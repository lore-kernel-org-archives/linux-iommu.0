Return-Path: <SRS0=eGnl=LK=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DD92C48BE5
	for <iommu@archiver.kernel.org>; Wed, 16 Jun 2021 11:50:21 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DDF506128B
	for <iommu@archiver.kernel.org>; Wed, 16 Jun 2021 11:50:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDF506128B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B825060717;
	Wed, 16 Jun 2021 11:50:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jtEsAvtH8fIA; Wed, 16 Jun 2021 11:50:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 93DB960667;
	Wed, 16 Jun 2021 11:50:18 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 762C4C000D;
	Wed, 16 Jun 2021 11:50:18 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 43E85C000B
 for <iommu@lists.linux-foundation.org>; Wed, 16 Jun 2021 11:50:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 24A4F4045B
 for <iommu@lists.linux-foundation.org>; Wed, 16 Jun 2021 11:50:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id cOdQBUgif-Je for <iommu@lists.linux-foundation.org>;
 Wed, 16 Jun 2021 11:50:15 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from mailgw01.mediatek.com (unknown [210.61.82.183])
 by smtp2.osuosl.org (Postfix) with ESMTPS id DA236403E8
 for <iommu@lists.linux-foundation.org>; Wed, 16 Jun 2021 11:50:14 +0000 (UTC)
X-UUID: b2b255ea32b248c187703587b5d9d101-20210616
X-UUID: b2b255ea32b248c187703587b5d9d101-20210616
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
 (envelope-from <yong.wu@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
 with ESMTP id 2001647873; Wed, 16 Jun 2021 19:45:09 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 16 Jun 2021 19:44:54 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 16 Jun 2021 19:44:53 +0800
From: Yong Wu <yong.wu@mediatek.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>, Rob Herring
 <robh+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>
Subject: [PATCH 6/9] memory: mtk-smi: Add smi sub common support
Date: Wed, 16 Jun 2021 19:43:43 +0800
Message-ID: <20210616114346.18812-7-yong.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210616114346.18812-1-yong.wu@mediatek.com>
References: <20210616114346.18812-1-yong.wu@mediatek.com>
MIME-Version: 1.0
X-MTK: N
Cc: youlin.pei@mediatek.com, anan.sun@mediatek.com, srv_heupstream@mediatek.com,
 Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
 Krzysztof Kozlowski <krzk@kernel.org>, iommu@lists.linux-foundation.org,
 linux-mediatek@lists.infradead.org, anthony.huang@mediatek.com,
 ming-fan.chen@mediatek.com, yi.kuo@mediatek.com,
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

This patch adds smi-sub-common support. some larbs may connect with the
smi-sub-common, then connect with smi-common.

Before we create device link between smi-larb with smi-common, If we have
sub-common, we should use device link the smi-larb and smi-sub-common,
then use device link between the smi-sub-common with smi-common. This is
for enabling clock/power automatically.
Move the device link code to a new interface for reusing.

there is no SW extra setting for smi-sub-common.

Signed-off-by: Yong Wu <yong.wu@mediatek.com>
---
 drivers/memory/mtk-smi.c | 78 ++++++++++++++++++++++++++--------------
 1 file changed, 52 insertions(+), 26 deletions(-)

diff --git a/drivers/memory/mtk-smi.c b/drivers/memory/mtk-smi.c
index 6858877ac859..fa3a14605dc2 100644
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
@@ -93,13 +94,14 @@ struct mtk_smi {
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
@@ -206,6 +208,39 @@ mtk_smi_larb_unbind(struct device *dev, struct device *master, void *data)
 	/* Do nothing as the iommu is always enabled. */
 }
 
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
+
+	return 0;
+}
+
 static const struct component_ops mtk_smi_larb_component_ops = {
 	.bind = mtk_smi_larb_bind,
 	.unbind = mtk_smi_larb_unbind,
@@ -267,9 +302,6 @@ static int mtk_smi_larb_probe(struct platform_device *pdev)
 	struct mtk_smi_larb *larb;
 	struct resource *res;
 	struct device *dev = &pdev->dev;
-	struct device_node *smi_node;
-	struct platform_device *smi_pdev;
-	struct device_link *link;
 	int i, ret;
 
 	larb = devm_kzalloc(dev, sizeof(*larb), GFP_KERNEL);
@@ -291,27 +323,9 @@ static int mtk_smi_larb_probe(struct platform_device *pdev)
 		return ret;
 
 	larb->smi.dev = dev;
-
-	smi_node = of_parse_phandle(dev->of_node, "mediatek,smi", 0);
-	if (!smi_node)
-		return -EINVAL;
-
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
@@ -451,6 +465,14 @@ static int mtk_smi_common_probe(struct platform_device *pdev)
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
@@ -458,6 +480,10 @@ static int mtk_smi_common_probe(struct platform_device *pdev)
 
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
