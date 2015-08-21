From: "=?ISO-8859-1?B?TmFuIFhpYW8=?=" <xiaonan19830818-9uewiaClKEY@public.gmane.org>
Subject: [PATCH] Fix bug in iommu_context_addr: Always get pointer to lower
	extended-context-table
Date: Fri, 21 Aug 2015 18:32:17 +0800
Message-ID: <tencent_662442777F92AABA3F0927FE@qq.com>
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
To: =?ISO-8859-1?B?ZHdtdzI=?= <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, =?ISO-8859-1?B?am9ybw==?= <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: =?ISO-8859-1?B?aW9tbXU=?= <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, =?ISO-8859-1?B?bGludXgta2VybmVs?= <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi David & Joerg,

In iommu_context_addr() function, we always use lower extended-context-table
even though upper-half of the extended root-entry is present.

Signed-off-by: Nan Xiao <nan-IAhD+5PxXTI3bvoXafbxaA@public.gmane.org>
---
 drivers/iommu/intel-iommu.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 0649b94..4213598 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -759,10 +759,11 @@ static inline struct context_entry *iommu_context_addr(struct intel_iommu *iommu
 		if (devfn >= 0x80) {
 			devfn -= 0x80;
 			entry = &root->hi;
-		}
+		} else
+			entry = &root->lo;
 		devfn *= 2;
-	}
-	entry = &root->lo;
+	} else
+		entry = &root->lo;
 	if (*entry & 1)
 		context = phys_to_virt(*entry & VTD_PAGE_MASK);
 	else {
-- 
2.4.3

Best Regards
Nan Xiao
