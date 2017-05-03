From: Matthias Brugger <mbrugger@suse.com>
Subject: [PATCH] iommu/rockchip: Enable Rockchip IOMMU on ARM64
Date: Wed,  3 May 2017 17:19:40 +0200
Message-ID: <20170503151940.3987-1-mbrugger@suse.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: joro@8bytes.org
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, xxm@rock-chips.com, zhengsq@rock-chips.com, tfiga@chromium.org, ykaukab@suse.com
List-Id: iommu@lists.linux-foundation.org

From: Simon Xue <xxm@rock-chips.com>

This patch makes it possible to compile the rockchip-iommu driver on
ARM64, so that it can be used with 64-bit SoCs equipped with this type
of IOMMU.

Signed-off-by: Simon Xue <xxm@rock-chips.com>
Signed-off-by: Shunqian Zheng <zhengsq@rock-chips.com>
Signed-off-by: Tomasz Figa <tfiga@chromium.org>
Reviewed-by: Matthias Brugger <mbrugger@suse.com>
---
 drivers/iommu/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index 6ee3a25ae731..99c6366a2551 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -219,7 +219,7 @@ config OMAP_IOMMU_DEBUG
 
 config ROCKCHIP_IOMMU
 	bool "Rockchip IOMMU Support"
-	depends on ARM
+	depends on ARM || ARM64
 	depends on ARCH_ROCKCHIP || COMPILE_TEST
 	select IOMMU_API
 	select ARM_DMA_USE_IOMMU
-- 
2.12.0
