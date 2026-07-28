Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F17A9411FB2
	for <iommu@lists.linux.dev>; Tue, 28 Jul 2026 21:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785273006; cv=none; b=HhOSg/vjXNHRHPswXHRoTBJ7yHHHovKGQa+s2nDHSmiYBvGxqqq7GICYLTzG2TvjPqja4lfGdx1JUXXcatakkW5zIRDsVyZbvWpEQBrM4ja/EoGkayHJpYnFXi34J/bLfrjpUlgacgzK7y80ESLU9VgEAeFFQZOSu8oIfO0Mf7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785273006; c=relaxed/simple;
	bh=MRyfHIF2MWuxU3c8SwjIpsjupdByPEwvXGhVFPcwGGM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=MuCGBy3KHWTLn1ReGMz6flZaL6kqpxA1VgGbq6AG7qqyznRshhP1SMrEu+crwTjfz0MCDaEOY611mO+H/lzrenYNiFGGXTHxp47Yg9+R3YJayn2T7vLKjNYl0XnqVpILplxOcne0fg+uMKoC/hcU2Cnk0gbelQwbmQE9L3/Gy2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Rusmie8Y; arc=none smtp.client-ip=209.85.214.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Rusmie8Y"
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2cf1c86963bso13651895ad.0
        for <iommu@lists.linux.dev>; Tue, 28 Jul 2026 14:10:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785273004; x=1785877804; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GFhBksdUPO0znF1KRVq6mRgwILQjjMIwQzPu3n7Yst4=;
        b=Rusmie8YlX73e5EODczlDKvlsjyeCh+ItRK4iEM5iwtJ9x6mm+aRQA4FVv7h7rNpvz
         af/VyZg0jfauLVKVbnCTMzcByxopPsqA7sqB7SliiLcXVFnAW+06BVn1anxtgSx3CW8V
         +fPmBh5iCH/YBWYPxE+HeA3CufHar4QxEfX80gz0a6jEU5krj5DQroykzheaoJfbmk0g
         UWCT4iFuiuUBfftTo76wQjzWZI37nEkhgTKPvohh8pGUf/dG8/oG3sNt+oijT+vYEpPn
         i3p+FIN4bV+8bvFXeg+yD0qe851j7I8oftc5W/R+8vBjQjmdPu4FBjjdj48H2oQdQiX/
         Hv4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785273004; x=1785877804;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GFhBksdUPO0znF1KRVq6mRgwILQjjMIwQzPu3n7Yst4=;
        b=RHlRwMEp+pJc3zFKHMTxdBpTByj9fvmhaKTWg3DgYrY3ijtrlG3muVxG3SmaKVc3QH
         viBSON2UnbEgv6+OFzg7l4IgxgcwSa0LE1ckoPoYuWtkCMpDyz/21/xct1AOJ2wi/vep
         qghAu3N8NTkgRl2frPAfCEeufShvXYTt33uwHApcU/4KSk2LtlSCfvkadAqWeqcJOkI3
         CqkTcPg4mA63HicesQA0KaHtaeG0bd84eu6pmpOMOJFXbcgeND5tZRU4bYQWcFBbsIcS
         dTXqxqZGedvYeYtvP3p4VzHHdCrUkJvSX0vbo7F7FFZJqqoaJFIDmf9rC2ki9EC4My0n
         B8YQ==
X-Gm-Message-State: AOJu0YwbCTcJFDQBUDzKaA0NNipOgHkubEjy6TswkOrtWsgZ+qtcmVSH
	lzVcB1ZkZr9ZDLzDT5nLvY6/pNFGk3Uyp/nStspPO43NXoQz8fIdWJquj+O6QiCCuo1iYCPOpC1
	zLMaes1sFM1H37DzmilvhUt7/sZHxi2bBRN3kRmWrtHt/51qItW8VIkvJMhaR4qHVYZUprM+w/v
	WN5LWjXMgvFWGqu8QJqcNy9XkD0TWxYw==
X-Received: from pllj6.prod.google.com ([2002:a17:902:7586:b0:2c7:f35e:555])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:4b48:b0:2ca:e496:5f19
 with SMTP id d9443c01a7336-2d015db7b79mr46897975ad.19.1785273003834; Tue, 28
 Jul 2026 14:10:03 -0700 (PDT)
Date: Tue, 28 Jul 2026 21:09:28 +0000
In-Reply-To: <20260728210928.1050849-1-praan@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260728210928.1050849-1-praan@google.com>
X-Mailer: git-send-email 2.55.0.487.gaf234c4eb3-goog
Message-ID: <20260728210928.1050849-13-praan@google.com>
Subject: [PATCH v9 12/12] iommu/arm-smmu-v3: Add KUnit unit tests for Runtime PM
From: Pranjal Shrivastava <praan@google.com>
To: iommu@lists.linux.dev
Cc: Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>, 
	Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>, Mostafa Saleh <smostafa@google.com>, 
	Nicolin Chen <nicolinc@nvidia.com>, Daniel Mentz <danielmentz@google.com>, 
	linux-arm-kernel@lists.infradead.org, Pranjal Shrivastava <praan@google.com>
Content-Type: text/plain; charset="UTF-8"

Introduce kunit selftests to verify the Runtime PM elision gating,
post-suspend elisions and progress on resumption under active
invalidation load. Simulate concurrent HW suspension using a timer.
Mock all HW registers and CMDQ buffers by allocating them on RAM.
Make the mock CMDQ self-consuming to avoid hitting queue_full scenarios.

Signed-off-by: Pranjal Shrivastava <praan@google.com>
---
 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-test.c  | 171 ++++++++++++++++++
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   |   1 +
 2 files changed, 172 insertions(+)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-test.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-test.c
index add671363c82..2654bd497fd3 100644
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
@@ -771,6 +775,171 @@ static void arm_smmu_v3_invs_test(struct kunit *test)
 	kfree(test_b);
 }
 
+struct arm_smmu_mock_cmdq {
+	u32 mock_prod_reg;
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
+	cmdq->q.prod_reg = (__force u32 __iomem *)&mock->mock_prod_reg;
+	cmdq->q.cons_reg = (__force u32 __iomem *)&mock->mock_prod_reg;
+
+	atomic_set(&cmdq->q.llq.atomic.prod, 0);
+	atomic_set(&cmdq->q.llq.atomic.cons, 0);
+	atomic_set(&cmdq->owner_prod, 0);
+	mock->mock_prod_reg = 0;
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
+	timer_setup(&timer_ctx.timer, arm_smmu_v3_test_rpm_timer_callback, 0);
+	mod_timer(&timer_ctx.timer, jiffies + msecs_to_jiffies(10));
+
+	/* Execute the unmap storm until the timer triggers */
+	while (!READ_ONCE(timer_ctx.suspended)) {
+		if (arm_smmu_cmdq_issue_cmdlist(&mock_smmu, cmdq, &cmd, 1, false))
+			break;
+		usleep_range(50, 100);
+	}
+
+	timer_delete_sync(&timer_ctx.timer);
+
+	/* Establish the post-storm prod_reg index */
+	stopped_prod = mock.mock_prod_reg;
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
+	KUNIT_EXPECT_EQ(test, stopped_prod, mock.mock_prod_reg);
+
+	/*
+	 * Clear the STOP_FLAG (resume the SMMU). A new invalidation must
+	 * now successfully commit prod_idx & move the prod_reg by exactly 1.
+	 */
+	atomic_andnot(CMDQ_PROD_STOP_FLAG, &cmdq->q.llq.atomic.prod);
+	KUNIT_EXPECT_EQ(test, 0, arm_smmu_cmdq_issue_cmdlist(&mock_smmu, cmdq, &cmd, 1, false));
+	KUNIT_EXPECT_EQ(test, stopped_prod + 1, mock.mock_prod_reg);
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
+static void arm_smmu_v3_rpm_test_kthread_race(struct kunit *test)
+{
+	struct arm_smmu_test_kthread_context ctx = {0};
+	struct arm_smmu_device mock_smmu = smmu;
+	struct arm_smmu_mock_cmdq mock = {0};
+	struct task_struct *thread1, *thread2;
+	u32 stopped_prod;
+
+	ctx.smmu = &mock_smmu;
+	arm_smmu_v3_test_init_mock_cmdq(test, &mock_smmu, &mock);
+
+	thread1 = kthread_run(arm_smmu_v3_test_kthread_worker, &ctx, "smmu_w1");
+	thread2 = kthread_run(arm_smmu_v3_test_kthread_worker, &ctx, "smmu_w2");
+	if (IS_ERR(thread1) || IS_ERR(thread2)) {
+		if (!IS_ERR(thread1))
+			kthread_stop(thread1);
+		if (!IS_ERR(thread2))
+			kthread_stop(thread2);
+		return;
+	}
+
+	usleep_range(1000, 2000);
+
+	/* Gate the CMDQ */
+	atomic_or(CMDQ_PROD_STOP_FLAG, &mock_smmu.cmdq.q.llq.atomic.prod);
+	stopped_prod = mock.mock_prod_reg;
+
+	usleep_range(1000, 2000);
+	KUNIT_EXPECT_EQ(test, stopped_prod, mock.mock_prod_reg);
+
+	/* Open the gate */
+	atomic_andnot(CMDQ_PROD_STOP_FLAG, &mock_smmu.cmdq.q.llq.atomic.prod);
+	usleep_range(1000, 2000);
+	KUNIT_EXPECT_NE(test, stopped_prod, mock.mock_prod_reg);
+
+	kthread_stop(thread1);
+	kthread_stop(thread2);
+	KUNIT_EXPECT_EQ(test, 0, ctx.error);
+}
+
 static struct kunit_case arm_smmu_v3_test_cases[] = {
 	KUNIT_CASE(arm_smmu_v3_write_ste_test_bypass_to_abort),
 	KUNIT_CASE(arm_smmu_v3_write_ste_test_abort_to_bypass),
@@ -797,6 +966,8 @@ static struct kunit_case arm_smmu_v3_test_cases[] = {
 	KUNIT_CASE(arm_smmu_v3_write_cd_test_sva_clear),
 	KUNIT_CASE(arm_smmu_v3_write_cd_test_sva_release),
 	KUNIT_CASE(arm_smmu_v3_invs_test),
+	KUNIT_CASE(arm_smmu_v3_rpm_test_stress_race),
+	KUNIT_CASE(arm_smmu_v3_rpm_test_kthread_race),
 	{},
 };
 
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 97e7284fcfcc..9106ffb75f7a 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -935,6 +935,7 @@ int __arm_smmu_cmdq_issue_cmdlist(struct arm_smmu_device *smmu,
 	local_irq_restore(flags);
 	return ret;
 }
+EXPORT_SYMBOL_IF_KUNIT(arm_smmu_cmdq_issue_cmdlist);
 
 bool arm_smmu_erratum_repeat_tlbi_cfgi(void)
 {
-- 
2.55.0.487.gaf234c4eb3-goog

