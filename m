Return-Path: <SRS0=eogA=LY=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62FC1C11F6A
	for <iommu@archiver.kernel.org>; Wed, 30 Jun 2021 02:38:01 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2FAD361D97
	for <iommu@archiver.kernel.org>; Wed, 30 Jun 2021 02:38:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FAD361D97
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 061804041F;
	Wed, 30 Jun 2021 02:38:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HN9y5n6QXg_h; Wed, 30 Jun 2021 02:38:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id DF40740178;
	Wed, 30 Jun 2021 02:37:59 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AED30C0010;
	Wed, 30 Jun 2021 02:37:59 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E9A32C000E
 for <iommu@lists.linux-foundation.org>; Wed, 30 Jun 2021 02:37:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E642F607EA
 for <iommu@lists.linux-foundation.org>; Wed, 30 Jun 2021 02:37:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id yXFduLozBlWA for <iommu@lists.linux-foundation.org>;
 Wed, 30 Jun 2021 02:37:58 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 by smtp3.osuosl.org (Postfix) with ESMTPS id EA26F60729
 for <iommu@lists.linux-foundation.org>; Wed, 30 Jun 2021 02:37:57 +0000 (UTC)
X-UUID: 4727b3d5ef924559995186802ca6e1e4-20210630
X-UUID: 4727b3d5ef924559995186802ca6e1e4-20210630
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw02.mediatek.com
 (envelope-from <yong.wu@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
 with ESMTP id 2113740949; Wed, 30 Jun 2021 10:37:55 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 30 Jun 2021 10:37:53 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 30 Jun 2021 10:37:52 +0800
From: Yong Wu <yong.wu@mediatek.com>
To: Joerg Roedel <joro@8bytes.org>, Rob Herring <robh+dt@kernel.org>, Matthias
 Brugger <matthias.bgg@gmail.com>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>
Subject: [PATCH 19/24] iommu/mediatek: Initialise bank HW for each a bank
Date: Wed, 30 Jun 2021 10:34:59 +0800
Message-ID: <20210630023504.18177-20-yong.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210630023504.18177-1-yong.wu@mediatek.com>
References: <20210630023504.18177-1-yong.wu@mediatek.com>
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

The mt8195 IOMMU HW max support 5 banks, and regarding the banks'
registers, it looks like:

 ----------------------------------------
 |bank0  | bank1 | bank2 | bank3 | bank4|
 ----------------------------------------
 |global |
 |control|         null
 |regs   |
 -----------------------------------------
 |bank   |bank   |bank   |bank   |bank   |
 |regs   |regs   |regs   |regs   |regs   |
 |       |       |       |       |       |
 -----------------------------------------

Each bank has some special bank registers and it share bank0's global
control registers. this patch initialise the bank hw with the bankid.

In the hw_init, we always initialise bank0's control register since
we don't know if the bank0 is initialised.

Additionally, About each bank's register base, always delta 0x1000.
like bank[x + 1] = bank[x] + 0x1000.

Signed-off-by: Yong Wu <yong.wu@mediatek.com>
---
 drivers/iommu/mtk_iommu.c | 28 +++++++++++++++++-----------
 1 file changed, 17 insertions(+), 11 deletions(-)

diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index 78c458bb8cc8..ed3cf75850ce 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -154,7 +154,7 @@ struct mtk_iommu_domain {
 
 static const struct iommu_ops mtk_iommu_ops;
 
-static int mtk_iommu_hw_init(const struct mtk_iommu_data *data);
+static int mtk_iommu_hw_init(const struct mtk_iommu_data *data, unsigned int bankid);
 
 #define MTK_IOMMU_TLB_ADDR(iova) ({					\
 	dma_addr_t _addr = iova;					\
@@ -523,12 +523,12 @@ static int mtk_iommu_attach_device(struct iommu_domain *domain,
 		dom->bank = bank;
 	}
 
-	if (!bank->m4u_dom) { /* Initialize the M4U HW */
+	if (!bank->m4u_dom) { /* Initialize the M4U HW for each a BANK */
 		ret = pm_runtime_resume_and_get(m4udev);
 		if (ret < 0)
 			return ret;
 
-		ret = mtk_iommu_hw_init(data);
+		ret = mtk_iommu_hw_init(data, bankid);
 		if (ret) {
 			pm_runtime_put(m4udev);
 			return ret;
@@ -737,11 +737,16 @@ static const struct iommu_ops mtk_iommu_ops = {
 	.owner		= THIS_MODULE,
 };
 
-static int mtk_iommu_hw_init(const struct mtk_iommu_data *data)
+static int mtk_iommu_hw_init(const struct mtk_iommu_data *data, unsigned int bankid)
 {
+	const struct mtk_iommu_bank_data *bankx = &data->bank[bankid];
 	const struct mtk_iommu_bank_data *bank0 = &data->bank[0];
 	u32 regval;
 
+	/*
+	 * global control setting is in bank0. May re-init these global registers
+	 * since no sure if there is bank0 consumers.
+	 */
 	if (data->plat_data->m4u_plat == M4U_MT8173) {
 		regval = F_MMU_PREFETCH_RT_REPLACE_MOD |
 			 F_MMU_TF_PROT_TO_PROGRAM_ADDR_MT8173;
@@ -784,13 +789,14 @@ static int mtk_iommu_hw_init(const struct mtk_iommu_data *data)
 	}
 	writel_relaxed(regval, bank0->base + REG_MMU_MISC_CTRL);
 
+	/* independent setting for each bank */
 	regval = F_L2_MULIT_HIT_EN |
 		F_TABLE_WALK_FAULT_INT_EN |
 		F_PREETCH_FIFO_OVERFLOW_INT_EN |
 		F_MISS_FIFO_OVERFLOW_INT_EN |
 		F_PREFETCH_FIFO_ERR_INT_EN |
 		F_MISS_FIFO_ERR_INT_EN;
-	writel_relaxed(regval, bank0->base + REG_MMU_INT_CONTROL0);
+	writel_relaxed(regval, bankx->base + REG_MMU_INT_CONTROL0);
 
 	regval = F_INT_TRANSLATION_FAULT |
 		F_INT_MAIN_MULTI_HIT_FAULT |
@@ -799,19 +805,19 @@ static int mtk_iommu_hw_init(const struct mtk_iommu_data *data)
 		F_INT_TLB_MISS_FAULT |
 		F_INT_MISS_TRANSACTION_FIFO_FAULT |
 		F_INT_PRETETCH_TRANSATION_FIFO_FAULT;
-	writel_relaxed(regval, bank0->base + REG_MMU_INT_MAIN_CONTROL);
+	writel_relaxed(regval, bankx->base + REG_MMU_INT_MAIN_CONTROL);
 
 	if (MTK_IOMMU_HAS_FLAG(data->plat_data, HAS_LEGACY_IVRP_PADDR))
 		regval = (data->protect_base >> 1) | (data->enable_4GB << 31);
 	else
 		regval = lower_32_bits(data->protect_base) |
 			 upper_32_bits(data->protect_base);
-	writel_relaxed(regval, bank0->base + REG_MMU_IVRP_PADDR);
+	writel_relaxed(regval, bankx->base + REG_MMU_IVRP_PADDR);
 
-	if (devm_request_irq(bank0->pdev, bank0->irq, mtk_iommu_isr, 0,
-			     dev_name(bank0->pdev), (void *)bank0)) {
-		writel_relaxed(0, bank0->base + REG_MMU_PT_BASE_ADDR);
-		dev_err(bank0->pdev, "Failed @ IRQ-%d Request\n", bank0->irq);
+	if (devm_request_irq(bankx->pdev, bankx->irq, mtk_iommu_isr, 0,
+			     dev_name(bankx->pdev), (void *)bankx)) {
+		writel_relaxed(0, bankx->base + REG_MMU_PT_BASE_ADDR);
+		dev_err(bankx->pdev, "Failed @ IRQ-%d Request\n", bankx->irq);
 		return -ENODEV;
 	}
 
-- 
2.18.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
