From: Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH 3/9] iommu: Introduce iommu do invalidate API function
Date: Tue, 27 Jun 2017 12:47:57 -0700
Message-ID: <1498592883-56224-4-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1498592883-56224-1-git-send-email-jacob.jun.pan@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1498592883-56224-1-git-send-email-jacob.jun.pan@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>, Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>
Cc: "Liu, Yi L" <yi.l.liu@intel.com>, Lan Tianyu <tianyu.lan@intel.com>, "Tian, Kevin" <kevin.tian@intel.com>, Raj Ashok <ashok.raj@intel.com>, Alex Williamson <alex.williamson@redhat.com>, Jean Delvare <khali@linux-fr.org>, "Liu, Yi L" <yi.l.liu@linux.intel.com>, Liu@vger.kernel.org, Jacob Pan <jacob.jun.pan@linux.intel.com>
List-Id: iommu@lists.linux-foundation.org

From: "Liu, Yi L" <yi.l.liu@linux.intel.com>

When a SVM capable device is assigned to a guest, the first level page
tables are owned by the guest and the guest PASID table pointer is
linked to the device context entry of the physical IOMMU.

Host IOMMU driver has no knowledge of caching structure updates unless
the guest invalidation activities are passed down to the host. The
primary usage is derived from emulated IOMMU in the guest, where QEMU
can trap invalidation activities before pass them down the
host/physical IOMMU. There are IOMMU architectural specific actions
need to be taken which requires the generic APIs introduced in this
patch to have opaque data in the tlb_invalidate_info argument.

Signed-off-by: Liu, Yi L <yi.l.liu@linux.intel.com>
Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
Signed-off-by: Ashok Raj <ashok.raj@intel.com>
---
 drivers/iommu/iommu.c      | 14 ++++++++++++++
 include/linux/iommu.h      | 12 ++++++++++++
 include/uapi/linux/iommu.h | 13 +++++++++++++
 3 files changed, 39 insertions(+)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 494309b..d973555 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -1347,6 +1347,20 @@ int iommu_unbind_pasid_table(struct iommu_domain *domain, struct device *dev)
 }
 EXPORT_SYMBOL_GPL(iommu_unbind_pasid_table);
 
+int iommu_invalidate(struct iommu_domain *domain,
+		struct device *dev, struct tlb_invalidate_info *inv_info)
+{
+	int ret = 0;
+
+	if (unlikely(!domain->ops->invalidate))
+		return -ENODEV;
+
+	ret = domain->ops->invalidate(domain, dev, inv_info);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(iommu_invalidate);
+
 static void __iommu_detach_device(struct iommu_domain *domain,
 				  struct device *dev)
 {
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 7122add..fbc08ae 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -186,6 +186,7 @@ struct iommu_resv_region {
  * @pgsize_bitmap: bitmap of all possible supported page sizes
  * @bind_pasid_table: bind pasid table pointer for guest SVM
  * @unbind_pasid_table: unbind pasid table pointer and restore defaults
+ * @invalidate: invalidate translation caches
  */
 struct iommu_ops {
 	bool (*capable)(enum iommu_cap);
@@ -232,6 +233,8 @@ struct iommu_ops {
 				struct pasid_table_info *pasidt_binfo);
 	int (*unbind_pasid_table)(struct iommu_domain *domain,
 				struct device *dev);
+	int (*invalidate)(struct iommu_domain *domain,
+		struct device *dev, struct tlb_invalidate_info *inv_info);
 
 	unsigned long pgsize_bitmap;
 };
@@ -293,6 +296,9 @@ extern int iommu_bind_pasid_table(struct iommu_domain *domain,
 		struct device *dev, struct pasid_table_info *pasidt_binfo);
 extern int iommu_unbind_pasid_table(struct iommu_domain *domain,
 				struct device *dev);
+extern int iommu_do_invalidate(struct iommu_domain *domain,
+		struct device *dev, struct tlb_invalidate_info *inv_info);
+
 extern struct iommu_domain *iommu_get_domain_for_dev(struct device *dev);
 extern int iommu_map(struct iommu_domain *domain, unsigned long iova,
 		     phys_addr_t paddr, size_t size, int prot);
@@ -660,6 +666,12 @@ int iommu_unbind_pasid_table(struct iommu_domain *domain, struct device *dev)
 	return -EINVAL;
 }
 
+static inline int iommu_do_invalidate(struct iommu_domain *domain,
+		struct device *dev, struct tlb_invalidate_info *inv_info)
+{
+	return -EINVAL;
+}
+
 #endif /* CONFIG_IOMMU_API */
 
 #endif /* __LINUX_IOMMU_H */
diff --git a/include/uapi/linux/iommu.h b/include/uapi/linux/iommu.h
index 9089a30..f077353 100644
--- a/include/uapi/linux/iommu.h
+++ b/include/uapi/linux/iommu.h
@@ -34,5 +34,18 @@ struct pasid_table_info {
 	__u8	opaque[];
 };
 
+/*
+ * Translation cache invalidation information, contains IOMMU model specific
+ * data which can be parsed based on model ID by model specific drivers.
+ *
+ * @model	iommu_model number
+ * @length	length of the opaque data in bytes
+ * @opaque	model specific IOMMU data
+ */
+struct tlb_invalidate_info {
+	__u32	model;
+	__u32	length;
+	__u8	opaque[];
+};
 
 #endif /* _UAPI_IOMMU_H */
-- 
2.7.4
