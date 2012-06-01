From: Joerg Roedel <joerg.roedel-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 2/2] iommu/amd: Fix deadlock in ppr-handling error path
Date: Fri, 1 Jun 2012 16:05:01 +0200
Message-ID: <1338559501-15478-2-git-send-email-joerg.roedel@amd.com>
References: <1338559501-15478-1-git-send-email-joerg.roedel@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1338559501-15478-1-git-send-email-joerg.roedel-5C7GfCeVMHo@public.gmane.org>
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

In the error path of the ppr_notifer it can happen that the
iommu->lock is taken recursivly. This patch fixes the
problem by releasing the iommu->lock before any notifier is
invoked. This also requires to move the erratum workaround
for the ppr-log (interrupt may be faster than data in the log)
one function up.

Cc: stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org # v3.3, v3.4
Signed-off-by: Joerg Roedel <joerg.roedel-5C7GfCeVMHo@public.gmane.org>
---
 drivers/iommu/amd_iommu.c |   71 ++++++++++++++++++++++++++++-----------------
 1 file changed, 44 insertions(+), 27 deletions(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index d90a421..a2e418c 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -547,26 +547,12 @@ static void iommu_poll_events(struct amd_iommu *iommu)
 	spin_unlock_irqrestore(&iommu->lock, flags);
 }
 
-static void iommu_handle_ppr_entry(struct amd_iommu *iommu, u32 head)
+static void iommu_handle_ppr_entry(struct amd_iommu *iommu, u64 *raw)
 {
 	struct amd_iommu_fault fault;
-	volatile u64 *raw;
-	int i;
 
 	INC_STATS_COUNTER(pri_requests);
 
-	raw = (u64 *)(iommu->ppr_log + head);
-
-	/*
-	 * Hardware bug: Interrupt may arrive before the entry is written to
-	 * memory. If this happens we need to wait for the entry to arrive.
-	 */
-	for (i = 0; i < LOOP_TIMEOUT; ++i) {
-		if (PPR_REQ_TYPE(raw[0]) != 0)
-			break;
-		udelay(1);
-	}
-
 	if (PPR_REQ_TYPE(raw[0]) != PPR_REQ_FAULT) {
 		pr_err_ratelimited("AMD-Vi: Unknown PPR request received\n");
 		return;
@@ -578,12 +564,6 @@ static void iommu_handle_ppr_entry(struct amd_iommu *iommu, u32 head)
 	fault.tag       = PPR_TAG(raw[0]);
 	fault.flags     = PPR_FLAGS(raw[0]);
 
-	/*
-	 * To detect the hardware bug we need to clear the entry
-	 * to back to zero.
-	 */
-	raw[0] = raw[1] = 0;
-
 	atomic_notifier_call_chain(&ppr_notifier, 0, &fault);
 }
 
@@ -595,25 +575,62 @@ static void iommu_poll_ppr_log(struct amd_iommu *iommu)
 	if (iommu->ppr_log == NULL)
 		return;
 
+	/* enable ppr interrupts again */
+	writel(MMIO_STATUS_PPR_INT_MASK, iommu->mmio_base + MMIO_STATUS_OFFSET);
+
 	spin_lock_irqsave(&iommu->lock, flags);
 
 	head = readl(iommu->mmio_base + MMIO_PPR_HEAD_OFFSET);
 	tail = readl(iommu->mmio_base + MMIO_PPR_TAIL_OFFSET);
 
 	while (head != tail) {
+		volatile u64 *raw;
+		u64 entry[2];
+		int i;
 
-		/* Handle PPR entry */
-		iommu_handle_ppr_entry(iommu, head);
+		raw = (u64 *)(iommu->ppr_log + head);
+
+		/*
+		 * Hardware bug: Interrupt may arrive before the entry is
+		 * written to memory. If this happens we need to wait for the
+		 * entry to arrive.
+		 */
+		for (i = 0; i < LOOP_TIMEOUT; ++i) {
+			if (PPR_REQ_TYPE(raw[0]) != 0)
+				break;
+			udelay(1);
+		}
+
+		/* Avoid memcpy function-call overhead */
+		entry[0] = raw[0];
+		entry[1] = raw[1];
 
-		/* Update and refresh ring-buffer state*/
+		/*
+		 * To detect the hardware bug we need to clear the entry
+		 * back to zero.
+		 */
+		raw[0] = raw[1] = 0UL;
+
+		/* Update head pointer of hardware ring-buffer */
 		head = (head + PPR_ENTRY_SIZE) % PPR_LOG_SIZE;
 		writel(head, iommu->mmio_base + MMIO_PPR_HEAD_OFFSET);
+
+		/*
+		 * Release iommu->lock because ppr-handling might need to
+		 * re-aquire it
+		 */
+		spin_unlock_irqrestore(&iommu->lock, flags);
+
+		/* Handle PPR entry */
+		iommu_handle_ppr_entry(iommu, entry);
+
+		spin_lock_irqsave(&iommu->lock, flags);
+
+		/* Refresh ring-buffer information */
+		head = readl(iommu->mmio_base + MMIO_PPR_HEAD_OFFSET);
 		tail = readl(iommu->mmio_base + MMIO_PPR_TAIL_OFFSET);
 	}
 
-	/* enable ppr interrupts again */
-	writel(MMIO_STATUS_PPR_INT_MASK, iommu->mmio_base + MMIO_STATUS_OFFSET);
-
 	spin_unlock_irqrestore(&iommu->lock, flags);
 }
 
-- 
1.7.9.5
