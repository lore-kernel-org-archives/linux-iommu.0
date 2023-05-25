Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14D4D33F1
	for <iommu@lists.linux.dev>; Thu, 25 May 2023 12:31:48 +0000 (UTC)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.206])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4QRnS36Rt6z67fjq;
	Thu, 25 May 2023 20:29:39 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 25 May
 2023 13:31:39 +0100
Date: Thu, 25 May 2023 13:31:38 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Catalin Marinas <catalin.marinas@arm.com>
CC: Linus Torvalds <torvalds@linux-foundation.org>, Christoph Hellwig
	<hch@lst.de>, Robin Murphy <robin.murphy@arm.com>, Arnd Bergmann
	<arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Will
 Deacon" <will@kernel.org>, Marc Zyngier <maz@kernel.org>, Andrew Morton
	<akpm@linux-foundation.org>, Herbert Xu <herbert@gondor.apana.org.au>, "Ard
 Biesheuvel" <ardb@kernel.org>, Isaac Manjarres <isaacmanjarres@google.com>,
	Saravana Kannan <saravanak@google.com>, Alasdair Kergon <agk@redhat.com>,
	Daniel Vetter <daniel@ffwll.ch>, "Joerg Roedel" <joro@8bytes.org>, Mark Brown
	<broonie@kernel.org>, Mike Snitzer <snitzer@kernel.org>, "Rafael J. Wysocki"
	<rafael@kernel.org>, <linux-mm@kvack.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v5 00/15] mm, dma, arm64: Reduce ARCH_KMALLOC_MINALIGN
 to 8
Message-ID: <20230525133138.000014b4@Huawei.com>
In-Reply-To: <20230524171904.3967031-1-catalin.marinas@arm.com>
References: <20230524171904.3967031-1-catalin.marinas@arm.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100004.china.huawei.com (7.191.162.219) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected

On Wed, 24 May 2023 18:18:49 +0100
Catalin Marinas <catalin.marinas@arm.com> wrote:

> Hi,
> 
> Another version of the series reducing the kmalloc() minimum alignment
> on arm64 to 8 (from 128). Other architectures can easily opt in by
> defining ARCH_KMALLOC_MINALIGN as 8 and selecting
> DMA_BOUNCE_UNALIGNED_KMALLOC.
> 
> The first 10 patches decouple ARCH_KMALLOC_MINALIGN from
> ARCH_DMA_MINALIGN and, for arm64, limit the kmalloc() caches to those
> aligned to the run-time probed cache_line_size(). On arm64 we gain the
> kmalloc-{64,192} caches.
> 
> The subsequent patches (11 to 15) further reduce the kmalloc() caches to
> kmalloc-{8,16,32,96} if the default swiotlb is present by bouncing small
> buffers in the DMA API.

Hi Catalin,

I think IIO_DMA_MINALIGN needs to switch to ARCH_DMA_MINALIGN as well.

It's used to force static alignement of buffers with larger structures,
to make them suitable for non coherent DMA, similar to your other cases.

Thanks,

Jonathan


> 
> Changes since v4:
> 
> - Following Robin's suggestions, reworked the iommu handling so that the
>   buffer size checks are done in the dev_use_swiotlb() and
>   dev_use_sg_swiotlb() functions (together with dev_is_untrusted()). The
>   sync operations can now check for the SG_DMA_USE_SWIOTLB flag. Since
>   this flag is no longer specific to kmalloc() bouncing (covers
>   dev_is_untrusted() as well), the sg_is_dma_use_swiotlb() and
>   sg_dma_mark_use_swiotlb() functions are always defined if
>   CONFIG_SWIOTLB.
> 
> - Dropped ARCH_WANT_KMALLOC_DMA_BOUNCE, only left the
>   DMA_BOUNCE_UNALIGNED_KMALLOC option, selectable by the arch code. The
>   NEED_SG_DMA_FLAGS is now selected by IOMMU_DMA if SWIOTLB.
> 
> - Rather than adding another config option, allow
>   dma_get_cache_alignment() to be overridden by the arch code
>   (Christoph's suggestion).
> 
> - Added a comment to the dma_kmalloc_needs_bounce() function on the
>   heuristics behind the bouncing.
> 
> - Added acked-by/reviewed-by tags (not adding Ard's tested-by yet as
>   there were some changes).
> 
> The updated patches are also available on this branch:
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux devel/kmalloc-minalign
> 
> Thanks.
> 
> Catalin Marinas (14):
>   mm/slab: Decouple ARCH_KMALLOC_MINALIGN from ARCH_DMA_MINALIGN
>   dma: Allow dma_get_cache_alignment() to be overridden by the arch code
>   mm/slab: Simplify create_kmalloc_cache() args and make it static
>   mm/slab: Limit kmalloc() minimum alignment to
>     dma_get_cache_alignment()
>   drivers/base: Use ARCH_DMA_MINALIGN instead of ARCH_KMALLOC_MINALIGN
>   drivers/gpu: Use ARCH_DMA_MINALIGN instead of ARCH_KMALLOC_MINALIGN
>   drivers/usb: Use ARCH_DMA_MINALIGN instead of ARCH_KMALLOC_MINALIGN
>   drivers/spi: Use ARCH_DMA_MINALIGN instead of ARCH_KMALLOC_MINALIGN
>   drivers/md: Use ARCH_DMA_MINALIGN instead of ARCH_KMALLOC_MINALIGN
>   arm64: Allow kmalloc() caches aligned to the smaller cache_line_size()
>   dma-mapping: Force bouncing if the kmalloc() size is not
>     cache-line-aligned
>   iommu/dma: Force bouncing if the size is not cacheline-aligned
>   mm: slab: Reduce the kmalloc() minimum alignment if DMA bouncing
>     possible
>   arm64: Enable ARCH_WANT_KMALLOC_DMA_BOUNCE for arm64
> 
> Robin Murphy (1):
>   scatterlist: Add dedicated config for DMA flags
> 
>  arch/arm64/Kconfig             |  1 +
>  arch/arm64/include/asm/cache.h |  3 ++
>  arch/arm64/mm/init.c           |  7 +++-
>  drivers/base/devres.c          |  6 ++--
>  drivers/gpu/drm/drm_managed.c  |  6 ++--
>  drivers/iommu/Kconfig          |  1 +
>  drivers/iommu/dma-iommu.c      | 50 +++++++++++++++++++++++-----
>  drivers/md/dm-crypt.c          |  2 +-
>  drivers/pci/Kconfig            |  1 +
>  drivers/spi/spidev.c           |  2 +-
>  drivers/usb/core/buffer.c      |  8 ++---
>  include/linux/dma-map-ops.h    | 61 ++++++++++++++++++++++++++++++++++
>  include/linux/dma-mapping.h    |  4 ++-
>  include/linux/scatterlist.h    | 29 +++++++++++++---
>  include/linux/slab.h           | 14 ++++++--
>  kernel/dma/Kconfig             |  7 ++++
>  kernel/dma/direct.h            |  3 +-
>  mm/slab.c                      |  6 +---
>  mm/slab.h                      |  5 ++-
>  mm/slab_common.c               | 46 +++++++++++++++++++------
>  20 files changed, 213 insertions(+), 49 deletions(-)
> 
> 
> 

