From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Subject: [PATCH 0/2] Renesas VMSA-compatible IPMMU driver
Date: Fri, 28 Feb 2014 16:24:57 +0100
Message-ID: <1393601099-4413-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Return-path: <linux-sh-owner@vger.kernel.org>
Sender: linux-sh-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org
Cc: linux-sh@vger.kernel.org, Ben Dooks <ben.dooks@codethink.co.uk>
List-Id: iommu@lists.linux-foundation.org

Hello,

This patch set adds a new driver for the Renesas IOMMU found in the R-Car H2
(r8a7790) and R-Car M2 (r8a7791) SoCs. Despite being called IPMMU like the
IOMMU present in older ARM Sh Mobile SoCs, the hardware has nothing in common
with the previous versions and thus requires a separate driver.

This IPMMU is compatible with the ARM VMSA short- and long-descriptor formats
(although some minor differences seem to exist, most probably due to hardware
bugs). The register set, however, is not compatible with the MMU-400 or
MMU-500. The existing arm-smmu driver can't thus be reused.

The second patch (not meant to be merged) in the set instanciates a platform
device for the IPMMU MX and associates it with the DU. The IPMMU can then be
tested using the rcar-du-drm driver. No modification is required to that
driver, as IOMMU integration is handled transparently by the ARM DMA
implementation.

One major problem still exist, in that the ARM DMA IOMMU backend doesn't seem
to mmap memory correctly to userspace. Tests carried on with the KMS modetest
application left the display hopelessly blank, until I decided to fill the KMS
buffers with a test pattern from inside the kernel. Although this makes the
IPMMU unusable at the moment, it shouldn't block review of the driver as it
shouldn't be involved in the problem. I'm of course investigating this.

Laurent Pinchart (2):
  iommu: Add driver for Renesas VMSA-compatible IPMMU
  [TEST] ARM: shmobile: koelsch-reference: Instantiate IPMMU-MX

 arch/arm/mach-shmobile/board-koelsch-reference.c |   30 +
 drivers/iommu/Kconfig                            |   12 +
 drivers/iommu/Makefile                           |    1 +
 drivers/iommu/ipmmu-vmsa.c                       | 1070 ++++++++++++++++++++++
 include/linux/platform_data/ipmmu-vmsa.h         |   24 +
 5 files changed, 1137 insertions(+)
 create mode 100644 drivers/iommu/ipmmu-vmsa.c
 create mode 100644 include/linux/platform_data/ipmmu-vmsa.h

-- 
Regards,

Laurent Pinchart

