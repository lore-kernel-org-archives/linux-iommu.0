Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92AA430FF39
	for <iommu@lists.linux.dev>; Mon, 17 Nov 2025 19:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763406899; cv=none; b=TCMeeQt9fFaIvkLDyF40Z2mCZQXzD3MfH2FKD78rT1RxhzA6+FUIsVx4YG7tDierGxZXdjr5YX6RC9k66AArd9pkFq9QkI1QkA7bS/cTLXlOWDZ/5Wfz2e+uK+EOqL+esIdQUFd2KV5HCdJE29aUy7/4r1FvTjLVotmtBHpnhfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763406899; c=relaxed/simple;
	bh=xgUqfpMH5KHohjDhI+emL9sOHeq0XA3tjwAxISXx9sg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hVO6++KVnK2+ZLZgmdhsOcIgQ0D+gSbkhYN2OXbz1eXLIl7Bi1+vrwg2Ablclb6Xzp61DtpPyFUYri3GytQMBLO+TUNn5UF6q+SZCRqL4UnrXdBLpXgXQfMbHgDAX+8cs5vqZjA/NNHUHB2qRhg695OEMXjrJ++eJ6ozob43aBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yMukBmI3; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yMukBmI3"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-34374bfbcccso4750390a91.0
        for <iommu@lists.linux.dev>; Mon, 17 Nov 2025 11:14:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763406897; x=1764011697; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=YGvXiu04e7RqET/r6yRIWNCwdZFZHkDsjYP5CALCVb8=;
        b=yMukBmI3Vlv5Z36IgS0G6UsCzayJ3R24dDxuHkYf7Ru158ffY5Q10TRNXaNlpEd7TW
         fLfQxnD1GJ0kcAr+6dgYsH+ix2CvFwkPxzTyQz1AxZoW3T3lwl9EybQvkkpnwWjELW/F
         oSWk/HcPrVlhuJSGGJ38gD9cKYy8xOqrhh34wQxRqKS0wswiVu+TTmAFQaDbSwNt60fD
         5CjMpvDeeQvt3QrEJYIvSSpK0CbnBFYV4ESmX2lSK07rsivSi3vbeyqCUSdussk7krJy
         97M/fgQPJGm8DZfKegsCtPdsBTHMWLIDOBsc6B0DrCZAqt3g5QF8f5k/FDyInAVP63Ww
         cWmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763406897; x=1764011697;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YGvXiu04e7RqET/r6yRIWNCwdZFZHkDsjYP5CALCVb8=;
        b=TIcC5sJKyfSHCwwVg9oW0O8Z/n3iN2jAPIwW7JN31O5SKhoDHOl+3nn6tk7Wo6Tby3
         j0th22DoyX1Vs/brDbGYqMQXDcUqWUIED2FOQTm1MbmZ8gufrqcC7ZkwdKdsxz8kM6nR
         ZlZLb+AF2XSXd68e5UPo6iEM/jZ09OZPI9oVVwhFVF/sZPn5pozlUlt8ndAfKVBVmavJ
         6/ojdgjAz3SvQGOouK500fNTCopmz6H9SkhF4ns+CYZwEmbDenYKKDwI9LB1K4fMUwiP
         9YOR2AeMwcZB3b40MxJYwmbrv+GiUFmgoqS8dUlDBBgevu4hKova49XkwmVZiRyyAfac
         A+FQ==
X-Gm-Message-State: AOJu0YwSAtjUJAia//6/wB71XwAstm9xQTceVRjib124JiGZOGS2Vn2b
	KaSmQy/3TUjOAsD/w06P9fWLWEZgMGXVOaBVglwLnVVG9FR41IcHAmuONeRyY9GE5O1Rr5FiQSn
	Uwm3yEqHWfa3sgCpZ/GWteFNDH8dxoe3WDf9lEi8eJF4EmfgLZP0/bPpNEtvJYILvM+yFdhHbjT
	NNRxrHjI0Q6aBoXGsEI2rPyRGGP7hwIQ==
X-Google-Smtp-Source: AGHT+IHmPU84l05r6iZM3j1tacxoenQu1pybDrFz2N41lupvuASgER4Jq3wdeQJJK/juqBrq+srOZn1vLA==
X-Received: from pjbtb7.prod.google.com ([2002:a17:90b:53c7:b0:33e:384c:7327])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1348:b0:340:bb64:c5e
 with SMTP id 98e67ed59e1d1-343f9ea41b3mr14514180a91.14.1763406896607; Mon, 17
 Nov 2025 11:14:56 -0800 (PST)
Date: Mon, 17 Nov 2025 19:14:26 +0000
In-Reply-To: <20251117191433.3360130-1-praan@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20251117191433.3360130-1-praan@google.com>
X-Mailer: git-send-email 2.52.0.rc1.455.g30608eb744-goog
Message-ID: <20251117191433.3360130-2-praan@google.com>
Subject: [PATCH v4 1/8] iommu/arm-smmu-v3: Refactor arm_smmu_setup_irqs
From: Pranjal Shrivastava <praan@google.com>
To: iommu@lists.linux.dev
Cc: Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>, 
	Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>, Mostafa Saleh <smostafa@google.com>, 
	Nicolin Chen <nicolinc@nvidia.com>, Daniel Mentz <danielmentz@google.com>, 
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
index 2a8b46b948f0..c5efd9713775 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -4035,14 +4035,32 @@ static void arm_smmu_setup_unique_irqs(struct arm_smmu_device *smmu)
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
@@ -4064,15 +4082,6 @@ static int arm_smmu_setup_irqs(struct arm_smmu_device *smmu)
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
 
@@ -4215,11 +4224,8 @@ static int arm_smmu_device_reset(struct arm_smmu_device *smmu)
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
@@ -4818,6 +4824,13 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
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
2.52.0.rc1.455.g30608eb744-goog

