From: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 5/6] iommu/tegra124: smmu: {TLB,PTC} reset value per SoC
Date: Thu, 5 Dec 2013 14:25:18 +0200
Message-ID: <1386246319-17851-6-git-send-email-hdoyu@nvidia.com>
References: <1386246319-17851-1-git-send-email-hdoyu@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1386246319-17851-1-git-send-email-hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

T124 has some new register bits in {TLB,PTC}_CONFIG:

- TLB_RR_ARB and PTC_REQ_LIMIT
- TLB_ACTIVE_LINES 0x20 instead of 0x10

They are defined as platform data now.

Signed-off-by: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
---
 drivers/iommu/tegra-smmu.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
index 04e7199..9b81e3a 100644
--- a/drivers/iommu/tegra-smmu.c
+++ b/drivers/iommu/tegra-smmu.c
@@ -71,12 +71,13 @@ enum {
 #define SMMU_CACHE_CONFIG_STATS_TEST		(1 << SMMU_CACHE_CONFIG_STATS_TEST_SHIFT)
 
 #define SMMU_TLB_CONFIG_HIT_UNDER_MISS__ENABLE	(1 << 29)
-#define SMMU_TLB_CONFIG_ACTIVE_LINES__VALUE	0x10
-#define SMMU_TLB_CONFIG_RESET_VAL		0x20000010
+#define SMMU_TLB_CONFIG_RESET_VAL		0x20000000
+#define SMMU_TLB_RR_ARB				(1 << 28)
 
 #define SMMU_PTC_CONFIG_CACHE__ENABLE		(1 << 29)
 #define SMMU_PTC_CONFIG_INDEX_MAP__PATTERN	0x3f
 #define SMMU_PTC_CONFIG_RESET_VAL		0x2000003f
+#define SMMU_PTC_REQ_LIMIT			(8 << 24)
 
 #define SMMU_PTB_ASID				0x1c
 #define SMMU_PTB_ASID_CURRENT_SHIFT		0
@@ -239,6 +240,8 @@ struct smmu_device {
 	struct page *avp_vector_page;	/* dummy page shared by all AS's */
 
 	int nr_xlats;		/* number of translation_enable registers */
+	u32 tlb_reset;		/* TLB config reset value */
+	u32 ptc_reset;		/* PTC config reset value */
 
 	/*
 	 * Register image savers for suspend/resume
@@ -260,6 +263,8 @@ struct smmu_device {
 struct smmu_platform_data {
 	int asids;		/* number of asids */
 	int nr_xlats;		/* number of translation_enable registers */
+	u32 tlb_reset;		/* TLB config reset value */
+	u32 ptc_reset;		/* PTC config reset value */
 };
 
 static struct smmu_device *smmu_handle; /* unique for a system */
@@ -519,8 +524,8 @@ static int smmu_setup_regs(struct smmu_device *smmu)
 			   SMMU_TRANSLATION_ENABLE_0 + i * sizeof(u32));
 
 	smmu_write(smmu, smmu->asid_security, SMMU_ASID_SECURITY);
-	smmu_write(smmu, SMMU_TLB_CONFIG_RESET_VAL, SMMU_CACHE_CONFIG(_TLB));
-	smmu_write(smmu, SMMU_PTC_CONFIG_RESET_VAL, SMMU_CACHE_CONFIG(_PTC));
+	smmu_write(smmu, smmu->ptc_reset, SMMU_CACHE_CONFIG(_PTC));
+	smmu_write(smmu, smmu->tlb_reset, SMMU_CACHE_CONFIG(_TLB));
 
 	smmu_flush_regs(smmu, 1);
 
@@ -1271,6 +1276,8 @@ static void tegra_smmu_create_default_map(struct smmu_device *smmu)
 static const struct smmu_platform_data tegra124_smmu_pdata = {
 	.asids = 128,
 	.nr_xlats = 4,
+	.tlb_reset = SMMU_TLB_CONFIG_RESET_VAL | SMMU_TLB_RR_ARB | 0x20,
+	.ptc_reset = SMMU_PTC_CONFIG_RESET_VAL | SMMU_PTC_REQ_LIMIT,
 };
 
 static struct of_device_id tegra_smmu_of_match[] = {
@@ -1320,6 +1327,10 @@ static int tegra_smmu_probe(struct platform_device *pdev)
 	smmu->map = (struct dma_iommu_mapping **)(smmu->as + asids);
 	smmu->xlat = (u32 *)(smmu->map + smmu->num_as);
 	smmu->nregs = pdev->num_resources;
+	smmu->tlb_reset = (pdata && pdata->tlb_reset) ? pdata->tlb_reset :
+		(SMMU_TLB_CONFIG_RESET_VAL | 0x10);
+	smmu->ptc_reset = (pdata && pdata->ptc_reset) ? pdata->ptc_reset :
+		(SMMU_PTC_CONFIG_RESET_VAL | SMMU_PTC_REQ_LIMIT);
 	smmu->regs = devm_kzalloc(dev, 2 * smmu->nregs * sizeof(*smmu->regs),
 				  GFP_KERNEL);
 	smmu->rege = smmu->regs + smmu->nregs;
-- 
1.8.1.5
