Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDA76C433EF
	for <iommu@archiver.kernel.org>; Tue,  3 May 2022 07:16:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 9E69B40547;
	Tue,  3 May 2022 07:16:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id i7uHeySj7I7z; Tue,  3 May 2022 07:16:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id A1B34404B7;
	Tue,  3 May 2022 07:16:30 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7DBCCC0039;
	Tue,  3 May 2022 07:16:30 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8BFC2C002D
 for <iommu@lists.linux-foundation.org>; Tue,  3 May 2022 07:16:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6D7CD80DBF
 for <iommu@lists.linux-foundation.org>; Tue,  3 May 2022 07:16:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id j9eLqqn02bXO for <iommu@lists.linux-foundation.org>;
 Tue,  3 May 2022 07:16:29 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
 by smtp1.osuosl.org (Postfix) with ESMTPS id AFF0F81291
 for <iommu@lists.linux-foundation.org>; Tue,  3 May 2022 07:16:28 +0000 (UTC)
X-UUID: c5cce1b54bba45a5ac135ed80bca9a8d-20220503
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.4, REQID:2ec0fc11-1ecd-47e4-a38e-14d1e5555f7f, OB:30,
 L
 OB:30,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:100,FILE:0,RULE:Release_Ham,
 ACTION:release,TS:100
X-CID-INFO: VERSION:1.1.4, REQID:2ec0fc11-1ecd-47e4-a38e-14d1e5555f7f, OB:30,
 LOB
 :30,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:100,FILE:0,RULE:Spam_GS981B3D,
 ACTION:quarantine,TS:100
X-CID-META: VersionHash:faefae9, CLOUDID:54bb4ac7-85ee-4ac1-ac05-bd3f1e72e732,
 C
 OID:641a58b95193,Recheck:0,SF:28|17|19|48,TC:nil,Content:0,EDM:-3,File:nil
 ,QS:0,BEC:nil
X-UUID: c5cce1b54bba45a5ac135ed80bca9a8d-20220503
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw01.mediatek.com
 (envelope-from <yong.wu@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
 with ESMTP id 985565606; Tue, 03 May 2022 15:16:23 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3; 
 Tue, 3 May 2022 15:16:22 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 3 May 2022 15:16:21 +0800
To: Joerg Roedel <joro@8bytes.org>, Rob Herring <robh+dt@kernel.org>,
 "Matthias Brugger" <matthias.bgg@gmail.com>, Will Deacon <will@kernel.org>
Subject: [PATCH v7 11/36] iommu/mediatek: Add a flag DCM_DISABLE
Date: Tue, 3 May 2022 15:14:02 +0800
Message-ID: <20220503071427.2285-12-yong.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220503071427.2285-1-yong.wu@mediatek.com>
References: <20220503071427.2285-1-yong.wu@mediatek.com>
MIME-Version: 1.0
X-MTK: N
Cc: devicetree@vger.kernel.org, libo.kang@mediatek.com,
 xueqi.zhang@mediatek.com, linux-kernel@vger.kernel.org,
 Krzysztof Kozlowski <krzk@kernel.org>, yen-chang.chen@mediatek.com,
 chengci.xu@mediatek.com, iommu@lists.linux-foundation.org,
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

In the infra iommu, we should disable DCM. add a new flag for this.

Signed-off-by: Yong Wu <yong.wu@mediatek.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/iommu/mtk_iommu.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index d91a0c138536..92f172a772d1 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -51,6 +51,8 @@
 #define F_MMU_STANDARD_AXI_MODE_MASK		(BIT(3) | BIT(19))
 
 #define REG_MMU_DCM_DIS				0x050
+#define F_MMU_DCM				BIT(8)
+
 #define REG_MMU_WR_LEN_CTRL			0x054
 #define F_MMU_WR_THROT_DIS_MASK			(BIT(5) | BIT(21))
 
@@ -119,6 +121,7 @@
 #define HAS_LEGACY_IVRP_PADDR		BIT(7)
 #define IOVA_34_EN			BIT(8)
 #define SHARE_PGTABLE			BIT(9) /* 2 HW share pgtable */
+#define DCM_DISABLE			BIT(10)
 
 #define MTK_IOMMU_HAS_FLAG(pdata, _x) \
 		((((pdata)->flags) & (_x)) == (_x))
@@ -765,7 +768,11 @@ static int mtk_iommu_hw_init(const struct mtk_iommu_data *data)
 		regval = F_MMU_VLD_PA_RNG(7, 4);
 		writel_relaxed(regval, data->base + REG_MMU_VLD_PA_RNG);
 	}
-	writel_relaxed(0, data->base + REG_MMU_DCM_DIS);
+	if (MTK_IOMMU_HAS_FLAG(data->plat_data, DCM_DISABLE))
+		writel_relaxed(F_MMU_DCM, data->base + REG_MMU_DCM_DIS);
+	else
+		writel_relaxed(0, data->base + REG_MMU_DCM_DIS);
+
 	if (MTK_IOMMU_HAS_FLAG(data->plat_data, WR_THROT_EN)) {
 		/* write command throttling mode */
 		regval = readl_relaxed(data->base + REG_MMU_WR_LEN_CTRL);
-- 
2.18.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
