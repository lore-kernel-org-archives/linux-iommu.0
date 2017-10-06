From: Shameerali Kolothum Thodi <shameerali.kolothum.thodi-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
Subject: RE: [PATCH v8 2/5] ACPI/IORT: Add msi address regions reservation
	helper
Date: Fri, 6 Oct 2017 10:17:17 +0000
Message-ID: <5FC3163CFD30C246ABAA99954A238FA83841DB56@FRAEML521-MBX.china.huawei.com>
References: <20170927133241.21036-1-shameerali.kolothum.thodi@huawei.com>
	<20170927133241.21036-3-shameerali.kolothum.thodi@huawei.com>
	<001729e8-7b34-0bb4-8af6-8af100661906@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <001729e8-7b34-0bb4-8af6-8af100661906-5wv7dgnIgG8@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Marc Zyngier <marc.zyngier-5wv7dgnIgG8@public.gmane.org>, "lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org" <lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org>, "sudeep.holla-5wv7dgnIgG8@public.gmane.org" <sudeep.holla-5wv7dgnIgG8@public.gmane.org>, "will.deacon-5wv7dgnIgG8@public.gmane.org" <will.deacon-5wv7dgnIgG8@public.gmane.org>, "robin.murphy-5wv7dgnIgG8@public.gmane.org" <robin.murphy-5wv7dgnIgG8@public.gmane.org>, "joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org" <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, "mark.rutland-5wv7dgnIgG8@public.gmane.org" <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Gabriele Paoloni <gabriele.paoloni-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, Linuxarm <linuxarm-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, "linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "Guohanjun (Hanjun Guo)" <guohanjun-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "devel-E0kO6a4B6psdnm+yROfE0A@public.gmane.org" <devel-E0kO6a4B6psdnm+yROfE0A@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org



> -----Original Message-----
> From: Marc Zyngier [mailto:marc.zyngier-5wv7dgnIgG8@public.gmane.org]
> Sent: Wednesday, October 04, 2017 3:18 PM
> To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>;
> lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org; sudeep.holla-5wv7dgnIgG8@public.gmane.org; will.deacon-5wv7dgnIgG8@public.gmane.org;
> robin.murphy-5wv7dgnIgG8@public.gmane.org; joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org; mark.rutland-5wv7dgnIgG8@public.gmane.org;
> robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
> Cc: Gabriele Paoloni <gabriele.paoloni-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>; John Garry
> <john.garry-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>; iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org; linux-arm-
> kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org; linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org;
> devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; devel-E0kO6a4B6psdnm+yROfE0A@public.gmane.org; Linuxarm
> <linuxarm-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>; Wangzhou (B) <wangzhou1-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org>;
> Guohanjun (Hanjun Guo) <guohanjun-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
> Subject: Re: [PATCH v8 2/5] ACPI/IORT: Add msi address regions reservation
> helper
> 
> On 27/09/17 14:32, Shameer Kolothum wrote:
> > On some platforms msi parent address regions have to be excluded from
> > normal IOVA allocation in that they are detected and decoded in a HW
> > specific way by system components and so they cannot be considered
> > normal IOVA address space.
> >
> > Add a helper function that retrieves ITS address regions - the msi
> > parent - through IORT device <-> ITS mappings and reserves it so that
> > these regions will not be translated by IOMMU and will be excluded
> > from IOVA allocations.
> >
> > Signed-off-by: Shameer Kolothum
> <shameerali.kolothum.thodi-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
> > [lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org: updated commit log/added comments]
> > Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org>
> > ---
> >  drivers/acpi/arm64/iort.c        | 96
> ++++++++++++++++++++++++++++++++++++++--
> >  drivers/irqchip/irq-gic-v3-its.c |  3 +-
> >  include/linux/acpi_iort.h        |  7 ++-
> >  3 files changed, 101 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
> > index 9565d57..14efa9d 100644
> > --- a/drivers/acpi/arm64/iort.c
> > +++ b/drivers/acpi/arm64/iort.c
> > @@ -39,6 +39,7 @@
> >  struct iort_its_msi_chip {
> >  	struct list_head	list;
> >  	struct fwnode_handle	*fw_node;
> > +	phys_addr_t		base_addr;
> >  	u32			translation_id;
> >  };
> >
> > @@ -136,14 +137,16 @@ typedef acpi_status (*iort_find_node_callback)
> > static DEFINE_SPINLOCK(iort_msi_chip_lock);
> >
> >  /**
> > - * iort_register_domain_token() - register domain token and related
> > ITS ID
> > - * to the list from where we can get it back later on.
> > + * iort_register_domain_token() - register domain token along with
> > + related
> > + * ITS ID and base address to the list from where we can get it back later
> on.
> >   * @trans_id: ITS ID.
> > + * @base: ITS base address.
> >   * @fw_node: Domain token.
> >   *
> >   * Returns: 0 on success, -ENOMEM if no memory when allocating list
> element
> >   */
> > -int iort_register_domain_token(int trans_id, struct fwnode_handle
> > *fw_node)
> > +int iort_register_domain_token(int trans_id, phys_addr_t base,
> > +			       struct fwnode_handle *fw_node)
> >  {
> >  	struct iort_its_msi_chip *its_msi_chip;
> >
> > @@ -153,6 +156,7 @@ int iort_register_domain_token(int trans_id,
> > struct fwnode_handle *fw_node)
> >
> >  	its_msi_chip->fw_node = fw_node;
> >  	its_msi_chip->translation_id = trans_id;
> > +	its_msi_chip->base_addr = base;
> >
> >  	spin_lock(&iort_msi_chip_lock);
> >  	list_add(&its_msi_chip->list, &iort_msi_chip_list); @@ -481,6
> > +485,24 @@ int iort_pmsi_get_dev_id(struct device *dev, u32 *dev_id)
> >  	return -ENODEV;
> >  }
> >
> > +static int __maybe_unused iort_find_its_base(u32 its_id, phys_addr_t
> > +*base) {
> > +	struct iort_its_msi_chip *its_msi_chip;
> > +	bool match = false;
> > +
> > +	spin_lock(&iort_msi_chip_lock);
> > +	list_for_each_entry(its_msi_chip, &iort_msi_chip_list, list) {
> > +		if (its_msi_chip->translation_id == its_id) {
> > +			*base = its_msi_chip->base_addr;
> > +			match = true;
> > +			break;
> > +		}
> > +	}
> > +	spin_unlock(&iort_msi_chip_lock);
> > +
> > +	return match ? 0 : -ENODEV;
> > +}
> > +
> >  /**
> >   * iort_dev_find_its_id() - Find the ITS identifier for a device
> >   * @dev: The device.
> > @@ -639,6 +661,72 @@ int iort_add_device_replay(const struct
> iommu_ops
> > *ops, struct device *dev)
> >
> >  	return err;
> >  }
> > +
> > +/**
> > + * iort_iommu_msi_get_resv_regions - Reserved region driver helper
> > + * @dev: Device from iommu_get_resv_regions()
> > + * @head: Reserved region list from iommu_get_resv_regions()
> > + *
> > + * Returns: Number of reserved regions on success (0 if no associated msi
> > + *          regions), appropriate error value otherwise. The ITS regions
> > + *          associated with the device are the msi reserved regions.
> > + */
> > +int iort_iommu_msi_get_resv_regions(struct device *dev, struct
> > +list_head *head) {
> > +	struct acpi_iort_its_group *its;
> > +	struct acpi_iort_node *node, *its_node = NULL;
> > +	int i, resv = 0;
> > +
> > +	node = iort_find_dev_node(dev);
> > +	if (!node)
> > +		return -ENODEV;
> > +
> > +	/*
> > +	 * Current logic to reserve ITS regions relies on HW topologies
> > +	 * where a given PCI or named component maps its IDs to only one
> > +	 * ITS group; if a PCI or named component can map its IDs to
> > +	 * different ITS groups through IORT mappings this function has
> > +	 * to be reworked to ensure we reserve regions for all ITS groups
> > +	 * a given PCI or named component may map IDs to.
> > +	 */
> > +	if (dev_is_pci(dev)) {
> > +		u32 rid;
> > +
> > +		pci_for_each_dma_alias(to_pci_dev(dev), __get_pci_rid,
> &rid);
> > +		its_node = iort_node_map_id(node, rid, NULL,
> IORT_MSI_TYPE);
> > +	} else {
> > +		for (i = 0; i < node->mapping_count; i++) {
> > +			its_node = iort_node_map_platform_id(node, NULL,
> > +							 IORT_MSI_TYPE, i);
> > +			if (its_node)
> > +				break;
> > +		}
> > +	}
> > +
> > +	if (!its_node)
> > +		return 0;
> > +
> > +	/* Move to ITS specific data */
> > +	its = (struct acpi_iort_its_group *)its_node->node_data;
> > +
> > +	for (i = 0; i < its->its_count; i++) {
> > +		phys_addr_t base;
> > +
> > +		if (!iort_find_its_base(its->identifiers[i], &base)) {
> > +			int prot = IOMMU_WRITE | IOMMU_NOEXEC |
> IOMMU_MMIO;
> > +			struct iommu_resv_region *region;
> > +
> > +			region = iommu_alloc_resv_region(base, SZ_128K,
> prot,
> > +							 IOMMU_RESV_MSI);
> 
> Same as the OF part: I strongly object to reserving the whole 128kB range.
> What we really care about is the second 64kB page, and that is what should
> get reserved.

Thanks Marc. I will make the changes in next revision.

Also as we are still discussing about the DT approach for this, I am thinking
of sending out the v9 with the above fix and blacklisting the HiSilicon PCIe
controllers on DT based hip06/hip07 systems when SMMUv3 is enabled.

Hi Will,

Hope that will address your concerns with respect to only having ACPI quirk
for this. 

Thanks,
Shameer
