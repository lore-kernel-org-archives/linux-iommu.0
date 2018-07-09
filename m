From: Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v4 5/9] iommu/vt-d: Add for_each_device_domain() helper
Date: Mon,  9 Jul 2018 13:22:54 +0800
Message-ID: <1531113778-28238-6-git-send-email-baolu.lu@linux.intel.com>
References: <1531113778-28238-1-git-send-email-baolu.lu@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1531113778-28238-1-git-send-email-baolu.lu@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>
Cc: ashok.raj@intel.com, sanjay.k.kumar@intel.com, jacob.jun.pan@intel.com, kevin.tian@intel.com, yi.l.liu@intel.com, yi.y.sun@intel.com, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Lu Baolu <baolu.lu@linux.intel.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>
List-Id: iommu@lists.linux-foundation.org

This adds a helper named for_each_device_domain() to iterate
over the elements in device_domain_list and invoke a callback
against each element. This allows to search the device_domain
list in other source files.

Cc: Ashok Raj <ashok.raj@intel.com>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: Kevin Tian <kevin.tian@intel.com>
Cc: Liu Yi L <yi.l.liu@intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Liu Yi L <yi.l.liu@intel.com>
---
 drivers/iommu/intel-iommu.c | 21 +++++++++++++++++++++
 include/linux/intel-iommu.h |  2 ++
 2 files changed, 23 insertions(+)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index d7d2ff9..3d802c5 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -447,6 +447,27 @@ EXPORT_SYMBOL_GPL(intel_iommu_gfx_mapped);
 static DEFINE_SPINLOCK(device_domain_lock);
 static LIST_HEAD(device_domain_list);
 
+/*
+ * Iterate over elements in device_domain_list and call the specified
+ * callback @fn against each element. This helper should only be used
+ * in the context where the device_domain_lock has already been holden.
+ */
+int for_each_device_domain(int (*fn)(struct device_domain_info *info,
+				     void *data), void *data)
+{
+	int ret = 0;
+	struct device_domain_info *info;
+
+	assert_spin_locked(&device_domain_lock);
+	list_for_each_entry(info, &device_domain_list, global) {
+		ret = fn(info, data);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
 const struct iommu_ops intel_iommu_ops;
 
 static bool translation_pre_enabled(struct intel_iommu *iommu)
diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
index 2e1fbde..4fd4c6f 100644
--- a/include/linux/intel-iommu.h
+++ b/include/linux/intel-iommu.h
@@ -520,6 +520,8 @@ struct dmar_domain *get_valid_domain_for_dev(struct device *dev);
 void *alloc_pgtable_page(int node);
 void free_pgtable_page(void *vaddr);
 struct intel_iommu *domain_get_iommu(struct dmar_domain *domain);
+int for_each_device_domain(int (*fn)(struct device_domain_info *info,
+				     void *data), void *data);
 
 #ifdef CONFIG_INTEL_IOMMU_SVM
 extern int intel_svm_alloc_pasid_tables(struct intel_iommu *iommu);
-- 
2.7.4
