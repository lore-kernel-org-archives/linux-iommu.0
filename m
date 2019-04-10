Return-Path: <SRS0=ghiB=SM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66786C10F11
	for <iommu@archiver.kernel.org>; Wed, 10 Apr 2019 16:50:54 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 350C620818
	for <iommu@archiver.kernel.org>; Wed, 10 Apr 2019 16:50:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="sCSdELLh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 350C620818
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id CFFCE1B61;
	Wed, 10 Apr 2019 16:50:53 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 1DCD71B44
	for <iommu@lists.linux-foundation.org>;
	Wed, 10 Apr 2019 16:50:38 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from bombadil.infradead.org (bombadil.infradead.org
	[198.137.202.133])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 759B4855
	for <iommu@lists.linux-foundation.org>;
	Wed, 10 Apr 2019 16:50:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=AlOe4uh+ynnRhPEMdnDm2XjrQ2M+QS0NcNpZlmTHAiA=;
	b=sCSdELLhG8AuQu1q5dQgfEXA/
	JmoDqr1G675U3429Y3WWXsSHKDNIlDab6Oun91A5ZOOcu8QfHCej0Pnvwar0SEpGBX8XSYw29EFTu
	bsm8EZNr/PvDRPxylypo3K7MglLCPV9OqqSl9OabtWHPlPz2pBufR2kGBJkGojNeLLCsU5/YiYyfS
	IrKatzx7PFCp2AociS8mei2PUleOSVSCrhwsHW+uYvACYt8lczgTCoNrUo3FbhzzpSALzIECyhcUm
	20mneEu2/p3kxiLU3jDp/dujgEZ8ESoTSY5/WSNG5JFdS4yj7hDe/FNwxxD49ho09pXm2kOrPKN1v
	EwqzM6Q6g==;
Received: from 089144214194.atnat0023.highway.a1.net ([89.144.214.194]
	helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
	id 1hEGQm-0004fI-LO; Wed, 10 Apr 2019 16:50:37 +0000
From: Christoph Hellwig <hch@lst.de>
To: joro@8bytes.org
Subject: [PATCH] iommu/amd: remove the leftover of bypass support
Date: Wed, 10 Apr 2019 18:50:14 +0200
Message-Id: <20190410165014.9932-1-hch@lst.de>
X-Mailer: git-send-email 2.20.1
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
Message-ID: <20190410165014.31i7P6yeaWdsSZabfJdTz1q5IBHNH9xu8n6VUdbnNjg@z>

The AMD iommu dma_ops are only attached on a per-device basis when an
actual translation is needed.  Remove the leftover bypass support which
in parts was already broken (e.g. it always returns 0 from ->map_sg).

Use the opportunity to remove a few local variables and move assignments
into the declaration line where they were previously separated by the
bypass check.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/iommu/amd_iommu.c | 80 +++++++++------------------------------
 1 file changed, 17 insertions(+), 63 deletions(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index f7cdd2ab7f11..982435434c3a 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -2498,20 +2498,10 @@ static dma_addr_t map_page(struct device *dev, struct page *page,
 			   unsigned long attrs)
 {
 	phys_addr_t paddr = page_to_phys(page) + offset;
-	struct protection_domain *domain;
-	struct dma_ops_domain *dma_dom;
-	u64 dma_mask;
-
-	domain = get_domain(dev);
-	if (PTR_ERR(domain) == -EINVAL)
-		return (dma_addr_t)paddr;
-	else if (IS_ERR(domain))
-		return DMA_MAPPING_ERROR;
-
-	dma_mask = *dev->dma_mask;
-	dma_dom = to_dma_ops_domain(domain);
+	struct protection_domain *domain = get_domain(dev);
+	struct dma_ops_domain *dma_dom = to_dma_ops_domain(domain);
 
-	return __map_single(dev, dma_dom, paddr, size, dir, dma_mask);
+	return __map_single(dev, dma_dom, paddr, size, dir, *dev->dma_mask);
 }
 
 /*
@@ -2520,14 +2510,8 @@ static dma_addr_t map_page(struct device *dev, struct page *page,
 static void unmap_page(struct device *dev, dma_addr_t dma_addr, size_t size,
 		       enum dma_data_direction dir, unsigned long attrs)
 {
-	struct protection_domain *domain;
-	struct dma_ops_domain *dma_dom;
-
-	domain = get_domain(dev);
-	if (IS_ERR(domain))
-		return;
-
-	dma_dom = to_dma_ops_domain(domain);
+	struct protection_domain *domain = get_domain(dev);
+	struct dma_ops_domain *dma_dom = to_dma_ops_domain(domain);
 
 	__unmap_single(dma_dom, dma_addr, size, dir);
 }
@@ -2567,20 +2551,13 @@ static int map_sg(struct device *dev, struct scatterlist *sglist,
 		  unsigned long attrs)
 {
 	int mapped_pages = 0, npages = 0, prot = 0, i;
-	struct protection_domain *domain;
-	struct dma_ops_domain *dma_dom;
+	struct protection_domain *domain = get_domain(dev);
+	struct dma_ops_domain *dma_dom = to_dma_ops_domain(domain);
 	struct scatterlist *s;
 	unsigned long address;
-	u64 dma_mask;
+	u64 dma_mask = *dev->dma_mask;
 	int ret;
 
-	domain = get_domain(dev);
-	if (IS_ERR(domain))
-		return 0;
-
-	dma_dom  = to_dma_ops_domain(domain);
-	dma_mask = *dev->dma_mask;
-
 	npages = sg_num_pages(dev, sglist, nelems);
 
 	address = dma_ops_alloc_iova(dev, dma_dom, npages, dma_mask);
@@ -2652,20 +2629,11 @@ static void unmap_sg(struct device *dev, struct scatterlist *sglist,
 		     int nelems, enum dma_data_direction dir,
 		     unsigned long attrs)
 {
-	struct protection_domain *domain;
-	struct dma_ops_domain *dma_dom;
-	unsigned long startaddr;
-	int npages = 2;
-
-	domain = get_domain(dev);
-	if (IS_ERR(domain))
-		return;
-
-	startaddr = sg_dma_address(sglist) & PAGE_MASK;
-	dma_dom   = to_dma_ops_domain(domain);
-	npages    = sg_num_pages(dev, sglist, nelems);
+	struct protection_domain *domain = get_domain(dev);
+	struct dma_ops_domain *dma_dom = to_dma_ops_domain(domain);
 
-	__unmap_single(dma_dom, startaddr, npages << PAGE_SHIFT, dir);
+	__unmap_single(dma_dom, sg_dma_address(sglist) & PAGE_MASK,
+			sg_num_pages(dev, sglist, nelems) << PAGE_SHIFT, dir);
 }
 
 /*
@@ -2676,16 +2644,11 @@ static void *alloc_coherent(struct device *dev, size_t size,
 			    unsigned long attrs)
 {
 	u64 dma_mask = dev->coherent_dma_mask;
-	struct protection_domain *domain;
+	struct protection_domain *domain = get_domain(dev);
 	struct dma_ops_domain *dma_dom;
 	struct page *page;
 
-	domain = get_domain(dev);
-	if (PTR_ERR(domain) == -EINVAL) {
-		page = alloc_pages(flag, get_order(size));
-		*dma_addr = page_to_phys(page);
-		return page_address(page);
-	} else if (IS_ERR(domain))
+	if (IS_ERR(domain))
 		return NULL;
 
 	dma_dom   = to_dma_ops_domain(domain);
@@ -2731,22 +2694,13 @@ static void free_coherent(struct device *dev, size_t size,
 			  void *virt_addr, dma_addr_t dma_addr,
 			  unsigned long attrs)
 {
-	struct protection_domain *domain;
-	struct dma_ops_domain *dma_dom;
-	struct page *page;
+	struct protection_domain *domain = get_domain(dev);
+	struct dma_ops_domain *dma_dom = to_dma_ops_domain(domain);
+	struct page *page = virt_to_page(virt_addr);
 
-	page = virt_to_page(virt_addr);
 	size = PAGE_ALIGN(size);
 
-	domain = get_domain(dev);
-	if (IS_ERR(domain))
-		goto free_mem;
-
-	dma_dom = to_dma_ops_domain(domain);
-
 	__unmap_single(dma_dom, dma_addr, size, DMA_BIDIRECTIONAL);
-
-free_mem:
 	if (!dma_release_from_contiguous(dev, page, size >> PAGE_SHIFT))
 		__free_pages(page, get_order(size));
 }
-- 
2.20.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
