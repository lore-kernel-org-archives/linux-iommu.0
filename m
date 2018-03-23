From: Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH v4 22/22] iommu: use sva invalidate and device fault trace event
Date: Thu, 22 Mar 2018 20:12:14 -0700
Message-ID: <1521774734-48433-23-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1521774734-48433-1-git-send-email-jacob.jun.pan@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1521774734-48433-1-git-send-email-jacob.jun.pan@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>, Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>, Jean-Philippe Brucker <jean-philippe.brucker@arm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rafael Wysocki <rafael.j.wysocki@intel.com>
Cc: "Liu, Yi L" <yi.l.liu@intel.com>, Lan Tianyu <tianyu.lan@intel.com>, "Tian, Kevin" <kevin.tian@intel.com>, Raj Ashok <ashok.raj@intel.com>, Alex Williamson <alex.williamson@redhat.com>, Jean Delvare <khali@linux-fr.org>, Christoph Hellwig <hch@infradead.org>, Jacob Pan <jacob.jun.pan@linux.intel.com>
List-Id: iommu@lists.linux-foundation.org

For performance and debugging purposes, these trace events help
analyzing device faults and passdown invalidations that interact
with IOMMU subsystem.
E.g.
IOMMU:0000:00:0a.0 type=2 reason=0 addr=0x00000000007ff000 pasid=1
group=1 last=0 prot=1

Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 drivers/iommu/iommu.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 1e74944..e5fc345 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -979,6 +979,7 @@ int iommu_report_device_fault(struct device *dev, struct iommu_fault_event *evt)
 		mutex_unlock(&fparam->lock);
 	}
 	ret = fparam->handler(evt, fparam->data);
+	trace_dev_fault(dev, evt);
 done_unlock:
 	mutex_unlock(&dev->iommu_param->lock);
 	return ret;
@@ -1547,6 +1548,7 @@ int iommu_sva_invalidate(struct iommu_domain *domain,
 		return -ENODEV;
 
 	ret = domain->ops->sva_invalidate(domain, dev, inv_info);
+	trace_sva_invalidate(dev, inv_info);
 
 	return ret;
 }
@@ -1584,6 +1586,7 @@ int iommu_page_response(struct device *dev,
 		if (evt->pasid == msg->pasid &&
 		    msg->page_req_group_id == evt->page_req_group_id) {
 			msg->private_data = evt->iommu_private;
+			trace_dev_page_response(dev, msg);
 			ret = domain->ops->page_response(dev, msg);
 			list_del(&evt->list);
 			kfree(evt);
-- 
2.7.4
