From: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Subject: [PATCH v6 0/3] iommu/smmu-v3: Workaround for hisilicon 161010801 erratum(reserve HW MSI)
Date: Wed, 9 Aug 2017 11:07:12 +0100
Message-ID: <20170809100715.870516-1-shameerali.kolothum.thodi@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-acpi-owner@vger.kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
To: lorenzo.pieralisi@arm.com, marc.zyngier@arm.com, sudeep.holla@arm.com, will.deacon@arm.com, robin.murphy@arm.com, hanjun.guo@linaro.org
Cc: gabriele.paoloni@huawei.com, john.garry@huawei.com, iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org, devel@acpica.org, linuxarm@huawei.com, wangzhou1@hisilicon.com, guohanjun@huawei.com, Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
List-Id: iommu@lists.linux-foundation.org

On certain HiSilicon platforms (Hip06/Hip07) the GIC ITS and
PCIe RC deviates from the standard implementation and this breaks
PCIe MSI functionality when SMMU is enabled.

The HiSilicon erratum 161010801 describes this limitation of certain
HiSilicon platforms to support the SMMU mappings for MSI transactions.
On these platforms GICv3 ITS translator is presented with the deviceID
by extending the MSI payload data to 64 bits to include the deviceID.
Hence, the PCIe controller on this platforms has to differentiate the
MSI payload against other DMA payload and has to modify the MSI payload.
This basically makes it difficult for this platforms to have a SMMU
translation for MSI.

To implement this quirk, the following changes are incorporated:

1. Added a generic helper function to IORT code to retrieve and
   reserve the HW ITS address regions.
2. Added quirk to SMMUv3 to reserve HW ITS address regions based
    on IORT SMMUv3 model with the help of a generic iommu helper
    function.

Thanks,
Shameer

Changelog:

v5 --> v6
Addressed comments from Robin and Lorenzo:
-No change to patch#1 .
-Reverted v5 patch#2 as this might break the platforms where this quirk
is not applicable. Provided a generic function in iommu code and
added back the quirk implementation in SMMU v3 driver(patch#3)
 
v4 --> v5
Addressed comments from Robin and Lorenzo:
-Added a comment to make it clear that, for now, only straightforward 
 HW topologies are handled while reserving ITS regions(patch #1).

v3 --> v4
Rebased on 4.13-rc1.
Addressed comments from Robin, Will and Lorenzo:
-As suggested by Robin, moved the ITS msi reservation into
 iommu_dma_get_resv_regions().
-Added its_count != resv region failure case(patch #1).

v2 --> v3
Addressed comments from Lorenzo and Robin:
-Removed dev_is_pci() check in smmuV3 driver.
-Don't treat device not having an ITS mapping as an error in
 iort helper function.

v1 --> v2
-patch 2/2: Invoke iort helper fn based on fwnode type(acpi).

RFCv2 -->PATCH
-Incorporated Lorenzo's review comments.

RFC v1 --> RFC v2
Based on Robin's review comments,
-Removed  the generic erratum framework.
-Using IORT/MADT tables to retrieve the ITS base addr instead
 of vendor specific CSRT table.

Shameer Kolothum (3):
  ACPI/IORT: Add ITS address regions reservation helper
  iommu/dma: Add a helper function to reserve HW MSI address regions for
    IOMMU drivers
  iommu/arm-smmu-v3:Enable ACPI based HiSilicon erratum 161010801

 drivers/acpi/arm64/iort.c        | 95 ++++++++++++++++++++++++++++++++++++++--
 drivers/iommu/arm-smmu-v3.c      | 27 +++++++++---
 drivers/iommu/dma-iommu.c        | 19 ++++++++
 drivers/irqchip/irq-gic-v3-its.c |  3 +-
 include/linux/acpi_iort.h        |  7 ++-
 include/linux/dma-iommu.h        |  7 +++
 6 files changed, 148 insertions(+), 10 deletions(-)

-- 
1.9.1


