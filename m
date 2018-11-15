From: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH 4/9] dma-mapping: move the arm64 ncoherent alloc/free
 support to common code
Date: Thu, 15 Nov 2018 19:50:04 +0000
Message-ID: <20181115195004.GB4535@brain-police>
References: <20181105121931.13481-1-hch@lst.de>
 <20181105121931.13481-5-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181105121931.13481-5-hch@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: iommu@lists.linux-foundation.org, Robin Murphy <robin.murphy@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Guo Ren <ren_guo@c-sky.com>, Laura Abbott <labbott@redhat.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

Hi Christoph,

Minor nit: typo in the subject "ncoherent".

On Mon, Nov 05, 2018 at 01:19:26PM +0100, Christoph Hellwig wrote:
> The arm64 codebase to implement coherent dma allocation for architectures
> with non-coherent DMA is a good start for a generic implementation, given
> that is uses the generic remap helpers, provides the atomic pool for
> allocations that can't sleep and still is realtively simple and well
> tested.  Move it to kernel/dma and allow architectures to opt into it
> using a config symbol.  Architectures just need to provide a new
> arch_dma_prep_coherent helper to writeback an invalidate the caches
> for any memory that gets remapped for uncached access.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  arch/arm64/Kconfig              |   2 +-
>  arch/arm64/mm/dma-mapping.c     | 184 ++------------------------------
>  include/linux/dma-mapping.h     |   5 +
>  include/linux/dma-noncoherent.h |   2 +
>  kernel/dma/Kconfig              |   6 ++
>  kernel/dma/remap.c              | 158 ++++++++++++++++++++++++++-
>  6 files changed, 181 insertions(+), 176 deletions(-)

I'm currently at LPC, so I've not been able to test this, but I've been
through the changes this morning and they look fine to me, so:

Reviewed-by: Will Deacon <will.deacon@arm.com>

Hopefully we'll get the fallout from the previous changes addressed next
week.

Cheers,

Will
