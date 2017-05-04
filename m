From: Geetha sowjanya <gakula@caviumnetworks.com>
Subject: [PATCH v2 0/7] Cavium ThunderX2 SMMUv3 errata workarounds
Date: Thu,  4 May 2017 18:05:32 +0530
Message-ID: <1493901339-14929-1-git-send-email-gakula@caviumnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-acpi-owner@vger.kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
To: will.deacon@arm.com, robin.murphy@arm.com, lorenzo.pieralisi@arm.com, hanjun.guo@linaro.org, sudeep.holla@arm.com, iommu@lists.linux-foundation.org
Cc: jcm@redhat.com, linux-kernel@vger.kernel.org, robert.richter@cavium.com, catalin.marinas@arm.com, sgoutham@cavium.com, linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org, geethasowjanya.akula@gmail.com, linu.cherian@cavium.com, Charles.Garcia-Tobin@arm.com
List-Id: iommu@lists.linux-foundation.org

From: Linu Cherian <linu.cherian@cavium.com>

Cavium ThunderX2 SMMUv3 implementation has two Silicon Erratas.
1. Errata ID #74
   SMMU register alias Page 1 is not implemented
2. Errata ID #126
   SMMU doesnt support unique IRQ lines and also MSI for gerror, 
   eventq and cmdq-sync

The following patchset does software workaround for these two erratas.

This series is based on patchset. 
https://www.spinics.net/lists/arm-kernel/msg578443.html

Changes from v1:
 Since the use of MIDR register is rejected and SMMU_IIDR is broken on this 
 silicon, as suggested by Will Deacon modified the patches to use ThunderX2 
 SMMUv3 IORT model number to enable errata workaround.


Geetha Sowjanya (1):
  iommu/arm-smmu-v3: Add workaround for Cavium ThunderX2 erratum #126

Linu Cherian (6):
  iommu/arm-smmu-v3: Introduce smmu option PAGE0_REGS_ONLY for ThunderX2
    errata#74.
  iommu/arm-smmu-v3: Do resource size checks based on SMMU option
    PAGE0_REGS_ONLY
  ACPICA: IORT: Add Cavium ThunderX2 SMMUv3 model definition.
  iommu/arm-smmu-v3: For ACPI based device probing, set PAGE0_REGS_ONLY
    option     for ThunderX2 SMMUv3 implementations.
  ACPI/IORT: Fixup SMMUv3 resource size for Cavium ThunderX2 SMMUv3
    model
  arm64: Documentation: Add Cavium ThunderX2 SMMUv3 erratas

 Documentation/arm64/silicon-errata.txt |   2 +
 drivers/acpi/arm64/iort.c              |  10 ++-
 drivers/iommu/arm-smmu-v3.c            | 122 ++++++++++++++++++++++++++-------
 include/acpi/actbl2.h                  |   2 +
 4 files changed, 110 insertions(+), 26 deletions(-)

-- 
1.8.3.1

