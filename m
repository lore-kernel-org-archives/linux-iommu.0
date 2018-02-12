From: Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>
Subject: [PATCH 32/37] iommu/arm-smmu-v3: Hook up ATC invalidation to mm ops
Date: Mon, 12 Feb 2018 18:33:47 +0000
Message-ID: <20180212183352.22730-33-jean-philippe.brucker@arm.com>
References: <20180212183352.22730-1-jean-philippe.brucker@arm.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20180212183352.22730-1-jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, catalin.marinas-5wv7dgnIgG8@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org, hanjun.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, sudeep.holla-5wv7dgnIgG8@public.gmane.org, rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org, lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, robin.murphy-5wv7dgnIgG8@public.gmane.org, bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, tn-nYOzD4b6Jr9Wk0Htik3J/w@public.gmane.org, liubo95-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, xieyisheng1-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, xuzaibo-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, ilias.apalodimas-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, jonathan.cameron-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, shunyong.yang-PT9Dzx9SjPiXmMXjJBpWqg@public.gmane.org, nwatters-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, okaya-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, jcrouse-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, rfranz-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, jacob.jun.pan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, yi.l.liu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, robdclark-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, christian.koenig-5C7GfCeVMHo@public.gmane.org, bharatku-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

The core calls us when an mm is modified. Perform the required ATC
invalidations.

Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>
---
 drivers/iommu/arm-smmu-v3.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index 76513135310f..8d09615fab35 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -1805,6 +1805,15 @@ static int arm_smmu_atc_inv_master_all(struct arm_smmu_master_data *master,
 	return arm_smmu_atc_inv_master(master, &cmd);
 }
 
+static int arm_smmu_atc_inv_master_range(struct arm_smmu_master_data *master,
+					 int ssid, unsigned long iova, size_t size)
+{
+	struct arm_smmu_cmdq_ent cmd;
+
+	arm_smmu_atc_inv_to_cmd(ssid, iova, size, &cmd);
+	return arm_smmu_atc_inv_master(master, &cmd);
+}
+
 static size_t
 arm_smmu_atc_inv_domain(struct arm_smmu_domain *smmu_domain, int ssid,
 			unsigned long iova, size_t size)
@@ -2450,11 +2459,12 @@ static void arm_smmu_mm_detach(struct iommu_domain *domain, struct device *dev,
 	struct arm_smmu_mm *smmu_mm = to_smmu_mm(io_mm);
 	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
 	struct iommu_pasid_table_ops *ops = smmu_domain->s1_cfg.ops;
+	struct arm_smmu_master_data *master = dev->iommu_fwspec->iommu_priv;
 
 	if (detach_domain)
 		ops->clear_entry(ops, io_mm->pasid, smmu_mm->cd);
 
-	/* TODO: Invalidate ATC. */
+	arm_smmu_atc_inv_master_all(master, io_mm->pasid);
 	/* TODO: Invalidate all mappings if last and not DVM. */
 }
 
@@ -2462,8 +2472,10 @@ static void arm_smmu_mm_invalidate(struct iommu_domain *domain,
 				   struct device *dev, struct io_mm *io_mm,
 				   unsigned long iova, size_t size)
 {
+	struct arm_smmu_master_data *master = dev->iommu_fwspec->iommu_priv;
+
+	arm_smmu_atc_inv_master_range(master, io_mm->pasid, iova, size);
 	/*
-	 * TODO: Invalidate ATC.
 	 * TODO: Invalidate mapping if not DVM
 	 */
 }
-- 
2.15.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
