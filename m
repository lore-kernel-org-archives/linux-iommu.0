From: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 19/23] iommu/tegra: smmu: Unfied driver for Tegra SoCs
Date: Wed, 26 Jun 2013 12:28:22 +0300
Message-ID: <1372238906-9346-20-git-send-email-hdoyu@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Support multiple generation of Tegra SoCs with this unified
SMMU driver. Necessary info is expected to be passed from DT.

Signed-off-by: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
---
 drivers/iommu/tegra-smmu.c | 80 ++--------------------------------------------
 1 file changed, 3 insertions(+), 77 deletions(-)

diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
index 6e82df3..ae71721 100644
--- a/drivers/iommu/tegra-smmu.c
+++ b/drivers/iommu/tegra-smmu.c
@@ -1,5 +1,5 @@
 /*
- * IOMMU API for SMMU in Tegra30
+ * IOMMU API for SMMU in Tegra SoC
  *
  * Copyright (c) 2011-2013, NVIDIA CORPORATION.  All rights reserved.
  *
@@ -41,46 +41,6 @@
 #include <asm/cacheflush.h>
 #include <asm/dma-iommu.h>
 
-enum smmu_hwgrp {
-	HWGRP_AFI,
-	HWGRP_AVPC,
-	HWGRP_DC,
-	HWGRP_DCB,
-	HWGRP_EPP,
-	HWGRP_G2,
-	HWGRP_HC,
-	HWGRP_HDA,
-	HWGRP_ISP,
-	HWGRP_MPE,
-	HWGRP_NV,
-	HWGRP_NV2,
-	HWGRP_PPCS,
-	HWGRP_SATA,
-	HWGRP_VDE,
-	HWGRP_VI,
-
-	HWGRP_COUNT,
-
-	HWGRP_END = ~0,
-};
-
-#define HWG_AFI		(1 << HWGRP_AFI)
-#define HWG_AVPC	(1 << HWGRP_AVPC)
-#define HWG_DC		(1 << HWGRP_DC)
-#define HWG_DCB		(1 << HWGRP_DCB)
-#define HWG_EPP		(1 << HWGRP_EPP)
-#define HWG_G2		(1 << HWGRP_G2)
-#define HWG_HC		(1 << HWGRP_HC)
-#define HWG_HDA		(1 << HWGRP_HDA)
-#define HWG_ISP		(1 << HWGRP_ISP)
-#define HWG_MPE		(1 << HWGRP_MPE)
-#define HWG_NV		(1 << HWGRP_NV)
-#define HWG_NV2		(1 << HWGRP_NV2)
-#define HWG_PPCS	(1 << HWGRP_PPCS)
-#define HWG_SATA	(1 << HWGRP_SATA)
-#define HWG_VDE		(1 << HWGRP_VDE)
-#define HWG_VI		(1 << HWGRP_VI)
-
 /* bitmap of the page sizes currently supported */
 #define SMMU_IOMMU_PGSIZES	(SZ_4K)
 
@@ -150,21 +110,7 @@ enum {
 #define SMMU_TRANSLATION_ENABLE_2		0x230
 
 #define SMMU_AFI_ASID	0x238   /* PCIE */
-#define SMMU_AVPC_ASID	0x23c   /* AVP */
-#define SMMU_DC_ASID	0x240   /* Display controller */
-#define SMMU_DCB_ASID	0x244   /* Display controller B */
-#define SMMU_EPP_ASID	0x248   /* Encoder pre-processor */
-#define SMMU_G2_ASID	0x24c   /* 2D engine */
-#define SMMU_HC_ASID	0x250   /* Host1x */
-#define SMMU_HDA_ASID	0x254   /* High-def audio */
-#define SMMU_ISP_ASID	0x258   /* Image signal processor */
-#define SMMU_MPE_ASID	0x264   /* MPEG encoder */
-#define SMMU_NV_ASID	0x268   /* (3D) */
-#define SMMU_NV2_ASID	0x26c   /* (3D) */
-#define SMMU_PPCS_ASID	0x270   /* AHB */
-#define SMMU_SATA_ASID	0x278   /* SATA */
-#define SMMU_VDE_ASID	0x27c   /* Video decoder */
-#define SMMU_VI_ASID	0x280   /* Video input */
+#define SMMU_SWGRP_ASID_BASE	SMMU_AFI_ASID
 
 #define SMMU_PDE_NEXT_SHIFT		28
 
@@ -236,26 +182,6 @@ enum {
 #define __smmu_client_enable_hwgrp(c, m) __smmu_client_set_hwgrp(c, m, 1)
 #define __smmu_client_disable_hwgrp(c)	__smmu_client_set_hwgrp(c, 0, 0)
 
-#define HWGRP_INIT(client) [HWGRP_##client] = SMMU_##client##_ASID
-
-static const u32 smmu_hwgrp_asid_reg[] = {
-	HWGRP_INIT(AFI),
-	HWGRP_INIT(AVPC),
-	HWGRP_INIT(DC),
-	HWGRP_INIT(DCB),
-	HWGRP_INIT(EPP),
-	HWGRP_INIT(G2),
-	HWGRP_INIT(HC),
-	HWGRP_INIT(HDA),
-	HWGRP_INIT(ISP),
-	HWGRP_INIT(MPE),
-	HWGRP_INIT(NV),
-	HWGRP_INIT(NV2),
-	HWGRP_INIT(PPCS),
-	HWGRP_INIT(SATA),
-	HWGRP_INIT(VDE),
-	HWGRP_INIT(VI),
-};
 #define HWGRP_ASID_REG(x) ((x) * sizeof(u32) + SMMU_AFI_ASID)
 
 /*
@@ -1353,7 +1279,7 @@ static void __exit tegra_smmu_exit(void)
 core_initcall(tegra_smmu_init);
 module_exit(tegra_smmu_exit);
 
-MODULE_DESCRIPTION("IOMMU API for SMMU in Tegra30");
+MODULE_DESCRIPTION("IOMMU API for SMMU in Tegra SoC");
 MODULE_AUTHOR("Hiroshi DOYU <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>");
 MODULE_ALIAS("platform:tegra-smmu");
 MODULE_LICENSE("GPL v2");
-- 
1.8.1.5
