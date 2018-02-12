From: Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>
Subject: [PATCH 10/37] iommu/fault: Allow blocking fault handlers
Date: Mon, 12 Feb 2018 18:33:25 +0000
Message-ID: <20180212183352.22730-11-jean-philippe.brucker@arm.com>
References: <20180212183352.22730-1-jean-philippe.brucker@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20180212183352.22730-1-jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: mark.rutland-5wv7dgnIgG8@public.gmane.org, ilias.apalodimas-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, catalin.marinas-5wv7dgnIgG8@public.gmane.org, xuzaibo-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, okaya-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, bharatku-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org, rfranz-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org, lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, shunyong.yang-PT9Dzx9SjPiXmMXjJBpWqg@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org, sudeep.holla-5wv7dgnIgG8@public.gmane.org, christian.koenig-5C7GfCeVMHo@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Allow device driver to register their fault handler at different stages of
the handling path. Since we now have a fault workqueue, it is easy to call
their handler from blocking context.

The API borrows "handler" and "thread" terms from the IRQ subsystem, even
though they don't match exactly: some IOMMU driver may report page faults
from an IRQ thread instead of handler. But executing blocking fault
handlers on the workqueue instead of the IRQ thread is still advantageous,
because it allows to unload the low-level fault queue as fast as possible
and avoid losing fault events.

A driver can request to be called both in blocking and non-blocking
context, so it can filter faults early and only execute the blocking code
for some of them.

Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>
---
 drivers/iommu/io-pgfault.c | 15 +++++++++++++--
 drivers/iommu/iommu.c      | 12 +++++++++++-
 include/linux/iommu.h      | 24 +++++++++++++++++++-----
 3 files changed, 43 insertions(+), 8 deletions(-)

diff --git a/drivers/iommu/io-pgfault.c b/drivers/iommu/io-pgfault.c
index 484a39710d3f..c8f1d9bdd825 100644
--- a/drivers/iommu/io-pgfault.c
+++ b/drivers/iommu/io-pgfault.c
@@ -89,10 +89,20 @@ static int iommu_fault_handle_single(struct iommu_fault_context *fault)
 	struct mm_struct *mm;
 	struct vm_area_struct *vma;
 	unsigned int access_flags = 0;
+	struct device *dev = fault->dev;
 	int ret = IOMMU_PAGE_RESP_INVALID;
 	unsigned int fault_flags = FAULT_FLAG_REMOTE;
 	struct iommu_fault_event *evt = &fault->evt;
 
+	if (iommu_has_blocking_device_fault_handler(dev)) {
+		struct iommu_fault_param *param = dev->iommu_param->fault_param;
+
+		ret = param->thread(evt, param->data);
+		if (ret != IOMMU_PAGE_RESP_CONTINUE)
+			return ret;
+		ret = IOMMU_PAGE_RESP_INVALID;
+	}
+
 	if (!evt->pasid_valid)
 		return ret;
 
@@ -272,7 +282,7 @@ int iommu_report_device_fault(struct device *dev, struct iommu_fault_event *evt)
 	 * if upper layers showed interest and installed a fault handler,
 	 * invoke it.
 	 */
-	if (iommu_has_device_fault_handler(dev)) {
+	if (iommu_has_atomic_device_fault_handler(dev)) {
 		struct iommu_fault_param *param = dev->iommu_param->fault_param;
 
 		ret = param->handler(evt, param->data);
@@ -282,7 +292,8 @@ int iommu_report_device_fault(struct device *dev, struct iommu_fault_event *evt)
 	}
 
 	/* If the handler is blocking, handle fault in the workqueue */
-	if (evt->type == IOMMU_FAULT_PAGE_REQ)
+	if (evt->type == IOMMU_FAULT_PAGE_REQ ||
+	    iommu_has_blocking_device_fault_handler(dev))
 		ret = iommu_queue_fault(domain, dev, evt);
 
 	return iommu_fault_complete(domain, dev, evt, ret);
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 9bec8390694c..7f8395b620b1 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -801,7 +801,8 @@ EXPORT_SYMBOL_GPL(iommu_group_unregister_notifier);
 /**
  * iommu_register_device_fault_handler() - Register a device fault handler
  * @dev: the device
- * @handler: the fault handler
+ * @handler: fault handler that can only be called in atomic context
+ * @thread: fault handler called from the workqueue and can block
  * @data: private data passed as argument to the callback
  *
  * When an IOMMU fault event is received, call this handler with the fault event
@@ -810,14 +811,22 @@ EXPORT_SYMBOL_GPL(iommu_group_unregister_notifier);
  * fault, or return IOMMU_PAGE_RESP_HANDLED and complete the fault later by
  * calling iommu_page_response().
  *
+ * At least one of @handler and @thread must be non-NULL. Both may be set, in
+ * which case the top-half @thread is called from the workqueue iff the
+ * bottom-half @handler returned IOMMU_PAGE_RESP_CONTINUE.
+ *
  * Return 0 if the fault handler was installed successfully, or an error.
  */
 int iommu_register_device_fault_handler(struct device *dev,
 					iommu_dev_fault_handler_t handler,
+					iommu_dev_fault_handler_t thread,
 					void *data)
 {
 	struct iommu_param *idata = dev->iommu_param;
 
+	if (!handler && !thread)
+		return -EINVAL;
+
 	/*
 	 * Device iommu_param should have been allocated when device is
 	 * added to its iommu_group.
@@ -833,6 +842,7 @@ int iommu_register_device_fault_handler(struct device *dev,
 	if (!idata->fault_param)
 		return -ENOMEM;
 	idata->fault_param->handler = handler;
+	idata->fault_param->thread = thread;
 	idata->fault_param->data = data;
 
 	return 0;
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index d29991be9401..36fcb579f5ed 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -431,12 +431,13 @@ struct iommu_fault_event {
 
 /**
  * struct iommu_fault_param - per-device IOMMU fault data
- * @dev_fault_handler: Callback function to handle IOMMU faults at device level
- * @data: handler private data
- *
+ * @handler: Atomic callback to handle IOMMU faults at device level
+ * @thread: Blocking callback to handle IOMMU faults at device level
+ * @data: private data for the handler
  */
 struct iommu_fault_param {
 	iommu_dev_fault_handler_t handler;
+	iommu_dev_fault_handler_t thread;
 	void *data;
 };
 
@@ -549,6 +550,7 @@ extern int iommu_group_unregister_notifier(struct iommu_group *group,
 					   struct notifier_block *nb);
 extern int iommu_register_device_fault_handler(struct device *dev,
 					iommu_dev_fault_handler_t handler,
+					iommu_dev_fault_handler_t thread,
 					void *data);
 
 extern int iommu_unregister_device_fault_handler(struct device *dev);
@@ -574,7 +576,13 @@ extern void iommu_domain_window_disable(struct iommu_domain *domain, u32 wnd_nr)
 extern int report_iommu_fault(struct iommu_domain *domain, struct device *dev,
 			      unsigned long iova, int flags);
 
-static inline bool iommu_has_device_fault_handler(struct device *dev)
+static inline bool iommu_has_blocking_device_fault_handler(struct device *dev)
+{
+	return dev->iommu_param && dev->iommu_param->fault_param &&
+		dev->iommu_param->fault_param->thread;
+}
+
+static inline bool iommu_has_atomic_device_fault_handler(struct device *dev)
 {
 	return dev->iommu_param && dev->iommu_param->fault_param &&
 		dev->iommu_param->fault_param->handler;
@@ -839,6 +847,7 @@ static inline int iommu_group_unregister_notifier(struct iommu_group *group,
 
 static inline int iommu_register_device_fault_handler(struct device *dev,
 						iommu_dev_fault_handler_t handler,
+						iommu_dev_fault_handler_t thread,
 						void *data)
 {
 	return 0;
@@ -849,7 +858,12 @@ static inline int iommu_unregister_device_fault_handler(struct device *dev)
 	return 0;
 }
 
-static inline bool iommu_has_device_fault_handler(struct device *dev)
+static inline bool iommu_has_blocking_device_fault_handler(struct device *dev)
+{
+	return false;
+}
+
+static inline bool iommu_has_atomic_device_fault_handler(struct device *dev)
 {
 	return false;
 }
-- 
2.15.1
