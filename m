From: "Li, Zhen-Hua" <zhen-hual-VXdhtT5mjnY@public.gmane.org>
Subject: [PATCH 1/1] x86/iommu: use bit structures for context_entry
Date: Fri, 10 Jan 2014 16:27:55 +0800
Message-ID: <1389342475-8540-1-git-send-email-zhen-hual@hp.com>
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
To: David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: "Li, Zhen-Hua" <zhen-hual-VXdhtT5mjnY@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

There is a structure named context_entry used by intel iommu, and there
are some bit operations on it. Use bit structure may make these operations
easy.
Also the function context_set_address_root may cause problem because it uses
 |= operation, not set the new value. And this patch can fix it.

Signed-off-by: Li, Zhen-Hua <zhen-hual-VXdhtT5mjnY@public.gmane.org>
---
 drivers/iommu/intel-iommu.c | 37 +++++++++++++++++++++++++++----------
 1 file changed, 27 insertions(+), 10 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 43b9bfe..65cd480 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -221,47 +221,64 @@ get_context_addr_from_root(struct root_entry *root)
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
 
 static inline bool context_present(struct context_entry *context)
 {
-	return (context->lo & 1);
+	return context->present;
 }
 static inline void context_set_present(struct context_entry *context)
 {
-	context->lo |= 1;
+	context->present = 1;
 }
 
 static inline void context_set_fault_enable(struct context_entry *context)
 {
-	context->lo &= (((u64)-1) << 2) | 1;
+	context->fpd = 1;
 }
 
 static inline void context_set_translation_type(struct context_entry *context,
 						unsigned long value)
 {
-	context->lo &= (((u64)-1) << 4) | 3;
-	context->lo |= (value & 3) << 2;
+	context->translation_type = value;
 }
 
 static inline void context_set_address_root(struct context_entry *context,
 					    unsigned long value)
 {
-	context->lo |= value & VTD_PAGE_MASK;
+	context->asr = value >> VTD_PAGE_SHIFT;
 }
 
 static inline void context_set_address_width(struct context_entry *context,
 					     unsigned long value)
 {
-	context->hi |= value & 7;
+	context->aw  = value;
 }
 
 static inline void context_set_domain_id(struct context_entry *context,
 					 unsigned long value)
 {
-	context->hi |= (value & ((1 << 16) - 1)) << 8;
+	context->did = value;
 }
 
 static inline void context_clear_entry(struct context_entry *context)
-- 
1.8.4.3
