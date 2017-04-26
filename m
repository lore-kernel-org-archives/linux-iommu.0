From: "Liu, Yi L" <yi.l.liu@intel.com>
Subject: [RFC PATCH 4/8] iommu/vt-d: Add iommu do invalidate function
Date: Wed, 26 Apr 2017 18:12:01 +0800
Message-ID: <1493201525-14418-5-git-send-email-yi.l.liu@intel.com>
References: <1493201525-14418-1-git-send-email-yi.l.liu@intel.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1493201525-14418-1-git-send-email-yi.l.liu@intel.com>
Sender: kvm-owner@vger.kernel.org
To: kvm@vger.kernel.org, iommu@lists.linux-foundation.org, alex.williamson@redhat.com, peterx@redhat.com
Cc: jasowang@redhat.com, qemu-devel@nongnu.org, kevin.tian@intel.com, ashok.raj@intel.com, jacob.jun.pan@intel.com, tianyu.lan@intel.com, yi.l.liu@intel.com, jean-philippe.brucker@arm.com, Jacob Pan <jacob.jun.pan@linux.intel.com>, "Liu, Yi L" <yi.l.liu@linux.intel.com>
List-Id: iommu@lists.linux-foundation.org

From: Jacob Pan <jacob.jun.pan@linux.intel.com>

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
---
 drivers/iommu/intel-iommu.c | 43 +++++++++++++++++++++++++++++++++++++++++++
 include/linux/intel-iommu.h | 11 +++++++++++
 2 files changed, 54 insertions(+)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 6d5b939..0b098ad 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -5042,6 +5042,48 @@ static void intel_iommu_detach_device(struct iommu_domain *domain,
 	dmar_remove_one_dev_info(to_dmar_domain(domain), dev);
 }
 
+static int intel_iommu_do_invalidate(struct iommu_domain *domain,
+		struct device *dev, struct tlb_invalidate_info *inv_info)
+{
+	int ret = 0;
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
+		set_mask_bits(&qi->low, QI_DID_MASK, QI_DID(did));
+		break;
+	}
+
+	ret = qi_submit_sync(qi, iommu);
+
+	return ret;
+}
+
 static int intel_iommu_map(struct iommu_domain *domain,
 			   unsigned long iova, phys_addr_t hpa,
 			   size_t size, int iommu_prot)
@@ -5416,6 +5458,7 @@ static int intel_iommu_unbind_pasid_table(struct iommu_domain *domain,
 #ifdef CONFIG_INTEL_IOMMU_SVM
 	.bind_pasid_table	= intel_iommu_bind_pasid_table,
 	.unbind_pasid_table	= intel_iommu_unbind_pasid_table,
+	.do_invalidate		= intel_iommu_do_invalidate,
 #endif
 	.map		= intel_iommu_map,
 	.unmap		= intel_iommu_unmap,
diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
index ac04f28..9d6562c 100644
--- a/include/linux/intel-iommu.h
+++ b/include/linux/intel-iommu.h
@@ -29,6 +29,7 @@
 #include <linux/dma_remapping.h>
 #include <linux/mmu_notifier.h>
 #include <linux/list.h>
+#include <linux/bitops.h>
 #include <asm/cacheflush.h>
 #include <asm/iommu.h>
 
@@ -271,6 +272,10 @@ enum {
 #define QI_PGRP_RESP_TYPE	0x9
 #define QI_PSTRM_RESP_TYPE	0xa
 
+#define QI_DID(did)		(((u64)did & 0xffff) << 16)
+#define QI_DID_MASK		GENMASK(31, 16)
+#define QI_TYPE_MASK		GENMASK(3, 0)
+
 #define QI_IEC_SELECTIVE	(((u64)1) << 4)
 #define QI_IEC_IIDEX(idx)	(((u64)(idx & 0xffff) << 32))
 #define QI_IEC_IM(m)		(((u64)(m & 0x1f) << 27))
@@ -529,6 +534,12 @@ struct intel_svm {
 extern struct intel_iommu *intel_svm_device_to_iommu(struct device *dev);
 #endif
 
+struct intel_invalidate_data {
+	u16 sid;
+	u32 pasid;
+	struct qi_desc inv_desc;
+};
+
 extern const struct attribute_group *intel_iommu_groups[];
 extern void intel_iommu_debugfs_init(void);
 extern struct context_entry *iommu_context_addr(struct intel_iommu *iommu,
-- 
1.9.1
