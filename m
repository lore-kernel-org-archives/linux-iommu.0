From: Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH v2 2/2] iommu/vt-d: fix dev iotlb pfsid use
Date: Thu,  7 Jun 2018 09:57:00 -0700
Message-ID: <1528390620-31565-3-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1528390620-31565-1-git-send-email-jacob.jun.pan@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1528390620-31565-1-git-send-email-jacob.jun.pan@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>, Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>, stable@vger.kernel.org, Ashok Raj <ashok.raj@intel.com>, Lu Baolu <baolu.lu@linux.intel.com>
List-Id: iommu@lists.linux-foundation.org

PFSID should be used in the invalidation descriptor for flushing
device IOTLBs on SRIOV VFs.

Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: stable@vger.kernel.org
Cc: "Ashok Raj" <ashok.raj@intel.com>
Cc: "Lu Baolu" <baolu.lu@linux.intel.com>
---
 drivers/iommu/dmar.c        |  6 +++---
 drivers/iommu/intel-iommu.c | 17 ++++++++++++++++-
 include/linux/intel-iommu.h |  5 ++---
 3 files changed, 21 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/dmar.c b/drivers/iommu/dmar.c
index 460bed4..7852678 100644
--- a/drivers/iommu/dmar.c
+++ b/drivers/iommu/dmar.c
@@ -1339,8 +1339,8 @@ void qi_flush_iotlb(struct intel_iommu *iommu, u16 did, u64 addr,
 	qi_submit_sync(&desc, iommu);
 }
 
-void qi_flush_dev_iotlb(struct intel_iommu *iommu, u16 sid, u16 qdep,
-			u64 addr, unsigned mask)
+void qi_flush_dev_iotlb(struct intel_iommu *iommu, u16 sid, u16 pfsid,
+			u16 qdep, u64 addr, unsigned mask)
 {
 	struct qi_desc desc;
 
@@ -1355,7 +1355,7 @@ void qi_flush_dev_iotlb(struct intel_iommu *iommu, u16 sid, u16 qdep,
 		qdep = 0;
 
 	desc.low = QI_DEV_IOTLB_SID(sid) | QI_DEV_IOTLB_QDEP(qdep) |
-		   QI_DIOTLB_TYPE;
+		   QI_DIOTLB_TYPE | QI_DEV_IOTLB_PFSID(pfsid);
 
 	qi_submit_sync(&desc, iommu);
 }
diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 3d77d61..8b533cc 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -1503,6 +1503,20 @@ static void iommu_enable_dev_iotlb(struct device_domain_info *info)
 		return;
 
 	pdev = to_pci_dev(info->dev);
+	/* For IOMMU that supports device IOTLB throttling (DIT), we assign
+	 * PFSID to the invalidation desc of a VF such that IOMMU HW can gauge
+	 * queue depth at PF level. If DIT is not set, PFSID will be treated as
+	 * reserved, which should be set to 0.
+	 */
+	if (!ecap_dit(info->iommu->ecap))
+		info->pfsid = 0;
+	else {
+		struct pci_dev *pf_pdev;
+
+		/* pdev will be returned if device is not a vf */
+		pf_pdev = pci_physfn(pdev);
+		info->pfsid = PCI_DEVID(pf_pdev->bus->number, pf_pdev->devfn);
+	}
 
 #ifdef CONFIG_INTEL_IOMMU_SVM
 	/* The PCIe spec, in its wisdom, declares that the behaviour of
@@ -1568,7 +1582,8 @@ static void iommu_flush_dev_iotlb(struct dmar_domain *domain,
 
 		sid = info->bus << 8 | info->devfn;
 		qdep = info->ats_qdep;
-		qi_flush_dev_iotlb(info->iommu, sid, qdep, addr, mask);
+		qi_flush_dev_iotlb(info->iommu, sid, info->pfsid,
+				qdep, addr, mask);
 	}
 	spin_unlock_irqrestore(&device_domain_lock, flags);
 }
diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
index af1c05f..7fd9fbae 100644
--- a/include/linux/intel-iommu.h
+++ b/include/linux/intel-iommu.h
@@ -456,9 +456,8 @@ extern void qi_flush_context(struct intel_iommu *iommu, u16 did, u16 sid,
 			     u8 fm, u64 type);
 extern void qi_flush_iotlb(struct intel_iommu *iommu, u16 did, u64 addr,
 			  unsigned int size_order, u64 type);
-extern void qi_flush_dev_iotlb(struct intel_iommu *iommu, u16 sid, u16 qdep,
-			       u64 addr, unsigned mask);
-
+extern void qi_flush_dev_iotlb(struct intel_iommu *iommu, u16 sid, u16 pfsid,
+			u16 qdep, u64 addr, unsigned mask);
 extern int qi_submit_sync(struct qi_desc *desc, struct intel_iommu *iommu);
 
 extern int dmar_ir_support(void);
-- 
2.7.4
