From: Lu Baolu <baolu.lu@linux.intel.com>
Subject: [RFC PATCH 04/10] iommu/vt-d: Get pasid table for a mediated device
Date: Sun, 22 Jul 2018 14:09:27 +0800
Message-ID: <1532239773-15325-5-git-send-email-baolu.lu@linux.intel.com>
References: <1532239773-15325-1-git-send-email-baolu.lu@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1532239773-15325-1-git-send-email-baolu.lu@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>, Alex Williamson <alex.williamson@redhat.com>, Kirti Wankhede <kwankhede@nvidia.com>
Cc: ashok.raj@intel.com, sanjay.k.kumar@intel.com, jacob.jun.pan@intel.com, kevin.tian@intel.com, yi.l.liu@intel.com, yi.y.sun@intel.com, peterx@redhat.com, iommu@lists.linux-foundation.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, Lu Baolu <baolu.lu@linux.intel.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>
List-Id: iommu@lists.linux-foundation.org

This patch adds the support to get the pasid table for a mediated
device. The assumption is that each mediated device is a minimal
assignable set of a physical PCI device. Hence, we should use the
pasid table of the parent PCI device to manage the translation.

Cc: Ashok Raj <ashok.raj@intel.com>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: Kevin Tian <kevin.tian@intel.com>
Cc: Liu Yi L <yi.l.liu@intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel-pasid.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/intel-pasid.c b/drivers/iommu/intel-pasid.c
index 1195c2a..9b4d462 100644
--- a/drivers/iommu/intel-pasid.c
+++ b/drivers/iommu/intel-pasid.c
@@ -129,7 +129,19 @@ int intel_pasid_alloc_table(struct device *dev)
 	int ret, order;
 
 	info = dev->archdata.iommu;
-	if (WARN_ON(!info || !dev_is_pci(dev) || info->pasid_table))
+	if (WARN_ON(!info || info->pasid_table))
+		return -EINVAL;
+
+	/* Use parent PCI device pasid table for mdev: */
+	if (dev_is_mdev(dev)) {
+		pasid_table = intel_pasid_get_table(dev_mdev_parent(dev));
+		if (pasid_table)
+			goto attach_out;
+		else
+			return -ENOMEM;
+	}
+
+	if (WARN_ON(!dev_is_pci(dev)))
 		return -EINVAL;
 
 	/* DMA alias device already has a pasid table, use it: */
@@ -190,7 +202,7 @@ void intel_pasid_free_table(struct device *dev)
 	int i, max_pde;
 
 	info = dev->archdata.iommu;
-	if (!info || !dev_is_pci(dev) || !info->pasid_table)
+	if (!info || !info->pasid_table)
 		return;
 
 	pasid_table = info->pasid_table;
-- 
2.7.4
