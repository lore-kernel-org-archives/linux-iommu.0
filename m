From: Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH v2 14/16] iommu/intel-svm: replace dev ops with fault report API
Date: Thu,  5 Oct 2017 16:03:42 -0700
Message-ID: <1507244624-39189-15-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1507244624-39189-1-git-send-email-jacob.jun.pan@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1507244624-39189-1-git-send-email-jacob.jun.pan@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>, Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rafael Wysocki <rafael.j.wysocki@intel.com>, Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Cc: "Liu, Yi L" <yi.l.liu@intel.com>, Lan Tianyu <tianyu.lan@intel.com>, "Tian, Kevin" <kevin.tian@intel.com>, Raj Ashok <ashok.raj@intel.com>, Alex Williamson <alex.williamson@redhat.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>
List-Id: iommu@lists.linux-foundation.org

With the introduction of generic IOMMU device fault reporting API, we
can replace the private fault callback functions with standard function
and event data.

Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 drivers/iommu/intel-svm.c |  7 +------
 include/linux/intel-svm.h | 20 +++-----------------
 2 files changed, 4 insertions(+), 23 deletions(-)

diff --git a/drivers/iommu/intel-svm.c b/drivers/iommu/intel-svm.c
index ea7c455..ea37d3e 100644
--- a/drivers/iommu/intel-svm.c
+++ b/drivers/iommu/intel-svm.c
@@ -283,7 +283,7 @@ static const struct mmu_notifier_ops intel_mmuops = {
 
 static DEFINE_MUTEX(pasid_mutex);
 
-int intel_svm_bind_mm(struct device *dev, int *pasid, int flags, struct svm_dev_ops *ops)
+int intel_svm_bind_mm(struct device *dev, int *pasid, int flags)
 {
 	struct intel_iommu *iommu = intel_svm_device_to_iommu(dev);
 	struct intel_svm_dev *sdev;
@@ -329,10 +329,6 @@ int intel_svm_bind_mm(struct device *dev, int *pasid, int flags, struct svm_dev_
 
 			list_for_each_entry(sdev, &svm->devs, list) {
 				if (dev == sdev->dev) {
-					if (sdev->ops != ops) {
-						ret = -EBUSY;
-						goto out;
-					}
 					sdev->users++;
 					goto success;
 				}
@@ -358,7 +354,6 @@ int intel_svm_bind_mm(struct device *dev, int *pasid, int flags, struct svm_dev_
 	}
 	/* Finish the setup now we know we're keeping it */
 	sdev->users = 1;
-	sdev->ops = ops;
 	init_rcu_head(&sdev->rcu);
 
 	if (!svm) {
diff --git a/include/linux/intel-svm.h b/include/linux/intel-svm.h
index 99bc5b3..a39a502 100644
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
@@ -120,7 +106,7 @@ extern int intel_svm_is_pasid_valid(struct device *dev, int pasid);
 #else /* CONFIG_INTEL_IOMMU_SVM */
 
 static inline int intel_svm_bind_mm(struct device *dev, int *pasid,
-				    int flags, struct svm_dev_ops *ops)
+				int flags)
 {
 	return -ENOSYS;
 }
@@ -136,6 +122,6 @@ static int intel_svm_is_pasid_valid(struct device *dev, int pasid)
 }
 #endif /* CONFIG_INTEL_IOMMU_SVM */
 
-#define intel_svm_available(dev) (!intel_svm_bind_mm((dev), NULL, 0, NULL))
+#define intel_svm_available(dev) (!intel_svm_bind_mm((dev), NULL, 0))
 
 #endif /* __INTEL_SVM_H__ */
-- 
2.7.4
