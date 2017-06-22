From: Geetha sowjanya <gakula-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org>
Subject: [PATCH v9 0/3] Cavium ThunderX2 SMMUv3 errata workarounds
Date: Thu, 22 Jun 2017 17:35:35 +0530
Message-ID: <1498133138-20244-1-git-send-email-gakula@caviumnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: will.deacon-5wv7dgnIgG8@public.gmane.org, robin.murphy-5wv7dgnIgG8@public.gmane.org, lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org, hanjun.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, sudeep.holla-5wv7dgnIgG8@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, Charles.Garcia-Tobin-5wv7dgnIgG8@public.gmane.org, Geetha sowjanya <gakula-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org>, geethasowjanya.akula-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, jcm-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, linu.cherian-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org, rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org, robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, robert.richter-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org, lv.zheng-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, catalin.marinas-5wv7dgnIgG8@public.gmane.org, sgoutham-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devel-E0kO6a4B6psdnm+yROfE0A@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Cavium ThunderX2 SMMUv3 implementation has two Silicon Erratas.
1. Errata ID #74
   SMMU register alias Page 1 is not implemented
2. Errata ID #126
   SMMU doesnt support unique IRQ lines and also MSI for gerror,
   eventq and cmdq-sync

The following patchset does software workaround for these two erratas.

This series is based on patchset.
https://www.spinics.net/lists/arm-kernel/msg578443.html

Changes since v8:
    - Reworked patch #3 as suggested by Will. 
    - Corrected typo mistake in patch #2

Changes since v7:
    - Added new function "arm_smmu_v3_resource_size" in iort.c to get resource
      size.
    - Added new SMMU option "SHARED_IRQ" to enable errata #126 workaround.
    - Coding style issues fixed.
    - Suggested changes in arm_smmu_device_probe addressed.
    - Replaced ACPI_IORT_SMMU_CAVIUM_CN99XX macro with ACPI_IORT_SMMU_V3_CAVIUM_CN99XX

Changes since v6:
   - Changed device tree compatible string to vendor specific.
   - Rebased on Robin's latest "Update SMMU models for IORT rev. C" v2 patch.
     https://www.spinics.net/lists/arm-kernel/msg582809.html

Changes since v5:
   - Rebased on Robin's "Update SMMU models for IORT rev. C" patch.
     https://www.spinics.net/lists/arm-kernel/msg580728.html
   - Replaced ACPI_IORT_SMMU_V3_CAVIUM_CN99XX macro with ACPI_IORT_SMMU_CAVIUM_CN99XX

Changes since v4:
  - Replaced all page1 offset macros ARM_SMMU_EVTQ/PRIQ_PROD/CONS with
    arm_smmu_page1_fixup(ARM_SMMU_EVTQ/PRIQ_PROD/CONS, smmu)

Changes since v3:
  - Merged patches 1, 2 and 4 of Version 3.
  - Modified the page1_offset_adjust() and get_irq_flags() implementation as
    suggested by Robin.

Changes since v2:
  - Updated "Documentation/devicetree/bindings/iommu/arm,smmu-v3.txt" document with
    new SMMU option used to enable errata workaround.

Changes since v1:
 - Since the use of MIDR register is rejected and SMMU_IIDR is broken on this
   silicon, as suggested by Will Deacon modified the patches to use ThunderX2
   SMMUv3 IORT model number to enable errata workaround.

Geetha Sowjanya (1):
  iommu/arm-smmu-v3: Add workaround for Cavium ThunderX2 erratum #126

Linu Cherian (2):
  ACPI/IORT: Fixup SMMUv3 resource size for Cavium ThunderX2 SMMUv3
    model
  iommu/arm-smmu-v3: Add workaround for Cavium ThunderX2 erratum #74

 Documentation/arm64/silicon-errata.txt             |    2 +
 .../devicetree/bindings/iommu/arm,smmu-v3.txt      |    7 +
 drivers/acpi/arm64/iort.c                          |   69 ++++++---
 drivers/iommu/arm-smmu-v3.c                        |  171 +++++++++++++++-----
 4 files changed, 186 insertions(+), 63 deletions(-)
