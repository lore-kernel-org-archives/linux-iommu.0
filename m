Return-Path: <SRS0=mcPB=OE=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37B93C433F5
	for <iommu@archiver.kernel.org>; Tue, 14 Sep 2021 11:38:10 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0834960F4A
	for <iommu@archiver.kernel.org>; Tue, 14 Sep 2021 11:38:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0834960F4A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id CD3C240141;
	Tue, 14 Sep 2021 11:38:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id q509IuDIsjMp; Tue, 14 Sep 2021 11:38:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 64A53400DE;
	Tue, 14 Sep 2021 11:38:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3739FC0011;
	Tue, 14 Sep 2021 11:38:08 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F2FEDC000D
 for <iommu@lists.linux-foundation.org>; Tue, 14 Sep 2021 11:38:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D63EC80F4B
 for <iommu@lists.linux-foundation.org>; Tue, 14 Sep 2021 11:38:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id uWmXHGVAjFD4 for <iommu@lists.linux-foundation.org>;
 Tue, 14 Sep 2021 11:38:05 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D9EDD80E27
 for <iommu@lists.linux-foundation.org>; Tue, 14 Sep 2021 11:38:04 +0000 (UTC)
X-UUID: 67fcfa19a4be4a7fbe83c25edfb1bb4f-20210914
X-UUID: 67fcfa19a4be4a7fbe83c25edfb1bb4f-20210914
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
 (envelope-from <yong.wu@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
 with ESMTP id 1967763731; Tue, 14 Sep 2021 19:38:02 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 14 Sep 2021 19:38:01 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 14 Sep 2021 19:38:00 +0800
From: Yong Wu <yong.wu@mediatek.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>, Rob Herring
 <robh+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>
Subject: [PATCH v4 04/13] memory: mtk-smi: Rename smi_gen to smi_type
Date: Tue, 14 Sep 2021 19:36:54 +0800
Message-ID: <20210914113703.31466-5-yong.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210914113703.31466-1-yong.wu@mediatek.com>
References: <20210914113703.31466-1-yong.wu@mediatek.com>
MIME-Version: 1.0
X-MTK: N
Cc: youlin.pei@mediatek.com, devicetree@vger.kernel.org, yi.kuo@mediatek.com,
 srv_heupstream@mediatek.com, Will Deacon <will@kernel.org>,
 linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>,
 iommu@lists.linux-foundation.org, linux-mediatek@lists.infradead.org,
 anthony.huang@mediatek.com, ming-fan.chen@mediatek.com, anan.sun@mediatek.com,
 Robin Murphy <robin.murphy@arm.com>, Ikjoon Jang <ikjn@chromium.org>,
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

Prepare for adding smi sub common. Only rename from smi_gen to smi_type.
No functional change.

About the current "smi_gen", we have gen1/gen2 that stand for the
generation number for HW. I plan to add a new type(sub_common), then the
name "gen" is not proper.

Signed-off-by: Yong Wu <yong.wu@mediatek.com>
Reviewed-by: Ikjoon Jang <ikjn@chromium.org>
---
 drivers/memory/mtk-smi.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/memory/mtk-smi.c b/drivers/memory/mtk-smi.c
index f91eaf5c3ab0..02a584dfb9b1 100644
--- a/drivers/memory/mtk-smi.c
+++ b/drivers/memory/mtk-smi.c
@@ -55,7 +55,7 @@
 /* All are MMU0 defaultly. Only specialize mmu1 here. */
 #define F_MMU1_LARB(larbid)		(0x1 << SMI_BUS_LARB_SHIFT(larbid))
 
-enum mtk_smi_gen {
+enum mtk_smi_type {
 	MTK_SMI_GEN1,
 	MTK_SMI_GEN2
 };
@@ -75,9 +75,9 @@ static const char * const mtk_smi_common_clks[] = {"apb", "smi", "gals0", "gals1
 #define MTK_SMI_COM_GALS_REQ_CLK_NR	MTK_SMI_CLK_NR_MAX
 
 struct mtk_smi_common_plat {
-	enum mtk_smi_gen gen;
-	bool             has_gals;
-	u32              bus_sel; /* Balance some larbs to enter mmu0 or mmu1 */
+	enum mtk_smi_type	type;
+	bool			has_gals;
+	u32			bus_sel; /* Balance some larbs to enter mmu0 or mmu1 */
 };
 
 struct mtk_smi_larb_gen {
@@ -409,29 +409,29 @@ static struct platform_driver mtk_smi_larb_driver = {
 };
 
 static const struct mtk_smi_common_plat mtk_smi_common_gen1 = {
-	.gen = MTK_SMI_GEN1,
+	.type     = MTK_SMI_GEN1,
 };
 
 static const struct mtk_smi_common_plat mtk_smi_common_gen2 = {
-	.gen = MTK_SMI_GEN2,
+	.type	  = MTK_SMI_GEN2,
 };
 
 static const struct mtk_smi_common_plat mtk_smi_common_mt6779 = {
-	.gen		= MTK_SMI_GEN2,
-	.has_gals	= true,
-	.bus_sel	= F_MMU1_LARB(1) | F_MMU1_LARB(2) | F_MMU1_LARB(4) |
-			  F_MMU1_LARB(5) | F_MMU1_LARB(6) | F_MMU1_LARB(7),
+	.type	  = MTK_SMI_GEN2,
+	.has_gals = true,
+	.bus_sel  = F_MMU1_LARB(1) | F_MMU1_LARB(2) | F_MMU1_LARB(4) |
+		    F_MMU1_LARB(5) | F_MMU1_LARB(6) | F_MMU1_LARB(7),
 };
 
 static const struct mtk_smi_common_plat mtk_smi_common_mt8183 = {
-	.gen      = MTK_SMI_GEN2,
+	.type     = MTK_SMI_GEN2,
 	.has_gals = true,
 	.bus_sel  = F_MMU1_LARB(1) | F_MMU1_LARB(2) | F_MMU1_LARB(5) |
 		    F_MMU1_LARB(7),
 };
 
 static const struct mtk_smi_common_plat mtk_smi_common_mt8192 = {
-	.gen      = MTK_SMI_GEN2,
+	.type     = MTK_SMI_GEN2,
 	.has_gals = true,
 	.bus_sel  = F_MMU1_LARB(1) | F_MMU1_LARB(2) | F_MMU1_LARB(5) |
 		    F_MMU1_LARB(6),
@@ -494,7 +494,7 @@ static int mtk_smi_common_probe(struct platform_device *pdev)
 	 * clock into emi clock domain, but for mtk smi gen2, there's no smi ao
 	 * base.
 	 */
-	if (common->plat->gen == MTK_SMI_GEN1) {
+	if (common->plat->type == MTK_SMI_GEN1) {
 		res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 		common->smi_ao_base = devm_ioremap_resource(dev, res);
 		if (IS_ERR(common->smi_ao_base))
@@ -534,7 +534,7 @@ static int __maybe_unused mtk_smi_common_resume(struct device *dev)
 	if (ret)
 		return ret;
 
-	if (common->plat->gen == MTK_SMI_GEN2 && bus_sel)
+	if (common->plat->type == MTK_SMI_GEN2 && bus_sel)
 		writel(bus_sel, common->base + SMI_BUS_SEL);
 	return 0;
 }
-- 
2.18.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
