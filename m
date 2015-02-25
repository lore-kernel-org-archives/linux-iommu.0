From: Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v6 6/7] PCI: update dma configuration from DT
Date: Tue, 24 Feb 2015 19:53:17 -0600
Message-ID: <20150225015317.GO6220@google.com>
References: <1423173179-10227-1-git-send-email-m-karicheri2@ti.com>
 <1423173179-10227-7-git-send-email-m-karicheri2@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1423173179-10227-7-git-send-email-m-karicheri2-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Murali Karicheri <m-karicheri2-l0cyMroinI0@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Suravee Suthikulpanit <Suravee.Suthikulpanit-5C7GfCeVMHo@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Thu, Feb 05, 2015 at 04:52:58PM -0500, Murali Karicheri wrote:
> If there is a DT node available for the root bridge's parent device,
> use the dma configuration from that device node. For example, keystone
> PCI devices would require dma_pfn_offset to be set correctly in the
> device structure of the pci device in order to have the correct dma mask.
> The DT node will have dma-ranges defined for this. Also support using
> the DT property dma-coherent to allow coherent DMA operation by the
> PCI device.

Hi Murali,

I'm guessing this is the patch that actually fixes things for Keystone.

And it looks like it should also fix things for other hardware that has
similar characteristics.  So I'd like to include some higher-level text
about that here.  For example:

  This fixes DMA on systems where DMA addresses are a constant offset
  from CPU physical addresses.

(I don't know exactly how these patches all fit together, so that's
probably not accurate, but that's the *sort* of thing I'd like to include.)

If that actually *is* what's going on, I have to wonder why this isn't
implemented as a very simple IOMMU instead of adding dma_pfn_offset,
which is present on all arches but only used on ARM.  In some sense that
offset is parallel but incompatible with an IOMMU: they both translate DMA
addresses into system RAM addresses.

I know you're not adding this, and I assume somebody explored that option
and rejected it for good reasons.  I just missed that discussion.

> This patch use the new helper function of_pci_dma_configure() to update
> the device dma configuration.
> 
> Cc: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
> Cc: Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> Cc: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
> Cc: Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
> Cc: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
> Cc: Suravee Suthikulpanit <Suravee.Suthikulpanit-5C7GfCeVMHo@public.gmane.org>
> 
> Acked-by: Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
> Signed-off-by: Murali Karicheri <m-karicheri2-l0cyMroinI0@public.gmane.org>
> ---
>  drivers/pci/probe.c |    2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 23212f8..d7dcd6c 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -6,6 +6,7 @@
>  #include <linux/delay.h>
>  #include <linux/init.h>
>  #include <linux/pci.h>
> +#include <linux/of_pci.h>
>  #include <linux/pci_hotplug.h>
>  #include <linux/slab.h>
>  #include <linux/module.h>
> @@ -1520,6 +1521,7 @@ void pci_device_add(struct pci_dev *dev, struct pci_bus *bus)
>  	dev->dev.dma_mask = &dev->dma_mask;
>  	dev->dev.dma_parms = &dev->dma_parms;
>  	dev->dev.coherent_dma_mask = 0xffffffffull;
> +	of_pci_dma_configure(dev);
>  
>  	pci_set_dma_max_seg_size(dev, 65536);
>  	pci_set_dma_seg_boundary(dev, 0xffffffff);
> -- 
> 1.7.9.5
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
