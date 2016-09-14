From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: [PATCH] iommu/amd: Don't put completion-wait semaphore on stack
Date: Wed, 14 Sep 2016 11:41:59 +0200
Message-ID: <1473846119-9527-1-git-send-email-joro@8bytes.org>
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
To: Ingo Molnar <mingo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org
Cc: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, bp-Gina5bIWoIWzQB+pC5nmwQ@public.gmane.org, Andy Lutomirski <luto-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

From: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>

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
 drivers/iommu/amd_iommu.c       | 14 ++++++++------
 drivers/iommu/amd_iommu_types.h |  2 ++
 2 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index 96de97a..1307e73 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -957,15 +957,16 @@ again:
 
 	if (left <= 2) {
 		struct iommu_cmd sync_cmd;
-		volatile u64 sem = 0;
 		int ret;
 
-		build_completion_wait(&sync_cmd, (u64)&sem);
+		iommu->cmd_sem = 0;
+
+		build_completion_wait(&sync_cmd, (u64)&iommu->cmd_sem);
 		copy_cmd_to_buffer(iommu, &sync_cmd, tail);
 
 		spin_unlock_irqrestore(&iommu->lock, flags);
 
-		if ((ret = wait_on_sem(&sem)) != 0)
+		if ((ret = wait_on_sem(&iommu->cmd_sem)) != 0)
 			return ret;
 
 		goto again;
@@ -993,19 +994,20 @@ static int iommu_queue_command(struct amd_iommu *iommu, struct iommu_cmd *cmd)
 static int iommu_completion_wait(struct amd_iommu *iommu)
 {
 	struct iommu_cmd cmd;
-	volatile u64 sem = 0;
 	int ret;
 
 	if (!iommu->need_sync)
 		return 0;
 
-	build_completion_wait(&cmd, (u64)&sem);
+	iommu->cmd_sem = 0;
+
+	build_completion_wait(&cmd, (u64)&iommu->cmd_sem);
 
 	ret = iommu_queue_command_sync(iommu, &cmd, false);
 	if (ret)
 		return ret;
 
-	return wait_on_sem(&sem);
+	return wait_on_sem(&iommu->cmd_sem);
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
