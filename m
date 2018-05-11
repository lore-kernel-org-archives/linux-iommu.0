From: Jacob Pan <jacob.jun.pan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH v5 09/23] iommu/vt-d: add svm/sva invalidate function
Date: Fri, 11 May 2018 13:54:01 -0700
Message-ID: <1526072055-86990-10-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1526072055-86990-1-git-send-email-jacob.jun.pan@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1526072055-86990-1-git-send-email-jacob.jun.pan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>
Cc: Yi L <yi.l.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Raj Ashok <ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Rafael Wysocki <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Liu-i9wRM+HIrmnmtl4Z8vJ8Kg761KYD1DLY@public.gmane.org, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

When Shared Virtual Address (SVA) is enabled for a guest OS via
vIOMMU, we need to provide invalidation support at IOMMU API and driver
level. This patch adds Intel VT-d specific function to implement
iommu passdown invalidate API for shared virtual address.

The use case is for supporting caching structure invalidation
of assigned SVM capable devices. Emulated IOMMU exposes queue
invalidation capability and passes down all descriptors from the guest
to the physical IOMMU.

The assumption is that guest to host device ID mapping should be
resolved prior to calling IOMMU driver. Based on the device handle,
host IOMMU driver can replace certain fields before submit to the
invalidation queue.

Signed-off-by: Liu, Yi L <yi.l.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Signed-off-by: Ashok Raj <ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Signed-off-by: Jacob Pan <jacob.jun.pan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 drivers/iommu/intel-iommu.c | 129 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 129 insertions(+)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 732a10f..684bd98 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -4973,6 +4973,134 @@ static void intel_iommu_detach_device(struct iommu_domain *domain,
 	dmar_remove_one_dev_info(to_dmar_domain(domain), dev);
 }
 
+/*
+ * 2D array for converting and sanitizing IOMMU generic TLB granularity to
+ * VT-d granularity. Invalidation is typically included in the unmap operation
+ * as a result of DMA or VFIO unmap. However, for assigned device where guest
+ * could own the first level page tables without being shadowed by QEMU. In
+ * this case there is no pass down unmap to the host IOMMU as a result of unmap
+ * in the guest. Only invalidations are trapped and passed down.
+ * In all cases, only first level TLB invalidation (request with PASID) can be
+ * passed down, therefore we do not include IOTLB granularity for request
+ * without PASID (second level).
+ *
+ * For an example, to find the VT-d granularity encoding for IOTLB
+ * type and page selective granularity within PASID:
+ * X: indexed by enum iommu_inv_type
+ * Y: indexed by enum iommu_inv_granularity
+ * [IOMMU_INV_TYPE_TLB][IOMMU_INV_GRANU_PAGE_PASID]
+ *
+ * Granu_map array indicates validity of the table. 1: valid, 0: invalid
+ *
+ */
+const static int inv_type_granu_map[IOMMU_INV_NR_TYPE][IOMMU_INV_NR_GRANU] = {
+	/* Extended dev TLBs */
+	{1, 1, 1},
+	/* Extended IOTLB */
+	{1, 1, 1},
+	/* PASID cache */
+	{1, 1, 0}
+};
+
+const static u64 inv_type_granu_table[IOMMU_INV_NR_TYPE][IOMMU_INV_NR_GRANU] = {
+	/* extended dev IOTLBs */
+	{QI_DEV_IOTLB_GRAN_ALL, QI_DEV_IOTLB_GRAN_PASID_SEL, 0},
+	/* Extended IOTLB */
+	{QI_GRAN_NONG_ALL, QI_GRAN_NONG_PASID, QI_GRAN_PSI_PASID},
+	/* PASID cache */
+	{QI_PC_ALL_PASIDS, QI_PC_PASID_SEL, 0},
+};
+
+static inline int to_vtd_granularity(int type, int granu, u64 *vtd_granu)
+{
+	if (type >= IOMMU_INV_NR_TYPE || granu >= IOMMU_INV_NR_GRANU ||
+		!inv_type_granu_map[type][granu])
+		return -EINVAL;
+
+	*vtd_granu = inv_type_granu_table[type][granu];
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
+	u16 did, sid;
+	u8 bus, devfn;
+	int ret = 0;
+	u64 granu;
+	unsigned long flags;
+
+	if (!inv_info || !dmar_domain ||
+		inv_info->hdr.type != TLB_INV_HDR_VERSION_1)
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
+				&granu);
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
+	case IOMMU_INV_TYPE_TLB:
+		if (inv_info->size &&
+			(inv_info->addr & ((1 << (VTD_PAGE_SHIFT + inv_info->size)) - 1))) {
+			pr_err("Addr out of range, addr 0x%llx, size order %d\n",
+				inv_info->addr, inv_info->size);
+			ret = -ERANGE;
+			goto out_unlock;
+		}
+
+		qi_flush_eiotlb(iommu, did, mm_to_dma_pfn(inv_info->addr),
+				inv_info->pasid,
+				inv_info->size, granu,
+				inv_info->flags & IOMMU_INVALIDATE_GLOBAL_PAGE);
+		/**
+		 * Always flush device IOTLB if ATS is enabled since guest
+		 * vIOMMU exposes CM = 1, no device IOTLB flush will be passed
+		 * down.
+		 */
+		info = iommu_support_dev_iotlb(dmar_domain, iommu, bus, devfn);
+		if (info && info->ats_enabled) {
+			qi_flush_dev_eiotlb(iommu, sid,
+					inv_info->pasid, info->ats_qdep,
+					inv_info->addr, inv_info->size,
+					granu);
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
@@ -5401,6 +5529,7 @@ const struct iommu_ops intel_iommu_ops = {
 #ifdef CONFIG_INTEL_IOMMU_SVM
 	.bind_pasid_table	= intel_iommu_bind_pasid_table,
 	.unbind_pasid_table	= intel_iommu_unbind_pasid_table,
+	.sva_invalidate		= intel_iommu_sva_invalidate,
 #endif
 	.map			= intel_iommu_map,
 	.unmap			= intel_iommu_unmap,
-- 
2.7.4
