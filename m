From: Shaohua Li <shli-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: [PATCH] iommu/vt-d: correctly disable Intel IOMMU force on
Date: Thu,  8 Jun 2017 11:27:14 -0700
Message-ID: <f6ee9a01b055762f447159cf40e4c6a4305b4eb4.1496945969.git.shli@fb.com>
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
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: Kernel-team-b10kYP2dOMg@public.gmane.org, jroedel-l3A5Bk7waGM@public.gmane.org, Shaohua Li <shli-b10kYP2dOMg@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

From: Shaohua Li <shli-b10kYP2dOMg@public.gmane.org>

I made a mistake in commit bfd20f1. We should skip the force on with the
option enabled instead of vice versa. Not sure why this passed our
performance test, sorry.

Fix: bfd20f1(x86, iommu/vt-d: Add an option to disable Intel IOMMU force on)
Signed-off-by: Shaohua Li <shli-b10kYP2dOMg@public.gmane.org>
---
 arch/x86/kernel/tboot.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/tboot.c b/arch/x86/kernel/tboot.c
index 4b17240..a4eb279 100644
--- a/arch/x86/kernel/tboot.c
+++ b/arch/x86/kernel/tboot.c
@@ -514,7 +514,7 @@ int tboot_force_iommu(void)
 	if (!tboot_enabled())
 		return 0;
 
-	if (!intel_iommu_tboot_noforce)
+	if (intel_iommu_tboot_noforce)
 		return 1;
 
 	if (no_iommu || swiotlb || dmar_disabled)
-- 
2.9.3
