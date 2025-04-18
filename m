Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE95620C037
	for <iommu@lists.linux.dev>; Fri, 18 Apr 2025 23:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745019294; cv=none; b=bCWkz+aq/ywqRdes5UT8Paqtik6Rkez61DlJbrqs/iLYy+4raMlR50G+ITWf+3QsN20Dm2hEOqtosdpmPvxwAMeihDPXL07I1NraLWrarY0AtD6nOutmoBYY4fkCErFRoYvNaC/CZ6l9ye0Oya+2mWoQTyC4fLcJiThj/r0iaBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745019294; c=relaxed/simple;
	bh=gFRTkSycQjzcv3D0FOKnwtTPvpreBZ4mn8ioJTzvVno=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=PiMfo/6spPFYoeIjAcPAIosjLcyd7TK0GM42s9dJY4lQzWqImI+0+eayeMEQY1PRHq2Q2OyawGbJBysp5NqY/Fn5jOrFNX+ZHwhk1uL+d3WKp1dQZxkAl8IS+XlhUZg7scis9+NR+MHhn4a2ZRS8Ml8wMegow4iTT8ZZEj54ZUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=O8ZCAbg4; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="O8ZCAbg4"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-73c2f5c284cso2509131b3a.3
        for <iommu@lists.linux.dev>; Fri, 18 Apr 2025 16:34:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745019292; x=1745624092; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=4FqZ1IEyqAcKjSuSe67954Kt8CwkQNMYFmK2ZTVcDQg=;
        b=O8ZCAbg4VKEifGrR3iVer88IvNIUhHO9X1v9KIiciKhuuku1mSmAO6R+PWEje3UpcA
         zXscQyBWtyh8o9d/OEA1bHEORwCMLFBZZRz+BCh9AXQ8IuCPux668+xw4EyWMt1lkPsG
         YPdN4ihxGqbbuKRUcls9bMO0xWKVT8i106ttkGmIsnYEsM+xXbyjrCIRYGavI8xMNK7E
         zQmWkgb+6JxNO6hLNeBEVszGs2/AuJBgaBlwAgQ1hCU6Y5Z9l+qUZsIOd8F7KuKNPjwi
         RrSrv7nnxrt6qjql1NsvRcBcb/M9Yb8AvlJbKezCou/e+EEONMbUZBPi6vUryRE8b1JN
         Z1Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745019292; x=1745624092;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4FqZ1IEyqAcKjSuSe67954Kt8CwkQNMYFmK2ZTVcDQg=;
        b=eQLdTgjsh4VLcv4FFC9MhH6+VJ/3AO2YaBUAzoneRtijVw/FrCDc8w2978+M+AVnEH
         XkzlrV/OSRwyDft7k2Vgh0RXRdYzPXRpNKU6Nbk4r8a+F7Y4NEDRjGbHD/A90llzxH5i
         tSFH/VO3HI+rey6nqVYjvhHQsCo0D5wCFTe0zYd76+uP09JChaPIX7qqlbwhmfXKaKDE
         XU/Qb38TmCHD9oGcIVUAT8oRVeCMF7lNxDTyG6HDWYgfzzkCt1D25pDlyJdzHL61KnDW
         P3UpP9zIzKxYREPdEd2V7BOZ4XfObG35g6dq9shtEksSx6Ew1lVmij5HjTDkRcFBvjrN
         mtEg==
X-Forwarded-Encrypted: i=1; AJvYcCUsnIhwXK1xGocm6oeKrWIZ1fV6wFNGxp925NWmf0Fma7MietIrppl8idJW4JmEm3/mkhdHLQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyqtYhmQIs1Ch+QI4grPnBx7eoVv0BCXqK1VhbYn780OUg+Fq02
	4hWtHGq8Orhn+Od+gqxD7CQZs4ssQpZ/Rk//Z1WkEukyruG+k74T5/GUXDfCSpFn0+Ayw7rpfg=
	=
X-Google-Smtp-Source: AGHT+IFeAgCl+k3aS5SX+KDMYlH8hbUxFWW5XorojXcc4TiXomjBT+kY3bqzjwwrZnwoqJrd24xj4m15aw==
X-Received: from pfbhw24.prod.google.com ([2002:a05:6a00:8918:b0:736:a320:25bd])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:3a44:b0:1f5:7280:1cf7
 with SMTP id adf61e73a8af0-203cbc5a1camr6197066637.16.1745019292097; Fri, 18
 Apr 2025 16:34:52 -0700 (PDT)
Date: Fri, 18 Apr 2025 23:34:02 +0000
In-Reply-To: <20250418233409.3926715-1-praan@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250418233409.3926715-1-praan@google.com>
X-Mailer: git-send-email 2.49.0.805.g082f7c87e0-goog
Message-ID: <20250418233409.3926715-4-praan@google.com>
Subject: [RFC PATCH v2 03/10] iommu/tegra241-cmdqv: Add a helper to drain VCMDQs
From: Pranjal Shrivastava <praan@google.com>
To: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>
Cc: Nicolin Chen <nicolinc@nvidia.com>, Mostafa Saleh <smostafa@google.com>, 
	Daniel Mentz <danielmentz@google.com>, iommu@lists.linux.dev, 
	Pranjal Shrivastava <praan@google.com>
Content-Type: text/plain; charset="UTF-8"

The tegra241-cmdqv driver supports vCMDQs which need to be drained
before suspending the SMMU. The current driver implementation only uses
VINTF0 for vCMDQs owned by the kernel which need to be drained. Add a
helper that drains all the enabled vCMDQs under VINTF0.

Add another function ptr to arm_smmu_impl_ops to drain implementation
specified queues and call it within `arm_smmu_drain_queues`

Signed-off-by: Pranjal Shrivastava <praan@google.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 10 +++++--
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  4 +++
 .../iommu/arm/arm-smmu-v3/tegra241-cmdqv.c    | 28 +++++++++++++++++++
 3 files changed, 39 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 58bfcfb0d04c..7f70e0f4f158 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -981,8 +981,8 @@ static int arm_smmu_cmdq_batch_submit(struct arm_smmu_device *smmu,
 					   cmds->num, true);
 }
 
-static int arm_smmu_queue_poll_until_empty(struct arm_smmu_device *smmu,
-					   struct arm_smmu_queue *q)
+int arm_smmu_queue_poll_until_empty(struct arm_smmu_device *smmu,
+				    struct arm_smmu_queue *q)
 {
 	struct arm_smmu_queue_poll qp;
 	struct arm_smmu_ll_queue *llq = &q->llq;
@@ -1024,7 +1024,11 @@ static int arm_smmu_drain_queues(struct arm_smmu_device *smmu)
 			return ret;
 	}
 
-	return 0;
+	/* Drain all implementation-specific queues */
+	if (smmu->impl_ops && smmu->impl_ops->drain_queues)
+		ret = smmu->impl_ops->drain_queues(smmu);
+
+	return ret;
 }
 
 static void arm_smmu_page_response(struct device *dev, struct iopf_fault *unused,
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index dd1ad56ce863..a950da2e7ed9 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -720,6 +720,7 @@ struct arm_smmu_impl_ops {
 	int (*init_structures)(struct arm_smmu_device *smmu);
 	struct arm_smmu_cmdq *(*get_secondary_cmdq)(
 		struct arm_smmu_device *smmu, struct arm_smmu_cmdq_ent *ent);
+	int (*drain_queues)(struct arm_smmu_device *smmu);
 };
 
 /* An SMMUv3 instance */
@@ -965,6 +966,9 @@ int arm_smmu_init_one_queue(struct arm_smmu_device *smmu,
 int arm_smmu_cmdq_init(struct arm_smmu_device *smmu,
 		       struct arm_smmu_cmdq *cmdq);
 
+int arm_smmu_queue_poll_until_empty(struct arm_smmu_device *smmu,
+				    struct arm_smmu_queue *q);
+
 static inline bool arm_smmu_master_canwbs(struct arm_smmu_master *master)
 {
 	return dev_iommu_fwspec_get(master->dev)->flags &
diff --git a/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c b/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
index dd7d030d2e89..767275e10d43 100644
--- a/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
+++ b/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
@@ -349,6 +349,33 @@ tegra241_cmdqv_get_cmdq(struct arm_smmu_device *smmu,
 	return &vcmdq->cmdq;
 }
 
+static int tegra241_cmdqv_drain_hyp_vcmdqs(struct arm_smmu_device *smmu)
+{
+	struct tegra241_cmdqv *cmdqv =
+		container_of(smmu, struct tegra241_cmdqv, smmu);
+	struct tegra241_vintf *vintf = cmdqv->vintfs[0];
+	struct tegra241_vcmdq *vcmdq;
+	int ret = 0;
+	u16 i;
+
+	/* Kernel only uses VINTF0 return if it's disabled */
+	if (!READ_ONCE(vintf->enabled))
+		return 0;
+
+	for (i = 0; i < cmdqv->num_lvcmdqs_per_vintf; i++) {
+		vcmdq = vintf->lvcmdqs[i];
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
 
 static void tegra241_vcmdq_hw_deinit(struct tegra241_vcmdq *vcmdq)
@@ -681,6 +708,7 @@ static struct arm_smmu_impl_ops tegra241_cmdqv_impl_ops = {
 	.get_secondary_cmdq = tegra241_cmdqv_get_cmdq,
 	.device_reset = tegra241_cmdqv_hw_reset,
 	.device_remove = tegra241_cmdqv_remove,
+	.drain_queues = tegra241_cmdqv_drain_hyp_vcmdqs,
 };
 
 /* Probe Functions */
-- 
2.49.0.805.g082f7c87e0-goog

