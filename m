Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1C335947E0
	for <iommu@lists.linux.dev>; Tue,  8 Sep 2026 17:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788887865; cv=none; b=fwut1QprVIPxEBkTksL9Tra7hBRKCiU5sAA1QiBc/GZDqwTChSDlor6Kg8DHAvC1CkE7AzEdtSJEceNQZzszGGoSrk1hNzWgfv1ATCysQurSrth9bGDMfs+2FEX9kwWIXx7NAmZ4g9YRDTsWIVzKwBKsd26qIjwRVz9pJx8vEY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788887865; c=relaxed/simple;
	bh=zjIf7K3Mkfr2rKcjFd1H2Z+pay4nSu7vmQxqMklLKwU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=RGYhkdGyNrTidZ2a0z+Z5L4RaG2rFFrT6aCn37PkCNSPKcb0xnhneRwCO4RWXeG5CTTyU6gIA7+uOGm/YdTtlzG3ZdGH7mgrOxVX6SRCj9mnFut2wnEp3PtoAksRrck/w9kAmz95LeX5fDImdCWazgD8FUJyuQjKpdRWAXhsZFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eA0cCp1L; arc=none smtp.client-ip=209.85.215.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eA0cCp1L"
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-cbee6bb8408so5927619a12.3
        for <iommu@lists.linux.dev>; Tue, 08 Sep 2026 10:17:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788887863; x=1789492663; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=g2N8e2H1e3+6am2yu8eJ4vnbIaibzyK1PtKYM9botJA=;
        b=eA0cCp1L2D3KJfkHmgwPivceIvFy4Lf+NXsF1+41lIG8m2MbBDyjUVb3lqVz2bnc3U
         agi18yQ5FN31DrPSJL4tzxEuxZNEYvl2UAaaA0SZyE5c4hiSKPUFaYzNNTqKgToFyInl
         bFYr9ZILinbaHl22MioNOct7YeGAIeYl8LT/BO9fWDFJuyMLhQAyj9gWEBJHgq6M7o33
         7m4YphoT/p3YFgh4Jt8t6klfkn91zzzc73pKLgquhCh2M6cv/aDdFLIMgpB4qpR6Mdar
         5hbGQjy0XvFCX6VnCTH7/l+7xk6idbIv3l5do1EtNb9RgsZikEmJqJvf0AzjjIjfiABj
         +RXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788887863; x=1789492663;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=g2N8e2H1e3+6am2yu8eJ4vnbIaibzyK1PtKYM9botJA=;
        b=V9e+eO3fDW4AedU/bFKL8+347UeErUc/W9j16lhVMRvY/MS64mLTZsedZQ5zXLnBcx
         u4qZJp3KLGz6hKk6gWD6sN6NWo559EKvppq5BU1QEkPLeajh+/UkemaqRu4iJUB6WU/R
         /pnOxvEj8pOZRzzKoIRvu3C/t3j1Rz5GKDLtB71spwIkCDbrS6SxowLh/1U/PqbPQ8eR
         OiS/QEgsHZPyEEN+HqNMi1yc/nGufkqg5MEsVccgeACl3nbBlJkYnGRRDQBORJ/1WaHE
         or3NCt8oNzUneJ4RQWJ9EeH+JPHJLCMSPKmi2DRCNCe/s+wVwlFhXywvnj4Vg2vCfz82
         S4Wg==
X-Gm-Message-State: AFuF++mQgxdYYHiQe1e2/tVHc7gmU3oYjj99X2Uib/k5Eis5Mkj5FeAJ
	lhKO3IkDy7x1OuKiWV+NZgt3MF+Btc/1KGlabBOCYYovXageNXwUVMKX2PsvAphuxq7F8KyylIu
	SN3R6cs8OqoON11B2bLILiNsv9oX5c8IgPaaLLwmeEJu6FgCe1wpT4oZVbMEB/CQwe8HH+vd/Jl
	6tOS0m10SZ0XJpm1ajdB10h86OBp6ZMQ==
X-Received: from pfblh18.prod.google.com ([2002:a05:6a00:7112:b0:863:9d90:a599])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:c490:b0:866:abd8:f112
 with SMTP id d2e1a72fcca58-866abd8f2bcmr8703014b3a.8.1788887862674; Tue, 08
 Sep 2026 10:17:42 -0700 (PDT)
Date: Tue,  8 Sep 2026 17:17:08 +0000
In-Reply-To: <20260908171712.356645-1-praan@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260908171712.356645-1-praan@google.com>
X-Mailer: git-send-email 2.55.0.979.g7e5102b832-goog
Message-ID: <20260908171712.356645-13-praan@google.com>
Subject: [PATCH v10 12/15] iommu/arm-smmu-v3: Implement pm_runtime & system
 sleep ops
From: Pranjal Shrivastava <praan@google.com>
To: iommu@lists.linux.dev
Cc: Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>, 
	Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>, Mostafa Saleh <smostafa@google.com>, 
	Nicolin Chen <nicolinc@nvidia.com>, Daniel Mentz <danielmentz@google.com>, 
	Ashish Mhetre <amhetre@nvidia.com>, linux-arm-kernel@lists.infradead.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, rafael@kernel.org, 
	Danilo Krummrich <dakr@kernel.org>, Thomas Gleixner <tglx@kernel.org>, driver-core@lists.linux.dev, 
	Pranjal Shrivastava <praan@google.com>
Content-Type: text/plain; charset="UTF-8"

Implement pm_runtime and system sleep ops for arm-smmu-v3.

The suspend callback configures the SMMU to abort transactions, disables
the main translation unit and then drains the command queue. A software
gate (STOP_FLAG) quiesces submissions before power-off. Since devlinks
ensure client devices are suspended before the SMMU, no client DMA can
occur, making EVTQ/PRIQ IRQ synchronization during suspend unnecessary.
Prod indices for EVTQ/PRIQ are synchronized via queue_sync_prod_in() to
retain unread entries across power cycles.

The resume callback restores the MSI configuration and performs a full
device reset via `arm_smmu_device_reset` to bring the SMMU back to an
operational state. The MSIs are cached during the msi_write and are
restored during the resume operation by using the helper. The STOP_FLAG
is cleared only after the CMDQ is enabled in hardware.

Standard SET_RUNTIME_PM_OPS() and SET_SYSTEM_SLEEP_PM_OPS() macros are
used to define dev_pm_ops, safely evaluating to NO_OPs when CONFIG_PM is
disabled. The new RPM helpers are marked __maybe_unused to keep
intermediate commits clean until invoked by respective handlers in the
subsequent patches.

Suggested-by: Daniel Mentz <danielmentz@google.com>
Signed-off-by: Pranjal Shrivastava <praan@google.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 255 +++++++++++++++++++-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  15 ++
 2 files changed, 265 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 7eb939888735..1c5d891564e4 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -29,6 +29,7 @@
 #include <linux/platform_device.h>
 #include <linux/sort.h>
 #include <linux/string_choices.h>
+#include <linux/pm_runtime.h>
 #include <kunit/visibility.h>
 #include <uapi/linux/iommufd.h>
 
@@ -119,6 +120,45 @@ static const char * const event_class_str[] = {
 static int arm_smmu_alloc_cd_tables(struct arm_smmu_master *master);
 static bool arm_smmu_ats_supported(struct arm_smmu_master *master);
 
+/* Runtime PM helpers */
+__maybe_unused static int arm_smmu_rpm_get(struct arm_smmu_device *smmu)
+{
+	int ret;
+
+	if (!pm_runtime_enabled(smmu->dev))
+		return 0;
+
+	ret = pm_runtime_resume_and_get(smmu->dev);
+	if (ret < 0) {
+		dev_err(smmu->dev, "failed to resume device: %d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+__maybe_unused static bool arm_smmu_rpm_get_if_active(struct arm_smmu_device *smmu)
+{
+	if (!pm_runtime_enabled(smmu->dev))
+		return true;
+
+	return pm_runtime_get_if_active(smmu->dev) > 0;
+}
+
+__maybe_unused static void arm_smmu_rpm_put(struct arm_smmu_device *smmu)
+{
+	int ret;
+
+	if (!pm_runtime_enabled(smmu->dev))
+		return;
+
+	ret = pm_runtime_put_autosuspend(smmu->dev);
+
+	/* -EAGAIN & -EBUSY aren't failures */
+	if (ret < 0 && ret != -EAGAIN && ret != -EBUSY)
+		dev_err(smmu->dev, "failed to suspend device: %d\n", ret);
+}
+
 static void parse_driver_options(struct arm_smmu_device *smmu)
 {
 	int i = 0;
@@ -729,10 +769,66 @@ int __arm_smmu_cmdq_issue_cmdlist(struct arm_smmu_device *smmu,
 
 		/*
 		 * If the SMMU is suspended/suspending, any new CMDs are elided.
-		 * This loop is the Point of Commitment. If we haven't cmpxchg'd
-		 * our new indices yet, we can safely bail. Once the indices are
-		 * committed, we MUST write valid commands to those slots to
-		 * avoid indefinite polling in the drain function.
+		 *
+		 * Note that eliding ATC invalidations (CMDQ_OP_ATC_INV) is safe
+		 * because client PCIe endpoints are guaranteed to be suspended
+		 * (via device links) before the SMMU is suspended. With the PCIe
+		 * links in a low-power state, no new TLPs can be transmitted.
+		 * It is strictly the responsibility of the client/endpoint driver
+		 * to quiesce DMA and ensure that the ATC state is cleared across
+		 * power state transitions.
+		 *
+		 * This loop acts as the Point of Commitment.
+		 * The CMDQ_PROD_STOP_FLAG ensures that no new commands are
+		 * committed once the SMMU begins to suspend. The synchronization
+		 * relies on the following observability invariants:
+		 *
+		 * 1. Other CPUs observe the STOP_FLAG only *after* the SMMU is
+		 *    disabled. This is enforced in arm_smmu_runtime_suspend()
+		 *    by using a fully ordered atomic_fetch_or() to set the flag,
+		 *    guaranteeing that SMMUEN=0 (with ABORT set) at the time of
+		 *    observation which ensures no in-memory structures are
+		 *    accessed by the SMMU (IHI0070 spec section 6.3.9.6).
+		 *
+		 * 2. Other CPUs observe the cleared STOP_FLAG before the SMMU
+		 *    is re-enabled. During resume, arm_smmu_device_reset()
+		 *    issues CFGI_ALL and TLBI_ALL commands *after* clearing the
+		 *    STOP_FLAG and before setting SMMUEN=1. The implicit
+		 *    dma_wmb() executed while submitting these commands ensures
+		 *    the cleared STOP_FLAG is visible to all other agents.
+		 *    Thus, any transition from a set STOP_FLAG to SMMUEN=1
+		 *    involves an invalidate-all operation prior to setting SMMUEN=1.
+		 *
+		 * Hence, if a CPU observes the STOP_FLAG, it is assured that:
+		 *  (a) Txns are blocked + No in-memory structures are accessed
+		 *  (b) If the SMMU is ever re-enabled, an invalidate-all is
+		 *      performed prior to it being enabled during reset.
+		 *
+		 * Note: The smp_mb() in arm_smmu_domain_inv_range() orders the
+		 * PTE update before the STOP_FLAG read, which ensures that if
+		 * CPU1 reads the STOP_FLAG and decides to elide the command,
+		 * the PTE update is already globally visible.
+		 *
+		 *  [CPU0]                            | [CPU1]
+		 *  arm_smmu_runtime_suspend() {      | [PTE update]
+		 *    SMMUEN = 0;                     | arm_smmu_domain_inv_range() {
+		 *    // set STOP_FLAG                |   smp_mb();
+		 *    target = atomic_fetch_or();     |   arm_smmu_cmdq_issue_cmdlist() {
+		 *    while (owner != target)         |     // read STOP_FLAG
+		 *      // wait for completion        |     Q_STOP(llq.prod);
+		 *    arm_smmu_drain_cmdqs();         |     // reserve indices
+		 *  }                                 |     cmpxchg(&cmdq->q.llq.atomic.prod);
+		 *  ...                               |     queue_write();
+		 *  arm_smmu_device_reset() {         |   }
+		 *    // clear STOP_FLAG              | }
+		 *    atomic_andnot();                |
+		 *    [Invalidate all TLB & CFG]      |
+		 *    SMMUEN = 1;                     |
+		 *  }                                 |
+		 *
+		 * If CPU1 hasn't cmpxchg'd its new indices yet, it observes the STOP_FLAG
+		 * and safely bails. Once the indices are committed, CPU1 MUST write valid
+		 * commands to those slots to avoid indefinite polling in CPU0's drain path.
 		 */
 		if (Q_STOP(llq.prod)) {
 			local_irq_restore(flags);
@@ -5087,7 +5183,8 @@ static int arm_smmu_device_reset(struct arm_smmu_device *smmu, bool resume)
 
 	/* Command queue */
 	writeq_relaxed(smmu->cmdq.q.q_base, smmu->base + ARM_SMMU_CMDQ_BASE);
-	writel_relaxed(smmu->cmdq.q.llq.prod, smmu->base + ARM_SMMU_CMDQ_PROD);
+	writel_relaxed(smmu->cmdq.q.llq.prod & CMDQ_PROD_IDX_MASK,
+		       smmu->base + ARM_SMMU_CMDQ_PROD);
 	writel_relaxed(smmu->cmdq.q.llq.cons, smmu->base + ARM_SMMU_CMDQ_CONS);
 
 	enables = CR0_CMDQEN;
@@ -5098,6 +5195,9 @@ static int arm_smmu_device_reset(struct arm_smmu_device *smmu, bool resume)
 		return ret;
 	}
 
+	/* Clear the STOP_FLAG to resume CMDQ submissions */
+	atomic_andnot(CMDQ_PROD_STOP_FLAG, &smmu->cmdq.q.llq.atomic.prod);
+
 	/* Invalidate any cached configuration */
 	arm_smmu_cmdq_issue_cmd_with_sync(smmu, arm_smmu_make_cmd_cfgi_all());
 
@@ -5849,6 +5949,150 @@ static void arm_smmu_device_shutdown(struct platform_device *pdev)
 	arm_smmu_device_disable(smmu);
 }
 
+static int __maybe_unused arm_smmu_runtime_suspend(struct device *dev)
+{
+	struct arm_smmu_device *smmu = dev_get_drvdata(dev);
+	struct arm_smmu_cmdq *cmdq = &smmu->cmdq;
+	int timeout = ARM_SMMU_SUSPEND_TIMEOUT_US;
+	u32 enables, target;
+	int ret;
+
+	/* Abort all transactions before disable to avoid spurious bypass */
+	arm_smmu_update_gbpa(smmu, GBPA_ABORT, 0);
+
+	/*
+	 * Disable the SMMU via CR0.EN and all queues except CMDQ.
+	 *
+	 * Note on EVTQ/PRIQ: Due to device links between client devices and
+	 * the SMMU, all masters are already runtime suspended and quiescent.
+	 * As client DMA is stopped, no new translation faults (EVTQ) or
+	 * Page Requests (PRIQ) can be generated, making it safe to disable
+	 * these queues without an explicit drain.
+	 */
+	enables = CR0_CMDQEN;
+	ret = arm_smmu_write_reg_sync(smmu, enables, ARM_SMMU_CR0, ARM_SMMU_CR0ACK);
+	if (ret) {
+		/* GBPA comes into effect when CR0.SMMUEN = 0, no rollback needed */
+		dev_err(smmu->dev, "failed to disable SMMU\n");
+		return ret;
+	}
+
+	/*
+	 * At this point the SMMU is completely disabled and won't access
+	 * any translation/config structures, even speculative accesses
+	 * aren't performed as per the IHI0070 spec (section 6.3.9.6).
+	 */
+
+	/*
+	 * Mark the primary CMDQ to stop and get the target index before the stop.
+	 *
+	 * Note that the primary CMDQ's STOP_FLAG acts as a proxy for the SMMU's
+	 * global power state. Because all queues are gated synchronously during
+	 * suspend, checking the primary queue's flag is sufficient.
+	 */
+	target = atomic_fetch_or(CMDQ_PROD_STOP_FLAG, &cmdq->q.llq.atomic.prod);
+	target &= CMDQ_PROD_IDX_MASK;
+
+
+	/* Wait for the last committed owner to reach the hardware */
+	while (atomic_read(&cmdq->owner_prod) != target && timeout) {
+		udelay(1);
+		timeout--;
+	}
+
+	/*
+	 * Entering suspend implies no active clients. A timeout here
+	 * indicates a fatal CMDQ lockup or hardware stall. We proceed
+	 * anyway to prioritize memory safety (avoiding stale TLBs)
+	 */
+	if (!timeout)
+		dev_err(smmu->dev, "cmdq owner wait timeout, (check runtime PM + devlinks)\n");
+
+	/* Wait for cmdq->lock == 0 to ensure last CMDQ_CONS_REG is written */
+	timeout = ARM_SMMU_SUSPEND_TIMEOUT_US;
+	while (atomic_read(&cmdq->lock) != 0 && timeout) {
+		udelay(1);
+		timeout--;
+	}
+
+	/* Timing out here implies misconfigured Runtime PM or broken devlinks */
+	if (!timeout)
+		dev_err(smmu->dev, "cmdq lock != 0, forcing suspend. Polling CPUs may fault.\n");
+
+	/* Drain the CMDQs */
+	ret = arm_smmu_drain_cmdqs(smmu);
+	if (ret)
+		dev_warn(smmu->dev, "failed to drain queues, forcing suspend\n");
+
+	/* Disable the SMMU */
+	arm_smmu_device_disable(smmu);
+
+	/* Disable IRQ generation */
+	arm_smmu_disable_irqs(smmu);
+
+	/* Wait for pending gerror handlers */
+	synchronize_irq(smmu->combined_irq ? smmu->combined_irq : smmu->gerr_irq);
+
+	/* Handle any pending gerrors before powering down */
+	arm_smmu_handle_gerror(smmu);
+
+	/* Sync prod pointer for EVTQ and PRIQ to avoid clobbering unread entries on resume */
+	if (queue_sync_prod_in(&smmu->evtq.q) == -EOVERFLOW)
+		dev_warn(smmu->dev, "EVTQ overflow detected during suspend\n");
+
+	if (smmu->features & ARM_SMMU_FEAT_PRI) {
+		if (queue_sync_prod_in(&smmu->priq.q) == -EOVERFLOW)
+			dev_warn(smmu->dev, "PRIQ overflow detected during suspend\n");
+	}
+
+	/* Avoid consuming stale commands on resume if we timed-out */
+	cmdq->q.llq.cons = cmdq->q.llq.prod & CMDQ_PROD_IDX_MASK;
+
+	dev_dbg(dev, "suspended smmu\n");
+
+	return 0;
+}
+
+static int __maybe_unused arm_smmu_runtime_resume(struct device *dev)
+{
+	struct arm_smmu_device *smmu = dev_get_drvdata(dev);
+	int ret;
+
+	/* Re-configure MSIs */
+	arm_smmu_resume_msis(smmu);
+
+	/* Clears the CMDQ_PROD_STOP_FLAG as well */
+	ret = arm_smmu_device_reset(smmu, true);
+	if (ret)
+		dev_err(dev, "failed to reset during resume operation: %d\n", ret);
+
+	dev_dbg(dev, "resumed smmu\n");
+
+	return ret;
+}
+
+static int __maybe_unused arm_smmu_pm_suspend(struct device *dev)
+{
+	if (pm_runtime_suspended(dev))
+		return 0;
+
+	return arm_smmu_runtime_suspend(dev);
+}
+
+static int __maybe_unused arm_smmu_pm_resume(struct device *dev)
+{
+	if (pm_runtime_suspended(dev))
+		return 0;
+
+	return arm_smmu_runtime_resume(dev);
+}
+
+static const struct dev_pm_ops arm_smmu_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(arm_smmu_pm_suspend, arm_smmu_pm_resume)
+	SET_RUNTIME_PM_OPS(arm_smmu_runtime_suspend,
+			   arm_smmu_runtime_resume, NULL)
+};
+
 static const struct of_device_id arm_smmu_of_match[] = {
 	{ .compatible = "arm,smmu-v3", },
 	{ },
@@ -5865,6 +6109,7 @@ static struct platform_driver arm_smmu_driver = {
 	.driver	= {
 		.name			= "arm-smmu-v3",
 		.of_match_table		= arm_smmu_of_match,
+		.pm                     = &arm_smmu_pm_ops,
 		.suppress_bind_attrs	= true,
 	},
 	.probe	= arm_smmu_device_probe,
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 0a841441cc44..d0a3d497915c 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -663,11 +663,14 @@ arm_smmu_make_cmd_tlbi(enum arm_smmu_cmdq_opcode op, u16 asid, u16 vmid)
 
 /* High-level queue structures */
 #define ARM_SMMU_POLL_TIMEOUT_US	1000000 /* 1s! */
+#define ARM_SMMU_SUSPEND_TIMEOUT_US	1000000	/* 1s! */
 #define ARM_SMMU_POLL_SPIN_COUNT	10
 
 #define MSI_IOVA_BASE			0x8000000
 #define MSI_IOVA_LENGTH			0x100000
 
+#define RPM_AUTOSUSPEND_DELAY_MS	15
+
 struct arm_smmu_ll_queue {
 	union {
 		u64			val;
@@ -1234,6 +1237,18 @@ int arm_smmu_cmdq_issue_cmdlist(struct arm_smmu_device *smmu,
 				bool sync);
 bool arm_smmu_erratum_repeat_tlbi_cfgi(void);
 
+/*
+ * Lockless pre-check to test if the SMMU is actively powered.
+ * Races with concurrent suspend are benign: the cmpxchg loop in
+ * arm_smmu_cmdq_issue_cmdlist() acts as the true commit point.
+ * If we lose the race, that loop observes Q_STOP == 1 and safely
+ * drops the command. If we win, the suspend thread waits for us.
+ */
+static inline bool arm_smmu_is_active(struct arm_smmu_device *smmu)
+{
+	return !Q_STOP(READ_ONCE(smmu->cmdq.q.llq.prod));
+}
+
 #ifdef CONFIG_ARM_SMMU_V3_SVA
 bool arm_smmu_sva_supported(struct arm_smmu_device *smmu);
 void arm_smmu_sva_notifier_synchronize(void);
-- 
2.55.0.979.g7e5102b832-goog

