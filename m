From: Thierry Reding <thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org>
Subject: [RFC 2/4] iommu: tegra/gart: Add device tree support
Date: Wed, 11 Apr 2012 14:10:28 +0200
Message-ID: <1334146230-1795-3-git-send-email-thierry.reding@avionic-design.de>
References: <1334146230-1795-1-git-send-email-thierry.reding@avionic-design.de>
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1334146230-1795-1-git-send-email-thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>, Colin Cross <ccross-z5hGa2qSFaRBDgjK7y7TUQ@public.gmane.org>, Jon Mayo <jmayo-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, David Airlie <airlied-cv59FeDIM0c@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Joerg Roedel <joerg.roedel-5C7GfCeVMHo@public.gmane.org>, Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

This commit adds device tree support for the GART hardware available on
NVIDIA Tegra 20 SoCs.

Signed-off-by: Thierry Reding <thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org>
---
 arch/arm/boot/dts/tegra20.dtsi         |    6 ++++++
 arch/arm/mach-tegra/board-dt-tegra20.c |    1 +
 drivers/iommu/tegra-gart.c             |   10 ++++++++++
 3 files changed, 17 insertions(+)

diff --git a/arch/arm/boot/dts/tegra20.dtsi b/arch/arm/boot/dts/tegra20.dtsi
index 55b28fd..cf3ff41 100644
--- a/arch/arm/boot/dts/tegra20.dtsi
+++ b/arch/arm/boot/dts/tegra20.dtsi
@@ -212,5 +212,11 @@
 		interrupts = < 0 97 0x04 >;
 		phy_type = "utmi";
 	};
+
+	gart: gart@7000f000 {
+		compatible = "nvidia,tegra20-gart";
+		reg = < 0x7000f000 0x00000100    /* controller registers */
+		        0x58000000 0x02000000 >; /* GART aperture */
+	};
 };
 
diff --git a/arch/arm/mach-tegra/board-dt-tegra20.c b/arch/arm/mach-tegra/board-dt-tegra20.c
index 57745e6..bffba1b 100644
--- a/arch/arm/mach-tegra/board-dt-tegra20.c
+++ b/arch/arm/mach-tegra/board-dt-tegra20.c
@@ -66,6 +66,7 @@ struct of_dev_auxdata tegra20_auxdata_lookup[] __initdata = {
 	OF_DEV_AUXDATA("nvidia,tegra20-ehci", TEGRA_USB3_BASE, "tegra-ehci.2",
 		       &tegra_ehci3_pdata),
 	OF_DEV_AUXDATA("nvidia,tegra20-pwm", TEGRA_PWFM_BASE, "tegra-pwm", NULL),
+	OF_DEV_AUXDATA("nvidia,tegra20-gart", TEGRA_MC_BASE, "tegra-gart", NULL),
 	{}
 };
 
diff --git a/drivers/iommu/tegra-gart.c b/drivers/iommu/tegra-gart.c
index f6bc1e6..4a571b7 100644
--- a/drivers/iommu/tegra-gart.c
+++ b/drivers/iommu/tegra-gart.c
@@ -29,6 +29,7 @@
 #include <linux/device.h>
 #include <linux/io.h>
 #include <linux/iommu.h>
+#include <linux/of.h>
 
 #include <asm/cacheflush.h>
 
@@ -422,6 +423,13 @@ const struct dev_pm_ops tegra_gart_pm_ops = {
 	.resume		= tegra_gart_resume,
 };
 
+#ifdef CONFIG_OF
+static struct of_device_id tegra_gart_of_match[] __devinitdata = {
+	{ .compatible = "nvidia,tegra20-gart", },
+	{ },
+};
+#endif
+
 static struct platform_driver tegra_gart_driver = {
 	.probe		= tegra_gart_probe,
 	.remove		= tegra_gart_remove,
@@ -429,6 +437,7 @@ static struct platform_driver tegra_gart_driver = {
 		.owner	= THIS_MODULE,
 		.name	= "tegra-gart",
 		.pm	= &tegra_gart_pm_ops,
+		.of_match_table = of_match_ptr(tegra_gart_of_match),
 	},
 };
 
@@ -448,4 +457,5 @@ module_exit(tegra_gart_exit);
 
 MODULE_DESCRIPTION("IOMMU API for GART in Tegra20");
 MODULE_AUTHOR("Hiroshi DOYU <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>");
+MODULE_ALIAS("platform:tegra-gart");
 MODULE_LICENSE("GPL v2");
-- 
1.7.10
