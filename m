From: Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>
Subject: [RFCv2 PATCH 04/36] iommu/process: Track process changes with an mmu_notifier
Date: Fri,  6 Oct 2017 14:31:31 +0100
Message-ID: <20171006133203.22803-5-jean-philippe.brucker@arm.com>
References: <20171006133203.22803-1-jean-philippe.brucker@arm.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20171006133203.22803-1-jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, catalin.marinas-5wv7dgnIgG8@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org, hanjun.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, sudeep.holla-5wv7dgnIgG8@public.gmane.org, rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org, lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, robin.murphy-5wv7dgnIgG8@public.gmane.org, bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, tn-nYOzD4b6Jr9Wk0Htik3J/w@public.gmane.org, liubo95-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, xieyisheng1-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, gabriele.paoloni-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, nwatters-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, okaya-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, rfranz-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, jacob.jun.pan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, yi.l.liu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, robdclark-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

When creating an iommu_process structure, register a notifier to be
informed of changes to the virtual address space and to know when the
process exits.

Two new operations are added to the IOMMU driver:

* process_invalidate when a range of addresses is unmapped, to let the
  IOMMU driver send TLB invalidations.

* process_exit when the mm is released. It's a bit more involved in this
  case, as the IOMMU driver has to tell all devices drivers to stop using
  this PASID, then clear the PASID table and invalidate TLBs.

Adding the notifier in the mix complicates process release. In one case
device drivers free the process explicitly by calling unbind (or detaching
the device). In the other case the process could crash before unbind, in
which case the release notifier has to do all the work.

Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>
---
 drivers/iommu/iommu-process.c | 165 ++++++++++++++++++++++++++++++++++++++++--
 include/linux/iommu.h         |  12 +++
 2 files changed, 170 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/iommu-process.c b/drivers/iommu/iommu-process.c
index 8f4c98632d58..1ef3f55b962b 100644
--- a/drivers/iommu/iommu-process.c
+++ b/drivers/iommu/iommu-process.c
@@ -21,9 +21,14 @@
 
 #include <linux/idr.h>
 #include <linux/iommu.h>
+#include <linux/mmu_notifier.h>
 #include <linux/slab.h>
+#include <linux/sched/mm.h>
 #include <linux/spinlock.h>
 
+/* FIXME: stub for the fault queue. Remove later. */
+#define iommu_fault_queue_flush(...)
+
 /* Link between a domain and a process */
 struct iommu_context {
 	struct iommu_process	*process;
@@ -50,6 +55,8 @@ static DEFINE_IDR(iommu_process_idr);
  */
 static DEFINE_SPINLOCK(iommu_process_lock);
 
+static struct mmu_notifier_ops iommu_process_mmu_notfier;
+
 /*
  * Allocate a iommu_process structure for the given task.
  *
@@ -74,15 +81,21 @@ iommu_process_alloc(struct iommu_domain *domain, struct task_struct *task)
 		return ERR_PTR(-ENOMEM);
 
 	process->pid		= get_task_pid(task, PIDTYPE_PID);
+	process->mm		= get_task_mm(task);
+	process->notifier.ops	= &iommu_process_mmu_notfier;
 	process->release	= domain->ops->process_free;
 	INIT_LIST_HEAD(&process->domains);
-	kref_init(&process->kref);
 
 	if (!process->pid) {
 		err = -EINVAL;
 		goto err_free_process;
 	}
 
+	if (!process->mm) {
+		err = -EINVAL;
+		goto err_put_pid;
+	}
+
 	idr_preload(GFP_KERNEL);
 	spin_lock(&iommu_process_lock);
 	pasid = idr_alloc_cyclic(&iommu_process_idr, process, domain->min_pasid,
@@ -93,11 +106,44 @@ iommu_process_alloc(struct iommu_domain *domain, struct task_struct *task)
 
 	if (pasid < 0) {
 		err = pasid;
-		goto err_put_pid;
+		goto err_put_mm;
 	}
 
+	err = mmu_notifier_register(&process->notifier, process->mm);
+	if (err)
+		goto err_free_pasid;
+
+	/*
+	 * Now that the MMU notifier is valid, we can allow users to grab this
+	 * process by setting a valid refcount. Before that it was accessible in
+	 * the IDR but invalid.
+	 *
+	 * Users of the process structure obtain it with inc_not_zero, which
+	 * provides a control dependency to ensure that they don't modify the
+	 * structure if they didn't acquire the ref. So I think we need a write
+	 * barrier here to pair with that control dependency (XXX probably
+	 * nonsense.)
+	 */
+	smp_wmb();
+	kref_init(&process->kref);
+
+	/* A mm_count reference is kept by the notifier */
+	mmput(process->mm);
+
 	return process;
 
+err_free_pasid:
+	/*
+	 * Even if the process is accessible from the IDR at this point, kref is
+	 * 0 so no user could get a reference to it. Free it manually.
+	 */
+	spin_lock(&iommu_process_lock);
+	idr_remove(&iommu_process_idr, process->pasid);
+	spin_unlock(&iommu_process_lock);
+
+err_put_mm:
+	mmput(process->mm);
+
 err_put_pid:
 	put_pid(process->pid);
 
@@ -107,21 +153,46 @@ iommu_process_alloc(struct iommu_domain *domain, struct task_struct *task)
 	return ERR_PTR(err);
 }
 
-static void iommu_process_release(struct kref *kref)
+static void iommu_process_free(struct rcu_head *rcu)
 {
 	struct iommu_process *process;
 	void (*release)(struct iommu_process *);
 
+	process = container_of(rcu, struct iommu_process, rcu);
+	release = process->release;
+
+	release(process);
+}
+
+static void iommu_process_release(struct kref *kref)
+{
+	struct iommu_process *process;
+
 	assert_spin_locked(&iommu_process_lock);
 
 	process = container_of(kref, struct iommu_process, kref);
-	release = process->release;
-
 	WARN_ON(!list_empty(&process->domains));
 
 	idr_remove(&iommu_process_idr, process->pasid);
 	put_pid(process->pid);
-	release(process);
+
+	/*
+	 * If we're being released from process exit, the notifier callback
+	 * ->release has already been called. Otherwise we don't need to go
+	 * through there, the process isn't attached to anything anymore. Hence
+	 * no_release.
+	 */
+	mmu_notifier_unregister_no_release(&process->notifier, process->mm);
+
+	/*
+	 * We can't free the structure here, because ->release might be
+	 * attempting to grab it concurrently. And in the other case, if the
+	 * structure is being released from within ->release, then
+	 * __mmu_notifier_release expects to still have a valid mn when
+	 * returning. So free the structure when it's safe, after the RCU grace
+	 * period elapsed.
+	 */
+	mmu_notifier_call_srcu(&process->rcu, iommu_process_free);
 }
 
 /*
@@ -187,7 +258,8 @@ static int iommu_process_attach(struct iommu_domain *domain, struct device *dev,
 	int pasid = process->pasid;
 	struct iommu_context *context;
 
-	if (WARN_ON(!domain->ops->process_attach || !domain->ops->process_detach))
+	if (WARN_ON(!domain->ops->process_attach || !domain->ops->process_detach ||
+		    !domain->ops->process_exit || !domain->ops->process_invalidate))
 		return -ENODEV;
 
 	if (pasid > domain->max_pasid || pasid < domain->min_pasid)
@@ -259,6 +331,85 @@ static void iommu_process_detach_locked(struct iommu_context *context,
 		iommu_context_free(context);
 }
 
+/*
+ * Called when the process exits. Might race with unbind or any other function
+ * dropping the last reference to the process. As the mmu notifier doesn't hold
+ * any reference to the process when calling ->release, try to take a reference.
+ */
+static void iommu_notifier_release(struct mmu_notifier *mn, struct mm_struct *mm)
+{
+	struct iommu_context *context, *next;
+	struct iommu_process *process = container_of(mn, struct iommu_process, notifier);
+
+	/*
+	 * If the process is exiting then domains are still attached to the
+	 * process. A few things need to be done before it is safe to release
+	 *
+	 * 1) Tell the IOMMU driver to stop using this PASID (and forward the
+	 *    message to attached device drivers. It can then clear the PASID
+	 *    table and invalidate relevant TLBs.
+	 *
+	 * 2) Drop all references to this process, by freeing the contexts.
+	 */
+	spin_lock(&iommu_process_lock);
+	if (!iommu_process_get_locked(process)) {
+		/* Someone's already taking care of it. */
+		spin_unlock(&iommu_process_lock);
+		return;
+	}
+
+	list_for_each_entry_safe(context, next, &process->domains, process_head) {
+		context->domain->ops->process_exit(context->domain, process);
+		iommu_context_free(context);
+	}
+	spin_unlock(&iommu_process_lock);
+
+	iommu_fault_queue_flush(NULL);
+
+	/*
+	 * We're now reasonably certain that no more fault is being handled for
+	 * this process, since we just flushed them all out of the fault queue.
+	 * Release the last reference to free the process.
+	 */
+	iommu_process_put(process);
+}
+
+static void iommu_notifier_invalidate_range(struct mmu_notifier *mn, struct mm_struct *mm,
+					    unsigned long start, unsigned long end)
+{
+	struct iommu_context *context;
+	struct iommu_process *process = container_of(mn, struct iommu_process, notifier);
+
+	spin_lock(&iommu_process_lock);
+	list_for_each_entry(context, &process->domains, process_head) {
+		context->domain->ops->process_invalidate(context->domain,
+						 process, start, end - start);
+	}
+	spin_unlock(&iommu_process_lock);
+}
+
+static int iommu_notifier_clear_flush_young(struct mmu_notifier *mn,
+					    struct mm_struct *mm,
+					    unsigned long start,
+					    unsigned long end)
+{
+	iommu_notifier_invalidate_range(mn, mm, start, end);
+	return 0;
+}
+
+static void iommu_notifier_change_pte(struct mmu_notifier *mn, struct mm_struct *mm,
+				      unsigned long address, pte_t pte)
+{
+	iommu_notifier_invalidate_range(mn, mm, address, address + PAGE_SIZE);
+}
+
+static struct mmu_notifier_ops iommu_process_mmu_notfier = {
+	.release		= iommu_notifier_release,
+	.clear_flush_young	= iommu_notifier_clear_flush_young,
+	.change_pte		= iommu_notifier_change_pte,
+	.invalidate_range	= iommu_notifier_invalidate_range,
+};
+
 /**
  * iommu_set_process_exit_handler() - set a callback for stopping the use of
  * PASID in a device.
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index e9528fcacab1..42b818437fa1 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -25,6 +25,7 @@
 #include <linux/errno.h>
 #include <linux/err.h>
 #include <linux/of.h>
+#include <linux/mmu_notifier.h>
 
 #define IOMMU_READ	(1 << 0)
 #define IOMMU_WRITE	(1 << 1)
@@ -111,9 +112,13 @@ struct iommu_process {
 	int			pasid;
 	struct list_head	domains;
 	struct kref		kref;
+	struct mmu_notifier	notifier;
+	struct mm_struct	*mm;
 
 	/* Release callback for this process */
 	void (*release)(struct iommu_process *process);
+	/* For postponed release */
+	struct rcu_head		rcu;
 };
 
 enum iommu_cap {
@@ -189,6 +194,9 @@ struct iommu_resv_region {
  * @process_attach: attach iommu process to a domain
  * @process_detach: detach iommu process from a domain. Remove PASID entry and
  *                  flush associated TLB entries.
+ * @process_invalidate: Invalidate a range of mappings for a process.
+ * @process_exit: A process is exiting. Stop using the PASID, remove PASID entry
+ *                and flush associated TLB entries.
  * @map: map a physically contiguous memory region to an iommu domain
  * @unmap: unmap a physically contiguous memory region from an iommu domain
  * @map_sg: map a scatter-gather list of physically contiguous memory chunks
@@ -228,6 +236,10 @@ struct iommu_ops {
 			      struct iommu_process *process, bool first);
 	void (*process_detach)(struct iommu_domain *domain, struct device *dev,
 			       struct iommu_process *process, bool last);
+	void (*process_invalidate)(struct iommu_domain *domain,
+				   struct iommu_process *process,
+				   unsigned long iova, size_t size);
+	void (*process_exit)(struct iommu_domain *domain, struct iommu_process *process);
 	int (*map)(struct iommu_domain *domain, unsigned long iova,
 		   phys_addr_t paddr, size_t size, int prot);
 	size_t (*unmap)(struct iommu_domain *domain, unsigned long iova,
-- 
2.13.3

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
