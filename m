Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 914755908DE
	for <iommu@lists.linux.dev>; Tue,  8 Sep 2026 17:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788887863; cv=none; b=W8tnftxZ5PzwAvVrCp4uyoy+3IwbWQ8DTu1ZLAXIVWymYWkNQDRSpDQOYgraHdIj5YksVe+wBadfUdiiFBV7LE+3K18seS91rcmkCvZOfkCnx74B480rw6btx+kbG3P+It/LaPJS8ewYycwQVMl+RruZ03w61NLPgRy6tkswXmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788887863; c=relaxed/simple;
	bh=zM+tCTjupWWSNDc0JdOOTYJEJ+KiPBNCIv/k9bHAYd8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Toe02YqSp9fnlybrSh7VeaXFYUV6UAOP1ppVCUTrwQhyErcGimyKG8JJ7kw5R08hCvlJLQ7j+FlUSh5WE9zV3kmBUN82F9kCnTfuKNTJ63zNGGCdC9pfzTjbCbLHHD+H9ZDS5XbNYzBz+BbRcyTc5YY0bOGFwwap0AVLshYeH5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TBjklQt1; arc=none smtp.client-ip=209.85.216.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TBjklQt1"
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-396638f9a18so3582031a91.2
        for <iommu@lists.linux.dev>; Tue, 08 Sep 2026 10:17:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788887861; x=1789492661; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uONWWaSJb8FTHdgaUf0CJlqohoMDMyLvCC6od1SxwCM=;
        b=TBjklQt1UJ/2OrKeY4CNdjMxh3SsZb0Nb/6sFY7yHyvLFlk6vPUi5nS71OwW/3l0lY
         y/w9S/6PFpEnub/UpaLSNIHk8PTVA6fuUUqUFFlK0116i7w81bDymgFnV/e1TEVbqbFW
         nWR+8uJtbSukXcanUDcjtHNViESNlnPpD1ZvkfL6q3sfvI5IeUtEHhKC7YxrYNxNq8r/
         tRsuJxtog0aiqf3uPvJHsNwaB8aSo2sU/aaoDkzsXkUhE8k8UUv1aCkJ9i7JWBaPnUGR
         cDRjN1vnSFSUThuqcHkkMUmQhko1XLrA+8rVY3SL40ih4ZWNFysJUZov/l6mkaKibgNY
         XsCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788887861; x=1789492661;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uONWWaSJb8FTHdgaUf0CJlqohoMDMyLvCC6od1SxwCM=;
        b=DVYSs4bvfSgceAxJ6wHHtFnqvIHnw0cxoqGvA9hb+k823NWaIv/oiQ5npaVuUKZgFC
         6yjD1ltS7CyrzVLxJKt+2FwIgtezuP7dPD7ZnflbjxovVUt2ZowYqgaY5tfwQi2MPIa6
         DaRFcPdmPZYIUkirD61JmQWc2fK0zqkhd08aZmKw7Os7OoNYcH2urIR43F4Yo7Bo3YBs
         nk7iLCqbpTbWtvUufv7Gh631Posg1bEr8Kk7r4mOGDRlvYlj3YByhtp0oulzw13efHru
         5nE0IUxT6B5zwY9jO4ERPtHysfL6ElNOj53mkUtP+Uc9zOUkcvwbvU4lhbHyqJneDA3r
         34fg==
X-Gm-Message-State: AFuF++mcPz35lzTT+2IsT+/AFpMRZ1nlcZg478czQ5t4SP+TvZhIGuQ0
	XaNnbMobNFmlN70aNB8ALDnrv50U1DE+IUNu0nfU6yIfUZMoCXMLr8K3oqoJmN62xq0wDhC3SYW
	yuYfjGc5Im+2k171Ed4oP1Ds+adRYkrWkBxmmgrbVll5PFRdasdAQwnWj6qwVprcIJij3LErn95
	zzcnX4N/moNIVRdOzZS84YmUvNDcdmdA==
X-Received: from pjbgg16.prod.google.com ([2002:a17:90b:a10:b0:39b:8e8b:e1f3])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2ccd:b0:398:9c00:29f0
 with SMTP id 98e67ed59e1d1-39b2628fc25mr48793062a91.24.1788887860460; Tue, 08
 Sep 2026 10:17:40 -0700 (PDT)
Date: Tue,  8 Sep 2026 17:17:07 +0000
In-Reply-To: <20260908171712.356645-1-praan@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260908171712.356645-1-praan@google.com>
X-Mailer: git-send-email 2.55.0.979.g7e5102b832-goog
Message-ID: <20260908171712.356645-12-praan@google.com>
Subject: [PATCH v10 11/15] iommu/tegra241-cmdqv: Add a helper to quiesce VCMDQs
From: Pranjal Shrivastava <praan@google.com>
To: iommu@lists.linux.dev
Cc: Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>, 
	Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>, Mostafa Saleh <smostafa@google.com>, 
	Nicolin Chen <nicolinc@nvidia.com>, Daniel Mentz <danielmentz@google.com>, 
	Ashish Mhetre <amhetre@nvidia.com>, linux-arm-kernel@lists.infradead.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, rafael@kernel.org, 
	Danilo Krummrich <dakr@kernel.org>, Thomas Gleixner <tglx@kernel.org>, driver-core@lists.linux.dev, 
	Pranjal Shrivastava <praan@google.com>
Content-Type: text/plain; charset="UTF-8"

The tegra241-cmdqv driver supports vCMDQs which need to be quiesced using
the STOP_FLAG. The current driver implementation only uses VINTF0 for
vCMDQs owned by the kernel which need to be stopped. Add a helper that
sets the CMDQ_PROD_STOP_FLAG on these vCMDQs.

Consolidate this logic by renaming the implementation hook to
quiesce_and_drain_queues and ensuring that the tegra241-cmdqv driver
gates all active local virtual queues before starting the drain loop.
Additionally, clear the STOP_FLAG in tegra241_vcmdq_hw_init() as a part
of tegra241_cmdqv_hw_reset().

Suggested-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Pranjal Shrivastava <praan@google.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   |  4 +-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  2 +-
 .../iommu/arm/arm-smmu-v3/tegra241-cmdqv.c    | 77 ++++++++++++++++++-
 3 files changed, 76 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 65939a9b0619..7eb939888735 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -1077,8 +1077,8 @@ static int __maybe_unused arm_smmu_drain_cmdqs(struct arm_smmu_device *smmu)
 	ret = arm_smmu_drain_queue(smmu, &smmu->cmdq.q, true);
 
 	/* Drain all implementation-specific queues */
-	if (smmu->impl_ops && smmu->impl_ops->drain_queues) {
-		err = smmu->impl_ops->drain_queues(smmu);
+	if (smmu->impl_ops && smmu->impl_ops->quiesce_and_drain_queues) {
+		err = smmu->impl_ops->quiesce_and_drain_queues(smmu);
 		if (err)
 			ret = err;
 	}
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 794b258550dd..0a841441cc44 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -896,7 +896,7 @@ struct arm_smmu_impl_ops {
 	size_t (*get_viommu_size)(enum iommu_viommu_type viommu_type);
 	int (*vsmmu_init)(struct arm_vsmmu *vsmmu,
 			  const struct iommu_user_data *user_data);
-	int (*drain_queues)(struct arm_smmu_device *smmu);
+	int (*quiesce_and_drain_queues)(struct arm_smmu_device *smmu);
 };
 
 /* An SMMUv3 instance */
diff --git a/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c b/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
index c7989fcd2c62..61847f2802a3 100644
--- a/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
+++ b/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
@@ -447,6 +447,54 @@ tegra241_cmdqv_get_cmdq(struct arm_smmu_device *smmu,
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
+static void tegra241_vcmdq_wait_quiescent(struct arm_smmu_device *smmu,
+					 struct tegra241_vcmdq *vcmdq)
+{
+	u32 target = READ_ONCE(vcmdq->cmdq.q.llq.prod) & CMDQ_PROD_IDX_MASK;
+	int timeout = ARM_SMMU_POLL_TIMEOUT_US;
+
+	/* Wait for the last committed owner to reach the hardware */
+	while (atomic_read(&vcmdq->cmdq.owner_prod) != target && timeout) {
+		udelay(1);
+		timeout--;
+	}
+
+	if (!timeout)
+		dev_err(smmu->dev, "vintf0 lvcmdq%u owner wait timeout\n",
+			vcmdq->lidx);
+
+	/* Wait for queue lock to be released */
+	timeout = ARM_SMMU_POLL_TIMEOUT_US;
+	while (atomic_read(&vcmdq->cmdq.lock) != 0 && timeout) {
+		udelay(1);
+		timeout--;
+	}
+
+	if (!timeout)
+		dev_err(smmu->dev, "vintf0 lvcmdq%u lock wait timeout\n",
+			vcmdq->lidx);
+}
+
 static int tegra241_cmdqv_drain_vintf0_lvcmdqs(struct arm_smmu_device *smmu)
 {
 	struct tegra241_cmdqv *cmdqv =
@@ -467,6 +515,21 @@ static int tegra241_cmdqv_drain_vintf0_lvcmdqs(struct arm_smmu_device *smmu)
 	if (!READ_ONCE(vintf->enabled))
 		return 0;
 
+	/*
+	 * Gate all vCMDQs by setting the STOP_FLAG in a separate,
+	 * initial loop to ensure no new commands can be submitted
+	 * to any secondary queue while we are waiting to drain them.
+	 *
+	 * Client devices are suspended at this point due to devlinks,
+	 * ensuring no concurrent command submissions race with this
+	 * drain sequence.
+	 */
+	tegra241_cmdqv_quiesce_vintf0_lvcmdqs(smmu);
+
+	/* Ensure all CPUs observe the STOP_FLAG before draining */
+	smp_mb();
+
+	/* Now that all queues are safely gated, drain them sequentially. */
 	for (lidx = 0; lidx < cmdqv->num_lvcmdqs_per_vintf; lidx++) {
 		struct tegra241_vcmdq *vcmdq = vintf->lvcmdqs[lidx];
 		int rc;
@@ -474,6 +537,9 @@ static int tegra241_cmdqv_drain_vintf0_lvcmdqs(struct arm_smmu_device *smmu)
 		if (!vcmdq || !READ_ONCE(vcmdq->enabled))
 			continue;
 
+		/* Wait for the last committed owner to reach the hardware */
+		tegra241_vcmdq_wait_quiescent(smmu, vcmdq);
+
 		rc = arm_smmu_drain_queue(smmu, &vcmdq->cmdq.q, true);
 		if (rc) {
 			/*
@@ -489,7 +555,7 @@ static int tegra241_cmdqv_drain_vintf0_lvcmdqs(struct arm_smmu_device *smmu)
 		}
 
 		/* Avoid consuming stale commands on resume */
-		vcmdq->cmdq.q.llq.cons = vcmdq->cmdq.q.llq.prod;
+		vcmdq->cmdq.q.llq.cons = vcmdq->cmdq.q.llq.prod & CMDQ_PROD_IDX_MASK;
 	}
 
 	return ret;
@@ -566,7 +632,6 @@ static int tegra241_vcmdq_hw_init(struct tegra241_vcmdq *vcmdq)
 
 	/* Configure and enable VCMDQ */
 	writeq_relaxed(vcmdq->cmdq.q.q_base, REG_VCMDQ_PAGE1(vcmdq, BASE));
-
 	/*
 	 * HW Registers reset to 0 when power-cycled. Restore them from their
 	 * SW copies to prevent executing stale/ghost commands after resume.
@@ -574,7 +639,8 @@ static int tegra241_vcmdq_hw_init(struct tegra241_vcmdq *vcmdq)
 	 * to the Guests since the relevant frameworks (IOMMUFD / VFIO) hold
 	 * active PM references preventing suspend while VMs are active.
 	 */
-	writel_relaxed(vcmdq->cmdq.q.llq.prod, REG_VCMDQ_PAGE0(vcmdq, PROD));
+	writel_relaxed(vcmdq->cmdq.q.llq.prod & CMDQ_PROD_IDX_MASK,
+		       REG_VCMDQ_PAGE0(vcmdq, PROD));
 	writel_relaxed(vcmdq->cmdq.q.llq.cons, REG_VCMDQ_PAGE0(vcmdq, CONS));
 
 	ret = vcmdq_write_config(vcmdq, VCMDQ_EN);
@@ -587,6 +653,9 @@ static int tegra241_vcmdq_hw_init(struct tegra241_vcmdq *vcmdq)
 		return ret;
 	}
 
+	/* Clear the CMDQ_PROD_STOP_FLAG */
+	atomic_andnot(CMDQ_PROD_STOP_FLAG, &vcmdq->cmdq.q.llq.atomic.prod);
+
 	dev_dbg(vcmdq->cmdqv->dev, "%sinited\n", h);
 	return 0;
 }
@@ -963,7 +1032,7 @@ static struct arm_smmu_impl_ops tegra241_cmdqv_impl_ops = {
 	.device_reset = tegra241_cmdqv_hw_reset,
 	.device_disable = tegra241_cmdqv_hw_disable,
 	.device_remove = tegra241_cmdqv_remove,
-	.drain_queues = tegra241_cmdqv_drain_vintf0_lvcmdqs,
+	.quiesce_and_drain_queues = tegra241_cmdqv_drain_vintf0_lvcmdqs,
 	/* For user-space use */
 	.hw_info = tegra241_cmdqv_hw_info,
 	.get_viommu_size = tegra241_cmdqv_get_vintf_size,
-- 
2.55.0.979.g7e5102b832-goog

