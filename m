From: Shameerali Kolothum Thodi <shameerali.kolothum.thodi-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
Subject: RE: [PATCH 2/2] iommu/arm-smmu-v3:Enable ACPI based HiSilicon
	erratum 161010801
Date: Fri, 16 Jun 2017 09:43:52 +0000
Message-ID: <5FC3163CFD30C246ABAA99954A238FA83836B212@FRAEML521-MBX.china.huawei.com>
References: <20170613114829.188036-1-shameerali.kolothum.thodi@huawei.com>
	<20170613114829.188036-3-shameerali.kolothum.thodi@huawei.com>
	<20170613131317.GB2868@red-moon>
	<5FC3163CFD30C246ABAA99954A238FA838368BC6@FRAEML521-MBX.china.huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <5FC3163CFD30C246ABAA99954A238FA838368BC6-WFPaWmAhWqtUuCJht5byYAK1hpo4iccwjNknBlVQO8k@public.gmane.org>
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
To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, Lorenzo Pieralisi <lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org>
Cc: "marc.zyngier-5wv7dgnIgG8@public.gmane.org" <marc.zyngier-5wv7dgnIgG8@public.gmane.org>, "will.deacon-5wv7dgnIgG8@public.gmane.org" <will.deacon-5wv7dgnIgG8@public.gmane.org>, Linuxarm <linuxarm-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, "linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "sudeep.holla-5wv7dgnIgG8@public.gmane.org" <sudeep.holla-5wv7dgnIgG8@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "devel-E0kO6a4B6psdnm+yROfE0A@public.gmane.org" <devel-E0kO6a4B6psdnm+yROfE0A@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi Lorenzo,

> -----Original Message-----
> From: linuxarm-bounces-hv44wF8Li93QT0dZR+AlfA@public.gmane.org [mailto:linuxarm-
> bounces-hv44wF8Li93QT0dZR+AlfA@public.gmane.org] On Behalf Of Shameerali Kolothum Thodi
> Sent: Tuesday, June 13, 2017 3:53 PM
> To: Lorenzo Pieralisi
> Cc: marc.zyngier-5wv7dgnIgG8@public.gmane.org; will.deacon-5wv7dgnIgG8@public.gmane.org; Linuxarm; linux-
> acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org;
> hanjun.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org; sudeep.holla-5wv7dgnIgG8@public.gmane.org; robin.murphy-5wv7dgnIgG8@public.gmane.org;
> linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org; devel-E0kO6a4B6psdnm+yROfE0A@public.gmane.org
> Subject: RE: [PATCH 2/2] iommu/arm-smmu-v3:Enable ACPI based HiSilicon
> erratum 161010801

[...]
 > > > ---
> > >  drivers/iommu/arm-smmu-v3.c | 27 ++++++++++++++++++++++-----
> > >  1 file changed, 22 insertions(+), 5 deletions(-)
> > >
> > > diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-
> > v3.c
> > > index abe4b88..2636c85 100644
> > > --- a/drivers/iommu/arm-smmu-v3.c
> > > +++ b/drivers/iommu/arm-smmu-v3.c
> > > @@ -597,6 +597,7 @@ struct arm_smmu_device {
> > >  	u32				features;
> > >
> > >  #define ARM_SMMU_OPT_SKIP_PREFETCH	(1 << 0)
> > > +#define ARM_SMMU_OPT_RESV_HW_MSI	(1 << 1)
> > >  	u32				options;
> > >
> > >  	struct arm_smmu_cmdq		cmdq;
> > > @@ -1904,14 +1905,29 @@ static void
> arm_smmu_get_resv_regions(struct
> > device *dev,
> > >  				      struct list_head *head)
> > >  {
> > >  	struct iommu_resv_region *region;
> > > +	struct arm_smmu_device *smmu;
> > > +	struct iommu_fwspec *fwspec = dev->iommu_fwspec;
> > >  	int prot = IOMMU_WRITE | IOMMU_NOEXEC | IOMMU_MMIO;
> > >
> > > -	region = iommu_alloc_resv_region(MSI_IOVA_BASE,
> > MSI_IOVA_LENGTH,
> > > -					 prot, IOMMU_RESV_SW_MSI);
> > > -	if (!region)
> > > -		return;
> > > +	smmu = arm_smmu_get_by_fwnode(fwspec->iommu_fwnode);
> > >
> > > -	list_add_tail(&region->list, head);
> > > +	if (smmu && (smmu->options & ARM_SMMU_OPT_RESV_HW_MSI)
> > &&
> > > +		      dev_is_pci(dev)) {
> > > +		int ret;
> > > +
> > > +		ret = iort_iommu_its_get_resv_regions(dev, head);
> >
> > This should be made fwnode dependent, it makes precious little sense to
> call
> > IORT to reserve regions on a DT based platforms (I know the
> > ARM_SMMU_OPT_RESV_HW_MSI option is only selected in ACPI (?) but
> > comment applies regardless - have you prototyped a DT version too ?).
> 
> Ok. I will add a check here. 

This is what I have in mind. Please take a look and let me know. I will send out
a v2 of this series soon.
....
if (smmu && (smmu->options & ARM_SMMU_OPT_RESV_HW_MSI) &&
			dev_is_pci(dev)) {
	int ret = -EINVAL;

	if (!is_of_node(smmu->dev->fwnode))
		ret = iort_iommu_its_get_resv_regions(dev, head);

	if (ret) {
		dev_warn(dev, "HW MSI region resv failed: %d\n", ret);
		return;
	}
} else {
---
Many thanks,
Shameer
