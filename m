From: Thomas Hellstrom via iommu <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Subject: Re: revert dma direct internals abuse
Date: Tue, 9 Apr 2019 17:24:48 +0000
Message-ID: <da06614b308500392c179651ef9c6fb835ee4045.camel@vmware.com>
References: <20190408105525.5493-1-hch@lst.de>
	<7d5f35da4a6b58639519f0764c7edbfe4dd1ba02.camel@vmware.com>
	<20190409095740.GE6827@lst.de>
	<5f0837ffc135560c764c38849eead40269cebb48.camel@vmware.com>
	<20190409133157.GA10876@lst.de>
	<466e658c73607fca5112d718972e87c0b78653ad.camel@vmware.com>
	<20190409152538.GA12816@lst.de>
Reply-To: Thomas Hellstrom <thellstrom-pghWNbHTmq7QT0dZR+AlfA@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20190409152538.GA12816-jcswGhMUV9g@public.gmane.org>
Content-Language: en-US
Content-ID: <5F44158474DBDB4E8E43F25AFEB4988C-HX+pjaQZbrqcE4WynfumptQqCkab/8FMAL8bYrjMMd8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: "hch-jcswGhMUV9g@public.gmane.org" <hch-jcswGhMUV9g@public.gmane.org>
Cc: "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Deepak Singh Rawat <drawat-pghWNbHTmq7QT0dZR+AlfA@public.gmane.org>, "torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org" <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Tue, 2019-04-09 at 17:25 +0200, hch-jcswGhMUV9g@public.gmane.org wrote:
> On Tue, Apr 09, 2019 at 02:17:40PM +0000, Thomas Hellstrom wrote:
> > If that's the case, I think most of the graphics drivers will stop
> > functioning. I don't think people would want that, and even if the
> > graphics drivers are "to blame" due to not implementing the sync
> > calls,
> > I think the work involved to get things right is impressive if at
> > all
> > possible.
> 
> Note that this only affects external, untrusted devices.  But that
> may include eGPU,

What about discrete graphics cards, like Radeon and Nvidia? Who gets to
determine what's trusted?

> so yes GPU folks finally need to up their game and
> stop thinking they are above the law^H^H^Hinterface.

And others doing user-space DMA. But I don't think a good way is to
break their drivers.

> 
> > There are two things that concerns me with dma_alloc_coherent:
> > 
> > 1) It seems to want pages mapped either in the kernel map or
> > vmapped.
> > Graphics drivers allocate huge amounts of memory, Typically up to
> > 50%
> > of system memory or more. In a 32 bit PAE system I'm afraid of
> > running
> > out of vmap space as well as not being able to allocate as much
> > memory
> > as I want. Perhaps a dma_alloc_coherent() interface that returns a
> > page
> > rather than a virtual address would do the trick.
> 
> We can't just simply export a page.  For devices that are not cache
> coherent we need to remap the returned memory to be uncached.  In the
> common cases that is either done by setting an uncached bit in the
> page
> tables, or by using a special address space alias.  So the virtual
> address to access the page matter, and we can't just kmap a random
> page an expect it to be coherent.  If you want memory that is not
> mapped into the kernel direct mapping and DMA to it you need to
> use the proper DMA streaming interface and obey their rules.

GPU libraries traditionally have been taking care of the CPU mapping
caching modes since the first AGP drivers. GPU MMU ptes commonly
support various caching options and pages are changing caching mode
dynamically.
So even if the DMA layer needs to do the remapping, couldn't we do that
on-demand when needed with a simple interface?

> 
> > 2) Exporting using dma-buf. A page allocated using
> > dma_alloc_coherent()
> > for one device might not be coherent for another device. What
> > happens
> > if I allocate a page using dma_alloc_coherent() for device 1 and
> > then
> > want to map it using dma_map_page() for device 2?
> 
> The problem in this case isn't really the coherency - once a page
> is mapped uncached it is 'coherent' for all devices, even those not
> requiring it.  The problem is addressability - the DMA address for
> the same memory might be different for different devices, and
> something
> that looks contigous to one device that is using an IOMMU might not
> for another one using the direct mapping.
> 
> We have the dma_get_sgtable API to map a piece of coherent memory
> using the streaming APIs for another device, but it has all sorts of
> problems.
> 
> That being said: your driver already uses the dma coherent API
> under various circumstances, so you already have the above issues.

Yes, but they are hidden behind driver options. We can't have someone
upgrade their kernel and suddenly things don't work anymore, That said,
I think the SWIOTLB case is rare enough for the below solution to be
acceptable, although the TTM check for the coherent page pool being
available still needs to remain.

Thanks,
Thomas


> 
> In the end swiotlb_nr_tbl() might be the best hint that some bounce
> buffering could happen.  This isn't proper use of the API, but at
> least a little better than your old intel_iommu_emabled check
> and much better than we we have right now.  Something like this:
> 
> diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c
> b/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c
> index 6165fe2c4504..ff00bea026c5 100644
> --- a/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c
> +++ b/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c
> @@ -545,21 +545,6 @@ static void vmw_get_initial_size(struct
> vmw_private *dev_priv)
>  	dev_priv->initial_height = height;
>  }
>  
> -/**
> - * vmw_assume_iommu - Figure out whether coherent dma-remapping
> might be
> - * taking place.
> - * @dev: Pointer to the struct drm_device.
> - *
> - * Return: true if iommu present, false otherwise.
> - */
> -static bool vmw_assume_iommu(struct drm_device *dev)
> -{
> -	const struct dma_map_ops *ops = get_dma_ops(dev->dev);
> -
> -	return !dma_is_direct(ops) && ops &&
> -		ops->map_page != dma_direct_map_page;
> -}
> -
>  /**
>   * vmw_dma_select_mode - Determine how DMA mappings should be set up
> for this
>   * system.
> @@ -581,25 +566,14 @@ static int vmw_dma_select_mode(struct
> vmw_private *dev_priv)
>  		[vmw_dma_map_populate] = "Keeping DMA mappings.",
>  		[vmw_dma_map_bind] = "Giving up DMA mappings early."};
>  
> -	if (vmw_force_coherent)
> -		dev_priv->map_mode = vmw_dma_alloc_coherent;
> -	else if (vmw_assume_iommu(dev_priv->dev))
> -		dev_priv->map_mode = vmw_dma_map_populate;
> -	else if (!vmw_force_iommu)
> -		dev_priv->map_mode = vmw_dma_phys;
> -	else if (IS_ENABLED(CONFIG_SWIOTLB) && swiotlb_nr_tbl())
> +	if (vmw_force_coherent ||
> +	    (IS_ENABLED(CONFIG_SWIOTLB) && swiotlb_nr_tbl()))
>  		dev_priv->map_mode = vmw_dma_alloc_coherent;
> +	else if (vmw_restrict_iommu)
> +		dev_priv->map_mode = vmw_dma_map_bind;
>  	else
>  		dev_priv->map_mode = vmw_dma_map_populate;
>  
> -	if (dev_priv->map_mode == vmw_dma_map_populate &&
> vmw_restrict_iommu)
> -		dev_priv->map_mode = vmw_dma_map_bind;
> -
> -	/* No TTM coherent page pool? FIXME: Ask TTM instead! */
> -        if (!(IS_ENABLED(CONFIG_SWIOTLB) ||
> IS_ENABLED(CONFIG_INTEL_IOMMU)) &&
> -	    (dev_priv->map_mode == vmw_dma_alloc_coherent))
> -		return -EINVAL;
> -
>  	DRM_INFO("DMA map mode: %s\n", names[dev_priv->map_mode]);
>  	return 0;
>  }
> 
