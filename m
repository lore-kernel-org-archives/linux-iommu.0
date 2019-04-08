From: Jacob Pan <jacob.jun.pan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH 07/18] iommu: Introduce attach/detach_pasid_table API
Date: Mon,  8 Apr 2019 16:59:22 -0700
Message-ID: <1554767973-30125-8-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1554767973-30125-1-git-send-email-jacob.jun.pan@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1554767973-30125-1-git-send-email-jacob.jun.pan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>
Cc: Yi L <yi.l.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, "Tian, Kevin" <kevin.tian-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Raj Ashok <ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Liu-i9wRM+HIrmnmtl4Z8vJ8Kg761KYD1DLY@public.gmane.org, Andriy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

In virtualization use case, when a guest is assigned
a PCI host device, protected by a virtual IOMMU on the guest,
the physical IOMMU must be programmed to be consistent with
the guest mappings. If the physical IOMMU supports two
translation stages it makes sense to program guest mappings
onto the first stage/level (ARM/Intel terminology) while the host
owns the stage/level 2.

In that case, it is mandated to trap on guest configuration
settings and pass those to the physical iommu driver.

This patch adds a new API to the iommu subsystem that allows
to set/unset the pasid table information.

A generic iommu_pasid_table_config struct is introduced in
a new iommu.h uapi header. This is going to be used by the VFIO
user API.

Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>
Signed-off-by: Liu, Yi L <yi.l.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Signed-off-by: Ashok Raj <ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Signed-off-by: Jacob Pan <jacob.jun.pan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Signed-off-by: Eric Auger <eric.auger-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

---

This patch generalizes the API introduced by Jacob & co-authors in
https://lwn.net/Articles/754331/

v3 -> v4:
- s/set_pasid_table/attach_pasid_table
- restore detach_pasid_table. Detach can be used on unwind path.
- add padding
- remove @abort
- signature used for config and format
- add comments for fields in the SMMU struct

v2 -> v3:
- replace unbind/bind by set_pasid_table
- move table pointer and pasid bits in the generic part of the struct

v1 -> v2:
- restore the original pasid table name
- remove the struct device * parameter in the API
- reworked iommu_pasid_smmuv3
---
 drivers/iommu/iommu.c      | 19 +++++++++++++++++++
 include/linux/iommu.h      | 22 ++++++++++++++++++++++
 include/uapi/linux/iommu.h | 47 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 88 insertions(+)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index ac7e6b3..242f702 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -1547,6 +1547,25 @@ int iommu_attach_device(struct iommu_domain *domain, struct device *dev)
 }
 EXPORT_SYMBOL_GPL(iommu_attach_device);
 
+int iommu_attach_pasid_table(struct iommu_domain *domain,
+			     struct iommu_pasid_table_config *cfg)
+{
+	if (unlikely(!domain->ops->attach_pasid_table))
+		return -ENODEV;
+
+	return domain->ops->attach_pasid_table(domain, cfg);
+}
+EXPORT_SYMBOL_GPL(iommu_attach_pasid_table);
+
+void iommu_detach_pasid_table(struct iommu_domain *domain)
+{
+	if (unlikely(!domain->ops->detach_pasid_table))
+		return;
+
+	domain->ops->detach_pasid_table(domain);
+}
+EXPORT_SYMBOL_GPL(iommu_detach_pasid_table);
+
 static void __iommu_detach_device(struct iommu_domain *domain,
 				  struct device *dev)
 {
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index f12f251..9f870ae 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -190,6 +190,8 @@ struct iommu_resv_region {
  * @is_attach_deferred: Check if domain attach should be deferred from iommu
  *                      driver init to device driver init (default no)
  * @pgsize_bitmap: bitmap of all possible supported page sizes
+ * @attach_pasid_table: attach a pasid table
+ * @detach_pasid_table: detach the pasid table
  */
 struct iommu_ops {
 	bool (*capable)(enum iommu_cap);
@@ -233,6 +235,10 @@ struct iommu_ops {
 	int (*of_xlate)(struct device *dev, struct of_phandle_args *args);
 	bool (*is_attach_deferred)(struct iommu_domain *domain, struct device *dev);
 
+	int (*attach_pasid_table)(struct iommu_domain *domain,
+				  struct iommu_pasid_table_config *cfg);
+	void (*detach_pasid_table)(struct iommu_domain *domain);
+
 	unsigned long pgsize_bitmap;
 };
 
@@ -343,6 +349,9 @@ extern int iommu_attach_device(struct iommu_domain *domain,
 			       struct device *dev);
 extern void iommu_detach_device(struct iommu_domain *domain,
 				struct device *dev);
+extern int iommu_attach_pasid_table(struct iommu_domain *domain,
+				    struct iommu_pasid_table_config *cfg);
+extern void iommu_detach_pasid_table(struct iommu_domain *domain);
 extern struct iommu_domain *iommu_get_domain_for_dev(struct device *dev);
 extern struct iommu_domain *iommu_get_dma_domain(struct device *dev);
 extern int iommu_map(struct iommu_domain *domain, unsigned long iova,
@@ -781,6 +790,19 @@ const struct iommu_ops *iommu_ops_from_fwnode(struct fwnode_handle *fwnode)
 	return NULL;
 }
 
+static inline
+int iommu_attach_pasid_table(struct iommu_domain *domain,
+			     struct iommu_pasid_table_config *cfg)
+{
+	return -ENODEV;
+}
+
+static inline
+void iommu_detach_pasid_table(struct iommu_domain *domain)
+{
+	return -ENODEV;
+}
+
 #endif /* CONFIG_IOMMU_API */
 
 #ifdef CONFIG_IOMMU_DEBUGFS
diff --git a/include/uapi/linux/iommu.h b/include/uapi/linux/iommu.h
index 7ebf23e..e9065bf 100644
--- a/include/uapi/linux/iommu.h
+++ b/include/uapi/linux/iommu.h
@@ -112,4 +112,51 @@ struct iommu_fault {
 		struct iommu_fault_page_request prm;
 	};
 };
+
+/**
+ * SMMUv3 Stream Table Entry stage 1 related information
+ * The PASID table is referred to as the context descriptor (CD) table.
+ *
+ * @s1fmt: STE s1fmt (format of the CD table: single CD, linear table
+   or 2-level table)
+ * @s1dss: STE s1dss (specifies the behavior when pasid_bits != 0
+   and no pasid is passed along with the incoming transaction)
+ * Please refer to the smmu 3.x spec (ARM IHI 0070A) for full details
+ */
+struct iommu_pasid_smmuv3 {
+#define PASID_TABLE_SMMUV3_CFG_VERSION_1 1
+	__u32	version;
+	__u8 s1fmt;
+	__u8 s1dss;
+	__u8 padding[2];
+};
+
+/**
+ * PASID table data used to bind guest PASID table to the host IOMMU
+ * Note PASID table corresponds to the Context Table on ARM SMMUv3.
+ *
+ * @version: API version to prepare for future extensions
+ * @format: format of the PASID table
+ * @base_ptr: guest physical address of the PASID table
+ * @pasid_bits: number of PASID bits used in the PASID table
+ * @config: indicates whether the guest translation stage must
+ * be translated, bypassed or aborted.
+ */
+struct iommu_pasid_table_config {
+#define PASID_TABLE_CFG_VERSION_1 1
+	__u32	version;
+#define IOMMU_PASID_FORMAT_SMMUV3	1
+	__u32	format;
+	__u64	base_ptr;
+	__u8	pasid_bits;
+#define IOMMU_PASID_CONFIG_TRANSLATE	1
+#define IOMMU_PASID_CONFIG_BYPASS	2
+#define IOMMU_PASID_CONFIG_ABORT	3
+	__u8	config;
+	__u8    padding[6];
+	union {
+		struct iommu_pasid_smmuv3 smmuv3;
+	};
+};
+
 #endif /* _UAPI_IOMMU_H */
-- 
2.7.4
