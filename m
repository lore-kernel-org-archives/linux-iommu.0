From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: [PATCH v2 3/4] iommu/arm-smmu-v3: Use CMD_SYNC completion MSI
Date: Thu, 31 Aug 2017 14:44:27 +0100
Message-ID: <dbf0ce00f8e249c64f3d2041acd8d91818178e52.1504182142.git.robin.murphy@arm.com>
References: <cover.1504182142.git.robin.murphy@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <cover.1504182142.git.robin.murphy-5wv7dgnIgG8@public.gmane.org>
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
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, sgoutham-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

As an IRQ, the CMD_SYNC interrupt is not particularly useful, not least
because we often need to wait for sync completion within someone else's
IRQ handler anyway. However, when the SMMU is both coherent and supports
MSIs, we can have a lot more fun by not using it as an interrupt at all.
Following the example suggested in the architecture and using a write
targeting normal memory, we can let callers wait on a status variable
outside the lock instead of having to stall the entire queue or even
touch MMIO registers. Since multiple sync commands are guaranteed to
complete in order, a simple incrementing sequence count is all we need
to unambiguously support any realistic number of overlapping waiters.

Signed-off-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
---

v2: Remove redundant 'bool msi' command member, other cosmetic tweaks

 drivers/iommu/arm-smmu-v3.c | 47 +++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 45 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index f066725298cd..311f482b93d5 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -377,7 +377,16 @@
 
 #define CMDQ_SYNC_0_CS_SHIFT		12
 #define CMDQ_SYNC_0_CS_NONE		(0UL << CMDQ_SYNC_0_CS_SHIFT)
+#define CMDQ_SYNC_0_CS_IRQ		(1UL << CMDQ_SYNC_0_CS_SHIFT)
 #define CMDQ_SYNC_0_CS_SEV		(2UL << CMDQ_SYNC_0_CS_SHIFT)
+#define CMDQ_SYNC_0_MSH_SHIFT		22
+#define CMDQ_SYNC_0_MSH_ISH		(3UL << CMDQ_SYNC_0_MSH_SHIFT)
+#define CMDQ_SYNC_0_MSIATTR_SHIFT	24
+#define CMDQ_SYNC_0_MSIATTR_OIWB	(0xfUL << CMDQ_SYNC_0_MSIATTR_SHIFT)
+#define CMDQ_SYNC_0_MSIDATA_SHIFT	32
+#define CMDQ_SYNC_0_MSIDATA_MASK	0xffffffffUL
+#define CMDQ_SYNC_1_MSIADDR_SHIFT	0
+#define CMDQ_SYNC_1_MSIADDR_MASK	0xffffffffffffcUL
 
 /* Event queue */
 #define EVTQ_ENT_DWORDS			4
@@ -409,6 +418,7 @@
 /* High-level queue structures */
 #define ARM_SMMU_POLL_TIMEOUT_US	100
 #define ARM_SMMU_CMDQ_DRAIN_TIMEOUT_US	1000000 /* 1s! */
+#define ARM_SMMU_SYNC_TIMEOUT_US	1000000 /* 1s! */
 
 #define MSI_IOVA_BASE			0x8000000
 #define MSI_IOVA_LENGTH			0x100000
@@ -504,6 +514,10 @@ struct arm_smmu_cmdq_ent {
 		} pri;
 
 		#define CMDQ_OP_CMD_SYNC	0x46
+		struct {
+			u32			msidata;
+			u64			msiaddr;
+		} sync;
 	};
 };
 
@@ -617,6 +631,9 @@ struct arm_smmu_device {
 	int				gerr_irq;
 	int				combined_irq;
 
+	atomic_t			sync_nr;
+	u32				sync_count;
+
 	unsigned long			ias; /* IPA */
 	unsigned long			oas; /* PA */
 	unsigned long			pgsize_bitmap;
@@ -878,7 +895,13 @@ static int arm_smmu_cmdq_build_cmd(u64 *cmd, struct arm_smmu_cmdq_ent *ent)
 		}
 		break;
 	case CMDQ_OP_CMD_SYNC:
-		cmd[0] |= CMDQ_SYNC_0_CS_SEV;
+		if (ent->sync.msiaddr)
+			cmd[0] |= CMDQ_SYNC_0_CS_IRQ;
+		else
+			cmd[0] |= CMDQ_SYNC_0_CS_SEV;
+		cmd[0] |= CMDQ_SYNC_0_MSH_ISH | CMDQ_SYNC_0_MSIATTR_OIWB;
+		cmd[0] |= (u64)ent->sync.msidata << CMDQ_SYNC_0_MSIDATA_SHIFT;
+		cmd[1] |= ent->sync.msiaddr & CMDQ_SYNC_1_MSIADDR_MASK;
 		break;
 	default:
 		return -ENOENT;
@@ -964,21 +987,40 @@ static void arm_smmu_cmdq_issue_cmd(struct arm_smmu_device *smmu,
 	spin_unlock_irqrestore(&smmu->cmdq.lock, flags);
 }
 
+static int arm_smmu_sync_poll_msi(struct arm_smmu_device *smmu, u32 sync_idx)
+{
+	ktime_t timeout = ktime_add_us(ktime_get(), ARM_SMMU_SYNC_TIMEOUT_US);
+	u32 val = smp_cond_load_acquire(&smmu->sync_count,
+					(int)(VAL - sync_idx) >= 0 ||
+					!ktime_before(ktime_get(), timeout));
+
+	return (int)(val - sync_idx) < 0 ? -ETIMEDOUT : 0;
+}
+
 static void arm_smmu_cmdq_issue_sync(struct arm_smmu_device *smmu)
 {
 	u64 cmd[CMDQ_ENT_DWORDS];
 	unsigned long flags;
 	bool wfe = !!(smmu->features & ARM_SMMU_FEAT_SEV);
+	bool msi = (smmu->features & ARM_SMMU_FEAT_MSI) &&
+		   (smmu->features & ARM_SMMU_FEAT_COHERENCY);
 	struct arm_smmu_cmdq_ent ent = { .opcode = CMDQ_OP_CMD_SYNC };
 	int ret;
 
+	if (msi) {
+		ent.sync.msidata = atomic_inc_return(&smmu->sync_nr);
+		ent.sync.msiaddr = virt_to_phys(&smmu->sync_count);
+	}
 	arm_smmu_cmdq_build_cmd(cmd, &ent);
 
 	spin_lock_irqsave(&smmu->cmdq.lock, flags);
 	arm_smmu_cmdq_insert_cmd(smmu, cmd);
-	ret = queue_poll_cons(&smmu->cmdq.q, true, wfe);
+	if (!msi)
+		ret = queue_poll_cons(&smmu->cmdq.q, true, wfe);
 	spin_unlock_irqrestore(&smmu->cmdq.lock, flags);
 
+	if (msi)
+		ret = arm_smmu_sync_poll_msi(smmu, ent.sync.msidata);
 	if (ret)
 		dev_err_ratelimited(smmu->dev, "CMD_SYNC timeout\n");
 }
@@ -2156,6 +2198,7 @@ static int arm_smmu_init_structures(struct arm_smmu_device *smmu)
 {
 	int ret;
 
+	atomic_set(&smmu->sync_nr, 0);
 	ret = arm_smmu_init_queues(smmu);
 	if (ret)
 		return ret;
-- 
2.13.4.dirty
