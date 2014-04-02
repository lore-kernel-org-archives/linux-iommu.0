From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Subject: [PATCH 0/3] SH-Mobile IPMMU miscellaneous cleanups
Date: Thu,  3 Apr 2014 01:49:19 +0200
Message-ID: <1396482562-1851-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Return-path: <linux-sh-owner@vger.kernel.org>
Sender: linux-sh-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org
Cc: linux-sh@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

Hello,

These three patches are small cleanups for the SH-Mobile IPMMU driver. Nothing
special here, please see individual patches for details.

I plan to send a pull request in a couple of days.

Laurent Pinchart (2):
  iommu/shmobile: Don't ignore the ipmmu_iommu_init() return value
  iommu/shmobile: Use devm_ioremap_resource()

Paul Bolle (1):
  iommu/shmobile: Depend on ARCH_SHMOBILE

 drivers/iommu/Kconfig          |  2 +-
 drivers/iommu/shmobile-ipmmu.c | 20 +++++++-------------
 2 files changed, 8 insertions(+), 14 deletions(-)

-- 
Regards,

Laurent Pinchart

