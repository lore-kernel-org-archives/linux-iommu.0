From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [RFC/PATCH 5/9] of: dma: Split of_configure_dma() into mask and
	ops configuration
Date: Thu, 28 May 2015 14:01:19 +0100
Message-ID: <20150528130119.GG31001@arm.com>
References: <1431644410-2997-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
	<1431644410-2997-6-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1431644410-2997-6-git-send-email-laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Laurent Pinchart <laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Cc: Laura Abbott <lauraa-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, "grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Fri, May 15, 2015 at 12:00:06AM +0100, Laurent Pinchart wrote:
> The of_configure_dma() function configures both the DMA masks and ops.
> Moving DMA ops configuration to probe time would thus also delay
> configuration of the DMA masks, which might not be safe. To avoid issues
> split the configuration in two to allow keeping masks configuration at
> device add time and move ops configuration to device probe time.
> 
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
> ---
>  drivers/of/device.c       | 48 ++++++++++++++++++++++++++++++++++-------------
>  drivers/of/of_pci.c       |  3 ++-
>  drivers/of/platform.c     |  6 ++++--
>  include/linux/of_device.h | 11 +++++++++--
>  4 files changed, 50 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/of/device.c b/drivers/of/device.c
> index f1b84f464fe1..3cb3f78a6d13 100644
> --- a/drivers/of/device.c
> +++ b/drivers/of/device.c
> @@ -70,7 +70,7 @@ int of_device_add(struct platform_device *ofdev)
>  }
>  
>  /**
> - * of_dma_configure - Setup DMA configuration
> + * of_dma_configure - Setup DMA masks and offset
>   * @dev:	Device to apply DMA configuration
>   * @np:		Pointer to OF node having DMA configuration
>   *
> @@ -81,13 +81,11 @@ int of_device_add(struct platform_device *ofdev)
>   * can use a platform bus notifier and handle BUS_NOTIFY_ADD_DEVICE events
>   * to fix up DMA configuration.
>   */
> -void of_dma_configure(struct device *dev, struct device_node *np)
> +void of_dma_configure_masks(struct device *dev, struct device_node *np)
>  {
> -	u64 dma_addr, paddr, size;
> -	int ret;
> -	bool coherent;
> +	u64 dma_addr, paddr, size, range_mask;
>  	unsigned long offset;
> -	struct iommu_ops *iommu;
> +	int ret;
>  
>  	/*
>  	 * Set default coherent_dma_mask to 32 bit.  Drivers are expected to
> @@ -105,9 +103,10 @@ void of_dma_configure(struct device *dev, struct device_node *np)
>  
>  	ret = of_dma_get_range(np, &dma_addr, &paddr, &size);
>  	if (ret < 0) {
> -		dma_addr = offset = 0;
> -		size = dev->coherent_dma_mask + 1;
> +		range_mask = dev->coherent_dma_mask + 1;

Hmm, do we still want this '+ 1'...

> +		offset = 0;
>  	} else {
> +		range_mask = DMA_BIT_MASK(ilog2(dma_addr + size));
>  		offset = PFN_DOWN(paddr - dma_addr);
>  		dev_dbg(dev, "dma_pfn_offset(%#08lx)\n", offset);
>  	}
> @@ -118,10 +117,31 @@ void of_dma_configure(struct device *dev, struct device_node *np)
>  	 * Limit coherent and dma mask based on size and default mask
>  	 * set by the driver.
>  	 */
> -	dev->coherent_dma_mask = min(dev->coherent_dma_mask,
> -				     DMA_BIT_MASK(ilog2(dma_addr + size)));
> -	*dev->dma_mask = min((*dev->dma_mask),
> -			     DMA_BIT_MASK(ilog2(dma_addr + size)));
> +	dev->coherent_dma_mask = min(dev->coherent_dma_mask, range_mask);

... if we now compare directly with the mask here? In fact, this setting
of the coherent_dma_mask could just belong in the else clause, no?

> +	*dev->dma_mask = min((*dev->dma_mask), range_mask);

Similar comment here, but we need to do this for both cases I guess.

> +}
> +EXPORT_SYMBOL_GPL(of_dma_configure_masks);
> +
> +/**
> + * of_dma_configure_ops - Setup DMA operations
> + * @dev:	Device to apply DMA configuration
> + * @np:		Pointer to OF node having DMA configuration
> + *
> + * Try to get devices's DMA configuration from DT and update it

Weird spelling.

Will
