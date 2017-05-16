From: Shameerali Kolothum Thodi <shameerali.kolothum.thodi-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
Subject: RE: [RFC v1 6/7] iommu/arm-smmu-v3: Rearrange msi resv alloc
 functions
Date: Tue, 16 May 2017 13:54:23 +0000
Message-ID: <5FC3163CFD30C246ABAA99954A238FA838350A37@FRAEML521-MBX.china.huawei.com>
References: <20170513094731.3676-1-shameerali.kolothum.thodi@huawei.com>
 <20170513094731.3676-7-shameerali.kolothum.thodi@huawei.com>
 <d2d90929-6e79-70a3-5c82-a25e67931b4a@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <d2d90929-6e79-70a3-5c82-a25e67931b4a-5wv7dgnIgG8@public.gmane.org>
Content-Language: en-US
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>, "will.deacon-5wv7dgnIgG8@public.gmane.org" <will.deacon-5wv7dgnIgG8@public.gmane.org>, "mark.rutland-5wv7dgnIgG8@public.gmane.org" <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org" <lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org>, "hanjun.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <hanjun.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Gabriele Paoloni <gabriele.paoloni-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, John Garry <john.garry-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, Linuxarm <linuxarm-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, "linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "Wangzhou (B)" <wangzhou1-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org>, "Guohanjun (Hanjun Guo)" <guohanjun-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "devel-E0kO6a4B6psdnm+yROfE0A@public.gmane.org" <devel-E0kO6a4B6psdnm+yROfE0A@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org



> -----Original Message-----
> From: Robin Murphy [mailto:robin.murphy-5wv7dgnIgG8@public.gmane.org]
> Sent: Tuesday, May 16, 2017 2:28 PM
> To: Shameerali Kolothum Thodi; will.deacon-5wv7dgnIgG8@public.gmane.org;
> mark.rutland-5wv7dgnIgG8@public.gmane.org; lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org; hanjun.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
> Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; Gabriele Paoloni; John Garry; Linuxarm;
> linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org; Wangzhou
> (B); Guohanjun (Hanjun Guo); linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org;
> devel-E0kO6a4B6psdnm+yROfE0A@public.gmane.org
> Subject: Re: [RFC v1 6/7] iommu/arm-smmu-v3: Rearrange msi resv alloc
> functions
> 
> On 13/05/17 10:47, shameer wrote:
> > This moves the SW MSI reserve region allocation to probe fn.
> 
> Why?

Sure, I will modify the commit message to mention about the next patch
where we will add the quirk to modify the default SW MSI region with a HW MSI
region on Hip06/07 platforms.

> > Signed-off-by: shameer <shameerali.kolothum.thodi-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
> > ---
> >  drivers/iommu/arm-smmu-v3.c | 36 +++++++++++++++++++++++++++---
> ------
> >  1 file changed, 27 insertions(+), 9 deletions(-)
> >
> > diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-
> v3.c
> > index 770cc9e..e7a8a50 100644
> > --- a/drivers/iommu/arm-smmu-v3.c
> > +++ b/drivers/iommu/arm-smmu-v3.c
> > @@ -619,6 +619,9 @@ struct arm_smmu_device {
> >
> >  	/* IOMMU core code handle */
> >  	struct iommu_device		iommu;
> > +
> > +	/* MSI Reserve region */
> > +	struct iommu_resv_region        *msi_region;
> >  };
> >
> >  /* SMMU private data for each master */
> > @@ -1960,15 +1963,12 @@ static int arm_smmu_of_xlate(struct device
> *dev, struct of_phandle_args *args)
> >  static void arm_smmu_get_resv_regions(struct device *dev,
> >  				      struct list_head *head)
> >  {
> > -	struct iommu_resv_region *region;
> > -	int prot = IOMMU_WRITE | IOMMU_NOEXEC | IOMMU_MMIO;
> > -
> > -	region = iommu_alloc_resv_region(MSI_IOVA_BASE,
> MSI_IOVA_LENGTH,
> > -					 prot, IOMMU_RESV_SW_MSI);
> > -	if (!region)
> > -		return;
> > +	struct iommu_domain *domain =
> iommu_get_domain_for_dev(dev);
> > +	struct arm_smmu_domain *smmu_domain =
> to_smmu_domain(domain);
> > +	struct arm_smmu_device *smmu = smmu_domain->smmu;
> 
> There's never any need for the domain dance if you don't need the
> domain, just pull the smmu out of the device's iommu_fwspec.

Ok. That makes sense. Thanks.

> > -	list_add_tail(&region->list, head);
> > +	if (smmu && smmu->msi_region)
> > +		list_add_tail(&smmu->msi_region->list, head);
> 
> Have you considered what happens for the second and subsequent domains
> allocated on this SMMU? I can't see that ending well.

Yes, I probably missed this part. I will recheck this.

Thanks,
Shameer
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
