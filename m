From: Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH 6/9] iommu/vt-d: track device with pasid table bond to a guest
Date: Tue, 27 Jun 2017 12:48:00 -0700
Message-ID: <1498592883-56224-7-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1498592883-56224-1-git-send-email-jacob.jun.pan@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1498592883-56224-1-git-send-email-jacob.jun.pan@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>, Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>
Cc: "Liu, Yi L" <yi.l.liu@intel.com>, Lan Tianyu <tianyu.lan@intel.com>, "Tian, Kevin" <kevin.tian@intel.com>, Raj Ashok <ashok.raj@intel.com>, Alex Williamson <alex.williamson@redhat.com>, Jean Delvare <khali@linux-fr.org>, Jacob Pan <jacob.jun.pan@linux.intel.com>
List-Id: iommu@lists.linux-foundation.org

When PASID table pointer of an assigned device is bond to a guest,
the first level page tables are managed by the guest. However, only
host/physical IOMMU can detect fault events, e.g. page requests.
Therefore, we need to keep track of which device has its PASID table
pointer bond to a guest such that page request and other events can
be propagated to the guest as needed.

Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
Signed-off-by: Ashok Raj <ashok.raj@intel.com>
---
 drivers/iommu/intel-iommu.c | 19 +------------------
 include/linux/intel-iommu.h | 19 +++++++++++++++++++
 2 files changed, 20 insertions(+), 18 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 242bb8c..d911d47 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -416,24 +416,6 @@ struct dmar_domain {
 					   iommu core */
 };
 
-/* PCI domain-device relationship */
-struct device_domain_info {
-	struct list_head link;	/* link to domain siblings */
-	struct list_head global; /* link to global list */
-	u8 bus;			/* PCI bus number */
-	u8 devfn;		/* PCI devfn number */
-	u8 pasid_supported:3;
-	u8 pasid_enabled:1;
-	u8 pri_supported:1;
-	u8 pri_enabled:1;
-	u8 ats_supported:1;
-	u8 ats_enabled:1;
-	u8 ats_qdep;
-	struct device *dev; /* it's NULL for PCIe-to-PCI bridge */
-	struct intel_iommu *iommu; /* IOMMU used by this device */
-	struct dmar_domain *domain; /* pointer to domain */
-};
-
 struct dmar_rmrr_unit {
 	struct list_head list;		/* list of rmrr units	*/
 	struct acpi_dmar_header *hdr;	/* ACPI header		*/
@@ -5555,6 +5537,7 @@ static int intel_iommu_bind_pasid_table(struct iommu_domain *domain,
 				DMA_CCMD_MASK_NOBIT,
 				DMA_CCMD_DEVICE_INVL);
 	iommu->flush.flush_iotlb(iommu, did, 0, 0, DMA_TLB_DSI_FLUSH);
+	info->pasid_tbl_bound = 1;
 	spin_unlock_irqrestore(&iommu->lock, flags);
 
 
diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
index 8df6c91..61f81ab 100644
--- a/include/linux/intel-iommu.h
+++ b/include/linux/intel-iommu.h
@@ -434,6 +434,25 @@ struct intel_iommu {
 	u32		flags;      /* Software defined flags */
 };
 
+/* PCI domain-device relationship */
+struct device_domain_info {
+	struct list_head link;	/* link to domain siblings */
+	struct list_head global; /* link to global list */
+	u8 bus;			/* PCI bus number */
+	u8 devfn;		/* PCI devfn number */
+	u8 pasid_supported:3;
+	u8 pasid_enabled:1;
+	u8 pasid_tbl_bound:1;	/* bound to guest PASID table */
+	u8 pri_supported:1;
+	u8 pri_enabled:1;
+	u8 ats_supported:1;
+	u8 ats_enabled:1;
+	u8 ats_qdep;
+	struct device *dev; /* it's NULL for PCIe-to-PCI bridge */
+	struct intel_iommu *iommu; /* IOMMU used by this device */
+	struct dmar_domain *domain; /* pointer to domain */
+};
+
 static inline void __iommu_flush_cache(
 	struct intel_iommu *iommu, void *addr, int size)
 {
-- 
2.7.4
