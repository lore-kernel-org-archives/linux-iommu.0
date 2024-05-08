Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7C0C84D30;
	Wed,  8 May 2024 17:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715188776; cv=none; b=YGMgH+AEcuAtOdARLw1k58XBFjrBXK6kyRZeokNL4i5sHtELs+0LkbIouFlzlHloCQs7588IFgHbjR2IDjtp31A7FbaxGVXolvXLduKR5m/sf7HHpRBTy718MnEO1wZNtUy3xcreSnCMWBREMuzWy8LaBVMTZnyLen3jdsgnAEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715188776; c=relaxed/simple;
	bh=VNYjEf+iN9B3/LMNy2QHOAfuVlavi97bZH6F11mPC7A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ym9lcWB5pYand40xybHcGgaRvU9AKpaK397buXwQR1mZ2JrO8WSjGc94p5e/f1HiJizUcBBKgYN6SeAUHMKfjKuoyNtnZ8scw7UtjgItVjHFv2JBgnATdTfQmnSkcFbmG1zTdA0kYKlNh9XfIPXo0iBz99HYIJWcM/UK0XZyZn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7023C113CC;
	Wed,  8 May 2024 17:19:34 +0000 (UTC)
Date: Wed, 8 May 2024 18:19:32 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: "T.J. Mercier" <tjmercier@google.com>
Cc: Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>, isaacmanjarres@google.com,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dma-direct: Set SG_DMA_SWIOTLB flag for dma-direct
Message-ID: <Zju0JOx_ij1qH-34@arm.com>
References: <20240503183713.1557480-1-tjmercier@google.com>
 <20240506052955.GA4923@lst.de>
 <CABdmKX1XNTtoPTvfsJRobim8pHdDjPsKx=qVovVZDh5GEbKCfQ@mail.gmail.com>
 <20240506160244.GA16248@lst.de>
 <CABdmKX1n98+bw+1kewz=wdqq2Nbpaxao_Lx-Gq8oKGNUEP4ytQ@mail.gmail.com>
 <20240506161906.GA17237@lst.de>
 <CABdmKX3s_HnxciDA3XGM8Qj0kLY8OWENg+ifexrON4VYVbuLsA@mail.gmail.com>
 <20240507054314.GA31814@lst.de>
 <CABdmKX3PgcXaRUH3L7OV+POMiMd5L6pEF4fLXYPgfmQUNu_trg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABdmKX3PgcXaRUH3L7OV+POMiMd5L6pEF4fLXYPgfmQUNu_trg@mail.gmail.com>

On Tue, May 07, 2024 at 01:07:25PM -0700, T.J. Mercier wrote:
> On Mon, May 6, 2024 at 10:43 PM Christoph Hellwig <hch@lst.de> wrote:
> > On Mon, May 06, 2024 at 09:39:53AM -0700, T.J. Mercier wrote:
> > > > You should not check, you simply must handle it by doing the proper
> > > > DMA API based ownership management.
> > >
> > > That doesn't really work for uncached buffers.
> >
> > What uncached buffers?
> 
> For example these ones:
> https://android.googlesource.com/kernel/common/+/refs/heads/android-mainline/drivers/dma-buf/heaps/system_heap.c#141
> 
> Vendors have their own drivers that also export uncached buffers in a
> similar way.

IIUC, you have an uncached dma buffer and you want to pass those pages
to dma_map_sgtable() with DMA_ATTR_SKIP_CPU_SYNC since the buffer has
already been made coherent via other means (the CPU mapping is
uncached). The small kmalloc() bouncing gets in the way as it copies the
data to a cached buffer but it also skips the cache maintenance because
of DMA_ATTR_SKIP_CPU_SYNC. I assume Android carries these patches:

https://lore.kernel.org/r/20201110034934.70898-8-john.stultz@linaro.org/

Arguably this is abusing the DMA API since DMA_ATTR_SKIP_CPU_SYNC should
be used for subsequent mappings of buffers already mapped to device by a
prior dma_map_*() operation. In the above patchset, the buffer is
vmap'ed by the dma-buf heap code and DMA_ATTR_SKIP_CPU_SYNC is used on
the first dma_map_*().

Ignoring the above hacks, I think we can get in a similar situation even
with more complex uses of the DMA API. Let's say some buffers are
initially mapped to device with dma_map_page(), some of them being
bounced but cache maintenance completed. A subsequent dma_map_*()
on those pages may force a bouncing again but DMA_ATTR_SKIP_CPU_SYNC
will avoid the cache maintenance. You are not actually sharing the
original buffers but create separate (bounced) copies no longer coherent
with the device.

I think in general buffer sharing with multiple dma_map_*() calls on the
same buffer and DMA_ATTR_SKIP_CPU_SYNC is incompatible with bouncing,
irrespective of the kmalloc() minalign series. If you do this for a
32-bit device and one of the pages is outside the ZONE_DMA32 range,
you'd get a similar behaviour.

From the kmalloc() minumum alignment perspective, it makes sense to skip
the bouncing if DMA_ATTR_SKIP_CPU_SYNC is passed. We also skip the
bouncing if the direction is DMA_TO_DEVICE or the device is fully
coherent.

A completely untested patch below. It doesn't solve other problems with
bouncing you may have with your out of tree patches and, as Christoph
said, checking in your driver whether the DMA address is a swiotlb
buffer is completely wrong.

---------8<------------------------
diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index e4cb26f6a943..c7ff464a5f81 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -602,15 +602,16 @@ static bool dev_is_untrusted(struct device *dev)
 }
 
 static bool dev_use_swiotlb(struct device *dev, size_t size,
-			    enum dma_data_direction dir)
+			    enum dma_data_direction dir, unsigned long attrs)
 {
 	return IS_ENABLED(CONFIG_SWIOTLB) &&
 		(dev_is_untrusted(dev) ||
-		 dma_kmalloc_needs_bounce(dev, size, dir));
+		 dma_kmalloc_needs_bounce(dev, size, dir, attrs));
 }
 
 static bool dev_use_sg_swiotlb(struct device *dev, struct scatterlist *sg,
-			       int nents, enum dma_data_direction dir)
+			       int nents, enum dma_data_direction dir,
+			       unsigned long attrs)
 {
 	struct scatterlist *s;
 	int i;
@@ -626,7 +627,7 @@ static bool dev_use_sg_swiotlb(struct device *dev, struct scatterlist *sg,
 	 * direction, check the individual lengths in the sg list. If any
 	 * element is deemed unsafe, use the swiotlb for bouncing.
 	 */
-	if (!dma_kmalloc_safe(dev, dir)) {
+	if (!dma_kmalloc_safe(dev, dir, attrs)) {
 		for_each_sg(sg, s, nents, i)
 			if (!dma_kmalloc_size_aligned(s->length))
 				return true;
@@ -1076,7 +1077,7 @@ static void iommu_dma_sync_single_for_cpu(struct device *dev,
 {
 	phys_addr_t phys;
 
-	if (dev_is_dma_coherent(dev) && !dev_use_swiotlb(dev, size, dir))
+	if (dev_is_dma_coherent(dev) && !dev_use_swiotlb(dev, size, dir, 0))
 		return;
 
 	phys = iommu_iova_to_phys(iommu_get_dma_domain(dev), dma_handle);
@@ -1092,7 +1093,7 @@ static void iommu_dma_sync_single_for_device(struct device *dev,
 {
 	phys_addr_t phys;
 
-	if (dev_is_dma_coherent(dev) && !dev_use_swiotlb(dev, size, dir))
+	if (dev_is_dma_coherent(dev) && !dev_use_swiotlb(dev, size, dir, 0))
 		return;
 
 	phys = iommu_iova_to_phys(iommu_get_dma_domain(dev), dma_handle);
@@ -1152,7 +1153,7 @@ static dma_addr_t iommu_dma_map_page(struct device *dev, struct page *page,
 	 * If both the physical buffer start address and size are
 	 * page aligned, we don't need to use a bounce page.
 	 */
-	if (dev_use_swiotlb(dev, size, dir) &&
+	if (dev_use_swiotlb(dev, size, dir, attrs) &&
 	    iova_offset(iovad, phys | size)) {
 		void *padding_start;
 		size_t padding_size, aligned_size;
@@ -1369,7 +1370,7 @@ static int iommu_dma_map_sg(struct device *dev, struct scatterlist *sg,
 			goto out;
 	}
 
-	if (dev_use_sg_swiotlb(dev, sg, nents, dir))
+	if (dev_use_sg_swiotlb(dev, sg, nents, dir, attrs))
 		return iommu_dma_map_sg_swiotlb(dev, sg, nents, dir, attrs);
 
 	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC))
diff --git a/include/linux/dma-map-ops.h b/include/linux/dma-map-ops.h
index 4abc60f04209..857a460e40f0 100644
--- a/include/linux/dma-map-ops.h
+++ b/include/linux/dma-map-ops.h
@@ -277,7 +277,8 @@ static inline bool dev_is_dma_coherent(struct device *dev)
  * Check whether potential kmalloc() buffers are safe for non-coherent DMA.
  */
 static inline bool dma_kmalloc_safe(struct device *dev,
-				    enum dma_data_direction dir)
+				    enum dma_data_direction dir,
+				    unsigned long attrs)
 {
 	/*
 	 * If DMA bouncing of kmalloc() buffers is disabled, the kmalloc()
@@ -288,10 +289,12 @@ static inline bool dma_kmalloc_safe(struct device *dev,
 
 	/*
 	 * kmalloc() buffers are DMA-safe irrespective of size if the device
-	 * is coherent or the direction is DMA_TO_DEVICE (non-desctructive
-	 * cache maintenance and benign cache line evictions).
+	 * is coherent, the direction is DMA_TO_DEVICE (non-desctructive
+	 * cache maintenance and benign cache line evictions) or the
+	 * attributes require no cache maintenance.
 	 */
-	if (dev_is_dma_coherent(dev) || dir == DMA_TO_DEVICE)
+	if (dev_is_dma_coherent(dev) || dir == DMA_TO_DEVICE ||
+	    attrs & DMA_ATTR_SKIP_CPU_SYNC)
 		return true;
 
 	return false;
@@ -328,9 +331,11 @@ static inline bool dma_kmalloc_size_aligned(size_t size)
  * in the kernel.
  */
 static inline bool dma_kmalloc_needs_bounce(struct device *dev, size_t size,
-					    enum dma_data_direction dir)
+					    enum dma_data_direction dir,
+					    unsigned long attrs)
 {
-	return !dma_kmalloc_safe(dev, dir) && !dma_kmalloc_size_aligned(size);
+	return !dma_kmalloc_safe(dev, dir, attrs) &&
+		!dma_kmalloc_size_aligned(size);
 }
 
 void *arch_dma_alloc(struct device *dev, size_t size, dma_addr_t *dma_handle,
diff --git a/kernel/dma/direct.h b/kernel/dma/direct.h
index 18d346118fe8..c2d31a67719e 100644
--- a/kernel/dma/direct.h
+++ b/kernel/dma/direct.h
@@ -96,7 +96,7 @@ static inline dma_addr_t dma_direct_map_page(struct device *dev,
 	}
 
 	if (unlikely(!dma_capable(dev, dma_addr, size, true)) ||
-	    dma_kmalloc_needs_bounce(dev, size, dir)) {
+	    dma_kmalloc_needs_bounce(dev, size, dir, attrs)) {
 		if (is_pci_p2pdma_page(page))
 			return DMA_MAPPING_ERROR;
 		if (is_swiotlb_active(dev))

-- 
Catalin
