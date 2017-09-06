From: Anup Patel <anup.patel@broadcom.com>
Subject: [PATCH v7] FlexRM support in VFIO platform
Date: Wed,  6 Sep 2017 13:46:37 +0530
Message-ID: <1504685798-27645-1-git-send-email-anup.patel@broadcom.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Will Deacon <will.deacon@arm.com>, Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>, Baptiste Reynal <b.reynal@virtualopensystems.com>, Alex Williamson <alex.williamson@redhat.com>
Cc: Scott Branden <sbranden@broadcom.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, iommu@lists.linux-foundation.org, kvm@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com, Anup Patel <anup.patel@broadcom.com>
List-Id: iommu@lists.linux-foundation.org

This patchset primarily adds Broadcom FlexRM reset module for
VFIO platform driver.

The patches are based on Linux-4.13-rc3 and can also be
found at flexrm-vfio-v7 branch of
https://github.com/Broadcom/arm64-linux.git

Changes since v6:
 - Update the FlexRM ring flush sequence as suggested
   by HW folks
 - Shutdown all FlexRM ring anyway even if it fails on
   any of the FlexRM rings
 - Use dev_warn() instead of pr_warn()

Changes since v5:
 - Make kconfig option VFIO_PLATFORM_BCMFLEXRM_RESET
   default to ARCH_BCM_IPROC

Changes since v4:
 - Use "--timeout" instead of "timeout--" in
   vfio_platform_bcmflexrm_shutdown()

Changes since v3:
 - Improve "depends on" for Kconfig option
   VFIO_PLATFORM_BCMFLEXRM_RESET
 - Fix typo in pr_warn() called by
   vfio_platform_bcmflexrm_shutdown()
 - Return error from vfio_platform_bcmflexrm_shutdown()
   when FlexRM ring flush timeout happens

Changes since v2:
 - Remove PATCH1 because fixing VFIO no-IOMMU mode is
   a separate topic

Changes since v1:
 - Remove iommu_present() check in vfio_iommu_group_get()
 - Drop PATCH1-to-PATCH3 because IOMMU_CAP_BYPASS is not
   required
 - Move additional comments out of license header in
   vfio_platform_bcmflexrm.c

Anup Patel (1):
  vfio: platform: reset: Add Broadcom FlexRM reset module

 drivers/vfio/platform/reset/Kconfig                |   9 ++
 drivers/vfio/platform/reset/Makefile               |   1 +
 .../vfio/platform/reset/vfio_platform_bcmflexrm.c  | 115 +++++++++++++++++++++
 3 files changed, 125 insertions(+)
 create mode 100644 drivers/vfio/platform/reset/vfio_platform_bcmflexrm.c

-- 
2.7.4
