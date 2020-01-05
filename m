Return-Path: <SRS0=m4R2=22=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D71BBC33C9A
	for <iommu@archiver.kernel.org>; Sun,  5 Jan 2020 10:47:00 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ACBC42465E
	for <iommu@archiver.kernel.org>; Sun,  5 Jan 2020 10:47:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="TApoU0iC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACBC42465E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 8529085B3C;
	Sun,  5 Jan 2020 10:47:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8sg3tUlNqJ1m; Sun,  5 Jan 2020 10:46:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id DDC1885A70;
	Sun,  5 Jan 2020 10:46:59 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CA2BBC1D84;
	Sun,  5 Jan 2020 10:46:59 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C1D17C0881
 for <iommu@lists.linux-foundation.org>; Sun,  5 Jan 2020 10:46:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id BC35685C90
 for <iommu@lists.linux-foundation.org>; Sun,  5 Jan 2020 10:46:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id UW0yu-UWojMJ for <iommu@lists.linux-foundation.org>;
 Sun,  5 Jan 2020 10:46:57 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mailgw01.mediatek.com (unknown [210.61.82.183])
 by whitealder.osuosl.org (Postfix) with ESMTP id CF02085209
 for <iommu@lists.linux-foundation.org>; Sun,  5 Jan 2020 10:46:56 +0000 (UTC)
X-UUID: 6eaec5b78ff743c7a5739bf46bdbf14d-20200105
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From;
 bh=i7uLllswA+30E+RlRxklVQ9qjW8u1U7i80NDkyo2BmA=; 
 b=TApoU0iCwDPxxO2bBTwOI46pa/3ERznmGwWAXFONM8AR1U4R3mFh0OX4JHiWguVH8LfO1NA1sF3Bi9HFVa6n9ANHVJcZiKewPhVQv1B8KrjMvh+zBwXsAnf4mL7OwHfQBHS+MVNnByPV6wSfQfKvMmBOt1uta7Fgterx2AF31tk=;
X-UUID: 6eaec5b78ff743c7a5739bf46bdbf14d-20200105
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by
 mailgw01.mediatek.com (envelope-from <chao.hao@mediatek.com>)
 (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
 with ESMTP id 508016898; Sun, 05 Jan 2020 18:46:55 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Sun, 5 Jan 2020 18:46:28 +0800
Received: from localhost.localdomain (10.15.20.246) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Sun, 5 Jan 2020 18:45:20 +0800
From: Chao Hao <chao.hao@mediatek.com>
To: Joerg Roedel <joro@8bytes.org>, Rob Herring <robh+dt@kernel.org>, Matthias
 Brugger <matthias.bgg@gmail.com>
Subject: [PATCH v2 08/19] iommu/mediatek: Add mt6779 basic support
Date: Sun, 5 Jan 2020 18:45:12 +0800
Message-ID: <20200105104523.31006-9-chao.hao@mediatek.com>
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

1. Add mt6779_data define to support mt6779 IOMMU HW init.
2. For mt6779, there are two IOMMUs, one is MM_IOMMU, the
other is VPU_IOMMU. MM_IOMMU is connected smi_larb to support
multimedia engine to access DRAM, and VPU_IOMMU is connected to
APU_bus to support VPU,MDLA,EDMA to access DRAM. MM_IOMMU and
VPU_IOMMU use the same page table to simplify design by
"mtk_iommu_get_m4u_data".
3. For smi_larb6, it doesn't use MM_IOMMU, so we can distinguish
VPU_IOMMU by it when excutes iommu_probe.
4. For mt6779 APU_IOMMU fault id is irregular, so it was treated specially.

Signed-off-by: Chao Hao <chao.hao@mediatek.com>
---
 drivers/iommu/mtk_iommu.c | 46 ++++++++++++++++++++++++++++++++++-----
 drivers/iommu/mtk_iommu.h |  2 ++
 2 files changed, 42 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index ad5690350d6a..7829d1fd08dd 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -43,7 +43,10 @@
 #define F_INVLD_EN1				BIT(1)
 
 #define REG_MMU_MISC_CTRL			0x048
+#define REG_MMU_STANDARD_AXI_MODE_MT6779	(BIT(3) | BIT(19))
+
 #define REG_MMU_DCM_DIS				0x050
+
 #define REG_MMU_WR_LEN				0x054
 #define F_MMU_WR_THROT_DIS			(BIT(5) |  BIT(21))
 
@@ -95,8 +98,10 @@
 #define F_MMU_INT_ID_SUB_COMM_ID(a)		(((a) >> 7) & 0x3)
 #define F_MMU_INT_ID_LARB_ID(a)			(((a) >> 7) & 0x7)
 #define F_MMU_INT_ID_PORT_ID(a)			(((a) >> 2) & 0x1f)
+#define F_MMU_INT_ID_COMM_APU_ID(a)		((a) & 0x3)
+#define F_MMU_INT_ID_SUB_APU_ID(a)		(((a) >> 2) & 0x3)
 
-#define MTK_PROTECT_PA_ALIGN			128
+#define MTK_PROTECT_PA_ALIGN			256
 
 /*
  * Get the local arbiter ID and the portid within the larb arbiter
@@ -249,8 +254,15 @@ static irqreturn_t mtk_iommu_isr(int irq, void *dev_id)
 	write = fault_iova & F_MMU_FAULT_VA_WRITE_BIT;
 	fault_port = F_MMU_INT_ID_PORT_ID(regval);
 	if (data->plat_data->has_sub_comm[data->m4u_id]) {
-		fault_larb = F_MMU_INT_ID_COMM_ID(regval);
-		sub_comm = F_MMU_INT_ID_SUB_COMM_ID(regval);
+		/* m4u1 is VPU in mt6779.*/
+		if (data->m4u_id && data->plat_data->m4u_plat == M4U_MT6779) {
+			fault_larb = F_MMU_INT_ID_COMM_APU_ID(regval);
+			sub_comm = F_MMU_INT_ID_SUB_APU_ID(regval);
+			fault_port = 0; /* for mt6779 APU ID is irregular */
+		} else {
+			fault_larb = F_MMU_INT_ID_COMM_ID(regval);
+			sub_comm = F_MMU_INT_ID_SUB_COMM_ID(regval);
+		}
 	} else {
 		fault_larb = F_MMU_INT_ID_LARB_ID(regval);
 	}
@@ -556,11 +568,12 @@ static int mtk_iommu_hw_init(const struct mtk_iommu_data *data)
 		return ret;
 	}
 
+	regval = readl_relaxed(data->base + REG_MMU_CTRL_REG);
 	if (data->plat_data->m4u_plat == M4U_MT8173)
-		regval = F_MMU_PREFETCH_RT_REPLACE_MOD |
+		regval |= F_MMU_PREFETCH_RT_REPLACE_MOD |
 			 F_MMU_TF_PROT_TO_PROGRAM_ADDR_MT8173;
 	else
-		regval = F_MMU_TF_PROT_TO_PROGRAM_ADDR;
+		regval |= F_MMU_TF_PROT_TO_PROGRAM_ADDR;
 	writel_relaxed(regval, data->base + REG_MMU_CTRL_REG);
 
 	regval = F_L2_MULIT_HIT_EN |
@@ -604,8 +617,16 @@ static int mtk_iommu_hw_init(const struct mtk_iommu_data *data)
 		writel_relaxed(regval, data->base + REG_MMU_WR_LEN);
 	}
 
-	if (data->plat_data->reset_axi)
+	if (data->plat_data->has_misc_ctrl[data->m4u_id]) {
+		/* special settings for mmu0 (multimedia iommu) */
+		regval = readl_relaxed(data->base + REG_MMU_MISC_CTRL);
+		/* non-standard AXI mode */
+		regval &= ~REG_MMU_STANDARD_AXI_MODE_MT6779;
+		writel_relaxed(regval, data->base + REG_MMU_MISC_CTRL);
+	} else if (data->plat_data->reset_axi) {
+		/*disable standard axi when it is REG_MMU_STANDARD_AXI_MODE */
 		writel_relaxed(0, data->base + REG_MMU_MISC_CTRL);
+	}
 
 	if (devm_request_irq(data->dev, data->irq, mtk_iommu_isr, 0,
 			     dev_name(data->dev), (void *)data)) {
@@ -806,6 +827,18 @@ static const struct mtk_iommu_plat_data mt2712_data = {
 	.inv_sel_reg = REG_MMU_INV_SEL,
 };
 
+static const struct mtk_iommu_plat_data mt6779_data = {
+	.m4u_plat = M4U_MT6779,
+	.larbid_remap[0] = {0, 1, 2, 3, 5, 7, 10, 9},
+	/* vp6a, vp6b, mdla/core2, mdla/edmc*/
+	.larbid_remap[1] = {2, 0, 3, 1},
+	.has_sub_comm = {true, true},
+	.has_wr_len = true,
+	.has_misc_ctrl = {true, false},
+	.inv_sel_reg = REG_MMU_INV_SEL_MT6779,
+	.m4u1_mask =  BIT(6),
+};
+
 static const struct mtk_iommu_plat_data mt8173_data = {
 	.m4u_plat     = M4U_MT8173,
 	.has_4gb_mode = true,
@@ -824,6 +857,7 @@ static const struct mtk_iommu_plat_data mt8183_data = {
 
 static const struct of_device_id mtk_iommu_of_ids[] = {
 	{ .compatible = "mediatek,mt2712-m4u", .data = &mt2712_data},
+	{ .compatible = "mediatek,mt6779-m4u", .data = &mt6779_data},
 	{ .compatible = "mediatek,mt8173-m4u", .data = &mt8173_data},
 	{ .compatible = "mediatek,mt8183-m4u", .data = &mt8183_data},
 	{}
diff --git a/drivers/iommu/mtk_iommu.h b/drivers/iommu/mtk_iommu.h
index 0623f199e96f..2b207dcadd06 100644
--- a/drivers/iommu/mtk_iommu.h
+++ b/drivers/iommu/mtk_iommu.h
@@ -31,6 +31,7 @@ struct mtk_iommu_suspend_reg {
 enum mtk_iommu_plat {
 	M4U_MT2701,
 	M4U_MT2712,
+	M4U_MT6779,
 	M4U_MT8173,
 	M4U_MT8183,
 };
@@ -45,6 +46,7 @@ struct mtk_iommu_plat_data {
 	bool                has_vld_pa_rng;
 	bool                reset_axi;
 	bool                has_wr_len;
+	bool                has_misc_ctrl[2];
 	u32                 m4u1_mask;
 	u32                 inv_sel_reg;
 	unsigned char       larbid_remap[2][MTK_LARB_NR_MAX];
-- 
2.18.0
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
