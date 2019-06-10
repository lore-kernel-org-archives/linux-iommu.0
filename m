Return-Path: <SRS0=ZsFK=UJ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5362CC282DD
	for <iommu@archiver.kernel.org>; Mon, 10 Jun 2019 12:24:51 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3685120859
	for <iommu@archiver.kernel.org>; Mon, 10 Jun 2019 12:24:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3685120859
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 07F3BC58;
	Mon, 10 Jun 2019 12:24:51 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id F010C255
	for <iommu@lists.linux-foundation.org>;
	Mon, 10 Jun 2019 12:24:49 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id EDF3C76F
	for <iommu@lists.linux-foundation.org>;
	Mon, 10 Jun 2019 12:24:48 +0000 (UTC)
X-UUID: 7192fe0e9eb64b79bbc2648a1893aaf5-20190610
X-UUID: 7192fe0e9eb64b79bbc2648a1893aaf5-20190610
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by
	mailgw02.mediatek.com (envelope-from <yong.wu@mediatek.com>)
	(mhqrelay.mediatek.com ESMTP with TLS)
	with ESMTP id 1556585299; Mon, 10 Jun 2019 20:19:42 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
	mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server
	(TLS) id 15.0.1395.4; Mon, 10 Jun 2019 20:19:42 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas07.mediatek.inc
	(172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
	Transport; Mon, 10 Jun 2019 20:19:40 +0800
From: Yong Wu <yong.wu@mediatek.com>
To: Joerg Roedel <joro@8bytes.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
	Robin Murphy <robin.murphy@arm.com>, Rob Herring <robh+dt@kernel.org>
Subject: [PATCH v7 06/21] iommu/io-pgtable-arm-v7s: Extend MediaTek 4GB Mode
Date: Mon, 10 Jun 2019 20:17:45 +0800
Message-ID: <1560169080-27134-7-git-send-email-yong.wu@mediatek.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1560169080-27134-1-git-send-email-yong.wu@mediatek.com>
References: <1560169080-27134-1-git-send-email-yong.wu@mediatek.com>
MIME-Version: 1.0
X-MTK: N
Cc: youlin.pei@mediatek.com, devicetree@vger.kernel.org,
	Nicolas Boichat <drinkcat@chromium.org>,
	srv_heupstream@mediatek.com, Will Deacon <will.deacon@arm.com>,
	linux-kernel@vger.kernel.org, Evan Green <evgreen@chromium.org>,
	Tomasz Figa <tfiga@google.com>, iommu@lists.linux-foundation.org,
	Matthias Kaehlcke <mka@chromium.org>,
	linux-mediatek@lists.infradead.org, yingjoe.chen@mediatek.com,
	anan.sun@mediatek.com, linux-arm-kernel@lists.infradead.org
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

MediaTek extend the arm v7s descriptor to support the dram over 4GB.

In the mt2712 and mt8173, it's called "4GB mode", the physical address
is from 0x4000_0000 to 0x1_3fff_ffff, but from EMI point of view, it
is remapped to high address from 0x1_0000_0000 to 0x1_ffff_ffff, the
bit32 is always enabled. thus, in the M4U, we always enable the bit9
for all PTEs which means to enable bit32 of physical address.

but in mt8183, M4U support the dram from 0x4000_0000 to 0x3_ffff_ffff
which isn't remaped. We extend the PTEs: the bit9 represent bit32 of
PA and the bit4 represent bit33 of PA. Meanwhile the iova still is
32bits.

In order to unify code, in the "4GB mode", we add the bit32 for the
physical address manually in our driver.

Correspondingly, Adding bit32 and bit33 for the PA in the iova_to_phys
has to been moved into v7s.

Regarding whether the pagetable address could be over 4GB, the mt8183
support it while the previous mt8173 don't. thus keep it as is.

Signed-off-by: Yong Wu <yong.wu@mediatek.com>
Reviewed-by: Robin Murphy <robin.murphy@arm.com>
Reviewed-by: Evan Green <evgreen@chromium.org>
---
 drivers/iommu/io-pgtable-arm-v7s.c | 31 ++++++++++++++++++++++++-------
 drivers/iommu/mtk_iommu.c          | 20 ++++++++++----------
 drivers/iommu/mtk_iommu.h          |  1 +
 3 files changed, 35 insertions(+), 17 deletions(-)

diff --git a/drivers/iommu/io-pgtable-arm-v7s.c b/drivers/iommu/io-pgtable-arm-v7s.c
index 94c38db..4077822 100644
--- a/drivers/iommu/io-pgtable-arm-v7s.c
+++ b/drivers/iommu/io-pgtable-arm-v7s.c
@@ -123,7 +123,9 @@
 #define ARM_V7S_TEX_MASK		0x7
 #define ARM_V7S_ATTR_TEX(val)		(((val) & ARM_V7S_TEX_MASK) << ARM_V7S_TEX_SHIFT)
 
-#define ARM_V7S_ATTR_MTK_4GB		BIT(9) /* MTK extend it for 4GB mode */
+/* MediaTek extend the two bits below for over 4GB mode */
+#define ARM_V7S_ATTR_MTK_PA_BIT32	BIT(9)
+#define ARM_V7S_ATTR_MTK_PA_BIT33	BIT(4)
 
 /* *well, except for TEX on level 2 large pages, of course :( */
 #define ARM_V7S_CONT_PAGE_TEX_SHIFT	6
@@ -190,13 +192,22 @@ static dma_addr_t __arm_v7s_dma_addr(void *pages)
 static arm_v7s_iopte paddr_to_iopte(phys_addr_t paddr, int lvl,
 				    struct io_pgtable_cfg *cfg)
 {
-	return paddr & ARM_V7S_LVL_MASK(lvl);
+	arm_v7s_iopte pte = paddr & ARM_V7S_LVL_MASK(lvl);
+
+	if (cfg->quirks & IO_PGTABLE_QUIRK_ARM_MTK_4GB) {
+		if (paddr & BIT_ULL(32))
+			pte |= ARM_V7S_ATTR_MTK_PA_BIT32;
+		if (paddr & BIT_ULL(33))
+			pte |= ARM_V7S_ATTR_MTK_PA_BIT33;
+	}
+	return pte;
 }
 
 static phys_addr_t iopte_to_paddr(arm_v7s_iopte pte, int lvl,
 				  struct io_pgtable_cfg *cfg)
 {
 	arm_v7s_iopte mask;
+	phys_addr_t paddr;
 
 	if (ARM_V7S_PTE_IS_TABLE(pte, lvl))
 		mask = ARM_V7S_TABLE_MASK;
@@ -205,7 +216,14 @@ static phys_addr_t iopte_to_paddr(arm_v7s_iopte pte, int lvl,
 	else
 		mask = ARM_V7S_LVL_MASK(lvl);
 
-	return pte & mask;
+	paddr = pte & mask;
+	if (cfg->quirks & IO_PGTABLE_QUIRK_ARM_MTK_4GB) {
+		if (pte & ARM_V7S_ATTR_MTK_PA_BIT32)
+			paddr |= BIT_ULL(32);
+		if (pte & ARM_V7S_ATTR_MTK_PA_BIT33)
+			paddr |= BIT_ULL(33);
+	}
+	return paddr;
 }
 
 static arm_v7s_iopte *iopte_deref(arm_v7s_iopte pte, int lvl,
@@ -326,9 +344,6 @@ static arm_v7s_iopte arm_v7s_prot_to_pte(int prot, int lvl,
 	if (lvl == 1 && (cfg->quirks & IO_PGTABLE_QUIRK_ARM_NS))
 		pte |= ARM_V7S_ATTR_NS_SECTION;
 
-	if (cfg->quirks & IO_PGTABLE_QUIRK_ARM_MTK_4GB)
-		pte |= ARM_V7S_ATTR_MTK_4GB;
-
 	return pte;
 }
 
@@ -515,7 +530,9 @@ static int arm_v7s_map(struct io_pgtable_ops *ops, unsigned long iova,
 	if (!(prot & (IOMMU_READ | IOMMU_WRITE)))
 		return 0;
 
-	if (WARN_ON(upper_32_bits(iova) || upper_32_bits(paddr)))
+	if (WARN_ON(upper_32_bits(iova)) ||
+	    WARN_ON(upper_32_bits(paddr) &&
+		    !(iop->cfg.quirks & IO_PGTABLE_QUIRK_ARM_MTK_4GB)))
 		return -ERANGE;
 
 	ret = __arm_v7s_map(data, iova, paddr, size, prot, 1, data->pgd);
diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index 1ddb2b7..aff5004 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -271,7 +271,8 @@ static int mtk_iommu_domain_finalise(struct mtk_iommu_domain *dom)
 	dom->cfg = (struct io_pgtable_cfg) {
 		.quirks = IO_PGTABLE_QUIRK_ARM_NS |
 			IO_PGTABLE_QUIRK_NO_PERMS |
-			IO_PGTABLE_QUIRK_TLBI_ON_MAP,
+			IO_PGTABLE_QUIRK_TLBI_ON_MAP |
+			IO_PGTABLE_QUIRK_ARM_MTK_4GB,
 		.pgsize_bitmap = mtk_iommu_ops.pgsize_bitmap,
 		.ias = 32,
 		.oas = 32,
@@ -279,9 +280,6 @@ static int mtk_iommu_domain_finalise(struct mtk_iommu_domain *dom)
 		.iommu_dev = data->dev,
 	};
 
-	if (data->enable_4GB)
-		dom->cfg.quirks |= IO_PGTABLE_QUIRK_ARM_MTK_4GB;
-
 	dom->iop = alloc_io_pgtable_ops(ARM_V7S, &dom->cfg, data);
 	if (!dom->iop) {
 		dev_err(data->dev, "Failed to alloc io pgtable\n");
@@ -367,12 +365,16 @@ static int mtk_iommu_map(struct iommu_domain *domain, unsigned long iova,
 			 phys_addr_t paddr, size_t size, int prot)
 {
 	struct mtk_iommu_domain *dom = to_mtk_domain(domain);
+	struct mtk_iommu_data *data = mtk_iommu_get_m4u_data();
 	unsigned long flags;
 	int ret;
 
+	/* The "4GB mode" M4U physically can not use the lower remap of Dram. */
+	if (data->plat_data->has_4gb_mode && data->enable_4GB)
+		paddr |= BIT_ULL(32);
+
 	spin_lock_irqsave(&dom->pgtlock, flags);
-	ret = dom->iop->map(dom->iop, iova, paddr & DMA_BIT_MASK(32),
-			    size, prot);
+	ret = dom->iop->map(dom->iop, iova, paddr, size, prot);
 	spin_unlock_irqrestore(&dom->pgtlock, flags);
 
 	return ret;
@@ -401,7 +403,6 @@ static phys_addr_t mtk_iommu_iova_to_phys(struct iommu_domain *domain,
 					  dma_addr_t iova)
 {
 	struct mtk_iommu_domain *dom = to_mtk_domain(domain);
-	struct mtk_iommu_data *data = mtk_iommu_get_m4u_data();
 	unsigned long flags;
 	phys_addr_t pa;
 
@@ -409,9 +410,6 @@ static phys_addr_t mtk_iommu_iova_to_phys(struct iommu_domain *domain,
 	pa = dom->iop->iova_to_phys(dom->iop, iova);
 	spin_unlock_irqrestore(&dom->pgtlock, flags);
 
-	if (data->enable_4GB)
-		pa |= BIT_ULL(32);
-
 	return pa;
 }
 
@@ -742,10 +740,12 @@ static int __maybe_unused mtk_iommu_resume(struct device *dev)
 
 static const struct mtk_iommu_plat_data mt2712_data = {
 	.m4u_plat     = M4U_MT2712,
+	.has_4gb_mode = true,
 };
 
 static const struct mtk_iommu_plat_data mt8173_data = {
 	.m4u_plat     = M4U_MT8173,
+	.has_4gb_mode = true,
 };
 
 static const struct of_device_id mtk_iommu_of_ids[] = {
diff --git a/drivers/iommu/mtk_iommu.h b/drivers/iommu/mtk_iommu.h
index 483d210..d7a001a 100644
--- a/drivers/iommu/mtk_iommu.h
+++ b/drivers/iommu/mtk_iommu.h
@@ -42,6 +42,7 @@ enum mtk_iommu_plat {
 
 struct mtk_iommu_plat_data {
 	enum mtk_iommu_plat m4u_plat;
+	bool                has_4gb_mode;
 };
 
 struct mtk_iommu_domain;
-- 
1.9.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
