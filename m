From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 09/12] iommu/amd: Cleanup buffer allocation
Date: Tue, 20 Oct 2015 17:33:42 +0200
Message-ID: <1445355225-17557-10-git-send-email-joro@8bytes.org>
References: <1445355225-17557-1-git-send-email-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1445355225-17557-1-git-send-email-joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
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
Cc: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

From: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>

Clean up the functions to allocate the command, event and
ppr-log buffers. Remove redundant code and change the return
value to int.

Signed-off-by: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
---
 drivers/iommu/amd_iommu_init.c | 46 +++++++++++++++---------------------------
 1 file changed, 16 insertions(+), 30 deletions(-)

diff --git a/drivers/iommu/amd_iommu_init.c b/drivers/iommu/amd_iommu_init.c
index 930a5d4..2f7fb1e 100644
--- a/drivers/iommu/amd_iommu_init.c
+++ b/drivers/iommu/amd_iommu_init.c
@@ -513,15 +513,12 @@ static int __init find_last_devid_acpi(struct acpi_table_header *table)
  * write commands to that buffer later and the IOMMU will execute them
  * asynchronously
  */
-static u8 * __init alloc_command_buffer(struct amd_iommu *iommu)
+static int __init alloc_command_buffer(struct amd_iommu *iommu)
 {
-	u8 *cmd_buf = (u8 *)__get_free_pages(GFP_KERNEL | __GFP_ZERO,
-			get_order(CMD_BUFFER_SIZE));
+	iommu->cmd_buf = (void *)__get_free_pages(GFP_KERNEL | __GFP_ZERO,
+						  get_order(CMD_BUFFER_SIZE));
 
-	if (cmd_buf == NULL)
-		return NULL;
-
-	return cmd_buf;
+	return iommu->cmd_buf ? 0 : -ENOMEM;
 }
 
 /*
@@ -563,15 +560,12 @@ static void __init free_command_buffer(struct amd_iommu *iommu)
 }
 
 /* allocates the memory where the IOMMU will log its events to */
-static u8 * __init alloc_event_buffer(struct amd_iommu *iommu)
+static int __init alloc_event_buffer(struct amd_iommu *iommu)
 {
-	iommu->evt_buf = (u8 *)__get_free_pages(GFP_KERNEL | __GFP_ZERO,
-						get_order(EVT_BUFFER_SIZE));
+	iommu->evt_buf = (void *)__get_free_pages(GFP_KERNEL | __GFP_ZERO,
+						  get_order(EVT_BUFFER_SIZE));
 
-	if (iommu->evt_buf == NULL)
-		return NULL;
-
-	return iommu->evt_buf;
+	return iommu->evt_buf ? 0 : -ENOMEM;
 }
 
 static void iommu_enable_event_buffer(struct amd_iommu *iommu)
@@ -598,15 +592,12 @@ static void __init free_event_buffer(struct amd_iommu *iommu)
 }
 
 /* allocates the memory where the IOMMU will log its events to */
-static u8 * __init alloc_ppr_log(struct amd_iommu *iommu)
+static int __init alloc_ppr_log(struct amd_iommu *iommu)
 {
-	iommu->ppr_log = (u8 *)__get_free_pages(GFP_KERNEL | __GFP_ZERO,
-						get_order(PPR_LOG_SIZE));
+	iommu->ppr_log = (void *)__get_free_pages(GFP_KERNEL | __GFP_ZERO,
+						  get_order(PPR_LOG_SIZE));
 
-	if (iommu->ppr_log == NULL)
-		return NULL;
-
-	return iommu->ppr_log;
+	return iommu->ppr_log ? 0 : -ENOMEM;
 }
 
 static void iommu_enable_ppr_log(struct amd_iommu *iommu)
@@ -1105,12 +1096,10 @@ static int __init init_iommu_one(struct amd_iommu *iommu, struct ivhd_header *h)
 	if (!iommu->mmio_base)
 		return -ENOMEM;
 
-	iommu->cmd_buf = alloc_command_buffer(iommu);
-	if (!iommu->cmd_buf)
+	if (alloc_command_buffer(iommu))
 		return -ENOMEM;
 
-	iommu->evt_buf = alloc_event_buffer(iommu);
-	if (!iommu->evt_buf)
+	if (alloc_event_buffer(iommu))
 		return -ENOMEM;
 
 	iommu->int_enabled = false;
@@ -1302,11 +1291,8 @@ static int iommu_init_pci(struct amd_iommu *iommu)
 		amd_iommu_v2_present = true;
 	}
 
-	if (iommu_feature(iommu, FEATURE_PPR)) {
-		iommu->ppr_log = alloc_ppr_log(iommu);
-		if (!iommu->ppr_log)
-			return -ENOMEM;
-	}
+	if (iommu_feature(iommu, FEATURE_PPR) && alloc_ppr_log(iommu))
+		return -ENOMEM;
 
 	if (iommu->cap & (1UL << IOMMU_CAP_NPCACHE))
 		amd_iommu_np_cache = true;
-- 
1.9.1
