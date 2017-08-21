From: Yong Wu <yong.wu@mediatek.com>
Subject: [PATCH v2 3/8] iommu/mediatek: Add mt2712 IOMMU support
Date: Mon, 21 Aug 2017 19:00:16 +0800
Message-ID: <1503313221-26453-4-git-send-email-yong.wu@mediatek.com>
References: <1503313221-26453-1-git-send-email-yong.wu@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1503313221-26453-1-git-send-email-yong.wu@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>, Rob Herring <robh+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, Robin Murphy <robin.murphy@arm.com>
Cc: Will Deacon <will.deacon@arm.com>, Daniel Kurtz <djkurtz@google.com>, Tomasz Figa <tfiga@google.com>, Catalin Marinas <catalin.marinas@arm.com>, linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, iommu@lists.linux-foundation.org, arnd@arndb.de, honghui.zhang@mediatek.com, k.zhang@mediatek.com, cloud.zhou@mediatek.com, yong.wu@mediatek.com
List-Id: iommu@lists.linux-foundation.org

The M4U IP blocks in mt2712 is MTK's generation2 M4U which use the
ARM Short-descriptor like mt8173, and most of the HW registers are
the same.

The difference is that there are 2 M4U HWs in mt2712 while there's
only one in mt8173. The purpose of 2 M4U HWs is for balance the
bandwidth.

Normally if there are 2 M4U HWs, there should be 2 iommu domains,
each M4U has a iommu domain.

Signed-off-by: Yong Wu <yong.wu@mediatek.com>
---
 drivers/iommu/mtk_iommu.c  | 71 ++++++++++++++++++++++------------------------
 drivers/iommu/mtk_iommu.h  |  7 +++++
 drivers/memory/mtk-smi.c   | 54 +++++++++++++++++++++++++++++++++--
 include/soc/mediatek/smi.h |  2 +-
 4 files changed, 93 insertions(+), 41 deletions(-)

diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index 4db6c8f..df23e02 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -53,7 +53,11 @@
 
 #define REG_MMU_CTRL_REG			0x110
 #define F_MMU_PREFETCH_RT_REPLACE_MOD		BIT(4)
-#define F_MMU_TF_PROTECT_SEL(prot)		(((prot) & 0x3) << 5)
+#define F_MMU_TF_PROTECT_SEL_SHIFT(data) \
+	((data)->m4u_plat == M4U_MT2712 ? 4 : 5)
+/* It's named by F_MMU_TF_PROT_SEL in mt2712. */
+#define F_MMU_TF_PROTECT_SEL(prot, data) \
+	(((prot) & 0x3) << F_MMU_TF_PROTECT_SEL_SHIFT(data))
 
 #define REG_MMU_IVRP_PADDR			0x114
 #define F_MMU_IVRP_PA_SET(pa, ext)		(((pa) >> 1) | ((!!(ext)) << 31))
@@ -96,7 +100,7 @@
  * Get the local arbiter ID and the portid within the larb arbiter
  * from mtk_m4u_id which is defined by MTK_M4U_ID.
  */
-#define MTK_M4U_TO_LARB(id)		(((id) >> 5) & 0x7)
+#define MTK_M4U_TO_LARB(id)		(((id) >> 5) & 0xf)
 #define MTK_M4U_TO_PORT(id)		((id) & 0x1f)
 
 struct mtk_iommu_domain {
@@ -307,10 +311,6 @@ static int mtk_iommu_attach_device(struct iommu_domain *domain,
 			data->m4u_dom = NULL;
 			return ret;
 		}
-	} else if (data->m4u_dom != dom) {
-		/* All the client devices should be in the same m4u domain */
-		dev_err(dev, "try to attach into the error iommu domain\n");
-		return -EPERM;
 	}
 
 	mtk_iommu_config(data, dev, true);
@@ -470,8 +470,9 @@ static int mtk_iommu_hw_init(const struct mtk_iommu_data *data)
 		return ret;
 	}
 
-	regval = F_MMU_PREFETCH_RT_REPLACE_MOD |
-		F_MMU_TF_PROTECT_SEL(2);
+	regval = F_MMU_TF_PROTECT_SEL(2, data);
+	if (data->m4u_plat == M4U_MT8173)
+		regval |= F_MMU_PREFETCH_RT_REPLACE_MOD;
 	writel_relaxed(regval, data->base + REG_MMU_CTRL_REG);
 
 	regval = F_L2_MULIT_HIT_EN |
@@ -493,9 +494,11 @@ static int mtk_iommu_hw_init(const struct mtk_iommu_data *data)
 
 	writel_relaxed(F_MMU_IVRP_PA_SET(data->protect_base, data->enable_4GB),
 		       data->base + REG_MMU_IVRP_PADDR);
-
 	writel_relaxed(0, data->base + REG_MMU_DCM_DIS);
-	writel_relaxed(0, data->base + REG_MMU_STANDARD_AXI_MODE);
+
+	/* It's MISC control register whose default value is ok except mt8173.*/
+	if (data->m4u_plat == M4U_MT8173)
+		writel_relaxed(0, data->base + REG_MMU_STANDARD_AXI_MODE);
 
 	if (devm_request_irq(data->dev, data->irq, mtk_iommu_isr, 0,
 			     dev_name(data->dev), (void *)data)) {
@@ -527,6 +530,7 @@ static int mtk_iommu_probe(struct platform_device *pdev)
 	if (!data)
 		return -ENOMEM;
 	data->dev = dev;
+	data->m4u_plat = (enum mtk_iommu_plat)of_device_get_match_data(dev);
 
 	/* Protect memory. HW will access here while translation fault.*/
 	protect = devm_kzalloc(dev, MTK_PROTECT_PA_ALIGN * 2, GFP_KERNEL);
@@ -560,6 +564,7 @@ static int mtk_iommu_probe(struct platform_device *pdev)
 	for (i = 0; i < larb_nr; i++) {
 		struct device_node *larbnode;
 		struct platform_device *plarbdev;
+		u32 id;
 
 		larbnode = of_parse_phandle(dev->of_node, "mediatek,larbs", i);
 		if (!larbnode)
@@ -568,17 +573,14 @@ static int mtk_iommu_probe(struct platform_device *pdev)
 		if (!of_device_is_available(larbnode))
 			continue;
 
+		ret = of_property_read_u32(larbnode, "mediatek,larb-id", &id);
+		if (ret)/* The id is consecutive if there is no this property */
+			id = i;
+
 		plarbdev = of_find_device_by_node(larbnode);
-		if (!plarbdev) {
-			plarbdev = of_platform_device_create(
-						larbnode, NULL,
-						platform_bus_type.dev_root);
-			if (!plarbdev) {
-				of_node_put(larbnode);
-				return -EPROBE_DEFER;
-			}
-		}
-		data->smi_imu.larb_imu[i].dev = &plarbdev->dev;
+		if (!plarbdev)
+			return -EPROBE_DEFER;
+		data->smi_imu.larb_imu[id].dev = &plarbdev->dev;
 
 		component_match_add_release(dev, &match, release_of,
 					    compare_of, larbnode);
@@ -646,8 +648,6 @@ static int __maybe_unused mtk_iommu_resume(struct device *dev)
 	struct mtk_iommu_suspend_reg *reg = &data->reg;
 	void __iomem *base = data->base;
 
-	writel_relaxed(data->m4u_dom->cfg.arm_v7s_cfg.ttbr[0],
-		       base + REG_MMU_PT_BASE_ADDR);
 	writel_relaxed(reg->standard_axi_mode,
 		       base + REG_MMU_STANDARD_AXI_MODE);
 	writel_relaxed(reg->dcm_dis, base + REG_MMU_DCM_DIS);
@@ -656,15 +656,19 @@ static int __maybe_unused mtk_iommu_resume(struct device *dev)
 	writel_relaxed(reg->int_main_control, base + REG_MMU_INT_MAIN_CONTROL);
 	writel_relaxed(F_MMU_IVRP_PA_SET(data->protect_base, data->enable_4GB),
 		       base + REG_MMU_IVRP_PADDR);
+	if (data->m4u_dom)
+		writel(data->m4u_dom->cfg.arm_v7s_cfg.ttbr[0],
+		       base + REG_MMU_PT_BASE_ADDR);
 	return 0;
 }
 
-const struct dev_pm_ops mtk_iommu_pm_ops = {
+static const struct dev_pm_ops mtk_iommu_pm_ops = {
 	SET_SYSTEM_SLEEP_PM_OPS(mtk_iommu_suspend, mtk_iommu_resume)
 };
 
 static const struct of_device_id mtk_iommu_of_ids[] = {
-	{ .compatible = "mediatek,mt8173-m4u", },
+	{ .compatible = "mediatek,mt2712-m4u", .data = (void *)M4U_MT2712},
+	{ .compatible = "mediatek,mt8173-m4u", .data = (void *)M4U_MT8173},
 	{}
 };
 
@@ -673,27 +677,20 @@ static int __maybe_unused mtk_iommu_resume(struct device *dev)
 	.remove	= mtk_iommu_remove,
 	.driver	= {
 		.name = "mtk-iommu",
-		.of_match_table = mtk_iommu_of_ids,
+		.of_match_table = of_match_ptr(mtk_iommu_of_ids),
 		.pm = &mtk_iommu_pm_ops,
 	}
 };
 
-static int mtk_iommu_init_fn(struct device_node *np)
+static int __init mtk_iommu_init(void)
 {
 	int ret;
-	struct platform_device *pdev;
-
-	pdev = of_platform_device_create(np, NULL, platform_bus_type.dev_root);
-	if (!pdev)
-		return -ENOMEM;
 
 	ret = platform_driver_register(&mtk_iommu_driver);
-	if (ret) {
-		pr_err("%s: Failed to register driver\n", __func__);
-		return ret;
-	}
+	if (ret != 0)
+		pr_err("Failed to register MTK IOMMU driver\n");
 
-	return 0;
+	return ret;
 }
 
-IOMMU_OF_DECLARE(mtkm4u, "mediatek,mt8173-m4u", mtk_iommu_init_fn);
+subsys_initcall(mtk_iommu_init)
diff --git a/drivers/iommu/mtk_iommu.h b/drivers/iommu/mtk_iommu.h
index c06cc91..462e593 100644
--- a/drivers/iommu/mtk_iommu.h
+++ b/drivers/iommu/mtk_iommu.h
@@ -34,6 +34,12 @@ struct mtk_iommu_suspend_reg {
 	u32				int_main_control;
 };
 
+enum mtk_iommu_plat {
+	M4U_MT2701,
+	M4U_MT2712,
+	M4U_MT8173,
+};
+
 struct mtk_iommu_domain;
 
 struct mtk_iommu_data {
@@ -50,6 +56,7 @@ struct mtk_iommu_data {
 	bool				tlb_flush_active;
 
 	struct iommu_device		iommu;
+	enum mtk_iommu_plat		m4u_plat;
 };
 
 static inline int compare_of(struct device *dev, void *data)
diff --git a/drivers/memory/mtk-smi.c b/drivers/memory/mtk-smi.c
index 13f8c45..8ffe321 100644
--- a/drivers/memory/mtk-smi.c
+++ b/drivers/memory/mtk-smi.c
@@ -23,7 +23,10 @@
 #include <soc/mediatek/smi.h>
 #include <dt-bindings/memory/mt2701-larb-port.h>
 
+/* mt8173 */
 #define SMI_LARB_MMU_EN		0xf00
+
+/* mt2701 */
 #define REG_SMI_SECUR_CON_BASE		0x5c0
 
 /* every register control 8 port, register offset 0x4 */
@@ -41,6 +44,10 @@
 /* mt2701 domain should be set to 3 */
 #define SMI_SECUR_CON_VAL_DOMAIN(id)	(0x3 << ((((id) & 0x7) << 2) + 1))
 
+/* mt2712 */
+#define SMI_LARB_NONSEC_CON(id)	(0x380 + ((id) * 4))
+#define F_MMU_EN		BIT(0)
+
 struct mtk_smi_larb_gen {
 	bool need_larbid;
 	int port_in_larb[MTK_LARB_NR_MAX + 1];
@@ -149,6 +156,15 @@ void mtk_smi_larb_put(struct device *larbdev)
 	struct mtk_smi_iommu *smi_iommu = data;
 	unsigned int         i;
 
+	if (larb->larb_gen->need_larbid) {
+		larb->mmu = &smi_iommu->larb_imu[larb->larbid].mmu;
+		return 0;
+	}
+
+	/*
+	 * If there is no larbid property, Loop to find the corresponding
+	 * iommu information.
+	 */
 	for (i = 0; i < smi_iommu->larb_nr; i++) {
 		if (dev == smi_iommu->larb_imu[i].dev) {
 			/* The 'mmu' may be updated in iommu-attach/detach. */
@@ -159,13 +175,32 @@ void mtk_smi_larb_put(struct device *larbdev)
 	return -ENODEV;
 }
 
-static void mtk_smi_larb_config_port(struct device *dev)
+static void mtk_smi_larb_config_port_mt2712(struct device *dev)
 {
 	struct mtk_smi_larb *larb = dev_get_drvdata(dev);
+	u32 reg;
+	int i;
 
-	writel(*larb->mmu, larb->base + SMI_LARB_MMU_EN);
+	/*
+	 * larb 8/9 is the bdpsys larb, the iommu_en is enabled defaultly.
+	 * Don't need to set it again.
+	 */
+	if (larb->larbid == 8 || larb->larbid == 9)
+		return;
+
+	for_each_set_bit(i, (unsigned long *)larb->mmu, 32) {
+		reg = readl_relaxed(larb->base + SMI_LARB_NONSEC_CON(i));
+		reg |= F_MMU_EN;
+		writel(reg, larb->base + SMI_LARB_NONSEC_CON(i));
+	}
 }
 
+static void mtk_smi_larb_config_port_mt8173(struct device *dev)
+{
+	struct mtk_smi_larb *larb = dev_get_drvdata(dev);
+
+	writel(*larb->mmu, larb->base + SMI_LARB_MMU_EN);
+}
 
 static void mtk_smi_larb_config_port_gen1(struct device *dev)
 {
@@ -211,7 +246,7 @@ static void mtk_smi_larb_config_port_gen1(struct device *dev)
 
 static const struct mtk_smi_larb_gen mtk_smi_larb_mt8173 = {
 	/* mt8173 do not need the port in larb */
-	.config_port = mtk_smi_larb_config_port,
+	.config_port = mtk_smi_larb_config_port_mt8173,
 };
 
 static const struct mtk_smi_larb_gen mtk_smi_larb_mt2701 = {
@@ -223,6 +258,11 @@ static void mtk_smi_larb_config_port_gen1(struct device *dev)
 	.config_port = mtk_smi_larb_config_port_gen1,
 };
 
+static const struct mtk_smi_larb_gen mtk_smi_larb_mt2712 = {
+	.need_larbid = true,
+	.config_port = mtk_smi_larb_config_port_mt2712,
+};
+
 static const struct of_device_id mtk_smi_larb_of_ids[] = {
 	{
 		.compatible = "mediatek,mt8173-smi-larb",
@@ -232,6 +272,10 @@ static void mtk_smi_larb_config_port_gen1(struct device *dev)
 		.compatible = "mediatek,mt2701-smi-larb",
 		.data = &mtk_smi_larb_mt2701
 	},
+	{
+		.compatible = "mediatek,mt2712-smi-larb",
+		.data = &mtk_smi_larb_mt2712
+	},
 	{}
 };
 
@@ -318,6 +362,10 @@ static int mtk_smi_larb_remove(struct platform_device *pdev)
 		.compatible = "mediatek,mt2701-smi-common",
 		.data = (void *)MTK_SMI_GEN1
 	},
+	{
+		.compatible = "mediatek,mt2712-smi-common",
+		.data = (void *)MTK_SMI_GEN2
+	},
 	{}
 };
 
diff --git a/include/soc/mediatek/smi.h b/include/soc/mediatek/smi.h
index 8893c5e..5201e90 100644
--- a/include/soc/mediatek/smi.h
+++ b/include/soc/mediatek/smi.h
@@ -19,7 +19,7 @@
 
 #ifdef CONFIG_MTK_SMI
 
-#define MTK_LARB_NR_MAX		8
+#define MTK_LARB_NR_MAX		16
 
 #define MTK_SMI_MMU_EN(port)	BIT(port)
 
-- 
1.9.1
