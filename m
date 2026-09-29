Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C0303EB10C
	for <iommu@lists.linux.dev>; Tue, 29 Sep 2026 03:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790653526; cv=none; b=nsjdl3IpBsNsucPQk+1/RGFaPe0d4UBaGBPc6Bl0lOJY2FKbip1TBHUW5oZksZWk8hGmHC0HEdQpKUEpX20VNeU9f4FqECTJB5QWvJ7VG90K4n1oCt9ct4JIYLjfQxewvPHOhTc8S4PvsD4wGU7eQfpitwOIZnDMCAc5Cf8Ry+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790653526; c=relaxed/simple;
	bh=t7cblxT0vUYQRPsDnQYqfMWFXyQmKaI9oSR/Og8xyn0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=LBapx1o31xCyqmNnBhdCaSaFaejjwIEOWxvSt3Kp1BjCpTZtqeXwZnV9rNfTVIL18AzjnGZcUI680knOhCC3/VdlYsUkFC9BmYn2+5YVj4lvNTpx+QaZI1ETcRcevA3u2dvRpmPufA1pbaVJfu6zudlFncO8eRLCi4w8TFkF1vA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FyztF70N; arc=none smtp.client-ip=209.85.210.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FyztF70N"
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-882d8c4239bso1443353b3a.2
        for <iommu@lists.linux.dev>; Mon, 28 Sep 2026 20:45:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790653525; x=1791258325; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9PTYxgSgI1gU4YVXt5Wl8EAQGb2RKGpOz4eoAl0qe8o=;
        b=FyztF70NUAMO1vFdqs0l/9y+aXfTY27Vap+4YOSiFTu6R0e7BgYHh/GBWXUz5jaDgH
         pZmHm/+uajz1a8PyUnu5ACNETRA+kuDwhs7ir8GTXOQQ+USR9DNe39ZsxPr11nJTBa79
         uolFRJKKz9NWw/8MhOSAHCR18J/IQNB7romsg8khAqDDmQF19uxr73yju/WrZZwvICGA
         B213H3yEFCI6rJvsXk6ew1muxKjrNcL5O075aQ1Xt4XqGSpNf62OXOdKcRlwzcMIqgjy
         ODMiS6QeJlrQwngCYhui8qxKItvIYPf/eFioeIZYRZsXzqTBXgOaUL8IC2qa7CORist6
         bDiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790653525; x=1791258325;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9PTYxgSgI1gU4YVXt5Wl8EAQGb2RKGpOz4eoAl0qe8o=;
        b=Y8cMKlRbjaEhHoUvlLZhuh+4w9pJmMH5JDl1PXnu0XfdZXH9jqtNHKLt6R50L1loBo
         5w4T+DBK0+kkjXNRl61BLVa6ngXnwtLInGkM604IW/i8yOSM6gbwv8VS7LeRX0cu1n71
         a/8ONuHHnDCDF7GpHxoM21ey6uJUo3UofhWT+i40BkuJDNopY7FkPCfnUOLHcNn8Pq5x
         vWLsenImuO/yqd9fnrmilsIwAM0WHUWtpmwTQusmk5F0SOlfoBTqYfPhmfSv6bsf7awb
         ZO5ZRY81PQs2MuzXfB7y6G+n+6BFtgIrwW599riWIDfnph8rWOTQkXvFK3AA10x3ySVs
         DcRg==
X-Gm-Message-State: AFuF++l5UvL5LaC6msc/23fEH3bVEAipBlzfAvW8rfXn+qY3u+/2m/J9
	xifZgd6LIaTO1CROwyXtUdKZdZFD9E2ccSs4ZPKorNGekO6StufR1KZiHDlioZOMOKiWH0diikl
	TC4kGj0Oi9bVEz5V8HvusRbuipU+BUxtBiCQ1iEEbRHXfSDKNvnLQKDUP+vJ+XUhe9x7Yif1oG5
	XIlj18KOZaKsWCECViG2is1psdUHUXsA==
X-Received: from pgce14.prod.google.com ([2002:a05:6a02:1ce:b0:cc7:9e98:e366])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:4ea6:b0:3dd:85aa:452a
 with SMTP id adf61e73a8af0-3de0e8d32b0mr14950680637.37.1790653524254; Mon, 28
 Sep 2026 20:45:24 -0700 (PDT)
Date: Tue, 29 Sep 2026 03:44:58 +0000
In-Reply-To: <20260929034510.2023173-1-praan@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260929034510.2023173-1-praan@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260929034510.2023173-5-praan@google.com>
Subject: [PATCH v11 04/16] iommu/tegra241-cmdqv: Add a helper to drain VCMDQs
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
2.56.0.rc1.315.gc6ed9934b7-goog

