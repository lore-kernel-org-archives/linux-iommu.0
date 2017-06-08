From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [RFCv2 2/2] iommu/arm-smmu-v3:Enable ACPI based HiSilicon
 erratum 161010801
Date: Thu, 8 Jun 2017 09:48:51 +0100
Message-ID: <20170608084851.GA8607@red-moon>
References: <20170531143213.82100-1-shameerali.kolothum.thodi@huawei.com>
 <20170531143213.82100-3-shameerali.kolothum.thodi@huawei.com>
 <20170606135623.GB20126@red-moon>
 <5FC3163CFD30C246ABAA99954A238FA838362082@FRAEML521-MBX.china.huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5FC3163CFD30C246ABAA99954A238FA838362082@FRAEML521-MBX.china.huawei.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Cc: "marc.zyngier@arm.com" <marc.zyngier@arm.com>, "sudeep.holla@arm.com" <sudeep.holla@arm.com>, "will.deacon@arm.com" <will.deacon@arm.com>, "robin.murphy@arm.com" <robin.murphy@arm.com>, "hanjun.guo@linaro.org" <hanjun.guo@linaro.org>, Gabriele Paoloni <gabriele.paoloni@huawei.com>, John Garry <john.garry@huawei.com>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "devel@acpica.org" <devel@acpica.org>, Linuxarm <linuxarm@huawei.com>, "Wangzhou (B)" <wangzhou1@hisilicon.com>, "Guohanjun (Hanjun Guo)" <guohanjun@huawei.com>
List-Id: iommu@lists.linux-foundation.org

On Tue, Jun 06, 2017 at 03:01:36PM +0000, Shameerali Kolothum Thodi wrote:

[...]

> > > +	irq_dom = pci_msi_get_device_domain(to_pci_dev(dev));
> > > +	if (irq_dom) {
> > > +		int	ret;
> > > +		u32	rid;
> > > +
> > > +		rid = pci_msi_domain_get_msi_rid(irq_dom,
> > to_pci_dev(dev));
> > > +		ret = iort_dev_find_its_base(dev, rid, 0, &base);
> > 
> > Well, here we use ITS id 0 which is fine as long as code in IORT uses the same
> > policy for getting the irq_domain (ie we want to reserve the ITS address
> > space that is actually used by the device to send IRQs not a a different one) it
> > is just a heads-up because I find this confusing.
> 
> Ok. Just to make it clear, 0 is the index into the ITS identifier
> list.  I noted that iort_get_device_domain() uses index 0 while
> retrieving the ITS identifier.  May be use the same approach here as
> well? ie, remove the index from function call?
> 
> I am not sure, how we can get the index info  though theoretically It
> is possible for the ITS group node having multiple ITSs.

Actually I think it would make sense to reserve ALL ITS regions a device
may be mapped to instead of just index 0 (ie in your case it is
equivalent); this leaves us some leeway as to choose which ITS the
device will be actually mapped to and this code does not have to care.

Lorenzo

>  
> > > +		if (!ret) {
> > > +			dev_info(dev, "SMMUv3:HW MSI resv addr
> > 0x%pa\n", &base);
> > > +			region = iommu_alloc_resv_region(base, SZ_128K,
> > > +							 prot,
> > IOMMU_RESV_MSI);
> > > +			return region;
> > > +		}
> > > +	}
> > > +
> > > +	return NULL;
> > > +}
> > > +#else
> > > +static struct iommu_resv_region *arm_smmu_acpi_alloc_hw_msi(struct
> > > +device *dev) {
> > > +	return NULL;
> > > +}
> > > +#endif
> > > +
> > >  static int arm_smmu_add_device(struct device *dev)  {
> > >  	int i, ret;
> > > @@ -1903,11 +1936,20 @@ static int arm_smmu_of_xlate(struct device
> > > *dev, struct of_phandle_args *args)  static void
> > arm_smmu_get_resv_regions(struct device *dev,
> > >  				      struct list_head *head)
> > >  {
> > > -	struct iommu_resv_region *region;
> > > +	struct iommu_fwspec *fwspec = dev->iommu_fwspec;
> > > +	struct iommu_resv_region *region = NULL;
> > >  	int prot = IOMMU_WRITE | IOMMU_NOEXEC | IOMMU_MMIO;
> > > +	struct arm_smmu_device *smmu;
> > > +
> > > +	smmu = arm_smmu_get_by_fwnode(fwspec->iommu_fwnode);
> > >
> > > -	region = iommu_alloc_resv_region(MSI_IOVA_BASE,
> > MSI_IOVA_LENGTH,
> > > -					 prot, IOMMU_RESV_SW_MSI);
> > > +	if (smmu && (smmu->options & ARM_SMMU_OPT_RESV_HW_MSI)
> > &&
> > > +		      dev_is_pci(dev))
> > > +		region = arm_smmu_acpi_alloc_hw_msi(dev);
> > 
> > Is it safe to carry on if arm_smmu_acpi_alloc_hw_msi() returns NULL here ?
> 
> It is just that PCIe devices won't be functional on this platforms as the endpoint will 
> be configured with ITS IOVA address. May be I should add some dev_warn() here.
> 
> Thanks,
> Shameer
