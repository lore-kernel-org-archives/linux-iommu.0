Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 863A2414A11
	for <iommu@lists.linux.dev>; Tue, 28 Jul 2026 21:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785272983; cv=none; b=Qy6WcwBdyeiffDk+WeUXnD7LLXfKEWwC/TsP4yppj5RMcISOaZqInK/pg4oyb/wsPYFaJ3tHSGP2FrIlULedempuTBzlitdhEQIRM6cLJ5vxbnbHHklEYNfj3M0TO2mF73WEdZ4BqoczjwDGAd3wgGg3x0acGa9tYoV0g/2EbQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785272983; c=relaxed/simple;
	bh=ZI2iFcUiYUQHXcsj5rsSBMSTHShcHJwTeeL21ml2npo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=pkbJGjdkkXZGtEfV7c63maROT7Llics2VNNkHOhDh/WUtg7y9LiG0OP3qLo/KmHbM7LI8mnFGiu+JzcY7ji8aCOdp00A7SbnN01HlAQ6bbZcPzVl0p6ZZL7lUbuJDVXtLhHH8z/OBpjrB7bi9qLR6WQZXbYK8yoqN4XLilKrLWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=K+R3NcNv; arc=none smtp.client-ip=209.85.214.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="K+R3NcNv"
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2ccd1958e8fso4325505ad.2
        for <iommu@lists.linux.dev>; Tue, 28 Jul 2026 14:09:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785272982; x=1785877782; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bCgrcRKU1nB4E0G4qMe0gJqryU3wt9UNU2vaPfypDCA=;
        b=K+R3NcNvmDs4q++L1AHyKmdE9J9R/5f6SLHH/foQRrREK8fMW77p5QRUxBUFfZIHWK
         a4qPz0TvDFSweio4T5Ef7sayRuCaKCmUcpFAWT7zXuy5qiAs4dzJhB5J0BuOY8h5DwOF
         3cdlx2QnFn6T1UyyURo21vty+Kkgy3zUsXIJTag2U+l1NVsLlncdrLUabW0UXm4o6KEU
         Poa2E3X8q0i7eaLpyNofs1myCOkjagJzPgHasSJTLdr+MJ83aDsOs4tinraplL/3W4VQ
         p7OroDmZcpwcESqsmfRi940dyL+TzONBQxcAwIQ8zdmRJ5TLBPxU5Q6f5tQ7mFCbqDtw
         7MhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785272982; x=1785877782;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bCgrcRKU1nB4E0G4qMe0gJqryU3wt9UNU2vaPfypDCA=;
        b=R0gtEaRHpTkOrIiRqYjA5aB/ErncDvr9CozWML45HX1OujPcTjNmeCUrrqwLMWhzUt
         3WSF34leE9feCz4HeWLjLkzNyKKpVZOUr07OoeVR0aw2Upy7eKVKRHdMdpoRahGcaMK2
         rUSAcGc78qZ0p1BLZ/816InGSR8ZaqJyt1gHNIrB/KR409HcQX9YBdPLma7F2C3JSGl0
         8oz0hSA0GWA+gdpELsS0wDQKxDyuVa+d0usEECobBPHPGo31evBBSWvsm0LYcKykRArM
         QAKnDkoJRq/9GV7KhoTHBtEwJgLkm698XlObuwqyD/WiyUZHA4DVLbpbfI1YWu1mSYxV
         TroQ==
X-Gm-Message-State: AOJu0YyyrF2B+qrI5UQucYipo9BcphgX5MpQh5DNQlUH2INOFdD4LzIA
	sdAVlZryRYK7+0eaO+yJsVpl3/tI7Q5ykNgcgy+lc22MgblMZosw+6JRMG5Ixrlp3BIeV41XVFa
	sPrrEEsBkCGS/2uiGx5oPAIgevXJj+f/+ktfcFFvgLfq+KxZGxTzTcv+FG1zCuIHlxkipAFB2WO
	bsF/9V9/2d9RZqOQLxM/JtjV7831pb5A==
X-Received: from plij8.prod.google.com ([2002:a17:903:3808:b0:2cc:e64a:e6da])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:26cc:b0:2cf:7ffb:82aa
 with SMTP id d9443c01a7336-2d015d4739dmr45426485ad.45.1785272981504; Tue, 28
 Jul 2026 14:09:41 -0700 (PDT)
Date: Tue, 28 Jul 2026 21:09:19 +0000
In-Reply-To: <20260728210928.1050849-1-praan@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260728210928.1050849-1-praan@google.com>
X-Mailer: git-send-email 2.55.0.487.gaf234c4eb3-goog
Message-ID: <20260728210928.1050849-4-praan@google.com>
Subject: [PATCH v9 03/12] iommu/tegra241-cmdqv: Add a helper to drain VCMDQs
From: Pranjal Shrivastava <praan@google.com>
To: iommu@lists.linux.dev
Cc: Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>, 
	Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>, Mostafa Saleh <smostafa@google.com>, 
	Nicolin Chen <nicolinc@nvidia.com>, Daniel Mentz <danielmentz@google.com>, 
	linux-arm-kernel@lists.infradead.org, Pranjal Shrivastava <praan@google.com>
Content-Type: text/plain; charset="UTF-8"

The tegra241-cmdqv driver supports vCMDQs which need to be drained
before suspending the SMMU. The current driver implementation only uses
VINTF0 for vCMDQs owned by the kernel which need to be drained. Add a
helper that drains all the enabled vCMDQs under VINTF0.

Add another function ptr to arm_smmu_impl_ops to drain implementation
specified queues and call it within `arm_smmu_drain_queues`.

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Pranjal Shrivastava <praan@google.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   |  7 ++++
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  1 +
 .../iommu/arm/arm-smmu-v3/tegra241-cmdqv.c    | 35 +++++++++++++++++++
 3 files changed, 43 insertions(+)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 08b83f211ab3..96ca4a024cdd 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -991,6 +991,13 @@ static int arm_smmu_drain_queues(struct arm_smmu_device *smmu)
 	 */
 	ret = arm_smmu_queue_poll_until_empty(smmu, &smmu->cmdq.q);
 
+	if (ret)
+		goto out;
+
+	/* Drain all implementation-specific queues */
+	if (smmu->impl_ops && smmu->impl_ops->drain_queues)
+		ret = smmu->impl_ops->drain_queues(smmu);
+out:
 	return ret;
 }
 
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 00ad2e0c257b..adfcbb654673 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -886,6 +886,7 @@ struct arm_smmu_impl_ops {
 	size_t (*get_viommu_size)(enum iommu_viommu_type viommu_type);
 	int (*vsmmu_init)(struct arm_vsmmu *vsmmu,
 			  const struct iommu_user_data *user_data);
+	int (*drain_queues)(struct arm_smmu_device *smmu);
 };
 
 /* An SMMUv3 instance */
diff --git a/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c b/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
index 6644075c1431..f62e9bdabf8a 100644
--- a/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
+++ b/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
@@ -447,6 +447,40 @@ tegra241_cmdqv_get_cmdq(struct arm_smmu_device *smmu,
 	return &vcmdq->cmdq;
 }
 
+static int tegra241_cmdqv_drain_vintf0_lvcmdqs(struct arm_smmu_device *smmu)
+{
+	struct tegra241_cmdqv *cmdqv =
+		container_of(smmu, struct tegra241_cmdqv, smmu);
+	struct tegra241_vintf *vintf = cmdqv->vintfs[0];
+	int ret = 0;
+	u16 lidx;
+
+	/*
+	 * Kernel only uses VINTF0. Return if it's disabled.
+	 * Note: Lockless reads of the enabled flags are safe here.
+	 * VINTF0 is initialized during probe() (before Runtime PM is
+	 * enabled) and de-initialized during remove() (after the driver
+	 * core has called pm_runtime_disable()). Thus, this drain helper,
+	 * running only in runtime_suspend(), cannot race against VINTF0
+	 * creation or destruction.
+	 */
+	if (!READ_ONCE(vintf->enabled))
+		return 0;
+
+	for (lidx = 0; lidx < cmdqv->num_lvcmdqs_per_vintf; lidx++) {
+		struct tegra241_vcmdq *vcmdq = vintf->lvcmdqs[lidx];
+
+		if (!vcmdq || !READ_ONCE(vcmdq->enabled))
+			continue;
+
+		ret = arm_smmu_queue_poll_until_empty(smmu, &vcmdq->cmdq.q);
+		if (ret)
+			break;
+	}
+
+	return ret;
+}
+
 /* HW Reset Functions */
 
 /*
@@ -905,6 +939,7 @@ static struct arm_smmu_impl_ops tegra241_cmdqv_impl_ops = {
 	.device_reset = tegra241_cmdqv_hw_reset,
 	.device_disable = tegra241_cmdqv_hw_disable,
 	.device_remove = tegra241_cmdqv_remove,
+	.drain_queues = tegra241_cmdqv_drain_vintf0_lvcmdqs,
 	/* For user-space use */
 	.hw_info = tegra241_cmdqv_hw_info,
 	.get_viommu_size = tegra241_cmdqv_get_vintf_size,
-- 
2.55.0.487.gaf234c4eb3-goog

