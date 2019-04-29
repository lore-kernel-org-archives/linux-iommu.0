From: Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v3 3/8] iommu/vt-d: Expose ISA direct mapping region via iommu_get_resv_regions
Date: Mon, 29 Apr 2019 10:09:20 +0800
Message-ID: <20190429020925.18136-4-baolu.lu@linux.intel.com>
References: <20190429020925.18136-1-baolu.lu@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190429020925.18136-1-baolu.lu@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: David Woodhouse <dwmw2@infradead.org>, Joerg Roedel <joro@8bytes.org>
Cc: ashok.raj@intel.com, jacob.jun.pan@intel.com, kevin.tian@intel.com, jamessewart@arista.com, tmurphy@arista.com, dima@arista.com, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

From: James Sewart <jamessewart@arista.com>

To support mapping ISA region via iommu_group_create_direct_mappings,
make sure its exposed by iommu_get_resv_regions. This allows
deduplication of reserved region mappings.

Signed-off-by: James Sewart <jamessewart@arista.com>
---
 drivers/iommu/intel-iommu.c | 43 +++++++++++++++++++++++++++++--------
 1 file changed, 34 insertions(+), 9 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index af025955f1bc..e9f31b062305 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -339,6 +339,8 @@ static LIST_HEAD(dmar_rmrr_units);
 #define for_each_rmrr_units(rmrr) \
 	list_for_each_entry(rmrr, &dmar_rmrr_units, list)
 
+static struct iommu_resv_region *isa_resv_region;
+
 /* bitmap for indexing intel_iommus */
 static int g_num_of_iommus;
 
@@ -2785,26 +2787,33 @@ static inline int iommu_prepare_rmrr_dev(struct dmar_rmrr_unit *rmrr,
 					  rmrr->end_address);
 }
 
+static inline struct iommu_resv_region *iommu_get_isa_resv_region(void)
+{
+	if (!isa_resv_region)
+		isa_resv_region = iommu_alloc_resv_region(0, 1UL << 24, 0,
+							  IOMMU_RESV_DIRECT);
+
+	return isa_resv_region;
+}
+
 #ifdef CONFIG_INTEL_IOMMU_FLOPPY_WA
-static inline void iommu_prepare_isa(void)
+static inline void iommu_prepare_isa(struct pci_dev *pdev)
 {
-	struct pci_dev *pdev;
 	int ret;
+	struct iommu_resv_region *reg = iommu_get_isa_resv_region();
 
-	pdev = pci_get_class(PCI_CLASS_BRIDGE_ISA << 8, NULL);
-	if (!pdev)
+	if (!reg)
 		return;
 
 	pr_info("Prepare 0-16MiB unity mapping for LPC\n");
-	ret = iommu_prepare_identity_map(&pdev->dev, 0, 16*1024*1024 - 1);
+	ret = iommu_prepare_identity_map(&pdev->dev, reg->start,
+					 reg->start + reg->length - 1);
 
 	if (ret)
 		pr_err("Failed to create 0-16MiB identity map - floppy might not work\n");
-
-	pci_dev_put(pdev);
 }
 #else
-static inline void iommu_prepare_isa(void)
+static inline void iommu_prepare_isa(struct pci_dev *pdev)
 {
 	return;
 }
@@ -3293,6 +3302,7 @@ static int __init init_dmars(void)
 	struct dmar_rmrr_unit *rmrr;
 	bool copied_tables = false;
 	struct device *dev;
+	struct pci_dev *pdev;
 	struct intel_iommu *iommu;
 	int i, ret;
 
@@ -3473,7 +3483,11 @@ static int __init init_dmars(void)
 		}
 	}
 
-	iommu_prepare_isa();
+	pdev = pci_get_class(PCI_CLASS_BRIDGE_ISA << 8, NULL);
+	if (pdev) {
+		iommu_prepare_isa(pdev);
+		pci_dev_put(pdev);
+	}
 
 domains_done:
 
@@ -5498,6 +5512,17 @@ static void intel_iommu_get_resv_regions(struct device *device,
 	}
 	rcu_read_unlock();
 
+#ifdef CONFIG_INTEL_IOMMU_FLOPPY_WA
+	if (dev_is_pci(device)) {
+		struct pci_dev *pdev = to_pci_dev(device);
+
+		if ((pdev->class >> 8) == PCI_CLASS_BRIDGE_ISA) {
+			reg = iommu_get_isa_resv_region();
+			list_add_tail(&reg->list, head);
+		}
+	}
+#endif /* CONFIG_INTEL_IOMMU_FLOPPY_WA */
+
 	reg = iommu_alloc_resv_region(IOAPIC_RANGE_START,
 				      IOAPIC_RANGE_END - IOAPIC_RANGE_START + 1,
 				      0, IOMMU_RESV_MSI);
-- 
2.17.1
