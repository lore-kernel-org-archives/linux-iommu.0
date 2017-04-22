From: Oza Oza via iommu <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Subject: Re: [RFC PATCH] of: Fix DMA configuration for non-DT masters
Date: Sat, 22 Apr 2017 14:23:47 +0530
Message-ID: <CAMSpPPez2TqzFi9EOers_sw-4=+rX_qKc6rWdbEmOhcBMF1OTA@mail.gmail.com>
References: <67d1f46172599be243405f4341665fd0ef9ab969.1490726288.git.robin.murphy@arm.com>
Reply-To: Oza Oza <oza.oza-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <67d1f46172599be243405f4341665fd0ef9ab969.1490726288.git.robin.murphy-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linux IOMMU <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Wed, Mar 29, 2017 at 12:27 AM, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org> wrote:
> For PCI masters not represented in DT, we pass the OF node of their
> associated host bridge to of_dma_configure(), such that they can inherit
> the appropriate DMA configuration from whatever is described there.
> Unfortunately, whilst this has worked for the "dma-coherent" property,
> it turns out to miss the case where the host bridge node has a non-empty
> "dma-ranges", since nobody is expecting the 'device' to be a bus itself.
>
> It transpires, though, that the de-facto interface since the prototype
> change in 1f5c69aa51f9 ("of: Move of_dma_configure() to device.c to help
> re-use") is very clear-cut: either the master_np argument is redundant
> with dev->of_node, or dev->of_node is NULL and master_np is the relevant
> parent bus. Let's ratify that behaviour, then teach the whole
> of_dma_configure() pipeline to cope with both cases properly.
>
> Signed-off-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
> ---
>
> This is what I'd consider the better fix - rather than adding yet more
> special cases - which will also make it simple to handle multiple
> "dma-ranges" entries with minimal further disruption. The callers now
> left passing dev->of_node as 'parent' are harmless, but look a bit silly
> and clearly want cleaning up - I'd be partial to renaming the existing
> function and having a single-argument wrapper for the 'normal' case, e.g.:
>
> static inline int of_dma_configure(struct device_node *dev)
> {
>         return of_dma_configure_parent(dev, NULL);
> }
>
> Thoughts?
>
> Robin.
>
>  drivers/iommu/of_iommu.c   |  7 ++++---
>  drivers/of/address.c       | 37 +++++++++++++++++++++++++------------
>  drivers/of/device.c        | 12 +++++++-----
>  include/linux/of_address.h |  7 ++++---
>  include/linux/of_device.h  |  4 ++--
>  include/linux/of_iommu.h   |  4 ++--
>  6 files changed, 44 insertions(+), 27 deletions(-)
>
> diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
> index 2683e9fc0dcf..35aff07bb5eb 100644
> --- a/drivers/iommu/of_iommu.c
> +++ b/drivers/iommu/of_iommu.c
> @@ -138,21 +138,22 @@ static const struct iommu_ops
>  }
>
>  const struct iommu_ops *of_iommu_configure(struct device *dev,
> -                                          struct device_node *master_np)
> +                                          struct device_node *parent)
>  {
>         struct of_phandle_args iommu_spec;
> -       struct device_node *np;
> +       struct device_node *np, *master_np;
>         const struct iommu_ops *ops = NULL;
>         int idx = 0;
>
>         if (dev_is_pci(dev))
> -               return of_pci_iommu_configure(to_pci_dev(dev), master_np);
> +               return of_pci_iommu_configure(to_pci_dev(dev), parent);
>
>         /*
>          * We don't currently walk up the tree looking for a parent IOMMU.
>          * See the `Notes:' section of
>          * Documentation/devicetree/bindings/iommu/iommu.txt
>          */
> +       master_np = dev->of_node ? dev->of_node : parent;
>         while (!of_parse_phandle_with_args(master_np, "iommus",
>                                            "#iommu-cells", idx,
>                                            &iommu_spec)) {
> diff --git a/drivers/of/address.c b/drivers/of/address.c
> index 02b2903fe9d2..833bc17f5e55 100644
> --- a/drivers/of/address.c
> +++ b/drivers/of/address.c
> @@ -808,6 +808,7 @@ EXPORT_SYMBOL(of_io_request_and_map);
>  /**
>   * of_dma_get_range - Get DMA range info
>   * @np:                device node to get DMA range info
> + * @parent:    node of device's parent bus, if @np is NULL
>   * @dma_addr:  pointer to store initial DMA address of DMA range
>   * @paddr:     pointer to store initial CPU address of DMA range
>   * @size:      pointer to store size of DMA range
> @@ -822,36 +823,48 @@ EXPORT_SYMBOL(of_io_request_and_map);
>   * It returns -ENODEV if "dma-ranges" property was not found
>   * for this device in DT.
>   */
> -int of_dma_get_range(struct device_node *np, u64 *dma_addr, u64 *paddr, u64 *size)
> +int of_dma_get_range(struct device_node *np, struct device_node *parent,
> +                    u64 *dma_addr, u64 *paddr, u64 *size)
>  {
> -       struct device_node *node = of_node_get(np);
> +       struct device_node *node;
>         const __be32 *ranges = NULL;
>         int len, naddr, nsize, pna;
>         int ret = 0;
>         u64 dmaaddr;
>
> -       if (!node)
> -               return -EINVAL;
> -
> -       while (1) {
> +       if (np) {
> +               node = of_node_get(np);
>                 naddr = of_n_addr_cells(node);
>                 nsize = of_n_size_cells(node);
>                 node = of_get_next_parent(node);
> -               if (!node)
> -                       break;
> +       } else if (parent) {
> +               node = of_node_get(parent);
> +               np = parent;
> +               if (of_property_read_u32(node, "#address-cells", &naddr))
> +                       naddr = of_n_addr_cells(node);
> +               if (of_property_read_u32(node, "#size-cells", &nsize))
> +                       nsize = of_n_size_cells(node);
> +       } else {
> +               return -EINVAL;
> +       }
>
> +       while (node) {
>                 ranges = of_get_property(node, "dma-ranges", &len);
>
> -               /* Ignore empty ranges, they imply no translation required */
> -               if (ranges && len > 0)
> -                       break;
> -
>                 /*
>                  * At least empty ranges has to be defined for parent node if
>                  * DMA is supported
>                  */
>                 if (!ranges)
>                         break;
> +
> +               /* Ignore empty ranges, they imply no translation required */
> +               if (len > 0)
> +                       break;
> +
> +               naddr = of_n_addr_cells(node);
> +               nsize = of_n_size_cells(node);
> +               node = of_get_next_parent(node);
>         }
>
>         if (!ranges) {
> diff --git a/drivers/of/device.c b/drivers/of/device.c
> index 9bb8518b28f2..57ec5324ed6c 100644
> --- a/drivers/of/device.c
> +++ b/drivers/of/device.c
> @@ -73,7 +73,8 @@ int of_device_add(struct platform_device *ofdev)
>  /**
>   * of_dma_configure - Setup DMA configuration
>   * @dev:       Device to apply DMA configuration
> - * @np:                Pointer to OF node having DMA configuration
> + * @parent:    OF node of device's parent bus, if @dev is not
> + *             represented in DT (i.e. @dev->of_node is NULL)
>   *
>   * Try to get devices's DMA configuration from DT and update it
>   * accordingly.
> @@ -82,13 +83,14 @@ int of_device_add(struct platform_device *ofdev)
>   * can use a platform bus notifier and handle BUS_NOTIFY_ADD_DEVICE events
>   * to fix up DMA configuration.
>   */
> -void of_dma_configure(struct device *dev, struct device_node *np)
> +void of_dma_configure(struct device *dev, struct device_node *parent)
>  {
>         u64 dma_addr, paddr, size;
>         int ret;
>         bool coherent;
>         unsigned long offset;
>         const struct iommu_ops *iommu;
> +       struct device_node *np = dev->of_node;
>
>         /*
>          * Set default coherent_dma_mask to 32 bit.  Drivers are expected to
> @@ -104,7 +106,7 @@ void of_dma_configure(struct device *dev, struct device_node *np)
>         if (!dev->dma_mask)
>                 dev->dma_mask = &dev->coherent_dma_mask;
>
> -       ret = of_dma_get_range(np, &dma_addr, &paddr, &size);
> +       ret = of_dma_get_range(np, parent, &dma_addr, &paddr, &size);
>         if (ret < 0) {
>                 dma_addr = offset = 0;
>                 size = dev->coherent_dma_mask + 1;
> @@ -132,11 +134,11 @@ void of_dma_configure(struct device *dev, struct device_node *np)
>         dev->coherent_dma_mask = DMA_BIT_MASK(ilog2(dma_addr + size));
>         *dev->dma_mask = dev->coherent_dma_mask;
>
> -       coherent = of_dma_is_coherent(np);
> +       coherent = of_dma_is_coherent(np ? np : parent);
>         dev_dbg(dev, "device is%sdma coherent\n",
>                 coherent ? " " : " not ");
>
> -       iommu = of_iommu_configure(dev, np);
> +       iommu = of_iommu_configure(dev, parent);
>         dev_dbg(dev, "device is%sbehind an iommu\n",
>                 iommu ? " " : " not ");
>
> diff --git a/include/linux/of_address.h b/include/linux/of_address.h
> index 37864734ca50..f1a507f3ae57 100644
> --- a/include/linux/of_address.h
> +++ b/include/linux/of_address.h
> @@ -52,8 +52,8 @@ extern int of_pci_range_parser_init(struct of_pci_range_parser *parser,
>  extern struct of_pci_range *of_pci_range_parser_one(
>                                         struct of_pci_range_parser *parser,
>                                         struct of_pci_range *range);
> -extern int of_dma_get_range(struct device_node *np, u64 *dma_addr,
> -                               u64 *paddr, u64 *size);
> +extern int of_dma_get_range(struct device_node *np, struct device_node *parent,
> +                               u64 *dma_addr, u64 *paddr, u64 *size);
>  extern bool of_dma_is_coherent(struct device_node *np);
>  #else /* CONFIG_OF_ADDRESS */
>  static inline void __iomem *of_io_request_and_map(struct device_node *device,
> @@ -95,7 +95,8 @@ static inline struct of_pci_range *of_pci_range_parser_one(
>         return NULL;
>  }
>
> -static inline int of_dma_get_range(struct device_node *np, u64 *dma_addr,
> +static inline int of_dma_get_range(struct device_node *np,
> +                               struct device_node *parent, u64 *dma_addr,
>                                 u64 *paddr, u64 *size)
>  {
>         return -ENODEV;
> diff --git a/include/linux/of_device.h b/include/linux/of_device.h
> index c12dace043f3..bcd2b6fbeef3 100644
> --- a/include/linux/of_device.h
> +++ b/include/linux/of_device.h
> @@ -55,7 +55,7 @@ static inline struct device_node *of_cpu_device_node_get(int cpu)
>         return of_node_get(cpu_dev->of_node);
>  }
>
> -void of_dma_configure(struct device *dev, struct device_node *np);
> +void of_dma_configure(struct device *dev, struct device_node *parent);
>  #else /* CONFIG_OF */
>
>  static inline int of_driver_match_device(struct device *dev,
> @@ -103,7 +103,7 @@ static inline struct device_node *of_cpu_device_node_get(int cpu)
>  {
>         return NULL;
>  }
> -static inline void of_dma_configure(struct device *dev, struct device_node *np)
> +static inline void of_dma_configure(struct device *dev, struct device_node *parent)
>  {}
>  #endif /* CONFIG_OF */
>
> diff --git a/include/linux/of_iommu.h b/include/linux/of_iommu.h
> index 13394ac83c66..c02b62e8e6ed 100644
> --- a/include/linux/of_iommu.h
> +++ b/include/linux/of_iommu.h
> @@ -12,7 +12,7 @@ extern int of_get_dma_window(struct device_node *dn, const char *prefix,
>                              size_t *size);
>
>  extern const struct iommu_ops *of_iommu_configure(struct device *dev,
> -                                       struct device_node *master_np);
> +                                       struct device_node *parent);
>
>  #else
>
> @@ -24,7 +24,7 @@ static inline int of_get_dma_window(struct device_node *dn, const char *prefix,
>  }
>
>  static inline const struct iommu_ops *of_iommu_configure(struct device *dev,
> -                                        struct device_node *master_np)
> +                                        struct device_node *parent)
>  {
>         return NULL;
>  }
> --
> 2.11.0.dirty
>

Hi Robin,

After some more thoughts to this, I have improved upon old patch design.
please check  https://lkml.org/lkml/2017/4/22/34

 this patch served following purposes

    1) exposes intrface to the pci host driver for thir inbound memory ranges

    2) provide an interface to callers such as of_dma_get_ranges.
    so then the returned size get best possible (largest) dma_mask.
    for e.g.
    dma-ranges = <0x43000000 0x00 0x00 0x00 0x00 0x80 0x00>;
    we should get dev->coherent_dma_mask=0x7fffffffff.

    3) this patch handles multiple inbound windows and dma-ranges.
    it is left to the caller, how it wants to use them.
    the new function returns the resources in a standard and unform way

    4) this way the callers of of_dma_get_ranges does not need to change.
    and

    5) leaves scope of adding PCI flag handling for inbound memory
    by the new function.


which I feel much better approach/way than accommodating
of_dma_get_ranges to handle multiple dma-ranges, addressing PCI
masters.
also in your patch I think, you have to make emulated parent node
which is more work I suppose.

again I have tested this on our SOC and it works well.

Regards,
Oza.
