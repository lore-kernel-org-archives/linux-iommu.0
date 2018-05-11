From: Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>
Subject: [PATCH v2 09/40] iommu/sva: Register page fault handler
Date: Fri, 11 May 2018 20:06:10 +0100
Message-ID: <20180511190641.23008-10-jean-philippe.brucker@arm.com>
References: <20180511190641.23008-1-jean-philippe.brucker@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20180511190641.23008-1-jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mm-Bw31MaZKKs3YtjvyW6yDsg@public.gmane.org
Cc: xuzaibo-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, okaya-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, bharatku-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org, rfranz-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org, rgummal-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org, ilias.apalodimas-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, christian.koenig-5C7GfCeVMHo@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Let users call iommu_sva_device_init() with the IOMMU_SVA_FEAT_IOPF flag,
that enables the I/O Page Fault queue. The IOMMU driver checks is the
device supports a form of page fault, in which case they add the device to
a fault queue. If the device doesn't support page faults, the IOMMU driver
aborts iommu_sva_device_init().

The fault queue must be flushed before any io_mm is freed, to make sure
that its PASID isn't used in any fault queue, and can be reallocated.
Add iopf_queue_flush() calls in a few strategic locations.

Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>

---
v1->v2: new
---
 drivers/iommu/iommu-sva.c | 36 ++++++++++++++++++++++++++++++++----
 drivers/iommu/iommu.c     |  6 +++---
 include/linux/iommu.h     |  2 ++
 3 files changed, 37 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/iommu-sva.c b/drivers/iommu/iommu-sva.c
index 5abe0f0b445c..e98b994c15f1 100644
--- a/drivers/iommu/iommu-sva.c
+++ b/drivers/iommu/iommu-sva.c
@@ -441,6 +441,8 @@ static void iommu_notifier_release(struct mmu_notifier *mn, struct mm_struct *mm
 			dev_WARN(bond->dev, "possible leak of PASID %u",
 				 io_mm->pasid);
 
+		iopf_queue_flush_dev(bond->dev);
+
 		spin_lock(&iommu_sva_lock);
 		next = list_next_entry(bond, mm_head);
 
@@ -518,6 +520,9 @@ static struct mmu_notifier_ops iommu_mmu_notifier = {
  * description. Setting @max_pasid to a non-zero value smaller than this limit
  * overrides it.
  *
+ * If the device should support recoverable I/O Page Faults (e.g. PCI PRI), the
+ * IOMMU_SVA_FEAT_IOPF feature must be requested.
+ *
  * If the driver intends to share process address spaces, it should pass a valid
  * @mm_exit handler. Otherwise @mm_exit can be NULL. After @mm_exit returns, the
  * device must not issue any more transaction with the PASID given as argument.
@@ -546,12 +551,21 @@ int iommu_sva_device_init(struct device *dev, unsigned long features,
 	if (!domain || !domain->ops->sva_device_init)
 		return -ENODEV;
 
-	if (features)
+	if (features & ~IOMMU_SVA_FEAT_IOPF)
 		return -EINVAL;
 
+	if (features & IOMMU_SVA_FEAT_IOPF) {
+		ret = iommu_register_device_fault_handler(dev, iommu_queue_iopf,
+							  dev);
+		if (ret)
+			return ret;
+	}
+
 	param = kzalloc(sizeof(*param), GFP_KERNEL);
-	if (!param)
-		return -ENOMEM;
+	if (!param) {
+		ret = -ENOMEM;
+		goto err_remove_handler;
+	}
 
 	param->features		= features;
 	param->max_pasid	= max_pasid;
@@ -584,6 +598,9 @@ int iommu_sva_device_init(struct device *dev, unsigned long features,
 err_free_param:
 	kfree(param);
 
+err_remove_handler:
+	iommu_unregister_device_fault_handler(dev);
+
 	return ret;
 }
 EXPORT_SYMBOL_GPL(iommu_sva_device_init);
@@ -593,7 +610,8 @@ EXPORT_SYMBOL_GPL(iommu_sva_device_init);
  * @dev: the device
  *
  * Disable SVA. Device driver should ensure that the device isn't performing any
- * DMA while this function is running.
+ * DMA while this function is running. In addition all faults should have been
+ * flushed to the IOMMU.
  */
 int iommu_sva_device_shutdown(struct device *dev)
 {
@@ -617,6 +635,8 @@ int iommu_sva_device_shutdown(struct device *dev)
 
 	kfree(param);
 
+	iommu_unregister_device_fault_handler(dev);
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(iommu_sva_device_shutdown);
@@ -694,6 +714,12 @@ int __iommu_sva_unbind_device(struct device *dev, int pasid)
 	if (!param || WARN_ON(!domain))
 		return -EINVAL;
 
+	/*
+	 * Caller stopped the device from issuing PASIDs, now make sure they are
+	 * out of the fault queue.
+	 */
+	iopf_queue_flush_dev(dev);
+
 	/* spin_lock_irq matches the one in wait_event_lock_irq */
 	spin_lock_irq(&iommu_sva_lock);
 	list_for_each_entry(bond, &param->mm_list, dev_head) {
@@ -721,6 +747,8 @@ void __iommu_sva_unbind_dev_all(struct device *dev)
 	struct iommu_sva_param *param;
 	struct iommu_bond *bond, *next;
 
+	iopf_queue_flush_dev(dev);
+
 	/*
 	 * io_mm_detach_locked might wait, so we shouldn't call it with the dev
 	 * param lock held. It's fine to read sva_param outside the lock because
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 333801e1519c..13f705df0725 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -2278,9 +2278,9 @@ EXPORT_SYMBOL_GPL(iommu_fwspec_add_ids);
  * iommu_sva_device_init() must be called first, to initialize the required SVA
  * features. @flags is a subset of these features.
  *
- * The caller must pin down using get_user_pages*() all mappings shared with the
- * device. mlock() isn't sufficient, as it doesn't prevent minor page faults
- * (e.g. copy-on-write).
+ * If IOMMU_SVA_FEAT_IOPF isn't requested, the caller must pin down using
+ * get_user_pages*() all mappings shared with the device. mlock() isn't
+ * sufficient, as it doesn't prevent minor page faults (e.g. copy-on-write).
  *
  * On success, 0 is returned and @pasid contains a valid ID. Otherwise, an error
  * is returned.
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index fad3a60e1c14..933100678f64 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -64,6 +64,8 @@ typedef int (*iommu_fault_handler_t)(struct iommu_domain *,
 typedef int (*iommu_dev_fault_handler_t)(struct iommu_fault_event *, void *);
 typedef int (*iommu_mm_exit_handler_t)(struct device *dev, int pasid, void *);
 
+#define IOMMU_SVA_FEAT_IOPF		(1 << 0)
+
 struct iommu_domain_geometry {
 	dma_addr_t aperture_start; /* First address that can be mapped    */
 	dma_addr_t aperture_end;   /* Last address that can be mapped     */
-- 
2.17.0
