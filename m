From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v12 0/3] iommu/smmu-v3: Workaround for hisilicon
 161010801 erratum(reserve HW MSI)
Date: Mon, 29 Jan 2018 16:21:10 +0000
Message-ID: <20180129162109.GA25266@arm.com>
References: <20171214160957.13716-1-shameerali.kolothum.thodi@huawei.com>
 <20180129153939.GC24972@arm.com>
 <5FC3163CFD30C246ABAA99954A238FA83863FC88@FRAEML521-MBX.china.huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <5FC3163CFD30C246ABAA99954A238FA83863FC88-WFPaWmAhWqtUuCJht5byYAK1hpo4iccwjNknBlVQO8k@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
Cc: "lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org" <lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org>, "robin.murphy-5wv7dgnIgG8@public.gmane.org" <robin.murphy-5wv7dgnIgG8@public.gmane.org>, "marc.zyngier-5wv7dgnIgG8@public.gmane.org" <marc.zyngier-5wv7dgnIgG8@public.gmane.org>, "joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org" <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, John Garry <john.garry-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, "xuwei (O)" <xuwei5-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, "Guohanjun (Hanjun Guo)" <guohanjun-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linuxarm <linuxarm-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Mon, Jan 29, 2018 at 04:16:33PM +0000, Shameerali Kolothum Thodi wrote:
> > -----Original Message-----
> > From: Will Deacon [mailto:will.deacon-5wv7dgnIgG8@public.gmane.org]
> > Sent: Monday, January 29, 2018 3:40 PM
> > To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
> > Cc: lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org; robin.murphy-5wv7dgnIgG8@public.gmane.org;
> > marc.zyngier-5wv7dgnIgG8@public.gmane.org; joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org; John Garry
> > <john.garry-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>; xuwei (O) <xuwei5-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>; Guohanjun
> > (Hanjun Guo) <guohanjun-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>; iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org;
> > linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org; linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org;
> > devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; Linuxarm <linuxarm-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
> > Subject: Re: [PATCH v12 0/3] iommu/smmu-v3: Workaround for hisilicon
> > 161010801 erratum(reserve HW MSI)
> > On Thu, Dec 14, 2017 at 04:09:54PM +0000, Shameer Kolothum wrote:
> > > On certain HiSilicon platforms (hip06/hip07) the GIC ITS and PCIe RC
> > > deviates from the standard implementation and this breaks PCIe MSI
> > > functionality when SMMU is enabled.
> > >
> > > The HiSilicon erratum 161010801 describes this limitation of certain
> > > HiSilicon platforms to support the SMMU mappings for MSI transactions.
> > > On these platforms GICv3 ITS translator is presented with the deviceID
> > > by extending the MSI payload data to 64 bits to include the deviceID.
> > > Hence, the PCIe controller on this platforms has to differentiate the
> > > MSI payload against other DMA payload and has to modify the MSI payload.
> > > This basically makes it difficult for this platforms to have a SMMU
> > > translation for MSI.
> > >
> > > This patch implements an ACPI based quirk to reserve the hw msi
> > > regions in the smmu-v3 driver which means these address regions will
> > > not be translated and will be excluded from iova allocations.
> > >
> > > To implement this quirk, the following changes are incorporated:
> > > 1. Added a generic helper function to IORT code to retrieve and reserve
> > >    the associated ITS base address from a device IORT node. The function
> > >    has a check for smmu model to determine whether the platform requires
> > >    the HW MSI reservation or not.
> > > 2. Added smmu node entries and explicitly disabled them in hip06/hip07
> > >     dts files so that users are warned about the non-DT support for this
> > >     erratum.
> > 
> > [...]
> > 
> > >  arch/arm64/boot/dts/hisilicon/hip06.dtsi |  56 ++++++++++++++++
> > > arch/arm64/boot/dts/hisilicon/hip07.dtsi |  25 +++++++
> > >  drivers/acpi/arm64/iort.c                | 111
> > ++++++++++++++++++++++++++++++-
> > >  drivers/iommu/dma-iommu.c                |   8 ++-
> > >  drivers/irqchip/irq-gic-v3-its.c         |   3 +-
> > >  include/linux/acpi_iort.h                |   7 +-
> > >  6 files changed, 204 insertions(+), 6 deletions(-)
> > 
> > It occurred to me this morning that this series probably isn't queued anywhere
> > because it's not obvious which tree is supposed to take it and I can't see it in -
> > next.
> > 
> > Is this one for arm64, IOMMU, irqchip or something else? It's probably missed
> > the boat for 4.16 now...
> > 
> 
> I have been trying to ping you guys on this[1]. My expectation was that it will be
> through IOMMU. Anyway missed the boat now, I will re-spin for 4.17.

The problem with "ping" emails is that they don't really mean anything. In
this case, everybody probably assumed somebody else was picking it up so you
didn't get a reply.

Joerg may be ok pulling this, but it's odd to have dts changes going via his
tree. You might want to split those out, at least. Talk to him.

Will
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
