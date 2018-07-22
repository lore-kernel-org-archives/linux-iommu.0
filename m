From: Lu Baolu <baolu.lu@linux.intel.com>
Subject: [RFC PATCH 07/10] iommu/vt-d: Add set_bus iommu ops
Date: Sun, 22 Jul 2018 14:09:30 +0800
Message-ID: <1532239773-15325-8-git-send-email-baolu.lu@linux.intel.com>
References: <1532239773-15325-1-git-send-email-baolu.lu@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1532239773-15325-1-git-send-email-baolu.lu@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>, Alex Williamson <alex.williamson@redhat.com>, Kirti Wankhede <kwankhede@nvidia.com>
Cc: ashok.raj@intel.com, sanjay.k.kumar@intel.com, jacob.jun.pan@intel.com, kevin.tian@intel.com, yi.l.liu@intel.com, yi.y.sun@intel.com, peterx@redhat.com, iommu@lists.linux-foundation.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, Lu Baolu <baolu.lu@linux.intel.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>
List-Id: iommu@lists.linux-foundation.org

This specifies the Intel IOMMU specific set_bus operation.

Cc: Ashok Raj <ashok.raj@intel.com>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: Kevin Tian <kevin.tian@intel.com>
Cc: Liu Yi L <yi.l.liu@intel.com>
Signed-off-by: Sanjay Kumar <sanjay.k.kumar@intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel-iommu.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index b6e9ea8..de36292 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -5346,6 +5346,23 @@ static struct iommu_group *intel_iommu_device_group(struct device *dev)
 	return ERR_PTR(-EINVAL);
 }
 
+static int intel_iommu_set_bus(struct bus_type *bus, struct iommu_device *idev)
+{
+	struct intel_iommu *iommu;
+
+	iommu = container_of(idev, struct intel_iommu, iommu);
+	if (strcmp(bus->name, "mdev"))
+		return -EINVAL;
+
+	if (!sm_supported(iommu))
+		return -ENODEV;
+
+	bus_set_iommu(bus, &intel_iommu_ops);
+	bus_register_notifier(bus, &device_nb);
+
+	return 0;
+}
+
 #ifdef CONFIG_INTEL_IOMMU_SVM
 int intel_iommu_enable_pasid(struct intel_iommu *iommu, struct intel_svm_dev *sdev)
 {
@@ -5440,6 +5457,7 @@ const struct iommu_ops intel_iommu_ops = {
 	.remove_device		= intel_iommu_remove_device,
 	.get_resv_regions	= intel_iommu_get_resv_regions,
 	.put_resv_regions	= intel_iommu_put_resv_regions,
+	.set_bus		= intel_iommu_set_bus,
 	.device_group		= intel_iommu_device_group,
 	.pgsize_bitmap		= INTEL_IOMMU_PGSIZES,
 };
-- 
2.7.4
