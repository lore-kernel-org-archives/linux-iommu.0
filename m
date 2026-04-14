Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 454202853FD
	for <iommu@lists.linux.dev>; Tue, 14 Apr 2026 19:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776196041; cv=none; b=SZJI3AbsT0pZ9fvNCdcBsed31r9Bje6E8b8srkvQfS6W4QokE7oCDpdCKQlndjTQ4MtdR96NVPIzitYa73dMxvNHPNUoVnRkvJBCqNamRhkW3GAxIfwMlbMhjcFqcAOl1OkptGjpEqdrKXgeHldA1jpu09kGmX/JUtgQ4ojWYvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776196041; c=relaxed/simple;
	bh=1fXDuSg8AoNvvHdMuqnOxCMSEVKpaa9lBi2VNJXy0c4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=nO1rchmD4rv0sWhPDyZJsXpUbQa0bNLhgoCwwCdzjQ1h8KOJt2kfAhdNn6Sxaonihc6qotV9LKKXspaj/8JGa8vyMLqeY8JgY6L8GG8ojkJhJtWU62W6dzOMoe7h+28AIg86nwWH5gb7T0yW95cPEamrxcruqDxzenOnFfh57/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZhWuwKdy; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZhWuwKdy"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-354c44bf176so5574353a91.0
        for <iommu@lists.linux.dev>; Tue, 14 Apr 2026 12:47:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776196039; x=1776800839; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=XBBcT8iygL82ZgVuvbNPVunvHYblzfmN/FbbtwHh758=;
        b=ZhWuwKdy836PAF8t8GFUHqH9SXHV0UvHx4W0+s1esYGqUI7hoWlWv0qAi98CruiDzh
         ylIy3otC/z7eA8uPVNDvJx+CpiVq5hCSdT0tc59zkdpFwg6x05crSwjYoR0Fekn5Q6z+
         s/2KX8MFWfaNAdztFJwUrHcd5+s+xjM4QV4LQ/4BnZ3+XvoPPulNt9hl4mx9Pni4bcAC
         QM6fHi1t935QSabJReYUoP+sxpQlmBzKskTFh/N/XGUBOjDF35IqFL6QUpGUoygK60eR
         5DMT3MeIDzkWVB0nq8GP4hS9Ot/iySisf4oq1x/8oQMqaxvgExVDPIN0e2GkF0BRYSxv
         2wZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776196039; x=1776800839;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XBBcT8iygL82ZgVuvbNPVunvHYblzfmN/FbbtwHh758=;
        b=k8WexzPnphw+bkaS0w9+SjvQzbLA+ZR73o7vsF8QRs4A5huU9uNWqu+UoMj9QHTp56
         rhZRFoCqcYrL749W5W8+XqAqGwtw8tIIcH1AXqJb2ZuFyJ695pFYWLlvndjguKqDx+qI
         mp+ryRiJa2nnaGlRewsh8O/hskxpnBCzJ6bKUjyruAUsUeGMjx9YB53G8uovqphK7WDA
         qPpTbkdq5fz9pg+r7IL+dR3R4MlUNkr4iFbEGAQ9RvRvKxRkkSDClo1rMQlcEnIsVtp3
         zwBCcQy/h8SDk+L/C8dYAJY8WEke9QwsLlF1eHbHXCPoABTESeIC3g5ayki1dsDK7JL7
         yZpg==
X-Gm-Message-State: AOJu0YyEJ/x2CXCqZxFgYCFUKcjzCzfw8keZigNR3WibTn+Fptx0xqhh
	6v54rHB+cSs6DOXRMVGOf3lDTnmcymTTOw5pIQNZjc6wkdKcU/WM29OxGj/qMsa3UE7QbXy3tXY
	4AcT88mEOtsts/ufYANqFes9B4ZuW3A7B1jD3g1d8+rgLmuV8o8nvH/0BjgLQu2bCiWZSpgh9lh
	yDEmVSEi3MrdgfknXLHWmCzlagc13JCA==
X-Received: from pjbpw5.prod.google.com ([2002:a17:90b:2785:b0:35d:a9bd:1fef])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2dc8:b0:35c:a8f:5c5f
 with SMTP id 98e67ed59e1d1-35e427708acmr19502027a91.8.1776196039260; Tue, 14
 Apr 2026 12:47:19 -0700 (PDT)
Date: Tue, 14 Apr 2026 19:46:55 +0000
In-Reply-To: <20260414194702.1229094-1-praan@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260414194702.1229094-1-praan@google.com>
X-Mailer: git-send-email 2.54.0.rc0.605.g598a273b03-goog
Message-ID: <20260414194702.1229094-4-praan@google.com>
Subject: [PATCH v6 03/10] iommu/tegra241-cmdqv: Add a helper to drain VCMDQs
From: Pranjal Shrivastava <praan@google.com>
To: iommu@lists.linux.dev
Cc: Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>, 
	Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>, Mostafa Saleh <smostafa@google.com>, 
	Nicolin Chen <nicolinc@nvidia.com>, Daniel Mentz <danielmentz@google.com>, 
	Ashish Mhetre <amhetre@nvidia.com>, Pranjal Shrivastava <praan@google.com>
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
index 088a7d1c002b..e865a8aa2210 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -1024,6 +1024,13 @@ static int arm_smmu_drain_queues(struct arm_smmu_device *smmu)
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
index 47799d58d10c..001734bc3c7d 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -818,6 +818,7 @@ struct arm_smmu_impl_ops {
 	size_t (*get_viommu_size)(enum iommu_viommu_type viommu_type);
 	int (*vsmmu_init)(struct arm_vsmmu *vsmmu,
 			  const struct iommu_user_data *user_data);
+	int (*drain_queues)(struct arm_smmu_device *smmu);
 };
 
 /* An SMMUv3 instance */
diff --git a/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c b/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
index 83f6e9f6c51d..b3ed2149f72b 100644
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
@@ -845,6 +871,7 @@ static struct arm_smmu_impl_ops tegra241_cmdqv_impl_ops = {
 	.get_secondary_cmdq = tegra241_cmdqv_get_cmdq,
 	.device_reset = tegra241_cmdqv_hw_reset,
 	.device_remove = tegra241_cmdqv_remove,
+	.drain_queues = tegra241_cmdqv_drain_vintf0_lvcmdqs,
 	/* For user-space use */
 	.hw_info = tegra241_cmdqv_hw_info,
 	.get_viommu_size = tegra241_cmdqv_get_vintf_size,
-- 
2.54.0.rc0.605.g598a273b03-goog

