From: Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH v2 16/16] iommu/vt-d: add intel iommu page response function
Date: Thu,  5 Oct 2017 16:03:44 -0700
Message-ID: <1507244624-39189-17-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1507244624-39189-1-git-send-email-jacob.jun.pan@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1507244624-39189-1-git-send-email-jacob.jun.pan@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>, Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rafael Wysocki <rafael.j.wysocki@intel.com>, Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Cc: "Liu, Yi L" <yi.l.liu@intel.com>, Lan Tianyu <tianyu.lan@intel.com>, "Tian, Kevin" <kevin.tian@intel.com>, Raj Ashok <ashok.raj@intel.com>, Alex Williamson <alex.williamson@redhat.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>
List-Id: iommu@lists.linux-foundation.org

This patch adds page response support for Intel VT-d.
Generic response data is taken from the IOMMU API
then parsed into VT-d specific response descriptor format.

Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 drivers/iommu/intel-iommu.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index ede0f2e..61ad26b 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -5165,6 +5165,35 @@ static int intel_iommu_invalidate(struct iommu_domain *domain,
 	return ret;
 }
 
+int intel_iommu_page_response(struct iommu_domain *domain, struct device *dev,
+			struct page_response_msg *msg)
+{
+	struct qi_desc resp;
+	struct intel_iommu *iommu = dev_to_intel_iommu(dev);
+
+	/* TODO: sanitize response message */
+	if (msg->last_req) {
+		/* Page Group Response */
+		resp.low = QI_PGRP_PASID(msg->pasid) |
+			QI_PGRP_DID(msg->did) |
+			QI_PGRP_PASID_P(msg->pasid_present) |
+			QI_PGRP_RESP_TYPE;
+		/* REVISIT: allow private data passing from device prq */
+		resp.high = QI_PGRP_IDX(msg->page_req_group_id) |
+			QI_PGRP_PRIV(msg->private_data) | QI_PGRP_RESP_CODE(msg->resp_code);
+	} else {
+		/* Page Stream Response */
+		resp.low = QI_PSTRM_IDX(msg->page_req_group_id) |
+			QI_PSTRM_PRIV(msg->private_data) | QI_PSTRM_BUS(PCI_BUS_NUM(msg->did)) |
+			QI_PSTRM_PASID(msg->pasid) | QI_PSTRM_RESP_TYPE;
+		resp.high = QI_PSTRM_ADDR(msg->paddr) | QI_PSTRM_DEVFN(msg->did & 0xff) |
+			QI_PSTRM_RESP_CODE(msg->resp_code);
+	}
+	qi_submit_sync(&resp, iommu);
+
+	return 0;
+}
+
 static int intel_iommu_map(struct iommu_domain *domain,
 			   unsigned long iova, phys_addr_t hpa,
 			   size_t size, int iommu_prot)
@@ -5594,6 +5623,7 @@ const struct iommu_ops intel_iommu_ops = {
 	.bind_pasid_table	= intel_iommu_bind_pasid_table,
 	.unbind_pasid_table	= intel_iommu_unbind_pasid_table,
 	.invalidate		= intel_iommu_invalidate,
+	.page_response		= intel_iommu_page_response,
 #endif
 	.map			= intel_iommu_map,
 	.unmap			= intel_iommu_unmap,
-- 
2.7.4
