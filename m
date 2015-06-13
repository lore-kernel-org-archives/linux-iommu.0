From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 06/19] iommu/vt-d: Do not re-use domain-ids from the old kernel
Date: Sat, 13 Jun 2015 08:47:14 +0200
Message-ID: <1434178047-17809-7-git-send-email-joro@8bytes.org>
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

Mark all domain-ids we find as reserved, so that there could
be no collision between domains from the previous kernel and
our domains in the IOMMU TLB.

Signed-off-by: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
---
 drivers/iommu/intel-iommu.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index a755f94..1d56696 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -273,6 +273,11 @@ static inline void context_set_domain_id(struct context_entry *context,
 	context->hi |= (value & ((1 << 16) - 1)) << 8;
 }
 
+static inline int context_domain_id(struct context_entry *c)
+{
+	return((c->hi >> 8) & 0xffff);
+}
+
 static inline void context_clear_entry(struct context_entry *context)
 {
 	context->lo = 0;
@@ -2782,7 +2787,7 @@ static int copy_context_table(struct intel_iommu *iommu,
 			      int bus, bool ext)
 {
 	struct context_entry *old_ce = NULL, *new_ce = NULL, ce;
-	int tbl_idx, pos = 0, idx, devfn, ret = 0;
+	int tbl_idx, pos = 0, idx, devfn, ret = 0, did;
 	phys_addr_t old_ce_phys;
 
 	tbl_idx = ext ? bus * 2 : bus;
@@ -2837,6 +2842,10 @@ static int copy_context_table(struct intel_iommu *iommu,
 		if (!context_present(&ce))
 			continue;
 
+		did = context_domain_id(&ce);
+		if (did >= 0 && did < cap_ndoms(iommu->cap))
+			set_bit(did, iommu->domain_ids);
+
 		new_ce[idx] = ce;
 	}
 
-- 
1.9.1
