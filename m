Return-Path: <SRS0=MNdo=WU=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7CADC3A5A4
	for <iommu@archiver.kernel.org>; Sat, 24 Aug 2019 03:20:44 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 978792133F
	for <iommu@archiver.kernel.org>; Sat, 24 Aug 2019 03:20:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 978792133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 12F8FC8F;
	Sat, 24 Aug 2019 03:20:37 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id AAB0DC6E
	for <iommu@lists.linux-foundation.org>;
	Sat, 24 Aug 2019 03:20:35 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	by smtp1.linuxfoundation.org (Postfix) with ESMTP id EFE63A7
	for <iommu@lists.linux-foundation.org>;
	Sat, 24 Aug 2019 03:20:34 +0000 (UTC)
X-UUID: efcea9a1365b4a7486e7c1a9664b2708-20190824
X-UUID: efcea9a1365b4a7486e7c1a9664b2708-20190824
Received: from mtkmrs01.mediatek.inc [(172.21.131.159)] by
	mailgw02.mediatek.com (envelope-from <yong.wu@mediatek.com>)
	(Cellopoint E-mail Firewall v4.1.10 Build 0707 with TLS)
	with ESMTP id 918104327; Sat, 24 Aug 2019 11:03:02 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
	mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server
	(TLS) id 15.0.1395.4; Sat, 24 Aug 2019 11:02:54 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas07.mediatek.inc
	(172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
	Transport; Sat, 24 Aug 2019 11:02:53 +0800
From: Yong Wu <yong.wu@mediatek.com>
To: Joerg Roedel <joro@8bytes.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
	Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>
Subject: [PATCH v11 02/23] iommu/mediatek: Use a struct as the platform data
Date: Sat, 24 Aug 2019 11:01:47 +0800
Message-ID: <1566615728-26388-3-git-send-email-yong.wu@mediatek.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1566615728-26388-1-git-send-email-yong.wu@mediatek.com>
References: <1566615728-26388-1-git-send-email-yong.wu@mediatek.com>
MIME-Version: 1.0
X-MTK: N
Cc: youlin.pei@mediatek.com, devicetree@vger.kernel.org,
	Nicolas Boichat <drinkcat@chromium.org>, cui.zhang@mediatek.com,
	srv_heupstream@mediatek.com, chao.hao@mediatek.com,
	linux-kernel@vger.kernel.org, Evan Green <evgreen@chromium.org>,
	Tomasz Figa <tfiga@google.com>, iommu@lists.linux-foundation.org,
	Rob Herring <robh+dt@kernel.org>,
	linux-mediatek@lists.infradead.org, ming-fan.chen@mediatek.com,
	anan.sun@mediatek.com, Matthias Kaehlcke <mka@chromium.org>,
	linux-arm-kernel@lists.infradead.org
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

Use a struct as the platform special data instead of the enumeration.
This is a prepare patch for adding mt8183 iommu support.

Signed-off-by: Yong Wu <yong.wu@mediatek.com>
Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
Reviewed-by: Evan Green <evgreen@chromium.org>
---
 drivers/iommu/mtk_iommu.c | 24 ++++++++++++++++--------
 drivers/iommu/mtk_iommu.h |  6 +++++-
 2 files changed, 21 insertions(+), 9 deletions(-)

diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index 82e4be4..c6e6dc3 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -46,7 +46,7 @@
 #define REG_MMU_CTRL_REG			0x110
 #define F_MMU_PREFETCH_RT_REPLACE_MOD		BIT(4)
 #define F_MMU_TF_PROTECT_SEL_SHIFT(data) \
-	((data)->m4u_plat == M4U_MT2712 ? 4 : 5)
+	((data)->plat_data->m4u_plat == M4U_MT2712 ? 4 : 5)
 /* It's named by F_MMU_TF_PROT_SEL in mt2712. */
 #define F_MMU_TF_PROTECT_SEL(prot, data) \
 	(((prot) & 0x3) << F_MMU_TF_PROTECT_SEL_SHIFT(data))
@@ -512,7 +512,7 @@ static int mtk_iommu_hw_init(const struct mtk_iommu_data *data)
 	}
 
 	regval = F_MMU_TF_PROTECT_SEL(2, data);
-	if (data->m4u_plat == M4U_MT8173)
+	if (data->plat_data->m4u_plat == M4U_MT8173)
 		regval |= F_MMU_PREFETCH_RT_REPLACE_MOD;
 	writel_relaxed(regval, data->base + REG_MMU_CTRL_REG);
 
@@ -533,14 +533,14 @@ static int mtk_iommu_hw_init(const struct mtk_iommu_data *data)
 		F_INT_PRETETCH_TRANSATION_FIFO_FAULT;
 	writel_relaxed(regval, data->base + REG_MMU_INT_MAIN_CONTROL);
 
-	if (data->m4u_plat == M4U_MT8173)
+	if (data->plat_data->m4u_plat == M4U_MT8173)
 		regval = (data->protect_base >> 1) | (data->enable_4GB << 31);
 	else
 		regval = lower_32_bits(data->protect_base) |
 			 upper_32_bits(data->protect_base);
 	writel_relaxed(regval, data->base + REG_MMU_IVRP_PADDR);
 
-	if (data->enable_4GB && data->m4u_plat != M4U_MT8173) {
+	if (data->enable_4GB && data->plat_data->m4u_plat != M4U_MT8173) {
 		/*
 		 * If 4GB mode is enabled, the validate PA range is from
 		 * 0x1_0000_0000 to 0x1_ffff_ffff. here record bit[32:30].
@@ -551,7 +551,7 @@ static int mtk_iommu_hw_init(const struct mtk_iommu_data *data)
 	writel_relaxed(0, data->base + REG_MMU_DCM_DIS);
 
 	/* It's MISC control register whose default value is ok except mt8173.*/
-	if (data->m4u_plat == M4U_MT8173)
+	if (data->plat_data->m4u_plat == M4U_MT8173)
 		writel_relaxed(0, data->base + REG_MMU_STANDARD_AXI_MODE);
 
 	if (devm_request_irq(data->dev, data->irq, mtk_iommu_isr, 0,
@@ -584,7 +584,7 @@ static int mtk_iommu_probe(struct platform_device *pdev)
 	if (!data)
 		return -ENOMEM;
 	data->dev = dev;
-	data->m4u_plat = (enum mtk_iommu_plat)of_device_get_match_data(dev);
+	data->plat_data = of_device_get_match_data(dev);
 
 	/* Protect memory. HW will access here while translation fault.*/
 	protect = devm_kzalloc(dev, MTK_PROTECT_PA_ALIGN * 2, GFP_KERNEL);
@@ -732,9 +732,17 @@ static int __maybe_unused mtk_iommu_resume(struct device *dev)
 	SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(mtk_iommu_suspend, mtk_iommu_resume)
 };
 
+static const struct mtk_iommu_plat_data mt2712_data = {
+	.m4u_plat     = M4U_MT2712,
+};
+
+static const struct mtk_iommu_plat_data mt8173_data = {
+	.m4u_plat     = M4U_MT8173,
+};
+
 static const struct of_device_id mtk_iommu_of_ids[] = {
-	{ .compatible = "mediatek,mt2712-m4u", .data = (void *)M4U_MT2712},
-	{ .compatible = "mediatek,mt8173-m4u", .data = (void *)M4U_MT8173},
+	{ .compatible = "mediatek,mt2712-m4u", .data = &mt2712_data},
+	{ .compatible = "mediatek,mt8173-m4u", .data = &mt8173_data},
 	{}
 };
 
diff --git a/drivers/iommu/mtk_iommu.h b/drivers/iommu/mtk_iommu.h
index 59337323..9725b08 100644
--- a/drivers/iommu/mtk_iommu.h
+++ b/drivers/iommu/mtk_iommu.h
@@ -32,6 +32,10 @@ enum mtk_iommu_plat {
 	M4U_MT8173,
 };
 
+struct mtk_iommu_plat_data {
+	enum mtk_iommu_plat m4u_plat;
+};
+
 struct mtk_iommu_domain;
 
 struct mtk_iommu_data {
@@ -48,7 +52,7 @@ struct mtk_iommu_data {
 	bool				tlb_flush_active;
 
 	struct iommu_device		iommu;
-	enum mtk_iommu_plat		m4u_plat;
+	const struct mtk_iommu_plat_data *plat_data;
 
 	struct list_head		list;
 };
-- 
1.9.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
