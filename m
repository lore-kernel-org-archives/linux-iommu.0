From: Liviu Dudau <Liviu.Dudau@arm.com>
Subject: [PATCH] iommu/ipmmu-vmsa: Do not replace bus IOMMU ops on driver init.
Date: Mon, 18 Sep 2017 11:04:44 +0100
Message-ID: <20170918100444.21878-1-Liviu.Dudau@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Cc: Magnus Damm <damm+renesas@opensource.se>, Geert Uytterhoeven <geert+renesas@glider.be>, Shawn Lin <shawn.lin@rock-chips.com>, Joerg Roedel <joro@8bytes.org>, IOMMU ML <iommu@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: iommu@lists.linux-foundation.org

If the IPMMU driver is compiled in the kernel it will replace the
platform bus IOMMU ops on running the ipmmu_init() function, regardless
if there is any IPMMU hardware present or not. This screws up systems
that just want to build a generic kernel that runs on multiple platforms
and use a different IOMMU implementation.

Move the bus_set_iommu() call at the end of the ipmmu_probe() function
when we know that hardware is present. With current IOMMU framework it
should be safe (at least for OF case).

Now that the ipmmu_init() and ipmmu_exit() functions are simple calls to
platform_driver_register() and platform_driver_unregister(), replace
them with the module_platform_driver() macro call.

Signed-off-by: Liviu Dudau <Liviu.Dudau@arm.com>
Cc: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/iommu/ipmmu-vmsa.c | 29 +++++------------------------
 1 file changed, 5 insertions(+), 24 deletions(-)

diff --git a/drivers/iommu/ipmmu-vmsa.c b/drivers/iommu/ipmmu-vmsa.c
index 2a38aa15be17d..c60569c74678d 100644
--- a/drivers/iommu/ipmmu-vmsa.c
+++ b/drivers/iommu/ipmmu-vmsa.c
@@ -1055,10 +1055,11 @@ static int ipmmu_probe(struct platform_device *pdev)
 	ipmmu_device_reset(mmu);
 
 	/*
-	 * We can't create the ARM mapping here as it requires the bus to have
-	 * an IOMMU, which only happens when bus_set_iommu() is called in
-	 * ipmmu_init() after the probe function returns.
+	 * Now that we have validated the presence of the hardware, set
+	 * the bus IOMMU ops to enable future domain and device setup.
 	 */
+	if (!iommu_present(&platform_bus_type))
+		bus_set_iommu(&platform_bus_type, &ipmmu_ops);
 
 	spin_lock(&ipmmu_devices_lock);
 	list_add(&mmu->list, &ipmmu_devices);
@@ -1100,27 +1101,7 @@ static struct platform_driver ipmmu_driver = {
 	.remove	= ipmmu_remove,
 };
 
-static int __init ipmmu_init(void)
-{
-	int ret;
-
-	ret = platform_driver_register(&ipmmu_driver);
-	if (ret < 0)
-		return ret;
-
-	if (!iommu_present(&platform_bus_type))
-		bus_set_iommu(&platform_bus_type, &ipmmu_ops);
-
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
 
 MODULE_DESCRIPTION("IOMMU API for Renesas VMSA-compatible IPMMU");
 MODULE_AUTHOR("Laurent Pinchart <laurent.pinchart@ideasonboard.com>");
-- 
2.14.1
