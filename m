Return-Path: <SRS0=o4oj=NB=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 138DFC4338F
	for <iommu@archiver.kernel.org>; Tue, 10 Aug 2021 08:09:58 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C2C2E61073
	for <iommu@archiver.kernel.org>; Tue, 10 Aug 2021 08:09:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C2C2E61073
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9B08D60614;
	Tue, 10 Aug 2021 08:09:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JnwlpnKn1j4M; Tue, 10 Aug 2021 08:09:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id E1F6760620;
	Tue, 10 Aug 2021 08:09:52 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BF292C0010;
	Tue, 10 Aug 2021 08:09:52 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0E5A0C000E
 for <iommu@lists.linux-foundation.org>; Tue, 10 Aug 2021 08:09:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E3C9840012
 for <iommu@lists.linux-foundation.org>; Tue, 10 Aug 2021 08:09:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Nk2M3SBw0P-H for <iommu@lists.linux-foundation.org>;
 Tue, 10 Aug 2021 08:09:47 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
 by smtp2.osuosl.org (Postfix) with ESMTPS id F3EAF403AA
 for <iommu@lists.linux-foundation.org>; Tue, 10 Aug 2021 08:09:46 +0000 (UTC)
X-UUID: 71f57129b32c49b7ae9cbb8430d973a8-20210810
X-UUID: 71f57129b32c49b7ae9cbb8430d973a8-20210810
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw01.mediatek.com
 (envelope-from <yong.wu@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
 with ESMTP id 1304977917; Tue, 10 Aug 2021 16:09:44 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 10 Aug 2021 16:09:42 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 10 Aug 2021 16:09:41 +0800
From: Yong Wu <yong.wu@mediatek.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>, Rob Herring
 <robh+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>
Subject: [PATCH v3 03/13] memory: mtk-smi: Use clk_bulk clock ops
Date: Tue, 10 Aug 2021 16:08:49 +0800
Message-ID: <20210810080859.29511-4-yong.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210810080859.29511-1-yong.wu@mediatek.com>
References: <20210810080859.29511-1-yong.wu@mediatek.com>
MIME-Version: 1.0
X-MTK: N
Cc: youlin.pei@mediatek.com, devicetree@vger.kernel.org, yi.kuo@mediatek.com,
 srv_heupstream@mediatek.com, Will Deacon <will@kernel.org>,
 linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>,
 iommu@lists.linux-foundation.org, linux-mediatek@lists.infradead.org,
 anthony.huang@mediatek.com, ming-fan.chen@mediatek.com, anan.sun@mediatek.com,
 Robin Murphy <robin.murphy@arm.com>, Ikjoon Jang <ikjn@chromium.org>,
 linux-arm-kernel@lists.infradead.org
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Use clk_bulk interface instead of the orginal one to simplify the code.

For SMI larbs: Require apb/smi clocks while gals is optional.
For SMI common: Require apb/smi/gals0/gal1 in has_gals case. Otherwise,
                also only require apb/smi, No optional clk here.

About the "has_gals" flag, for smi larbs, the gals clock also may be
optional even this platform support it. thus it always use
*_bulk_get_optional, then the flag has_gals is unnecessary. Remove it.
The smi_common's has_gals still keep it.

Also remove clk fail logs since bulk interface already output fail log.

Signed-off-by: Yong Wu <yong.wu@mediatek.com>
---
change note:
still keep smi-common's has_glas flag. it is more strict.
But it did change many code, thus I didn't keep Ikjoon's R-b.
---
 drivers/memory/mtk-smi.c | 143 +++++++++++++++------------------------
 1 file changed, 55 insertions(+), 88 deletions(-)

diff --git a/drivers/memory/mtk-smi.c b/drivers/memory/mtk-smi.c
index c5fb51f73b34..f91eaf5c3ab0 100644
--- a/drivers/memory/mtk-smi.c
+++ b/drivers/memory/mtk-smi.c
@@ -60,6 +60,20 @@ enum mtk_smi_gen {
 	MTK_SMI_GEN2
 };
 
+#define MTK_SMI_CLK_NR_MAX			4
+
+/* larbs: Require apb/smi clocks while gals is optional. */
+static const char * const mtk_smi_larb_clks[] = {"apb", "smi", "gals"};
+#define MTK_SMI_LARB_REQ_CLK_NR		2
+#define MTK_SMI_LARB_OPT_CLK_NR		1
+
+/*
+ * common: Require these four clocks in has_gals case. Otherwise, only apb/smi are required.
+ */
+static const char * const mtk_smi_common_clks[] = {"apb", "smi", "gals0", "gals1"};
+#define MTK_SMI_COM_REQ_CLK_NR		2
+#define MTK_SMI_COM_GALS_REQ_CLK_NR	MTK_SMI_CLK_NR_MAX
+
 struct mtk_smi_common_plat {
 	enum mtk_smi_gen gen;
 	bool             has_gals;
@@ -70,13 +84,12 @@ struct mtk_smi_larb_gen {
 	int port_in_larb[MTK_LARB_NR_MAX + 1];
 	void (*config_port)(struct device *dev);
 	unsigned int			larb_direct_to_common_mask;
-	bool				has_gals;
 };
 
 struct mtk_smi {
 	struct device			*dev;
-	struct clk			*clk_apb, *clk_smi;
-	struct clk			*clk_gals0, *clk_gals1;
+	unsigned int			clk_num;
+	struct clk_bulk_data		clks[MTK_SMI_CLK_NR_MAX];
 	struct clk			*clk_async; /*only needed by mt2701*/
 	union {
 		void __iomem		*smi_ao_base; /* only for gen1 */
@@ -95,45 +108,6 @@ struct mtk_smi_larb { /* larb: local arbiter */
 	unsigned char			*bank;
 };
 
-static int mtk_smi_clk_enable(const struct mtk_smi *smi)
-{
-	int ret;
-
-	ret = clk_prepare_enable(smi->clk_apb);
-	if (ret)
-		return ret;
-
-	ret = clk_prepare_enable(smi->clk_smi);
-	if (ret)
-		goto err_disable_apb;
-
-	ret = clk_prepare_enable(smi->clk_gals0);
-	if (ret)
-		goto err_disable_smi;
-
-	ret = clk_prepare_enable(smi->clk_gals1);
-	if (ret)
-		goto err_disable_gals0;
-
-	return 0;
-
-err_disable_gals0:
-	clk_disable_unprepare(smi->clk_gals0);
-err_disable_smi:
-	clk_disable_unprepare(smi->clk_smi);
-err_disable_apb:
-	clk_disable_unprepare(smi->clk_apb);
-	return ret;
-}
-
-static void mtk_smi_clk_disable(const struct mtk_smi *smi)
-{
-	clk_disable_unprepare(smi->clk_gals1);
-	clk_disable_unprepare(smi->clk_gals0);
-	clk_disable_unprepare(smi->clk_smi);
-	clk_disable_unprepare(smi->clk_apb);
-}
-
 int mtk_smi_larb_get(struct device *larbdev)
 {
 	int ret = pm_runtime_resume_and_get(larbdev);
@@ -270,7 +244,6 @@ static const struct mtk_smi_larb_gen mtk_smi_larb_mt6779 = {
 };
 
 static const struct mtk_smi_larb_gen mtk_smi_larb_mt8183 = {
-	.has_gals                   = true,
 	.config_port                = mtk_smi_larb_config_port_gen2_general,
 	.larb_direct_to_common_mask = BIT(2) | BIT(3) | BIT(7),
 				      /* IPU0 | IPU1 | CCU */
@@ -312,6 +285,27 @@ static const struct of_device_id mtk_smi_larb_of_ids[] = {
 	{}
 };
 
+static int mtk_smi_dts_clk_init(struct device *dev, struct mtk_smi *smi,
+				const char * const clks[],
+				unsigned int clk_nr_required,
+				unsigned int clk_nr_optional)
+{
+	int i, ret;
+
+	for (i = 0; i < clk_nr_required; i++)
+		smi->clks[i].id = clks[i];
+	ret = devm_clk_bulk_get(dev, clk_nr_required, smi->clks);
+	if (ret)
+		return ret;
+
+	for (i = clk_nr_required; i < clk_nr_required + clk_nr_optional; i++)
+		smi->clks[i].id = clks[i];
+	ret = devm_clk_bulk_get_optional(dev, clk_nr_optional,
+					 smi->clks + clk_nr_required);
+	smi->clk_num = clk_nr_required + clk_nr_optional;
+	return ret;
+}
+
 static int mtk_smi_larb_probe(struct platform_device *pdev)
 {
 	struct mtk_smi_larb *larb;
@@ -320,6 +314,7 @@ static int mtk_smi_larb_probe(struct platform_device *pdev)
 	struct device_node *smi_node;
 	struct platform_device *smi_pdev;
 	struct device_link *link;
+	int ret;
 
 	larb = devm_kzalloc(dev, sizeof(*larb), GFP_KERNEL);
 	if (!larb)
@@ -331,24 +326,12 @@ static int mtk_smi_larb_probe(struct platform_device *pdev)
 	if (IS_ERR(larb->base))
 		return PTR_ERR(larb->base);
 
-	larb->smi.clk_apb = devm_clk_get(dev, "apb");
-	if (IS_ERR(larb->smi.clk_apb))
-		return PTR_ERR(larb->smi.clk_apb);
-
-	larb->smi.clk_smi = devm_clk_get(dev, "smi");
-	if (IS_ERR(larb->smi.clk_smi))
-		return PTR_ERR(larb->smi.clk_smi);
-
-	if (larb->larb_gen->has_gals) {
-		/* The larbs may still haven't gals even if the SoC support.*/
-		larb->smi.clk_gals0 = devm_clk_get(dev, "gals");
-		if (PTR_ERR(larb->smi.clk_gals0) == -ENOENT)
-			larb->smi.clk_gals0 = NULL;
-		else if (IS_ERR(larb->smi.clk_gals0))
-			return PTR_ERR(larb->smi.clk_gals0);
-	}
-	larb->smi.dev = dev;
+	ret = mtk_smi_dts_clk_init(dev, &larb->smi, mtk_smi_larb_clks,
+				   MTK_SMI_LARB_REQ_CLK_NR, MTK_SMI_LARB_OPT_CLK_NR);
+	if (ret)
+		return ret;
 
+	larb->smi.dev = dev;
 	smi_node = of_parse_phandle(dev->of_node, "mediatek,smi", 0);
 	if (!smi_node)
 		return -EINVAL;
@@ -391,11 +374,9 @@ static int __maybe_unused mtk_smi_larb_resume(struct device *dev)
 	const struct mtk_smi_larb_gen *larb_gen = larb->larb_gen;
 	int ret;
 
-	ret = mtk_smi_clk_enable(&larb->smi);
-	if (ret < 0) {
-		dev_err(dev, "Failed to enable clock(%d).\n", ret);
+	ret = clk_bulk_prepare_enable(larb->smi.clk_num, larb->smi.clks);
+	if (ret < 0)
 		return ret;
-	}
 
 	/* Configure the basic setting for this larb */
 	larb_gen->config_port(dev);
@@ -407,7 +388,7 @@ static int __maybe_unused mtk_smi_larb_suspend(struct device *dev)
 {
 	struct mtk_smi_larb *larb = dev_get_drvdata(dev);
 
-	mtk_smi_clk_disable(&larb->smi);
+	clk_bulk_disable_unprepare(larb->smi.clk_num, larb->smi.clks);
 	return 0;
 }
 
@@ -493,7 +474,7 @@ static int mtk_smi_common_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct mtk_smi *common;
 	struct resource *res;
-	int ret;
+	int ret, clk_required = MTK_SMI_COM_REQ_CLK_NR;
 
 	common = devm_kzalloc(dev, sizeof(*common), GFP_KERNEL);
 	if (!common)
@@ -501,23 +482,11 @@ static int mtk_smi_common_probe(struct platform_device *pdev)
 	common->dev = dev;
 	common->plat = of_device_get_match_data(dev);
 
-	common->clk_apb = devm_clk_get(dev, "apb");
-	if (IS_ERR(common->clk_apb))
-		return PTR_ERR(common->clk_apb);
-
-	common->clk_smi = devm_clk_get(dev, "smi");
-	if (IS_ERR(common->clk_smi))
-		return PTR_ERR(common->clk_smi);
-
-	if (common->plat->has_gals) {
-		common->clk_gals0 = devm_clk_get(dev, "gals0");
-		if (IS_ERR(common->clk_gals0))
-			return PTR_ERR(common->clk_gals0);
-
-		common->clk_gals1 = devm_clk_get(dev, "gals1");
-		if (IS_ERR(common->clk_gals1))
-			return PTR_ERR(common->clk_gals1);
-	}
+	if (common->plat->has_gals)
+		clk_required = MTK_SMI_COM_GALS_REQ_CLK_NR;
+	ret = mtk_smi_dts_clk_init(dev, common, mtk_smi_common_clks, clk_required, 0);
+	if (ret)
+		return ret;
 
 	/*
 	 * for mtk smi gen 1, we need to get the ao(always on) base to config
@@ -561,11 +530,9 @@ static int __maybe_unused mtk_smi_common_resume(struct device *dev)
 	u32 bus_sel = common->plat->bus_sel;
 	int ret;
 
-	ret = mtk_smi_clk_enable(common);
-	if (ret) {
-		dev_err(common->dev, "Failed to enable clock(%d).\n", ret);
+	ret = clk_bulk_prepare_enable(common->clk_num, common->clks);
+	if (ret)
 		return ret;
-	}
 
 	if (common->plat->gen == MTK_SMI_GEN2 && bus_sel)
 		writel(bus_sel, common->base + SMI_BUS_SEL);
@@ -576,7 +543,7 @@ static int __maybe_unused mtk_smi_common_suspend(struct device *dev)
 {
 	struct mtk_smi *common = dev_get_drvdata(dev);
 
-	mtk_smi_clk_disable(common);
+	clk_bulk_disable_unprepare(common->clk_num, common->clks);
 	return 0;
 }
 
-- 
2.18.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
