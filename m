From: Jacob Pan <jacob.jun.pan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH v4 20/22] iommu/vt-d: add intel iommu page response function
Date: Mon, 16 Apr 2018 14:49:09 -0700
Message-ID: <1523915351-54415-21-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1523915351-54415-1-git-send-email-jacob.jun.pan@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1523915351-54415-1-git-send-email-jacob.jun.pan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>
Cc: Raj Ashok <ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Rafael Wysocki <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

This patch adds page response support for Intel VT-d.
Generic response data is taken from the IOMMU API
then parsed into VT-d specific response descriptor format.

Signed-off-by: Jacob Pan <jacob.jun.pan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 drivers/iommu/intel-iommu.c | 47 +++++++++++++++++++++++++++++++++++++++++++++
 include/linux/intel-iommu.h |  3 +++
 2 files changed, 50 insertions(+)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index a6ea67d..38f76d4 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -5142,6 +5142,52 @@ static int intel_iommu_sva_invalidate(struct iommu_domain *domain,
 	return ret;
 }
 
+static int intel_iommu_page_response(struct device *dev, struct page_response_msg *msg)
+{
+	struct qi_desc resp;
+	struct intel_iommu *iommu;
+	struct pci_dev *pdev;
+	u8 bus, devfn;
+	u16 rid;
+	u64 desc;
+
+	pdev = to_pci_dev(dev);
+	iommu = device_to_iommu(dev, &bus, &devfn);
+	if (!iommu) {
+		dev_err(dev, "No IOMMU for device to unbind PASID table\n");
+		return -ENODEV;
+	}
+
+	pci_dev_get(pdev);
+	rid = ((u16)bus << 8) | devfn;
+	/* Iommu private data contains  preserved page request descriptor, so we
+	 * inspect the SRR bit for response type then queue response with only
+	 * the private data [54:32].
+	 */
+	desc = msg->private_data;
+	if (desc & QI_PRQ_SRR) {
+		/* Page Stream Response */
+		resp.low = QI_PSTRM_IDX(msg->page_req_group_id) |
+			(desc & QI_PRQ_PRIV) | QI_PSTRM_BUS(PCI_BUS_NUM(pdev->bus->number)) |
+			QI_PSTRM_PASID(msg->pasid) | QI_PSTRM_RESP_TYPE;
+		resp.high = QI_PSTRM_ADDR(msg->addr) | QI_PSTRM_DEVFN(pdev->devfn & 0xff) |
+			QI_PSTRM_RESP_CODE(msg->resp_code);
+	} else {
+		/* Page Group Response */
+		resp.low = QI_PGRP_PASID(msg->pasid) |
+			QI_PGRP_DID(rid) |
+			QI_PGRP_PASID_P(msg->pasid_present) |
+			QI_PGRP_RESP_TYPE;
+		resp.high = QI_PGRP_IDX(msg->page_req_group_id) |
+			(desc & QI_PRQ_PRIV) | QI_PGRP_RESP_CODE(msg->resp_code);
+
+	}
+	qi_submit_sync(&resp, iommu);
+	pci_dev_put(pdev);
+
+	return 0;
+}
+
 static int intel_iommu_map(struct iommu_domain *domain,
 			   unsigned long iova, phys_addr_t hpa,
 			   size_t size, int iommu_prot)
@@ -5568,6 +5614,7 @@ const struct iommu_ops intel_iommu_ops = {
 	.bind_pasid_table	= intel_iommu_bind_pasid_table,
 	.unbind_pasid_table	= intel_iommu_unbind_pasid_table,
 	.sva_invalidate		= intel_iommu_sva_invalidate,
+	.page_response		= intel_iommu_page_response,
 #endif
 	.map			= intel_iommu_map,
 	.unmap			= intel_iommu_unmap,
diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
index dbe8c93..ed2883a 100644
--- a/include/linux/intel-iommu.h
+++ b/include/linux/intel-iommu.h
@@ -337,6 +337,9 @@ enum {
 #define QI_PSTRM_BUS(bus)	(((u64)(bus)) << 24)
 #define QI_PSTRM_PASID(pasid)	(((u64)(pasid)) << 4)
 
+#define QI_PRQ_SRR	BIT_ULL(0)
+#define QI_PRQ_PRIV	GENMASK_ULL(54, 32)
+
 #define QI_RESP_SUCCESS		0x0
 #define QI_RESP_INVALID		0x1
 #define QI_RESP_FAILURE		0xf
-- 
2.7.4
