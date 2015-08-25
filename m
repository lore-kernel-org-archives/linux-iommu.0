From: "joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org" <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] Fix bug in iommu_context_addr: Always get pointer to
	lower extended-context-table
Date: Tue, 25 Aug 2015 10:59:37 +0200
Message-ID: <20150825085937.GD32055@8bytes.org>
References: <F9D82F0D71C0024FA18FE771EDDAF149081FAC8F@G4W3303.americas.hpqcorp.net>
	<20150825084208.GB32055@8bytes.org>
	<F9D82F0D71C0024FA18FE771EDDAF149082020ED@G4W3298.americas.hpqcorp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <F9D82F0D71C0024FA18FE771EDDAF149082020ED-aJCdeS5/g6oSZAcGdq5asR6epYMZPwEe5NbjCUgZEJk@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: "Xiao, Nan (Nan@HPservers-Core-OE-PSC)" <nan.xiao-VXdhtT5mjnY@public.gmane.org>
Cc: "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org" <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Tue, Aug 25, 2015 at 08:46:27AM +0000, Xiao, Nan (Nan@HPservers-Core-OE-PSC) wrote:
> Yes, your patch is simple and better!

Okay, I queued this patch to my x86/vt-d branch:

>From 03932776424a799c3f065a69e98076a78530288b Mon Sep 17 00:00:00 2001
From: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
Date: Tue, 25 Aug 2015 10:54:28 +0200
Subject: [PATCH] iommu/vt-d: Really use upper context table when necessary

There is a bug in iommu_context_addr() which will always use
the lower context table, event when the upper context table
needs to be used. Fix this issue.

Fixes: 03ecc32c5274 ("iommu/vt-d: support extended root and context entries")
Reported-by: Xiao, Nan <nan.xiao-VXdhtT5mjnY@public.gmane.org>
Signed-off-by: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
---
 drivers/iommu/intel-iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index a85077d..63daf1b 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -803,6 +803,7 @@ static inline struct context_entry *iommu_context_addr(struct intel_iommu *iommu
 	struct context_entry *context;
 	u64 *entry;
 
+	entry = &root->lo;
 	if (ecs_enabled(iommu)) {
 		if (devfn >= 0x80) {
 			devfn -= 0x80;
@@ -810,7 +811,6 @@ static inline struct context_entry *iommu_context_addr(struct intel_iommu *iommu
 		}
 		devfn *= 2;
 	}
-	entry = &root->lo;
 	if (*entry & 1)
 		context = phys_to_virt(*entry & VTD_PAGE_MASK);
 	else {
-- 
1.8.4.5
