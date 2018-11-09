From: Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH RFC 1/3] mm: When CONFIG_ZONE_DMA32 is set, use DMA32 for
 SLAB_CACHE_DMA
Date: Fri, 9 Nov 2018 11:43:23 +0100
Message-ID: <00afe803-22dd-5a75-70aa-dda0c7752470@suse.cz>
References: <20181109082448.150302-1-drinkcat@chromium.org>
 <20181109082448.150302-2-drinkcat@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181109082448.150302-2-drinkcat@chromium.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Nicolas Boichat <drinkcat@chromium.org>, Robin Murphy <robin.murphy@arm.com>
Cc: Will Deacon <will.deacon@arm.com>, Joerg Roedel <joro@8bytes.org>, Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>, David Rientjes <rientjes@google.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>, Andrew Morton <akpm@linux-foundation.org>, Michal Hocko <mhocko@suse.com>, Mel Gorman <mgorman@techsingularity.net>, Levin Alexander <alexander.levin@verizon.com>, Huaisheng Ye <yehs1@lenovo.com>, Mike Rapoport <rppt@linux.vnet.ibm.com>, linux-arm-kernel@lists.infradead.org, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, Yong Wu <yong.wu@mediatek.com>, Matthias Brugger <matthias.bgg@gmail.com>, Tomasz Figa <tfiga@google.com>, yingjoe.chen@mediatek.com
List-Id: iommu@lists.linux-foundation.org

On 11/9/18 9:24 AM, Nicolas Boichat wrote:
> Some callers, namely iommu/io-pgtable-arm-v7s, expect the physical
> address returned by kmem_cache_alloc with GFP_DMA parameter to be
> a 32-bit address.
> 
> Instead of adding a separate SLAB_CACHE_DMA32 (and then audit
> all the calls to check if they require memory from DMA or DMA32
> zone), we simply allocate SLAB_CACHE_DMA cache in DMA32 region,
> if CONFIG_ZONE_DMA32 is set.
> 
> Fixes: ad67f5a6545f ("arm64: replace ZONE_DMA with ZONE_DMA32")
> Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>
> ---
>  include/linux/slab.h | 13 ++++++++++++-
>  mm/slab.c            |  2 +-
>  mm/slub.c            |  2 +-
>  3 files changed, 14 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/slab.h b/include/linux/slab.h
> index 918f374e7156f4..390afe90c5dec0 100644
> --- a/include/linux/slab.h
> +++ b/include/linux/slab.h
> @@ -30,7 +30,7 @@
>  #define SLAB_POISON		((slab_flags_t __force)0x00000800U)
>  /* Align objs on cache lines */
>  #define SLAB_HWCACHE_ALIGN	((slab_flags_t __force)0x00002000U)
> -/* Use GFP_DMA memory */
> +/* Use GFP_DMA or GFP_DMA32 memory */
>  #define SLAB_CACHE_DMA		((slab_flags_t __force)0x00004000U)
>  /* DEBUG: Store the last owner for bug hunting */
>  #define SLAB_STORE_USER		((slab_flags_t __force)0x00010000U)
> @@ -126,6 +126,17 @@
>  #define ZERO_OR_NULL_PTR(x) ((unsigned long)(x) <= \
>  				(unsigned long)ZERO_SIZE_PTR)
>  
> +/*
> + * When ZONE_DMA32 is defined, have SLAB_CACHE_DMA allocate memory with
> + * GFP_DMA32 instead of GFP_DMA, as this is what some of the callers
> + * require (instead of duplicating cache for DMA and DMA32 zones).
> + */
> +#ifdef CONFIG_ZONE_DMA32
> +#define SLAB_CACHE_DMA_GFP GFP_DMA32
> +#else
> +#define SLAB_CACHE_DMA_GFP GFP_DMA
> +#endif

AFAICS this will break e.g. x86 which can have both ZONE_DMA and
ZONE_DMA32, and now you would make kmalloc(__GFP_DMA) return objects
from ZONE_DMA32 instead of __ZONE_DMA, which can break something.

Also I'm probably missing the point of this all. In patch 3 you use
__get_dma32_pages() thus __get_free_pages(__GFP_DMA32), which uses
alloc_pages, thus the page allocator directly, and there's no slab
caches involved. It makes little sense to involve slab for page table
allocations anyway, as those tend to be aligned to a page size (or
high-order page size). So what am I missing?
