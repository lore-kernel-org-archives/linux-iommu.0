Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7145E2F83A2
	for <iommu@lists.linux.dev>; Tue, 14 Apr 2026 19:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776196049; cv=none; b=Hfm8ryFsrMgYKDPaYwE2EKYg85MAx/JMSQF1nLqzb8HC2NIqYkhjNQCYLUkfhfov+4W4TZxUIQml6EbuEawol6Ba36somcxkHw5LsuhS0M3GN8t0MT+SQmyTKhLhMQW/VxdK7NoPJYM7nWxBt70sgKgyG+b7gdXyytfJcwUNoWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776196049; c=relaxed/simple;
	bh=/GIUhuQyoWsIRkgFiVPF/E7MLXE+87GVg5qWqVVgjYw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=W6L+84KqdVRfmcyt9znuTPCj2JJGxRQrimh7COmnioqQuHL979w93DgkLcs4vXcNjZvMQEejJmLqOhJruA6ThIQRP74EZX8vx8oK154BekEDr1mFOdIqaMETKgDhbg6TfvakPWXRxEqpjONJvpz2+sKgaVAER15MYg7IBSxEDBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RdJ078B5; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RdJ078B5"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-358df8fbd1cso6557385a91.0
        for <iommu@lists.linux.dev>; Tue, 14 Apr 2026 12:47:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776196048; x=1776800848; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=x1VkVGLOJAyJW0A7uvmcQZzradAHpERJp/liWxenc4o=;
        b=RdJ078B5/2xki846w/N7vZpBrhdH3vZxniATe+MuGxhzXgAfgzzW8FvVPzveer52sC
         lsZkqQa7yXQZxI1VYJRSsDtsC0+YFaslT354jCV4XeDmfkHcB7WJF62VI5SxxzLJJU+Z
         prRvBH10TypMbbuCUJX0/i2eAyofYuJzYzlwntoYRPC83F+0UYLuky2cAMZVrXJFFjyb
         BLe/k58UYw36yqyz7AHRjnsfNaH5EJKDFqazhvbwnfrhlxqZsre0QbmyR7Drk3v1fpU/
         k9WquwEqDF36/GRis/0xS4oqeXkOdHStY50jLPFyzxWyeG+F2a16QBGfbinqFUoPyWNT
         hWMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776196048; x=1776800848;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x1VkVGLOJAyJW0A7uvmcQZzradAHpERJp/liWxenc4o=;
        b=iInfQIeDn7Y6QWjcZgYxS9Awa/73aauyjHygMmO4QDD09rBbXA29icpc4IjN/tIUsZ
         1bvHT5sA8WLHH+mDEEWGOJcZUnDNmEL8B8deNEVXOIBixdsyie2SuOGOJAZV3cSvxH/V
         DILKZ01d7wUEdY1/Yf4BGxrrK4AM56sHruHBYpQTOrCbZCdCUBGJXnYZSAuJYnzSUJhL
         TsSjUMyU1/P9ZCdUE9xOrXVSN5EHlvtsilTqVOGIHD3juTRfgQDhe84ifl0em6TXGakD
         fwzkpARRsx+ohk4V0cyVrsATK58YtyqY1U687hisDgP6RQGaHn8W7zvAiwkfjrEnwqd3
         QWTQ==
X-Gm-Message-State: AOJu0Yw8yuvTnPxlJnkLsJrgvuQaQhxZoc+MWcEQTR+iAMbWOBfJSS0Y
	6ZdULDHaUUxW2C/UY+jXHEx/9FYCe/p1qb5c0pVrXwNvyRMqrd01ZNISb4bH6kuL4ygq5OnaS6c
	z/zI7X5qrSLUsluAKxSR7Rox2Yx9mS7Vdrn0APwSNOdyrDI6p7XgsB3R0EchLPeeoyU3Bs2JPKj
	I28RtVTwbH+2HGFftNJqYgvl22RXKEyQ==
X-Received: from pjbbk11.prod.google.com ([2002:a17:90b:80b:b0:35f:63f9:b04d])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:10d6:b0:35e:577c:c9f
 with SMTP id 98e67ed59e1d1-35e577c1debmr8471173a91.9.1776196047335; Tue, 14
 Apr 2026 12:47:27 -0700 (PDT)
Date: Tue, 14 Apr 2026 19:46:59 +0000
In-Reply-To: <20260414194702.1229094-1-praan@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260414194702.1229094-1-praan@google.com>
X-Mailer: git-send-email 2.54.0.rc0.605.g598a273b03-goog
Message-ID: <20260414194702.1229094-8-praan@google.com>
Subject: [PATCH v6 07/10] iommu/arm-smmu-v3: Implement pm_runtime & system
 sleep ops
From: Pranjal Shrivastava <praan@google.com>
To: iommu@lists.linux.dev
Cc: Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>, 
	Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>, Mostafa Saleh <smostafa@google.com>, 
	Nicolin Chen <nicolinc@nvidia.com>, Daniel Mentz <danielmentz@google.com>, 
	Ashish Mhetre <amhetre@nvidia.com>, Pranjal Shrivastava <praan@google.com>
Content-Type: text/plain; charset="UTF-8"

Implement pm_runtime and system sleep ops for arm-smmu-v3.

The suspend callback configures the SMMU to abort new transactions,
disables the main translation unit and then drains the command queue
to ensure completion of any in-flight commands. A software gate
(STOP_FLAG) and synchronization barriers are used to quiesce the command
submission pipeline and ensure state consistency before power-off.

The resume callback restores the MSI configuration and performs a full
device reset via `arm_smmu_device_reset` to bring the SMMU back to an
operational state. The MSIs are cached during the msi_write and are
restored during the resume operation by using the helper.

Suggested-by: Daniel Mentz <danielmentz@google.com>
Signed-off-by: Pranjal Shrivastava <praan@google.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 179 ++++++++++++++++++++
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |   8 +
 2 files changed, 187 insertions(+)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 93ce9ea81991..a6aee4538b57 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -28,6 +28,7 @@
 #include <linux/platform_device.h>
 #include <linux/sort.h>
 #include <linux/string_choices.h>
+#include <linux/pm_runtime.h>
 #include <kunit/visibility.h>
 #include <uapi/linux/iommufd.h>
 
@@ -109,6 +110,48 @@ static const char * const event_class_str[] = {
 
 static int arm_smmu_alloc_cd_tables(struct arm_smmu_master *master);
 
+/* Runtime PM helpers */
+__maybe_unused static int arm_smmu_rpm_get(struct arm_smmu_device *smmu)
+{
+	int ret;
+
+	if (pm_runtime_enabled(smmu->dev)) {
+		ret = pm_runtime_resume_and_get(smmu->dev);
+		if (ret < 0) {
+			dev_err(smmu->dev, "failed to resume device: %d\n", ret);
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
+__maybe_unused static void arm_smmu_rpm_put(struct arm_smmu_device *smmu)
+{
+	int ret;
+
+	if (pm_runtime_enabled(smmu->dev)) {
+		ret = pm_runtime_put_autosuspend(smmu->dev);
+		if (ret < 0)
+			dev_err(smmu->dev, "failed to suspend device: %d\n", ret);
+	}
+}
+
+/*
+ * This should always return true if devlinks are setup correctly
+ * and the client using the SMMU is active.
+ */
+__maybe_unused bool arm_smmu_rpm_get_if_active(struct arm_smmu_device *smmu)
+{
+	if (!arm_smmu_is_active(smmu))
+		return false;
+
+	if (pm_runtime_enabled(smmu->dev))
+		return pm_runtime_get_if_active(smmu->dev) > 0;
+
+	return true;
+}
+
 static void parse_driver_options(struct arm_smmu_device *smmu)
 {
 	int i = 0;
@@ -5700,6 +5743,141 @@ static void arm_smmu_device_shutdown(struct platform_device *pdev)
 	arm_smmu_device_disable(smmu);
 }
 
+static int __maybe_unused arm_smmu_runtime_suspend(struct device *dev)
+{
+	struct arm_smmu_device *smmu = dev_get_drvdata(dev);
+	struct arm_smmu_cmdq *cmdq = &smmu->cmdq;
+	struct arm_smmu_ll_queue llq, head;
+	int timeout = ARM_SMMU_SUSPEND_TIMEOUT_US;
+	u32 enables, target;
+	u64 old;
+	int ret;
+
+	/* Abort all transactions before disable to avoid spurious bypass */
+	arm_smmu_update_gbpa(smmu, GBPA_ABORT, 0);
+
+	/* Disable the SMMU via CR0.EN and all queues except CMDQ */
+	enables = CR0_CMDQEN;
+	ret = arm_smmu_write_reg_sync(smmu, enables, ARM_SMMU_CR0, ARM_SMMU_CR0ACK);
+	if (ret) {
+		dev_err(smmu->dev, "failed to disable SMMUEN\n");
+		return ret;
+	}
+
+	/*
+	 * At this point the SMMU is completely disabled and won't access
+	 * any translation/config structures, even speculative accesses
+	 * aren't performed as per the IHI0070 spec (section 6.3.9.6).
+	 */
+
+	/* Mark the CMDQ to stop */
+	llq.val = READ_ONCE(cmdq->q.llq.val);
+	do {
+		head = llq;
+		head.prod |= CMDQ_PROD_STOP_FLAG;
+
+		old = cmpxchg_relaxed(&cmdq->q.llq.val, llq.val, head.val);
+		if (old == llq.val)
+			break;
+
+		llq.val = old;
+	} while (1);
+
+	/* Wait for the last committed owner to reach the hardware */
+	target = head.prod & ~CMDQ_PROD_STOP_FLAG;
+	while (atomic_read(&cmdq->owner_prod) != target && --timeout)
+		udelay(1);
+
+	/*
+	 * Entering suspend implies no active clients. A race or timeout here
+	 * indicates a broken RPM or devlink dependency. We proceed anyway to
+	 * prioritize memory safety (avoiding stale TLBs) over bus faults.
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
+	dev_dbg(dev, "suspended smmu\n");
+
+	return 0;
+}
+
+static int __maybe_unused arm_smmu_runtime_resume(struct device *dev)
+{
+	int ret;
+	struct arm_smmu_device *smmu = dev_get_drvdata(dev);
+	struct arm_smmu_cmdq *cmdq = &smmu->cmdq;
+	struct arm_smmu_ll_queue llq;
+
+	/* Clear the STOP FLAG to allow CMDQ Submissions */
+	llq.val = READ_ONCE(cmdq->q.llq.val);
+	while (1) {
+		u64 old_val;
+		struct arm_smmu_ll_queue head = llq;
+
+		if (!(head.prod & CMDQ_PROD_STOP_FLAG))
+			break;
+
+		head.prod &= ~CMDQ_PROD_STOP_FLAG;
+		old_val = cmpxchg_relaxed(&cmdq->q.llq.val, llq.val, head.val);
+		if (old_val == llq.val)
+			break;
+		llq.val = old_val;
+	}
+
+	/* Re-configure MSIs */
+	arm_smmu_resume_msis(smmu);
+
+	ret = arm_smmu_device_reset(smmu);
+	if (ret)
+		dev_err(dev, "failed to reset during resume operation: %d\n", ret);
+
+	dev_dbg(dev, "resumed device\n");
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
@@ -5716,6 +5894,7 @@ static struct platform_driver arm_smmu_driver = {
 	.driver	= {
 		.name			= "arm-smmu-v3",
 		.of_match_table		= arm_smmu_of_match,
+		.pm                     = &arm_smmu_pm_ops,
 		.suppress_bind_attrs	= true,
 	},
 	.probe	= arm_smmu_device_probe,
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 4bace6a85d29..3a20a553105e 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -504,11 +504,14 @@ static inline unsigned int arm_smmu_cdtab_l2_idx(unsigned int ssid)
 
 /* High-level queue structures */
 #define ARM_SMMU_POLL_TIMEOUT_US	1000000 /* 1s! */
+#define ARM_SMMU_SUSPEND_TIMEOUT_US	1000000	/* 1s! */
 #define ARM_SMMU_POLL_SPIN_COUNT	10
 
 #define MSI_IOVA_BASE			0x8000000
 #define MSI_IOVA_LENGTH			0x100000
 
+#define RPM_AUTOSUSPEND_DELAY_MS	15
+
 enum pri_resp {
 	PRI_RESP_DENY = 0,
 	PRI_RESP_FAIL = 1,
@@ -1149,6 +1152,11 @@ int arm_smmu_cmdq_issue_cmdlist(struct arm_smmu_device *smmu,
 				struct arm_smmu_cmdq *cmdq, u64 *cmds, int n,
 				bool sync);
 
+static inline bool arm_smmu_is_active(struct arm_smmu_device *smmu)
+{
+	return !Q_STOP(READ_ONCE(smmu->cmdq.q.llq.prod));
+}
+
 #ifdef CONFIG_ARM_SMMU_V3_SVA
 bool arm_smmu_sva_supported(struct arm_smmu_device *smmu);
 void arm_smmu_sva_notifier_synchronize(void);
-- 
2.54.0.rc0.605.g598a273b03-goog

