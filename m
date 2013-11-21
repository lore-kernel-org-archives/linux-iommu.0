From: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: [PATCHv6 02/13] iommu/of: introduce a global iommu device list
Date: Thu, 21 Nov 2013 15:40:38 +0200
Message-ID: <1385041249-7705-3-git-send-email-hdoyu@nvidia.com>
References: <1385041249-7705-1-git-send-email-hdoyu@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1385041249-7705-1-git-send-email-hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org, robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org
Cc: mark.rutland-5wv7dgnIgG8@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

This enables to find an populated IOMMU device via a device node. This
can be used to see if an dependee IOMMU is populated or not to keep
correct device population order. Client devices need to wait an IOMMU
to be populated.

Suggested by Thierry Reding and copied his example code.

Signed-off-by: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
v6:
New for v6.
---
 drivers/iommu/of_iommu.c | 37 +++++++++++++++++++++++++++++++++++++
 include/linux/of_iommu.h | 16 ++++++++++++++++
 2 files changed, 53 insertions(+)

diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
index ee249bc..5d1aeb9 100644
--- a/drivers/iommu/of_iommu.c
+++ b/drivers/iommu/of_iommu.c
@@ -20,6 +20,43 @@
 #include <linux/export.h>
 #include <linux/limits.h>
 #include <linux/of.h>
+#include <linux/of_iommu.h>
+#include <linux/device.h>
+
+static DEFINE_MUTEX(iommus_lock);
+static LIST_HEAD(iommus_list);
+
+void iommu_add(struct iommu *iommu)
+{
+	INIT_LIST_HEAD(&iommu->list);
+	mutex_lock(&iommus_lock);
+	list_add_tail(&iommu->list, &iommus_list);
+	mutex_unlock(&iommus_lock);
+}
+
+void iommu_del(struct iommu *iommu)
+{
+	INIT_LIST_HEAD(&iommu->list);
+	mutex_lock(&iommus_lock);
+	list_del(&iommu->list);
+	mutex_unlock(&iommus_lock);
+}
+
+static struct iommu *of_find_iommu_by_node(struct device_node *np)
+{
+	struct iommu *iommu;
+
+	mutex_lock(&iommus_lock);
+	list_for_each_entry(iommu, &iommus_list, list) {
+		if (iommu->dev->of_node == np) {
+			mutex_unlock(&iommus_lock);
+			return iommu;
+		}
+	}
+	mutex_unlock(&iommus_lock);
+
+	return NULL;
+}
 
 /**
  * of_get_dma_window - Parse *dma-window property and returns 0 if found.
diff --git a/include/linux/of_iommu.h b/include/linux/of_iommu.h
index 51a560f..a0aa9d4 100644
--- a/include/linux/of_iommu.h
+++ b/include/linux/of_iommu.h
@@ -3,10 +3,18 @@
 
 #ifdef CONFIG_OF_IOMMU
 
+struct iommu {
+	struct list_head list;
+	struct device *dev;
+};
+
 extern int of_get_dma_window(struct device_node *dn, const char *prefix,
 			     int index, unsigned long *busno, dma_addr_t *addr,
 			     size_t *size);
 
+extern void iommu_add(struct iommu *iommu);
+extern void iommu_del(struct iommu *iommu);
+
 #else
 
 static inline int of_get_dma_window(struct device_node *dn, const char *prefix,
@@ -16,6 +24,14 @@ static inline int of_get_dma_window(struct device_node *dn, const char *prefix,
 	return -EINVAL;
 }
 
+static inline void iommu_add(struct iommu *iommu)
+{
+}
+
+static inline void iommu_del(struct iommu *iommu)
+{
+}
+
 #endif	/* CONFIG_OF_IOMMU */
 
 #endif /* __OF_IOMMU_H */
-- 
1.8.1.5
