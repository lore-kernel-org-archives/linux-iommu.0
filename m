From: Joerg Roedel <joerg.roedel-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH] iommu/amd: Don't initialize IOMMUv2 resources when not
	required
Date: Thu, 15 Mar 2012 12:49:21 +0100
Message-ID: <1331812161-5294-1-git-send-email-joerg.roedel@amd.com>
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
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Add a check to the init-path of the AMD IOMMUv2 driver if
the hardware is available in the system. Only allocate all
the resources if it is really available.

Signed-off-by: Joerg Roedel <joerg.roedel-5C7GfCeVMHo@public.gmane.org>
---
 drivers/iommu/amd_iommu_v2.c |   14 +++++++++++++-
 1 files changed, 13 insertions(+), 1 deletions(-)

diff --git a/drivers/iommu/amd_iommu_v2.c b/drivers/iommu/amd_iommu_v2.c
index 8add9f1..036fe9b 100644
--- a/drivers/iommu/amd_iommu_v2.c
+++ b/drivers/iommu/amd_iommu_v2.c
@@ -921,7 +921,16 @@ static int __init amd_iommu_v2_init(void)
 	size_t state_table_size;
 	int ret;
 
-	pr_info("AMD IOMMUv2 driver by Joerg Roedel <joerg.roedel-5C7GfCeVMHo@public.gmane.org>");
+	pr_info("AMD IOMMUv2 driver by Joerg Roedel <joerg.roedel-5C7GfCeVMHo@public.gmane.org>\n");
+
+	if (!amd_iommu_v2_supported()) {
+		pr_info("AMD IOMMUv2 functionality not available on this sytem\n");
+		/*
+		 * Load anyway to provide the symbols to other modules
+		 * which may use AMD IOMMUv2 optionally.
+		 */
+		return 0;
+	}
 
 	spin_lock_init(&state_lock);
 
@@ -961,6 +970,9 @@ static void __exit amd_iommu_v2_exit(void)
 	size_t state_table_size;
 	int i;
 
+	if (!amd_iommu_v2_supported())
+		return;
+
 	profile_event_unregister(PROFILE_TASK_EXIT, &profile_nb);
 	amd_iommu_unregister_ppr_notifier(&ppr_nb);
 
-- 
1.7.5.4
