Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 078608F44
	for <iommu@lists.linux.dev>; Thu, 20 Apr 2023 17:43:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BA16C433EF;
	Thu, 20 Apr 2023 17:43:33 +0000 (UTC)
Date: Thu, 20 Apr 2023 18:43:30 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Petr Tesarik <petr.tesarik.ext@huawei.com>
Cc: Isaac Manjarres <isaacmanjarres@google.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Arnd Bergmann <arnd@arndb.de>, Christoph Hellwig <hch@lst.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Ard Biesheuvel <ardb@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	Alasdair Kergon <agk@redhat.com>, Daniel Vetter <daniel@ffwll.ch>,
	Joerg Roedel <joro@8bytes.org>, Mark Brown <broonie@kernel.org>,
	Mike Snitzer <snitzer@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>, linux-mm@kvack.org,
	iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 00/13] mm, dma, arm64: Reduce ARCH_KMALLOC_MINALIGN to
 8
Message-ID: <ZEF5wlFZ+1M6pnrh@arm.com>
References: <20221106220143.2129263-1-catalin.marinas@arm.com>
 <ZBNiN9CR2F/fvUTh@google.com>
 <ZEARbKMfMS8KdkhJ@arm.com>
 <66a67d9e-70ce-9e2c-3b23-2d49447c4f24@huawei.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <66a67d9e-70ce-9e2c-3b23-2d49447c4f24@huawei.com>

On Thu, Apr 20, 2023 at 11:52:00AM +0200, Petr Tesarik wrote:
> On 4/19/2023 6:06 PM, Catalin Marinas wrote:
> > On Thu, Mar 16, 2023 at 11:38:47AM -0700, Isaac Manjarres wrote:
> >[...]>> Given this, I don't think there's anything blocking this series from
> >> being merged. The requirement for SWIOTLB to get to the minimum
> >> kmalloc alignment down to 8 bytes shouldn't prevent this series from
> >> being merged, as the amount of memory that is allocated for SWIOTLB
> >> can be configured through the commandline to minimize the impact of
> >> having SWIOTLB memory. Additionally, even if no SWIOTLB is present,
> >> this series still offers memory savings on a lot of ARM64 platforms
> >> by using the cache line size as the minimum alignment for kmalloc.
> > 
> > Actually, there's some progress on the swiotlb front to allow dynamic
> > allocation. I haven't reviewed the series yet (I wasn't aware of it
> > until v2) but at a quick look, it limits the dynamic allocation to
> > bouncing buffers of at least a page size. Maybe this can be later
> > improved for buffers below ARCH_DMA_MINALIGN.
> 
> Indeed. My patch allocates dynamic bounce buffers with
> dma_direct_alloc_pages() to keep things simple for now, but there is no
> real reason against allocating less than a page with another suitable
> allocator.

I guess it could fall back to a suitably aligned kmalloc() for smaller
sizes.

> However, I'd be interested what the use case is, so I can assess the
> performance impact, which depends on workload, and FYI it may not even
> be negative. ;-)

On arm64 we have an ARCH_DMA_MINALIGN of 128 bytes as that's the largest
cache line size that you can find on a non-coherent platform. The
implication is that ARCH_KMALLOC_MINALIGN is also 128, so smaller
slab-{8,16,32,64,96,192} caches cannot be created, leading to some
memory wastage.

This series decouples the two static alignments so that we can have an
ARCH_KMALLOC_MINALIGN of 8 while keeping ARCH_DMA_MINALIGN as 128. The
problem is that there are some drivers that do a small kmalloc() (below
a cache line size; typically USB drivers) and expect DMA to such buffer
to work. If the cache line is shared with some unrelated data, either
the cache maintenance in the DMA API corrupts such data or the cache
dirtying overrides inbound DMA data.

So, the solution is to bounce such small buffers if they end up in
functions like dma_map_single(). All we need is for the bounce buffer to
be aligned to the cache line size and honour the coherent mask (normally
ok with one of the GFP_DMA/DMA32 flags if required).

The swiotlb buffer would solve this but there are some (mobile)
platforms where the vendor disables the bounce buffer to save memory.
Having a way to dynamically allocate it in those rare cases above would
be helpful.

-- 
Catalin
