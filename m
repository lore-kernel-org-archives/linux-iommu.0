From: Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH v2 03/16] iommu: introduce iommu invalidate API function
Date: Thu,  5 Oct 2017 16:03:31 -0700
Message-ID: <1507244624-39189-4-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1507244624-39189-1-git-send-email-jacob.jun.pan@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1507244624-39189-1-git-send-email-jacob.jun.pan@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>, Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rafael Wysocki <rafael.j.wysocki@intel.com>, Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Cc: "Liu, Yi L" <yi.l.liu@intel.com>, Lan Tianyu <tianyu.lan@intel.com>, "Tian, Kevin" <kevin.tian@intel.com>, Raj Ashok <ashok.raj@intel.com>, Alex Williamson <alex.williamson@redhat.com>, "Liu, Yi L" <yi.l.liu@linux.intel.com>, Liu@vger.kernel.org, Jacob Pan <jacob.jun.pan@linux.intel.com>
List-Id: iommu@lists.linux-foundation.org

From: "Liu, Yi L" <yi.l.liu@linux.intel.com>

When an SVM capable device is assigned to a guest, the first level page
tables are owned by the guest and the guest PASID table pointer is
linked to the device context entry of the physical IOMMU.

Host IOMMU driver has no knowledge of caching structure updates unless
the guest invalidation activities are passed down to the host. The
primary usage is derived from emulated IOMMU in the guest, where QEMU
can trap invalidation activities before passing them down to the
host/physical IOMMU.
Since the invalidation data are obtained from user space and will be
written into physical IOMMU, we must allow security check at various
layers. Therefore, generic invalidation data format are proposed here,
model specific IOMMU drivers need to convert them into their own format.

Signed-off-by: Liu, Yi L <yi.l.liu@linux.intel.com>
Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
Signed-off-by: Ashok Raj <ashok.raj@intel.com>
---
 drivers/iommu/iommu.c      | 14 +++++++++++
 include/linux/iommu.h      | 12 +++++++++
 include/uapi/linux/iommu.h | 62 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 88 insertions(+)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 761cf50..5a14154 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -1341,6 +1341,20 @@ int iommu_unbind_pasid_table(struct iommu_domain *domain, struct device *dev)
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
index 672cc06..4af1820 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -190,6 +190,7 @@ struct iommu_resv_region {
  * @pgsize_bitmap: bitmap of all possible supported page sizes
  * @bind_pasid_table: bind pasid table pointer for guest SVM
  * @unbind_pasid_table: unbind pasid table pointer and restore defaults
+ * @invalidate: invalidate translation caches
  */
 struct iommu_ops {
 	bool (*capable)(enum iommu_cap);
@@ -243,6 +244,8 @@ struct iommu_ops {
 				struct pasid_table_config *pasidt_binfo);
 	int (*unbind_pasid_table)(struct iommu_domain *domain,
 				struct device *dev);
+	int (*invalidate)(struct iommu_domain *domain,
+		struct device *dev, struct tlb_invalidate_info *inv_info);
 
 	unsigned long pgsize_bitmap;
 };
@@ -309,6 +312,9 @@ extern int iommu_bind_pasid_table(struct iommu_domain *domain,
 		struct device *dev, struct pasid_table_config *pasidt_binfo);
 extern int iommu_unbind_pasid_table(struct iommu_domain *domain,
 				struct device *dev);
+extern int iommu_invalidate(struct iommu_domain *domain,
+		struct device *dev, struct tlb_invalidate_info *inv_info);
+
 extern struct iommu_domain *iommu_get_domain_for_dev(struct device *dev);
 extern int iommu_map(struct iommu_domain *domain, unsigned long iova,
 		     phys_addr_t paddr, size_t size, int prot);
@@ -721,6 +727,12 @@ int iommu_unbind_pasid_table(struct iommu_domain *domain, struct device *dev)
 	return -EINVAL;
 }
 
+static inline int iommu_invalidate(struct iommu_domain *domain,
+		struct device *dev, struct tlb_invalidate_info *inv_info)
+{
+	return -EINVAL;
+}
+
 #endif /* CONFIG_IOMMU_API */
 
 #endif /* __LINUX_IOMMU_H */
diff --git a/include/uapi/linux/iommu.h b/include/uapi/linux/iommu.h
index aeeaf0e..ee11aae 100644
--- a/include/uapi/linux/iommu.h
+++ b/include/uapi/linux/iommu.h
@@ -52,4 +52,66 @@ struct pasid_table_config {
 	};
 };
 
+enum iommu_inv_granularity {
+	IOMMU_INV_GRANU_GLOBAL,		/* all TLBs invalidated */
+	IOMMU_INV_GRANU_DOMAIN,		/* all TLBs associated with a domain */
+	IOMMU_INV_GRANU_DEVICE,		/* caching structure associated with a
+					 * device ID
+					 */
+	IOMMU_INV_GRANU_DOMAN_PAGE,	/* address range with a domain */
+	IOMMU_INV_GRANU_ALL_PASID,	/* cache of a given PASID */
+	IOMMU_INV_GRANU_PASID_SEL,	/* only invalidate specified PASID */
+
+	IOMMU_INV_GRANU_NG_ALL_PASID,	/* non-global within all PASIDs */
+	IOMMU_INV_GRANU_NG_PASID,	/* non-global within a PASIDs */
+	IOMMU_INV_GRANU_PAGE_PASID,	/* page-selective within a PASID */
+	IOMMU_INV_NR_GRANU,
+};
+
+enum iommu_inv_type {
+	IOMMU_INV_TYPE_DTLB,	/* device IOTLB */
+	IOMMU_INV_TYPE_TLB,	/* IOMMU paging structure cache */
+	IOMMU_INV_TYPE_PASID,	/* PASID cache */
+	IOMMU_INV_TYPE_CONTEXT,	/* device context entry cache */
+	IOMMU_INV_NR_TYPE
+};
+
+/**
+ * Translation cache invalidation header that contains mandatory meta data.
+ * @version:	info format version, expecting future extesions
+ * @type:	type of translation cache to be invalidated
+ */
+struct tlb_invalidate_hdr {
+	__u32 version;
+#define TLB_INV_HDR_VERSION_1 1
+	enum iommu_inv_type type;
+};
+
+/**
+ * Translation cache invalidation information, contains generic IOMMU
+ * data which can be parsed based on model ID by model specific drivers.
+ *
+ * @granularity:	requested invalidation granularity, type dependent
+ * @size:		2^size of 4K pages, 0 for 4k, 9 for 2MB, etc.
+ * @pasid:		processor address space ID value per PCI spec.
+ * @addr:		page address to be invalidated
+ * @flags	IOMMU_INVALIDATE_NO_PASID: targets non-pasid mappings,
+ *					@pasid is not valid
+ *		IOMMU_INVALIDATE_ADDR_LEAF: indicating that the pIOMMU
+ *		IOMMU_INVALIDATE_GLOBAL_PAGE: global pages
+ *		IOMMU_INVALIDATE_DMA_PASID: DMA request with PASID
+ *
+ */
+struct tlb_invalidate_info {
+	struct tlb_invalidate_hdr	hdr;
+	enum iommu_inv_granularity	granularity;
+	__u32		flags;
+#define IOMMU_INVALIDATE_NO_PASID	(1 << 0)
+#define IOMMU_INVALIDATE_ADDR_LEAF	(1 << 1)
+#define IOMMU_INVALIDATE_GLOBAL_PAGE	(1 << 2)
+#define IOMMU_INVALIDATE_DMA_PASID	(1 << 3)
+	__u8		size;
+	__u32		pasid;
+	__u64		addr;
+};
 #endif /* _UAPI_IOMMU_H */
-- 
2.7.4
