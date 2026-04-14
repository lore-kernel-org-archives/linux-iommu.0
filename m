Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FF1A2853FD
	for <iommu@lists.linux.dev>; Tue, 14 Apr 2026 19:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776196037; cv=none; b=NndrokxV23ZRVxfAystNU3nYmhShlaP1eDmhNMSPqQqEmTSfccb/WGkJ9TKIzhtNIYNHNWnAibw2MAr0FQA8FUjwd/h7k9gXoL0YTjMCHUNepraAgI0XNim+NaFXJZh0SHytMskukn2/39VtyAt3lOgI1sGIiIdkR9cZg67LFSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776196037; c=relaxed/simple;
	bh=qh9wPvya59iwK/kBDSt3Lvu6SRzBuTemuZLxwRgVbTo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=s/zktT5hNAg+tyt3f1areGvHIvofaz9+NIInUG04/Cy042eKznh6rF+4a+uEao5Y9zL0zJkJzbRfK+ejf1AgDISjobD0zc+ynyte+PJYILgmyP5F4JYtKEAdyOAgzGkHhYhT3pLFf2wCm1+CZkXphduh+zeawqTIa0Isk4Wkmkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RA4xaRTY; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RA4xaRTY"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-35da97f6a6dso6226407a91.0
        for <iommu@lists.linux.dev>; Tue, 14 Apr 2026 12:47:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776196035; x=1776800835; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Z8zK+T3xl1OAvpSqdDQK2RPvzKXhJX9ga0+p+8NH+HM=;
        b=RA4xaRTYg2cRApAwcsUmNJY8ubJmbViTh1nCXTQnf1XIXifCpQIaPZ8ErM1DUtD3Gt
         Zha1T6DXgfXIYS6zmMiH3AnsV6uZkDIdWYMirpWwJ5u7ODTorQQoFkbQQyiVe5r2LUU+
         hAxIMo3qmip4Xz0N1b3k/CEmg14dX4Vlc46dzG7ePlihsSAAiswCC2ZHBVLTFqs9FQ+d
         rBV8Y5oEosT7fTfIsXhkz2/aJL1Pvy6RbvKZHfVWNiWGehYUEAAaYET9mVAC4n7BI2tB
         xoXDiByWHSkjb3McrzM9Fg1dYbu6ghG8zhrab8kK4EYnztOEbNJ1ls0A87550tU1OQ2b
         7uYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776196035; x=1776800835;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z8zK+T3xl1OAvpSqdDQK2RPvzKXhJX9ga0+p+8NH+HM=;
        b=k47gPxBrI36uzoM0NfQUJVQuBSMaH8w//TxqV4wda/BFO6YMEhmMFLTMxSeBDOo+BH
         u0uJJw6JirpsyWWwiECAuW9ki85aIkQYV6jsgZS45mH94Gfi17ENWoBJsaafcyUvF1xk
         Gfb7D27AAlwFF+VxXQaQL1AONzUjRznNgFH7aWFfHuXFhbCia5ppNQRWU6Vg71xA9SEA
         GhoVr7GRSnUvZjMMcoIOBJP/1iSnzixbgLfn3B8/2xzKXDu6XiZoOkPdZlqAK4L+rSSa
         MckOpqwwT7ZNY+W9/8CFST6KjEVH1pPDKC9K9bZ5jIcWvrk5pP4gI//ccGMjpoHpDW3L
         m2FQ==
X-Gm-Message-State: AOJu0YwutqG6QHDEJ0ahAtZouYBhVVkXN15pE9mo5NyD+hdTKLn9UeJg
	/CO2TwcZMomYadUddvlKWuQm2ZfmabNxSXOhlUZMoJMXGmWcFRZFK+cJe9jfX0tQVQLGUcs39+R
	kAwOkbgdk36rOsmGliKbzNWae5vKZp0q98P+uqr2pWkQH8rS6Chn/NL1sMJMlAjFX3E3E/3iC/U
	NsPvJ/cEbsNFavKV8iZOCQYSVidBXgPg==
X-Received: from pjbcu2.prod.google.com ([2002:a17:90a:fa82:b0:35e:59f8:af2d])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1e0c:b0:35b:e5ba:c0c8
 with SMTP id 98e67ed59e1d1-35e4289ecc9mr17970325a91.28.1776196035120; Tue, 14
 Apr 2026 12:47:15 -0700 (PDT)
Date: Tue, 14 Apr 2026 19:46:53 +0000
In-Reply-To: <20260414194702.1229094-1-praan@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260414194702.1229094-1-praan@google.com>
X-Mailer: git-send-email 2.54.0.rc0.605.g598a273b03-goog
Message-ID: <20260414194702.1229094-2-praan@google.com>
Subject: [PATCH v6 01/10] iommu/arm-smmu-v3: Refactor arm_smmu_setup_irqs
From: Pranjal Shrivastava <praan@google.com>
To: iommu@lists.linux.dev
Cc: Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>, 
	Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>, Mostafa Saleh <smostafa@google.com>, 
	Nicolin Chen <nicolinc@nvidia.com>, Daniel Mentz <danielmentz@google.com>, 
	Ashish Mhetre <amhetre@nvidia.com>, Pranjal Shrivastava <praan@google.com>
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
index f6901c5437ed..a77e0472e5c0 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -4727,14 +4727,32 @@ static void arm_smmu_setup_unique_irqs(struct arm_smmu_device *smmu)
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
@@ -4756,15 +4774,6 @@ static int arm_smmu_setup_irqs(struct arm_smmu_device *smmu)
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
 
@@ -4907,11 +4916,8 @@ static int arm_smmu_device_reset(struct arm_smmu_device *smmu)
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
@@ -5545,6 +5551,13 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
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
2.54.0.rc0.605.g598a273b03-goog

