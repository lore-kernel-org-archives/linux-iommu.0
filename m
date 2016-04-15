From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [RFC PATCH 09/11] drivers: acpi: implement acpi_dma_configure
Date: Fri, 15 Apr 2016 17:31:58 +0100
Message-ID: <5711177E.2000509@arm.com>
References: <1460654743-7896-1-git-send-email-lorenzo.pieralisi@arm.com>
	<1460654743-7896-10-git-send-email-lorenzo.pieralisi@arm.com>
	<20160415161400.GC7973@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20160415161400.GC7973@localhost>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Bjorn Helgaas <helgaas-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Lorenzo Pieralisi <lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Marc Zyngier <marc.zyngier-5wv7dgnIgG8@public.gmane.org>, Tomasz Nowicki <tn-nYOzD4b6Jr9Wk0Htik3J/w@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Sinan Kaya <okaya-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Hanjun Guo <hanjun.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Jon Masters <jcm-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi Bjorn,

On 15/04/16 17:14, Bjorn Helgaas wrote:
> On Thu, Apr 14, 2016 at 06:25:41PM +0100, Lorenzo Pieralisi wrote:
>> On DT based systems, the of_dma_configure() API implements DMA configuration
>> for a given device. On ACPI systems an API equivalent to of_dma_configure()
>> is missing which implies that it is currently not possible to set-up DMA
>> operations for devices through the ACPI generic kernel layer.
>>
>> This patch fills the gap by introducing acpi_dma_configure/deconfigure()
>> calls, that carry out IOMMU configuration through IORT (on systems where
>> it is present) and call arch_setup_dma_ops(...) with the retrieved
>> parameters.
>>
>> The DMA range size passed to arch_setup_dma_ops() is sized according
>> to the device coherent_dma_mask (starting at address 0x0), mirroring the
>> DT probing path behaviour when a dma-ranges property is not provided
>> for the device being probed; this changes the current arch_setup_dma_ops()
>> call parameters in the ACPI probing case, but since arch_setup_dma_ops()
>> is a NOP on all architectures but ARM/ARM64 this patch does not change
>> the current kernel behaviour on them.
>>
>> This patch updates ACPI and PCI core code to use the newly introduced
>> acpi_dma_configure function, providing the same functionality
>> as of_dma_configure on ARM systems and leaving behaviour unchanged
>> for all other arches.
>>
>> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org>
>> Cc: Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
>> Cc: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
>> Cc: Tomasz Nowicki <tn-nYOzD4b6Jr9Wk0Htik3J/w@public.gmane.org>
>> Cc: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
>> Cc: "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>
>
> There's only a tiny PCI change in this series, so I assume somebody
> else will merge all this.  Here's my ack for the PCI part:
>
> Acked-by: Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>	# for drivers/pci/probe.c change
>
> One question on use of pci_for_each_dma_alias() below.
>
>> +static int __get_pci_rid(struct pci_dev *pdev, u16 alias, void *data)
>> +{
>> +	u32 *rid = data;
>> +
>> +	*rid = alias;
>> +	return 0;
>> +}
>> +
>> +/**
>> + * iort_iommu_configure - Set-up IOMMU configuration for a device.
>> + *
>> + * @dev: device that requires IOMMU set-up
>> + *
>> + * Returns: iommu_ops pointer on configuration success
>> + *          NULL on configuration failure
>> + */
>> +struct iommu_ops *iort_iommu_configure(struct device *dev)
>> +{
>> +	struct acpi_iort_node *node, *parent;
>> +	struct iommu_ops *ops = NULL;
>> +	struct iommu_fwspec fwspec;
>> +	struct iort_iommu_node *iommu_node;
>> +	u32 rid = 0, devid = 0;
>> +
>> +	if (dev_is_pci(dev)) {
>> +		struct pci_bus *bus = to_pci_dev(dev)->bus;
>> +
>> +		pci_for_each_dma_alias(to_pci_dev(dev), __get_pci_rid,
>> +				       &rid);
>
> You end up with only the last DMA alias in "rid".  Is it really true
> that you only need to call iort_dev_map_rid() for one of the aliases?

Indeed - all we care about is what things look like by the time they 
come out of the root complex on their way to the the IOMMU, so whatever 
intermediate aliasing _within_ the PCI bus might happen along the way 
doesn't actually matter.

Robin.

>> +		node = iort_scan_node(ACPI_IORT_NODE_PCI_ROOT_COMPLEX,
>> +				      iort_find_dev_callback, &bus->dev);
>> +	} else
>> +		node = iort_scan_node(ACPI_IORT_NODE_NAMED_COMPONENT,
>> +				      iort_find_dev_callback, dev);
>> +
>> +	if (!node)
>> +		return NULL;
>> +
>> +	iort_dev_map_rid(node, rid, &devid, ACPI_IORT_NODE_SMMU);
>> +
>> +	parent = iort_find_parent_node(node, ACPI_IORT_NODE_SMMU);
>> +
>> +	if (!parent)
>> +		return NULL;
>> +
>> +	iommu_node = iort_iommu_get_node(parent);
>> +	ops = iommu_node->ops;
>> +
>> +	fwspec.fwnode = iommu_node->fwnode;
>> +	fwspec.param_count = 1;
>> +	fwspec.param[0] = devid;
>> +
>> +	if (!ops || !ops->fw_xlate || ops->fw_xlate(dev, &fwspec))
>> +		return NULL;
>> +
>> +	return ops;
>> +}
> _______________________________________________
> iommu mailing list
> iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu
>
