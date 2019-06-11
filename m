Return-Path: <SRS0=+ySY=UK=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A9C6C4321A
	for <iommu@archiver.kernel.org>; Tue, 11 Jun 2019 13:46:52 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 38FAE20896
	for <iommu@archiver.kernel.org>; Tue, 11 Jun 2019 13:46:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38FAE20896
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id ADF3DEE7;
	Tue, 11 Jun 2019 13:46:23 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 98E44D6A
	for <iommu@lists.linux-foundation.org>;
	Tue, 11 Jun 2019 13:46:22 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp1.linuxfoundation.org (Postfix) with ESMTP id DC557711
	for <iommu@lists.linux-foundation.org>;
	Tue, 11 Jun 2019 13:46:20 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8D773FEC;
	Tue, 11 Jun 2019 06:46:20 -0700 (PDT)
Received: from fuggles.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
	[10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id DBB9C3F557; 
	Tue, 11 Jun 2019 06:46:18 -0700 (PDT)
From: Will Deacon <will.deacon@arm.com>
To: iommu@lists.linux-foundation.org
Subject: [RFC CFT 6/6] iommu/arm-smmu-v3: Reduce contention during
	command-queue insertion
Date: Tue, 11 Jun 2019 14:46:03 +0100
Message-Id: <20190611134603.4253-7-will.deacon@arm.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190611134603.4253-1-will.deacon@arm.com>
References: <20190611134603.4253-1-will.deacon@arm.com>
Cc: Vijay Kilary <vkilari@codeaurora.org>,
	Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
	Jon Masters <jcm@redhat.com>, Jan Glauber <jglauber@marvell.com>,
	Will Deacon <will.deacon@arm.com>,
	Jayachandran Chandrasekharan Nair <jnair@marvell.com>,
	Robin Murphy <robin.murphy@arm.com>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Development issues for Linux IOMMU support
	<iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

The SMMU command queue is a bottleneck in large systems, thanks to the
spin_lock which serialises accesses from all CPUs to the single queue
supported by the hardware.

Attempt to improve this situation by moving to a new algorithm for
inserting commands into the queue, which is lock-free on the fast-path.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 drivers/iommu/arm-smmu-v3.c | 579 +++++++++++++++++++++++++++++++++-----------
 1 file changed, 441 insertions(+), 138 deletions(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index 85535400a365..1e9fa83b502a 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -183,7 +183,7 @@
 
 #define Q_IDX(llq, p)			((p) & ((1 << (llq)->max_n_shift) - 1))
 #define Q_WRP(llq, p)			((p) & (1 << (llq)->max_n_shift))
-#define Q_OVERFLOW_FLAG			(1 << 31)
+#define Q_OVERFLOW_FLAG			(1U << 31)
 #define Q_OVF(p)			((p) & Q_OVERFLOW_FLAG)
 #define Q_ENT(q, p)			((q)->base +			\
 					 Q_IDX(&((q)->llq), p) *	\
@@ -301,6 +301,8 @@
 #define CMDQ_ERR_CERROR_ABT_IDX		2
 #define CMDQ_ERR_CERROR_ATC_INV_IDX	3
 
+#define CMDQ_PROD_OWNED_FLAG		Q_OVERFLOW_FLAG
+
 #define CMDQ_0_OP			GENMASK_ULL(7, 0)
 #define CMDQ_0_SSV			(1UL << 11)
 
@@ -363,9 +365,8 @@
 #define PRIQ_1_ADDR_MASK		GENMASK_ULL(63, 12)
 
 /* High-level queue structures */
-#define ARM_SMMU_POLL_TIMEOUT_US	100
-#define ARM_SMMU_CMDQ_SYNC_TIMEOUT_US	1000000 /* 1s! */
-#define ARM_SMMU_CMDQ_SYNC_SPIN_COUNT	10
+#define ARM_SMMU_POLL_TIMEOUT_US	1000000 /* 1s! */
+#define ARM_SMMU_POLL_SPIN_COUNT	10
 
 #define MSI_IOVA_BASE			0x8000000
 #define MSI_IOVA_LENGTH			0x100000
@@ -467,15 +468,24 @@ struct arm_smmu_cmdq_ent {
 
 		#define CMDQ_OP_CMD_SYNC	0x46
 		struct {
-			u32			msidata;
-			u64			msiaddr;
+			bool			msi;
 		} sync;
 	};
 };
 
 struct arm_smmu_ll_queue {
-	u32				prod;
-	u32				cons;
+	union {
+		u64			val;
+		struct {
+			u32		prod;
+			u32		cons;
+		};
+		struct {
+			atomic_t	prod;
+			atomic_t	cons;
+		} atomic;
+		u8			__pad[SMP_CACHE_BYTES];
+	} ____cacheline_aligned_in_smp;
 	u32				max_n_shift;
 };
 
@@ -493,9 +503,18 @@ struct arm_smmu_queue {
 	u32 __iomem			*cons_reg;
 };
 
+struct arm_smmu_queue_poll {
+	ktime_t				timeout;
+	unsigned int			delay;
+	unsigned int			spin_cnt;
+	bool				wfe;
+};
+
 struct arm_smmu_cmdq {
 	struct arm_smmu_queue		q;
-	spinlock_t			lock;
+	unsigned long			*valid_map;
+	atomic_t			owner_prod;
+	atomic_t			lock;
 };
 
 struct arm_smmu_evtq {
@@ -595,12 +614,6 @@ struct arm_smmu_device {
 
 	struct arm_smmu_strtab_cfg	strtab_cfg;
 
-	/* Hi16xx adds an extra 32 bits of goodness to its MSI payload */
-	union {
-		u32			sync_count;
-		u64			padding;
-	};
-
 	/* IOMMU core code handle */
 	struct iommu_device		iommu;
 };
@@ -696,9 +709,12 @@ static bool queue_empty(struct arm_smmu_ll_queue *q)
 	       Q_WRP(q, q->prod) == Q_WRP(q, q->cons);
 }
 
-static void queue_sync_cons_in(struct arm_smmu_queue *q)
+static bool queue_consumed(struct arm_smmu_ll_queue *q, u32 prod)
 {
-	q->llq.cons = readl_relaxed(q->cons_reg);
+	return ((Q_WRP(q, q->cons) == Q_WRP(q, prod)) &&
+		(Q_IDX(q, q->cons) > Q_IDX(q, prod))) ||
+	       ((Q_WRP(q, q->cons) != Q_WRP(q, prod)) &&
+		(Q_IDX(q, q->cons) <= Q_IDX(q, prod)));
 }
 
 static void queue_sync_cons_out(struct arm_smmu_queue *q)
@@ -729,46 +745,39 @@ static int queue_sync_prod_in(struct arm_smmu_queue *q)
 	return ret;
 }
 
-static void queue_sync_prod_out(struct arm_smmu_queue *q)
+static u32 queue_inc_prod_n(struct arm_smmu_ll_queue *q, int n)
 {
-	writel(q->llq.prod, q->prod_reg);
+	u32 prod = (Q_WRP(q, q->prod) | Q_IDX(q, q->prod)) + n;
+	return Q_OVF(q->prod) | Q_WRP(q, prod) | Q_IDX(q, prod);
 }
 
 static void queue_inc_prod(struct arm_smmu_ll_queue *q)
 {
-	u32 prod = (Q_WRP(q, q->prod) | Q_IDX(q, q->prod)) + 1;
-	q->prod = Q_OVF(q->prod) | Q_WRP(q, prod) | Q_IDX(q, prod);
+	q->prod = queue_inc_prod_n(q, 1);
 }
 
-/*
- * Wait for the SMMU to consume items. If sync is true, wait until the queue
- * is empty. Otherwise, wait until there is at least one free slot.
- */
-static int queue_poll_cons(struct arm_smmu_queue *q, bool sync, bool wfe)
+static void queue_poll_init(struct arm_smmu_device *smmu,
+			    struct arm_smmu_queue_poll *qp)
 {
-	ktime_t timeout;
-	unsigned int delay = 1, spin_cnt = 0;
-
-	/* Wait longer if it's a CMD_SYNC */
-	timeout = ktime_add_us(ktime_get(), sync ?
-					    ARM_SMMU_CMDQ_SYNC_TIMEOUT_US :
-					    ARM_SMMU_POLL_TIMEOUT_US);
+	qp->delay = 1;
+	qp->spin_cnt = 0;
+	qp->wfe = !!(smmu->features & ARM_SMMU_FEAT_SEV);
+	qp->timeout = ktime_add_us(ktime_get(), ARM_SMMU_POLL_TIMEOUT_US);
+}
 
-	while (queue_sync_cons_in(q),
-	      (sync ? !queue_empty(&q->llq) : queue_full(&q->llq))) {
-		if (ktime_compare(ktime_get(), timeout) > 0)
-			return -ETIMEDOUT;
+static int queue_poll(struct arm_smmu_queue_poll *qp)
+{
+	if (ktime_compare(ktime_get(), qp->timeout) > 0)
+		return -ETIMEDOUT;
 
-		if (wfe) {
-			wfe();
-		} else if (++spin_cnt < ARM_SMMU_CMDQ_SYNC_SPIN_COUNT) {
-			cpu_relax();
-			continue;
-		} else {
-			udelay(delay);
-			delay *= 2;
-			spin_cnt = 0;
-		}
+	if (qp->wfe) {
+		wfe();
+	} else if (++qp->spin_cnt < ARM_SMMU_POLL_SPIN_COUNT) {
+		cpu_relax();
+	} else {
+		udelay(qp->delay);
+		qp->delay *= 2;
+		qp->spin_cnt = 0;
 	}
 
 	return 0;
@@ -782,17 +791,6 @@ static void queue_write(__le64 *dst, u64 *src, size_t n_dwords)
 		*dst++ = cpu_to_le64(*src++);
 }
 
-static int queue_insert_raw(struct arm_smmu_queue *q, u64 *ent)
-{
-	if (queue_full(&q->llq))
-		return -ENOSPC;
-
-	queue_write(Q_ENT(q, q->llq.prod), ent, q->ent_dwords);
-	queue_inc_prod(&q->llq);
-	queue_sync_prod_out(q);
-	return 0;
-}
-
 static void queue_read(__le64 *dst, u64 *src, size_t n_dwords)
 {
 	int i;
@@ -875,20 +873,12 @@ static int arm_smmu_cmdq_build_cmd(u64 *cmd, struct arm_smmu_cmdq_ent *ent)
 		cmd[1] |= FIELD_PREP(CMDQ_PRI_1_RESP, ent->pri.resp);
 		break;
 	case CMDQ_OP_CMD_SYNC:
-		if (ent->sync.msiaddr)
+		if (ent->sync.msi)
 			cmd[0] |= FIELD_PREP(CMDQ_SYNC_0_CS, CMDQ_SYNC_0_CS_IRQ);
 		else
 			cmd[0] |= FIELD_PREP(CMDQ_SYNC_0_CS, CMDQ_SYNC_0_CS_SEV);
 		cmd[0] |= FIELD_PREP(CMDQ_SYNC_0_MSH, ARM_SMMU_SH_ISH);
 		cmd[0] |= FIELD_PREP(CMDQ_SYNC_0_MSIATTR, ARM_SMMU_MEMATTR_OIWB);
-		/*
-		 * Commands are written little-endian, but we want the SMMU to
-		 * receive MSIData, and thus write it back to memory, in CPU
-		 * byte order, so big-endian needs an extra byteswap here.
-		 */
-		cmd[0] |= FIELD_PREP(CMDQ_SYNC_0_MSIDATA,
-				     cpu_to_le32(ent->sync.msidata));
-		cmd[1] |= ent->sync.msiaddr & CMDQ_SYNC_1_MSIADDR_MASK;
 		break;
 	default:
 		return -ENOENT;
@@ -897,6 +887,20 @@ static int arm_smmu_cmdq_build_cmd(u64 *cmd, struct arm_smmu_cmdq_ent *ent)
 	return 0;
 }
 
+static void arm_smmu_cmdq_cmd_set_msi_addr(u64 *cmd, struct arm_smmu_cmdq *cmdq,
+					   u32 prod)
+{
+	struct arm_smmu_queue *q = &cmdq->q;
+	dma_addr_t addr = q->base_dma;
+
+	/*
+	 * Beware that Hi16xx adds an extra 32 bits of goodness to its MSI
+	 * payload, so the write will zero the entire command on that platform.
+	 */
+	addr += Q_IDX(&q->llq, prod) * q->ent_dwords * 8;
+	cmd[1] |= (u64)addr & CMDQ_SYNC_1_MSIADDR_MASK;
+}
+
 static void arm_smmu_cmdq_skip_err(struct arm_smmu_device *smmu)
 {
 	static const char *cerror_str[] = {
@@ -955,109 +959,371 @@ static void arm_smmu_cmdq_skip_err(struct arm_smmu_device *smmu)
 	queue_write(Q_ENT(q, cons), cmd, q->ent_dwords);
 }
 
-static void arm_smmu_cmdq_insert_cmd(struct arm_smmu_device *smmu, u64 *cmd)
+/*
+ * Command queue locking.
+ * This is a form of bastardised rwlock with the following major changes:
+ *
+ * - The only LOCK routines are exclusive_trylock() and shared_lock().
+ *   Neither have barrier semantics, and instead provide only a control
+ *   dependency.
+ *
+ * - The UNLOCK routines are supplemented with shared_tryunlock(), which
+ *   fails if the caller appears to be the last lock holder (yes, this is
+ *   racy). All successful UNLOCK routines have RELEASE semantics.
+ */
+static void arm_smmu_cmdq_shared_lock(struct arm_smmu_cmdq *cmdq)
 {
-	struct arm_smmu_queue *q = &smmu->cmdq.q;
-	bool wfe = !!(smmu->features & ARM_SMMU_FEAT_SEV);
+	int val;
+
+	do {
+		val = atomic_cond_read_relaxed(&cmdq->lock, VAL >= 0);
+	} while (atomic_cmpxchg_relaxed(&cmdq->lock, val, val + 1) != val);
+}
 
-	smmu->prev_cmd_opcode = FIELD_GET(CMDQ_0_OP, cmd[0]);
+static void arm_smmu_cmdq_shared_unlock(struct arm_smmu_cmdq *cmdq)
+{
+	(void)atomic_dec_return_release(&cmdq->lock);
+}
 
-	while (queue_insert_raw(q, cmd) == -ENOSPC) {
-		if (queue_poll_cons(q, false, wfe))
-			dev_err_ratelimited(smmu->dev, "CMDQ timeout\n");
+static bool arm_smmu_cmdq_shared_tryunlock(struct arm_smmu_cmdq *cmdq)
+{
+	if (atomic_read(&cmdq->lock) == 1)
+		return false;
+
+	arm_smmu_cmdq_shared_unlock(cmdq);
+	return true;
+}
+
+#define arm_smmu_cmdq_exclusive_trylock_irqsave(cmdq, flags)		\
+({									\
+	bool __ret;							\
+	local_irq_save(flags);						\
+	__ret = !atomic_cmpxchg_relaxed(&cmdq->lock, 0, -1);		\
+	if (!__ret)							\
+		local_irq_restore(flags);				\
+	__ret;								\
+})
+
+#define arm_smmu_cmdq_exclusive_unlock_irqrestore(cmdq, flags)		\
+({									\
+	atomic_set_release(&cmdq->lock, 0);				\
+	local_irq_restore(flags);					\
+})
+
+/*
+ * Command queue insertion.
+ * This is made fiddly by our attempts to achieve some sort of scalability
+ * since there is one queue shared amongst all of the CPUs in the system.  If
+ * you like mixed-size concurrency, dependency ordering and relaxed atomics,
+ * then you'll *love* this monstrosity.
+ *
+ * The basic idea is to split the queue up into ranges of commands that are
+ * owned by a given CPU; the owner may not have written all of the commands
+ * itself, but is responsible for advancing the hardware prod pointer when
+ * the time comes. The algorithm is roughly:
+ *
+ * 	1. Allocate some space in the queue. At this point we also discover
+ *	   whether the head of the queue is currently owned by another CPU,
+ *	   or whether we are the owner.
+ *
+ *	2. Write our command into our allocated slot in the queue.
+ *
+ *	3. Mark our slot as valid in arm_smmu_cmdq.valid_map.
+ *
+ *	4. If we are an owner:
+ *		a. Wait for the previous owner to finish.
+ *		b. Mark the queue head as unowned, which tells us the range
+ *		   that we are responsible for publishing.
+ *		c. Wait for all commands in our owned range to become valid.
+ *		d. Advance the hardware prod pointer.
+ *		e. Tell the next owner we've finished.
+ *
+ *	5. If we are inserting a CMD_SYNC (we may or may not have been an
+ *	   owner), then we need to stick around until it has completed:
+ *		a. If we have MSIs, the SMMU can write back into the CMD_SYNC
+ *		   to clear the first 4 bytes.
+ *		b. Otherwise, we spin waiting for the hardware cons pointer to
+ *		   advance past our command.
+ *
+ * The devil is in the details, particularly the use of locking for handling
+ * SYNC completion and freeing up space in the queue before we think that it is
+ * full.
+ */
+
+/* Wait for all entries in the range [sprod, eprod) to become valid */
+static void arm_smmu_cmdq_poll_valid_map(struct arm_smmu_cmdq *cmdq,
+					 u32 sprod, u32 eprod)
+{
+	u32 swidx, sbidx, ewidx, ebidx;
+	struct arm_smmu_ll_queue llq = {
+		.max_n_shift	= cmdq->q.llq.max_n_shift,
+		.prod		= sprod,
+	};
+
+	ewidx = BIT_WORD(Q_IDX(&llq, eprod));
+	ebidx = Q_IDX(&llq, eprod) % BITS_PER_LONG;
+
+	while (llq.prod != eprod) {
+		unsigned long mask, valid, *ptr;
+		u32 limit = BITS_PER_LONG;
+
+		swidx = BIT_WORD(Q_IDX(&llq, llq.prod));
+		sbidx = Q_IDX(&llq, llq.prod) % BITS_PER_LONG;
+
+		ptr = &cmdq->valid_map[swidx];
+
+		if ((swidx == ewidx) && (sbidx < ebidx))
+			limit = ebidx;
+
+		mask = GENMASK(limit - 1, sbidx);
+
+		/*
+		 * The valid bit is the inverse of the wrap bit. This means
+		 * that a zero-initialised queue is invalid and, after marking
+		 * all entries as valid, they become invalid again when we
+		 * wrap.
+		 */
+		valid = ULONG_MAX + !!Q_WRP(&llq, llq.prod);
+		smp_cond_load_relaxed(ptr, (VAL & mask) == (valid & mask));
+		llq.prod = queue_inc_prod_n(&llq, limit - sbidx);
 	}
 }
 
-static void arm_smmu_cmdq_issue_cmd(struct arm_smmu_device *smmu,
-				    struct arm_smmu_cmdq_ent *ent)
+/* Wait for the command queue to become non-full */
+static int arm_smmu_cmdq_poll_until_space(struct arm_smmu_device *smmu,
+					  struct arm_smmu_ll_queue *llq)
 {
-	u64 cmd[CMDQ_ENT_DWORDS];
 	unsigned long flags;
+	struct arm_smmu_queue_poll qp;
+	struct arm_smmu_cmdq *cmdq = &smmu->cmdq;
+	int ret = 0;
 
-	if (arm_smmu_cmdq_build_cmd(cmd, ent)) {
-		dev_warn(smmu->dev, "ignoring unknown CMDQ opcode 0x%x\n",
-			 ent->opcode);
-		return;
+	/*
+	 * Try to update our copy of cons by grabbing exclusive cmdq access. If
+	 * that fails, spin until somebody else updates it for us.
+	 */
+	if (arm_smmu_cmdq_exclusive_trylock_irqsave(cmdq, flags)) {
+		WRITE_ONCE(cmdq->q.llq.cons, readl_relaxed(cmdq->q.cons_reg));
+		arm_smmu_cmdq_exclusive_unlock_irqrestore(cmdq, flags);
+		llq->val = READ_ONCE(cmdq->q.llq.val);
+		return 0;
 	}
 
-	spin_lock_irqsave(&smmu->cmdq.lock, flags);
-	arm_smmu_cmdq_insert_cmd(smmu, cmd);
-	spin_unlock_irqrestore(&smmu->cmdq.lock, flags);
+	queue_poll_init(smmu, &qp);
+	do {
+		llq->val = READ_ONCE(smmu->cmdq.q.llq.val);
+		if (!queue_full(llq))
+			break;
+
+		ret = queue_poll(&qp);
+	} while (!ret);
+
+	return ret;
 }
 
 /*
- * The difference between val and sync_idx is bounded by the maximum size of
- * a queue at 2^20 entries, so 32 bits is plenty for wrap-safe arithmetic.
+ * Wait until the SMMU signals a CMD_SYNC completion MSI.
+ * Must be called with the cmdq lock held in some capacity.
  */
-static int __arm_smmu_sync_poll_msi(struct arm_smmu_device *smmu, u32 sync_idx)
+static int arm_smmu_cmdq_poll_until_msi(struct arm_smmu_device *smmu,
+					struct arm_smmu_ll_queue *llq)
 {
-	ktime_t timeout;
-	u32 val;
+	int ret = 0;
+	struct arm_smmu_queue_poll qp;
+	struct arm_smmu_cmdq *cmdq = &smmu->cmdq;
+	u32 *cmd = (u32 *)(Q_ENT(&cmdq->q, llq->prod));
 
-	timeout = ktime_add_us(ktime_get(), ARM_SMMU_CMDQ_SYNC_TIMEOUT_US);
-	val = smp_cond_load_acquire(&smmu->sync_count,
-				    (int)(VAL - sync_idx) >= 0 ||
-				    !ktime_before(ktime_get(), timeout));
+	queue_poll_init(smmu, &qp);
 
-	return (int)(val - sync_idx) < 0 ? -ETIMEDOUT : 0;
+	/*
+	 * The MSI won't generate an event, since it's being written back
+	 * into the command queue.
+	 */
+	qp.wfe = false;
+	smp_cond_load_relaxed(cmd, !VAL || (ret = queue_poll(&qp)));
+	llq->cons = ret ? llq->prod : queue_inc_prod_n(llq, 1);
+	return ret;
 }
 
-static int __arm_smmu_cmdq_issue_sync_msi(struct arm_smmu_device *smmu)
+/*
+ * Wait until the SMMU cons index passes llq->prod.
+ * Must be called with the cmdq lock held in some capacity.
+ */
+static int arm_smmu_cmdq_poll_until_consumed(struct arm_smmu_device *smmu,
+					     struct arm_smmu_ll_queue *llq)
 {
-	u64 cmd[CMDQ_ENT_DWORDS];
-	unsigned long flags;
-	struct arm_smmu_cmdq_ent ent = {
-		.opcode = CMDQ_OP_CMD_SYNC,
-		.sync	= {
-			.msiaddr = virt_to_phys(&smmu->sync_count),
-		},
-	};
+	struct arm_smmu_queue_poll qp;
+	struct arm_smmu_cmdq *cmdq = &smmu->cmdq;
+	u32 prod = llq->prod;
+	int ret = 0;
 
-	spin_lock_irqsave(&smmu->cmdq.lock, flags);
+	queue_poll_init(smmu, &qp);
+	llq->val = READ_ONCE(smmu->cmdq.q.llq.val);
+	do {
+		if (queue_consumed(llq, prod))
+			break;
 
-	/* Piggy-back on the previous command if it's a SYNC */
-	if (smmu->prev_cmd_opcode == CMDQ_OP_CMD_SYNC) {
-		ent.sync.msidata = smmu->sync_nr;
-	} else {
-		ent.sync.msidata = ++smmu->sync_nr;
-		arm_smmu_cmdq_build_cmd(cmd, &ent);
-		arm_smmu_cmdq_insert_cmd(smmu, cmd);
-	}
+		ret = queue_poll(&qp);
 
-	spin_unlock_irqrestore(&smmu->cmdq.lock, flags);
+		/*
+		 * This needs to be a readl() so that our subsequent call
+		 * to arm_smmu_cmdq_shared_tryunlock() can fail accurately.
+		 *
+		 * Specifically, we need to ensure that we observe all
+		 * shared_lock()s by other CMD_SYNCs that share our owner,
+		 * so that a failing call to tryunlock() means that we're
+		 * the last one out and therefore we can safely advance
+		 * cmdq->q.llq.cons. Roughly speaking:
+		 *
+		 * CPU 0		CPU1			CPU2 (us)
+		 *
+		 * if (sync)
+		 * 	shared_lock();
+		 *
+		 * dma_wmb();
+		 * change_bit(valid_map)
+		 *
+		 * 			if (owner) {
+		 *				poll_valid_map();
+		 *				<control dependency>
+		 *				writel(prod_reg);
+		 *
+		 *						readl(cons_reg);
+		 *						tryunlock();
+		 *
+		 * Requires us to see CPU 0's shared_lock() acquisition.
+		 */
+		llq->cons = readl(cmdq->q.cons_reg);
+	} while (!ret);
 
-	return __arm_smmu_sync_poll_msi(smmu, ent.sync.msidata);
+	return ret;
 }
 
-static int __arm_smmu_cmdq_issue_sync(struct arm_smmu_device *smmu)
+static int arm_smmu_cmdq_issue_cmd(struct arm_smmu_device *smmu,
+				    struct arm_smmu_cmdq_ent *ent)
 {
 	u64 cmd[CMDQ_ENT_DWORDS];
 	unsigned long flags;
-	bool wfe = !!(smmu->features & ARM_SMMU_FEAT_SEV);
-	struct arm_smmu_cmdq_ent ent = { .opcode = CMDQ_OP_CMD_SYNC };
-	int ret;
+	bool owner, sync = (ent->opcode == CMDQ_OP_CMD_SYNC);
+	struct arm_smmu_cmdq *cmdq = &smmu->cmdq;
+	struct arm_smmu_ll_queue llq = {
+		.max_n_shift = cmdq->q.llq.max_n_shift,
+	}, head = llq;
+	int ret = 0;
+
+	if (arm_smmu_cmdq_build_cmd(cmd, ent)) {
+		dev_warn(smmu->dev, "ignoring unknown CMDQ opcode 0x%x\n",
+			 ent->opcode);
+		return -EINVAL;
+	}
+
+	/* 1. Allocate some space in the queue */
+	local_irq_save(flags);
+	do {
+		llq.val = READ_ONCE(cmdq->q.llq.val);
+
+		while (queue_full(&llq)) {
+			local_irq_restore(flags);
+			if (arm_smmu_cmdq_poll_until_space(smmu, &llq))
+				dev_err_ratelimited(smmu->dev, "CMDQ timeout\n");
+			local_irq_save(flags);
+		}
+
+		head.val = llq.val;
+		queue_inc_prod(&head);
+		owner = !(llq.prod & CMDQ_PROD_OWNED_FLAG);
+		if (owner)
+			head.prod |= CMDQ_PROD_OWNED_FLAG;
+	} while (cmpxchg_relaxed(&cmdq->q.llq.val, llq.val, head.val) != llq.val);
+
+	/*
+	 * 2. Write our command into the queue
+	 * Dependency ordering from the cmpxchg() loop above.
+	 */
+	if (sync && ent->sync.msi)
+		arm_smmu_cmdq_cmd_set_msi_addr(cmd, cmdq, llq.prod);
+	queue_write(Q_ENT(&cmdq->q, llq.prod), cmd, CMDQ_ENT_DWORDS);
+
+	/*
+	 * In order to determine completion of our CMD_SYNC, we must ensure
+	 * that the queue can't wrap twice without us noticing. We achieve that
+	 * by taking the cmdq lock as shared before marking our slot as valid.
+	 */
+	if (sync)
+		arm_smmu_cmdq_shared_lock(cmdq);
+
+	/* 3. Mark our slot as valid, ensuring command is visible first */
+	dma_wmb();
+	change_bit(Q_IDX(&llq, llq.prod), cmdq->valid_map);
+
+	/* 4. If we are the owner, take control of the SMMU hardware */
+	if (owner) {
+		u32 prod;
 
-	arm_smmu_cmdq_build_cmd(cmd, &ent);
+		/* a. Wait for previous owner to finish */
+		atomic_cond_read_relaxed(&cmdq->owner_prod, VAL == llq.prod);
 
-	spin_lock_irqsave(&smmu->cmdq.lock, flags);
-	arm_smmu_cmdq_insert_cmd(smmu, cmd);
-	ret = queue_poll_cons(&smmu->cmdq.q, true, wfe);
-	spin_unlock_irqrestore(&smmu->cmdq.lock, flags);
+		/* b. Stop gathering work by clearing the owned flag */
+		prod = atomic_fetch_andnot_relaxed(CMDQ_PROD_OWNED_FLAG,
+						   &cmdq->q.llq.atomic.prod);
+		prod &= ~CMDQ_PROD_OWNED_FLAG;
+		head.prod &= ~CMDQ_PROD_OWNED_FLAG;
 
+		/* c. Wait for any gathered work to be written to the queue */
+		if (head.prod != prod)
+			arm_smmu_cmdq_poll_valid_map(cmdq, llq.prod, prod);
+
+		/*
+		 * d. Advance the hardware prod pointer
+		 * Control dependency ordering from the entries becoming valid.
+		 */
+		writel_relaxed(prod, cmdq->q.prod_reg);
+
+		/*
+		 * e. Tell the next owner we're done
+		 * Make sure we've updated the hardware first, so that we don't
+		 * race to update prod and potentially move it backwards.
+		 */
+		atomic_set_release(&cmdq->owner_prod, prod);
+	}
+
+	/* 5. If we are inserting a CMD_SYNC, we must wait for it to complete */
+	if (sync) {
+		ret = ent->sync.msi ?
+		      arm_smmu_cmdq_poll_until_msi(smmu, &llq) :
+		      arm_smmu_cmdq_poll_until_consumed(smmu, &llq);
+
+		if (ret) {
+			dev_err_ratelimited(smmu->dev,
+					    "CMD_SYNC %s timeout [hwprod 0x%08x, hwcons 0x%08x]\n",
+					    ent->sync.msi ? "MSI" : "polling",
+					    readl_relaxed(cmdq->q.prod_reg),
+					    readl_relaxed(cmdq->q.cons_reg));
+		}
+
+		/*
+		 * Try to unlock the cmq lock. This will fail if we're the last
+		 * reader, in which case we can safely update cmdq->q.llq.cons
+		 */
+		if (!arm_smmu_cmdq_shared_tryunlock(cmdq)) {
+			WRITE_ONCE(cmdq->q.llq.cons, llq.cons);
+			arm_smmu_cmdq_shared_unlock(cmdq);
+		}
+	}
+
+	local_irq_restore(flags);
 	return ret;
 }
 
 static int arm_smmu_cmdq_issue_sync(struct arm_smmu_device *smmu)
 {
-	int ret;
-	bool msi = (smmu->features & ARM_SMMU_FEAT_MSI) &&
-		   (smmu->features & ARM_SMMU_FEAT_COHERENCY);
+	struct arm_smmu_cmdq_ent ent = {
+		.opcode = CMDQ_OP_CMD_SYNC,
+		.sync.msi = (smmu->features & ARM_SMMU_FEAT_MSI) &&
+			    (smmu->features & ARM_SMMU_FEAT_COHERENCY),
+	};
 
-	ret = msi ? __arm_smmu_cmdq_issue_sync_msi(smmu)
-		  : __arm_smmu_cmdq_issue_sync(smmu);
-	if (ret)
-		dev_err_ratelimited(smmu->dev, "CMD_SYNC timeout\n");
-	return ret;
+	return arm_smmu_cmdq_issue_cmd(smmu, &ent);
 }
 
 /* Context descriptor manipulation functions */
@@ -1581,9 +1847,9 @@ static void arm_smmu_tlb_inv_context(void *cookie)
 	/*
 	 * NOTE: when io-pgtable is in non-strict mode, we may get here with
 	 * PTEs previously cleared by unmaps on the current CPU not yet visible
-	 * to the SMMU. We are relying on the DSB implicit in
-	 * queue_sync_prod_out() to guarantee those are observed before the
-	 * TLBI. Do be careful, 007.
+	 * to the SMMU. We are relying on the dma_wmb() implicit during cmd
+	 * insertion to guarantee those are observed before the TLBI. Do be
+	 * careful, 007.
 	 */
 	arm_smmu_cmdq_issue_cmd(smmu, &cmd);
 	arm_smmu_cmdq_issue_sync(smmu);
@@ -2330,18 +2596,49 @@ static int arm_smmu_init_one_queue(struct arm_smmu_device *smmu,
 	return 0;
 }
 
+static void arm_smmu_cmdq_free_bitmap(void *data)
+{
+	unsigned long *bitmap = data;
+	bitmap_free(bitmap);
+}
+
+static int arm_smmu_cmdq_init(struct arm_smmu_device *smmu)
+{
+	int ret = 0;
+	struct arm_smmu_cmdq *cmdq = &smmu->cmdq;
+	unsigned int nents = 1 << cmdq->q.llq.max_n_shift;
+	unsigned long *bitmap;
+
+	atomic_set(&cmdq->owner_prod, 0);
+	atomic_set(&cmdq->lock, 0);
+
+	bitmap = bitmap_zalloc(nents, GFP_KERNEL);
+	if (!bitmap) {
+		dev_err(smmu->dev, "failed to allocate cmdq bitmap\n");
+		ret = -ENOMEM;
+	} else {
+		cmdq->valid_map = bitmap;
+		devm_add_action(smmu->dev, arm_smmu_cmdq_free_bitmap, bitmap);
+	}
+
+	return ret;
+}
+
 static int arm_smmu_init_queues(struct arm_smmu_device *smmu)
 {
 	int ret;
 
 	/* cmdq */
-	spin_lock_init(&smmu->cmdq.lock);
 	ret = arm_smmu_init_one_queue(smmu, &smmu->cmdq.q, ARM_SMMU_CMDQ_PROD,
 				      ARM_SMMU_CMDQ_CONS, CMDQ_ENT_DWORDS,
 				      "cmdq");
 	if (ret)
 		return ret;
 
+	ret = arm_smmu_cmdq_init(smmu);
+	if (ret)
+		return ret;
+
 	/* evtq */
 	ret = arm_smmu_init_one_queue(smmu, &smmu->evtq.q, ARM_SMMU_EVTQ_PROD,
 				      ARM_SMMU_EVTQ_CONS, EVTQ_ENT_DWORDS,
@@ -2922,9 +3219,15 @@ static int arm_smmu_device_hw_probe(struct arm_smmu_device *smmu)
 	/* Queue sizes, capped to ensure natural alignment */
 	smmu->cmdq.q.llq.max_n_shift = min_t(u32, CMDQ_MAX_SZ_SHIFT,
 					     FIELD_GET(IDR1_CMDQS, reg));
-	if (!smmu->cmdq.q.llq.max_n_shift) {
-		/* Odd alignment restrictions on the base, so ignore for now */
-		dev_err(smmu->dev, "unit-length command queue not supported\n");
+	if (smmu->cmdq.q.llq.max_n_shift < ilog2(BITS_PER_LONG)) {
+		/*
+		 * The cmdq valid_map relies on the total number of entries
+		 * being a multiple of BITS_PER_LONG. There's also no way
+		 * we can handle the weird alignment restrictions on the
+		 * base pointer for a unit-length queue.
+		 */
+		dev_err(smmu->dev, "command queue size < %d entries not supported\n",
+			ilog2(BITS_PER_LONG));
 		return -ENXIO;
 	}
 
-- 
2.11.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
