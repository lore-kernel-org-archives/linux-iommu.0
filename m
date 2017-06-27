From: Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH 1/9] iommu: Introduce bind_pasid_table API function
Date: Tue, 27 Jun 2017 12:47:55 -0700
Message-ID: <1498592883-56224-2-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1498592883-56224-1-git-send-email-jacob.jun.pan@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1498592883-56224-1-git-send-email-jacob.jun.pan@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>, Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>
Cc: "Liu, Yi L" <yi.l.liu@intel.com>, Lan Tianyu <tianyu.lan@intel.com>, "Tian, Kevin" <kevin.tian@intel.com>, Raj Ashok <ashok.raj@intel.com>, Alex Williamson <alex.williamson@redhat.com>, Jean Delvare <khali@linux-fr.org>, Jacob Pan <jacob.jun.pan@linux.intel.com>, Liu@vger.kernel.org, Yi L <yi.l.liu@linux.intel.com>
List-Id: iommu@lists.linux-foundation.org

Virtual IOMMU was proposed to support Shared Virtual Memory (SVM) use
case in the guest:
https://lists.gnu.org/archive/html/qemu-devel/2016-11/msg05311.html

As part of the proposed architecture, when a SVM capable PCI
device is assigned to a guest, nested mode is turned on. Guest owns the
first level page tables (request with PASID) and performs GVA->GPA
translation. Second level page tables are owned by the host for GPA->HPA
translation for both request with and without PASID.

A new IOMMU driver interface is therefore needed to perform tasks as
follows:
* Enable nested translation and appropriate translation type
* Assign guest PASID table pointer (in GPA) and size to host IOMMU

This patch introduces new functions called iommu_(un)bind_pasid_table()
to IOMMU APIs. Architecture specific IOMMU function can be added later
to perform the specific steps for binding pasid table of assigned devices.

This patch also adds model definition in iommu.h. It would be used to
check if the bind request is from a compatible entity. e.g. a bind
request from an intel_iommu emulator may not be supported by an ARM SMMU
driver.

Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
Signed-off-by: Liu, Yi L <yi.l.liu@linux.intel.com>
Signed-off-by: Ashok Raj <ashok.raj@intel.com>
---
 drivers/iommu/iommu.c      | 19 +++++++++++++++++++
 include/linux/iommu.h      | 23 +++++++++++++++++++++++
 include/uapi/linux/iommu.h | 38 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 80 insertions(+)
 create mode 100644 include/uapi/linux/iommu.h

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index cf7ca7e..494309b 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -1328,6 +1328,25 @@ int iommu_attach_device(struct iommu_domain *domain, struct device *dev)
 }
 EXPORT_SYMBOL_GPL(iommu_attach_device);
 
+int iommu_bind_pasid_table(struct iommu_domain *domain, struct device *dev,
+			struct pasid_table_info *pasidt_binfo)
+{
+	if (unlikely(!domain->ops->bind_pasid_table))
+		return -EINVAL;
+
+	return domain->ops->bind_pasid_table(domain, dev, pasidt_binfo);
+}
+EXPORT_SYMBOL_GPL(iommu_bind_pasid_table);
+
+int iommu_unbind_pasid_table(struct iommu_domain *domain, struct device *dev)
+{
+	if (unlikely(!domain->ops->unbind_pasid_table))
+		return -EINVAL;
+
+	return domain->ops->unbind_pasid_table(domain, dev);
+}
+EXPORT_SYMBOL_GPL(iommu_unbind_pasid_table);
+
 static void __iommu_detach_device(struct iommu_domain *domain,
 				  struct device *dev)
 {
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 2cb54ad..7122add 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -25,6 +25,7 @@
 #include <linux/errno.h>
 #include <linux/err.h>
 #include <linux/of.h>
+#include <uapi/linux/iommu.h>
 
 #define IOMMU_READ	(1 << 0)
 #define IOMMU_WRITE	(1 << 1)
@@ -183,6 +184,8 @@ struct iommu_resv_region {
  * @domain_get_windows: Return the number of windows for a domain
  * @of_xlate: add OF master IDs to iommu grouping
  * @pgsize_bitmap: bitmap of all possible supported page sizes
+ * @bind_pasid_table: bind pasid table pointer for guest SVM
+ * @unbind_pasid_table: unbind pasid table pointer and restore defaults
  */
 struct iommu_ops {
 	bool (*capable)(enum iommu_cap);
@@ -225,6 +228,10 @@ struct iommu_ops {
 	u32 (*domain_get_windows)(struct iommu_domain *domain);
 
 	int (*of_xlate)(struct device *dev, struct of_phandle_args *args);
+	int (*bind_pasid_table)(struct iommu_domain *domain, struct device *dev,
+				struct pasid_table_info *pasidt_binfo);
+	int (*unbind_pasid_table)(struct iommu_domain *domain,
+				struct device *dev);
 
 	unsigned long pgsize_bitmap;
 };
@@ -282,6 +289,10 @@ extern int iommu_attach_device(struct iommu_domain *domain,
 			       struct device *dev);
 extern void iommu_detach_device(struct iommu_domain *domain,
 				struct device *dev);
+extern int iommu_bind_pasid_table(struct iommu_domain *domain,
+		struct device *dev, struct pasid_table_info *pasidt_binfo);
+extern int iommu_unbind_pasid_table(struct iommu_domain *domain,
+				struct device *dev);
 extern struct iommu_domain *iommu_get_domain_for_dev(struct device *dev);
 extern int iommu_map(struct iommu_domain *domain, unsigned long iova,
 		     phys_addr_t paddr, size_t size, int prot);
@@ -637,6 +648,18 @@ const struct iommu_ops *iommu_ops_from_fwnode(struct fwnode_handle *fwnode)
 	return NULL;
 }
 
+static inline
+int iommu_bind_pasid_table(struct iommu_domain *domain, struct device *dev,
+			struct pasid_table_info *pasidt_binfo)
+{
+	return -EINVAL;
+}
+static inline
+int iommu_unbind_pasid_table(struct iommu_domain *domain, struct device *dev)
+{
+	return -EINVAL;
+}
+
 #endif /* CONFIG_IOMMU_API */
 
 #endif /* __LINUX_IOMMU_H */
diff --git a/include/uapi/linux/iommu.h b/include/uapi/linux/iommu.h
new file mode 100644
index 0000000..9089a30
--- /dev/null
+++ b/include/uapi/linux/iommu.h
@@ -0,0 +1,38 @@
+/*
+ * IOMMU user API definitions
+ *
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef _UAPI_IOMMU_H
+#define _UAPI_IOMMU_H
+
+#include <linux/types.h>
+
+enum iommu_model {
+	IOMMU_MODEL_INTEL_VTD,
+	IOMMU_MODEL_ARM_SMMU,
+};
+
+/*
+ * PASID table data used to bind guest PASID table to the host IOMMU. This will
+ * enable guest managed first level page tables.
+ * @ptr		PASID table pointer
+ * @size	size of the guest PASID table in bytes, must be <= host table size
+ * @model	iommu_model number
+ * @length	length of the opaque data in bytes
+ * @opaque	model specific IOMMU data
+ */
+struct pasid_table_info {
+	__u64	ptr;
+	__u64	size;
+	__u32	model;
+	__u32	length;
+	__u8	opaque[];
+};
+
+
+#endif /* _UAPI_IOMMU_H */
-- 
2.7.4
