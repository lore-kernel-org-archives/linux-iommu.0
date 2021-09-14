Return-Path: <SRS0=mcPB=OE=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 031E2C433FE
	for <iommu@archiver.kernel.org>; Tue, 14 Sep 2021 11:39:26 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA43A60FDA
	for <iommu@archiver.kernel.org>; Tue, 14 Sep 2021 11:39:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org BA43A60FDA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9A7CB40131;
	Tue, 14 Sep 2021 11:39:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JnGk4tUBv-tz; Tue, 14 Sep 2021 11:39:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 71F3A4014A;
	Tue, 14 Sep 2021 11:39:24 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4575DC001B;
	Tue, 14 Sep 2021 11:39:24 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1B86FC000D
 for <iommu@lists.linux-foundation.org>; Tue, 14 Sep 2021 11:39:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0B98C80ACA
 for <iommu@lists.linux-foundation.org>; Tue, 14 Sep 2021 11:39:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Q_cZUYFoMLT9 for <iommu@lists.linux-foundation.org>;
 Tue, 14 Sep 2021 11:39:22 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E829F80ABA
 for <iommu@lists.linux-foundation.org>; Tue, 14 Sep 2021 11:39:21 +0000 (UTC)
X-UUID: 2b77aaa424d048b7a1ecff47794d24ad-20210914
X-UUID: 2b77aaa424d048b7a1ecff47794d24ad-20210914
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by
 mailgw01.mediatek.com (envelope-from <yong.wu@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
 with ESMTP id 1091787263; Tue, 14 Sep 2021 19:39:19 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 14 Sep 2021 19:39:17 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 14 Sep 2021 19:39:16 +0800
From: Yong Wu <yong.wu@mediatek.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>, Rob Herring
 <robh+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>
Subject: [PATCH v4 12/13] memory: mtk-smi: mt8195: Add initial setting for
 smi-larb
Date: Tue, 14 Sep 2021 19:37:02 +0800
Message-ID: <20210914113703.31466-13-yong.wu@mediatek.com>
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

To improve the performance, We add some initial setting for smi larbs.
there are two part:
1), Each port has the special ostd(outstanding) value in each larb.
2), Two general settings for each larb.
   a. THRT_UPDATE: the value in bits[7:4] of 0x24 is not so good.
   The HW default is 4, and we expect it is 5, thus, add a flag to update
   it. This is only a DE recommendatory value, not a actual issue.
   The register name(THRT_CON) means: throttling control, and the field
   RD_NU_LMT means: Read Non-ultra commands limit.
   This change means update the Read non-ultra command from 4 to 5 here.

   b. SW_FLAG: Set 1 to the FLAG register. this is only for helping
   debug. We could confirm if the larb is reset from this value is 1 or 0.

In some SoC, this setting maybe changed dynamically for some special case
like 4K, and this initial setting is enough in mt8195.

Signed-off-by: Yong Wu <yong.wu@mediatek.com>
---
 drivers/memory/mtk-smi.c | 79 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 78 insertions(+), 1 deletion(-)

diff --git a/drivers/memory/mtk-smi.c b/drivers/memory/mtk-smi.c
index 689a45b39a65..b883dcc0bbfa 100644
--- a/drivers/memory/mtk-smi.c
+++ b/drivers/memory/mtk-smi.c
@@ -32,6 +32,15 @@
 #define SMI_DUMMY			0x444
 
 /* SMI LARB */
+#define SMI_LARB_CMD_THRT_CON		0x24
+#define SMI_LARB_THRT_RD_NU_LMT_MSK	GENMASK(7, 4)
+#define SMI_LARB_THRT_RD_NU_LMT		(5 << 4)
+
+#define SMI_LARB_SW_FLAG		0x40
+#define SMI_LARB_SW_FLAG_1		0x1
+
+#define SMI_LARB_OSTDL_PORT		0x200
+#define SMI_LARB_OSTDL_PORTx(id)	(SMI_LARB_OSTDL_PORT + (((id) & 0x1f) << 2))
 
 /* Below are about mmu enable registers, they are different in SoCs */
 /* gen1: mt2701 */
@@ -68,6 +77,11 @@
 })
 
 #define SMI_COMMON_INIT_REGS_NR		6
+#define SMI_LARB_PORT_NR_MAX		32
+
+#define MTK_SMI_FLAG_THRT_UPDATE	BIT(0)
+#define MTK_SMI_FLAG_SW_FLAG		BIT(1)
+#define MTK_SMI_CAPS(flags, _x)		(!!((flags) & (_x)))
 
 struct mtk_smi_reg_pair {
 	unsigned int		offset;
@@ -108,6 +122,8 @@ struct mtk_smi_larb_gen {
 	int port_in_larb[MTK_LARB_NR_MAX + 1];
 	void (*config_port)(struct device *dev);
 	unsigned int			larb_direct_to_common_mask;
+	unsigned int			flags_general;
+	const u8			(*ostd)[SMI_LARB_PORT_NR_MAX];
 };
 
 struct mtk_smi {
@@ -224,12 +240,26 @@ static void mtk_smi_larb_config_port_mt8173(struct device *dev)
 static void mtk_smi_larb_config_port_gen2_general(struct device *dev)
 {
 	struct mtk_smi_larb *larb = dev_get_drvdata(dev);
-	u32 reg;
+	u32 reg, flags_general = larb->larb_gen->flags_general;
+	const u8 *larbostd = larb->larb_gen->ostd[larb->larbid];
 	int i;
 
 	if (BIT(larb->larbid) & larb->larb_gen->larb_direct_to_common_mask)
 		return;
 
+	if (MTK_SMI_CAPS(flags_general, MTK_SMI_FLAG_THRT_UPDATE)) {
+		reg = readl_relaxed(larb->base + SMI_LARB_CMD_THRT_CON);
+		reg &= ~SMI_LARB_THRT_RD_NU_LMT_MSK;
+		reg |= SMI_LARB_THRT_RD_NU_LMT;
+		writel_relaxed(reg, larb->base + SMI_LARB_CMD_THRT_CON);
+	}
+
+	if (MTK_SMI_CAPS(flags_general, MTK_SMI_FLAG_SW_FLAG))
+		writel_relaxed(SMI_LARB_SW_FLAG_1, larb->base + SMI_LARB_SW_FLAG);
+
+	for (i = 0; i < SMI_LARB_PORT_NR_MAX && larbostd && !!larbostd[i]; i++)
+		writel_relaxed(larbostd[i], larb->base + SMI_LARB_OSTDL_PORTx(i));
+
 	for_each_set_bit(i, (unsigned long *)larb->mmu, 32) {
 		reg = readl_relaxed(larb->base + SMI_LARB_NONSEC_CON(i));
 		reg |= F_MMU_EN;
@@ -238,6 +268,51 @@ static void mtk_smi_larb_config_port_gen2_general(struct device *dev)
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
@@ -280,6 +355,8 @@ static const struct mtk_smi_larb_gen mtk_smi_larb_mt8192 = {
 
 static const struct mtk_smi_larb_gen mtk_smi_larb_mt8195 = {
 	.config_port                = mtk_smi_larb_config_port_gen2_general,
+	.flags_general	            = MTK_SMI_FLAG_THRT_UPDATE | MTK_SMI_FLAG_SW_FLAG,
+	.ostd		            = mtk_smi_larb_mt8195_ostd,
 };
 
 static const struct of_device_id mtk_smi_larb_of_ids[] = {
-- 
2.18.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
