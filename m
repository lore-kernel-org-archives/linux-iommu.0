From: Russell King - ARM Linux <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>
Subject: Re: [PATCH v4 1/2] ARM: dma-mapping: Set proper DMA ops in
	arm_iommu_detach_device()
Date: Mon, 2 Jul 2018 16:23:55 +0100
Message-ID: <20180702152355.GM17271@n2100.armlinux.org.uk>
References: <20180530140625.21247-1-thierry.reding@gmail.com>
	<20180530140625.21247-2-thierry.reding@gmail.com>
	<20180702115317.GB5280@ulmo>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20180702115317.GB5280@ulmo>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: nouveau-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Ben Skeggs <bskeggs-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Daniel Vetter <daniel-/w4YWyX8dFk@public.gmane.org>, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Mon, Jul 02, 2018 at 01:53:17PM +0200, Thierry Reding wrote:
> On Wed, May 30, 2018 at 04:06:24PM +0200, Thierry Reding wrote:
> > From: Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> > 
> > Instead of setting the DMA ops pointer to NULL, set the correct,
> > non-IOMMU ops depending on the device's coherency setting.
> > 
> > Signed-off-by: Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> > ---
> > Changes in v4:
> > - new patch to fix existing arm_iommu_detach_device() to do what we need
> > 
> >  arch/arm/mm/dma-mapping.c | 12 ++++++------
> >  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> Christoph, Russell,
> 
> could either of you provide an Acked-by for this? I think it makes the
> most sense for Ben to pick this up into the Nouveau tree along with
> patch 2/2.

Looks fine to me.

Acked-by: Russell King <rmk+kernel-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>

Thanks.

> 
> Thierry
> 
> > diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
> > index af27f1c22d93..87a0037574e4 100644
> > --- a/arch/arm/mm/dma-mapping.c
> > +++ b/arch/arm/mm/dma-mapping.c
> > @@ -1151,6 +1151,11 @@ int arm_dma_supported(struct device *dev, u64 mask)
> >  	return __dma_supported(dev, mask, false);
> >  }
> >  
> > +static const struct dma_map_ops *arm_get_dma_map_ops(bool coherent)
> > +{
> > +	return coherent ? &arm_coherent_dma_ops : &arm_dma_ops;
> > +}
> > +
> >  #ifdef CONFIG_ARM_DMA_USE_IOMMU
> >  
> >  static int __dma_info_to_prot(enum dma_data_direction dir, unsigned long attrs)
> > @@ -2296,7 +2301,7 @@ void arm_iommu_detach_device(struct device *dev)
> >  	iommu_detach_device(mapping->domain, dev);
> >  	kref_put(&mapping->kref, release_iommu_mapping);
> >  	to_dma_iommu_mapping(dev) = NULL;
> > -	set_dma_ops(dev, NULL);
> > +	set_dma_ops(dev, arm_get_dma_map_ops(dev->archdata.dma_coherent));
> >  
> >  	pr_debug("Detached IOMMU controller from %s device.\n", dev_name(dev));
> >  }
> > @@ -2357,11 +2362,6 @@ static void arm_teardown_iommu_dma_ops(struct device *dev) { }
> >  
> >  #endif	/* CONFIG_ARM_DMA_USE_IOMMU */
> >  
> > -static const struct dma_map_ops *arm_get_dma_map_ops(bool coherent)
> > -{
> > -	return coherent ? &arm_coherent_dma_ops : &arm_dma_ops;
> > -}
> > -
> >  void arch_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
> >  			const struct iommu_ops *iommu, bool coherent)
> >  {
> > -- 
> > 2.17.0
> > 



-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
