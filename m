From: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Subject: [PATCH v8 0/5] iommu/smmu-v3: Workaround for hisilicon 161010801 erratum(reserve HW MSI)
Date: Wed, 27 Sep 2017 14:32:36 +0100
Message-ID: <20170927133241.21036-1-shameerali.kolothum.thodi@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-acpi-owner@vger.kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
To: lorenzo.pieralisi@arm.com, marc.zyngier@arm.com, sudeep.holla@arm.com, will.deacon@arm.com, robin.murphy@arm.com, joro@8bytes.org, mark.rutland@arm.com, robh@kernel.org
Cc: gabriele.paoloni@huawei.com, john.garry@huawei.com, iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org, devicetree@vger.kernel.org, devel@acpica.org, linuxarm@huawei.com, wangzhou1@hisilicon.com, guohanjun@huawei.com, Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
List-Id: iommu@lists.linux-foundation.org

On certain HiSilicon platforms (hip06/hip07) the GIC ITS and PCIe RC
deviates from the standard implementation and this breaks PCIe MSI
functionality when SMMU is enabled.

The HiSilicon erratum 161010801 describes this limitation of certain
HiSilicon platforms to support the SMMU mappings for MSI transactions.
On these platforms GICv3 ITS translator is presented with the deviceID
by extending the MSI payload data to 64 bits to include the deviceID.
Hence, the PCIe controller on this platforms has to differentiate the MSI
payload against other DMA payload and has to modify the MSI payload.
This basically makes it difficult for this platforms to have a SMMU
translation for MSI.

This patch implements an ACPI and DT based quirk to reserve the hw msi
regions in the smmu-v3 driver which means these address regions will
not be translated and will be excluded from iova allocations.

To implement this quirk, the following changes are incorporated:
1. Added a generic helper function to IORT code to retrieve the
   associated ITS base address from a device IORT node.
2. Added a generic helper function to of iommu code to retrieve the
   associated msi controller base address from for a PCI RC
   msi-mapping and also platform device msi-parent.
3. Added quirk to SMMUv3 to retrieve the HW ITS address and replace
   the default SW MSI reserve address based on the IORT SMMU model
   or DT bindings.

Changelog:

v7 --> v8
Addressed comments from Rob and Lorenzo:
 -Modified to use DT compatible string for errata.
 -Changed logic to retrieve the msi-parent for DT case.

v6 --> v7
Addressed request from Will to add DT support for the erratum:
 - added bt binding
 - add of_iommu_msi_get_resv_regions()
New arm64 silicon errata entry
Rename iort_iommu_{its->msi}_get_resv_regions

v5 --> v6
Addressed comments from Robin and Lorenzo:
-No change to patch#1 .
-Reverted v5 patch#2 as this might break the platforms where this quirk
  is not applicable. Provided a generic function in iommu code and added
  back the quirk implementation in SMMU v3 driver(patch#3)
 
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
-Using IORT/MADT tables to retrieve the ITS base addr instead  of vendor specific CSRT table.

John Garry (2):
  Doc: iommu/arm-smmu-v3: Add workaround for HiSilicon erratum 161010801
  iommu/of: Add msi address regions reservation helper

Shameer Kolothum (3):
  ACPI/IORT: Add msi address regions reservation helper
  iommu/dma: Add a helper function to reserve HW MSI address regions for
    IOMMU drivers
  iommu/arm-smmu-v3:Enable ACPI based HiSilicon erratum 161010801

 Documentation/arm64/silicon-errata.txt             |  1 +
 .../devicetree/bindings/iommu/arm,smmu-v3.txt      |  9 +-
 drivers/acpi/arm64/iort.c                          | 96 +++++++++++++++++++++-
 drivers/iommu/arm-smmu-v3.c                        | 41 +++++++--
 drivers/iommu/dma-iommu.c                          | 19 +++++
 drivers/iommu/of_iommu.c                           | 95 +++++++++++++++++++++
 drivers/irqchip/irq-gic-v3-its.c                   |  3 +-
 include/linux/acpi_iort.h                          |  7 +-
 include/linux/dma-iommu.h                          |  7 ++
 include/linux/of_iommu.h                           | 10 +++
 10 files changed, 276 insertions(+), 12 deletions(-)

-- 
1.9.1


