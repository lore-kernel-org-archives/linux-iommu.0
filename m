From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [RFC/PATCH 4/9] of: dma: Make of_dma_deconfigure() public
Date: Thu, 28 May 2015 13:42:22 +0100
Message-ID: <20150528124222.GF31001@arm.com>
References: <1431644410-2997-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
	<1431644410-2997-5-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1431644410-2997-5-git-send-email-laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
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

(sorry for the mid-review delay, I got side-tracked yesterday evening)

On Fri, May 15, 2015 at 12:00:05AM +0100, Laurent Pinchart wrote:
> As part of moving DMA initializing to probe time the
> of_dma_deconfigure() function will need to be called from different
> source files. Make it public and move it to drivers/of/device.c where
> the of_dma_configure() function is.
> 
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
> ---
>  drivers/of/device.c       | 12 ++++++++++++
>  drivers/of/platform.c     |  5 -----
>  include/linux/of_device.h |  3 +++
>  3 files changed, 15 insertions(+), 5 deletions(-)

Acked-by: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>

Cheers,

Will

> diff --git a/drivers/of/device.c b/drivers/of/device.c
> index 530aa1ed3e1b..f1b84f464fe1 100644
> --- a/drivers/of/device.c
> +++ b/drivers/of/device.c
> @@ -135,6 +135,18 @@ void of_dma_configure(struct device *dev, struct device_node *np)
>  }
>  EXPORT_SYMBOL_GPL(of_dma_configure);
>  
> +/**
> + * of_dma_deconfigure - Clean up DMA configuration
> + * @dev:	Device for which to clean up DMA configuration
> + *
> + * Clean up all configuration performed by of_dma_configure_ops() and free all
> + * resources that have been allocated.
> + */
> +void of_dma_deconfigure(struct device *dev)
> +{
> +	arch_teardown_dma_ops(dev);
> +}
> +
>  int of_device_register(struct platform_device *pdev)
>  {
>  	device_initialize(&pdev->dev);
> diff --git a/drivers/of/platform.c b/drivers/of/platform.c
> index a01f57c9e34e..7a660c79ff84 100644
> --- a/drivers/of/platform.c
> +++ b/drivers/of/platform.c
> @@ -149,11 +149,6 @@ struct platform_device *of_device_alloc(struct device_node *np,
>  }
>  EXPORT_SYMBOL(of_device_alloc);
>  
> -static void of_dma_deconfigure(struct device *dev)
> -{
> -	arch_teardown_dma_ops(dev);
> -}
> -
>  /**
>   * of_platform_device_create_pdata - Alloc, initialize and register an of_device
>   * @np: pointer to node to create device for
> diff --git a/include/linux/of_device.h b/include/linux/of_device.h
> index 22801b10cef5..6710807b0653 100644
> --- a/include/linux/of_device.h
> +++ b/include/linux/of_device.h
> @@ -54,6 +54,7 @@ static inline struct device_node *of_cpu_device_node_get(int cpu)
>  }
>  
>  void of_dma_configure(struct device *dev, struct device_node *np);
> +void of_dma_deconfigure(struct device *dev);
>  #else /* CONFIG_OF */
>  
>  static inline int of_driver_match_device(struct device *dev,
> @@ -93,6 +94,8 @@ static inline struct device_node *of_cpu_device_node_get(int cpu)
>  }
>  static inline void of_dma_configure(struct device *dev, struct device_node *np)
>  {}
> +static inline void of_dma_deconfigure(struct device *dev)
> +{}
>  #endif /* CONFIG_OF */
>  
>  #endif /* _LINUX_OF_DEVICE_H */
> -- 
> 2.3.6
> 
