From: Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH v3 06/16] iommu/vt-d: add svm/sva invalidate function
Date: Fri, 17 Nov 2017 10:55:04 -0800
Message-ID: <1510944914-54430-7-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1510944914-54430-1-git-send-email-jacob.jun.pan@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1510944914-54430-1-git-send-email-jacob.jun.pan@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>, Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rafael Wysocki <rafael.j.wysocki@intel.com>, Alex Williamson <alex.williamson@redhat.com>
Cc: "Liu, Yi L" <yi.l.liu@intel.com>, Lan Tianyu <tianyu.lan@intel.com>, "Tian, Kevin" <kevin.tian@intel.com>, Raj Ashok <ashok.raj@intel.com>, Jean Delvare <khali@linux-fr.org>, Christoph Hellwig <hch@infradead.org>, Jacob Pan <jacob.jun.pan@linux.intel.com>, Liu@vger.kernel.org, Yi L <yi.l.liu@linux.intel.com>
List-Id: iommu@lists.linux-foundation.org

This patch adds Intel VT-d specific function to implement
iommu passdown invalidate API for shared virtual address.

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
 drivers/iommu/intel-iommu.c | 200 +++++++++++++++++++++++++++++++++++++++++++-
 include/linux/intel-iommu.h |  17 +++-
 2 files changed, 211 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 556bdd2..000b2b3 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -4981,6 +4981,183 @@ static void intel_iommu_detach_device(struct iommu_domain *domain,
 	dmar_remove_one_dev_info(to_dmar_domain(domain), dev);
 }
 
+/*
+ * 3D array for converting IOMMU generic type-granularity to VT-d granularity
+ * X indexed by enum iommu_inv_type
+ * Y indicates request without and with PASID
+ * Z indexed by enum enum iommu_inv_granularity
+ *
+ * For an example, if we want to find the VT-d granularity encoding for IOTLB
+ * type, DMA request with PASID, and page selective. The look up indices are:
+ * [1][1][8], where
+ * 1: IOMMU_INV_TYPE_TLB
+ * 1: with PASID
+ * 8: IOMMU_INV_GRANU_PAGE_PASID
+ *
+ */
+const static int inv_type_granu_map[IOMMU_INV_NR_TYPE][2][IOMMU_INV_NR_GRANU] = {
+	/* extended dev IOTLBs, for dev-IOTLB, only global is valid,
+	   for dev-EXIOTLB, two valid granu */
+	{
+		{1},
+		{0, 0, 0, 0, 1, 1, 0, 0, 0}
+	},
+	/* IOTLB and EIOTLB */
+	{
+		{1, 1, 0, 1, 0, 0, 0, 0, 0},
+		{0, 0, 0, 0, 1, 0, 1, 1, 1}
+	},
+	/* PASID cache */
+	{
+		{0},
+		{0, 0, 0, 0, 1, 1, 0, 0, 0}
+	},
+	/* context cache */
+	{
+		{1, 1, 1}
+	}
+};
+
+const static u64 inv_type_granu_table[IOMMU_INV_NR_TYPE][2][IOMMU_INV_NR_GRANU] = {
+	/* extended dev IOTLBs, only global is valid */
+	{
+		{QI_DEV_IOTLB_GRAN_ALL},
+		{0, 0, 0, 0, QI_DEV_IOTLB_GRAN_ALL, QI_DEV_IOTLB_GRAN_PASID_SEL, 0, 0, 0}
+	},
+	/* IOTLB and EIOTLB */
+	{
+		{DMA_TLB_GLOBAL_FLUSH, DMA_TLB_DSI_FLUSH, 0, DMA_TLB_PSI_FLUSH},
+		{0, 0, 0, 0, QI_GRAN_ALL_ALL, 0, QI_GRAN_NONG_ALL, QI_GRAN_NONG_PASID, QI_GRAN_PSI_PASID}
+	},
+	/* PASID cache */
+	{
+		{0},
+		{0, 0, 0, 0, QI_PC_ALL_PASIDS, QI_PC_PASID_SEL}
+	},
+	/* context cache */
+	{
+		{DMA_CCMD_GLOBAL_INVL, DMA_CCMD_DOMAIN_INVL, DMA_CCMD_DEVICE_INVL}
+	}
+};
+
+static inline int to_vtd_granularity(int type, int granu, int with_pasid, u64 *vtd_granu)
+{
+	if (type >= IOMMU_INV_NR_TYPE || granu >= IOMMU_INV_NR_GRANU || with_pasid > 1)
+		return -EINVAL;
+
+	if (inv_type_granu_map[type][with_pasid][granu] == 0)
+		return -EINVAL;
+
+	*vtd_granu = inv_type_granu_table[type][with_pasid][granu];
+
+	return 0;
+}
+
+static int intel_iommu_sva_invalidate(struct iommu_domain *domain,
+		struct device *dev, struct tlb_invalidate_info *inv_info)
+{
+	struct intel_iommu *iommu;
+	struct dmar_domain *dmar_domain = to_dmar_domain(domain);
+	struct device_domain_info *info;
+	struct pci_dev *pdev;
+	u16 did, sid, pfsid;
+	u8 bus, devfn;
+	int ret = 0;
+	u64 granu;
+	unsigned long flags;
+
+	if (!inv_info || !dmar_domain)
+		return -EINVAL;
+
+	iommu = device_to_iommu(dev, &bus, &devfn);
+	if (!iommu)
+		return -ENODEV;
+
+	if (!dev || !dev_is_pci(dev))
+		return -ENODEV;
+
+	did = dmar_domain->iommu_did[iommu->seq_id];
+	sid = PCI_DEVID(bus, devfn);
+	ret = to_vtd_granularity(inv_info->hdr.type, inv_info->granularity,
+				!!(inv_info->flags & IOMMU_INVALIDATE_PASID_TAGGED), &granu);
+	if (ret) {
+		pr_err("Invalid range type %d, granu %d\n", inv_info->hdr.type,
+			inv_info->granularity);
+		return ret;
+	}
+
+	spin_lock(&iommu->lock);
+	spin_lock_irqsave(&device_domain_lock, flags);
+
+	switch (inv_info->hdr.type) {
+	case IOMMU_INV_TYPE_CONTEXT:
+		iommu->flush.flush_context(iommu, did, sid,
+					DMA_CCMD_MASK_NOBIT, granu);
+		break;
+	case IOMMU_INV_TYPE_TLB:
+		/* We need to deal with two scenarios:
+		 * - IOTLB for request w/o PASID
+		 * - extended IOTLB for request with PASID.
+		 */
+		if (inv_info->size &&
+			(inv_info->addr & ((1 << (VTD_PAGE_SHIFT + inv_info->size)) - 1))) {
+			pr_err("Addr out of range, addr 0x%llx, size order %d\n",
+				inv_info->addr, inv_info->size);
+			ret = -ERANGE;
+			goto out_unlock;
+		}
+
+		if (inv_info->flags & IOMMU_INVALIDATE_PASID_TAGGED)
+			qi_flush_eiotlb(iommu, did, mm_to_dma_pfn(inv_info->addr),
+					inv_info->pasid,
+					inv_info->size, granu,
+					inv_info->flags & IOMMU_INVALIDATE_GLOBAL_PAGE);
+		else
+			qi_flush_iotlb(iommu, did, mm_to_dma_pfn(inv_info->addr),
+				inv_info->size, granu);
+		/* For SRIOV VF, invalidation of device IOTLB requires PFSID */
+		pdev = to_pci_dev(dev);
+		if (pdev && pdev->is_virtfn)
+			pfsid = PCI_DEVID(pdev->physfn->bus->number, pdev->physfn->devfn);
+		else
+			pfsid = sid;
+
+		/**
+		 * Always flush device IOTLB if ATS is enabled since guest
+		 * vIOMMU exposes CM = 1, no device IOTLB flush will be passed
+		 * down.
+		 * TODO: check if device is VF, use PF ATS data if spec does not require
+		 * VF to include all PF capabilities,  VF qdep and VF ats_enabled.
+		 */
+		info = iommu_support_dev_iotlb(dmar_domain, iommu, bus, devfn);
+		if (info && info->ats_enabled) {
+			if (inv_info->flags & IOMMU_INVALIDATE_PASID_TAGGED)
+				qi_flush_dev_eiotlb(iommu, sid, info->pfsid,
+						inv_info->pasid, info->ats_qdep,
+						inv_info->addr, inv_info->size,
+						granu);
+			else
+				qi_flush_dev_iotlb(iommu, sid, info->pfsid,
+						info->ats_qdep, inv_info->addr,
+						inv_info->size);
+		}
+		break;
+	case IOMMU_INV_TYPE_PASID:
+		qi_flush_pasid(iommu, did, granu, inv_info->pasid);
+
+		break;
+	default:
+		dev_err(dev, "Unknown IOMMU invalidation type %d\n",
+			inv_info->hdr.type);
+		ret = -EINVAL;
+	}
+out_unlock:
+	spin_unlock(&iommu->lock);
+	spin_unlock_irqrestore(&device_domain_lock, flags);
+
+	return ret;
+}
+
 static int intel_iommu_map(struct iommu_domain *domain,
 			   unsigned long iova, phys_addr_t hpa,
 			   size_t size, int iommu_prot)
@@ -5304,7 +5481,7 @@ static int intel_iommu_bind_pasid_table(struct iommu_domain *domain,
 	iommu = device_to_iommu(dev, &bus, &devfn);
 	if (!iommu)
 		return -ENODEV;
-	/* VT-d spec 9.4 says pasid table size is encoded as 2^(x+5) */
+	/* VT-d spec section 9.4 says pasid table size is encoded as 2^(x+5) */
 	host_table_pasid_bits = intel_iommu_get_pts(iommu) + MIN_NR_PASID_BITS;
 	if (!pasidt_binfo || pasidt_binfo->pasid_bits > host_table_pasid_bits ||
 		pasidt_binfo->pasid_bits < MIN_NR_PASID_BITS) {
@@ -5313,7 +5490,11 @@ static int intel_iommu_bind_pasid_table(struct iommu_domain *domain,
 			MIN_NR_PASID_BITS, host_table_pasid_bits);
 		return -ERANGE;
 	}
-
+	if (!ecap_nest(iommu->ecap)) {
+		dev_err(dev, "Cannot bind PASID table, no nested translation\n");
+		ret = -EINVAL;
+		goto out;
+	}
 	pdev = to_pci_dev(dev);
 	sid = PCI_DEVID(bus, devfn);
 	info = dev->archdata.iommu;
@@ -5323,6 +5504,11 @@ static int intel_iommu_bind_pasid_table(struct iommu_domain *domain,
 		ret = -EINVAL;
 		goto out;
 	}
+	if (info->pasid_table_bound) {
+		dev_err(dev, "Device PASID table already bound\n");
+		ret = -EBUSY;
+		goto out;
+	}
 	if (!info->pasid_enabled) {
 		ret = pci_enable_pasid(pdev, info->pasid_supported & ~1);
 		if (ret) {
@@ -5363,7 +5549,7 @@ static int intel_iommu_bind_pasid_table(struct iommu_domain *domain,
 				DMA_CCMD_MASK_NOBIT,
 				DMA_CCMD_DEVICE_INVL);
 	iommu->flush.flush_iotlb(iommu, did, 0, 0, DMA_TLB_DSI_FLUSH);
-
+	info->pasid_table_bound = 1;
 out_unlock:
 	spin_unlock_irqrestore(&iommu->lock, flags);
 out:
@@ -5375,8 +5561,14 @@ static void intel_iommu_unbind_pasid_table(struct iommu_domain *domain,
 {
 	struct intel_iommu *iommu;
 	struct dmar_domain *dmar_domain = to_dmar_domain(domain);
+	struct device_domain_info *info;
 	u8 bus, devfn;
 
+	info = dev->archdata.iommu;
+	if (!info) {
+		dev_err(dev, "Invalid device domain info\n");
+		return;
+	}
 	assert_spin_locked(&device_domain_lock);
 	iommu = device_to_iommu(dev, &bus, &devfn);
 	if (!iommu) {
@@ -5387,6 +5579,7 @@ static void intel_iommu_unbind_pasid_table(struct iommu_domain *domain,
 	domain_context_clear(iommu, dev);
 
 	domain_context_mapping_one(dmar_domain, iommu, bus, devfn);
+	info->pasid_table_bound = 0;
 }
 #endif /* CONFIG_INTEL_IOMMU_SVM */
 
@@ -5399,6 +5592,7 @@ const struct iommu_ops intel_iommu_ops = {
 #ifdef CONFIG_INTEL_IOMMU_SVM
 	.bind_pasid_table	= intel_iommu_bind_pasid_table,
 	.unbind_pasid_table	= intel_iommu_unbind_pasid_table,
+	.sva_invalidate		= intel_iommu_sva_invalidate,
 #endif
 	.map			= intel_iommu_map,
 	.unmap			= intel_iommu_unmap,
diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
index 3c83f7e..7f05e36 100644
--- a/include/linux/intel-iommu.h
+++ b/include/linux/intel-iommu.h
@@ -258,6 +258,10 @@ enum {
 #define QI_PGRP_RESP_TYPE	0x9
 #define QI_PSTRM_RESP_TYPE	0xa
 
+#define QI_DID(did)		(((u64)did & 0xffff) << 16)
+#define QI_DID_MASK		GENMASK(31, 16)
+#define QI_TYPE_MASK		GENMASK(3, 0)
+
 #define QI_IEC_SELECTIVE	(((u64)1) << 4)
 #define QI_IEC_IIDEX(idx)	(((u64)(idx & 0xffff) << 32))
 #define QI_IEC_IM(m)		(((u64)(m & 0x1f) << 27))
@@ -288,8 +292,9 @@ enum {
 #define QI_PC_DID(did)		(((u64)did) << 16)
 #define QI_PC_GRAN(gran)	(((u64)gran) << 4)
 
-#define QI_PC_ALL_PASIDS	(QI_PC_TYPE | QI_PC_GRAN(0))
-#define QI_PC_PASID_SEL		(QI_PC_TYPE | QI_PC_GRAN(1))
+/* PC inv granu */
+#define QI_PC_ALL_PASIDS	0
+#define QI_PC_PASID_SEL		1
 
 #define QI_EIOTLB_ADDR(addr)	((u64)(addr) & VTD_PAGE_MASK)
 #define QI_EIOTLB_GL(gl)	(((u64)gl) << 7)
@@ -299,6 +304,10 @@ enum {
 #define QI_EIOTLB_DID(did)	(((u64)did) << 16)
 #define QI_EIOTLB_GRAN(gran) 	(((u64)gran) << 4)
 
+/* QI Dev-IOTLB inv granu */
+#define QI_DEV_IOTLB_GRAN_ALL		0
+#define QI_DEV_IOTLB_GRAN_PASID_SEL	1
+
 #define QI_DEV_EIOTLB_ADDR(a)	((u64)(a) & VTD_PAGE_MASK)
 #define QI_DEV_EIOTLB_SIZE	(((u64)1) << 11)
 #define QI_DEV_EIOTLB_GLOB(g)	((u64)g)
@@ -327,6 +336,7 @@ enum {
 #define QI_RESP_INVALID		0x1
 #define QI_RESP_FAILURE		0xf
 
+/* QI EIOTLB inv granu */
 #define QI_GRAN_ALL_ALL			0
 #define QI_GRAN_NONG_ALL		1
 #define QI_GRAN_NONG_PASID		2
@@ -471,6 +481,7 @@ struct device_domain_info {
 	u8 pri_enabled:1;
 	u8 ats_supported:1;
 	u8 ats_enabled:1;
+	u8 pasid_table_bound:1;
 	u8 ats_qdep;
 	u64 fault_mask;	/* selected IOMMU faults to be reported */
 	struct device *dev; /* it's NULL for PCIe-to-PCI bridge */
@@ -502,7 +513,7 @@ extern void qi_flush_eiotlb(struct intel_iommu *iommu, u16 did, u64 addr,
 extern void qi_flush_dev_iotlb(struct intel_iommu *iommu, u16 sid, u16 pfsid,
 			u16 qdep, u64 addr, unsigned mask);
 extern void qi_flush_dev_eiotlb(struct intel_iommu *iommu, u16 sid, u16 pfsid,
-				u32 pasid, u16 qdep, u64 addr, unsigned size);
+			u32 pasid, u16 qdep, u64 addr, unsigned size, u64 granu);
 extern void qi_flush_pasid(struct intel_iommu *iommu, u16 did, u64 granu, int pasid);
 
 extern int qi_submit_sync(struct qi_desc *desc, struct intel_iommu *iommu);
-- 
2.7.4
