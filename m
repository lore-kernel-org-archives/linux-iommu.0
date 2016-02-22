From: Simon Horman <horms+renesas@verge.net.au>
Subject: [PATCH] iommu: ipmmu-vmsa: Use ARCH_RENESAS
Date: Mon, 22 Feb 2016 10:41:35 +0900
Message-ID: <1456105295-13497-1-git-send-email-horms+renesas@verge.net.au>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>
Cc: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, Magnus Damm <magnus.damm@gmail.com>, iommu@lists.linux-foundation.org, linux-renesas-soc@vger.kernel.org, Simon Horman <horms+renesas@verge.net.au>
List-Id: iommu@lists.linux-foundation.org

Make use of ARCH_RENESAS in place of ARCH_SHMOBILE.

This is part of an ongoing process to migrate from ARCH_SHMOBILE to
ARCH_RENESAS the motivation for which being that RENESAS seems to be a more
appropriate name than SHMOBILE for the majority of Renesas ARM based SoCs.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 drivers/iommu/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

 Based on the next branch of Joerg's iommu tree on kernel.org

diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index a1e75cba18e0..d4b38e4d27fe 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -266,7 +266,7 @@ config EXYNOS_IOMMU_DEBUG
 config IPMMU_VMSA
 	bool "Renesas VMSA-compatible IPMMU"
 	depends on ARM_LPAE
-	depends on ARCH_SHMOBILE || COMPILE_TEST
+	depends on ARCH_RENESAS || COMPILE_TEST
 	select IOMMU_API
 	select IOMMU_IO_PGTABLE_LPAE
 	select ARM_DMA_USE_IOMMU
-- 
2.1.4
