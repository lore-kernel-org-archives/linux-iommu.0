From: Jacob Pan <jacob.jun.pan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH v4 14/22] iommu: handle page response timeout
Date: Thu, 22 Mar 2018 20:12:06 -0700
Message-ID: <1521774734-48433-15-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1521774734-48433-1-git-send-email-jacob.jun.pan@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1521774734-48433-1-git-send-email-jacob.jun.pan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Rafael Wysocki <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Lan Tianyu <tianyu.lan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Raj Ashok <ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

When IO page faults are reported outside IOMMU subsystem, the page
request handler may fail for various reasons. E.g. a guest received
page requests but did not have a chance to run for a long time. The
irresponsive behavior could hold off limited resources on the pending
device.
There can be hardware or credit based software solutions as suggested
in the PCI ATS Ch-4. To provide a basic safty net this patch
introduces a per device deferrable timer which monitors the longest
pending page fault that requires a response. Proper action such as
sending failure response code could be taken when timer expires but not
included in this patch. We need to consider the life cycle of page
groupd ID to prevent confusion with reused group ID by a device.
For now, a warning message provides clue of such failure.

Signed-off-by: Jacob Pan <jacob.jun.pan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Signed-off-by: Ashok Raj <ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
---
 drivers/iommu/iommu.c | 60 +++++++++++++++++++++++++++++++++++++++++++++++++--
 include/linux/iommu.h |  4 ++++
 2 files changed, 62 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 42e8f00..1e74944 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -799,6 +799,39 @@ int iommu_group_unregister_notifier(struct iommu_group *group,
 }
 EXPORT_SYMBOL_GPL(iommu_group_unregister_notifier);
 
+/* Max time to wait for a pending page request */
+#define IOMMU_PAGE_RESPONSE_MAXTIME (HZ * 10)
+static void iommu_dev_fault_timer_fn(struct timer_list *t)
+{
+	struct iommu_fault_param *fparam = from_timer(fparam, t, timer);
+	struct iommu_fault_event *evt, *iter;
+
+	u64 now;
+
+	now = get_jiffies_64();
+
+	/* The goal is to ensure driver or guest page fault handler(via vfio)
+	 * send page response on time. Otherwise, limited queue resources
+	 * may be occupied by some irresponsive guests or drivers.
+	 * When per device pending fault list is not empty, we periodically checks
+	 * if any anticipated page response time has expired.
+	 *
+	 * TODO:
+	 * We could do the following if response time expires:
+	 * 1. send page response code FAILURE to all pending PRQ
+	 * 2. inform device driver or vfio
+	 * 3. drain in-flight page requests and responses for this device
+	 * 4. clear pending fault list such that driver can unregister fault
+	 *    handler(otherwise blocked when pending faults are present).
+	 */
+	list_for_each_entry_safe(evt, iter, &fparam->faults, list) {
+		if (time_after64(evt->expire, now))
+			pr_err("Page response time expired!, pasid %d gid %d exp %llu now %llu\n",
+				evt->pasid, evt->page_req_group_id, evt->expire, now);
+	}
+	mod_timer(t, now + IOMMU_PAGE_RESPONSE_MAXTIME);
+}
+
 /**
  * iommu_register_device_fault_handler() - Register a device fault handler
  * @dev: the device
@@ -806,8 +839,8 @@ EXPORT_SYMBOL_GPL(iommu_group_unregister_notifier);
  * @data: private data passed as argument to the handler
  *
  * When an IOMMU fault event is received, call this handler with the fault event
- * and data as argument. The handler should return 0. If the fault is
- * recoverable (IOMMU_FAULT_PAGE_REQ), the handler must also complete
+ * and data as argument. The handler should return 0 on success. If the fault is
+ * recoverable (IOMMU_FAULT_PAGE_REQ), the handler can also complete
  * the fault by calling iommu_page_response() with one of the following
  * response code:
  * - IOMMU_PAGE_RESP_SUCCESS: retry the translation
@@ -848,6 +881,9 @@ int iommu_register_device_fault_handler(struct device *dev,
 	param->fault_param->data = data;
 	INIT_LIST_HEAD(&param->fault_param->faults);
 
+	timer_setup(&param->fault_param->timer, iommu_dev_fault_timer_fn,
+		TIMER_DEFERRABLE);
+
 	mutex_unlock(&param->lock);
 
 	return 0;
@@ -905,6 +941,8 @@ int iommu_report_device_fault(struct device *dev, struct iommu_fault_event *evt)
 {
 	int ret = 0;
 	struct iommu_fault_event *evt_pending;
+	struct timer_list *tmr;
+	u64 exp;
 	struct iommu_fault_param *fparam;
 
 	/* iommu_param is allocated when device is added to group */
@@ -925,6 +963,17 @@ int iommu_report_device_fault(struct device *dev, struct iommu_fault_event *evt)
 			goto done_unlock;
 		}
 		memcpy(evt_pending, evt, sizeof(struct iommu_fault_event));
+		/* Keep track of response expiration time */
+		exp = get_jiffies_64() + IOMMU_PAGE_RESPONSE_MAXTIME;
+		evt_pending->expire = exp;
+
+		if (list_empty(&fparam->faults)) {
+			/* First pending event, start timer */
+			tmr = &dev->iommu_param->fault_param->timer;
+			WARN_ON(timer_pending(tmr));
+			mod_timer(tmr, exp);
+		}
+
 		mutex_lock(&fparam->lock);
 		list_add_tail(&evt_pending->list, &fparam->faults);
 		mutex_unlock(&fparam->lock);
@@ -1542,6 +1591,13 @@ int iommu_page_response(struct device *dev,
 		}
 	}
 
+	/* stop response timer if no more pending request */
+	if (list_empty(&param->fault_param->faults) &&
+		timer_pending(&param->fault_param->timer)) {
+		pr_debug("no pending PRQ, stop timer\n");
+		del_timer(&param->fault_param->timer);
+	}
+
 done_unlock:
 	mutex_unlock(&param->fault_param->lock);
 	return ret;
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index af0e393..94cfda8 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -375,6 +375,7 @@ enum iommu_fault_reason {
  * @iommu_private: used by the IOMMU driver for storing fault-specific
  *                 data. Users should not modify this field before
  *                 sending the fault response.
+ * @expire: time limit in jiffies will wait for page response
  */
 struct iommu_fault_event {
 	struct list_head list;
@@ -388,6 +389,7 @@ struct iommu_fault_event {
 	u32 prot;
 	u64 device_private;
 	u64 iommu_private;
+	u64 expire;
 };
 
 /**
@@ -395,11 +397,13 @@ struct iommu_fault_event {
  * @dev_fault_handler: Callback function to handle IOMMU faults at device level
  * @data: handler private data
  * @faults: holds the pending faults which needs response, e.g. page response.
+ * @timer: track page request pending time limit
  * @lock: protect pending PRQ event list
  */
 struct iommu_fault_param {
 	iommu_dev_fault_handler_t handler;
 	struct list_head faults;
+	struct timer_list timer;
 	struct mutex lock;
 	void *data;
 };
-- 
2.7.4
