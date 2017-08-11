From: Yong Wu <yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Subject: [PATCH 2/8] iommu/mediatek: Add mt2712 IOMMU support
Date: Fri, 11 Aug 2017 17:56:11 +0800
Message-ID: <1502445377-26936-3-git-send-email-yong.wu@mediatek.com>
References: <1502445377-26936-1-git-send-email-yong.wu@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1502445377-26936-1-git-send-email-yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Arvind Yadav <arvind.yadav.cs-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, arnd-r2nGTMty4D4@public.gmane.org, srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, youlin.pei-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Tomasz Figa <tfiga-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Daniel Kurtz <djkurtz-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, cloud.chou-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, k.zhang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

The M4U IP blocks in mt2712 is MTK's generation2 M4U which use the
Short-descriptor like mt8173, and most of the HW registers are the
same.

The difference is that there are 2 M4U HWs in mt2712 while there's
only one in mt8173. The purpose of 2 M4U HWs is for balance the
bandwidth.

Normally if there are 2 M4U HWs, there should be 2 iommu domains,
each M4U has a iommu domain.

Signed-off-by: Yong Wu <yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
---
This patch also include a minor issue:
suspend while there is no iommu client. it will hang because
there is no iommu domain at that time.
---
 drivers/iommu/mtk_iommu.c | 48 ++++++++++++++++++++++++++++++++---------------
 drivers/iommu/mtk_iommu.h |  7 +++++++
 drivers/memory/mtk-smi.c  | 40 ++++++++++++++++++++++++++++++++++++---
 3 files changed, 77 insertions(+), 18 deletions(-)

diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index 91c6d36..da6cedb 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -54,7 +54,9 @@
 
 #define REG_MMU_CTRL_REG			0x110
 #define F_MMU_PREFETCH_RT_REPLACE_MOD		BIT(4)
+/* The TF-protect-select is bit[5:4] in mt2712 while it's bit[6:5] in mt8173.*/
 #define F_MMU_TF_PROTECT_SEL(prot)		(((prot) & 0x3) << 5)
+#define F_MMU_TF_PROT_SEL(prot)			(((prot) & 0x3) << 4)
 
 #define REG_MMU_IVRP_PADDR			0x114
 #define F_MMU_IVRP_PA_SET(pa, ext)		(((pa) >> 1) | ((!!(ext)) << 31))
@@ -301,10 +303,6 @@ static int mtk_iommu_attach_device(struct iommu_domain *domain,
 			data->m4u_dom = NULL;
 			return ret;
 		}
-	} else if (data->m4u_dom != dom) {
-		/* All the client devices should be in the same m4u domain */
-		dev_err(dev, "try to attach into the error iommu domain\n");
-		return -EPERM;
 	}
 
 	mtk_iommu_config(data, dev, true);
@@ -464,8 +462,12 @@ static int mtk_iommu_hw_init(const struct mtk_iommu_data *data)
 		return ret;
 	}
 
-	regval = F_MMU_PREFETCH_RT_REPLACE_MOD |
-		F_MMU_TF_PROTECT_SEL(2);
+	if (data->m4u_type == M4U_MT8173) {
+		regval = F_MMU_PREFETCH_RT_REPLACE_MOD |
+			F_MMU_TF_PROTECT_SEL(2);
+	} else {
+		regval = F_MMU_TF_PROT_SEL(2);
+	}
 	writel_relaxed(regval, data->base + REG_MMU_CTRL_REG);
 
 	regval = F_L2_MULIT_HIT_EN |
@@ -487,9 +489,11 @@ static int mtk_iommu_hw_init(const struct mtk_iommu_data *data)
 
 	writel_relaxed(F_MMU_IVRP_PA_SET(data->protect_base, data->enable_4GB),
 		       data->base + REG_MMU_IVRP_PADDR);
-
 	writel_relaxed(0, data->base + REG_MMU_DCM_DIS);
-	writel_relaxed(0, data->base + REG_MMU_STANDARD_AXI_MODE);
+
+	/* It's MISC control register whose default value is ok except mt8173.*/
+	if (data->m4u_type == M4U_MT8173)
+		writel_relaxed(0, data->base + REG_MMU_STANDARD_AXI_MODE);
 
 	if (devm_request_irq(data->dev, data->irq, mtk_iommu_isr, 0,
 			     dev_name(data->dev), (void *)data)) {
@@ -521,6 +525,7 @@ static int mtk_iommu_probe(struct platform_device *pdev)
 	if (!data)
 		return -ENOMEM;
 	data->dev = dev;
+	data->m4u_type = (enum mtk_iommu_type)of_device_get_match_data(dev);
 
 	/* Protect memory. HW will access here while translation fault.*/
 	protect = devm_kzalloc(dev, MTK_PROTECT_PA_ALIGN * 2, GFP_KERNEL);
@@ -554,6 +559,7 @@ static int mtk_iommu_probe(struct platform_device *pdev)
 	for (i = 0; i < larb_nr; i++) {
 		struct device_node *larbnode;
 		struct platform_device *plarbdev;
+		unsigned int id;
 
 		larbnode = of_parse_phandle(dev->of_node, "mediatek,larbs", i);
 		if (!larbnode)
@@ -562,6 +568,10 @@ static int mtk_iommu_probe(struct platform_device *pdev)
 		if (!of_device_is_available(larbnode))
 			continue;
 
+		ret = of_property_read_u32(larbnode, "mediatek,larb-id", &id);
+		if (ret)/* The id is consecutive if there is no this property */
+			id = i;
+
 		plarbdev = of_find_device_by_node(larbnode);
 		if (!plarbdev) {
 			plarbdev = of_platform_device_create(
@@ -572,7 +582,7 @@ static int mtk_iommu_probe(struct platform_device *pdev)
 				return -EPROBE_DEFER;
 			}
 		}
-		data->smi_imu.larb_imu[i].dev = &plarbdev->dev;
+		data->smi_imu.larb_imu[id].dev = &plarbdev->dev;
 
 		component_match_add_release(dev, &match, release_of,
 					    compare_of, larbnode);
@@ -640,8 +650,6 @@ static int __maybe_unused mtk_iommu_resume(struct device *dev)
 	struct mtk_iommu_suspend_reg *reg = &data->reg;
 	void __iomem *base = data->base;
 
-	writel_relaxed(data->m4u_dom->cfg.arm_v7s_cfg.ttbr[0],
-		       base + REG_MMU_PT_BASE_ADDR);
 	writel_relaxed(reg->standard_axi_mode,
 		       base + REG_MMU_STANDARD_AXI_MODE);
 	writel_relaxed(reg->dcm_dis, base + REG_MMU_DCM_DIS);
@@ -650,15 +658,19 @@ static int __maybe_unused mtk_iommu_resume(struct device *dev)
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
 
@@ -667,16 +679,20 @@ static int __maybe_unused mtk_iommu_resume(struct device *dev)
 	.remove	= mtk_iommu_remove,
 	.driver	= {
 		.name = "mtk-iommu",
-		.of_match_table = mtk_iommu_of_ids,
+		.of_match_table = of_match_ptr(mtk_iommu_of_ids),
 		.pm = &mtk_iommu_pm_ops,
 	}
 };
 
 static int mtk_iommu_init_fn(struct device_node *np)
 {
+	static bool init_done;
 	int ret;
 	struct platform_device *pdev;
 
+	if (init_done)
+		return 0;
+
 	pdev = of_platform_device_create(np, NULL, platform_bus_type.dev_root);
 	if (!pdev)
 		return -ENOMEM;
@@ -686,8 +702,10 @@ static int mtk_iommu_init_fn(struct device_node *np)
 		pr_err("%s: Failed to register driver\n", __func__);
 		return ret;
 	}
+	init_done = true;
 
 	return 0;
 }
 
-IOMMU_OF_DECLARE(mtkm4u, "mediatek,mt8173-m4u", mtk_iommu_init_fn);
+IOMMU_OF_DECLARE(mt8173m4u, "mediatek,mt8173-m4u", mtk_iommu_init_fn);
+IOMMU_OF_DECLARE(mt2712m4u, "mediatek,mt2712-m4u", mtk_iommu_init_fn);
diff --git a/drivers/iommu/mtk_iommu.h b/drivers/iommu/mtk_iommu.h
index c06cc91..cd729a3 100644
--- a/drivers/iommu/mtk_iommu.h
+++ b/drivers/iommu/mtk_iommu.h
@@ -34,6 +34,12 @@ struct mtk_iommu_suspend_reg {
 	u32				int_main_control;
 };
 
+enum mtk_iommu_type {
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
+	enum mtk_iommu_type		m4u_type;
 };
 
 static inline int compare_of(struct device *dev, void *data)
diff --git a/drivers/memory/mtk-smi.c b/drivers/memory/mtk-smi.c
index 13f8c45..ec06d2b 100644
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
+#define SMI_LARB_NONSEC_CON(id)	(0x380 + (id * 4))
+#define F_MMU_EN		BIT(0)
+
 struct mtk_smi_larb_gen {
 	bool need_larbid;
 	int port_in_larb[MTK_LARB_NR_MAX + 1];
@@ -149,7 +156,7 @@ void mtk_smi_larb_put(struct device *larbdev)
 	struct mtk_smi_iommu *smi_iommu = data;
 	unsigned int         i;
 
-	for (i = 0; i < smi_iommu->larb_nr; i++) {
+	for (i = 0; i < MTK_LARB_NR_MAX; i++) {
 		if (dev == smi_iommu->larb_imu[i].dev) {
 			/* The 'mmu' may be updated in iommu-attach/detach. */
 			larb->mmu = &smi_iommu->larb_imu[i].mmu;
@@ -159,13 +166,28 @@ void mtk_smi_larb_put(struct device *larbdev)
 	return -ENODEV;
 }
 
-static void mtk_smi_larb_config_port(struct device *dev)
+static void mtk_smi_larb_config_port_mt8173(struct device *dev)
 {
 	struct mtk_smi_larb *larb = dev_get_drvdata(dev);
 
 	writel(*larb->mmu, larb->base + SMI_LARB_MMU_EN);
 }
 
+static void mtk_smi_larb_config_port_mt2712(struct device *dev)
+{
+	struct mtk_smi_larb *larb = dev_get_drvdata(dev);
+	u32 reg;
+	int i;
+
+	for (i = 0; i < 32; i++) {
+		if (*larb->mmu & BIT(i)) {
+			reg = readl_relaxed(larb->base +
+					    SMI_LARB_NONSEC_CON(i));
+			reg |= F_MMU_EN;
+			writel(reg, larb->base + SMI_LARB_NONSEC_CON(i));
+		}
+	}
+}
 
 static void mtk_smi_larb_config_port_gen1(struct device *dev)
 {
@@ -211,7 +233,11 @@ static void mtk_smi_larb_config_port_gen1(struct device *dev)
 
 static const struct mtk_smi_larb_gen mtk_smi_larb_mt8173 = {
 	/* mt8173 do not need the port in larb */
-	.config_port = mtk_smi_larb_config_port,
+	.config_port = mtk_smi_larb_config_port_mt8173,
+};
+
+static const struct mtk_smi_larb_gen mtk_smi_larb_mt2712 = {
+	.config_port = mtk_smi_larb_config_port_mt2712,
 };
 
 static const struct mtk_smi_larb_gen mtk_smi_larb_mt2701 = {
@@ -232,6 +258,10 @@ static void mtk_smi_larb_config_port_gen1(struct device *dev)
 		.compatible = "mediatek,mt2701-smi-larb",
 		.data = &mtk_smi_larb_mt2701
 	},
+	{
+		.compatible = "mediatek,mt2712-smi-larb",
+		.data = &mtk_smi_larb_mt2712
+	},
 	{}
 };
 
@@ -318,6 +348,10 @@ static int mtk_smi_larb_remove(struct platform_device *pdev)
 		.compatible = "mediatek,mt2701-smi-common",
 		.data = (void *)MTK_SMI_GEN1
 	},
+	{
+		.compatible = "mediatek,mt2712-smi-common",
+		.data = (void *)MTK_SMI_GEN2
+	},
 	{}
 };
 
-- 
1.9.1
