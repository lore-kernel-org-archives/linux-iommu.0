From: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH v12 0/3] iommu/smmu-v3: Workaround for hisilicon
 161010801 erratum(reserve HW MSI)
Date: Mon, 29 Jan 2018 15:39:40 +0000
Message-ID: <20180129153939.GC24972@arm.com>
References: <20171214160957.13716-1-shameerali.kolothum.thodi@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171214160957.13716-1-shameerali.kolothum.thodi@huawei.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Cc: lorenzo.pieralisi@arm.com, robin.murphy@arm.com, marc.zyngier@arm.com, joro@8bytes.org, john.garry@huawei.com, xuwei5@hisilicon.com, guohanjun@huawei.com, iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org, devicetree@vger.kernel.org, linuxarm@huawei.com
List-Id: iommu@lists.linux-foundation.org

Hi Shameer,

On Thu, Dec 14, 2017 at 04:09:54PM +0000, Shameer Kolothum wrote:
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

[...]

>  arch/arm64/boot/dts/hisilicon/hip06.dtsi |  56 ++++++++++++++++
>  arch/arm64/boot/dts/hisilicon/hip07.dtsi |  25 +++++++
>  drivers/acpi/arm64/iort.c                | 111 ++++++++++++++++++++++++++++++-
>  drivers/iommu/dma-iommu.c                |   8 ++-
>  drivers/irqchip/irq-gic-v3-its.c         |   3 +-
>  include/linux/acpi_iort.h                |   7 +-
>  6 files changed, 204 insertions(+), 6 deletions(-)

It occurred to me this morning that this series probably isn't queued
anywhere because it's not obvious which tree is supposed to take it and
I can't see it in -next.

Is this one for arm64, IOMMU, irqchip or something else? It's probably
missed the boat for 4.16 now...

Will
