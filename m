From: Paul Bolle <pebolle@tiscali.nl>
Subject: [PATCH] iommu: shmobile: depend on ARCH_SHMOBILE
Date: Sat, 08 Feb 2014 22:21:54 +0100
Message-ID: <1391894514.19595.5.camel@x220>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>
Cc: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, Simon Horman <horms+renesas@verge.net.au>, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

Commit 78a2e12f51d9 ("iommu: shmobile: Enable driver compilation with
COMPILE_TEST") added an optional dependency on SH_MOBILE. But that
Kconfig symbol doesn't exist. It seems ARCH_SHMOBILE was intended. Use
that.

Signed-off-by: Paul Bolle <pebolle@tiscali.nl>
---
Completely untested.

 drivers/iommu/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index 79bbc21..df56e4c 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -207,7 +207,7 @@ config SHMOBILE_IOMMU
 	bool "IOMMU for Renesas IPMMU/IPMMUI"
 	default n
 	depends on ARM
-	depends on SH_MOBILE || COMPILE_TEST
+	depends on ARCH_SHMOBILE || COMPILE_TEST
 	select IOMMU_API
 	select ARM_DMA_USE_IOMMU
 	select SHMOBILE_IPMMU
-- 
1.8.5.3
