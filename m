From: Filippo Sironi via iommu <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Subject: [PATCH v2] iommu/vt-d: Don't be too aggressive when clearing one
	context entry
Date: Thu, 31 Aug 2017 10:58:11 +0200
Message-ID: <1504169891-9480-1-git-send-email-sironi@amazon.de>
References: <1503929789-26698-1-git-send-email-sironi@amazon.de>
Reply-To: Filippo Sironi <sironi-ebkRAfMGSJGzQB+pC5nmwQ@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1503929789-26698-1-git-send-email-sironi-ebkRAfMGSJGzQB+pC5nmwQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Filippo Sironi <sironi-ebkRAfMGSJGzQB+pC5nmwQ@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, David Woodhouse <dwmw-vV1OtcyAfmbQXOPxS62xeg@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Previously, we were invalidating context cache and IOTLB globally when
clearing one context entry.  This is a tad too aggressive.
Invalidate the context cache and IOTLB for the interested device only.

Signed-off-by: Filippo Sironi <sironi-ebkRAfMGSJGzQB+pC5nmwQ@public.gmane.org>
Cc: David Woodhouse <dwmw-vV1OtcyAfmbQXOPxS62xeg@public.gmane.org>
Cc: David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Cc: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: Jacob Pan <jacob.jun.pan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
---
 drivers/iommu/intel-iommu.c | 42 ++++++++++++++++++++++++------------------
 1 file changed, 24 insertions(+), 18 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 3e8636f1220e..1aa4ad7974b9 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -974,20 +974,6 @@ static int device_context_mapped(struct intel_iommu *iommu, u8 bus, u8 devfn)
 	return ret;
 }
 
-static void clear_context_table(struct intel_iommu *iommu, u8 bus, u8 devfn)
-{
-	struct context_entry *context;
-	unsigned long flags;
-
-	spin_lock_irqsave(&iommu->lock, flags);
-	context = iommu_context_addr(iommu, bus, devfn, 0);
-	if (context) {
-		context_clear_entry(context);
-		__iommu_flush_cache(iommu, context, sizeof(*context));
-	}
-	spin_unlock_irqrestore(&iommu->lock, flags);
-}
-
 static void free_context_table(struct intel_iommu *iommu)
 {
 	int i;
@@ -2351,13 +2337,33 @@ static inline int domain_pfn_mapping(struct dmar_domain *domain, unsigned long i
 
 static void domain_context_clear_one(struct intel_iommu *iommu, u8 bus, u8 devfn)
 {
+	unsigned long flags;
+	struct context_entry *context;
+	u16 did_old;
+
 	if (!iommu)
 		return;
 
-	clear_context_table(iommu, bus, devfn);
-	iommu->flush.flush_context(iommu, 0, 0, 0,
-					   DMA_CCMD_GLOBAL_INVL);
-	iommu->flush.flush_iotlb(iommu, 0, 0, 0, DMA_TLB_GLOBAL_FLUSH);
+	spin_lock_irqsave(&iommu->lock, flags);
+	context = iommu_context_addr(iommu, bus, devfn, 0);
+	if (!context) {
+		spin_unlock_irqrestore(&iommu->lock, flags);
+		return;
+	}
+	did_old = context_domain_id(context);
+	context_clear_entry(context);
+	__iommu_flush_cache(iommu, context, sizeof(*context));
+	spin_unlock_irqrestore(&iommu->lock, flags);
+	iommu->flush.flush_context(iommu,
+				   did_old,
+				   (((u16)bus) << 8) | devfn,
+				   DMA_CCMD_MASK_NOBIT,
+				   DMA_CCMD_DEVICE_INVL);
+	iommu->flush.flush_iotlb(iommu,
+				 did_old,
+				 0,
+				 0,
+				 DMA_TLB_DSI_FLUSH);
 }
 
 static inline void unlink_domain_info(struct device_domain_info *info)
-- 
2.7.4
