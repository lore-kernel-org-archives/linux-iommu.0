Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB2F5D30B
	for <iommu@lists.linux.dev>; Wed,  5 Jul 2023 13:40:39 +0000 (UTC)
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-635e3ceb152so33522976d6.2
        for <iommu@lists.linux.dev>; Wed, 05 Jul 2023 06:40:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688564438; x=1691156438;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=OVl7S6svfqIntE0S0D0sZ/BLm4TgMTlV195W9gSGqjI=;
        b=S/GzS4Yu/u1Ktj/ZQgqK8bBoepHz0jbR+VqbAnF0Hik8LCCrxyUQEvmBUQdXvHoKyj
         7wPRdc1Gx/vD9F6EhxsQhdtoiDGmTTa4wI+/oTkU+mMcsW8cpHxtAc2rsXSZgGiH6b4z
         FClKjjULBujaw8sKVsMYTfQs5HQlzzM+8a71Va/t9WncsybaI8kpOEvfyfwBnpIw11X6
         fxvHMeqm0LxcdU714hBHIjJMWg8NLPhbGOSKlJ+vpt1hgSD13esnyD/TJqyL/M53oMNK
         lPe/xfqZQzDLFGSPf3CeUZE4jenYiSzpsk69BJWwinBFQCxS69s6AvEAf6o5AcKc5ptM
         UKUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688564438; x=1691156438;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OVl7S6svfqIntE0S0D0sZ/BLm4TgMTlV195W9gSGqjI=;
        b=AgD1544E+pObUIm01+SqBCLoFGg1gyZDM+0OlHIDd+8cdI8tWCGqzEG6DOHYAc+9Fb
         qsU8Y/1m14CcIIRoydah0rShlmcQlTx0nkqg6T6QSSs6xs98Z3oGUOEvyKl9ZNFpJTzu
         ruqh5jtrKhS8xEuH9ODDA8ZsjeKATcZY3ZCXlmHNg7ddGixO9HZZl48uiJdjSmndXxoS
         huCxTImKfBEE6ceTJEAEY4TIMJy5WiA1g78Qy0J9rBKAQdeBcqJ4dM8ehNiS2Hxfz3bg
         UsiEmgTrqefJ+9niehApQWSMtIEHFZJXsDgoK0SGqsvlaprlh8pbqLCJH/utrcqoM+g3
         fEMg==
X-Gm-Message-State: ABy/qLbtVJX+t9+/kepdx7NGhIjND+kq3oFDJBQiHcn/68sCGaGlc2bv
	7+YEtMOx1nNfsqTp3Wmu0VaPdbiVmHZzgoAawrk1Tw==
X-Google-Smtp-Source: APBJJlFuWrcMdffrgiGAPowe14BbSPjQvY6jEOP1IVPswkR9U1SExJXl45gInbXylx8/bDqkstvmwPgsWSDcq8TTVbw=
X-Received: by 2002:a05:6214:27cf:b0:634:7c34:6c96 with SMTP id
 ge15-20020a05621427cf00b006347c346c96mr15049376qvb.7.1688564438448; Wed, 05
 Jul 2023 06:40:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20230612153201.554742-1-catalin.marinas@arm.com>
In-Reply-To: <20230612153201.554742-1-catalin.marinas@arm.com>
From: Amit Pundir <amit.pundir@linaro.org>
Date: Wed, 5 Jul 2023 19:10:02 +0530
Message-ID: <CAMi1Hd04mu6JojT3y6wyN2YeVkPR5R3qnkKJ8iR8if_YByCn4w@mail.gmail.com>
Subject: Re: [PATCH v7 00/17] mm, dma, arm64: Reduce ARCH_KMALLOC_MINALIGN to 8
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Christoph Hellwig <hch@lst.de>, 
	Robin Murphy <robin.murphy@arm.com>, Arnd Bergmann <arnd@arndb.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Will Deacon <will@kernel.org>, 
	Marc Zyngier <maz@kernel.org>, Herbert Xu <herbert@gondor.apana.org.au>, 
	Ard Biesheuvel <ardb@kernel.org>, Isaac Manjarres <isaacmanjarres@google.com>, 
	Saravana Kannan <saravanak@google.com>, Alasdair Kergon <agk@redhat.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Joerg Roedel <joro@8bytes.org>, Mark Brown <broonie@kernel.org>, Mike Snitzer <snitzer@kernel.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Jonathan Cameron <jic23@kernel.org>, Vlastimil Babka <vbabka@suse.cz>, 
	linux-mm@kvack.org, iommu@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, 
	Linux regressions mailing list <regressions@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"

Hi Catalin,

On Wed, 5 Jul 2023 at 18:17, Catalin Marinas <catalin.marinas@arm.com> wrote:
>
> Hi,
>
> That's v7 of the series reducing the kmalloc() minimum alignment on
> arm64 to 8 (from 128). There's no new/different functionality, mostly
> cosmetic changes and acks/tested-bys.
>
> Andrew, if there are no further comments or objections to this version,
> are you ok to take the series through the mm tree? The arm64 changes are
> fairly small. Alternatively, I can push it into linux-next now to give
> it some wider exposure and decide whether to upstream it when the
> merging window opens. Thanks.

This patch series broke Dragonboard 845c (SDM845) running AOSP.
With this series I run into random oops at __kmem_cache_alloc_node().
Here is one such boot log https://bugs.linaro.org/attachment.cgi?id=1146

Reverting "arm64: Enable ARCH_WANT_KMALLOC_DMA_BOUNCE for arm64"
fixes it for the time being.

Regards,
Amit Pundir


>
> The updated patches are also available on this branch:
>
> git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux devel/kmalloc-minalign
>
> Changes since v6
> (https://lore.kernel.org/r/20230531154836.1366225-1-catalin.marinas@arm.com):
>
> - Moved ARCH_DMA_MINALIGN to include/linux/cache.h from slab.h (it
>   matches the asm/cache.h where most architectures defining this macro
>   place it).
>
> - Single body for __kmalloc_minalign() with an #ifdef.
>
> - Renamed the sg_dma_use_swiotlb() to sg_dma_is_swiotlb() (Robin's
>   suggestion).
>
> - Added acks/tested-by.
>
> Catalin Marinas (15):
>   mm/slab: Decouple ARCH_KMALLOC_MINALIGN from ARCH_DMA_MINALIGN
>   dma: Allow dma_get_cache_alignment() to be overridden by the arch code
>   mm/slab: Simplify create_kmalloc_cache() args and make it static
>   mm/slab: Limit kmalloc() minimum alignment to
>     dma_get_cache_alignment()
>   drivers/base: Use ARCH_DMA_MINALIGN instead of ARCH_KMALLOC_MINALIGN
>   drivers/gpu: Use ARCH_DMA_MINALIGN instead of ARCH_KMALLOC_MINALIGN
>   drivers/usb: Use ARCH_DMA_MINALIGN instead of ARCH_KMALLOC_MINALIGN
>   drivers/spi: Use ARCH_DMA_MINALIGN instead of ARCH_KMALLOC_MINALIGN
>   dm-crypt: Use ARCH_DMA_MINALIGN instead of ARCH_KMALLOC_MINALIGN
>   iio: core: Use ARCH_DMA_MINALIGN instead of ARCH_KMALLOC_MINALIGN
>   arm64: Allow kmalloc() caches aligned to the smaller cache_line_size()
>   dma-mapping: Force bouncing if the kmalloc() size is not
>     cache-line-aligned
>   iommu/dma: Force bouncing if the size is not cacheline-aligned
>   mm: slab: Reduce the kmalloc() minimum alignment if DMA bouncing
>     possible
>   arm64: Enable ARCH_WANT_KMALLOC_DMA_BOUNCE for arm64
>
> Robin Murphy (2):
>   scatterlist: Add dedicated config for DMA flags
>   dma-mapping: Name SG DMA flag helpers consistently
>
>  arch/arm64/Kconfig             |  1 +
>  arch/arm64/include/asm/cache.h |  3 ++
>  arch/arm64/mm/init.c           |  7 +++-
>  drivers/base/devres.c          |  6 ++--
>  drivers/gpu/drm/drm_managed.c  |  6 ++--
>  drivers/iommu/Kconfig          |  1 +
>  drivers/iommu/dma-iommu.c      | 58 ++++++++++++++++++++++++--------
>  drivers/iommu/iommu.c          |  2 +-
>  drivers/md/dm-crypt.c          |  2 +-
>  drivers/pci/Kconfig            |  1 +
>  drivers/spi/spidev.c           |  2 +-
>  drivers/usb/core/buffer.c      |  8 ++---
>  include/linux/cache.h          |  6 ++++
>  include/linux/dma-map-ops.h    | 61 ++++++++++++++++++++++++++++++++++
>  include/linux/dma-mapping.h    |  5 ++-
>  include/linux/iio/iio.h        |  2 +-
>  include/linux/scatterlist.h    | 60 ++++++++++++++++++++++++++-------
>  include/linux/slab.h           | 14 +++++---
>  kernel/dma/Kconfig             |  7 ++++
>  kernel/dma/direct.c            |  2 +-
>  kernel/dma/direct.h            |  3 +-
>  mm/slab.c                      |  6 +---
>  mm/slab.h                      |  5 ++-
>  mm/slab_common.c               | 41 +++++++++++++++++------
>  24 files changed, 244 insertions(+), 65 deletions(-)
>
