Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39FC718FDAB
	for <iommu@lists.linux.dev>; Mon, 16 Jun 2025 20:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750105941; cv=none; b=B1qCIpUVl/kmc9Fn7X4cnYnFPWQ6duspYmIiDEEbQ19M15LT4ME9wasjVITfykwg7wBXRDKicrQXlvlr/uBWre5uQtxsJ9t/NOlBXiznWIOgPyEJ3t68rEObiJxDbX03FI7AkKaLFwLX8+svSZW0vMR+Hl4D1k+id8ZOfH8hJes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750105941; c=relaxed/simple;
	bh=fBvWi4pFR2T41k9euCMuzRTjjYr1tMugdUu5Ch0mPvI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=MCvzoRXm/10MBgsWkZq5tA7ztTUpxP/FuP3V8EZOhcubo6ainHX7O2zmH2PTR4pxodUAYag/GEdpe9EaqExDZDMMpRXZKtJCRzPQGYriy54003XP0pnD9Ay1LWi0FvugRi91PxSdz5Tc9EGrT4oS1gMDqeOut70ytZ36iGOcSA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wtohzWo7; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wtohzWo7"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-7394772635dso3526591b3a.0
        for <iommu@lists.linux.dev>; Mon, 16 Jun 2025 13:32:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750105939; x=1750710739; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=mX7B9G8+EveHxktt/hXXfRgblm2Z+OTppEoxlub0uCc=;
        b=wtohzWo7wQGX9u7LzeofRdk5FKLIoJCt167+zbhiGFieX4H9fsc6EjgcKCAovwH8H5
         2lSfoLgq5sqtTEIYUV9vYA7XjTztYUYYepGJj6mr+DwMze0gJR7hG8xaNy0t5t0lx7Nn
         pD9vQyLjoX0JXqfX7yr4W77zPv6h0tVjqGVpvlBw7327LhoUKRHrTNakmnIqyNXKh+lq
         Caf6/xM/Gd9mmaSSwmirguenvqFyicRtvhAc4dhBoR2Jr7WkkZWsyAy0f+QT7D5l5uj7
         vnjAz7IMKcwuKyR/TwbLeCEjZhAKBApa6LeL5i6DHESHLvtKSEZn9wiVdqr04vjkj9ob
         Sogw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750105939; x=1750710739;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mX7B9G8+EveHxktt/hXXfRgblm2Z+OTppEoxlub0uCc=;
        b=YbtEFNCOZ9eawQ8ccOuCz3KfxVK/d6SwVfKTv9jA6XHmAZkYaA58z2y4Ijpb6kYi4s
         /7jmiQetXezpzrk3sIgI99vFS89+9JSopJVAeoA6g+rT1IYY4S4/MPotePf9615i/hHA
         Oq8/AwjoQG3RI9U7qM4xEfx9/V6b+2VAYQ6bJLm2jhJdP8Rpo7DBQxXmh9bEEJVRaSd2
         y0jKmsmbefWyjbqE2gN0dhlK8ZZRPL7ZWatcWR+tAmWA2v3q86M4KyqW+So7a6ocx/nD
         CFCJgkmOtzlwrYe/l3jbNyfRecKgprSg78mO7gkOtIwXtn/7jQnrDfgsX7ShKamPI/59
         a+MQ==
X-Forwarded-Encrypted: i=1; AJvYcCVYesvTASkuv6iwh9+JrIN2/r8UfHGXmw+lhLs8PpWHXERvO3eh5FI8QnkVeTZQPJH0CTnqQA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzdx14cByCdmKEUHeO65jPYgwxjlp4KL4d7aEQqGWk4YtNUwjTX
	K1eDkq+2Z82a5OVxZ8GzXjDKdj9PZWOtuhAQtweS+l1xitDAczbVje4yR2jSMMtKidJsCu1vUzf
	tMQ==
X-Google-Smtp-Source: AGHT+IGAtQy1DjAp0D2jj8esOaGogqTdlDy8RG8aCVa3b/6siaWa68Ktfr8mJDw32gKdrFIghgpX9VNilw==
X-Received: from pfbjr36.prod.google.com ([2002:a05:6a00:9164:b0:746:257b:1d37])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:b4d:b0:746:27fc:fea9
 with SMTP id d2e1a72fcca58-7489cfff3e5mr13067624b3a.11.1750105939469; Mon, 16
 Jun 2025 13:32:19 -0700 (PDT)
Date: Mon, 16 Jun 2025 20:31:42 +0000
In-Reply-To: <20250616203149.2649118-1-praan@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250616203149.2649118-1-praan@google.com>
X-Mailer: git-send-email 2.50.0.rc2.692.g299adb8693-goog
Message-ID: <20250616203149.2649118-2-praan@google.com>
Subject: [RFC PATCH v3 1/8] iommu/arm-smmu-v3: Refactor arm_smmu_setup_irqs
From: Pranjal Shrivastava <praan@google.com>
To: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	"Rafael J. Wysocki" <rafael@kernel.org>
Cc: Nicolin Chen <nicolinc@nvidia.com>, Mostafa Saleh <smostafa@google.com>, 
	Daniel Mentz <danielmentz@google.com>, iommu@lists.linux.dev, 
	Pranjal Shrivastava <praan@google.com>
Content-Type: text/plain; charset="UTF-8"

Refactor arm_smmu_setup_irqs by splitting it into two parts, one for
registering interrupt handlers and the other one for enabling interrupt
generation in the hardware. This refactor helps in re-initialization of
hardware interrupts as part of a subsequent patch that enables runtime
power management for the arm-smmu-v3 driver.

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Pranjal Shrivastava <praan@google.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 53 ++++++++++++++-------
 1 file changed, 36 insertions(+), 17 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index f50c26596416..f19a77708d2c 100644
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
@@ -4022,6 +4034,18 @@ static int arm_smmu_setup_irqs(struct arm_smmu_device *smmu)
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
+	if (ret)
+		return ret;
+
 	irq = smmu->combined_irq;
 	if (irq) {
 		/*
@@ -4038,15 +4062,6 @@ static int arm_smmu_setup_irqs(struct arm_smmu_device *smmu)
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
 
@@ -4189,11 +4204,8 @@ static int arm_smmu_device_reset(struct arm_smmu_device *smmu)
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
@@ -4778,6 +4790,13 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
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
2.50.0.rc2.692.g299adb8693-goog

