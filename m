Return-Path: <SRS0=SLGw=NE=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 542D7C4338F
	for <iommu@archiver.kernel.org>; Fri, 13 Aug 2021 06:54:38 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 19E1F610CC
	for <iommu@archiver.kernel.org>; Fri, 13 Aug 2021 06:54:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 19E1F610CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id E48A04023D;
	Fri, 13 Aug 2021 06:54:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lTpPEdvpdm7I; Fri, 13 Aug 2021 06:54:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 08D9F401CD;
	Fri, 13 Aug 2021 06:54:34 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DA730C0010;
	Fri, 13 Aug 2021 06:54:33 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2BC8AC000E
 for <iommu@lists.linux-foundation.org>; Fri, 13 Aug 2021 06:54:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 0E834400C9
 for <iommu@lists.linux-foundation.org>; Fri, 13 Aug 2021 06:54:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id j8ZQc2ee0A-J for <iommu@lists.linux-foundation.org>;
 Fri, 13 Aug 2021 06:54:32 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5BECB40002
 for <iommu@lists.linux-foundation.org>; Fri, 13 Aug 2021 06:54:32 +0000 (UTC)
X-UUID: b912c618549547118c663f66b1809865-20210813
X-UUID: b912c618549547118c663f66b1809865-20210813
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
 (envelope-from <yong.wu@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
 with ESMTP id 1243132031; Fri, 13 Aug 2021 14:54:26 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 13 Aug 2021 14:54:25 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 13 Aug 2021 14:54:24 +0800
From: Yong Wu <yong.wu@mediatek.com>
To: Joerg Roedel <joro@8bytes.org>, Rob Herring <robh+dt@kernel.org>, Matthias
 Brugger <matthias.bgg@gmail.com>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>
Subject: [PATCH v2 06/29] iommu/mediatek: Add a flag DCM_DISABLE
Date: Fri, 13 Aug 2021 14:53:01 +0800
Message-ID: <20210813065324.29220-7-yong.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210813065324.29220-1-yong.wu@mediatek.com>
References: <20210813065324.29220-1-yong.wu@mediatek.com>
MIME-Version: 1.0
X-MTK: N
Cc: youlin.pei@mediatek.com, devicetree@vger.kernel.org,
 Nicolas Boichat <drinkcat@chromium.org>, srv_heupstream@mediatek.com,
 Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
 linux-kernel@vger.kernel.org, Evan Green <evgreen@chromium.org>,
 Tomasz Figa <tfiga@google.com>, iommu@lists.linux-foundation.org,
 linux-mediatek@lists.infradead.org, chao.hao@mediatek.com,
 anan.sun@mediatek.com, linux-arm-kernel@lists.infradead.org
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

In the infra iommu, we should disable DCM. add a new flag for this.

Signed-off-by: Yong Wu <yong.wu@mediatek.com>
---
 drivers/iommu/mtk_iommu.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index 259ff7b90ff3..bd50f3020bc1 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -52,6 +52,8 @@
 #define F_MMU_STANDARD_AXI_MODE_MASK		(BIT(3) | BIT(19))
 
 #define REG_MMU_DCM_DIS				0x050
+#define F_MMU_DCM				BIT(8)
+
 #define REG_MMU_WR_LEN_CTRL			0x054
 #define F_MMU_WR_THROT_DIS_MASK			(BIT(5) | BIT(21))
 
@@ -120,6 +122,7 @@
 #define HAS_LEGACY_IVRP_PADDR		BIT(7)
 #define IOVA_34_EN			BIT(8)
 #define SHARE_PGTABLE			BIT(9) /* 2 HW share pgtable */
+#define DCM_DISABLE			BIT(10)
 
 #define MTK_IOMMU_HAS_FLAG(pdata, _x) \
 		((((pdata)->flags) & (_x)) == (_x))
@@ -733,7 +736,11 @@ static int mtk_iommu_hw_init(const struct mtk_iommu_data *data)
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
