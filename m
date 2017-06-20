From: Shameerali Kolothum Thodi <shameerali.kolothum.thodi-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
Subject: RE: [PATCH v2 2/2] iommu/arm-smmu-v3:Enable ACPI based HiSilicon
	erratum 161010801
Date: Tue, 20 Jun 2017 13:11:28 +0000
Message-ID: <5FC3163CFD30C246ABAA99954A238FA838385EC5@FRAEML521-MBS.china.huawei.com>
References: <20170619154500.92336-1-shameerali.kolothum.thodi@huawei.com>
	<20170619154500.92336-3-shameerali.kolothum.thodi@huawei.com>
	<311de3aa-aec9-f403-d9a8-48b3e3de54c3@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <311de3aa-aec9-f403-d9a8-48b3e3de54c3-5wv7dgnIgG8@public.gmane.org>
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
To: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>, "lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org" <lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org>, "marc.zyngier-5wv7dgnIgG8@public.gmane.org" <marc.zyngier-5wv7dgnIgG8@public.gmane.org>, "sudeep.holla-5wv7dgnIgG8@public.gmane.org" <sudeep.holla-5wv7dgnIgG8@public.gmane.org>, "will.deacon-5wv7dgnIgG8@public.gmane.org" <will.deacon-5wv7dgnIgG8@public.gmane.org>, "hanjun.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <hanjun.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Gabriele Paoloni <gabriele.paoloni-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, Linuxarm <linuxarm-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, "linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "Wangzhou (B)" <wangzhou1-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org>, "Guohanjun
	(Hanjun Guo)" <guohanjun-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "devel-E0kO6a4B6psdnm+yROfE0A@public.gmane.org" <devel-E0kO6a4B6psdnm+yROfE0A@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org



> -----Original Message-----
> From: Robin Murphy [mailto:robin.murphy-5wv7dgnIgG8@public.gmane.org]
> Sent: Monday, June 19, 2017 6:42 PM
> To: Shameerali Kolothum Thodi; lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org;
> marc.zyngier-5wv7dgnIgG8@public.gmane.org; sudeep.holla-5wv7dgnIgG8@public.gmane.org; will.deacon-5wv7dgnIgG8@public.gmane.org;
> hanjun.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
> Cc: Gabriele Paoloni; John Garry; iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org; linux-
> arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org; linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org;
> devel-E0kO6a4B6psdnm+yROfE0A@public.gmane.org; Linuxarm; Wangzhou (B); Guohanjun (Hanjun Guo)
> Subject: Re: [PATCH v2 2/2] iommu/arm-smmu-v3:Enable ACPI based
> HiSilicon erratum 161010801
> 
> On 19/06/17 16:45, shameer wrote:
> > The HiSilicon erratum 161010801 describes the limitation of HiSilicon
> > platforms Hip06/Hip07 to support the SMMU mappings for MSI
> transactions.
> >
> > On these platforms GICv3 ITS translator is presented with the deviceID
> > by extending the MSI payload data to 64 bits to include the deviceID.
> > Hence, the PCIe controller on this platforms has to differentiate the
> > MSI payload against other DMA payload and has to modify the MSI
> payload.
> > This basically makes it difficult for this platforms to have a SMMU
> > translation for MSI.
> >
> > This patch implements a ACPI table based quirk to reserve the hw msi
> > regions in the smmu-v3 driver which means these address regions will
> > not be translated and will be excluded from iova allocations.
> >
> > Signed-off-by: shameer <shameerali.kolothum.thodi-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
> > ---
> >  drivers/iommu/arm-smmu-v3.c | 29 ++++++++++++++++++++++++-----
> >  1 file changed, 24 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-
> v3.c
> > index abe4b88..f03c63b 100644
> > --- a/drivers/iommu/arm-smmu-v3.c
> > +++ b/drivers/iommu/arm-smmu-v3.c
> > @@ -597,6 +597,7 @@ struct arm_smmu_device {
> >  	u32				features;
> >
> >  #define ARM_SMMU_OPT_SKIP_PREFETCH	(1 << 0)
> > +#define ARM_SMMU_OPT_RESV_HW_MSI	(1 << 1)
> >  	u32				options;
> >
> >  	struct arm_smmu_cmdq		cmdq;
> > @@ -1904,14 +1905,31 @@ static void arm_smmu_get_resv_regions(struct
> device *dev,
> >  				      struct list_head *head)
> >  {
> >  	struct iommu_resv_region *region;
> > +	struct arm_smmu_device *smmu;
> > +	struct iommu_fwspec *fwspec = dev->iommu_fwspec;
> >  	int prot = IOMMU_WRITE | IOMMU_NOEXEC | IOMMU_MMIO;
> >
> > -	region = iommu_alloc_resv_region(MSI_IOVA_BASE,
> MSI_IOVA_LENGTH,
> > -					 prot, IOMMU_RESV_SW_MSI);
> > -	if (!region)
> > -		return;
> > +	smmu = arm_smmu_get_by_fwnode(fwspec->iommu_fwnode);
> > +
> > +	if (smmu && (smmu->options & ARM_SMMU_OPT_RESV_HW_MSI)
> &&
> 
> AFAICS, iommu_get_resv_regions is only ever called on devices which are
> at least already part of an iommu_group, so smmu should never
> legitimately be NULL. I'd say if you really want to be robust against
> flagrant API misuse, at least WARN_ON and bail out immediately.

Ok.  I will address this in next revision.

Thanks,
Shameer
