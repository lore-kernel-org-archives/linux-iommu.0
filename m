From: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Subject: [PATCH v13 0/2] iommu/smmu-v3: Workaround for hisilicon 161010801 erratum(reserve HW MSI)
Date: Tue, 13 Feb 2018 15:20:49 +0000
Message-ID: <20180213152051.10296-1-shameerali.kolothum.thodi@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-acpi-owner@vger.kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
To: lorenzo.pieralisi@arm.com, robin.murphy@arm.com, marc.zyngier@arm.com, will.deacon@arm.com
Cc: joro@8bytes.org, john.garry@huawei.com, xuwei5@hisilicon.com, guohanjun@huawei.com, iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org, linuxarm@huawei.com, Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
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

This patch implements an ACPI based quirk to reserve the hw msi regions
in the smmu-v3 driver which means these address regions will not be
translated and will be excluded from iova allocations.

To implement this quirk, the following changes are incorporated,
  -Added a generic helper function to IORT code to retrieve and reserve
   the associated ITS base address from a device IORT node. The function
   has a check for smmu model to determine whether the platform requires
   the HW MSI reservation or not.

Changelog:

v12 --> v13
- Added Reviewed-by tags for patch #1.
- Dropped the .dts changes (patch #3) from this series. That will be
  send separately. 

v11--> v12
-Thanks to Lorenzo, Fixed !CONFIG_IOMMU_API compile error(patch #1).

v10 --> v11
-Addressed comments from Lorenzo(patch#1)
-Added Robin's Reviewed-by to patch #2

v9 --> v10
Addressed comments:
-Moved smmu model check to iort helper function to selectively apply
 the msi reservation which will make the fn call generic from iommu-dma.
-Removed PCI blacklisting patch, instead added smmu nodes(disabled)
 with comments to hip06/hip07 dts file.

v8 --> v9
-Thanks to Marc, fixed IORT helper function to reserve the ITS
 translater region only.
-Removed the DT support for MSI reservation and blacklisted
 HiSilicon PCIe controllers on DT based systems when SMMUv3 is
 enabled.

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
-Using IORT/MADT tables to retrieve the ITS base addr instead
 of vendor specific CSRT table.


Shameerali Kolothum Thodi (2):
  ACPI/IORT: Add msi address regions reservation helper
  iommu/dma: Add HW MSI(GICv3 ITS) address regions reservation

 drivers/acpi/arm64/iort.c        | 111 +++++++++++++++++++++++++++++++++++++--
 drivers/iommu/dma-iommu.c        |   8 ++-
 drivers/irqchip/irq-gic-v3-its.c |   3 +-
 include/linux/acpi_iort.h        |   7 ++-
 4 files changed, 123 insertions(+), 6 deletions(-)

-- 
2.7.4


