Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81EF826E6F4
	for <iommu@lists.linux.dev>; Mon, 26 Jan 2026 15:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769440330; cv=none; b=C9nebq+9NmXD1h67ghqyqhfGNG4lA8ANVcUNlc+pqeOuG3QacozBS/fdogJeTZ+FG9IwKN5uQ6+RCt5D5DdkeRgCmPXu4LldwJKzTrCwYO8WPh5gCCH9NG+FveVK8xW3ycOoq1BBAgoYs97q9iVp+6itR8sG5+a/FCusFS02BBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769440330; c=relaxed/simple;
	bh=21iGZ9vUB6B71N+GlkfUDwZibUlIusNFfjRKl4fWqLI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=FY/O2fjgM3H1iU4awuolQMuUBgcWksOAWXHwMQGT6InPrn2ApcW93V5Ovbz+0fGqYJy5TH1ZAGArzSfXeLfV3lZPG1PBfPGl/J+Q51LtP5dj9AJ+JvnJPoVZD5ZJFSo+IEacglszWSrKFi2j4rFlgHEFlYvOrrwZG4hYrkIkslQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HkSVH4+f; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HkSVH4+f"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c617e59845dso2560256a12.1
        for <iommu@lists.linux.dev>; Mon, 26 Jan 2026 07:12:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769440329; x=1770045129; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ifrBIEB1x/ZL3IlZIKiv+q/nbxwMkUHVsZQH0mGL8Q8=;
        b=HkSVH4+fvq3FINHWmsb2ZedD4b0vsHZLITKzsyGEvFkmmOoaoJiRHJSPZ1nOes8tCV
         qhmc4RuPyjyBip5glK2ZxFkEhq4MhRTKIgRqidATFEwaCPvI/PIScm+GQB11D/KbxC0Z
         t2gmDFe9U2iQW1QoN86v+C8n/+wVRcsFokIArHKIbRI4uRecTqWC71UlTspWIrr9+XPQ
         6y6z36vowwVJH722JPrhn6uc8Ms8XZRi3sw4Nh4am65JFWySeZVgg6amggfUtsnMIuCh
         In205fjUNlRGFQUuN8665tdBtfDFSi/sBe4DrGSGMB4c6ABiowmbSWus3ADOz8AVbsZJ
         kYfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769440329; x=1770045129;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ifrBIEB1x/ZL3IlZIKiv+q/nbxwMkUHVsZQH0mGL8Q8=;
        b=QMLbjmWCmu9XMykkS+OXjiNMkU8IsDGHD+RdwsTNDq2otcQ/u7AnEOCtlM/Zeosnyq
         Jf32SbPl3kRGmMR7Aw4NJFoMk/wSuA7pqRHxHWqs5jimWOt5i+NCB+UTjJvil+R+R4F2
         oJvxaSikpegJZiJ+WLxWR2Rc6CN0tRnJ9JiZsVvkOc2mk7BzUZ01q6iV7L8oEyBlGSZS
         tRa+sVXcHjCYq9VVftidNl1Dn0LfNjNfZKt1XwzNW3iCxKKYJ6ETshcKJ4HCjYhPgR/R
         VQ3GXsXypf4fUuwibktG/20/DmbPBHjpo+fRSwkB5BlMakuy+orrFI2sLBwDWLpIcd8v
         upTA==
X-Gm-Message-State: AOJu0YzPOXw+RqvMo/Wqfg1wRvPSIVJwgOY/pABuRY7bp6m+T6q4kGPO
	uyqLLQiHET32ujdB+jLbXeEW/7vB0lqmwycX05kUQQ0jX/1C52MjNOs1ttWkDvxbaKn6dnVxNg8
	qXEIWmtqh/tHsw+z42TkkFCUoEPHMRYnfAWFsy1MfntTQTCvPk2Cx9gzASTq1JqI42ZfjzMviDF
	SbnJsx9n+o0SZOTxtYA5KzEuZwOey5lA==
X-Received: from pgct22.prod.google.com ([2002:a05:6a02:5296:b0:c5e:f054:992b])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6300:2209:b0:38e:90ca:5a4a
 with SMTP id adf61e73a8af0-38e9f0f41ebmr4371970637.1.1769440328580; Mon, 26
 Jan 2026 07:12:08 -0800 (PST)
Date: Mon, 26 Jan 2026 15:11:50 +0000
In-Reply-To: <20260126151157.3418145-1-praan@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260126151157.3418145-1-praan@google.com>
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260126151157.3418145-4-praan@google.com>
Subject: [PATCH v5 03/10] iommu/tegra241-cmdqv: Add a helper to drain VCMDQs
From: Pranjal Shrivastava <praan@google.com>
To: iommu@lists.linux.dev
Cc: Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>, 
	Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>, Mostafa Saleh <smostafa@google.com>, 
	Nicolin Chen <nicolinc@nvidia.com>, Daniel Mentz <danielmentz@google.com>, 
	Ashish Mhetre <amhetre@nvidia.com>, Sairaj Kodilkar <sarunkod@amd.com>, 
	Pranjal Shrivastava <praan@google.com>
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
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   |  7 +++++
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  1 +
 .../iommu/arm/arm-smmu-v3/tegra241-cmdqv.c    | 27 +++++++++++++++++++
 3 files changed, 35 insertions(+)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 014d08cdfb92..d9003f5f40b6 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -1023,6 +1023,13 @@ static int arm_smmu_drain_queues(struct arm_smmu_device *smmu)
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
index 4c04f63966eb..d083141c6563 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -731,6 +731,7 @@ struct arm_smmu_impl_ops {
 	size_t (*get_viommu_size)(enum iommu_viommu_type viommu_type);
 	int (*vsmmu_init)(struct arm_vsmmu *vsmmu,
 			  const struct iommu_user_data *user_data);
+	int (*drain_queues)(struct arm_smmu_device *smmu);
 };
 
 /* An SMMUv3 instance */
diff --git a/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c b/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
index 1fc03b72beb8..38d637fde86e 100644
--- a/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
+++ b/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
@@ -414,6 +414,32 @@ tegra241_cmdqv_get_cmdq(struct arm_smmu_device *smmu,
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
+	/* Kernel only uses VINTF0. Return if it's disabled */
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
@@ -844,6 +870,7 @@ static struct arm_smmu_impl_ops tegra241_cmdqv_impl_ops = {
 	.get_secondary_cmdq = tegra241_cmdqv_get_cmdq,
 	.device_reset = tegra241_cmdqv_hw_reset,
 	.device_remove = tegra241_cmdqv_remove,
+	.drain_queues = tegra241_cmdqv_drain_vintf0_lvcmdqs,
 	/* For user-space use */
 	.hw_info = tegra241_cmdqv_hw_info,
 	.get_viommu_size = tegra241_cmdqv_get_vintf_size,
-- 
2.52.0.457.g6b5491de43-goog

