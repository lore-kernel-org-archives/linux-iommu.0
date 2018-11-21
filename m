From: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH v2 3/3] iommu/io-pgtable-arm-v7s: Request DMA32 memory,
 and improve debugging
Date: Wed, 21 Nov 2018 17:43:44 +0000
Message-ID: <a034e2c3-8933-caba-a113-ca08372da2b9@arm.com>
References: <20181111090341.120786-1-drinkcat@chromium.org>
 <20181111090341.120786-4-drinkcat@chromium.org>
 <20181121164638.GD24883@arm.com>
 <01000167375a15f8-362aa1e2-cf01-49b5-92b5-f0a4efcca477-000000@email.amazonses.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <01000167375a15f8-362aa1e2-cf01-49b5-92b5-f0a4efcca477-000000@email.amazonses.com>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: Christopher Lameter <cl@linux.com>, Will Deacon <will.deacon@arm.com>
Cc: Nicolas Boichat <drinkcat@chromium.org>, Joerg Roedel <joro@8bytes.org>, Pekka Enberg <penberg@kernel.org>, David Rientjes <rientjes@google.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>, Andrew Morton <akpm@linux-foundation.org>, Vlastimil Babka <vbabka@suse.cz>, Michal Hocko <mhocko@suse.com>, Mel Gorman <mgorman@techsingularity.net>, Levin Alexander <Alexander.Levin@microsoft.com>, Huaisheng Ye <yehs1@lenovo.com>, Mike Rapoport <rppt@linux.vnet.ibm.com>, linux-arm-kernel@lists.infradead.org, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, Yong Wu <yong.wu@mediatek.com>, Matthias Brugger <matthias.bgg@gmail.com>, Tomasz Figa <tfiga@google.com>, yingjoe.chen@mediatek.com
List-Id: iommu@lists.linux-foundation.org

On 21/11/2018 17:38, Christopher Lameter wrote:
> On Wed, 21 Nov 2018, Will Deacon wrote:
> 
>>> +#define ARM_V7S_TABLE_SLAB_CACHE SLAB_CACHE_DMA32
> 
> SLAB_CACHE_DMA32??? WTH is going on here? We are trying to get rid of
> the dma slab array.

See the previous two patches in this series. If there's already a 
(better) way to have a kmem_cache which allocates its backing pages with 
GFP_DMA32, please do let us know.

Robin.
