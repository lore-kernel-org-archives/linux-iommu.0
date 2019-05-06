Return-Path: <SRS0=Zlue=TG=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C6E6C04A6B
	for <iommu@archiver.kernel.org>; Mon,  6 May 2019 12:30:47 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64140206A3
	for <iommu@archiver.kernel.org>; Mon,  6 May 2019 12:30:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64140206A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 001324629;
	Mon,  6 May 2019 12:30:46 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id A97E64556
	for <iommu@lists.linux-foundation.org>;
	Mon,  6 May 2019 12:29:21 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id B071E878
	for <iommu@lists.linux-foundation.org>;
	Mon,  6 May 2019 12:29:20 +0000 (UTC)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
	by mx1.suse.de (Postfix) with ESMTP id CCF4BAE12;
	Mon,  6 May 2019 12:29:18 +0000 (UTC)
Date: Mon, 6 May 2019 14:29:16 +0200
From: Joerg Roedel <jroedel@suse.de>
To: Qian Cai <cai@lca.pw>
Subject: Re: "iommu/amd: Set exclusion range correctly" causes smartpqi offline
Message-ID: <20190506122916.GB3486@suse.de>
References: <1556290348.6132.6.camel@lca.pw>
	<ca40e139-3b0e-01db-b3c8-df0c1a04f9e6@lca.pw>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ca40e139-3b0e-01db-b3c8-df0c1a04f9e6@lca.pw>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: don.brace@microsemi.com, linux-scsi@vger.kernel.org,
	martin.petersen@oracle.com, kevin.barnett@microsemi.com,
	jejb@linux.ibm.com, linux-kernel@vger.kernel.org,
	iommu@lists.linux-foundation.org, scott.teel@microsemi.com,
	david.carroll@microsemi.com, hch@lst.de
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

On Sun, May 05, 2019 at 10:56:28PM -0400, Qian Cai wrote:
> It turned out another linux-next commit is needed to reproduce this, i.e.,
> 7a5dbf3ab2f0 ("iommu/amd: Remove the leftover of bypass support"). Specifically,
> the chunks for map_sg() and unmap_sg(). This has been reproduced on 3 different
> HPE ProLiant DL385 Gen10 systems so far.
> 
> Either reverted the chunks (map_sg() and unmap_sg()) on the top of the latest
> linux-next fixed the issue or applied them on the top of the mainline v5.1
> reproduced it immediately.
> 
> Lots of time it triggered this BUG_ON(!iova) in iova_magazine_free_pfns()
> instead of the smartpqi offline.

Thanks a lot for tracking this down further. I queued a revert of the
above patch, as it does some questionable things I missed during review.
We should revisit the patch during the next cycle, but for now it is
better to just revert it. Revert attached.

From 89736a0ee81d14439d085c8d4653bc1d86fe64d8 Mon Sep 17 00:00:00 2001
From: Joerg Roedel <jroedel@suse.de>
Date: Mon, 6 May 2019 14:24:18 +0200
Subject: [PATCH] Revert "iommu/amd: Remove the leftover of bypass support"

This reverts commit 7a5dbf3ab2f04905cf8468c66fcdbfb643068bcb.

This commit not only removes the leftovers of bypass
support, it also mostly removes the checking of the return
value of the get_domain() function. This can lead to silent
data corruption bugs when a device is not attached to its
dma_ops domain and a DMA-API function is called for that
device.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 drivers/iommu/amd_iommu.c | 80 +++++++++++++++++++++++++++++++++++++----------
 1 file changed, 63 insertions(+), 17 deletions(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index bc98de5fa867..23c1a7eebb06 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -2459,10 +2459,20 @@ static dma_addr_t map_page(struct device *dev, struct page *page,
 			   unsigned long attrs)
 {
 	phys_addr_t paddr = page_to_phys(page) + offset;
-	struct protection_domain *domain = get_domain(dev);
-	struct dma_ops_domain *dma_dom = to_dma_ops_domain(domain);
+	struct protection_domain *domain;
+	struct dma_ops_domain *dma_dom;
+	u64 dma_mask;
+
+	domain = get_domain(dev);
+	if (PTR_ERR(domain) == -EINVAL)
+		return (dma_addr_t)paddr;
+	else if (IS_ERR(domain))
+		return DMA_MAPPING_ERROR;
+
+	dma_mask = *dev->dma_mask;
+	dma_dom = to_dma_ops_domain(domain);
 
-	return __map_single(dev, dma_dom, paddr, size, dir, *dev->dma_mask);
+	return __map_single(dev, dma_dom, paddr, size, dir, dma_mask);
 }
 
 /*
@@ -2471,8 +2481,14 @@ static dma_addr_t map_page(struct device *dev, struct page *page,
 static void unmap_page(struct device *dev, dma_addr_t dma_addr, size_t size,
 		       enum dma_data_direction dir, unsigned long attrs)
 {
-	struct protection_domain *domain = get_domain(dev);
-	struct dma_ops_domain *dma_dom = to_dma_ops_domain(domain);
+	struct protection_domain *domain;
+	struct dma_ops_domain *dma_dom;
+
+	domain = get_domain(dev);
+	if (IS_ERR(domain))
+		return;
+
+	dma_dom = to_dma_ops_domain(domain);
 
 	__unmap_single(dma_dom, dma_addr, size, dir);
 }
@@ -2512,13 +2528,20 @@ static int map_sg(struct device *dev, struct scatterlist *sglist,
 		  unsigned long attrs)
 {
 	int mapped_pages = 0, npages = 0, prot = 0, i;
-	struct protection_domain *domain = get_domain(dev);
-	struct dma_ops_domain *dma_dom = to_dma_ops_domain(domain);
+	struct protection_domain *domain;
+	struct dma_ops_domain *dma_dom;
 	struct scatterlist *s;
 	unsigned long address;
-	u64 dma_mask = *dev->dma_mask;
+	u64 dma_mask;
 	int ret;
 
+	domain = get_domain(dev);
+	if (IS_ERR(domain))
+		return 0;
+
+	dma_dom  = to_dma_ops_domain(domain);
+	dma_mask = *dev->dma_mask;
+
 	npages = sg_num_pages(dev, sglist, nelems);
 
 	address = dma_ops_alloc_iova(dev, dma_dom, npages, dma_mask);
@@ -2592,11 +2615,20 @@ static void unmap_sg(struct device *dev, struct scatterlist *sglist,
 		     int nelems, enum dma_data_direction dir,
 		     unsigned long attrs)
 {
-	struct protection_domain *domain = get_domain(dev);
-	struct dma_ops_domain *dma_dom = to_dma_ops_domain(domain);
+	struct protection_domain *domain;
+	struct dma_ops_domain *dma_dom;
+	unsigned long startaddr;
+	int npages = 2;
+
+	domain = get_domain(dev);
+	if (IS_ERR(domain))
+		return;
+
+	startaddr = sg_dma_address(sglist) & PAGE_MASK;
+	dma_dom   = to_dma_ops_domain(domain);
+	npages    = sg_num_pages(dev, sglist, nelems);
 
-	__unmap_single(dma_dom, sg_dma_address(sglist) & PAGE_MASK,
-			sg_num_pages(dev, sglist, nelems) << PAGE_SHIFT, dir);
+	__unmap_single(dma_dom, startaddr, npages << PAGE_SHIFT, dir);
 }
 
 /*
@@ -2607,11 +2639,16 @@ static void *alloc_coherent(struct device *dev, size_t size,
 			    unsigned long attrs)
 {
 	u64 dma_mask = dev->coherent_dma_mask;
-	struct protection_domain *domain = get_domain(dev);
+	struct protection_domain *domain;
 	struct dma_ops_domain *dma_dom;
 	struct page *page;
 
-	if (IS_ERR(domain))
+	domain = get_domain(dev);
+	if (PTR_ERR(domain) == -EINVAL) {
+		page = alloc_pages(flag, get_order(size));
+		*dma_addr = page_to_phys(page);
+		return page_address(page);
+	} else if (IS_ERR(domain))
 		return NULL;
 
 	dma_dom   = to_dma_ops_domain(domain);
@@ -2657,13 +2694,22 @@ static void free_coherent(struct device *dev, size_t size,
 			  void *virt_addr, dma_addr_t dma_addr,
 			  unsigned long attrs)
 {
-	struct protection_domain *domain = get_domain(dev);
-	struct dma_ops_domain *dma_dom = to_dma_ops_domain(domain);
-	struct page *page = virt_to_page(virt_addr);
+	struct protection_domain *domain;
+	struct dma_ops_domain *dma_dom;
+	struct page *page;
 
+	page = virt_to_page(virt_addr);
 	size = PAGE_ALIGN(size);
 
+	domain = get_domain(dev);
+	if (IS_ERR(domain))
+		goto free_mem;
+
+	dma_dom = to_dma_ops_domain(domain);
+
 	__unmap_single(dma_dom, dma_addr, size, DMA_BIDIRECTIONAL);
+
+free_mem:
 	if (!dma_release_from_contiguous(dev, page, size >> PAGE_SHIFT))
 		__free_pages(page, get_order(size));
 }
-- 
2.16.4

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
