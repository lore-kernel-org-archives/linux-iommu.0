Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E8C51E9B06
	for <iommu@lists.linux.dev>; Mon, 20 Jan 2025 15:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737388012; cv=none; b=Q+SaxDaVZq3UH0K0y9xAVpZ4odnIt3MlxpJAuDYssGT8HGnhjVGptSmISff5/qPocUuJHDTJ8kjzq8teahBR6vpBG5ybtmpownMSTe5uW/L5kGuPFV6mY8Ah6jmbC/rCF0vhpgPyEDdtXikbnfFmZ6y9vMebTKlayxeQvLLVQ5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737388012; c=relaxed/simple;
	bh=4obbXrvjN1YYsEVfq8apmOVUt5dXPe6TwBqzW1FSgs0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bHnR29Q5gBPB0gm2Nang6sznkPMcblEmLJqmVoN+DFbrhYShAxh/bsIhyRLoq6gwlV7G12ep2aEVWR2283a3gqdpnXNUDrEgNRn5WRGPo7wMJ3ZnVYMUjrfYDxhQRsqiYf0ffkZ4uL6GEagm9zowBqcanQca+nsbtAMfW3sHfZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IBk/Dl27; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IBk/Dl27"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-46796c932bdso3450761cf.2
        for <iommu@lists.linux.dev>; Mon, 20 Jan 2025 07:46:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737388010; x=1737992810; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=clItPhIQuRHdt/X/5Yn3hkPoRrPZ3x4kk0mvqKl7Y8o=;
        b=IBk/Dl27WffdaXQoE+YoLDvIuZrZcl308WKVKRD2wdVVfIwT32MncPo0XKyCLXMIKa
         MAmTTyy6GMLXkH+JaHma5jIs7u2DFmue/vqLVQTJxS7tSJ3PDeFsCPlHadEPIiJHqDQ4
         4g/j8rb3IuSd7Brz3AYMSTJUJZejT2uFd0/ZzXK5KvH4D515hpIB4q3glmUG9SY+vCHZ
         6RjfxwsOJeDJYxNQ0BdeHygjr5e4Hkv1pWcaN7fxkEQ5ffz4855VaNEA1bVwZCCj9z04
         TD2yHjr3CkwrFsFpY4UjNYbZWtcOIfMo27nPJSe7/Ao8jKovXUdgVFgA0XyniqtRBojj
         g8sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737388010; x=1737992810;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=clItPhIQuRHdt/X/5Yn3hkPoRrPZ3x4kk0mvqKl7Y8o=;
        b=EUB7UYNWSbYhwVS1Ph4gceOhdCNv2Z67DyAOLnKxWs9TI6o1BvrLtIQuzyJDYSb8Kn
         IFhK3dvHpSMU8hK86H3vqn5HT+WRSeotfPaUtPfU/TnxelFfuKlygMqdtRflv1TzxqqA
         oICqeYtZn4p7QyH/sGjKLhdivr50pOpnQ88aUjmNZJjFnG/lIaIFvC6HDfc0gSu6P2cK
         5MpqGQteqtqdMb1NNRJFM9LLu1ufTWY7RYModagFurN5hwMWDr8fzoKTFGrWrM0Cn9FL
         nGuLneyya0I7fz3bDHCtTwNqSVh5jFJjZJFakToq5+9X3WAd6WVzNZ88yxzk6GGDbvqD
         9gGw==
X-Gm-Message-State: AOJu0YwzoYaUMcov2/92bz5jTL3ogNjKADl1sYASc7N3varCOvvpwpkQ
	HUKJdhtabCZmKWBzr6RStaVQ1m0LJfe/NTgAfJRU/BB8cFix1r/y
X-Gm-Gg: ASbGncuOyQK5iNg85JBCCX5u4ZX0NDmds7PIGpUTdEQ+nyvuS3cPD44MvqZ9d+68odP
	o2B6kHouozwbwuREhU5lmo8me9hRERNbMoYpr8G6xpb4kgePrUCc6BmZS8q7R7U/zX6KGa8FTNv
	7v9dhCKHqqGF9x0Ub3c90ElwsPSLBYUcC53uclP3+NQ+mxWc7iCq+wwRWgin/kJrMzqVw82HPUR
	5lT8njel7Z71G5rfz1JAyizGlJ/IByGNR5MMYzWiRfdDwke7nsg0lRcF2fzoMvhu7uGPd35jM2w
	Nt8lHw0jy9U1ThSEUIWnL69wTx3G
X-Google-Smtp-Source: AGHT+IGO83HWcFHvsj2Z+GtJHgpwBYQ5v8L6QYl9DTIkrCF/MppDtKtDUAn/rsAhdmobjhxCpwFbMA==
X-Received: by 2002:a05:622a:608a:b0:46e:12fc:6c83 with SMTP id d75a77b69052e-46e12fc733cmr80827391cf.0.1737388009957;
        Mon, 20 Jan 2025 07:46:49 -0800 (PST)
Received: from [192.168.1.99] (ool-4355b0da.dyn.optonline.net. [67.85.176.218])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-46e258c82a6sm24230501cf.59.2025.01.20.07.46.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jan 2025 07:46:49 -0800 (PST)
From: Connor Abbott <cwabbott0@gmail.com>
Date: Mon, 20 Jan 2025 10:46:46 -0500
Subject: [PATCH v2 2/3] iommu/arm-smmu-qcom: Make set_stall work when the
 device is on
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250120-msm-gpu-fault-fixes-next-v2-2-d636c4027042@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1737388006; l=2108;
 i=cwabbott0@gmail.com; s=20240426; h=from:subject:message-id;
 bh=4obbXrvjN1YYsEVfq8apmOVUt5dXPe6TwBqzW1FSgs0=;
 b=1hM2Wj1hNgl2mwr4iWI4WCaP5p+MmlgGs0igxClq5lMDY3J0i7z9MPcdLw38a+qq6t3MdsGRN
 stHBB5mOzQLDWO2MTNS3tPbd/ElnrF/+O0xip/h7iEzq0A8p8RLFyl4
X-Developer-Key: i=cwabbott0@gmail.com; a=ed25519;
 pk=dkpOeRSXLzVgqhy0Idr3nsBr4ranyERLMnoAgR4cHmY=

Up until now we have only called the set_stall callback during
initialization when the device is off. But we will soon start calling it
to temporarily disable stall-on-fault when the device is on, so handle
that by checking if the device is on and writing SCTLR.

Signed-off-by: Connor Abbott <cwabbott0@gmail.com>
---
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 30 +++++++++++++++++++++++++++---
 1 file changed, 27 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
index 7d86e9972094eb4d304b24259f4ed9a4820cabc7..6693d8f8e3ae4e970ca9d7f549321ab4f59e8b32 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
@@ -112,12 +112,36 @@ static void qcom_adreno_smmu_set_stall(const void *cookie, bool enabled)
 {
 	struct arm_smmu_domain *smmu_domain = (void *)cookie;
 	struct arm_smmu_cfg *cfg = &smmu_domain->cfg;
-	struct qcom_smmu *qsmmu = to_qcom_smmu(smmu_domain->smmu);
+	struct arm_smmu_device *smmu = smmu_domain->smmu;
+	struct qcom_smmu *qsmmu = to_qcom_smmu(smmu);
+	u32 mask = BIT(cfg->cbndx);
+	bool stall_changed = !!(qsmmu->stall_enabled & mask) != enabled;
+	unsigned long flags;
 
 	if (enabled)
-		qsmmu->stall_enabled |= BIT(cfg->cbndx);
+		qsmmu->stall_enabled |= mask;
 	else
-		qsmmu->stall_enabled &= ~BIT(cfg->cbndx);
+		qsmmu->stall_enabled &= ~mask;
+
+	/*
+	 * If the device is on and we changed the setting, update the register.
+	 */
+	if (stall_changed && pm_runtime_get_if_active(smmu->dev) > 0) {
+		spin_lock_irqsave(&smmu_domain->cb_lock, flags);
+
+		u32 reg = arm_smmu_cb_read(smmu, cfg->cbndx, ARM_SMMU_CB_SCTLR);
+
+		if (enabled)
+			reg |= ARM_SMMU_SCTLR_CFCFG;
+		else
+			reg &= ~ARM_SMMU_SCTLR_CFCFG;
+
+		arm_smmu_cb_write(smmu, cfg->cbndx, ARM_SMMU_CB_SCTLR, reg);
+
+		spin_unlock_irqrestore(&smmu_domain->cb_lock, flags);
+
+		pm_runtime_put_autosuspend(smmu->dev);
+	}
 }
 
 static void qcom_adreno_smmu_resume_translation(const void *cookie, bool terminate)

-- 
2.47.1

