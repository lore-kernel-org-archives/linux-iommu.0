Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E214384CDB
	for <iommu@lists.linux.dev>; Mon,  1 Jun 2026 21:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780351156; cv=none; b=tmC9c4QhGx+TY+F/U3xOIXBSyN5x8BJR6eL2OA+2eSvHTk7O2W1f0D/BLtiDacTq4er3PEwLwZnd0/uh8gRXjuUhyEr6ax/Or+RNfCoV0AbUQvl5AbPdS5IXBJqmcBtvSfiE1aghsA2S41feGCYtUSWFSB6nVbV1ObHpY7Q7bqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780351156; c=relaxed/simple;
	bh=x1ZqV4b9R2qwUOKBq1ITtcC9mMvts/dkNE9aJjIjoHM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qGAwDq42TRXTKDMWPqjKRa6Rv9LaYt87EJO2Ccv1rnKEWIjUGnm2cT+Hvc3jLRLSGReEQO8Nk5lt7rAfljGyJ6LXicFV83D5Y+kUDkvLqf4vLsguFN5o8qO7Xevg4D39wI6PSS3qcVYPfF6Pqwi5EBszlB8GDCobibqq/tlBaCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tUrdiN23; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tUrdiN23"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2c0bfcd629eso23518265ad.2
        for <iommu@lists.linux.dev>; Mon, 01 Jun 2026 14:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780351154; x=1780955954; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ai+cV1PUAoJFIr5rJA5saMXsoTfCbKkPKE9Leq0NHbo=;
        b=tUrdiN230s+Uk5XUZWEGn/8cB3YVDBWicys1iRXi0C0VH3PSf0e8dnJ+zXW5/fFPaO
         UPyBsxpYRm6wW669R/7aGki0yoKXunIZUrdjabL6vO+D8bKpJ0pgsuwXwA7brpj2xKD4
         C4BfOELZSkGHIWQTdx+6erxQ9lY8bPd7+PRHrweSwRf1UnrzyudqgjAp952BhL3innkC
         t9C2AYUK9LPs/WlZvHHTC7qFo3+ycNdL8AXjvPu10DVGVh3Mg/T1bSwql7xcN3jgDC71
         dcwY7m26gJweculNWRZE6aiMaCYuXPtfMlK7Wv9X4dSbw4TVYlZuq/R0t0zQAZSLqAef
         2QcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780351154; x=1780955954;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ai+cV1PUAoJFIr5rJA5saMXsoTfCbKkPKE9Leq0NHbo=;
        b=jyVeqVDy0dsXU3Whf/LZfu25BD30K290vLUd4ECXp3R7uWne85LKF8DhkzVJlcBNXj
         yer2WphYDhRcdbZnP4yeOLBHsaLL4CzAgNPhaJ8GhVajLuVtVHl6w6ZMZNPuGdIlU838
         doIbe5z2P3mlMHyqCFXuAuLTpX8nZr44QbGhcikpeEvvIuvTcUI7ZIMYQMR6bKa2tM8s
         ah7jUKwvZJkVMwWWxUs1fgo1zsbyYuovVCtX3D5cDFUEe9f1VJQto5w206N0XWCoIikb
         YstgM8ykS8fUqYm/eaZiPLjqnR9/tUD1Fwsz0aSUOshVmKlyhRof0q9voA+hZ2esh2Sa
         LWHg==
X-Gm-Message-State: AOJu0YziOJ0zQSqT33DXhavHr8Ycq09bKaGwySJeTr5VyPNd/GjAUqDG
	CG46hPBgvkn7NGHaTE6wiPXQ4NFR50VxXYhA2iCaEpCppC2s0X/dZ5rHrOv4zoEn98q+LN+3HUK
	waDTgDpYeZ4OZraq2las2ITsZYzZDzi8LuALK9qp1jGw2woKaqzgYVMYKcI7s/WmS0NTKaUYgC/
	JGGORMo1M/SNo+S95/f+KDNgeHLPezGg==
X-Received: from plbna5.prod.google.com ([2002:a17:903:1585:b0:2bf:fd0f:2b0d])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:e78b:b0:2bd:907:2cf0
 with SMTP id d9443c01a7336-2bf36840972mr152023605ad.32.1780351154112; Mon, 01
 Jun 2026 14:59:14 -0700 (PDT)
Date: Mon,  1 Jun 2026 21:58:58 +0000
In-Reply-To: <20260601215909.3958732-1-praan@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260601215909.3958732-1-praan@google.com>
X-Mailer: git-send-email 2.54.0.1013.g208068f2d8-goog
Message-ID: <20260601215909.3958732-2-praan@google.com>
Subject: [PATCH v8 01/12] iommu/arm-smmu-v3: Refactor arm_smmu_setup_irqs
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
2.54.0.1013.g208068f2d8-goog

