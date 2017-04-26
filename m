From: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH 0/4] iommu: Header file cleanups
Date: Wed, 26 Apr 2017 17:45:02 +0200
Message-ID: <1493221506-7651-1-git-send-email-joro@8bytes.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org
Cc: linux-kernel@vger.kernel.org, Joerg Roedel <joro@8bytes.org>
List-Id: iommu@lists.linux-foundation.org

Hi,

here is a small patch-set to remove some header dependencies
from the IOMMU header files. The linux/iommu.h file does not
include linux/pci.h and the iommu trace-event headers
anymore.

For this the report_iommu_fault function was moved to
iommu.c and the place relying on above includes were fixed.

Please review.

Thanks,

	Joerg

Joerg Roedel (4):
  iommu: Include device.h in iommu.h
  iommu: Move report_iommu_fault() to iommu.c
  iommu: Remove pci.h include from trace/events/iommu.h
  iommu: Remove trace-events include from iommu.h

 arch/arm64/mm/dma-mapping.c              |  1 +
 drivers/iommu/fsl_pamu.h                 |  1 +
 drivers/iommu/iommu.c                    | 42 ++++++++++++++++++++++++++++
 drivers/iommu/rockchip-iommu.c           |  1 +
 drivers/iommu/tegra-smmu.c               |  1 +
 drivers/media/platform/mtk-vpu/mtk_vpu.c |  1 +
 include/linux/dma-iommu.h                |  1 +
 include/linux/iommu.h                    | 47 ++++----------------------------
 include/trace/events/iommu.h             |  1 -
 9 files changed, 53 insertions(+), 43 deletions(-)

-- 
1.9.1
