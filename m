From: Shameerali Kolothum Thodi <shameerali.kolothum.thodi-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
Subject: RE: [PATCH v6 3/3] iommu/arm-smmu-v3:Enable ACPI based HiSilicon
	erratum 161010801
Date: Thu, 10 Aug 2017 17:52:01 +0000
Message-ID: <5FC3163CFD30C246ABAA99954A238FA8383CC287@FRAEML521-MBX.china.huawei.com>
References: <20170809100715.870516-1-shameerali.kolothum.thodi@huawei.com>
	<20170809100715.870516-4-shameerali.kolothum.thodi@huawei.com>
	<20170810172723.GD9980@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20170810172723.GD9980-5wv7dgnIgG8@public.gmane.org>
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
To: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Cc: Gabriele Paoloni <gabriele.paoloni-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, "marc.zyngier-5wv7dgnIgG8@public.gmane.org" <marc.zyngier-5wv7dgnIgG8@public.gmane.org>, "Guohanjun
	(Hanjun Guo)" <guohanjun-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, Linuxarm <linuxarm-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, "linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "Wangzhou (B)" <wangzhou1-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org>, "sudeep.holla-5wv7dgnIgG8@public.gmane.org" <sudeep.holla-5wv7dgnIgG8@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "devel-E0kO6a4B6psdnm+yROfE0A@public.gmane.org" <devel-E0kO6a4B6psdnm+yROfE0A@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi Will,

> -----Original Message-----
> From: Will Deacon [mailto:will.deacon-5wv7dgnIgG8@public.gmane.org]
> Sent: Thursday, August 10, 2017 6:27 PM
> To: Shameerali Kolothum Thodi
> Cc: lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org; marc.zyngier-5wv7dgnIgG8@public.gmane.org;
> sudeep.holla-5wv7dgnIgG8@public.gmane.org; robin.murphy-5wv7dgnIgG8@public.gmane.org; hanjun.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org;
> Gabriele Paoloni; John Garry; iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org; linux-arm-
> kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org; linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; devel-E0kO6a4B6psdnm+yROfE0A@public.gmane.org;
> Linuxarm; Wangzhou (B); Guohanjun (Hanjun Guo)
> Subject: Re: [PATCH v6 3/3] iommu/arm-smmu-v3:Enable ACPI based
> HiSilicon erratum 161010801
> 
> On Wed, Aug 09, 2017 at 11:07:15AM +0100, Shameer Kolothum wrote:
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
> > Signed-off-by: Shameer Kolothum
> <shameerali.kolothum.thodi-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
> > ---
> >  drivers/iommu/arm-smmu-v3.c | 27 ++++++++++++++++++++++-----
> >  1 file changed, 22 insertions(+), 5 deletions(-)
> 
> Please can you also add a devicetree binding with corresponding
> documentation to enable this workaround on non-ACPI based systems too?
> It should be straightforward if you update the arm_smmu_options table.

As I mentioned before, devicetree was a lower priority and we would definitely
submit patch to support that. Even if we update the arm_smmu_options table
with DT binding, the generic function to retrieve the MSI address regions only
works on ACPI/IORT case now.

Moreover I am on holidays starting tomorrow, and really appreciate if this series
can go through now.

Please let me know.

Thanks,
Shameer
