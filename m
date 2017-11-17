From: Jacob Pan <jacob.jun.pan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH v3 15/16] iommu: introduce page response function
Date: Fri, 17 Nov 2017 10:55:13 -0800
Message-ID: <1510944914-54430-16-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1510944914-54430-1-git-send-email-jacob.jun.pan@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1510944914-54430-1-git-send-email-jacob.jun.pan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Rafael Wysocki <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Lan Tianyu <tianyu.lan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
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

Signed-off-by: Jacob Pan <jacob.jun.pan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 drivers/iommu/iommu.c | 14 ++++++++++++++
 include/linux/iommu.h | 42 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 56 insertions(+)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 97b7990..7aefb40 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -1416,6 +1416,20 @@ int iommu_sva_invalidate(struct iommu_domain *domain,
 }
 EXPORT_SYMBOL_GPL(iommu_sva_invalidate);
 
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
index 3083796b..17f698b 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -163,6 +163,43 @@ struct iommu_resv_region {
 
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
+ * @prot: page access protection flag, e.g. IOMMU_FAULT_READ, IOMMU_FAULT_WRITE
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
@@ -196,6 +233,7 @@ struct iommu_resv_region {
  * @bind_pasid_table: bind pasid table pointer for guest SVM
  * @unbind_pasid_table: unbind pasid table pointer and restore defaults
  * @sva_invalidate: invalidate translation caches of shared virtual address
+ * @page_response: handle page request response
  */
 struct iommu_ops {
 	bool (*capable)(enum iommu_cap);
@@ -251,6 +289,8 @@ struct iommu_ops {
 				struct device *dev);
 	int (*sva_invalidate)(struct iommu_domain *domain,
 		struct device *dev, struct tlb_invalidate_info *inv_info);
+	int (*page_response)(struct iommu_domain *domain, struct device *dev,
+			struct page_response_msg *msg);
 
 	unsigned long pgsize_bitmap;
 };
@@ -472,6 +512,8 @@ extern int iommu_unregister_device_fault_handler(struct device *dev);
 
 extern int iommu_report_device_fault(struct device *dev, struct iommu_fault_event *evt);
 
+extern int iommu_page_response(struct iommu_domain *domain, struct device *dev,
+			struct page_response_msg *msg);
 extern int iommu_group_id(struct iommu_group *group);
 extern struct iommu_group *iommu_group_get_for_dev(struct device *dev);
 extern struct iommu_domain *iommu_group_default_domain(struct iommu_group *);
-- 
2.7.4
