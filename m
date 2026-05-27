Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47C563CA491
	for <iommu@lists.linux.dev>; Wed, 27 May 2026 22:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779920081; cv=none; b=ff689eq6sTAROcwW1pQosKiQuQwpULQq/hdfYOOyFUpq61IFqvPXh+x2NAdqIRolYbe8PvH5T+4QSr6q5xakSWzSYv/KJ/2c+NHMTqNu/XL+24dDQOefwe6M0XssQkATyxsb5q4QyjYcCkuP3IJ8XAmtclR+gHGE13XxS7VVnk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779920081; c=relaxed/simple;
	bh=9xe/ZawcHlHdik179vlJOTC8QOkXkjuKRy8LOVU2O0c=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=LjjxcO0qrZGJv3IuVcRrAhhN4/ax8FDMoUnE48OEMmTroRyIW9zu8/CJyZ4l/rBpQ340sJm2/3Nr7mkYZCjhpho+3BlBfd1H8Of8vU7FkYjkN5YGa6EIv4yDx6nRnxODhBZCGJLcWCCmRZW/s9sRk+82ujCQvq29wtCX9ZSJ9ZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FJ/rDvwb; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FJ/rDvwb"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-3663cbff31cso6155193a91.2
        for <iommu@lists.linux.dev>; Wed, 27 May 2026 15:14:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779920078; x=1780524878; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=S7BBhgFZ8Ma4OIokkNAhr8EAGinTewemkDEloxmI0Rw=;
        b=FJ/rDvwb3cHudoIm0B+WYqV05kcEkq5kJE5vHJ3Y5YGCQsULN4IVHZhVR5JCPBuDCE
         n5DzP2D5qErgvBBe7fwR94wsyTsID8uxD7+yIP+KLq4WPreGzlyUotM2KgBHitdqo4Yo
         TbD8Ir+ur2uJrMP9Qw0YXeZqYkTvvRmWlv8+pWaKT205RIClAyTcpCojPxaabyyCeRd8
         40HkRznFEuXo0iKPnUkTjmc1TcEpEyn7kLwvyBTnGTJ1bZYAkZCKr/JBehYcox2deZ1j
         gbBuxDG1rTP5IjUr+XVYjjnPTbmp9nPEsYjmnBvtg1AxTpR3UpF/mGNi5NixKba/3j4A
         qKBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779920078; x=1780524878;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S7BBhgFZ8Ma4OIokkNAhr8EAGinTewemkDEloxmI0Rw=;
        b=OA7Xf+B6cat2FE3oAqnopoggFP4U5JpmExxmHoq4sGi7Lz7oXXfp7HhF9J4B9zC2u6
         qlztGPl/E2zTPZZ+pFHeLbduEAz85UyqW/4OVXEt3CTiZ1qTwUnmn+N0rZq4TjLfa9xR
         fW5AW1NSme5PKIhvc+ntRttUGP4jK927Tkyyb23Z2/gIj6/mS+POF9cW64YYJxIlpiYG
         EAjyBtJcN5dbFHvJB3EFOUU1sqgY6SuSGjN47jWu0NToJE6RNJMcBdKVoAZ9kkZjNuIq
         wKNEfQl3/aHP/FWqoKMgRA1buHIPgBgGTWVm3SfNprtYuZ51P2X/opApTuOrHsFTtm2i
         g5LQ==
X-Gm-Message-State: AOJu0YySU+CeIlayknje+4opFnqvoI3vk5B8NfoLSH3ZpaaC7oq6kmRw
	y6nG3iLCUmspaz6S7cXI/WrRWT9Uc1ucKyfhsxd6lOZ9K1oB0VlWBRVlVPFErEc7sUzz9KxFOlN
	bzRfmZ1/7PtvakjRHt3f0reqew0lv8n1Lh+XeOmJ/SY3Nqln46DPttTsZ4mrY2i8WZGFmOgKsJm
	7VRIK8dtG84n9pJuqytUbMHY5QE8Fv5g==
X-Received: from pjbgz7.prod.google.com ([2002:a17:90b:ec7:b0:366:3a03:b66d])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3882:b0:366:132:fda7
 with SMTP id 98e67ed59e1d1-36a6771a702mr25194976a91.10.1779920078032; Wed, 27
 May 2026 15:14:38 -0700 (PDT)
Date: Wed, 27 May 2026 22:14:07 +0000
In-Reply-To: <20260527221407.1756491-1-praan@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260527221407.1756491-1-praan@google.com>
X-Mailer: git-send-email 2.54.0.794.g4f17f83d09-goog
Message-ID: <20260527221407.1756491-12-praan@google.com>
Subject: [PATCH v7 11/11] iommu/arm-smmu-v3: Add KUnit unit tests for Runtime PM
From: Pranjal Shrivastava <praan@google.com>
To: iommu@lists.linux.dev
Cc: Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>, 
	Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>, Mostafa Saleh <smostafa@google.com>, 
	Nicolin Chen <nicolinc@nvidia.com>, Daniel Mentz <danielmentz@google.com>, 
	Ashish Mhetre <amhetre@nvidia.com>, linux-arm-kernel@lists.infradead.org, 
	Pranjal Shrivastava <praan@google.com>
Content-Type: text/plain; charset="UTF-8"

Introduce a kunit selftests to verify the Runtime PM elision gating,
post-suspend elisions and progress on resumption under active
invalidation load. Simulate concurrent HW suspension using a timer.
Mock all HW registers and CMDQ buffers by allocating them on RAM.
Make the mock CMDQ self-consuming to avoid hitting queue_full scenarios.

Signed-off-by: Pranjal Shrivastava <praan@google.com>
---
 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-test.c  | 150 ++++++++++++++++++
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   |   1 +
 2 files changed, 151 insertions(+)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-test.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-test.c
index add671363c82..ef9a17343ed8 100644
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
@@ -771,7 +775,153 @@ static void arm_smmu_v3_invs_test(struct kunit *test)
 	kfree(test_b);
 }
 
+struct arm_smmu_test_pm_context {
+	u32 *mock_prod_reg;
+	u64 *mock_base;
+	unsigned long *mock_valid_map;
+};
+
+/*
+ * Shared helper to allocate and map a fully functional, self-consuming mock
+ * CMDQ. By redirecting both prod_reg and cons_reg to the same memory location,
+ * every producer write is instantly reflected as a consumer completion.
+ */
+static struct arm_smmu_test_pm_context *
+arm_smmu_v3_test_init_mock_cmdq(struct kunit *test, struct arm_smmu_device *smmu)
+{
+	struct arm_smmu_test_pm_context *ctx;
+	struct arm_smmu_cmdq *cmdq = &smmu->cmdq;
+
+	ctx = kunit_kzalloc(test, sizeof(*ctx), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, ctx);
+
+	/* Use a standard 1024-entry queue for safe word bitmask alignment */
+	ctx->mock_prod_reg = kunit_kzalloc(test, sizeof(u32), GFP_KERNEL);
+	ctx->mock_base = kunit_kzalloc(test, 1024 * 16, GFP_KERNEL);
+	ctx->mock_valid_map = kunit_kzalloc(test, BITS_TO_LONGS(1024) * sizeof(long), GFP_KERNEL);
+
+	KUNIT_ASSERT_NOT_NULL(test, ctx->mock_prod_reg);
+	KUNIT_ASSERT_NOT_NULL(test, ctx->mock_base);
+	KUNIT_ASSERT_NOT_NULL(test, ctx->mock_valid_map);
+
+	smmu->features = 0;
+	/* 1024 entries */
+	cmdq->q.llq.max_n_shift = 10;
+	/* SMMUv3 commands are 2 dwords (16 bytes) */
+	cmdq->q.ent_dwords = 2;
+	cmdq->q.base = (__le64 *)ctx->mock_base;
+	cmdq->valid_map = (atomic_long_t *)ctx->mock_valid_map;
+
+	/* Self-Consuming, prod == cons always ensures queue empty */
+	cmdq->q.prod_reg = (__force u32 __iomem *)ctx->mock_prod_reg;
+	cmdq->q.cons_reg = (__force u32 __iomem *)ctx->mock_prod_reg;
+
+	/* Initialize memory indices */
+	atomic_set(&cmdq->q.llq.atomic.prod, 0);
+	atomic_set(&cmdq->q.llq.atomic.cons, 0);
+	atomic_set(&cmdq->owner_prod, 0);
+	*ctx->mock_prod_reg = 0;
+
+	return ctx;
+}
+
+struct arm_smmu_test_timer_context {
+	struct kunit *test;
+	struct arm_smmu_device *smmu;
+	struct arm_smmu_test_pm_context *pm_ctx;
+	struct timer_list timer;
+	bool stopped;
+};
+
+/* Asynchronous timer callback running in softirq context */
+static void arm_smmu_v3_test_rpm_timer_callback(struct timer_list *t)
+{
+	struct arm_smmu_test_timer_context *ctx =
+		timer_container_of(ctx, t, timer);
+	struct arm_smmu_cmdq *cmdq = &ctx->smmu->cmdq;
+
+	/*
+	 * Asynchronously set the STOP_FLAG (Close the gate).
+	 * Simulate a concurrent runtime suspend event interrupting
+	 * the invalidations happening under active load.
+	 */
+	atomic_or(CMDQ_PROD_STOP_FLAG, &cmdq->q.llq.atomic.prod);
+
+	/* Signal to the main storm loop that suspend has triggered */
+	WRITE_ONCE(ctx->stopped, true);
+}
+
+/*
+ * Verify SMMU PM Runtime gating, elision, and post-suspend resumption
+ * safety sequentially under active stress.
+ */
+static void arm_smmu_v3_test_rpm_stress_race(struct kunit *test)
+{
+	struct arm_smmu_device *smmu = kunit_kzalloc(test, sizeof(*smmu), GFP_KERNEL);
+	struct arm_smmu_test_pm_context *pm_ctx;
+	struct arm_smmu_test_timer_context *timer_ctx;
+	struct arm_smmu_cmdq *cmdq = &smmu->cmdq;
+	struct arm_smmu_cmd cmd = arm_smmu_make_cmd_cfgi_all();
+	u32 stopped_prod;
+	int i, ret;
+
+	KUNIT_ASSERT_NOT_NULL(test, smmu);
+	pm_ctx = arm_smmu_v3_test_init_mock_cmdq(test, smmu);
+
+	timer_ctx = kunit_kmalloc(test, sizeof(*timer_ctx), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, timer_ctx);
+	timer_ctx->test = test;
+	timer_ctx->smmu = smmu;
+	timer_ctx->pm_ctx = pm_ctx;
+	timer_ctx->stopped = false;
+
+	/* Setup the kernel software timer */
+	timer_setup(&timer_ctx->timer, arm_smmu_v3_test_rpm_timer_callback, 0);
+
+	/* Start the timer to fire in 10 jiffies */
+	mod_timer(&timer_ctx->timer, jiffies + msecs_to_jiffies(10));
+
+	/* Execute the unmap storm until the timer triggers */
+	while (!READ_ONCE(timer_ctx->stopped)) {
+		ret = arm_smmu_cmdq_issue_cmdlist(smmu, cmdq, &cmd, 1, false);
+		if (ret != 0) {
+			KUNIT_FAIL(test, "Unmap Storm loop failed to submit cmd list: %d\n", ret);
+			break;
+		}
+
+		usleep_range(50, 100);
+	}
+
+	timer_delete_sync(&timer_ctx->timer);
+
+	/* Establish the globally stable, post-storm register baseline index */
+	stopped_prod = *pm_ctx->mock_prod_reg;
+
+	/*
+	 * Attempt multiple unmaps while the SMMU is disabled (STOP_GATE is set)
+	 * Every single invalidation must be instantly elided, returning 0
+	 * immediately and leaving the mock MMIO register completely frozen.
+	 */
+	for (i = 0; i < 1000; i++) {
+		ret = arm_smmu_cmdq_issue_cmdlist(smmu, cmdq, &cmd, 1, false);
+		if (ret != 0) {
+			KUNIT_FAIL(test, "Gated storm loop failed at iteration %d: %d\n", i, ret);
+			break;
+		}
+	}
+	KUNIT_EXPECT_EQ(test, stopped_prod, *pm_ctx->mock_prod_reg);
+
+	/*
+	 * Clear the STOP_FLAG (resume SMMU). A new invalidation must now
+	 * successfully commit, moving the prod_reg by exactly 1 slot
+	 */
+	atomic_andnot(CMDQ_PROD_STOP_FLAG, &cmdq->q.llq.atomic.prod);
+	KUNIT_EXPECT_EQ(test, 0, arm_smmu_cmdq_issue_cmdlist(smmu, cmdq, &cmd, 1, false));
+	KUNIT_EXPECT_EQ(test, stopped_prod + 1, *pm_ctx->mock_prod_reg);
+}
+
 static struct kunit_case arm_smmu_v3_test_cases[] = {
+	KUNIT_CASE(arm_smmu_v3_test_rpm_stress_race),
 	KUNIT_CASE(arm_smmu_v3_write_ste_test_bypass_to_abort),
 	KUNIT_CASE(arm_smmu_v3_write_ste_test_abort_to_bypass),
 	KUNIT_CASE(arm_smmu_v3_write_ste_test_cdtable_to_abort),
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index d42f78777571..dd7cfd3c16f4 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -871,6 +871,7 @@ int arm_smmu_cmdq_issue_cmdlist(struct arm_smmu_device *smmu,
 	local_irq_restore(flags);
 	return ret;
 }
+EXPORT_SYMBOL_IF_KUNIT(arm_smmu_cmdq_issue_cmdlist);
 
 static int arm_smmu_cmdq_issue_cmd_p(struct arm_smmu_device *smmu,
 				     struct arm_smmu_cmd *cmd, bool sync)
-- 
2.54.0.794.g4f17f83d09-goog

