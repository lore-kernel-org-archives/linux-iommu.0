From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH v5 1/2] ACPI/IORT: Add ITS address regions reservation
 helper
Date: Mon, 7 Aug 2017 18:09:21 +0100
Message-ID: <20170807170921.GB27830@red-moon>
References: <20170801104913.71912-1-shameerali.kolothum.thodi@huawei.com>
 <20170801104913.71912-2-shameerali.kolothum.thodi@huawei.com>
 <b478d1b4-5993-9459-adfc-dec05525d72e@arm.com>
 <5FC3163CFD30C246ABAA99954A238FA8383C7EF8@FRAEML521-MBX.china.huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5FC3163CFD30C246ABAA99954A238FA8383C7EF8@FRAEML521-MBX.china.huawei.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Cc: Robin Murphy <robin.murphy@arm.com>, "marc.zyngier@arm.com" <marc.zyngier@arm.com>, "sudeep.holla@arm.com" <sudeep.holla@arm.com>, "will.deacon@arm.com" <will.deacon@arm.com>, "hanjun.guo@linaro.org" <hanjun.guo@linaro.org>, Gabriele Paoloni <gabriele.paoloni@huawei.com>, John Garry <john.garry@huawei.com>, Linuxarm <linuxarm@huawei.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "Wangzhou (B)" <wangzhou1@hisilicon.com>, "Guohanjun (Hanjun Guo)" <guohanjun@huawei.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "devel@acpica.org" <devel@acpica.org>
List-Id: iommu@lists.linux-foundation.org

On Mon, Aug 07, 2017 at 08:21:40AM +0000, Shameerali Kolothum Thodi wrote:
> 
> 
> > -----Original Message-----
> > From: Robin Murphy [mailto:robin.murphy@arm.com]
> > Sent: Friday, August 04, 2017 5:57 PM
> > To: Shameerali Kolothum Thodi; lorenzo.pieralisi@arm.com;
> > marc.zyngier@arm.com; sudeep.holla@arm.com; will.deacon@arm.com;
> > hanjun.guo@linaro.org
> > Cc: Gabriele Paoloni; John Garry; iommu@lists.linux-foundation.org; linux-
> > arm-kernel@lists.infradead.org; linux-acpi@vger.kernel.org;
> > devel@acpica.org; Linuxarm; Wangzhou (B); Guohanjun (Hanjun Guo)
> > Subject: Re: [PATCH v5 1/2] ACPI/IORT: Add ITS address regions reservation
> > helper
> > 
> > On 01/08/17 11:49, Shameer Kolothum wrote:
> > > On some platforms ITS address regions have to be excluded from normal
> > > IOVA allocation in that they are detected and decoded in a HW specific
> > > way by system components and so they cannot be considered normal
> > IOVA
> > > address space.
> > >
> > > Add an helper function that retrieves ITS address regions through IORT
> > > device <-> ITS mappings and reserves it so that these regions will not
> > > be translated by IOMMU and will be excluded from IOVA allocations.
> > 
> > I've just realised that we no longer seem to have a check that ensures
> > the regions are only reserved on platforms that need it - if not, then
> > we're going to break everything else that does have an ITS behind SMMU
> > translation as expected.
> 
> Right. I had this doubt, but then my thinking was that we will have the SW_MSI
> regions for those and will end up  using that. But that doesn’t seems
> to be the case now.
> 
> > It feels like IORT should know enough to be able to make that decision
> > internally, but if not (or if it would be hideous to do so), then I
> > guess my idea for patch #2 was a bust and we probably do need to go back
> > to calling directly from the SMMU driver based on the SMMU model.
> 
> It might be possible to do that check inside iort code, but then we have to find
> the  smmu node first and check the model number. I think it will be more
> cleaner if SMMU driver makes that check and call the
> iommu_dma_get_msi_resv_regions().

+1 on this one - we can do it in IORT but I think it is more logical
to have a flag in the SMMU driver (keeping the DT/ACPI fwnode switch in
generic IOMMU layer though).

Side note I: AFAICS iommu_dma_get_resv_regions() is only used on ARM, if
it is not patch 2 would break miserably on arches that do not select
IORT - you should rework the return code on !CONFIG_ACPI_IORT configs.

Side note II(nit): why not call the function iort_iommu_get_resv_regions() ?

Lorenzo

> If you are Ok with that I will quickly rework and send out the next version.
> 
> Thanks,
> Shameer
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
