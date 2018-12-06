From: Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH v4 2/3] mm: Add support for kmem caches in DMA32 zone
Date: Thu, 6 Dec 2018 10:34:38 +0100
Message-ID: <09f56edb-2dab-c023-2164-dd7b5cef6afb@suse.cz>
References: <20181205054828.183476-1-drinkcat@chromium.org>
 <20181205054828.183476-3-drinkcat@chromium.org>
 <5eddd264-5527-a98e-fc8b-31ea89f474db@suse.cz>
 <CANMq1KAL7TcVa4xF8=NdK2cs0VakEq5i6MyCvfmYTGCmJ78-ag@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CANMq1KAL7TcVa4xF8=NdK2cs0VakEq5i6MyCvfmYTGCmJ78-ag@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Nicolas Boichat <drinkcat@chromium.org>
Cc: Will Deacon <will.deacon@arm.com>, Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>, Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>, David Rientjes <rientjes@google.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>, Andrew Morton <akpm@linux-foundation.org>, Michal Hocko <mhocko@suse.com>, Mel Gorman <mgorman@techsingularity.net>, Levin Alexander <Alexander.Levin@microsoft.com>, Huaisheng Ye <yehs1@lenovo.com>, Mike Rapoport <rppt@linux.vnet.ibm.com>, linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>, iommu@lists.linux-foundation.org, lkml <linux-kernel@vger.kernel.org>, linux-mm@kvack.org, Yong Wu <yong.wu@mediatek.com>, Matthias Brugger <matthias.bgg@gmail.com>, Tomasz Figa <tfiga@google.com>, yi
List-Id: iommu@lists.linux-foundation.org

On 12/6/18 4:49 AM, Nicolas Boichat wrote:
>> So it would be fine even unchanged. The check would anyway need some
>> more love to catch the same with __GFP_DMA to be consistent and cover
>> all corner cases.
> Yes, the test is not complete. If we really wanted this to be
> accurate, we'd need to check that GFP_* exactly matches SLAB_CACHE_*.
> 
> The only problem with dropping this is test that we should restore
> GFP_DMA32 warning/errors somewhere else (as Christopher pointed out
> here: https://lkml.org/lkml/2018/11/22/430), especially for kmalloc
> case.

I meant just dropping that patch hunk, not the whole test. Then the test
stays as it is and will keep warning anyone calling kmalloc(GFP_DMA32).
It would also warn anyone calling kmem_cache_alloc(GFP_DMA32) on
SLAB_CACHE_DMA32 cache, but since the gfp can be just dropped, and you
as the only user of this so far will do that, it's fine?

> Maybe this can be done in kmalloc_slab.
