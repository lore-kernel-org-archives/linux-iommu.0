From: Joerg Roedel <joerg.roedel-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 09/28] iommu/amd: Move unmap_flush message to
	amd_iommu_init_dma_ops()
Date: Thu, 5 Jul 2012 14:36:29 +0200
Message-ID: <1341491808-23083-10-git-send-email-joerg.roedel@amd.com>
References: <1341491808-23083-1-git-send-email-joerg.roedel@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1341491808-23083-1-git-send-email-joerg.roedel-5C7GfCeVMHo@public.gmane.org>
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
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

The message belongs there anyway, so move it to that
function.

Signed-off-by: Joerg Roedel <joerg.roedel-5C7GfCeVMHo@public.gmane.org>
---
 drivers/iommu/amd_iommu.c      |    5 +++++
 drivers/iommu/amd_iommu_init.c |    8 --------
 2 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index cfa01c4..569800f 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -2962,6 +2962,11 @@ int __init amd_iommu_init_dma_ops(void)
 
 	amd_iommu_stats_init();
 
+	if (amd_iommu_unmap_flush)
+		pr_info("AMD-Vi: IO/TLB flush on unmap enabled\n");
+	else
+		pr_info("AMD-Vi: Lazy IO/TLB flushing enabled\n");
+
 	return 0;
 
 free_domains:
diff --git a/drivers/iommu/amd_iommu_init.c b/drivers/iommu/amd_iommu_init.c
index 2324f9b..ab3bc19 100644
--- a/drivers/iommu/amd_iommu_init.c
+++ b/drivers/iommu/amd_iommu_init.c
@@ -1706,14 +1706,6 @@ static int __init amd_iommu_init(void)
 
 	amd_iommu_init_api();
 
-	if (iommu_pass_through)
-		goto out;
-
-	if (amd_iommu_unmap_flush)
-		printk(KERN_INFO "AMD-Vi: IO/TLB flush on unmap enabled\n");
-	else
-		printk(KERN_INFO "AMD-Vi: Lazy IO/TLB flushing enabled\n");
-
 out:
 	return ret;
 
-- 
1.7.9.5
