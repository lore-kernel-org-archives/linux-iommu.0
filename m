From: Lu Baolu <baolu.lu@linux.intel.com>
Subject: [RFC PATCH 4/5] iommu/vt-d: Allocate and free a pasid
Date: Mon, 12 Nov 2018 14:45:00 +0800
Message-ID: <20181112064501.2290-5-baolu.lu@linux.intel.com>
References: <20181112064501.2290-1-baolu.lu@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181112064501.2290-1-baolu.lu@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>, Alex Williamson <alex.williamson@redhat.com>, Kirti Wankhede <kwankhede@nvidia.com>
Cc: ashok.raj@intel.com, sanjay.k.kumar@intel.com, jacob.jun.pan@intel.com, kevin.tian@intel.com, Jean-Philippe Brucker <jean-philippe.brucker@arm.com>, yi.l.liu@intel.com, yi.y.sun@intel.com, peterx@redhat.com, tiwei.bie@intel.com, Zeng Xin <xin.zeng@intel.com>, iommu@lists.linux-foundation.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, Lu Baolu <baolu.lu@linux.intel.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>
List-Id: iommu@lists.linux-foundation.org

This adds the Intel vt-d specific ops to allocate and free a
pasid value.

Cc: Ashok Raj <ashok.raj@intel.com>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel-iommu.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 769b7059d52f..8dbd0c601dab 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -5626,6 +5626,37 @@ static int intel_iommu_pasid_init(struct iommu_pasid *pasid)
 	return 0;
 }
 
+static int intel_iommu_pasid_alloc(struct iommu_pasid *pasid, ioasid_t start,
+				   ioasid_t end, ioasid_t *ioasid)
+{
+	struct intel_iommu *iommu;
+
+	iommu = pasid->priv;
+	if (!iommu)
+		return -EINVAL;
+
+	/*
+	 * In caching mode, PASID ID should be allocated and freed
+	 * through the virtual command registers. Otherwise, rely
+	 * on the iommu global idr.
+	 */
+	if (!cap_caching_mode(iommu->cap))
+		return -EAGAIN;
+
+	return vcmd_alloc_pasid(iommu, ioasid);
+}
+
+static void intel_iommu_pasid_free(struct iommu_pasid *pasid, ioasid_t ioasid)
+{
+	struct intel_iommu *iommu;
+
+	iommu = pasid->priv;
+	if (!iommu || !cap_caching_mode(iommu->cap))
+		return;
+
+	vcmd_free_pasid(iommu, ioasid);
+}
+
 const struct iommu_ops intel_iommu_ops = {
 	.capable		= intel_iommu_capable,
 	.domain_alloc		= intel_iommu_domain_alloc,
@@ -5646,6 +5677,8 @@ const struct iommu_ops intel_iommu_ops = {
 	.get_dev_attr		= intel_iommu_get_dev_attr,
 	.set_dev_attr		= intel_iommu_set_dev_attr,
 	.pasid_init		= intel_iommu_pasid_init,
+	.pasid_alloc		= intel_iommu_pasid_alloc,
+	.pasid_free		= intel_iommu_pasid_free,
 	.pgsize_bitmap		= INTEL_IOMMU_PGSIZES,
 };
 
-- 
2.17.1
