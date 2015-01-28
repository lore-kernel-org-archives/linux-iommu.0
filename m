From: Rob Herring <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v5 5/8] of/pci: add of_pci_dma_configure() update dma configuration
Date: Tue, 27 Jan 2015 20:49:25 -0600
Message-ID: <CAL_JsqL_SBezH92nJ_xHg5o1ZfH8uC_wne72CQr6yCP+ByuiXQ@mail.gmail.com>
References: <1422392405-32196-1-git-send-email-m-karicheri2@ti.com> <1422392405-32196-6-git-send-email-m-karicheri2@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1422392405-32196-6-git-send-email-m-karicheri2-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Murali Karicheri <m-karicheri2-l0cyMroinI0@public.gmane.org>
Cc: "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux IOMMU <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Suravee Suthikulpanit <Suravee.Suthikulpanit-5C7GfCeVMHo@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Tue, Jan 27, 2015 at 3:00 PM, Murali Karicheri <m-karicheri2-l0cyMroinI0@public.gmane.org> wrote:
> Add of_pci_dma_configure() to allow updating the dma configuration
> of the pci device using the configuration from DT of the parent of
> the root bridge device. Use the newly added APIs
> pci_get/put_host_bridge_device() for implementing this.
>
> Cc: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
> Cc: Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>

Acked-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>

> Cc: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
> Cc: Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
> Cc: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
> Cc: Suravee Suthikulpanit <Suravee.Suthikulpanit-5C7GfCeVMHo@public.gmane.org>
>
> Acked-by: Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
> Signed-off-by: Murali Karicheri <m-karicheri2-l0cyMroinI0@public.gmane.org>
> ---
>  drivers/of/of_pci.c    |   19 +++++++++++++++++++
>  include/linux/of_pci.h |    5 +++++
>  2 files changed, 24 insertions(+)
>
> diff --git a/drivers/of/of_pci.c b/drivers/of/of_pci.c
> index 88471d3..0f1dd0b 100644
> --- a/drivers/of/of_pci.c
> +++ b/drivers/of/of_pci.c
> @@ -2,6 +2,7 @@
>  #include <linux/export.h>
>  #include <linux/of.h>
>  #include <linux/of_address.h>
> +#include <linux/of_device.h>
>  #include <linux/of_pci.h>
>  #include <linux/slab.h>
>
> @@ -229,6 +230,24 @@ parse_failed:
>         return err;
>  }
>  EXPORT_SYMBOL_GPL(of_pci_get_host_bridge_resources);
> +
> +/**
> + * of_pci_dma_configure - Setup DMA configuration
> + * @dev: ptr to pci_dev struct of the pci device
> + *
> + * Function to update PCI devices's DMA configuration using the same
> + * info from the OF node of root host bridge's parent.
> + */
> +void of_pci_dma_configure(struct pci_dev *pci_dev)
> +{
> +       struct device *dev = &pci_dev->dev;
> +       struct device *bridge = pci_get_host_bridge_device(pci_dev);
> +
> +       of_dma_configure(dev, bridge->parent->of_node);
> +       pci_put_host_bridge_device(bridge);
> +}
> +EXPORT_SYMBOL_GPL(of_pci_dma_configure);
> +
>  #endif /* CONFIG_OF_ADDRESS */
>
>  #ifdef CONFIG_PCI_MSI
> diff --git a/include/linux/of_pci.h b/include/linux/of_pci.h
> index ce0e5ab..8f1741f 100644
> --- a/include/linux/of_pci.h
> +++ b/include/linux/of_pci.h
> @@ -16,6 +16,7 @@ int of_pci_get_devfn(struct device_node *np);
>  int of_irq_parse_and_map_pci(const struct pci_dev *dev, u8 slot, u8 pin);
>  int of_pci_parse_bus_range(struct device_node *node, struct resource *res);
>  int of_get_pci_domain_nr(struct device_node *node);
> +void of_pci_dma_configure(struct pci_dev *pci_dev);
>  #else
>  static inline int of_irq_parse_pci(const struct pci_dev *pdev, struct of_phandle_args *out_irq)
>  {
> @@ -50,6 +51,10 @@ of_get_pci_domain_nr(struct device_node *node)
>  {
>         return -1;
>  }
> +
> +static inline void of_pci_dma_configure(struct pci_dev *pci_dev)
> +{
> +}
>  #endif
>
>  #if defined(CONFIG_OF_ADDRESS)
> --
> 1.7.9.5
>
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
