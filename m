Return-Path: <SRS0=eogA=LY=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A69EC11F67
	for <iommu@archiver.kernel.org>; Wed, 30 Jun 2021 02:37:38 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC46061D81
	for <iommu@archiver.kernel.org>; Wed, 30 Jun 2021 02:37:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC46061D81
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 850E440600;
	Wed, 30 Jun 2021 02:37:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id W5fROKrIhRhQ; Wed, 30 Jun 2021 02:37:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 5789540607;
	Wed, 30 Jun 2021 02:37:35 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 14B24C0010;
	Wed, 30 Jun 2021 02:37:35 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 16B93C000E
 for <iommu@lists.linux-foundation.org>; Wed, 30 Jun 2021 02:37:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 12FE560894
 for <iommu@lists.linux-foundation.org>; Wed, 30 Jun 2021 02:37:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id SYvD_6B4o6Uw for <iommu@lists.linux-foundation.org>;
 Wed, 30 Jun 2021 02:37:31 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 0C516608AC
 for <iommu@lists.linux-foundation.org>; Wed, 30 Jun 2021 02:37:30 +0000 (UTC)
X-UUID: 7edf48f8388540f287a4eb1c734c49f2-20210630
X-UUID: 7edf48f8388540f287a4eb1c734c49f2-20210630
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw02.mediatek.com
 (envelope-from <yong.wu@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
 with ESMTP id 852163939; Wed, 30 Jun 2021 10:37:26 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 30 Jun 2021 10:37:25 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 30 Jun 2021 10:37:24 +0800
From: Yong Wu <yong.wu@mediatek.com>
To: Joerg Roedel <joro@8bytes.org>, Rob Herring <robh+dt@kernel.org>, Matthias
 Brugger <matthias.bgg@gmail.com>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>
Subject: [PATCH 16/24] iommu/mediatek: Only adjust code about register base
Date: Wed, 30 Jun 2021 10:34:56 +0800
Message-ID: <20210630023504.18177-17-yong.wu@mediatek.com>
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

This patch have no functional change. Use "base" instead of the
data->base. This is avoid to touch too many lines in the next patches.

Signed-off-by: Yong Wu <yong.wu@mediatek.com>
---
 drivers/iommu/mtk_iommu.c | 43 ++++++++++++++++++++-------------------
 1 file changed, 22 insertions(+), 21 deletions(-)

diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index 5e046587eef4..1072a10e36ce 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -240,6 +240,7 @@ static void mtk_iommu_tlb_flush_range_sync(unsigned long iova, size_t size,
 {
 	struct list_head *head = data->hw_list;
 	bool has_pm = !!data->dev->pm_domain;
+	void __iomem *base = data->base;
 	unsigned long flags;
 	int ret;
 	u32 tmp;
@@ -252,17 +253,15 @@ static void mtk_iommu_tlb_flush_range_sync(unsigned long iova, size_t size,
 
 		spin_lock_irqsave(&data->tlb_lock, flags);
 		writel_relaxed(F_INVLD_EN1 | F_INVLD_EN0,
-			       data->base + data->plat_data->inv_sel_reg);
+			       base + data->plat_data->inv_sel_reg);
 
-		writel_relaxed(MTK_IOMMU_TLB_ADDR(iova),
-			       data->base + REG_MMU_INVLD_START_A);
+		writel_relaxed(MTK_IOMMU_TLB_ADDR(iova), base + REG_MMU_INVLD_START_A);
 		writel_relaxed(MTK_IOMMU_TLB_ADDR(iova + size - 1),
-			       data->base + REG_MMU_INVLD_END_A);
-		writel_relaxed(F_MMU_INV_RANGE,
-			       data->base + REG_MMU_INVALIDATE);
+			       base + REG_MMU_INVLD_END_A);
+		writel_relaxed(F_MMU_INV_RANGE, base + REG_MMU_INVALIDATE);
 
 		/* tlb sync */
-		ret = readl_poll_timeout_atomic(data->base + REG_MMU_CPE_DONE,
+		ret = readl_poll_timeout_atomic(base + REG_MMU_CPE_DONE,
 						tmp, tmp != 0, 10, 1000);
 		if (ret) {
 			dev_warn(data->dev,
@@ -270,7 +269,7 @@ static void mtk_iommu_tlb_flush_range_sync(unsigned long iova, size_t size,
 			mtk_iommu_tlb_flush_all(data);
 		}
 		/* Clear the CPE status */
-		writel_relaxed(0, data->base + REG_MMU_CPE_DONE);
+		writel_relaxed(0, base + REG_MMU_CPE_DONE);
 		spin_unlock_irqrestore(&data->tlb_lock, flags);
 
 		if (has_pm)
@@ -284,23 +283,25 @@ static irqreturn_t mtk_iommu_isr(int irq, void *dev_id)
 	struct mtk_iommu_domain *dom = data->m4u_dom;
 	unsigned int fault_larb = 0, fault_port = 0, sub_comm = 0;
 	u32 int_state, regval, va34_32, pa34_32;
+	const struct mtk_iommu_plat_data *plat_data = data->plat_data;
+	void __iomem *base = data->base;
 	u64 fault_iova, fault_pa;
 	bool layer, write;
 
 	/* Read error info from registers */
-	int_state = readl_relaxed(data->base + REG_MMU_FAULT_ST1);
+	int_state = readl_relaxed(base + REG_MMU_FAULT_ST1);
 	if (int_state & F_REG_MMU0_FAULT_MASK) {
-		regval = readl_relaxed(data->base + REG_MMU0_INT_ID);
-		fault_iova = readl_relaxed(data->base + REG_MMU0_FAULT_VA);
-		fault_pa = readl_relaxed(data->base + REG_MMU0_INVLD_PA);
+		regval = readl_relaxed(base + REG_MMU0_INT_ID);
+		fault_iova = readl_relaxed(base + REG_MMU0_FAULT_VA);
+		fault_pa = readl_relaxed(base + REG_MMU0_INVLD_PA);
 	} else {
-		regval = readl_relaxed(data->base + REG_MMU1_INT_ID);
-		fault_iova = readl_relaxed(data->base + REG_MMU1_FAULT_VA);
-		fault_pa = readl_relaxed(data->base + REG_MMU1_INVLD_PA);
+		regval = readl_relaxed(base + REG_MMU1_INT_ID);
+		fault_iova = readl_relaxed(base + REG_MMU1_FAULT_VA);
+		fault_pa = readl_relaxed(base + REG_MMU1_INVLD_PA);
 	}
 	layer = fault_iova & F_MMU_FAULT_VA_LAYER_BIT;
 	write = fault_iova & F_MMU_FAULT_VA_WRITE_BIT;
-	if (MTK_IOMMU_HAS_FLAG(data->plat_data, IOVA_34_EN)) {
+	if (MTK_IOMMU_HAS_FLAG(plat_data, IOVA_34_EN)) {
 		va34_32 = FIELD_GET(F_MMU_INVAL_VA_34_32_MASK, fault_iova);
 		fault_iova = fault_iova & F_MMU_INVAL_VA_31_12_MASK;
 		fault_iova |= (u64)va34_32 << 32;
@@ -308,12 +309,12 @@ static irqreturn_t mtk_iommu_isr(int irq, void *dev_id)
 	pa34_32 = FIELD_GET(F_MMU_INVAL_PA_34_32_MASK, fault_iova);
 	fault_pa |= (u64)pa34_32 << 32;
 
-	if (MTK_IOMMU_IS_TYPE(data->plat_data, MTK_IOMMU_TYPE_MM)) {
+	if (MTK_IOMMU_IS_TYPE(plat_data, MTK_IOMMU_TYPE_MM)) {
 		fault_port = F_MMU_INT_ID_PORT_ID(regval);
-		if (MTK_IOMMU_HAS_FLAG(data->plat_data, HAS_SUB_COMM_2BITS)) {
+		if (MTK_IOMMU_HAS_FLAG(plat_data, HAS_SUB_COMM_2BITS)) {
 			fault_larb = F_MMU_INT_ID_COMM_ID(regval);
 			sub_comm = F_MMU_INT_ID_SUB_COMM_ID(regval);
-		} else if (MTK_IOMMU_HAS_FLAG(data->plat_data, HAS_SUB_COMM_3BITS)) {
+		} else if (MTK_IOMMU_HAS_FLAG(plat_data, HAS_SUB_COMM_3BITS)) {
 			fault_larb = F_MMU_INT_ID_COMM_ID_EXT(regval);
 			sub_comm = F_MMU_INT_ID_SUB_COMM_ID_EXT(regval);
 		} else {
@@ -332,9 +333,9 @@ static irqreturn_t mtk_iommu_isr(int irq, void *dev_id)
 	}
 
 	/* Interrupt clear */
-	regval = readl_relaxed(data->base + REG_MMU_INT_CONTROL0);
+	regval = readl_relaxed(base + REG_MMU_INT_CONTROL0);
 	regval |= F_INT_CLR_BIT;
-	writel_relaxed(regval, data->base + REG_MMU_INT_CONTROL0);
+	writel_relaxed(regval, base + REG_MMU_INT_CONTROL0);
 
 	mtk_iommu_tlb_flush_all(data);
 
-- 
2.18.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
