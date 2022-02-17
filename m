Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33C9EC433FE
	for <iommu@archiver.kernel.org>; Thu, 17 Feb 2022 11:39:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id DB75B6F6C4;
	Thu, 17 Feb 2022 11:38:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dO1dqJkdfx6D; Thu, 17 Feb 2022 11:38:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id A9E4460709;
	Thu, 17 Feb 2022 11:38:58 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9224CC0021;
	Thu, 17 Feb 2022 11:38:58 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DAFF5C000B
 for <iommu@lists.linux-foundation.org>; Thu, 17 Feb 2022 11:38:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D490F60709
 for <iommu@lists.linux-foundation.org>; Thu, 17 Feb 2022 11:38:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id b-3RgkwDmJhJ for <iommu@lists.linux-foundation.org>;
 Thu, 17 Feb 2022 11:38:56 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E899F606EB
 for <iommu@lists.linux-foundation.org>; Thu, 17 Feb 2022 11:38:55 +0000 (UTC)
X-UUID: 41de23469d6748b19f3f012279ed96e8-20220217
X-UUID: 41de23469d6748b19f3f012279ed96e8-20220217
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by
 mailgw01.mediatek.com (envelope-from <yong.wu@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 1642652840; Thu, 17 Feb 2022 19:38:52 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Thu, 17 Feb 2022 19:38:50 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 17 Feb 2022 19:38:49 +0800
To: Joerg Roedel <joro@8bytes.org>, Rob Herring <robh+dt@kernel.org>,
 "Matthias Brugger" <matthias.bgg@gmail.com>, Will Deacon <will@kernel.org>
Subject: [PATCH v5 24/34] iommu/mediatek: Just move code position in hw_init
Date: Thu, 17 Feb 2022 19:34:43 +0800
Message-ID: <20220217113453.13658-25-yong.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220217113453.13658-1-yong.wu@mediatek.com>
References: <20220217113453.13658-1-yong.wu@mediatek.com>
MIME-Version: 1.0
X-MTK: N
Cc: devicetree@vger.kernel.org, srv_heupstream@mediatek.com,
 Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
 chengci.xu@mediatek.com, xueqi.zhang@mediatek.com,
 linux-kernel@vger.kernel.org, libo.kang@mediatek.com,
 yen-chang.chen@mediatek.com, iommu@lists.linux-foundation.org,
 yf.wang@mediatek.com, linux-mediatek@lists.infradead.org,
 Hsin-Yi Wang <hsinyi@chromium.org>, anan.sun@mediatek.com,
 Robin Murphy <robin.murphy@arm.com>, mingyuan.ma@mediatek.com,
 linux-arm-kernel@lists.infradead.org, AngeloGioacchino
 Del Regno <angelogioacchino.delregno@collabora.com>
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
From: Yong Wu via iommu <iommu@lists.linux-foundation.org>
Reply-To: Yong Wu <yong.wu@mediatek.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

No functional change too, prepare for mt8195 IOMMU support bank functions.
Some global control settings are in bank0 while the other banks have
their bank independent setting. Here only move the global control
settings and the independent registers together.

Signed-off-by: Yong Wu <yong.wu@mediatek.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/iommu/mtk_iommu.c | 48 +++++++++++++++++++--------------------
 1 file changed, 24 insertions(+), 24 deletions(-)

diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index c068e0c0ebf4..efba08774c52 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -801,30 +801,6 @@ static int mtk_iommu_hw_init(const struct mtk_iommu_data *data)
 	}
 	writel_relaxed(regval, data->base + REG_MMU_CTRL_REG);
 
-	regval = F_L2_MULIT_HIT_EN |
-		F_TABLE_WALK_FAULT_INT_EN |
-		F_PREETCH_FIFO_OVERFLOW_INT_EN |
-		F_MISS_FIFO_OVERFLOW_INT_EN |
-		F_PREFETCH_FIFO_ERR_INT_EN |
-		F_MISS_FIFO_ERR_INT_EN;
-	writel_relaxed(regval, data->base + REG_MMU_INT_CONTROL0);
-
-	regval = F_INT_TRANSLATION_FAULT |
-		F_INT_MAIN_MULTI_HIT_FAULT |
-		F_INT_INVALID_PA_FAULT |
-		F_INT_ENTRY_REPLACEMENT_FAULT |
-		F_INT_TLB_MISS_FAULT |
-		F_INT_MISS_TRANSACTION_FIFO_FAULT |
-		F_INT_PRETETCH_TRANSATION_FIFO_FAULT;
-	writel_relaxed(regval, data->base + REG_MMU_INT_MAIN_CONTROL);
-
-	if (MTK_IOMMU_HAS_FLAG(data->plat_data, HAS_LEGACY_IVRP_PADDR))
-		regval = (data->protect_base >> 1) | (data->enable_4GB << 31);
-	else
-		regval = lower_32_bits(data->protect_base) |
-			 upper_32_bits(data->protect_base);
-	writel_relaxed(regval, data->base + REG_MMU_IVRP_PADDR);
-
 	if (data->enable_4GB &&
 	    MTK_IOMMU_HAS_FLAG(data->plat_data, HAS_VLD_PA_RNG)) {
 		/*
@@ -858,6 +834,30 @@ static int mtk_iommu_hw_init(const struct mtk_iommu_data *data)
 	}
 	writel_relaxed(regval, data->base + REG_MMU_MISC_CTRL);
 
+	regval = F_L2_MULIT_HIT_EN |
+		F_TABLE_WALK_FAULT_INT_EN |
+		F_PREETCH_FIFO_OVERFLOW_INT_EN |
+		F_MISS_FIFO_OVERFLOW_INT_EN |
+		F_PREFETCH_FIFO_ERR_INT_EN |
+		F_MISS_FIFO_ERR_INT_EN;
+	writel_relaxed(regval, data->base + REG_MMU_INT_CONTROL0);
+
+	regval = F_INT_TRANSLATION_FAULT |
+		F_INT_MAIN_MULTI_HIT_FAULT |
+		F_INT_INVALID_PA_FAULT |
+		F_INT_ENTRY_REPLACEMENT_FAULT |
+		F_INT_TLB_MISS_FAULT |
+		F_INT_MISS_TRANSACTION_FIFO_FAULT |
+		F_INT_PRETETCH_TRANSATION_FIFO_FAULT;
+	writel_relaxed(regval, data->base + REG_MMU_INT_MAIN_CONTROL);
+
+	if (MTK_IOMMU_HAS_FLAG(data->plat_data, HAS_LEGACY_IVRP_PADDR))
+		regval = (data->protect_base >> 1) | (data->enable_4GB << 31);
+	else
+		regval = lower_32_bits(data->protect_base) |
+			 upper_32_bits(data->protect_base);
+	writel_relaxed(regval, data->base + REG_MMU_IVRP_PADDR);
+
 	if (devm_request_irq(data->dev, data->irq, mtk_iommu_isr, 0,
 			     dev_name(data->dev), (void *)data)) {
 		writel_relaxed(0, data->base + REG_MMU_PT_BASE_ADDR);
-- 
2.18.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
