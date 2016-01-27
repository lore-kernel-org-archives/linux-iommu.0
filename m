From: Anup Patel <anup.patel@broadcom.com>
Subject: [RFC PATCH 0/6] iommu/arm-smmu: Add support for DMA domains and instruction fetch
Date: Wed, 27 Jan 2016 10:51:13 +0530
Message-ID: <1453872079-27140-1-git-send-email-anup.patel@broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Catalin Marinas <catalin.marinas@arm.com>, Joerg Roedel <joro@8bytes.org>, Will Deacon <will.deacon@arm.com>, Robin Murphy <Robin.Murphy@arm.com>, Sricharan R <sricharan@codeaurora.org>, Linux IOMMU <iommu@lists.linux-foundation.org>, Linux ARM Kernel <linux-arm-kernel@lists.infradead.org>
Cc: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Device Tree <devicetree@vger.kernel.org>, Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, Vikram Prakash <vikramp@broadcom.com>, Linux Kernel <linux-kernel@vger.kernel.org>, BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>, Anup Patel <anup.patel@broadcom.com>
List-Id: iommu@lists.linux-foundation.org

This patchset adds following to SMMUv1/SMMUv2 driver:
1. Support for domain type IOMMU_DOMAIN_DMA
2. Allow privilege instruction fetchs from MMU masters by having
a DT option to treat instruction fetch as data read

The patchset is based on '4.5-rc1' tag of linux mainline tree
and is available in smmu_v1 branch of
https://github.com/Broadcom/arm64-linux.git

All patches have been tested on Broadcom SoCs having SMMU-500.

Anup Patel (5):
  iommu/arm-smmu: Invoke DT probe from arm_smmu_of_setup()
  of: iommu: Increment DT node refcount in of_iommu_set_ops()
  iommu/arm-smmu: Add support for IOMMU_DOMAIN_DMA in SMMUv1/SMMUv2
    driver
  iommu/arm-smmu: Option to treat instruction fetch as data read for
    SMMUv2
  iommu/arm-smmu: Update bindings document for smmu-inst-as-data DT
    option

Sricharan R (1):
  iommu/arm-smmu: Init driver using IOMMU_OF_DECLARE

 .../devicetree/bindings/iommu/arm,smmu.txt         |  8 +++
 drivers/iommu/arm-smmu.c                           | 70 +++++++++++++++++-----
 drivers/iommu/of_iommu.c                           |  1 +
 3 files changed, 65 insertions(+), 14 deletions(-)

-- 
1.9.1
