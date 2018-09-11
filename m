From: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [RFC PATCH 0/2] dma-mapping: introduce helper for setting
 dma_parms
Date: Tue, 11 Sep 2018 18:24:08 +0100
Message-ID: <a9478a05-5908-e693-7eeb-3673b2facda7@arm.com>
References: <20180911163050.28072-1-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180911163050.28072-1-wsa+renesas@sang-engineering.com>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>, iommu@lists.linux-foundation.org
Cc: linux-renesas-soc@vger.kernel.org, Christoph Hellwig <hch@lst.de>, Marek Szyprowski <m.szyprowski@samsung.com>, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On 11/09/18 17:30, Wolfram Sang wrote:
> Hi all,
> 
> commit 78c47830a5cb ("dma-debug: check scatterlist segments") triggers
> for Renesas hardware I look after, so thanks for pointing out we should
> have proper dma_parms for our DMA providers.
> 
> When trying to fix it, I became a bit puzzled about the life cycle of
> the pointer to dma_parms. AFAIU most drivers leave the pointer dangling
> on driver unbind. Check drivers/dma/bcm2835-dma.c, for example:
> 
> 	od = devm_kzalloc(&pdev->dev, sizeof(*od), GFP_KERNEL);
> 	if (!od)
> 		return -ENOMEM;
> 
> 	pdev->dev.dma_parms = &od->dma_parms;
> 	dma_set_max_seg_size(&pdev->dev, 0x3FFFFFFF);
> 
> And that's all about handling dma_parms. So, on unbind, the memory for
> 'od' gets freed and dma_params is a dangling pointer.

That's the typical case - the dma_parms structure is simply embedded in 
some other private data which tends to have the appropriate lifetime 
anyway. I can't see that the dangling pointer is an issue when it's set 
unconditionally on probe and valid until remove, because anyone 
dereferencing dev->dma_parms when dev has no driver bound is doing 
something very very wrong anyway. I suppose we could zero it in 
__device_release_driver() for good measure though - shame we've found 
something dma_deconfigure() could have been useful for just after we 
killed it ;)

> 
> drivers/gpu/drm/exynos/exynos_drm_iommu.c seems to do it correctly:

...but could be even simpler if it was just included in 
exynos_drm_private. Realistically, I struggle to imagine a driver which 
would need to set dma_parms that didn't already have some other private 
state into which it could fit.

Note that ultimately we'd like to have a single structure to hold all 
the masks and other gubbins (per the very original intent of dma_parms), 
so there's a fair chance of this getting fundamentally rejigged at some 
point anyway.

Robin.

> static inline int configure_dma_max_seg_size(struct device *dev)
> {
>          if (!dev->dma_parms)
>                  dev->dma_parms = kzalloc(sizeof(*dev->dma_parms), GFP_KERNEL);
>          if (!dev->dma_parms)
>                  return -ENOMEM;
> 
>          dma_set_max_seg_size(dev, DMA_BIT_MASK(32));
>          return 0;
> }
> 
> static inline void clear_dma_max_seg_size(struct device *dev)
> {
>          kfree(dev->dma_parms);
>          dev->dma_parms = NULL;
> }
> 
> But this seems error prone and quite some code to add for every DMA
> provider. So, I wondered if we couldn't have a helper for that. After
> some brainstorming, I favour a dmam_-type of function. It will ensure
> the memory gets freed and the pointer cleared on unbind. And it should
> be easy to use.
> 
> I attached an RFC which I tested on a Renesas R-Car H3 SoC with the internal
> DMAC of the SD controller. A branch can be found here (still waiting for
> buildbot results):
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git renesas/sdhi/set_max_seg
> 
> I added the companion function dmam_free_dma_parms() for completeness
> although there is no user yet. I'd be totally open to drop it until
> someone needs it.
> 
> Please let me know what you think. If this is the right track, I'll be
> willing to fix the dangling pointers with it, too.
> 
> Thanks and happy hacking,
> 
>     Wolfram
> 
> 
> 
> Wolfram Sang (2):
>    dma-mapping: introduce helper for setting dma_parms
>    mmc: sdhi: internal_dmac: set dma_parms
> 
>   drivers/mmc/host/renesas_sdhi_internal_dmac.c |  2 +
>   include/linux/dma-mapping.h                   |  5 ++
>   kernel/dma/mapping.c                          | 50 +++++++++++++++++++
>   3 files changed, 57 insertions(+)
> 
