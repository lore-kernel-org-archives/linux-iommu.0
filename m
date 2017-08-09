From: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH 2/4] iommu/pamu: Make driver depend on CONFIG_PHYS_64BIT
Date: Wed,  9 Aug 2017 16:46:52 +0200
Message-ID: <1502290014-2890-3-git-send-email-joro@8bytes.org>
References: <1502290014-2890-1-git-send-email-joro@8bytes.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1502290014-2890-1-git-send-email-joro@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org
Cc: Varun.Sethi@freescale.com, linux-kernel@vger.kernel.org, Joerg Roedel <jroedel@suse.de>
List-Id: iommu@lists.linux-foundation.org

From: Joerg Roedel <jroedel@suse.de>

Certain address calculations in the driver make the
assumption that phys_addr_t and dma_addr_t are 64 bit wide.
Force this by depending on CONFIG_PHYS_64BIT to be set.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 drivers/iommu/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index e73b7c5..e163b02 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -77,6 +77,7 @@ config IOMMU_DMA
 config FSL_PAMU
 	bool "Freescale IOMMU support"
 	depends on PCI
+	depends on PHYS_64BIT
 	depends on PPC_E500MC || (COMPILE_TEST && PPC)
 	select IOMMU_API
 	select GENERIC_ALLOCATOR
-- 
2.7.4
