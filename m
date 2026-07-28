Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39E6241684A
	for <iommu@lists.linux.dev>; Tue, 28 Jul 2026 21:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785272998; cv=none; b=N6/99vb70RY8ZD5n9wY9in/2zRzy1jWAPn0/XHSAyscKac94ZLH41/EXWVIRUrcogv4RrUEFwRpIUSqbU85/ewm87Z7q8Rypa7JiqfLSK+pCDHs+/lMLDwzy8ZrrbtIpLlMH2/wOAA78t1kJa8D9gLKGP3zgE6KFUWegYWASd5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785272998; c=relaxed/simple;
	bh=rJx8TtomSQ6+u2LqrSa3vF95of08fws1Tbdo0pTBm3A=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=BhlqkLxeSTNKk5ScF1rEmYLWX5tO/IHBYM5CfNG+14k1i3pBwTX3g0RGMZL9qhXvPC2tUlPGfk9eogrWT1St3KqxjgF/rC+7qdTORiR9WugkB3xyiS7OABe0REuozlwkoevKNmgBk8PxgcVOHgBL0m7f/WLRL7FC5fljFpo62rU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=b2moylEk; arc=none smtp.client-ip=209.85.210.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="b2moylEk"
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-84e0234967aso188121b3a.3
        for <iommu@lists.linux.dev>; Tue, 28 Jul 2026 14:09:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785272996; x=1785877796; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kvjxKrjDPnLW7mSd0bC/dty786L2bKvGu4lVRdTEVq8=;
        b=b2moylEkSvlSoHO+ETE777bSmpg/OMf5wXEHvHymeB+3GeubWLoClOywCMulBZA8tl
         Tf9b94iF2vFZVSLZwlpcvhljvWbSfJAzcSrJxSU1xz4yuzcRP2JwdBFPAzzWeukUvihl
         PXbv9noBNai1DBzFtwDlWzUnyQWEXt1Db696sK/0FQUMYykJ/YR2AbP91LOdFr0mdJRI
         ZH89n+4/cyVGOJg+O6gFFfeH67R3SVEwT/HSHZMegyXBIhPyVwgzWVJg+qcYT3AXE0HU
         Xq3tatgF5LZRaD6OQOYxXeMZF+mh8Q6ao7LoCmtcUdHJIeEvKswHYJSnIZevLw3xAlQ7
         nZvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785272996; x=1785877796;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kvjxKrjDPnLW7mSd0bC/dty786L2bKvGu4lVRdTEVq8=;
        b=CTqcA++k4hhkrL1DVkGdvHLJb21edJz7LXFuxzvGKFcjbR5pNLJzTqybpCjDgkiium
         Ob/ZTGEGhTnqkMl+c/BxObx2ACvWQGxOd3LdD3u16dOW1IXGb6vSm+si1kpz22IFtBoN
         VfoXgLmyua9qwUi+eKFlWTN74VNUTJjnxV5NUucwse18auMxuCQR09i5ZuN6LrzQvVTT
         FCH79v/POXeYW9dFTZZQ2pjwhgGbLYhCbxSELuDKtEkZDRCdtqNaOim7OFxZes+od/zA
         slM0JBHD0UHOVx6hieEw31NeSy52bvmIJwQ91RiN56XsJpwNbl6xWDsSKDIQAELi58ka
         NfRg==
X-Gm-Message-State: AOJu0YxZl9/+ew9uSJ7xaInUWRvzgR0lHubIcQiyjxIzIYmE2/uyJUoH
	hagtyNfMYlCEZ1WW+m5PxGN1MQGrMjOCiWjapuGiw/B4iDRSw/cRatakNbmVMm4vFEZ9Vk5uhHW
	C8XXjP7VuLH3+Xu6IpG8jQFi/pDdc0JRZkISfNSo9GoAE376/jU6CkR7dNI8djWDP+QXSJE2l5/
	bzfPu58/zNjjtQq1PBq/6QonaScDy1lA==
X-Received: from pgli32.prod.google.com ([2002:a63:1320:0:b0:c9a:eb48:4a8])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:b4e:b0:84c:1cd2:142b
 with SMTP id d2e1a72fcca58-84e932ca245mr4204240b3a.9.1785272995975; Tue, 28
 Jul 2026 14:09:55 -0700 (PDT)
Date: Tue, 28 Jul 2026 21:09:25 +0000
In-Reply-To: <20260728210928.1050849-1-praan@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260728210928.1050849-1-praan@google.com>
X-Mailer: git-send-email 2.55.0.487.gaf234c4eb3-goog
Message-ID: <20260728210928.1050849-10-praan@google.com>
Subject: [PATCH v9 09/12] iommu/arm-smmu-v3: Implement pm_runtime & system
 sleep ops
From: Pranjal Shrivastava <praan@google.com>
To: iommu@lists.linux.dev
Cc: Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>, 
	Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>, Mostafa Saleh <smostafa@google.com>, 
	Nicolin Chen <nicolinc@nvidia.com>, Daniel Mentz <danielmentz@google.com>, 
	linux-arm-kernel@lists.infradead.org, Pranjal Shrivastava <praan@google.com>
Content-Type: text/plain; charset="UTF-8"

Implement pm_runtime and system sleep ops for arm-smmu-v3.

The suspend callback configures the SMMU to abort new transactions,
disables the main translation unit and then drains the command queue
to ensure completion of any in-flight commands. A software gate
(STOP_FLAG) and synchronization barriers are used to quiesce the command
submission pipeline and ensure state consistency before power-off.

To prevent software metadata flags from leaking into physical registers
or polluting the tracking pointer, a newly introduced bitmask
(CMDQ_PROD_IDX_MASK) is applied to all register writes and tracking
updates.

The resume callback restores the MSI configuration and performs a full
device reset via `arm_smmu_device_reset` to bring the SMMU back to an
operational state. The MSIs are cached during the msi_write and are
restored during the resume operation by using the helper. The STOP_FLAG
is cleared only after the CMDQ is enabled in hardware.

Suggested-by: Daniel Mentz <danielmentz@google.com>
Signed-off-by: Pranjal Shrivastava <praan@google.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 233 +++++++++++++++++++-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  15 ++
 2 files changed, 242 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 49e15d062dd5..5f0e01dc4f6a 100644
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
@@ -730,10 +770,58 @@ int __arm_smmu_cmdq_issue_cmdlist(struct arm_smmu_device *smmu,
 
 		/*
 		 * If the SMMU is suspended/suspending, any new CMDs are elided.
-		 * This loop is the Point of Commitment. If we haven't cmpxchg'd
-		 * our new indices yet, we can safely bail. Once the indices are
-		 * committed, we MUST write valid commands to those slots to
-		 * avoid indefinite polling in the drain function.
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
+		 *    arm_smmu_drain_queues();        |     // reserve indices
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
@@ -798,7 +886,8 @@ int __arm_smmu_cmdq_issue_cmdlist(struct arm_smmu_device *smmu,
 		/* b. Stop gathering work by clearing the owned flag */
 		prod = atomic_fetch_andnot_relaxed(CMDQ_PROD_OWNED_FLAG,
 						   &cmdq->q.llq.atomic.prod);
-		prod &= ~CMDQ_PROD_OWNED_FLAG;
+		/* Strip all metadata flags */
+		prod &= CMDQ_PROD_IDX_MASK;
 
 		/*
 		 * c. Wait for any gathered work to be written to the queue.
@@ -4995,7 +5084,8 @@ static int arm_smmu_device_reset(struct arm_smmu_device *smmu)
 
 	/* Command queue */
 	writeq_relaxed(smmu->cmdq.q.q_base, smmu->base + ARM_SMMU_CMDQ_BASE);
-	writel_relaxed(smmu->cmdq.q.llq.prod, smmu->base + ARM_SMMU_CMDQ_PROD);
+	writel_relaxed(smmu->cmdq.q.llq.prod & CMDQ_PROD_IDX_MASK,
+		       smmu->base + ARM_SMMU_CMDQ_PROD);
 	writel_relaxed(smmu->cmdq.q.llq.cons, smmu->base + ARM_SMMU_CMDQ_CONS);
 
 	enables = CR0_CMDQEN;
@@ -5006,6 +5096,9 @@ static int arm_smmu_device_reset(struct arm_smmu_device *smmu)
 		return ret;
 	}
 
+	/* Clear the STOP_FLAG to resume CMDQ submissions */
+	atomic_andnot(CMDQ_PROD_STOP_FLAG, &smmu->cmdq.q.llq.atomic.prod);
+
 	/* Invalidate any cached configuration */
 	arm_smmu_cmdq_issue_cmd_with_sync(smmu, arm_smmu_make_cmd_cfgi_all());
 
@@ -5746,6 +5839,133 @@ static void arm_smmu_device_shutdown(struct platform_device *pdev)
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
+	/* Disable the SMMU via CR0.EN and all queues except CMDQ */
+	enables = CR0_CMDQEN;
+	ret = arm_smmu_write_reg_sync(smmu, enables, ARM_SMMU_CR0, ARM_SMMU_CR0ACK);
+	if (ret) {
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
+	ret = arm_smmu_drain_queues(smmu);
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
+	/* Avoid consuming stale commands if we timed-out to drain the queues */
+	if (ret || !timeout)
+		cmdq->q.llq.cons = cmdq->q.llq.prod & CMDQ_PROD_IDX_MASK;
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
+	ret = arm_smmu_device_reset(smmu);
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
@@ -5762,6 +5982,7 @@ static struct platform_driver arm_smmu_driver = {
 	.driver	= {
 		.name			= "arm-smmu-v3",
 		.of_match_table		= arm_smmu_of_match,
+		.pm                     = &arm_smmu_pm_ops,
 		.suppress_bind_attrs	= true,
 	},
 	.probe	= arm_smmu_device_probe,
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index cc25f307a9e4..24b9969b0b90 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -658,11 +658,14 @@ arm_smmu_make_cmd_tlbi(enum arm_smmu_cmdq_opcode op, u16 asid, u16 vmid)
 
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
@@ -1227,6 +1230,18 @@ int arm_smmu_cmdq_issue_cmdlist(struct arm_smmu_device *smmu,
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
2.55.0.487.gaf234c4eb3-goog

