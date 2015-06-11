From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 2/4] iommu/vt-d: Don't consider copied context entries as
	present
Date: Thu, 11 Jun 2015 15:47:41 +0200
Message-ID: <1434030463-942-3-git-send-email-joro@8bytes.org>
References: <1434030463-942-1-git-send-email-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1434030463-942-1-git-send-email-joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>, zhen-hual-VXdhtT5mjnY@public.gmane.org, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

From: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>

Hide the copied context entries from the IOMMU driver by
considering them as non-present. This is implemented by
setting the first AVL bit (bit 67) in the context entry to
one. If this bit is set, the context_present() function
returns false.

Signed-off-by: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
---
 drivers/iommu/intel-iommu.c | 24 ++++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index b0fd5f2..f50d065 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -234,11 +234,21 @@ struct context_entry {
 	u64 hi;
 };
 
-static inline bool context_present(struct context_entry *context)
+static inline bool __context_present(struct context_entry *context)
 {
 	return (context->lo & 1);
 }
 
+static inline bool context_copied(struct context_entry *context)
+{
+	return (((context->hi >> 3) & 0xfULL) == 1);
+}
+
+static inline bool context_present(struct context_entry *context)
+{
+	return __context_present(context) && !context_copied(context);
+}
+
 static inline int context_fault_enable(struct context_entry *c)
 {
 	return((c->lo >> 1) & 0x1);
@@ -269,6 +279,11 @@ static inline void context_set_present(struct context_entry *context)
 	context->lo |= 1;
 }
 
+static inline void context_set_copied(struct context_entry *context)
+{
+	context->hi |= 1ULL << 3;
+}
+
 static inline void context_set_fault_enable(struct context_entry *context)
 {
 	context->lo &= (((u64)-1) << 2) | 1;
@@ -1919,6 +1934,9 @@ static int domain_context_mapping_one(struct dmar_domain *domain,
 		}
 	}
 
+	/* First clear any left-overs, like a copied context entry */
+	context_clear_entry(context);
+
 	context_set_domain_id(context, id);
 
 	if (translation != CONTEXT_TT_PASS_THROUGH) {
@@ -4911,13 +4929,15 @@ static int copy_one_context_table(struct intel_iommu *iommu,
 		memcpy_fromio(&ce, &ctxt_tbl_old[devfn],
 			      sizeof(struct context_entry));
 
-		if (!context_present(&ce))
+		if (!__context_present(&ce))
 			continue;
 
 		did = context_domain_id(&ce);
 		if (did >=0 && did < cap_ndoms(iommu->cap))
 			set_bit(did, iommu->domain_ids);
 
+		context_set_copied(&ce);
+
 		ctxt_tbl[devfn] = ce;
 	}
 
-- 
1.9.1
