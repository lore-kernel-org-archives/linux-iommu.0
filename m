From: Lu Baolu <baolu.lu@linux.intel.com>
Subject: [RFC PATCH 01/10] iommu/vt-d: Get iommu device for a mediated device
Date: Sun, 22 Jul 2018 14:09:24 +0800
Message-ID: <1532239773-15325-2-git-send-email-baolu.lu@linux.intel.com>
References: <1532239773-15325-1-git-send-email-baolu.lu@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1532239773-15325-1-git-send-email-baolu.lu@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>, Alex Williamson <alex.williamson@redhat.com>, Kirti Wankhede <kwankhede@nvidia.com>
Cc: ashok.raj@intel.com, sanjay.k.kumar@intel.com, jacob.jun.pan@intel.com, kevin.tian@intel.com, yi.l.liu@intel.com, yi.y.sun@intel.com, peterx@redhat.com, iommu@lists.linux-foundation.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, Lu Baolu <baolu.lu@linux.intel.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>
List-Id: iommu@lists.linux-foundation.org

This patch adds the support to get the iommu device for a mediated
device. The assumption is that each mediated device is a minimal
assignable set of a physical PCI device. Hence, we should use the
iommu device of the parent PCI device to manage the translation.

Cc: Ashok Raj <ashok.raj@intel.com>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: Kevin Tian <kevin.tian@intel.com>
Cc: Liu Yi L <yi.l.liu@intel.com>
Signed-off-by: Sanjay Kumar <sanjay.k.kumar@intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel-iommu.c |  6 ++++++
 drivers/iommu/intel-pasid.h | 16 ++++++++++++++++
 2 files changed, 22 insertions(+)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 7d198ea..fc3ac1c 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -767,6 +767,12 @@ static struct intel_iommu *device_to_iommu(struct device *dev, u8 *bus, u8 *devf
 	if (iommu_dummy(dev))
 		return NULL;
 
+	if (dev_is_mdev(dev)) {
+		dev = dev_mdev_parent(dev);
+		if (WARN_ON(!dev_is_pci(dev)))
+			return NULL;
+	}
+
 	if (dev_is_pci(dev)) {
 		struct pci_dev *pf_pdev;
 
diff --git a/drivers/iommu/intel-pasid.h b/drivers/iommu/intel-pasid.h
index 518df72..46cde66 100644
--- a/drivers/iommu/intel-pasid.h
+++ b/drivers/iommu/intel-pasid.h
@@ -35,6 +35,22 @@ struct pasid_table {
 	struct list_head	dev;		/* device list */
 };
 
+static inline bool dev_is_mdev(struct device *dev)
+{
+	if (!dev)
+		return false;
+
+	return !strcmp(dev->bus->name, "mdev");
+}
+
+static inline struct device *dev_mdev_parent(struct device *dev)
+{
+	if (WARN_ON(!dev_is_mdev(dev)))
+		return NULL;
+
+	return dev->parent;
+}
+
 extern u32 intel_pasid_max_id;
 int intel_pasid_alloc_id(void *ptr, int start, int end, gfp_t gfp);
 void intel_pasid_free_id(int pasid);
-- 
2.7.4
