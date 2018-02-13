From: Shameerali Kolothum Thodi <shameerali.kolothum.thodi-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
Subject: RE: [PATCH v12 0/3] iommu/smmu-v3: Workaround for hisilicon
	161010801 erratum(reserve HW MSI)
Date: Tue, 13 Feb 2018 09:18:28 +0000
Message-ID: <5FC3163CFD30C246ABAA99954A238FA83864614F@FRAEML521-MBX.china.huawei.com>
References: <20171214160957.13716-1-shameerali.kolothum.thodi@huawei.com>
	<20180129153939.GC24972@arm.com>
	<5FC3163CFD30C246ABAA99954A238FA83863FC88@FRAEML521-MBX.china.huawei.com>
	<20180129162109.GA25266@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20180129162109.GA25266-5wv7dgnIgG8@public.gmane.org>
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
Cc: "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "marc.zyngier-5wv7dgnIgG8@public.gmane.org" <marc.zyngier-5wv7dgnIgG8@public.gmane.org>, Linuxarm <linuxarm-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, "linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "xuwei (O)" <xuwei5-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, "Guohanjun (Hanjun
	Guo)" <guohanjun-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi Will,

> -----Original Message-----
> From: Will Deacon [mailto:will.deacon-5wv7dgnIgG8@public.gmane.org]
> Sent: Monday, January 29, 2018 4:21 PM
> To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
> Cc: lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org; robin.murphy-5wv7dgnIgG8@public.gmane.org;
> marc.zyngier-5wv7dgnIgG8@public.gmane.org; joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org; John Garry
> <john.garry-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>; xuwei (O) <xuwei5-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>; Guohanjun
> (Hanjun Guo) <guohanjun-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>; iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org;
> linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org; linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org;
> devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; Linuxarm <linuxarm-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
> Subject: Re: [PATCH v12 0/3] iommu/smmu-v3: Workaround for hisilicon
> 161010801 erratum(reserve HW MSI)
> 
> On Mon, Jan 29, 2018 at 04:16:33PM +0000, Shameerali Kolothum Thodi wrote:
> > > -----Original Message-----
> > > From: Will Deacon [mailto:will.deacon-5wv7dgnIgG8@public.gmane.org]
> > > Sent: Monday, January 29, 2018 3:40 PM
> > > To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
> > > Cc: lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org; robin.murphy-5wv7dgnIgG8@public.gmane.org;
> > > marc.zyngier-5wv7dgnIgG8@public.gmane.org; joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org; John Garry
> > > <john.garry-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>; xuwei (O) <xuwei5-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>; Guohanjun
> > > (Hanjun Guo) <guohanjun-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>; iommu-cunTk1MwBs/ROKNJybVBZg@public.gmane.org
> foundation.org;
> > > linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org; linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org;
> > > devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; Linuxarm <linuxarm-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
> > > Subject: Re: [PATCH v12 0/3] iommu/smmu-v3: Workaround for hisilicon
> > > 161010801 erratum(reserve HW MSI)
> > > On Thu, Dec 14, 2017 at 04:09:54PM +0000, Shameer Kolothum wrote:
> > > > On certain HiSilicon platforms (hip06/hip07) the GIC ITS and PCIe RC
> > > > deviates from the standard implementation and this breaks PCIe MSI
> > > > functionality when SMMU is enabled.
> > > >
[...]

> > > It occurred to me this morning that this series probably isn't queued
> anywhere
> > > because it's not obvious which tree is supposed to take it and I can't see it in
> -
> > > next.
> > >
> > > Is this one for arm64, IOMMU, irqchip or something else? It's probably
> missed
> > > the boat for 4.16 now...
> > >
> >
> > I have been trying to ping you guys on this[1]. My expectation was that it will
> be
> > through IOMMU. Anyway missed the boat now, I will re-spin for 4.17.
> 
> The problem with "ping" emails is that they don't really mean anything. In
> this case, everybody probably assumed somebody else was picking it up so you
> didn't get a reply.
> 
> Joerg may be ok pulling this, but it's odd to have dts changes going via his
> tree. You might want to split those out, at least. Talk to him.

As this series missed out from the PULL request, I am preparing to send this again.
Please let me know, you are ok with the dts changes being part of this or would like
to split it.

Thanks,
Shameer
