Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17CC0414A08
	for <iommu@lists.linux.dev>; Tue, 28 Jul 2026 21:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785272979; cv=none; b=qhckGm0bQIukF7uXbC9WykoOULkMIN8j4D7AoBQrohLeAaIvBYgw8mVItmsj0vfJ5/dDN5dAXrMvVXdxibAtNmhX/z33L4QW692qshJc031aznPyYZ+jJ3iPbIy/PtKlp/tAVVkuvREdgz0tmIJqaGDUryUcbTBGuuvd58l+N3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785272979; c=relaxed/simple;
	bh=prqoJFieE5ZiDZfnVIy20YiG3RyIU8hDVmyZYv+gamA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=BZ+vVnnXyZvSiV+iLR2g/Q3yIbcHhdcMmbPZKU0ZwDe/VvQYomG8hp6WbzoeJ97kR6utTXHw9q689YoWrb227AlxLoQ7xmBvLfjeNNINHd9/5gAygMp9zJAefjcV4dlH/Vl9BNWrk8LQRFc9IHqyJ6RjlK2n2gocNYCJvYTY+vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AStdd/eA; arc=none smtp.client-ip=209.85.210.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AStdd/eA"
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-8486ffba174so390630b3a.1
        for <iommu@lists.linux.dev>; Tue, 28 Jul 2026 14:09:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785272977; x=1785877777; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=v6jDsLdtzLKtqY4apUWLxP6U5mjSigvgDfQ1qHvaeqM=;
        b=AStdd/eAd7UX0wFDhME4HjLpZLHPxemfXogd9c0XdonaBwICKAqFIspJmRhZPgzcaM
         D3RXkKN3KTRtz9bQb9gEmbAS+d6+GTS2lwl8atBNjux3zF+XtNlGzmv5f1oEcd4qCT3L
         alNS283HIBx8znOtDDsUORHZQQXmkfB7+TaWxOdh5qdn+IfH4c6PA1zcUFQs97gLoXhT
         IAg0i8U6VPBTq2MRRf34TQXNwNzn+6QPp6+4YgV19Zk5jVzK9hqRnFzhTA7Qa+msM0nO
         xS+zkDKD3le0eDpzsXsE/W+4HCBB2jQTMxx5M9dIaoFwHJYXVVTXDU3cXhK0BKmhxs4e
         wcfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785272977; x=1785877777;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=v6jDsLdtzLKtqY4apUWLxP6U5mjSigvgDfQ1qHvaeqM=;
        b=CvhFR8PsBy0kqxu0k50iOyLXA9AfEuWshqgyQHP2+B5JocJkIER7nbY7xEbEpwqEvC
         V/GIDT6qAIW67wWmu0HflZgPv43OYre3xlrQxeyxVKcGMrQ7O/+3D6DaLa/5l5HXPkZJ
         d5fOyTxS0tIOI1rVbnWEyqx/8bMLEINhI+o+lUzMVDx5gduh99Uf46JlKLBZkZj7w0cH
         +gAfJq/SiPXYS6AwZprawQK1x/fKBjPb2fmA0sP/JtfFQxH19ONr042KSXeR0FIBlYpc
         lWaC6QL4bZnTCOnGKwCpnpJzZkT1DHqcYC5Fyb1eZHZMLAp7vtWWnrz/qyuYS09gmOGI
         x41Q==
X-Gm-Message-State: AOJu0YyP5XQmY7p4jN0tM29iRXdrsUQyrfZr2ubZW3SEDb+1Ng0oSN+a
	z57mmJazbkm+NMvW2oHO5iKdOcBMvrF4tEDhC/n5BrJmDOXW7q8F1SMcNDF/VuceWG8B9OUK8nQ
	uDiG0gTYxbbb7qj1ELcMnP9s5icD5Y4LmHkF/pqmePeB1CL/UwQF4WtJeWaCpX7UFKq1a6D1WFS
	Bq+V7DxKGSJK4pyC0W06YEQ+22k4edgg==
X-Received: from pglf33.prod.google.com ([2002:a63:1021:0:b0:c92:dd1e:dc3c])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:4ac6:b0:848:2f6e:e52e
 with SMTP id d2e1a72fcca58-84e9337e944mr3967580b3a.66.1785272976845; Tue, 28
 Jul 2026 14:09:36 -0700 (PDT)
Date: Tue, 28 Jul 2026 21:09:17 +0000
In-Reply-To: <20260728210928.1050849-1-praan@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260728210928.1050849-1-praan@google.com>
X-Mailer: git-send-email 2.55.0.487.gaf234c4eb3-goog
Message-ID: <20260728210928.1050849-2-praan@google.com>
Subject: [PATCH v9 01/12] iommu/arm-smmu-v3: Refactor arm_smmu_setup_irqs
From: Pranjal Shrivastava <praan@google.com>
To: iommu@lists.linux.dev
Cc: Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>, 
	Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>, Mostafa Saleh <smostafa@google.com>, 
	Nicolin Chen <nicolinc@nvidia.com>, Daniel Mentz <danielmentz@google.com>, 
	linux-arm-kernel@lists.infradead.org, Pranjal Shrivastava <praan@google.com>
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
index 3a9cbd7d8a00..a11f5bcbe77d 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -4749,14 +4749,32 @@ static void arm_smmu_setup_unique_irqs(struct arm_smmu_device *smmu)
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
@@ -4778,15 +4796,6 @@ static int arm_smmu_setup_irqs(struct arm_smmu_device *smmu)
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
 
@@ -4936,11 +4945,8 @@ static int arm_smmu_device_reset(struct arm_smmu_device *smmu)
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
@@ -5576,6 +5582,13 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
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
 	if (ret) {
-- 
2.55.0.487.gaf234c4eb3-goog

