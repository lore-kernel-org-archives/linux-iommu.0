From: Lorenzo Pieralisi <lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [RFCv2 1/2] acpi:iort: Add new helper function to retrieve ITS
	base addr from dev IORT node
Date: Tue, 6 Jun 2017 15:10:19 +0100
Message-ID: <20170606141019.GC20126@red-moon>
References: <20170531143213.82100-1-shameerali.kolothum.thodi@huawei.com>
	<20170531143213.82100-2-shameerali.kolothum.thodi@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170531143213.82100-2-shameerali.kolothum.thodi-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: shameer <shameerali.kolothum.thodi-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
Cc: guohanjun-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, gabriele.paoloni-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, marc.zyngier-5wv7dgnIgG8@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, linuxarm-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, wangzhou1-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org, sudeep.holla-5wv7dgnIgG8@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devel-E0kO6a4B6psdnm+yROfE0A@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Wed, May 31, 2017 at 03:32:12PM +0100, shameer wrote:
> This provides a helper function to find and retrieve the ITS
> base address from the ID mappings array reference of a device
> IORT node(if any).
> 
> This is used in the subsequent patch to retrieve the ITS base 
> address associated with a pci dev IORT node.

"Add an IORT helper function to retrieve the ITS data through IORT
device<->ITS mappings".

> Signed-off-by: shameer <shameerali.kolothum.thodi-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
> ---
>  drivers/acpi/arm64/iort.c        | 47 +++++++++++++++++++++++++++++++++++++---
>  drivers/irqchip/irq-gic-v3-its.c |  3 ++-
>  include/linux/acpi_iort.h        |  8 ++++++-
>  3 files changed, 53 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
> index c5fecf9..12d7347 100644
> --- a/drivers/acpi/arm64/iort.c
> +++ b/drivers/acpi/arm64/iort.c
> @@ -34,6 +34,7 @@
>  struct iort_its_msi_chip {
>  	struct list_head	list;
>  	struct fwnode_handle	*fw_node;
> +	u64			base_addr;

phys_addr_t

>  	u32			translation_id;
>  };
>  
> @@ -132,13 +133,14 @@ typedef acpi_status (*iort_find_node_callback)
>  
>  /**
>   * iort_register_domain_token() - register domain token and related ITS ID
> - * to the list from where we can get it back later on.
> + * and base address to the list from where we can get it back later on.
>   * @trans_id: ITS ID.

Missing something here

>   * @fw_node: Domain token.
>   *
>   * Returns: 0 on success, -ENOMEM if no memory when allocating list element
>   */
> -int iort_register_domain_token(int trans_id, struct fwnode_handle *fw_node)
> +int iort_register_domain_token(int trans_id, u64 base,

phys_addr_t

> +			       struct fwnode_handle *fw_node)
>  {
>  	struct iort_its_msi_chip *its_msi_chip;
>  
> @@ -148,6 +150,7 @@ int iort_register_domain_token(int trans_id, struct fwnode_handle *fw_node)
>  
>  	its_msi_chip->fw_node = fw_node;
>  	its_msi_chip->translation_id = trans_id;
> +	its_msi_chip->base_addr = base;
>  
>  	spin_lock(&iort_msi_chip_lock);
>  	list_add(&its_msi_chip->list, &iort_msi_chip_list);
> @@ -370,7 +373,6 @@ static struct acpi_iort_node *iort_node_map_id(struct acpi_iort_node *node,
>  
>  		if (!node->mapping_offset || !node->mapping_count)
>  			goto fail_map;
> -

Unrelated change.

>  		map = ACPI_ADD_PTR(struct acpi_iort_id_mapping, node,
>  				   node->mapping_offset);
>  
> @@ -491,6 +493,45 @@ int iort_pmsi_get_dev_id(struct device *dev, u32 *dev_id)
>  	return -ENODEV;
>  }
>  
> +int iort_dev_find_its_base(struct device *dev, u32 req_id,
> +			   unsigned int idx, u64 *its_base)
> +{
> +	struct acpi_iort_its_group *its;
> +	struct acpi_iort_node *node;
> +	struct iort_its_msi_chip *its_msi_chip;
> +	u32  trans_id;
> +
> +	node = iort_find_dev_node(dev);
> +	if (!node)
> +		return -ENXIO;

-ENODEV, throughout

> +
> +	node = iort_node_map_id(node, req_id, NULL, IORT_MSI_TYPE);
> +	if (!node)
> +		return -ENXIO;
> +
> +	/* Move to ITS specific data */
> +	its = (struct acpi_iort_its_group *)node->node_data;
> +	if (idx > its->its_count) {
> +		dev_err(dev, "requested ITS ID index [%d] is greater than available [%d]\n",
> +			idx, its->its_count);
> +		return -ENXIO;
> +	}
> +
> +	trans_id = its->identifiers[idx];
> +
> +	spin_lock(&iort_msi_chip_lock);
> +	list_for_each_entry(its_msi_chip, &iort_msi_chip_list, list) {
> +		if (its_msi_chip->translation_id == trans_id) {
> +			*its_base = its_msi_chip->base_addr;
> +			spin_unlock(&iort_msi_chip_lock);
> +			return 0;
> +		}
> +	}
> +	spin_unlock(&iort_msi_chip_lock);
> +
> +	return -ENXIO;

Cosmetics:

	bool match = false;

	[...]

	spin_lock(&iort_msi_chip_lock);
	list_for_each_entry(its_msi_chip, &iort_msi_chip_list, list) {
		if (its_msi_chip->translation_id == trans_id) {
			*its_base = its_msi_chip->base_addr;
			match = true;
			break;
		}
	}
	spin_unlock(&iort_msi_chip_lock);

	return match ? 0 : -ENODEV;

}

>  /**
>   * iort_dev_find_its_id() - Find the ITS identifier for a device
>   * @dev: The device.
> diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
> index 45ea1933..c45a2ad 100644
> --- a/drivers/irqchip/irq-gic-v3-its.c
> +++ b/drivers/irqchip/irq-gic-v3-its.c
> @@ -1854,7 +1854,8 @@ static int __init gic_acpi_parse_madt_its(struct acpi_subtable_header *header,
>  		return -ENOMEM;
>  	}
>  
> -	err = iort_register_domain_token(its_entry->translation_id, dom_handle);
> +	err = iort_register_domain_token(its_entry->translation_id, res.start,
> +					 dom_handle);
>  	if (err) {
>  		pr_err("ITS@%pa: Unable to register GICv3 ITS domain token (ITS ID %d) to IORT\n",
>  		       &res.start, its_entry->translation_id);
> diff --git a/include/linux/acpi_iort.h b/include/linux/acpi_iort.h
> index 3ff9ace..bf7b53d 100644
> --- a/include/linux/acpi_iort.h
> +++ b/include/linux/acpi_iort.h
> @@ -26,7 +26,8 @@
>  #define IORT_IRQ_MASK(irq)		(irq & 0xffffffffULL)
>  #define IORT_IRQ_TRIGGER_MASK(irq)	((irq >> 32) & 0xffffffffULL)
>  
> -int iort_register_domain_token(int trans_id, struct fwnode_handle *fw_node);
> +int iort_register_domain_token(int trans_id, u64 base,
> +			       struct fwnode_handle *fw_node);
>  void iort_deregister_domain_token(int trans_id);
>  struct fwnode_handle *iort_find_domain_token(int trans_id);
>  #ifdef CONFIG_ACPI_IORT
> @@ -36,6 +37,8 @@
>  struct irq_domain *iort_get_device_domain(struct device *dev, u32 req_id);
>  void acpi_configure_pmsi_domain(struct device *dev);
>  int iort_pmsi_get_dev_id(struct device *dev, u32 *dev_id);
> +int iort_dev_find_its_base(struct device *dev, u32 req_id,
> +			   unsigned int idx, u64 *its_base);
>  /* IOMMU interface */
>  void iort_set_dma_mask(struct device *dev);
>  const struct iommu_ops *iort_iommu_configure(struct device *dev);
> @@ -48,6 +51,9 @@ static inline struct irq_domain *iort_get_device_domain(struct device *dev,
>  							u32 req_id)
>  { return NULL; }
>  static inline void acpi_configure_pmsi_domain(struct device *dev) { }
> +int iort_dev_find_its_base(struct device *dev, u32 req_id,
> +			   unsigned int idx, u64 *its_base)
> +{ return -ENOSYS; }

-ENODEV

Thanks,
Lorenzo
