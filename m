From: shameer <shameerali.kolothum.thodi-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
Subject: [RFC v1 0/7] iommu/smmu-v3: Workaround for hisilicon 161010801 erratum(reserve HW MSI)
Date: Sat, 13 May 2017 10:47:24 +0100
Message-ID: <20170513094731.3676-1-shameerali.kolothum.thodi@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: will.deacon-5wv7dgnIgG8@public.gmane.org, robin.murphy-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org, hanjun.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
Cc: gabriele.paoloni-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, john.garry-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devel-E0kO6a4B6psdnm+yROfE0A@public.gmane.org, linuxarm-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, wangzhou1-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org, guohanjun-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, shameer <shameerali.kolothum.thodi-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
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
not be translated and will be excluded from iova alloactions.

To implement this quirk, the following changes are incorporated 
into smmu-v3:
1. Added a general erratum framework based on arm_arch_timer erratum
   framework. The intention is to have a common framework for dt and
   acpi based quirk implementations.
2. Replaced the existing hisilicon, broken_prefetch_cmd quirk using 
   the new erratum framework (erratum-161010701)
3. Introduced a ACPI based quirk for erratum-161010801.
4. ACPI CSRT vendor specific blobs are used to pass the reserve address
   region info on these platforms.

Also please note that this patchset is based on Robin's patch series
"acpica: iort: Update SMMU models for IORT rev. C".
https://lkml.org/lkml/2017/5/12/211


Thanks,
Shameer

shameer (7):
  iommu/arm-smmu-v3: Add erratum framework structures
  iommu/arm-smmu-v3: Add erratum framework functions
  iommu/arm-smmu-v3: Replace the device tree binding for hisilicon
    broken prefetch cmd with erratum id
  iommu/arm-smmu-v3: Enable HiSilicon erratum 161010701
  iommu/arm-smmu-v3: Enable ACPI based HiSilicon erratum 161010701
  iommu/arm-smmu-v3: Rearrange msi resv alloc functions
  iommu/arm-smmu-v3: Enable ACPI based HiSilicon erratum 161010801

 .../devicetree/bindings/iommu/arm,smmu-v3.txt      |   2 +-
 arch/arm64/Kconfig                                 |  20 +-
 drivers/iommu/arm-smmu-v3.c                        | 225 ++++++++++++++++++---
 3 files changed, 218 insertions(+), 29 deletions(-)

-- 
2.5.0


--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
