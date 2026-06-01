Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93791380FEC
	for <iommu@lists.linux.dev>; Mon,  1 Jun 2026 21:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780351178; cv=none; b=IDpkghO+kixK0qa/wIiSrFBJwQDNRZUwdzs2vbcoezaX9RBfwhcuzKIgfMxAE3jyHjedGUdMaqGrH1POBh1nJJoB1j/zHawCOKHYMnq4LEtpy56u9iqgDAGTOxRLxlRNWOuwNxJb+UtsDii1YK58JKkEpdSdWruUjFjVL6Ck+RE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780351178; c=relaxed/simple;
	bh=xYiJCzcMhxAaCHzX1sr76x+mha9ASmcw5PIQ0IvGYF8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Buaxlmu3B3ocSICdYLwGAYIzrff7nPYC3WQeEHH8Nx0MP5wEn5qqESJw6oZw00waL6RH1gG7RlS2LfPXNeC9a+GRLxuh8rPJ5VCiheLtCEVfpnLZAQfnLxYFzRWn0d1wfIo1tO3ApazcDlD1Gpzd4zTjISH4HyfaEL3sQgSlFLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SV74xi5N; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SV74xi5N"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-36d98b54cf2so1424934a91.1
        for <iommu@lists.linux.dev>; Mon, 01 Jun 2026 14:59:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780351177; x=1780955977; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=NhgaY/FpOn3IwQ6y8dnnL1iO7vtgSThimAmynNFDD1A=;
        b=SV74xi5N8tvuei3F2ViZsZp0hdxhJVWPIIUez4uPlNNB5NGY7YxL8xvDXDlO1MOKGh
         YEOXE7lb18OyKKxhCwn4coOaie7/MM0tsWtadGjZ6wTb0TV8zsE7YP+EuDfoGmTlFuHa
         ulmSgZc1hQySfrW/805+7XWop7s8HgWGl+XFqv0T8XJfhRHdt9o1p8EwyL3+a5aKtIrc
         IrhKz1mmrcyQ6l8x4ox4afAZF1u8NYePIBrLbk6pk9IwPXK09U/roBaGTEaJuQIKVuKw
         x3yV+28sbqAQ7Wsnyo/6hFwBZMaPNLOsXpxi2HgPIZTuqLmkbPYLfUBQbN3sG+fgphgB
         dGJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780351177; x=1780955977;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NhgaY/FpOn3IwQ6y8dnnL1iO7vtgSThimAmynNFDD1A=;
        b=oRjo/9AGb/VxCrINCUpiMEu5i6t0/zORm16g8UO4lrgE3ujmFLoGUxCGEQcNPKlnEj
         4ofXTIcVrprCR0PVlhGoiGS3p0gznhAAE06abAdnwp4VJDIIteT2TXQ7Ky2L7SMQD6Az
         a+qNa2IN8+1of1nGnttjSfYRZRf/lh4rJkM6rg4vGAvIsbbp23v6p7J/+3nyBcPFYAUQ
         +8uCkB7/nwrE7SffUrO17LbzvVCRYhTsxMPXJLZw/eJkVf63NcFWYmoWsNaaGXu5eIAp
         f1Z6yyFeWUCGqGLelmkW2gZf0Uz1tUNhBSkUrH0y6CaJGO73Ufc1wmjZtP+5yUhi460C
         knnQ==
X-Gm-Message-State: AOJu0YyRbid0Mz3qk1Zeum9RGSL+SBoFN1HgTQNK9pk2LmGuc2tTx8tM
	BlRJ9cZ/yryf5vUtwc69E2zZzB70qavHZB3p6d2c6us7uxlvc0EpAxTdFXJo+c7mwOiQ7xEjAg2
	7hmEp9MzKcmkUSbHiugJILUdPTTkS+NsS+gbP6ZUAAkrIouDr3VUjkoxghutarTulDHD7wKGdqZ
	7l38B03+RKlwM6GJCTg2kDskvXJJU2pg==
X-Received: from pjbok15.prod.google.com ([2002:a17:90b:1d4f:b0:36b:c52b:7c2e])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:fc4c:b0:36b:e109:1e63
 with SMTP id 98e67ed59e1d1-36c685a8f89mr13002900a91.27.1780351176452; Mon, 01
 Jun 2026 14:59:36 -0700 (PDT)
Date: Mon,  1 Jun 2026 21:59:09 +0000
In-Reply-To: <20260601215909.3958732-1-praan@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260601215909.3958732-1-praan@google.com>
X-Mailer: git-send-email 2.54.0.1013.g208068f2d8-goog
Message-ID: <20260601215909.3958732-13-praan@google.com>
Subject: [PATCH v8 12/12] iommu/arm-smmu-v3: Add KUnit unit tests for Runtime PM
From: Pranjal Shrivastava <praan@google.com>
To: iommu@lists.linux.dev
Cc: Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>, 
	Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>, Mostafa Saleh <smostafa@google.com>, 
	Nicolin Chen <nicolinc@nvidia.com>, Daniel Mentz <danielmentz@google.com>, 
	Ashish Mhetre <amhetre@nvidia.com>, linux-arm-kernel@lists.infradead.org, 
	Pranjal Shrivastava <praan@google.com>
Content-Type: text/plain; charset="UTF-8"

Introduce kunit selftests to verify the Runtime PM elision gating,
post-suspend elisions and progress on resumption under active
invalidation load. Simulate concurrent HW suspension using a timer.
Mock all HW registers and CMDQ buffers by allocating them on RAM.
Make the mock CMDQ self-consuming to avoid hitting queue_full scenarios.

Signed-off-by: Pranjal Shrivastava <praan@google.com>
---
 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-test.c  | 169 ++++++++++++++++++
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   |   1 +
 2 files changed, 170 insertions(+)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-test.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-test.c
index add671363c82..04c65920c147 100644
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
@@ -771,6 +775,169 @@ static void arm_smmu_v3_invs_test(struct kunit *test)
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
+		if (!IS_ERR(thread1)) kthread_stop(thread1);
+		if (!IS_ERR(thread2)) kthread_stop(thread2);
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
@@ -797,6 +964,8 @@ static struct kunit_case arm_smmu_v3_test_cases[] = {
 	KUNIT_CASE(arm_smmu_v3_write_cd_test_sva_clear),
 	KUNIT_CASE(arm_smmu_v3_write_cd_test_sva_release),
 	KUNIT_CASE(arm_smmu_v3_invs_test),
+	KUNIT_CASE(arm_smmu_v3_rpm_test_stress_race),
+	KUNIT_CASE(arm_smmu_v3_rpm_test_kthread_race),
 	{},
 };
 
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 2e260f85b8fd..d72c891e75ba 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -873,6 +873,7 @@ int arm_smmu_cmdq_issue_cmdlist(struct arm_smmu_device *smmu,
 	local_irq_restore(flags);
 	return ret;
 }
+EXPORT_SYMBOL_IF_KUNIT(arm_smmu_cmdq_issue_cmdlist);
 
 static int arm_smmu_cmdq_issue_cmd_p(struct arm_smmu_device *smmu,
 				     struct arm_smmu_cmd *cmd, bool sync)
-- 
2.54.0.1013.g208068f2d8-goog

