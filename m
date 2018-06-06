From: Jacob Pan <jacob.jun.pan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH 2/2] iommu/vt-d: fix dev iotlb pfsid use
Date: Wed,  6 Jun 2018 13:18:00 -0700
Message-ID: <1528316280-24307-3-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1528316280-24307-1-git-send-email-jacob.jun.pan@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1528316280-24307-1-git-send-email-jacob.jun.pan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Cc: Raj Ashok <ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

PFSID should be used in the invalidation descriptor for flushing
device IOTLBs on SRIOV VFs.

Signed-off-by: Jacob Pan <jacob.jun.pan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 drivers/iommu/dmar.c        |  6 +++---
 drivers/iommu/intel-iommu.c | 16 +++++++++++++++-
 include/linux/intel-iommu.h |  5 ++---
 3 files changed, 20 insertions(+), 7 deletions(-)

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
index 3d77d61..e0e80c3 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -1503,6 +1503,19 @@ static void iommu_enable_dev_iotlb(struct device_domain_info *info)
 		return;
 
 	pdev = to_pci_dev(info->dev);
+	/* For IOMMU that supports device IOTLB throttling (DIT), we assign
+	 * PFSID to the invalidation desc of a VF such that IOMMU HW can gauge
+	 * queue depth at PF level. If DIT is not set, PFSID will be treated as
+	 * reserved, which should be set to 0.
+	 */
+	if (!ecap_dit(info->iommu->ecap))
+		info->pfsid = 0;
+	else if (pdev && pdev->is_virtfn) {
+		if (ecap_dit(info->iommu->ecap))
+			dev_warn(&pdev->dev, "SRIOV VF device IOTLB enabled without flow control\n");
+		info->pfsid = PCI_DEVID(pdev->physfn->bus->number, pdev->physfn->devfn);
+	} else
+		info->pfsid = PCI_DEVID(info->bus, info->devfn);
 
 #ifdef CONFIG_INTEL_IOMMU_SVM
 	/* The PCIe spec, in its wisdom, declares that the behaviour of
@@ -1568,7 +1581,8 @@ static void iommu_flush_dev_iotlb(struct dmar_domain *domain,
 
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
