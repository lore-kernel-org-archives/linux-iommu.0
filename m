Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6299349CE1
	for <iommu@lists.linux.dev>; Mon,  1 Jun 2026 21:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780351173; cv=none; b=dizp993uXk1hcSik0Bm9USUaLzPRXbjwABP4iY0o5k1rIwCcNYmnG0Xk0wG0kU0IQf4HqDXvJnJ/0vRE/5F5lNWUi0gPDeoishqKhA/LxPT7nbxO0HlnyavqKEoa0Y9P+V+vvSaAltfpT2Vl1no4l/ITRr0tiwYOsC+nuzTVJyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780351173; c=relaxed/simple;
	bh=ZMRixVbCudZR65Dza8Mr43fCzHJZzYdv+YXt3Adn6Is=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=sWY7VmNC2oqwi2m2t+9BGPEkkdZXeZpoF6XedeU5bzkN+GTSLerqoESszD7e1l+bXhLXCC4D1G/zFuVAUV6eBqOR/y8b24PPDovwGysVVgWItRu9t4I2llb5A4iOZDgas1l/mYy5raTcl97dgUqG7ob735QaMlODPgb6pI0bvG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=f98nfUSp; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="f98nfUSp"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2bf160f7191so21409815ad.3
        for <iommu@lists.linux.dev>; Mon, 01 Jun 2026 14:59:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780351171; x=1780955971; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Rg+/1CKy1BOtonhw8GAQavpaE5sBngLputrohP126YA=;
        b=f98nfUSp7mXPvspRbHpWLXkGRjtYyvr6x9ryPsWIzj1S+cahgE1BR01M1xFxdjnVh/
         c9Epi+A52KCWIwqNWpweLPARCc4Vzvlv5mA7tInRE+c85AjSc/Gn5PnxG4jwkhvaXK+9
         4mjwgAzFyiOjPm56NR87pZE21z10k7qKOiVIMIYryi4cZl46eGU8UZYQSOfVowKmSE8W
         kIaURExsL0MbCjr5v+/JcYRKlMUSM34qdF1qWJc555R7tldFsAVOUasfzF0LYh3EdUsz
         Xa2KgYP0UIbDb5vP6mo6abzLPAX/hy6Q5rsl7EqgTN3NIo3dDK77RkWSkhehzb+PZda6
         xceg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780351171; x=1780955971;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Rg+/1CKy1BOtonhw8GAQavpaE5sBngLputrohP126YA=;
        b=s2sdnzkKypVbqFE0ZpRfqN9dO00+HszEvbmKCKHYRUT8BLjWPkk0Vz8OOEaRkvge4n
         sKPgpFmg+4LOMiLCv+FwdF3krtV/j1pMHLE+Ej/9vKPkNMgATl2siVtnWTLOdi4q8Y9n
         xBfN54V+l4gOHgnurj5MjXKy1H+9ayIgHbQFNkX6GT+IPilimCSlnfuVzfHQrSWc2/3T
         xIptC229jkjun3sfVgeeLj83ywObKJyd81MPxRbnFZ/ThfPQJnJdDUmCwy1fJkqNJa66
         acIhZbNeXTTyBZnpDdApAo3D7UVgCPJw3Ng7Hym8Ng+MxeLstm7QcPD9xzkaqZsRrsJw
         vV3g==
X-Gm-Message-State: AOJu0YwOOOTOosyDs6EqQ+H2MCPdyL2MF4Npei7AFPCLJwNuwETW6Azn
	HsVpT3SFsoRLxDMjbueFeq9/KRaeGxQs0QeIe7J67L5QyGX97W/ZjRqhN64qIfhJVKA6R4Ewp3V
	nUH4+EfsN2wMk6XfaeJwB3vHCDEtlJ8P3a1Yv4VdiHjd9xnh4pQ5CTH9WuB6sGXzewE/py5PxBX
	YEVEoPI/BKLJmcjdrfvsBcAhG4NuBCuQ==
X-Received: from plblo7.prod.google.com ([2002:a17:903:4347:b0:2bf:8db:4516])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:15cf:b0:2c0:c3ac:4af3
 with SMTP id d9443c01a7336-2c0c3ac4e7cmr96353685ad.15.1780351170705; Mon, 01
 Jun 2026 14:59:30 -0700 (PDT)
Date: Mon,  1 Jun 2026 21:59:06 +0000
In-Reply-To: <20260601215909.3958732-1-praan@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260601215909.3958732-1-praan@google.com>
X-Mailer: git-send-email 2.54.0.1013.g208068f2d8-goog
Message-ID: <20260601215909.3958732-10-praan@google.com>
Subject: [PATCH v8 09/12] iommu/arm-smmu-v3: Implement pm_runtime & system
 sleep ops
From: Pranjal Shrivastava <praan@google.com>
To: iommu@lists.linux.dev
Cc: Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>, 
	Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>, Mostafa Saleh <smostafa@google.com>, 
	Nicolin Chen <nicolinc@nvidia.com>, Daniel Mentz <danielmentz@google.com>, 
	Ashish Mhetre <amhetre@nvidia.com>, linux-arm-kernel@lists.infradead.org, 
	Pranjal Shrivastava <praan@google.com>
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
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 172 +++++++++++++++++++-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  18 ++
 2 files changed, 188 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index d31e50b64b50..542de3a3173a 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -28,6 +28,7 @@
 #include <linux/platform_device.h>
 #include <linux/sort.h>
 #include <linux/string_choices.h>
+#include <linux/pm_runtime.h>
 #include <kunit/visibility.h>
 #include <uapi/linux/iommufd.h>
 
@@ -110,6 +111,40 @@ static const char * const event_class_str[] = {
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
+__maybe_unused static void arm_smmu_rpm_put(struct arm_smmu_device *smmu)
+{
+	int ret;
+
+	if (!pm_runtime_enabled(smmu->dev))
+		return;
+
+	ret = pm_runtime_put_autosuspend(smmu->dev);
+	if (ret < 0)
+		dev_err(smmu->dev, "failed to suspend device: %d\n", ret);
+}
+
+static inline u32 arm_smmu_cmdq_owner_prod_idx(struct arm_smmu_cmdq *cmdq)
+{
+	return atomic_read(&cmdq->owner_prod) & CMDQ_PROD_IDX_MASK;
+}
+
 static void parse_driver_options(struct arm_smmu_device *smmu)
 {
 	int i = 0;
@@ -789,7 +824,8 @@ int arm_smmu_cmdq_issue_cmdlist(struct arm_smmu_device *smmu,
 		/* b. Stop gathering work by clearing the owned flag */
 		prod = atomic_fetch_andnot_relaxed(CMDQ_PROD_OWNED_FLAG,
 						   &cmdq->q.llq.atomic.prod);
-		prod &= ~CMDQ_PROD_OWNED_FLAG;
+		/* Strip all metadata flags */
+		prod &= CMDQ_PROD_IDX_MASK;
 
 		/*
 		 * c. Wait for any gathered work to be written to the queue.
@@ -4828,7 +4864,8 @@ static int arm_smmu_device_reset(struct arm_smmu_device *smmu)
 
 	/* Command queue */
 	writeq_relaxed(smmu->cmdq.q.q_base, smmu->base + ARM_SMMU_CMDQ_BASE);
-	writel_relaxed(smmu->cmdq.q.llq.prod, smmu->base + ARM_SMMU_CMDQ_PROD);
+	writel_relaxed(smmu->cmdq.q.llq.prod & CMDQ_PROD_IDX_MASK,
+		       smmu->base + ARM_SMMU_CMDQ_PROD);
 	writel_relaxed(smmu->cmdq.q.llq.cons, smmu->base + ARM_SMMU_CMDQ_CONS);
 
 	enables = CR0_CMDQEN;
@@ -4839,6 +4876,10 @@ static int arm_smmu_device_reset(struct arm_smmu_device *smmu)
 		return ret;
 	}
 
+	/* Clear any flags from the previous life */
+	atomic_andnot(CMDQ_PROD_STOP_FLAG, &smmu->cmdq.owner_prod);
+	atomic_andnot(CMDQ_PROD_STOP_FLAG, &smmu->cmdq.q.llq.atomic.prod);
+
 	/* Invalidate any cached configuration */
 	arm_smmu_cmdq_issue_cmd_with_sync(smmu, arm_smmu_make_cmd_cfgi_all());
 
@@ -4898,6 +4939,21 @@ static int arm_smmu_device_reset(struct arm_smmu_device *smmu)
 	if (is_kdump_kernel())
 		enables &= ~(CR0_EVTQEN | CR0_PRIQEN);
 
+	/*
+	 * While the SMMU was suspended, concurrent CPU threads may have
+	 * updated in-memory structures (such as STEs, CDs, and PTEs).
+	 * Any invalidations corresponding to those updates were safely
+	 * elided because the command queue was stopped (STOP_FLAG == 1).
+	 *
+	 * Since the reset invalidate-all commands above have fully cleared
+	 * the HW TLBs and config caches, the SMMU will fetch these descriptors
+	 * directly from RAM as soon as translation is enabled.
+	 *
+	 * Add a memory barrier to collect all prior RAM writes to ensure the
+	 * SMMU sees a consistent view of memory before translation is enabled.
+	 */
+	smp_mb();
+
 	/* Enable the SMMU interface */
 	enables |= CR0_SMMUEN;
 	ret = arm_smmu_write_reg_sync(smmu, enables, ARM_SMMU_CR0,
@@ -5580,6 +5636,117 @@ static void arm_smmu_device_shutdown(struct platform_device *pdev)
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
+	/* Mark the CMDQ to stop and get the target index before the stop */
+	target = atomic_fetch_or_relaxed(CMDQ_PROD_STOP_FLAG, &cmdq->q.llq.atomic.prod);
+	target &= CMDQ_PROD_IDX_MASK;
+
+
+	/* Wait for the last committed owner to reach the hardware */
+	while ((arm_smmu_cmdq_owner_prod_idx(cmdq) != target) && --timeout)
+		udelay(1);
+
+	/*
+	 * Entering suspend implies no active clients. A timeout here
+	 * indicates a fatal CMDQ lockup or hardware stall. We proceed
+	 * anyway to prioritize memory safety (avoiding stale TLBs)
+	 */
+	if (!timeout)
+		dev_err(smmu->dev, "cmdq owner wait timeout, (check runtime PM + devlinks)\n");
+
+	/* Drain the CMDQs */
+	ret = arm_smmu_drain_queues(smmu);
+	if (ret)
+		dev_warn(smmu->dev, "failed to drain queues, forcing suspend\n");
+
+	/* Wait for cmdq->lock == 0 to ensure last CMDQ_CONS_REG is written */
+	timeout = ARM_SMMU_SUSPEND_TIMEOUT_US;
+	while (atomic_read(&cmdq->lock) != 0 && --timeout)
+		udelay(1);
+
+	/* Timing out here implies misconfigured Runtime PM or broken devlinks */
+	if (!timeout)
+		dev_err(smmu->dev, "cmdq lock != 0, forcing suspend. Polling CPUs may fault.\n");
+
+	/* Disable everything */
+	arm_smmu_device_disable(smmu);
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
@@ -5596,6 +5763,7 @@ static struct platform_driver arm_smmu_driver = {
 	.driver	= {
 		.name			= "arm-smmu-v3",
 		.of_match_table		= arm_smmu_of_match,
+		.pm                     = &arm_smmu_pm_ops,
 		.suppress_bind_attrs	= true,
 	},
 	.probe	= arm_smmu_device_probe,
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 719e499c72ce..51a3281a1e46 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -392,6 +392,9 @@ static inline unsigned int arm_smmu_cdtab_l2_idx(unsigned int ssid)
 #define CMDQ_PROD_STOP_FLAG		(1U << 30)
 #define Q_STOP(p)			((p) & CMDQ_PROD_STOP_FLAG)
 
+/* Mask out software-only metadata flags to get the pure queue index/wrap bits */
+#define CMDQ_PROD_IDX_MASK		~(CMDQ_PROD_STOP_FLAG | CMDQ_PROD_OWNED_FLAG)
+
 struct arm_smmu_cmd {
 	u64 data[CMDQ_ENT_DWORDS];
 };
@@ -655,11 +658,14 @@ arm_smmu_make_cmd_tlbi(enum arm_smmu_cmdq_opcode op, u16 asid, u16 vmid)
 
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
@@ -1217,6 +1223,18 @@ int arm_smmu_cmdq_issue_cmdlist(struct arm_smmu_device *smmu,
 				struct arm_smmu_cmd *cmds, int n,
 				bool sync);
 
+/*
+ * Lockless pre-check to elide invalidations if SMMU is suspended.
+ * Races with concurrent suspend are benign: the cmpxchg loop in
+ * arm_smmu_cmdq_issue_cmdlist() acts as the true commit point.
+ * If we lose the race, that loop observes Q_STOP == 1 and safely
+ * drops the command. If we win, the suspend thread waits for us.
+ */
+static inline bool arm_smmu_can_elide(struct arm_smmu_device *smmu)
+{
+	return !!Q_STOP(READ_ONCE(smmu->cmdq.q.llq.prod));
+}
+
 #ifdef CONFIG_ARM_SMMU_V3_SVA
 bool arm_smmu_sva_supported(struct arm_smmu_device *smmu);
 void arm_smmu_sva_notifier_synchronize(void);
-- 
2.54.0.1013.g208068f2d8-goog

