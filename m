Return-Path: <SRS0=xQF/=WQ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90EB9C3A5A2
	for <iommu@archiver.kernel.org>; Tue, 20 Aug 2019 03:05:21 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 56FC022CEC
	for <iommu@archiver.kernel.org>; Tue, 20 Aug 2019 03:05:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56FC022CEC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 23AB2CD1;
	Tue, 20 Aug 2019 03:05:21 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id A9814CC9
	for <iommu@lists.linux-foundation.org>;
	Tue, 20 Aug 2019 03:05:19 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 7993467F
	for <iommu@lists.linux-foundation.org>;
	Tue, 20 Aug 2019 03:05:18 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
	id 48ABB68B02; Tue, 20 Aug 2019 05:05:14 +0200 (CEST)
Date: Tue, 20 Aug 2019 05:05:14 +0200
From: Christoph Hellwig <hch@lst.de>
To: Tobias Klausmann <tobias.johannes.klausmann@mni.thm.de>
Subject: Re: regression in ath10k dma allocation
Message-ID: <20190820030514.GA24612@lst.de>
References: <8fe8b415-2d34-0a14-170b-dcb31c162e67@mni.thm.de>
	<20190816164301.GA3629@lst.de>
	<af96ea6a-2b17-9b66-7aba-b7dae5bcbba5@mni.thm.de>
	<20190816222506.GA24413@Asurada-Nvidia.nvidia.com>
	<20190818031328.11848-1-hdanton@sina.com>
	<acd7a4b0-fde8-1aa2-af07-2b469e5d5ca7@mni.thm.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <acd7a4b0-fde8-1aa2-af07-2b469e5d5ca7@mni.thm.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Cc: Hillf Danton <hdanton@sina.com>, netdev@vger.kernel.org,
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	ath10k@lists.infradead.org, davem@davemloft.net,
	Nicolin Chen <nicoleotsuka@gmail.com>,
	iommu@lists.linux-foundation.org, tobias.klausmann@freenet.de,
	robin.murphy@arm.com, Christoph Hellwig <hch@lst.de>, kvalo@codeaurora.org
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

Tobias, plase try this patch:

--
From 88c590a2ecafc8279388f25bfbe1ead8ea3507a6 Mon Sep 17 00:00:00 2001
From: Christoph Hellwig <hch@lst.de>
Date: Tue, 20 Aug 2019 11:45:49 +0900
Subject: dma-direct: fix zone selection after an unaddressable CMA allocation

The new dma_alloc_contiguous hides if we allocate CMA or regular
pages, and thus fails to retry a ZONE_NORMAL allocation if the CMA
allocation succeeds but isn't addressable.  That means we either fail
outright or dip into a small zone that might not succeed either.

Thanks to Hillf Danton for debugging this issue.

Fixes: b1d2dc009dec ("dma-contiguous: add dma_{alloc,free}_contiguous() helpers")
Reported-by: Tobias Klausmann <tobias.johannes.klausmann@mni.thm.de>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/iommu/dma-iommu.c      | 3 +++
 include/linux/dma-contiguous.h | 5 +----
 kernel/dma/contiguous.c        | 9 +++------
 kernel/dma/direct.c            | 7 ++++++-
 4 files changed, 13 insertions(+), 11 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index d991d40f797f..f68a62c3c32b 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -965,10 +965,13 @@ static void *iommu_dma_alloc_pages(struct device *dev, size_t size,
 {
 	bool coherent = dev_is_dma_coherent(dev);
 	size_t alloc_size = PAGE_ALIGN(size);
+	int node = dev_to_node(dev);
 	struct page *page = NULL;
 	void *cpu_addr;
 
 	page = dma_alloc_contiguous(dev, alloc_size, gfp);
+	if (!page)
+		page = alloc_pages_node(node, gfp, get_order(alloc_size));
 	if (!page)
 		return NULL;
 
diff --git a/include/linux/dma-contiguous.h b/include/linux/dma-contiguous.h
index c05d4e661489..03f8e98e3bcc 100644
--- a/include/linux/dma-contiguous.h
+++ b/include/linux/dma-contiguous.h
@@ -160,10 +160,7 @@ bool dma_release_from_contiguous(struct device *dev, struct page *pages,
 static inline struct page *dma_alloc_contiguous(struct device *dev, size_t size,
 		gfp_t gfp)
 {
-	int node = dev ? dev_to_node(dev) : NUMA_NO_NODE;
-	size_t align = get_order(PAGE_ALIGN(size));
-
-	return alloc_pages_node(node, gfp, align);
+	return NULL;
 }
 
 static inline void dma_free_contiguous(struct device *dev, struct page *page,
diff --git a/kernel/dma/contiguous.c b/kernel/dma/contiguous.c
index 2bd410f934b3..e6b450fdbeb6 100644
--- a/kernel/dma/contiguous.c
+++ b/kernel/dma/contiguous.c
@@ -230,9 +230,7 @@ bool dma_release_from_contiguous(struct device *dev, struct page *pages,
  */
 struct page *dma_alloc_contiguous(struct device *dev, size_t size, gfp_t gfp)
 {
-	int node = dev ? dev_to_node(dev) : NUMA_NO_NODE;
-	size_t count = PAGE_ALIGN(size) >> PAGE_SHIFT;
-	size_t align = get_order(PAGE_ALIGN(size));
+	size_t count = size >> PAGE_SHIFT;
 	struct page *page = NULL;
 	struct cma *cma = NULL;
 
@@ -243,14 +241,12 @@ struct page *dma_alloc_contiguous(struct device *dev, size_t size, gfp_t gfp)
 
 	/* CMA can be used only in the context which permits sleeping */
 	if (cma && gfpflags_allow_blocking(gfp)) {
+		size_t align = get_order(size);
 		size_t cma_align = min_t(size_t, align, CONFIG_CMA_ALIGNMENT);
 
 		page = cma_alloc(cma, count, cma_align, gfp & __GFP_NOWARN);
 	}
 
-	/* Fallback allocation of normal pages */
-	if (!page)
-		page = alloc_pages_node(node, gfp, align);
 	return page;
 }
 
@@ -258,6 +254,7 @@ struct page *dma_alloc_contiguous(struct device *dev, size_t size, gfp_t gfp)
  * dma_free_contiguous() - release allocated pages
  * @dev:   Pointer to device for which the pages were allocated.
  * @page:  Pointer to the allocated pages.
+	int node = dev ? dev_to_node(dev) : NUMA_NO_NODE;
  * @size:  Size of allocated pages.
  *
  * This function releases memory allocated by dma_alloc_contiguous(). As the
diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index 795c9b095d75..d82d184463ce 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -85,6 +85,8 @@ static bool dma_coherent_ok(struct device *dev, phys_addr_t phys, size_t size)
 struct page *__dma_direct_alloc_pages(struct device *dev, size_t size,
 		dma_addr_t *dma_handle, gfp_t gfp, unsigned long attrs)
 {
+	size_t alloc_size = PAGE_ALIGN(size);
+	int node = dev_to_node(dev);
 	struct page *page = NULL;
 	u64 phys_mask;
 
@@ -95,8 +97,11 @@ struct page *__dma_direct_alloc_pages(struct device *dev, size_t size,
 	gfp &= ~__GFP_ZERO;
 	gfp |= __dma_direct_optimal_gfp_mask(dev, dev->coherent_dma_mask,
 			&phys_mask);
+	page = dma_alloc_contiguous(dev, alloc_size, gfp);
+	if (page && dma_coherent_ok(dev, page_to_phys(page), size))
+		return page;
 again:
-	page = dma_alloc_contiguous(dev, size, gfp);
+	page = alloc_pages_node(node, gfp, get_order(alloc_size));
 	if (page && !dma_coherent_ok(dev, page_to_phys(page), size)) {
 		dma_free_contiguous(dev, page, size);
 		page = NULL;
-- 
2.20.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
