Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC02537BE6F
	for <iommu@lists.linux.dev>; Mon,  1 Jun 2026 21:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780351171; cv=none; b=Dhvhb41Mo7wmjQ+riYgMcqlFT3GgZSdy22RErWf6KzCWRKQpKq/Dw2yx048fsaFtQqBmygg8cdwtGR5cDcsubfe95jCwacpilKs1D6UqmZWO6caXBtiKbXerjPVTwfZdva3Qq+a5+1rH8XhVgx3mF7lHZed8iWWI8eSHBqXmijY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780351171; c=relaxed/simple;
	bh=bOhyGau3BIL3cYOdiWH6CMWu5zrOx0+qyaoAkCpucJg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qe0iUEMWAdlg3Pe0NHKIyWogXODnBYvZS4tdgMpkH6fQpfLWgL/gwuRydS3QOODBb88+r1EhCmOitFBeij5d3ZA9DWa6EdvmvsRLTezWFZiCDLhtnqQ0Virh+KMYMJUM259LilCmiUoM0HmqLxIf/nybVFJUKHBCG+zelt48NHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UFHivxZt; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UFHivxZt"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-36d99333358so1689879a91.3
        for <iommu@lists.linux.dev>; Mon, 01 Jun 2026 14:59:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780351169; x=1780955969; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=VwoPBlNloT+7eWpBXhnL6MtBCTp1+ESlF9RR1+VuIgk=;
        b=UFHivxZtzIqbOL9L0mehS4QTdp1uuYFagamVCKHYfNDcHXuC4j25HQIf/wSUM/gFuD
         0R4IRum1dh2itEeBU0yW5m/Yd3qSiep5EvAQi6di5Yt4NLecJymrCk7elHoBhGsaL/t0
         hll+k+nLVoqqdxBfUin3FHQfNyi1CMwknOnpI6iMaruyhHNszYJnMnrQJFiJq34H+G2O
         +X8Tz7HsXOH0xwe1+oKScC/TpB0EqhoupFLZTcDD9PQ0dIBla78T5SonuzlST75T0SWG
         bV9XDM0/SKB3Mw3q1XXQcx7If7sNg2eE722JT6vY2MMDs18NuWYDIPa972snevXQpKu3
         KpYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780351169; x=1780955969;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VwoPBlNloT+7eWpBXhnL6MtBCTp1+ESlF9RR1+VuIgk=;
        b=ZD7PxYGs9eXS17++UaBLA+T6AAiDyq+5N7jz15hCHJ53U/GA0W2OakgksHY411Idcl
         XKmeVHQiuQ7u+1D5LDTDgJeUgfOwsETZEXH87oV9XINw6ThvYI+41bWblApg0JRQnuoW
         hoHSfmbQV0dkPL5Uvw+36xBO9epz+YHgJwj3kdXTpHna5Wn1O5ML8+imC6Ggkpil7Zv0
         cVlBVPn7YW9huq/iaUDg9Sgj7PmfMoahI4hT0FGaqT+0KVltMrUS4SxCf47+4VXojqJj
         afWgp9LpmZOmB/FJKS2XfsQlskGasaXi0oQPD93POg8j6RKqDoSUa8kKDFj2ZmSrOmFJ
         6U7A==
X-Gm-Message-State: AOJu0Yx8BwdK7AaQ0vg0Zw2wUcfHc67ydSCYhbUIlzjmdsJeQYHCSUJ5
	QOiyrtChLMWDF22IODRL+xdfpX61nqyDwRm4bE2hQiv6WR7HhPD9pMW/CoS819U/Y+Lf1rkSBMz
	74MKFL9LIvaa6BtAAeoAlXSLWcQ8YcMsG2P4Il4KUczgrY2KRRUuCgp9PJXTzDWUnB7qZ4sPRyU
	+LhR1S9sTRbLZn34Nf0kCXSfXFSD6G+w==
X-Received: from pjbot1.prod.google.com ([2002:a17:90b:3b41:b0:36b:b668:1956])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3dc8:b0:36d:cf58:b79
 with SMTP id 98e67ed59e1d1-36dcf580f7fmr2656997a91.19.1780351168717; Mon, 01
 Jun 2026 14:59:28 -0700 (PDT)
Date: Mon,  1 Jun 2026 21:59:05 +0000
In-Reply-To: <20260601215909.3958732-1-praan@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260601215909.3958732-1-praan@google.com>
X-Mailer: git-send-email 2.54.0.1013.g208068f2d8-goog
Message-ID: <20260601215909.3958732-9-praan@google.com>
Subject: [PATCH v8 08/12] iommu/tegra241-cmdqv: Add a helper to quiesce VCMDQs
From: Pranjal Shrivastava <praan@google.com>
To: iommu@lists.linux.dev
Cc: Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>, 
	Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>, Mostafa Saleh <smostafa@google.com>, 
	Nicolin Chen <nicolinc@nvidia.com>, Daniel Mentz <danielmentz@google.com>, 
	Ashish Mhetre <amhetre@nvidia.com>, linux-arm-kernel@lists.infradead.org, 
	Pranjal Shrivastava <praan@google.com>
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
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   |  4 +--
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  2 +-
 .../iommu/arm/arm-smmu-v3/tegra241-cmdqv.c    | 32 +++++++++++++++++--
 3 files changed, 33 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index c4315bdde7d5..d31e50b64b50 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -937,8 +937,8 @@ static int arm_smmu_drain_queues(struct arm_smmu_device *smmu)
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
index a3c8417c87d8..719e499c72ce 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -887,7 +887,7 @@ struct arm_smmu_impl_ops {
 	size_t (*get_viommu_size)(enum iommu_viommu_type viommu_type);
 	int (*vsmmu_init)(struct arm_vsmmu *vsmmu,
 			  const struct iommu_user_data *user_data);
-	int (*drain_queues)(struct arm_smmu_device *smmu);
+	int (*quiesce_and_drain_queues)(struct arm_smmu_device *smmu);
 };
 
 /* An SMMUv3 instance */
diff --git a/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c b/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
index 866cae7b73e5..536aeeb63202 100644
--- a/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
+++ b/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
@@ -414,6 +414,28 @@ tegra241_cmdqv_get_cmdq(struct arm_smmu_device *smmu,
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
+
+	return;
+}
+
 static int tegra241_cmdqv_drain_vintf0_lvcmdqs(struct arm_smmu_device *smmu)
 {
 	struct tegra241_cmdqv *cmdqv =
@@ -426,6 +448,8 @@ static int tegra241_cmdqv_drain_vintf0_lvcmdqs(struct arm_smmu_device *smmu)
 	if (!READ_ONCE(vintf->enabled))
 		return 0;
 
+	tegra241_cmdqv_quiesce_vintf0_lvcmdqs(smmu);
+
 	for (lidx = 0; lidx < cmdqv->num_lvcmdqs_per_vintf; lidx++) {
 		struct tegra241_vcmdq *vcmdq = vintf->lvcmdqs[lidx];
 
@@ -511,9 +535,13 @@ static int tegra241_vcmdq_hw_init(struct tegra241_vcmdq *vcmdq)
 
 	/* Configure and enable VCMDQ */
 	writeq_relaxed(vcmdq->cmdq.q.q_base, REG_VCMDQ_PAGE1(vcmdq, BASE));
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
@@ -873,7 +901,7 @@ static struct arm_smmu_impl_ops tegra241_cmdqv_impl_ops = {
 	.get_secondary_cmdq = tegra241_cmdqv_get_cmdq,
 	.device_reset = tegra241_cmdqv_hw_reset,
 	.device_remove = tegra241_cmdqv_remove,
-	.drain_queues = tegra241_cmdqv_drain_vintf0_lvcmdqs,
+	.quiesce_and_drain_queues = tegra241_cmdqv_drain_vintf0_lvcmdqs,
 	/* For user-space use */
 	.hw_info = tegra241_cmdqv_hw_info,
 	.get_viommu_size = tegra241_cmdqv_get_vintf_size,
-- 
2.54.0.1013.g208068f2d8-goog

