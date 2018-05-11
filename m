From: Jacob Pan <jacob.jun.pan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH v5 04/23] iommu/vt-d: add bind_pasid_table function
Date: Fri, 11 May 2018 13:53:56 -0700
Message-ID: <1526072055-86990-5-git-send-email-jacob.jun.pan@linux.intel.com>
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

Add Intel VT-d ops to the generic iommu_bind_pasid_table API
functions.

The primary use case is for direct assignment of SVM capable
device. Originated from emulated IOMMU in the guest, the request goes
through many layers (e.g. VFIO). Upon calling host IOMMU driver, caller
passes guest PASID table pointer (GPA) and size.

Device context table entry is modified by Intel IOMMU specific
bind_pasid_table function. This will turn on nesting mode and matching
translation type.

The unbind operation restores default context mapping.

Signed-off-by: Jacob Pan <jacob.jun.pan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Signed-off-by: Liu, Yi L <yi.l.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Signed-off-by: Ashok Raj <ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
---
 drivers/iommu/intel-iommu.c   | 122 ++++++++++++++++++++++++++++++++++++++++++
 include/linux/dma_remapping.h |   1 +
 2 files changed, 123 insertions(+)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index a0f81a4..4623294 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -2409,6 +2409,7 @@ static struct dmar_domain *dmar_insert_one_dev_info(struct intel_iommu *iommu,
 	info->ats_supported = info->pasid_supported = info->pri_supported = 0;
 	info->ats_enabled = info->pasid_enabled = info->pri_enabled = 0;
 	info->ats_qdep = 0;
+	info->pasid_table_bound = 0;
 	info->dev = dev;
 	info->domain = domain;
 	info->iommu = iommu;
@@ -5132,6 +5133,7 @@ static void intel_iommu_put_resv_regions(struct device *dev,
 
 #ifdef CONFIG_INTEL_IOMMU_SVM
 #define MAX_NR_PASID_BITS (20)
+#define MIN_NR_PASID_BITS (5)
 static inline unsigned long intel_iommu_get_pts(struct intel_iommu *iommu)
 {
 	/*
@@ -5258,6 +5260,122 @@ struct intel_iommu *intel_svm_device_to_iommu(struct device *dev)
 
 	return iommu;
 }
+
+static int intel_iommu_bind_pasid_table(struct iommu_domain *domain,
+		struct device *dev, struct pasid_table_config *pasidt_binfo)
+{
+	struct intel_iommu *iommu;
+	struct context_entry *context;
+	struct dmar_domain *dmar_domain = to_dmar_domain(domain);
+	struct device_domain_info *info;
+	struct pci_dev *pdev;
+	u8 bus, devfn, host_table_pasid_bits;
+	u16 did, sid;
+	int ret = 0;
+	unsigned long flags;
+	u64 ctx_lo;
+
+	if ((pasidt_binfo->version != PASID_TABLE_CFG_VERSION_1) ||
+		pasidt_binfo->bytes != sizeof(*pasidt_binfo))
+		return -EINVAL;
+	iommu = device_to_iommu(dev, &bus, &devfn);
+	if (!iommu)
+		return -ENODEV;
+	/* VT-d spec section 9.4 says pasid table size is encoded as 2^(x+5) */
+	host_table_pasid_bits = intel_iommu_get_pts(iommu) + MIN_NR_PASID_BITS;
+	if (!pasidt_binfo || pasidt_binfo->pasid_bits > host_table_pasid_bits ||
+		pasidt_binfo->pasid_bits < MIN_NR_PASID_BITS) {
+		pr_err("Invalid gPASID bits %d, host range %d - %d\n",
+			pasidt_binfo->pasid_bits,
+			MIN_NR_PASID_BITS, host_table_pasid_bits);
+		return -ERANGE;
+	}
+	if (!ecap_nest(iommu->ecap)) {
+		dev_err(dev, "Cannot bind PASID table, no nested translation\n");
+		ret = -ENODEV;
+		goto out;
+	}
+	pdev = to_pci_dev(dev);
+	sid = PCI_DEVID(bus, devfn);
+	info = dev->archdata.iommu;
+
+	if (!info) {
+		dev_err(dev, "Invalid device domain info\n");
+		ret = -EINVAL;
+		goto out;
+	}
+	if (info->pasid_table_bound) {
+		dev_err(dev, "Device PASID table already bound\n");
+		ret = -EBUSY;
+		goto out;
+	}
+	if (!info->pasid_enabled) {
+		ret = pci_enable_pasid(pdev, info->pasid_supported & ~1);
+		if (ret) {
+			dev_err(dev, "Failed to enable PASID\n");
+			goto out;
+		}
+	}
+	spin_lock_irqsave(&iommu->lock, flags);
+	context = iommu_context_addr(iommu, bus, devfn, 0);
+	if (!context_present(context)) {
+		dev_err(dev, "Context not present\n");
+		ret = -EINVAL;
+		goto out_unlock;
+	}
+
+	/* Anticipate guest to use SVM and owns the first level, so we turn
+	 * nested mode on
+	 */
+	ctx_lo = context[0].lo;
+	ctx_lo |= CONTEXT_NESTE | CONTEXT_PRS | CONTEXT_PASIDE;
+	ctx_lo &= ~CONTEXT_TT_MASK;
+	ctx_lo |= CONTEXT_TT_DEV_IOTLB << 2;
+	context[0].lo = ctx_lo;
+
+	/* Assign guest PASID table pointer and size order */
+	ctx_lo = (pasidt_binfo->base_ptr & VTD_PAGE_MASK) |
+		(pasidt_binfo->pasid_bits - MIN_NR_PASID_BITS);
+	context[1].lo = ctx_lo;
+	/* make sure context entry is updated before flushing */
+	wmb();
+	did = dmar_domain->iommu_did[iommu->seq_id];
+	iommu->flush.flush_context(iommu, did,
+				(((u16)bus) << 8) | devfn,
+				DMA_CCMD_MASK_NOBIT,
+				DMA_CCMD_DEVICE_INVL);
+	iommu->flush.flush_iotlb(iommu, did, 0, 0, DMA_TLB_DSI_FLUSH);
+	info->pasid_table_bound = 1;
+out_unlock:
+	spin_unlock_irqrestore(&iommu->lock, flags);
+out:
+	return ret;
+}
+
+static void intel_iommu_unbind_pasid_table(struct iommu_domain *domain,
+					struct device *dev)
+{
+	struct intel_iommu *iommu;
+	struct dmar_domain *dmar_domain = to_dmar_domain(domain);
+	struct device_domain_info *info;
+	u8 bus, devfn;
+
+	info = dev->archdata.iommu;
+	if (!info) {
+		dev_err(dev, "Invalid device domain info\n");
+		return;
+	}
+	iommu = device_to_iommu(dev, &bus, &devfn);
+	if (!iommu) {
+		dev_err(dev, "No IOMMU for device to unbind PASID table\n");
+		return;
+	}
+
+	domain_context_clear(iommu, dev);
+
+	domain_context_mapping_one(dmar_domain, iommu, bus, devfn);
+	info->pasid_table_bound = 0;
+}
 #endif /* CONFIG_INTEL_IOMMU_SVM */
 
 const struct iommu_ops intel_iommu_ops = {
@@ -5266,6 +5384,10 @@ const struct iommu_ops intel_iommu_ops = {
 	.domain_free		= intel_iommu_domain_free,
 	.attach_dev		= intel_iommu_attach_device,
 	.detach_dev		= intel_iommu_detach_device,
+#ifdef CONFIG_INTEL_IOMMU_SVM
+	.bind_pasid_table	= intel_iommu_bind_pasid_table,
+	.unbind_pasid_table	= intel_iommu_unbind_pasid_table,
+#endif
 	.map			= intel_iommu_map,
 	.unmap			= intel_iommu_unmap,
 	.map_sg			= default_iommu_map_sg,
diff --git a/include/linux/dma_remapping.h b/include/linux/dma_remapping.h
index 21b3e7d..db290b2 100644
--- a/include/linux/dma_remapping.h
+++ b/include/linux/dma_remapping.h
@@ -28,6 +28,7 @@
 
 #define CONTEXT_DINVE		(1ULL << 8)
 #define CONTEXT_PRS		(1ULL << 9)
+#define CONTEXT_NESTE		(1ULL << 10)
 #define CONTEXT_PASIDE		(1ULL << 11)
 
 struct intel_iommu;
-- 
2.7.4
