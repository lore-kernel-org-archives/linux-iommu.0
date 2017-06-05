From: Tom Lendacky <thomas.lendacky-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH v1 1/3] iommu/amd: Reduce amount of MMIO when submitting
	commands
Date: Mon, 05 Jun 2017 14:52:12 -0500
Message-ID: <20170605195212.11512.98801.stgit@tlendack-t1.amdoffice.net>
References: <20170605195203.11512.20579.stgit@tlendack-t1.amdoffice.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20170605195203.11512.20579.stgit-qCXWGYdRb2BnqfbPTmsdiZQ+2ll4COg0XqFh9Ls21Oc@public.gmane.org>
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
Cc: Arindam Nath <arindam.nath-5C7GfCeVMHo@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

As newer, higher speed devices are developed, perf data shows that the
amount of MMIO that is performed when submitting commands to the IOMMU
causes performance issues. Currently, the command submission path reads
the command buffer head and tail pointers and then writes the tail
pointer once the command is ready.

The tail pointer is only ever updated by the driver so it can be tracked
by the driver without having to read it from the hardware.

The head pointer is updated by the hardware, but can be read
opportunistically. Reading the head pointer only when it appears that
there might not be room in the command buffer and then re-checking the
available space reduces the number of times the head pointer has to be
read.

Signed-off-by: Tom Lendacky <thomas.lendacky-5C7GfCeVMHo@public.gmane.org>
---
 drivers/iommu/amd_iommu.c       |   35 ++++++++++++++++++++++-------------
 drivers/iommu/amd_iommu_init.c  |    2 ++
 drivers/iommu/amd_iommu_types.h |    2 ++
 3 files changed, 26 insertions(+), 13 deletions(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index 63cacf5..faf0ddf 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -848,19 +848,20 @@ static int wait_on_sem(volatile u64 *sem)
 }
 
 static void copy_cmd_to_buffer(struct amd_iommu *iommu,
-			       struct iommu_cmd *cmd,
-			       u32 tail)
+			       struct iommu_cmd *cmd)
 {
 	u8 *target;
 
-	target = iommu->cmd_buf + tail;
-	tail   = (tail + sizeof(*cmd)) % CMD_BUFFER_SIZE;
+	target = iommu->cmd_buf + iommu->cmd_buf_tail;
+
+	iommu->cmd_buf_tail += sizeof(*cmd);
+	iommu->cmd_buf_tail %= CMD_BUFFER_SIZE;
 
 	/* Copy command to buffer */
 	memcpy(target, cmd, sizeof(*cmd));
 
 	/* Tell the IOMMU about it */
-	writel(tail, iommu->mmio_base + MMIO_CMD_TAIL_OFFSET);
+	writel(iommu->cmd_buf_tail, iommu->mmio_base + MMIO_CMD_TAIL_OFFSET);
 }
 
 static void build_completion_wait(struct iommu_cmd *cmd, u64 address)
@@ -1018,23 +1019,31 @@ static int __iommu_queue_command_sync(struct amd_iommu *iommu,
 				      struct iommu_cmd *cmd,
 				      bool sync)
 {
-	u32 left, tail, head, next_tail;
+	bool read_head = true;
+	u32 left, next_tail;
 
+	next_tail = (iommu->cmd_buf_tail + sizeof(*cmd)) % CMD_BUFFER_SIZE;
 again:
-
-	head      = readl(iommu->mmio_base + MMIO_CMD_HEAD_OFFSET);
-	tail      = readl(iommu->mmio_base + MMIO_CMD_TAIL_OFFSET);
-	next_tail = (tail + sizeof(*cmd)) % CMD_BUFFER_SIZE;
-	left      = (head - next_tail) % CMD_BUFFER_SIZE;
+	left      = (iommu->cmd_buf_head - next_tail) % CMD_BUFFER_SIZE;
 
 	if (left <= 0x20) {
 		struct iommu_cmd sync_cmd;
 		int ret;
 
+		if (read_head) {
+			/* Update head and recheck remaining space */
+			iommu->cmd_buf_head = readl(iommu->mmio_base +
+						    MMIO_CMD_HEAD_OFFSET);
+			read_head = false;
+			goto again;
+		}
+
+		read_head = true;
+
 		iommu->cmd_sem = 0;
 
 		build_completion_wait(&sync_cmd, (u64)&iommu->cmd_sem);
-		copy_cmd_to_buffer(iommu, &sync_cmd, tail);
+		copy_cmd_to_buffer(iommu, &sync_cmd);
 
 		if ((ret = wait_on_sem(&iommu->cmd_sem)) != 0)
 			return ret;
@@ -1042,7 +1051,7 @@ static int __iommu_queue_command_sync(struct amd_iommu *iommu,
 		goto again;
 	}
 
-	copy_cmd_to_buffer(iommu, cmd, tail);
+	copy_cmd_to_buffer(iommu, cmd);
 
 	/* We need to sync now to make sure all commands are processed */
 	iommu->need_sync = sync;
diff --git a/drivers/iommu/amd_iommu_init.c b/drivers/iommu/amd_iommu_init.c
index 5a11328..3fa7e3b 100644
--- a/drivers/iommu/amd_iommu_init.c
+++ b/drivers/iommu/amd_iommu_init.c
@@ -588,6 +588,8 @@ void amd_iommu_reset_cmd_buffer(struct amd_iommu *iommu)
 
 	writel(0x00, iommu->mmio_base + MMIO_CMD_HEAD_OFFSET);
 	writel(0x00, iommu->mmio_base + MMIO_CMD_TAIL_OFFSET);
+	iommu->cmd_buf_head = 0;
+	iommu->cmd_buf_tail = 0;
 
 	iommu_feature_enable(iommu, CONTROL_CMDBUF_EN);
 }
diff --git a/drivers/iommu/amd_iommu_types.h b/drivers/iommu/amd_iommu_types.h
index 4de8f41..6960d7d 100644
--- a/drivers/iommu/amd_iommu_types.h
+++ b/drivers/iommu/amd_iommu_types.h
@@ -516,6 +516,8 @@ struct amd_iommu {
 
 	/* command buffer virtual address */
 	u8 *cmd_buf;
+	u32 cmd_buf_head;
+	u32 cmd_buf_tail;
 
 	/* event buffer virtual address */
 	u8 *evt_buf;
