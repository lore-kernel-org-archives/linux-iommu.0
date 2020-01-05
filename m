Return-Path: <SRS0=m4R2=22=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D50D8C33C8C
	for <iommu@archiver.kernel.org>; Sun,  5 Jan 2020 10:52:10 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB2C121582
	for <iommu@archiver.kernel.org>; Sun,  5 Jan 2020 10:52:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="YGljSC8q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB2C121582
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 9989D85D26;
	Sun,  5 Jan 2020 10:52:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UFvh4+yTS9io; Sun,  5 Jan 2020 10:52:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 1082B85CE0;
	Sun,  5 Jan 2020 10:52:10 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F26BCC1D84;
	Sun,  5 Jan 2020 10:52:09 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 50723C0881
 for <iommu@lists.linux-foundation.org>; Sun,  5 Jan 2020 10:52:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 4CB2A85CE0
 for <iommu@lists.linux-foundation.org>; Sun,  5 Jan 2020 10:52:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id d0MP2ajFGhIG for <iommu@lists.linux-foundation.org>;
 Sun,  5 Jan 2020 10:52:06 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 by whitealder.osuosl.org (Postfix) with ESMTP id 5086185CC7
 for <iommu@lists.linux-foundation.org>; Sun,  5 Jan 2020 10:52:06 +0000 (UTC)
X-UUID: ed6921aaaf3e44569e2117d59d61f7c9-20200105
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From;
 bh=wzv+DS2QU8JGS/oClDBJUbQzay4lYYCHyz03iNL5uvs=; 
 b=YGljSC8q8V0BRi4imizn3RnSB2cTy4/hf4KslC+BzSMYe9Bq3Dm7MT9BxXOJsIOMDSEgOTCRcASbPKJiJby67h+sBectUDNtxlxaRxWxJ3FrNS653qkxaWlt9BM1pcPclGg++ZQEDIyC/0Vwxu+NwiDqkVZAi9Ofnh9PK8bj5/c=;
X-UUID: ed6921aaaf3e44569e2117d59d61f7c9-20200105
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by
 mailgw02.mediatek.com (envelope-from <chao.hao@mediatek.com>)
 (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
 with ESMTP id 1008748616; Sun, 05 Jan 2020 18:47:02 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Sun, 5 Jan 2020 18:46:35 +0800
Received: from localhost.localdomain (10.15.20.246) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Sun, 5 Jan 2020 18:45:32 +0800
From: Chao Hao <chao.hao@mediatek.com>
To: Joerg Roedel <joro@8bytes.org>, Rob Herring <robh+dt@kernel.org>, Matthias
 Brugger <matthias.bgg@gmail.com>
Subject: [PATCH v2 11/19] iommu/mediatek: Remove pgtable info in
 mtk_iommu_domain
Date: Sun, 5 Jan 2020 18:45:15 +0800
Message-ID: <20200105104523.31006-12-chao.hao@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20200105104523.31006-1-chao.hao@mediatek.com>
References: <20200105104523.31006-1-chao.hao@mediatek.com>
MIME-Version: 1.0
X-MTK: N
Cc: Anan Sun <anan.sun@mediatek.com>, devicetree@vger.kernel.org,
 Jun Yan <jun.yan@mediatek.com>, wsd_upstream@mediatek.com,
 linux-kernel@vger.kernel.org, Chao Hao <chao.hao@mediatek.com>,
 iommu@lists.linux-foundation.org, linux-mediatek@lists.infradead.org,
 Cui Zhang <zhang.cui@mediatek.com>, linux-arm-kernel@lists.infradead.org
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

This patch will use mtk_iommu_pgtable to replace the part
of pgtable in mtk_iommu_domain, so we can remove the information
of pgtable in mtk_iommu_domain.

Signed-off-by: Chao Hao <chao.hao@mediatek.com>
---
 drivers/iommu/mtk_iommu.c | 37 +++++++++++++++++--------------------
 1 file changed, 17 insertions(+), 20 deletions(-)

diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index cfefdd638f1a..b34bd3abccf8 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -111,9 +111,6 @@
 #define MTK_M4U_TO_PORT(id)		((id) & 0x1f)
 
 struct mtk_iommu_domain {
-	struct io_pgtable_cfg		cfg;
-	struct io_pgtable_ops		*iop;
-
 	struct iommu_domain		domain;
 };
 
@@ -373,6 +370,10 @@ static int mtk_iommu_attach_pgtable(struct mtk_iommu_data *data,
 	/* binding to pgtable */
 	data->pgtable = pgtable;
 
+	/* update HW settings */
+	writel(pgtable->cfg.arm_v7s_cfg.ttbr[0] & MMU_PT_ADDR_MASK,
+	       data->base + REG_MMU_PT_BASE_ADDR);
+
 	dev_info(data->dev, "m4u%d attach_pgtable done!\n", data->m4u_id);
 
 	return 0;
@@ -398,8 +399,6 @@ static struct iommu_domain *mtk_iommu_domain_alloc(unsigned type)
 	if (iommu_get_dma_cookie(&dom->domain))
 		goto  free_dom;
 
-	dom->cfg = pgtable->cfg;
-	dom->iop = pgtable->iop;
 	/* Update our support page sizes bitmap */
 	dom->domain.pgsize_bitmap = pgtable->cfg.pgsize_bitmap;
 
@@ -416,11 +415,12 @@ static struct iommu_domain *mtk_iommu_domain_alloc(unsigned type)
 
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
@@ -433,11 +433,8 @@ static int mtk_iommu_attach_device(struct iommu_domain *domain,
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
@@ -457,7 +454,7 @@ static void mtk_iommu_detach_device(struct iommu_domain *domain,
 static int mtk_iommu_map(struct iommu_domain *domain, unsigned long iova,
 			 phys_addr_t paddr, size_t size, int prot, gfp_t gfp)
 {
-	struct mtk_iommu_domain *dom = to_mtk_domain(domain);
+	struct mtk_iommu_pgtable *pgtable = mtk_iommu_get_pgtable();
 	struct mtk_iommu_data *data = mtk_iommu_get_m4u_data();
 
 	/* The "4GB mode" M4U physically can not use the lower remap of Dram. */
@@ -465,16 +462,16 @@ static int mtk_iommu_map(struct iommu_domain *domain, unsigned long iova,
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
@@ -498,11 +495,11 @@ static void mtk_iommu_iotlb_sync(struct iommu_domain *domain,
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
 
@@ -845,8 +842,8 @@ static int __maybe_unused mtk_iommu_suspend(struct device *dev)
 static int __maybe_unused mtk_iommu_resume(struct device *dev)
 {
 	struct mtk_iommu_data *data = dev_get_drvdata(dev);
+	struct mtk_iommu_pgtable *pgtable = data->pgtable;
 	struct mtk_iommu_suspend_reg *reg = &data->reg;
-	struct mtk_iommu_domain *m4u_dom = data->m4u_dom;
 	void __iomem *base = data->base;
 	int ret;
 
@@ -864,8 +861,8 @@ static int __maybe_unused mtk_iommu_resume(struct device *dev)
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
