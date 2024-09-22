Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2A0214293;
	Sun, 22 Sep 2024 07:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726989584; cv=none; b=dcv3X39pfLrW4XlPFHqV8wel/Ts7Wsec3s7TgJwohmMlJNlgmE3ly2IpWBv5FYj1N+JOlJX2nkAoJt+wyKLbxXZdAmfQV3V/CNZ5JKvfdvF9Lyb1gspZgdjTbeqWessWszQolKR7vexdhhF4Vt7qpwDoKp07mUMa7lUmQXK7z3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726989584; c=relaxed/simple;
	bh=IK8iqVHdKfEQpB9KqzBjwhMlf7cWDAlhAaRJv5hMDzU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fbezRbJwjx20+QZEorQS+u3Vc336RDUW8gS1Mglk27/oiPSek6kVme+kDGEArDSSr5dDB4f6z9Tb2rL7SAjNKSyiMA10n/OFUH6OtR/Eefd+FRpMqTT+AALXl4evBSIGonoi6bSDPrOfcZMXvbGZxwztXCPrufKS3088qmcIkK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=eRHyfB+p; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="eRHyfB+p"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=OmRsb8mXgEg5UXvLQdRTjsiLmv0s/wQjYIFW6ezT8yU=; b=eRHyfB+p2GZL3SK95CqfzzDvhC
	26GQB1wfWcSP40oit/JSy8yE6YKfMFyyEeQvUBtMJiMJjQwFx0kkDE8fDHPSlTrjFI5eA67aFL1hN
	NLX4Xzewy54tTxs4BtaJIBDxA+EQm7fMGZPGzhQnWD7WpTP0wKvAiWcfP5tvLHzaWaAa1iwAawLre
	vU0dtKxyvDE6eyMp16DVAXGHfSHvuzjxJOebBhVAUlwSR0l2FG0OusZWhEymaZCRsYPmOGbhm0/+S
	kayeDx2+KhQqM87l0X01dv38V11nuomv1OReRVKFksdoaptjGolLSbMev5p4lueJvPPmuyeG7aUCk
	IUnE+Yzw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1ssGsf-0000000EpXs-3XrT;
	Sun, 22 Sep 2024 07:19:41 +0000
Date: Sun, 22 Sep 2024 00:19:41 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Xi Ruoyao <xry111@xry111.site>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	Leon Romanovsky <leon@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>
Subject: Re: [GIT PULL] dma-mapping updates for Linux 6.12
Message-ID: <Zu_FDfHZAVzPv1lq@infradead.org>
References: <971fbb889da38ca4e60f3dedde29ea43e9338d68.camel@xry111.site>
 <Zu1byUGU832iWBUp@infradead.org>
 <Zu2Bd50GdSxF_-eA@infradead.org>
 <19e4bdbcda78ace200c78c56eb7173097337b921.camel@xry111.site>
 <Zu5VoW1ZkViSOws3@infradead.org>
 <9a84a7c6f943209cc87a54075ed22df37ebda5f8.camel@xry111.site>
 <Zu7PW07FmBgs_dpI@infradead.org>
 <38bc765eaba8a646a87ce14e1ff06f28d449fcd5.camel@xry111.site>
 <Zu-kCdMau6127_vM@infradead.org>
 <11368b7c0b7370aea61b3dda73e462fb70f306a7.camel@xry111.site>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11368b7c0b7370aea61b3dda73e462fb70f306a7.camel@xry111.site>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Sun, Sep 22, 2024 at 02:56:57PM +0800, Xi Ruoyao wrote:
> With SND disabled, b5c58b2fdc427e7958412ecb2de2804a1f7c1572 boots fine
> (no oops), but the camera does not work. 
> f69e342eec008e1bab772d3963c3dd9979293e13 boots fine and the camera works
> fine.
> 
> So the first bad commit is b5c58b2fdc427e7958412ecb2de2804a1f7c1572.

Thanks a lot for the bisection!

I took a quitck look what is special in the intersection of uvcvideo
and that commit, and what springs to meind is that
uvcvideo is one of the very few users of dma_alloc_noncontiguous, and
while that and the free call for it got converted correctly, the
conversion was missed for the vmap and mmap callbacks.

Can you test the fix below?

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 3672d619bcb691..2a9fa0c8cc00fe 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -1038,6 +1038,21 @@ static void *iommu_dma_alloc_remap(struct device *dev, size_t size,
 	return NULL;
 }
 
+/*
+ * This is the actual return value from the iommu_dma_alloc_noncontiguous.
+ *
+ * The users of the DMA API should only care about the sg_table, but to make
+ * the DMA-API internal vmaping and freeing easier we stash away the page
+ * array as well (except for the fallback case).  This can go away any time,
+ * e.g. when a vmap-variant that takes a scatterlist comes along.
+ */
+struct dma_sgt_handle {
+	struct sg_table sgt;
+	struct page **pages;
+};
+#define sgt_handle(sgt) \
+	container_of((sgt), struct dma_sgt_handle, sgt)
+
 struct sg_table *iommu_dma_alloc_noncontiguous(struct device *dev, size_t size,
 	       enum dma_data_direction dir, gfp_t gfp, unsigned long attrs)
 {
@@ -1066,6 +1081,24 @@ void iommu_dma_free_noncontiguous(struct device *dev, size_t size,
 	kfree(sh);
 }
 
+void *iommu_dma_vmap_noncontiguous(struct device *dev, size_t size,
+		struct sg_table *sgt)
+{
+	unsigned long count = PAGE_ALIGN(size) >> PAGE_SHIFT;
+
+	return vmap(sgt_handle(sgt)->pages, count, VM_MAP, PAGE_KERNEL);
+}
+
+int iommu_dma_mmap_noncontiguous(struct device *dev, struct vm_area_struct *vma,
+		size_t size, struct sg_table *sgt)
+{
+	unsigned long count = PAGE_ALIGN(size) >> PAGE_SHIFT;
+
+	if (vma->vm_pgoff >= count || vma_pages(vma) > count - vma->vm_pgoff)
+		return -ENXIO;
+	return vm_map_pages(vma, sgt_handle(sgt)->pages, count);
+}
+
 void iommu_dma_sync_single_for_cpu(struct device *dev, dma_addr_t dma_handle,
 		size_t size, enum dma_data_direction dir)
 {
diff --git a/include/linux/dma-map-ops.h b/include/linux/dma-map-ops.h
index 9668ddf3696e71..b7773201414c27 100644
--- a/include/linux/dma-map-ops.h
+++ b/include/linux/dma-map-ops.h
@@ -24,11 +24,6 @@ struct dma_map_ops {
 			gfp_t gfp);
 	void (*free_pages)(struct device *dev, size_t size, struct page *vaddr,
 			dma_addr_t dma_handle, enum dma_data_direction dir);
-	struct sg_table *(*alloc_noncontiguous)(struct device *dev, size_t size,
-			enum dma_data_direction dir, gfp_t gfp,
-			unsigned long attrs);
-	void (*free_noncontiguous)(struct device *dev, size_t size,
-			struct sg_table *sgt, enum dma_data_direction dir);
 	int (*mmap)(struct device *, struct vm_area_struct *,
 			void *, dma_addr_t, size_t, unsigned long attrs);
 
@@ -206,20 +201,6 @@ static inline int dma_mmap_from_global_coherent(struct vm_area_struct *vma,
 }
 #endif /* CONFIG_DMA_GLOBAL_POOL */
 
-/*
- * This is the actual return value from the ->alloc_noncontiguous method.
- * The users of the DMA API should only care about the sg_table, but to make
- * the DMA-API internal vmaping and freeing easier we stash away the page
- * array as well (except for the fallback case).  This can go away any time,
- * e.g. when a vmap-variant that takes a scatterlist comes along.
- */
-struct dma_sgt_handle {
-	struct sg_table sgt;
-	struct page **pages;
-};
-#define sgt_handle(sgt) \
-	container_of((sgt), struct dma_sgt_handle, sgt)
-
 int dma_common_get_sgtable(struct device *dev, struct sg_table *sgt,
 		void *cpu_addr, dma_addr_t dma_addr, size_t size,
 		unsigned long attrs);
diff --git a/include/linux/iommu-dma.h b/include/linux/iommu-dma.h
index 1bb55ca1ab79d7..7bf145a52d6a1a 100644
--- a/include/linux/iommu-dma.h
+++ b/include/linux/iommu-dma.h
@@ -44,6 +44,12 @@ struct sg_table *iommu_dma_alloc_noncontiguous(struct device *dev, size_t size,
 		enum dma_data_direction dir, gfp_t gfp, unsigned long attrs);
 void iommu_dma_free_noncontiguous(struct device *dev, size_t size,
 		struct sg_table *sgt, enum dma_data_direction dir);
+void *iommu_dma_vmap_noncontiguous(struct device *dev, size_t size,
+		struct sg_table *sgt);
+#define iommu_dma_vunmap_noncontiguous(dev, vaddr) \
+	vunmap(vaddr);
+int iommu_dma_mmap_noncontiguous(struct device *dev, struct vm_area_struct *vma,
+		size_t size, struct sg_table *sgt);
 void iommu_dma_sync_single_for_cpu(struct device *dev, dma_addr_t dma_handle,
 		size_t size, enum dma_data_direction dir);
 void iommu_dma_sync_single_for_device(struct device *dev, dma_addr_t dma_handle,
diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
index b839683da0baf0..7911c754d9f42a 100644
--- a/kernel/dma/mapping.c
+++ b/kernel/dma/mapping.c
@@ -750,7 +750,6 @@ static struct sg_table *alloc_single_sgt(struct device *dev, size_t size,
 struct sg_table *dma_alloc_noncontiguous(struct device *dev, size_t size,
 		enum dma_data_direction dir, gfp_t gfp, unsigned long attrs)
 {
-	const struct dma_map_ops *ops = get_dma_ops(dev);
 	struct sg_table *sgt;
 
 	if (WARN_ON_ONCE(attrs & ~DMA_ATTR_ALLOC_SINGLE_PAGES))
@@ -758,9 +757,7 @@ struct sg_table *dma_alloc_noncontiguous(struct device *dev, size_t size,
 	if (WARN_ON_ONCE(gfp & __GFP_COMP))
 		return NULL;
 
-	if (ops && ops->alloc_noncontiguous)
-		sgt = ops->alloc_noncontiguous(dev, size, dir, gfp, attrs);
-	else if (use_dma_iommu(dev))
+	if (use_dma_iommu(dev))
 		sgt = iommu_dma_alloc_noncontiguous(dev, size, dir, gfp, attrs);
 	else
 		sgt = alloc_single_sgt(dev, size, dir, gfp);
@@ -786,13 +783,10 @@ static void free_single_sgt(struct device *dev, size_t size,
 void dma_free_noncontiguous(struct device *dev, size_t size,
 		struct sg_table *sgt, enum dma_data_direction dir)
 {
-	const struct dma_map_ops *ops = get_dma_ops(dev);
-
 	trace_dma_unmap_sg(dev, sgt->sgl, sgt->orig_nents, dir, 0);
 	debug_dma_unmap_sg(dev, sgt->sgl, sgt->orig_nents, dir);
-	if (ops && ops->free_noncontiguous)
-		ops->free_noncontiguous(dev, size, sgt, dir);
-	else if (use_dma_iommu(dev))
+
+	if (use_dma_iommu(dev))
 		iommu_dma_free_noncontiguous(dev, size, sgt, dir);
 	else
 		free_single_sgt(dev, size, sgt, dir);
@@ -802,37 +796,26 @@ EXPORT_SYMBOL_GPL(dma_free_noncontiguous);
 void *dma_vmap_noncontiguous(struct device *dev, size_t size,
 		struct sg_table *sgt)
 {
-	const struct dma_map_ops *ops = get_dma_ops(dev);
-	unsigned long count = PAGE_ALIGN(size) >> PAGE_SHIFT;
 
-	if (ops && ops->alloc_noncontiguous)
-		return vmap(sgt_handle(sgt)->pages, count, VM_MAP, PAGE_KERNEL);
+	if (use_dma_iommu(dev))
+		return iommu_dma_vmap_noncontiguous(dev, size, sgt);
+
 	return page_address(sg_page(sgt->sgl));
 }
 EXPORT_SYMBOL_GPL(dma_vmap_noncontiguous);
 
 void dma_vunmap_noncontiguous(struct device *dev, void *vaddr)
 {
-	const struct dma_map_ops *ops = get_dma_ops(dev);
-
-	if (ops && ops->alloc_noncontiguous)
-		vunmap(vaddr);
+	if (use_dma_iommu(dev))
+		iommu_dma_vunmap_noncontiguous(dev, vaddr);
 }
 EXPORT_SYMBOL_GPL(dma_vunmap_noncontiguous);
 
 int dma_mmap_noncontiguous(struct device *dev, struct vm_area_struct *vma,
 		size_t size, struct sg_table *sgt)
 {
-	const struct dma_map_ops *ops = get_dma_ops(dev);
-
-	if (ops && ops->alloc_noncontiguous) {
-		unsigned long count = PAGE_ALIGN(size) >> PAGE_SHIFT;
-
-		if (vma->vm_pgoff >= count ||
-		    vma_pages(vma) > count - vma->vm_pgoff)
-			return -ENXIO;
-		return vm_map_pages(vma, sgt_handle(sgt)->pages, count);
-	}
+	if (use_dma_iommu(dev))
+		return iommu_dma_mmap_noncontiguous(dev, vma, size, sgt);
 	return dma_mmap_pages(dev, vma, size, sg_page(sgt->sgl));
 }
 EXPORT_SYMBOL_GPL(dma_mmap_noncontiguous);
