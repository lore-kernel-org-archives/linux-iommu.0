From: Tomasz Nowicki <tn@semihalf.com>
Subject: Re: [RFC PATCH v2 13/15] drivers: acpi: iort: introduce
 iort_iommu_configure
Date: Fri, 10 Jun 2016 14:46:56 +0200
Message-ID: <575AB6C0.4050808@semihalf.com>
References: <1465306270-27076-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1465306270-27076-14-git-send-email-lorenzo.pieralisi@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1465306270-27076-14-git-send-email-lorenzo.pieralisi@arm.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, iommu@lists.linux-foundation.org
Cc: Hanjun Guo <hanjun.guo@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Will Deacon <will.deacon@arm.com>, Marc Zyngier <marc.zyngier@arm.com>, Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>, Jon Masters <jcm@redhat.com>, Sinan Kaya <okaya@codeaurora.org>, linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: iommu@lists.linux-foundation.org

On 07.06.2016 15:31, Lorenzo Pieralisi wrote:
> +static int __get_pci_rid(struct pci_dev *pdev, u16 alias, void *data)
> +{
> +	u32 *rid = data;
> +
> +	*rid = alias;
> +	return 0;
> +}
> +
> +/**
> + * iort_iommu_configure - Set-up IOMMU configuration for a device.
> + *
> + * @dev: device to configure
> + *
> + * Returns: iommu_ops pointer on configuration success
> + *          NULL on configuration failure
> + */
> +const struct iommu_ops *iort_iommu_configure(struct device *dev)
> +{
> +	struct acpi_iort_node *node, *parent;
> +	const struct iort_ops_node *iort_ops;
> +	u32 rid = 0, devid = 0;
> +
> +	if (dev_is_pci(dev)) {
> +		struct pci_bus *bus = to_pci_dev(dev)->bus;
> +
> +		pci_for_each_dma_alias(to_pci_dev(dev), __get_pci_rid,
> +				       &rid);

I think we should find here the root bus which is connected to RC IORT node.

> +
> +		node = iort_scan_node(ACPI_IORT_NODE_PCI_ROOT_COMPLEX,
> +				      iort_find_dev_callback, &bus->dev);
> +	} else {
> +		node = iort_scan_node(ACPI_IORT_NODE_NAMED_COMPONENT,
> +				      iort_find_dev_callback, dev);
> +	}
> +
> +	if (!node)
> +		return NULL;
> +
> +	parent = iort_find_parent_node(node);
> +
> +	if (!parent)
> +		return NULL;
> +
> +	iort_ops = iort_smmu_get_ops_node(parent);
> +
> +	if (iort_ops && iort_ops->iommu_xlate) {
> +		iort_dev_map_rid(node, rid, &devid, parent->type);
> +		iort_ops->iommu_xlate(dev, devid, parent);
> +		return iort_ops->ops;
> +	}
> +
> +	return NULL;
> +}
> +

Thanks,
Tomasz
