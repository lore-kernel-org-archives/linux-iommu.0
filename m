Return-Path: <SRS0=yzgR=76=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C32AC433E1
	for <iommu@archiver.kernel.org>; Wed, 17 Jun 2020 03:01:16 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 731F62082E
	for <iommu@archiver.kernel.org>; Wed, 17 Jun 2020 03:01:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="cmylI8IZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 731F62082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 51C5B897CB;
	Wed, 17 Jun 2020 03:01:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ju2TP0tNqwWh; Wed, 17 Jun 2020 03:01:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id B719A897AA;
	Wed, 17 Jun 2020 03:01:15 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A3D12C07FF;
	Wed, 17 Jun 2020 03:01:15 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BED8BC016E
 for <iommu@lists.linux-foundation.org>; Wed, 17 Jun 2020 03:01:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id B8FA4895F1
 for <iommu@lists.linux-foundation.org>; Wed, 17 Jun 2020 03:01:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4fqNK9ivEs63 for <iommu@lists.linux-foundation.org>;
 Wed, 17 Jun 2020 03:01:14 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mailgw01.mediatek.com (unknown [210.61.82.183])
 by whitealder.osuosl.org (Postfix) with ESMTP id BB97388227
 for <iommu@lists.linux-foundation.org>; Wed, 17 Jun 2020 03:01:13 +0000 (UTC)
X-UUID: e5c5e6dc3df24fdd8171ae3f73ba7612-20200617
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From;
 bh=tI5yYu408gV43UkHvfzp5IIwTJR94Q+9kyhZO32jWGI=; 
 b=cmylI8IZ+h6V+Q/CkqxqqtJ9jBXeB0LxMxJ7nXCCTckWgEF6Imla0p/lL8A0jeZjNL2DeVP9TUFQInhUaN/S7ZwxHwVFPFCcf/Y4x+28+r90w5piJV1M6ntc2U7dUUZy1F+fcFrhkYlU+nKIAQIP8XqSLMjUDwHr10A5aI2pI9s=;
X-UUID: e5c5e6dc3df24fdd8171ae3f73ba7612-20200617
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by
 mailgw01.mediatek.com (envelope-from <chao.hao@mediatek.com>)
 (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
 with ESMTP id 1378228981; Wed, 17 Jun 2020 11:01:11 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 17 Jun 2020 11:01:09 +0800
Received: from localhost.localdomain (10.15.20.246) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 17 Jun 2020 11:01:02 +0800
From: Chao Hao <chao.hao@mediatek.com>
To: Joerg Roedel <joro@8bytes.org>, Rob Herring <robh+dt@kernel.org>, Matthias
 Brugger <matthias.bgg@gmail.com>
Subject: [PATCH v4 5/7] iommu/mediatek: Add sub_comm id in translation fault
Date: Wed, 17 Jun 2020 11:00:27 +0800
Message-ID: <20200617030029.4082-6-chao.hao@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20200617030029.4082-1-chao.hao@mediatek.com>
References: <20200617030029.4082-1-chao.hao@mediatek.com>
MIME-Version: 1.0
X-MTK: N
Cc: devicetree@vger.kernel.org, FY Yang <fy.yang@mediatek.com>,
 wsd_upstream@mediatek.com, linux-kernel@vger.kernel.org,
 Chao Hao <chao.hao@mediatek.com>, iommu@lists.linux-foundation.org,
 linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org
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
From these two variable, we could get the real larb number when
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

In this patch we extern larb_remap[] to larb_remap[8][4] for this.
larb_remap[x][y]: x mean common-id above, y means subcommon_id above.

We can also distinguish if the M4U HW has sub_common by has_sub_comm
property.

Signed-off-by: Chao Hao <chao.hao@mediatek.com>
Reviewed-by: Yong Wu <yong.wu@mediatek.com>
---
 drivers/iommu/mtk_iommu.c | 20 +++++++++++++-------
 drivers/iommu/mtk_iommu.h |  3 ++-
 2 files changed, 15 insertions(+), 8 deletions(-)

diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index f23919feba4e..a687e8db0e51 100644
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
+	if (data->plat_data->has_sub_comm) {
+		fault_larb = F_MMU_INT_ID_COMM_ID(regval);
+		sub_comm = F_MMU_INT_ID_SUB_COMM_ID(regval);
+	} else {
+		fault_larb = F_MMU_INT_ID_LARB_ID(regval);
+	}
+	fault_larb = data->plat_data->larbid_remap[fault_larb][sub_comm];
 
 	if (report_iommu_fault(&dom->domain, data->dev, fault_iova,
 			       write ? IOMMU_FAULT_WRITE : IOMMU_FAULT_READ)) {
@@ -778,7 +784,7 @@ static const struct mtk_iommu_plat_data mt2712_data = {
 	.has_bclk       = true,
 	.has_vld_pa_rng = true,
 	.inv_sel_reg    = REG_MMU_INV_SEL_GEN1,
-	.larbid_remap   = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9},
+	.larbid_remap   = {{0}, {1}, {2}, {3}, {4}, {5}, {6}, {7}},
 };
 
 static const struct mtk_iommu_plat_data mt8173_data = {
@@ -787,14 +793,14 @@ static const struct mtk_iommu_plat_data mt8173_data = {
 	.has_bclk     = true,
 	.reset_axi    = true,
 	.inv_sel_reg  = REG_MMU_INV_SEL_GEN1,
-	.larbid_remap = {0, 1, 2, 3, 4, 5}, /* Linear mapping. */
+	.larbid_remap = {{0}, {1}, {2}, {3}, {4}, {5}}, /* Linear mapping. */
 };
 
 static const struct mtk_iommu_plat_data mt8183_data = {
 	.m4u_plat     = M4U_MT8183,
 	.reset_axi    = true,
 	.inv_sel_reg  = REG_MMU_INV_SEL_GEN1,
-	.larbid_remap = {0, 4, 5, 6, 7, 2, 3, 1},
+	.larbid_remap = {{0}, {4}, {5}, {6}, {7}, {2}, {3}, {1}},
 };
 
 static const struct of_device_id mtk_iommu_of_ids[] = {
diff --git a/drivers/iommu/mtk_iommu.h b/drivers/iommu/mtk_iommu.h
index afd7a2de5c1e..d51ff99c2c71 100644
--- a/drivers/iommu/mtk_iommu.h
+++ b/drivers/iommu/mtk_iommu.h
@@ -41,10 +41,11 @@ struct mtk_iommu_plat_data {
 	/* HW will use the EMI clock if there isn't the "bclk". */
 	bool                has_bclk;
 	bool		    has_misc_ctrl;
+	bool		    has_sub_comm;
 	bool                has_vld_pa_rng;
 	bool                reset_axi;
 	u32                 inv_sel_reg;
-	unsigned char       larbid_remap[MTK_LARB_NR_MAX];
+	unsigned char       larbid_remap[8][4];
 };
 
 struct mtk_iommu_domain;
-- 
2.18.0
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
