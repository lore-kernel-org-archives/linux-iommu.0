From: <suravee.suthikulpanit-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 1/2 V2] iommu/amd: Add workaround for ERBT1312
Date: Mon, 15 Apr 2013 02:07:46 -0500
Message-ID: <1366009666-44792-1-git-send-email-suravee.suthikulpanit@amd.com>
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
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

From: Suravee Suthikulpanit <suravee.suthikulpanit-5C7GfCeVMHo@public.gmane.org>

The IOMMU interrupt handling in bottom half must clear the PPR log interrupt
and event log interrupt bits to re-enable the interrupt. This is done by
writing 1 to the memory mapped register to clear the bit. Due to hardware bug,
if the driver tries to clear this bit while the IOMMU hardware also setting
this bit, the conflict will result with the bit being set. If the interrupt
handling code does not make sure to clear this bit, subsequent changes in the
event/PPR logs will no longer generating interrupts, and would result if
buffer overflow. After clearing the bits, the driver must read back
the register to verify.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit-5C7GfCeVMHo@public.gmane.org>
---
 drivers/iommu/amd_iommu.c |  145 +++++++++++++++++++++++++++++----------------
 1 file changed, 93 insertions(+), 52 deletions(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index e5db3e5..419af1d 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -803,22 +803,43 @@ retry:
 static void iommu_poll_events(struct amd_iommu *iommu)
 {
 	u32 head, tail;
+	u32 status;
 	unsigned long flags;
 
-	/* enable event interrupts again */
-	writel(MMIO_STATUS_EVT_INT_MASK, iommu->mmio_base + MMIO_STATUS_OFFSET);
-
 	spin_lock_irqsave(&iommu->lock, flags);
 
-	head = readl(iommu->mmio_base + MMIO_EVT_HEAD_OFFSET);
-	tail = readl(iommu->mmio_base + MMIO_EVT_TAIL_OFFSET);
+	status = readl(iommu->mmio_base + MMIO_STATUS_OFFSET);
 
-	while (head != tail) {
-		iommu_handle_event(iommu, iommu->evt_buf + head);
-		head = (head + EVENT_ENTRY_SIZE) % iommu->evt_buf_size;
-	}
+	while (status & MMIO_STATUS_EVT_INT_MASK) {
+
+		/* enable event interrupts again */
+		writel(MMIO_STATUS_EVT_INT_MASK,
+			iommu->mmio_base + MMIO_STATUS_OFFSET);
 
-	writel(head, iommu->mmio_base + MMIO_EVT_HEAD_OFFSET);
+		head = readl(iommu->mmio_base + MMIO_EVT_HEAD_OFFSET);
+		tail = readl(iommu->mmio_base + MMIO_EVT_TAIL_OFFSET);
+
+		while (head != tail) {
+			iommu_handle_event(iommu, iommu->evt_buf + head);
+			head = (head + EVENT_ENTRY_SIZE) % iommu->evt_buf_size;
+		}
+
+		writel(head, iommu->mmio_base + MMIO_EVT_HEAD_OFFSET);
+
+		/*
+		 * Hardware bug: When re-enabling interrupt (by writing 1
+		 * to clear the bit), the hardware might also try to set
+		 * the interrupt bit in the event status register.
+		 * In this scenario, the bit will be set, and disable
+		 * subsequent interrupts.
+		 *
+		 * Workaround: The IOMMU driver should read back the
+		 * status register and check if the interrupt bits are cleared.
+		 * If not, driver will need to go through the interrupt handler
+		 * again and re-clear the bits
+		 */
+		status = readl(iommu->mmio_base + MMIO_STATUS_OFFSET);
+	}
 
 	spin_unlock_irqrestore(&iommu->lock, flags);
 }
@@ -846,65 +867,85 @@ static void iommu_handle_ppr_entry(struct amd_iommu *iommu, u64 *raw)
 static void iommu_poll_ppr_log(struct amd_iommu *iommu)
 {
 	unsigned long flags;
+	u32 status;
 	u32 head, tail;
 
 	if (iommu->ppr_log == NULL)
 		return;
 
-	/* enable ppr interrupts again */
-	writel(MMIO_STATUS_PPR_INT_MASK, iommu->mmio_base + MMIO_STATUS_OFFSET);
-
 	spin_lock_irqsave(&iommu->lock, flags);
 
-	head = readl(iommu->mmio_base + MMIO_PPR_HEAD_OFFSET);
-	tail = readl(iommu->mmio_base + MMIO_PPR_TAIL_OFFSET);
+	status = readl(iommu->mmio_base + MMIO_STATUS_OFFSET);
 
-	while (head != tail) {
-		volatile u64 *raw;
-		u64 entry[2];
-		int i;
+	while (status & MMIO_STATUS_PPR_INT_MASK) {
+		/* enable ppr interrupts again */
+		writel(MMIO_STATUS_PPR_INT_MASK,
+			iommu->mmio_base + MMIO_STATUS_OFFSET);
 
-		raw = (u64 *)(iommu->ppr_log + head);
+		head = readl(iommu->mmio_base + MMIO_PPR_HEAD_OFFSET);
+		tail = readl(iommu->mmio_base + MMIO_PPR_TAIL_OFFSET);
 
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
+		while (head != tail) {
+			volatile u64 *raw;
+			u64 entry[2];
+			int i;
 
-		/* Avoid memcpy function-call overhead */
-		entry[0] = raw[0];
-		entry[1] = raw[1];
+			raw = (u64 *)(iommu->ppr_log + head);
 
-		/*
-		 * To detect the hardware bug we need to clear the entry
-		 * back to zero.
-		 */
-		raw[0] = raw[1] = 0UL;
+			/*
+			 * Hardware bug: Interrupt may arrive before the entry
+			 * is written to memory. If this happens we need to wait
+			 * for the entry to arrive.
+			 */
+			for (i = 0; i < LOOP_TIMEOUT; ++i) {
+				if (PPR_REQ_TYPE(raw[0]) != 0)
+					break;
+				udelay(1);
+			}
 
-		/* Update head pointer of hardware ring-buffer */
-		head = (head + PPR_ENTRY_SIZE) % PPR_LOG_SIZE;
-		writel(head, iommu->mmio_base + MMIO_PPR_HEAD_OFFSET);
+			/* Avoid memcpy function-call overhead */
+			entry[0] = raw[0];
+			entry[1] = raw[1];
 
-		/*
-		 * Release iommu->lock because ppr-handling might need to
-		 * re-acquire it
-		 */
-		spin_unlock_irqrestore(&iommu->lock, flags);
+			/*
+			 * To detect the hardware bug we need to clear the entry
+			 * back to zero.
+			 */
+			raw[0] = raw[1] = 0UL;
+
+			/* Update head pointer of hardware ring-buffer */
+			head = (head + PPR_ENTRY_SIZE) % PPR_LOG_SIZE;
+			writel(head, iommu->mmio_base + MMIO_PPR_HEAD_OFFSET);
 
-		/* Handle PPR entry */
-		iommu_handle_ppr_entry(iommu, entry);
+			/*
+			 * Release iommu->lock because ppr-handling might need
+			 * to re-acquire it
+			 */
+			spin_unlock_irqrestore(&iommu->lock, flags);
 
-		spin_lock_irqsave(&iommu->lock, flags);
+			/* Handle PPR entry */
+			iommu_handle_ppr_entry(iommu, entry);
 
-		/* Refresh ring-buffer information */
-		head = readl(iommu->mmio_base + MMIO_PPR_HEAD_OFFSET);
-		tail = readl(iommu->mmio_base + MMIO_PPR_TAIL_OFFSET);
+			spin_lock_irqsave(&iommu->lock, flags);
+
+			/* Refresh ring-buffer information */
+			head = readl(iommu->mmio_base + MMIO_PPR_HEAD_OFFSET);
+			tail = readl(iommu->mmio_base + MMIO_PPR_TAIL_OFFSET);
+		}
+
+		/*
+		 * Hardware bug: When re-enabling interrupt (by writing 1
+		 * to clear the bit), the hardware might also try to set
+		 * the interrupt bit in the event status register.
+		 * In this scenario, the bit will be set, and disable
+		 * subsequent interrupts.
+		 *
+		 * Workaround: The IOMMU driver should read back the
+		 * status register and check if the interrupt bits are cleared.
+		 * If not, driver will need to go through the interrupt handler
+		 * again and re-clear the bits
+		 */
+		status = readl(iommu->mmio_base + MMIO_STATUS_OFFSET);
 	}
 
 	spin_unlock_irqrestore(&iommu->lock, flags);
-- 
1.7.10.4
