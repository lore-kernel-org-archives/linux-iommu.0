Return-Path: <SRS0=ghiB=SM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7144EC10F11
	for <iommu@archiver.kernel.org>; Wed, 10 Apr 2019 16:15:04 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F7FA20830
	for <iommu@archiver.kernel.org>; Wed, 10 Apr 2019 16:15:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WtvcBF8i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F7FA20830
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id E8C4A1AB2;
	Wed, 10 Apr 2019 16:14:53 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 204D21AA3
	for <iommu@lists.linux-foundation.org>;
	Wed, 10 Apr 2019 16:14:40 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from bombadil.infradead.org (bombadil.infradead.org
	[198.137.202.133])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 91703875
	for <iommu@lists.linux-foundation.org>;
	Wed, 10 Apr 2019 16:14:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=t4DvbWjCbRB13850AG+KyUWoUR6hkpPD5Ees5o/2BYY=;
	b=WtvcBF8i/dOh4zsja5feb2JXO8
	hthAVECvzCa+XZuiawl0F2XWb6MqGpZsvFPtjdV4qn/tc87BjbVA9Qbz8reKtHJ22Dru4bMV2yFmx
	xLk0QHxKF7vmCBgKR24w/faDjle6UqU11rPIUJU0jHVyK2L7q7Li4BsRiqYESnv74VNJ3SbEkMf7b
	uP7yXr7nJQywJ9X7I6EAUChYtx2/3OS7S/1JOitj6MaNP8soO2PYKvtwOiCa6XRL8xMJrMocAy/as
	5xkRPtJPNo+0WtkeWlDnzQjrENgCy9wkNVWWWf9yuyAEwyGAB8XxsXkuDW5gCyEXpA1iPk0dPoVgA
	Hq2HySwg==;
Received: from 089144214194.atnat0023.highway.a1.net ([89.144.214.194]
	helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
	id 1hEFrx-0007OK-7o; Wed, 10 Apr 2019 16:14:37 +0000
From: Christoph Hellwig <hch@lst.de>
To: David Woodhouse <dwmw2@infradead.org>,
	Joerg Roedel <joro@8bytes.org>
Subject: [PATCH 2/3] intel-iommu: use dma_direct for bypass devices
Date: Wed, 10 Apr 2019 18:14:07 +0200
Message-Id: <20190410161408.7119-3-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190410161408.7119-1-hch@lst.de>
References: <20190410161408.7119-1-hch@lst.de>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
	bombadil.infradead.org. See http://www.infradead.org/rpr.html
Cc: iommu@lists.linux-foundation.org
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org
Message-ID: <20190410161407.K8Y4mcC186OLZn9nCQdz6kCxKexe7U75A4yxF2kyssc@z>

The intel-iommu driver currently has a partial reimplementation
of the direct mapping code for devices that use pass through
mode.  Replace that code with calls to the relevant dma_direct
routines at the highest level.  This means we have exactly the
same behvior as the dma direct code itself, and can prepare for
eventually only attaching the intel_iommu ops to devices that
actually need dynamic iommu mappings.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/iommu/intel-iommu.c | 71 ++++++++++++++++---------------------
 1 file changed, 31 insertions(+), 40 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 121a0cb450df..497217cb0880 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -3655,9 +3655,6 @@ static dma_addr_t __intel_map_single(struct device *dev, phys_addr_t paddr,
 
 	BUG_ON(dir == DMA_NONE);
 
-	if (!iommu_need_mapping(dev))
-		return paddr;
-
 	domain = get_valid_domain_for_dev(dev);
 	if (!domain)
 		return DMA_MAPPING_ERROR;
@@ -3706,15 +3703,20 @@ static dma_addr_t intel_map_page(struct device *dev, struct page *page,
 				 enum dma_data_direction dir,
 				 unsigned long attrs)
 {
-	return __intel_map_single(dev, page_to_phys(page) + offset, size,
-				  dir, *dev->dma_mask);
+	if (iommu_need_mapping(dev))
+		return __intel_map_single(dev, page_to_phys(page) + offset,
+				size, dir, *dev->dma_mask);
+	return dma_direct_map_page(dev, page, offset, size, dir, attrs);
 }
 
 static dma_addr_t intel_map_resource(struct device *dev, phys_addr_t phys_addr,
 				     size_t size, enum dma_data_direction dir,
 				     unsigned long attrs)
 {
-	return __intel_map_single(dev, phys_addr, size, dir, *dev->dma_mask);
+	if (iommu_need_mapping(dev))
+		return __intel_map_single(dev, phys_addr, size, dir,
+				*dev->dma_mask);
+	return dma_direct_map_resource(dev, phys_addr, size, dir, attrs);
 }
 
 static void intel_unmap(struct device *dev, dma_addr_t dev_addr, size_t size)
@@ -3726,9 +3728,6 @@ static void intel_unmap(struct device *dev, dma_addr_t dev_addr, size_t size)
 	struct intel_iommu *iommu;
 	struct page *freelist;
 
-	if (!iommu_need_mapping(dev))
-		return;
-
 	domain = find_domain(dev);
 	BUG_ON(!domain);
 
@@ -3764,7 +3763,17 @@ static void intel_unmap_page(struct device *dev, dma_addr_t dev_addr,
 			     size_t size, enum dma_data_direction dir,
 			     unsigned long attrs)
 {
-	intel_unmap(dev, dev_addr, size);
+	if (iommu_need_mapping(dev))
+		intel_unmap(dev, dev_addr, size);
+	else
+		dma_direct_unmap_page(dev, dev_addr, size, dir, attrs);
+}
+
+static void intel_unmap_resource(struct device *dev, dma_addr_t dev_addr,
+		size_t size, enum dma_data_direction dir, unsigned long attrs)
+{
+	if (iommu_need_mapping(dev))
+		intel_unmap(dev, dev_addr, size);
 }
 
 static void *intel_alloc_coherent(struct device *dev, size_t size,
@@ -3774,28 +3783,18 @@ static void *intel_alloc_coherent(struct device *dev, size_t size,
 	struct page *page = NULL;
 	int order;
 
+	if (!iommu_need_mapping(dev))
+		return dma_direct_alloc(dev, size, dma_handle, flags, attrs);
+
 	size = PAGE_ALIGN(size);
 	order = get_order(size);
-
-	if (iommu_need_mapping(dev))
-		flags &= ~(GFP_DMA | GFP_DMA32);
-	else if (dev->coherent_dma_mask < dma_get_required_mask(dev)) {
-		if (dev->coherent_dma_mask < DMA_BIT_MASK(32))
-			flags |= GFP_DMA;
-		else
-			flags |= GFP_DMA32;
-	}
+	flags &= ~(GFP_DMA | GFP_DMA32);
 
 	if (gfpflags_allow_blocking(flags)) {
 		unsigned int count = size >> PAGE_SHIFT;
 
 		page = dma_alloc_from_contiguous(dev, count, order,
 						 flags & __GFP_NOWARN);
-		if (page && !iommu_need_mapping(dev) &&
-		    page_to_phys(page) + size > dev->coherent_dma_mask) {
-			dma_release_from_contiguous(dev, page, count);
-			page = NULL;
-		}
 	}
 
 	if (!page)
@@ -3821,6 +3820,9 @@ static void intel_free_coherent(struct device *dev, size_t size, void *vaddr,
 	int order;
 	struct page *page = virt_to_page(vaddr);
 
+	if (!iommu_need_mapping(dev))
+		return dma_direct_free(dev, size, vaddr, dma_handle, attrs);
+
 	size = PAGE_ALIGN(size);
 	order = get_order(size);
 
@@ -3838,6 +3840,9 @@ static void intel_unmap_sg(struct device *dev, struct scatterlist *sglist,
 	struct scatterlist *sg;
 	int i;
 
+	if (!iommu_need_mapping(dev))
+		return dma_direct_unmap_sg(dev, sglist, nelems, dir, attrs);
+
 	for_each_sg(sglist, sg, nelems, i) {
 		nrpages += aligned_nrpages(sg_dma_address(sg), sg_dma_len(sg));
 	}
@@ -3845,20 +3850,6 @@ static void intel_unmap_sg(struct device *dev, struct scatterlist *sglist,
 	intel_unmap(dev, startaddr, nrpages << VTD_PAGE_SHIFT);
 }
 
-static int intel_nontranslate_map_sg(struct device *hddev,
-	struct scatterlist *sglist, int nelems, int dir)
-{
-	int i;
-	struct scatterlist *sg;
-
-	for_each_sg(sglist, sg, nelems, i) {
-		BUG_ON(!sg_page(sg));
-		sg->dma_address = sg_phys(sg);
-		sg->dma_length = sg->length;
-	}
-	return nelems;
-}
-
 static int intel_map_sg(struct device *dev, struct scatterlist *sglist, int nelems,
 			enum dma_data_direction dir, unsigned long attrs)
 {
@@ -3874,7 +3865,7 @@ static int intel_map_sg(struct device *dev, struct scatterlist *sglist, int nele
 
 	BUG_ON(dir == DMA_NONE);
 	if (!iommu_need_mapping(dev))
-		return intel_nontranslate_map_sg(dev, sglist, nelems, dir);
+		return dma_direct_map_sg(dev, sglist, nelems, dir, attrs);
 
 	domain = get_valid_domain_for_dev(dev);
 	if (!domain)
@@ -3924,7 +3915,7 @@ static const struct dma_map_ops intel_dma_ops = {
 	.map_page = intel_map_page,
 	.unmap_page = intel_unmap_page,
 	.map_resource = intel_map_resource,
-	.unmap_resource = intel_unmap_page,
+	.unmap_resource = intel_unmap_resource,
 	.dma_supported = dma_direct_supported,
 };
 
-- 
2.20.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
