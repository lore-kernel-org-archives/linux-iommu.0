From: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 7/6] iommu/tegra124: smmu: add multiple asid_security support
Date: Mon, 9 Dec 2013 09:16:17 +0200
Message-ID: <1386573377-31063-1-git-send-email-hdoyu@nvidia.com>
References: <1386246319-17851-1-git-send-email-hdoyu@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1386246319-17851-1-git-send-email-hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

In Tegra124 the number of MC_SMMU_ASID_SECURITY_# registers
increased. Now this info is provided as platfrom data. If no platfrom
data the default valude(1) is used.

Signed-off-by: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
---
Sending now as [PATCH 7/6] because this was missed from the thread.
---
 drivers/iommu/tegra-smmu.c | 39 +++++++++++++++++++++++++++++++++------
 1 file changed, 33 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
index 535b14a..5524773 100644
--- a/drivers/iommu/tegra-smmu.c
+++ b/drivers/iommu/tegra-smmu.c
@@ -108,6 +108,13 @@ enum {
 #define SMMU_PTC_FLUSH_1			0x9b8
 
 #define SMMU_ASID_SECURITY			0x38
+#define SMMU_ASID_SECURITY_1			0x3c
+#define SMMU_ASID_SECURITY_2			0x9e0
+#define SMMU_ASID_SECURITY_3			0x9e4
+#define SMMU_ASID_SECURITY_4			0x9e8
+#define SMMU_ASID_SECURITY_5			0x9ec
+#define SMMU_ASID_SECURITY_6			0x9f0
+#define SMMU_ASID_SECURITY_7			0x9f4
 
 #define SMMU_STATS_CACHE_COUNT_BASE		0x1f0
 
@@ -243,6 +250,7 @@ struct smmu_device {
 	struct page *avp_vector_page;	/* dummy page shared by all AS's */
 
 	int nr_xlats;		/* number of translation_enable registers */
+	int nr_asid_secs;	/* number of asid_security registers */
 	u32 tlb_reset;		/* TLB config reset value */
 	u32 ptc_reset;		/* PTC config reset value */
 
@@ -250,7 +258,7 @@ struct smmu_device {
 	 * Register image savers for suspend/resume
 	 */
 	u32 *xlat;
-	unsigned long asid_security;
+	u32 *asid_sec;
 
 	struct dentry *debugfs_root;
 	struct smmu_debugfs_info *debugfs_info;
@@ -266,6 +274,7 @@ struct smmu_device {
 struct smmu_platform_data {
 	int asids;		/* number of asids */
 	int nr_xlats;		/* number of translation_enable registers */
+	int nr_asid_secs;	/* number of asid_security registers */
 	u32 tlb_reset;		/* TLB config reset value */
 	u32 ptc_reset;		/* PTC config reset value */
 };
@@ -328,6 +337,17 @@ static inline void smmu_write(struct smmu_device *smmu, u32 val, size_t offs)
  */
 #define FLUSH_SMMU_REGS(smmu)	smmu_read(smmu, SMMU_CONFIG)
 
+static const u32 smmu_asid_sec_ofs[] = {
+	SMMU_ASID_SECURITY,
+	SMMU_ASID_SECURITY_1,
+	SMMU_ASID_SECURITY_2,
+	SMMU_ASID_SECURITY_3,
+	SMMU_ASID_SECURITY_4,
+	SMMU_ASID_SECURITY_5,
+	SMMU_ASID_SECURITY_6,
+	SMMU_ASID_SECURITY_7,
+};
+
 static size_t smmu_get_asid_offset(int id)
 {
 	switch (id) {
@@ -526,7 +546,9 @@ static int smmu_setup_regs(struct smmu_device *smmu)
 		smmu_write(smmu, smmu->xlat[i],
 			   SMMU_TRANSLATION_ENABLE_0 + i * sizeof(u32));
 
-	smmu_write(smmu, smmu->asid_security, SMMU_ASID_SECURITY);
+	for (i = 0; i < smmu->nr_asid_secs; i++)
+		smmu_write(smmu, smmu->asid_sec[i], smmu_asid_sec_ofs[i]);
+
 	smmu_write(smmu, smmu->ptc_reset, SMMU_CACHE_CONFIG(_PTC));
 	smmu_write(smmu, smmu->tlb_reset, SMMU_CACHE_CONFIG(_TLB));
 
@@ -1243,7 +1265,9 @@ static int tegra_smmu_suspend(struct device *dev)
 		smmu->xlat[i] = smmu_read(smmu,
 				SMMU_TRANSLATION_ENABLE_0 + i * sizeof(u32));
 
-	smmu->asid_security = smmu_read(smmu, SMMU_ASID_SECURITY);
+	for (i = 0; i < smmu->nr_asid_secs; i++)
+		smmu->asid_sec[i] =
+			smmu_read(smmu, smmu_asid_sec_ofs[i]);
 	return 0;
 }
 
@@ -1279,6 +1303,7 @@ static void tegra_smmu_create_default_map(struct smmu_device *smmu)
 static const struct smmu_platform_data tegra124_smmu_pdata = {
 	.asids = 128,
 	.nr_xlats = 4,
+	.nr_asid_secs = 8,
 	.tlb_reset = SMMU_TLB_CONFIG_RESET_VAL | SMMU_TLB_RR_ARB | 0x20,
 	.ptc_reset = SMMU_PTC_CONFIG_RESET_VAL | SMMU_PTC_REQ_LIMIT,
 };
@@ -1299,7 +1324,7 @@ static int tegra_smmu_probe(struct platform_device *pdev)
 	size_t bytes, uninitialized_var(size);
 	const struct of_device_id *match;
 	const struct smmu_platform_data *pdata;
-	int nr_xlats;
+	int nr_xlats, nr_asid_secs;
 
 	if (smmu_handle)
 		return -EIO;
@@ -1311,6 +1336,7 @@ static int tegra_smmu_probe(struct platform_device *pdev)
 		return -EINVAL;
 	pdata = match->data;
 	nr_xlats = (pdata && pdata->nr_xlats) ?	pdata->nr_xlats : 3;
+	nr_asid_secs = (pdata && pdata->nr_asid_secs) ?	pdata->nr_asid_secs : 1;
 
 	if (of_property_read_u32(dev->of_node, "nvidia,#asids", &asids))
 		asids = (pdata && pdata->asids) ? pdata->asids : 4;
@@ -1319,7 +1345,7 @@ static int tegra_smmu_probe(struct platform_device *pdev)
 
 	bytes = sizeof(*smmu) + asids * (sizeof(*smmu->as) +
 					 sizeof(struct dma_iommu_mapping *));
-	bytes += sizeof(u32) * nr_xlats;
+	bytes += sizeof(u32) * (nr_asid_secs + nr_xlats);
 	smmu = devm_kzalloc(dev, bytes, GFP_KERNEL);
 	if (!smmu) {
 		dev_err(dev, "failed to allocate smmu_device\n");
@@ -1329,6 +1355,7 @@ static int tegra_smmu_probe(struct platform_device *pdev)
 	smmu->clients = RB_ROOT;
 	smmu->map = (struct dma_iommu_mapping **)(smmu->as + asids);
 	smmu->xlat = (u32 *)(smmu->map + smmu->num_as);
+	smmu->asid_sec = smmu->xlat + smmu->nr_xlats;
 	smmu->nregs = pdev->num_resources;
 	smmu->tlb_reset = (pdata && pdata->tlb_reset) ? pdata->tlb_reset :
 		(SMMU_TLB_CONFIG_RESET_VAL | 0x10);
@@ -1368,7 +1395,7 @@ static int tegra_smmu_probe(struct platform_device *pdev)
 	smmu->nr_xlats = nr_xlats;
 	smmu->iovmm_base = base;
 	smmu->page_count = size;
-	smmu->asid_security = 0;
+	smmu->nr_asid_secs = nr_asid_secs;
 	for (i = 0; i < smmu->nr_xlats; i++)
 		smmu->xlat[i] = ~0;
 
-- 
1.8.1.5
