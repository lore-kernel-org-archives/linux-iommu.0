From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: [PATCH] iommu/arm-smmu-v3: Inline arm_smmu_cmdq_build_cmd()
Date: Wed, 15 Aug 2018 15:45:47 +0100
Message-ID: <141de3c3278e280712d16d9ac9ab305c3b80a810.1534344167.git.robin.murphy@arm.com>
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
To: will.deacon-5wv7dgnIgG8@public.gmane.org
Cc: jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Outside arm_smmu_cmdq_issue_cmd(), the only places we build a command
are those in which we are generating a sync for various reasons. Given
the circumstances, one might hope GCC to be clever enough to emit a
specialisation which avoids running through the switch statement with a
known constant opcode just to copy two dwords of mostly-static data, but
apparently it needs a little more help.

Explicitly marking arm_smmu_cmdq_build_cmd() as inline reduces these
sync special cases from an out-of-line call to a neat handful of ALU
instructions at the couple of relevant sites, yet squashing the full
switch statement into arm_smmu_cmdq_issue_cmd() somehow has a knock-on
effect across various other areas of the driver for a surprising overall
code size reduction:

   text	   data	    bss	    dec	    hex	filename
  16951	    648	      8	  17607	   44c7	arm-smmu-v3.o.new
  17199	    648	      8	  17855	   45bf	arm-smmu-v3.o.old

Signed-off-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
---

Having distilled this out of my pile of hacks, I'm fairly confident that
it's a reasonable change. Nothing in the latest SVA branch seems to have
any adverse effect either, which is reassuring.

 drivers/iommu/arm-smmu-v3.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index 1d647104bccc..94544cd9d929 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -776,7 +776,7 @@ static int queue_remove_raw(struct arm_smmu_queue *q, u64 *ent)
 }
 
 /* High-level queue accessors */
-static int arm_smmu_cmdq_build_cmd(u64 *cmd, struct arm_smmu_cmdq_ent *ent)
+static inline int arm_smmu_cmdq_build_cmd(u64 *cmd, struct arm_smmu_cmdq_ent *ent)
 {
 	memset(cmd, 0, CMDQ_ENT_DWORDS << 3);
 	cmd[0] |= FIELD_PREP(CMDQ_0_OP, ent->opcode);
-- 
2.17.1.dirty
