From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH v2 2/2] iommu/arm-smmu-v3:Enable ACPI based HiSilicon
 erratum 161010801
Date: Tue, 20 Jun 2017 16:51:05 +0100
Message-ID: <20170620155105.GD11351@red-moon>
References: <20170619154500.92336-1-shameerali.kolothum.thodi@huawei.com>
 <20170619154500.92336-3-shameerali.kolothum.thodi@huawei.com>
 <20170620102906.GA26908@red-moon>
 <5FC3163CFD30C246ABAA99954A238FA83838617D@FRAEML521-MBS.china.huawei.com>
 <d6e824b0-17bd-dd41-2d11-0491d8f66759@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <d6e824b0-17bd-dd41-2d11-0491d8f66759@arm.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Robin Murphy <robin.murphy@arm.com>
Cc: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>, "marc.zyngier@arm.com" <marc.zyngier@arm.com>, "sudeep.holla@arm.com" <sudeep.holla@arm.com>, "will.deacon@arm.com" <will.deacon@arm.com>, "hanjun.guo@linaro.org" <hanjun.guo@linaro.org>, Gabriele Paoloni <gabriele.paoloni@huawei.com>, John Garry <john.garry@huawei.com>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "devel@acpica.org" <devel@acpica.org>, Linuxarm <linuxarm@huawei.com>, "Wangzhou (B)" <wangzhou1@hisilicon.com>, "Guohanjun (Hanjun Guo)" <guohanjun@huawei.com>
List-Id: iommu@lists.linux-foundation.org

On Tue, Jun 20, 2017 at 04:16:18PM +0100, Robin Murphy wrote:
> On 20/06/17 15:07, Shameerali Kolothum Thodi wrote:
> > 
> > 
> >> -----Original Message-----
> >> From: Lorenzo Pieralisi [mailto:lorenzo.pieralisi@arm.com]
> >> Sent: Tuesday, June 20, 2017 11:29 AM
> >> To: Shameerali Kolothum Thodi
> >> Cc: marc.zyngier@arm.com; sudeep.holla@arm.com; will.deacon@arm.com;
> >> robin.murphy@arm.com; hanjun.guo@linaro.org; Gabriele Paoloni; John
> >> Garry; iommu@lists.linux-foundation.org; linux-arm-
> >> kernel@lists.infradead.org; linux-acpi@vger.kernel.org; devel@acpica.org;
> >> Linuxarm; Wangzhou (B); Guohanjun (Hanjun Guo)
> >> Subject: Re: [PATCH v2 2/2] iommu/arm-smmu-v3:Enable ACPI based
> >> HiSilicon erratum 161010801
> >>
> >> Hi Shameer,
> >>
> >> On Mon, Jun 19, 2017 at 04:45:00PM +0100, shameer wrote:
> >>> The HiSilicon erratum 161010801 describes the limitation of HiSilicon
> >>> platforms Hip06/Hip07 to support the SMMU mappings for MSI
> >> transactions.
> >>>
> >>> On these platforms GICv3 ITS translator is presented with the deviceID
> >>> by extending the MSI payload data to 64 bits to include the deviceID.
> >>> Hence, the PCIe controller on this platforms has to differentiate the
> >>> MSI payload against other DMA payload and has to modify the MSI
> >> payload.
> >>> This basically makes it difficult for this platforms to have a SMMU
> >>> translation for MSI.
> >>>
> >>> This patch implements a ACPI table based quirk to reserve the hw msi
> >>> regions in the smmu-v3 driver which means these address regions will
> >>> not be translated and will be excluded from iova allocations.
> >>>
> >>> Signed-off-by: shameer <shameerali.kolothum.thodi@huawei.com>
> >>> ---
> >>>  drivers/iommu/arm-smmu-v3.c | 29 ++++++++++++++++++++++++-----
> >>>  1 file changed, 24 insertions(+), 5 deletions(-)
> >>>
> >>> diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-
> >> v3.c
> >>> index abe4b88..f03c63b 100644
> >>> --- a/drivers/iommu/arm-smmu-v3.c
> >>> +++ b/drivers/iommu/arm-smmu-v3.c
> >>> @@ -597,6 +597,7 @@ struct arm_smmu_device {
> >>>  	u32				features;
> >>>
> >>>  #define ARM_SMMU_OPT_SKIP_PREFETCH	(1 << 0)
> >>> +#define ARM_SMMU_OPT_RESV_HW_MSI	(1 << 1)
> >>>  	u32				options;
> >>>
> >>>  	struct arm_smmu_cmdq		cmdq;
> >>> @@ -1904,14 +1905,31 @@ static void arm_smmu_get_resv_regions(struct
> >> device *dev,
> >>>  				      struct list_head *head)
> >>>  {
> >>>  	struct iommu_resv_region *region;
> >>> +	struct arm_smmu_device *smmu;
> >>> +	struct iommu_fwspec *fwspec = dev->iommu_fwspec;
> >>>  	int prot = IOMMU_WRITE | IOMMU_NOEXEC | IOMMU_MMIO;
> >>>
> >>> -	region = iommu_alloc_resv_region(MSI_IOVA_BASE,
> >> MSI_IOVA_LENGTH,
> >>> -					 prot, IOMMU_RESV_SW_MSI);
> >>> -	if (!region)
> >>> -		return;
> >>> +	smmu = arm_smmu_get_by_fwnode(fwspec->iommu_fwnode);
> >>> +
> >>> +	if (smmu && (smmu->options & ARM_SMMU_OPT_RESV_HW_MSI)
> >> &&
> >>> +		      dev_is_pci(dev)) {
> >>
> >> IORT changes are fine to me, I am still no big fan of this supposedly
> >> generic option that is _really_ platform specific (in particular as I
> >> said before the quirk depends on the PCI host bridge but in this
> >> patchset I see no such dependency. In short - the quirk is hooked off
> >> the SMMUv3 model which implicitly implies a PCI host bridge
> >> configuration IIUC). It is Will and Robin decision though, I am not sure
> >> you can make it any tidier (given that on ACPI you may not even have
> >> a PCI host bridge specific _HID to base your check above on).
> > 
> > Thanks Lorenzo. I understand your point. As far as our platform is 
> > concerned, I think It is ok to remove the dev_is_pci() check and make
> > it generic, if that helps.  I don't think it will harm us other than couple of
> >  "HW MSI region resv failed: " logs  for our platform devices.
> 
> I think the answer there is that iort_iommu_its_get_resv_regions()
> really should distinguish between "this device just doesn't have an ITS
> mapping" and "something actually went wrong", such that you don't treat
> the former as an error. That's almost certainly cleaner than e.g. trying
> to check if dev has an associated MSI domain here before calling it.

I would agree, even though this way we would end up reserving the ITS
address regions for all devices mapping to an ITS even though they may
or may not be affected by the quirk (because IIUC that's just a PCI
bridge problem), which is what my point is all about.

It does not seem to be clean-cut, however we slice it.

Thanks,
Lorenzo
