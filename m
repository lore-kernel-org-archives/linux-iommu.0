From: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH v6 2/3] iommu/io-pgtable-arm-v7s: Request DMA32 memory,
 and improve debugging
Date: Sat, 19 Jan 2019 23:57:39 +0000
Message-ID: <20190119235737.GE26876@brain-police>
References: <20181210011504.122604-1-drinkcat@chromium.org>
 <20181210011504.122604-3-drinkcat@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181210011504.122604-3-drinkcat@chromium.org>
Sender: stable-owner@vger.kernel.org
To: Nicolas Boichat <drinkcat@chromium.org>
Cc: Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>, Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>, David Rientjes <rientjes@google.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>, Andrew Morton <akpm@linux-foundation.org>, Vlastimil Babka <vbabka@suse.cz>, Michal Hocko <mhocko@suse.com>, Mel Gorman <mgorman@techsingularity.net>, Levin Alexander <Alexander.Levin@microsoft.com>, Huaisheng Ye <yehs1@lenovo.com>, Mike Rapoport <rppt@linux.vnet.ibm.com>, linux-arm-kernel@lists.infradead.org, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, Yong Wu <yong.wu@mediatek.com>, Matthias Brugger <matthias.bgg@gmail.com>, Tomasz Figa <tfiga@google.com>, yingjoe.chen@mediatek.com, hch@infr
List-Id: iommu@lists.linux-foundation.org

On Mon, Dec 10, 2018 at 09:15:03AM +0800, Nicolas Boichat wrote:
> IOMMUs using ARMv7 short-descriptor format require page tables
> (level 1 and 2) to be allocated within the first 4GB of RAM, even
> on 64-bit systems.
> 
> For level 1/2 pages, ensure GFP_DMA32 is used if CONFIG_ZONE_DMA32
> is defined (e.g. on arm64 platforms).
> 
> For level 2 pages, allocate a slab cache in SLAB_CACHE_DMA32. Note
> that we do not explicitly pass GFP_DMA[32] to kmem_cache_zalloc,
> as this is not strictly necessary, and would cause a warning
> in mm/sl*b.c, as we did not update GFP_SLAB_BUG_MASK.
> 
> Also, print an error when the physical address does not fit in
> 32-bit, to make debugging easier in the future.
> 
> Cc: stable@vger.kernel.org
> Fixes: ad67f5a6545f ("arm64: replace ZONE_DMA with ZONE_DMA32")
> Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>

Assuming you're routing all of this via akpm:

Acked-by: Will Deacon <will.deacon@arm.com>

Will
