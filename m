From: Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v6 2/9] iommu/vt-d: Move enable pasid out of CONFIG_INTEL_IOMMU_SVM
Date: Wed, 13 Feb 2019 12:02:54 +0800
Message-ID: <20190213040301.23021-3-baolu.lu@linux.intel.com>
References: <20190213040301.23021-1-baolu.lu@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190213040301.23021-1-baolu.lu@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>, Alex Williamson <alex.williamson@redhat.com>, Kirti Wankhede <kwankhede@nvidia.com>
Cc: ashok.raj@intel.com, sanjay.k.kumar@intel.com, jacob.jun.pan@intel.com, kevin.tian@intel.com, Jean-Philippe Brucker <jean-philippe.brucker@arm.com>, yi.l.liu@intel.com, yi.y.sun@intel.com, peterx@redhat.com, tiwei.bie@intel.com, xin.zeng@intel.com, iommu@lists.linux-foundation.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, Lu Baolu <baolu.lu@linux.intel.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>
List-Id: iommu@lists.linux-foundation.org

This moves intel_iommu_enable_pasid() out of the scope of
CONFIG_INTEL_IOMMU_SVM with more and more features requiring
pasid function.

Cc: Ashok Raj <ashok.raj@intel.com>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel-iommu.c | 22 +++++++---------------
 drivers/iommu/intel-svm.c   | 19 ++++++++++++++++++-
 include/linux/intel-iommu.h |  2 +-
 3 files changed, 26 insertions(+), 17 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index af23cfc2a05e..c4e0024c9736 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -5295,8 +5295,7 @@ static void intel_iommu_put_resv_regions(struct device *dev,
 	}
 }
 
-#ifdef CONFIG_INTEL_IOMMU_SVM
-int intel_iommu_enable_pasid(struct intel_iommu *iommu, struct intel_svm_dev *sdev)
+int intel_iommu_enable_pasid(struct intel_iommu *iommu, struct device *dev)
 {
 	struct device_domain_info *info;
 	struct context_entry *context;
@@ -5305,7 +5304,7 @@ int intel_iommu_enable_pasid(struct intel_iommu *iommu, struct intel_svm_dev *sd
 	u64 ctx_lo;
 	int ret;
 
-	domain = get_valid_domain_for_dev(sdev->dev);
+	domain = get_valid_domain_for_dev(dev);
 	if (!domain)
 		return -EINVAL;
 
@@ -5313,7 +5312,7 @@ int intel_iommu_enable_pasid(struct intel_iommu *iommu, struct intel_svm_dev *sd
 	spin_lock(&iommu->lock);
 
 	ret = -EINVAL;
-	info = sdev->dev->archdata.iommu;
+	info = dev->archdata.iommu;
 	if (!info || !info->pasid_supported)
 		goto out;
 
@@ -5322,15 +5321,13 @@ int intel_iommu_enable_pasid(struct intel_iommu *iommu, struct intel_svm_dev *sd
 		goto out;
 
 	ctx_lo = context[0].lo;
-
-	sdev->did = domain->iommu_did[iommu->seq_id];
-	sdev->sid = PCI_DEVID(info->bus, info->devfn);
-
 	if (!(ctx_lo & CONTEXT_PASIDE)) {
 		ctx_lo |= CONTEXT_PASIDE;
 		context[0].lo = ctx_lo;
 		wmb();
-		iommu->flush.flush_context(iommu, sdev->did, sdev->sid,
+		iommu->flush.flush_context(iommu,
+					   domain->iommu_did[iommu->seq_id],
+					   PCI_DEVID(info->bus, info->devfn),
 					   DMA_CCMD_MASK_NOBIT,
 					   DMA_CCMD_DEVICE_INVL);
 	}
@@ -5339,12 +5336,6 @@ int intel_iommu_enable_pasid(struct intel_iommu *iommu, struct intel_svm_dev *sd
 	if (!info->pasid_enabled)
 		iommu_enable_dev_iotlb(info);
 
-	if (info->ats_enabled) {
-		sdev->dev_iotlb = 1;
-		sdev->qdep = info->ats_qdep;
-		if (sdev->qdep >= QI_DEV_EIOTLB_MAX_INVS)
-			sdev->qdep = 0;
-	}
 	ret = 0;
 
  out:
@@ -5354,6 +5345,7 @@ int intel_iommu_enable_pasid(struct intel_iommu *iommu, struct intel_svm_dev *sd
 	return ret;
 }
 
+#ifdef CONFIG_INTEL_IOMMU_SVM
 struct intel_iommu *intel_svm_device_to_iommu(struct device *dev)
 {
 	struct intel_iommu *iommu;
diff --git a/drivers/iommu/intel-svm.c b/drivers/iommu/intel-svm.c
index c79540deaf00..ecc255ddf6ae 100644
--- a/drivers/iommu/intel-svm.c
+++ b/drivers/iommu/intel-svm.c
@@ -228,6 +228,7 @@ static LIST_HEAD(global_svm_list);
 int intel_svm_bind_mm(struct device *dev, int *pasid, int flags, struct svm_dev_ops *ops)
 {
 	struct intel_iommu *iommu = intel_svm_device_to_iommu(dev);
+	struct device_domain_info *info;
 	struct intel_svm_dev *sdev;
 	struct intel_svm *svm = NULL;
 	struct mm_struct *mm = NULL;
@@ -291,13 +292,29 @@ int intel_svm_bind_mm(struct device *dev, int *pasid, int flags, struct svm_dev_
 	}
 	sdev->dev = dev;
 
-	ret = intel_iommu_enable_pasid(iommu, sdev);
+	ret = intel_iommu_enable_pasid(iommu, dev);
 	if (ret || !pasid) {
 		/* If they don't actually want to assign a PASID, this is
 		 * just an enabling check/preparation. */
 		kfree(sdev);
 		goto out;
 	}
+
+	info = dev->archdata.iommu;
+	if (!info || !info->pasid_supported) {
+		kfree(sdev);
+		goto out;
+	}
+
+	sdev->did = info->domain->iommu_did[iommu->seq_id];
+	sdev->sid = PCI_DEVID(info->bus, info->devfn);
+	if (info->ats_enabled) {
+		sdev->dev_iotlb = 1;
+		sdev->qdep = info->ats_qdep;
+		if (sdev->qdep >= QI_DEV_EIOTLB_MAX_INVS)
+			sdev->qdep = 0;
+	}
+
 	/* Finish the setup now we know we're keeping it */
 	sdev->users = 1;
 	sdev->ops = ops;
diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
index fa364de9db18..b7d1e2fbb9ca 100644
--- a/include/linux/intel-iommu.h
+++ b/include/linux/intel-iommu.h
@@ -650,6 +650,7 @@ struct intel_iommu *domain_get_iommu(struct dmar_domain *domain);
 int for_each_device_domain(int (*fn)(struct device_domain_info *info,
 				     void *data), void *data);
 void iommu_flush_write_buffer(struct intel_iommu *iommu);
+int intel_iommu_enable_pasid(struct intel_iommu *iommu, struct device *dev);
 
 #ifdef CONFIG_INTEL_IOMMU_SVM
 int intel_svm_init(struct intel_iommu *iommu);
@@ -679,7 +680,6 @@ struct intel_svm {
 	struct list_head list;
 };
 
-extern int intel_iommu_enable_pasid(struct intel_iommu *iommu, struct intel_svm_dev *sdev);
 extern struct intel_iommu *intel_svm_device_to_iommu(struct device *dev);
 #endif
 
-- 
2.17.1
