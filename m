From: Jacob Pan <jacob.jun.pan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH v3 05/16] iommu/vt-d: support flushing more TLB types
Date: Fri, 17 Nov 2017 10:55:03 -0800
Message-ID: <1510944914-54430-6-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1510944914-54430-1-git-send-email-jacob.jun.pan@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1510944914-54430-1-git-send-email-jacob.jun.pan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Rafael Wysocki <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Lan Tianyu <tianyu.lan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Yi L <yi.l.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Liu-i9wRM+HIrmnmtl4Z8vJ8Kg761KYD1DLY@public.gmane.org, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

With shared virtual memory vitualization, extended IOTLB invalidation
may be passed down from outside IOMMU subsystems. This patch adds
invalidation functions that can be used for each IOTLB types.

Signed-off-by: Jacob Pan <jacob.jun.pan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Signed-off-by: Liu, Yi L <yi.l.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Signed-off-by: Ashok Raj <ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
---
 drivers/iommu/dmar.c        | 54 ++++++++++++++++++++++++++++++++++++++++++---
 drivers/iommu/intel-iommu.c |  3 ++-
 include/linux/intel-iommu.h | 10 +++++++--
 3 files changed, 61 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/dmar.c b/drivers/iommu/dmar.c
index 57c920c..f69f6ee 100644
--- a/drivers/iommu/dmar.c
+++ b/drivers/iommu/dmar.c
@@ -1336,11 +1336,25 @@ void qi_flush_iotlb(struct intel_iommu *iommu, u16 did, u64 addr,
 	qi_submit_sync(&desc, iommu);
 }
 
-void qi_flush_dev_iotlb(struct intel_iommu *iommu, u16 sid, u16 qdep,
-			u64 addr, unsigned mask)
+void qi_flush_eiotlb(struct intel_iommu *iommu, u16 did, u64 addr, u32 pasid,
+		unsigned int size_order, u64 granu, bool global)
 {
 	struct qi_desc desc;
 
+	desc.low = QI_EIOTLB_PASID(pasid) | QI_EIOTLB_DID(did) |
+		QI_EIOTLB_GRAN(granu) | QI_EIOTLB_TYPE;
+	desc.high = QI_EIOTLB_ADDR(addr) | QI_EIOTLB_GL(global) |
+		QI_EIOTLB_IH(0) | QI_EIOTLB_AM(size_order);
+	qi_submit_sync(&desc, iommu);
+}
+
+void qi_flush_dev_iotlb(struct intel_iommu *iommu, u16 sid, u16 pfsid,
+			u16 qdep, u64 addr, unsigned mask)
+{
+	struct qi_desc desc;
+
+	pr_debug_ratelimited("%s: sid %d, pfsid %d, qdep %d, addr %llx, mask %d\n",
+		__func__, sid, pfsid, qdep, addr, mask);
 	if (mask) {
 		BUG_ON(addr & ((1 << (VTD_PAGE_SHIFT + mask)) - 1));
 		addr |= (1ULL << (VTD_PAGE_SHIFT + mask - 1)) - 1;
@@ -1352,7 +1366,41 @@ void qi_flush_dev_iotlb(struct intel_iommu *iommu, u16 sid, u16 qdep,
 		qdep = 0;
 
 	desc.low = QI_DEV_IOTLB_SID(sid) | QI_DEV_IOTLB_QDEP(qdep) |
-		   QI_DIOTLB_TYPE;
+		   QI_DIOTLB_TYPE | QI_DEV_IOTLB_SID(pfsid);
+
+	qi_submit_sync(&desc, iommu);
+}
+
+void qi_flush_dev_eiotlb(struct intel_iommu *iommu, u16 sid, u16 pfsid,
+		u32 pasid,  u16 qdep, u64 addr, unsigned size, u64 granu)
+{
+	struct qi_desc desc;
+
+	desc.low = QI_DEV_EIOTLB_PASID(pasid) | QI_DEV_EIOTLB_SID(sid) |
+		QI_DEV_EIOTLB_QDEP(qdep) | QI_DEIOTLB_TYPE |
+		QI_DEV_EIOTLB_PFSID(pfsid);
+	desc.high |= QI_DEV_EIOTLB_GLOB(granu);
+
+	/* If S bit is 0, we only flush a single page. If S bit is set,
+	 * The least significant zero bit indicates the size. VT-d spec
+	 * 6.5.2.6
+	 */
+	if (!size)
+		desc.high = QI_DEV_EIOTLB_ADDR(addr) & ~QI_DEV_EIOTLB_SIZE;
+	else {
+		unsigned long mask = 1UL << (VTD_PAGE_SHIFT + size);
+
+		desc.high = QI_DEV_EIOTLB_ADDR(addr & ~mask) | QI_DEV_EIOTLB_SIZE;
+	}
+	qi_submit_sync(&desc, iommu);
+}
+
+void qi_flush_pasid(struct intel_iommu *iommu, u16 did, u64 granu, int pasid)
+{
+	struct qi_desc desc;
+
+	desc.high = 0;
+	desc.low = QI_PC_TYPE | QI_PC_DID(did) | QI_PC_GRAN(granu) | QI_PC_PASID(pasid);
 
 	qi_submit_sync(&desc, iommu);
 }
diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 399b504..556bdd2 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -1524,7 +1524,8 @@ static void iommu_flush_dev_iotlb(struct dmar_domain *domain,
 
 		sid = info->bus << 8 | info->devfn;
 		qdep = info->ats_qdep;
-		qi_flush_dev_iotlb(info->iommu, sid, qdep, addr, mask);
+		qi_flush_dev_iotlb(info->iommu, sid, info->pfsid,
+				qdep, addr, mask);
 	}
 	spin_unlock_irqrestore(&device_domain_lock, flags);
 }
diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
index 8d38e24..3c83f7e 100644
--- a/include/linux/intel-iommu.h
+++ b/include/linux/intel-iommu.h
@@ -305,6 +305,7 @@ enum {
 #define QI_DEV_EIOTLB_PASID(p)	(((u64)p) << 32)
 #define QI_DEV_EIOTLB_SID(sid)	((u64)((sid) & 0xffff) << 16)
 #define QI_DEV_EIOTLB_QDEP(qd)	((u64)((qd) & 0x1f) << 4)
+#define QI_DEV_EIOTLB_PFSID(pfsid) (((u64)(pfsid & 0xf) << 12) | ((u64)(pfsid & 0xff0) << 48))
 #define QI_DEV_EIOTLB_MAX_INVS	32
 
 #define QI_PGRP_IDX(idx)	(((u64)(idx)) << 55)
@@ -496,8 +497,13 @@ extern void qi_flush_context(struct intel_iommu *iommu, u16 did, u16 sid,
 			     u8 fm, u64 type);
 extern void qi_flush_iotlb(struct intel_iommu *iommu, u16 did, u64 addr,
 			  unsigned int size_order, u64 type);
-extern void qi_flush_dev_iotlb(struct intel_iommu *iommu, u16 sid, u16 qdep,
-			       u64 addr, unsigned mask);
+extern void qi_flush_eiotlb(struct intel_iommu *iommu, u16 did, u64 addr,
+			u32 pasid, unsigned int size_order, u64 type, bool global);
+extern void qi_flush_dev_iotlb(struct intel_iommu *iommu, u16 sid, u16 pfsid,
+			u16 qdep, u64 addr, unsigned mask);
+extern void qi_flush_dev_eiotlb(struct intel_iommu *iommu, u16 sid, u16 pfsid,
+				u32 pasid, u16 qdep, u64 addr, unsigned size);
+extern void qi_flush_pasid(struct intel_iommu *iommu, u16 did, u64 granu, int pasid);
 
 extern int qi_submit_sync(struct qi_desc *desc, struct intel_iommu *iommu);
 
-- 
2.7.4
