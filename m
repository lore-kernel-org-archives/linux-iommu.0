Return-Path: <SRS0=o4oj=NB=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9DFFC432BE
	for <iommu@archiver.kernel.org>; Tue, 10 Aug 2021 08:10:46 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 801E561058
	for <iommu@archiver.kernel.org>; Tue, 10 Aug 2021 08:10:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 801E561058
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 541AE83294;
	Tue, 10 Aug 2021 08:10:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qb0oAKR2fu0h; Tue, 10 Aug 2021 08:10:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 7028C83332;
	Tue, 10 Aug 2021 08:10:44 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 591ECC0010;
	Tue, 10 Aug 2021 08:10:44 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 386DDC000E
 for <iommu@lists.linux-foundation.org>; Tue, 10 Aug 2021 08:10:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 268C94044D
 for <iommu@lists.linux-foundation.org>; Tue, 10 Aug 2021 08:10:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id cjuv8sg-10bg for <iommu@lists.linux-foundation.org>;
 Tue, 10 Aug 2021 08:10:42 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E24E84044A
 for <iommu@lists.linux-foundation.org>; Tue, 10 Aug 2021 08:10:41 +0000 (UTC)
X-UUID: bf6325e6af4c431f9032edfe502280e3-20210810
X-UUID: bf6325e6af4c431f9032edfe502280e3-20210810
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by
 mailgw01.mediatek.com (envelope-from <yong.wu@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 1467757678; Tue, 10 Aug 2021 16:10:39 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 10 Aug 2021 16:10:37 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 10 Aug 2021 16:10:36 +0800
From: Yong Wu <yong.wu@mediatek.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>, Rob Herring
 <robh+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>
Subject: [PATCH v3 11/13] memory: mtk-smi: mt8195: Add initial setting for
 smi-common
Date: Tue, 10 Aug 2021 16:08:57 +0800
Message-ID: <20210810080859.29511-12-yong.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210810080859.29511-1-yong.wu@mediatek.com>
References: <20210810080859.29511-1-yong.wu@mediatek.com>
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

To improve the performance, add initial setting for smi-common.
some register use some fix setting(suggested from DE).

Signed-off-by: Yong Wu <yong.wu@mediatek.com>
---
 drivers/memory/mtk-smi.c | 42 ++++++++++++++++++++++++++++++++++++----
 1 file changed, 38 insertions(+), 4 deletions(-)

diff --git a/drivers/memory/mtk-smi.c b/drivers/memory/mtk-smi.c
index 35853ba980c9..689a45b39a65 100644
--- a/drivers/memory/mtk-smi.c
+++ b/drivers/memory/mtk-smi.c
@@ -18,11 +18,19 @@
 #include <dt-bindings/memory/mtk-memory-port.h>
 
 /* SMI COMMON */
+#define SMI_L1LEN			0x100
+
 #define SMI_BUS_SEL			0x220
 #define SMI_BUS_LARB_SHIFT(larbid)	((larbid) << 1)
 /* All are MMU0 defaultly. Only specialize mmu1 here. */
 #define F_MMU1_LARB(larbid)		(0x1 << SMI_BUS_LARB_SHIFT(larbid))
 
+#define SMI_M4U_TH			0x234
+#define SMI_FIFO_TH1			0x238
+#define SMI_FIFO_TH2			0x23c
+#define SMI_DCM				0x300
+#define SMI_DUMMY			0x444
+
 /* SMI LARB */
 
 /* Below are about mmu enable registers, they are different in SoCs */
@@ -59,6 +67,13 @@
 	(_id << 8 | _id << 10 | _id << 12 | _id << 14);	\
 })
 
+#define SMI_COMMON_INIT_REGS_NR		6
+
+struct mtk_smi_reg_pair {
+	unsigned int		offset;
+	u32			value;
+};
+
 enum mtk_smi_type {
 	MTK_SMI_GEN1,
 	MTK_SMI_GEN2,		/* gen2 smi common */
@@ -85,6 +100,8 @@ struct mtk_smi_common_plat {
 	enum mtk_smi_type	type;
 	bool			has_gals;
 	u32			bus_sel; /* Balance some larbs to enter mmu0 or mmu1 */
+
+	const struct mtk_smi_reg_pair	*init;
 };
 
 struct mtk_smi_larb_gen {
@@ -419,6 +436,15 @@ static struct platform_driver mtk_smi_larb_driver = {
 	}
 };
 
+static const struct mtk_smi_reg_pair mtk_smi_common_mt8195_init[SMI_COMMON_INIT_REGS_NR] = {
+	{SMI_L1LEN, 0xb},
+	{SMI_M4U_TH, 0xe100e10},
+	{SMI_FIFO_TH1, 0x506090a},
+	{SMI_FIFO_TH2, 0x506090a},
+	{SMI_DCM, 0x4f1},
+	{SMI_DUMMY, 0x1},
+};
+
 static const struct mtk_smi_common_plat mtk_smi_common_gen1 = {
 	.type     = MTK_SMI_GEN1,
 };
@@ -453,12 +479,14 @@ static const struct mtk_smi_common_plat mtk_smi_common_mt8195_vdo = {
 	.has_gals = true,
 	.bus_sel  = F_MMU1_LARB(1) | F_MMU1_LARB(3) | F_MMU1_LARB(5) |
 		    F_MMU1_LARB(7),
+	.init     = mtk_smi_common_mt8195_init,
 };
 
 static const struct mtk_smi_common_plat mtk_smi_common_mt8195_vpp = {
 	.type     = MTK_SMI_GEN2,
 	.has_gals = true,
 	.bus_sel  = F_MMU1_LARB(1) | F_MMU1_LARB(2) | F_MMU1_LARB(7),
+	.init     = mtk_smi_common_mt8195_init,
 };
 
 static const struct mtk_smi_common_plat mtk_smi_sub_common_mt8195 = {
@@ -551,15 +579,21 @@ static int mtk_smi_common_remove(struct platform_device *pdev)
 static int __maybe_unused mtk_smi_common_resume(struct device *dev)
 {
 	struct mtk_smi *common = dev_get_drvdata(dev);
-	u32 bus_sel = common->plat->bus_sel;
-	int ret;
+	const struct mtk_smi_reg_pair *init = common->plat->init;
+	u32 bus_sel = common->plat->bus_sel; /* default is 0 */
+	int ret, i;
 
 	ret = clk_bulk_prepare_enable(common->clk_num, common->clks);
 	if (ret)
 		return ret;
 
-	if (common->plat->type == MTK_SMI_GEN2 && bus_sel)
-		writel(bus_sel, common->base + SMI_BUS_SEL);
+	if (common->plat->type != MTK_SMI_GEN2)
+		return 0;
+
+	for (i = 0; i < SMI_COMMON_INIT_REGS_NR && init && init[i].offset; i++)
+		writel_relaxed(init[i].value, common->base + init[i].offset);
+
+	writel(bus_sel, common->base + SMI_BUS_SEL);
 	return 0;
 }
 
-- 
2.18.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
