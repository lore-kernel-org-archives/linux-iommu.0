From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Subject: [PATCH 2/4] iommu/arm-smmu-v3: Link domains and devices
Date: Wed, 20 Mar 2019 17:36:32 +0000
Message-ID: <20190320173634.21895-3-jean-philippe.brucker@arm.com>
References: <20190320173634.21895-1-jean-philippe.brucker@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190320173634.21895-1-jean-philippe.brucker@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: will.deacon@arm.com
Cc: lorenzo.pieralisi@arm.com, zhongmiao@hisilicon.com, okaya@kernel.org, joro@8bytes.org, rjw@rjwysocki.net, linux-acpi@vger.kernel.org, iommu@lists.linux-foundation.org, hanjun.guo@linaro.org, sudeep.holla@arm.com, robin.murphy@arm.com, linux-arm-kernel@lists.infradead.org, lenb@kernel.org
List-Id: iommu@lists.linux-foundation.org

When removing a mapping from a domain, we need to send an invalidation to
all devices that might have stored it in their Address Translation Cache
(ATC). In addition when updating the context descriptor of a live domain,
we'll need to send invalidations for all devices attached to it.

Maintain a list of devices in each domain, protected by a spinlock. It is
updated every time we attach or detach devices to and from domains.

It needs to be a spinlock because we'll invalidate ATC entries from
within hardirq-safe contexts, but it may be possible to relax the read
side with RCU later.

Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
---
 drivers/iommu/arm-smmu-v3.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index d3880010c6cf..66a29c113dbc 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -594,6 +594,11 @@ struct arm_smmu_device {
 struct arm_smmu_master_data {
 	struct arm_smmu_device		*smmu;
 	struct arm_smmu_strtab_ent	ste;
+
+	struct arm_smmu_domain		*domain;
+	struct list_head		domain_head;
+
+	struct device			*dev;
 };
 
 /* SMMU private data for an IOMMU domain */
@@ -618,6 +623,9 @@ struct arm_smmu_domain {
 	};
 
 	struct iommu_domain		domain;
+
+	struct list_head		devices;
+	spinlock_t			devices_lock;
 };
 
 struct arm_smmu_option_prop {
@@ -1493,6 +1501,9 @@ static struct iommu_domain *arm_smmu_domain_alloc(unsigned type)
 	}
 
 	mutex_init(&smmu_domain->init_mutex);
+	INIT_LIST_HEAD(&smmu_domain->devices);
+	spin_lock_init(&smmu_domain->devices_lock);
+
 	return &smmu_domain->domain;
 }
 
@@ -1711,8 +1722,18 @@ static void arm_smmu_install_ste_for_dev(struct iommu_fwspec *fwspec)
 
 static void arm_smmu_detach_dev(struct device *dev)
 {
+	unsigned long flags;
 	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
 	struct arm_smmu_master_data *master = fwspec->iommu_priv;
+	struct arm_smmu_domain *smmu_domain = master->domain;
+
+	if (smmu_domain) {
+		spin_lock_irqsave(&smmu_domain->devices_lock, flags);
+		list_del(&master->domain_head);
+		spin_unlock_irqrestore(&smmu_domain->devices_lock, flags);
+
+		master->domain = NULL;
+	}
 
 	master->ste.assigned = false;
 	arm_smmu_install_ste_for_dev(fwspec);
@@ -1721,6 +1742,7 @@ static void arm_smmu_detach_dev(struct device *dev)
 static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 {
 	int ret = 0;
+	unsigned long flags;
 	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
 	struct arm_smmu_device *smmu;
 	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
@@ -1757,6 +1779,11 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 	}
 
 	ste->assigned = true;
+	master->domain = smmu_domain;
+
+	spin_lock_irqsave(&smmu_domain->devices_lock, flags);
+	list_add(&master->domain_head, &smmu_domain->devices);
+	spin_unlock_irqrestore(&smmu_domain->devices_lock, flags);
 
 	if (smmu_domain->stage == ARM_SMMU_DOMAIN_BYPASS) {
 		ste->s1_cfg = NULL;
@@ -1883,6 +1910,7 @@ static int arm_smmu_add_device(struct device *dev)
 			return -ENOMEM;
 
 		master->smmu = smmu;
+		master->dev = dev;
 		fwspec->iommu_priv = master;
 	}
 
-- 
2.21.0
