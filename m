Return-Path: <SRS0=s4mY=HE=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3BF0C433E0
	for <iommu@archiver.kernel.org>; Tue,  2 Feb 2021 09:51:30 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 12DAA64DE7
	for <iommu@archiver.kernel.org>; Tue,  2 Feb 2021 09:51:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12DAA64DE7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 96A67866C3;
	Tue,  2 Feb 2021 09:51:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BYhtO5gcjhUJ; Tue,  2 Feb 2021 09:51:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 96BB3865FC;
	Tue,  2 Feb 2021 09:51:27 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7F2AAC0174;
	Tue,  2 Feb 2021 09:51:27 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AFFCCC013A
 for <iommu@lists.linux-foundation.org>; Tue,  2 Feb 2021 09:51:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id A09B985AB9
 for <iommu@lists.linux-foundation.org>; Tue,  2 Feb 2021 09:51:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 22x6RoMpX+or for <iommu@lists.linux-foundation.org>;
 Tue,  2 Feb 2021 09:51:24 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 6397281E3F
 for <iommu@lists.linux-foundation.org>; Tue,  2 Feb 2021 09:51:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=C4gwfxOJ/vXre3lN9UufmmjUIasSmHttFaQ+GpK794U=; b=WLYQ6ATISrWnytFZgqVHcBywtp
 qW19X7wWNafG/J/XPvNuvxTO05RlagTk2At59gRvsoHW1OMB6epZJDjbLtpiRzIJX7bpdKZ/oI5dB
 MDduPa7nJTfJQVHO9RCoExXFSKGxDMCAKP5qX9DB58bi///dgemhhyfxc98P9cjdp2wYnugju8Mhc
 aiAwdFnZ7S7+gJDbrpiK8Zc0h2ee33P9kqB/fFng3+ZKQi/MAp62iEbcACNrkT9xl/UzJWc8OIq6K
 0Bif+vWkjvzQw6CIkPKqe2M3du/OzOwYoEpE2W6eXeCLthc5nMigNplUGSAZGXsynpFX8Jiac+Sc4
 cOAhQfZA==;
Received: from [2001:4bb8:198:6bf4:7f38:755e:a6e0:73e9] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
 id 1l6sL5-00F0wB-6r; Tue, 02 Feb 2021 09:51:15 +0000
From: Christoph Hellwig <hch@lst.de>
To: Mauro Carvalho Chehab <mchehab@kernel.org>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Tomasz Figa <tfiga@chromium.org>, Ricardo Ribalda <ribalda@chromium.org>,
 Sergey Senozhatsky <senozhatsky@google.com>,
 iommu@lists.linux-foundation.org
Subject: [PATCH 1/7] dma-mapping: remove the {alloc,free}_noncoherent methods
Date: Tue,  2 Feb 2021 10:51:04 +0100
Message-Id: <20210202095110.1215346-2-hch@lst.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210202095110.1215346-1-hch@lst.de>
References: <20210202095110.1215346-1-hch@lst.de>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
Cc: linux-media@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
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

It turns out allowing non-contigous allocations here was a rather bad
idea, as we'll now need to define ways to get the pages for mmaping
or dma_buf sharing.  Revert this change and stick to the original
concept.  A different API for the use case of non-contigous allocations
will be added back later.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 Documentation/core-api/dma-api.rst | 64 ++++++++++--------------------
 drivers/iommu/dma-iommu.c          | 30 --------------
 include/linux/dma-map-ops.h        |  5 ---
 include/linux/dma-mapping.h        | 17 ++++++--
 kernel/dma/mapping.c               | 40 -------------------
 5 files changed, 35 insertions(+), 121 deletions(-)

diff --git a/Documentation/core-api/dma-api.rst b/Documentation/core-api/dma-api.rst
index 75cb757bbff00a..e6d23f117308df 100644
--- a/Documentation/core-api/dma-api.rst
+++ b/Documentation/core-api/dma-api.rst
@@ -528,16 +528,14 @@ an I/O device, you should not be using this part of the API.
 
 ::
 
-	void *
-	dma_alloc_noncoherent(struct device *dev, size_t size,
-			dma_addr_t *dma_handle, enum dma_data_direction dir,
-			gfp_t gfp)
+	struct page *
+	dma_alloc_pages(struct device *dev, size_t size, dma_addr_t *dma_handle,
+			enum dma_data_direction dir, gfp_t gfp)
 
-This routine allocates a region of <size> bytes of consistent memory.  It
-returns a pointer to the allocated region (in the processor's virtual address
-space) or NULL if the allocation failed.  The returned memory may or may not
-be in the kernel direct mapping.  Drivers must not call virt_to_page on
-the returned memory region.
+This routine allocates a region of <size> bytes of non-coherent memory.  It
+returns a pointer to first struct page for the region, or NULL if the
+allocation failed. The resulting struct page can be used for everything a
+struct page is suitable for.
 
 It also returns a <dma_handle> which may be cast to an unsigned integer the
 same width as the bus and given to the device as the DMA address base of
@@ -558,51 +556,33 @@ reused.
 ::
 
 	void
-	dma_free_noncoherent(struct device *dev, size_t size, void *cpu_addr,
+	dma_free_pages(struct device *dev, size_t size, struct page *page,
 			dma_addr_t dma_handle, enum dma_data_direction dir)
 
-Free a region of memory previously allocated using dma_alloc_noncoherent().
-dev, size and dma_handle and dir must all be the same as those passed into
-dma_alloc_noncoherent().  cpu_addr must be the virtual address returned by
-dma_alloc_noncoherent().
+Free a region of memory previously allocated using dma_alloc_pages().
+dev, size, dma_handle and dir must all be the same as those passed into
+dma_alloc_pages().  page must be the pointer returned by dma_alloc_pages().
 
 ::
 
-	struct page *
-	dma_alloc_pages(struct device *dev, size_t size, dma_addr_t *dma_handle,
-			enum dma_data_direction dir, gfp_t gfp)
-
-This routine allocates a region of <size> bytes of non-coherent memory.  It
-returns a pointer to first struct page for the region, or NULL if the
-allocation failed. The resulting struct page can be used for everything a
-struct page is suitable for.
-
-It also returns a <dma_handle> which may be cast to an unsigned integer the
-same width as the bus and given to the device as the DMA address base of
-the region.
-
-The dir parameter specified if data is read and/or written by the device,
-see dma_map_single() for details.
-
-The gfp parameter allows the caller to specify the ``GFP_`` flags (see
-kmalloc()) for the allocation, but rejects flags used to specify a memory
-zone such as GFP_DMA or GFP_HIGHMEM.
+	void *
+	dma_alloc_noncoherent(struct device *dev, size_t size,
+			dma_addr_t *dma_handle, enum dma_data_direction dir,
+			gfp_t gfp)
 
-Before giving the memory to the device, dma_sync_single_for_device() needs
-to be called, and before reading memory written by the device,
-dma_sync_single_for_cpu(), just like for streaming DMA mappings that are
-reused.
+This routine is a convenient wrapper around dma_alloc_pages that returns the
+kernel virtual address for the allocated memory instead of the page structure.
 
 ::
 
 	void
-	dma_free_pages(struct device *dev, size_t size, struct page *page,
+	dma_free_noncoherent(struct device *dev, size_t size, void *cpu_addr,
 			dma_addr_t dma_handle, enum dma_data_direction dir)
 
-Free a region of memory previously allocated using dma_alloc_pages().
-dev, size and dma_handle and dir must all be the same as those passed into
-dma_alloc_noncoherent().  page must be the pointer returned by
-dma_alloc_pages().
+Free a region of memory previously allocated using dma_alloc_noncoherent().
+dev, size, dma_handle and dir must all be the same as those passed into
+dma_alloc_noncoherent().  cpu_addr must be the virtual address returned by
+dma_alloc_noncoherent().
 
 ::
 
diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 4078358ed66ea8..255533faf90599 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -1197,34 +1197,6 @@ static void *iommu_dma_alloc(struct device *dev, size_t size,
 	return cpu_addr;
 }
 
-#ifdef CONFIG_DMA_REMAP
-static void *iommu_dma_alloc_noncoherent(struct device *dev, size_t size,
-		dma_addr_t *handle, enum dma_data_direction dir, gfp_t gfp)
-{
-	if (!gfpflags_allow_blocking(gfp)) {
-		struct page *page;
-
-		page = dma_common_alloc_pages(dev, size, handle, dir, gfp);
-		if (!page)
-			return NULL;
-		return page_address(page);
-	}
-
-	return iommu_dma_alloc_remap(dev, size, handle, gfp | __GFP_ZERO,
-				     PAGE_KERNEL, 0);
-}
-
-static void iommu_dma_free_noncoherent(struct device *dev, size_t size,
-		void *cpu_addr, dma_addr_t handle, enum dma_data_direction dir)
-{
-	__iommu_dma_unmap(dev, handle, size);
-	__iommu_dma_free(dev, size, cpu_addr);
-}
-#else
-#define iommu_dma_alloc_noncoherent		NULL
-#define iommu_dma_free_noncoherent		NULL
-#endif /* CONFIG_DMA_REMAP */
-
 static int iommu_dma_mmap(struct device *dev, struct vm_area_struct *vma,
 		void *cpu_addr, dma_addr_t dma_addr, size_t size,
 		unsigned long attrs)
@@ -1295,8 +1267,6 @@ static const struct dma_map_ops iommu_dma_ops = {
 	.free			= iommu_dma_free,
 	.alloc_pages		= dma_common_alloc_pages,
 	.free_pages		= dma_common_free_pages,
-	.alloc_noncoherent	= iommu_dma_alloc_noncoherent,
-	.free_noncoherent	= iommu_dma_free_noncoherent,
 	.mmap			= iommu_dma_mmap,
 	.get_sgtable		= iommu_dma_get_sgtable,
 	.map_page		= iommu_dma_map_page,
diff --git a/include/linux/dma-map-ops.h b/include/linux/dma-map-ops.h
index 70fcd0f610ea48..11e02537b9e01b 100644
--- a/include/linux/dma-map-ops.h
+++ b/include/linux/dma-map-ops.h
@@ -22,11 +22,6 @@ struct dma_map_ops {
 			gfp_t gfp);
 	void (*free_pages)(struct device *dev, size_t size, struct page *vaddr,
 			dma_addr_t dma_handle, enum dma_data_direction dir);
-	void *(*alloc_noncoherent)(struct device *dev, size_t size,
-			dma_addr_t *dma_handle, enum dma_data_direction dir,
-			gfp_t gfp);
-	void (*free_noncoherent)(struct device *dev, size_t size, void *vaddr,
-			dma_addr_t dma_handle, enum dma_data_direction dir);
 	int (*mmap)(struct device *, struct vm_area_struct *,
 			void *, dma_addr_t, size_t, unsigned long attrs);
 
diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index 2e49996a8f391a..fbfa3f5abd9498 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -263,10 +263,19 @@ struct page *dma_alloc_pages(struct device *dev, size_t size,
 		dma_addr_t *dma_handle, enum dma_data_direction dir, gfp_t gfp);
 void dma_free_pages(struct device *dev, size_t size, struct page *page,
 		dma_addr_t dma_handle, enum dma_data_direction dir);
-void *dma_alloc_noncoherent(struct device *dev, size_t size,
-		dma_addr_t *dma_handle, enum dma_data_direction dir, gfp_t gfp);
-void dma_free_noncoherent(struct device *dev, size_t size, void *vaddr,
-		dma_addr_t dma_handle, enum dma_data_direction dir);
+
+static inline void *dma_alloc_noncoherent(struct device *dev, size_t size,
+		dma_addr_t *dma_handle, enum dma_data_direction dir, gfp_t gfp)
+{
+	struct page *page = dma_alloc_pages(dev, size, dma_handle, dir, gfp);
+	return page ? page_address(page) : NULL;
+}
+
+static inline void dma_free_noncoherent(struct device *dev, size_t size,
+		void *vaddr, dma_addr_t dma_handle, enum dma_data_direction dir)
+{
+	dma_free_pages(dev, size, virt_to_page(vaddr), dma_handle, dir);
+}
 
 static inline dma_addr_t dma_map_single_attrs(struct device *dev, void *ptr,
 		size_t size, enum dma_data_direction dir, unsigned long attrs)
diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
index f87a89d086544b..68992e35c8c3a7 100644
--- a/kernel/dma/mapping.c
+++ b/kernel/dma/mapping.c
@@ -515,46 +515,6 @@ void dma_free_pages(struct device *dev, size_t size, struct page *page,
 }
 EXPORT_SYMBOL_GPL(dma_free_pages);
 
-void *dma_alloc_noncoherent(struct device *dev, size_t size,
-		dma_addr_t *dma_handle, enum dma_data_direction dir, gfp_t gfp)
-{
-	const struct dma_map_ops *ops = get_dma_ops(dev);
-	void *vaddr;
-
-	if (!ops || !ops->alloc_noncoherent) {
-		struct page *page;
-
-		page = dma_alloc_pages(dev, size, dma_handle, dir, gfp);
-		if (!page)
-			return NULL;
-		return page_address(page);
-	}
-
-	size = PAGE_ALIGN(size);
-	vaddr = ops->alloc_noncoherent(dev, size, dma_handle, dir, gfp);
-	if (vaddr)
-		debug_dma_map_page(dev, virt_to_page(vaddr), 0, size, dir,
-				   *dma_handle);
-	return vaddr;
-}
-EXPORT_SYMBOL_GPL(dma_alloc_noncoherent);
-
-void dma_free_noncoherent(struct device *dev, size_t size, void *vaddr,
-		dma_addr_t dma_handle, enum dma_data_direction dir)
-{
-	const struct dma_map_ops *ops = get_dma_ops(dev);
-
-	if (!ops || !ops->free_noncoherent) {
-		dma_free_pages(dev, size, virt_to_page(vaddr), dma_handle, dir);
-		return;
-	}
-
-	size = PAGE_ALIGN(size);
-	debug_dma_unmap_page(dev, dma_handle, size, dir);
-	ops->free_noncoherent(dev, size, vaddr, dma_handle, dir);
-}
-EXPORT_SYMBOL_GPL(dma_free_noncoherent);
-
 int dma_supported(struct device *dev, u64 mask)
 {
 	const struct dma_map_ops *ops = get_dma_ops(dev);
-- 
2.29.2

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
