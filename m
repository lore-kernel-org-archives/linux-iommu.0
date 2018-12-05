From: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH v4 3/3] iommu/io-pgtable-arm-v7s: Request DMA32 memory,
 and improve debugging
Date: Wed, 5 Dec 2018 14:40:06 +0000
Message-ID: <1d211576-9153-cca1-5cd0-8c9881bd3fa4@arm.com>
References: <20181205054828.183476-1-drinkcat@chromium.org>
 <20181205054828.183476-4-drinkcat@chromium.org>
 <20181205135406.GA29031@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181205135406.GA29031@infradead.org>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@infradead.org>, Nicolas Boichat <drinkcat@chromium.org>
Cc: Will Deacon <will.deacon@arm.com>, Joerg Roedel <joro@8bytes.org>, Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>, David Rientjes <rientjes@google.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>, Andrew Morton <akpm@linux-foundation.org>, Vlastimil Babka <vbabka@suse.cz>, Michal Hocko <mhocko@suse.com>, Mel Gorman <mgorman@techsingularity.net>, Levin Alexander <Alexander.Levin@microsoft.com>, Huaisheng Ye <yehs1@lenovo.com>, Mike Rapoport <rppt@linux.vnet.ibm.com>, linux-arm-kernel@lists.infradead.org, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, Yong Wu <yong.wu@mediatek.com>, Matthias Brugger <matthias.bgg@gmail.com>, Tomasz Figa <tfiga@google.com>, yingjoe.chen@mediatek.comMatthew Wilcox <wi>
List-Id: iommu@lists.linux-foundation.org

On 05/12/2018 13:54, Christoph Hellwig wrote:
> On Wed, Dec 05, 2018 at 01:48:28PM +0800, Nicolas Boichat wrote:
>> IOMMUs using ARMv7 short-descriptor format require page tables
>> (level 1 and 2) to be allocated within the first 4GB of RAM, even
>> on 64-bit systems.
> 
>> +#ifdef CONFIG_ZONE_DMA32
>> +#define ARM_V7S_TABLE_GFP_DMA GFP_DMA32
>> +#define ARM_V7S_TABLE_SLAB_CACHE SLAB_CACHE_DMA32
>> +#else
>> +#define ARM_V7S_TABLE_GFP_DMA GFP_DMA
>> +#define ARM_V7S_TABLE_SLAB_CACHE SLAB_CACHE_DMA
>> +#endif
> 
> How does using GFP_DMA make sense based on the above?  If the system
> has more than 32-bits worth of RAM it should be using GFP_DMA32, else
> GFP_KERNEL, not GFP_DMA for an arch defined small addressability pool.

32-bit Arm doesn't have ZONE_DMA32, but has (or at least had at the 
time) a 2GB ZONE_DMA. Whether we actually need that or not depends on 
how this all interacts with LPAE and highmem, but I'm not sure of those 
details off-hand.

Robin.
