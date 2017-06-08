From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [RFCv2 2/2] iommu/arm-smmu-v3:Enable ACPI based HiSilicon
 erratum 161010801
Date: Thu, 8 Jun 2017 11:15:08 +0100
Message-ID: <20170608101508.GA8644@red-moon>
References: <20170531143213.82100-1-shameerali.kolothum.thodi@huawei.com>
 <20170531143213.82100-3-shameerali.kolothum.thodi@huawei.com>
 <20170606135623.GB20126@red-moon>
 <5FC3163CFD30C246ABAA99954A238FA838362082@FRAEML521-MBX.china.huawei.com>
 <20170608084851.GA8607@red-moon>
 <5FC3163CFD30C246ABAA99954A238FA838363D5D@FRAEML521-MBX.china.huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5FC3163CFD30C246ABAA99954A238FA838363D5D@FRAEML521-MBX.china.huawei.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Cc: "marc.zyngier@arm.com" <marc.zyngier@arm.com>, "sudeep.holla@arm.com" <sudeep.holla@arm.com>, "will.deacon@arm.com" <will.deacon@arm.com>, "robin.murphy@arm.com" <robin.murphy@arm.com>, "hanjun.guo@linaro.org" <hanjun.guo@linaro.org>, Gabriele Paoloni <gabriele.paoloni@huawei.com>, John Garry <john.garry@huawei.com>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "devel@acpica.org" <devel@acpica.org>, Linuxarm <linuxarm@huawei.com>, "Wangzhou (B)" <wangzhou1@hisilicon.com>, "Guohanjun (Hanjun Guo)" <guohanjun@huawei.com>
List-Id: iommu@lists.linux-foundation.org

On Thu, Jun 08, 2017 at 09:09:28AM +0000, Shameerali Kolothum Thodi wrote:
> 
> 
> > -----Original Message-----
> > From: Lorenzo Pieralisi [mailto:lorenzo.pieralisi@arm.com]
> > Sent: Thursday, June 08, 2017 9:49 AM
> > To: Shameerali Kolothum Thodi
> > Cc: marc.zyngier@arm.com; sudeep.holla@arm.com; will.deacon@arm.com;
> > robin.murphy@arm.com; hanjun.guo@linaro.org; Gabriele Paoloni; John
> > Garry; iommu@lists.linux-foundation.org; linux-arm-
> > kernel@lists.infradead.org; linux-acpi@vger.kernel.org; devel@acpica.org;
> > Linuxarm; Wangzhou (B); Guohanjun (Hanjun Guo)
> > Subject: Re: [RFCv2 2/2] iommu/arm-smmu-v3:Enable ACPI based HiSilicon
> > erratum 161010801
> > 
> > On Tue, Jun 06, 2017 at 03:01:36PM +0000, Shameerali Kolothum Thodi
> > wrote:
> > 
> > [...]
> > 
> > > > > +	irq_dom = pci_msi_get_device_domain(to_pci_dev(dev));
> > > > > +	if (irq_dom) {
> > > > > +		int	ret;
> > > > > +		u32	rid;
> > > > > +
> > > > > +		rid = pci_msi_domain_get_msi_rid(irq_dom,
> > > > to_pci_dev(dev));
> > > > > +		ret = iort_dev_find_its_base(dev, rid, 0, &base);
> > > >
> > > > Well, here we use ITS id 0 which is fine as long as code in IORT
> > > > uses the same policy for getting the irq_domain (ie we want to
> > > > reserve the ITS address space that is actually used by the device to
> > > > send IRQs not a a different one) it is just a heads-up because I find this
> > confusing.
> > >
> > > Ok. Just to make it clear, 0 is the index into the ITS identifier
> > > list.  I noted that iort_get_device_domain() uses index 0 while
> > > retrieving the ITS identifier.  May be use the same approach here as
> > > well? ie, remove the index from function call?
> > >
> > > I am not sure, how we can get the index info  though theoretically It
> > > is possible for the ITS group node having multiple ITSs.
> > 
> > Actually I think it would make sense to reserve ALL ITS regions a device may
> > be mapped to instead of just index 0 (ie in your case it is equivalent); this
> > leaves us some leeway as to choose which ITS the device will be actually
> > mapped to and this code does not have to care.
> 
> Ok. That make sense. Just a quick one, is it ok to add another helper function in
> iort code to retrieve the its->its_count then? 

While at it, given that the pci API code to retrieve domain and rid falls
back to IORT anyway, I would add the whole reservation to IORT (mind,
it depends on IOMMU_API) as one function instead of fiddling about with
indexes.

Side note: why Hilisicon dts upstream (eg hip07.dtsi) report ITS size
as 256K ? I was just checking whether the ITS reg map size is system
dependent and I bumped into them, I suspect there may be some dts
patching needed here.

Lorenzo
