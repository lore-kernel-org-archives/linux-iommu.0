Return-Path: <SRS0=qe9F=AK=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66504C433E1
	for <iommu@archiver.kernel.org>; Mon, 29 Jun 2020 07:14:29 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B5142332F
	for <iommu@archiver.kernel.org>; Mon, 29 Jun 2020 07:14:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="UYm5eizY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B5142332F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 2E63289369;
	Mon, 29 Jun 2020 07:14:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YY9GW2HTqE-6; Mon, 29 Jun 2020 07:14:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 8FC888934F;
	Mon, 29 Jun 2020 07:14:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 610FCC0895;
	Mon, 29 Jun 2020 07:14:28 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 19270C016E
 for <iommu@lists.linux-foundation.org>; Mon, 29 Jun 2020 07:14:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 0830888580
 for <iommu@lists.linux-foundation.org>; Mon, 29 Jun 2020 07:14:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hX8d3AAy43gd for <iommu@lists.linux-foundation.org>;
 Mon, 29 Jun 2020 07:14:26 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 by whitealder.osuosl.org (Postfix) with ESMTP id 001298865C
 for <iommu@lists.linux-foundation.org>; Mon, 29 Jun 2020 07:14:25 +0000 (UTC)
X-UUID: 1316d131a3db4849a73d6867dde3ad5d-20200629
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From;
 bh=rOIi5qu7Ra1P7e+zGHqBc8XsLXTZdTATO1zH6O+OUcE=; 
 b=UYm5eizYgSnuc79pKVUfJcRSs3Yb6nqv2O+cIF9j2xLaGr7+MhF2M7Semts+O0N9ey164DSdc7JHGr5d6fpLz68tpEg/7oQ39Z9h7NLoOVjZFYMBgW4IgabP5aCmSDvxRLu1fiFr2SyZ/EODFZBP0U0KKAJkFrMg0Dmr5riBLWA=;
X-UUID: 1316d131a3db4849a73d6867dde3ad5d-20200629
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
 (envelope-from <chao.hao@mediatek.com>)
 (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
 with ESMTP id 1341987100; Mon, 29 Jun 2020 15:14:23 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 29 Jun 2020 15:14:20 +0800
Received: from localhost.localdomain (10.15.20.246) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 29 Jun 2020 15:14:19 +0800
From: Chao Hao <chao.hao@mediatek.com>
To: Joerg Roedel <joro@8bytes.org>, Rob Herring <robh+dt@kernel.org>, Matthias
 Brugger <matthias.bgg@gmail.com>
Subject: [PATCH v5 06/10] iommu/mediatek: Add sub_comm id in translation fault
Date: Mon, 29 Jun 2020 15:13:06 +0800
Message-ID: <20200629071310.1557-7-chao.hao@mediatek.com>
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

The max larb number that a iommu HW support is 8(larb0~larb7 in the below
diagram).
If the larb's number is over 8, we use a sub_common for merging
several larbs into one larb. At this case, we will extend larb_id:
bit[11:9] means common-id;
bit[8:7] means subcommon-id;
From these two variables, we could get the real larb number when
translation fault happen.
The diagram is as below:
		 EMI
		  |
		IOMMU
		  |
           -----------------
	   |               |
	common1   	common0
	   |		   |
	   -----------------
		  |
             smi common
		  |
  ------------------------------------
  |       |       |       |     |    |
 3'd0    3'd1    3'd2    3'd3  ...  3'd7   <-common_id(max is 8)
  |       |       |       |     |    |
Larb0   Larb1     |     Larb3  ... Larb7
		  |
	    smi sub common
		  |
     --------------------------
     |        |       |       |
    2'd0     2'd1    2'd2    2'd3   <-sub_common_id(max is 4)
     |        |       |       |
   Larb8    Larb9   Larb10  Larb11

In this patch we extend larb_remap[] to larb_remap[8][4] for this.
larb_remap[x][y]: x means common-id above, y means subcommon_id above.

We can also distinguish if the M4U HW has sub_common by HAS_SUB_COMM
macro.

Cc: Matthias Brugger <matthias.bgg@gmail.com>
Signed-off-by: Chao Hao <chao.hao@mediatek.com>
Reviewed-by: Yong Wu <yong.wu@mediatek.com>
---
 drivers/iommu/mtk_iommu.c  | 20 +++++++++++++-------
 drivers/iommu/mtk_iommu.h  |  3 ++-
 include/soc/mediatek/smi.h |  2 ++
 3 files changed, 17 insertions(+), 8 deletions(-)

diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index 116418cc1cf8..ec1f86913739 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -91,6 +91,8 @@
 #define REG_MMU1_INVLD_PA			0x148
 #define REG_MMU0_INT_ID				0x150
 #define REG_MMU1_INT_ID				0x154
+#define F_MMU_INT_ID_COMM_ID(a)			(((a) >> 9) & 0x7)
+#define F_MMU_INT_ID_SUB_COMM_ID(a)		(((a) >> 7) & 0x3)
 #define F_MMU_INT_ID_LARB_ID(a)			(((a) >> 7) & 0x7)
 #define F_MMU_INT_ID_PORT_ID(a)			(((a) >> 2) & 0x1f)
 
@@ -229,7 +231,7 @@ static irqreturn_t mtk_iommu_isr(int irq, void *dev_id)
 	struct mtk_iommu_data *data = dev_id;
 	struct mtk_iommu_domain *dom = data->m4u_dom;
 	u32 int_state, regval, fault_iova, fault_pa;
-	unsigned int fault_larb, fault_port;
+	unsigned int fault_larb, fault_port, sub_comm = 0;
 	bool layer, write;
 
 	/* Read error info from registers */
@@ -245,10 +247,14 @@ static irqreturn_t mtk_iommu_isr(int irq, void *dev_id)
 	}
 	layer = fault_iova & F_MMU_FAULT_VA_LAYER_BIT;
 	write = fault_iova & F_MMU_FAULT_VA_WRITE_BIT;
-	fault_larb = F_MMU_INT_ID_LARB_ID(regval);
 	fault_port = F_MMU_INT_ID_PORT_ID(regval);
-
-	fault_larb = data->plat_data->larbid_remap[fault_larb];
+	if (MTK_IOMMU_HAS_FLAG(data->plat_data, HAS_SUB_COMM)) {
+		fault_larb = F_MMU_INT_ID_COMM_ID(regval);
+		sub_comm = F_MMU_INT_ID_SUB_COMM_ID(regval);
+	} else {
+		fault_larb = F_MMU_INT_ID_LARB_ID(regval);
+	}
+	fault_larb = data->plat_data->larbid_remap[fault_larb][sub_comm];
 
 	if (report_iommu_fault(&dom->domain, data->dev, fault_iova,
 			       write ? IOMMU_FAULT_WRITE : IOMMU_FAULT_READ)) {
@@ -778,7 +784,7 @@ static const struct mtk_iommu_plat_data mt2712_data = {
 			HAS_BCLK |
 			HAS_VLD_PA_RNG,
 	.inv_sel_reg  = REG_MMU_INV_SEL_GEN1,
-	.larbid_remap = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9},
+	.larbid_remap = {{0}, {1}, {2}, {3}, {4}, {5}, {6}, {7}},
 };
 
 static const struct mtk_iommu_plat_data mt8173_data = {
@@ -787,14 +793,14 @@ static const struct mtk_iommu_plat_data mt8173_data = {
 			HAS_BCLK |
 			RESET_AXI,
 	.inv_sel_reg  = REG_MMU_INV_SEL_GEN1,
-	.larbid_remap = {0, 1, 2, 3, 4, 5}, /* Linear mapping. */
+	.larbid_remap = {{0}, {1}, {2}, {3}, {4}, {5}}, /* Linear mapping. */
 };
 
 static const struct mtk_iommu_plat_data mt8183_data = {
 	.m4u_plat     = M4U_MT8183,
 	.flags        = RESET_AXI,
 	.inv_sel_reg  = REG_MMU_INV_SEL_GEN1,
-	.larbid_remap = {0, 4, 5, 6, 7, 2, 3, 1},
+	.larbid_remap = {{0}, {4}, {5}, {6}, {7}, {2}, {3}, {1}},
 };
 
 static const struct of_device_id mtk_iommu_of_ids[] = {
diff --git a/drivers/iommu/mtk_iommu.h b/drivers/iommu/mtk_iommu.h
index ae70296af2b4..be6d32ee5bda 100644
--- a/drivers/iommu/mtk_iommu.h
+++ b/drivers/iommu/mtk_iommu.h
@@ -23,6 +23,7 @@
 #define HAS_VLD_PA_RNG			BIT(2)
 #define RESET_AXI			BIT(3)
 #define OUT_ORDER_EN			BIT(4)
+#define HAS_SUB_COMM			BIT(5)
 
 #define MTK_IOMMU_HAS_FLAG(pdata, _x) \
 		((((pdata)->flags) & (_x)) == (_x))
@@ -48,7 +49,7 @@ struct mtk_iommu_plat_data {
 	enum mtk_iommu_plat m4u_plat;
 	u32                 flags;
 	u32                 inv_sel_reg;
-	unsigned char       larbid_remap[MTK_LARB_NR_MAX];
+	unsigned char       larbid_remap[MTK_LARB_COM_MAX][MTK_LARB_SUBCOM_MAX];
 };
 
 struct mtk_iommu_domain;
diff --git a/include/soc/mediatek/smi.h b/include/soc/mediatek/smi.h
index 5a34b87d89e3..fa65a55468e2 100644
--- a/include/soc/mediatek/smi.h
+++ b/include/soc/mediatek/smi.h
@@ -12,6 +12,8 @@
 #ifdef CONFIG_MTK_SMI
 
 #define MTK_LARB_NR_MAX		16
+#define MTK_LARB_COM_MAX	8
+#define MTK_LARB_SUBCOM_MAX	4
 
 #define MTK_SMI_MMU_EN(port)	BIT(port)
 
-- 
2.18.0
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
