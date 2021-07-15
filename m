Return-Path: <SRS0=9Lhb=MH=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE989C07E96
	for <iommu@archiver.kernel.org>; Thu, 15 Jul 2021 12:14:01 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F30661374
	for <iommu@archiver.kernel.org>; Thu, 15 Jul 2021 12:14:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F30661374
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 70F5040682;
	Thu, 15 Jul 2021 12:14:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fZRmpv-p7qRX; Thu, 15 Jul 2021 12:14:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 56645402AB;
	Thu, 15 Jul 2021 12:14:00 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 33D9AC0010;
	Thu, 15 Jul 2021 12:14:00 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2B4EBC000E
 for <iommu@lists.linux-foundation.org>; Thu, 15 Jul 2021 12:13:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 0BE24404A7
 for <iommu@lists.linux-foundation.org>; Thu, 15 Jul 2021 12:13:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YvC498frEwM3 for <iommu@lists.linux-foundation.org>;
 Thu, 15 Jul 2021 12:13:58 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 by smtp4.osuosl.org (Postfix) with ESMTPS id AEAE7403A3
 for <iommu@lists.linux-foundation.org>; Thu, 15 Jul 2021 12:13:57 +0000 (UTC)
X-UUID: 58a79c52eb5f4346a71e5ab3a1e32b67-20210715
X-UUID: 58a79c52eb5f4346a71e5ab3a1e32b67-20210715
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
 (envelope-from <yong.wu@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
 with ESMTP id 1064677084; Thu, 15 Jul 2021 20:13:53 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs06n1.mediatek.inc (172.21.101.129) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 15 Jul 2021 20:13:51 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 15 Jul 2021 20:13:50 +0800
From: Yong Wu <yong.wu@mediatek.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>, Rob Herring
 <robh+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>
Subject: [PATCH v2 11/11] memory: mtk-smi: mt8195: Add initial setting for
 smi-larb
Date: Thu, 15 Jul 2021 20:12:09 +0800
Message-ID: <20210715121209.31024-12-yong.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210715121209.31024-1-yong.wu@mediatek.com>
References: <20210715121209.31024-1-yong.wu@mediatek.com>
MIME-Version: 1.0
X-MTK: N
Cc: youlin.pei@mediatek.com, devicetree@vger.kernel.org, yi.kuo@mediatek.com,
 srv_heupstream@mediatek.com, Will Deacon <will@kernel.org>,
 linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>,
 iommu@lists.linux-foundation.org, linux-mediatek@lists.infradead.org,
 anthony.huang@mediatek.com, ming-fan.chen@mediatek.com, anan.sun@mediatek.com,
 Robin Murphy <robin.murphy@arm.com>, linux-arm-kernel@lists.infradead.org
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

To improve the performance, We add some initial setting for smi larbs.
there are two part:
1), Each port has the special ostd(outstanding) value in each larb.
2), Two general setting for each larb.

In some SoC, this setting maybe changed dynamically for some special case
like 4K, and this initial setting is enough in mt8195.

Signed-off-by: Yong Wu <yong.wu@mediatek.com>
---
 drivers/memory/mtk-smi.c | 74 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 73 insertions(+), 1 deletion(-)

diff --git a/drivers/memory/mtk-smi.c b/drivers/memory/mtk-smi.c
index c52bf02458ff..1d9e67520433 100644
--- a/drivers/memory/mtk-smi.c
+++ b/drivers/memory/mtk-smi.c
@@ -32,6 +32,14 @@
 #define SMI_DUMMY			0x444
 
 /* SMI LARB */
+#define SMI_LARB_CMD_THRT_CON		0x24
+#define SMI_LARB_THRT_EN		0x370256
+
+#define SMI_LARB_SW_FLAG		0x40
+#define SMI_LARB_SW_FLAG_1		0x1
+
+#define SMI_LARB_OSTDL_PORT		0x200
+#define SMI_LARB_OSTDL_PORTx(id)	(SMI_LARB_OSTDL_PORT + (((id) & 0x1f) << 2))
 
 /* Below are about mmu enable registers, they are different in SoCs */
 /* mt2701 */
@@ -67,6 +75,11 @@
 })
 
 #define SMI_COMMON_INIT_REGS_NR		6
+#define SMI_LARB_PORT_NR_MAX		32
+
+#define MTK_SMI_FLAG_LARB_THRT_EN	BIT(0)
+#define MTK_SMI_FLAG_LARB_SW_FLAG	BIT(1)
+#define MTK_SMI_CAPS(flags, _x)		(!!((flags) & (_x)))
 
 struct mtk_smi_reg_pair {
 	unsigned int		offset;
@@ -97,6 +110,8 @@ struct mtk_smi_larb_gen {
 	int port_in_larb[MTK_LARB_NR_MAX + 1];
 	void (*config_port)(struct device *dev);
 	unsigned int			larb_direct_to_common_mask;
+	unsigned int			flags_general;
+	const u8			(*ostd)[SMI_LARB_PORT_NR_MAX];
 };
 
 struct mtk_smi {
@@ -213,12 +228,22 @@ static void mtk_smi_larb_config_port_mt8173(struct device *dev)
 static void mtk_smi_larb_config_port_gen2_general(struct device *dev)
 {
 	struct mtk_smi_larb *larb = dev_get_drvdata(dev);
-	u32 reg;
+	u32 reg, flags_general = larb->larb_gen->flags_general;
+	const u8 *larbostd = larb->larb_gen->ostd[larb->larbid];
 	int i;
 
 	if (BIT(larb->larbid) & larb->larb_gen->larb_direct_to_common_mask)
 		return;
 
+	if (MTK_SMI_CAPS(flags_general, MTK_SMI_FLAG_LARB_THRT_EN))
+		writel_relaxed(SMI_LARB_THRT_EN, larb->base + SMI_LARB_CMD_THRT_CON);
+
+	if (MTK_SMI_CAPS(flags_general, MTK_SMI_FLAG_LARB_SW_FLAG))
+		writel_relaxed(SMI_LARB_SW_FLAG_1, larb->base + SMI_LARB_SW_FLAG);
+
+	for (i = 0; i < SMI_LARB_PORT_NR_MAX && larbostd && !!larbostd[i]; i++)
+		writel_relaxed(larbostd[i], larb->base + SMI_LARB_OSTDL_PORTx(i));
+
 	for_each_set_bit(i, (unsigned long *)larb->mmu, 32) {
 		reg = readl_relaxed(larb->base + SMI_LARB_NONSEC_CON(i));
 		reg |= F_MMU_EN;
@@ -227,6 +252,51 @@ static void mtk_smi_larb_config_port_gen2_general(struct device *dev)
 	}
 }
 
+static const u8 mtk_smi_larb_mt8195_ostd[][SMI_LARB_PORT_NR_MAX] = {
+	[0] = {0x0a, 0xc, 0x22, 0x22, 0x01, 0x0a,}, /* larb0 */
+	[1] = {0x0a, 0xc, 0x22, 0x22, 0x01, 0x0a,}, /* larb1 */
+	[2] = {0x12, 0x12, 0x12, 0x12, 0x0a,},      /* ... */
+	[3] = {0x12, 0x12, 0x12, 0x12, 0x28, 0x28, 0x0a,},
+	[4] = {0x06, 0x01, 0x17, 0x06, 0x0a,},
+	[5] = {0x06, 0x01, 0x17, 0x06, 0x06, 0x01, 0x06, 0x0a,},
+	[6] = {0x06, 0x01, 0x06, 0x0a,},
+	[7] = {0x0c, 0x0c, 0x12,},
+	[8] = {0x0c, 0x0c, 0x12,},
+	[9] = {0x0a, 0x08, 0x04, 0x06, 0x01, 0x01, 0x10, 0x18, 0x11, 0x0a,
+		0x08, 0x04, 0x11, 0x06, 0x02, 0x06, 0x01, 0x11, 0x11, 0x06,},
+	[10] = {0x18, 0x08, 0x01, 0x01, 0x20, 0x12, 0x18, 0x06, 0x05, 0x10,
+		0x08, 0x08, 0x10, 0x08, 0x08, 0x18, 0x0c, 0x09, 0x0b, 0x0d,
+		0x0d, 0x06, 0x10, 0x10,},
+	[11] = {0x0e, 0x0e, 0x0e, 0x0e, 0x0e, 0x0e, 0x01, 0x01, 0x01, 0x01,},
+	[12] = {0x09, 0x09, 0x05, 0x05, 0x0c, 0x18, 0x02, 0x02, 0x04, 0x02,},
+	[13] = {0x02, 0x02, 0x12, 0x12, 0x02, 0x02, 0x02, 0x02, 0x08, 0x01,},
+	[14] = {0x12, 0x12, 0x02, 0x02, 0x02, 0x02, 0x16, 0x01, 0x16, 0x01,
+		0x01, 0x02, 0x02, 0x08, 0x02,},
+	[15] = {},
+	[16] = {0x28, 0x02, 0x02, 0x12, 0x02, 0x12, 0x10, 0x02, 0x02, 0x0a,
+		0x12, 0x02, 0x0a, 0x16, 0x02, 0x04,},
+	[17] = {0x1a, 0x0e, 0x0a, 0x0a, 0x0c, 0x0e, 0x10,},
+	[18] = {0x12, 0x06, 0x12, 0x06,},
+	[19] = {0x01, 0x04, 0x01, 0x01, 0x01, 0x01, 0x01, 0x04, 0x04, 0x01,
+		0x01, 0x01, 0x04, 0x0a, 0x06, 0x01, 0x01, 0x01, 0x0a, 0x06,
+		0x01, 0x01, 0x05, 0x03, 0x03, 0x04, 0x01,},
+	[20] = {0x01, 0x04, 0x01, 0x01, 0x01, 0x01, 0x01, 0x04, 0x04, 0x01,
+		0x01, 0x01, 0x04, 0x0a, 0x06, 0x01, 0x01, 0x01, 0x0a, 0x06,
+		0x01, 0x01, 0x05, 0x03, 0x03, 0x04, 0x01,},
+	[21] = {0x28, 0x19, 0x0c, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x04,},
+	[22] = {0x28, 0x19, 0x0c, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x04,},
+	[23] = {0x18, 0x01,},
+	[24] = {0x01, 0x01, 0x04, 0x01, 0x01, 0x01, 0x01, 0x01, 0x04, 0x01,
+		0x01, 0x01,},
+	[25] = {0x02, 0x02, 0x02, 0x28, 0x16, 0x02, 0x02, 0x02, 0x12, 0x16,
+		0x02, 0x01,},
+	[26] = {0x02, 0x02, 0x02, 0x28, 0x16, 0x02, 0x02, 0x02, 0x12, 0x16,
+		0x02, 0x01,},
+	[27] = {0x02, 0x02, 0x02, 0x28, 0x16, 0x02, 0x02, 0x02, 0x12, 0x16,
+		0x02, 0x01,},
+	[28] = {0x1a, 0x0e, 0x0a, 0x0a, 0x0c, 0x0e, 0x10,},
+};
+
 static const struct mtk_smi_larb_gen mtk_smi_larb_mt2701 = {
 	.port_in_larb = {
 		LARB0_PORT_OFFSET, LARB1_PORT_OFFSET,
@@ -269,6 +339,8 @@ static const struct mtk_smi_larb_gen mtk_smi_larb_mt8192 = {
 
 static const struct mtk_smi_larb_gen mtk_smi_larb_mt8195 = {
 	.config_port                = mtk_smi_larb_config_port_gen2_general,
+	.flags_general	            = MTK_SMI_FLAG_LARB_THRT_EN | MTK_SMI_FLAG_LARB_SW_FLAG,
+	.ostd		            = mtk_smi_larb_mt8195_ostd,
 };
 
 static const struct of_device_id mtk_smi_larb_of_ids[] = {
-- 
2.18.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
