Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3189FC433EF
	for <iommu@archiver.kernel.org>; Tue, 25 Jan 2022 09:01:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E658D60FDC;
	Tue, 25 Jan 2022 09:01:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id etFu3HUc6f_b; Tue, 25 Jan 2022 09:01:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id CF7C560FD7;
	Tue, 25 Jan 2022 09:01:16 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AAF98C0031;
	Tue, 25 Jan 2022 09:01:16 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 90BEAC002F
 for <iommu@lists.linux-foundation.org>; Tue, 25 Jan 2022 09:01:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6983B84CD2
 for <iommu@lists.linux-foundation.org>; Tue, 25 Jan 2022 09:01:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Gw4-PX8PaaNF for <iommu@lists.linux-foundation.org>;
 Tue, 25 Jan 2022 09:01:14 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 756FC84CEA
 for <iommu@lists.linux-foundation.org>; Tue, 25 Jan 2022 09:01:14 +0000 (UTC)
X-UUID: 03f4751e6bc947db8e62b7b6969034c1-20220125
X-UUID: 03f4751e6bc947db8e62b7b6969034c1-20220125
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by
 mailgw02.mediatek.com (envelope-from <yong.wu@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 1096530071; Tue, 25 Jan 2022 17:01:11 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Tue, 25 Jan 2022 17:01:10 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 25 Jan 2022 17:01:08 +0800
From: Yong Wu <yong.wu@mediatek.com>
To: Joerg Roedel <joro@8bytes.org>, Rob Herring <robh+dt@kernel.org>,
 "Matthias Brugger" <matthias.bgg@gmail.com>, Will Deacon <will@kernel.org>
Subject: [PATCH v4 34/35] iommu/mediatek: Backup/restore regsiters for multi
 banks
Date: Tue, 25 Jan 2022 16:56:33 +0800
Message-ID: <20220125085634.17972-35-yong.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220125085634.17972-1-yong.wu@mediatek.com>
References: <20220125085634.17972-1-yong.wu@mediatek.com>
MIME-Version: 1.0
X-MTK: N
Cc: youlin.pei@mediatek.com, devicetree@vger.kernel.org,
 srv_heupstream@mediatek.com,
 Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
 chengci.xu@mediatek.com, xueqi.zhang@mediatek.com,
 linux-kernel@vger.kernel.org, libo.kang@mediatek.com,
 yen-chang.chen@mediatek.com, iommu@lists.linux-foundation.org,
 yf.wang@mediatek.com, linux-mediatek@lists.infradead.org,
 Hsin-Yi Wang <hsinyi@chromium.org>, anan.sun@mediatek.com,
 Robin Murphy <robin.murphy@arm.com>, mingyuan.ma@mediatek.com,
 linux-arm-kernel@lists.infradead.org, AngeloGioacchino
 Del Regno <angelogioacchino.delregno@collabora.com>
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

Each bank has some independent registers. thus backup/restore them for
each a bank when suspend and resume.

Signed-off-by: Yong Wu <yong.wu@mediatek.com>
---
 drivers/iommu/mtk_iommu.c | 46 ++++++++++++++++++++++++++-------------
 1 file changed, 31 insertions(+), 15 deletions(-)

diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index 3a2907c19bd8..a17610434868 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -173,11 +173,12 @@ struct mtk_iommu_suspend_reg {
 	u32			misc_ctrl;
 	u32			dcm_dis;
 	u32			ctrl_reg;
-	u32			int_control0;
-	u32			int_main_control;
-	u32			ivrp_paddr;
 	u32			vld_pa_rng;
 	u32			wr_len_ctrl;
+
+	u32			int_control[MTK_IOMMU_BANK_MAX];
+	u32			int_main_control[MTK_IOMMU_BANK_MAX];
+	u32			ivrp_paddr[MTK_IOMMU_BANK_MAX];
 };
 
 struct mtk_iommu_plat_data {
@@ -1264,16 +1265,23 @@ static int __maybe_unused mtk_iommu_runtime_suspend(struct device *dev)
 {
 	struct mtk_iommu_data *data = dev_get_drvdata(dev);
 	struct mtk_iommu_suspend_reg *reg = &data->reg;
-	void __iomem *base = data->bank[0].base;
+	void __iomem *base;
+	int i = 0;
 
+	base = data->bank[i].base;
 	reg->wr_len_ctrl = readl_relaxed(base + REG_MMU_WR_LEN_CTRL);
 	reg->misc_ctrl = readl_relaxed(base + REG_MMU_MISC_CTRL);
 	reg->dcm_dis = readl_relaxed(base + REG_MMU_DCM_DIS);
 	reg->ctrl_reg = readl_relaxed(base + REG_MMU_CTRL_REG);
-	reg->int_control0 = readl_relaxed(base + REG_MMU_INT_CONTROL0);
-	reg->int_main_control = readl_relaxed(base + REG_MMU_INT_MAIN_CONTROL);
-	reg->ivrp_paddr = readl_relaxed(base + REG_MMU_IVRP_PADDR);
 	reg->vld_pa_rng = readl_relaxed(base + REG_MMU_VLD_PA_RNG);
+	do {
+		if (!data->plat_data->banks_enable[i])
+			continue;
+		base = data->bank[i].base;
+		reg->int_control[i] = readl_relaxed(base + REG_MMU_INT_CONTROL0);
+		reg->int_main_control[i] = readl_relaxed(base + REG_MMU_INT_MAIN_CONTROL);
+		reg->ivrp_paddr[i] = readl_relaxed(base + REG_MMU_IVRP_PADDR);
+	} while (++i < data->plat_data->banks_num);
 	clk_disable_unprepare(data->bclk);
 	return 0;
 }
@@ -1282,9 +1290,9 @@ static int __maybe_unused mtk_iommu_runtime_resume(struct device *dev)
 {
 	struct mtk_iommu_data *data = dev_get_drvdata(dev);
 	struct mtk_iommu_suspend_reg *reg = &data->reg;
-	struct mtk_iommu_domain *m4u_dom = data->bank[0].m4u_dom;
-	void __iomem *base = data->bank[0].base;
-	int ret;
+	struct mtk_iommu_domain *m4u_dom;
+	void __iomem *base;
+	int ret, i = 0;
 
 	ret = clk_prepare_enable(data->bclk);
 	if (ret) {
@@ -1296,18 +1304,26 @@ static int __maybe_unused mtk_iommu_runtime_resume(struct device *dev)
 	 * Uppon first resume, only enable the clk and return, since the values of the
 	 * registers are not yet set.
 	 */
-	if (!m4u_dom)
+	if (!reg->wr_len_ctrl)
 		return 0;
 
+	base = data->bank[i].base;
 	writel_relaxed(reg->wr_len_ctrl, base + REG_MMU_WR_LEN_CTRL);
 	writel_relaxed(reg->misc_ctrl, base + REG_MMU_MISC_CTRL);
 	writel_relaxed(reg->dcm_dis, base + REG_MMU_DCM_DIS);
 	writel_relaxed(reg->ctrl_reg, base + REG_MMU_CTRL_REG);
-	writel_relaxed(reg->int_control0, base + REG_MMU_INT_CONTROL0);
-	writel_relaxed(reg->int_main_control, base + REG_MMU_INT_MAIN_CONTROL);
-	writel_relaxed(reg->ivrp_paddr, base + REG_MMU_IVRP_PADDR);
 	writel_relaxed(reg->vld_pa_rng, base + REG_MMU_VLD_PA_RNG);
-	writel(m4u_dom->cfg.arm_v7s_cfg.ttbr & MMU_PT_ADDR_MASK, base + REG_MMU_PT_BASE_ADDR);
+	do {
+		m4u_dom = data->bank[i].m4u_dom;
+		if (!data->plat_data->banks_enable[i] || !m4u_dom)
+			continue;
+		base = data->bank[i].base;
+		writel_relaxed(reg->int_control[i], base + REG_MMU_INT_CONTROL0);
+		writel_relaxed(reg->int_main_control[i], base + REG_MMU_INT_MAIN_CONTROL);
+		writel_relaxed(reg->ivrp_paddr[i], base + REG_MMU_IVRP_PADDR);
+		writel(m4u_dom->cfg.arm_v7s_cfg.ttbr & MMU_PT_ADDR_MASK,
+		       base + REG_MMU_PT_BASE_ADDR);
+	} while (++i < data->plat_data->banks_num);
 
 	/*
 	 * Users may allocate dma buffer before they call pm_runtime_get,
-- 
2.18.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
