From: Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>
Subject: [RFC PATCH 02/30] iommu/arm-smmu-v3: Link groups and domains
Date: Mon, 27 Feb 2017 19:54:13 +0000
Message-ID: <20170227195441.5170-3-jean-philippe.brucker@arm.com>
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

When removing a mapping from a domain, we need to send an invalidation to
all of devices that might have stored it in their Address Translation
Cache (ATC). This requires a lookup from smmu_domain to smmu_group. Add a
list of groups in each domain.

Although this domain-group link is already protected by
iommu_group->mutex, the domain-to-group lookup will be done outside of the
sections protected by that mutex. Add a spinlock for this case.

Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>
---
 drivers/iommu/arm-smmu-v3.c | 44 ++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 42 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index ce8b68fe254b..69d00416990d 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -651,9 +651,15 @@ struct arm_smmu_domain {
 	};
 
 	struct iommu_domain		domain;
+
+	struct list_head		groups;
+	spinlock_t			groups_lock;
 };
 
 struct arm_smmu_group {
+	struct arm_smmu_domain		*domain;
+	struct list_head		domain_head;
+
 	struct list_head		devices;
 	spinlock_t			devices_lock;
 };
@@ -1408,6 +1414,9 @@ static struct iommu_domain *arm_smmu_domain_alloc(unsigned type)
 
 	mutex_init(&smmu_domain->init_mutex);
 	spin_lock_init(&smmu_domain->pgtbl_lock);
+	INIT_LIST_HEAD(&smmu_domain->groups);
+	spin_lock_init(&smmu_domain->groups_lock);
+
 	return &smmu_domain->domain;
 }
 
@@ -1641,6 +1650,7 @@ static void arm_smmu_detach_dev(struct device *dev)
 static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 {
 	int ret = 0;
+	unsigned long flags;
 	struct iommu_group *group;
 	struct arm_smmu_device *smmu;
 	struct arm_smmu_group *smmu_group;
@@ -1666,9 +1676,31 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 		return -ENOMEM;
 	}
 
-	/* Already attached to a different domain? */
-	if (!ste->bypass)
+	/*
+	 * Already attached to a different domain? This happens when we're
+	 * switching from default domain to unmanaged domain, and back. We
+	 * assume here that, when switching from old domain to new domain, old
+	 * domain doesn't have any live mapping anymore. This is an important
+	 * requirement because here we remove the group-domain link when we
+	 * re-attach the first device in a group. Other devices in that group
+	 * might still be attached to the old domain, and will be reattached in
+	 * a moment.
+	 *
+	 * We also take this path when attaching for the very first time, just
+	 * after the STE is initialized.
+	 */
+	if (!ste->bypass) {
+		struct arm_smmu_domain *other_domain = smmu_group->domain;
+
+		if (other_domain) {
+			spin_lock_irqsave(&other_domain->groups_lock, flags);
+			list_del(&smmu_group->domain_head);
+			spin_unlock_irqrestore(&other_domain->groups_lock, flags);
+
+			smmu_group->domain = NULL;
+		}
 		arm_smmu_detach_dev(dev);
+	}
 
 	mutex_lock(&smmu_domain->init_mutex);
 
@@ -1688,6 +1720,14 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 		goto out_unlock;
 	}
 
+	if (!smmu_group->domain) {
+		smmu_group->domain = smmu_domain;
+
+		spin_lock_irqsave(&smmu_domain->groups_lock, flags);
+		list_add(&smmu_group->domain_head, &smmu_domain->groups);
+		spin_unlock_irqrestore(&smmu_domain->groups_lock, flags);
+	}
+
 	ste->bypass = false;
 	ste->valid = true;
 
-- 
2.11.0
