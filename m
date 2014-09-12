From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: [RFC PATCH v3 4/7] iommu: provide helper function to configure an
	IOMMU for an of master
Date: Fri, 12 Sep 2014 17:34:52 +0100
Message-ID: <1410539695-29128-5-git-send-email-will.deacon@arm.com>
References: <1410539695-29128-1-git-send-email-will.deacon@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1410539695-29128-1-git-send-email-will.deacon-5wv7dgnIgG8@public.gmane.org>
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

This patch introduces of_iommu_configure, which does exactly that. A
list of iommu_dma_mapping structures are created for each device, which
represent the set of IOMMU instances through which the device can
master. The list is protected by a kref count and freed when no users
remain. It is expected that DMA-mapping code will take a reference if it
wishes to make use of the IOMMU information.

Signed-off-by: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
---
 drivers/iommu/Kconfig       |  2 +-
 drivers/iommu/of_iommu.c    | 70 +++++++++++++++++++++++++++++++++++++++++++++
 include/linux/dma-mapping.h |  8 ++++++
 include/linux/of_iommu.h    | 10 +++++++
 4 files changed, 89 insertions(+), 1 deletion(-)

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
index 13d800c4ce25..8656b63f27ee 100644
--- a/drivers/iommu/of_iommu.c
+++ b/drivers/iommu/of_iommu.c
@@ -18,9 +18,11 @@
  */
 
 #include <linux/export.h>
+#include <linux/iommu.h>
 #include <linux/limits.h>
 #include <linux/of.h>
 #include <linux/of_iommu.h>
+#include <linux/slab.h>
 
 /**
  * of_get_dma_window - Parse *dma-window property and returns 0 if found.
@@ -90,6 +92,74 @@ int of_get_dma_window(struct device_node *dn, const char *prefix, int index,
 }
 EXPORT_SYMBOL_GPL(of_get_dma_window);
 
+struct iommu_dma_mapping *of_iommu_configure(struct device *dev)
+{
+	struct of_phandle_args iommu_spec;
+	struct iommu_dma_mapping *mapping;
+	struct device_node *np;
+	struct iommu_data *iommu = NULL;
+	int idx = 0;
+
+	/*
+	 * We don't currently walk up the tree looking for a parent IOMMU.
+	 * See the `Notes:' section of
+	 * Documentation/devicetree/bindings/iommu/iommu.txt
+	 */
+	while (!of_parse_phandle_with_args(dev->of_node, "iommus",
+					   "#iommu-cells", idx,
+					   &iommu_spec)) {
+		struct iommu_data *data;
+
+		np = iommu_spec.np;
+		data = of_iommu_get_data(np);
+
+		if (!data || !data->ops || !data->ops->of_xlate)
+			goto err_put_node;
+
+		if (!iommu) {
+			iommu = data;
+		} else if (iommu != data) {
+			/* We don't currently support multi-IOMMU masters */
+			pr_warn("Rejecting device %s with multiple IOMMU instances\n",
+				dev_name(dev));
+			goto err_put_node;
+		}
+
+		if (!data->ops->of_xlate(dev, &iommu_spec))
+			goto err_put_node;
+
+		of_node_put(np);
+		idx++;
+	}
+
+	if (!iommu)
+		return NULL;
+
+	mapping = kzalloc(sizeof(*mapping), GFP_KERNEL);
+	if (!mapping)
+		return NULL;
+
+	kref_init(&mapping->kref);
+	INIT_LIST_HEAD(&mapping->node);
+	mapping->iommu = iommu;
+	return mapping;
+
+err_put_node:
+	of_node_put(np);
+	return NULL;
+}
+
+void of_iommu_deconfigure(struct kref *kref)
+{
+	struct iommu_dma_mapping *mapping, *curr, *next;
+
+	mapping = container_of(kref, struct iommu_dma_mapping, kref);
+	list_for_each_entry_safe(curr, next, &mapping->node, node) {
+		list_del(&curr->node);
+		kfree(curr);
+	}
+}
+
 void __init of_iommu_init(void)
 {
 	struct device_node *np;
diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index 1e944e77d38d..e60e52d82db9 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -62,6 +62,14 @@ struct dma_map_ops {
 	int is_phys;
 };
 
+struct iommu_data;
+
+struct iommu_dma_mapping {
+	struct iommu_data *iommu;
+	struct list_head node;
+	struct kref kref;
+};
+
 #define DMA_BIT_MASK(n)	(((n) == 64) ? ~0ULL : ((1ULL<<(n))-1))
 
 #define DMA_MASK_NONE	0x0ULL
diff --git a/include/linux/of_iommu.h b/include/linux/of_iommu.h
index 0a685e0ab33e..af6179557005 100644
--- a/include/linux/of_iommu.h
+++ b/include/linux/of_iommu.h
@@ -1,9 +1,12 @@
 #ifndef __OF_IOMMU_H
 #define __OF_IOMMU_H
 
+#include <linux/device.h>
 #include <linux/iommu.h>
 #include <linux/of.h>
 
+struct iommu_dma_mapping;
+
 #ifdef CONFIG_OF_IOMMU
 
 extern int of_get_dma_window(struct device_node *dn, const char *prefix,
@@ -11,6 +14,8 @@ extern int of_get_dma_window(struct device_node *dn, const char *prefix,
 			     size_t *size);
 
 extern void of_iommu_init(void);
+extern struct iommu_dma_mapping *of_iommu_configure(struct device *dev);
+extern void of_iommu_deconfigure(struct kref *kref);
 
 #else
 
@@ -22,6 +27,11 @@ static inline int of_get_dma_window(struct device_node *dn, const char *prefix,
 }
 
 static inline void of_iommu_init(void) { }
+static inline struct iommu_dma_mapping *of_iommu_configure(struct device *dev)
+{
+	return NULL;
+}
+static inline void of_iommu_deconfigure(struct kref *kref) { }
 
 #endif	/* CONFIG_OF_IOMMU */
 
-- 
2.1.0
