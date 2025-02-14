Received: from mx2.freebsd.org (mx2.freebsd.org [96.47.72.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39E2C2673BA
	for <iommu@lists.linux.dev>; Fri, 14 Feb 2025 15:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=96.47.72.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739547826; cv=pass; b=MrnoWBNwrN3EQUnYTYkHGZywwaoKri15p6zICvNranKR80qHoRmX3dS6WQfGxN8/JjxoSKdN9JKO2nzCRPrXwn/ohADZvQdLZDaSIRwIc2E9ABwkez3F7mAofTHGaayO9CBTdCbbAASU7LKSY6/WFbFINWDjnqNd+XNj7g7rjJQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739547826; c=relaxed/simple;
	bh=1UNRsCnQp/C7eTi7rUcie0BFSORejfsIWOXb5Sn7dhY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fGu4mnpo7sOAxdWS/pvcsaBv6AxevbcFokYN/zBAs96tZjIu3at0JatAnimI4yFbz9qOfSTrCCDLtEcvDWm1SblcwMeTgUsd2LcvU9cW7bvv7J5q864tspjIUXiYOHd0yBVGWhaLnwS6yCy3Q3f6vSga2GXtHFPIZLad7LDgKxY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=FreeBSD.org; spf=pass smtp.mailfrom=FreeBSD.org; dkim=pass (2048-bit key) header.d=freebsd.org header.i=@freebsd.org header.b=JdoRkyOW; arc=pass smtp.client-ip=96.47.72.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=FreeBSD.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=FreeBSD.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=freebsd.org header.i=@freebsd.org header.b="JdoRkyOW"
Received: from mx1.freebsd.org (mx1.freebsd.org [96.47.72.80])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits)
	 client-signature RSA-PSS (4096 bits))
	(Client CN "mx1.freebsd.org", Issuer "R10" (verified OK))
	by mx2.freebsd.org (Postfix) with ESMTPS id 4Yvbtk57sXz4X02;
	Fri, 14 Feb 2025 15:43:42 +0000 (UTC)
	(envelope-from jfree@FreeBSD.org)
Received: from smtp.freebsd.org (smtp.freebsd.org [IPv6:2610:1c1:1:606c::24b:4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "smtp.freebsd.org", Issuer "R10" (verified OK))
	by mx1.freebsd.org (Postfix) with ESMTPS id 4Yvbtj4M25z3MCy;
	Fri, 14 Feb 2025 15:43:41 +0000 (UTC)
	(envelope-from jfree@FreeBSD.org)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=freebsd.org; s=dkim;
	t=1739547821;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=DGtjsDbKtyU6xedXLsDVq8qn7NP5CiQ9uA2IM5aQwfE=;
	b=JdoRkyOWWhCCrUuoviNEzBlCD4JsIhFdhZrpzFPwXLmSiVfeTn46Ys12QZK5zyuOfA7520
	9F+AdSt6dgJaN7ozilkNB6tmEAEdR/TQHmlzkx9ZHFMC6w/vV3fEpwc7IsrthmOsYWGsS7
	EnE4xnPJSZIxcOCBUAjnXJOn12A3KKZiBT8TNRCjERymMmehR1KbXZqFNSqX/tfq2LZzpu
	Gzpcucm6BrCz8Sx+OWcIaUQgZJQLwTEfh9hxjA8v+iUfzlQMeEoI28YfP6Hj1BjYifBsg3
	Lf6HRJn4fclD2ATulhCzIN3JaGwjB12AQME4vlIwOLuzmg3EXh/ynAY4WyE1fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=freebsd.org;
	s=dkim; t=1739547821;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=DGtjsDbKtyU6xedXLsDVq8qn7NP5CiQ9uA2IM5aQwfE=;
	b=iFFiunV/Vnz5WgIaY0AXPRn75NYBKrt+yU6AwafCV0+8pSqwrPIotnYxgOtatwH0KTolJj
	ZxxFP0IlCUgiCPVJ3r1SKb4YnaEp4n01o4zYZVjmMTEuVQVVbdACI8ZEHRrVHGxXWx879M
	E8ygDUrZxIiqShDw82fVyzAoI1PpG/EdBa5W0oZvyJ0Lam0Rd9dMOtvYOeMRNuC9GbKpOi
	/unRdGNqXLs5kOO+1u6ERIqtIVz9dJsa02mjTTv89M5F0I/8bbIFK1vcL4vdGShxAeO7pr
	hQQuW/WfVf0elc60lItCN62RBPv7LUJWF7zDUM7CkPQ2mtuFktg37wICIyakVQ==
ARC-Seal: i=1; s=dkim; d=freebsd.org; t=1739547821; a=rsa-sha256; cv=none;
	b=xp62hXpV1RY0qNC0060xbosnZa3oRWM1qljUbhnslKQQDt4+rJtM9aDYY50k/TBd/nlYIc
	K3B1zZhBD4svxrL6EZT8xCIOIx+IN6QeXYMVMt8Q611p2psyFCO0ZeoZjoZ2do+ieU5Ddm
	G2Od0WW73yT8f3XhKGWMPnBzXaPURe7MVwyIDTKvV7+2q/4ByhnwmOp93NV0MzPv2IV5Nt
	Xm2kyK0Z/Y5RE90qjKvWEHKRRAnnqEA1sKt1PsznhnZLX4o6YoeYl0JKCVTPNFh4f97Gny
	YZipTPgSKDFdDh93TG8x+t6JVEYUkzlPrTZ70o/d8vERV8lbNQAFS0tXfborYw==
ARC-Authentication-Results: i=1;
	mx1.freebsd.org;
	none
Received: from s1.pct.niksun.com (67-4-132-58.mpls.qwest.net [67.4.132.58])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: jfree)
	by smtp.freebsd.org (Postfix) with ESMTPSA id 4Yvbtj1bvjzRMY;
	Fri, 14 Feb 2025 15:43:41 +0000 (UTC)
	(envelope-from jfree@FreeBSD.org)
From: Jake Freeland <jfree@FreeBSD.org>
To: Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Jake Freeland <jfree@FreeBSD.org>,
	Robin Murphy <robin.murphy@arm.com>,
	iommu@lists.linux.dev
Subject: [PATCH] dma: Attempt gigantic allocations outside of CMA
Date: Fri, 14 Feb 2025 09:43:20 -0600
Message-ID: <20250214154322.1230277-1-jfree@FreeBSD.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Do not restrict gigantic DMA allocations to memory from CMA. If CMA
memory is exhausted or not present and the requested size has an order
greater than MAX_PAGE_ORDER, then attempt to find a suitable range of
contiguous pages at call-time and allocate them with alloc_contig_pages().

Previously, if a region with an order exceeding MAX_PAGE_ORDER was
requested via dma_direct_alloc() and CMA memory was unavailable, the
allocation would fall back to the buddy allocator and fail. This fix
makes the allocation fall back to alloc_contig_pages() increasing the
chances of a successful allocation.

Signed-off-by: Jake Freeland <jfree@FreeBSD.org>
---
 include/linux/dma-map-ops.h |  8 +++++++-
 include/linux/gfp.h         | 16 ++++++++++++++--
 kernel/dma/contiguous.c     |  8 ++++++--
 kernel/dma/direct.c         | 26 +++++++++++++++++---------
 4 files changed, 44 insertions(+), 14 deletions(-)

diff --git a/include/linux/dma-map-ops.h b/include/linux/dma-map-ops.h
index e172522cd936..572a8c501560 100644
--- a/include/linux/dma-map-ops.h
+++ b/include/linux/dma-map-ops.h
@@ -151,7 +151,13 @@ static inline struct page *dma_alloc_contiguous(struct device *dev, size_t size,
 static inline void dma_free_contiguous(struct device *dev, struct page *page,
 		size_t size)
 {
-	__free_pages(page, get_order(size));
+	unsigned long nr_pages = PAGE_ALIGN(size) >> PAGE_SHIFT;
+	int order = get_order(size);
+
+	if (order > MAX_PAGE_ORDER)
+		free_contig_range(page_to_pfn(page), nr_pages);
+	else
+		__free_pages(page, order);
 }
 #endif /* CONFIG_DMA_CMA*/
 
diff --git a/include/linux/gfp.h b/include/linux/gfp.h
index 6bb1a5a7a4ae..def5f7be8ba7 100644
--- a/include/linux/gfp.h
+++ b/include/linux/gfp.h
@@ -403,13 +403,25 @@ extern gfp_t vma_thp_gfp_mask(struct vm_area_struct *vma);
 /* The below functions must be run on a range from a single zone. */
 extern int alloc_contig_range_noprof(unsigned long start, unsigned long end,
 			      unsigned migratetype, gfp_t gfp_mask);
-#define alloc_contig_range(...)			alloc_hooks(alloc_contig_range_noprof(__VA_ARGS__))
 
 extern struct page *alloc_contig_pages_noprof(unsigned long nr_pages, gfp_t gfp_mask,
 					      int nid, nodemask_t *nodemask);
-#define alloc_contig_pages(...)			alloc_hooks(alloc_contig_pages_noprof(__VA_ARGS__))
+#else
+static inline int alloc_contig_range_noprof(unsigned long start, unsigned long end,
+					    unsigned migratetype, gfp_t gfp_mask)
+{
+	return -ENOSYS;
+}
 
+static inline struct page *alloc_contig_pages_noprof(unsigned long nr_pages,
+						    gfp_t gfp_mask, int nid,
+						    nodemask_t *nodemask)
+{
+	return NULL;
+}
 #endif
+#define alloc_contig_range(...)			alloc_hooks(alloc_contig_range_noprof(__VA_ARGS__))
+#define alloc_contig_pages(...)			alloc_hooks(alloc_contig_pages_noprof(__VA_ARGS__))
 void free_contig_range(unsigned long pfn, unsigned long nr_pages);
 
 #ifdef CONFIG_CONTIG_ALLOC
diff --git a/kernel/dma/contiguous.c b/kernel/dma/contiguous.c
index 055da410ac71..2b82e45f136e 100644
--- a/kernel/dma/contiguous.c
+++ b/kernel/dma/contiguous.c
@@ -396,11 +396,12 @@ struct page *dma_alloc_contiguous(struct device *dev, size_t size, gfp_t gfp)
  * This function releases memory allocated by dma_alloc_contiguous(). As the
  * cma_release returns false when provided pages do not belong to contiguous
  * area and true otherwise, this function then does a fallback __free_pages()
- * upon a false-return.
+ * or free_contig_range() (depending on order) upon a false-return.
  */
 void dma_free_contiguous(struct device *dev, struct page *page, size_t size)
 {
 	unsigned int count = PAGE_ALIGN(size) >> PAGE_SHIFT;
+	int order = get_order(size);
 
 	/* if dev has its own cma, free page from there */
 	if (dev->cma_area) {
@@ -423,7 +424,10 @@ void dma_free_contiguous(struct device *dev, struct page *page, size_t size)
 	}
 
 	/* not in any cma, free from buddy */
-	__free_pages(page, get_order(size));
+	if (order > MAX_PAGE_ORDER)
+		free_contig_range(page_to_pfn(page), count);
+	else
+		__free_pages(page, order);
 }
 
 /*
diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index 5b4e6d3bf7bc..4983353b0143 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -118,7 +118,8 @@ static struct page *dma_direct_alloc_swiotlb(struct device *dev, size_t size)
 static struct page *__dma_direct_alloc_pages(struct device *dev, size_t size,
 		gfp_t gfp, bool allow_highmem)
 {
-	int node = dev_to_node(dev);
+	unsigned long nr_pages = PAGE_ALIGN(size) >> PAGE_SHIFT;
+	int node = dev_to_node(dev), order = get_order(size);
 	struct page *page = NULL;
 	u64 phys_limit;
 
@@ -130,17 +131,24 @@ static struct page *__dma_direct_alloc_pages(struct device *dev, size_t size,
 	gfp |= dma_direct_optimal_gfp_mask(dev, &phys_limit);
 	page = dma_alloc_contiguous(dev, size, gfp);
 	if (page) {
-		if (!dma_coherent_ok(dev, page_to_phys(page), size) ||
-		    (!allow_highmem && PageHighMem(page))) {
-			dma_free_contiguous(dev, page, size);
-			page = NULL;
-		}
+		if (dma_coherent_ok(dev, page_to_phys(page), size) &&
+		    (allow_highmem || !PageHighMem(page)))
+			return page;
+		dma_free_contiguous(dev, page, size);
 	}
+
 again:
-	if (!page)
-		page = alloc_pages_node(node, gfp, get_order(size));
+	if (order > MAX_PAGE_ORDER)
+		page = alloc_contig_pages(nr_pages, gfp,
+				node != NUMA_NO_NODE ? node : numa_mem_id(),
+				&node_states[N_MEMORY]);
+	else
+		page = alloc_pages_node(node, gfp, order);
 	if (page && !dma_coherent_ok(dev, page_to_phys(page), size)) {
-		__free_pages(page, get_order(size));
+		if (order > MAX_PAGE_ORDER)
+			free_contig_range(page_to_pfn(page), nr_pages);
+		else
+			__free_pages(page, order);
 		page = NULL;
 
 		if (IS_ENABLED(CONFIG_ZONE_DMA32) &&
-- 
2.48.1

