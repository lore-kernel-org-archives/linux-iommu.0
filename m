From: Thomas Hellstrom <thellstrom-pghWNbHTmq7QT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 4/4] drm/vmwgfx: unwind spaghetti code in
	vmw_dma_select_mode
Date: Tue, 8 Jan 2019 10:56:47 +0000
Message-ID: <92880e1e58f38332ac7ece81cde2c791465b18a2.camel@vmware.com>
References: <20190105080108.14837-1-hch@lst.de>
	<20190105080108.14837-5-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20190105080108.14837-5-hch-jcswGhMUV9g@public.gmane.org>
Content-Language: en-US
Content-ID: <A53589A84A5D9E4E8641EB49A502A1FA-HX+pjaQZbrqcE4WynfumptQqCkab/8FMAL8bYrjMMd8@public.gmane.org>
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
Cc: "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Linux-graphics-maintainer <Linux-graphics-maintainer-pghWNbHTmq7QT0dZR+AlfA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Sat, 2019-01-05 at 09:01 +0100, Christoph Hellwig wrote:
> Just use a simple if/else chain to select the DMA mode.
> 
> Signed-off-by: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>

Reviewed-by: Thomas Hellstrom <thellstrom-pghWNbHTmq7QT0dZR+AlfA@public.gmane.org>


> ---
>  drivers/gpu/drm/vmwgfx/vmwgfx_drv.c | 25 ++++++-------------------
>  1 file changed, 6 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c
> b/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c
> index c2060f6cc9e8..86387735a90b 100644
> --- a/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c
> +++ b/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c
> @@ -566,34 +566,21 @@ static int vmw_dma_select_mode(struct
> vmw_private *dev_priv)
>  		[vmw_dma_map_populate] = "Keeping DMA mappings.",
>  		[vmw_dma_map_bind] = "Giving up DMA mappings early."};
>  
> -	if (intel_iommu_enabled) {
> +	if (vmw_force_coherent)
> +		dev_priv->map_mode = vmw_dma_alloc_coherent;
> +	else if (intel_iommu_enabled)
>  		dev_priv->map_mode = vmw_dma_map_populate;
> -		goto out_fixup;
> -	}
> -
> -	if (!(vmw_force_iommu || vmw_force_coherent)) {
> +	else if (!vmw_force_iommu)
>  		dev_priv->map_mode = vmw_dma_phys;
> -		DRM_INFO("DMA map mode: %s\n", names[dev_priv-
> >map_mode]);
> -		return 0;
> -	}
> -
> -#ifdef CONFIG_SWIOTLB
> -	if (swiotlb_nr_tbl())
> +	else if (IS_ENABLED(CONFIG_SWIOTLB) && swiotlb_nr_tbl())
>  		dev_priv->map_mode = vmw_dma_alloc_coherent;
>  	else
> -#endif
>  		dev_priv->map_mode = vmw_dma_map_populate;
>  
> -out_fixup:
> -	if (dev_priv->map_mode == vmw_dma_map_populate &&
> -	    vmw_restrict_iommu)
> +	if (dev_priv->map_mode == vmw_dma_map_populate &&
> vmw_restrict_iommu)
>  		dev_priv->map_mode = vmw_dma_map_bind;
>  
> -	if (vmw_force_coherent)
> -		dev_priv->map_mode = vmw_dma_alloc_coherent;
> -
>  	DRM_INFO("DMA map mode: %s\n", names[dev_priv->map_mode]);
> -
>  	return 0;
>  }
>  
