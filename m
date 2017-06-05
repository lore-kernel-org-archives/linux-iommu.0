From: Tom Lendacky <thomas.lendacky-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH v1 2/3] iommu/amd: Reduce delay waiting for command buffer
	space
Date: Mon, 05 Jun 2017 14:52:26 -0500
Message-ID: <20170605195226.11512.1123.stgit@tlendack-t1.amdoffice.net>
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

Currently if there is no room to add a command to the command buffer, the
driver performs a "completion wait" which only returns when all commands
on the queue have been processed. There is no need to wait for the entire
command queue to be executed before adding the next command.

Update the driver to perform the same udelay() loop that the "completion
wait" performs, but instead re-read the head pointer to determine if
sufficient space is available.  The very first time it is found that there
is no space available, the udelay() will be skipped to immediately perform
the opportunistic read of the head pointer. If it is still found that
there is not sufficient space, then the udelay() will be performed.

Signed-off-by: Leo Duran <leo.duran-5C7GfCeVMHo@public.gmane.org>
Signed-off-by: Tom Lendacky <thomas.lendacky-5C7GfCeVMHo@public.gmane.org>
---
 drivers/iommu/amd_iommu.c |   33 +++++++++++++--------------------
 1 file changed, 13 insertions(+), 20 deletions(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index faf0ddf..856103b 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -1019,7 +1019,7 @@ static int __iommu_queue_command_sync(struct amd_iommu *iommu,
 				      struct iommu_cmd *cmd,
 				      bool sync)
 {
-	bool read_head = true;
+	unsigned int count = 0;
 	u32 left, next_tail;
 
 	next_tail = (iommu->cmd_buf_tail + sizeof(*cmd)) % CMD_BUFFER_SIZE;
@@ -1027,33 +1027,26 @@ static int __iommu_queue_command_sync(struct amd_iommu *iommu,
 	left      = (iommu->cmd_buf_head - next_tail) % CMD_BUFFER_SIZE;
 
 	if (left <= 0x20) {
-		struct iommu_cmd sync_cmd;
-		int ret;
-
-		if (read_head) {
-			/* Update head and recheck remaining space */
-			iommu->cmd_buf_head = readl(iommu->mmio_base +
-						    MMIO_CMD_HEAD_OFFSET);
-			read_head = false;
-			goto again;
-		}
-
-		read_head = true;
-
-		iommu->cmd_sem = 0;
+		/* Skip udelay() the first time around */
+		if (count++) {
+			if (count == LOOP_TIMEOUT) {
+				pr_err("AMD-Vi: Command buffer timeout\n");
+				return -EIO;
+			}
 
-		build_completion_wait(&sync_cmd, (u64)&iommu->cmd_sem);
-		copy_cmd_to_buffer(iommu, &sync_cmd);
+			udelay(1);
+		}
 
-		if ((ret = wait_on_sem(&iommu->cmd_sem)) != 0)
-			return ret;
+		/* Update head and recheck remaining space */
+		iommu->cmd_buf_head = readl(iommu->mmio_base +
+					    MMIO_CMD_HEAD_OFFSET);
 
 		goto again;
 	}
 
 	copy_cmd_to_buffer(iommu, cmd);
 
-	/* We need to sync now to make sure all commands are processed */
+	/* Do we need to make sure all commands are processed? */
 	iommu->need_sync = sync;
 
 	return 0;
