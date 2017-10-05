From: Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH v2 15/16] iommu: introduce page response function
Date: Thu,  5 Oct 2017 16:03:43 -0700
Message-ID: <1507244624-39189-16-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1507244624-39189-1-git-send-email-jacob.jun.pan@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1507244624-39189-1-git-send-email-jacob.jun.pan@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>, Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rafael Wysocki <rafael.j.wysocki@intel.com>, Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Cc: "Liu, Yi L" <yi.l.liu@intel.com>, Lan Tianyu <tianyu.lan@intel.com>, "Tian, Kevin" <kevin.tian@intel.com>, Raj Ashok <ashok.raj@intel.com>, Alex Williamson <alex.williamson@redhat.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>
List-Id: iommu@lists.linux-foundation.org

When nested translation is turned on and guest owns the
first level page tables, device page request can be forwared
to the guest for handling faults. As the page response returns
by the guest, IOMMU driver on the host need to process the
response which informs the device and completes the page request
transaction.

This patch introduces generic API function for page response
passing from the guest or other in-kernel users. The definitions of
the generic data is based on PCI ATS specification not limited to
any vendor.

Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 drivers/iommu/iommu.c | 14 ++++++++++++++
 include/linux/iommu.h | 42 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 56 insertions(+)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 0b058e2..b1c9a0e 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -1409,6 +1409,20 @@ int iommu_invalidate(struct iommu_domain *domain,
 }
 EXPORT_SYMBOL_GPL(iommu_invalidate);
 
+int iommu_page_response(struct iommu_domain *domain, struct device *dev,
+			struct page_response_msg *msg)
+{
+	int ret = 0;
+
+	if (unlikely(!domain->ops->page_response))
+		return -ENODEV;
+
+	ret = domain->ops->page_response(domain, dev, msg);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(iommu_page_response);
+
 static void __iommu_detach_device(struct iommu_domain *domain,
 				  struct device *dev)
 {
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index a675775..c289760 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -161,6 +161,43 @@ struct iommu_resv_region {
 
 #ifdef CONFIG_IOMMU_API
 
+enum page_response_type {
+	IOMMU_PAGE_STREAM_RESP = 1,
+	IOMMU_PAGE_GROUP_RESP,
+};
+
+/**
+ * Generic page response information based on PCI ATS and PASID spec.
+ * @paddr: servicing page address
+ * @pasid: contains process address space ID, used in shared virtual memory(SVM)
+ * @rid: requestor ID
+ * @did: destination device ID
+ * @last_req: last request in a page request group
+ * @resp_code: response code
+ * @page_req_group_id: page request group index
+ * @prot: page access protection flag, e.g. IOMMU_READ, IOMMU_WRITE
+ * @type: group or stream response
+ * @private_data: uniquely identify device-specific private data for an
+ *                individual page response
+
+ */
+struct page_response_msg {
+	u64 paddr;
+	u32 pasid;
+	u32 rid:16;
+	u32 did:16;
+	u32 resp_code:4;
+	u32 last_req:1;
+	u32 pasid_present:1;
+#define IOMMU_PAGE_RESP_SUCCESS	0
+#define IOMMU_PAGE_RESP_INVALID	1
+#define IOMMU_PAGE_RESP_FAILURE	0xF
+	u32 page_req_group_id : 9;
+	u32 prot;
+	enum page_response_type type;
+	u32 private_data;
+};
+
 /**
  * struct iommu_ops - iommu ops and capabilities
  * @capable: check capability
@@ -194,6 +231,7 @@ struct iommu_resv_region {
  * @bind_pasid_table: bind pasid table pointer for guest SVM
  * @unbind_pasid_table: unbind pasid table pointer and restore defaults
  * @invalidate: invalidate translation caches
+ * @page_response: handle page request response
  */
 struct iommu_ops {
 	bool (*capable)(enum iommu_cap);
@@ -249,6 +287,8 @@ struct iommu_ops {
 				struct device *dev);
 	int (*invalidate)(struct iommu_domain *domain,
 		struct device *dev, struct tlb_invalidate_info *inv_info);
+	int (*page_response)(struct iommu_domain *domain, struct device *dev,
+			struct page_response_msg *msg);
 
 	unsigned long pgsize_bitmap;
 };
@@ -424,6 +464,8 @@ extern int iommu_unregister_device_fault_handler(struct device *dev);
 
 extern int iommu_report_device_fault(struct device *dev, struct iommu_fault_event *evt);
 
+extern int iommu_page_response(struct iommu_domain *domain, struct device *dev,
+			struct page_response_msg *msg);
 extern int iommu_group_id(struct iommu_group *group);
 extern struct iommu_group *iommu_group_get_for_dev(struct device *dev);
 extern struct iommu_domain *iommu_group_default_domain(struct iommu_group *);
-- 
2.7.4
