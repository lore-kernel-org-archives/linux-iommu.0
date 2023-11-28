Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD89C39AC1;
	Tue, 28 Nov 2023 17:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC3D5C433C7;
	Tue, 28 Nov 2023 17:44:50 +0000 (UTC)
Date: Tue, 28 Nov 2023 17:44:48 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Christoph Hellwig <hch@lst.de>,
	Hamza Mahfooz <someguy@effective-light.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Andrew <travneff@gmail.com>, Ferry Toth <ferry.toth@elsinga.info>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Thorsten Leemhuis <regressions@leemhuis.info>,
	iommu@lists.linux.dev,
	Kernel development list <linux-kernel@vger.kernel.org>,
	USB mailing list <linux-usb@vger.kernel.org>,
	Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>
Subject: Re: Bug in add_dma_entry()'s debugging code
Message-ID: <ZWYnECPRKca5Dpqc@arm.com>
References: <736e584f-7d5f-41aa-a382-2f4881ba747f@rowland.harvard.edu>
 <20231127160759.GA1668@lst.de>
 <637d6dff-de56-4815-a15a-1afccde073f0@rowland.harvard.edu>
 <20231128133702.GA9917@lst.de>
 <cb7dc5da-37cb-45ba-9846-5a085f55692e@rowland.harvard.edu>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cb7dc5da-37cb-45ba-9846-5a085f55692e@rowland.harvard.edu>

On Tue, Nov 28, 2023 at 10:18:19AM -0500, Alan Stern wrote:
> On Tue, Nov 28, 2023 at 02:37:02PM +0100, Christoph Hellwig wrote:
> > I'd actually go one step back:
> > 
> >  1) for not cache coherent DMA you can't do overlapping operations inside
> >     a cache line
> 
> Rephrasing slightly: You mustn't perform multiple non-cache-coherent DMA 
> operations that touch the same cache line concurrently.  (The word 
> "overlapping" is a a little ambiguous in this context.)

The problem is worse. I'd say you should not perform even a single
non-cache-coherent DMA (usually from-device or bidirectional) operation
if the cache line is shared with anything else modifying it. It doesn't
need to be another DMA operation. But that's more difficult to add to
the DMA API debug code (maybe something like the bouncing logic in
dma_kmalloc_needs_bounce()).

> > The logical confcusion from that would be that IFF dma-debug is enabled on
> > any platform we need to set ARCH_DMA_MINALIGN to the cache line size.

Or just force the kmalloc() min align to cache_line_size(), something
like:

diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index 4a658de44ee9..3ece20367636 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -543,6 +543,8 @@ static inline int dma_get_cache_alignment(void)
 #ifdef ARCH_HAS_DMA_MINALIGN
 	return ARCH_DMA_MINALIGN;
 #endif
+	if (IS_ENABLED(CONFIG_DMA_API_DEBUG))
+		return cache_line_size();
 	return 1;
 }
 #endif
diff --git a/mm/slab_common.c b/mm/slab_common.c
index 8d431193c273..d0b21d6e9328 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -879,7 +879,7 @@ static unsigned int __kmalloc_minalign(void)
 	unsigned int minalign = dma_get_cache_alignment();
 
 	if (IS_ENABLED(CONFIG_DMA_BOUNCE_UNALIGNED_KMALLOC) &&
-	    is_swiotlb_allocated())
+	    is_swiotlb_allocated() && !IS_ENABLED(CONFIG_DMA_API_DEBUG))
 		minalign = ARCH_KMALLOC_MINALIGN;
 
 	return max(minalign, arch_slab_minalign());

Also note that to_cacheline_number() in kernel/dma/debug.c only takes
into account the L1_CACHE_SHIFT. On arm64 for example, cache_line_size()
returns the maximum line of all the cache levels (and we've seen
hardware where the L1 is 64-byte, L2 is 128).

> > BUT:  we're actually reduzing our dependency on ARCH_DMA_MINALIGN by
> > moving to bounce buffering unaligned memory for non-coherent
> > architectures,
> 
> What's the reason for this?  To allow the minimum allocation size to be
> smaller than the cache line size?  Does the savings in memory make up 
> for the extra overhead of bounce buffering?
> 
> Or is this just to allow people to be more careless about how they 
> allocate their DMA buffers (which doesn't seem to make sense)?

It's the former and it does make a difference with lots of small
structure or string allocations.

[...]
> I get the impression that you would really like to have two different 
> versions of kmalloc() and friends: one for buffers that will be used in 
> DMA (and hence require cache-line alignment) and one for buffers that 
> won't be.

We've been there for the past 2-3 years (and a few other options). It's
hard to guess in a generic way because the allocation place may not
necessarily know how the device is going to access that memory (PIO,
DMA). The conclusion was that for those cases where the buffer is small,
we just do a bounce. If it's performance critical, the driver can use a
kmem_cache_create(SLAB_HWCACHE_ALIGN) and avoid the bouncing.

-- 
Catalin
