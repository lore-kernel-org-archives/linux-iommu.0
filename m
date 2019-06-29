Return-Path: <SRS0=Olzo=U4=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBBFAC4321A
	for <iommu@archiver.kernel.org>; Sat, 29 Jun 2019 02:41:18 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 91AAC2086D
	for <iommu@archiver.kernel.org>; Sat, 29 Jun 2019 02:41:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91AAC2086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 54301CAE;
	Sat, 29 Jun 2019 02:41:18 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 7FE44C11
	for <iommu@lists.linux-foundation.org>;
	Sat, 29 Jun 2019 02:41:17 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mailgw01.mediatek.com (unknown [210.61.82.183])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id B3DB92C6
	for <iommu@lists.linux-foundation.org>;
	Sat, 29 Jun 2019 02:41:16 +0000 (UTC)
X-UUID: 9cee493895d14b65b986362767d1c31c-20190629
X-UUID: 9cee493895d14b65b986362767d1c31c-20190629
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw01.mediatek.com
	(envelope-from <yong.wu@mediatek.com>)
	(mhqrelay.mediatek.com ESMTP with TLS)
	with ESMTP id 262559601; Sat, 29 Jun 2019 10:41:12 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
	mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server
	(TLS) id 15.0.1395.4; Sat, 29 Jun 2019 10:41:11 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas09.mediatek.inc
	(172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
	Transport; Sat, 29 Jun 2019 10:41:10 +0800
From: Yong Wu <yong.wu@mediatek.com>
To: Joerg Roedel <joro@8bytes.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
	Robin Murphy <robin.murphy@arm.com>, Rob Herring <robh+dt@kernel.org>
Subject: [PATCH v8 11/21] iommu/mediatek: Move reset_axi into plat_data
Date: Sat, 29 Jun 2019 10:39:45 +0800
Message-ID: <1561775995-24963-12-git-send-email-yong.wu@mediatek.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1561775995-24963-11-git-send-email-yong.wu@mediatek.com>
References: <1561775995-24963-11-git-send-email-yong.wu@mediatek.com>
MIME-Version: 1.0
X-MTK: N
Cc: youlin.pei@mediatek.com, devicetree@vger.kernel.org,
	Nicolas Boichat <drinkcat@chromium.org>,
	srv_heupstream@mediatek.com, Will Deacon <will.deacon@arm.com>,
	linux-kernel@vger.kernel.org, Evan Green <evgreen@chromium.org>,
	Tomasz Figa <tfiga@google.com>, iommu@lists.linux-foundation.org,
	Matthias Kaehlcke <mka@chromium.org>,
	linux-mediatek@lists.infradead.org, yingjoe.chen@mediatek.com,
	anan.sun@mediatek.com, linux-arm-kernel@lists.infradead.org
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

In mt8173 and mt8183, 0x48 is REG_MMU_STANDARD_AXI_MODE while it is
REG_MMU_CTRL in the other SoCs, and the bits meaning is completely
different with the REG_MMU_STANDARD_AXI_MODE.

This patch moves this property to plat_data, it's also a preparing
patch for mt8183.

Signed-off-by: Yong Wu <yong.wu@mediatek.com>
Reviewed-by: Nicolas Boichat <drinkcat@chromium.org>
Reviewed-by: Evan Green <evgreen@chromium.org>
Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
---
 drivers/iommu/mtk_iommu.c | 4 ++--
 drivers/iommu/mtk_iommu.h | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index 4f8a2cb..1f9f307 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -575,8 +575,7 @@ static int mtk_iommu_hw_init(const struct mtk_iommu_data *data)
 	}
 	writel_relaxed(0, data->base + REG_MMU_DCM_DIS);
 
-	/* It's MISC control register whose default value is ok except mt8173.*/
-	if (data->plat_data->m4u_plat == M4U_MT8173)
+	if (data->plat_data->reset_axi)
 		writel_relaxed(0, data->base + REG_MMU_STANDARD_AXI_MODE);
 
 	if (devm_request_irq(data->dev, data->irq, mtk_iommu_isr, 0,
@@ -772,6 +771,7 @@ static int __maybe_unused mtk_iommu_resume(struct device *dev)
 	.m4u_plat     = M4U_MT8173,
 	.has_4gb_mode = true,
 	.has_bclk     = true,
+	.reset_axi    = true,
 	.larbid_remap = {0, 1, 2, 3, 4, 5}, /* Linear mapping. */
 };
 
diff --git a/drivers/iommu/mtk_iommu.h b/drivers/iommu/mtk_iommu.h
index 61fd5d6..55d73c1 100644
--- a/drivers/iommu/mtk_iommu.h
+++ b/drivers/iommu/mtk_iommu.h
@@ -46,7 +46,7 @@ struct mtk_iommu_plat_data {
 
 	/* HW will use the EMI clock if there isn't the "bclk". */
 	bool                has_bclk;
-
+	bool                reset_axi;
 	unsigned char       larbid_remap[MTK_LARB_NR_MAX];
 };
 
-- 
1.9.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
