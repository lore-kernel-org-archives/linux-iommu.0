From: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [RFC PATCH 2/2] pcie: sideband data by dropping RID bits
Date: Fri, 7 Jul 2017 14:33:01 +0100
Message-ID: <20170707133301.GC3425@leverpostej>
References: <1499411399-25103-1-git-send-email-srinath.mannam@broadcom.com>
	<1499411399-25103-3-git-send-email-srinath.mannam@broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1499411399-25103-3-git-send-email-srinath.mannam-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Srinath Mannam <srinath.mannam-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org, Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Frank Rowand <frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Fri, Jul 07, 2017 at 12:39:59PM +0530, Srinath Mannam wrote:
> The MSI Device ID or Stream ID are passed as sideband
> data on the SOC bus to which PCI RC is connected.
> 
> If sideband data on SOC bus is less than 16bits then
> PCI RC will have to derive sideband data from RID by
> dropping selected bits.
> 
> This patch implements optional DT properties to generate
> smaller sideband data from RID which can be further
> mapped to MSI Device ID or Stream ID.
> 
> Sideband data generation from RID is done by dropping
> bits corresponding zero bits in {iommu/msi}-map-drop-mask.
> 
> Example: If drop-mask is 0xFF09 then sideband data is
> 8 bits bus number followed by 1 bit of device number and
> 1 bit function number. This means drop-mask=0xFF09 will
> convert RID=0x1a10 (16bits) to sideband data 0x6a (10bits).

As mentioned on the prior two patches, I don't think this is a good
idea, especially given this isn't a trivial masking operation.

It's already possible to express this mapping using a number of entries
in the the *-map properties, which you can generate programmatically
with a script.

Please do that instead.

Thanks,
Mark.

> 
> Signed-off-by: Anup Patel <anup.patel-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
> Signed-off-by: Oza Pawandeep <oza.oza-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
> Signed-off-by: Srinath Mannam <srinath.mannam-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
> Reviewed-by: Ray Jui <ray.jui-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
> Reviewed-by: Scott Branden <scott.branden-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
> ---
>  drivers/iommu/of_iommu.c |  4 ++--
>  drivers/of/irq.c         |  3 ++-
>  drivers/of/of_pci.c      | 48 +++++++++++++++++++++++++++++++++++++++++++++---
>  include/linux/of_pci.h   |  6 ++++--
>  4 files changed, 53 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
> index 19779b8..f179724 100644
> --- a/drivers/iommu/of_iommu.c
> +++ b/drivers/iommu/of_iommu.c
> @@ -169,8 +169,8 @@ static const struct iommu_ops
>  	 */
>  	iommu_spec.np = NULL;
>  	err = of_pci_map_rid(bridge_np, iommu_spec.args[0], "iommu-map",
> -			     "iommu-map-mask", &iommu_spec.np,
> -			     iommu_spec.args);
> +			     "iommu-map-mask", "iommu-map-drop-mask",
> +			     &iommu_spec.np, iommu_spec.args);
>  	if (err)
>  		return err == -ENODEV ? NULL : ERR_PTR(err);
>  
> diff --git a/drivers/of/irq.c b/drivers/of/irq.c
> index d11437c..454f47a 100644
> --- a/drivers/of/irq.c
> +++ b/drivers/of/irq.c
> @@ -606,7 +606,8 @@ static u32 __of_msi_map_rid(struct device *dev, struct device_node **np,
>  	 */
>  	for (parent_dev = dev; parent_dev; parent_dev = parent_dev->parent)
>  		if (!of_pci_map_rid(parent_dev->of_node, rid_in, "msi-map",
> -				    "msi-map-mask", np, &rid_out))
> +				    "msi-map-mask", "msi-map-drop-mask", np,
> +				    &rid_out))
>  			break;
>  	return rid_out;
>  }
> diff --git a/drivers/of/of_pci.c b/drivers/of/of_pci.c
> index c9d4d3a..a914bcf 100644
> --- a/drivers/of/of_pci.c
> +++ b/drivers/of/of_pci.c
> @@ -285,6 +285,35 @@ int of_pci_get_host_bridge_resources(struct device_node *dev,
>  EXPORT_SYMBOL_GPL(of_pci_get_host_bridge_resources);
>  #endif /* CONFIG_OF_ADDRESS */
>  
> +static inline u32 out_masked_rid(u32 rid, u32 drop_mask)
> +{
> +	u32 id = 0;
> +	u32 i = 0;
> +
> +	/* RID's BUS, DEV, FUN values not inside the mask are invalid */
> +	if (rid & ~drop_mask)
> +		return -EINVAL;
> +
> +	/*
> +	 * RID value is translated to sideband data using drop_mask
> +	 * by dropping bits corresponding zero bits in drop_mask.
> +	 *
> +	 * Example: If drop_mask is 0xFF09 then sideband data is
> +	 * 8 bits bus number followed by 1 bit of device number and
> +	 * 1 bit function number. This means drop_mask=0xFF09 will
> +	 * convert RID=0x1a10 (16bits) to sideband data 0x6a (10bits).
> +	 */
> +	while (drop_mask) {
> +		if (drop_mask & 0x1) {
> +			id |= ((rid & 0x1) << i);
> +			i++;
> +		}
> +		rid = rid >> 1;
> +		drop_mask = drop_mask >> 1;
> +	}
> +
> +	return id;
> +}
>  /**
>   * of_pci_map_rid - Translate a requester ID through a downstream mapping.
>   * @np: root complex device node.
> @@ -304,11 +333,11 @@ EXPORT_SYMBOL_GPL(of_pci_get_host_bridge_resources);
>   *
>   * Return: 0 on success or a standard error code on failure.
>   */
> -int of_pci_map_rid(struct device_node *np, u32 rid,
> -		   const char *map_name, const char *map_mask_name,
> +int of_pci_map_rid(struct device_node *np, u32 rid, const char *map_name,
> +		   const char *map_mask_name, const char *drop_mask_name,
>  		   struct device_node **target, u32 *id_out)
>  {
> -	u32 map_mask, masked_rid;
> +	u32 map_mask, masked_rid, drop_mask;
>  	int map_len;
>  	const __be32 *map = NULL;
>  
> @@ -340,7 +369,20 @@ int of_pci_map_rid(struct device_node *np, u32 rid,
>  	if (map_mask_name)
>  		of_property_read_u32(np, map_mask_name, &map_mask);
>  
> +	/* The default is to select all bits. */
> +	drop_mask = 0xffffffff;
> +
> +	/*
> +	 * Can be overridden by "{iommu,msi}-map-drop-mask" property.
> +	 * If of_property_read_u32() fails, the default is used.
> +	 */
> +	if (drop_mask_name)
> +		of_property_read_u32(np, drop_mask_name, &drop_mask);
> +
>  	masked_rid = map_mask & rid;
> +
> +	masked_rid = out_masked_rid(masked_rid, drop_mask);
> +
>  	for ( ; map_len > 0; map_len -= 4 * sizeof(*map), map += 4) {
>  		struct device_node *phandle_node;
>  		u32 rid_base = be32_to_cpup(map + 0);
> diff --git a/include/linux/of_pci.h b/include/linux/of_pci.h
> index 518c8d2..98937ec 100644
> --- a/include/linux/of_pci.h
> +++ b/include/linux/of_pci.h
> @@ -20,7 +20,8 @@ int of_pci_get_max_link_speed(struct device_node *node);
>  void of_pci_check_probe_only(void);
>  int of_pci_map_rid(struct device_node *np, u32 rid,
>  		   const char *map_name, const char *map_mask_name,
> -		   struct device_node **target, u32 *id_out);
> +		   const char *drop_mask_name, struct device_node **target,
> +		   u32 *id_out);
>  #else
>  static inline int of_irq_parse_pci(const struct pci_dev *pdev, struct of_phandle_args *out_irq)
>  {
> @@ -58,7 +59,8 @@ of_get_pci_domain_nr(struct device_node *node)
>  
>  static inline int of_pci_map_rid(struct device_node *np, u32 rid,
>  			const char *map_name, const char *map_mask_name,
> -			struct device_node **target, u32 *id_out)
> +			const char *drop_mask_name, struct device_node **target,
> +			u32 *id_out)
>  {
>  	return -EINVAL;
>  }
> -- 
> 2.7.4
> 
