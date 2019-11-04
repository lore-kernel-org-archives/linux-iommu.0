Return-Path: <SRS0=uwQI=Y4=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D260CA9ECF
	for <iommu@archiver.kernel.org>; Mon,  4 Nov 2019 11:53:07 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 28A7721E6F
	for <iommu@archiver.kernel.org>; Mon,  4 Nov 2019 11:53:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28A7721E6F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 29786EFE;
	Mon,  4 Nov 2019 11:53:00 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 06E15EF6
	for <iommu@lists.linux-foundation.org>;
	Mon,  4 Nov 2019 11:52:59 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	by smtp1.linuxfoundation.org (Postfix) with ESMTP id 22AD68A8
	for <iommu@lists.linux-foundation.org>;
	Mon,  4 Nov 2019 11:52:57 +0000 (UTC)
X-UUID: 0b8c457d4857446a91e74a38d8c14806-20191104
X-UUID: 0b8c457d4857446a91e74a38d8c14806-20191104
Received: from mtkcas09.mediatek.inc [(172.21.101.178)] by
	mailgw02.mediatek.com (envelope-from <chao.hao@mediatek.com>)
	(Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
	with ESMTP id 455068893; Mon, 04 Nov 2019 19:52:54 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
	mtkmbs06n2.mediatek.inc (172.21.101.130) with Microsoft SMTP Server
	(TLS) id 15.0.1395.4; Mon, 4 Nov 2019 19:52:52 +0800
Received: from localhost.localdomain (10.15.20.246) by MTKCAS06.mediatek.inc
	(172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
	Transport; Mon, 4 Nov 2019 19:52:48 +0800
From: Chao Hao <chao.hao@mediatek.com>
To: Joerg Roedel <joro@8bytes.org>, Rob Herring <robh+dt@kernel.org>, Matthias
	Brugger <matthias.bgg@gmail.com>
Subject: [RESEND,
	PATCH 05/13] iommu/mediatek: Remove pgtable info in mtk_iommu_domain
Date: Mon, 4 Nov 2019 19:52:30 +0800
Message-ID: <20191104115238.2394-6-chao.hao@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20191104115238.2394-1-chao.hao@mediatek.com>
References: <20191104115238.2394-1-chao.hao@mediatek.com>
MIME-Version: 1.0
X-TM-SNTS-SMTP: 4F9ED66731A35343C8300A3A7FFACDAA6F5CFFF43922DCCCA9CA71AF5322E28B2000:8
X-MTK: N
Cc: Anan Sun <anan.sun@mediatek.com>, devicetree@vger.kernel.org,
	Cui Zhang <cui.zhang@mediatek.com>,
	Jun Yan <jun.yan@mediatek.com>, wsd_upstream@mediatek.com,
	linux-kernel@vger.kernel.org, Chao Hao <chao.hao@mediatek.com>,
	iommu@lists.linux-foundation.org, linux-mediatek@lists.infradead.org,
	Miles Chen <miles.chen@mediatek.com>, linux-arm-kernel@lists.infradead.org,
	Guangming Cao <guangming.cao@mediatek.com>
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

This patch will use mtk_iommu_pgtable to replace the part
of pgtable in mtk_iommu_domain, so we can remove the information
of pgtable in mtk_iommu_domain.

Signed-off-by: Chao Hao <chao.hao@mediatek.com>
---
 drivers/iommu/mtk_iommu.c | 37 +++++++++++++++++--------------------
 1 file changed, 17 insertions(+), 20 deletions(-)

diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index 3fa09b12e9f9..f264fa8c16a0 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -117,9 +117,6 @@
 #define MTK_M4U_TO_PORT(id)		((id) & 0x1f)
 
 struct mtk_iommu_domain {
-	struct io_pgtable_cfg		cfg;
-	struct io_pgtable_ops		*iop;
-
 	struct iommu_domain		domain;
 };
 
@@ -379,6 +376,10 @@ static int mtk_iommu_attach_pgtable(struct mtk_iommu_data *data,
 	/* binding to pgtable */
 	data->pgtable = pgtable;
 
+	/* update HW settings */
+	writel(pgtable->cfg.arm_v7s_cfg.ttbr[0] & MMU_PT_ADDR_MASK,
+	       data->base + REG_MMU_PT_BASE_ADDR);
+
 	dev_info(data->dev, "m4u%d attach_pgtable done!\n", data->m4u_id);
 
 	return 0;
@@ -404,8 +405,6 @@ static struct iommu_domain *mtk_iommu_domain_alloc(unsigned type)
 	if (iommu_get_dma_cookie(&dom->domain))
 		goto  free_dom;
 
-	dom->cfg = pgtable->cfg;
-	dom->iop = pgtable->iop;
 	/* Update our support page sizes bitmap */
 	dom->domain.pgsize_bitmap = pgtable->cfg.pgsize_bitmap;
 
@@ -422,11 +421,12 @@ static struct iommu_domain *mtk_iommu_domain_alloc(unsigned type)
 
 static void mtk_iommu_domain_free(struct iommu_domain *domain)
 {
-	struct mtk_iommu_domain *dom = to_mtk_domain(domain);
+	struct mtk_iommu_pgtable *pgtable = mtk_iommu_get_pgtable();
 
-	free_io_pgtable_ops(dom->iop);
 	iommu_put_dma_cookie(domain);
 	kfree(to_mtk_domain(domain));
+	free_io_pgtable_ops(pgtable->iop);
+	kfree(pgtable);
 }
 
 static int mtk_iommu_attach_device(struct iommu_domain *domain,
@@ -439,11 +439,8 @@ static int mtk_iommu_attach_device(struct iommu_domain *domain,
 		return -ENODEV;
 
 	/* Update the pgtable base address register of the M4U HW */
-	if (!data->m4u_dom) {
+	if (!data->m4u_dom)
 		data->m4u_dom = dom;
-		writel(dom->cfg.arm_v7s_cfg.ttbr[0] & MMU_PT_ADDR_MASK,
-		       data->base + REG_MMU_PT_BASE_ADDR);
-	}
 
 	mtk_iommu_config(data, dev, true);
 	return 0;
@@ -463,7 +460,7 @@ static void mtk_iommu_detach_device(struct iommu_domain *domain,
 static int mtk_iommu_map(struct iommu_domain *domain, unsigned long iova,
 			 phys_addr_t paddr, size_t size, int prot)
 {
-	struct mtk_iommu_domain *dom = to_mtk_domain(domain);
+	struct mtk_iommu_pgtable *pgtable = mtk_iommu_get_pgtable();
 	struct mtk_iommu_data *data = mtk_iommu_get_m4u_data();
 
 	/* The "4GB mode" M4U physically can not use the lower remap of Dram. */
@@ -471,16 +468,16 @@ static int mtk_iommu_map(struct iommu_domain *domain, unsigned long iova,
 		paddr |= BIT_ULL(32);
 
 	/* Synchronize with the tlb_lock */
-	return dom->iop->map(dom->iop, iova, paddr, size, prot);
+	return pgtable->iop->map(pgtable->iop, iova, paddr, size, prot);
 }
 
 static size_t mtk_iommu_unmap(struct iommu_domain *domain,
 			      unsigned long iova, size_t size,
 			      struct iommu_iotlb_gather *gather)
 {
-	struct mtk_iommu_domain *dom = to_mtk_domain(domain);
+	struct mtk_iommu_pgtable *pgtable = mtk_iommu_get_pgtable();
 
-	return dom->iop->unmap(dom->iop, iova, size, gather);
+	return pgtable->iop->unmap(pgtable->iop, iova, size, gather);
 }
 
 static void mtk_iommu_flush_iotlb_all(struct iommu_domain *domain)
@@ -504,11 +501,11 @@ static void mtk_iommu_iotlb_sync(struct iommu_domain *domain,
 static phys_addr_t mtk_iommu_iova_to_phys(struct iommu_domain *domain,
 					  dma_addr_t iova)
 {
-	struct mtk_iommu_domain *dom = to_mtk_domain(domain);
+	struct mtk_iommu_pgtable *pgtable = mtk_iommu_get_pgtable();
 	struct mtk_iommu_data *data = mtk_iommu_get_m4u_data();
 	phys_addr_t pa;
 
-	pa = dom->iop->iova_to_phys(dom->iop, iova);
+	pa = pgtable->iop->iova_to_phys(pgtable->iop, iova);
 	if (data->enable_4GB && pa >= MTK_IOMMU_4GB_MODE_REMAP_BASE)
 		pa &= ~BIT_ULL(32);
 
@@ -850,8 +847,8 @@ static int __maybe_unused mtk_iommu_suspend(struct device *dev)
 static int __maybe_unused mtk_iommu_resume(struct device *dev)
 {
 	struct mtk_iommu_data *data = dev_get_drvdata(dev);
+	struct mtk_iommu_pgtable *pgtable = data->pgtable;
 	struct mtk_iommu_suspend_reg *reg = &data->reg;
-	struct mtk_iommu_domain *m4u_dom = data->m4u_dom;
 	void __iomem *base = data->base;
 	int ret;
 
@@ -869,8 +866,8 @@ static int __maybe_unused mtk_iommu_resume(struct device *dev)
 	writel_relaxed(reg->int_main_control, base + REG_MMU_INT_MAIN_CONTROL);
 	writel_relaxed(reg->ivrp_paddr, base + REG_MMU_IVRP_PADDR);
 	writel_relaxed(reg->vld_pa_rng, base + REG_MMU_VLD_PA_RNG);
-	if (m4u_dom)
-		writel(m4u_dom->cfg.arm_v7s_cfg.ttbr[0] & MMU_PT_ADDR_MASK,
+	if (pgtable)
+		writel(pgtable->cfg.arm_v7s_cfg.ttbr[0] & MMU_PT_ADDR_MASK,
 		       base + REG_MMU_PT_BASE_ADDR);
 	return 0;
 }
-- 
2.18.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
