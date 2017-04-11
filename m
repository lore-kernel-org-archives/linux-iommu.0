From: linucherian-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Subject: [RFC PATCH 0/7] Cavium CN99xx SMMUv3 Errata workarounds
Date: Tue, 11 Apr 2017 20:12:38 +0530
Message-ID: <1491921765-29475-1-git-send-email-linucherian@gmail.com>
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
To: catalin.marinas-5wv7dgnIgG8@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org, hanjun.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, sudeep.holla-5wv7dgnIgG8@public.gmane.org
Cc: Sunil.Goutham-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org, Geethasowjanya.Akula-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org, rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org, robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, robert.richter-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, lv.zheng-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, linu.cherian-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org, devel-E0kO6a4B6psdnm+yROfE0A@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

From: Linu Cherian <linu.cherian-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>

Cavium CN99xx SMMUv3 implementation has two Silicon Erratas.
1. Errata ID #74
   SMMU register alias Page 1 is not implemented
2. Errata ID #126
   SMMU doesnt support unique IRQ lines for gerror, eventq and cmdq-sync

The following patchset does software workaround for these two erratas.
An option flag is introduced for each errata which will enable/disable
the errata workarounds.
For device tree based probing, option flags can be turned on by passing 
relevant options along with the smmuv3 device node. For ACPI, option flags
are turned on when Cavium CN99xx SMMuv3 model is identified in the IORT.

Note: We are in the process of getting necessary IORT SMMUv3 model ID 
      for Cavium CN99xx SMMUv3 implementation and it is yet to get
      allocated. We have assumed model ID 3 for this.

Geetha (1):
  iommu/arm-smmu-v3: Introduce smmu option USE_SHARED_IRQS for Silicon
    errata

Linu Cherian (6):
  iommu/arm-smmu-v3: Introduce smmu option PAGE0_REGS_ONLY for Silicon
    errata.
  iommu/arm-smmu-v3: Do resource size checks based on smmu option
    PAGE0_REGS_ONLY
  ACPICA: IORT: Add SMMuV3 model definitions.
  iommu/arm-smmu-v3: For ACPI based device probing, set relevant options
    for different SMMUv3 implementations.
  ACPI/IORT: Fixup SMMUv3 resource size for Cavium 99xx SMMUv3 model.
  arm64: Documentation: Add Cavium ThunderX2 SMMUv3 erratas.

 Documentation/arm64/silicon-errata.txt |   2 +
 drivers/acpi/arm64/iort.c              |  10 ++-
 drivers/iommu/arm-smmu-v3.c            | 115 ++++++++++++++++++++++++++-------
 include/acpi/actbl2.h                  |   5 ++
 4 files changed, 107 insertions(+), 25 deletions(-)

-- 
1.9.1
