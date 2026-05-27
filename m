Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4487D3C343E
	for <iommu@lists.linux.dev>; Wed, 27 May 2026 22:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779920058; cv=none; b=QZb7q8R9ACPxCH2xMKhVc5vigXnWbNo+wcKmOXINFaHhEVmaIhSQeqVrEoQ3F8J965oqIreMxms1kbUoqIOlPqhxsxjFkOSKz9NoD2RccKTT2QgM1QwIO0hFJmcWL+6hgC5/TtdEvC5lv5f85OhYXhvSMV9WSjJ4687eOTi3wYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779920058; c=relaxed/simple;
	bh=ZeZVWP8wCQHKe1wouVTq07pJzjuLA9Q5J24Ih4oEQ9E=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=KjnacLyemCzzDVnn9Sd0bGoXxwv66LnCbWrxG+9jwVl0ROLGlFM3LL+CqXw8Y2ytssGtwMtJU+QH6v7+EmoOgE2IhH61r6MrtgjSsD9EVYzDxNx1ekOa7M0L7vpKQgQRKmzt7tFlqpwxt+EEjZInCmaEfCEEKQ6G3mHqhcTjPKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=foe2gCie; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="foe2gCie"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2ba224c3ffdso31007535ad.0
        for <iommu@lists.linux.dev>; Wed, 27 May 2026 15:14:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779920055; x=1780524855; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=VNBzpNsHMP9EroVda/kt7Sgk7izqkm+EHVOhUu1fFbM=;
        b=foe2gCiec8D6708iwt35+Fl+ZfuFr5P/Ou0p7d4BaScOe89z79KMQO022c9lHs/voh
         MyX3Uz4Btkq2tDfUWtlxTMDsUn3vE3RH0Xi12HmheuiE3cazve3DKwGg7zy05HUypybg
         ubWWN/nPb8lSNEubGIUfZwtk86Y5W6QmXWtU8tUdV/MlaE/aoYNWRpwPrR/tMqj6SaAH
         9/T3HU+oGNExlwFnZvvZl7B9fSelvoEys5dNoZoXmK4UgnBoKTm3BOTrS2jLCZcdXV0U
         ucIOXhkuveSVK0uaEDy+hcYXpZ0MiqL7N3ibajwVpImWhg3Puv9nXLl6kDYPLgvfsBFW
         1rYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779920055; x=1780524855;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VNBzpNsHMP9EroVda/kt7Sgk7izqkm+EHVOhUu1fFbM=;
        b=bD2+XD8rHfjfje+JUCfBhKq+k6cEbgZ77+mDgzrE00Owq+NcRtRT9IxxIGUosl/B8s
         di8wIGI1fmLV+gYZTpgETDU/RmmB9u9Ryn3isg2lK0E2XMwYwMkR/PQhL81Fc2aGX7tu
         v5F+Njv1FPVAd8P8RF97N8EkoQrKSRp+HsFfDTuh1jMNIlg0N8TZ9CIWxmhOJ5cRxVah
         9FasoaPnr0RaJDrU2yjoGBlBSOsKsLmu7r6ZH6TQmzXfN/j2XYz1U3/tOSwrIS/i+d8O
         gD7RK1Sb93RroWwgBIGPKzbES5UuhCf2fkyi1Gy/FS7gTQ7gSPRh7RVoiQDoVAMwv9S7
         GnYQ==
X-Gm-Message-State: AOJu0YycWgWeNdNy+gFbg5m2Xi6DHKOJyfAX1B+IN1ZqSWSkWQL/fRkB
	tzY4IYed/u3B1QJQmR+rjsPCYgEJjNmnYjtg3zvLsnNrYQgd1c9kryrZrbm1oh5Uc3dhZI912n7
	/rjeq0f8PM96FvZovhsJLbY+RZ64zKTOZ2LAwanch6GMh/Qf8qUUrlX8nXigA1qY8Ax8slWWt9d
	YU6AmVZO48PDhq+e6EZt3HsSDYLaL43A==
X-Received: from plbjc6.prod.google.com ([2002:a17:903:25c6:b0:2bd:9b10:8067])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:24c:b0:2b9:fb0b:b727
 with SMTP id d9443c01a7336-2beb0675f69mr259357035ad.39.1779920054234; Wed, 27
 May 2026 15:14:14 -0700 (PDT)
Date: Wed, 27 May 2026 22:13:57 +0000
In-Reply-To: <20260527221407.1756491-1-praan@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260527221407.1756491-1-praan@google.com>
X-Mailer: git-send-email 2.54.0.794.g4f17f83d09-goog
Message-ID: <20260527221407.1756491-2-praan@google.com>
Subject: [PATCH v7 01/11] iommu/arm-smmu-v3: Refactor arm_smmu_setup_irqs
From: Pranjal Shrivastava <praan@google.com>
To: iommu@lists.linux.dev
Cc: Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>, 
	Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>, Mostafa Saleh <smostafa@google.com>, 
	Nicolin Chen <nicolinc@nvidia.com>, Daniel Mentz <danielmentz@google.com>, 
	Ashish Mhetre <amhetre@nvidia.com>, linux-arm-kernel@lists.infradead.org, 
	Pranjal Shrivastava <praan@google.com>
Content-Type: text/plain; charset="UTF-8"

Refactor arm_smmu_setup_irqs by splitting it into two parts, one for
registering interrupt handlers and the other one for enabling interrupt
generation in the hardware. This refactor helps in re-initialization of
hardware interrupts as part of a subsequent patch that enables runtime
power management for the arm-smmu-v3 driver.

Reviewed-by: Mostafa Saleh <smostafa@google.com>
Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Pranjal Shrivastava <praan@google.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 47 +++++++++++++--------
 1 file changed, 30 insertions(+), 17 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 8ce3e801eda3..3dad2c2d3283 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -4601,14 +4601,32 @@ static void arm_smmu_setup_unique_irqs(struct arm_smmu_device *smmu)
 	}
 }
 
+static void arm_smmu_enable_irqs(struct arm_smmu_device *smmu)
+{
+	int ret;
+	u32 irqen_flags = IRQ_CTRL_EVTQ_IRQEN | IRQ_CTRL_GERROR_IRQEN;
+
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
+	return arm_smmu_write_reg_sync(smmu, 0, ARM_SMMU_IRQ_CTRL,
+				       ARM_SMMU_IRQ_CTRLACK);
+}
+
 static int arm_smmu_setup_irqs(struct arm_smmu_device *smmu)
 {
 	int ret, irq;
-	u32 irqen_flags = IRQ_CTRL_EVTQ_IRQEN | IRQ_CTRL_GERROR_IRQEN;
 
 	/* Disable IRQs first */
-	ret = arm_smmu_write_reg_sync(smmu, 0, ARM_SMMU_IRQ_CTRL,
-				      ARM_SMMU_IRQ_CTRLACK);
+	ret = arm_smmu_disable_irqs(smmu);
 	if (ret) {
 		dev_err(smmu->dev, "failed to disable irqs\n");
 		return ret;
@@ -4630,15 +4648,6 @@ static int arm_smmu_setup_irqs(struct arm_smmu_device *smmu)
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
 
@@ -4779,11 +4788,8 @@ static int arm_smmu_device_reset(struct arm_smmu_device *smmu)
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
@@ -5417,6 +5423,13 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
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
2.54.0.794.g4f17f83d09-goog

