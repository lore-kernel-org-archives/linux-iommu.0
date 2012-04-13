From: Thierry Reding <thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org>
Subject: [PATCH 2/3] iommu: tegra/gart: Add device tree support
Date: Fri, 13 Apr 2012 15:08:08 +0200
Message-ID: <1334322489-837-2-git-send-email-thierry.reding@avionic-design.de>
References: <1334322489-837-1-git-send-email-thierry.reding@avionic-design.de>
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1334322489-837-1-git-send-email-thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>, Colin Cross <ccross-z5hGa2qSFaRBDgjK7y7TUQ@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Joerg Roedel <joerg.roedel-5C7GfCeVMHo@public.gmane.org>, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

This commit adds device tree support for the GART hardware available on
NVIDIA Tegra 20 SoCs.

Signed-off-by: Thierry Reding <thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org>
---
 .../devicetree/bindings/iommu/nvidia,tegra20-gart.txt    |   14 ++++++++++++++
 drivers/iommu/tegra-gart.c                               |   11 +++++++++++
 2 files changed, 25 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iommu/nvidia,tegra20-gart.txt

diff --git a/Documentation/devicetree/bindings/iommu/nvidia,tegra20-gart.txt b/Documentation/devicetree/bindings/iommu/nvidia,tegra20-gart.txt
new file mode 100644
index 0000000..2d87b91
--- /dev/null
+++ b/Documentation/devicetree/bindings/iommu/nvidia,tegra20-gart.txt
@@ -0,0 +1,14 @@
+NVIDIA Tegra 20 GART
+
+Required properties:
+- compatible: "nvidia,tegra20-gart"
+- reg: Two pairs of cells specifying the physical address and size of
+  the memory controller registers and the GART aperture respectively.
+
+Example:
+
+	gart: gart@7000f000 {
+		compatible = "nvidia,tegra20-gart";
+		reg = < 0x7000f000 0x00000100    /* controller registers */
+		        0x58000000 0x02000000 >; /* GART aperture */
+	};
diff --git a/drivers/iommu/tegra-gart.c b/drivers/iommu/tegra-gart.c
index f6bc1e6..40533bb 100644
--- a/drivers/iommu/tegra-gart.c
+++ b/drivers/iommu/tegra-gart.c
@@ -29,6 +29,7 @@
 #include <linux/device.h>
 #include <linux/io.h>
 #include <linux/iommu.h>
+#include <linux/of.h>
 
 #include <asm/cacheflush.h>
 
@@ -422,6 +423,14 @@ const struct dev_pm_ops tegra_gart_pm_ops = {
 	.resume		= tegra_gart_resume,
 };
 
+#ifdef CONFIG_OF
+static struct of_device_id tegra_gart_of_match[] __devinitdata = {
+	{ .compatible = "nvidia,tegra20-gart", },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, tegra_gart_of_match);
+#endif
+
 static struct platform_driver tegra_gart_driver = {
 	.probe		= tegra_gart_probe,
 	.remove		= tegra_gart_remove,
@@ -429,6 +438,7 @@ static struct platform_driver tegra_gart_driver = {
 		.owner	= THIS_MODULE,
 		.name	= "tegra-gart",
 		.pm	= &tegra_gart_pm_ops,
+		.of_match_table = of_match_ptr(tegra_gart_of_match),
 	},
 };
 
@@ -448,4 +458,5 @@ module_exit(tegra_gart_exit);
 
 MODULE_DESCRIPTION("IOMMU API for GART in Tegra20");
 MODULE_AUTHOR("Hiroshi DOYU <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>");
+MODULE_ALIAS("platform:tegra-gart");
 MODULE_LICENSE("GPL v2");
-- 
1.7.10
