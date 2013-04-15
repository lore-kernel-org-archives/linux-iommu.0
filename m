From: <suravee.suthikulpanit-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 2/2 V2] iommu/AMD: Per-thread IOMMU Interrupt Handling
Date: Mon, 15 Apr 2013 02:07:56 -0500
Message-ID: <1366009676-44867-1-git-send-email-suravee.suthikulpanit@amd.com>
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

In the current interrupt handling scheme, there are as many threads as
the number of IOMMUs. Each thread is created and assigned to an IOMMU at
the time of registering interrupt handlers (request_threaded_irq).
When an IOMMU HW generates an interrupt, the irq handler (top half) wakes up
the corresponding thread to process event and PPR logs of all IOMMUs
starting from the 1st IOMMU.

In the system with multiple IOMMU,this handling scheme complicates the
synchronization of the IOMMU data structures and status registers as
there could be multiple threads competing for the same IOMMU while
the other IOMMU could be left unhandled.

To simplify, this patch is proposing a different interrupt handling scheme
by having each thread only managing interrupts of the corresponding IOMMU.
This can be achieved by passing the struct amd_iommu when registering the
interrupt handlers. This structure is unique for each IOMMU and can be used
by the bottom half thread to identify the IOMMU to be handled instead
of calling for_each_iommu.  Besides this also eliminate the needs to lock
the IOMMU for processing event and PPR logs.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit-5C7GfCeVMHo@public.gmane.org>
---
 drivers/iommu/amd_iommu.c      |  154 +++++++++++++++-------------------------
 drivers/iommu/amd_iommu_init.c |    2 +-
 2 files changed, 58 insertions(+), 98 deletions(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index 419af1d..3548d63 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -803,45 +803,16 @@ retry:
 static void iommu_poll_events(struct amd_iommu *iommu)
 {
 	u32 head, tail;
-	u32 status;
-	unsigned long flags;
-
-	spin_lock_irqsave(&iommu->lock, flags);
-
-	status = readl(iommu->mmio_base + MMIO_STATUS_OFFSET);
-
-	while (status & MMIO_STATUS_EVT_INT_MASK) {
-
-		/* enable event interrupts again */
-		writel(MMIO_STATUS_EVT_INT_MASK,
-			iommu->mmio_base + MMIO_STATUS_OFFSET);
-
-		head = readl(iommu->mmio_base + MMIO_EVT_HEAD_OFFSET);
-		tail = readl(iommu->mmio_base + MMIO_EVT_TAIL_OFFSET);
 
-		while (head != tail) {
-			iommu_handle_event(iommu, iommu->evt_buf + head);
-			head = (head + EVENT_ENTRY_SIZE) % iommu->evt_buf_size;
-		}
-
-		writel(head, iommu->mmio_base + MMIO_EVT_HEAD_OFFSET);
+	head = readl(iommu->mmio_base + MMIO_EVT_HEAD_OFFSET);
+	tail = readl(iommu->mmio_base + MMIO_EVT_TAIL_OFFSET);
 
-		/*
-		 * Hardware bug: When re-enabling interrupt (by writing 1
-		 * to clear the bit), the hardware might also try to set
-		 * the interrupt bit in the event status register.
-		 * In this scenario, the bit will be set, and disable
-		 * subsequent interrupts.
-		 *
-		 * Workaround: The IOMMU driver should read back the
-		 * status register and check if the interrupt bits are cleared.
-		 * If not, driver will need to go through the interrupt handler
-		 * again and re-clear the bits
-		 */
-		status = readl(iommu->mmio_base + MMIO_STATUS_OFFSET);
+	while (head != tail) {
+		iommu_handle_event(iommu, iommu->evt_buf + head);
+		head = (head + EVENT_ENTRY_SIZE) % iommu->evt_buf_size;
 	}
 
-	spin_unlock_irqrestore(&iommu->lock, flags);
+	writel(head, iommu->mmio_base + MMIO_EVT_HEAD_OFFSET);
 }
 
 static void iommu_handle_ppr_entry(struct amd_iommu *iommu, u64 *raw)
@@ -866,73 +837,75 @@ static void iommu_handle_ppr_entry(struct amd_iommu *iommu, u64 *raw)
 
 static void iommu_poll_ppr_log(struct amd_iommu *iommu)
 {
-	unsigned long flags;
-	u32 status;
 	u32 head, tail;
 
 	if (iommu->ppr_log == NULL)
 		return;
 
-	spin_lock_irqsave(&iommu->lock, flags);
-
-	status = readl(iommu->mmio_base + MMIO_STATUS_OFFSET);
-
-	while (status & MMIO_STATUS_PPR_INT_MASK) {
-		/* enable ppr interrupts again */
-		writel(MMIO_STATUS_PPR_INT_MASK,
-			iommu->mmio_base + MMIO_STATUS_OFFSET);
+	head = readl(iommu->mmio_base + MMIO_PPR_HEAD_OFFSET);
+	tail = readl(iommu->mmio_base + MMIO_PPR_TAIL_OFFSET);
 
-		head = readl(iommu->mmio_base + MMIO_PPR_HEAD_OFFSET);
-		tail = readl(iommu->mmio_base + MMIO_PPR_TAIL_OFFSET);
+	while (head != tail) {
+		volatile u64 *raw;
+		u64 entry[2];
+		int i;
 
-		while (head != tail) {
-			volatile u64 *raw;
-			u64 entry[2];
-			int i;
+		raw = (u64 *)(iommu->ppr_log + head);
 
-			raw = (u64 *)(iommu->ppr_log + head);
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
 
-			/*
-			 * Hardware bug: Interrupt may arrive before the entry
-			 * is written to memory. If this happens we need to wait
-			 * for the entry to arrive.
-			 */
-			for (i = 0; i < LOOP_TIMEOUT; ++i) {
-				if (PPR_REQ_TYPE(raw[0]) != 0)
-					break;
-				udelay(1);
-			}
+		/* Avoid memcpy function-call overhead */
+		entry[0] = raw[0];
+		entry[1] = raw[1];
 
-			/* Avoid memcpy function-call overhead */
-			entry[0] = raw[0];
-			entry[1] = raw[1];
+		/*
+		 * To detect the hardware bug we need to clear the entry
+		 * back to zero.
+		 */
+		raw[0] = raw[1] = 0UL;
 
-			/*
-			 * To detect the hardware bug we need to clear the entry
-			 * back to zero.
-			 */
-			raw[0] = raw[1] = 0UL;
+		/* Update head pointer of hardware ring-buffer */
+		head = (head + PPR_ENTRY_SIZE) % PPR_LOG_SIZE;
+		writel(head, iommu->mmio_base + MMIO_PPR_HEAD_OFFSET);
 
-			/* Update head pointer of hardware ring-buffer */
-			head = (head + PPR_ENTRY_SIZE) % PPR_LOG_SIZE;
-			writel(head, iommu->mmio_base + MMIO_PPR_HEAD_OFFSET);
+		/* Handle PPR entry */
+		iommu_handle_ppr_entry(iommu, entry);
 
-			/*
-			 * Release iommu->lock because ppr-handling might need
-			 * to re-acquire it
-			 */
-			spin_unlock_irqrestore(&iommu->lock, flags);
+		/* Refresh ring-buffer information */
+		head = readl(iommu->mmio_base + MMIO_PPR_HEAD_OFFSET);
+		tail = readl(iommu->mmio_base + MMIO_PPR_TAIL_OFFSET);
+	}
+}
 
-			/* Handle PPR entry */
-			iommu_handle_ppr_entry(iommu, entry);
+irqreturn_t amd_iommu_int_thread(int irq, void *data)
+{
+	struct amd_iommu *iommu = (struct amd_iommu *) data;
+	u32 status = readl(iommu->mmio_base + MMIO_STATUS_OFFSET);
 
-			spin_lock_irqsave(&iommu->lock, flags);
+	while (status & (MMIO_STATUS_EVT_INT_MASK | MMIO_STATUS_PPR_INT_MASK)) {
+		if (status & MMIO_STATUS_EVT_INT_MASK) {
+			pr_devel("AMD-Vi: Processing IOMMU Event Log\n");
+			iommu_poll_events(iommu);
+		}
 
-			/* Refresh ring-buffer information */
-			head = readl(iommu->mmio_base + MMIO_PPR_HEAD_OFFSET);
-			tail = readl(iommu->mmio_base + MMIO_PPR_TAIL_OFFSET);
+		if (status & MMIO_STATUS_PPR_INT_MASK) {
+			pr_devel("AMD-Vi: Processing IOMMU PPR Log\n");
+			iommu_poll_ppr_log(iommu);
 		}
 
+		/* Enable EVT and PPR interrupts again */
+		writel((MMIO_STATUS_EVT_INT_MASK | MMIO_STATUS_PPR_INT_MASK),
+			iommu->mmio_base + MMIO_STATUS_OFFSET);
+
 		/*
 		 * Hardware bug: When re-enabling interrupt (by writing 1
 		 * to clear the bit), the hardware might also try to set
@@ -947,19 +920,6 @@ static void iommu_poll_ppr_log(struct amd_iommu *iommu)
 		 */
 		status = readl(iommu->mmio_base + MMIO_STATUS_OFFSET);
 	}
-
-	spin_unlock_irqrestore(&iommu->lock, flags);
-}
-
-irqreturn_t amd_iommu_int_thread(int irq, void *data)
-{
-	struct amd_iommu *iommu;
-
-	for_each_iommu(iommu) {
-		iommu_poll_events(iommu);
-		iommu_poll_ppr_log(iommu);
-	}
-
 	return IRQ_HANDLED;
 }
 
diff --git a/drivers/iommu/amd_iommu_init.c b/drivers/iommu/amd_iommu_init.c
index e3c2d74..e4120bb 100644
--- a/drivers/iommu/amd_iommu_init.c
+++ b/drivers/iommu/amd_iommu_init.c
@@ -1275,7 +1275,7 @@ static int iommu_setup_msi(struct amd_iommu *iommu)
 				 amd_iommu_int_handler,
 				 amd_iommu_int_thread,
 				 0, "AMD-Vi",
-				 iommu->dev);
+				 iommu);
 
 	if (r) {
 		pci_disable_msi(iommu->dev);
-- 
1.7.10.4
