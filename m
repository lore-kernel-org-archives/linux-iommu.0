From: Liviu Dudau <Liviu.Dudau@arm.com>
Subject: [PATCH] iommu/ipmmu-vmsa: Simplify driver probing.
Date: Tue, 21 Nov 2017 14:02:57 +0000
Message-ID: <20171121140257.934-1-Liviu.Dudau@arm.com>
References: <20171121120801.GK5165@e110455-lin.cambridge.arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171121120801.GK5165@e110455-lin.cambridge.arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Magnus Damm <damm+renesas@opensource.se>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Joerg Roedel <jroedel@suse.de>, IOMMU ML <iommu@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Liviu Dudau <liviu.dudau@arm.com>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, Alex Williamson <alex.williamson@redhat.com>
List-Id: iommu@lists.linux-foundation.org

The IPMMU driver still uses initcalls to do its initialisation, while
other IOMMU drivers have moved to probe deferal mechanism. Update
the IPMMU driver so that it can use modern driver probing which allows
for it to be compiled together with other IOMMU drivers and not
trying at boot time to replace bus masters for platforms that don't
use IPMMU.

Signed-off-by: Liviu Dudau <liviu.dudau@arm.com>
Cc: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Cc: Magnus Damm <damm+renesas@opensource.se>
Cc: Alex Williamson <alex.williamson@redhat.com>
---
 drivers/iommu/ipmmu-vmsa.c | 47 +++-------------------------------------------
 1 file changed, 3 insertions(+), 44 deletions(-)

diff --git a/drivers/iommu/ipmmu-vmsa.c b/drivers/iommu/ipmmu-vmsa.c
index 8dce3a9de9d86..6eea75ca3c92e 100644
--- a/drivers/iommu/ipmmu-vmsa.c
+++ b/drivers/iommu/ipmmu-vmsa.c
@@ -1039,18 +1039,10 @@ static int ipmmu_probe(struct platform_device *pdev)
 		if (ret)
 			return ret;
 
-#if defined(CONFIG_IOMMU_DMA)
 		if (!iommu_present(&platform_bus_type))
 			bus_set_iommu(&platform_bus_type, &ipmmu_ops);
-#endif
 	}
 
-	/*
-	 * We can't create the ARM mapping here as it requires the bus to have
-	 * an IOMMU, which only happens when bus_set_iommu() is called in
-	 * ipmmu_init() after the probe function returns.
-	 */
-
 	platform_set_drvdata(pdev, mmu);
 
 	return 0;
@@ -1079,46 +1071,13 @@ static struct platform_driver ipmmu_driver = {
 	.remove	= ipmmu_remove,
 };
 
-static int __init ipmmu_init(void)
-{
-	static bool setup_done;
-	int ret;
-
-	if (setup_done)
-		return 0;
-
-	ret = platform_driver_register(&ipmmu_driver);
-	if (ret < 0)
-		return ret;
-
-#if defined(CONFIG_ARM) && !defined(CONFIG_IOMMU_DMA)
-	if (!iommu_present(&platform_bus_type))
-		bus_set_iommu(&platform_bus_type, &ipmmu_ops);
-#endif
-
-	setup_done = true;
-	return 0;
-}
-
-static void __exit ipmmu_exit(void)
-{
-	return platform_driver_unregister(&ipmmu_driver);
-}
-
-subsys_initcall(ipmmu_init);
-module_exit(ipmmu_exit);
+module_platform_driver(ipmmu_driver);
 
 #ifdef CONFIG_IOMMU_DMA
-static int __init ipmmu_vmsa_iommu_of_setup(struct device_node *np)
-{
-	ipmmu_init();
-	return 0;
-}
 
-IOMMU_OF_DECLARE(ipmmu_vmsa_iommu_of, "renesas,ipmmu-vmsa",
-		 ipmmu_vmsa_iommu_of_setup);
+IOMMU_OF_DECLARE(ipmmu_vmsa_iommu_of, "renesas,ipmmu-vmsa", NULL);
 IOMMU_OF_DECLARE(ipmmu_r8a7795_iommu_of, "renesas,ipmmu-r8a7795",
-		 ipmmu_vmsa_iommu_of_setup);
+		 NULL);
 #endif
 
 MODULE_DESCRIPTION("IOMMU API for Renesas VMSA-compatible IPMMU");
-- 
2.15.0
