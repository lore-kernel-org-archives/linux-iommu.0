From: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Subject: RE: [PATCH 2/2] iommu/arm-smmu-v3:Enable ACPI based HiSilicon
 erratum 161010801
Date: Fri, 16 Jun 2017 11:31:06 +0000
Message-ID: <5FC3163CFD30C246ABAA99954A238FA83836B2DC@FRAEML521-MBX.china.huawei.com>
References: <20170613114829.188036-1-shameerali.kolothum.thodi@huawei.com>
 <20170613114829.188036-3-shameerali.kolothum.thodi@huawei.com>
 <20170613131317.GB2868@red-moon>
 <5FC3163CFD30C246ABAA99954A238FA838368BC6@FRAEML521-MBX.china.huawei.com>
 <5FC3163CFD30C246ABAA99954A238FA83836B212@FRAEML521-MBX.china.huawei.com>
 <20170616111729.GB22323@red-moon>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20170616111729.GB22323@red-moon>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: "marc.zyngier@arm.com" <marc.zyngier@arm.com>, "will.deacon@arm.com" <will.deacon@arm.com>, Linuxarm <linuxarm@huawei.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "hanjun.guo@linaro.org" <hanjun.guo@linaro.org>, "sudeep.holla@arm.com" <sudeep.holla@arm.com>, "robin.murphy@arm.com" <robin.murphy@arm.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "devel@acpica.org" <devel@acpica.org>
List-Id: iommu@lists.linux-foundation.org



> -----Original Message-----
> From: Lorenzo Pieralisi [mailto:lorenzo.pieralisi@arm.com]
> Sent: Friday, June 16, 2017 12:17 PM
> To: Shameerali Kolothum Thodi
> Cc: marc.zyngier@arm.com; will.deacon@arm.com; Linuxarm; linux-
> acpi@vger.kernel.org; iommu@lists.linux-foundation.org;
> hanjun.guo@linaro.org; sudeep.holla@arm.com; robin.murphy@arm.com;
> linux-arm-kernel@lists.infradead.org; devel@acpica.org
> Subject: Re: [PATCH 2/2] iommu/arm-smmu-v3:Enable ACPI based HiSilicon
> erratum 161010801
> 
> On Fri, Jun 16, 2017 at 09:43:52AM +0000, Shameerali Kolothum Thodi wrote:
> > Hi Lorenzo,
> >
> > > -----Original Message-----
> > > From: linuxarm-bounces@huawei.com [mailto:linuxarm-
> > > bounces@huawei.com] On Behalf Of Shameerali Kolothum Thodi
> > > Sent: Tuesday, June 13, 2017 3:53 PM
> > > To: Lorenzo Pieralisi
> > > Cc: marc.zyngier@arm.com; will.deacon@arm.com; Linuxarm; linux-
> > > acpi@vger.kernel.org; iommu@lists.linux-foundation.org;
> > > hanjun.guo@linaro.org; sudeep.holla@arm.com;
> robin.murphy@arm.com;
> > > linux-arm-kernel@lists.infradead.org; devel@acpica.org
> > > Subject: RE: [PATCH 2/2] iommu/arm-smmu-v3:Enable ACPI based
> HiSilicon
> > > erratum 161010801
> >
> > [...]
> >  > > > ---
> > > > >  drivers/iommu/arm-smmu-v3.c | 27 ++++++++++++++++++++++----
> -
> > > > >  1 file changed, 22 insertions(+), 5 deletions(-)
> > > > >
> > > > > diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-
> smmu-
> > > > v3.c
> > > > > index abe4b88..2636c85 100644
> > > > > --- a/drivers/iommu/arm-smmu-v3.c
> > > > > +++ b/drivers/iommu/arm-smmu-v3.c
> > > > > @@ -597,6 +597,7 @@ struct arm_smmu_device {
> > > > >  	u32				features;
> > > > >
> > > > >  #define ARM_SMMU_OPT_SKIP_PREFETCH	(1 << 0)
> > > > > +#define ARM_SMMU_OPT_RESV_HW_MSI	(1 << 1)
> > > > >  	u32				options;
> > > > >
> > > > >  	struct arm_smmu_cmdq		cmdq;
> > > > > @@ -1904,14 +1905,29 @@ static void
> > > arm_smmu_get_resv_regions(struct
> > > > device *dev,
> > > > >  				      struct list_head *head)
> > > > >  {
> > > > >  	struct iommu_resv_region *region;
> > > > > +	struct arm_smmu_device *smmu;
> > > > > +	struct iommu_fwspec *fwspec = dev->iommu_fwspec;
> > > > >  	int prot = IOMMU_WRITE | IOMMU_NOEXEC |
> IOMMU_MMIO;
> > > > >
> > > > > -	region = iommu_alloc_resv_region(MSI_IOVA_BASE,
> > > > MSI_IOVA_LENGTH,
> > > > > -					 prot,
> IOMMU_RESV_SW_MSI);
> > > > > -	if (!region)
> > > > > -		return;
> > > > > +	smmu = arm_smmu_get_by_fwnode(fwspec-
> >iommu_fwnode);
> > > > >
> > > > > -	list_add_tail(&region->list, head);
> > > > > +	if (smmu && (smmu->options &
> ARM_SMMU_OPT_RESV_HW_MSI)
> > > > &&
> > > > > +		      dev_is_pci(dev)) {
> > > > > +		int ret;
> > > > > +
> > > > > +		ret = iort_iommu_its_get_resv_regions(dev, head);
> > > >
> > > > This should be made fwnode dependent, it makes precious little sense
> to
> > > call
> > > > IORT to reserve regions on a DT based platforms (I know the
> > > > ARM_SMMU_OPT_RESV_HW_MSI option is only selected in ACPI (?)
> but
> > > > comment applies regardless - have you prototyped a DT version too ?).
> > >
> > > Ok. I will add a check here.
> >
> > This is what I have in mind. Please take a look and let me know. I will send
> out
> > a v2 of this series soon.
> > ....
> > if (smmu && (smmu->options & ARM_SMMU_OPT_RESV_HW_MSI) &&
> > 			dev_is_pci(dev)) {
> > 	int ret = -EINVAL;
> >
> > 	if (!is_of_node(smmu->dev->fwnode))
> > 		ret = iort_iommu_its_get_resv_regions(dev, head);
> >
> > 	if (ret) {
> > 		dev_warn(dev, "HW MSI region resv failed: %d\n", ret);
> > 		return;
> > 	}
> > } else {
> 
> The fwnode handling is fine, I do not like much the:
> 
> dev_is_pci()
> 
> check because it relies on implicit knowledge of the platform and
> the quirks you need (ie you know that it is _just_ a PCI RC quirk
> implicitly), the logic behind reserving the regions is a bit
> convoluted and not easy to understand at all.
> 
> Let me try to rephrase it: you know, through an SMMU model number,
> that your PCI RC handles MSI in a specific way, but by reading the
> code above this is not clear at all, at least to me. This is a PCI
> RC quirk but it does not depend on any PCI RC specific firmware binding
> whatsoever, that's what is a bit hard to understand.

Right.  I had a thought of limiting the iort_iommu_its_get_resv_regions
to pci devices only. Just like the way iommu_dma_get_resv_regions()
does now. But not sure there will ever be a platform which requires this
for non-pci devices as well.

Thanks,
Shameer
