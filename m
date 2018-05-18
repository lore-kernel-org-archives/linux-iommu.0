From: Gary R Hook <gary.hook-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH] iommu/amd - Optimize PPR log handling
Date: Fri, 18 May 2018 16:51:56 -0500
Message-ID: <152668031618.108078.8188026193559324640.stgit@wsp141332wss.amd.com>
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
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Improve the performance of the PPR log polling function (i.e. the
task of emptying the log) by minimizing MMIO operations and more
efficiently processing groups of log entries. Cache the head
pointer, as there's never a reason to read it. Ensure the head
pointer register is updated every so often, to inform the IOMMU
that space is available in the log.

Finally, since a single pass may leave logged events unread, use
an outer loop to repeat until head has caught up to tail.

Signed-off-by: Gary R Hook <gary.hook-5C7GfCeVMHo@public.gmane.org>
---
 drivers/iommu/amd_iommu.c       |   69 +++++++++++++++++++++------------------
 drivers/iommu/amd_iommu_init.c  |    1 +
 drivers/iommu/amd_iommu_types.h |    1 +
 3 files changed, 39 insertions(+), 32 deletions(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index 77c056ae082c..13a550fb7d47 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -660,51 +660,56 @@ static void iommu_handle_ppr_entry(struct amd_iommu *iommu, u64 *raw)
 
 static void iommu_poll_ppr_log(struct amd_iommu *iommu)
 {
-	u32 head, tail;
+	u32 tail;
 
 	if (iommu->ppr_log == NULL)
 		return;
 
-	head = readl(iommu->mmio_base + MMIO_PPR_HEAD_OFFSET);
 	tail = readl(iommu->mmio_base + MMIO_PPR_TAIL_OFFSET);
 
-	while (head != tail) {
-		volatile u64 *raw;
-		u64 entry[2];
-		int i;
+	while (iommu->ppr_log_head != tail) {
+		uint count = PPR_LOG_ENTRIES / 8;
+
+		while (iommu->ppr_log_head != tail && count--) {
+			volatile u64 *raw;
+			u64 entry[2];
+			int i;
+
+			raw = (u64 *)(iommu->ppr_log + iommu->ppr_log_head);
+
+			/*
+			 * Hardware bug: Interrupt may arrive before the
+			 * entry is written to memory. If this happens we
+			 * need to wait for the entry to arrive.
+			 */
+			for (i = 0; i < LOOP_TIMEOUT; ++i) {
+				if (PPR_REQ_TYPE(raw[0]) != 0)
+					break;
+				udelay(1);
+			}
 
-		raw = (u64 *)(iommu->ppr_log + head);
+			/* Avoid memcpy function-call overhead */
+			entry[0] = raw[0];
+			entry[1] = raw[1];
 
-		/*
-		 * Hardware bug: Interrupt may arrive before the entry is
-		 * written to memory. If this happens we need to wait for the
-		 * entry to arrive.
-		 */
-		for (i = 0; i < LOOP_TIMEOUT; ++i) {
-			if (PPR_REQ_TYPE(raw[0]) != 0)
-				break;
-			udelay(1);
-		}
+			/*
+			 * To detect the hardware bug we need to clear the
+			 * entry back to zero.
+			 */
+			raw[0] = raw[1] = 0UL;
 
-		/* Avoid memcpy function-call overhead */
-		entry[0] = raw[0];
-		entry[1] = raw[1];
+			/* Handle PPR entry */
+			iommu_handle_ppr_entry(iommu, entry);
 
-		/*
-		 * To detect the hardware bug we need to clear the entry
-		 * back to zero.
-		 */
-		raw[0] = raw[1] = 0UL;
+			iommu->ppr_log_head += PPR_ENTRY_SIZE;
+			iommu->ppr_log_head %= PPR_LOG_SIZE;
+		}
 
 		/* Update head pointer of hardware ring-buffer */
-		head = (head + PPR_ENTRY_SIZE) % PPR_LOG_SIZE;
-		writel(head, iommu->mmio_base + MMIO_PPR_HEAD_OFFSET);
-
-		/* Handle PPR entry */
-		iommu_handle_ppr_entry(iommu, entry);
+		writel(iommu->ppr_log_head,
+		       iommu->mmio_base + MMIO_PPR_HEAD_OFFSET);
 
-		/* Refresh ring-buffer information */
-		head = readl(iommu->mmio_base + MMIO_PPR_HEAD_OFFSET);
+		/* Get the current value of tail */
 		tail = readl(iommu->mmio_base + MMIO_PPR_TAIL_OFFSET);
 	}
 }
diff --git a/drivers/iommu/amd_iommu_init.c b/drivers/iommu/amd_iommu_init.c
index 904c575d1677..227a9887feb1 100644
--- a/drivers/iommu/amd_iommu_init.c
+++ b/drivers/iommu/amd_iommu_init.c
@@ -721,6 +721,7 @@ static void iommu_enable_ppr_log(struct amd_iommu *iommu)
 	/* set head and tail to zero manually */
 	writel(0x00, iommu->mmio_base + MMIO_PPR_HEAD_OFFSET);
 	writel(0x00, iommu->mmio_base + MMIO_PPR_TAIL_OFFSET);
+	iommu->ppr_log_head = 0;
 
 	iommu_feature_enable(iommu, CONTROL_PPFLOG_EN);
 	iommu_feature_enable(iommu, CONTROL_PPR_EN);
diff --git a/drivers/iommu/amd_iommu_types.h b/drivers/iommu/amd_iommu_types.h
index 986cbe0cc189..31afcc54434c 100644
--- a/drivers/iommu/amd_iommu_types.h
+++ b/drivers/iommu/amd_iommu_types.h
@@ -548,6 +548,7 @@ struct amd_iommu {
 
 	/* Base of the PPR log, if present */
 	u8 *ppr_log;
+	u32 ppr_log_head;
 
 	/* Base of the GA log, if present */
 	u8 *ga_log;
