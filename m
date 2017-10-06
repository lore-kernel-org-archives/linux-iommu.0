From: Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>
Subject: [RFCv2 PATCH 06/36] iommu: Extend fault reporting
Date: Fri,  6 Oct 2017 14:31:33 +0100
Message-ID: <20171006133203.22803-7-jean-philippe.brucker@arm.com>
References: <20171006133203.22803-1-jean-philippe.brucker@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20171006133203.22803-1-jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: mark.rutland-5wv7dgnIgG8@public.gmane.org, gabriele.paoloni-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, catalin.marinas-5wv7dgnIgG8@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, okaya-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, rfranz-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org, lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org, sudeep.holla-5wv7dgnIgG8@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

A number of new users will need additional information in the IOMMU fault
report, such as PASID and/or PRI group. Pass a new iommu_fault structure
to the driver callbacks.

For the moment add the new API in parallel, with an "ext" prefix, to let
users move to the new API at their pace. I think it would be nice to use a
single API though. There are only 4 device drivers using it, and receiving
an iommu_fault instead of iova/flags wouldn't hurt them much.

For the same reason as the process_exit handler, set_fault_handler is done
on a device rather than a domain (although for the moment stored in the
domain). Even when multiple heterogenous devices are in the same IOMMU
group, each of their driver might want to register a fault handler. At the
moment they'll race to set the handler, and the winning driver will
receive fault reports from other devices.

The new registering function also takes flags as arguments, giving future
users a way to specify at which point of the fault process they want to be
called.

Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>
---
 drivers/iommu/iommu.c | 42 ++++++++++++++++++++++++++++++++++++++++++
 include/linux/iommu.h | 18 ++++++++++++++++++
 2 files changed, 60 insertions(+)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index f9cb89dd28f5..ee956b5fc301 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -1234,6 +1234,8 @@ EXPORT_SYMBOL_GPL(iommu_capable);
  * This function should be used by IOMMU users which want to be notified
  * whenever an IOMMU fault happens.
  *
+ * Note that new users should use iommu_set_ext_fault_handler instead.
+ *
  * The fault handler itself should return 0 on success, and an appropriate
  * error code otherwise.
  */
@@ -1243,11 +1245,44 @@ void iommu_set_fault_handler(struct iommu_domain *domain,
 {
 	BUG_ON(!domain);
 
+	if (WARN_ON(domain->ext_handler))
+		return;
+
 	domain->handler = handler;
 	domain->handler_token = token;
 }
 EXPORT_SYMBOL_GPL(iommu_set_fault_handler);
 
+/**
+ * iommu_set_ext_fault_handler() - set a fault handler for a device
+ * @dev: the device
+ * @handler: fault handler
+ * @token: user data, will be passed back to the fault handler
+ * @flags: IOMMU_FAULT_HANDLER_* parameters.
+ *
+ * This function should be used by IOMMU users which want to be notified
+ * whenever an IOMMU fault happens.
+ *
+ * The fault handler itself should return 0 on success, and an appropriate
+ * error code otherwise.
+ */
+void iommu_set_ext_fault_handler(struct device *dev,
+				 iommu_ext_fault_handler_t handler,
+				 void *token, int flags)
+{
+	struct iommu_domain *domain = iommu_get_domain_for_dev(dev);
+
+	if (WARN_ON(!domain))
+		return;
+
+	if (WARN_ON(domain->handler || domain->ext_handler))
+		return;
+
+	domain->ext_handler = handler;
+	domain->handler_token = token;
+}
+EXPORT_SYMBOL_GPL(iommu_set_ext_fault_handler);
+
 static struct iommu_domain *__iommu_domain_alloc(struct bus_type *bus,
 						 unsigned type)
 {
@@ -1787,6 +1822,10 @@ int report_iommu_fault(struct iommu_domain *domain, struct device *dev,
 		       unsigned long iova, int flags)
 {
 	int ret = -ENOSYS;
+	struct iommu_fault fault = {
+		.address	= iova,
+		.flags		= flags,
+	};
 
 	/*
 	 * if upper layers showed interest and installed a fault handler,
@@ -1795,6 +1834,9 @@ int report_iommu_fault(struct iommu_domain *domain, struct device *dev,
 	if (domain->handler)
 		ret = domain->handler(domain, dev, iova, flags,
 						domain->handler_token);
+	else if (domain->ext_handler)
+		ret = domain->ext_handler(domain, dev, &fault,
+					  domain->handler_token);
 
 	trace_io_page_fault(dev, iova, flags);
 	return ret;
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index e64c2711ea8d..ea4eaf585eb4 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -57,6 +57,14 @@ struct notifier_block;
 typedef int (*iommu_fault_handler_t)(struct iommu_domain *,
 			struct device *, unsigned long, int, void *);
 
+struct iommu_fault {
+	unsigned long		address;
+	unsigned int		flags;
+};
+
+typedef int (*iommu_ext_fault_handler_t)(struct iommu_domain *, struct device *,
+					 struct iommu_fault *, void *);
+
 /* All process are being detached from this device */
 #define IOMMU_PROCESS_EXIT_ALL			(-1)
 typedef int (*iommu_process_exit_handler_t)(struct iommu_domain *, struct device *dev,
@@ -97,6 +105,7 @@ struct iommu_domain {
 	const struct iommu_ops *ops;
 	unsigned long pgsize_bitmap;	/* Bitmap of page sizes in use */
 	iommu_fault_handler_t handler;
+	iommu_ext_fault_handler_t ext_handler;
 	void *handler_token;
 	iommu_process_exit_handler_t process_exit;
 	void *process_exit_token;
@@ -352,6 +361,9 @@ extern size_t default_iommu_map_sg(struct iommu_domain *domain, unsigned long io
 extern phys_addr_t iommu_iova_to_phys(struct iommu_domain *domain, dma_addr_t iova);
 extern void iommu_set_fault_handler(struct iommu_domain *domain,
 			iommu_fault_handler_t handler, void *token);
+extern void iommu_set_ext_fault_handler(struct device *dev,
+					iommu_ext_fault_handler_t handler,
+					void *token, int flags);
 
 extern void iommu_get_resv_regions(struct device *dev, struct list_head *list);
 extern void iommu_put_resv_regions(struct device *dev, struct list_head *list);
@@ -566,6 +578,12 @@ static inline void iommu_set_fault_handler(struct iommu_domain *domain,
 {
 }
 
+static inline void iommu_set_ext_fault_handler(struct device *dev,
+				 iommu_ext_fault_handler_t handler, void *token,
+				 int flags)
+{
+}
+
 static inline void iommu_get_resv_regions(struct device *dev,
 					struct list_head *list)
 {
-- 
2.13.3
