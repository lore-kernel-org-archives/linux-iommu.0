Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E597B3C25
	for <iommu@lists.linux.dev>; Tue, 13 Jun 2023 11:13:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E4EEC433EF;
	Tue, 13 Jun 2023 11:13:49 +0000 (UTC)
Date: Tue, 13 Jun 2023 12:13:46 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Christoph Hellwig <hch@lst.de>, Robin Murphy <robin.murphy@arm.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Ard Biesheuvel <ardb@kernel.org>,
	Isaac Manjarres <isaacmanjarres@google.com>,
	Saravana Kannan <saravanak@google.com>,
	Alasdair Kergon <agk@redhat.com>, Daniel Vetter <daniel@ffwll.ch>,
	Joerg Roedel <joro@8bytes.org>, Mark Brown <broonie@kernel.org>,
	Mike Snitzer <snitzer@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>, linux-mm@kvack.org,
	iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH v7 01/17] mm/slab: Decouple ARCH_KMALLOC_MINALIGN from
 ARCH_DMA_MINALIGN
Message-ID: <ZIhPaixb/0ve7zZo@arm.com>
References: <20230612153201.554742-1-catalin.marinas@arm.com>
 <20230612153201.554742-2-catalin.marinas@arm.com>
 <5faed13c-43f2-66ef-c42c-7d7bebb224d8@suse.cz>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5faed13c-43f2-66ef-c42c-7d7bebb224d8@suse.cz>

On Tue, Jun 13, 2023 at 11:46:31AM +0200, Vlastimil Babka wrote:
> On 6/12/23 17:31, Catalin Marinas wrote:
> > In preparation for supporting a kmalloc() minimum alignment smaller than
> > the arch DMA alignment, decouple the two definitions. This requires that
> > either the kmalloc() caches are aligned to a (run-time) cache-line size
> > or the DMA API bounces unaligned kmalloc() allocations. Subsequent
> > patches will implement both options.
> > 
> > After this patch, ARCH_DMA_MINALIGN is expected to be used in static
> > alignment annotations and defined by an architecture to be the maximum
> > alignment for all supported configurations/SoCs in a single Image.
> > Architectures opting in to a smaller ARCH_KMALLOC_MINALIGN will need to
> > define its value in the arch headers.
> > 
> > Since ARCH_DMA_MINALIGN is now always defined, adjust the #ifdef in
> > dma_get_cache_alignment() so that there is no change for architectures
> > not requiring a minimum DMA alignment.
> > 
> > Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Cc: Vlastimil Babka <vbabka@suse.cz>
> > Cc: Christoph Hellwig <hch@lst.de>
> > Cc: Robin Murphy <robin.murphy@arm.com>
> > Tested-by: Isaac J. Manjarres <isaacmanjarres@google.com>
> 
> Acked-by: Vlastimil Babka <vbabka@suse.cz>

Thanks for the ack.

It looks like moving the ARCH_DMA_MINALIGN definition to linux/cache.h
messes up powerpc32 -
https://lore.kernel.org/r/202306131053.1ybvRRhO-lkp@intel.com - possibly
a few other architecture that define this macro in a file other than
asm/cache.h (I only tested powerpc64 before posting).

At a quick grep, we have:

  arch/microblaze/include/asm/page.h:34: #define ARCH_DMA_MINALIGN       L1_CACHE_BYTES

This could be moved to asm/cache.h. It probably already relies on some
indirect includes.

  arch/mips/include/asm/mach-generic/kmalloc.h:10: #define ARCH_DMA_MINALIGN       128
  arch/mips/include/asm/mach-ip32/kmalloc.h:7: #define ARCH_DMA_MINALIGN       32
  arch/mips/include/asm/mach-ip32/kmalloc.h:9: #define ARCH_DMA_MINALIGN       128
  arch/mips/include/asm/mach-n64/kmalloc.h:6: #define ARCH_DMA_MINALIGN L1_CACHE_BYTES
  arch/mips/include/asm/mach-tx49xx/kmalloc.h:5: #define ARCH_DMA_MINALIGN L1_CACHE_BYTES

These are ok since kmalloc.h is included in asm/cache.h.

  arch/powerpc/include/asm/page_32.h:16: #define ARCH_DMA_MINALIGN       L1_CACHE_BYTES

I'd move this macro to asm/cache.h on powerpc. asm/page_32.h already
includes asm/cache.h.

  arch/sh/include/asm/page.h:181: #define ARCH_DMA_MINALIGN       L1_CACHE_BYTES

Same here. L1_CACHE_BYTES is defined in asm/cache.h but it's not
included in asm/page.h, so I guess it's relying on some indirect
includes.

I'll post three more patches to move the ARCH_DMA_MINALIGN to
asm/cache.h for microblaze, powerpc and sh (once I finished build
testing).

-- 
Catalin
