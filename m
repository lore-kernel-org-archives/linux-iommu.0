From: Jeffy Chen <jeffy.chen@rock-chips.com>
Subject: [PATCH] iommu/rockchip: Remove build dependency on ARM
Date: Wed, 10 May 2017 18:28:12 +0800
Message-ID: <1494412092-25458-1-git-send-email-jeffy.chen@rock-chips.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: heiko@sntech.de, briannorris@chromium.org, dianders@chromium.org, tfiga@chromium.org, seanpaul@chromium.org, zyw@rock-chips.com, mark.yao@rock-chips.com, Jeffy Chen <jeffy.chen@rock-chips.com>, iommu@lists.linux-foundation.org, Joerg Roedel <joro@8bytes.org>
List-Id: iommu@lists.linux-foundation.org

This patch removes the build dependency on ARM, so we can build on arm64
as well.

Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>

---

 drivers/iommu/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index 6ee3a25..cb26f45 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -219,7 +219,6 @@ config OMAP_IOMMU_DEBUG
 
 config ROCKCHIP_IOMMU
 	bool "Rockchip IOMMU Support"
-	depends on ARM
 	depends on ARCH_ROCKCHIP || COMPILE_TEST
 	select IOMMU_API
 	select ARM_DMA_USE_IOMMU
-- 
2.1.4
