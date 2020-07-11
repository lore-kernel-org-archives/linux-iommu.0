Return-Path: <SRS0=PEfB=AW=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,UNWANTED_LANGUAGE_BODY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B474DC433EA
	for <iommu@archiver.kernel.org>; Sat, 11 Jul 2020 06:52:47 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 899B120725
	for <iommu@archiver.kernel.org>; Sat, 11 Jul 2020 06:52:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="hZ+5XT6L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 899B120725
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 7A57588282;
	Sat, 11 Jul 2020 06:52:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qKaBHq1oWeoh; Sat, 11 Jul 2020 06:52:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 0F99C8826F;
	Sat, 11 Jul 2020 06:52:47 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E8E9CC088E;
	Sat, 11 Jul 2020 06:52:46 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A8624C088E
 for <iommu@lists.linux-foundation.org>; Sat, 11 Jul 2020 06:52:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 97B7988AE0
 for <iommu@lists.linux-foundation.org>; Sat, 11 Jul 2020 06:52:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id m3sd28FrFbAc for <iommu@lists.linux-foundation.org>;
 Sat, 11 Jul 2020 06:52:43 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 by whitealder.osuosl.org (Postfix) with ESMTP id 2EFE488334
 for <iommu@lists.linux-foundation.org>; Sat, 11 Jul 2020 06:52:43 +0000 (UTC)
X-UUID: 8bf2ef7cbbad4d0ba7fc277f275626e5-20200711
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From;
 bh=yf085KSU3PMUn6TkSNQXo1sLly+cdKGR+5jbWgYX2B0=; 
 b=hZ+5XT6LTicyUwJekF9VLxKtDj9tElV7YuQ7GR/3FnDbMD+JVcFzl3ZxGKAeUcmubHnIMNHDfceU2ZkFrsOCrDVMt7gyDZYDd92Q6OLVpPmlfnag1tTNiBdq9+CIYG/b9AM+3KjPEekGgm+EvEzQxZO6HigiadFmlt5U6tJlQBo=;
X-UUID: 8bf2ef7cbbad4d0ba7fc277f275626e5-20200711
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by
 mailgw02.mediatek.com (envelope-from <yong.wu@mediatek.com>)
 (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
 with ESMTP id 1085459974; Sat, 11 Jul 2020 14:52:41 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sat, 11 Jul 2020 14:52:37 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sat, 11 Jul 2020 14:52:36 +0800
From: Yong Wu <yong.wu@mediatek.com>
To: Joerg Roedel <joro@8bytes.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
 Rob Herring <robh+dt@kernel.org>, Robin Murphy <robin.murphy@arm.com>
Subject: [PATCH 20/21] iommu/mediatek: Add mt8192 support
Date: Sat, 11 Jul 2020 14:48:45 +0800
Message-ID: <20200711064846.16007-21-yong.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20200711064846.16007-1-yong.wu@mediatek.com>
References: <20200711064846.16007-1-yong.wu@mediatek.com>
MIME-Version: 1.0
X-MTK: N
Cc: youlin.pei@mediatek.com, devicetree@vger.kernel.org,
 Nicolas Boichat <drinkcat@chromium.org>, cui.zhang@mediatek.com,
 srv_heupstream@mediatek.com, chao.hao@mediatek.com,
 linux-kernel@vger.kernel.org, Evan Green <evgreen@chromium.org>,
 Tomasz Figa <tfiga@google.com>, iommu@lists.linux-foundation.org,
 linux-mediatek@lists.infradead.org, ming-fan.chen@mediatek.com,
 anan.sun@mediatek.com, Will Deacon <will@kernel.org>,
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

Add mt8192 iommu support.

Signed-off-by: Yong Wu <yong.wu@mediatek.com>
---
 drivers/iommu/mtk_iommu.c | 20 ++++++++++++++++++++
 drivers/iommu/mtk_iommu.h |  1 +
 2 files changed, 21 insertions(+)

diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index a4ac41e60c4f..da7d055af919 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -168,6 +168,14 @@ static const struct mtk_iommu_iova_region single_domain[] = {
 	{.iova_base = 0, .size = SZ_4G},
 };
 
+static const struct mtk_iommu_iova_region mt8192_multi_dom[] = {
+	{ .iova_base = 0x0, .size = SZ_4G},	      /* disp : 0 ~ 4G */
+	{ .iova_base = SZ_4G, .size = SZ_4G},         /* vdec : 4G ~ 8G */
+	{ .iova_base = SZ_4G * 2, .size = SZ_4G},     /* CAM/MDP: 8G ~ 12G */
+	{ .iova_base = 0x240000000ULL, .size = 0x4000000}, /* CCU0 */
+	{ .iova_base = 0x244000000ULL, .size = 0x4000000}, /* CCU1 */
+};
+
 /*
  * There may be 1 or 2 M4U HWs, But we always expect they are in the same domain
  * for the performance.
@@ -991,11 +999,23 @@ static const struct mtk_iommu_plat_data mt8183_data = {
 	.larbid_remap = {{0}, {4}, {5}, {6}, {7}, {2}, {3}, {1}},
 };
 
+static const struct mtk_iommu_plat_data mt8192_data = {
+	.m4u_plat       = M4U_MT8192,
+	.flags          = HAS_SUB_COMM | OUT_ORDER_WR_EN | WR_THROT_EN
+			  | IOVA_34_EN,
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
index 11795b8d82ff..d42a250156bd 100644
--- a/drivers/iommu/mtk_iommu.h
+++ b/drivers/iommu/mtk_iommu.h
@@ -41,6 +41,7 @@ enum mtk_iommu_plat {
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
