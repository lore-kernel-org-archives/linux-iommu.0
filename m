Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A54A1E9B14
	for <iommu@lists.linux.dev>; Mon, 20 Jan 2025 15:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737388012; cv=none; b=T0lPoSPUkjZ60LtwL0np25YxXS0QTCM6SvZXNYGEiYrPsIgBGiQkYL+wKa7FlaXPPoS9YdNYmrYbE83kesgkXbcwlDm7+Em0HKRK5YwZrMY5CyWFYsblfxxXSVuDAF69hmO/jrWKfm99HGBlFXHLdMKQqjOAjieATCg0VTgY2oI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737388012; c=relaxed/simple;
	bh=/R/KwmLG8BNK0A9MSvTs3s46WR5S+uGDge+4KTr0h7A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=P6PIpgQhwon3OfbkATCyjsHqhFsfXyETxgxggZfp6gEi/wZGa5bxL0nb4Ve184bJwZYOtjyBqx0V4xbWrtjGnnHUZM7EtV/1VpM73YxIFF3/QaYL53p0rLH5uYFulEQ4B3k4QFp+Ukxk35NlySPjirlU5TNbugIJ6Czzcm4ukGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ktj0CZm0; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ktj0CZm0"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7bb849ac4cbso18468285a.2
        for <iommu@lists.linux.dev>; Mon, 20 Jan 2025 07:46:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737388009; x=1737992809; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hSLZFqeYYNzupLkvhQkP6jOZE1gw3J9u+/ZaTXXZ98M=;
        b=ktj0CZm0EI7DG3et/iEbcZeAa4EqqsxUFkmc83RMRtwzx2f7Fms9+Y+XIlbIkiobBd
         rdrSsOJHotHjw455j3xy190JAKgjE05d3RccscxxjLjCzNSEVXvD0GOsRCKR4T20Bo15
         6vXgAlhMFkp4Dv5t1+1Yl8d9EP4+f0aUGjBD4jsPg7vx3rRWWuiy49t0gVKbGMKvuoRE
         3fWGSQYCSU5w4rQOBVfjquabAxa+BbBJI7bcJTHZCmEyNpz+1tEqU6X8bhMjjE9BOMfl
         V1qZLxG3TrdyYNmQFhL9sawVKgetogUbf6vlRXJSbkoAGTGL56s95PgPTWPoXxToIx0w
         kcsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737388009; x=1737992809;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hSLZFqeYYNzupLkvhQkP6jOZE1gw3J9u+/ZaTXXZ98M=;
        b=r/XzXVLvOLpt5+KT4dHzScVDKvqTpdwsVNGWzyctk+pHVKUmHK83oH+YKbckdyJtZq
         KsUn5B2I5zMH2FqCz3RZM4jm8Lt86MQgVIW+MOjqfE6i4hKjzZ8ECf3X5gHkCHumxtNV
         PZZQ7kN/lzogMun1CrdRtpp8rHe8B24uk7xlIzrEUfsJyUp8fKtSF6D75CxLVTy81m2J
         tlE4HSQX5ZSSs1VqtTsBiwmf8Cwq9uuckFJcYVJNf/HwdHX+OJ3HXOJyWUW+YwUN9t4y
         caMMmOesj54GAWNVRK3XwJeQZYXqC1amyVmc/yRHMG9jACvck9Hs5naZ2XTrJ7uADjgf
         5iPg==
X-Gm-Message-State: AOJu0Ywkcu0GUXaz5pCJ8l1kPtOtVdj77v6qkJvoHwZvt69/WsbeNYH8
	Js6SrNNu6EjAsnANrkDklw8/jKrqjDQcdDWrcw3WGfpshVGm9v5V
X-Gm-Gg: ASbGncuDXDL00lMtCwvupID2Y0b9/WCcxr+aMs5/hk50UwvOwncmYYltJnFyMw9X7zN
	QT0B6xuXClSKileXf4TnMwXwGmwJYi2t6ORlx3LMIQYE7YwDacicZhuxT3X+gAaLqbgWqDJdJi1
	tKNjQh0ZlktqYPgxPYvDGDXb3Xp+oOFNzqmZW1jww4rE0uDaJa/TXV3YrbSRvOftKYZvFSJsh4Y
	RlAYAYSYm68pSDf0iYC7XmfuqXwMH0ebfrvojFo6eB7hgpUBVEmti1TSpqaCA80hM3g5uFZcAbm
	FpYSUIbiqHS8TY41whTcL+wHOPuq
X-Google-Smtp-Source: AGHT+IGRsLr/plYsivjFW9Wg8gre0DgIcAGugN+vGYfCVVtZ4j/IBlWDl4kSNHtp3nt9yDagfFdlpg==
X-Received: by 2002:a05:622a:1b92:b0:467:692b:754f with SMTP id d75a77b69052e-46e12ba7bbcmr75029041cf.13.1737388008704;
        Mon, 20 Jan 2025 07:46:48 -0800 (PST)
Received: from [192.168.1.99] (ool-4355b0da.dyn.optonline.net. [67.85.176.218])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-46e258c82a6sm24230501cf.59.2025.01.20.07.46.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jan 2025 07:46:48 -0800 (PST)
From: Connor Abbott <cwabbott0@gmail.com>
Date: Mon, 20 Jan 2025 10:46:45 -0500
Subject: [PATCH v2 1/3] iommu/arm-smmu: Fix spurious interrupts with
 stall-on-fault
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250120-msm-gpu-fault-fixes-next-v2-1-d636c4027042@gmail.com>
References: <20250120-msm-gpu-fault-fixes-next-v2-0-d636c4027042@gmail.com>
In-Reply-To: <20250120-msm-gpu-fault-fixes-next-v2-0-d636c4027042@gmail.com>
To: Rob Clark <robdclark@gmail.com>, Will Deacon <will@kernel.org>, 
 Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>, 
 Sean Paul <sean@poorly.run>, Konrad Dybcio <konradybcio@kernel.org>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
 Marijn Suijten <marijn.suijten@somainline.org>
Cc: iommu@lists.linux.dev, linux-arm-msm@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, freedreno@lists.freedesktop.org, 
 Connor Abbott <cwabbott0@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1737388006; l=4916;
 i=cwabbott0@gmail.com; s=20240426; h=from:subject:message-id;
 bh=/R/KwmLG8BNK0A9MSvTs3s46WR5S+uGDge+4KTr0h7A=;
 b=i7N/dXDgmGRIUd5U3WyV/nZ1JYDRziJEUikvzGMd1shfUJc6J9lsKpEdwN1swebrd3bgyVDHe
 ji9jXgXa20LAFM5UdplIavb/r9aoVLZzBohatVWjp8A6USt4YLtjmui
X-Developer-Key: i=cwabbott0@gmail.com; a=ed25519;
 pk=dkpOeRSXLzVgqhy0Idr3nsBr4ranyERLMnoAgR4cHmY=

On some SMMUv2 implementations, including MMU-500, SMMU_CBn_FSR.SS
asserts an interrupt. The only way to clear that bit is to resume the
transaction by writing SMMU_CBn_RESUME, but typically resuming the
transaction requires complex operations (copying in pages, etc.) that
can't be done in IRQ context. drm/msm already has a problem, because
its fault handler sometimes schedules a job to dump the GPU state and
doesn't resume translation until this is complete.

Work around this by disabling context fault interrupts until after the
transaction is resumed. Because other context banks can share an IRQ
line, we may still get an interrupt intended for another context bank,
but in this case only SMMU_CBn_FSR.SS will be asserted and we can skip
it assuming that interrupts are disabled which is accomplished by
removing the bit from ARM_SMMU_CB_FSR_FAULT.

Signed-off-by: Connor Abbott <cwabbott0@gmail.com>
---
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 15 ++++++++++++++-
 drivers/iommu/arm/arm-smmu/arm-smmu.c      | 30 ++++++++++++++++++++++++++++++
 drivers/iommu/arm/arm-smmu/arm-smmu.h      |  1 -
 3 files changed, 44 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
index 59d02687280e8d37b5e944619fcfe4ebd1bd6926..7d86e9972094eb4d304b24259f4ed9a4820cabc7 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
@@ -125,12 +125,25 @@ static void qcom_adreno_smmu_resume_translation(const void *cookie, bool termina
 	struct arm_smmu_domain *smmu_domain = (void *)cookie;
 	struct arm_smmu_cfg *cfg = &smmu_domain->cfg;
 	struct arm_smmu_device *smmu = smmu_domain->smmu;
-	u32 reg = 0;
+	u32 reg = 0, sctlr;
+	unsigned long flags;
 
 	if (terminate)
 		reg |= ARM_SMMU_RESUME_TERMINATE;
 
+	spin_lock_irqsave(&smmu_domain->cb_lock, flags);
+
 	arm_smmu_cb_write(smmu, cfg->cbndx, ARM_SMMU_CB_RESUME, reg);
+
+	/*
+	 * Re-enable interrupts after they were disabled by
+	 * arm_smmu_context_fault().
+	 */
+	sctlr = arm_smmu_cb_read(smmu, cfg->cbndx, ARM_SMMU_CB_SCTLR);
+	sctlr |= ARM_SMMU_SCTLR_CFIE;
+	arm_smmu_cb_write(smmu, cfg->cbndx, ARM_SMMU_CB_SCTLR, sctlr);
+
+	spin_unlock_irqrestore(&smmu_domain->cb_lock, flags);
 }
 
 static void qcom_adreno_smmu_set_prr_bit(const void *cookie, bool set)
diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/arm-smmu/arm-smmu.c
index 79afc92e1d8b984dd35c469a3f283ad0c78f3d26..fe3d77984533eb1a0e0e211021598bc808f2a6b2 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
@@ -463,6 +463,36 @@ static irqreturn_t arm_smmu_context_fault(int irq, void *dev)
 	if (!(cfi.fsr & ARM_SMMU_CB_FSR_FAULT))
 		return IRQ_NONE;
 
+	/*
+	 * On some implementations FSR.SS asserts a context fault
+	 * interrupt. We do not want this behavior, because resolving the
+	 * original context fault typically requires operations that cannot be
+	 * performed in IRQ context but leaving the stall unacknowledged will
+	 * immediately lead to another spurious interrupt as FSR.SS is still
+	 * set. Work around this by disabling interrupts for this context bank.
+	 * It's expected that interrupts are re-enabled after resuming the
+	 * translation.
+	 *
+	 * We have to do this before report_iommu_fault() so that we don't
+	 * leave interrupts disabled in case the downstream user decides the
+	 * fault can be resolved inside its fault handler.
+	 *
+	 * There is a possible race if there are multiple context banks sharing
+	 * the same interrupt and both signal an interrupt in between writing
+	 * RESUME and SCTLR. We could disable interrupts here before we
+	 * re-enable them in the resume handler, leaving interrupts enabled.
+	 * Lock the write to serialize it with the resume handler.
+	 */
+	if (cfi.fsr & ARM_SMMU_CB_FSR_SS) {
+		u32 val;
+
+		spin_lock(&smmu_domain->cb_lock);
+		val = arm_smmu_cb_read(smmu, idx, ARM_SMMU_CB_SCTLR);
+		val &= ~ARM_SMMU_SCTLR_CFIE;
+		arm_smmu_cb_write(smmu, idx, ARM_SMMU_CB_SCTLR, val);
+		spin_unlock(&smmu_domain->cb_lock);
+	}
+
 	ret = report_iommu_fault(&smmu_domain->domain, NULL, cfi.iova,
 		cfi.fsynr & ARM_SMMU_CB_FSYNR0_WNR ? IOMMU_FAULT_WRITE : IOMMU_FAULT_READ);
 
diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.h b/drivers/iommu/arm/arm-smmu/arm-smmu.h
index 2dbf3243b5ad2db01e17fb26c26c838942a491be..789c64ff3eb9944c8af37426e005241a8288da20 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu.h
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu.h
@@ -216,7 +216,6 @@ enum arm_smmu_cbar_type {
 					 ARM_SMMU_CB_FSR_TLBLKF)
 
 #define ARM_SMMU_CB_FSR_FAULT		(ARM_SMMU_CB_FSR_MULTI |	\
-					 ARM_SMMU_CB_FSR_SS |		\
 					 ARM_SMMU_CB_FSR_UUT |		\
 					 ARM_SMMU_CB_FSR_EF |		\
 					 ARM_SMMU_CB_FSR_PF |		\

-- 
2.47.1

