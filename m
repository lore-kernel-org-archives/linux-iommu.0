From: Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>
Subject: [RFC PATCH 01/30] iommu/arm-smmu-v3: Link groups and devices
Date: Mon, 27 Feb 2017 19:54:12 +0000
Message-ID: <20170227195441.5170-2-jean-philippe.brucker@arm.com>
References: <20170227195441.5170-1-jean-philippe.brucker@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20170227195441.5170-1-jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: Shanker Donthineni <shankerd-Rm6X0d1/PG5y9aJCnZT0Uw@public.gmane.org>, kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, Sinan Kaya <okaya-Rm6X0d1/PG5y9aJCnZT0Uw@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Harv Abdulhamid <harba-Rm6X0d1/PG5y9aJCnZT0Uw@public.gmane.org>, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Nate Watterson <nwatters-Rm6X0d1/PG5y9aJCnZT0Uw@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Reintroduce smmu_group. This structure was removed during the generic DT
bindings rework, but will be needed when implementing PCIe ATS, to lookup
devices attached to a given domain.

When unmapping from a domain, we need to send an invalidation to all
devices that could have stored the mapping in their ATC. It would be nice
to use IOMMU API's iommu_group_for_each_dev, but that list is protected by
group->mutex, which we can't use because atc_invalidate won't be allowed
to sleep. So add a list of devices, protected by a spinlock.

Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>
---
 drivers/iommu/arm-smmu-v3.c | 74 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 74 insertions(+)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index 5806a6acc94e..ce8b68fe254b 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -625,6 +625,9 @@ struct arm_smmu_device {
 struct arm_smmu_master_data {
 	struct arm_smmu_device		*smmu;
 	struct arm_smmu_strtab_ent	ste;
+
+	struct device			*dev;
+	struct list_head		group_head;
 };
 
 /* SMMU private data for an IOMMU domain */
@@ -650,6 +653,11 @@ struct arm_smmu_domain {
 	struct iommu_domain		domain;
 };
 
+struct arm_smmu_group {
+	struct list_head		devices;
+	spinlock_t			devices_lock;
+};
+
 struct arm_smmu_option_prop {
 	u32 opt;
 	const char *prop;
@@ -665,6 +673,8 @@ static struct arm_smmu_domain *to_smmu_domain(struct iommu_domain *dom)
 	return container_of(dom, struct arm_smmu_domain, domain);
 }
 
+#define to_smmu_group iommu_group_get_iommudata
+
 static void parse_driver_options(struct arm_smmu_device *smmu)
 {
 	int i = 0;
@@ -1595,6 +1605,30 @@ static int arm_smmu_install_ste_for_dev(struct iommu_fwspec *fwspec)
 	return 0;
 }
 
+static void arm_smmu_group_release(void *smmu_group)
+{
+	kfree(smmu_group);
+}
+
+static struct arm_smmu_group *arm_smmu_group_alloc(struct iommu_group *group)
+{
+	struct arm_smmu_group *smmu_group = to_smmu_group(group);
+
+	if (smmu_group)
+		return smmu_group;
+
+	smmu_group = kzalloc(sizeof(*smmu_group), GFP_KERNEL);
+	if (!smmu_group)
+		return NULL;
+
+	INIT_LIST_HEAD(&smmu_group->devices);
+	spin_lock_init(&smmu_group->devices_lock);
+
+	iommu_group_set_iommudata(group, smmu_group, arm_smmu_group_release);
+
+	return smmu_group;
+}
+
 static void arm_smmu_detach_dev(struct device *dev)
 {
 	struct arm_smmu_master_data *master = dev->iommu_fwspec->iommu_priv;
@@ -1607,7 +1641,9 @@ static void arm_smmu_detach_dev(struct device *dev)
 static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 {
 	int ret = 0;
+	struct iommu_group *group;
 	struct arm_smmu_device *smmu;
+	struct arm_smmu_group *smmu_group;
 	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
 	struct arm_smmu_master_data *master;
 	struct arm_smmu_strtab_ent *ste;
@@ -1619,6 +1655,17 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 	smmu = master->smmu;
 	ste = &master->ste;
 
+	/*
+	 * When adding devices, this is the first occasion we have to create the
+	 * smmu_group and attach it to iommu_group.
+	 */
+	group = iommu_group_get(dev);
+	smmu_group = arm_smmu_group_alloc(group);
+	if (!smmu_group) {
+		iommu_group_put(group);
+		return -ENOMEM;
+	}
+
 	/* Already attached to a different domain? */
 	if (!ste->bypass)
 		arm_smmu_detach_dev(dev);
@@ -1659,6 +1706,9 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 
 out_unlock:
 	mutex_unlock(&smmu_domain->init_mutex);
+
+	iommu_group_put(group);
+
 	return ret;
 }
 
@@ -1745,7 +1795,9 @@ static struct iommu_ops arm_smmu_ops;
 static int arm_smmu_add_device(struct device *dev)
 {
 	int i, ret;
+	unsigned long flags;
 	struct arm_smmu_device *smmu;
+	struct arm_smmu_group *smmu_group;
 	struct arm_smmu_master_data *master;
 	struct iommu_fwspec *fwspec = dev->iommu_fwspec;
 	struct iommu_group *group;
@@ -1769,6 +1821,7 @@ static int arm_smmu_add_device(struct device *dev)
 			return -ENOMEM;
 
 		master->smmu = smmu;
+		master->dev = dev;
 		fwspec->iommu_priv = master;
 	}
 
@@ -1789,6 +1842,12 @@ static int arm_smmu_add_device(struct device *dev)
 
 	group = iommu_group_get_for_dev(dev);
 	if (!IS_ERR(group)) {
+		smmu_group = to_smmu_group(group);
+
+		spin_lock_irqsave(&smmu_group->devices_lock, flags);
+		list_add(&master->group_head, &smmu_group->devices);
+		spin_unlock_irqrestore(&smmu_group->devices_lock, flags);
+
 		iommu_group_put(group);
 		iommu_device_link(&smmu->iommu, dev);
 	}
@@ -1800,7 +1859,10 @@ static void arm_smmu_remove_device(struct device *dev)
 {
 	struct iommu_fwspec *fwspec = dev->iommu_fwspec;
 	struct arm_smmu_master_data *master;
+	struct arm_smmu_group *smmu_group;
 	struct arm_smmu_device *smmu;
+	struct iommu_group *group;
+	unsigned long flags;
 
 	if (!fwspec || fwspec->ops != &arm_smmu_ops)
 		return;
@@ -1809,6 +1871,18 @@ static void arm_smmu_remove_device(struct device *dev)
 	smmu = master->smmu;
 	if (master && master->ste.valid)
 		arm_smmu_detach_dev(dev);
+
+	if (master) {
+		group = iommu_group_get(dev);
+		smmu_group = to_smmu_group(group);
+
+		spin_lock_irqsave(&smmu_group->devices_lock, flags);
+		list_del(&master->group_head);
+		spin_unlock_irqrestore(&smmu_group->devices_lock, flags);
+
+		iommu_group_put(group);
+	}
+
 	iommu_group_remove_device(dev);
 	iommu_device_unlink(&smmu->iommu, dev);
 	kfree(master);
-- 
2.11.0
