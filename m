From: Thomas Hellstrom via iommu <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Subject: Re: [PATCH] Revert "drm/vmwgfx: Improve on IOMMU detection"
Date: Mon, 8 Apr 2019 20:05:48 +0000
Message-ID: <88c0cd21b11a385b3b0130715a25673b71b57112.camel@vmware.com>
References: <20190408105525.5493-1-hch@lst.de>
	<20190408105525.5493-2-hch@lst.de>
Reply-To: Thomas Hellstrom <thellstrom-pghWNbHTmq7QT0dZR+AlfA@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20190408105525.5493-2-hch-jcswGhMUV9g@public.gmane.org>
Content-Language: en-US
Content-ID: <0151265B32F40043B252873E3BC44AB6-HX+pjaQZbrqcE4WynfumptQqCkab/8FMAL8bYrjMMd8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: "hch-jcswGhMUV9g@public.gmane.org" <hch-jcswGhMUV9g@public.gmane.org>, "torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org" <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Cc: "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Deepak Singh Rawat <drawat-pghWNbHTmq7QT0dZR+AlfA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Mon, 2019-04-08 at 12:55 +0200, Christoph Hellwig wrote:
> This reverts commit 9ddac734aa310c5fbc0ec93602335d2a39092451.

IMHO, rather than reverting, I'd like to see the dma API provide a
function telling us whether streaming DMA operations are coherent or
not. 

With that we could fix all drivers that would otherwise just blow up if
somebody happened to enable swiotlb with bounce buffers...

/Thomas



> ---
>  drivers/gpu/drm/vmwgfx/vmwgfx_drv.c | 19 ++-----------------
>  1 file changed, 2 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c
> b/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c
> index 6165fe2c4504..9294b76c8084 100644
> --- a/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c
> +++ b/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c
> @@ -26,7 +26,6 @@
>  
> *********************************************************************
> *****/
>  #include <linux/module.h>
>  #include <linux/console.h>
> -#include <linux/dma-mapping.h>
>  
>  #include <drm/drmP.h>
>  #include "vmwgfx_drv.h"
> @@ -35,6 +34,7 @@
>  #include <drm/ttm/ttm_placement.h>
>  #include <drm/ttm/ttm_bo_driver.h>
>  #include <drm/ttm/ttm_module.h>
> +#include <linux/intel-iommu.h>
>  
>  #define VMWGFX_DRIVER_DESC "Linux drm driver for VMware graphics
> devices"
>  #define VMWGFX_CHIP_SVGAII 0
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
> @@ -583,7 +568,7 @@ static int vmw_dma_select_mode(struct vmw_private
> *dev_priv)
>  
>  	if (vmw_force_coherent)
>  		dev_priv->map_mode = vmw_dma_alloc_coherent;
> -	else if (vmw_assume_iommu(dev_priv->dev))
> +	else if (intel_iommu_enabled)
>  		dev_priv->map_mode = vmw_dma_map_populate;
>  	else if (!vmw_force_iommu)
>  		dev_priv->map_mode = vmw_dma_phys;
