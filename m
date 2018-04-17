From: Lu Baolu <baolu.lu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH 3/9] iommu/vt-d: Use global PASID for SVM usage
Date: Tue, 17 Apr 2018 11:03:16 +0800
Message-ID: <1523934202-21669-4-git-send-email-baolu.lu@linux.intel.com>
References: <1523934202-21669-1-git-send-email-baolu.lu@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1523934202-21669-1-git-send-email-baolu.lu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, sanjay.k.kumar-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, yi.y.sun-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, jacob.jun.pan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

This patch switches PASID management for SVM from per iommu
idr to the global idr.

Cc: Ashok Raj <ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Jacob Pan <jacob.jun.pan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: Kevin Tian <kevin.tian-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Liu Yi L <yi.l.liu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Signed-off-by: Lu Baolu <baolu.lu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Reviewed-by: Kevin Tian <kevin.tian-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
---
 drivers/iommu/intel-svm.c   | 22 +++++++++++-----------
 include/linux/intel-iommu.h |  1 -
 2 files changed, 11 insertions(+), 12 deletions(-)

diff --git a/drivers/iommu/intel-svm.c b/drivers/iommu/intel-svm.c
index 983af0c..24d0ea1 100644
--- a/drivers/iommu/intel-svm.c
+++ b/drivers/iommu/intel-svm.c
@@ -26,6 +26,8 @@
 #include <linux/interrupt.h>
 #include <asm/page.h>
 
+#include "intel-pasid.h"
+
 #define PASID_ENTRY_P		BIT_ULL(0)
 #define PASID_ENTRY_FLPM_5LP	BIT_ULL(9)
 #define PASID_ENTRY_SRE		BIT_ULL(11)
@@ -85,8 +87,6 @@ int intel_svm_alloc_pasid_tables(struct intel_iommu *iommu)
 				iommu->name);
 	}
 
-	idr_init(&iommu->pasid_idr);
-
 	return 0;
 }
 
@@ -102,7 +102,7 @@ int intel_svm_free_pasid_tables(struct intel_iommu *iommu)
 		free_pages((unsigned long)iommu->pasid_state_table, order);
 		iommu->pasid_state_table = NULL;
 	}
-	idr_destroy(&iommu->pasid_idr);
+
 	return 0;
 }
 
@@ -392,9 +392,9 @@ int intel_svm_bind_mm(struct device *dev, int *pasid, int flags, struct svm_dev_
 			pasid_max = iommu->pasid_max;
 
 		/* Do not use PASID 0 in caching mode (virtualised IOMMU) */
-		ret = idr_alloc(&iommu->pasid_idr, svm,
-				!!cap_caching_mode(iommu->cap),
-				pasid_max - 1, GFP_KERNEL);
+		ret = intel_pasid_alloc_id(svm,
+					   !!cap_caching_mode(iommu->cap),
+					   pasid_max - 1, GFP_KERNEL);
 		if (ret < 0) {
 			kfree(svm);
 			kfree(sdev);
@@ -410,7 +410,7 @@ int intel_svm_bind_mm(struct device *dev, int *pasid, int flags, struct svm_dev_
 		if (mm) {
 			ret = mmu_notifier_register(&svm->notifier, mm);
 			if (ret) {
-				idr_remove(&svm->iommu->pasid_idr, svm->pasid);
+				intel_pasid_free_id(svm->pasid);
 				kfree(svm);
 				kfree(sdev);
 				goto out;
@@ -460,7 +460,7 @@ int intel_svm_unbind_mm(struct device *dev, int pasid)
 	if (!iommu || !iommu->pasid_table)
 		goto out;
 
-	svm = idr_find(&iommu->pasid_idr, pasid);
+	svm = intel_pasid_lookup_id(pasid);
 	if (!svm)
 		goto out;
 
@@ -485,7 +485,7 @@ int intel_svm_unbind_mm(struct device *dev, int pasid)
 					svm->iommu->pasid_table[svm->pasid].val = 0;
 					wmb();
 
-					idr_remove(&svm->iommu->pasid_idr, svm->pasid);
+					intel_pasid_free_id(svm->pasid);
 					if (svm->mm)
 						mmu_notifier_unregister(&svm->notifier, svm->mm);
 
@@ -520,7 +520,7 @@ int intel_svm_is_pasid_valid(struct device *dev, int pasid)
 	if (!iommu || !iommu->pasid_table)
 		goto out;
 
-	svm = idr_find(&iommu->pasid_idr, pasid);
+	svm = intel_pasid_lookup_id(pasid);
 	if (!svm)
 		goto out;
 
@@ -618,7 +618,7 @@ static irqreturn_t prq_event_thread(int irq, void *d)
 
 		if (!svm || svm->pasid != req->pasid) {
 			rcu_read_lock();
-			svm = idr_find(&iommu->pasid_idr, req->pasid);
+			svm = intel_pasid_lookup_id(req->pasid);
 			/* It *can't* go away, because the driver is not permitted
 			 * to unbind the mm while any page faults are outstanding.
 			 * So we only need RCU to protect the internal idr code. */
diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
index 795717e..6b5ef6c 100644
--- a/include/linux/intel-iommu.h
+++ b/include/linux/intel-iommu.h
@@ -418,7 +418,6 @@ struct intel_iommu {
 	struct pasid_state_entry *pasid_state_table;
 	struct page_req_dsc *prq;
 	unsigned char prq_name[16];    /* Name for PRQ interrupt */
-	struct idr pasid_idr;
 	u32 pasid_max;
 #endif
 	struct q_inval  *qi;            /* Queued invalidation info */
-- 
2.7.4
