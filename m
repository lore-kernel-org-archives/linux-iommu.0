From: Kevin Mitchell via iommu <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Subject: [PATCH 3/3] iommu/amd: only free resources once on init error
Date: Thu, 18 Apr 2019 10:57:49 -0700
Message-ID: <20190418175744.6229-4-kevmitch@arista.com>
References: <20190418175744.6229-1-kevmitch@arista.com>
Reply-To: Kevin Mitchell <kevmitch-nzgTgzXrdUbQT0dZR+AlfA@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20190418175744.6229-1-kevmitch-nzgTgzXrdUbQT0dZR+AlfA@public.gmane.org>
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
List-Id: iommu@lists.linux-foundation.org

When amd_iommu=off was specified on the command line, free_X_resources
functions were called immediately after early_amd_iommu_init. They were
then called again when amd_iommu_init also failed (as expected).

Instead, call them only once: at the end of state_next() whenever
there's an error. These functions should be safe to call any time and
any number of times. However, since state_next is never called again in
an error state, the cleanup will only ever be run once.

This also ensures that cleanup code is run as soon as possible after an
error is detected rather than waiting for amd_iommu_init() to be called.

Signed-off-by: Kevin Mitchell <kevmitch-nzgTgzXrdUbQT0dZR+AlfA@public.gmane.org>
---
 drivers/iommu/amd_iommu_init.c | 27 +++++++++++++--------------
 1 file changed, 13 insertions(+), 14 deletions(-)

diff --git a/drivers/iommu/amd_iommu_init.c b/drivers/iommu/amd_iommu_init.c
index 5f3df5ae6ba8..24fc060fe596 100644
--- a/drivers/iommu/amd_iommu_init.c
+++ b/drivers/iommu/amd_iommu_init.c
@@ -2638,8 +2638,6 @@ static int __init state_next(void)
 		init_state = ret ? IOMMU_INIT_ERROR : IOMMU_ACPI_FINISHED;
 		if (init_state == IOMMU_ACPI_FINISHED && amd_iommu_disabled) {
 			pr_info("AMD IOMMU disabled on kernel command-line\n");
-			free_dma_resources();
-			free_iommu_resources();
 			init_state = IOMMU_CMDLINE_DISABLED;
 			ret = -EINVAL;
 		}
@@ -2680,6 +2678,19 @@ static int __init state_next(void)
 		BUG();
 	}
 
+	if (ret) {
+		free_dma_resources();
+		if (!irq_remapping_enabled) {
+			disable_iommus();
+			free_iommu_resources();
+		} else {
+			struct amd_iommu *iommu;
+
+			uninit_device_table_dma();
+			for_each_iommu(iommu)
+				iommu_flush_all_caches(iommu);
+		}
+	}
 	return ret;
 }
 
@@ -2753,18 +2764,6 @@ static int __init amd_iommu_init(void)
 	int ret;
 
 	ret = iommu_go_to_state(IOMMU_INITIALIZED);
-	if (ret) {
-		free_dma_resources();
-		if (!irq_remapping_enabled) {
-			disable_iommus();
-			free_iommu_resources();
-		} else {
-			uninit_device_table_dma();
-			for_each_iommu(iommu)
-				iommu_flush_all_caches(iommu);
-		}
-	}
-
 #ifdef CONFIG_GART_IOMMU
 	if (ret && list_empty(&amd_iommu_list)) {
 		/*
-- 
2.20.1
