From: Michal Hocko <mhocko@kernel.org>
Subject: Re: [PATCH v2 3/3] iommu/io-pgtable-arm-v7s: Request DMA32 memory,
 and improve debugging
Date: Wed, 21 Nov 2018 19:02:20 +0100
Message-ID: <20181121180000.GU12932@dhcp22.suse.cz>
References: <20181111090341.120786-1-drinkcat@chromium.org>
 <20181111090341.120786-4-drinkcat@chromium.org>
 <20181121164638.GD24883@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181121164638.GD24883@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Will Deacon <will.deacon@arm.com>
Cc: Nicolas Boichat <drinkcat@chromium.org>, Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>, Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>, David Rientjes <rientjes@google.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>, Andrew Morton <akpm@linux-foundation.org>, Vlastimil Babka <vbabka@suse.cz>, Mel Gorman <mgorman@techsingularity.net>, Levin Alexander <Alexander.Levin@microsoft.com>, Huaisheng Ye <yehs1@lenovo.com>, Mike Rapoport <rppt@linux.vnet.ibm.com>, linux-arm-kernel@lists.infradead.org, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, Yong Wu <yong.wu@mediatek.com>, Matthias Brugger <matthias.bgg@gmail.com>, Tomasz Figa <tfiga@google.com>, yingjoe.chen@mediatek.com
List-Id: iommu@lists.linux-foundation.org

On Wed 21-11-18 16:46:38, Will Deacon wrote:
> On Sun, Nov 11, 2018 at 05:03:41PM +0800, Nicolas Boichat wrote:
> > For level 1/2 pages, ensure GFP_DMA32 is used if CONFIG_ZONE_DMA32
> > is defined (e.g. on arm64 platforms).
> > 
> > For level 2 pages, allocate a slab cache in SLAB_CACHE_DMA32.
> > 
> > Also, print an error when the physical address does not fit in
> > 32-bit, to make debugging easier in the future.
> > 
> > Fixes: ad67f5a6545f ("arm64: replace ZONE_DMA with ZONE_DMA32")
> > Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>
> > ---
> > 
> > Changes since v1:
> >  - Changed approach to use SLAB_CACHE_DMA32 added by the previous
> >    commit.
> >  - Use DMA or DMA32 depending on the architecture (DMA for arm,
> >    DMA32 for arm64).
> > 
> > drivers/iommu/io-pgtable-arm-v7s.c | 20 ++++++++++++++++----
> >  1 file changed, 16 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/iommu/io-pgtable-arm-v7s.c b/drivers/iommu/io-pgtable-arm-v7s.c
> > index 445c3bde04800c..996f7b6d00b44a 100644
> > --- a/drivers/iommu/io-pgtable-arm-v7s.c
> > +++ b/drivers/iommu/io-pgtable-arm-v7s.c
> > @@ -161,6 +161,14 @@
> >  
> >  #define ARM_V7S_TCR_PD1			BIT(5)
> >  
> > +#ifdef CONFIG_ZONE_DMA32
> > +#define ARM_V7S_TABLE_GFP_DMA GFP_DMA32
> > +#define ARM_V7S_TABLE_SLAB_CACHE SLAB_CACHE_DMA32
> > +#else
> > +#define ARM_V7S_TABLE_GFP_DMA GFP_DMA
> > +#define ARM_V7S_TABLE_SLAB_CACHE SLAB_CACHE_DMA
> > +#endif
> 
> It's a bit grotty that GFP_DMA32 doesn't just map to GFP_DMA on 32-bit
> architectures, since then we wouldn't need this #ifdeffery afaict.

But GFP_DMA32 should map to GFP_KERNEL on 32b, no? Or what exactly is
going on in here?

-- 
Michal Hocko
SUSE Labs
