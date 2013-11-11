From: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: [PATCHv4 2/7] driver/core: Populate IOMMU'able devices in order
Date: Mon, 11 Nov 2013 10:31:53 +0200
Message-ID: <1384158718-4756-3-git-send-email-hdoyu@nvidia.com>
References: <1384158718-4756-1-git-send-email-hdoyu@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1384158718-4756-1-git-send-email-hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org, swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org
Cc: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

An "IOMMU device" on the bus is poplulated first, "IOMMU'able devices"
are done later.

With CONFIG_OF_IOMMU, "#stream-id-cells" DT binding would be used to
identify whether a device is IOMMU'able or not. If a device is
IOMMU'able, we'll defer to populate that device till an iommu device
is populated. Once an iommu device is populated, "dev->bus->iommu_ops"
is set in the bus. Then, those defered IOMMU'able devices are
populated and configured as IOMMU'abled with help of the already
populated iommu device via iommu_ops->add_device().

Signed-off-by: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
---
Update:
This is newly added, and the successor of the following RFC:
  [RFC][PATCHv3+ 1/2] driver/core: Add of_iommu_attach()
  http://lists.linuxfoundation.org/pipermail/iommu/2013-November/006914.html
---
 drivers/base/dd.c        |  5 +++++
 drivers/iommu/of_iommu.c | 33 +++++++++++++++++++++++++++++++++
 include/linux/of_iommu.h |  7 +++++++
 3 files changed, 45 insertions(+)

diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index 35fa368..6e892d4 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -25,6 +25,7 @@
 #include <linux/async.h>
 #include <linux/pm_runtime.h>
 #include <linux/pinctrl/devinfo.h>
+#include <linux/of_iommu.h>
 
 #include "base.h"
 #include "power/power.h"
@@ -273,6 +274,10 @@ static int really_probe(struct device *dev, struct device_driver *drv)
 
 	dev->driver = drv;
 
+	ret = of_iommu_attach(dev);
+	if (ret)
+		goto probe_failed;
+
 	/* If using pinctrl, bind pins now before probing */
 	ret = pinctrl_bind_pins(dev);
 	if (ret)
diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
index ee249bc..335bf6a 100644
--- a/drivers/iommu/of_iommu.c
+++ b/drivers/iommu/of_iommu.c
@@ -20,6 +20,8 @@
 #include <linux/export.h>
 #include <linux/limits.h>
 #include <linux/of.h>
+#include <linux/device.h>
+#include <linux/iommu.h>
 
 /**
  * of_get_dma_window - Parse *dma-window property and returns 0 if found.
@@ -88,3 +90,34 @@ int of_get_dma_window(struct device_node *dn, const char *prefix, int index,
 	return 0;
 }
 EXPORT_SYMBOL_GPL(of_get_dma_window);
+
+static bool of_is_iommuable(struct device *dev)
+{
+	size_t bytes;
+	const __be32 *prop;
+	const char *propname = "#stream-id-cells";
+
+	prop = of_get_property(dev->of_node, propname, &bytes);
+	if (!prop || !bytes)
+		return false;
+
+	pr_debug("%s=%d %s\n", propname, bytes, dev_name(dev));
+	return true;
+}
+
+int of_iommu_attach(struct device *dev)
+{
+	struct iommu_ops *ops;
+
+	if (!of_is_iommuable(dev))
+		return 0;
+
+	ops = dev->bus->iommu_ops;
+	if (!ops)
+		return -EPROBE_DEFER;
+
+	if (ops->add_device)
+		return ops->add_device(dev);
+
+	return 0;
+}
diff --git a/include/linux/of_iommu.h b/include/linux/of_iommu.h
index 51a560f..3457489 100644
--- a/include/linux/of_iommu.h
+++ b/include/linux/of_iommu.h
@@ -7,6 +7,8 @@ extern int of_get_dma_window(struct device_node *dn, const char *prefix,
 			     int index, unsigned long *busno, dma_addr_t *addr,
 			     size_t *size);
 
+extern int of_iommu_attach(struct device *dev);
+
 #else
 
 static inline int of_get_dma_window(struct device_node *dn, const char *prefix,
@@ -16,6 +18,11 @@ static inline int of_get_dma_window(struct device_node *dn, const char *prefix,
 	return -EINVAL;
 }
 
+static inline int of_iommu_attach(struct device *dev)
+{
+	return 0;
+}
+
 #endif	/* CONFIG_OF_IOMMU */
 
 #endif /* __OF_IOMMU_H */
-- 
1.8.1.5
