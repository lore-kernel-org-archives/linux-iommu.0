Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 732C83FCB1C
	for <iommu@lists.linux.dev>; Tue, 28 Jul 2026 21:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785272995; cv=none; b=Ws65SG7thR4m290m8TVaqeMkWzwvi26OstTS50upTzudJrmBZ9gccahJ+y48bwtD7vx6KT1j4PMKkSiPOcinsG984asdXZXPsqG0jdRsAjUDbnKjYr29bxGNo4BRYev6FVREWNxaL0jkG+huGccPOya4MWD/OZYiq3yAmXOLGEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785272995; c=relaxed/simple;
	bh=rCwHlRmsAM/K8tChcmi8vSWfoYrU8LRjF3znTUncz8I=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=PZJXqwXJWGveyxLgAxbeBtjUvZbH37KaHRMZqRp/DtksJCdTUArW+dzw7fojFcl9Ibb4k9KcKkLHAjO64SfDTlC6AdpfcqYiQ/oOInKAZP0zfNi8kzxWCyngMY8nV4GiFOQ4DTogCgDKwqd2r7CfHHg/CBeUlD1Hn9J+4WZgzfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fMIwFnpI; arc=none smtp.client-ip=209.85.215.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fMIwFnpI"
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-cb7049fa552so138615a12.2
        for <iommu@lists.linux.dev>; Tue, 28 Jul 2026 14:09:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785272994; x=1785877794; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KxItAIafgzEWpgvlD1boJ4CXcti6VEwEZqB89OI68jc=;
        b=fMIwFnpIkMUWp9awqzldyVa5JJpW/5lfdJgCBLkvKjeVVOsDFCSkls2X9e02Bfj6an
         KO0rrdi3BRicVQZTgJUPvmyxJe3S2nMI8S8ry1dAuWKVreLDWk9flXBg2LXlIPHolNaT
         yrpTmqtVqGJ8GpSeStIK1hlTU22tzg17HSqwR5dkaPov1R9juQMgcd47mJI48T9gPJJe
         5CBoP8rUQ5gpEBFqVM5Dib3olw3IDH6tlCvH4iZCkBdQOphp9R216Oi0cEbqc5IwGCGf
         JxLGIJ9zXLn9r5fJAzrwrnI8QkQHUnr50pl+ICRs3M+Un6L9x9QwnazHN6SfNHitRFRl
         0dSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785272994; x=1785877794;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KxItAIafgzEWpgvlD1boJ4CXcti6VEwEZqB89OI68jc=;
        b=Yz7vbp39blHeG4gYbHAgoXDVL94e1shK5HQbgCyEQ2BxoVeqBIOFnXinWWmD14a2M3
         9iAoRX8P9zFsJTfgYniHgdoAXou34Iv3QNexdNHBqCtJimGJMiQjbCFAh/P3CGSYcZiw
         uvqjdKlNeAypm5LlYHkgSUVVbdP7oAbG0I5B2kROFvs573h++1tzTc6Ump+SVzpr05Ji
         4xDG9U8QhWuRgEFv7/ckbXpzr+Vtdv+C/Ebuj87bV8Q/iZNkJnZUQ+blufiljiP8aCDq
         FXh3ul16E4OtA3gr1vaiZGZWdtv1yphkb49+4TGX950IiUQVN8Aiv/n1drYF+L4xv0W4
         C0Ag==
X-Gm-Message-State: AOJu0YwKPP8Xc3xS/+MmB77P9sdevqnXejtvLznpNwvNtGAV39ZC6LOW
	rlX9L81ZlELxlAB64JfjaahSM9PFsd1Y2YfI2210NTF3P3SqbF6zbCHEyqT45Cm22jydxkQ4foL
	+jrfpcQkX//v8/53rBYBJzTYDTI8AxfAgAC3/n6tTPJrYmyUMR73HsZQ2f2nhjq/Laa9IlRPEfR
	OKhcZTrzhlero+9s/XtekGUIVOPKTI2g==
X-Received: from pggg12.prod.google.com ([2002:a63:200c:0:b0:c8b:6fd:f93f])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:1645:b0:3c3:a20f:f729
 with SMTP id adf61e73a8af0-3c8aafb4adbmr5111132637.7.1785272993435; Tue, 28
 Jul 2026 14:09:53 -0700 (PDT)
Date: Tue, 28 Jul 2026 21:09:24 +0000
In-Reply-To: <20260728210928.1050849-1-praan@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260728210928.1050849-1-praan@google.com>
X-Mailer: git-send-email 2.55.0.487.gaf234c4eb3-goog
Message-ID: <20260728210928.1050849-9-praan@google.com>
Subject: [PATCH v9 08/12] iommu/tegra241-cmdqv: Add a helper to quiesce VCMDQs
From: Pranjal Shrivastava <praan@google.com>
To: iommu@lists.linux.dev
Cc: Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>, 
	Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>, Mostafa Saleh <smostafa@google.com>, 
	Nicolin Chen <nicolinc@nvidia.com>, Daniel Mentz <danielmentz@google.com>, 
	linux-arm-kernel@lists.infradead.org, Pranjal Shrivastava <praan@google.com>
Content-Type: text/plain; charset="UTF-8"

The tegra241-cmdqv driver supports vCMDQs which need to be quiesced using
the STOP_FLAG as well. The current driver implementation only uses VINTF0
for vCMDQs owned by the kernel which need to be stopped. Add a helper
that sets the CMDQ_PROD_STOP_FLAG on the vCMDQs as well.

Consolidate this logic by renaming the implementation hook to
quiesce_and_drain_queues and ensuring that the tegra241-cmdqv driver
gates all active local virtual queues before starting the drain loop.
Additionally, clear the STOP_FLAG in tegra241_vcmdq_hw_init() as a part
of tegra241_cmdqv_hw_reset.

Suggested-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Pranjal Shrivastava <praan@google.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   |  4 +-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  2 +-
 .../iommu/arm/arm-smmu-v3/tegra241-cmdqv.c    | 37 +++++++++++++++++--
 3 files changed, 37 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 8809757ebee8..49e15d062dd5 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -1013,8 +1013,8 @@ static int arm_smmu_drain_queues(struct arm_smmu_device *smmu)
 		goto out;
 
 	/* Drain all implementation-specific queues */
-	if (smmu->impl_ops && smmu->impl_ops->drain_queues)
-		ret = smmu->impl_ops->drain_queues(smmu);
+	if (smmu->impl_ops && smmu->impl_ops->quiesce_and_drain_queues)
+		ret = smmu->impl_ops->quiesce_and_drain_queues(smmu);
 out:
 	return ret;
 }
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 40b889998d5b..cc25f307a9e4 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -891,7 +891,7 @@ struct arm_smmu_impl_ops {
 	size_t (*get_viommu_size)(enum iommu_viommu_type viommu_type);
 	int (*vsmmu_init)(struct arm_vsmmu *vsmmu,
 			  const struct iommu_user_data *user_data);
-	int (*drain_queues)(struct arm_smmu_device *smmu);
+	int (*quiesce_and_drain_queues)(struct arm_smmu_device *smmu);
 };
 
 /* An SMMUv3 instance */
diff --git a/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c b/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
index 8ecd2052b6dd..32139797c19b 100644
--- a/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
+++ b/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
@@ -447,6 +447,26 @@ tegra241_cmdqv_get_cmdq(struct arm_smmu_device *smmu,
 	return &vcmdq->cmdq;
 }
 
+static void tegra241_cmdqv_quiesce_vintf0_lvcmdqs(struct arm_smmu_device *smmu)
+{
+	struct tegra241_cmdqv *cmdqv =
+		container_of(smmu, struct tegra241_cmdqv, smmu);
+	struct tegra241_vintf *vintf = cmdqv->vintfs[0];
+	u16 lidx;
+
+	if (!READ_ONCE(vintf->enabled))
+		return;
+
+	for (lidx = 0; lidx < cmdqv->num_lvcmdqs_per_vintf; lidx++) {
+		struct tegra241_vcmdq *vcmdq = vintf->lvcmdqs[lidx];
+
+		if (!vcmdq || !READ_ONCE(vcmdq->enabled))
+			continue;
+
+		atomic_or(CMDQ_PROD_STOP_FLAG, &vcmdq->cmdq.q.llq.atomic.prod);
+	}
+}
+
 static int tegra241_cmdqv_drain_vintf0_lvcmdqs(struct arm_smmu_device *smmu)
 {
 	struct tegra241_cmdqv *cmdqv =
@@ -467,6 +487,14 @@ static int tegra241_cmdqv_drain_vintf0_lvcmdqs(struct arm_smmu_device *smmu)
 	if (!READ_ONCE(vintf->enabled))
 		return 0;
 
+	/*
+	 * Gate all vCMDQs by setting the STOP_FLAG in a separate,
+	 * initial loop to ensure no new commands can be submitted
+	 * to any secondary queue while we are waiting to drain them.
+	 */
+	tegra241_cmdqv_quiesce_vintf0_lvcmdqs(smmu);
+
+	/* Now that all queues are safely gated, drain them sequentially. */
 	for (lidx = 0; lidx < cmdqv->num_lvcmdqs_per_vintf; lidx++) {
 		struct tegra241_vcmdq *vcmdq = vintf->lvcmdqs[lidx];
 
@@ -552,14 +580,17 @@ static int tegra241_vcmdq_hw_init(struct tegra241_vcmdq *vcmdq)
 
 	/* Configure and enable VCMDQ */
 	writeq_relaxed(vcmdq->cmdq.q.q_base, REG_VCMDQ_PAGE1(vcmdq, BASE));
-
 	/*
 	 * HW Registers reset to 0 when power-cycled. Restore them from their
 	 * SW copies to prevent executing stale/ghost commands after resume.
 	 */
-	writel_relaxed(vcmdq->cmdq.q.llq.prod, REG_VCMDQ_PAGE0(vcmdq, PROD));
+	writel_relaxed(vcmdq->cmdq.q.llq.prod & CMDQ_PROD_IDX_MASK,
+		       REG_VCMDQ_PAGE0(vcmdq, PROD));
 	writel_relaxed(vcmdq->cmdq.q.llq.cons, REG_VCMDQ_PAGE0(vcmdq, CONS));
 
+	/* Clear the CMDQ_PROD_STOP_FLAG */
+	atomic_andnot(CMDQ_PROD_STOP_FLAG, &vcmdq->cmdq.q.llq.atomic.prod);
+
 	ret = vcmdq_write_config(vcmdq, VCMDQ_EN);
 	if (ret) {
 		dev_err(vcmdq->cmdqv->dev,
@@ -946,7 +977,7 @@ static struct arm_smmu_impl_ops tegra241_cmdqv_impl_ops = {
 	.device_reset = tegra241_cmdqv_hw_reset,
 	.device_disable = tegra241_cmdqv_hw_disable,
 	.device_remove = tegra241_cmdqv_remove,
-	.drain_queues = tegra241_cmdqv_drain_vintf0_lvcmdqs,
+	.quiesce_and_drain_queues = tegra241_cmdqv_drain_vintf0_lvcmdqs,
 	/* For user-space use */
 	.hw_info = tegra241_cmdqv_hw_info,
 	.get_viommu_size = tegra241_cmdqv_get_vintf_size,
-- 
2.55.0.487.gaf234c4eb3-goog

