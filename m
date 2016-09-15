From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: [PATCH v2] iommu/amd: Don't put completion-wait semaphore on stack
Date: Thu, 15 Sep 2016 10:29:31 +0200
Message-ID: <20160915082931.GF1437@8bytes.org>
References: <1473846119-9527-1-git-send-email-joro@8bytes.org>
	<20160914152647.GA13814@gmail.com>
	<20160914212712.GD1437@8bytes.org> <20160914213835.GA28800@suse.de>
	<20160915054435.GA25155@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20160915054435.GA25155-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Ingo Molnar <mingo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>, x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Ingo Molnar <mingo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, bp-Gina5bIWoIWzQB+pC5nmwQ@public.gmane.org, Andy Lutomirski <luto-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Ingo,

On Thu, Sep 15, 2016 at 07:44:35AM +0200, Ingo Molnar wrote:
> Yeah, I can still remove it - just zapped it in fact.

Thanks, and sorry for the hassle. Here is the v2 patch that has the
correct locking. I tested it with and without lockdep enabled and also
under some load. Looks all fine.

So here is the patch:

>From 9becedb853c682c3fc3dd5574b933df216d91acd Mon Sep 17 00:00:00 2001
From: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
Date: Wed, 14 Sep 2016 11:41:59 +0200
Subject: [PATCH] iommu/amd: Don't put completion-wait semaphore on stack

The semaphore used by the AMD IOMMU to signal command
completion lived on the stack until now, which was safe as
the driver busy-waited on the semaphore with IRQs disabled,
so the stack can't go away under the driver.

But the recently introduced vmap-based stacks break this as
the physical address of the semaphore can't be determinded
easily anymore. The driver used the __pa() macro, but that
only works in the direct-mapping. The result were
Completion-Wait timeout errors seen by the IOMMU driver,
breaking system boot.

Since putting the semaphore on the stack is bad design
anyway, move the semaphore into 'struct amd_iommu'. It is
protected by the per-iommu lock and now in the direct
mapping again. This fixes the Completion-Wait timeout errors
and makes AMD IOMMU systems boot again with vmap-based
stacks enabled.

Reported-by: Borislav Petkov <bp-Gina5bIWoIWzQB+pC5nmwQ@public.gmane.org>
Signed-off-by: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
---
 drivers/iommu/amd_iommu.c       | 51 ++++++++++++++++++++++++++++-------------
 drivers/iommu/amd_iommu_types.h |  2 ++
 2 files changed, 37 insertions(+), 16 deletions(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index 96de97a..4025291 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -940,15 +940,13 @@ static void build_inv_irt(struct iommu_cmd *cmd, u16 devid)
  * Writes the command to the IOMMUs command buffer and informs the
  * hardware about the new command.
  */
-static int iommu_queue_command_sync(struct amd_iommu *iommu,
-				    struct iommu_cmd *cmd,
-				    bool sync)
+static int __iommu_queue_command_sync(struct amd_iommu *iommu,
+				      struct iommu_cmd *cmd,
+				      bool sync)
 {
 	u32 left, tail, head, next_tail;
-	unsigned long flags;
 
 again:
-	spin_lock_irqsave(&iommu->lock, flags);
 
 	head      = readl(iommu->mmio_base + MMIO_CMD_HEAD_OFFSET);
 	tail      = readl(iommu->mmio_base + MMIO_CMD_TAIL_OFFSET);
@@ -957,15 +955,14 @@ again:
 
 	if (left <= 2) {
 		struct iommu_cmd sync_cmd;
-		volatile u64 sem = 0;
 		int ret;
 
-		build_completion_wait(&sync_cmd, (u64)&sem);
-		copy_cmd_to_buffer(iommu, &sync_cmd, tail);
+		iommu->cmd_sem = 0;
 
-		spin_unlock_irqrestore(&iommu->lock, flags);
+		build_completion_wait(&sync_cmd, (u64)&iommu->cmd_sem);
+		copy_cmd_to_buffer(iommu, &sync_cmd, tail);
 
-		if ((ret = wait_on_sem(&sem)) != 0)
+		if ((ret = wait_on_sem(&iommu->cmd_sem)) != 0)
 			return ret;
 
 		goto again;
@@ -976,9 +973,21 @@ again:
 	/* We need to sync now to make sure all commands are processed */
 	iommu->need_sync = sync;
 
+	return 0;
+}
+
+static int iommu_queue_command_sync(struct amd_iommu *iommu,
+				    struct iommu_cmd *cmd,
+				    bool sync)
+{
+	unsigned long flags;
+	int ret;
+
+	spin_lock_irqsave(&iommu->lock, flags);
+	ret = __iommu_queue_command_sync(iommu, cmd, sync);
 	spin_unlock_irqrestore(&iommu->lock, flags);
 
-	return 0;
+	return ret;
 }
 
 static int iommu_queue_command(struct amd_iommu *iommu, struct iommu_cmd *cmd)
@@ -993,19 +1002,29 @@ static int iommu_queue_command(struct amd_iommu *iommu, struct iommu_cmd *cmd)
 static int iommu_completion_wait(struct amd_iommu *iommu)
 {
 	struct iommu_cmd cmd;
-	volatile u64 sem = 0;
+	unsigned long flags;
 	int ret;
 
 	if (!iommu->need_sync)
 		return 0;
 
-	build_completion_wait(&cmd, (u64)&sem);
 
-	ret = iommu_queue_command_sync(iommu, &cmd, false);
+	build_completion_wait(&cmd, (u64)&iommu->cmd_sem);
+
+	spin_lock_irqsave(&iommu->lock, flags);
+
+	iommu->cmd_sem = 0;
+
+	ret = __iommu_queue_command_sync(iommu, &cmd, false);
 	if (ret)
-		return ret;
+		goto out_unlock;
+
+	ret = wait_on_sem(&iommu->cmd_sem);
 
-	return wait_on_sem(&sem);
+out_unlock:
+	spin_unlock_irqrestore(&iommu->lock, flags);
+
+	return ret;
 }
 
 static int iommu_flush_dte(struct amd_iommu *iommu, u16 devid)
diff --git a/drivers/iommu/amd_iommu_types.h b/drivers/iommu/amd_iommu_types.h
index caf5e38..9652848 100644
--- a/drivers/iommu/amd_iommu_types.h
+++ b/drivers/iommu/amd_iommu_types.h
@@ -524,6 +524,8 @@ struct amd_iommu {
 	struct irq_domain *ir_domain;
 	struct irq_domain *msi_domain;
 #endif
+
+	volatile u64 __aligned(8) cmd_sem;
 };
 
 #define ACPIHID_UID_LEN 256
-- 
2.6.2
