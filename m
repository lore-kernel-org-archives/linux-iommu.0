From: Shameerali Kolothum Thodi <shameerali.kolothum.thodi-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
Subject: RE: [RFCv2 2/2] iommu/arm-smmu-v3:Enable ACPI based HiSilicon
	erratum 161010801
Date: Thu, 8 Jun 2017 09:17:56 +0000
Message-ID: <5FC3163CFD30C246ABAA99954A238FA838363D83@FRAEML521-MBX.china.huawei.com>
References: <20170531143213.82100-1-shameerali.kolothum.thodi@huawei.com>
	<20170531143213.82100-3-shameerali.kolothum.thodi@huawei.com>
	<20170606135623.GB20126@red-moon>
	<5FC3163CFD30C246ABAA99954A238FA838362082@FRAEML521-MBX.china.huawei.com>
	<20170607171618.GC7937@red-moon>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20170607171618.GC7937@red-moon>
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
To: Lorenzo Pieralisi <lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org>
Cc: "Guohanjun (Hanjun Guo)" <guohanjun-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, Gabriele Paoloni <gabriele.paoloni-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, "marc.zyngier-5wv7dgnIgG8@public.gmane.org" <marc.zyngier-5wv7dgnIgG8@public.gmane.org>, "will.deacon-5wv7dgnIgG8@public.gmane.org" <will.deacon-5wv7dgnIgG8@public.gmane.org>, Linuxarm <linuxarm-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, "linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "Wangzhou (B)" <wangzhou1-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org>, "sudeep.holla-5wv7dgnIgG8@public.gmane.org" <sudeep.holla-5wv7dgnIgG8@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "devel-E0kO6a4B6psdnm+yROfE0A@public.gmane.org" <devel-E0kO6a4B6psdnm+yROfE0A@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org



> -----Original Message-----
> From: Lorenzo Pieralisi [mailto:lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org]
> Sent: Wednesday, June 07, 2017 6:16 PM
> To: Shameerali Kolothum Thodi
> Cc: marc.zyngier-5wv7dgnIgG8@public.gmane.org; sudeep.holla-5wv7dgnIgG8@public.gmane.org; will.deacon-5wv7dgnIgG8@public.gmane.org;
> robin.murphy-5wv7dgnIgG8@public.gmane.org; hanjun.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org; Gabriele Paoloni; John
> Garry; iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org; linux-arm-
> kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org; linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; devel-E0kO6a4B6psdnm+yROfE0A@public.gmane.org;
> Linuxarm; Wangzhou (B); Guohanjun (Hanjun Guo)
> Subject: Re: [RFCv2 2/2] iommu/arm-smmu-v3:Enable ACPI based HiSilicon
> erratum 161010801
> 
> On Tue, Jun 06, 2017 at 03:01:36PM +0000, Shameerali Kolothum Thodi
> wrote:
> > Hi Lorenzo,
> >
> > > -----Original Message-----
> > > From: Lorenzo Pieralisi [mailto:lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org]
> > > Sent: Tuesday, June 06, 2017 2:56 PM
> > > To: Shameerali Kolothum Thodi
> > > Cc: marc.zyngier-5wv7dgnIgG8@public.gmane.org; sudeep.holla-5wv7dgnIgG8@public.gmane.org;
> will.deacon-5wv7dgnIgG8@public.gmane.org;
> > > robin.murphy-5wv7dgnIgG8@public.gmane.org; hanjun.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org; Gabriele Paoloni; John
> > > Garry; iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org; linux-arm-
> > > kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org; linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org;
> devel-E0kO6a4B6psdnm+yROfE0A@public.gmane.org;
> > > Linuxarm; Wangzhou (B); Guohanjun (Hanjun Guo)
> > > Subject: Re: [RFCv2 2/2] iommu/arm-smmu-v3:Enable ACPI based
> HiSilicon
> > > erratum 161010801
> > >
> > > On Wed, May 31, 2017 at 03:32:13PM +0100, shameer wrote:
> > > > The HiSilicon erratum 161010801 describes the limitation of HiSilicon
> > > > platforms Hip06/Hip07 to support the SMMU mappings for MSI
> > > transactions.
> > > >
> > > > On these platforms GICv3 ITS translator is presented with the deviceID
> > > > by extending the MSI payload data to 64 bits to include the deviceID.
> > > > Hence, the PCIe controller on this platforms has to differentiate the
> > > > MSI payload against other DMA payload and has to modify the MSI
> > > payload.
> > > > This basically makes it difficult for this platforms to have a SMMU
> > > > translation for MSI.
> > > >
> > > > This patch implements a ACPI table based quirk to reserve the hw msi
> > > > regions in the smmu-v3 driver which means these address regions will
> > > > not be translated and will be excluded from iova allocations.
> > > >
> > > > The HW ITS address region associated with the dev is retrieved using a
> > > > new helper function added in the IORT code.
> > >
> > > Remove or rephrase last paragraph, it reads as if you are adding an IORT
> > > helper function in this patch but you actually aren't.
> >
> > Thanks for going through this patch series. I will remove this in next
> version.
> >
> > > > Signed-off-by: shameer <shameerali.kolothum.thodi-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
> > > > ---
> > > >  drivers/iommu/arm-smmu-v3.c | 49
> > > > ++++++++++++++++++++++++++++++++++++++++++---
> > > >  1 file changed, 46 insertions(+), 3 deletions(-)
> > > >
> > > > diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-
> smmu-
> > > v3.c
> > > > index abe4b88..3767526 100644
> > > > --- a/drivers/iommu/arm-smmu-v3.c
> > > > +++ b/drivers/iommu/arm-smmu-v3.c
> > > > @@ -597,6 +597,7 @@ struct arm_smmu_device {
> > > >  	u32				features;
> > > >
> > > >  #define ARM_SMMU_OPT_SKIP_PREFETCH	(1 << 0)
> > > > +#define ARM_SMMU_OPT_RESV_HW_MSI	(1 << 1)
> > > >  	u32				options;
> > > >
> > > >  	struct arm_smmu_cmdq		cmdq;
> > > > @@ -1755,6 +1756,38 @@ static bool arm_smmu_sid_in_range(struct
> > > > arm_smmu_device *smmu, u32 sid)
> > > >
> > > >  static struct iommu_ops arm_smmu_ops;
> > > >
> > > > +#ifdef CONFIG_ACPI
> > > > +static struct iommu_resv_region
> *arm_smmu_acpi_alloc_hw_msi(struct
> > > > +device *dev) {
> > > > +	struct iommu_resv_region *region;
> > > > +	struct	irq_domain *irq_dom;
> > > > +	int prot = IOMMU_WRITE | IOMMU_NOEXEC | IOMMU_MMIO;
> > > > +	u64	base;
> > >
> > > phys_addr_t
> >
> > Ok.
> >
> > > > +	irq_dom = pci_msi_get_device_domain(to_pci_dev(dev));
> > > > +	if (irq_dom) {
> > > > +		int	ret;
> > > > +		u32	rid;
> > > > +
> > > > +		rid = pci_msi_domain_get_msi_rid(irq_dom,
> > > to_pci_dev(dev));
> > > > +		ret = iort_dev_find_its_base(dev, rid, 0, &base);
> > >
> > > Well, here we use ITS id 0 which is fine as long as code in IORT uses the
> same
> > > policy for getting the irq_domain (ie we want to reserve the ITS address
> > > space that is actually used by the device to send IRQs not a a different
> one) it
> > > is just a heads-up because I find this confusing.
> >
> > Ok. Just to make it clear, 0 is the index into the ITS identifier list.
> > I noted that iort_get_device_domain() uses index 0 while retrieving the ITS
> identifier.
> > May be use the same approach here as well? ie, remove the index from
> function call?
> >
> > I am not sure, how we can get the index info  though theoretically It is
> possible for
> > the ITS group node having multiple ITSs.
> 
> Yes, it would be ideal to avoid the look-up through the ITS index and
> just reuse the ITS node associated with the MSI domain because I do not
> want this quirk to force the ITS domain allocation policy (what I mean
> I do not want to be tied to index 0 if for any reason we change
> the allocation in IORT for normal ITS<->device mapping).
> 
> I will have a further look to see if we can improve the code to
> this extent.
> 
> > > > +		if (!ret) {
> > > > +			dev_info(dev, "SMMUv3:HW MSI resv addr
> > > 0x%pa\n", &base);
> > > > +			region = iommu_alloc_resv_region(base, SZ_128K,
> > > > +							 prot,
> > > IOMMU_RESV_MSI);
> > > > +			return region;
> > > > +		}
> > > > +	}
> > > > +
> > > > +	return NULL;
> > > > +}
> > > > +#else
> > > > +static struct iommu_resv_region
> *arm_smmu_acpi_alloc_hw_msi(struct
> > > > +device *dev) {
> > > > +	return NULL;
> > > > +}
> > > > +#endif
> > > > +
> > > >  static int arm_smmu_add_device(struct device *dev)  {
> > > >  	int i, ret;
> > > > @@ -1903,11 +1936,20 @@ static int arm_smmu_of_xlate(struct device
> > > > *dev, struct of_phandle_args *args)  static void
> > > arm_smmu_get_resv_regions(struct device *dev,
> > > >  				      struct list_head *head)
> > > >  {
> > > > -	struct iommu_resv_region *region;
> > > > +	struct iommu_fwspec *fwspec = dev->iommu_fwspec;
> > > > +	struct iommu_resv_region *region = NULL;
> > > >  	int prot = IOMMU_WRITE | IOMMU_NOEXEC | IOMMU_MMIO;
> > > > +	struct arm_smmu_device *smmu;
> > > > +
> > > > +	smmu = arm_smmu_get_by_fwnode(fwspec->iommu_fwnode);
> > > >
> > > > -	region = iommu_alloc_resv_region(MSI_IOVA_BASE,
> > > MSI_IOVA_LENGTH,
> > > > -					 prot, IOMMU_RESV_SW_MSI);
> > > > +	if (smmu && (smmu->options & ARM_SMMU_OPT_RESV_HW_MSI)
> > > &&
> > > > +		      dev_is_pci(dev))
> > > > +		region = arm_smmu_acpi_alloc_hw_msi(dev);
> > >
> > > Is it safe to carry on if arm_smmu_acpi_alloc_hw_msi() returns NULL
> here ?
> >
> > It is just that PCIe devices won't be functional on this platforms as the
> endpoint will
> > be configured with ITS IOVA address. May be I should add some
> dev_warn() here.
> 
> Well yes and also I am not sure that if arm_smmu_acpi_alloc_hw_msi()
> fails you should allocate the SW_MSI region I am not sure I understand
> the logic, so you should add a warning and just return on failure right ?

True. There is no point in reserving the SW_MSI on these platforms. I think
it's better to return.

Shameer
