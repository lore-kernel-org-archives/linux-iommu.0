From: Rob Herring <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [RFC/PATCH 5/9] of: dma: Split of_configure_dma() into mask and
	ops configuration
Date: Fri, 29 May 2015 09:19:30 -0500
Message-ID: <CAL_Jsq+udHwGrtqzh-2S-WBQBQKHpTv=gLkOnG2w1PnL6uBj6A@mail.gmail.com>
References: <1431644410-2997-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
	<1431644410-2997-6-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
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
Cc: Laura Abbott <lauraa-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux IOMMU <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Thu, May 14, 2015 at 6:00 PM, Laurent Pinchart
<laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org> wrote:
> The of_configure_dma() function configures both the DMA masks and ops.
> Moving DMA ops configuration to probe time would thus also delay
> configuration of the DMA masks, which might not be safe. To avoid issues
> split the configuration in two to allow keeping masks configuration at
> device add time and move ops configuration to device probe time.

Why is it not safe? The probe is deferred before drivers' probe happens.

Rob

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
>   * @dev:       Device to apply DMA configuration
>   * @np:                Pointer to OF node having DMA configuration
>   *
> @@ -81,13 +81,11 @@ int of_device_add(struct platform_device *ofdev)
>   * can use a platform bus notifier and handle BUS_NOTIFY_ADD_DEVICE events
>   * to fix up DMA configuration.
>   */
> -void of_dma_configure(struct device *dev, struct device_node *np)
> +void of_dma_configure_masks(struct device *dev, struct device_node *np)
>  {
> -       u64 dma_addr, paddr, size;
> -       int ret;
> -       bool coherent;
> +       u64 dma_addr, paddr, size, range_mask;
>         unsigned long offset;
> -       struct iommu_ops *iommu;
> +       int ret;
>
>         /*
>          * Set default coherent_dma_mask to 32 bit.  Drivers are expected to
> @@ -105,9 +103,10 @@ void of_dma_configure(struct device *dev, struct device_node *np)
>
>         ret = of_dma_get_range(np, &dma_addr, &paddr, &size);
>         if (ret < 0) {
> -               dma_addr = offset = 0;
> -               size = dev->coherent_dma_mask + 1;
> +               range_mask = dev->coherent_dma_mask + 1;
> +               offset = 0;
>         } else {
> +               range_mask = DMA_BIT_MASK(ilog2(dma_addr + size));
>                 offset = PFN_DOWN(paddr - dma_addr);
>                 dev_dbg(dev, "dma_pfn_offset(%#08lx)\n", offset);
>         }
> @@ -118,10 +117,31 @@ void of_dma_configure(struct device *dev, struct device_node *np)
>          * Limit coherent and dma mask based on size and default mask
>          * set by the driver.
>          */
> -       dev->coherent_dma_mask = min(dev->coherent_dma_mask,
> -                                    DMA_BIT_MASK(ilog2(dma_addr + size)));
> -       *dev->dma_mask = min((*dev->dma_mask),
> -                            DMA_BIT_MASK(ilog2(dma_addr + size)));
> +       dev->coherent_dma_mask = min(dev->coherent_dma_mask, range_mask);
> +       *dev->dma_mask = min((*dev->dma_mask), range_mask);
> +}
> +EXPORT_SYMBOL_GPL(of_dma_configure_masks);
> +
> +/**
> + * of_dma_configure_ops - Setup DMA operations
> + * @dev:       Device to apply DMA configuration
> + * @np:                Pointer to OF node having DMA configuration
> + *
> + * Try to get devices's DMA configuration from DT and update it
> + * accordingly.
> + */
> +int of_dma_configure_ops(struct device *dev, struct device_node *np)
> +{
> +       u64 dma_addr, paddr, size;
> +       struct iommu_ops *iommu;
> +       bool coherent;
> +       int ret;
> +
> +       ret = of_dma_get_range(np, &dma_addr, &paddr, &size);
> +       if (ret < 0) {
> +               dma_addr = 0;
> +               size = dev->coherent_dma_mask + 1;
> +       }
>
>         coherent = of_dma_is_coherent(np);
>         dev_dbg(dev, "device is%sdma coherent\n",
> @@ -132,8 +152,10 @@ void of_dma_configure(struct device *dev, struct device_node *np)
>                 iommu ? " " : " not ");
>
>         arch_setup_dma_ops(dev, dma_addr, size, iommu, coherent);
> +
> +       return 0;
>  }
> -EXPORT_SYMBOL_GPL(of_dma_configure);
> +EXPORT_SYMBOL_GPL(of_dma_configure_ops);
>
>  /**
>   * of_dma_deconfigure - Clean up DMA configuration
> diff --git a/drivers/of/of_pci.c b/drivers/of/of_pci.c
> index 5751dc5b6494..c65803da2067 100644
> --- a/drivers/of/of_pci.c
> +++ b/drivers/of/of_pci.c
> @@ -132,7 +132,8 @@ void of_pci_dma_configure(struct pci_dev *pci_dev)
>         if (!bridge->parent)
>                 return;
>
> -       of_dma_configure(dev, bridge->parent->of_node);
> +       of_dma_configure_masks(dev, bridge->parent->of_node);
> +       of_dma_configure_ops(dev, bridge->parent->of_node);
>         pci_put_host_bridge_device(bridge);
>  }
>  EXPORT_SYMBOL_GPL(of_pci_dma_configure);
> diff --git a/drivers/of/platform.c b/drivers/of/platform.c
> index 7a660c79ff84..9a29f09b7723 100644
> --- a/drivers/of/platform.c
> +++ b/drivers/of/platform.c
> @@ -177,7 +177,8 @@ static struct platform_device *of_platform_device_create_pdata(
>
>         dev->dev.bus = &platform_bus_type;
>         dev->dev.platform_data = platform_data;
> -       of_dma_configure(&dev->dev, dev->dev.of_node);
> +       of_dma_configure_masks(&dev->dev, dev->dev.of_node);
> +       of_dma_configure_ops(&dev->dev, dev->dev.of_node);
>
>         if (of_device_add(dev) != 0) {
>                 of_dma_deconfigure(&dev->dev);
> @@ -240,7 +241,8 @@ static struct amba_device *of_amba_device_create(struct device_node *node,
>                 dev_set_name(&dev->dev, "%s", bus_id);
>         else
>                 of_device_make_bus_id(&dev->dev);
> -       of_dma_configure(&dev->dev, dev->dev.of_node);
> +       of_dma_configure_masks(&dev->dev, dev->dev.of_node);
> +       of_dma_configure_ops(&dev->dev, dev->dev.of_node);
>
>         /* Allow the HW Peripheral ID to be overridden */
>         prop = of_get_property(node, "arm,primecell-periphid", NULL);
> diff --git a/include/linux/of_device.h b/include/linux/of_device.h
> index 6710807b0653..794f234c7c7d 100644
> --- a/include/linux/of_device.h
> +++ b/include/linux/of_device.h
> @@ -53,7 +53,8 @@ static inline struct device_node *of_cpu_device_node_get(int cpu)
>         return of_node_get(cpu_dev->of_node);
>  }
>
> -void of_dma_configure(struct device *dev, struct device_node *np);
> +void of_dma_configure_masks(struct device *dev, struct device_node *np);
> +int of_dma_configure_ops(struct device *dev, struct device_node *np);
>  void of_dma_deconfigure(struct device *dev);
>  #else /* CONFIG_OF */
>
> @@ -92,8 +93,14 @@ static inline struct device_node *of_cpu_device_node_get(int cpu)
>  {
>         return NULL;
>  }
> -static inline void of_dma_configure(struct device *dev, struct device_node *np)
> +static inline void of_dma_configure_masks(struct device *dev,
> +                                         struct device_node *np)
>  {}
> +static inline int of_dma_configure_ops(struct device *dev,
> +                                      struct device_node *np)
> +{
> +       return 0;
> +}
>  static inline void of_dma_deconfigure(struct device *dev)
>  {}
>  #endif /* CONFIG_OF */
> --
> 2.3.6
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
