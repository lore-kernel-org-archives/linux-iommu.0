From: Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [RFC 4/9] iommu/vt-d: Add iommu do invalidate function
Date: Wed, 14 Jun 2017 15:22:58 -0700
Message-ID: <1497478983-77580-5-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1497478983-77580-1-git-send-email-jacob.jun.pan@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1497478983-77580-1-git-send-email-jacob.jun.pan@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>, Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>
Cc: "Liu, Yi L" <yi.l.liu@intel.com>, Lan Tianyu <tianyu.lan@intel.com>, "Tian, Kevin" <kevin.tian@intel.com>, Raj Ashok <ashok.raj@intel.com>, Alex Williamson <alex.williamson@redhat.com>, Jean Delvare <khali@linux-fr.org>, Jacob Pan <jacob.jun.pan@linux.intel.com>, Liu@vger.kernel.org, Yi L <yi.l.liu@linux.intel.com>
List-Id: iommu@lists.linux-foundation.org

This patch adds Intel VT-d specific function to implement
iommu_do_invalidate API.

The use case is for supporting caching structure invalidation
of assigned SVM capable devices. Emulated IOMMU exposes queue
invalidation capability and passes down all descriptors from the guest
to the physical IOMMU.

The assumption is that guest to host device ID mapping should be
resolved prior to calling IOMMU driver. Based on the device handle,
host IOMMU driver can replace certain fields before submit to the
invalidation queue.

Signed-off-by: Liu, Yi L <yi.l.liu@linux.intel.com>
Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
Signed-off-by: Ashok Raj <ashok.raj@intel.com>
---
 drivers/iommu/intel-iommu.c | 41 +++++++++++++++++++++++++++++++++++++++++
 include/linux/intel-iommu.h | 11 ++++++++++-
 2 files changed, 51 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 1d5d9ab9..6b8e997 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -5127,6 +5127,46 @@ static void intel_iommu_detach_device(struct iommu_domain *domain,
 	dmar_remove_one_dev_info(to_dmar_domain(domain), dev);
 }
 
+static int intel_iommu_do_invalidate(struct iommu_domain *domain,
+		struct device *dev, struct tlb_invalidate_info *inv_info)
+{
+	struct intel_iommu *iommu;
+	struct dmar_domain *dmar_domain = to_dmar_domain(domain);
+	struct intel_invalidate_data *inv_data;
+	struct qi_desc *qi;
+	u16 did;
+	u8 bus, devfn;
+
+	if (!inv_info || !dmar_domain || (inv_info->model != INTEL_IOMMU))
+		return -EINVAL;
+
+	iommu = device_to_iommu(dev, &bus, &devfn);
+	if (!iommu)
+		return -ENODEV;
+
+	inv_data = (struct intel_invalidate_data *)&inv_info->opaque;
+
+	/* check SID */
+	if (PCI_DEVID(bus, devfn) != inv_data->sid)
+		return 0;
+
+	qi = &inv_data->inv_desc;
+
+	switch (qi->low & QI_TYPE_MASK) {
+	case QI_DIOTLB_TYPE:
+	case QI_DEIOTLB_TYPE:
+		/* for device IOTLB, we just let it pass through */
+		break;
+	default:
+		did = dmar_domain->iommu_did[iommu->seq_id];
+		qi->low &= ~QI_DID_MASK;
+		qi->low |= QI_DID(did);
+		break;
+	}
+
+	return qi_submit_sync(qi, iommu);
+}
+
 static int intel_iommu_map(struct iommu_domain *domain,
 			   unsigned long iova, phys_addr_t hpa,
 			   size_t size, int iommu_prot)
@@ -5546,6 +5586,7 @@ const struct iommu_ops intel_iommu_ops = {
 #ifdef CONFIG_INTEL_IOMMU_SVM
 	.bind_pasid_table	= intel_iommu_bind_pasid_table,
 	.unbind_pasid_table	= intel_iommu_unbind_pasid_table,
+	.do_invalidate		= intel_iommu_do_invalidate,
 #endif
 	.map			= intel_iommu_map,
 	.unmap			= intel_iommu_unmap,
diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
index 485a5b4..8df6c91 100644
--- a/include/linux/intel-iommu.h
+++ b/include/linux/intel-iommu.h
@@ -31,7 +31,6 @@
 #include <linux/list.h>
 #include <linux/iommu.h>
 #include <linux/io-64-nonatomic-lo-hi.h>
-
 #include <asm/cacheflush.h>
 #include <asm/iommu.h>
 
@@ -258,6 +257,10 @@ enum {
 #define QI_PGRP_RESP_TYPE	0x9
 #define QI_PSTRM_RESP_TYPE	0xa
 
+#define QI_DID(did)		(((u64)did & 0xffff) << 16)
+#define QI_DID_MASK		GENMASK(31, 16)
+#define QI_TYPE_MASK		GENMASK(3, 0)
+
 #define QI_IEC_SELECTIVE	(((u64)1) << 4)
 #define QI_IEC_IIDEX(idx)	(((u64)(idx & 0xffff) << 32))
 #define QI_IEC_IM(m)		(((u64)(m & 0x1f) << 27))
@@ -489,6 +492,12 @@ extern int intel_iommu_enable_pasid(struct intel_iommu *iommu, struct intel_svm_
 extern struct intel_iommu *intel_svm_device_to_iommu(struct device *dev);
 #endif
 
+struct intel_invalidate_data {
+	u16 sid;
+	u32 pasid;
+	struct qi_desc inv_desc;
+};
+
 extern const struct attribute_group *intel_iommu_groups[];
 
 #endif
-- 
2.7.4
