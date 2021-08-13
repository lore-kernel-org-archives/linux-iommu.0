Return-Path: <SRS0=SLGw=NE=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84CC5C4320E
	for <iommu@archiver.kernel.org>; Fri, 13 Aug 2021 06:57:03 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D9F4610F7
	for <iommu@archiver.kernel.org>; Fri, 13 Aug 2021 06:57:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3D9F4610F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1DE2660B9E;
	Fri, 13 Aug 2021 06:57:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qpZeKk8Z3bi1; Fri, 13 Aug 2021 06:57:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id E1A3460B85;
	Fri, 13 Aug 2021 06:57:01 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CC272C0010;
	Fri, 13 Aug 2021 06:57:01 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 26E38C000E
 for <iommu@lists.linux-foundation.org>; Fri, 13 Aug 2021 06:57:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 09D22407B1
 for <iommu@lists.linux-foundation.org>; Fri, 13 Aug 2021 06:57:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id e4mCHg__bJ7c for <iommu@lists.linux-foundation.org>;
 Fri, 13 Aug 2021 06:57:00 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 18F79407B0
 for <iommu@lists.linux-foundation.org>; Fri, 13 Aug 2021 06:56:59 +0000 (UTC)
X-UUID: 05eab1bdb08342d196b17153cb4a9972-20210813
X-UUID: 05eab1bdb08342d196b17153cb4a9972-20210813
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by
 mailgw02.mediatek.com (envelope-from <yong.wu@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
 with ESMTP id 421471501; Fri, 13 Aug 2021 14:56:55 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 13 Aug 2021 14:56:54 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 13 Aug 2021 14:56:53 +0800
From: Yong Wu <yong.wu@mediatek.com>
To: Joerg Roedel <joro@8bytes.org>, Rob Herring <robh+dt@kernel.org>, Matthias
 Brugger <matthias.bgg@gmail.com>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>
Subject: [PATCH v2 24/29] iommu/mediatek: Add bank_nr and bank_enable
Date: Fri, 13 Aug 2021 14:53:19 +0800
Message-ID: <20210813065324.29220-25-yong.wu@mediatek.com>
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

Prepare for supporting multi banks, Adds two variables in the plat_data:
bank_nr: the bank number that this SoC support;
bank_enable: list if the banks is enabled.

Add them for all the current SoC, bank_nr always is 1 and only
bank_enable[0] is enabled.

Signed-off-by: Yong Wu <yong.wu@mediatek.com>
---
 drivers/iommu/mtk_iommu.c | 18 ++++++++++++++++++
 drivers/iommu/mtk_iommu.h |  3 +++
 2 files changed, 21 insertions(+)

diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index cd86151c5181..5b9891b2be6c 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -1137,6 +1137,8 @@ static const struct mtk_iommu_plat_data mt2712_data = {
 			NOT_STD_AXI_MODE | MTK_IOMMU_TYPE_MM,
 	.hw_list      = &m4ulist,
 	.inv_sel_reg  = REG_MMU_INV_SEL_GEN1,
+	.bank_nr      = 1,
+	.bank_enable  = {true},
 	.iova_region  = single_domain,
 	.iova_region_nr = ARRAY_SIZE(single_domain),
 	.larbid_remap = {{0}, {1}, {2}, {3}, {4}, {5}, {6}, {7}},
@@ -1147,6 +1149,8 @@ static const struct mtk_iommu_plat_data mt6779_data = {
 	.flags         = HAS_SUB_COMM_2BITS | OUT_ORDER_WR_EN | WR_THROT_EN |
 			 NOT_STD_AXI_MODE | MTK_IOMMU_TYPE_MM,
 	.inv_sel_reg   = REG_MMU_INV_SEL_GEN2,
+	.bank_nr       = 1,
+	.bank_enable   = {true},
 	.iova_region   = single_domain,
 	.iova_region_nr = ARRAY_SIZE(single_domain),
 	.larbid_remap  = {{0}, {1}, {2}, {3}, {5}, {7, 8}, {10}, {9}},
@@ -1157,6 +1161,8 @@ static const struct mtk_iommu_plat_data mt8167_data = {
 	.flags        = RESET_AXI | HAS_LEGACY_IVRP_PADDR | NOT_STD_AXI_MODE |
 			MTK_IOMMU_TYPE_MM,
 	.inv_sel_reg  = REG_MMU_INV_SEL_GEN1,
+	.bank_nr      = 1,
+	.bank_enable  = {true},
 	.iova_region  = single_domain,
 	.iova_region_nr = ARRAY_SIZE(single_domain),
 	.larbid_remap = {{0}, {1}, {2}}, /* Linear mapping. */
@@ -1168,6 +1174,8 @@ static const struct mtk_iommu_plat_data mt8173_data = {
 			HAS_LEGACY_IVRP_PADDR | NOT_STD_AXI_MODE |
 			MTK_IOMMU_TYPE_MM,
 	.inv_sel_reg  = REG_MMU_INV_SEL_GEN1,
+	.bank_nr      = 1,
+	.bank_enable  = {true},
 	.iova_region  = single_domain,
 	.iova_region_nr = ARRAY_SIZE(single_domain),
 	.larbid_remap = {{0}, {1}, {2}, {3}, {4}, {5}}, /* Linear mapping. */
@@ -1177,6 +1185,8 @@ static const struct mtk_iommu_plat_data mt8183_data = {
 	.m4u_plat     = M4U_MT8183,
 	.flags        = RESET_AXI | MTK_IOMMU_TYPE_MM,
 	.inv_sel_reg  = REG_MMU_INV_SEL_GEN1,
+	.bank_nr      = 1,
+	.bank_enable  = {true},
 	.iova_region  = single_domain,
 	.iova_region_nr = ARRAY_SIZE(single_domain),
 	.larbid_remap = {{0}, {4}, {5}, {6}, {7}, {2}, {3}, {1}},
@@ -1188,6 +1198,8 @@ static const struct mtk_iommu_plat_data mt8192_data = {
 			  WR_THROT_EN | IOVA_34_EN | NOT_STD_AXI_MODE |
 			  MTK_IOMMU_TYPE_MM,
 	.inv_sel_reg    = REG_MMU_INV_SEL_GEN2,
+	.bank_nr        = 1,
+	.bank_enable    = {true},
 	.iova_region    = mt8192_multi_dom,
 	.iova_region_nr = ARRAY_SIZE(mt8192_multi_dom),
 	.larbid_remap   = {{0}, {1}, {4, 5}, {7}, {2}, {9, 11, 19, 20},
@@ -1199,6 +1211,8 @@ static const struct mtk_iommu_plat_data mt8195_data_infra = {
 	.flags            = WR_THROT_EN | DCM_DISABLE |
 			    MTK_IOMMU_TYPE_INFRA | IFA_IOMMU_PCIe_SUPPORT,
 	.pericfg_comp_str = "mediatek,mt8195-pericfg_ao",
+	.bank_nr	  = 1,
+	.bank_enable      = {true},
 	.inv_sel_reg      = REG_MMU_INV_SEL_GEN2,
 	.iova_region      = single_domain,
 	.iova_region_nr   = ARRAY_SIZE(single_domain),
@@ -1211,6 +1225,8 @@ static const struct mtk_iommu_plat_data mt8195_data_vdo = {
 			  SHARE_PGTABLE | MTK_IOMMU_TYPE_MM,
 	.hw_list        = &m4ulist,
 	.inv_sel_reg    = REG_MMU_INV_SEL_GEN2,
+	.bank_nr	= 1,
+	.bank_enable    = {true},
 	.iova_region	= mt8192_multi_dom,
 	.iova_region_nr	= ARRAY_SIZE(mt8192_multi_dom),
 	.larbid_remap   = {{2, 0}, {21}, {24}, {7}, {19}, {9, 10, 11},
@@ -1224,6 +1240,8 @@ static const struct mtk_iommu_plat_data mt8195_data_vpp = {
 			  SHARE_PGTABLE | MTK_IOMMU_TYPE_MM,
 	.hw_list        = &m4ulist,
 	.inv_sel_reg    = REG_MMU_INV_SEL_GEN2,
+	.bank_nr	= 1,
+	.bank_enable    = {true},
 	.iova_region	= mt8192_multi_dom,
 	.iova_region_nr	= ARRAY_SIZE(mt8192_multi_dom),
 	.larbid_remap   = {{1}, {3}, {22, 0, 0, 0, 23}, {8},
diff --git a/drivers/iommu/mtk_iommu.h b/drivers/iommu/mtk_iommu.h
index 80dc08468eda..7a8d6a233d14 100644
--- a/drivers/iommu/mtk_iommu.h
+++ b/drivers/iommu/mtk_iommu.h
@@ -62,6 +62,9 @@ struct mtk_iommu_plat_data {
 	struct list_head			*hw_list;
 	unsigned int				iova_region_nr;
 	const struct mtk_iommu_iova_region	*iova_region;
+
+	unsigned int        bank_nr;
+	bool                bank_enable[MTK_IOMMU_BANK_MAX];
 	unsigned char       larbid_remap[MTK_LARB_COM_MAX][MTK_LARB_SUBCOM_MAX];
 };
 
-- 
2.18.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
