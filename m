From: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Subject: RE: [PATCH v10 0/3] iommu/smmu-v3: Workaround for hisilicon
 161010801 erratum(reserve HW MSI)
Date: Mon, 11 Dec 2017 09:17:08 +0000
Message-ID: <5FC3163CFD30C246ABAA99954A238FA838626230@FRAEML521-MBX.china.huawei.com>
References: <20171129141449.120316-1-shameerali.kolothum.thodi@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20171129141449.120316-1-shameerali.kolothum.thodi@huawei.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
To: "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>, "will.deacon@arm.com" <will.deacon@arm.com>, "robin.murphy@arm.com" <robin.murphy@arm.com>, "marc.zyngier@arm.com" <marc.zyngier@arm.com>, "joro@8bytes.org" <joro@8bytes.org>
Cc: John Garry <john.garry@huawei.com>, "xuwei (O)" <xuwei5@hisilicon.com>, "Guohanjun (Hanjun Guo)" <guohanjun@huawei.com>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Linuxarm <linuxarm@huawei.com>
List-Id: iommu@lists.linux-foundation.org

Hi Lorenzo/Robin,

Any feedback on this series, please?

This one has the platform check(smmu model) moved into iort
code and invoking the helper fn from iommu_dma_get_resv_regions().

Thanks,
Shameer

> -----Original Message-----
> From: Shameerali Kolothum Thodi
> Sent: Wednesday, November 29, 2017 2:15 PM
> To: lorenzo.pieralisi@arm.com; will.deacon@arm.com;
> robin.murphy@arm.com; marc.zyngier@arm.com; joro@8bytes.org
> Cc: John Garry <john.garry@huawei.com>; xuwei (O) <xuwei5@hisilicon.com>;
> Guohanjun (Hanjun Guo) <guohanjun@huawei.com>; iommu@lists.linux-
> foundation.org; linux-arm-kernel@lists.infradead.org; linux-
> acpi@vger.kernel.org; devicetree@vger.kernel.org; Linuxarm
> <linuxarm@huawei.com>; Shameerali Kolothum Thodi
> <shameerali.kolothum.thodi@huawei.com>
> Subject: [PATCH v10 0/3] iommu/smmu-v3: Workaround for hisilicon
> 161010801 erratum(reserve HW MSI)
> 
> On certain HiSilicon platforms (hip06/hip07) the GIC ITS and PCIe RC
> deviates from the standard implementation and this breaks PCIe MSI
> functionality when SMMU is enabled.
> 
> The HiSilicon erratum 161010801 describes this limitation of certain
> HiSilicon platforms to support the SMMU mappings for MSI transactions.
> On these platforms GICv3 ITS translator is presented with the deviceID
> by extending the MSI payload data to 64 bits to include the deviceID.
> Hence, the PCIe controller on this platforms has to differentiate the MSI
> payload against other DMA payload and has to modify the MSI payload.
> This basically makes it difficult for this platforms to have a SMMU
> translation for MSI.
> 
> This patch implements an ACPI based quirk to reserve the hw msi regions
> in the smmu-v3 driver which means these address regions will not be
> translated and will be excluded from iova allocations.
> 
> To implement this quirk, the following changes are incorporated:
> 1. Added a generic helper function to IORT code to retrieve and reserve
>    the associated ITS base address from a device IORT node. The function
>    has a check for smmu model to determine whether the platform requires
>    the HW MSI reservation or not.
> 2. Added smmu node entries and explicitly disabled them in hip06/hip07
>     dts files so that users are warned about the non-DT support for this
>     erratum.
> 
> Changelog:
> 
> v9 --> v10
> Addressed comments:
> -Moved smmu model check to iort helper function to selectively apply
>  the msi reservation which will make the fn call generic from iommu-dma.
> -Removed PCI blacklisting patch, instead added smmu nodes(disabled)
>  with comments to hip06/hip07 dts file.
> 
> v8 --> v9
> -Thanks to Marc, fixed IORT helper function to reserve the ITS
>  translater region only.
> -Removed the DT support for MSI reservation and blacklisted
>  HiSilicon PCIe controllers on DT based systems when SMMUv3 is
>  enabled.
> 
> v7 --> v8
> Addressed comments from Rob and Lorenzo:
>  -Modified to use DT compatible string for errata.
>  -Changed logic to retrieve the msi-parent for DT case.
> 
> v6 --> v7
> Addressed request from Will to add DT support for the erratum:
>  - added bt binding
>  - add of_iommu_msi_get_resv_regions()
> New arm64 silicon errata entry
> Rename iort_iommu_{its->msi}_get_resv_regions
> 
> v5 --> v6
> Addressed comments from Robin and Lorenzo:
> -No change to patch#1 .
> -Reverted v5 patch#2 as this might break the platforms where this quirk
>   is not applicable. Provided a generic function in iommu code and added
>   back the quirk implementation in SMMU v3 driver(patch#3)
> 
> v4 --> v5
> Addressed comments from Robin and Lorenzo:
> -Added a comment to make it clear that, for now, only straightforward
>   HW topologies are handled while reserving ITS regions(patch #1).
> 
> v3 --> v4
> Rebased on 4.13-rc1.
> Addressed comments from Robin, Will and Lorenzo:
> -As suggested by Robin, moved the ITS msi reservation into
>   iommu_dma_get_resv_regions().
> -Added its_count != resv region failure case(patch #1).
> 
> v2 --> v3
> Addressed comments from Lorenzo and Robin:
> -Removed dev_is_pci() check in smmuV3 driver.
> -Don't treat device not having an ITS mapping as an error in
>   iort helper function.
> 
> v1 --> v2
> -patch 2/2: Invoke iort helper fn based on fwnode type(acpi).
> 
> RFCv2 -->PATCH
> -Incorporated Lorenzo's review comments.
> 
> RFC v1 --> RFC v2
> Based on Robin's review comments,
> -Removed  the generic erratum framework.
> -Using IORT/MADT tables to retrieve the ITS base addr instead  of vendor
> specific CSRT table.
> 
> Shameer Kolothum (3):
>   ACPI/IORT: Add msi address regions reservation helper
>   iommu/dma: Add HW MSI(GICv3 ITS) address regions reservation
>   arm64:dts:hisilicon Disable hisilicon smmu node on hip06/hip07
> 
>  arch/arm64/boot/dts/hisilicon/hip06.dtsi |  55 +++++++++++++
>  arch/arm64/boot/dts/hisilicon/hip07.dtsi |  24 ++++++
>  drivers/acpi/arm64/iort.c                | 133 ++++++++++++++++++++++++++++++-
>  drivers/iommu/dma-iommu.c                |   8 +-
>  drivers/irqchip/irq-gic-v3-its.c         |   3 +-
>  include/linux/acpi_iort.h                |   7 +-
>  6 files changed, 224 insertions(+), 6 deletions(-)
> 
> --
> 1.9.1
> 

