Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7229128B407
	for <iommu@lists.linux.dev>; Thu, 15 May 2025 19:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747339182; cv=none; b=LB0CcNT/8+83VLp91RzuLO7idZDwAypgOUv5/gWcRCBduGVCIZt0TC9SfsVqLq2Z2zq6l8I0H/WyCC4NCb0B543Cyh7+THQLiLQwHkaDfFMnrrFHZesWTsz89Yth3decsaXaVmW/cgTwBwRUMXeHoMGw+YFrjCGGwt4nNYvF6qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747339182; c=relaxed/simple;
	bh=yKFBdsoANpail9eN0dLOxr2jAWKJ9zute64DqhO2lxc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=icGwwKe3HwDUuAVG/xGja6mlIs7oUHminQ3rX0rVyWR7Ce5OJ5Y3v1AYrLK1cRROSvvrP6F1duiXgAhKRSwyvwejEA9/LH0uIq+7099UUx0I9nLgH/DWD6fYGACQIlogIRyrvPZwPw6akx6uAnvbp8HAuhWQlN4Faa/in5+i824=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YF1HlPC2; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YF1HlPC2"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-47745b4b9aaso2271221cf.0
        for <iommu@lists.linux.dev>; Thu, 15 May 2025 12:59:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747339179; x=1747943979; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=20DcKlS2hTvAgodxaUTpKC1CD/IfYxghOMwo8wKmU7s=;
        b=YF1HlPC2PH5vRI2Oe8gAt6x3zBk8t6GtkFidTeCAkEAkRNJbov4IjQRpoCnJKfrC9r
         zUZlOeTfRJr7YbEsk2fRZ+W6L6zyFKI3Ap4mgvnKeVW0RXVbzU69MzW4B/INLkQcoOXl
         UETGi2vQpdEr/x2w5c20B6wljgg7M5rE8uYt5uYMxirSqLJtkx2kueUr7h2bRAN9PtuA
         zzgU5rIKmyorxci/KKXl7/9jzYyYfZiEWwkLLc/0mZfpufXJbgGQmilTelGe8/OhG+DK
         75DGkNzGZZz68X4hFp8Ggyf1J4+niNghCMzWcGCWsL2NkN1zU9YkIUyiqUkzKwA+mp4f
         tbQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747339179; x=1747943979;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=20DcKlS2hTvAgodxaUTpKC1CD/IfYxghOMwo8wKmU7s=;
        b=cB8O+raM89XFdl2Wx3LMETXF8xiWCnaT1vuzXyjG564AyDsUpHmiB+vkGpVzgFkdrV
         ICGNSZAJgLG/mB+43zEJ3IaA3jkXhyzGetuvrU1/5rMoDUivtv3ukw1OhLKoTe0TTr2w
         uhssekHw+Ik3E8BuAWRu/AK6fcbzrLs2udCjeyb2WoGimbmfW4PqBeDp0fiUKTZmOvxU
         gRWnO8KEncF6z8OvUDBbhCnsHp+HHFUk6qOwaBIBMwQlXcY7N0iSdhmTqD1G3IMKxwNM
         R8dWEnz7A46olmsX2kZ1WURXDLbyduqLvRGtkBsMv8fyArEbVxhuxIqFWKg5pU7GlgL7
         VFmg==
X-Gm-Message-State: AOJu0YwQ5KZWDmjt5wlY2htaSumgT/X0s3o8tlJgiQgmbXLsaUN7HPWN
	8Fjz1OUwdgA2I8p75CTI/HCDvT3NSfO0/dtte0AeZpHxLSpoMnpF0yEf
X-Gm-Gg: ASbGnctrU5X4fuqpWoUEc+f4omXB9tiog7vdzI1I6T9PLgDgCqsHs5Wj+uF0MtAgCVW
	vt6ZnymsE+Mnhdv+FvbAKG7gSxE8mrMPdYYaPExYEdzxT/4mmGFfut8Xk9CWyrOyljXnz9ALpp/
	BWZpV2n9B1wEq7VcaTLH/8em8WwVtQ9rcLerd+55Ewr1Czx4h4Im+XE06pKelsKsfn81NT4VWYb
	PHuxKLy3lWWY4X/j9H2QCpDdClh+yi7adZoQF741kDa0az5Shkz8bG/BY1dPVNHSY+puc+/287G
	Elv9byBKHRkPCkOvGY8SvD/oBcxrkirhjD0RVMFvWrLQ1VUltBtvM4sDI1cUsJSSScaN8ZJo6og
	JxngaWVhvtpgsCLklRYE=
X-Google-Smtp-Source: AGHT+IEiZCk//3KnZJ9QFraR8/9r40L9GjGgn7adTJxnnP/o4rKsmZ4SlZHA8YvdjcwS+Khc00ipDg==
X-Received: by 2002:a05:622a:43:b0:476:add4:d2b6 with SMTP id d75a77b69052e-494ae339167mr4150621cf.1.1747339179131;
        Thu, 15 May 2025 12:59:39 -0700 (PDT)
Received: from [192.168.124.1] (syn-067-243-142-039.res.spectrum.com. [67.243.142.39])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-494ae4fd80bsm1957231cf.56.2025.05.15.12.59.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 May 2025 12:59:38 -0700 (PDT)
From: Connor Abbott <cwabbott0@gmail.com>
Date: Thu, 15 May 2025 15:58:44 -0400
Subject: [PATCH v6 2/7] iommu/arm-smmu: Move handing of RESUME to the
 context fault handler
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250515-msm-gpu-fault-fixes-next-v6-2-4fe2a583a878@gmail.com>
References: <20250515-msm-gpu-fault-fixes-next-v6-0-4fe2a583a878@gmail.com>
In-Reply-To: <20250515-msm-gpu-fault-fixes-next-v6-0-4fe2a583a878@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1747339176; l=5231;
 i=cwabbott0@gmail.com; s=20240426; h=from:subject:message-id;
 bh=yKFBdsoANpail9eN0dLOxr2jAWKJ9zute64DqhO2lxc=;
 b=tuXpSyUWL02D4yi11LDbI98odEa/K1GIb7KgJHtYoH2rfOsfAexwNEoBtysuOMrgQmJQBgNIq
 7yU62f0j+OqDJs/HwcLdtj+Mw72LGRQBJhNrGx5ApqAFYflwvH73z4v
X-Developer-Key: i=cwabbott0@gmail.com; a=ed25519;
 pk=dkpOeRSXLzVgqhy0Idr3nsBr4ranyERLMnoAgR4cHmY=

The upper layer fault handler is now expected to handle everything
required to retry the transaction or dump state related to it, since we
enable threaded IRQs. This means that we can take charge of writing
RESUME, making sure that we always write it after writing FSR as
recommended by the specification.

The iommu handler should write -EAGAIN if a transaction needs to be
retried. This avoids tricky cross-tree changes in drm/msm, since it
never wants to retry the transaction and it already returns 0 from its
fault handler. Therefore it will continue to correctly terminate the
transaction without any changes required.

devcoredumps from drm/msm will temporarily be broken until it is fixed
to collect devcoredumps inside its fault handler, but fixing that first
would actually be worse because MMU-500 ignores writes to RESUME unless
all fields of FSR (except SS of course) are clear and raises an
interrupt when only SS is asserted. Right now, things happen to work
most of the time if we collect a devcoredump, because RESUME is written
asynchronously in the fault worker after the fault handler clears FSR
and finishes, although there will be some spurious faults, but if this
is changed before this commit fixes the FSR/RESUME write order then SS
will never be cleared, the interrupt will never be cleared, and the
whole system will hang every time a fault happens. It will therefore
help bisectability if this commit goes first.

I've changed the TBU path to also accept -EAGAIN and do the same thing,
while keeping the old -EBUSY behavior. Although the old path was broken
because you'd get a storm of interrupts due to returning IRQ_NONE that
would eventually result in the interrupt being disabled, and I think it
was dead code anyway, so it should eventually be deleted. Note that
drm/msm never uses TBU so this is untested.

Signed-off-by: Connor Abbott <cwabbott0@gmail.com>
---
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom-debug.c |  9 +++++++++
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c       | 14 --------------
 drivers/iommu/arm/arm-smmu/arm-smmu.c            |  6 ++++++
 3 files changed, 15 insertions(+), 14 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom-debug.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom-debug.c
index 548783f3f8e89fd978367afa65c473002f66e2e7..3e0c2c7c639b0c09243578ebb95129398c630ef2 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom-debug.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom-debug.c
@@ -406,6 +406,12 @@ irqreturn_t qcom_smmu_context_fault(int irq, void *dev)
 			arm_smmu_print_context_fault_info(smmu, idx, &cfi);
 
 		arm_smmu_cb_write(smmu, idx, ARM_SMMU_CB_FSR, cfi.fsr);
+
+		if (cfi.fsr & ARM_SMMU_CB_FSR_SS) {
+			arm_smmu_cb_write(smmu, idx, ARM_SMMU_CB_RESUME,
+					  ret == -EAGAIN ? 0 : ARM_SMMU_RESUME_TERMINATE);
+		}
+
 		return IRQ_HANDLED;
 	}
 
@@ -416,6 +422,9 @@ irqreturn_t qcom_smmu_context_fault(int irq, void *dev)
 	if (!tmp || tmp == -EBUSY) {
 		ret = IRQ_HANDLED;
 		resume = ARM_SMMU_RESUME_TERMINATE;
+	} else if (tmp == -EAGAIN) {
+		ret = IRQ_HANDLED;
+		resume = 0;
 	} else {
 		phys_addr_t phys_atos = qcom_smmu_verify_fault(smmu_domain, cfi.iova, cfi.fsr);
 
diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
index 2b21b7208bc7b439d69e36ca678acd2eacbd5b85..d71404ad90376b2c258d67e07ec380674961a429 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
@@ -86,19 +86,6 @@ static void qcom_adreno_smmu_set_stall(const void *cookie, bool enabled)
 		qsmmu->stall_enabled &= ~BIT(cfg->cbndx);
 }
 
-static void qcom_adreno_smmu_resume_translation(const void *cookie, bool terminate)
-{
-	struct arm_smmu_domain *smmu_domain = (void *)cookie;
-	struct arm_smmu_cfg *cfg = &smmu_domain->cfg;
-	struct arm_smmu_device *smmu = smmu_domain->smmu;
-	u32 reg = 0;
-
-	if (terminate)
-		reg |= ARM_SMMU_RESUME_TERMINATE;
-
-	arm_smmu_cb_write(smmu, cfg->cbndx, ARM_SMMU_CB_RESUME, reg);
-}
-
 #define QCOM_ADRENO_SMMU_GPU_SID 0
 
 static bool qcom_adreno_smmu_is_gpu_device(struct device *dev)
@@ -238,7 +225,6 @@ static int qcom_adreno_smmu_init_context(struct arm_smmu_domain *smmu_domain,
 	priv->set_ttbr0_cfg = qcom_adreno_smmu_set_ttbr0_cfg;
 	priv->get_fault_info = qcom_adreno_smmu_get_fault_info;
 	priv->set_stall = qcom_adreno_smmu_set_stall;
-	priv->resume_translation = qcom_adreno_smmu_resume_translation;
 
 	return 0;
 }
diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/arm-smmu/arm-smmu.c
index ade4684c14c9b2724a71e2457288dbfaf7562c83..90a1b23223b4c25cfa033c28a2823e60e8b0c5a4 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
@@ -470,6 +470,12 @@ static irqreturn_t arm_smmu_context_fault(int irq, void *dev)
 		arm_smmu_print_context_fault_info(smmu, idx, &cfi);
 
 	arm_smmu_cb_write(smmu, idx, ARM_SMMU_CB_FSR, cfi.fsr);
+
+	if (cfi.fsr & ARM_SMMU_CB_FSR_SS) {
+		arm_smmu_cb_write(smmu, idx, ARM_SMMU_CB_RESUME,
+				  ret == -EAGAIN ? 0 : ARM_SMMU_RESUME_TERMINATE);
+	}
+
 	return IRQ_HANDLED;
 }
 

-- 
2.47.1

