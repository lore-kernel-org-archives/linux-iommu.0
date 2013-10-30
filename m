From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Subject: [PATCH v3] iommu: shmobile: Enable the driver on all ARM platforms
Date: Wed, 30 Oct 2013 12:20:43 +0100
Message-ID: <1383132043-5190-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Return-path: <linux-sh-owner@vger.kernel.org>
Sender: linux-sh-owner@vger.kernel.org
To: linux-sh@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Joerg Roedel <joro@8bytes.org>, iommu@lists.linux-foundation.org
List-Id: iommu@lists.linux-foundation.org

Renesas ARM platforms are transitioning from single-platform to
multi-platform kernels using the new ARCH_SHMOBILE_MULTI. Make the
driver available on all ARM platforms to enable it on both ARCH_SHMOBILE
and ARCH_SHMOBILE_MULTI and increase build testing coverage.

Don't enable COMPILE_TEST support as the driver doesn't compile on
non-ARM platforms due to usage of the ARM DMA IOMMU API.

Cc: Joerg Roedel <joro@8bytes.org>
Cc: iommu@lists.linux-foundation.org
Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/iommu/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index c880eba..3e7fdbb 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -206,7 +206,7 @@ config SHMOBILE_IPMMU_TLB
 config SHMOBILE_IOMMU
 	bool "IOMMU for Renesas IPMMU/IPMMUI"
 	default n
-	depends on (ARM && ARCH_SHMOBILE)
+	depends on ARM
 	select IOMMU_API
 	select ARM_DMA_USE_IOMMU
 	select SHMOBILE_IPMMU
-- 
1.8.1.5

