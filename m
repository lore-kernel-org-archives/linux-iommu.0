From: "Li, Zhen-Hua" <zhen-hual-VXdhtT5mjnY@public.gmane.org>
Subject: [PATCH 1/1] x86/iommu: use bit structures for context_entry
Date: Fri, 24 May 2013 08:22:11 +0800
Message-ID: <1369354931-19373-1-git-send-email-zhen-hual@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: "Li, Zhen-Hua" <zhen-hual-VXdhtT5mjnY@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

There is a structure named context_entry used by intel iommu, and there
are some bit operations on it. Use bit structure may make these operations
easy.

Signed-off-by: Li, Zhen-Hua <zhen-hual-VXdhtT5mjnY@public.gmane.org>
---
 drivers/iommu/intel-iommu.c |   88 +++++++++++++++----------------------------
 1 file changed, 31 insertions(+), 57 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index b4f0e28..ae10471 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -221,55 +221,28 @@ get_context_addr_from_root(struct root_entry *root)
  * 8-23: domain id
  */
 struct context_entry {
-	u64 lo;
-	u64 hi;
+	union {
+		struct {
+			u64	present:1,
+				fpd:1,
+				translation_type:2,
+				reserved_l:8,
+				asr:52;
+		};
+		u64 lo;
+	};
+	union {
+		struct {
+			u64	aw:3,
+				avail:4,
+				reserved_h1:1,
+				did:16,
+				reserved_h2:40;
+		};
+		u64 hi;
+	};
 };
 
-static inline bool context_present(struct context_entry *context)
-{
-	return (context->lo & 1);
-}
-static inline void context_set_present(struct context_entry *context)
-{
-	context->lo |= 1;
-}
-
-static inline void context_set_fault_enable(struct context_entry *context)
-{
-	context->lo &= (((u64)-1) << 2) | 1;
-}
-
-static inline void context_set_translation_type(struct context_entry *context,
-						unsigned long value)
-{
-	context->lo &= (((u64)-1) << 4) | 3;
-	context->lo |= (value & 3) << 2;
-}
-
-static inline void context_set_address_root(struct context_entry *context,
-					    unsigned long value)
-{
-	context->lo |= value & VTD_PAGE_MASK;
-}
-
-static inline void context_set_address_width(struct context_entry *context,
-					     unsigned long value)
-{
-	context->hi |= value & 7;
-}
-
-static inline void context_set_domain_id(struct context_entry *context,
-					 unsigned long value)
-{
-	context->hi |= (value & ((1 << 16) - 1)) << 8;
-}
-
-static inline void context_clear_entry(struct context_entry *context)
-{
-	context->lo = 0;
-	context->hi = 0;
-}
-
 /*
  * 0: readable
  * 1: writable
@@ -727,7 +700,7 @@ static int device_context_mapped(struct intel_iommu *iommu, u8 bus, u8 devfn)
 		ret = 0;
 		goto out;
 	}
-	ret = context_present(&context[devfn]);
+	ret = context->present;
 out:
 	spin_unlock_irqrestore(&iommu->lock, flags);
 	return ret;
@@ -743,7 +716,8 @@ static void clear_context_table(struct intel_iommu *iommu, u8 bus, u8 devfn)
 	root = &iommu->root_entry[bus];
 	context = get_context_addr_from_root(root);
 	if (context) {
-		context_clear_entry(&context[devfn]);
+		context[devfn].lo = 0;
+		context[devfn].hi = 0;
 		__iommu_flush_cache(iommu, &context[devfn], \
 			sizeof(*context));
 	}
@@ -1573,7 +1547,7 @@ static int domain_context_mapping_one(struct dmar_domain *domain, int segment,
 	if (!context)
 		return -ENOMEM;
 	spin_lock_irqsave(&iommu->lock, flags);
-	if (context_present(context)) {
+	if (context->present) {
 		spin_unlock_irqrestore(&iommu->lock, flags);
 		return 0;
 	}
@@ -1623,7 +1597,7 @@ static int domain_context_mapping_one(struct dmar_domain *domain, int segment,
 		}
 	}
 
-	context_set_domain_id(context, id);
+	context->did = id;
 
 	if (translation != CONTEXT_TT_PASS_THROUGH) {
 		info = iommu_support_dev_iotlb(domain, segment, bus, devfn);
@@ -1635,15 +1609,15 @@ static int domain_context_mapping_one(struct dmar_domain *domain, int segment,
 	 * AGAW value supported by hardware. And ASR is ignored by hardware.
 	 */
 	if (unlikely(translation == CONTEXT_TT_PASS_THROUGH))
-		context_set_address_width(context, iommu->msagaw);
+		context->aw = iommu->msagaw;
 	else {
-		context_set_address_root(context, virt_to_phys(pgd));
-		context_set_address_width(context, iommu->agaw);
+		context->asr = virt_to_phys(pgd) >> VTD_PAGE_SHIFT;
+		context->aw  = iommu->agaw;
 	}
 
-	context_set_translation_type(context, translation);
-	context_set_fault_enable(context);
-	context_set_present(context);
+	context->translation_type = translation;
+	context->fpd = 0;
+	context->present = 1;
 	domain_flush_cache(domain, context, sizeof(*context));
 
 	/*
-- 
1.7.10.4
