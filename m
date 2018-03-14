From: Vivek Gautam <vivek.gautam-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: [PATCH v10 1/5] driver core: Delete the link between two given devices
Date: Wed, 14 Mar 2018 13:44:30 +0530
Message-ID: <20180314081434.30875-2-vivek.gautam@codeaurora.org>
References: <20180314081434.30875-1-vivek.gautam@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20180314081434.30875-1-vivek.gautam-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, robin.murphy-5wv7dgnIgG8@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: mark.rutland-5wv7dgnIgG8@public.gmane.org, "Rafael J . Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Given the consumer and supplier devices, add an API to
delete the link between them.

Suggested-by: Tomasz Figa <tfiga-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Signed-off-by: Vivek Gautam <vivek.gautam-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Cc: Rafael J. Wysocki <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>
Cc: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
---

 - This patch replaces an earlier patch [1] that was adding
   device_link_find() API.
   [1] https://patchwork.kernel.org/patch/10277975/

 drivers/base/core.c    | 31 +++++++++++++++++++++++++++++++
 include/linux/device.h |  1 +
 2 files changed, 32 insertions(+)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 5847364f25d9..e13d904e1e12 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -336,6 +336,37 @@ void device_link_del(struct device_link *link)
 }
 EXPORT_SYMBOL_GPL(device_link_del);
 
+/**
+ * device_link_del_dev - Delete a link between two given devices
+ * @consumer: Consumer end of the link.
+ * @supplier: Supplier end of the link.
+ *
+ * The caller must ensure proper synchronization of this function with runtime
+ * PM.
+ */
+void device_link_del_dev(struct device *consumer, struct device *supplier)
+{
+	struct device_link *link;
+
+	if (!consumer || !supplier)
+		return;
+
+	device_links_write_lock();
+	device_pm_lock();
+
+	list_for_each_entry(link, &supplier->links.consumers, s_node) {
+		if (link->consumer == consumer) {
+			__device_link_del(link);
+			/* just one link between the devices */
+			break;
+		}
+	}
+
+	device_pm_unlock();
+	device_links_write_unlock();
+}
+EXPORT_SYMBOL_GPL(device_link_del_dev);
+
 static void device_links_missing_supplier(struct device *dev)
 {
 	struct device_link *link;
diff --git a/include/linux/device.h b/include/linux/device.h
index b093405ed525..14508d843f67 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -1278,6 +1278,7 @@ extern const char *dev_driver_string(const struct device *dev);
 struct device_link *device_link_add(struct device *consumer,
 				    struct device *supplier, u32 flags);
 void device_link_del(struct device_link *link);
+void device_link_del_dev(struct device *consumer, struct device *supplier);
 
 #ifdef CONFIG_PRINTK
 
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
