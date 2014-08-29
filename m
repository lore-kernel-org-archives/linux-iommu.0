From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: [RFC PATCH 4/7] iommu: provide helper function to configure an IOMMU
	for an of master
Date: Fri, 29 Aug 2014 16:54:27 +0100
Message-ID: <1409327670-3495-5-git-send-email-will.deacon@arm.com>
References: <1409327670-3495-1-git-send-email-will.deacon@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1409327670-3495-1-git-send-email-will.deacon-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: jroedel-l3A5Bk7waGM@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org, Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

The generic IOMMU device-tree bindings can be used to add arbitrary OF
masters to an IOMMU with a compliant binding.

This patch introduces of_iommu_configure, which does exactly that.

Signed-off-by: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
---
 drivers/iommu/Kconfig    |  2 +-
 drivers/iommu/of_iommu.c | 36 ++++++++++++++++++++++++++++++++++++
 include/linux/of_iommu.h |  6 ++++++
 3 files changed, 43 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index dd5112265cc9..6d13f962f156 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -15,7 +15,7 @@ if IOMMU_SUPPORT
 
 config OF_IOMMU
        def_bool y
-       depends on OF
+       depends on OF && IOMMU_API
 
 config FSL_PAMU
 	bool "Freescale IOMMU support"
diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
index f9209666157c..a7d3b3a13b83 100644
--- a/drivers/iommu/of_iommu.c
+++ b/drivers/iommu/of_iommu.c
@@ -19,6 +19,7 @@
 
 #include <linux/export.h>
 #include <linux/limits.h>
+#include <linux/iommu.h>
 #include <linux/of.h>
 #include <linux/of_iommu.h>
 
@@ -90,6 +91,41 @@ int of_get_dma_window(struct device_node *dn, const char *prefix, int index,
 }
 EXPORT_SYMBOL_GPL(of_get_dma_window);
 
+int of_iommu_configure(struct device *dev)
+{
+	struct of_phandle_args iommu_spec;
+	struct bus_type *bus = dev->bus;
+	const struct iommu_ops *ops = bus->iommu_ops;
+	int ret = -EINVAL, idx = 0;
+
+	if (!iommu_present(bus))
+		return -ENODEV;
+
+	/*
+	 * We don't currently walk up the tree looking for a parent IOMMU.
+	 * See the `Notes:' section of
+	 * Documentation/devicetree/bindings/iommu/iommu.txt
+	 */
+	while (!of_parse_phandle_with_args(dev->of_node, "iommus",
+					   "#iommu-cells", idx,
+					   &iommu_spec)) {
+		void *data = of_iommu_get_data(iommu_spec.np);
+
+		of_node_put(iommu_spec.np);
+		if (!ops->add_device_master_ids)
+			return -ENODEV;
+
+		ret = ops->add_device_master_ids(dev, iommu_spec.args_count,
+						 iommu_spec.args, data);
+		if (ret)
+			break;
+
+		idx++;
+	}
+
+	return ret;
+}
+
 void __init of_iommu_init(void)
 {
 	struct device_node *np;
diff --git a/include/linux/of_iommu.h b/include/linux/of_iommu.h
index 29f2f3f88d6a..85c6d1152624 100644
--- a/include/linux/of_iommu.h
+++ b/include/linux/of_iommu.h
@@ -1,6 +1,7 @@
 #ifndef __OF_IOMMU_H
 #define __OF_IOMMU_H
 
+#include <linux/device.h>
 #include <linux/of.h>
 
 #ifdef CONFIG_OF_IOMMU
@@ -10,6 +11,7 @@ extern int of_get_dma_window(struct device_node *dn, const char *prefix,
 			     size_t *size);
 
 extern void of_iommu_init(void);
+extern int of_iommu_configure(struct device *dev);
 
 #else
 
@@ -21,6 +23,10 @@ static inline int of_get_dma_window(struct device_node *dn, const char *prefix,
 }
 
 static inline void of_iommu_init(void) { }
+static inline int of_iommu_configure(struct device *dev)
+{
+	return -ENODEV;
+}
 
 #endif	/* CONFIG_OF_IOMMU */
 
-- 
2.1.0
