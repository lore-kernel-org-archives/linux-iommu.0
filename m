From: Lorenzo Pieralisi <lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH V5 10/12] drivers: acpi: Configure acpi devices dma
	operation at probe time
Date: Thu, 19 Jan 2017 16:42:22 +0000
Message-ID: <20170119164222.GA28483@red-moon>
References: <1484838356-24962-1-git-send-email-sricharan@codeaurora.org>
	<1484838356-24962-11-git-send-email-sricharan@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1484838356-24962-11-git-send-email-sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Sricharan R <sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Cc: linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Thu, Jan 19, 2017 at 08:35:54PM +0530, Sricharan R wrote:
> With all the DT based devices getting their dma ops configured
> during probe time to have the right iommu setup, let us do the
> same for acpi based devices as well.
> 
> Configuring DMA ops at probe time will allow deferring device probe when
> the IOMMU isn't available yet. The dma_configure for the device is
> now called from the generic device_attach callback just before the
> bus/driver probe is called. This way, configuring the DMA ops for the
> device would be called at the same place for all bus_types, hence the
> deferred probing mechanism should work for all buses as well.
> 
> Signed-off-by: Sricharan R <sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
> ---
>  * Removed the dma configuration for the pci devices in case of ACPI
>    from pci_dma_configure which was hanging outside separately and
>    doing it in dma_configure function itself.
> 
>  drivers/acpi/glue.c        |  5 -----
>  drivers/base/dma-mapping.c | 13 ++++++++++++-
>  drivers/pci/probe.c        | 25 -------------------------
>  3 files changed, 12 insertions(+), 31 deletions(-)
> 
> diff --git a/drivers/acpi/glue.c b/drivers/acpi/glue.c
> index fb19e1c..c05f241 100644
> --- a/drivers/acpi/glue.c
> +++ b/drivers/acpi/glue.c
> @@ -176,7 +176,6 @@ int acpi_bind_one(struct device *dev, struct acpi_device *acpi_dev)
>  	struct list_head *physnode_list;
>  	unsigned int node_id;
>  	int retval = -EINVAL;
> -	enum dev_dma_attr attr;
>  
>  	if (has_acpi_companion(dev)) {
>  		if (acpi_dev) {
> @@ -233,10 +232,6 @@ int acpi_bind_one(struct device *dev, struct acpi_device *acpi_dev)
>  	if (!has_acpi_companion(dev))
>  		ACPI_COMPANION_SET(dev, acpi_dev);
>  
> -	attr = acpi_get_dma_attr(acpi_dev);
> -	if (attr != DEV_DMA_NOT_SUPPORTED)
> -		acpi_dma_configure(dev, attr);
> -
>  	acpi_physnode_link_name(physical_node_name, node_id);
>  	retval = sysfs_create_link(&acpi_dev->dev.kobj, &dev->kobj,
>  				   physical_node_name);
> diff --git a/drivers/base/dma-mapping.c b/drivers/base/dma-mapping.c
> index f82212c..294942d 100644
> --- a/drivers/base/dma-mapping.c
> +++ b/drivers/base/dma-mapping.c
> @@ -7,6 +7,7 @@
>   * This file is released under the GPLv2.
>   */
>  
> +#include <linux/acpi.h>
>  #include <linux/dma-mapping.h>
>  #include <linux/export.h>
>  #include <linux/gfp.h>
> @@ -352,6 +353,7 @@ int dma_configure(struct device *dev)
>  {
>  	struct device *_dev = dev;
>  	int is_pci = dev_is_pci(dev);
> +	enum dev_dma_attr attr;
>  	int ret = 0;
>  
>  	if (is_pci) {
> @@ -361,8 +363,16 @@ int dma_configure(struct device *dev)
>  			_dev = _dev->parent;
>  	}
>  
> -	if (_dev->of_node)
> +	if (_dev->of_node) {
>  		ret = of_dma_configure(dev, _dev->of_node);
> +	} else if (has_acpi_companion(_dev)) {
> +		attr = acpi_get_dma_attr(to_acpi_device_node(_dev->fwnode));
> +
> +		if (attr == DEV_DMA_NOT_SUPPORTED)
> +			dev_warn(dev, "DMA not supported.\n");

The changes you are making are correct but now this dev_warn spits hell
for non-pci devices that do not support DMA (ie they do not have a _CCA
on CONFIG_ACPI_CCA_REQUIRED systems), so you will have to remove it
given that this path is now shared.

Thanks,
Lorenzo

> +		else
> +			acpi_dma_configure(dev, attr);
> +	}
>  
>  	if (is_pci)
>  		pci_put_host_bridge_device(_dev);
> @@ -373,4 +383,5 @@ int dma_configure(struct device *dev)
>  void dma_deconfigure(struct device *dev)
>  {
>  	of_dma_deconfigure(dev);
> +	acpi_dma_deconfigure(dev);
>  }
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 634d34e..b86e9b1 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -1862,30 +1862,6 @@ static void pci_set_msi_domain(struct pci_dev *dev)
>  	dev_set_msi_domain(&dev->dev, d);
>  }
>  
> -/**
> - * pci_dma_configure - Setup DMA configuration
> - * @dev: ptr to pci_dev struct of the PCI device
> - *
> - * Function to update PCI devices's DMA configuration using the same
> - * info from the OF node or ACPI node of host bridge's parent (if any).
> - */
> -static void pci_dma_configure(struct pci_dev *dev)
> -{
> -	struct device *bridge = pci_get_host_bridge_device(dev);
> -
> -	if (has_acpi_companion(bridge)) {
> -		struct acpi_device *adev = to_acpi_device_node(bridge->fwnode);
> -		enum dev_dma_attr attr = acpi_get_dma_attr(adev);
> -
> -		if (attr == DEV_DMA_NOT_SUPPORTED)
> -			dev_warn(&dev->dev, "DMA not supported.\n");
> -		else
> -			acpi_dma_configure(&dev->dev, attr);
> -	}
> -
> -	pci_put_host_bridge_device(bridge);
> -}
> -
>  void pci_device_add(struct pci_dev *dev, struct pci_bus *bus)
>  {
>  	int ret;
> @@ -1899,7 +1875,6 @@ void pci_device_add(struct pci_dev *dev, struct pci_bus *bus)
>  	dev->dev.dma_mask = &dev->dma_mask;
>  	dev->dev.dma_parms = &dev->dma_parms;
>  	dev->dev.coherent_dma_mask = 0xffffffffull;
> -	pci_dma_configure(dev);
>  
>  	pci_set_dma_max_seg_size(dev, 65536);
>  	pci_set_dma_seg_boundary(dev, 0xffffffff);
> -- 
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
> 
