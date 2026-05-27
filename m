Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B4E03C343E
	for <iommu@lists.linux.dev>; Wed, 27 May 2026 22:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779920061; cv=none; b=nd+U41Y4oSvDGiOF1nxuQSZE/OLaeA+k6j3HlNCSmNfMBchQotpEzCcQpCkCofzG6DEJ1FFdyiLd77FK2X34u0M91pxotb+Y2z6LyAOZt//tVG9H7l3jhMmBZRezZPVmxQ4pES/fTrXeG7tnHWUa1gs+ruJY46K7Qba+UgnDwiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779920061; c=relaxed/simple;
	bh=6yNZvxKqA1sqbthdzlkIKJPV50hN6O9BTXHXHvQo4io=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=GKl49je0uWi7urcz5/H1RNJFrReZMZTktSrq4pSKVA6CABP3fbGHUOc/SvFC3AgLaJx0xn16WyIQrNPkvf40BSQCIP4yQVt/kTrR2ELiPXuIiV9ZBWSYOWmck5hQx9w5VrSxBEYYJM+RGh3JhNRtNwXUe0rnib/KHzQxqqGE/aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pxHw78sX; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pxHw78sX"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2ba15e384c7so85796045ad.3
        for <iommu@lists.linux.dev>; Wed, 27 May 2026 15:14:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779920060; x=1780524860; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=8gsMt/qJYcRL9ucHkcs+vvKUOXqHjlbxlLPWzRbnpQ0=;
        b=pxHw78sXspTEy4QRA3PYzQ9RH+rKrzNJ3oahNna21e0ZwxWGgXZqMJXnlVYT4THE7T
         NEhiNiNRNR+zNcDnEtZPaZHiQq8tEMtJFSkJ6h+3coUQdimfHF/5uSuu8tKIxGJZwQTI
         P2tiHmyHbu4/O9af4U8daFRKUY+fza1yD9L5AY5rlah/slxNHi9lVdpmRsIG4FGy5MX3
         HpA1uCSWDCjyf4+xmAqg37UCpm+3d9x9s3MPErAD+Mz//yWwEnFQ8D63JD77OytgaV1L
         E0CBewdk5YxF+zOPMJAit70+XP80V81Cd6FHcMcgfhEYhexSXxln3HTya6XQCacIpFi7
         iMsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779920060; x=1780524860;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8gsMt/qJYcRL9ucHkcs+vvKUOXqHjlbxlLPWzRbnpQ0=;
        b=T9To6p2N/Sd1RAg071cC2rILHw2prU+w2ZgT57fnPHW7gTX1quhhhFFgHm6dfegg7P
         5rhH9kdmbOfXRhPVadHl7cJTYrDgdxtLD5aohaCSSPyGS31rfzZyUnojQoxrGFcnYoY+
         034M7/HZ2pV8Pbzvyk/zRjPf0hK1JoYUKizR9/+9zZL3LXhwXuKQEnQahHX5FDXAxQsm
         2DAF3cz+9ZcAm/AmoP7yrflGIL3jsWJu0wjEbbVBWy3TSlAkDQ0s0RPNW1daL99V19xt
         9cknd2q87lU6tmDXDMW+0xR2S9rChh9OZQaLT+OKeHhhk3qfVXv3YP/cL67imPokMI2l
         cL4w==
X-Gm-Message-State: AOJu0Yzj0B6HPXqMeZrVPuYOD/L+8apvlWW3Wi7EbXF3XUTAFdsCfrE6
	l4M8IyFj6zjeqgTVpIRmA+w5Y85g1X6WI5JU+eVEJdKm/F3KoKRTkxIW39AtaA2AmD6QXDcRoN8
	PGuyS1c4tCpJaHbc2vUQdNFyWqcJIBCJy6puwHO/99EFE15K3mEFFWPSSLFs/xIdbhFCEo6ToRc
	XlLK28rPnF2oFEoo9Q5XuQPEvi/RgpBA==
X-Received: from plwp4.prod.google.com ([2002:a17:903:2484:b0:2be:fc8f:7217])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:2f05:b0:2be:1eb1:eaf7
 with SMTP id d9443c01a7336-2beb05b5f70mr289297455ad.24.1779920059380; Wed, 27
 May 2026 15:14:19 -0700 (PDT)
Date: Wed, 27 May 2026 22:13:59 +0000
In-Reply-To: <20260527221407.1756491-1-praan@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260527221407.1756491-1-praan@google.com>
X-Mailer: git-send-email 2.54.0.794.g4f17f83d09-goog
Message-ID: <20260527221407.1756491-4-praan@google.com>
Subject: [PATCH v7 03/11] iommu/tegra241-cmdqv: Add a helper to drain VCMDQs
From: Pranjal Shrivastava <praan@google.com>
To: iommu@lists.linux.dev
Cc: Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>, 
	Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>, Mostafa Saleh <smostafa@google.com>, 
	Nicolin Chen <nicolinc@nvidia.com>, Daniel Mentz <danielmentz@google.com>, 
	Ashish Mhetre <amhetre@nvidia.com>, linux-arm-kernel@lists.infradead.org, 
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
index 0e77ef1e4523..8682be5060ed 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -915,6 +915,13 @@ static int arm_smmu_drain_queues(struct arm_smmu_device *smmu)
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
index c855ab4962ed..24d5e28eea88 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -885,6 +885,7 @@ struct arm_smmu_impl_ops {
 	size_t (*get_viommu_size)(enum iommu_viommu_type viommu_type);
 	int (*vsmmu_init)(struct arm_vsmmu *vsmmu,
 			  const struct iommu_user_data *user_data);
+	int (*drain_queues)(struct arm_smmu_device *smmu);
 };
 
 /* An SMMUv3 instance */
diff --git a/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c b/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
index 67be62a6e764..cb1e75e4ee91 100644
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
2.54.0.794.g4f17f83d09-goog

