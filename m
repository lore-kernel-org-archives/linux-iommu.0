From: "Li, Zhen-Hua" <zhen-hual-VXdhtT5mjnY@public.gmane.org>
Subject: [PATCH 1/1] x86/iommu: fix incorrect bit operations in setting values
Date: Wed,  5 Nov 2014 15:30:19 +0800
Message-ID: <1415172619-4801-1-git-send-email-zhen-hual@hp.com>
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
To: joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org
Cc: "Li, Zhen-Hua" <zhen-hual-VXdhtT5mjnY@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

The function context_set_address_root() and set_root_value are setting new
address in a wrong way, and this patch is trying to fix this problem.

According to Intel Vt-d specs(Feb 2011, Revision 1.3), Chapter 9.1 and 9.2,
field ctp in root entry is using bits 12:63, field asr in context entry is
using bits 12:63.

To set these fields, the following functions are used:
static inline void context_set_address_root(struct context_entry *context,
        unsigned long value);
and
static inline void set_root_value(struct root_entry *root, unsigned long value)

But they are using an invalid method to set these fields, in current code, only
a '|' operator is used to set it. This will not set the asr to the expected
value if it has an old value.

For example:
Before calling this function,
	context->lo = 0x3456789012111;
	value = 0x123456789abcef12;

After we call context_set_address_root(context, value), expected result is
	context->lo == 0x123456789abce111;

But the actual result is:
	context->lo == 0x1237577f9bbde111;

So we need to clear bits 12:63 before setting the new value, this will fix
this problem.

Signed-off-by: Li, Zhen-Hua <zhen-hual-VXdhtT5mjnY@public.gmane.org>
---
 drivers/iommu/intel-iommu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index a27d6cb..11ac47b 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -195,6 +195,7 @@ static inline void set_root_present(struct root_entry *root)
 }
 static inline void set_root_value(struct root_entry *root, unsigned long value)
 {
+	root->val &= ~VTD_PAGE_MASK;
 	root->val |= value & VTD_PAGE_MASK;
 }
 
@@ -247,6 +248,7 @@ static inline void context_set_translation_type(struct context_entry *context,
 static inline void context_set_address_root(struct context_entry *context,
 					    unsigned long value)
 {
+	context->lo &= ~VTD_PAGE_MASK;
 	context->lo |= value & VTD_PAGE_MASK;
 }
 
-- 
2.0.0-rc0
