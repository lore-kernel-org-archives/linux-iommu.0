From: James Sewart <jamessewart@arista.com>
Subject: [PATCH v2 3/7] iommu/vt-d: Expose ISA direct mapping region via
 iommu_get_resv_regions
Date: Thu, 14 Mar 2019 11:58:27 +0000
Message-ID: <F531CABB-FFDA-4E0A-A3D5-095FF338DD5A@arista.com>
References: <0F0C82BE-86E5-4BAC-938C-6F7629E18D27@arista.com>
 <83B82113-8AE5-4B0C-A079-F389520525BD@arista.com>
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <83B82113-8AE5-4B0C-A079-F389520525BD@arista.com>
Sender: linux-kernel-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org
Cc: Tom Murphy <tmurphy@arista.com>, Dmitry Safonov <dima@arista.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>, linux-kernel@vger.kernel.org, Lu Baolu <baolu.lu@linux.intel.com>
List-Id: iommu@lists.linux-foundation.org

To support mapping ISA region via iommu_group_create_direct_mappings,
make sure its exposed by iommu_get_resv_regions. This allows
deduplication of reserved region mappings

Signed-off-by: James Sewart <jamessewart@arista.com>
---
 drivers/iommu/intel-iommu.c | 42 +++++++++++++++++++++++++++++--------
 1 file changed, 33 insertions(+), 9 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 8e0a4e2ff77f..2e00e8708f06 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -337,6 +337,8 @@ static LIST_HEAD(dmar_rmrr_units);
 #define for_each_rmrr_units(rmrr) \
 	list_for_each_entry(rmrr, &dmar_rmrr_units, list)
=20
+static struct iommu_resv_region *isa_resv_region;
+
 /* bitmap for indexing intel_iommus */
 static int g_num_of_iommus;
=20
@@ -2780,26 +2782,34 @@ static inline int iommu_prepare_rmrr_dev(struct =
dmar_rmrr_unit *rmrr,
 					  rmrr->end_address);
 }
=20
+static inline struct iommu_resv_region *iommu_get_isa_resv_region(void)
+{
+	if (!isa_resv_region)
+		isa_resv_region =3D iommu_alloc_resv_region(0,
+				16*1024*1024,
+				0, IOMMU_RESV_DIRECT);
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
+	struct iommu_resv_region *reg =3D iommu_get_isa_resv_region();
=20
-	pdev =3D pci_get_class(PCI_CLASS_BRIDGE_ISA << 8, NULL);
-	if (!pdev)
+	if (!reg)
 		return;
=20
 	pr_info("Prepare 0-16MiB unity mapping for LPC\n");
-	ret =3D iommu_prepare_identity_map(&pdev->dev, 0, 16*1024*1024 - =
1);
+	ret =3D iommu_prepare_identity_map(&pdev->dev, reg->start,
+			reg->start + reg->length - 1);
=20
 	if (ret)
 		pr_err("Failed to create 0-16MiB identity map - floppy =
might not work\n");
-
-	pci_dev_put(pdev);
 }
 #else
-static inline void iommu_prepare_isa(void)
+static inline void iommu_prepare_isa(struct pci_dev *pdev)
 {
 	return;
 }
@@ -3289,6 +3299,7 @@ static int __init init_dmars(void)
 	struct dmar_rmrr_unit *rmrr;
 	bool copied_tables =3D false;
 	struct device *dev;
+	struct pci_dev *pdev;
 	struct intel_iommu *iommu;
 	int i, ret;
=20
@@ -3469,7 +3480,11 @@ static int __init init_dmars(void)
 		}
 	}
=20
-	iommu_prepare_isa();
+	pdev =3D pci_get_class(PCI_CLASS_BRIDGE_ISA << 8, NULL);
+	if (pdev) {
+		iommu_prepare_isa(pdev);
+		pci_dev_put(pdev);
+	}
=20
 domains_done:
=20
@@ -5266,6 +5281,7 @@ static void intel_iommu_get_resv_regions(struct =
device *device,
 	struct iommu_resv_region *reg;
 	struct dmar_rmrr_unit *rmrr;
 	struct device *i_dev;
+	struct pci_dev *pdev;
 	int i;
=20
 	rcu_read_lock();
@@ -5280,6 +5296,14 @@ static void intel_iommu_get_resv_regions(struct =
device *device,
 	}
 	rcu_read_unlock();
=20
+	if (dev_is_pci(device)) {
+		pdev =3D to_pci_dev(device);
+		if ((pdev->class >> 8) =3D=3D PCI_CLASS_BRIDGE_ISA) {
+			reg =3D iommu_get_isa_resv_region();
+			list_add_tail(&reg->list, head);
+		}
+	}
+
 	reg =3D iommu_alloc_resv_region(IOAPIC_RANGE_START,
 				      IOAPIC_RANGE_END - =
IOAPIC_RANGE_START + 1,
 				      0, IOMMU_RESV_MSI);
--=20
2.17.1
