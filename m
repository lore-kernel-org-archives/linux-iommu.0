From: Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>
Subject: [RFCv2 PATCH 20/36] iommu/arm-smmu-v3: Track ASID state
Date: Fri,  6 Oct 2017 14:31:47 +0100
Message-ID: <20171006133203.22803-21-jean-philippe.brucker@arm.com>
References: <20171006133203.22803-1-jean-philippe.brucker@arm.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20171006133203.22803-1-jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, catalin.marinas-5wv7dgnIgG8@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org, hanjun.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, sudeep.holla-5wv7dgnIgG8@public.gmane.org, rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org, lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, robin.murphy-5wv7dgnIgG8@public.gmane.org, bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, tn-nYOzD4b6Jr9Wk0Htik3J/w@public.gmane.org, liubo95-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, xieyisheng1-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, gabriele.paoloni-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, nwatters-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, okaya-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, rfranz-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, jacob.jun.pan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, yi.l.liu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, robdclark-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

At the moment each SMMU has a 8- or 16-bit ASID set and allocates one ASID
per device via a bitmap. ASIDs are used to differentiate address spaces in
SMMU TLB entries. With SVM, sharing process address spaces with the SMMU,
we need to use CPU ASIDs in SMMU contexts, to ensure that broadcast TLB
invalidations reach the right IOTLB entries.

When binding a process address space to a device, we become slaves to the
arch ASID allocator. We have to use whatever ASID they give us. If a
domain is currently using it, then we'll either abort or steal that ASID.

To make matters worse, tasks are global, while domains are per-SMMU. SMMU
ASIDs can be aliased across different SMMUs, but the CPU ASID space is
unique across the whole system.

Introduce an IDR for SMMU ASID allocation. It allows to keep information
about an ASID, for instance which domain it is assigned to or how many
devices are using it.

Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>
---
 drivers/iommu/arm-smmu-v3.c | 53 +++++++++++++++++++++++++++++++++++++--------
 1 file changed, 44 insertions(+), 9 deletions(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index 96347aad605f..71fc3a2c8a95 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -640,6 +640,10 @@ struct arm_smmu_strtab_cfg {
 	u32				strtab_base_cfg;
 };
 
+struct arm_smmu_asid_state {
+	struct arm_smmu_domain		*domain;
+};
+
 /* An SMMUv3 instance */
 struct arm_smmu_device {
 	struct device			*dev;
@@ -681,7 +685,8 @@ struct arm_smmu_device {
 
 #define ARM_SMMU_MAX_ASIDS		(1 << 16)
 	unsigned int			asid_bits;
-	DECLARE_BITMAP(asid_map, ARM_SMMU_MAX_ASIDS);
+	struct idr			asid_idr;
+	spinlock_t			asid_lock;
 
 #define ARM_SMMU_MAX_VMIDS		(1 << 16)
 	unsigned int			vmid_bits;
@@ -1828,7 +1833,11 @@ static void arm_smmu_domain_free(struct iommu_domain *domain)
 		struct arm_smmu_s1_cfg *cfg = &smmu_domain->s1_cfg;
 		if (cfg->num_contexts) {
 			arm_smmu_free_cd_tables(smmu_domain);
-			arm_smmu_bitmap_free(smmu->asid_map, cfg->cd.asid);
+
+			spin_lock(&smmu->asid_lock);
+			kfree(idr_find(&smmu->asid_idr, cfg->cd.asid));
+			idr_remove(&smmu->asid_idr, cfg->cd.asid);
+			spin_unlock(&smmu->asid_lock);
 		}
 	} else {
 		struct arm_smmu_s2_cfg *cfg = &smmu_domain->s2_cfg;
@@ -1844,25 +1853,48 @@ static int arm_smmu_domain_finalise_s1(struct arm_smmu_domain *smmu_domain,
 {
 	int ret;
 	int asid;
+	struct arm_smmu_asid_state *asid_state;
 	struct arm_smmu_device *smmu = smmu_domain->smmu;
 	struct arm_smmu_s1_cfg *cfg = &smmu_domain->s1_cfg;
 
-	asid = arm_smmu_bitmap_alloc(smmu->asid_map, smmu->asid_bits);
-	if (asid < 0)
-		return asid;
-
 	ret = arm_smmu_alloc_cd_tables(smmu_domain);
 	if (ret)
-		goto out_free_asid;
+		return ret;
+
+	asid_state = kzalloc(sizeof(*asid_state), GFP_KERNEL);
+	if (!asid_state) {
+		ret = -ENOMEM;
+		goto out_free_tables;
+	}
+
+	asid_state->domain = smmu_domain;
+
+	idr_preload(GFP_KERNEL);
+	spin_lock(&smmu->asid_lock);
+	asid = idr_alloc_cyclic(&smmu->asid_idr, asid_state, 0,
+				1 << smmu->asid_bits, GFP_ATOMIC);
 
 	cfg->cd.asid	= (u16)asid;
 	cfg->cd.ttbr	= pgtbl_cfg->arm_lpae_s1_cfg.ttbr[0];
 	cfg->cd.tcr	= pgtbl_cfg->arm_lpae_s1_cfg.tcr;
 	cfg->cd.mair	= pgtbl_cfg->arm_lpae_s1_cfg.mair[0];
+
+	spin_unlock(&smmu->asid_lock);
+	idr_preload_end();
+
+	if (asid < 0) {
+		ret = asid;
+		goto out_free_asid_state;
+	}
+
 	return 0;
 
-out_free_asid:
-	arm_smmu_bitmap_free(smmu->asid_map, asid);
+out_free_asid_state:
+	kfree(asid_state);
+
+out_free_tables:
+	arm_smmu_free_cd_tables(smmu_domain);
+
 	return ret;
 }
 
@@ -2506,6 +2538,9 @@ static int arm_smmu_init_structures(struct arm_smmu_device *smmu)
 {
 	int ret;
 
+	spin_lock_init(&smmu->asid_lock);
+	idr_init(&smmu->asid_idr);
+
 	ret = arm_smmu_init_queues(smmu);
 	if (ret)
 		return ret;
-- 
2.13.3

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
