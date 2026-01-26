Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2843330D35
	for <iommu@lists.linux.dev>; Mon, 26 Jan 2026 15:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769440326; cv=none; b=KnDvEKz7SskKPB94qu85M4qvt7Q39WO6GdH5jDSd7Ka+S0HbmxlwcU5M0zF5QIzxEgujsrv0gEmKw90gb6uCNU1p2PvdydhRECtrbzTqTs2MKZzwm8Ubt0lrGVJ5cwIALPiNAdiyfIfMto5QnzT9gd4fa0L0l0zsAmCkLs3NZIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769440326; c=relaxed/simple;
	bh=u7N4El14UmV2b/iyyAf/hhqv9R3hP6NiRG2tmJu2KPs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Uo9LQ4cBRVEZsoh13ShQHa/hyDEZIEgsVcN4LTN4p5R0V30Vn+HzxDOTzsT1QGZY2G1WIJDco40fQK8HcnEsfgTDSjw0MtEmt6jchPQ31YuQMKFayR0mgSobD76Hie9SVuFWuqyhtMMLgPUEaQL8XHctr+wqTyseCFTZ0FKbOJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=A8xiKf9d; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="A8xiKf9d"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-34e5a9de94bso9038452a91.0
        for <iommu@lists.linux.dev>; Mon, 26 Jan 2026 07:12:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769440325; x=1770045125; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=bvQZh2uBY+j5AQhREhXPjy6ufuv513yJd5eeIQTfedg=;
        b=A8xiKf9dVPihOFhaowfu0qQJoEa5cWRoDYstYipBmylKJYXRg5I7ronLrA6lzeK6WO
         HSVlQh4jR/e7Ps9h3TE9ZnD3hbjbAerNhx04NOT11zy7nH+3eIDr5/DuT2WiB6npMxG6
         a/g5H2elSiB0ZOANOsmNXMwMvCq6LiSNFuLConPVRuEKK4C3ObG+C3q/uYs8cMZxLi5x
         3nFghN83QTeUWJkw9VZYQEetcdY0kAn/wOzxaHfynvX65FKk3/3l7sqP/gREeVtvIzib
         /pN3QrO2forGH/lMPeCCTFzRizDGA/+4KL4r/13/awIwUvN8IM+2UTZzkxugbibqoC61
         ks0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769440325; x=1770045125;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bvQZh2uBY+j5AQhREhXPjy6ufuv513yJd5eeIQTfedg=;
        b=jAvimSzfg2phRGi30Bz/b7gbqvy/dUpKBx/+jcnJF93WPNwyn2Jgr65SQJuXLQ1IAc
         m0WS/QtPKGEbGSMir31b8bfQio6+tzENvv1QkdgSQTt6ooWOYL3Uydd+WMhsdmWjkIRZ
         5r3ze9krICaQZcWFcNO7BR1RsESttuBEeni/yLiBfIyiWp5POV14fbCYRsSZf7OBMpZ1
         1fMEauibxDqBvur4V1mLx3GLLFCQCSekkPG0JI1qSd649/yHlkurHcx4kPTBe8uUpKGb
         FSF1Azsm+by+dDo3ONxhjuoInvLpqKkFS0vxEgExoNjX0ulmCZk5Z65ibMKWvijbOC4a
         Hyjg==
X-Gm-Message-State: AOJu0YwUE1lXbBg4gok4vWmXQtGsIPjdyjEeKr4n68lRGX9FtdiQy/2O
	bMUQsc5/RrbGXw5Cf58cfkEwpqEp7Z0f7U8m8Vm2adRcSIABsn2GfRvUhM2uO83/skQvvvRI3sN
	eaUy/l8/+T2n3hBaXea4EKGBT+Ne68MKUJa6M98r313uMT5qNEaiAPHRf7bRuWqChke9Q0uv3Vd
	zFJOIFVMgZzudss/VGd2wMte1eoS0MjA==
X-Received: from pjbph12.prod.google.com ([2002:a17:90b:3bcc:b0:353:8d2b:682])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2dc8:b0:32b:623d:ee91
 with SMTP id 98e67ed59e1d1-353c4177047mr4089109a91.27.1769440324580; Mon, 26
 Jan 2026 07:12:04 -0800 (PST)
Date: Mon, 26 Jan 2026 15:11:48 +0000
In-Reply-To: <20260126151157.3418145-1-praan@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260126151157.3418145-1-praan@google.com>
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260126151157.3418145-2-praan@google.com>
Subject: [PATCH v5 01/10] iommu/arm-smmu-v3: Refactor arm_smmu_setup_irqs
From: Pranjal Shrivastava <praan@google.com>
To: iommu@lists.linux.dev
Cc: Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>, 
	Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>, Mostafa Saleh <smostafa@google.com>, 
	Nicolin Chen <nicolinc@nvidia.com>, Daniel Mentz <danielmentz@google.com>, 
	Ashish Mhetre <amhetre@nvidia.com>, Sairaj Kodilkar <sarunkod@amd.com>, 
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
index 852379845359..d479fadc3fe6 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -4097,14 +4097,32 @@ static void arm_smmu_setup_unique_irqs(struct arm_smmu_device *smmu)
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
@@ -4126,15 +4144,6 @@ static int arm_smmu_setup_irqs(struct arm_smmu_device *smmu)
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
 
@@ -4277,11 +4286,8 @@ static int arm_smmu_device_reset(struct arm_smmu_device *smmu)
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
@@ -4905,6 +4911,13 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
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
2.52.0.457.g6b5491de43-goog

