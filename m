From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Subject: [PATCH 2/2] [TEST] ARM: shmobile: koelsch-reference: Instantiate IPMMU-MX
Date: Fri, 28 Feb 2014 16:24:59 +0100
Message-ID: <1393601099-4413-3-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
References: <1393601099-4413-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1393601099-4413-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Sender: linux-sh-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org
Cc: linux-sh@vger.kernel.org, Ben Dooks <ben.dooks@codethink.co.uk>
List-Id: iommu@lists.linux-foundation.org

Not-Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 arch/arm/mach-shmobile/board-koelsch-reference.c | 30 ++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/arch/arm/mach-shmobile/board-koelsch-reference.c b/arch/arm/mach-shmobile/board-koelsch-reference.c
index a3fd302..d2f4ed8 100644
--- a/arch/arm/mach-shmobile/board-koelsch-reference.c
+++ b/arch/arm/mach-shmobile/board-koelsch-reference.c
@@ -24,6 +24,7 @@
 #include <linux/dma-mapping.h>
 #include <linux/kernel.h>
 #include <linux/of_platform.h>
+#include <linux/platform_data/ipmmu-vmsa.h>
 #include <linux/platform_data/rcar-du.h>
 #include <mach/common.h>
 #include <mach/irqs.h>
@@ -82,6 +83,34 @@ static void __init koelsch_add_du_device(void)
 	platform_device_register_full(&info);
 }
 
+/*
+ * IPMMUs
+ *
+ * MX: for JPU, 2DDMAC, VSP, DCU, FDP, IMR-LSX2, DU, VCP, VPC and VIN
+ */
+static struct resource ipmmu_mx_resources[] = {
+	DEFINE_RES_MEM(0xfe951800, 0x800),
+	DEFINE_RES_IRQ(gic_spi(222)),
+};
+
+static const struct ipmmu_vmsa_master ipmmu_mx_masters[] = {
+	{ "rcar-du-r8a7791", 15, },
+};
+
+static struct ipmmu_vmsa_platform_data ipmmu_mx_platform_data = {
+	.masters = ipmmu_mx_masters,
+	.num_masters = ARRAY_SIZE(ipmmu_mx_masters),
+};
+
+static void __init koelsch_add_ipmmu_devices(void)
+{
+	platform_device_register_resndata(NULL, "ipmmu-vmsa", -1,
+					  ipmmu_mx_resources,
+					  ARRAY_SIZE(ipmmu_mx_resources),
+					  &ipmmu_mx_platform_data,
+					  sizeof(ipmmu_mx_platform_data));
+}
+
 static void __init koelsch_add_standard_devices(void)
 {
 	/*
@@ -128,6 +157,7 @@ static void __init koelsch_add_standard_devices(void)
 	r8a7791_add_dt_devices();
 	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
 
+	koelsch_add_ipmmu_devices();
 	koelsch_add_du_device();
 }
 
-- 
1.8.3.2

