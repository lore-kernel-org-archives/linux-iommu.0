From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 08/12] iommu/amd: Remove cmd_buf_size and evt_buf_size from
	struct amd_iommu
Date: Tue, 20 Oct 2015 17:33:41 +0200
Message-ID: <1445355225-17557-9-git-send-email-joro@8bytes.org>
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

The driver always uses a constant size for these buffers
anyway, so there is no need to waste memory to store the
sizes.

Signed-off-by: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
---
 drivers/iommu/amd_iommu.c       | 10 ++++------
 drivers/iommu/amd_iommu_init.c  |  8 +-------
 drivers/iommu/amd_iommu_types.h |  4 ----
 3 files changed, 5 insertions(+), 17 deletions(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index 1a7c78d..8886488 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -534,7 +534,7 @@ static void iommu_poll_events(struct amd_iommu *iommu)
 
 	while (head != tail) {
 		iommu_print_event(iommu, iommu->evt_buf + head);
-		head = (head + EVENT_ENTRY_SIZE) % iommu->evt_buf_size;
+		head = (head + EVENT_ENTRY_SIZE) % EVT_BUFFER_SIZE;
 	}
 
 	writel(head, iommu->mmio_base + MMIO_EVT_HEAD_OFFSET);
@@ -684,7 +684,7 @@ static void copy_cmd_to_buffer(struct amd_iommu *iommu,
 	u8 *target;
 
 	target = iommu->cmd_buf + tail;
-	tail   = (tail + sizeof(*cmd)) % iommu->cmd_buf_size;
+	tail   = (tail + sizeof(*cmd)) % CMD_BUFFER_SIZE;
 
 	/* Copy command to buffer */
 	memcpy(target, cmd, sizeof(*cmd));
@@ -851,15 +851,13 @@ static int iommu_queue_command_sync(struct amd_iommu *iommu,
 	u32 left, tail, head, next_tail;
 	unsigned long flags;
 
-	WARN_ON(iommu->cmd_buf_size & CMD_BUFFER_UNINITIALIZED);
-
 again:
 	spin_lock_irqsave(&iommu->lock, flags);
 
 	head      = readl(iommu->mmio_base + MMIO_CMD_HEAD_OFFSET);
 	tail      = readl(iommu->mmio_base + MMIO_CMD_TAIL_OFFSET);
-	next_tail = (tail + sizeof(*cmd)) % iommu->cmd_buf_size;
-	left      = (head - next_tail) % iommu->cmd_buf_size;
+	next_tail = (tail + sizeof(*cmd)) % CMD_BUFFER_SIZE;
+	left      = (head - next_tail) % CMD_BUFFER_SIZE;
 
 	if (left <= 2) {
 		struct iommu_cmd sync_cmd;
diff --git a/drivers/iommu/amd_iommu_init.c b/drivers/iommu/amd_iommu_init.c
index 1b066e7..930a5d4 100644
--- a/drivers/iommu/amd_iommu_init.c
+++ b/drivers/iommu/amd_iommu_init.c
@@ -521,8 +521,6 @@ static u8 * __init alloc_command_buffer(struct amd_iommu *iommu)
 	if (cmd_buf == NULL)
 		return NULL;
 
-	iommu->cmd_buf_size = CMD_BUFFER_SIZE | CMD_BUFFER_UNINITIALIZED;
-
 	return cmd_buf;
 }
 
@@ -557,13 +555,11 @@ static void iommu_enable_command_buffer(struct amd_iommu *iommu)
 		    &entry, sizeof(entry));
 
 	amd_iommu_reset_cmd_buffer(iommu);
-	iommu->cmd_buf_size &= ~(CMD_BUFFER_UNINITIALIZED);
 }
 
 static void __init free_command_buffer(struct amd_iommu *iommu)
 {
-	free_pages((unsigned long)iommu->cmd_buf,
-		   get_order(iommu->cmd_buf_size & ~(CMD_BUFFER_UNINITIALIZED)));
+	free_pages((unsigned long)iommu->cmd_buf, get_order(CMD_BUFFER_SIZE));
 }
 
 /* allocates the memory where the IOMMU will log its events to */
@@ -575,8 +571,6 @@ static u8 * __init alloc_event_buffer(struct amd_iommu *iommu)
 	if (iommu->evt_buf == NULL)
 		return NULL;
 
-	iommu->evt_buf_size = EVT_BUFFER_SIZE;
-
 	return iommu->evt_buf;
 }
 
diff --git a/drivers/iommu/amd_iommu_types.h b/drivers/iommu/amd_iommu_types.h
index 3026b34..921b2e9 100644
--- a/drivers/iommu/amd_iommu_types.h
+++ b/drivers/iommu/amd_iommu_types.h
@@ -528,11 +528,7 @@ struct amd_iommu {
 
 	/* command buffer virtual address */
 	u8 *cmd_buf;
-	/* size of command buffer */
-	u32 cmd_buf_size;
 
-	/* size of event buffer */
-	u32 evt_buf_size;
 	/* event buffer virtual address */
 	u8 *evt_buf;
 
-- 
1.9.1
