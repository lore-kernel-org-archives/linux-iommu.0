From: Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v4 5/8] iommu/vt-d: Return ID associated with an auxiliary domain
Date: Mon,  5 Nov 2018 15:34:05 +0800
Message-ID: <20181105073408.21815-6-baolu.lu@linux.intel.com>
References: <20181105073408.21815-1-baolu.lu@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181105073408.21815-1-baolu.lu@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>, Alex Williamson <alex.williamson@redhat.com>, Kirti Wankhede <kwankhede@nvidia.com>
Cc: ashok.raj@intel.com, sanjay.k.kumar@intel.com, jacob.jun.pan@intel.com, kevin.tian@intel.com, Jean-Philippe Brucker <jean-philippe.brucker@arm.com>, yi.l.liu@intel.com, yi.y.sun@intel.com, peterx@redhat.com, tiwei.bie@intel.com, Zeng Xin <xin.zeng@intel.com>, iommu@lists.linux-foundation.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, Lu Baolu <baolu.lu@linux.intel.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>
List-Id: iommu@lists.linux-foundation.org

This adds support to return the default pasid associated with
an auxiliary domain. The PCI device which is bound with this
domain should use this value as the pasid for all DMA requests
of the subset of device which is isolated and protected with
this domain.

Cc: Ashok Raj <ashok.raj@intel.com>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
---
 drivers/iommu/intel-iommu.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index a61b25ad0d3b..49a278a699b0 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -5576,6 +5576,27 @@ static int intel_iommu_set_dev_attr(struct device *dev,
 	return ret;
 }
 
+static int intel_iommu_domain_get_attr(struct iommu_domain *domain,
+				       enum iommu_attr attr, void *data)
+{
+	struct dmar_domain *dmar_domain = to_dmar_domain(domain);
+	int ret = -EINVAL, *id;
+
+	switch (attr) {
+	case DOMAIN_ATTR_AUXD_ID:
+		if (dmar_domain->default_pasid > 0) {
+			ret = 0;
+			id = data;
+			*id = dmar_domain->default_pasid;
+		}
+		break;
+	default:
+		break;
+	}
+
+	return ret;
+}
+
 const struct iommu_ops intel_iommu_ops = {
 	.capable		= intel_iommu_capable,
 	.domain_alloc		= intel_iommu_domain_alloc,
@@ -5592,6 +5613,7 @@ const struct iommu_ops intel_iommu_ops = {
 	.get_resv_regions	= intel_iommu_get_resv_regions,
 	.put_resv_regions	= intel_iommu_put_resv_regions,
 	.device_group		= pci_device_group,
+	.domain_get_attr	= intel_iommu_domain_get_attr,
 	.get_dev_attr		= intel_iommu_get_dev_attr,
 	.set_dev_attr		= intel_iommu_set_dev_attr,
 	.pgsize_bitmap		= INTEL_IOMMU_PGSIZES,
-- 
2.17.1
