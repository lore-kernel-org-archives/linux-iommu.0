Return-Path: <SRS0=9Lhb=MH=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A9B2C07E96
	for <iommu@archiver.kernel.org>; Thu, 15 Jul 2021 12:13:38 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C6C47613DC
	for <iommu@archiver.kernel.org>; Thu, 15 Jul 2021 12:13:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6C47613DC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A2D4B83D5A;
	Thu, 15 Jul 2021 12:13:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id T6qz8wVowPMN; Thu, 15 Jul 2021 12:13:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 9ABA782B49;
	Thu, 15 Jul 2021 12:13:36 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 76CA5C0010;
	Thu, 15 Jul 2021 12:13:36 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A8E6DC000E
 for <iommu@lists.linux-foundation.org>; Thu, 15 Jul 2021 12:13:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 87A0642274
 for <iommu@lists.linux-foundation.org>; Thu, 15 Jul 2021 12:13:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6tx-nxo6WOHV for <iommu@lists.linux-foundation.org>;
 Thu, 15 Jul 2021 12:13:34 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C78DE42262
 for <iommu@lists.linux-foundation.org>; Thu, 15 Jul 2021 12:13:33 +0000 (UTC)
X-UUID: 9cf31c09bac84611a4716b3ab8afb329-20210715
X-UUID: 9cf31c09bac84611a4716b3ab8afb329-20210715
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by
 mailgw02.mediatek.com (envelope-from <yong.wu@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 346738490; Thu, 15 Jul 2021 20:13:30 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs02n1.mediatek.inc (172.21.101.77) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 15 Jul 2021 20:13:29 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 15 Jul 2021 20:13:28 +0800
From: Yong Wu <yong.wu@mediatek.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>, Rob Herring
 <robh+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>
Subject: [PATCH v2 08/11] memory: mtk-smi: Use devm_platform_ioremap_resource
Date: Thu, 15 Jul 2021 20:12:06 +0800
Message-ID: <20210715121209.31024-9-yong.wu@mediatek.com>
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

No functional change. Simplify probing code.

Signed-off-by: Yong Wu <yong.wu@mediatek.com>
---
 drivers/memory/mtk-smi.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/memory/mtk-smi.c b/drivers/memory/mtk-smi.c
index ee49bb50f5f5..e5a34b3952a0 100644
--- a/drivers/memory/mtk-smi.c
+++ b/drivers/memory/mtk-smi.c
@@ -317,7 +317,6 @@ static int mtk_smi_dts_clk_init(struct device *dev, struct mtk_smi *smi,
 static int mtk_smi_larb_probe(struct platform_device *pdev)
 {
 	struct mtk_smi_larb *larb;
-	struct resource *res;
 	struct device *dev = &pdev->dev;
 	int ret;
 
@@ -326,8 +325,7 @@ static int mtk_smi_larb_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	larb->larb_gen = of_device_get_match_data(dev);
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	larb->base = devm_ioremap_resource(dev, res);
+	larb->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(larb->base))
 		return PTR_ERR(larb->base);
 
@@ -447,7 +445,6 @@ static int mtk_smi_common_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct mtk_smi *common;
-	struct resource *res;
 	int ret;
 
 	common = devm_kzalloc(dev, sizeof(*common), GFP_KERNEL);
@@ -468,8 +465,7 @@ static int mtk_smi_common_probe(struct platform_device *pdev)
 	 * base.
 	 */
 	if (common->plat->type == MTK_SMI_GEN1) {
-		res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-		common->smi_ao_base = devm_ioremap_resource(dev, res);
+		common->smi_ao_base = devm_platform_ioremap_resource(pdev, 0);
 		if (IS_ERR(common->smi_ao_base))
 			return PTR_ERR(common->smi_ao_base);
 
@@ -481,8 +477,7 @@ static int mtk_smi_common_probe(struct platform_device *pdev)
 		if (ret)
 			return ret;
 	} else {
-		res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-		common->base = devm_ioremap_resource(dev, res);
+		common->base = devm_platform_ioremap_resource(pdev, 0);
 		if (IS_ERR(common->base))
 			return PTR_ERR(common->base);
 	}
-- 
2.18.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
