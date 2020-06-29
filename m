Return-Path: <SRS0=qe9F=AK=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26AACC433E1
	for <iommu@archiver.kernel.org>; Mon, 29 Jun 2020 07:14:24 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F060F2332B
	for <iommu@archiver.kernel.org>; Mon, 29 Jun 2020 07:14:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="iGvW3X8Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F060F2332B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id C381C8936F;
	Mon, 29 Jun 2020 07:14:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PUdD05NwLvHm; Mon, 29 Jun 2020 07:14:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 2CF2889362;
	Mon, 29 Jun 2020 07:14:23 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 113F2C08A2;
	Mon, 29 Jun 2020 07:14:23 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 00CECC07FF
 for <iommu@lists.linux-foundation.org>; Mon, 29 Jun 2020 07:14:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id DC1C888558
 for <iommu@lists.linux-foundation.org>; Mon, 29 Jun 2020 07:14:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3D2i+f+0LFEo for <iommu@lists.linux-foundation.org>;
 Mon, 29 Jun 2020 07:14:20 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 by whitealder.osuosl.org (Postfix) with ESMTP id EF21588587
 for <iommu@lists.linux-foundation.org>; Mon, 29 Jun 2020 07:14:19 +0000 (UTC)
X-UUID: 07376069f2cc423aaa00359729f9f81f-20200629
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From;
 bh=Waw4MpLzpM/zl2PaUldmCJgI6Pg/QZM8fvRDXqtPgjM=; 
 b=iGvW3X8ZwK3o3yltF0TjkmANIyvARvtAKaZVvyi2uTNm4Vg2Y1PncbCBPFl6hufCbmMMrunoFVZJ7h96TSjYMURhK1F5JUg+k9r73zPW5E588wmM2t5oysi4UzXx5TYb1SORx2mfiZt7hF/72zcn3yTkvhnJanyziKwEYFtLUn0=;
X-UUID: 07376069f2cc423aaa00359729f9f81f-20200629
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by
 mailgw02.mediatek.com (envelope-from <chao.hao@mediatek.com>)
 (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
 with ESMTP id 263684464; Mon, 29 Jun 2020 15:14:17 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 29 Jun 2020 15:14:14 +0800
Received: from localhost.localdomain (10.15.20.246) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 29 Jun 2020 15:14:14 +0800
From: Chao Hao <chao.hao@mediatek.com>
To: Joerg Roedel <joro@8bytes.org>, Rob Herring <robh+dt@kernel.org>, Matthias
 Brugger <matthias.bgg@gmail.com>
Subject: [PATCH v5 03/10] iommu/mediatek: Modify the usage of
 mtk_iommu_plat_data structure
Date: Mon, 29 Jun 2020 15:13:03 +0800
Message-ID: <20200629071310.1557-4-chao.hao@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20200629071310.1557-1-chao.hao@mediatek.com>
References: <20200629071310.1557-1-chao.hao@mediatek.com>
MIME-Version: 1.0
X-MTK: N
Cc: devicetree@vger.kernel.org, FY Yang <fy.yang@mediatek.com>,
 wsd_upstream@mediatek.com, linux-kernel@vger.kernel.org,
 Evan Green <evgreen@chromium.org>, Chao Hao <chao.hao@mediatek.com>,
 iommu@lists.linux-foundation.org, linux-mediatek@lists.infradead.org,
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

Given the fact that we are adding more and more plat_data bool values,
it would make sense to use a u32 flags register and add the appropriate
macro definitions to set and check for a flag present.
No functional change.

Suggested-by: Matthias Brugger <matthias.bgg@gmail.com>
Signed-off-by: Chao Hao <chao.hao@mediatek.com>
---
 drivers/iommu/mtk_iommu.c | 23 ++++++++++++-----------
 drivers/iommu/mtk_iommu.h | 16 ++++++++++------
 2 files changed, 22 insertions(+), 17 deletions(-)

diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index 88d3df5b91c2..8f81df6cbe51 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -563,7 +563,8 @@ static int mtk_iommu_hw_init(const struct mtk_iommu_data *data)
 			 upper_32_bits(data->protect_base);
 	writel_relaxed(regval, data->base + REG_MMU_IVRP_PADDR);
 
-	if (data->enable_4GB && data->plat_data->has_vld_pa_rng) {
+	if (data->enable_4GB &&
+	    MTK_IOMMU_HAS_FLAG(data->plat_data, HAS_VLD_PA_RNG)) {
 		/*
 		 * If 4GB mode is enabled, the validate PA range is from
 		 * 0x1_0000_0000 to 0x1_ffff_ffff. here record bit[32:30].
@@ -573,7 +574,7 @@ static int mtk_iommu_hw_init(const struct mtk_iommu_data *data)
 	}
 	writel_relaxed(0, data->base + REG_MMU_DCM_DIS);
 
-	if (data->plat_data->reset_axi) {
+	if (MTK_IOMMU_HAS_FLAG(data->plat_data, RESET_AXI)) {
 		/* The register is called STANDARD_AXI_MODE in this case */
 		writel_relaxed(0, data->base + REG_MMU_MISC_CTRL);
 	}
@@ -618,7 +619,7 @@ static int mtk_iommu_probe(struct platform_device *pdev)
 
 	/* Whether the current dram is over 4GB */
 	data->enable_4GB = !!(max_pfn > (BIT_ULL(32) >> PAGE_SHIFT));
-	if (!data->plat_data->has_4gb_mode)
+	if (!MTK_IOMMU_HAS_FLAG(data->plat_data, HAS_4GB_MODE))
 		data->enable_4GB = false;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
@@ -631,7 +632,7 @@ static int mtk_iommu_probe(struct platform_device *pdev)
 	if (data->irq < 0)
 		return data->irq;
 
-	if (data->plat_data->has_bclk) {
+	if (MTK_IOMMU_HAS_FLAG(data->plat_data, HAS_BCLK)) {
 		data->bclk = devm_clk_get(dev, "bclk");
 		if (IS_ERR(data->bclk))
 			return PTR_ERR(data->bclk);
@@ -763,23 +764,23 @@ static const struct dev_pm_ops mtk_iommu_pm_ops = {
 
 static const struct mtk_iommu_plat_data mt2712_data = {
 	.m4u_plat     = M4U_MT2712,
-	.has_4gb_mode = true,
-	.has_bclk     = true,
-	.has_vld_pa_rng   = true,
+	.flags        = HAS_4GB_MODE |
+			HAS_BCLK |
+			HAS_VLD_PA_RNG,
 	.larbid_remap = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9},
 };
 
 static const struct mtk_iommu_plat_data mt8173_data = {
 	.m4u_plat     = M4U_MT8173,
-	.has_4gb_mode = true,
-	.has_bclk     = true,
-	.reset_axi    = true,
+	.flags	      = HAS_4GB_MODE |
+			HAS_BCLK |
+			RESET_AXI,
 	.larbid_remap = {0, 1, 2, 3, 4, 5}, /* Linear mapping. */
 };
 
 static const struct mtk_iommu_plat_data mt8183_data = {
 	.m4u_plat     = M4U_MT8183,
-	.reset_axi    = true,
+	.flags        = RESET_AXI,
 	.larbid_remap = {0, 4, 5, 6, 7, 2, 3, 1},
 };
 
diff --git a/drivers/iommu/mtk_iommu.h b/drivers/iommu/mtk_iommu.h
index 1b6ea839b92c..7cc39f729263 100644
--- a/drivers/iommu/mtk_iommu.h
+++ b/drivers/iommu/mtk_iommu.h
@@ -17,6 +17,15 @@
 #include <linux/spinlock.h>
 #include <soc/mediatek/smi.h>
 
+#define HAS_4GB_MODE			BIT(0)
+/* HW will use the EMI clock if there isn't the "bclk". */
+#define HAS_BCLK			BIT(1)
+#define HAS_VLD_PA_RNG			BIT(2)
+#define RESET_AXI			BIT(3)
+
+#define MTK_IOMMU_HAS_FLAG(pdata, _x) \
+		((((pdata)->flags) & (_x)) == (_x))
+
 struct mtk_iommu_suspend_reg {
 	u32				misc_ctrl;
 	u32				dcm_dis;
@@ -36,12 +45,7 @@ enum mtk_iommu_plat {
 
 struct mtk_iommu_plat_data {
 	enum mtk_iommu_plat m4u_plat;
-	bool                has_4gb_mode;
-
-	/* HW will use the EMI clock if there isn't the "bclk". */
-	bool                has_bclk;
-	bool                has_vld_pa_rng;
-	bool                reset_axi;
+	u32                 flags;
 	unsigned char       larbid_remap[MTK_LARB_NR_MAX];
 };
 
-- 
2.18.0
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
