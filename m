Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DEB420C037
	for <iommu@lists.linux.dev>; Fri, 18 Apr 2025 23:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745019283; cv=none; b=cHFcO6G4tDIWws5m9yZsNXdyaX2Dl8/kWEV0lt/IN45jVwWNrNzogvfkWC953DeghS29W5amnfMnRJNh5fulWiSSe9SU1lLlLBiKEfVxVE49DlTGpbqgI3oGnWF50z9b4k/ey/djoXAuAxnHa7FOODpeiO5QA+xvKT5PrTRpfEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745019283; c=relaxed/simple;
	bh=xLWa7xu/alUXOgsiSBN7FWqszPfj1CVRul9JSyiv8i0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=IGtJSUTTbQ26ZjQuozY8wj6SqItaAJ49LX6T6UjelYUv4TA+hQIjLrgMlD9yT2AoqxpRMaQieBHGZ0Tw/BxnvNaopUx4vNihu0wXWtloVWVduip0L6xzmegXZ+u2aoa6rElXisIkJ/ju1ydGtLosL2TzZl6YYEuI3ks0o9GogzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LSnRcfg6; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LSnRcfg6"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2241e7e3addso20910115ad.1
        for <iommu@lists.linux.dev>; Fri, 18 Apr 2025 16:34:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745019280; x=1745624080; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=IfZnQErzs8MW0EMlKzyGO1305RJ5eJL/i3i+9xyOEp8=;
        b=LSnRcfg6U1klpg1HSZJ2LuD3swWU2wA791odGDI+xpPF/mAs/b6IqUuqMMJ0MePoEy
         KhOpXpkepB9Qa/7d8oeMVRhWzfTGJmAiP2NBI1fiKGTxGyVucVC82h1fs1QlCGyZtKe3
         l8s99WbYRGRxAATBcuWFfwAcHTu/XR1/Tow07TX1ieUq/8fexAz+JaHcyI6NAeJE88Ei
         50XfXUSqDdSLq48xA6M4xwdHPU8BDsUdqTtuUuJQ96CSHoWOPgoPr2fBtUaY5zzlHL9h
         LR62ZJaY6K72/rH0RysdQsNGqaXgodeqLvkql3XoVuDrSOxNQtwdmLnH6tz77Rr7zXpZ
         sm6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745019280; x=1745624080;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IfZnQErzs8MW0EMlKzyGO1305RJ5eJL/i3i+9xyOEp8=;
        b=JLvLXyGbvZDFCDALoSaO0DFBp9yUyLhwlB8juLeorxHp0ROcd90xJyGiXpL+32kRWI
         DoHmvy/rGuou1yogfVDwhIyrXaPz2Dna6ZSIW6199nnRnKCkUeqbocNzJ2KApaga9ZWY
         /TMEd17+85xt3IQ8PZZSzYJGGZvbR0pId7relSeSqnnFDKH3+Y6ss770vDh886CFUfzZ
         MQJK6el9QvWhSTQeLqIyiQcMgtucriVVEpna/m571mmx8pUBRdmitecrIXzbt9/0D+Q7
         W5EB/6ZYT3qx/80A/SjiM1xZx3MNBePGFzpxPFG2HSee69fGxMCuLWUvCtqQTVLZ1naT
         tAmg==
X-Forwarded-Encrypted: i=1; AJvYcCXDc2jNbLOmhTwlFb0u0QHNQIK1e7fLQpwOMKspBpvQiSzI4vrisHjohqhpmR/0OHnah43PmA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzEUfxlJ/1EFEajy1FNWtiAqB/lecpGRLZN8m4v1t567usTb6yW
	4qa0By4cFgeL08Au44BuJnATv6VfcxazBdeoVIHtqLdNxnmeo7q63KAjKsPWf40UPJqoaOWadg=
	=
X-Google-Smtp-Source: AGHT+IH1q23r4/AmgowMLbi6o3H+G/2ZJXSI2sud1G2lrqcYQsIs5If5C6avS3DRa8zYbsLyNxLJ9Jp+0A==
X-Received: from pjbnb12.prod.google.com ([2002:a17:90b:35cc:b0:2ea:5084:5297])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:cec1:b0:227:e980:9190
 with SMTP id d9443c01a7336-22c53626a1amr56307335ad.44.1745019279724; Fri, 18
 Apr 2025 16:34:39 -0700 (PDT)
Date: Fri, 18 Apr 2025 23:34:00 +0000
In-Reply-To: <20250418233409.3926715-1-praan@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250418233409.3926715-1-praan@google.com>
X-Mailer: git-send-email 2.49.0.805.g082f7c87e0-goog
Message-ID: <20250418233409.3926715-2-praan@google.com>
Subject: [RFC PATCH v2 01/10] iommu/arm-smmu-v3: Refactor arm_smmu_setup_irqs
From: Pranjal Shrivastava <praan@google.com>
To: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>
Cc: Nicolin Chen <nicolinc@nvidia.com>, Mostafa Saleh <smostafa@google.com>, 
	Daniel Mentz <danielmentz@google.com>, iommu@lists.linux.dev, 
	Pranjal Shrivastava <praan@google.com>
Content-Type: text/plain; charset="UTF-8"

Refactor arm_smmu_setup_irqs by splitting it into two parts, one for
registering interrupt handlers and the other one for enabling interrupt
generation in the hardware. This refactor helps in re-initialization of
hardware interrupts as part of a subsequent patch that enables runtime
power management for the arm-smmu-v3 driver.

Signed-off-by: Pranjal Shrivastava <praan@google.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 54 ++++++++++++++-------
 1 file changed, 37 insertions(+), 17 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index b4c21aaed126..c295837b20a1 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -4009,12 +4009,24 @@ static void arm_smmu_setup_unique_irqs(struct arm_smmu_device *smmu)
 	}
 }
 
-static int arm_smmu_setup_irqs(struct arm_smmu_device *smmu)
+static void arm_smmu_enable_irqs(struct arm_smmu_device *smmu)
 {
-	int ret, irq;
+	int ret;
 	u32 irqen_flags = IRQ_CTRL_EVTQ_IRQEN | IRQ_CTRL_GERROR_IRQEN;
 
-	/* Disable IRQs first */
+	if (smmu->features & ARM_SMMU_FEAT_PRI)
+		irqen_flags |= IRQ_CTRL_PRIQ_IRQEN;
+
+	ret = arm_smmu_write_reg_sync(smmu, irqen_flags,
+				      ARM_SMMU_IRQ_CTRL, ARM_SMMU_IRQ_CTRLACK);
+	if (ret)
+		dev_warn(smmu->dev, "failed to enable irqs\n");
+}
+
+static int arm_smmu_disable_irqs(struct arm_smmu_device *smmu)
+{
+	int ret;
+
 	ret = arm_smmu_write_reg_sync(smmu, 0, ARM_SMMU_IRQ_CTRL,
 				      ARM_SMMU_IRQ_CTRLACK);
 	if (ret) {
@@ -4022,6 +4034,19 @@ static int arm_smmu_setup_irqs(struct arm_smmu_device *smmu)
 		return ret;
 	}
 
+	return 0;
+}
+
+static int arm_smmu_setup_irqs(struct arm_smmu_device *smmu)
+{
+	int ret, irq;
+
+	/* Disable IRQs first */
+	ret = arm_smmu_disable_irqs(smmu);
+
+	if (ret)
+		return ret;
+
 	irq = smmu->combined_irq;
 	if (irq) {
 		/*
@@ -4038,15 +4063,6 @@ static int arm_smmu_setup_irqs(struct arm_smmu_device *smmu)
 	} else
 		arm_smmu_setup_unique_irqs(smmu);
 
-	if (smmu->features & ARM_SMMU_FEAT_PRI)
-		irqen_flags |= IRQ_CTRL_PRIQ_IRQEN;
-
-	/* Enable interrupt generation on the SMMU */
-	ret = arm_smmu_write_reg_sync(smmu, irqen_flags,
-				      ARM_SMMU_IRQ_CTRL, ARM_SMMU_IRQ_CTRLACK);
-	if (ret)
-		dev_warn(smmu->dev, "failed to enable irqs\n");
-
 	return 0;
 }
 
@@ -4189,11 +4205,8 @@ static int arm_smmu_device_reset(struct arm_smmu_device *smmu)
 		}
 	}
 
-	ret = arm_smmu_setup_irqs(smmu);
-	if (ret) {
-		dev_err(smmu->dev, "failed to setup irqs\n");
-		return ret;
-	}
+	/* Enable interrupt generation on the SMMU */
+	arm_smmu_enable_irqs(smmu);
 
 	if (is_kdump_kernel())
 		enables &= ~(CR0_EVTQEN | CR0_PRIQEN);
@@ -4778,6 +4791,13 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
 	/* Check for RMRs and install bypass STEs if any */
 	arm_smmu_rmr_install_bypass_ste(smmu);
 
+	/* Setup interrupt handlers */
+	ret = arm_smmu_setup_irqs(smmu);
+	if (ret) {
+		dev_err(smmu->dev, "failed to setup irqs\n");
+		goto err_free_iopf;
+	}
+
 	/* Reset the device */
 	ret = arm_smmu_device_reset(smmu);
 	if (ret)
-- 
2.49.0.805.g082f7c87e0-goog

