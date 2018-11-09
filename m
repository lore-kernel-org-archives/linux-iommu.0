From: Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH RFC 1/3] mm: When CONFIG_ZONE_DMA32 is set, use DMA32 for
 SLAB_CACHE_DMA
Date: Fri, 9 Nov 2018 13:14:41 +0100
Message-ID: <8f58b778-f8ef-d32e-8803-2a20f171a0b1@suse.cz>
References: <20181109082448.150302-1-drinkcat@chromium.org>
 <20181109082448.150302-2-drinkcat@chromium.org>
 <00afe803-22dd-5a75-70aa-dda0c7752470@suse.cz>
 <CANMq1KB84Lpe_QbiuaKaBOwSsYr9Cis-gv5xpXaV5qjU=ON=7w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CANMq1KB84Lpe_QbiuaKaBOwSsYr9Cis-gv5xpXaV5qjU=ON=7w@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Nicolas Boichat <drinkcat@chromium.org>
Cc: robin.murphy@arm.com, will.deacon@arm.com, joro@8bytes.org, cl@linux.com, penberg@kernel.org, rientjes@google.com, Joonsoo Kim <iamjoonsoo.kim@lge.com>, Andrew Morton <akpm@linux-foundation.org>, mhocko@suse.com, mgorman@techsingularity.net, yehs1@lenovo.com, rppt@linux.vnet.ibm.com, linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>, iommu@lists.linux-foundation.org, lkml <linux-kernel@vger.kernel.org>, linux-mm@kvack.org, yong.wu@mediatek.com, Matthias Brugger <matthias.bgg@gmail.com>, tfiga@google.com, yingjoe.chen@mediatek.com, Alexander.Levin@microsoft.com
List-Id: iommu@lists.linux-foundation.org

On 11/9/18 12:57 PM, Nicolas Boichat wrote:
> On Fri, Nov 9, 2018 at 6:43 PM Vlastimil Babka <vbabka@suse.cz> wrote:
>> Also I'm probably missing the point of this all. In patch 3 you use
>> __get_dma32_pages() thus __get_free_pages(__GFP_DMA32), which uses
>> alloc_pages, thus the page allocator directly, and there's no slab
>> caches involved.
> 
> __get_dma32_pages fixes level 1 page allocations in the patch 3.
> 
> This change fixes level 2 page allocations
> (kmem_cache_zalloc(data->l2_tables, gfp | GFP_DMA)), by transparently
> remapping GFP_DMA to an underlying ZONE_DMA32.
> 
> The alternative would be to create a new SLAB_CACHE_DMA32 when
> CONFIG_ZONE_DMA32 is defined, but then I'm concerned that the callers
> would need to choose between the 2 (GFP_DMA or GFP_DMA32...), and also
> need to use some ifdefs (but maybe that's not a valid concern?).
> 
>> It makes little sense to involve slab for page table
>> allocations anyway, as those tend to be aligned to a page size (or
>> high-order page size). So what am I missing?
> 
> Level 2 tables are ARM_V7S_TABLE_SIZE(2) => 1kb, so we'd waste 3kb if
> we allocated a full page.

Oh, I see.

Well, I think indeed the most transparent would be to support
SLAB_CACHE_DMA32. The callers of kmem_cache_zalloc() would then need not
add anything special to gfp, as that's stored internally upon
kmem_cache_create(). Of course SLAB_BUG_MASK would no longer have to
treat __GFP_DMA32 as unexpected. It would be unexpected when passed to
kmalloc() which doesn't have special dma32 caches, but for a cache
explicitly created to allocate from ZONE_DMA32, I don't see why not. I'm
somewhat surprised that there wouldn't be a need for this earlier, so
maybe I'm still missing something.

> Thanks,
> 
