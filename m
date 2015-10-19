From: Magnus Damm <magnus.damm@gmail.com>
Subject: [PATCH] iommu/ipmmu-vmsa: Drop LPAE Kconfig dependency
Date: Mon, 19 Oct 2015 12:02:53 +0900
Message-ID: <20151019030253.6274.46547.sendpatchset@little-apple>
Return-path: <linux-sh-owner@vger.kernel.org>
Sender: linux-sh-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org
Cc: laurent.pinchart+renesas@ideasonboard.com, geert+renesas@glider.be, linux-sh@vger.kernel.org, joro@8bytes.org, linux-kernel@vger.kernel.org, horms+renesas@verge.net.au, Magnus Damm <magnus.damm@gmail.com>
List-Id: iommu@lists.linux-foundation.org

From: Magnus Damm <damm+renesas@opensource.se>

Neither the ARM page table code enabled by IOMMU_IO_PGTABLE_LPAE
nor the IPMMU_VMSA driver actually depends on ARM_LPAE, so get
rid of the dependency.

Tested with ipmmu-vmsa on r8a7794 ALT and a kernel config using:
 # CONFIG_ARM_LPAE is not set

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
---

 drivers/iommu/Kconfig |    1 -
 1 file changed, 1 deletion(-)

--- 0001/drivers/iommu/Kconfig
+++ work/drivers/iommu/Kconfig	2015-10-18 14:58:09.080513000 +0900
@@ -324,7 +324,6 @@ config SHMOBILE_IOMMU_L1SIZE
 
 config IPMMU_VMSA
 	bool "Renesas VMSA-compatible IPMMU"
-	depends on ARM_LPAE
 	depends on ARCH_SHMOBILE || COMPILE_TEST
 	select IOMMU_API
 	select IOMMU_IO_PGTABLE_LPAE
