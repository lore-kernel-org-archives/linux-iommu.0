From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH v3 1/2] acpi:iort: Add an IORT helper function to reserve
 HW ITS address regions for IOMMU drivers
Date: Tue, 4 Jul 2017 11:16:39 +0100
Message-ID: <20170704101638.GB17491@red-moon>
References: <20170623145801.325244-1-shameerali.kolothum.thodi@huawei.com>
 <20170623145801.325244-2-shameerali.kolothum.thodi@huawei.com>
 <20170623165406.GA6412@red-moon>
 <5FC3163CFD30C246ABAA99954A238FA838399F10@FRAEML521-MBX.china.huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5FC3163CFD30C246ABAA99954A238FA838399F10@FRAEML521-MBX.china.huawei.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Cc: "Guohanjun (Hanjun Guo)" <guohanjun@huawei.com>, Gabriele Paoloni <gabriele.paoloni@huawei.com>, "marc.zyngier@arm.com" <marc.zyngier@arm.com>, John Garry <john.garry@huawei.com>, "will.deacon@arm.com" <will.deacon@arm.com>, Linuxarm <linuxarm@huawei.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "hanjun.guo@linaro.org" <hanjun.guo@linaro.org>, "Wangzhou (B)" <wangzhou1@hisilicon.com>, "sudeep.holla@arm.com" <sudeep.holla@arm.com>, "robin.murphy@arm.com" <robin.murphy@arm.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "devel@acpica.org" <devel@acpica.org>
List-Id: iommu@lists.linux-foundation.org

On Mon, Jul 03, 2017 at 08:18:45AM +0000, Shameerali Kolothum Thodi wrote:
> 
> 
> > -----Original Message-----
> > From: Lorenzo Pieralisi [mailto:lorenzo.pieralisi@arm.com]
> > Sent: Friday, June 23, 2017 5:54 PM
> > To: Shameerali Kolothum Thodi
> > Cc: marc.zyngier@arm.com; sudeep.holla@arm.com; will.deacon@arm.com;
> > robin.murphy@arm.com; hanjun.guo@linaro.org; Gabriele Paoloni; John
> > Garry; iommu@lists.linux-foundation.org; linux-arm-
> > kernel@lists.infradead.org; linux-acpi@vger.kernel.org; devel@acpica.org;
> > Linuxarm; Wangzhou (B); Guohanjun (Hanjun Guo)
> > Subject: Re: [PATCH v3 1/2] acpi:iort: Add an IORT helper function to reserve
> > HW ITS address regions for IOMMU drivers
> > 
> > On Fri, Jun 23, 2017 at 03:58:00PM +0100, shameer wrote:
> > > The helper function retrieves ITS address regions through IORT device
> > > <-> ITS mappings and reserves it so that these regions will not be
> > > translated by IOMMU and will be excluded from IOVA allocations. IOMMU
> > > drivers can use this to implement their .get_resv_regions callback.
> > >
> > > Signed-off-by: shameer <shameerali.kolothum.thodi@huawei.com>
> > > ---
> > >  drivers/acpi/arm64/iort.c        | 91
> > ++++++++++++++++++++++++++++++++++++++--
> > >  drivers/irqchip/irq-gic-v3-its.c |  3 +-
> > >  include/linux/acpi_iort.h        |  7 +++-
> > >  3 files changed, 96 insertions(+), 5 deletions(-)
> > >
> > > diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
> > > index c5fecf9..cf0a6b8 100644
> > > --- a/drivers/acpi/arm64/iort.c
> > > +++ b/drivers/acpi/arm64/iort.c
> > > @@ -34,6 +34,7 @@
> > >  struct iort_its_msi_chip {
> > >  	struct list_head	list;
> > >  	struct fwnode_handle	*fw_node;
> > > +	phys_addr_t		base_addr;
> > >  	u32			translation_id;
> > >  };
> > >
> > > @@ -131,14 +132,16 @@ typedef acpi_status (*iort_find_node_callback)
> > > static DEFINE_SPINLOCK(iort_msi_chip_lock);
> > >
> > >  /**
> > > - * iort_register_domain_token() - register domain token and related
> > > ITS ID
> > > - * to the list from where we can get it back later on.
> > > + * iort_register_domain_token() - register domain token along with
> > > + related
> > > + * ITS ID and base address to the list from where we can get it back later
> > on.
> > >   * @trans_id: ITS ID.
> > > + * @base: ITS base address.
> > >   * @fw_node: Domain token.
> > >   *
> > >   * Returns: 0 on success, -ENOMEM if no memory when allocating list
> > element
> > >   */
> > > -int iort_register_domain_token(int trans_id, struct fwnode_handle
> > > *fw_node)
> > > +int iort_register_domain_token(int trans_id, phys_addr_t base,
> > > +			       struct fwnode_handle *fw_node)
> > >  {
> > >  	struct iort_its_msi_chip *its_msi_chip;
> > >
> > > @@ -148,6 +151,7 @@ int iort_register_domain_token(int trans_id,
> > > struct fwnode_handle *fw_node)
> > >
> > >  	its_msi_chip->fw_node = fw_node;
> > >  	its_msi_chip->translation_id = trans_id;
> > > +	its_msi_chip->base_addr = base;
> > >
> > >  	spin_lock(&iort_msi_chip_lock);
> > >  	list_add(&its_msi_chip->list, &iort_msi_chip_list); @@ -491,6
> > > +495,24 @@ int iort_pmsi_get_dev_id(struct device *dev, u32 *dev_id)
> > >  	return -ENODEV;
> > >  }
> > >
> > > +static int iort_find_its_base(u32 its_id, phys_addr_t *base) {
> > > +	struct iort_its_msi_chip *its_msi_chip;
> > > +	bool match = false;
> > > +
> > > +	spin_lock(&iort_msi_chip_lock);
> > > +	list_for_each_entry(its_msi_chip, &iort_msi_chip_list, list) {
> > > +		if (its_msi_chip->translation_id == its_id) {
> > > +			*base = its_msi_chip->base_addr;
> > > +			match = true;
> > > +			break;
> > > +		}
> > > +	}
> > > +	spin_unlock(&iort_msi_chip_lock);
> > > +
> > > +	return match ? 0 : -ENODEV;
> > > +}
> > > +
> > >  /**
> > >   * iort_dev_find_its_id() - Find the ITS identifier for a device
> > >   * @dev: The device.
> > > @@ -649,6 +671,67 @@ int iort_add_device_replay(const struct
> > iommu_ops
> > > *ops, struct device *dev)
> > >
> > >  	return err;
> > >  }
> > > +
> > > +/**
> > > + * iort_iommu_its_get_resv_regions - Reserved region driver helper
> > > + * @dev: Device from iommu_get_resv_regions()
> > > + * @list: Reserved region list from iommu_get_resv_regions()
> > > + *
> > > + * Returns: Number of reserved regions on success(0 if no associated ITS),
> > > + *          appropriate error value otherwise.
> > > + *
> > > + * IOMMU drivers can use this to implement their .get_resv_regions
> > > +callback
> > > + * for reserving the HW ITS address regions.
> > > + */
> > > +int iort_iommu_its_get_resv_regions(struct device *dev, struct
> > > +list_head *head) {
> > > +	int i;
> > > +	struct acpi_iort_its_group *its;
> > > +	struct acpi_iort_node *node, *its_node = NULL;
> > > +	int resv = 0;
> > > +
> > > +	node = iort_find_dev_node(dev);
> > > +	if (!node)
> > > +		return -ENODEV;
> > > +
> > > +	if (dev_is_pci(dev)) {
> > > +		u32 rid;
> > > +
> > > +		pci_for_each_dma_alias(to_pci_dev(dev), __get_pci_rid,
> > &rid);
> > > +		its_node = iort_node_map_id(node, rid, NULL,
> > IORT_MSI_TYPE);
> > > +	} else {
> > > +		for (i = 0; i < node->mapping_count; i++) {
> > > +			its_node = iort_node_map_platform_id(node, NULL,
> > > +							 IORT_MSI_TYPE, i);
> > > +			if (its_node)
> > > +				break;
> > > +		}
> > > +	}
> > > +
> > > +	if (!its_node)
> > > +		return 0;
> > > +
> > > +	/* Move to ITS specific data */
> > > +	its = (struct acpi_iort_its_group *)its_node->node_data;
> > > +
> > > +	for (i = 0; i < its->its_count; i++) {
> > > +		phys_addr_t base;
> > > +
> > > +		if (!iort_find_its_base(its->identifiers[i], &base)) {
> > > +			int prot = IOMMU_WRITE | IOMMU_NOEXEC |
> > IOMMU_MMIO;
> > > +			struct iommu_resv_region *region;
> > > +
> > > +			region = iommu_alloc_resv_region(base, SZ_128K,
> > prot,
> > > +							 IOMMU_RESV_MSI);
> > > +			if (region) {
> > > +				list_add_tail(&region->list, head);
> > > +				resv++;
> > > +			}
> > > +		}
> > > +	}
> > > +
> > > +	return resv ? : -ENODEV;
> > 
> > IIUC I think this is not right (ie resv < its_count should count as a failure).
> 
> Yes, that is a valid error.
> 
> > This should be easy to fix-up but I am not sure there is still time for these
> > patches to be merged for this merge window, I take the blame since I am the
> > cause of the delay but I thought the logic in the SMMU driver should have
> > been clarified and this version does it IMO.
> 
> No problem and thanks for your support. I could rebase this on  rc1 and send
> the next version. Please let me know.

Yes, that will work, please resend the final version at -rc1 and if
Will and Robin are ok with SMMU changes we can queue it for 4.14.

Thanks,
Lorenzo
