From: Anup Patel <anup.patel@broadcom.com>
Subject: [PATCH v2 0/2] FlexRM support in VFIO platform
Date: Thu, 20 Jul 2017 10:02:32 +0530
Message-ID: <1500525154-5200-1-git-send-email-anup.patel@broadcom.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Will Deacon <will.deacon@arm.com>, Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>, Baptiste Reynal <b.reynal@virtualopensystems.com>, Alex Williamson <alex.williamson@redhat.com>
Cc: Scott Branden <sbranden@broadcom.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, iommu@lists.linux-foundation.org, kvm@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com, Anup Patel <anup.patel@broadcom.com>
List-Id: iommu@lists.linux-foundation.org

This patchset primarily adds Broadcom FlexRM reset module for
VFIO platform driver. We also have minor improvments in IOMMU
and VFIO driver to allow VFIO no-IOMMU mode access to FlexRM.

The patches are based on Linux-4.13-rc1 and can also be
found at flexrm-vfio-v2 branch of
https://github.com/Broadcom/arm64-linux.git

Changes since v1:
 - Remove iommu_present() check in vfio_iommu_group_get()
 - Drop PATCH1-to-PATCH3 because IOMMU_CAP_BYPASS is not
   required
 - Move additional comments out of license header in
   vfio_platform_bcmflexrm.c

Anup Patel (2):
  vfio: Allow No-IOMMU mode without checking iommu_present()
  vfio: platform: reset: Add Broadcom FlexRM reset module

 drivers/vfio/platform/reset/Kconfig                |  9 +++
 drivers/vfio/platform/reset/Makefile               |  1 +
 .../vfio/platform/reset/vfio_platform_bcmflexrm.c  | 93 ++++++++++++++++++++++
 drivers/vfio/vfio.c                                |  7 +-
 4 files changed, 106 insertions(+), 4 deletions(-)
 create mode 100644 drivers/vfio/platform/reset/vfio_platform_bcmflexrm.c

-- 
2.7.4
