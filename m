From: Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v8 3/9] iommu/vt-d: Add per-device IOMMU feature ops entries
Date: Mon, 25 Mar 2019 09:30:30 +0800
Message-ID: <20190325013036.18400-4-baolu.lu@linux.intel.com>
References: <20190325013036.18400-1-baolu.lu@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190325013036.18400-1-baolu.lu@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>, Alex Williamson <alex.williamson@redhat.com>, Kirti Wankhede <kwankhede@nvidia.com>
Cc: ashok.raj@intel.com, sanjay.k.kumar@intel.com, jacob.jun.pan@intel.com, kevin.tian@intel.com, Jean-Philippe Brucker <jean-philippe.brucker@arm.com>, yi.l.liu@intel.com, yi.y.sun@intel.com, peterx@redhat.com, tiwei.bie@intel.com, xin.zeng@intel.com, iommu@lists.linux-foundation.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, Lu Baolu <baolu.lu@linux.intel.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>
List-Id: iommu@lists.linux-foundation.org

This adds the iommu ops entries for aux-domain per-device
feature query and enable/disable.

Cc: Ashok Raj <ashok.raj@intel.com>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Sanjay Kumar <sanjay.k.kumar@intel.com>
Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel-iommu.c | 159 ++++++++++++++++++++++++++++++++++++
 include/linux/intel-iommu.h |   1 +
 2 files changed, 160 insertions(+)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index d2e613875b3a..ba5f2e5b3a03 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -2485,6 +2485,7 @@ static struct dmar_domain *dmar_insert_one_dev_info(struct intel_iommu *iommu,
 	info->domain = domain;
 	info->iommu = iommu;
 	info->pasid_table = NULL;
+	info->auxd_enabled = 0;
 
 	if (dev && dev_is_pci(dev)) {
 		struct pci_dev *pdev = to_pci_dev(info->dev);
@@ -5223,6 +5224,42 @@ static phys_addr_t intel_iommu_iova_to_phys(struct iommu_domain *domain,
 	return phys;
 }
 
+static inline bool scalable_mode_support(void)
+{
+	struct dmar_drhd_unit *drhd;
+	struct intel_iommu *iommu;
+	bool ret = true;
+
+	rcu_read_lock();
+	for_each_active_iommu(iommu, drhd) {
+		if (!sm_supported(iommu)) {
+			ret = false;
+			break;
+		}
+	}
+	rcu_read_unlock();
+
+	return ret;
+}
+
+static inline bool iommu_pasid_support(void)
+{
+	struct dmar_drhd_unit *drhd;
+	struct intel_iommu *iommu;
+	bool ret = true;
+
+	rcu_read_lock();
+	for_each_active_iommu(iommu, drhd) {
+		if (!pasid_supported(iommu)) {
+			ret = false;
+			break;
+		}
+	}
+	rcu_read_unlock();
+
+	return ret;
+}
+
 static bool intel_iommu_capable(enum iommu_cap cap)
 {
 	if (cap == IOMMU_CAP_CACHE_COHERENCY)
@@ -5380,6 +5417,124 @@ struct intel_iommu *intel_svm_device_to_iommu(struct device *dev)
 }
 #endif /* CONFIG_INTEL_IOMMU_SVM */
 
+static int intel_iommu_enable_auxd(struct device *dev)
+{
+	struct device_domain_info *info;
+	struct intel_iommu *iommu;
+	unsigned long flags;
+	u8 bus, devfn;
+	int ret;
+
+	iommu = device_to_iommu(dev, &bus, &devfn);
+	if (!iommu || dmar_disabled)
+		return -EINVAL;
+
+	if (!sm_supported(iommu) || !pasid_supported(iommu))
+		return -EINVAL;
+
+	ret = intel_iommu_enable_pasid(iommu, dev);
+	if (ret)
+		return -ENODEV;
+
+	spin_lock_irqsave(&device_domain_lock, flags);
+	info = dev->archdata.iommu;
+	info->auxd_enabled = 1;
+	spin_unlock_irqrestore(&device_domain_lock, flags);
+
+	return 0;
+}
+
+static int intel_iommu_disable_auxd(struct device *dev)
+{
+	struct device_domain_info *info;
+	unsigned long flags;
+
+	spin_lock_irqsave(&device_domain_lock, flags);
+	info = dev->archdata.iommu;
+	if (!WARN_ON(!info))
+		info->auxd_enabled = 0;
+	spin_unlock_irqrestore(&device_domain_lock, flags);
+
+	return 0;
+}
+
+/*
+ * A PCI express designated vendor specific extended capability is defined
+ * in the section 3.7 of Intel scalable I/O virtualization technical spec
+ * for system software and tools to detect endpoint devices supporting the
+ * Intel scalable IO virtualization without host driver dependency.
+ *
+ * Returns the address of the matching extended capability structure within
+ * the device's PCI configuration space or 0 if the device does not support
+ * it.
+ */
+static int siov_find_pci_dvsec(struct pci_dev *pdev)
+{
+	int pos;
+	u16 vendor, id;
+
+	pos = pci_find_next_ext_capability(pdev, 0, 0x23);
+	while (pos) {
+		pci_read_config_word(pdev, pos + 4, &vendor);
+		pci_read_config_word(pdev, pos + 8, &id);
+		if (vendor == PCI_VENDOR_ID_INTEL && id == 5)
+			return pos;
+
+		pos = pci_find_next_ext_capability(pdev, pos, 0x23);
+	}
+
+	return 0;
+}
+
+static bool
+intel_iommu_dev_has_feat(struct device *dev, enum iommu_dev_features feat)
+{
+	if (feat == IOMMU_DEV_FEAT_AUX) {
+		int ret;
+
+		if (!dev_is_pci(dev) || dmar_disabled ||
+		    !scalable_mode_support() || !iommu_pasid_support())
+			return false;
+
+		ret = pci_pasid_features(to_pci_dev(dev));
+		if (ret < 0)
+			return false;
+
+		return !!siov_find_pci_dvsec(to_pci_dev(dev));
+	}
+
+	return false;
+}
+
+static int
+intel_iommu_dev_enable_feat(struct device *dev, enum iommu_dev_features feat)
+{
+	if (feat == IOMMU_DEV_FEAT_AUX)
+		return intel_iommu_enable_auxd(dev);
+
+	return -ENODEV;
+}
+
+static int
+intel_iommu_dev_disable_feat(struct device *dev, enum iommu_dev_features feat)
+{
+	if (feat == IOMMU_DEV_FEAT_AUX)
+		return intel_iommu_disable_auxd(dev);
+
+	return -ENODEV;
+}
+
+static bool
+intel_iommu_dev_feat_enabled(struct device *dev, enum iommu_dev_features feat)
+{
+	struct device_domain_info *info = dev->archdata.iommu;
+
+	if (feat == IOMMU_DEV_FEAT_AUX)
+		return scalable_mode_support() && info && info->auxd_enabled;
+
+	return false;
+}
+
 const struct iommu_ops intel_iommu_ops = {
 	.capable		= intel_iommu_capable,
 	.domain_alloc		= intel_iommu_domain_alloc,
@@ -5394,6 +5549,10 @@ const struct iommu_ops intel_iommu_ops = {
 	.get_resv_regions	= intel_iommu_get_resv_regions,
 	.put_resv_regions	= intel_iommu_put_resv_regions,
 	.device_group		= pci_device_group,
+	.dev_has_feat		= intel_iommu_dev_has_feat,
+	.dev_feat_enabled	= intel_iommu_dev_feat_enabled,
+	.dev_enable_feat	= intel_iommu_dev_enable_feat,
+	.dev_disable_feat	= intel_iommu_dev_disable_feat,
 	.pgsize_bitmap		= INTEL_IOMMU_PGSIZES,
 };
 
diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
index b7d1e2fbb9ca..4f0745479b6d 100644
--- a/include/linux/intel-iommu.h
+++ b/include/linux/intel-iommu.h
@@ -568,6 +568,7 @@ struct device_domain_info {
 	u8 pri_enabled:1;
 	u8 ats_supported:1;
 	u8 ats_enabled:1;
+	u8 auxd_enabled:1;	/* Multiple domains per device */
 	u8 ats_qdep;
 	struct device *dev; /* it's NULL for PCIe-to-PCI bridge */
 	struct intel_iommu *iommu; /* IOMMU used by this device */
-- 
2.17.1
