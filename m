Return-Path: <SRS0=3/wr=6X=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3D86C47257
	for <iommu@archiver.kernel.org>; Sat,  9 May 2020 08:45:28 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 97EBB2495C
	for <iommu@archiver.kernel.org>; Sat,  9 May 2020 08:45:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="MRRXnXiF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97EBB2495C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 649CC22C1A;
	Sat,  9 May 2020 08:45:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0nNe-vSyp1Wo; Sat,  9 May 2020 08:45:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 6C4B322622;
	Sat,  9 May 2020 08:45:27 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 50211C0888;
	Sat,  9 May 2020 08:45:27 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1DB87C0888
 for <iommu@lists.linux-foundation.org>; Sat,  9 May 2020 08:45:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 07C4A88086
 for <iommu@lists.linux-foundation.org>; Sat,  9 May 2020 08:45:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ebrEGjiqeiPf for <iommu@lists.linux-foundation.org>;
 Sat,  9 May 2020 08:45:24 +0000 (UTC)
X-Greylist: delayed 00:05:07 by SQLgrey-1.7.6
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 by whitealder.osuosl.org (Postfix) with ESMTP id C8DE088116
 for <iommu@lists.linux-foundation.org>; Sat,  9 May 2020 08:45:23 +0000 (UTC)
X-UUID: 57a394ace62a4cacbe7dec24340acc29-20200509
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From;
 bh=nxNKFtFcVgXCGJ4BNQwJD0XYyDxH3mH6r9HcI8tiLlE=; 
 b=MRRXnXiFne5u4hG0nWXHIcudRfO+wupWcG7XMPe5fCbaeTSAkdGMWs9CiZQ244FRrkiJtMnbGEQynPH3Mxr6ZApWk4tR5TSGy8lm/vaNP9rCUgSTaetCKMzmH0x+GOxZ5zdZDcg1cbP+le3VkHmthaW6qrW2IWqTi+LPN56Svg4=;
X-UUID: 57a394ace62a4cacbe7dec24340acc29-20200509
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by
 mailgw02.mediatek.com (envelope-from <chao.hao@mediatek.com>)
 (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
 with ESMTP id 1637859311; Sat, 09 May 2020 16:40:19 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sat, 9 May 2020 16:40:17 +0800
Received: from localhost.localdomain (10.15.20.246) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sat, 9 May 2020 16:40:16 +0800
From: Chao Hao <chao.hao@mediatek.com>
To: Joerg Roedel <joro@8bytes.org>, Rob Herring <robh+dt@kernel.org>, Matthias
 Brugger <matthias.bgg@gmail.com>
Subject: [PATCH v3 6/7] iommu/mediatek: Add REG_MMU_WR_LEN definition
 preparing for mt6779
Date: Sat, 9 May 2020 16:36:53 +0800
Message-ID: <20200509083654.5178-7-chao.hao@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20200509083654.5178-1-chao.hao@mediatek.com>
References: <20200509083654.5178-1-chao.hao@mediatek.com>
MIME-Version: 1.0
X-MTK: N
Cc: devicetree@vger.kernel.org, FY Yang <fy.yang@mediatek.com>,
 wsd_upstream@mediatek.com, linux-kernel@vger.kernel.org,
 Chao Hao <chao.hao@mediatek.com>, iommu@lists.linux-foundation.org,
 linux-mediatek@lists.infradead.org, Jun Yan <jun.yan@mediatek.com>,
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

Some platforms(ex: mt6779) have a new register called by REG_MMU_WR_LEN
to improve performance.
This patch add this register definition.

Signed-off-by: Chao Hao <chao.hao@mediatek.com>
---
 drivers/iommu/mtk_iommu.c | 10 ++++++++++
 drivers/iommu/mtk_iommu.h |  2 ++
 2 files changed, 12 insertions(+)

diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index 3914c418d1b0..dc9ae944e712 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -45,6 +45,8 @@
 #define F_MMU_STANDARD_AXI_MODE_BIT		(BIT(3) | BIT(19))
 
 #define REG_MMU_DCM_DIS				0x050
+#define REG_MMU_WR_LEN				0x054
+#define F_MMU_WR_THROT_DIS_BIT			(BIT(5) |  BIT(21))
 
 #define REG_MMU_CTRL_REG			0x110
 #define F_MMU_TF_PROT_TO_PROGRAM_ADDR		(2 << 4)
@@ -592,6 +594,12 @@ static int mtk_iommu_hw_init(const struct mtk_iommu_data *data)
 		writel_relaxed(regval, data->base + REG_MMU_VLD_PA_RNG);
 	}
 	writel_relaxed(0, data->base + REG_MMU_DCM_DIS);
+	if (data->plat_data->has_wr_len) {
+		/* write command throttling mode */
+		regval = readl_relaxed(data->base + REG_MMU_WR_LEN);
+		regval &= ~F_MMU_WR_THROT_DIS_BIT;
+		writel_relaxed(regval, data->base + REG_MMU_WR_LEN);
+	}
 
 	if (data->plat_data->has_misc_ctrl) {
 		regval = readl_relaxed(data->base + REG_MMU_MISC_CTRL);
@@ -744,6 +752,7 @@ static int __maybe_unused mtk_iommu_suspend(struct device *dev)
 	struct mtk_iommu_suspend_reg *reg = &data->reg;
 	void __iomem *base = data->base;
 
+	reg->wr_len = readl_relaxed(base + REG_MMU_WR_LEN);
 	reg->misc_ctrl = readl_relaxed(base + REG_MMU_MISC_CTRL);
 	reg->dcm_dis = readl_relaxed(base + REG_MMU_DCM_DIS);
 	reg->ctrl_reg = readl_relaxed(base + REG_MMU_CTRL_REG);
@@ -768,6 +777,7 @@ static int __maybe_unused mtk_iommu_resume(struct device *dev)
 		dev_err(data->dev, "Failed to enable clk(%d) in resume\n", ret);
 		return ret;
 	}
+	writel_relaxed(reg->wr_len, base + REG_MMU_WR_LEN);
 	writel_relaxed(reg->misc_ctrl, base + REG_MMU_MISC_CTRL);
 	writel_relaxed(reg->dcm_dis, base + REG_MMU_DCM_DIS);
 	writel_relaxed(reg->ctrl_reg, base + REG_MMU_CTRL_REG);
diff --git a/drivers/iommu/mtk_iommu.h b/drivers/iommu/mtk_iommu.h
index d51ff99c2c71..9971cedd72ea 100644
--- a/drivers/iommu/mtk_iommu.h
+++ b/drivers/iommu/mtk_iommu.h
@@ -25,6 +25,7 @@ struct mtk_iommu_suspend_reg {
 	u32				int_main_control;
 	u32				ivrp_paddr;
 	u32				vld_pa_rng;
+	u32				wr_len;
 };
 
 enum mtk_iommu_plat {
@@ -43,6 +44,7 @@ struct mtk_iommu_plat_data {
 	bool		    has_misc_ctrl;
 	bool		    has_sub_comm;
 	bool                has_vld_pa_rng;
+	bool                has_wr_len;
 	bool                reset_axi;
 	u32                 inv_sel_reg;
 	unsigned char       larbid_remap[8][4];
-- 
2.18.0
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
