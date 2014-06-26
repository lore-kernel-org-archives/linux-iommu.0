From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [RFC 01/10] iommu: Add IOMMU device registry
Date: Thu, 26 Jun 2014 22:49:41 +0200
Message-ID: <1403815790-8548-2-git-send-email-thierry.reding@gmail.com>
References: <1403815790-8548-1-git-send-email-thierry.reding@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1403815790-8548-1-git-send-email-thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: Olav Haugan <ohaugan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Grant Grundler <grundler-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Rhyland Klein <rklein-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Marc Zyngier <marc.zyngier-5wv7dgnIgG8@public.gmane.org>, Allen Martin <amartin-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Paul Walmsley <pwalmsley-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Cho KyongHo <pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Dave Martin <Dave.Martin-5wv7dgnIgG8@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

From: Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>

Add an IOMMU device registry for drivers to register with and implement
a method for users of the IOMMU API to attach to an IOMMU device. This
allows to support deferred probing and gives the IOMMU API a convenient
hook to perform early initialization of a device if necessary.

Signed-off-by: Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
---
 drivers/iommu/iommu.c | 93 +++++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/iommu.h | 27 +++++++++++++++
 2 files changed, 120 insertions(+)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 806b55d056b7..5e9e82c73bbf 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -29,8 +29,12 @@
 #include <linux/idr.h>
 #include <linux/notifier.h>
 #include <linux/err.h>
+#include <linux/of.h>
 #include <trace/events/iommu.h>
 
+static DEFINE_MUTEX(iommus_lock);
+static LIST_HEAD(iommus);
+
 static struct kset *iommu_group_kset;
 static struct ida iommu_group_ida;
 static struct mutex iommu_group_mutex;
@@ -1004,3 +1008,92 @@ int iommu_domain_set_attr(struct iommu_domain *domain,
 	return ret;
 }
 EXPORT_SYMBOL_GPL(iommu_domain_set_attr);
+
+int iommu_add(struct iommu *iommu)
+{
+	mutex_lock(&iommus_lock);
+	list_add_tail(&iommu->list, &iommus);
+	mutex_unlock(&iommus_lock);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(iommu_add);
+
+void iommu_remove(struct iommu *iommu)
+{
+	mutex_lock(&iommus_lock);
+	list_del_init(&iommu->list);
+	mutex_unlock(&iommus_lock);
+}
+EXPORT_SYMBOL_GPL(iommu_remove);
+
+static int of_iommu_attach(struct device *dev)
+{
+	struct of_phandle_iter iter;
+	struct iommu *iommu;
+
+	mutex_lock(&iommus_lock);
+
+	of_property_for_each_phandle_with_args(iter, dev->of_node, "iommus",
+					       "#iommu-cells", 0) {
+		bool found = false;
+		int err;
+
+		/* skip disabled IOMMUs */
+		if (!of_device_is_available(iter.out_args.np))
+			continue;
+
+		list_for_each_entry(iommu, &iommus, list) {
+			if (iommu->dev->of_node == iter.out_args.np) {
+				err = iommu->ops->attach(iommu, dev);
+				if (err < 0) {
+				}
+
+				found = true;
+			}
+		}
+
+		if (!found) {
+			mutex_unlock(&iommus_lock);
+			return -EPROBE_DEFER;
+		}
+	}
+
+	mutex_unlock(&iommus_lock);
+
+	return 0;
+}
+
+static int of_iommu_detach(struct device *dev)
+{
+	/* TODO: implement */
+	return -ENOSYS;
+}
+
+int iommu_attach(struct device *dev)
+{
+	int err = 0;
+
+	if (IS_ENABLED(CONFIG_OF) && dev->of_node) {
+		err = of_iommu_attach(dev);
+		if (!err)
+			return 0;
+	}
+
+	return err;
+}
+EXPORT_SYMBOL_GPL(iommu_attach);
+
+int iommu_detach(struct device *dev)
+{
+	int err = 0;
+
+	if (IS_ENABLED(CONFIG_OF) && dev->of_node) {
+		err = of_iommu_detach(dev);
+		if (!err)
+			return 0;
+	}
+
+	return err;
+}
+EXPORT_SYMBOL_GPL(iommu_detach);
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 284a4683fdc1..ac2ceef194d4 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -43,6 +43,17 @@ struct notifier_block;
 typedef int (*iommu_fault_handler_t)(struct iommu_domain *,
 			struct device *, unsigned long, int, void *);
 
+struct iommu {
+	struct device *dev;
+
+	struct list_head list;
+
+	const struct iommu_ops *ops;
+};
+
+int iommu_add(struct iommu *iommu);
+void iommu_remove(struct iommu *iommu);
+
 struct iommu_domain_geometry {
 	dma_addr_t aperture_start; /* First address that can be mapped    */
 	dma_addr_t aperture_end;   /* Last address that can be mapped     */
@@ -130,6 +141,9 @@ struct iommu_ops {
 	/* Get the numer of window per domain */
 	u32 (*domain_get_windows)(struct iommu_domain *domain);
 
+	int (*attach)(struct iommu *iommu, struct device *dev);
+	int (*detach)(struct iommu *iommu, struct device *dev);
+
 	unsigned long pgsize_bitmap;
 };
 
@@ -192,6 +206,10 @@ extern int iommu_domain_window_enable(struct iommu_domain *domain, u32 wnd_nr,
 				      phys_addr_t offset, u64 size,
 				      int prot);
 extern void iommu_domain_window_disable(struct iommu_domain *domain, u32 wnd_nr);
+
+int iommu_attach(struct device *dev);
+int iommu_detach(struct device *dev);
+
 /**
  * report_iommu_fault() - report about an IOMMU fault to the IOMMU framework
  * @domain: the iommu domain where the fault has happened
@@ -396,6 +414,15 @@ static inline int iommu_domain_set_attr(struct iommu_domain *domain,
 	return -EINVAL;
 }
 
+static inline int iommu_attach(struct device *dev)
+{
+	return 0;
+}
+
+static inline int iommu_detach(struct device *dev)
+{
+	return 0;
+}
 #endif /* CONFIG_IOMMU_API */
 
 #endif /* __LINUX_IOMMU_H */
-- 
2.0.0
