Return-Path: <SRS0=900o=ON=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31645C433F5
	for <iommu@archiver.kernel.org>; Thu, 23 Sep 2021 12:03:16 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E68EF61107
	for <iommu@archiver.kernel.org>; Thu, 23 Sep 2021 12:03:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E68EF61107
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id B3D374067B;
	Thu, 23 Sep 2021 12:03:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GQRk8mf1om5r; Thu, 23 Sep 2021 12:03:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 9E4BB400C5;
	Thu, 23 Sep 2021 12:03:13 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 76C3CC0011;
	Thu, 23 Sep 2021 12:03:13 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 08784C000D
 for <iommu@lists.linux-foundation.org>; Thu, 23 Sep 2021 12:03:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D7A96400C5
 for <iommu@lists.linux-foundation.org>; Thu, 23 Sep 2021 12:03:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Tnbvc_XFG73L for <iommu@lists.linux-foundation.org>;
 Thu, 23 Sep 2021 12:03:10 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E01D04063B
 for <iommu@lists.linux-foundation.org>; Thu, 23 Sep 2021 12:03:09 +0000 (UTC)
X-UUID: c32addba72f7493b897284925ce36d95-20210923
X-UUID: c32addba72f7493b897284925ce36d95-20210923
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by
 mailgw01.mediatek.com (envelope-from <yong.wu@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
 with ESMTP id 1337201487; Thu, 23 Sep 2021 20:03:05 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 23 Sep 2021 20:03:03 +0800
Received: from localhost.localdomain (10.17.3.154) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 23 Sep 2021 20:03:03 +0800
From: Yong Wu <yong.wu@mediatek.com>
To: Joerg Roedel <joro@8bytes.org>, Rob Herring <robh+dt@kernel.org>, Matthias
 Brugger <matthias.bgg@gmail.com>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>
Subject: [PATCH v3 26/33] iommu/mediatek: Add mtk_iommu_bank_data structure
Date: Thu, 23 Sep 2021 19:58:33 +0800
Message-ID: <20210923115840.17813-27-yong.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210923115840.17813-1-yong.wu@mediatek.com>
References: <20210923115840.17813-1-yong.wu@mediatek.com>
MIME-Version: 1.0
X-MTK: N
Cc: youlin.pei@mediatek.com, devicetree@vger.kernel.org,
 srv_heupstream@mediatek.com,
 Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
 linux-kernel@vger.kernel.org, yen-chang.chen@mediatek.com,
 chao.hao@mediatek.com, iommu@lists.linux-foundation.org,
 linux-mediatek@lists.infradead.org, Hsin-Yi Wang <hsinyi@chromium.org>,
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

Prepare for supporting multi-banks for the IOMMU HW, No functional change.

Add a new structure(mtk_iommu_bank_data) for each a bank. Each a bank have
the independent HW base/IRQ/tlb-range ops, and each a bank has its special
iommu-domain(independent pgtable), thus, also move the domain information
into it.

In previous SoC, we have only one bank which could be treated as bank0(
bankid always is 0 for the previous SoC).

After adding this structure, the tlb operations and irq could use
bank_data as parameter.

Signed-off-by: Yong Wu <yong.wu@mediatek.com>
---
 drivers/iommu/mtk_iommu.c | 137 ++++++++++++++++++++++----------------
 drivers/iommu/mtk_iommu.h |  24 ++++++-
 2 files changed, 99 insertions(+), 62 deletions(-)

diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index ac31fe8b7aaf..6ef3eb3cad92 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -146,7 +146,7 @@ struct mtk_iommu_domain {
 	struct io_pgtable_cfg		cfg;
 	struct io_pgtable_ops		*iop;
 
-	struct mtk_iommu_data		*data;
+	struct mtk_iommu_bank_data	*bank;
 	struct iommu_domain		domain;
 };
 
@@ -221,25 +221,29 @@ static struct mtk_iommu_domain *to_mtk_domain(struct iommu_domain *dom)
 
 static void mtk_iommu_tlb_flush_all(struct mtk_iommu_data *data)
 {
-	void __iomem *base = data->base;
+	/* Tlb flush all always is in bank0. */
+	struct mtk_iommu_bank_data *bank = &data->bank[0];
+	void __iomem *base = bank->base;
 	unsigned long flags;
 
 	/*
 	 * No need get power status since the HW PM status nearly is active
 	 * when entering here.
 	 */
-	spin_lock_irqsave(&data->tlb_lock, flags);
+	spin_lock_irqsave(&bank->tlb_lock, flags);
 	writel_relaxed(F_INVLD_EN1 | F_INVLD_EN0, base + data->plat_data->inv_sel_reg);
 	writel_relaxed(F_ALL_INVLD, base + REG_MMU_INVALIDATE);
 	wmb(); /* Make sure the tlb flush all done */
-	spin_unlock_irqrestore(&data->tlb_lock, flags);
+	spin_unlock_irqrestore(&bank->tlb_lock, flags);
 }
 
 static void mtk_iommu_tlb_flush_range_sync(unsigned long iova, size_t size,
-					   struct mtk_iommu_data *data)
+					   struct mtk_iommu_bank_data *bank)
 {
-	struct list_head *head = data->hw_list;
-	bool has_pm = !!data->dev->pm_domain;
+	struct list_head *head = bank->pdata->hw_list;
+	bool has_pm = !!bank->pdev->pm_domain;
+	struct mtk_iommu_bank_data *curbank;
+	struct mtk_iommu_data *data;
 	unsigned long flags;
 	void __iomem *base;
 	int ret;
@@ -251,9 +255,10 @@ static void mtk_iommu_tlb_flush_range_sync(unsigned long iova, size_t size,
 				continue;
 		}
 
-		base = data->base;
+		curbank = &data->bank[bank->id];
+		base = curbank->base;
 
-		spin_lock_irqsave(&data->tlb_lock, flags);
+		spin_lock_irqsave(&curbank->tlb_lock, flags);
 		writel_relaxed(F_INVLD_EN1 | F_INVLD_EN0,
 			       base + data->plat_data->inv_sel_reg);
 
@@ -268,7 +273,7 @@ static void mtk_iommu_tlb_flush_range_sync(unsigned long iova, size_t size,
 
 		/* Clear the CPE status */
 		writel_relaxed(0, base + REG_MMU_CPE_DONE);
-		spin_unlock_irqrestore(&data->tlb_lock, flags);
+		spin_unlock_irqrestore(&curbank->tlb_lock, flags);
 
 		if (ret) {
 			dev_warn(data->dev,
@@ -283,12 +288,13 @@ static void mtk_iommu_tlb_flush_range_sync(unsigned long iova, size_t size,
 
 static irqreturn_t mtk_iommu_isr(int irq, void *dev_id)
 {
-	struct mtk_iommu_data *data = dev_id;
-	struct mtk_iommu_domain *dom = data->m4u_dom;
+	struct mtk_iommu_bank_data *bank = dev_id;
+	struct mtk_iommu_data *data = bank->pdata;
+	struct mtk_iommu_domain *dom = bank->m4u_dom;
 	unsigned int fault_larb = 0, fault_port = 0, sub_comm = 0;
 	u32 int_state, regval, va34_32, pa34_32;
 	const struct mtk_iommu_plat_data *plat_data = data->plat_data;
-	void __iomem *base = data->base;
+	void __iomem *base = bank->base;
 	u64 fault_iova, fault_pa;
 	bool layer, write;
 
@@ -327,10 +333,10 @@ static irqreturn_t mtk_iommu_isr(int irq, void *dev_id)
 		fault_larb = data->plat_data->larbid_remap[fault_larb][sub_comm];
 	}
 
-	if (report_iommu_fault(&dom->domain, data->dev, fault_iova,
+	if (report_iommu_fault(&dom->domain, bank->pdev, fault_iova,
 			       write ? IOMMU_FAULT_WRITE : IOMMU_FAULT_READ)) {
 		dev_err_ratelimited(
-			data->dev,
+			bank->pdev,
 			"fault type=0x%x iova=0x%llx pa=0x%llx master=0x%x(larb=%d port=%d) layer=%d %s\n",
 			int_state, fault_iova, fault_pa, regval, fault_larb, fault_port,
 			layer, write ? "write" : "read");
@@ -427,12 +433,14 @@ static int mtk_iommu_domain_finalise(struct mtk_iommu_domain *dom,
 				     unsigned int domid)
 {
 	const struct mtk_iommu_iova_region *region;
-
-	/* Use the exist domain as there is only one pgtable here. */
-	if (data->m4u_dom) {
-		dom->iop = data->m4u_dom->iop;
-		dom->cfg = data->m4u_dom->cfg;
-		dom->domain.pgsize_bitmap = data->m4u_dom->cfg.pgsize_bitmap;
+	struct mtk_iommu_domain	*m4u_dom;
+
+	/* Always use bank0 in sharing pgtable case */
+	m4u_dom = data->bank[0].m4u_dom;
+	if (m4u_dom) {
+		dom->iop = m4u_dom->iop;
+		dom->cfg = m4u_dom->cfg;
+		dom->domain.pgsize_bitmap = m4u_dom->cfg.pgsize_bitmap;
 		goto update_iova_region;
 	}
 
@@ -493,23 +501,26 @@ static int mtk_iommu_attach_device(struct iommu_domain *domain,
 	struct mtk_iommu_data *data = dev_iommu_priv_get(dev), *frstdata;
 	struct mtk_iommu_domain *dom = to_mtk_domain(domain);
 	struct list_head *hw_list = data->hw_list;
+	struct mtk_iommu_bank_data *bank;
 	struct device *m4udev = data->dev;
+	unsigned int bankid = 0;
 	int ret, domid;
 
 	domid = mtk_iommu_get_domain_id(dev, data->plat_data);
 	if (domid < 0)
 		return domid;
 
-	if (!dom->data) {
+	bank = &data->bank[bankid];
+	if (!dom->bank) {
 		/* Data is in the frstdata in sharing pgtable case. */
 		frstdata = mtk_iommu_get_frst_data(hw_list);
 
 		if (mtk_iommu_domain_finalise(dom, frstdata, domid))
 			return -ENODEV;
-		dom->data = data;
+		dom->bank = bank;
 	}
 
-	if (!data->m4u_dom) { /* Initialize the M4U HW */
+	if (!bank->m4u_dom) { /* Initialize the M4U HW */
 		ret = pm_runtime_resume_and_get(m4udev);
 		if (ret < 0)
 			return ret;
@@ -519,9 +530,9 @@ static int mtk_iommu_attach_device(struct iommu_domain *domain,
 			pm_runtime_put(m4udev);
 			return ret;
 		}
-		data->m4u_dom = dom;
+		bank->m4u_dom = dom;
 		writel(dom->cfg.arm_v7s_cfg.ttbr & MMU_PT_ADDR_MASK,
-		       data->base + REG_MMU_PT_BASE_ADDR);
+		       bank->base + REG_MMU_PT_BASE_ADDR);
 
 		pm_runtime_put(m4udev);
 	}
@@ -543,7 +554,7 @@ static int mtk_iommu_map(struct iommu_domain *domain, unsigned long iova,
 	struct mtk_iommu_domain *dom = to_mtk_domain(domain);
 
 	/* The "4GB mode" M4U physically can not use the lower remap of Dram. */
-	if (dom->data->enable_4GB)
+	if (dom->bank->pdata->enable_4GB)
 		paddr |= BIT_ULL(32);
 
 	/* Synchronize with the tlb_lock */
@@ -564,7 +575,7 @@ static void mtk_iommu_flush_iotlb_all(struct iommu_domain *domain)
 {
 	struct mtk_iommu_domain *dom = to_mtk_domain(domain);
 
-	mtk_iommu_tlb_flush_all(dom->data);
+	mtk_iommu_tlb_flush_all(dom->bank->pdata);
 }
 
 static void mtk_iommu_iotlb_sync(struct iommu_domain *domain,
@@ -573,7 +584,7 @@ static void mtk_iommu_iotlb_sync(struct iommu_domain *domain,
 	struct mtk_iommu_domain *dom = to_mtk_domain(domain);
 	size_t length = gather->end - gather->start + 1;
 
-	mtk_iommu_tlb_flush_range_sync(gather->start, length, dom->data);
+	mtk_iommu_tlb_flush_range_sync(gather->start, length, dom->bank);
 }
 
 static void mtk_iommu_sync_map(struct iommu_domain *domain, unsigned long iova,
@@ -581,7 +592,7 @@ static void mtk_iommu_sync_map(struct iommu_domain *domain, unsigned long iova,
 {
 	struct mtk_iommu_domain *dom = to_mtk_domain(domain);
 
-	mtk_iommu_tlb_flush_range_sync(iova, size, dom->data);
+	mtk_iommu_tlb_flush_range_sync(iova, size, dom->bank);
 }
 
 static phys_addr_t mtk_iommu_iova_to_phys(struct iommu_domain *domain,
@@ -591,7 +602,7 @@ static phys_addr_t mtk_iommu_iova_to_phys(struct iommu_domain *domain,
 	phys_addr_t pa;
 
 	pa = dom->iop->iova_to_phys(dom->iop, iova);
-	if (dom->data->enable_4GB && pa >= MTK_IOMMU_4GB_MODE_REMAP_BASE)
+	if (dom->bank->pdata->enable_4GB && pa >= MTK_IOMMU_4GB_MODE_REMAP_BASE)
 		pa &= ~BIT_ULL(32);
 
 	return pa;
@@ -720,16 +731,17 @@ static const struct iommu_ops mtk_iommu_ops = {
 
 static int mtk_iommu_hw_init(const struct mtk_iommu_data *data)
 {
+	const struct mtk_iommu_bank_data *bank0 = &data->bank[0];
 	u32 regval;
 
 	if (data->plat_data->m4u_plat == M4U_MT8173) {
 		regval = F_MMU_PREFETCH_RT_REPLACE_MOD |
 			 F_MMU_TF_PROT_TO_PROGRAM_ADDR_MT8173;
 	} else {
-		regval = readl_relaxed(data->base + REG_MMU_CTRL_REG);
+		regval = readl_relaxed(bank0->base + REG_MMU_CTRL_REG);
 		regval |= F_MMU_TF_PROT_TO_PROGRAM_ADDR;
 	}
-	writel_relaxed(regval, data->base + REG_MMU_CTRL_REG);
+	writel_relaxed(regval, bank0->base + REG_MMU_CTRL_REG);
 
 	if (data->enable_4GB &&
 	    MTK_IOMMU_HAS_FLAG(data->plat_data, HAS_VLD_PA_RNG)) {
@@ -738,31 +750,31 @@ static int mtk_iommu_hw_init(const struct mtk_iommu_data *data)
 		 * 0x1_0000_0000 to 0x1_ffff_ffff. here record bit[32:30].
 		 */
 		regval = F_MMU_VLD_PA_RNG(7, 4);
-		writel_relaxed(regval, data->base + REG_MMU_VLD_PA_RNG);
+		writel_relaxed(regval, bank0->base + REG_MMU_VLD_PA_RNG);
 	}
 	if (MTK_IOMMU_HAS_FLAG(data->plat_data, DCM_DISABLE))
-		writel_relaxed(F_MMU_DCM, data->base + REG_MMU_DCM_DIS);
+		writel_relaxed(F_MMU_DCM, bank0->base + REG_MMU_DCM_DIS);
 	else
-		writel_relaxed(0, data->base + REG_MMU_DCM_DIS);
+		writel_relaxed(0, bank0->base + REG_MMU_DCM_DIS);
 
 	if (MTK_IOMMU_HAS_FLAG(data->plat_data, WR_THROT_EN)) {
 		/* write command throttling mode */
-		regval = readl_relaxed(data->base + REG_MMU_WR_LEN_CTRL);
+		regval = readl_relaxed(bank0->base + REG_MMU_WR_LEN_CTRL);
 		regval &= ~F_MMU_WR_THROT_DIS_MASK;
-		writel_relaxed(regval, data->base + REG_MMU_WR_LEN_CTRL);
+		writel_relaxed(regval, bank0->base + REG_MMU_WR_LEN_CTRL);
 	}
 
 	if (MTK_IOMMU_HAS_FLAG(data->plat_data, RESET_AXI)) {
 		/* The register is called STANDARD_AXI_MODE in this case */
 		regval = 0;
 	} else {
-		regval = readl_relaxed(data->base + REG_MMU_MISC_CTRL);
+		regval = readl_relaxed(bank0->base + REG_MMU_MISC_CTRL);
 		if (MTK_IOMMU_HAS_FLAG(data->plat_data, NOT_STD_AXI_MODE))
 			regval &= ~F_MMU_STANDARD_AXI_MODE_MASK;
 		if (MTK_IOMMU_HAS_FLAG(data->plat_data, OUT_ORDER_WR_EN))
 			regval &= ~F_MMU_IN_ORDER_WR_EN_MASK;
 	}
-	writel_relaxed(regval, data->base + REG_MMU_MISC_CTRL);
+	writel_relaxed(regval, bank0->base + REG_MMU_MISC_CTRL);
 
 	regval = F_L2_MULIT_HIT_EN |
 		F_TABLE_WALK_FAULT_INT_EN |
@@ -770,7 +782,7 @@ static int mtk_iommu_hw_init(const struct mtk_iommu_data *data)
 		F_MISS_FIFO_OVERFLOW_INT_EN |
 		F_PREFETCH_FIFO_ERR_INT_EN |
 		F_MISS_FIFO_ERR_INT_EN;
-	writel_relaxed(regval, data->base + REG_MMU_INT_CONTROL0);
+	writel_relaxed(regval, bank0->base + REG_MMU_INT_CONTROL0);
 
 	regval = F_INT_TRANSLATION_FAULT |
 		F_INT_MAIN_MULTI_HIT_FAULT |
@@ -779,19 +791,19 @@ static int mtk_iommu_hw_init(const struct mtk_iommu_data *data)
 		F_INT_TLB_MISS_FAULT |
 		F_INT_MISS_TRANSACTION_FIFO_FAULT |
 		F_INT_PRETETCH_TRANSATION_FIFO_FAULT;
-	writel_relaxed(regval, data->base + REG_MMU_INT_MAIN_CONTROL);
+	writel_relaxed(regval, bank0->base + REG_MMU_INT_MAIN_CONTROL);
 
 	if (MTK_IOMMU_HAS_FLAG(data->plat_data, HAS_LEGACY_IVRP_PADDR))
 		regval = (data->protect_base >> 1) | (data->enable_4GB << 31);
 	else
 		regval = lower_32_bits(data->protect_base) |
 			 upper_32_bits(data->protect_base);
-	writel_relaxed(regval, data->base + REG_MMU_IVRP_PADDR);
+	writel_relaxed(regval, bank0->base + REG_MMU_IVRP_PADDR);
 
-	if (devm_request_irq(data->dev, data->irq, mtk_iommu_isr, 0,
-			     dev_name(data->dev), (void *)data)) {
-		writel_relaxed(0, data->base + REG_MMU_PT_BASE_ADDR);
-		dev_err(data->dev, "Failed @ IRQ-%d Request\n", data->irq);
+	if (devm_request_irq(bank0->pdev, bank0->irq, mtk_iommu_isr, 0,
+			     dev_name(bank0->pdev), (void *)bank0)) {
+		writel_relaxed(0, bank0->base + REG_MMU_PT_BASE_ADDR);
+		dev_err(bank0->pdev, "Failed @ IRQ-%d Request\n", bank0->irq);
 		return -ENODEV;
 	}
 
@@ -884,6 +896,8 @@ static int mtk_iommu_probe(struct platform_device *pdev)
 	int                     ret;
 	u32			val;
 	char                    *p;
+	struct mtk_iommu_bank_data *bank;
+	void __iomem		*base;
 
 	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
 	if (!data)
@@ -921,14 +935,20 @@ static int mtk_iommu_probe(struct platform_device *pdev)
 	}
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	data->base = devm_ioremap_resource(dev, res);
-	if (IS_ERR(data->base))
-		return PTR_ERR(data->base);
+	base = devm_ioremap_resource(dev, res);
+	if (IS_ERR(base))
+		return PTR_ERR(base);
 	ioaddr = res->start;
 
-	data->irq = platform_get_irq(pdev, 0);
-	if (data->irq < 0)
-		return data->irq;
+	bank = &data->bank[0];
+	bank->id = 0;
+	bank->base = base;
+	bank->irq = platform_get_irq(pdev, 0);
+	if (bank->irq < 0)
+		return bank->irq;
+	bank->pdev = dev;
+	bank->pdata = data;
+	spin_lock_init(&bank->tlb_lock);
 
 	if (MTK_IOMMU_HAS_FLAG(data->plat_data, HAS_BCLK)) {
 		data->bclk = devm_clk_get(dev, "bclk");
@@ -964,8 +984,6 @@ static int mtk_iommu_probe(struct platform_device *pdev)
 	if (ret)
 		goto out_sysfs_remove;
 
-	spin_lock_init(&data->tlb_lock);
-
 	if (MTK_IOMMU_HAS_FLAG(data->plat_data, SHARE_PGTABLE)) {
 		list_add_tail(&data->list, data->plat_data->hw_list);
 		data->hw_list = data->plat_data->hw_list;
@@ -1015,6 +1033,7 @@ static int mtk_iommu_probe(struct platform_device *pdev)
 static int mtk_iommu_remove(struct platform_device *pdev)
 {
 	struct mtk_iommu_data *data = platform_get_drvdata(pdev);
+	struct mtk_iommu_bank_data *bank = &data->bank[0];
 
 	iommu_device_sysfs_remove(&data->iommu);
 	iommu_device_unregister(&data->iommu);
@@ -1031,7 +1050,7 @@ static int mtk_iommu_remove(struct platform_device *pdev)
 		#endif
 	}
 	pm_runtime_disable(&pdev->dev);
-	devm_free_irq(&pdev->dev, data->irq, data);
+	devm_free_irq(&pdev->dev, bank->irq, bank);
 	return 0;
 }
 
@@ -1039,7 +1058,7 @@ static int __maybe_unused mtk_iommu_runtime_suspend(struct device *dev)
 {
 	struct mtk_iommu_data *data = dev_get_drvdata(dev);
 	struct mtk_iommu_suspend_reg *reg = &data->reg;
-	void __iomem *base = data->base;
+	void __iomem *base = data->bank[0].base;
 
 	reg->wr_len_ctrl = readl_relaxed(base + REG_MMU_WR_LEN_CTRL);
 	reg->misc_ctrl = readl_relaxed(base + REG_MMU_MISC_CTRL);
@@ -1057,8 +1076,8 @@ static int __maybe_unused mtk_iommu_runtime_resume(struct device *dev)
 {
 	struct mtk_iommu_data *data = dev_get_drvdata(dev);
 	struct mtk_iommu_suspend_reg *reg = &data->reg;
-	struct mtk_iommu_domain *m4u_dom = data->m4u_dom;
-	void __iomem *base = data->base;
+	struct mtk_iommu_domain *m4u_dom = data->bank[0].m4u_dom;
+	void __iomem *base = data->bank[0].base;
 	int ret;
 
 	ret = clk_prepare_enable(data->bclk);
diff --git a/drivers/iommu/mtk_iommu.h b/drivers/iommu/mtk_iommu.h
index a9dc79c5a724..881fade8d39a 100644
--- a/drivers/iommu/mtk_iommu.h
+++ b/drivers/iommu/mtk_iommu.h
@@ -24,6 +24,8 @@
 
 #define MTK_IOMMU_GROUP_MAX	8
 
+#define MTK_IOMMU_BANK_MAX	5
+
 struct mtk_iommu_suspend_reg {
 	union {
 		u32			standard_axi_mode;/* v1 */
@@ -65,17 +67,33 @@ struct mtk_iommu_plat_data {
 
 struct mtk_iommu_domain;
 
-struct mtk_iommu_data {
+struct mtk_iommu_bank_data {
 	void __iomem			*base;
 	int				irq;
+	unsigned int			id;
+	struct device			*pdev;
+	struct mtk_iommu_data		*pdata;   /* parent data */
+	spinlock_t			tlb_lock; /* lock for tlb range flush */
+	struct mtk_iommu_domain		*m4u_dom; /* Each bank has a domain */
+};
+
+struct mtk_iommu_data {
+	union {
+		struct { /* only for gen1 */
+			void __iomem		*base;
+			int			irq;
+			struct mtk_iommu_domain	*m4u_dom;
+		};
+
+		/* only for gen2 that support multi-banks */
+		struct mtk_iommu_bank_data	bank[MTK_IOMMU_BANK_MAX];
+	};
 	struct device			*dev;
 	struct clk			*bclk;
 	phys_addr_t			protect_base; /* protect memory base */
 	struct mtk_iommu_suspend_reg	reg;
-	struct mtk_iommu_domain		*m4u_dom;
 	struct iommu_group		*m4u_group[MTK_IOMMU_GROUP_MAX];
 	bool                            enable_4GB;
-	spinlock_t			tlb_lock; /* lock for tlb range flush */
 
 	struct iommu_device		iommu;
 	const struct mtk_iommu_plat_data *plat_data;
-- 
2.18.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
