From: Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v5 5/8] iommu/vt-d: Return ID associated with an auxiliary domain
Date: Thu, 10 Jan 2019 11:00:24 +0800
Message-ID: <20190110030027.31447-6-baolu.lu@linux.intel.com>
References: <20190110030027.31447-1-baolu.lu@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190110030027.31447-1-baolu.lu@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>, Alex Williamson <alex.williamson@redhat.com>, Kirti Wankhede <kwankhede@nvidia.com>
Cc: ashok.raj@intel.com, sanjay.k.kumar@intel.com, jacob.jun.pan@intel.com, kevin.tian@intel.com, Jean-Philippe Brucker <jean-philippe.brucker@arm.com>, yi.l.liu@intel.com, yi.y.sun@intel.com, peterx@redhat.com, tiwei.bie@intel.com, Zeng@vger.kernel.org, Xin <xin.zeng@intel.com>, iommu@lists.linux-foundation.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, Lu Baolu <baolu.lu@linux.intel.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>
List-Id: iommu@lists.linux-foundation.org

This adds support to return the default pasid associated with
an auxiliary domain. The PCI device which is bound with this
domain should use this value as the pasid for all DMA requests
of the subset of device which is isolated and protected with
this domain.

Cc: Ashok Raj <ashok.raj@intel.com>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Sanjay Kumar <sanjay.k.kumar@intel.com>
Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel-iommu.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index b8fb6a4bd447..614906276bf1 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -5624,6 +5624,15 @@ intel_iommu_dev_disable_feat(struct device *dev, enum iommu_dev_features feat)
 	return -ENODEV;
 }
 
+static int
+intel_iommu_aux_get_pasid(struct iommu_domain *domain, struct device *dev)
+{
+	struct dmar_domain *dmar_domain = to_dmar_domain(domain);
+
+	return dmar_domain->default_pasid > 0 ?
+			dmar_domain->default_pasid : -EINVAL;
+}
+
 const struct iommu_ops intel_iommu_ops = {
 	.capable		= intel_iommu_capable,
 	.domain_alloc		= intel_iommu_domain_alloc,
@@ -5632,6 +5641,7 @@ const struct iommu_ops intel_iommu_ops = {
 	.detach_dev		= intel_iommu_detach_device,
 	.aux_attach_dev		= intel_iommu_aux_attach_device,
 	.aux_detach_dev		= intel_iommu_aux_detach_device,
+	.aux_get_pasid		= intel_iommu_aux_get_pasid,
 	.map			= intel_iommu_map,
 	.unmap			= intel_iommu_unmap,
 	.iova_to_phys		= intel_iommu_iova_to_phys,
-- 
2.17.1
