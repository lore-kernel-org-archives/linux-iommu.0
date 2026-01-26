Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 622FD330D35
	for <iommu@lists.linux.dev>; Mon, 26 Jan 2026 15:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769440336; cv=none; b=MtRxDuDk2gfWyBn5EOUtL8wO+AmdckkT7laOlPk0Ko0zzL4gT57XMOKx3lrAcUmtGMR6hXy7zMaaorLzJ1kO84HfdPg5X2O9/U1MLl9L/2qNzr5qYB9THXSUPI9khEk1xSv3qNLHCZfEwCIzm+ab40+B5xKY0O8TBUmOiJDUoIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769440336; c=relaxed/simple;
	bh=GIVcFn7zUB7E4P5gvubFhWAT9WLjNP7Pr+RSuC3agAQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=nvNsQE7MnNWcaPxJEzp9+u69WPJyZrqpMEuoKJ24dIZuqm5kOwXsoIT+Eki2wjTJRWBkSrsfog20K10u7Vgz565eWtEuMzEw5FaUQlDPuz1K0CdxIL8GdmKmTv4B14N9gS3s1EI1uUK7xY30JKnkc5LZBNfMYdI7VqUObwtvUfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=M5yVAoH6; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="M5yVAoH6"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-34c314af2d4so3329475a91.3
        for <iommu@lists.linux.dev>; Mon, 26 Jan 2026 07:12:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769440335; x=1770045135; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=X7gpEtpYFeL3cZYJsaCyp3f8uurVGisCYgXh80wOQDM=;
        b=M5yVAoH6K+5ltE6Ob83XjofH9QPi8AKt7SzTHGjtq3mtEn0LPMonMTtLwsYQIedcj4
         UhYJkiLUViDGrmecK4qtqPVF+q3l3kxDhV8yWSRnIDOTxmAp2nBZkDlPD0BE+xMSBjAd
         Jwu4htaSk6IkkakXfQ/SiOn/g7zu2OKzjp6fCMnRYsFeavUAGazqL5oX44qG2s51aL4r
         t0FEWzCuyb47egC7DQPdndWO5xzacn6EBrxaQ1kQVhlOrQLULcezlBosuttJh7N/Pf+c
         u5uOOS1/ZTHwbOa6QbHZR4n6zBfdE2yBQ5oaOTupornFufnq5fNEIx5kaFDLqAkTYJOn
         PdbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769440335; x=1770045135;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X7gpEtpYFeL3cZYJsaCyp3f8uurVGisCYgXh80wOQDM=;
        b=VSaHh1iRE8Tl44snvqpbGF80KpPvUcWigjxGRg1HW65WKlZlZntZoZZbW1/IpT08L6
         mGee4lOI/pxZFDxtSY+2YqSQvxeTLjS5oiX5LmdTcUqGsnj5IWZH9JvVlUlUHKYtAdg3
         JZPOneYgeApN/NOt4POId6QkDrVuU5MxOHYfxuHWUMOkph0qIpXl9rgy9GovEFOw68D3
         m/RK7PL2wukA6JrUQVWkRIgGfqpWL+oKXZd2qjfhf7CYTQKsXSkSUYcGAcgoNXSSPwgl
         yJ/9bkqs7iUy2qkJe0UUsnoj8cQFdEyiDAvvgxH1e2g+WhujcZNcThx64bvKOxZYZIUI
         wzSQ==
X-Gm-Message-State: AOJu0YypxoNoo7ciHlObL4L7kt6vnSOkt3a8sV8nib6Li2c8j9zegeP1
	S28JOhGi3dg6md+KXP0L5vC8qK3MGuTICBOrg0kdBkWtTe9WBHQfoSV3bSXe4JSPIAxf4xoYxU0
	VBir9r4gC20C5/usx2bFYV26tvIJ6cnaLEx762drwwMVhb45RjWEPoBbijzZRddd3hbppWhYX+F
	vYZ46bbUrKYH0F6FrmrutPHEIu+ZDq1w==
X-Received: from pjvf5.prod.google.com ([2002:a17:90a:da85:b0:34c:489a:f4c9])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:da8c:b0:33f:ebc2:643
 with SMTP id 98e67ed59e1d1-353c4156c1cmr4038469a91.23.1769440334577; Mon, 26
 Jan 2026 07:12:14 -0800 (PST)
Date: Mon, 26 Jan 2026 15:11:53 +0000
In-Reply-To: <20260126151157.3418145-1-praan@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260126151157.3418145-1-praan@google.com>
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260126151157.3418145-7-praan@google.com>
Subject: [PATCH v5 06/10] iommu/arm-smmu-v3: Add a usage counter for cmdq
From: Pranjal Shrivastava <praan@google.com>
To: iommu@lists.linux.dev
Cc: Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>, 
	Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>, Mostafa Saleh <smostafa@google.com>, 
	Nicolin Chen <nicolinc@nvidia.com>, Daniel Mentz <danielmentz@google.com>, 
	Ashish Mhetre <amhetre@nvidia.com>, Sairaj Kodilkar <sarunkod@amd.com>, 
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
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 65 +++++++++++++++++----
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  3 +
 2 files changed, 57 insertions(+), 11 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 91edcd8922a7..3a8d3c2a8d69 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -805,7 +805,7 @@ int arm_smmu_cmdq_issue_cmdlist(struct arm_smmu_device *smmu,
 	u64 cmd_sync[CMDQ_ENT_DWORDS];
 	u32 prod;
 	unsigned long flags;
-	bool owner;
+	bool owner, has_ref = false;
 	struct arm_smmu_ll_queue llq, head;
 	int ret = 0;
 
@@ -819,8 +819,15 @@ int arm_smmu_cmdq_issue_cmdlist(struct arm_smmu_device *smmu,
 
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
 
@@ -879,10 +886,35 @@ int arm_smmu_cmdq_issue_cmdlist(struct arm_smmu_device *smmu,
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
@@ -894,14 +926,19 @@ int arm_smmu_cmdq_issue_cmdlist(struct arm_smmu_device *smmu,
 
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
+		if (has_ref || atomic_inc_not_zero(&smmu->nr_cmdq_users)) {
+			has_ref = true;
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
@@ -914,6 +951,9 @@ int arm_smmu_cmdq_issue_cmdlist(struct arm_smmu_device *smmu,
 		}
 	}
 
+	if (has_ref)
+		atomic_dec_return_release(&smmu->nr_cmdq_users);
+
 	local_irq_restore(flags);
 	return ret;
 }
@@ -4310,6 +4350,9 @@ static int arm_smmu_device_reset(struct arm_smmu_device *smmu)
 		return ret;
 	}
 
+	/* Set the cmdq to be active before issuing any commands */
+	atomic_set(&smmu->nr_cmdq_users, 1);
+
 	/* Invalidate any cached configuration */
 	cmd.opcode = CMDQ_OP_CFGI_ALL;
 	arm_smmu_cmdq_issue_cmd_with_sync(smmu, &cmd);
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index d083141c6563..50a2513e4425 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -804,6 +804,9 @@ struct arm_smmu_device {
 
 	struct rb_root			streams;
 	struct mutex			streams_mutex;
+
+	/* Tracks the cmdq usage count for runtime PM */
+	atomic_t			nr_cmdq_users;
 };
 
 struct arm_smmu_stream {
-- 
2.52.0.457.g6b5491de43-goog

