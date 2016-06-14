From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v2 3/7] of/irq: Break out msi-map lookup (again)
Date: Tue, 14 Jun 2016 15:37:50 +0100
Message-ID: <20160614143750.GJ19407@arm.com>
References: <cover.1464966939.git.robin.murphy@arm.com>
 <2cbffa9a341edfd10114994f6486f6b08d0c390c.1464966939.git.robin.murphy@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <2cbffa9a341edfd10114994f6486f6b08d0c390c.1464966939.git.robin.murphy-5wv7dgnIgG8@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Cc: joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, Marc Zyngier <marc.zyngier-5wv7dgnIgG8@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Fri, Jun 03, 2016 at 06:15:38PM +0100, Robin Murphy wrote:
> The PCI msi-map code is already doing double-duty translating IDs and
> retrieving MSI parents, which unsurprisingly is the same functionality
> we need for the identically-formatted PCI iommu-map property. Drag the
> core parsing routine up yet another layer into the general OF-PCI code,
> and further generalise it for either kind of lookup in either flavour
> of map property.
> 
> CC: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> CC: Frank Rowand <frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> CC: Marc Zyngier <marc.zyngier-5wv7dgnIgG8@public.gmane.org>
> Signed-off-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
> ---
> 
> v2: No change.
> 
>  drivers/of/irq.c       |  70 ++-------------------------------
>  drivers/of/of_pci.c    | 102 +++++++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/of_pci.h |   8 ++++
>  3 files changed, 114 insertions(+), 66 deletions(-)

[...]

> diff --git a/drivers/of/of_pci.c b/drivers/of/of_pci.c
> index 13f4fed38048..20bf5a0c57fd 100644
> --- a/drivers/of/of_pci.c
> +++ b/drivers/of/of_pci.c
> @@ -306,3 +306,105 @@ struct msi_controller *of_pci_find_msi_chip_by_node(struct device_node *of_node)
>  EXPORT_SYMBOL_GPL(of_pci_find_msi_chip_by_node);
>  
>  #endif /* CONFIG_PCI_MSI */
> +
> +#define MASK_NAME_LEN	32	/* Safely longer than "iommu-map-mask" */
> +
> +/**
> + * of_pci_map_rid - Translate a requester ID through a downstream mapping.
> + * @np: root complex device node.
> + * @map_name: property name of the map to use.
> + * @target: optional pointer to a target device node.
> + * @id_out: optional pointer to receive the translated ID.
> + *
> + * Given a PCI requester ID, look up the appropriate implementation-defined
> + * platform ID and/or the target device which receives transactions on that
> + * ID, as per the "iommu-map" and "msi-map" bindings. @target or @id_out may
> + * be NULL if not required. If @target points to a device node pointer, only
> + * entries targeting that node will be matched; if it points to a NULL
> + * value, it will receive the device node for the first matching target entry,
> + * with a reference held.
> + *
> + * Return: 0 on success or a standard error code on failure.
> + */
> +int of_pci_map_rid(struct device_node *np, const char *map_name, u32 rid_in,
> +		   struct device_node **target, u32 *rid_out)
> +{
> +	u32 map_mask, masked_rid;
> +	int map_len;
> +	const __be32 *map = NULL;
> +	char mask_name[MASK_NAME_LEN];

Couldn't you avoid this if you just took const char *mask_name as a
parameter too?

Will
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
