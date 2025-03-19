Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D66A91E231F
	for <iommu@lists.linux.dev>; Wed, 19 Mar 2025 14:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742395453; cv=none; b=l5TAJ+j/h5OAzqJTnNS6E12zSBYsO13ghD5SiE7L59vLEbXe3+xIN327j0EwVIR+xzlaxsL31k4JCMq+hbGQZIvq+7TAckMROHg2skliTCQcNzejdAiuj62WVYtzUpra6b4eFknSFpqnVL+ZV6Ea3G8i/y3CmV85ACLAwXg2QlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742395453; c=relaxed/simple;
	bh=tTTpB0Ao5UrDtWkZT9tEFwgF3Yy2+aFm7zr2QcY9Sdk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RLGdqNDNKl+Hv9suxCmB5HnqsQx2VkaQsisjb6/r3a+LCCayvVKJpK3bwpvz4l5bnT6mkJVGSYk3LPIUmCRB4j2CFHIDH/whrKUhzgLGM3Xo9pDBhN4uZtZPl0JD/13KdpvfjJ/vC25MMqbKCEGwbrfMQre+fCwXSx/Rviqgg8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fv5C5N2d; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fv5C5N2d"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7c5a3334fddso31444685a.1
        for <iommu@lists.linux.dev>; Wed, 19 Mar 2025 07:44:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742395450; x=1743000250; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LVIOe6YO1QFlgbOaSVSB9MxST2MN7teDfhAEgXLqPn8=;
        b=fv5C5N2dlSkuaCjERrrxVgJ2RGvcpgZ9Lhey/D8ZVNk6WKwSXvGV/q3jJcxM0AJN7L
         +SNjarVo5j5yYqAEtjGrG4c+jFhxvOSTzfn67xO3HAl3X/4KAEQcn9r7hpcsSXCcTCBZ
         JSRmva/AMYbrFezv/T3Gjr27tvHcpsy1htweqSqW1m45Q+MvBYoygf8n0j9a4GIBPHk4
         8hdE5S3qusXIMomqDVV/ep3FMBZmF0pCjEXd+GfkAwl2iBmsixr/2BlCEBf2zYV7mHoJ
         aijR03n1RdtUAWMVafE7TWwWGcSTVbfECQVcoB7LZ66rY3xggvtqUYL1PTGN5gJ3y1RA
         vrnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742395450; x=1743000250;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LVIOe6YO1QFlgbOaSVSB9MxST2MN7teDfhAEgXLqPn8=;
        b=GWhrzcfUjU/GpAG7b9etaVcCEt4qUf+AIJZNHVevSrHtr9z9YCeOut9cYwdYJV8bbv
         iEJCTgpA4DaEp0WoEYfAUPhQWLwSmw50LCe6PNXolEitTae+jcrOVm0aKiPDuu/9W0mj
         EVx35ngyeevDkkHQnLXZhu4F4QEbu8OwVtOToWUXq+Z+254r3x5wo+tiI1OXUvF05u6Z
         kCmx1/va4pyb3p5GxOBVvA45TUPqdfDLQFQEbaypqE5/NhjLYSgvv5KlNKMEm51+T19o
         HyIew0xuc73ukiZcnFEpfMOw1g076glTgAD4ehFMLAj9AtLfO3IExpa1lJRrlD/unO7D
         8WuQ==
X-Gm-Message-State: AOJu0YwEqs7r56EfZ4uKVSw2yGRKL8Sc1bnJgqGQRxGFVt/4Z4avx2NC
	MvG9ejYUgHKAoHNNghfr2922b/mUAMaDcY0LcQgDfN6ZHFR7jwVU
X-Gm-Gg: ASbGnctz2fuapyk8SsQ0Rwr4EtlDbR9cbVvD0S5TntgkYVfw9Nqa2fKptSX5pbimOtU
	omVNsTXhUkfmBpw2N/Bkfeu2245QpgDLfnDK4v9+IDX044ZJIJjHshAm3X7Qq/3T12QoINUxwAY
	oHwoeA4QuerVD1G1gDcf7hcnFFUgFDBo/0RoccZpTXosG5Chvjg4ywn66U1PHn4ozpm4PSXJrq4
	MRYWluhUcB4o6Ci/5ysW4CQ2PqKao61wzIESAmkSfi0Rx2fE0m4STaKcVVRfinCXC1OVU3qDmQb
	ReIRrnlTFJ+bPVZZcFl7/a/S7rl1OjWYhUL9Hst0k3bmDyAoNcxoYHDykoOOLSRLnrbGWRv76E9
	kjr0=
X-Google-Smtp-Source: AGHT+IFNRUs3nv+7+hsvhyD1099wEYjZlC8bdXc8Jfmcl+lTK2hcYAEosbvXtZXZvJ/hQAwsmaiwrg==
X-Received: by 2002:a05:620a:2485:b0:7c0:b018:5930 with SMTP id af79cd13be357-7c5a849ceb4mr150552885a.15.1742395449476;
        Wed, 19 Mar 2025 07:44:09 -0700 (PDT)
Received: from [192.168.1.99] (ool-4355b0da.dyn.optonline.net. [67.85.176.218])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c573c5201fsm868587485a.23.2025.03.19.07.44.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 07:44:09 -0700 (PDT)
From: Connor Abbott <cwabbott0@gmail.com>
Date: Wed, 19 Mar 2025 10:44:01 -0400
Subject: [PATCH v5 2/5] iommu/arm-smmu-qcom: Don't read fault registers
 directly
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250319-msm-gpu-fault-fixes-next-v5-2-97561209dd8c@gmail.com>
References: <20250319-msm-gpu-fault-fixes-next-v5-0-97561209dd8c@gmail.com>
In-Reply-To: <20250319-msm-gpu-fault-fixes-next-v5-0-97561209dd8c@gmail.com>
To: Rob Clark <robdclark@gmail.com>, Will Deacon <will@kernel.org>, 
 Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>, 
 Sean Paul <sean@poorly.run>, Konrad Dybcio <konradybcio@kernel.org>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 Marijn Suijten <marijn.suijten@somainline.org>
Cc: iommu@lists.linux.dev, linux-arm-msm@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, freedreno@lists.freedesktop.org, 
 Connor Abbott <cwabbott0@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1742395446; l=5867;
 i=cwabbott0@gmail.com; s=20240426; h=from:subject:message-id;
 bh=tTTpB0Ao5UrDtWkZT9tEFwgF3Yy2+aFm7zr2QcY9Sdk=;
 b=SbxyVBfCazjMcZnOBvSnP6XYVUpV1d+ECUu5MQSlhmDcQ2Sqe2AtsfGxR81gtgborBDdYHY9U
 6zMkNpecHzPArS1lpqtpzbf/QtWVL0UWm99pJ9QFFbo6w9vGuBQfa1U
X-Developer-Key: i=cwabbott0@gmail.com; a=ed25519;
 pk=dkpOeRSXLzVgqhy0Idr3nsBr4ranyERLMnoAgR4cHmY=

In some cases drm/msm has to resume a stalled transaction directly in
its fault handler. Experimentally this doesn't work on SMMU500 if the
fault hasn't already been acknowledged by clearing FSR. Rather than
trying to clear FSR in msm's fault handler and implementing a
tricky handshake to avoid accidentally clearing FSR twice, we want to
clear FSR before calling the fault handlers, but this means that the
contents of registers can change underneath us in the fault handler and
msm currently uses a private function to read the register contents for
its own purposes in its fault handler, such as using the
implementation-defined FSYNR1 to determine which block caused the fault.
Fix this by making msm use the register values already read by arm-smmu
itself before clearing FSR rather than messing around with reading
registers directly.

Signed-off-by: Connor Abbott <cwabbott0@gmail.com>
Reviewed-by: Rob Clark <robdclark@gmail.com>
---
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 19 +++++++++----------
 drivers/iommu/arm/arm-smmu/arm-smmu.c      | 14 +++++++-------
 drivers/iommu/arm/arm-smmu/arm-smmu.h      | 21 +++++++++++----------
 3 files changed, 27 insertions(+), 27 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
index 6372f3e25c4bc24cb52f9233095170e8aa510a53..186d6ad4fd1c990398df4dec53f4d58ada9e658c 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
@@ -62,16 +62,15 @@ static void qcom_adreno_smmu_get_fault_info(const void *cookie,
 		struct adreno_smmu_fault_info *info)
 {
 	struct arm_smmu_domain *smmu_domain = (void *)cookie;
-	struct arm_smmu_cfg *cfg = &smmu_domain->cfg;
-	struct arm_smmu_device *smmu = smmu_domain->smmu;
-
-	info->fsr = arm_smmu_cb_read(smmu, cfg->cbndx, ARM_SMMU_CB_FSR);
-	info->fsynr0 = arm_smmu_cb_read(smmu, cfg->cbndx, ARM_SMMU_CB_FSYNR0);
-	info->fsynr1 = arm_smmu_cb_read(smmu, cfg->cbndx, ARM_SMMU_CB_FSYNR1);
-	info->far = arm_smmu_cb_readq(smmu, cfg->cbndx, ARM_SMMU_CB_FAR);
-	info->cbfrsynra = arm_smmu_gr1_read(smmu, ARM_SMMU_GR1_CBFRSYNRA(cfg->cbndx));
-	info->ttbr0 = arm_smmu_cb_readq(smmu, cfg->cbndx, ARM_SMMU_CB_TTBR0);
-	info->contextidr = arm_smmu_cb_read(smmu, cfg->cbndx, ARM_SMMU_CB_CONTEXTIDR);
+	struct arm_smmu_context_fault_info *cfi = &smmu_domain->cfi;
+
+	info->fsr = cfi->fsr;
+	info->fsynr0 = cfi->fsynr0;
+	info->fsynr1 = cfi->fsynr1;
+	info->far = cfi->iova;
+	info->cbfrsynra = cfi->cbfrsynra;
+	info->ttbr0 = cfi->ttbr0;
+	info->contextidr = cfi->contextidr;
 }
 
 static void qcom_adreno_smmu_set_stall(const void *cookie, bool enabled)
diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/arm-smmu/arm-smmu.c
index a02078eb968b81a35c1c086ed7007ea2a453ef94..c7b5d7c093e71050d29a834c8d33125e96b04d81 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
@@ -457,26 +457,26 @@ void arm_smmu_print_context_fault_info(struct arm_smmu_device *smmu, int idx,
 
 static irqreturn_t arm_smmu_context_fault(int irq, void *dev)
 {
-	struct arm_smmu_context_fault_info cfi;
 	struct arm_smmu_domain *smmu_domain = dev;
+	struct arm_smmu_context_fault_info *cfi = &smmu_domain->cfi;
 	struct arm_smmu_device *smmu = smmu_domain->smmu;
 	static DEFINE_RATELIMIT_STATE(rs, DEFAULT_RATELIMIT_INTERVAL,
 				      DEFAULT_RATELIMIT_BURST);
 	int idx = smmu_domain->cfg.cbndx;
 	int ret;
 
-	arm_smmu_read_context_fault_info(smmu_domain, &cfi);
+	arm_smmu_read_context_fault_info(smmu_domain, cfi);
 
-	if (!(cfi.fsr & ARM_SMMU_CB_FSR_FAULT))
+	if (!(cfi->fsr & ARM_SMMU_CB_FSR_FAULT))
 		return IRQ_NONE;
 
-	ret = report_iommu_fault(&smmu_domain->domain, NULL, cfi.iova,
-		cfi.fsynr0 & ARM_SMMU_CB_FSYNR0_WNR ? IOMMU_FAULT_WRITE : IOMMU_FAULT_READ);
+	ret = report_iommu_fault(&smmu_domain->domain, NULL, cfi->iova,
+		cfi->fsynr0 & ARM_SMMU_CB_FSYNR0_WNR ? IOMMU_FAULT_WRITE : IOMMU_FAULT_READ);
 
 	if (ret == -ENOSYS && __ratelimit(&rs))
-		arm_smmu_print_context_fault_info(smmu, idx, &cfi);
+		arm_smmu_print_context_fault_info(smmu, idx, cfi);
 
-	arm_smmu_cb_write(smmu, idx, ARM_SMMU_CB_FSR, cfi.fsr);
+	arm_smmu_cb_write(smmu, idx, ARM_SMMU_CB_FSR, cfi->fsr);
 	return IRQ_HANDLED;
 }
 
diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.h b/drivers/iommu/arm/arm-smmu/arm-smmu.h
index ef6915a0d9f62b0a1734a3ee57ea422615036094..ff84ce3b8d8567d3402e945e8277ca2a87df9a4e 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu.h
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu.h
@@ -373,6 +373,16 @@ enum arm_smmu_domain_stage {
 	ARM_SMMU_DOMAIN_NESTED,
 };
 
+struct arm_smmu_context_fault_info {
+	unsigned long iova;
+	u64 ttbr0;
+	u32 fsr;
+	u32 fsynr0;
+	u32 fsynr1;
+	u32 cbfrsynra;
+	u32 contextidr;
+};
+
 struct arm_smmu_domain {
 	struct arm_smmu_device		*smmu;
 	struct io_pgtable_ops		*pgtbl_ops;
@@ -380,6 +390,7 @@ struct arm_smmu_domain {
 	const struct iommu_flush_ops	*flush_ops;
 	struct arm_smmu_cfg		cfg;
 	enum arm_smmu_domain_stage	stage;
+	struct arm_smmu_context_fault_info cfi;
 	struct mutex			init_mutex; /* Protects smmu pointer */
 	spinlock_t			cb_lock; /* Serialises ATS1* ops and TLB syncs */
 	struct iommu_domain		domain;
@@ -541,16 +552,6 @@ struct arm_smmu_device *qcom_smmu_impl_init(struct arm_smmu_device *smmu);
 void arm_smmu_write_context_bank(struct arm_smmu_device *smmu, int idx);
 int arm_mmu500_reset(struct arm_smmu_device *smmu);
 
-struct arm_smmu_context_fault_info {
-	unsigned long iova;
-	u64 ttbr0;
-	u32 fsr;
-	u32 fsynr0;
-	u32 fsynr1;
-	u32 cbfrsynra;
-	u32 contextidr;
-};
-
 void arm_smmu_read_context_fault_info(struct arm_smmu_domain *smmu_domain,
 				      struct arm_smmu_context_fault_info *cfi);
 

-- 
2.47.1

