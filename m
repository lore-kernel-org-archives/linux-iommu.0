Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ADBC43031A
	for <iommu@lists.linux.dev>; Tue, 29 Sep 2026 03:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790653553; cv=none; b=uasOUMYBZ/gbgu5B2feQ44n9eEza0RIjD5nhr3VYT1+41VL6YjkV5ZukjXfjLy8WEZGI5hsNE2IlhpWyEOLn1+o/3WgVEmKgEF0pzRbH8pg32yrxq8TvdLkK06q3I+edD9gIsntT6hTvKxWQ1to3LBoMpUXB7hUNcsXxHF6Ok+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790653553; c=relaxed/simple;
	bh=Gb31fIvFOmJDnn3TQarQeSRrzRTD9iLRZv0TB/VL/Y0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=d9mj1fjgOm+uOnOAYpXhK9uF5ZyRbYe58jQYSN+SPQw9a8+YV57F+NKU9LKvE9r9KD0Qwhs+nZnah7h0yijlj7IyxM+Y2M8XEIFByT5H7dPJ4awEhd/Tc9XP+5AD+0GOQbv6pnQP4KuR945wiz2zjf/bjjkPxJRLJABFy1Osb0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aEcYXHFM; arc=none smtp.client-ip=209.85.215.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aEcYXHFM"
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cc1ca15334cso4175697a12.1
        for <iommu@lists.linux.dev>; Mon, 28 Sep 2026 20:45:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790653549; x=1791258349; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Q1UoDLaUSVrQDcp8js+xQqVPvK9lSKlk7fepU02SFQA=;
        b=aEcYXHFMZmGxc2cxDOK7b41p9C3kWK0M/jvvm5Gl6QUARiaAl88Z34D7crozJaQ0lz
         iA/qUFJzK+MdCbXTCprE7wb0OS+uSMR6ZE/zZNhrCwEaDmhRVMqSpRQHqgpKZUKBHzUj
         ze6DYRPy+hTJDMxd2rdTNmxCdwjL/vBjfYtndLCzTelYqHN9DwJSiEF+AjTL8aCmrJSl
         3aS5nGiC3+NvAFI65w+sRj2cq0GkkaSpqDkKBA+yfhdem3lbcqSZok34oEUQiQr+y4Lh
         LApToLZqQEULtF+aQMJktMdy37MFoKE3JkaTNHzkwz2JbMwJv+vpio/fEJsCc+FThoBy
         U5Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790653549; x=1791258349;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Q1UoDLaUSVrQDcp8js+xQqVPvK9lSKlk7fepU02SFQA=;
        b=f1s3LVwgiYQPEgebvAxfO1gZMK4jVFXC2XE1Pb7wLyEn9/uVxdIMm+VmQZkNM9uB+2
         szk9pRvMK5C8ZsvfeXAYfFTB+1OlgMeZRYm99UZDcp0y6BYJQ5JaMgTmioSZz/RZ9jO5
         XkHSxzd3ZeZe1MWgsa7liaKPmcfIhZMANZ5233UyRONzUiytLOC7MxC/QhYnhLSVYDUP
         Q1y1n/UMPcXSQLeo45C4EMFC27kVjHYlpMHc5I0Sy+TgKRg6BHydo0MJn26BA9JTgHOY
         re/Qiu+L1OHUZa85fbl7OodNQ4VKhEgn4mr8Vysu+oRyATbVt7jF9eZnLfrSMkjG9UQE
         tVKg==
X-Gm-Message-State: AFuF++lN3Du/wzA+tRPHewUil1n/1YmByIhq3bPnudSDKcjmGHt6pEw3
	ReXBBswLmP/ltkOBDDTI47L/UhoAMIEDVutFlvlukyGoKaaB6wP7rWCqAOxQrZldVlK995IhqsI
	fbP0PCou0km0htnf+MMkhIBvlxwaZkrZjBYgv6+0YYZ0cfvs7slz1a1xcC1cdQAKo/lZi8MCFq3
	WiTjNcWXKfR+khwKVxkHWJ+8IGy8egKw==
X-Received: from pgww22.prod.google.com ([2002:a05:6a02:2c96:b0:cc7:ade4:5f77])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:c90a:b0:3dd:85a9:55a9
 with SMTP id adf61e73a8af0-3de26db3254mr10142499637.34.1790653549063; Mon, 28
 Sep 2026 20:45:49 -0700 (PDT)
Date: Tue, 29 Sep 2026 03:45:06 +0000
In-Reply-To: <20260929034510.2023173-1-praan@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260929034510.2023173-1-praan@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260929034510.2023173-13-praan@google.com>
Subject: [PATCH v11 12/16] iommu/tegra241-cmdqv: Add a helper to quiesce VCMDQs
From: Pranjal Shrivastava <praan@google.com>
To: iommu@lists.linux.dev
Cc: Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>, 
	Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>, Mostafa Saleh <smostafa@google.com>, 
	Nicolin Chen <nicolinc@nvidia.com>, Daniel Mentz <danielmentz@google.com>, 
	Ashish Mhetre <amhetre@nvidia.com>, linux-arm-kernel@lists.infradead.org, 
	Thomas Gleixner <tglx@kernel.org>, Radu Rendec <radu@rendec.net>, Bjorn Helgaas <bhelgaas@google.com>, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, rafael@kernel.org, 
	Danilo Krummrich <dakr@kernel.org>, driver-core@lists.linux.dev, 
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
index 7f89e2306942..89a4e756ff17 100644
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
2.56.0.rc1.315.gc6ed9934b7-goog

