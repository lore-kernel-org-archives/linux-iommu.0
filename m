From: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 2/6] iommu/tegra: smmu: Pass swgroup info from DT
Date: Tue, 15 Jan 2013 10:17:24 +0200
Message-ID: <1358237848-968-2-git-send-email-hdoyu@nvidia.com>
References: <1358237848-968-1-git-send-email-hdoyu@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1358237848-968-1-git-send-email-hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org
Cc: linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Pass available H/W client component(software client group) info from
DT in bitmap. This info is specific to a certain generation of Tegra
SoC. With this, Tegra SMMU driver could be identical among Tegra
generations. This also removes the old way of passing this bit from
each device pdata, which could configure(enable/disable) each device
IOMMU'able, but it belongs to a kind of "policy", which can be done by
kernel/system later. Now DT passes just pure H/W info.

Signed-off-by: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
---
 .../bindings/iommu/nvidia,tegra30-smmu.txt         |   41 ++++++++
 drivers/iommu/tegra-smmu.c                         |   99 +++-----------------
 2 files changed, 55 insertions(+), 85 deletions(-)

diff --git a/Documentation/devicetree/bindings/iommu/nvidia,tegra30-smmu.txt b/Documentation/devicetree/bindings/iommu/nvidia,tegra30-smmu.txt
index 89fb543..de449d0 100644
--- a/Documentation/devicetree/bindings/iommu/nvidia,tegra30-smmu.txt
+++ b/Documentation/devicetree/bindings/iommu/nvidia,tegra30-smmu.txt
@@ -8,6 +8,46 @@ Required properties:
 - nvidia,#asids : # of ASIDs
 - dma-window : IOVA start address and length.
 - nvidia,ahb : phandle to the ahb bus connected to SMMU.
+- nvidia,swgroups: Available H/W client component(software client
+  group) in bitmap in SoC. Those IDs are calculated as below:
+
+	  <ID> = (<OFFSET> - MC_SMMU_AFI_ASID_0) / 4;
+
+  This <ID>/<OFFSET> can grow if SWGROUP is added in the future
+  SoC. Please refer to Tegra SoC TRM to find which SWGROUPs are
+  implemented in SoC.
+
+------------------------
+ID	Offset	SWGROUP
+=======================
+0	238	AFI
+1	23c	AVP
+2	240	DC
+3	244	DCB
+------------------------
+4	248	EPP
+5	24c	G2
+6	250	HC
+7	254	HDA
+------------------------
+8	258	ISP
+9	25c	-
+10	260	-
+11	264	MPE
+------------------------
+12	268	NV
+13	26c	NV2
+14	270	PPC
+15	274	-
+------------------------
+16	278	SAT
+17	27c	VDE
+18	280	VI
+19	284	-
+------------------------
+20	288	-
+21	29c	-
+......
 
 Example:
 	smmu {
@@ -17,5 +57,6 @@ Example:
 		       0x7000f228 0x05c>;
 		nvidia,#asids = <4>;		/* # of ASIDs */
 		dma-window = <0 0x40000000>;	/* IOVA start & length */
+		nvidia,swgroups = <0x775ff>;
 		nvidia,ahb = <&ahb>;
 	};
diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
index 224c0a0..e83797b 100644
--- a/drivers/iommu/tegra-smmu.c
+++ b/drivers/iommu/tegra-smmu.c
@@ -39,46 +39,6 @@
 #include <asm/page.h>
 #include <asm/cacheflush.h>
 
-enum smmu_swgrp {
-	SWGRP_AFI,
-	SWGRP_AVPC,
-	SWGRP_DC,
-	SWGRP_DCB,
-	SWGRP_EPP,
-	SWGRP_G2,
-	SWGRP_HC,
-	SWGRP_HDA,
-	SWGRP_ISP,
-	SWGRP_MPE,
-	SWGRP_NV,
-	SWGRP_NV2,
-	SWGRP_PPCS,
-	SWGRP_SATA,
-	SWGRP_VDE,
-	SWGRP_VI,
-
-	SWGRP_COUNT,
-
-	SWGRP_END = ~0,
-};
-
-#define SWG_AFI		(1 << SWGRP_AFI)
-#define SWG_AVPC	(1 << SWGRP_AVPC)
-#define SWG_DC		(1 << SWGRP_DC)
-#define SWG_DCB		(1 << SWGRP_DCB)
-#define SWG_EPP		(1 << SWGRP_EPP)
-#define SWG_G2		(1 << SWGRP_G2)
-#define SWG_HC		(1 << SWGRP_HC)
-#define SWG_HDA		(1 << SWGRP_HDA)
-#define SWG_ISP		(1 << SWGRP_ISP)
-#define SWG_MPE		(1 << SWGRP_MPE)
-#define SWG_NV		(1 << SWGRP_NV)
-#define SWG_NV2		(1 << SWGRP_NV2)
-#define SWG_PPCS	(1 << SWGRP_PPCS)
-#define SWG_SATA	(1 << SWGRP_SATA)
-#define SWG_VDE		(1 << SWGRP_VDE)
-#define SWG_VI		(1 << SWGRP_VI)
-
 /* bitmap of the page sizes currently supported */
 #define SMMU_IOMMU_PGSIZES	(SZ_4K)
 
@@ -148,21 +108,10 @@ enum {
 #define SMMU_TRANSLATION_ENABLE_2		0x230
 
 #define SMMU_AFI_ASID	0x238   /* PCIE */
+#define SMMU_SWGRP_ASID_BASE	SMMU_AFI_ASID
+
 #define SMMU_AVPC_ASID	0x23c   /* AVP */
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
+#define SWG_AVPC	((SMMU_AVPC_ASID - SMMU_SWGRP_ASID_BASE) / 4)
 
 #define SMMU_PDE_NEXT_SHIFT		28
 
@@ -234,27 +183,7 @@ enum {
 #define __smmu_client_enable_swgrp(c, m) __smmu_client_set_swgrp(c, m, 1)
 #define __smmu_client_disable_swgrp(c)	__smmu_client_set_swgrp(c, 0, 0)
 
-#define SWGRP_INIT(client) [SWGRP_##client] = SMMU_##client##_ASID
-
-static const u32 smmu_swgrp_asid_reg[] = {
-	SWGRP_INIT(AFI),
-	SWGRP_INIT(AVPC),
-	SWGRP_INIT(DC),
-	SWGRP_INIT(DCB),
-	SWGRP_INIT(EPP),
-	SWGRP_INIT(G2),
-	SWGRP_INIT(HC),
-	SWGRP_INIT(HDA),
-	SWGRP_INIT(ISP),
-	SWGRP_INIT(MPE),
-	SWGRP_INIT(NV),
-	SWGRP_INIT(NV2),
-	SWGRP_INIT(PPCS),
-	SWGRP_INIT(SATA),
-	SWGRP_INIT(VDE),
-	SWGRP_INIT(VI),
-};
-#define SWGRP_ASID_REG(x) (smmu_swgrp_asid_reg[x])
+#define SWGRP_ASID_REG(id) (4 * (id) + SMMU_SWGRP_ASID_BASE)
 
 /*
  * Per client for address space
@@ -263,7 +192,6 @@ struct smmu_client {
 	struct device		*dev;
 	struct list_head	list;
 	struct smmu_as		*as;
-	u32			swgrp;
 };
 
 /*
@@ -313,6 +241,7 @@ struct smmu_device {
 	struct smmu_debugfs_info *debugfs_info;
 
 	struct device_node *ahb;
+	u32 swgrp;
 
 	int		num_as;
 	struct smmu_as	as[0];		/* Run-time allocated array */
@@ -375,8 +304,6 @@ static inline void smmu_write(struct smmu_device *smmu, u32 val, size_t offs)
  */
 #define FLUSH_SMMU_REGS(smmu)	smmu_read(smmu, SMMU_CONFIG)
 
-#define smmu_client_swgrp(c) (u32)((c)->dev->platform_data)
-
 static int __smmu_client_set_swgrp(struct smmu_client *c,
 				   unsigned long map, int on)
 {
@@ -388,10 +315,8 @@ static int __smmu_client_set_swgrp(struct smmu_client *c,
 	WARN_ON(!on && map);
 	if (on && !map)
 		return -EINVAL;
-	if (!on)
-		map = smmu_client_swgrp(c);
 
-	for_each_set_bit(i, &map, SWGRP_COUNT) {
+	for_each_set_bit(i, &map, BITS_PER_LONG) {
 		offs = SWGRP_ASID_REG(i);
 		val = smmu_read(smmu, offs);
 		if (on) {
@@ -405,11 +330,10 @@ static int __smmu_client_set_swgrp(struct smmu_client *c,
 		smmu_write(smmu, val, offs);
 	}
 	FLUSH_SMMU_REGS(smmu);
-	c->swgrp = map;
 	return 0;
 
 err_hw_busy:
-	for_each_set_bit(i, &map, SWGRP_COUNT) {
+	for_each_set_bit(i, &map, BITS_PER_LONG) {
 		offs = SWGRP_ASID_REG(i);
 		val = smmu_read(smmu, offs);
 		val &= ~mask;
@@ -466,7 +390,7 @@ static int smmu_setup_regs(struct smmu_device *smmu)
 		smmu_write(smmu, val, SMMU_PTB_DATA);
 
 		list_for_each_entry(c, &as->client, list)
-			__smmu_client_set_swgrp(c, c->swgrp, 1);
+			__smmu_client_set_swgrp(c, smmu->swgrp, 1);
 	}
 
 	smmu_write(smmu, smmu->translation_enable_0, SMMU_TRANSLATION_ENABLE_0);
@@ -794,7 +718,7 @@ static int smmu_iommu_attach_dev(struct iommu_domain *domain,
 		return -ENOMEM;
 	client->dev = dev;
 	client->as = as;
-	map = (unsigned long)dev->platform_data;
+	map = smmu->swgrp;
 	if (!map)
 		return -EINVAL;
 
@@ -1154,12 +1078,16 @@ static int tegra_smmu_probe(struct platform_device *pdev)
 	int i, asids, err = 0;
 	dma_addr_t uninitialized_var(base);
 	size_t bytes, uninitialized_var(size);
+	u32 swgrp;
 
 	if (smmu_handle)
 		return -EIO;
 
 	BUILD_BUG_ON(PAGE_SHIFT != SMMU_PAGE_SHIFT);
 
+	if (of_property_read_u32(dev->of_node, "nvidia,swgroups", &swgrp))
+		return -ENODEV;
+
 	if (of_property_read_u32(dev->of_node, "nvidia,#asids", &asids))
 		return -ENODEV;
 
@@ -1198,6 +1126,7 @@ static int tegra_smmu_probe(struct platform_device *pdev)
 
 	smmu->dev = dev;
 	smmu->num_as = asids;
+	smmu->swgrp = swgrp;
 	smmu->iovmm_base = base;
 	smmu->page_count = size;
 
-- 
1.7.9.5
