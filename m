Return-Path: <SRS0=mcPB=OE=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD030C433EF
	for <iommu@archiver.kernel.org>; Tue, 14 Sep 2021 11:38:18 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 76AE260FDA
	for <iommu@archiver.kernel.org>; Tue, 14 Sep 2021 11:38:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 76AE260FDA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 53EA5400DE;
	Tue, 14 Sep 2021 11:38:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZvPP4I4O_eEo; Tue, 14 Sep 2021 11:38:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id C8169400E4;
	Tue, 14 Sep 2021 11:38:16 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7A04DC0011;
	Tue, 14 Sep 2021 11:38:16 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AFE65C000D
 for <iommu@lists.linux-foundation.org>; Tue, 14 Sep 2021 11:38:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A026B80F30
 for <iommu@lists.linux-foundation.org>; Tue, 14 Sep 2021 11:38:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id dRITpqAogUDl for <iommu@lists.linux-foundation.org>;
 Tue, 14 Sep 2021 11:38:15 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 70B2880E27
 for <iommu@lists.linux-foundation.org>; Tue, 14 Sep 2021 11:38:14 +0000 (UTC)
X-UUID: d20806d33d304792b247e30a167888cd-20210914
X-UUID: d20806d33d304792b247e30a167888cd-20210914
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw01.mediatek.com
 (envelope-from <yong.wu@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
 with ESMTP id 343189939; Tue, 14 Sep 2021 19:38:11 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 14 Sep 2021 19:38:09 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 14 Sep 2021 19:38:08 +0800
From: Yong Wu <yong.wu@mediatek.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>, Rob Herring
 <robh+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>
Subject: [PATCH v4 05/13] memory: mtk-smi: Adjust some code position
Date: Tue, 14 Sep 2021 19:36:55 +0800
Message-ID: <20210914113703.31466-6-yong.wu@mediatek.com>
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

No functional change. Only move the code position to make the code more
readable.
1. Put the register smi-common above smi-larb. Prepare to add some others
   register setting.
2. Put mtk_smi_larb_unbind around larb_bind.
3. Sort the SoC data alphabetically. and put them in one line as the
   current kernel allow it.

Signed-off-by: Yong Wu <yong.wu@mediatek.com>
Reviewed-by: Ikjoon Jang <ikjn@chromium.org>
---
 drivers/memory/mtk-smi.c | 188 ++++++++++++++++-----------------------
 1 file changed, 75 insertions(+), 113 deletions(-)

diff --git a/drivers/memory/mtk-smi.c b/drivers/memory/mtk-smi.c
index 02a584dfb9b1..33b6c5efe102 100644
--- a/drivers/memory/mtk-smi.c
+++ b/drivers/memory/mtk-smi.c
@@ -17,13 +17,16 @@
 #include <dt-bindings/memory/mt2701-larb-port.h>
 #include <dt-bindings/memory/mtk-memory-port.h>
 
-/* mt8173 */
-#define SMI_LARB_MMU_EN		0xf00
+/* SMI COMMON */
+#define SMI_BUS_SEL			0x220
+#define SMI_BUS_LARB_SHIFT(larbid)	((larbid) << 1)
+/* All are MMU0 defaultly. Only specialize mmu1 here. */
+#define F_MMU1_LARB(larbid)		(0x1 << SMI_BUS_LARB_SHIFT(larbid))
 
-/* mt8167 */
-#define MT8167_SMI_LARB_MMU_EN	0xfc0
+/* SMI LARB */
 
-/* mt2701 */
+/* Below are about mmu enable registers, they are different in SoCs */
+/* gen1: mt2701 */
 #define REG_SMI_SECUR_CON_BASE		0x5c0
 
 /* every register control 8 port, register offset 0x4 */
@@ -41,20 +44,21 @@
 /* mt2701 domain should be set to 3 */
 #define SMI_SECUR_CON_VAL_DOMAIN(id)	(0x3 << ((((id) & 0x7) << 2) + 1))
 
-/* mt2712 */
-#define SMI_LARB_NONSEC_CON(id)	(0x380 + ((id) * 4))
-#define F_MMU_EN		BIT(0)
-#define BANK_SEL(id)		({			\
+/* gen2: */
+/* mt8167 */
+#define MT8167_SMI_LARB_MMU_EN		0xfc0
+
+/* mt8173 */
+#define MT8173_SMI_LARB_MMU_EN		0xf00
+
+/* general */
+#define SMI_LARB_NONSEC_CON(id)		(0x380 + ((id) * 4))
+#define F_MMU_EN			BIT(0)
+#define BANK_SEL(id)			({		\
 	u32 _id = (id) & 0x3;				\
 	(_id << 8 | _id << 10 | _id << 12 | _id << 14);	\
 })
 
-/* SMI COMMON */
-#define SMI_BUS_SEL			0x220
-#define SMI_BUS_LARB_SHIFT(larbid)	((larbid) << 1)
-/* All are MMU0 defaultly. Only specialize mmu1 here. */
-#define F_MMU1_LARB(larbid)		(0x1 << SMI_BUS_LARB_SHIFT(larbid))
-
 enum mtk_smi_type {
 	MTK_SMI_GEN1,
 	MTK_SMI_GEN2
@@ -140,36 +144,16 @@ mtk_smi_larb_bind(struct device *dev, struct device *master, void *data)
 	return -ENODEV;
 }
 
-static void mtk_smi_larb_config_port_gen2_general(struct device *dev)
-{
-	struct mtk_smi_larb *larb = dev_get_drvdata(dev);
-	u32 reg;
-	int i;
-
-	if (BIT(larb->larbid) & larb->larb_gen->larb_direct_to_common_mask)
-		return;
-
-	for_each_set_bit(i, (unsigned long *)larb->mmu, 32) {
-		reg = readl_relaxed(larb->base + SMI_LARB_NONSEC_CON(i));
-		reg |= F_MMU_EN;
-		reg |= BANK_SEL(larb->bank[i]);
-		writel(reg, larb->base + SMI_LARB_NONSEC_CON(i));
-	}
-}
-
-static void mtk_smi_larb_config_port_mt8173(struct device *dev)
+static void
+mtk_smi_larb_unbind(struct device *dev, struct device *master, void *data)
 {
-	struct mtk_smi_larb *larb = dev_get_drvdata(dev);
-
-	writel(*larb->mmu, larb->base + SMI_LARB_MMU_EN);
+	/* Do nothing as the iommu is always enabled. */
 }
 
-static void mtk_smi_larb_config_port_mt8167(struct device *dev)
-{
-	struct mtk_smi_larb *larb = dev_get_drvdata(dev);
-
-	writel(*larb->mmu, larb->base + MT8167_SMI_LARB_MMU_EN);
-}
+static const struct component_ops mtk_smi_larb_component_ops = {
+	.bind = mtk_smi_larb_bind,
+	.unbind = mtk_smi_larb_unbind,
+};
 
 static void mtk_smi_larb_config_port_gen1(struct device *dev)
 {
@@ -202,26 +186,36 @@ static void mtk_smi_larb_config_port_gen1(struct device *dev)
 	}
 }
 
-static void
-mtk_smi_larb_unbind(struct device *dev, struct device *master, void *data)
+static void mtk_smi_larb_config_port_mt8167(struct device *dev)
 {
-	/* Do nothing as the iommu is always enabled. */
+	struct mtk_smi_larb *larb = dev_get_drvdata(dev);
+
+	writel(*larb->mmu, larb->base + MT8167_SMI_LARB_MMU_EN);
 }
 
-static const struct component_ops mtk_smi_larb_component_ops = {
-	.bind = mtk_smi_larb_bind,
-	.unbind = mtk_smi_larb_unbind,
-};
+static void mtk_smi_larb_config_port_mt8173(struct device *dev)
+{
+	struct mtk_smi_larb *larb = dev_get_drvdata(dev);
 
-static const struct mtk_smi_larb_gen mtk_smi_larb_mt8173 = {
-	/* mt8173 do not need the port in larb */
-	.config_port = mtk_smi_larb_config_port_mt8173,
-};
+	writel(*larb->mmu, larb->base + MT8173_SMI_LARB_MMU_EN);
+}
 
-static const struct mtk_smi_larb_gen mtk_smi_larb_mt8167 = {
-	/* mt8167 do not need the port in larb */
-	.config_port = mtk_smi_larb_config_port_mt8167,
-};
+static void mtk_smi_larb_config_port_gen2_general(struct device *dev)
+{
+	struct mtk_smi_larb *larb = dev_get_drvdata(dev);
+	u32 reg;
+	int i;
+
+	if (BIT(larb->larbid) & larb->larb_gen->larb_direct_to_common_mask)
+		return;
+
+	for_each_set_bit(i, (unsigned long *)larb->mmu, 32) {
+		reg = readl_relaxed(larb->base + SMI_LARB_NONSEC_CON(i));
+		reg |= F_MMU_EN;
+		reg |= BANK_SEL(larb->bank[i]);
+		writel(reg, larb->base + SMI_LARB_NONSEC_CON(i));
+	}
+}
 
 static const struct mtk_smi_larb_gen mtk_smi_larb_mt2701 = {
 	.port_in_larb = {
@@ -243,6 +237,16 @@ static const struct mtk_smi_larb_gen mtk_smi_larb_mt6779 = {
 		/* DUMMY | IPU0 | IPU1 | CCU | MDLA */
 };
 
+static const struct mtk_smi_larb_gen mtk_smi_larb_mt8167 = {
+	/* mt8167 do not need the port in larb */
+	.config_port = mtk_smi_larb_config_port_mt8167,
+};
+
+static const struct mtk_smi_larb_gen mtk_smi_larb_mt8173 = {
+	/* mt8173 do not need the port in larb */
+	.config_port = mtk_smi_larb_config_port_mt8173,
+};
+
 static const struct mtk_smi_larb_gen mtk_smi_larb_mt8183 = {
 	.config_port                = mtk_smi_larb_config_port_gen2_general,
 	.larb_direct_to_common_mask = BIT(2) | BIT(3) | BIT(7),
@@ -254,34 +258,13 @@ static const struct mtk_smi_larb_gen mtk_smi_larb_mt8192 = {
 };
 
 static const struct of_device_id mtk_smi_larb_of_ids[] = {
-	{
-		.compatible = "mediatek,mt8167-smi-larb",
-		.data = &mtk_smi_larb_mt8167
-	},
-	{
-		.compatible = "mediatek,mt8173-smi-larb",
-		.data = &mtk_smi_larb_mt8173
-	},
-	{
-		.compatible = "mediatek,mt2701-smi-larb",
-		.data = &mtk_smi_larb_mt2701
-	},
-	{
-		.compatible = "mediatek,mt2712-smi-larb",
-		.data = &mtk_smi_larb_mt2712
-	},
-	{
-		.compatible = "mediatek,mt6779-smi-larb",
-		.data = &mtk_smi_larb_mt6779
-	},
-	{
-		.compatible = "mediatek,mt8183-smi-larb",
-		.data = &mtk_smi_larb_mt8183
-	},
-	{
-		.compatible = "mediatek,mt8192-smi-larb",
-		.data = &mtk_smi_larb_mt8192
-	},
+	{.compatible = "mediatek,mt2701-smi-larb", .data = &mtk_smi_larb_mt2701},
+	{.compatible = "mediatek,mt2712-smi-larb", .data = &mtk_smi_larb_mt2712},
+	{.compatible = "mediatek,mt6779-smi-larb", .data = &mtk_smi_larb_mt6779},
+	{.compatible = "mediatek,mt8167-smi-larb", .data = &mtk_smi_larb_mt8167},
+	{.compatible = "mediatek,mt8173-smi-larb", .data = &mtk_smi_larb_mt8173},
+	{.compatible = "mediatek,mt8183-smi-larb", .data = &mtk_smi_larb_mt8183},
+	{.compatible = "mediatek,mt8192-smi-larb", .data = &mtk_smi_larb_mt8192},
 	{}
 };
 
@@ -438,34 +421,13 @@ static const struct mtk_smi_common_plat mtk_smi_common_mt8192 = {
 };
 
 static const struct of_device_id mtk_smi_common_of_ids[] = {
-	{
-		.compatible = "mediatek,mt8173-smi-common",
-		.data = &mtk_smi_common_gen2,
-	},
-	{
-		.compatible = "mediatek,mt8167-smi-common",
-		.data = &mtk_smi_common_gen2,
-	},
-	{
-		.compatible = "mediatek,mt2701-smi-common",
-		.data = &mtk_smi_common_gen1,
-	},
-	{
-		.compatible = "mediatek,mt2712-smi-common",
-		.data = &mtk_smi_common_gen2,
-	},
-	{
-		.compatible = "mediatek,mt6779-smi-common",
-		.data = &mtk_smi_common_mt6779,
-	},
-	{
-		.compatible = "mediatek,mt8183-smi-common",
-		.data = &mtk_smi_common_mt8183,
-	},
-	{
-		.compatible = "mediatek,mt8192-smi-common",
-		.data = &mtk_smi_common_mt8192,
-	},
+	{.compatible = "mediatek,mt2701-smi-common", .data = &mtk_smi_common_gen1},
+	{.compatible = "mediatek,mt2712-smi-common", .data = &mtk_smi_common_gen2},
+	{.compatible = "mediatek,mt6779-smi-common", .data = &mtk_smi_common_mt6779},
+	{.compatible = "mediatek,mt8167-smi-common", .data = &mtk_smi_common_gen2},
+	{.compatible = "mediatek,mt8173-smi-common", .data = &mtk_smi_common_gen2},
+	{.compatible = "mediatek,mt8183-smi-common", .data = &mtk_smi_common_mt8183},
+	{.compatible = "mediatek,mt8192-smi-common", .data = &mtk_smi_common_mt8192},
 	{}
 };
 
-- 
2.18.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
