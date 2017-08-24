From: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH v6 3/3] iommu/arm-smmu-v3:Enable ACPI based HiSilicon
 erratum 161010801
Date: Thu, 24 Aug 2017 15:35:37 +0100
Message-ID: <20170824143536.GA8904@arm.com>
References: <20170809100715.870516-1-shameerali.kolothum.thodi@huawei.com>
 <20170809100715.870516-4-shameerali.kolothum.thodi@huawei.com>
 <20170810172723.GD9980@arm.com>
 <5FC3163CFD30C246ABAA99954A238FA8383CC287@FRAEML521-MBX.china.huawei.com>
 <c6b7c641-b839-1388-7982-366e796e6ba9@huawei.com>
 <20170823132430.GB634@arm.com>
 <77b6c97f-f2d2-fd14-e83e-345addc5ea71@huawei.com>
 <20170823164301.GC590@arm.com>
 <53b9795c-6222-9cf0-50dc-9dafbfb67a2c@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <53b9795c-6222-9cf0-50dc-9dafbfb67a2c@huawei.com>
Sender: linux-acpi-owner@vger.kernel.org
To: John Garry <john.garry@huawei.com>
Cc: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>, "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>, "marc.zyngier@arm.com" <marc.zyngier@arm.com>, "sudeep.holla@arm.com" <sudeep.holla@arm.com>, "robin.murphy@arm.com" <robin.murphy@arm.com>, "hanjun.guo@linaro.org" <hanjun.guo@linaro.org>, Gabriele Paoloni <gabriele.paoloni@huawei.com>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "devel@acpica.org" <devel@acpica.org>, Linuxarm <linuxarm@huawei.com>, "Wangzhou (B)" <wangzhou1@hisilicon.com>, "Guohanjun (Hanjun Guo)" <guohanjun@huawei.com>
List-Id: iommu@lists.linux-foundation.org

On Wed, Aug 23, 2017 at 05:55:52PM +0100, John Garry wrote:
> On 23/08/2017 17:43, Will Deacon wrote:
> >On Wed, Aug 23, 2017 at 03:29:46PM +0100, John Garry wrote:
> >>On 23/08/2017 14:24, Will Deacon wrote:
> >>>On Wed, Aug 23, 2017 at 02:17:24PM +0100, John Garry wrote:
> >>>>>>>Signed-off-by: Shameer Kolothum
> >>>>>><shameerali.kolothum.thodi@huawei.com>
> >>>>>>>---
> >>>>>>>drivers/iommu/arm-smmu-v3.c | 27 ++++++++++++++++++++++-----
> >>>>>>>1 file changed, 22 insertions(+), 5 deletions(-)
> >>>>>>
> >>>>>>Please can you also add a devicetree binding with corresponding
> >>>>>>documentation to enable this workaround on non-ACPI based systems too?
> >>>>>>It should be straightforward if you update the arm_smmu_options table.
> >>>>>
> >>>>>As I mentioned before, devicetree was a lower priority and we would definitely
> >>>>>submit patch to support that. Even if we update the arm_smmu_options table
> >>>>>with DT binding, the generic function to retrieve the MSI address regions only
> >>>>>works on ACPI/IORT case now.
> >>>>>
> >>>>
> >>>>Hi Will,
> >>>>
> >>>>Can you confirm your stance on supporting this workaround for DT as well as
> >>>>ACPI?
> >>>>
> >>>>For us, we now only "officially" support ACPI FW, and DT support at this
> >>>>point is patchy/limited. To me, adding DT support is just more errata
> >>>>workaround code to maintain with little useful gain.
> >>>
> >>>I basically don't like the idea of a driver that only works for one of
> >>>ACPI or DT yet claims to support both. I'm less fussed about functionality
> >>>differences (feature X is only available with firmware Y), but not working
> >>>around a hardware erratum that we know about is just lazy.
> >>>
> >>>So I'd prefer that we handle this in both cases, or blacklist affected
> >>>devices when booting with DT. Continuing as though there isn't an erratum
> >>>is the worst thing we can do.
> >>
> >>OK, seems reasonable.
> >>
> >>We would consider blacklisting the device, where/how to do is the question.
> >>
> >>So the errata is in the GICv3 ITS/PCI host controller, and we just use the
> >>in-between SMMU (driver) to provide the workaround. So my initial impression
> >>is that the PCI host controller would have to be blacklisted IFF behind an
> >>IOMMU for DT firmware in pcie-hisi.c or pci quirks framework. How does it
> >>sound?
> >
> >If that avoids us running into the erratum, then fine by me. I'd obviously
> >prefer we work-around it since we know how to, but that's up to you.
> 
> I'm surpsised that you may want more errata workaround code to maintain.
> 
> Anyway we'll check both approaches and show you how they look and go from
> there.

Don't get me wrong, I don't dream about adding errata workarounds to the
code, but our job as an operating system is to abstract the hardware from
the user, which means dealing with its quirks whether we like it or not.

Thanks,

Will
