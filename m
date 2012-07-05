From: Joerg Roedel <joerg.roedel-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 08/28] iommu/amd: Split enable_iommus() routine
Date: Thu, 5 Jul 2012 14:36:28 +0200
Message-ID: <1341491808-23083-9-git-send-email-joerg.roedel@amd.com>
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

Split the enable_iommus() routine so that a part of it can
run in early code.

Signed-off-by: Joerg Roedel <joerg.roedel-5C7GfCeVMHo@public.gmane.org>
---
 drivers/iommu/amd_iommu_init.c |   26 +++++++++++++++++++++-----
 1 file changed, 21 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/amd_iommu_init.c b/drivers/iommu/amd_iommu_init.c
index 1b23235..2324f9b 100644
--- a/drivers/iommu/amd_iommu_init.c
+++ b/drivers/iommu/amd_iommu_init.c
@@ -1382,7 +1382,7 @@ static void iommu_apply_resume_quirks(struct amd_iommu *iommu)
  * This function finally enables all IOMMUs found in the system after
  * they have been initialized
  */
-static void enable_iommus(void)
+static void early_enable_iommus(void)
 {
 	struct amd_iommu *iommu;
 
@@ -1392,12 +1392,30 @@ static void enable_iommus(void)
 		iommu_set_device_table(iommu);
 		iommu_enable_command_buffer(iommu);
 		iommu_enable_event_buffer(iommu);
-		iommu_enable_ppr_log(iommu);
-		iommu_enable_gt(iommu);
 		iommu_set_exclusion_range(iommu);
 		iommu_enable(iommu);
 		iommu_flush_all_caches(iommu);
 	}
+
+	x86_platform.iommu_shutdown = disable_iommus;
+
+}
+
+static void enable_iommus_v2(void)
+{
+	struct amd_iommu *iommu;
+
+	for_each_iommu(iommu) {
+		iommu_enable_ppr_log(iommu);
+		iommu_enable_gt(iommu);
+	}
+}
+
+static void enable_iommus(void)
+{
+	early_enable_iommus();
+
+	enable_iommus_v2();
 }
 
 static void disable_iommus(void)
@@ -1696,8 +1714,6 @@ static int __init amd_iommu_init(void)
 	else
 		printk(KERN_INFO "AMD-Vi: Lazy IO/TLB flushing enabled\n");
 
-	x86_platform.iommu_shutdown = disable_iommus;
-
 out:
 	return ret;
 
-- 
1.7.9.5
