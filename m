From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 07/19] iommu/vt-d: Mark copied context entries
Date: Sat, 13 Jun 2015 08:47:15 +0200
Message-ID: <1434178047-17809-8-git-send-email-joro@8bytes.org>
References: <1434178047-17809-1-git-send-email-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1434178047-17809-1-git-send-email-joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
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
Cc: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, jroedel-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, zhen-hual-VXdhtT5mjnY@public.gmane.org, dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

From: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>

Mark the context entries we copied over from the old kernel,
so that we don't detect them as present in other code paths.
This makes sure we safely overwrite old context entries when
a new domain is assigned.

Signed-off-by: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
---
 drivers/iommu/intel-iommu.c | 53 +++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 51 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 1d56696..1fdff58 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -233,10 +233,38 @@ struct context_entry {
 	u64 hi;
 };
 
-static inline bool context_present(struct context_entry *context)
+static inline void context_clear_pasid_enable(struct context_entry *context)
+{
+	context->lo &= ~(1ULL << 11);
+}
+
+static inline bool context_pasid_enabled(struct context_entry *context)
+{
+	return !!(context->lo & (1ULL << 11));
+}
+
+static inline void context_set_copied(struct context_entry *context)
+{
+	context->hi |= (1ull << 3);
+}
+
+static inline bool context_copied(struct context_entry *context)
+{
+	return !!(context->hi & (1ULL << 3));
+}
+
+static inline bool __context_present(struct context_entry *context)
 {
 	return (context->lo & 1);
 }
+
+static inline bool context_present(struct context_entry *context)
+{
+	return context_pasid_enabled(context) ?
+	     __context_present(context) :
+	     __context_present(context) && !context_copied(context);
+}
+
 static inline void context_set_present(struct context_entry *context)
 {
 	context->lo |= 1;
@@ -1841,6 +1869,8 @@ static int domain_context_mapping_one(struct dmar_domain *domain,
 		return 0;
 	}
 
+	context_clear_entry(context);
+
 	id = domain->id;
 	pgd = domain->pgd;
 
@@ -2839,13 +2869,32 @@ static int copy_context_table(struct intel_iommu *iommu,
 		/* Now copy the context entry */
 		ce = old_ce[idx];
 
-		if (!context_present(&ce))
+		if (!__context_present(&ce))
 			continue;
 
 		did = context_domain_id(&ce);
 		if (did >= 0 && did < cap_ndoms(iommu->cap))
 			set_bit(did, iommu->domain_ids);
 
+		/*
+		 * We need a marker for copied context entries. This
+		 * marker needs to work for the old format as well as
+		 * for extended context entries.
+		 *
+		 * Bit 67 of the context entry is used. In the old
+		 * format this bit is available to software, in the
+		 * extended format it is the PGE bit, but PGE is ignored
+		 * by HW if PASIDs are disabled (and thus still
+		 * available).
+		 *
+		 * So disable PASIDs first and then mark the entry
+		 * copied. This means that we don't copy PASID
+		 * translations from the old kernel, but this is fine as
+		 * faults there are not fatal.
+		 */
+		context_clear_pasid_enable(&ce);
+		context_set_copied(&ce);
+
 		new_ce[idx] = ce;
 	}
 
-- 
1.9.1
