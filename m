Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 390AF32ED5B
	for <iommu@lists.linux.dev>; Mon, 17 Nov 2025 19:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763406912; cv=none; b=CZy+YEIasHMNEiTKwabpDcIhokzarqLiPpF7PJUcd1hSqvAylBe8/xfX5GRJ6TChD8+BFfnXx/opVkWG6VKwyCBrVMnSWqeaxi1ujoML3/Kddz+PmkS8UzHBKzPVL9G+Lmb6WJ668w1fP2wvG4OJ0QR6gugooYCogxIH+W+HnX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763406912; c=relaxed/simple;
	bh=cpbY5S3BABL1PIVn4cjf1/Km0OXi4a2gsxdapXMisZE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ds4k65FiBDGu40Q0DCGdjKkLD1Oz5OC6jW0OYhWnPWCkXgYltjoH4ZJpsTyC7BCLazWiZTYyiwGemnzIOj17CfrK6pddSK2FlNn2v1HXEnTRJXvs/G7FpHlu8EqGqU2rqeFUDNXftwncmsBtfIffuXuqcMcURJBh19f7fTDyK3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mhz+EcGD; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mhz+EcGD"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-340c261fb38so9422537a91.0
        for <iommu@lists.linux.dev>; Mon, 17 Nov 2025 11:15:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763406909; x=1764011709; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=fgQrywQhLR3FZKNoSsO5hsdvoZUTGOMfHovmbLxf1zw=;
        b=mhz+EcGDaoyQ9E+LVBdhHEJKrALAcTjAEks8Fvs2frmk7W9HD3rV+CRUYqJ7gB/wLM
         RKv1QkeoYpjFFuQLE9XqN7mFYotBW737qcAFTfB5hy2RGKPhRoweSQJGOorXNBAXdQz1
         BZkXODwA0obaD55NkSxc0r4v02Qfn4NyEr+BITvoPmtT1YtG099eB6ERnSSEDKBtinEP
         u1BpjSHz6NHLUuNTls2Lk6Xe0sbnt8O0wKtrkxh9FpcT4GtyS6BQc/GJKC9sULMpoEPv
         2GVN5u9H6dEzP8DAmhxrpzJ1OyHPQ+McBiVKSLSyEj43V26UgQUyc0DjEUPjqABnbWFP
         GexA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763406909; x=1764011709;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fgQrywQhLR3FZKNoSsO5hsdvoZUTGOMfHovmbLxf1zw=;
        b=qeG/3F8VPeKVfy/3vaD3gkrG7OEPZC6+O3m6OTXW+4B55alh544Nm/ZpScg2IOy9iE
         MS+kbtC7U5qJExzhDynlZdNC0SgysniWwa0yrwL0iaXZOoqb+CNCVsH21KYFZk8pVd4F
         cLB/9GksDMq/GgVYsd2NdchDKscN29PjTtIvuQyXoH60cMm2UMlGWdJ3TI0RSPucLjz/
         zQZSYiDrRCXDHxhe5rVjl/BV5c/HCf+Dr9LnSH9k4SKPxrftYynrJ9X6JC3svlYECOK2
         u7QcjwJMleOhgS/uHvexuRl8R1UDgs/8LQTUxqKZi/Hy4jYFRN0VF5iguTEAol3MRx14
         bx/g==
X-Gm-Message-State: AOJu0Yy/gG4ZKEXi5vBTghVGPtQNjthjlse52wmy+acJlj+cnkljK2HM
	SXKCbwD7561Kt3ooEd4iJTbOWI11Ie9bxMrNrHy+liHdXwzvs7aNAFHJo02csIp0saosBxgIME5
	onnFQtKzBhPZapHQUsMWVrO58/v+srzaeouFE/I1pVVFiyfqTyXRl91+jpOlCQQaOZ+inFY41u7
	R1eAPPMbhI/75FUx2QnicW2nnB6txHuw==
X-Google-Smtp-Source: AGHT+IEhBpV6oismOU5wTinaIIenupNeAxMnhuKRD1s3NsiLzdEn9nj6NET9iFnTFFlMyL06A7YLsNGxAQ==
X-Received: from pjup20.prod.google.com ([2002:a17:90a:d314:b0:343:a631:28aa])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:280d:b0:334:cb89:bde6
 with SMTP id 98e67ed59e1d1-343f9e93833mr15778539a91.4.1763406909327; Mon, 17
 Nov 2025 11:15:09 -0800 (PST)
Date: Mon, 17 Nov 2025 19:14:30 +0000
In-Reply-To: <20251117191433.3360130-1-praan@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20251117191433.3360130-1-praan@google.com>
X-Mailer: git-send-email 2.52.0.rc1.455.g30608eb744-goog
Message-ID: <20251117191433.3360130-6-praan@google.com>
Subject: [PATCH v4 5/8] iommu/arm-smmu-v3: Add a usage counter for cmdq
From: Pranjal Shrivastava <praan@google.com>
To: iommu@lists.linux.dev
Cc: Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>, 
	Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>, Mostafa Saleh <smostafa@google.com>, 
	Nicolin Chen <nicolinc@nvidia.com>, Daniel Mentz <danielmentz@google.com>, 
	Pranjal Shrivastava <praan@google.com>
Content-Type: text/plain; charset="UTF-8"

Introduce a biased counter to track the number of active cmdq owners as
a preparatory step for the runtime PM implementation.

The counter will be used to gate command submission, preventing the
submission of new commands while the device is suspended and deferring
suspend while the command submissions are in-flight.

The counter is biased to a value of 1 during device reset. A cmdq owner
or a thread issuing cmds with sync, increment it before accessing HW
registers and decrements it with release semantics afterwards.

A value of 1 represents an idle (but active) state. A suspend operation
will set it to from 1 -> 0 representing the suspended state.

Signed-off-by: Pranjal Shrivastava <praan@google.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 69 +++++++++++++++++----
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  3 +
 2 files changed, 61 insertions(+), 11 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 1d6c60bee7dd..d6e75d1646d6 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -794,7 +794,7 @@ int arm_smmu_cmdq_issue_cmdlist(struct arm_smmu_device *smmu,
 	u64 cmd_sync[CMDQ_ENT_DWORDS];
 	u32 prod;
 	unsigned long flags;
-	bool owner;
+	bool owner, has_ref = false;
 	struct arm_smmu_ll_queue llq, head;
 	int ret = 0;
 
@@ -808,8 +808,15 @@ int arm_smmu_cmdq_issue_cmdlist(struct arm_smmu_device *smmu,
 
 		while (!queue_has_space(&llq, n + sync)) {
 			local_irq_restore(flags);
+
+			if (!atomic_inc_not_zero(&smmu->nr_cmdq_users))
+				/* Device is suspended, don't wait for space */
+				return 0;
+
 			if (arm_smmu_cmdq_poll_until_not_full(smmu, cmdq, &llq))
 				dev_err_ratelimited(smmu->dev, "CMDQ timeout\n");
+
+			atomic_dec_return_release(&smmu->nr_cmdq_users);
 			local_irq_save(flags);
 		}
 
@@ -868,10 +875,35 @@ int arm_smmu_cmdq_issue_cmdlist(struct arm_smmu_device *smmu,
 		arm_smmu_cmdq_poll_valid_map(cmdq, llq.prod, prod);
 
 		/*
-		 * d. Advance the hardware prod pointer
+		 * d. Advance the hardware prod pointer (if smmu is still active)
 		 * Control dependency ordering from the entries becoming valid.
 		 */
-		writel_relaxed(prod, cmdq->q.prod_reg);
+		if (atomic_inc_not_zero(&smmu->nr_cmdq_users)) {
+			writel_relaxed(prod, cmdq->q.prod_reg);
+
+			if (sync) {
+				has_ref = true;
+			} else {
+				/*
+				 * Use release semantics to enforce ordering without a full barrier.
+				 * This ensures the prior writel_relaxed() is ordered/visible
+				 * before the refcount decrement, avoiding the heavy pipeline
+				 * stall of a full wmb().
+				 *
+				 * We need the atomic_dec_return_release() below and the
+				 * atomic_set_release() in step (e) below doesn't suffice.
+				 *
+				 * Specifically, without release semantics on the decrement,
+				 * the CPU is free to reorder the independent atomic_dec_relaxed()
+				 * before the writel_relaxed().
+				 *
+				 * If this happens, the refcount could drop to zero, allowing the PM
+				 * suspend path (running on another CPU) to disable the SMMU before
+				 * the register write completes, resulting in a bus fault.
+				 */
+				atomic_dec_return_release(&smmu->nr_cmdq_users);
+			}
+		}
 
 		/*
 		 * e. Tell the next owner we're done
@@ -883,14 +915,23 @@ int arm_smmu_cmdq_issue_cmdlist(struct arm_smmu_device *smmu,
 
 	/* 5. If we are inserting a CMD_SYNC, we must wait for it to complete */
 	if (sync) {
-		llq.prod = queue_inc_prod_n(&llq, n);
-		ret = arm_smmu_cmdq_poll_until_sync(smmu, cmdq, &llq);
-		if (ret) {
-			dev_err_ratelimited(smmu->dev,
-					    "CMD_SYNC timeout at 0x%08x [hwprod 0x%08x, hwcons 0x%08x]\n",
-					    llq.prod,
-					    readl_relaxed(cmdq->q.prod_reg),
-					    readl_relaxed(cmdq->q.cons_reg));
+
+		/* If we are not the owner, check if we're suspended */
+		if (!has_ref) {
+			if (atomic_inc_not_zero(&smmu->nr_cmdq_users))
+				has_ref = true;
+		}
+
+		if (has_ref) {
+			llq.prod = queue_inc_prod_n(&llq, n);
+			ret = arm_smmu_cmdq_poll_until_sync(smmu, cmdq, &llq);
+			if (ret) {
+				dev_err_ratelimited(smmu->dev,
+						    "CMD_SYNC timeout at 0x%08x [hwprod 0x%08x, hwcons 0x%08x]\n",
+						    llq.prod,
+						    readl_relaxed(cmdq->q.prod_reg),
+						    readl_relaxed(cmdq->q.cons_reg));
+			}
 		}
 
 		/*
@@ -903,6 +944,9 @@ int arm_smmu_cmdq_issue_cmdlist(struct arm_smmu_device *smmu,
 		}
 	}
 
+	if (has_ref)
+		atomic_dec_return_release(&smmu->nr_cmdq_users);
+
 	local_irq_restore(flags);
 	return ret;
 }
@@ -4251,6 +4295,9 @@ static int arm_smmu_device_reset(struct arm_smmu_device *smmu)
 		return ret;
 	}
 
+	/* Set the cmdq to be active before issuing any commands */
+	atomic_set(&smmu->nr_cmdq_users, 1);
+
 	/* Invalidate any cached configuration */
 	cmd.opcode = CMDQ_OP_CFGI_ALL;
 	arm_smmu_cmdq_issue_cmd_with_sync(smmu, &cmd);
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 2db0ec14b2ed..924580610ce0 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -806,6 +806,9 @@ struct arm_smmu_device {
 
 	struct rb_root			streams;
 	struct mutex			streams_mutex;
+
+	/* Tracks the cmdq usage count for runtime PM */
+	atomic_t			nr_cmdq_users;
 };
 
 struct arm_smmu_stream {
-- 
2.52.0.rc1.455.g30608eb744-goog

