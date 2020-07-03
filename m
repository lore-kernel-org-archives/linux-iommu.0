Return-Path: <SRS0=r5As=AO=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 088C4C433EA
	for <iommu@archiver.kernel.org>; Fri,  3 Jul 2020 04:43:04 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D319F20760
	for <iommu@archiver.kernel.org>; Fri,  3 Jul 2020 04:43:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="CL+hVcQ6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D319F20760
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id C597E88B74;
	Fri,  3 Jul 2020 04:43:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id n0qhBoFePUSD; Fri,  3 Jul 2020 04:43:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 709EA88C9F;
	Fri,  3 Jul 2020 04:43:02 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 52EE4C08A2;
	Fri,  3 Jul 2020 04:43:02 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1EB62C0890
 for <iommu@lists.linux-foundation.org>; Fri,  3 Jul 2020 04:43:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 07C7B88C3D
 for <iommu@lists.linux-foundation.org>; Fri,  3 Jul 2020 04:43:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Q4RQ84MoSQgO for <iommu@lists.linux-foundation.org>;
 Fri,  3 Jul 2020 04:43:00 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 by whitealder.osuosl.org (Postfix) with ESMTP id 31B6288C34
 for <iommu@lists.linux-foundation.org>; Fri,  3 Jul 2020 04:43:00 +0000 (UTC)
X-UUID: c714dccfbcbc42028b2540368722e630-20200703
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From;
 bh=8qMmwM2uoxTxvPWDvQpY/SHOtQPS3rAHZGZciSo8HQ4=; 
 b=CL+hVcQ6FWtGawwo7GzH/XBsh4DqzR/8CG0msMyMgqzgfsaigX/DmMlA7WC9drZgCd8uvW/bokjV6pMjjg+Qe4TjxEBrjxmGcBOXl4JddDzNDkSMcBrE1bdayCJ77cnUlMF4nx3FDCMHEzu7fDRblmiZlX1exhb/xBsHe4nUlbo=;
X-UUID: c714dccfbcbc42028b2540368722e630-20200703
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
 (envelope-from <chao.hao@mediatek.com>)
 (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
 with ESMTP id 114306700; Fri, 03 Jul 2020 12:42:56 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 3 Jul 2020 12:42:44 +0800
Received: from localhost.localdomain (10.15.20.246) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 3 Jul 2020 12:42:40 +0800
From: Chao Hao <chao.hao@mediatek.com>
To: Joerg Roedel <joro@8bytes.org>, Rob Herring <robh+dt@kernel.org>,
 "Matthias Brugger" <matthias.bgg@gmail.com>
Subject: [PATCH v6 04/10] iommu/mediatek: Setting MISC_CTRL register
Date: Fri, 3 Jul 2020 12:41:21 +0800
Message-ID: <20200703044127.27438-5-chao.hao@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20200703044127.27438-1-chao.hao@mediatek.com>
References: <20200703044127.27438-1-chao.hao@mediatek.com>
MIME-Version: 1.0
X-TM-SNTS-SMTP: 62FC61D80859CCE8BC6DF8E8BC20DEFB1CFD8B2EDE2E84826E68BEC490F758B82000:8
X-MTK: N
Cc: devicetree@vger.kernel.org, FY Yang <fy.yang@mediatek.com>,
 wsd_upstream@mediatek.com, linux-kernel@vger.kernel.org,
 Chao Hao <chao.hao@mediatek.com>, iommu@lists.linux-foundation.org,
 TH Yang <th.yang@mediatek.com>, linux-mediatek@lists.infradead.org,
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

Add F_MMU_IN_ORDER_WR_EN_MASK and F_MMU_STANDARD_AXI_MODE_EN_MASK
definitions in MISC_CTRL register.
F_MMU_STANDARD_AXI_MODE_EN_MASK:
If we set F_MMU_STANDARD_AXI_MODE_EN_MASK (bit[3][19] = 0, not follow
standard AXI protocol), the iommu will priorize sending of urgent read
command over a normal read command. This improves the performance.
F_MMU_IN_ORDER_WR_EN_MASK:
If we set F_MMU_IN_ORDER_WR_EN_MASK (bit[1][17] = 0, out-of-order write),
the iommu will re-order write commands and send the write commands with
higher priority. Otherwise the sending of write commands will be done in
order. The feature is controlled by OUT_ORDER_WR_EN platform data flag.

Cc: Matthias Brugger <matthias.bgg@gmail.com>
Suggested-by: Yong Wu <yong.wu@mediatek.com>
Signed-off-by: Chao Hao <chao.hao@mediatek.com>
---
 drivers/iommu/mtk_iommu.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index 40ca564d97af..219d7aa6f059 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -42,6 +42,9 @@
 #define F_INVLD_EN1				BIT(1)
 
 #define REG_MMU_MISC_CTRL			0x048
+#define F_MMU_IN_ORDER_WR_EN_MASK		(BIT(1) | BIT(17))
+#define F_MMU_STANDARD_AXI_MODE_MASK		(BIT(3) | BIT(19))
+
 #define REG_MMU_DCM_DIS				0x050
 
 #define REG_MMU_CTRL_REG			0x110
@@ -105,6 +108,7 @@
 #define HAS_BCLK			BIT(1)
 #define HAS_VLD_PA_RNG			BIT(2)
 #define RESET_AXI			BIT(3)
+#define OUT_ORDER_WR_EN			BIT(4)
 
 #define MTK_IOMMU_HAS_FLAG(pdata, _x) \
 		((((pdata)->flags) & (_x)) == (_x))
@@ -585,8 +589,14 @@ static int mtk_iommu_hw_init(const struct mtk_iommu_data *data)
 
 	if (MTK_IOMMU_HAS_FLAG(data->plat_data, RESET_AXI)) {
 		/* The register is called STANDARD_AXI_MODE in this case */
-		writel_relaxed(0, data->base + REG_MMU_MISC_CTRL);
+		regval = 0;
+	} else {
+		regval = readl_relaxed(data->base + REG_MMU_MISC_CTRL);
+		regval &= ~F_MMU_STANDARD_AXI_MODE_MASK;
+		if (MTK_IOMMU_HAS_FLAG(data->plat_data, OUT_ORDER_WR_EN))
+			regval &= ~F_MMU_IN_ORDER_WR_EN_MASK;
 	}
+	writel_relaxed(regval, data->base + REG_MMU_MISC_CTRL);
 
 	if (devm_request_irq(data->dev, data->irq, mtk_iommu_isr, 0,
 			     dev_name(data->dev), (void *)data)) {
-- 
2.18.0
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
