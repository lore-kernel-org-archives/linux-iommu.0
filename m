Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78AFC595740
	for <iommu@lists.linux.dev>; Tue,  8 Sep 2026 17:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788887846; cv=none; b=JUa5ppjQXbXVr9iVXaQIt5wDAlGLlu0ZOuA2wKQSJYRQ2BOVDunLwqHF2L5R7pLk7hBYGLAY9FLIpzIIGPR/NFnVuk5E+zjXva1UdISAG2UFgzUSJU2EdCHJOULuolmXDalLmre9DJugykFWY6ecZpf4DJLGVoeDCZef9PlgPaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788887846; c=relaxed/simple;
	bh=q0CrQS1uNJLTOpfZUkVO+v6eCun1s2wvCYAqB0wYBTU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=kf4g0B3fOpvQLfripuie062I7EnHNJ2qu6oz8Gs+lAcOz5sJ1+uPdpAeIj0yT8YXaeo1eG465JkVOmUD2w+NClwrDFwt1qrPgwF8Fh08VzqstJNayOxuvF2hln87dzik93aKkYhxVMYf8LgiB0npR/VQ1GG73JMKCB31yq3es78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RExzmSwW; arc=none smtp.client-ip=209.85.215.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RExzmSwW"
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cc42a07d04aso5206152a12.1
        for <iommu@lists.linux.dev>; Tue, 08 Sep 2026 10:17:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788887845; x=1789492645; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9C92r83nS2wq2dKMa8skb7uP3YeUASzkep8OkFa0pmc=;
        b=RExzmSwWA2YEVL/zivnOQZrBmvRyTIzdF+Elb7Zcov8vqjwDeOp9g+8PAvN7N5kcTD
         nw/5sbRXq67PugBPUaBv4VSIMv7t+ayR9uXWCsHYOvxDkq3UAKjySoayEj9D6/+sg3kK
         hMuxuvJfJvbhVncVUjl+zI69DuurmKRdzqbWpa/jDT1aSyEyW2e/OBbo0Fuky71dC9lF
         mv/KXke9/a8XghGGT3K7KyoKaL4M+Z8ddAmweWtQ9mBUPI2MbQ1WDcRnLAVugIYBw0yq
         4ytVUNPzdxAxy4SJCrP9AxnCsfAJMxzxuhW81NPT01wwh0ZUQyPXYW8qEMXX49dQ7y6k
         iVAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788887845; x=1789492645;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9C92r83nS2wq2dKMa8skb7uP3YeUASzkep8OkFa0pmc=;
        b=jHZkSW+VInj9+LZ4LNJ7GBXex2MdAq6v+xxxWX3fhX6mugRgB24iU8hZj1LGt8AHZr
         V0Oz4+t+p54H4/pxXjnZCiDYgsN5OfJUDuHBFPkgLOJ8WAHH6W3tBVzwYLX1qN1/FJbE
         UVsDfKq3iWB0FeB5QBDCoEXJ1pNdijVzHduRpsS3KwY6r1RZLKF+wziu+rzCrLVKL0S+
         6rIgJND3DREqpnJm/dQq1ZuU/Lpo7SQ4J4XqkzWiNl8v3EOIBv50BqDx6PWY5Rt/CGrj
         yq68caRoEr4vblMvkHoUJaQwiiZEB7PmJZTHs2mH3JJd5J98tn/9oHAU+paiesoQcGLO
         FiJQ==
X-Gm-Message-State: AFuF++m37ZoM3fyTlubstLWasndCwc5pB6cocjpXv9K6pQt/NTUDJLk6
	Vzcb0zCpPZgIoBtTIoxhLfLSLNbjC7AlFcPa5yy2gUBgEokF6twH9L6lLgVEA4YBsooh2cgTHvz
	hxeUfCUUDZz6+zPooCAcmxGu+ElEbMjTNRIuU23A3bv0LfGS+qKfgj31tmWZqwaUfdrJk3GNqbS
	qQEblq+Zckx6wcXdyOyt11slwtck36Vg==
X-Received: from pgbcl15.prod.google.com ([2002:a05:6a02:98f:b0:c8b:2706:11a7])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:9f43:b0:3cc:92d9:80cb
 with SMTP id adf61e73a8af0-3da39e4d212mr51863565637.12.1788887844433; Tue, 08
 Sep 2026 10:17:24 -0700 (PDT)
Date: Tue,  8 Sep 2026 17:17:00 +0000
In-Reply-To: <20260908171712.356645-1-praan@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260908171712.356645-1-praan@google.com>
X-Mailer: git-send-email 2.55.0.979.g7e5102b832-goog
Message-ID: <20260908171712.356645-5-praan@google.com>
Subject: [PATCH v10 04/15] iommu/tegra241-cmdqv: Add a helper to drain VCMDQs
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

The tegra241-cmdqv driver supports vCMDQs which need to be drained
before suspending the SMMU. The current driver implementation only uses
VINTF0 for vCMDQs owned by the kernel which need to be drained. Add a
helper that drains all the enabled vCMDQs under VINTF0.

Add a drain_queues function ptr to arm_smmu_impl_ops to drain
implementation specified queues, and export arm_smmu_drain_queue().

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Pranjal Shrivastava <praan@google.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   |  5 +-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  4 ++
 .../iommu/arm/arm-smmu-v3/tegra241-cmdqv.c    | 49 +++++++++++++++++++
 3 files changed, 55 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 84b56849f6dc..d809b625f7fb 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -976,9 +976,8 @@ static int arm_smmu_cmdq_batch_submit(struct arm_smmu_device *smmu,
  * Context: Process context; may sleep.
  * Return: 0 on success or a negative errno on timeout.
  */
-static int __maybe_unused arm_smmu_drain_queue(struct arm_smmu_device *smmu,
-					       struct arm_smmu_queue *q,
-					       bool until_empty)
+int arm_smmu_drain_queue(struct arm_smmu_device *smmu,
+			 struct arm_smmu_queue *q, bool until_empty)
 {
 	ktime_t timeout = ktime_add_us(ktime_get(), ARM_SMMU_POLL_TIMEOUT_US);
 	u32 cons, prod, prev, undrained;
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 84e618a7fa9e..deefb17e31eb 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -891,6 +891,7 @@ struct arm_smmu_impl_ops {
 	size_t (*get_viommu_size)(enum iommu_viommu_type viommu_type);
 	int (*vsmmu_init)(struct arm_vsmmu *vsmmu,
 			  const struct iommu_user_data *user_data);
+	int (*drain_queues)(struct arm_smmu_device *smmu);
 };
 
 /* An SMMUv3 instance */
@@ -1174,6 +1175,9 @@ int arm_smmu_init_one_queue(struct arm_smmu_device *smmu,
 int arm_smmu_cmdq_init(struct arm_smmu_device *smmu,
 		       struct arm_smmu_cmdq *cmdq);
 
+int arm_smmu_drain_queue(struct arm_smmu_device *smmu,
+			 struct arm_smmu_queue *q, bool until_empty);
+
 static inline bool arm_smmu_master_canwbs(struct arm_smmu_master *master)
 {
 	return dev_iommu_fwspec_get(master->dev)->flags &
diff --git a/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c b/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
index 6644075c1431..a394bf0f487f 100644
--- a/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
+++ b/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
@@ -447,6 +447,54 @@ tegra241_cmdqv_get_cmdq(struct arm_smmu_device *smmu,
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
+		int rc;
+
+		if (!vcmdq || !READ_ONCE(vcmdq->enabled))
+			continue;
+
+		rc = arm_smmu_drain_queue(smmu, &vcmdq->cmdq.q, true);
+		if (rc) {
+			/*
+			 * The PM core forces suspend even if a drain times out.
+			 * We must record the error but continue draining the
+			 * remaining queues to ensure no in-flight commands are
+			 * abandoned when the hardware power is cut.
+			 */
+			dev_warn_ratelimited(smmu->dev,
+					     "vintf0 lvcmdq%u drain timed out\n",
+					     lidx);
+			ret = rc;
+		}
+
+		/* Avoid consuming stale commands on resume */
+		vcmdq->cmdq.q.llq.cons = vcmdq->cmdq.q.llq.prod;
+	}
+
+	return ret;
+}
+
 /* HW Reset Functions */
 
 /*
@@ -905,6 +953,7 @@ static struct arm_smmu_impl_ops tegra241_cmdqv_impl_ops = {
 	.device_reset = tegra241_cmdqv_hw_reset,
 	.device_disable = tegra241_cmdqv_hw_disable,
 	.device_remove = tegra241_cmdqv_remove,
+	.drain_queues = tegra241_cmdqv_drain_vintf0_lvcmdqs,
 	/* For user-space use */
 	.hw_info = tegra241_cmdqv_hw_info,
 	.get_viommu_size = tegra241_cmdqv_get_vintf_size,
-- 
2.55.0.979.g7e5102b832-goog

