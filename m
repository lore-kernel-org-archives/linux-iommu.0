From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH] ARM: dma-mapping: Don't tear third-party mappings
Date: Tue, 16 May 2017 19:44:42 +0300
Message-ID: <4043121.T8QnJes2jP@avalon>
References: <6d9fa319-4401-c47a-7985-9a349838bcaf@arm.com> <20170516151434.18830-1-laurent.pinchart+renesas@ideasonboard.com> <2602abb1-e777-700c-bc95-14e576372537@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <2602abb1-e777-700c-bc95-14e576372537@arm.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Robin Murphy <robin.murphy@arm.com>
Cc: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, linux-arm-kernel@lists.infradead.org, Sricharan R <sricharan@codeaurora.org>, Joerg Roedel <jroedel@suse.de>, Geert Uytterhoeven <geert@linux-m68k.org>, Will Deacon <will.deacon@arm.com>, iommu@lists.linux-foundation.org, linux-renesas-soc@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

Hi Robin,

On Tuesday 16 May 2017 16:47:36 Robin Murphy wrote:
> On 16/05/17 16:14, Laurent Pinchart wrote:
> > arch_setup_dma_ops() is used in device probe code paths to create an
> > IOMMU mapping and attach it to the device. The function assumes that the
> > device is attached to a device-specific IOMMU instance (or at least a
> > device-specific TLB in a shared IOMMU instance) and thus creates a
> > separate mapping for every device.
> > 
> > On several systems (Renesas R-Car Gen2 being one of them), that
> > assumption is not true, and IOMMU mappings must be shared between
> > multiple devices. In those cases the IOMMU driver knows better than the
> > generic ARM dma-mapping layer and attaches mapping to devices manually
> > with arm_iommu_attach_device(), which sets the DMA ops for the device.
> > 
> > The arch_setup_dma_ops() function takes this into account and bails out
> > immediately if the device already has DMA ops assigned. However, the
> > corresponding arch_teardown_dma_ops() function, called from driver
> > unbind code paths (including probe deferral), will tear the mapping down
> > regardless of who created it. When the device is reprobed
> > arch_setup_dma_ops() will be called again but won't perform any
> > operation as the DMA ops will still be set.
> > 
> > We need to reset the DMA ops in arch_teardown_dma_ops() to fix this.
> > However, we can't do so unconditionally, as then a new mapping would be
> > created by arch_setup_dma_ops() when the device is reprobed, regardless
> > of whether the device needs to share a mapping or not. We must thus keep
> > track of whether arch_setup_dma_ops() created the mapping, and only in
> > that case tear it down in arch_teardown_dma_ops().
> > 
> > Keep track of that information in the dev_archdata structure. As the
> > structure is embedded in all instances of struct device let's not grow
> > it, but turn the existing dma_coherent bool field into a bitfield that
> > can be used for other purposes.
> > 
> > Fixes: 7b07cbefb68d ("iommu: of: Handle IOMMU lookup failure with deferred
> > probing or error") Signed-off-by: Laurent Pinchart
> > <laurent.pinchart+renesas@ideasonboard.com> ---
> > 
> >  arch/arm/include/asm/device.h | 3 ++-
> >  arch/arm/mm/dma-mapping.c     | 5 +++++
> >  2 files changed, 7 insertions(+), 1 deletion(-)
> > 
> > diff --git a/arch/arm/include/asm/device.h b/arch/arm/include/asm/device.h
> > index 36ec9c8f6e16..3234fe9bba6e 100644
> > --- a/arch/arm/include/asm/device.h
> > +++ b/arch/arm/include/asm/device.h
> > @@ -19,7 +19,8 @@ struct dev_archdata {
> >  #ifdef CONFIG_XEN
> >  	const struct dma_map_ops *dev_dma_ops;
> >  #endif
> > -	bool dma_coherent;
> > +	unsigned int dma_coherent:1;
> 
> This should only ever be accessed by the Xen DMA code via the
> is_device_dma_coherent() helper, so I can't see the change of storage
> type causing any problems.

Thank you for double-checking. I agree with your analysis.

> > +	unsigned int dma_ops_setup:1;
> >  };
> >  
> >  struct omap_device;
> > diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
> > index c742dfd2967b..e0272f9140e2 100644
> > --- a/arch/arm/mm/dma-mapping.c
> > +++ b/arch/arm/mm/dma-mapping.c
> > @@ -2430,9 +2430,14 @@ void arch_setup_dma_ops(struct device *dev, u64
> > dma_base, u64 size,
> >  		dev->dma_ops = xen_dma_ops;
> >  	}
> >  #endif
> > +	dev->archdata.dma_ops_setup = true;
> >  }
> >  
> >  void arch_teardown_dma_ops(struct device *dev)
> >  {
> > +	if (!dev->archdata.dma_ops_setup)
> > +		return;
> > +
> >  	arm_teardown_iommu_dma_ops(dev);
> > +	set_dma_ops(dev, NULL);
> 
> Should we clear dma_ops_setup here for symmetry? I guess in practice
> it's down to the IOMMU driver so will never change after the first
> probe, but it still feels like a bit of a nagging loose end.

To make a difference, we would need an IOMMU driver that creates a mapping 
after a first round of arch_setup_dma_ops() / arch_teardown_dma_ops() calls, 
follow by a second round. I don't think this could happen, but if it did, I 
believe we'd be screwed already, as there would be a time were an incorrect 
mapping (created by arch_setup_dma_ops() while the IOMMU driver needs to take 
care of mapping creation) exists.

> With that (or firm reassurance that it's OK not to),
> 
> Reviewed-by: Robin Murphy <robin.murphy@arm.com>
> 
> Apologies for being too arm64-focused in the earlier reviews and
> overlooking this. Should the patch supersede 8674/1 currently in
> Russell's incoming box?

Yes I think it should. Could you please take care of that ?

You can also add my

Tested-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

as I've tested that this paptch restores proper IOMMU operation on the Renesas 
R-Car H2 Lager board. I believe the problem related to Sricharan's patch 
reported by Geert still affects us and needs to be addressed separately.

-- 
Regards,

Laurent Pinchart
