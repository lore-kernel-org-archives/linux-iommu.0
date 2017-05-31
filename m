From: shameer <shameerali.kolothum.thodi@huawei.com>
Subject: [RFCv2 0/2] iommu/smmu-v3: Workaround for hisilicon 161010801 erratum(reserve HW MSI)
Date: Wed, 31 May 2017 15:32:11 +0100
Message-ID: <20170531143213.82100-1-shameerali.kolothum.thodi@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-acpi-owner@vger.kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
To: lorenzo.pieralisi@arm.com, marc.zyngier@arm.com, sudeep.holla@arm.com, will.deacon@arm.com, robin.murphy@arm.com, hanjun.guo@linaro.org
Cc: gabriele.paoloni@huawei.com, john.garry@huawei.com, iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org, devel@acpica.org, linuxarm@huawei.com, wangzhou1@hisilicon.com, guohanjun@huawei.com, shameer <shameerali.kolothum.thodi@huawei.com>
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

This patch implements a ACPI table based quirk to reserve the hw msi
regions in the smmu-v3 driver which means these address regions will
not be translated and will be excluded from iova allocations.

To implement this quirk, the following changes are incorporated:

1. Added a generic helper function to IORT code to retrieve the
   associated ITS base address from a device IORT node.
2. Added quirk to SMMUv3 to retrieve the HW ITS address and replace
   the default SW MSI reserve address based on the IORT SMMU model.

This is based on the following patches:
1. https://patchwork.kernel.org/patch/9740733/
2. https://patchwork.kernel.org/patch/9730491/

Thanks,
Shameer

RFC v1 ---> v2
 Based on Robin's review comments,
        :Removed  the generic erratum framework.
        :Using IORT/MADT tables to retrieve the ITS base addr instead
         of vendor specific CSRT table.

shameer (2):
  acpi:iort: Add new helper function to retrieve ITS base addr from IORT
    node
  iommu/arm-smmu-v3:Enable ACPI based HiSilicon erratum 161010801

 drivers/acpi/arm64/iort.c        | 47 +++++++++++++++++++++++++++++++++++---
 drivers/iommu/arm-smmu-v3.c      | 49 +++++++++++++++++++++++++++++++++++++---
 drivers/irqchip/irq-gic-v3-its.c |  3 ++-
 include/linux/acpi_iort.h        |  8 ++++++-
 4 files changed, 99 insertions(+), 8 deletions(-)

-- 
1.9.1


