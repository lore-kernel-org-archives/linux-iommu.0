From: Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>
Subject: [PATCH v3 08/10] iommu/iopf: Handle mm faults
Date: Thu, 20 Sep 2018 18:00:44 +0100
Message-ID: <20180920170046.20154-9-jean-philippe.brucker@arm.com>
References: <20180920170046.20154-1-jean-philippe.brucker@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20180920170046.20154-1-jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: kevin.tian-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ilias.apalodimas-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, okaya-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, liguozhu-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org, robin.murphy-5wv7dgnIgG8@public.gmane.org, christian.koenig-5C7GfCeVMHo@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

When a recoverable page fault is handled by the fault workqueue, find the
associated mm and call handle_mm_fault.

Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>
---
 drivers/iommu/io-pgfault.c | 86 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 84 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/io-pgfault.c b/drivers/iommu/io-pgfault.c
index 29aa8c6ba459..f6d9f40b879b 100644
--- a/drivers/iommu/io-pgfault.c
+++ b/drivers/iommu/io-pgfault.c
@@ -7,6 +7,7 @@
 
 #include <linux/iommu.h>
 #include <linux/list.h>
+#include <linux/sched/mm.h>
 #include <linux/slab.h>
 #include <linux/workqueue.h>
 
@@ -65,8 +66,65 @@ static int iopf_complete(struct device *dev, struct iommu_fault_event *evt,
 static enum page_response_code
 iopf_handle_single(struct iopf_fault *fault)
 {
-	/* TODO */
-	return -ENODEV;
+	vm_fault_t ret;
+	struct mm_struct *mm;
+	struct vm_area_struct *vma;
+	unsigned int access_flags = 0;
+	unsigned int fault_flags = FAULT_FLAG_REMOTE;
+	struct iommu_fault_event *evt = &fault->evt;
+	enum page_response_code status = IOMMU_PAGE_RESP_INVALID;
+
+	if (!evt->pasid_valid)
+		return status;
+
+	mm = iommu_sva_find(evt->pasid);
+	if (!mm)
+		return status;
+
+	down_read(&mm->mmap_sem);
+
+	vma = find_extend_vma(mm, evt->addr);
+	if (!vma)
+		/* Unmapped area */
+		goto out_put_mm;
+
+	if (evt->prot & IOMMU_FAULT_READ)
+		access_flags |= VM_READ;
+
+	if (evt->prot & IOMMU_FAULT_WRITE) {
+		access_flags |= VM_WRITE;
+		fault_flags |= FAULT_FLAG_WRITE;
+	}
+
+	if (evt->prot & IOMMU_FAULT_EXEC) {
+		access_flags |= VM_EXEC;
+		fault_flags |= FAULT_FLAG_INSTRUCTION;
+	}
+
+	if (!(evt->prot & IOMMU_FAULT_PRIV))
+		fault_flags |= FAULT_FLAG_USER;
+
+	if (access_flags & ~vma->vm_flags)
+		/* Access fault */
+		goto out_put_mm;
+
+	ret = handle_mm_fault(vma, evt->addr, fault_flags);
+	status = ret & VM_FAULT_ERROR ? IOMMU_PAGE_RESP_INVALID :
+		IOMMU_PAGE_RESP_SUCCESS;
+
+out_put_mm:
+	up_read(&mm->mmap_sem);
+
+	/*
+	 * If the process exits while we're handling the fault on its mm, we
+	 * can't do mmput(). exit_mmap() would release the MMU notifier, calling
+	 * iommu_notifier_release(), which has to flush the fault queue that
+	 * we're executing on... So mmput_async() moves the release of the mm to
+	 * another thread, if we're the last user.
+	 */
+	mmput_async(mm);
+
+	return status;
 }
 
 static void iopf_handle_group(struct work_struct *work)
@@ -100,6 +158,30 @@ static void iopf_handle_group(struct work_struct *work)
  * @cookie: struct device, passed to iommu_register_device_fault_handler.
  *
  * Add a fault to the device workqueue, to be handled by mm.
+ *
+ * This module doesn't handle PCI PASID Stop Marker; IOMMU drivers must discard
+ * them before reporting faults. A PASID Stop Marker (LRW = 0b100) doesn't
+ * expect a response. It may be generated when disabling a PASID (issuing a
+ * PASID stop request) by some PCI devices.
+ *
+ * The PASID stop request is triggered by the mm_exit() callback. When the
+ * callback returns from the device driver, no page request is generated for
+ * this PASID anymore and outstanding ones have been pushed to the IOMMU (as per
+ * PCIe 4.0r1.0 - 6.20.1 and 10.4.1.2 - Managing PASID TLP Prefix Usage). Some
+ * PCI devices will wait for all outstanding page requests to come back with a
+ * response before completing the PASID stop request. Others do not wait for
+ * page responses, and instead issue this Stop Marker that tells us when the
+ * PASID can be reallocated.
+ *
+ * It is safe to discard the Stop Marker because it is an optimization.
+ * a. Page requests, which are posted requests, have been flushed to the IOMMU
+ *    when mm_exit() returns,
+ * b. We flush all fault queues after mm_exit() returns and before freeing the
+ *    PASID.
+ *
+ * So even though the Stop Marker might be issued by the device *after* the stop
+ * request completes, outstanding faults will have been dealt with by the time
+ * we free the PASID.
  */
 int iommu_queue_iopf(struct iommu_fault_event *evt, void *cookie)
 {
-- 
2.18.0
