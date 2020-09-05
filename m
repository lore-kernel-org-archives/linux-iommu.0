Return-Path: <SRS0=R2i3=CO=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C37ABC43461
	for <iommu@archiver.kernel.org>; Sat,  5 Sep 2020 08:14:46 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6DE4F2074D
	for <iommu@archiver.kernel.org>; Sat,  5 Sep 2020 08:14:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="FFpOp74z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DE4F2074D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 5ADF586D47;
	Sat,  5 Sep 2020 08:14:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qThp6sBy2iUr; Sat,  5 Sep 2020 08:14:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id A59BF81A29;
	Sat,  5 Sep 2020 08:14:45 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9150DC088B;
	Sat,  5 Sep 2020 08:14:45 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0EAC5C0052
 for <iommu@lists.linux-foundation.org>; Sat,  5 Sep 2020 08:14:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id F24A186E1D
 for <iommu@lists.linux-foundation.org>; Sat,  5 Sep 2020 08:14:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id cZ-SCcyHmaAH for <iommu@lists.linux-foundation.org>;
 Sat,  5 Sep 2020 08:14:43 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 by hemlock.osuosl.org (Postfix) with ESMTP id E576F8584C
 for <iommu@lists.linux-foundation.org>; Sat,  5 Sep 2020 08:14:42 +0000 (UTC)
X-UUID: 00dc1d75ef68401ab1df6a840c582e5a-20200905
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From;
 bh=RGC4TyuwgH+C0nl9qqtSkY3WkBISOgOe8Q8KEaKsHZg=; 
 b=FFpOp74zlpgQJL8hFhxGQE7Bb7vDVuCD8R2WElaffKQKG+g6G9JG+7N4JMQbPCepJlUp5QYqnyXbpGVXtQJfkJA7WGGF0WVkXD7mXPvdTD6L44qp2aSltXdAbeAUfHsLJ/eWSZ7fqkFr5bM5yEdvdJkUUTNoIuu9P7R04LWv9+g=;
X-UUID: 00dc1d75ef68401ab1df6a840c582e5a-20200905
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by
 mailgw02.mediatek.com (envelope-from <yong.wu@mediatek.com>)
 (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2
 ECDHE-RSA-AES256-SHA384 256/256)
 with ESMTP id 1671242871; Sat, 05 Sep 2020 16:14:41 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sat, 5 Sep 2020 16:14:38 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sat, 5 Sep 2020 16:14:38 +0800
From: Yong Wu <yong.wu@mediatek.com>
To: Joerg Roedel <joro@8bytes.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
 Rob Herring <robh+dt@kernel.org>, Robin Murphy <robin.murphy@arm.com>
Subject: [PATCH v2 22/23] iommu/mediatek: Add mt8192 support
Date: Sat, 5 Sep 2020 16:09:19 +0800
Message-ID: <20200905080920.13396-23-yong.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20200905080920.13396-1-yong.wu@mediatek.com>
References: <20200905080920.13396-1-yong.wu@mediatek.com>
MIME-Version: 1.0
X-TM-SNTS-SMTP: 5B5F9E93F3ACDA5B93F530C569B8DA973D4AF1AF300DD1BD6639A2B983DAA07A2000:8
X-MTK: N
Cc: youlin.pei@mediatek.com, devicetree@vger.kernel.org,
 Nicolas Boichat <drinkcat@chromium.org>, srv_heupstream@mediatek.com,
 chao.hao@mediatek.com, linux-kernel@vger.kernel.org,
 Evan Green <evgreen@chromium.org>, Tomasz Figa <tfiga@google.com>,
 iommu@lists.linux-foundation.org, linux-mediatek@lists.infradead.org,
 ming-fan.chen@mediatek.com, anan.sun@mediatek.com,
 Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org
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

Add mt8192 iommu support.

For multi domain, Add 1M gap for the vdec domain size. That is because
vdec HW has a end address register which require (start_addr +
len) rather than (start_addr + len - 1). Take a example, if the start_addr
is 0xfff00000, size is 0x100000, then the end_address is 0xfff00000 +
0x100000 = 0x1 0000 0000. but the register only is 32bit. thus HW will get
the end address is 0. To avoid this issue, I add 1M gap for this.

Signed-off-by: Yong Wu <yong.wu@mediatek.com>
---
 drivers/iommu/mtk_iommu.c | 22 ++++++++++++++++++++++
 drivers/iommu/mtk_iommu.h |  1 +
 2 files changed, 23 insertions(+)

diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index d0593d317240..ebc3767b62ab 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -171,6 +171,16 @@ static const struct mtk_iommu_iova_region single_domain[] = {
 	{.iova_base = 0,		.size = SZ_4G},
 };
 
+static const struct mtk_iommu_iova_region mt8192_multi_dom[] = {
+	{ .iova_base = 0x0,		.size = SZ_4G},		/* disp: 0 ~ 4G */
+	#if IS_ENABLED(CONFIG_ARCH_DMA_ADDR_T_64BIT)
+	{ .iova_base = SZ_4G,		.size = SZ_4G - SZ_1M},	/* vdec: 4G ~ 8G gap: 1M */
+	{ .iova_base = SZ_4G * 2,	.size = SZ_4G - SZ_1M},	/* CAM/MDP: 8G ~ 12G */
+	{ .iova_base = 0x240000000ULL,	.size = 0x4000000},	/* CCU0 */
+	{ .iova_base = 0x244000000ULL,	.size = 0x4000000},	/* CCU1 */
+	#endif
+};
+
 /*
  * There may be 1 or 2 M4U HWs, But we always expect they are in the same domain
  * for the performance.
@@ -967,11 +977,23 @@ static const struct mtk_iommu_plat_data mt8183_data = {
 	.larbid_remap = {{0}, {4}, {5}, {6}, {7}, {2}, {3}, {1}},
 };
 
+static const struct mtk_iommu_plat_data mt8192_data = {
+	.m4u_plat       = M4U_MT8192,
+	.flags          = HAS_BCLK | HAS_SUB_COMM | OUT_ORDER_WR_EN |
+			  WR_THROT_EN | IOVA_34_EN,
+	.inv_sel_reg    = REG_MMU_INV_SEL_GEN2,
+	.iova_region    = mt8192_multi_dom,
+	.iova_region_nr = ARRAY_SIZE(mt8192_multi_dom),
+	.larbid_remap   = {{0}, {1}, {4, 5}, {7}, {2}, {9, 11, 19, 20},
+			   {0, 14, 16}, {0, 13, 18, 17}},
+};
+
 static const struct of_device_id mtk_iommu_of_ids[] = {
 	{ .compatible = "mediatek,mt2712-m4u", .data = &mt2712_data},
 	{ .compatible = "mediatek,mt6779-m4u", .data = &mt6779_data},
 	{ .compatible = "mediatek,mt8173-m4u", .data = &mt8173_data},
 	{ .compatible = "mediatek,mt8183-m4u", .data = &mt8183_data},
+	{ .compatible = "mediatek,mt8192-m4u", .data = &mt8192_data},
 	{}
 };
 
diff --git a/drivers/iommu/mtk_iommu.h b/drivers/iommu/mtk_iommu.h
index 5e346464cdf8..d2702eda25d4 100644
--- a/drivers/iommu/mtk_iommu.h
+++ b/drivers/iommu/mtk_iommu.h
@@ -42,6 +42,7 @@ enum mtk_iommu_plat {
 	M4U_MT6779,
 	M4U_MT8173,
 	M4U_MT8183,
+	M4U_MT8192,
 };
 
 struct mtk_iommu_iova_region;
-- 
2.18.0
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
