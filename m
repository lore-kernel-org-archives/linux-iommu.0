From: Magnus Damm <magnus.damm@gmail.com>
Subject: [PATCH v3 06/06] iommu/ipmmu-vmsa: Drop LPAE Kconfig dependency
Date: Fri, 03 Jun 2016 00:56:18 +0900
Message-ID: <20160602155618.31018.67078.sendpatchset@little-apple>
References: <20160602155519.31018.59925.sendpatchset@little-apple>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160602155519.31018.59925.sendpatchset@little-apple>
Sender: linux-kernel-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org
Cc: laurent.pinchart+renesas@ideasonboard.com, geert+renesas@glider.be, joro@8bytes.org, linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org, horms+renesas@verge.net.au, Magnus Damm <magnus.damm@gmail.com>, robin.murphy@arm.com, m.szyprowski@samsung.com
List-Id: iommu@lists.linux-foundation.org

From: Magnus Damm <damm+renesas@opensource.se>

Neither the ARM page table code enabled by IOMMU_IO_PGTABLE_LPAE
nor the IPMMU_VMSA driver actually depends on ARM_LPAE, so get
rid of the dependency.

Tested with ipmmu-vmsa on r8a7794 ALT and a kernel config using:
 # CONFIG_ARM_LPAE is not set

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---

 Changes since V2:
 - None

 Changes since V1:
 - Rebased on top of ARCH_RENESAS change
 - Added Acked-by from Laurent

 drivers/iommu/Kconfig |    1 -
 1 file changed, 1 deletion(-)

--- 0001/drivers/iommu/Kconfig
+++ work/drivers/iommu/Kconfig	2016-06-02 22:17:14.950607110 +0900
@@ -273,7 +273,6 @@ config EXYNOS_IOMMU_DEBUG
 
 config IPMMU_VMSA
 	bool "Renesas VMSA-compatible IPMMU"
-	depends on ARM_LPAE
 	depends on ARCH_RENESAS || COMPILE_TEST
 	select IOMMU_API
 	select IOMMU_IO_PGTABLE_LPAE
