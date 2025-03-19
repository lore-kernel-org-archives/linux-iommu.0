Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49154A920
	for <iommu@lists.linux.dev>; Wed, 19 Mar 2025 00:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742344992; cv=none; b=HRyQ7Dtis8q03IUD/QMaszngakW4FGpRHocfmOeCDAO4uL5Z3YhPxipwprrodIR9xQWW45N1mGNgcXjcxVJDQ08wZOzbBaO0TbGNoVvvU8XsJT0rcVqXknAd0RDUtGUqSSm/F93hA8NJmCrcaJ4PB2rNxXz5sQlSaGr44B/Xte4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742344992; c=relaxed/simple;
	bh=VZOyGOowkyDAC2ihIDnWog+HxelXlFZldpFDi+Vls7Y=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=OgkQdrw+yaBIQvzEPQjBFw/DY2mzHwtPGFv4oADk6QMvzW35Tztoa3AmLW5HFVlAyTAIx98SmnXmik3O7ePxRn4JeMO442NI3ODOjFiVJ7zkdqVZ5QXZRJDsbBQZS3vxeauTai04Tm4IHAUcPTwMRxglwNWZM0niVe7P6b2F/kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XNLeKFJu; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XNLeKFJu"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-223a2770b75so116347605ad.1
        for <iommu@lists.linux.dev>; Tue, 18 Mar 2025 17:43:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742344989; x=1742949789; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=8kuGfzvFT4umMCv3Gh3tItjsa0Cp3enOHud8FA+I2wI=;
        b=XNLeKFJumWOdozKo0FYnQRHcedYuabyfxIfD67L86Rvb9nwU+l5KUKtQi9IBpq7xLG
         fhvFTiir8IKbUHkXZdRsHKK9jGKWQmL8rMKPANUPP1m4ZTZboufhC6EyKtY/Ik1UB49a
         x5U9ASKftfQ3jAp3+5k1JkejM95UOYt/yVfR2h8laOyzGM5B+UXrEHcjsb7Xqt9vPMKE
         kqrLDwh1heFMob/vlhZv8hnBBzaE2zYZ73vY3GT5giNQFhktTQtKIlodRk1qFJjZtupU
         m9peqPWDXGjw+B7DtfUdJF14llGVtrbx3LNZd8GFCHYKcVpxJAtOtdKlDKH0Xd8aySM0
         E6cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742344989; x=1742949789;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8kuGfzvFT4umMCv3Gh3tItjsa0Cp3enOHud8FA+I2wI=;
        b=Rxbw5167EA5uL9FXa2pypgx+qc8hKMB92DnJ+ec03GTn6PtEKkwJ3qqZLKcckOcXJa
         QIfrAO0tbiTV5TYPH4usDpT0yVAVgAbfE6z6AHUC+RYzZIHaGK8qHCrkJ1AhvAh03YbN
         oJfybweG+rKHF5QrYgSTtEYV31zgs8xUcVS6ZSNOxbL28Q0bOj9gqSQQjJf2+FVQjJp2
         2TFUqYR1a7JMGtx3lrpYY3YcO/P51b/guJWq/xiylXz41COL/P4jqz1Ezvoqlmv/Na02
         mzJmfOPwzQgB8iYo2mw6Aw0PQ6vSNYcasCAdklRcB9ipUjHxGo1SxHl3YwBVpUne61eb
         bT3g==
X-Forwarded-Encrypted: i=1; AJvYcCWY/1fpAo+f0MyEGP599JUmwB1BmffPlN/gt2Z1jPdiWRcWydP1xfv+KCak6qkT0aVoZHYL4Q==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz5bB+yPkJMoibpeXEd5XVSlP2ZupYjpQawcSnNBqmWrlpv4HVC
	gyppYq/K28ZLJY9a5g3d9JWVIa/kcPJ8LECwD/MEi+07tV6qwSEzZsP+EsXSXxYLsaHhKXtyAQ=
	=
X-Google-Smtp-Source: AGHT+IGBrkhGXpdpzaXjBk3yhT3MwZVd/Bo04c2TXNa4Rl0Seibh1byM9nJBZG0HGClslUrBIv2Y7mD15A==
X-Received: from pfrb11.prod.google.com ([2002:aa7:8ecb:0:b0:736:9c55:9272])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:2e17:b0:736:34ca:dee2
 with SMTP id d2e1a72fcca58-7376d5f149emr1250303b3a.4.1742344989448; Tue, 18
 Mar 2025 17:43:09 -0700 (PDT)
Date: Wed, 19 Mar 2025 00:42:50 +0000
In-Reply-To: <20250319004254.2547950-1-praan@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250319004254.2547950-1-praan@google.com>
X-Mailer: git-send-email 2.49.0.rc1.451.g8f38331e32-goog
Message-ID: <20250319004254.2547950-2-praan@google.com>
Subject: [RFC PATCH 1/5] iommu/arm-smmu-v3: Refactor arm_smmu_setup_irqs
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
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 50 ++++++++++++++++-----
 1 file changed, 38 insertions(+), 12 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 358072b4e293..80362d9f293b 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -3985,12 +3985,24 @@ static void arm_smmu_setup_unique_irqs(struct arm_smmu_device *smmu)
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
@@ -3998,6 +4010,19 @@ static int arm_smmu_setup_irqs(struct arm_smmu_device *smmu)
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
@@ -4014,15 +4039,6 @@ static int arm_smmu_setup_irqs(struct arm_smmu_device *smmu)
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
 
@@ -4171,6 +4187,9 @@ static int arm_smmu_device_reset(struct arm_smmu_device *smmu)
 		return ret;
 	}
 
+	/* Enable interrupt generation on the SMMU */
+	arm_smmu_enable_irqs(smmu);
+
 	if (is_kdump_kernel())
 		enables &= ~(CR0_EVTQEN | CR0_PRIQEN);
 
@@ -4754,6 +4773,13 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
 	/* Check for RMRs and install bypass STEs if any */
 	arm_smmu_rmr_install_bypass_ste(smmu);
 
+	/* Setup interrupt handlers */
+	ret = arm_smmu_setup_irqs(smmu);
+	if (ret) {
+		dev_err(smmu->dev, "failed to setup irqs\n");
+		return ret;
+	}
+
 	/* Reset the device */
 	ret = arm_smmu_device_reset(smmu);
 	if (ret)
-- 
2.49.0.rc1.451.g8f38331e32-goog

