From: Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH 9/9] iommu/intel-svm: replace dev ops with generic fault notifier
Date: Tue, 27 Jun 2017 12:48:03 -0700
Message-ID: <1498592883-56224-10-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1498592883-56224-1-git-send-email-jacob.jun.pan@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1498592883-56224-1-git-send-email-jacob.jun.pan@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>, Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>
Cc: "Liu, Yi L" <yi.l.liu@intel.com>, Lan Tianyu <tianyu.lan@intel.com>, "Tian, Kevin" <kevin.tian@intel.com>, Raj Ashok <ashok.raj@intel.com>, Alex Williamson <alex.williamson@redhat.com>, Jean Delvare <khali@linux-fr.org>, Jacob Pan <jacob.jun.pan@linux.intel.com>
List-Id: iommu@lists.linux-foundation.org

Intel SVM devices register callbacks when bind task and PASID. These fault
callbacks are optional which can be replaced by the generic IOMMU fault
notifier APIs.

Currently, there is no main line kernel user of these callback functions.
Fault event data delivered by the IOMMU notification API is both generic
and contains raw data for architectural specific uses.

Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
Signed-off-by: Ashok Raj <ashok.raj@intel.com>
---
 drivers/iommu/intel-svm.c | 13 ++-----------
 include/linux/intel-svm.h | 20 +++-----------------
 2 files changed, 5 insertions(+), 28 deletions(-)

diff --git a/drivers/iommu/intel-svm.c b/drivers/iommu/intel-svm.c
index 98fca35..4831c6f 100644
--- a/drivers/iommu/intel-svm.c
+++ b/drivers/iommu/intel-svm.c
@@ -291,7 +291,7 @@ static const struct mmu_notifier_ops intel_mmuops = {
 
 static DEFINE_MUTEX(pasid_mutex);
 
-int intel_svm_bind_mm(struct device *dev, int *pasid, int flags, struct svm_dev_ops *ops)
+int intel_svm_bind_mm(struct device *dev, int *pasid, int flags)
 {
 	struct intel_iommu *iommu = intel_svm_device_to_iommu(dev);
 	struct intel_svm_dev *sdev;
@@ -337,10 +337,6 @@ int intel_svm_bind_mm(struct device *dev, int *pasid, int flags, struct svm_dev_
 
 			list_for_each_entry(sdev, &svm->devs, list) {
 				if (dev == sdev->dev) {
-					if (sdev->ops != ops) {
-						ret = -EBUSY;
-						goto out;
-					}
 					sdev->users++;
 					goto success;
 				}
@@ -366,7 +362,6 @@ int intel_svm_bind_mm(struct device *dev, int *pasid, int flags, struct svm_dev_
 	}
 	/* Finish the setup now we know we're keeping it */
 	sdev->users = 1;
-	sdev->ops = ops;
 	init_rcu_head(&sdev->rcu);
 
 	if (!svm) {
@@ -701,11 +696,7 @@ static irqreturn_t prq_event_thread(int irq, void *d)
 		if (WARN_ON(&sdev->list == &svm->devs))
 			sdev = NULL;
 
-		if (sdev && sdev->ops && sdev->ops->fault_cb) {
-			int rwxp = (req->rd_req << 3) | (req->wr_req << 2) |
-				(req->exe_req << 1) | (req->priv_req);
-			sdev->ops->fault_cb(sdev->dev, req->pasid, req->addr, req->private, rwxp, result);
-		}
+		intel_svm_prq_notify(sdev->dev, req);
 		/* We get here in the error case where the PASID lookup failed,
 		   and these can be NULL. Do not use them below this point! */
 		sdev = NULL;
diff --git a/include/linux/intel-svm.h b/include/linux/intel-svm.h
index 3c25794..67e056d3 100644
--- a/include/linux/intel-svm.h
+++ b/include/linux/intel-svm.h
@@ -18,18 +18,6 @@
 
 struct device;
 
-struct svm_dev_ops {
-	void (*fault_cb)(struct device *dev, int pasid, u64 address,
-			 u32 private, int rwxp, int response);
-};
-
-/* Values for rxwp in fault_cb callback */
-#define SVM_REQ_READ	(1<<3)
-#define SVM_REQ_WRITE	(1<<2)
-#define SVM_REQ_EXEC	(1<<1)
-#define SVM_REQ_PRIV	(1<<0)
-
-
 /*
  * The SVM_FLAG_PRIVATE_PASID flag requests a PASID which is *not* the "main"
  * PASID for the current process. Even if a PASID already exists, a new one
@@ -60,7 +48,6 @@ struct svm_dev_ops {
  * @dev:	Device to be granted acccess
  * @pasid:	Address for allocated PASID
  * @flags:	Flags. Later for requesting supervisor mode, etc.
- * @ops:	Callbacks to device driver
  *
  * This function attempts to enable PASID support for the given device.
  * If the @pasid argument is non-%NULL, a PASID is allocated for access
@@ -82,8 +69,7 @@ struct svm_dev_ops {
  * Multiple calls from the same process may result in the same PASID
  * being re-used. A reference count is kept.
  */
-extern int intel_svm_bind_mm(struct device *dev, int *pasid, int flags,
-			     struct svm_dev_ops *ops);
+extern int intel_svm_bind_mm(struct device *dev, int *pasid, int flags);
 
 /**
  * intel_svm_unbind_mm() - Unbind a specified PASID
@@ -105,7 +91,7 @@ extern int intel_svm_unbind_mm(struct device *dev, int pasid);
 #else /* CONFIG_INTEL_IOMMU_SVM */
 
 static inline int intel_svm_bind_mm(struct device *dev, int *pasid,
-				    int flags, struct svm_dev_ops *ops)
+				int flags)
 {
 	return -ENOSYS;
 }
@@ -116,6 +102,6 @@ static inline int intel_svm_unbind_mm(struct device *dev, int pasid)
 }
 #endif /* CONFIG_INTEL_IOMMU_SVM */
 
-#define intel_svm_available(dev) (!intel_svm_bind_mm((dev), NULL, 0, NULL))
+#define intel_svm_available(dev) (!intel_svm_bind_mm((dev), NULL, 0))
 
 #endif /* __INTEL_SVM_H__ */
-- 
2.7.4
