From: Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH v5 1/3] mm: Add support for kmem caches in DMA32 zone
Date: Fri, 7 Dec 2018 08:25:27 +0100
Message-ID: <0d0d0571-be74-d9a4-4f2d-27881da2e2ed@suse.cz>
References: <20181207061620.107881-1-drinkcat@chromium.org>
 <20181207061620.107881-2-drinkcat@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181207061620.107881-2-drinkcat@chromium.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Nicolas Boichat <drinkcat@chromium.org>, Will Deacon <will.deacon@arm.com>
Cc: Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>, Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>, David Rientjes <rientjes@google.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>, Andrew Morton <akpm@linux-foundation.org>, Michal Hocko <mhocko@suse.com>, Mel Gorman <mgorman@techsingularity.net>, Levin Alexander <Alexander.Levin@microsoft.com>, Huaisheng Ye <yehs1@lenovo.com>, Mike Rapoport <rppt@linux.vnet.ibm.com>, linux-arm-kernel@lists.infradead.org, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, Yong Wu <yong.wu@mediatek.com>, Matthias Brugger <matthias.bgg@gmail.com>, Tomasz Figa <tfiga@google.com>, yingjoe.chen@mediatek.com, hch@infradead.org, Matthew Wilcox <willy@infradead>
List-Id: iommu@lists.linux-foundation.org

On 12/7/18 7:16 AM, Nicolas Boichat wrote:
> IOMMUs using ARMv7 short-descriptor format require page tables
> to be allocated within the first 4GB of RAM, even on 64-bit systems.
> On arm64, this is done by passing GFP_DMA32 flag to memory allocation
> functions.
> 
> For IOMMU L2 tables that only take 1KB, it would be a waste to allocate
> a full page using get_free_pages, so we considered 3 approaches:
>  1. This patch, adding support for GFP_DMA32 slab caches.
>  2. genalloc, which requires pre-allocating the maximum number of L2
>     page tables (4096, so 4MB of memory).
>  3. page_frag, which is not very memory-efficient as it is unable
>     to reuse freed fragments until the whole page is freed.
> 
> This change makes it possible to create a custom cache in DMA32 zone
> using kmem_cache_create, then allocate memory using kmem_cache_alloc.
> 
> We do not create a DMA32 kmalloc cache array, as there are currently
> no users of kmalloc(..., GFP_DMA32). These calls will continue to
> trigger a warning, as we keep GFP_DMA32 in GFP_SLAB_BUG_MASK.
> 
> This implies that calls to kmem_cache_*alloc on a SLAB_CACHE_DMA32
> kmem_cache must _not_ use GFP_DMA32 (it is anyway redundant and
> unnecessary).
> 
> Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>

Acked-by: Vlastimil Babka <vbabka@suse.cz>
