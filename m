From: <honghui.zhang@mediatek.com>
Subject: [PATCH v2 1/3] memory: mtk-smi: add larbid handle routine
Date: Fri, 28 Jul 2017 18:55:41 +0800
Message-ID: <1501239343-9190-2-git-send-email-honghui.zhang@mediatek.com>
References: <1501239343-9190-1-git-send-email-honghui.zhang@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1501239343-9190-1-git-send-email-honghui.zhang@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
To: joro@8bytes.org, matthias.bgg@gmail.com, robh@kernel.org, robin.murphy@arm.com
Cc: devicetree@vger.kernel.org, kendrick.hsu@mediatek.com, srv_heupstream@mediatek.com, will.deacon@arm.com, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, robh+dt@kernel.org, linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org, youlin.pei@mediatek.com, erin.lo@mediatek.com, yong.wu@mediatek.com, xinping.qian@mediatek.com, Honghui Zhang <honghui.zhang@mediatek.com>
List-Id: iommu@lists.linux-foundation.org

From: Honghui Zhang <honghui.zhang@mediatek.com>

In the commit 3c8f4ad85c4b ("memory/mediatek: add support for mt2701"),
the larb->larbid was added but not initialized.
Mediatek's gen1 smi need this hardware larbid information to get the
register offset which controls whether enable iommu for this larb.
This patch add the initialize routine for larbid.

Signed-off-by: Honghui Zhang <honghui.zhang@mediatek.com>
---
 drivers/memory/mtk-smi.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/memory/mtk-smi.c b/drivers/memory/mtk-smi.c
index 2b798bb4..8f75aaa 100644
--- a/drivers/memory/mtk-smi.c
+++ b/drivers/memory/mtk-smi.c
@@ -42,6 +42,7 @@
 #define SMI_SECUR_CON_VAL_DOMAIN(id)	(0x3 << ((((id) & 0x7) << 2) + 1))
 
 struct mtk_smi_larb_gen {
+	bool need_larbid;
 	int port_in_larb[MTK_LARB_NR_MAX + 1];
 	void (*config_port)(struct device *);
 };
@@ -214,6 +215,7 @@ static const struct mtk_smi_larb_gen mtk_smi_larb_mt8173 = {
 };
 
 static const struct mtk_smi_larb_gen mtk_smi_larb_mt2701 = {
+	.need_larbid = true,
 	.port_in_larb = {
 		LARB0_PORT_OFFSET, LARB1_PORT_OFFSET,
 		LARB2_PORT_OFFSET, LARB3_PORT_OFFSET
@@ -240,6 +242,7 @@ static int mtk_smi_larb_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct device_node *smi_node;
 	struct platform_device *smi_pdev;
+	int err;
 
 	if (!dev->pm_domain)
 		return -EPROBE_DEFER;
@@ -263,6 +266,15 @@ static int mtk_smi_larb_probe(struct platform_device *pdev)
 		return PTR_ERR(larb->smi.clk_smi);
 	larb->smi.dev = dev;
 
+	if (larb->larb_gen->need_larbid) {
+		err = of_property_read_u32(dev->of_node, "mediatek,larbid",
+					   &larb->larbid);
+		if (err) {
+			dev_err(dev, "missing larbid property\n");
+			return err;
+		}
+	}
+
 	smi_node = of_parse_phandle(dev->of_node, "mediatek,smi", 0);
 	if (!smi_node)
 		return -EINVAL;
-- 
2.6.4
