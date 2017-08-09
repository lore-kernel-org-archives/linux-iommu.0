From: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH 1/4] iommu/pamu: Let PAMU depend on PCI
Date: Wed,  9 Aug 2017 16:46:51 +0200
Message-ID: <1502290014-2890-2-git-send-email-joro@8bytes.org>
References: <1502290014-2890-1-git-send-email-joro@8bytes.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1502290014-2890-1-git-send-email-joro@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org
Cc: Varun.Sethi@freescale.com, linux-kernel@vger.kernel.org, Joerg Roedel <jroedel@suse.de>
List-Id: iommu@lists.linux-foundation.org

From: Joerg Roedel <jroedel@suse.de>

The driver does not compile when PCI is not selected, so
make it depend on it.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 drivers/iommu/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index f73ff28..e73b7c5 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -76,6 +76,7 @@ config IOMMU_DMA
 
 config FSL_PAMU
 	bool "Freescale IOMMU support"
+	depends on PCI
 	depends on PPC_E500MC || (COMPILE_TEST && PPC)
 	select IOMMU_API
 	select GENERIC_ALLOCATOR
-- 
2.7.4
