From: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 1/1] ARM: tegra: bus_notifier registers platform IOMMU devices
Date: Fri, 30 Nov 2012 14:19:51 +0200
Message-ID: <1354277991-21254-1-git-send-email-hdoyu@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org
Cc: linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org, nvmarkzhang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Most of platform devices are IOMMU'able in Tegra30 SoC. Registering
all IOMMU'able devices manually isn't nice. This patch allows
platform bus_notifier to register IOMMU devices. Map info can be
passed from DT. Info format is:

  dma-window = <0 0x40000000>;

TODO:
A map can be shared with mutiple devices. This info also could be
passed from DT or default map can be set in advance.

Signed-off-by: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
---
 drivers/iommu/tegra-smmu.c |   45 +++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 44 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
index 25c1210..1c49af9 100644
--- a/drivers/iommu/tegra-smmu.c
+++ b/drivers/iommu/tegra-smmu.c
@@ -38,6 +38,7 @@
 
 #include <asm/page.h>
 #include <asm/cacheflush.h>
+#include <asm/dma-iommu.h>
 
 enum smmu_hwgrp {
 	HWGRP_AFI,
@@ -1273,9 +1274,51 @@ static struct platform_driver tegra_smmu_driver = {
 	},
 };
 
+static int tegra_smmu_device_notifier(struct notifier_block *nb,
+				      unsigned long event, void *_dev)
+{
+	struct dma_iommu_mapping *map = NULL;
+	struct device *dev = _dev;
+	dma_addr_t base;
+	size_t size;
+	int err;
+
+	switch (event) {
+	case BUS_NOTIFY_ADD_DEVICE:
+		err = of_get_dma_window(dev->of_node, NULL, 0, NULL, &base,
+					&size);
+		if (!err)
+			map = arm_iommu_create_mapping(&platform_bus_type,
+						       base, size, 0);
+		if (IS_ERR_OR_NULL(map))
+			break;
+		if (arm_iommu_attach_device(dev, map)) {
+			arm_iommu_release_mapping(map);
+			dev_err(dev, "Failed to attach %s\n", dev_name(dev));
+		}
+		dev_dbg(dev, "Attached %s to map %p\n", dev_name(dev), map);
+		break;
+	default:
+		break;
+	}
+	return NOTIFY_DONE;
+}
+
+static struct notifier_block tegra_smmu_device_nb = {
+	.notifier_call = tegra_smmu_device_notifier,
+};
+
 static int __devinit tegra_smmu_init(void)
 {
-	return platform_driver_register(&tegra_smmu_driver);
+	int err;
+
+	err = platform_driver_register(&tegra_smmu_driver);
+	if (err)
+		return err;
+	if (IS_ENABLED(CONFIG_ARM_DMA_USE_IOMMU))
+		bus_register_notifier(&platform_bus_type,
+				      &tegra_smmu_device_nb);
+	return 0;
 }
 
 static void __exit tegra_smmu_exit(void)
-- 
1.7.9.5
