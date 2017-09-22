From: Lorenzo Pieralisi <lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v7 3/5] iommu/of: Add msi address regions reservation
	helper
Date: Fri, 22 Sep 2017 15:27:58 +0100
Message-ID: <20170922142758.GE3475@red-moon>
References: <20170914125756.14836-1-shameerali.kolothum.thodi@huawei.com>
	<20170914125756.14836-4-shameerali.kolothum.thodi@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170914125756.14836-4-shameerali.kolothum.thodi-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Shameer Kolothum <shameerali.kolothum.thodi-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
Cc: mark.rutland-5wv7dgnIgG8@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, guohanjun-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, gabriele.paoloni-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, marc.zyngier-5wv7dgnIgG8@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, linuxarm-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, sudeep.holla-5wv7dgnIgG8@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devel-E0kO6a4B6psdnm+yROfE0A@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

John, Shameer,

On Thu, Sep 14, 2017 at 01:57:54PM +0100, Shameer Kolothum wrote:
> From: John Garry <john.garry-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
> 
> On some platforms msi-controller address regions have to be excluded
> from normal IOVA allocation in that they are detected and decoded in
> a HW specific way by system components and so they cannot be considered
> normal IOVA address space.
> 
> Add a helper function that retrieves msi address regions through device
> tree msi mapping, so that these regions will not be translated by IOMMU
> and will be excluded from IOVA allocations.
> 
> Signed-off-by: John Garry <john.garry-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
> ---
>  drivers/iommu/of_iommu.c | 117 +++++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/of_iommu.h |  10 ++++
>  2 files changed, 127 insertions(+)
> 
> diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
> index 8cb6082..f2d1a76 100644
> --- a/drivers/iommu/of_iommu.c
> +++ b/drivers/iommu/of_iommu.c
> @@ -21,6 +21,7 @@
>  #include <linux/iommu.h>
>  #include <linux/limits.h>
>  #include <linux/of.h>
> +#include <linux/of_address.h>
>  #include <linux/of_iommu.h>
>  #include <linux/of_pci.h>
>  #include <linux/slab.h>
> @@ -246,6 +247,122 @@ const struct iommu_ops *of_iommu_configure(struct device *dev,
>  	return ops;
>  }
>  
> +/**
> + * of_iommu_msi_get_resv_regions - Reserved region driver helper
> + * @dev: Device from iommu_get_resv_regions()
> + * @list: Reserved region list from iommu_get_resv_regions()
> + *
> + * Returns: Number of reserved regions on success (0 if no associated
> + *          msi parent), appropriate error value otherwise.
> + */
> +int of_iommu_msi_get_resv_regions(struct device *dev, struct list_head *head)
> +{
> +	int prot = IOMMU_WRITE | IOMMU_NOEXEC | IOMMU_MMIO;
> +	struct iommu_resv_region *region;
> +	struct device_node *np;
> +	struct resource res;
> +	int i, resv = 0, mappings = 0;
> +
> +	if (dev_is_pci(dev)) {
> +		struct device *dma_dev, *bridge;
> +		struct of_phandle_args iommu_spec;
> +		struct pci_dev *pdev = to_pci_dev(dev);
> +		int err, count;
> +		u32 rid, map_mask;
> +		const __be32 *msi_map;
> +
> +		bridge = pci_get_host_bridge_device(pdev);
> +		dma_dev = bridge->parent;
> +		pci_put_host_bridge_device(bridge);
> +
> +		if (!dma_dev->of_node)
> +			return -ENODEV;
> +
> +		iommu_spec.args_count = 1;
> +		np = iommu_spec.np = dma_dev->of_node;
> +		pci_for_each_dma_alias(pdev, __get_pci_rid, &iommu_spec);
> +
> +		rid = iommu_spec.args[0];
> +		if (!of_property_read_u32(np, "msi-map-mask", &map_mask))
> +			rid &= map_mask;
> +
> +		msi_map = of_get_property(np, "msi-map", NULL);
> +		if (!msi_map)
> +			return -ENODEV;
> +
> +		mappings = of_count_phandle_with_args(np, "msi-map", NULL) / 4;
> +
> +		for (i = 0, count = mappings; i < count; i++, msi_map += 4) {
> +			struct device_node *msi_node;
> +			u32 rid_base, rid_len, phandle;
> +
> +			rid_base = be32_to_cpup(msi_map + 0);
> +			phandle = be32_to_cpup(msi_map + 1);
> +			rid_len = be32_to_cpup(msi_map + 3);
> +
> +			/* check rid is within range */
> +			if (rid < rid_base || rid >= rid_base + rid_len) {
> +				mappings--;
> +				continue;
> +			}
> +
> +			msi_node = of_find_node_by_phandle(phandle);
> +			if (!msi_node)
> +				return -ENODEV;

This is basically of_pci_map_rid(), I wonder whether there is not
a way to consolidate some code here - duplicating certainly does not
help. To make MSI reservations generic this is probably the only way
to do it but it would be nice to reuse some OF MSI code.

With the current kernel API there is a way but it is a bit whacky.

Just loop over "msi-controller" nodes and try to map the device to
them through of_pci_map_rid, if mapping succeeds reserve region for
the target node.

Not a big fan of what I am proposing but it certainly helps reuse
some existing code that makes no sense to duplicate.

> +			err = of_address_to_resource(msi_node, 0, &res);
> +			of_node_put(msi_node);
> +			if (err)
> +				return err;
> +
> +			region = iommu_alloc_resv_region(res.start,
> +							 resource_size(&res),
> +							 prot, IOMMU_RESV_MSI);
> +			if (region) {
> +				list_add_tail(&region->list, head);
> +				resv++;
> +			}
> +		}
> +	} else if (dev->of_node) {
> +		struct device_node *msi_np;
> +		int index = 0;
> +		int tuples;
> +
> +		np = dev->of_node;
> +
> +		tuples = of_count_phandle_with_args(np, "msi-parent", NULL);
> +
> +		while (index < tuples) {

Would not be easier to have an of_parse_phandle_with_args() loop here ?

Lorenzo

> +			int msi_cells = 0;
> +			int err;
> +
> +			msi_np = of_parse_phandle(np, "msi-parent", index);
> +			if (!msi_np)
> +				return -ENODEV;
> +
> +			of_property_read_u32(msi_np, "#msi-cells", &msi_cells);
> +
> +			err = of_address_to_resource(msi_np, 0, &res);
> +			of_node_put(msi_np);
> +			if (err)
> +				return err;
> +
> +			mappings++;
> +
> +			region = iommu_alloc_resv_region(res.start,
> +							 resource_size(&res),
> +							 prot, IOMMU_RESV_MSI);
> +			if (region) {
> +				list_add_tail(&region->list, head);
> +				resv++;
> +			}
> +			index += 1 + msi_cells;
> +		}
> +	}
> +
> +	return (resv == mappings) ? resv : -ENODEV;
> +}
> +
>  static int __init of_iommu_init(void)
>  {
>  	struct device_node *np;
> diff --git a/include/linux/of_iommu.h b/include/linux/of_iommu.h
> index 13394ac..9267772 100644
> --- a/include/linux/of_iommu.h
> +++ b/include/linux/of_iommu.h
> @@ -14,6 +14,9 @@ extern int of_get_dma_window(struct device_node *dn, const char *prefix,
>  extern const struct iommu_ops *of_iommu_configure(struct device *dev,
>  					struct device_node *master_np);
>  
> +extern int of_iommu_msi_get_resv_regions(struct device *dev,
> +					struct list_head *head);
> +
>  #else
>  
>  static inline int of_get_dma_window(struct device_node *dn, const char *prefix,
> @@ -29,6 +32,13 @@ static inline const struct iommu_ops *of_iommu_configure(struct device *dev,
>  	return NULL;
>  }
>  
> +static int of_iommu_msi_get_resv_regions(struct device *dev,
> +					struct list_head *head)
> +{
> +	return -ENODEV;
> +}
> +
> +
>  #endif	/* CONFIG_OF_IOMMU */
>  
>  extern struct of_device_id __iommu_of_table;
> -- 
> 1.9.1
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
