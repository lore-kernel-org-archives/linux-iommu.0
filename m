Return-Path: <SRS0=m4R2=22=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D35BC33C9A
	for <iommu@archiver.kernel.org>; Sun,  5 Jan 2020 10:52:28 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6344421775
	for <iommu@archiver.kernel.org>; Sun,  5 Jan 2020 10:52:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="Wt5c9fV2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6344421775
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 415C185CE2;
	Sun,  5 Jan 2020 10:52:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id iQbCPnakB7Ra; Sun,  5 Jan 2020 10:52:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id CA15C85CC7;
	Sun,  5 Jan 2020 10:52:27 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B7DBFC1D84;
	Sun,  5 Jan 2020 10:52:27 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 64FC5C0881
 for <iommu@lists.linux-foundation.org>; Sun,  5 Jan 2020 10:52:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 5DCDC85C9D
 for <iommu@lists.linux-foundation.org>; Sun,  5 Jan 2020 10:52:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 679mMsVT5wmI for <iommu@lists.linux-foundation.org>;
 Sun,  5 Jan 2020 10:52:27 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 96D8485C5E
 for <iommu@lists.linux-foundation.org>; Sun,  5 Jan 2020 10:52:26 +0000 (UTC)
X-UUID: 6aa44d3c98c74eeb9f0c1e78ab4293ac-20200105
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From;
 bh=3mbq9FpjSxSDLEY2w5X2s9Gfj1UKMBPHT8u/FwCDfyk=; 
 b=Wt5c9fV25mF/KFJFOc5ImE3zvuehaP/tlV0EzygatHO1BspQwiF2nPZbJLb6Fkf8yLHOT/A4f7ZL8m7Fc2SmEaFcli4OgBqE+G4dSPduxiVx99Hhvmcs6SLNoJhbKdtMiR339KQwiphmQWMBq5J7E3YWZKscjL8LllIn+4aqU2c=;
X-UUID: 6aa44d3c98c74eeb9f0c1e78ab4293ac-20200105
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by
 mailgw02.mediatek.com (envelope-from <chao.hao@mediatek.com>)
 (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
 with ESMTP id 1127711607; Sun, 05 Jan 2020 18:47:22 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Sun, 5 Jan 2020 18:46:54 +0800
Received: from localhost.localdomain (10.15.20.246) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Sun, 5 Jan 2020 18:45:52 +0800
From: Chao Hao <chao.hao@mediatek.com>
To: Joerg Roedel <joro@8bytes.org>, Rob Herring <robh+dt@kernel.org>, Matthias
 Brugger <matthias.bgg@gmail.com>
Subject: [PATCH v2 19/19] iommu/mediatek: Add multiple mtk_iommu_domain
 support for mt6779
Date: Sun, 5 Jan 2020 18:45:23 +0800
Message-ID: <20200105104523.31006-20-chao.hao@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20200105104523.31006-1-chao.hao@mediatek.com>
References: <20200105104523.31006-1-chao.hao@mediatek.com>
MIME-Version: 1.0
X-MTK: N
Cc: Anan Sun <anan.sun@mediatek.com>, devicetree@vger.kernel.org,
 Jun Yan <jun.yan@mediatek.com>, wsd_upstream@mediatek.com,
 linux-kernel@vger.kernel.org, Chao Hao <chao.hao@mediatek.com>,
 iommu@lists.linux-foundation.org, linux-mediatek@lists.infradead.org,
 Cui Zhang <zhang.cui@mediatek.com>, linux-arm-kernel@lists.infradead.org
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

For mt6779, it need to support three mtk_iommu_domains, every
mtk_iommu_domain's iova space is different.
Three mtk_iommu_domains is as below:
1. Normal mtk_iommu_domain exclude 0x4000_0000~0x47ff_ffff and
   0x7da0_0000~7fbf_ffff.
2. CCU mtk_iommu_domain include 0x4000_0000~0x47ff_ffff.
3. VPU mtk_iommu_domain 0x7da0_0000~0x7fbf_ffff.

Signed-off-by: Chao Hao <chao.hao@mediatek.com>
---
 drivers/iommu/mtk_iommu.c | 45 +++++++++++++++++++++++++++++++++++++--
 1 file changed, 43 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index ab09f435d437..d56254883541 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -134,6 +134,30 @@ const struct mtk_domain_data single_dom = {
 	.max_iova = DMA_BIT_MASK(32)
 };
 
+/*
+ * related file: mt6779-larb-port.h
+ */
+const struct mtk_domain_data mt6779_multi_dom[] = {
+	/* normal domain */
+	{
+	 .min_iova = 0x0,
+	 .max_iova = DMA_BIT_MASK(32),
+	},
+	/* ccu domain */
+	{
+	 .min_iova = 0x40000000,
+	 .max_iova = 0x48000000 - 1,
+	 .port_mask = {MTK_M4U_ID(9, 21), MTK_M4U_ID(9, 22),
+		       MTK_M4U_ID(12, 0), MTK_M4U_ID(12, 1)}
+	},
+	/* vpu domain */
+	{
+	 .min_iova = 0x7da00000,
+	 .max_iova = 0x7fc00000 - 1,
+	 .port_mask = {MTK_M4U_ID(13, 0)}
+	}
+};
+
 static struct mtk_iommu_pgtable *share_pgtable;
 static const struct iommu_ops mtk_iommu_ops;
 
@@ -1050,6 +1074,21 @@ static const struct dev_pm_ops mtk_iommu_pm_ops = {
 	SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(mtk_iommu_suspend, mtk_iommu_resume)
 };
 
+static const struct mtk_iommu_resv_iova_region mt6779_iommu_rsv_list[] = {
+	{
+		.dom_id = 0,
+		.iova_base = 0x40000000,	/* CCU */
+		.iova_size = 0x8000000,
+		.type = IOMMU_RESV_RESERVED,
+	},
+	{
+		.dom_id = 0,
+		.iova_base = 0x7da00000,	/* VPU/MDLA */
+		.iova_size = 0x2700000,
+		.type = IOMMU_RESV_RESERVED,
+	},
+};
+
 static const struct mtk_iommu_plat_data mt2712_data = {
 	.m4u_plat     = M4U_MT2712,
 	.has_4gb_mode = true,
@@ -1063,8 +1102,10 @@ static const struct mtk_iommu_plat_data mt2712_data = {
 
 static const struct mtk_iommu_plat_data mt6779_data = {
 	.m4u_plat = M4U_MT6779,
-	.dom_cnt = 1,
-	.dom_data = &single_dom,
+	.resv_cnt     = ARRAY_SIZE(mt6779_iommu_rsv_list),
+	.resv_region  = mt6779_iommu_rsv_list,
+	.dom_cnt = ARRAY_SIZE(mt6779_multi_dom),
+	.dom_data = mt6779_multi_dom,
 	.larbid_remap[0] = {0, 1, 2, 3, 5, 7, 10, 9},
 	/* vp6a, vp6b, mdla/core2, mdla/edmc*/
 	.larbid_remap[1] = {2, 0, 3, 1},
-- 
2.18.0
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
