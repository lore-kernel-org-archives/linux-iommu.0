Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C4C6356762
	for <iommu@lists.linux.dev>; Tue, 29 Sep 2026 03:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790653563; cv=none; b=IvJzeffE2dPjpFcPxEg6b/eOZbpEXqacqp4526j5t9sDe25VgGJbkFnJJYHEQWzDD/NY6fIUMZyMLCTZm1lTOfA8bSNUVa/NKk+W/CYnDxnF1jPSKhLh3YByjWEXjissJkhE2/QHY6RFTFE7+3ddGDXVmR0MXZZuUtdoFR0bPSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790653563; c=relaxed/simple;
	bh=RV9BRd3bDPRHxs8h+GEdjYXEZL77i6dCc2nVia+FuaU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=cPw2zy6RtRQjWfKecjRroZYQIfQYL4mtb/gdMQsIPC2gf8sanQfpTdhSX3XZW26SbR2n9LPOJ1uLbo/TRfTGnGRsCvy5HvF5Y5/iqxEJMaSC5CV2MkrpdsV/Wa5sbkAnvwnZZlXSkseJT8xjZ2JprUVweoTL5AUcNKS0LYLnuO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=p9EdL5Y1; arc=none smtp.client-ip=209.85.216.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="p9EdL5Y1"
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-3823dcc1647so2842183a91.3
        for <iommu@lists.linux.dev>; Mon, 28 Sep 2026 20:46:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790653560; x=1791258360; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1q1rUCYuMozZipImZqMvE4+Ndw0NLK5Ay3DBtmbY5AU=;
        b=p9EdL5Y1JTHx3aDNqwidLHcLgaEIvXB7K6TCowh65CGIBfwHkuLAhCQeWiWUDPnlEh
         prk+b6UmnA9dBieuNHMHwNaJXRgf2G9fjsxcPZJTdLsBExbQhR3IgeMl73OhgZVAclB4
         WjEk1lqq0a5+scPMVuQIYBON2UrDP9U72Hj8pTvWM8O1PdbOa1089yPPXqg1EvhLieCn
         uIkiSarRTGbu/4Ms0ZpE0EOdNNgyEis14e+OZqNo7pPRRjKkNq5f2EKThUJSAxRQNcEx
         Dzm8ApK3CsLY1/0mRZlBXxIZxS9Aa0Ps8XkjldqO/MtOK3vZ0cBE4BgSbgP0KOaWQgAF
         umWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790653560; x=1791258360;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1q1rUCYuMozZipImZqMvE4+Ndw0NLK5Ay3DBtmbY5AU=;
        b=x0YOvjyC317u/K9Zt8m+4+o4zsxXkrQqbAQIQsX58ohwni7UW5oKIcgJxpNQ71gBul
         ZnZNOmjivGfRnaycuW2jPBvUmPdLVoXSFT3liif293DkX2KeUSHPq1A37p6yDS1pc8kM
         YDeMosGQU4/eQkN7yJRQjCgcC9javx/SFdbSP6SBbP7gt2paKIq15CUf47fzJ9kUzqgU
         mAZXG1lbpbnxGy/ZwUqmhCc9yGTD4AzUZLXFN6cpm4oF2G1SoiMWFgnQGrAtyojD3q8z
         2Rh7MfUcsBrLRuqhsD7yWyr6Z3iEbX+Pfvxn1ONH+KMjhnRWP7RBTn/uYSmMKerC7yCH
         ph5A==
X-Gm-Message-State: AFq9FYIY8bqIRx3w6Vz73Fe+bSwPHzRcghV7RHglLhqQm+dGi8aRLx5b
	goU2JzkGOIkFIhwoM0L+8vTUQR/PXx/zMAKR/TTjkcc9wlt8vLPCJf1U2auLLKk9gIC/hG3khvF
	bdpwrxKd6XL1u59QagQvJbWNbeti/AlQotDp/RplE5fjOQ+TFnruomvglb1pNKxQfZ56uwbRz9E
	KNfpzOzGsz6jKjJHURgQtosoAW8+OEvg==
X-Received: from pgbcw4.prod.google.com ([2002:a05:6a02:4284:b0:cc7:b387:6d4b])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:55d0:b0:398:9bd5:490b
 with SMTP id 98e67ed59e1d1-3a098cdbb1fmr12417808a91.18.1790653559658; Mon, 28
 Sep 2026 20:45:59 -0700 (PDT)
Date: Tue, 29 Sep 2026 03:45:10 +0000
In-Reply-To: <20260929034510.2023173-1-praan@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260929034510.2023173-1-praan@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260929034510.2023173-17-praan@google.com>
Subject: [PATCH v11 16/16] iommu/arm-smmu-v3: Add KUnit unit tests for Runtime PM
From: Pranjal Shrivastava <praan@google.com>
To: iommu@lists.linux.dev
Cc: Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>, 
	Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>, Mostafa Saleh <smostafa@google.com>, 
	Nicolin Chen <nicolinc@nvidia.com>, Daniel Mentz <danielmentz@google.com>, 
	Ashish Mhetre <amhetre@nvidia.com>, linux-arm-kernel@lists.infradead.org, 
	Thomas Gleixner <tglx@kernel.org>, Radu Rendec <radu@rendec.net>, Bjorn Helgaas <bhelgaas@google.com>, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, rafael@kernel.org, 
	Danilo Krummrich <dakr@kernel.org>, driver-core@lists.linux.dev, 
	Pranjal Shrivastava <praan@google.com>
Content-Type: text/plain; charset="UTF-8"

Introduce kunit selftests to verify the Runtime PM elision gating,
post-suspend elisions and progress on resumption under active
invalidation load. Simulate concurrent HW suspension using a timer.
Mock all HW registers and CMDQ buffers by allocating them on RAM.
Make the mock CMDQ self-consuming to avoid hitting queue_full scenarios.

Signed-off-by: Pranjal Shrivastava <praan@google.com>
---
 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-test.c  | 215 ++++++++++++++++++
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   |   1 +
 2 files changed, 216 insertions(+)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-test.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-test.c
index add671363c82..97c1e907717d 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-test.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-test.c
@@ -3,6 +3,10 @@
  * Copyright 2024 Google LLC.
  */
 #include <kunit/test.h>
+#include <linux/delay.h>
+#include <linux/kthread.h>
+#include <linux/sched.h>
+#include <linux/timer.h>
 #include <linux/io-pgtable.h>
 
 #include "arm-smmu-v3.h"
@@ -771,6 +775,215 @@ static void arm_smmu_v3_invs_test(struct kunit *test)
 	kfree(test_b);
 }
 
+struct arm_smmu_mock_cmdq {
+	/*
+	 * Mock register in RAM. Typed as __le32 to match writel_relaxed()
+	 * endianness without calling readl_* accessors directly on RAM.
+	 */
+	__le32 mock_prod_reg;
+};
+
+/* Helper to allocate a self-consuming mock cmdq */
+static void arm_smmu_v3_test_init_mock_cmdq(struct kunit *test,
+					    struct arm_smmu_device *smmu,
+					    struct arm_smmu_mock_cmdq *mock)
+{
+	struct arm_smmu_cmdq *cmdq = &smmu->cmdq;
+	unsigned long *mock_valid_map;
+	u64 *mock_base;
+
+	mock_base = kunit_kzalloc(test, 1024 * sizeof(struct arm_smmu_cmd), GFP_KERNEL);
+	mock_valid_map = kunit_kzalloc(test, BITS_TO_LONGS(1024) * sizeof(long), GFP_KERNEL);
+
+	KUNIT_ASSERT_NOT_NULL(test, mock_base);
+	KUNIT_ASSERT_NOT_NULL(test, mock_valid_map);
+
+	smmu->features = 0;
+	/* 1024 entries */
+	cmdq->q.llq.max_n_shift = 10;
+	cmdq->q.ent_dwords = CMDQ_ENT_DWORDS;
+	cmdq->q.base = (__le64 *)mock_base;
+	cmdq->valid_map = (atomic_long_t *)mock_valid_map;
+
+	/* Self-Consuming, prod == cons always ensures queue empty */
+	cmdq->q.prod_reg = (__force void __iomem *)&mock->mock_prod_reg;
+	cmdq->q.cons_reg = (__force void __iomem *)&mock->mock_prod_reg;
+
+	atomic_set(&cmdq->q.llq.atomic.prod, 0);
+	atomic_set(&cmdq->q.llq.atomic.cons, 0);
+	atomic_set(&cmdq->owner_prod, 0);
+	mock->mock_prod_reg = cpu_to_le32(0);
+}
+
+struct arm_smmu_test_timer_context {
+	struct arm_smmu_device *smmu;
+	struct timer_list timer;
+	bool suspended;
+};
+
+static void arm_smmu_v3_test_rpm_timer_callback(struct timer_list *t)
+{
+	struct arm_smmu_test_timer_context *ctx =
+		timer_container_of(ctx, t, timer);
+	struct arm_smmu_cmdq *cmdq = &ctx->smmu->cmdq;
+
+	/* Simulate a concurrent suspend event interrupting the invalidations */
+	atomic_or(CMDQ_PROD_STOP_FLAG, &cmdq->q.llq.atomic.prod);
+	WRITE_ONCE(ctx->suspended, true);
+}
+
+/*
+ * Verify SMMU PM Runtime gating, elision, and post-suspend resumption
+ * safety sequentially under active stress.
+ */
+static void arm_smmu_v3_rpm_test_stress_race(struct kunit *test)
+{
+	struct arm_smmu_cmd cmd = arm_smmu_make_cmd_cfgi_all();
+	struct arm_smmu_test_timer_context timer_ctx = {0};
+	struct arm_smmu_device mock_smmu = smmu;
+	struct arm_smmu_cmdq *cmdq = &mock_smmu.cmdq;
+	struct arm_smmu_mock_cmdq mock = {0};
+	u32 stopped_prod;
+	int i;
+
+	arm_smmu_v3_test_init_mock_cmdq(test, &mock_smmu, &mock);
+
+	timer_ctx.smmu = &mock_smmu;
+
+	timer_setup_on_stack(&timer_ctx.timer, arm_smmu_v3_test_rpm_timer_callback, 0);
+	mod_timer(&timer_ctx.timer, jiffies + msecs_to_jiffies(10));
+
+	/* Execute the unmap storm until the timer triggers */
+	while (!READ_ONCE(timer_ctx.suspended)) {
+		if (arm_smmu_cmdq_issue_cmdlist(&mock_smmu, cmdq, &cmd, 1, false))
+			break;
+		usleep_range(50, 100);
+	}
+
+	timer_shutdown_sync(&timer_ctx.timer);
+	timer_destroy_on_stack(&timer_ctx.timer);
+
+	/* Establish the post-storm prod_reg index */
+	stopped_prod = le32_to_cpu(mock.mock_prod_reg);
+
+	/*
+	 * Attempt multiple unmaps while the SMMU is disabled (STOP_GATE is set)
+	 * Every single invalidation must get elided and return 0. The prod_reg
+	 * shall remain completely frozen after all of these submissions.
+	 */
+	for (i = 0; i < 1000; i++) {
+		if (arm_smmu_cmdq_issue_cmdlist(&mock_smmu, cmdq, &cmd, 1, false))
+			break;
+	}
+	KUNIT_EXPECT_EQ(test, stopped_prod, le32_to_cpu(mock.mock_prod_reg));
+
+	/*
+	 * Clear the STOP_FLAG (resume the SMMU). A new invalidation must
+	 * now successfully commit prod_idx & move the prod_reg by exactly 1.
+	 */
+	atomic_andnot(CMDQ_PROD_STOP_FLAG, &cmdq->q.llq.atomic.prod);
+	KUNIT_EXPECT_EQ(test, 0, arm_smmu_cmdq_issue_cmdlist(&mock_smmu, cmdq, &cmd, 1, false));
+	KUNIT_EXPECT_EQ(test, Q_POS(&cmdq->q.llq, stopped_prod + 1),
+			le32_to_cpu(mock.mock_prod_reg));
+}
+
+struct arm_smmu_test_kthread_context {
+	struct arm_smmu_device *smmu;
+	int error;
+};
+
+static int arm_smmu_v3_test_kthread_worker(void *data)
+{
+	struct arm_smmu_cmd cmd = arm_smmu_make_cmd_cfgi_all();
+	struct arm_smmu_test_kthread_context *ctx = data;
+	struct arm_smmu_cmdq *cmdq = &ctx->smmu->cmdq;
+
+	while (!kthread_should_stop()) {
+		if (arm_smmu_cmdq_issue_cmdlist(ctx->smmu, cmdq, &cmd, 1, false))
+			WRITE_ONCE(ctx->error, 1);
+		usleep_range(50, 100);
+	}
+	return 0;
+}
+
+KUNIT_DEFINE_ACTION_WRAPPER(kunit_action_kthread_stop, kthread_stop, struct task_struct *);
+
+static void arm_smmu_v3_rpm_test_kthread_race(struct kunit *test)
+{
+	struct arm_smmu_test_kthread_context *ctx;
+	struct arm_smmu_device *mock_smmu;
+	struct arm_smmu_mock_cmdq *mock;
+	struct task_struct *thread1, *thread2;
+	u32 stopped_prod;
+	int i;
+
+	ctx = kunit_kzalloc(test, sizeof(*ctx), GFP_KERNEL);
+	mock_smmu = kunit_kzalloc(test, sizeof(*mock_smmu), GFP_KERNEL);
+	mock = kunit_kzalloc(test, sizeof(*mock), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, ctx);
+	KUNIT_ASSERT_NOT_NULL(test, mock_smmu);
+	KUNIT_ASSERT_NOT_NULL(test, mock);
+
+	*mock_smmu = smmu;
+	ctx->smmu = mock_smmu;
+	arm_smmu_v3_test_init_mock_cmdq(test, mock_smmu, mock);
+
+	thread1 = kthread_run(arm_smmu_v3_test_kthread_worker, ctx, "smmu_w1");
+	if (IS_ERR(thread1)) {
+		KUNIT_FAIL(test, "Failed to spawn kthread 1\n");
+		return;
+	}
+	if (kunit_add_action_or_reset(test, kunit_action_kthread_stop, thread1)) {
+		KUNIT_FAIL(test, "Failed to register cleanup for kthread 1\n");
+		return;
+	}
+
+	thread2 = kthread_run(arm_smmu_v3_test_kthread_worker, ctx, "smmu_w2");
+	if (IS_ERR(thread2)) {
+		KUNIT_FAIL(test, "Failed to spawn kthread 2\n");
+		return;
+	}
+	if (kunit_add_action_or_reset(test, kunit_action_kthread_stop, thread2)) {
+		KUNIT_FAIL(test, "Failed to register cleanup for kthread 2\n");
+		return;
+	}
+
+	/* Wait for worker threads to start and issue initial commands */
+	for (i = 0; i < 20; i++) {
+		if (le32_to_cpu(READ_ONCE(mock->mock_prod_reg)) > 0)
+			break;
+		usleep_range(1000, 2000);
+	}
+	KUNIT_EXPECT_GT(test, le32_to_cpu(READ_ONCE(mock->mock_prod_reg)), 0);
+
+	/* Gate the CMDQ */
+	atomic_or(CMDQ_PROD_STOP_FLAG, &mock_smmu->cmdq.q.llq.atomic.prod);
+
+	/* Wait for in-flight submissions to settle */
+	for (i = 0; i < 50; i++) {
+		stopped_prod = le32_to_cpu(READ_ONCE(mock->mock_prod_reg));
+		usleep_range(1000, 2000);
+		if (stopped_prod == le32_to_cpu(READ_ONCE(mock->mock_prod_reg)))
+			break;
+	}
+
+	usleep_range(1000, 2000);
+	KUNIT_EXPECT_EQ(test, stopped_prod, le32_to_cpu(READ_ONCE(mock->mock_prod_reg)));
+
+	/* Open the gate and wait for worker threads to resume */
+	atomic_andnot(CMDQ_PROD_STOP_FLAG, &mock_smmu->cmdq.q.llq.atomic.prod);
+	for (i = 0; i < 20; i++) {
+		if (le32_to_cpu(READ_ONCE(mock->mock_prod_reg)) != stopped_prod)
+			break;
+		usleep_range(1000, 2000);
+	}
+	KUNIT_EXPECT_NE(test, stopped_prod, le32_to_cpu(READ_ONCE(mock->mock_prod_reg)));
+
+	kunit_release_action(test, kunit_action_kthread_stop, thread2);
+	kunit_release_action(test, kunit_action_kthread_stop, thread1);
+	KUNIT_EXPECT_EQ(test, 0, READ_ONCE(ctx->error));
+}
+
 static struct kunit_case arm_smmu_v3_test_cases[] = {
 	KUNIT_CASE(arm_smmu_v3_write_ste_test_bypass_to_abort),
 	KUNIT_CASE(arm_smmu_v3_write_ste_test_abort_to_bypass),
@@ -797,6 +1010,8 @@ static struct kunit_case arm_smmu_v3_test_cases[] = {
 	KUNIT_CASE(arm_smmu_v3_write_cd_test_sva_clear),
 	KUNIT_CASE(arm_smmu_v3_write_cd_test_sva_release),
 	KUNIT_CASE(arm_smmu_v3_invs_test),
+	KUNIT_CASE(arm_smmu_v3_rpm_test_stress_race),
+	KUNIT_CASE(arm_smmu_v3_rpm_test_kthread_race),
 	{},
 };
 
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 89ffa8346478..62fc758d8044 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -991,6 +991,7 @@ int arm_smmu_cmdq_issue_cmdlist(struct arm_smmu_device *smmu,
 
 	return ret;
 }
+EXPORT_SYMBOL_IF_KUNIT(arm_smmu_cmdq_issue_cmdlist);
 
 static int arm_smmu_cmdq_issue_cmd_p(struct arm_smmu_device *smmu,
 				     struct arm_smmu_cmd *cmd, bool sync)
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

