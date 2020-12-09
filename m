Return-Path: <SRS0=OQvg=FN=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2289C433FE
	for <iommu@archiver.kernel.org>; Wed,  9 Dec 2020 08:05:00 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A77C20773
	for <iommu@archiver.kernel.org>; Wed,  9 Dec 2020 08:05:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A77C20773
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 3E1D1864D0;
	Wed,  9 Dec 2020 08:05:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Ia_sSedFPd8Z; Wed,  9 Dec 2020 08:04:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id A40148648C;
	Wed,  9 Dec 2020 08:04:59 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8FB18C0FA7;
	Wed,  9 Dec 2020 08:04:59 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0616AC013B
 for <iommu@lists.linux-foundation.org>; Wed,  9 Dec 2020 08:04:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id E7B1D864BD
 for <iommu@lists.linux-foundation.org>; Wed,  9 Dec 2020 08:04:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id sckj_0mO_4tr for <iommu@lists.linux-foundation.org>;
 Wed,  9 Dec 2020 08:04:58 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mailgw01.mediatek.com (unknown [210.61.82.183])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 4826F8648C
 for <iommu@lists.linux-foundation.org>; Wed,  9 Dec 2020 08:04:58 +0000 (UTC)
X-UUID: 01ae33656fa4478d90bb7c0d2d2be4ef-20201209
X-UUID: 01ae33656fa4478d90bb7c0d2d2be4ef-20201209
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
 (envelope-from <yong.wu@mediatek.com>)
 (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2
 ECDHE-RSA-AES256-SHA384 256/256)
 with ESMTP id 1560250551; Wed, 09 Dec 2020 16:04:55 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 9 Dec 2020 16:04:53 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 9 Dec 2020 16:04:52 +0800
From: Yong Wu <yong.wu@mediatek.com>
To: Joerg Roedel <joro@8bytes.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
 Rob Herring <robh+dt@kernel.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>
Subject: [PATCH v5 23/27] iommu/mediatek: Support report iova 34bit
 translation fault in ISR
Date: Wed, 9 Dec 2020 16:00:58 +0800
Message-ID: <20201209080102.26626-24-yong.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20201209080102.26626-1-yong.wu@mediatek.com>
References: <20201209080102.26626-1-yong.wu@mediatek.com>
MIME-Version: 1.0
X-MTK: N
Cc: youlin.pei@mediatek.com, devicetree@vger.kernel.org,
 Nicolas Boichat <drinkcat@chromium.org>, srv_heupstream@mediatek.com,
 chao.hao@mediatek.com, linux-kernel@vger.kernel.org,
 Evan Green <evgreen@chromium.org>, Tomasz Figa <tfiga@google.com>,
 iommu@lists.linux-foundation.org, linux-mediatek@lists.infradead.org,
 Krzysztof Kozlowski <krzk@kernel.org>, anan.sun@mediatek.com,
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

If the iova is over 32bit, the fault status register bit is a little
different.

Signed-off-by: Yong Wu <yong.wu@mediatek.com>
---
 drivers/iommu/mtk_iommu.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index 164479e1f5c5..ed771133643d 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -3,6 +3,7 @@
  * Copyright (c) 2015-2016 MediaTek Inc.
  * Author: Yong Wu <yong.wu@mediatek.com>
  */
+#include <linux/bitfield.h>
 #include <linux/bug.h>
 #include <linux/clk.h>
 #include <linux/component.h>
@@ -89,6 +90,9 @@
 #define F_REG_MMU1_FAULT_MASK			GENMASK(13, 7)
 
 #define REG_MMU0_FAULT_VA			0x13c
+#define F_MMU_INVAL_VA_31_12_MASK		GENMASK(31, 12)
+#define F_MMU_INVAL_VA_34_32_MASK		GENMASK(11, 9)
+#define F_MMU_INVAL_PA_34_32_MASK		GENMASK(8, 6)
 #define F_MMU_FAULT_VA_WRITE_BIT		BIT(1)
 #define F_MMU_FAULT_VA_LAYER_BIT		BIT(0)
 
@@ -264,8 +268,9 @@ static irqreturn_t mtk_iommu_isr(int irq, void *dev_id)
 {
 	struct mtk_iommu_data *data = dev_id;
 	struct mtk_iommu_domain *dom = data->m4u_dom;
-	u32 int_state, regval, fault_iova, fault_pa;
 	unsigned int fault_larb, fault_port, sub_comm = 0;
+	u32 int_state, regval, va34_32, pa34_32;
+	u64 fault_iova, fault_pa;
 	bool layer, write;
 
 	/* Read error info from registers */
@@ -281,6 +286,14 @@ static irqreturn_t mtk_iommu_isr(int irq, void *dev_id)
 	}
 	layer = fault_iova & F_MMU_FAULT_VA_LAYER_BIT;
 	write = fault_iova & F_MMU_FAULT_VA_WRITE_BIT;
+	if (MTK_IOMMU_HAS_FLAG(data->plat_data, IOVA_34_EN)) {
+		va34_32 = FIELD_GET(F_MMU_INVAL_VA_34_32_MASK, fault_iova);
+		pa34_32 = FIELD_GET(F_MMU_INVAL_PA_34_32_MASK, fault_iova);
+		fault_iova = fault_iova & F_MMU_INVAL_VA_31_12_MASK;
+		fault_iova |=  (u64)va34_32 << 32;
+		fault_pa |= (u64)pa34_32 << 32;
+	}
+
 	fault_port = F_MMU_INT_ID_PORT_ID(regval);
 	if (MTK_IOMMU_HAS_FLAG(data->plat_data, HAS_SUB_COMM)) {
 		fault_larb = F_MMU_INT_ID_COMM_ID(regval);
@@ -294,7 +307,7 @@ static irqreturn_t mtk_iommu_isr(int irq, void *dev_id)
 			       write ? IOMMU_FAULT_WRITE : IOMMU_FAULT_READ)) {
 		dev_err_ratelimited(
 			data->dev,
-			"fault type=0x%x iova=0x%x pa=0x%x larb=%d port=%d layer=%d %s\n",
+			"fault type=0x%x iova=0x%llx pa=0x%llx larb=%d port=%d layer=%d %s\n",
 			int_state, fault_iova, fault_pa, fault_larb, fault_port,
 			layer, write ? "write" : "read");
 	}
-- 
2.18.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
