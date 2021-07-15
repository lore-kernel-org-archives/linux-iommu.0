Return-Path: <SRS0=9Lhb=MH=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07B5AC47E48
	for <iommu@archiver.kernel.org>; Thu, 15 Jul 2021 12:13:36 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C683A6136E
	for <iommu@archiver.kernel.org>; Thu, 15 Jul 2021 12:13:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C683A6136E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A1EC0607FA;
	Thu, 15 Jul 2021 12:13:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 852k7ACzuGbX; Thu, 15 Jul 2021 12:13:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 686656003C;
	Thu, 15 Jul 2021 12:13:34 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4E2CBC0010;
	Thu, 15 Jul 2021 12:13:34 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9606DC000E
 for <iommu@lists.linux-foundation.org>; Thu, 15 Jul 2021 12:13:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7C21742262
 for <iommu@lists.linux-foundation.org>; Thu, 15 Jul 2021 12:13:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id cgCXWvFlg441 for <iommu@lists.linux-foundation.org>;
 Thu, 15 Jul 2021 12:13:30 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 3C76042274
 for <iommu@lists.linux-foundation.org>; Thu, 15 Jul 2021 12:13:30 +0000 (UTC)
X-UUID: 897d1e1c0a1245f4a62cf69e897f7075-20210715
X-UUID: 897d1e1c0a1245f4a62cf69e897f7075-20210715
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
 (envelope-from <yong.wu@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
 with ESMTP id 1117801782; Thu, 15 Jul 2021 20:13:24 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs02n1.mediatek.inc (172.21.101.77) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 15 Jul 2021 20:13:23 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 15 Jul 2021 20:13:21 +0800
From: Yong Wu <yong.wu@mediatek.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>, Rob Herring
 <robh+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>
Subject: [PATCH v2 07/11] memory: mtk-smi: Add smi sub common support
Date: Thu, 15 Jul 2021 20:12:05 +0800
Message-ID: <20210715121209.31024-8-yong.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210715121209.31024-1-yong.wu@mediatek.com>
References: <20210715121209.31024-1-yong.wu@mediatek.com>
MIME-Version: 1.0
X-MTK: N
Cc: youlin.pei@mediatek.com, devicetree@vger.kernel.org, yi.kuo@mediatek.com,
 srv_heupstream@mediatek.com, Will Deacon <will@kernel.org>,
 linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>,
 iommu@lists.linux-foundation.org, linux-mediatek@lists.infradead.org,
 anthony.huang@mediatek.com, ming-fan.chen@mediatek.com, anan.sun@mediatek.com,
 Robin Murphy <robin.murphy@arm.com>, linux-arm-kernel@lists.infradead.org
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

In mt8195, there are some larbs connect with the smi-sub-common, then
connect with smi-common.

Before we create device link between smi-larb with smi-common. If we have
sub-common, we should use device link the smi-larb and smi-sub-common,
then use device link between the smi-sub-common with smi-common. This is
for enabling clock/power automatically.

Move the device link code to a new interface for reusing.

There is no SW extra setting for smi-sub-common.

Signed-off-by: Yong Wu <yong.wu@mediatek.com>
---
 drivers/memory/mtk-smi.c | 75 +++++++++++++++++++++++++++-------------
 1 file changed, 51 insertions(+), 24 deletions(-)

diff --git a/drivers/memory/mtk-smi.c b/drivers/memory/mtk-smi.c
index e68cbb51dd12..ee49bb50f5f5 100644
--- a/drivers/memory/mtk-smi.c
+++ b/drivers/memory/mtk-smi.c
@@ -60,7 +60,8 @@
 
 enum mtk_smi_type {
 	MTK_SMI_GEN1,
-	MTK_SMI_GEN2
+	MTK_SMI_GEN2,		/* gen2 smi common */
+	MTK_SMI_GEN2_SUB_COMM,	/* gen2 smi sub common */
 };
 
 #define MTK_SMI_CLK_NR_MAX			4
@@ -90,13 +91,14 @@ struct mtk_smi {
 		void __iomem		*smi_ao_base; /* only for gen1 */
 		void __iomem		*base;	      /* only for gen2 */
 	};
+	struct device			*smi_common_dev; /* for sub common */
 	const struct mtk_smi_common_plat *plat;
 };
 
 struct mtk_smi_larb { /* larb: local arbiter */
 	struct mtk_smi			smi;
 	void __iomem			*base;
-	struct device			*smi_common_dev;
+	struct device			*smi_common_dev; /* common or sub-common dev */
 	const struct mtk_smi_larb_gen	*larb_gen;
 	int				larbid;
 	u32				*mmu;
@@ -259,6 +261,38 @@ static const struct of_device_id mtk_smi_larb_of_ids[] = {
 	{}
 };
 
+static int mtk_smi_device_link_common(struct device *dev, struct device **com_dev)
+{
+	struct platform_device *smi_com_pdev;
+	struct device_node *smi_com_node;
+	struct device *smi_com_dev;
+	struct device_link *link;
+
+	smi_com_node = of_parse_phandle(dev->of_node, "mediatek,smi", 0);
+	if (!smi_com_node)
+		return -EINVAL;
+
+	smi_com_pdev = of_find_device_by_node(smi_com_node);
+	of_node_put(smi_com_node);
+	if (smi_com_pdev) {
+		/* smi common is the supplier, Make sure it is ready before */
+		if (!platform_get_drvdata(smi_com_pdev))
+			return -EPROBE_DEFER;
+		smi_com_dev = &smi_com_pdev->dev;
+		link = device_link_add(dev, smi_com_dev,
+				       DL_FLAG_PM_RUNTIME | DL_FLAG_STATELESS);
+		if (!link) {
+			dev_err(dev, "Unable to link smi-common dev\n");
+			return -ENODEV;
+		}
+		*com_dev = smi_com_dev;
+	} else {
+		dev_err(dev, "Failed to get the smi_common device\n");
+		return -EINVAL;
+	}
+	return 0;
+}
+
 static int mtk_smi_dts_clk_init(struct device *dev, struct mtk_smi *smi,
 				unsigned int clk_nr_optional,
 				const char * const clk_optional[])
@@ -285,9 +319,6 @@ static int mtk_smi_larb_probe(struct platform_device *pdev)
 	struct mtk_smi_larb *larb;
 	struct resource *res;
 	struct device *dev = &pdev->dev;
-	struct device_node *smi_node;
-	struct platform_device *smi_pdev;
-	struct device_link *link;
 	int ret;
 
 	larb = devm_kzalloc(dev, sizeof(*larb), GFP_KERNEL);
@@ -307,26 +338,10 @@ static int mtk_smi_larb_probe(struct platform_device *pdev)
 		return ret;
 
 	larb->smi.dev = dev;
-	smi_node = of_parse_phandle(dev->of_node, "mediatek,smi", 0);
-	if (!smi_node)
-		return -EINVAL;
 
-	smi_pdev = of_find_device_by_node(smi_node);
-	of_node_put(smi_node);
-	if (smi_pdev) {
-		if (!platform_get_drvdata(smi_pdev))
-			return -EPROBE_DEFER;
-		larb->smi_common_dev = &smi_pdev->dev;
-		link = device_link_add(dev, larb->smi_common_dev,
-				       DL_FLAG_PM_RUNTIME | DL_FLAG_STATELESS);
-		if (!link) {
-			dev_err(dev, "Unable to link smi-common dev\n");
-			return -ENODEV;
-		}
-	} else {
-		dev_err(dev, "Failed to get the smi_common device\n");
-		return -EINVAL;
-	}
+	ret = mtk_smi_device_link_common(dev, &larb->smi_common_dev);
+	if (ret < 0)
+		return ret;
 
 	pm_runtime_enable(dev);
 	platform_set_drvdata(pdev, larb);
@@ -471,6 +486,14 @@ static int mtk_smi_common_probe(struct platform_device *pdev)
 		if (IS_ERR(common->base))
 			return PTR_ERR(common->base);
 	}
+
+	/* link its smi-common if this is smi-sub-common */
+	if (common->plat->type == MTK_SMI_GEN2_SUB_COMM) {
+		ret = mtk_smi_device_link_common(dev, &common->smi_common_dev);
+		if (ret < 0)
+			return ret;
+	}
+
 	pm_runtime_enable(dev);
 	platform_set_drvdata(pdev, common);
 	return 0;
@@ -478,6 +501,10 @@ static int mtk_smi_common_probe(struct platform_device *pdev)
 
 static int mtk_smi_common_remove(struct platform_device *pdev)
 {
+	struct mtk_smi *common = dev_get_drvdata(&pdev->dev);
+
+	if (common->plat->type == MTK_SMI_GEN2_SUB_COMM)
+		device_link_remove(&pdev->dev, common->smi_common_dev);
 	pm_runtime_disable(&pdev->dev);
 	return 0;
 }
-- 
2.18.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
