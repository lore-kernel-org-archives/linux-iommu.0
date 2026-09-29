Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C37643C3BFC
	for <iommu@lists.linux.dev>; Tue, 29 Sep 2026 03:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790653519; cv=none; b=E73joUQNyVc31XHRArR6YxnIyrN0GlQa/9nQr5gPIr9QnkGhvJKlBT8odS3cgmrBmylykrFePBN3p2svCjq6CxzATw8wiJKjQNk51n9Lialt+vVrgG0kwF640gG69B6Waa0EK64ieAskGB0jA7sjBiB3O3QEWYmr+jNSAGumahc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790653519; c=relaxed/simple;
	bh=sSaCOx4U6R0q+XEpXdBsjzIiaG0C0n1CnHH/2I4K5iI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Gt85YoJlAnkUVQCTGfgsKL4V6TA96rHckfW7URfhvHyvUhw7IitpYoJ7Llz1JRqWWDJQiNQ2q8y/Y0EESfr2F7alrC5T/D+43JjApJKeCExtTHm7fl9jvznj7h4AgTUvfh/hdElgNYyLEizjmYsidF8XINuKjZbHRulJ40WY9Vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VsrTZo8W; arc=none smtp.client-ip=209.85.215.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VsrTZo8W"
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-cc1bbd7d6e6so2568070a12.3
        for <iommu@lists.linux.dev>; Mon, 28 Sep 2026 20:45:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790653517; x=1791258317; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IDZxo1vDA8KPlmypD4LBvSL25B+x7JnUcC92a9yoH8o=;
        b=VsrTZo8WwFkEYPeLi3bG4Xm9Bh7PhV1dVl8QHHLbyNItR2SI2T5yddNiu9bpnixFRK
         Mb8VvmWAc6EyyI7uA43I3gZezRdUi/WQ5/TzrpnuqpIXef8h/qgkHd7ly4tbRzTp2xGh
         tVKGf37IcxGFktnuDB1RVLr11gXSgulZmQn5HIJJO3mUHdOgOfiSV0XGs8vAvQ7ymWYD
         EleSr/6se9RYCuYtAn9EkkVhQxn/yIsqZp9VpRj+6QM9PfriR3tBFCBOCO+QvHXjpD9H
         +VX8wq8gC8UdgXJ+TycwaEPNaU2gxYAtyFMo5T7j+faSIEix0nIFrgJduDsD+z+g+Vk9
         fkLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790653517; x=1791258317;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IDZxo1vDA8KPlmypD4LBvSL25B+x7JnUcC92a9yoH8o=;
        b=ZdZyU7pVK5aFcCjON/eU9sMer0sECvB2XrFBbT/Omd+aD4vDyLbfGexEDHXe/6QZJe
         67WHp4NCZwuKRU4YX8RyNf5f1+Peng19SrahYzi3IBFkUdQBWA4jAWPRYrzX1dJMCpDk
         O0GRLmYzBm4DIESuMa+5wjuZKY1KOpYi4npS0+MYL32Cup+qclnTsXDqJyr3OyA8HApB
         H18p9ccvuunekIEfuPXrMChmxdWW58CiKX83JVTksWRg8ZLgBqgbih0aDmf4WlokNn3w
         +VEaUXziyU53jVfb/SduoMT8BN0OynDUyfMItyjb0Uf81kwFwQmD3jRU+6dsmaaEG+iz
         LMCg==
X-Gm-Message-State: AFuF++mgglRVnEhh2Mq+RzWZZamOdzYZNF4EcDQ6WsI/5jslYmiY9Z8J
	6IyqY+wTP6EwDilTPmH+tYQT2eW9FxI80616lhaJ/OADC9kWRtgrR4czrCu3qsoKPP4gVN216qq
	Fqpk89yDpcghCcmLe0yhecnsNzq2QC548NINpJcjvz58zzBYFNVFF+I3g9Ka8iQMhPGyadL4mtM
	ozbDDIdSEx3RRaIgmsSYyva7hxwLtVyw==
X-Received: from pfcs22.prod.google.com ([2002:a05:6a00:6fd6:b0:882:ebd3:410c])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:7585:b0:87f:dcc3:62f
 with SMTP id d2e1a72fcca58-87fdcc35542mr7869110b3a.60.1790653516329; Mon, 28
 Sep 2026 20:45:16 -0700 (PDT)
Date: Tue, 29 Sep 2026 03:44:55 +0000
In-Reply-To: <20260929034510.2023173-1-praan@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260929034510.2023173-1-praan@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260929034510.2023173-2-praan@google.com>
Subject: [PATCH v11 01/16] iommu/arm-smmu-v3: Refactor arm_smmu_setup_irqs
From: Pranjal Shrivastava <praan@google.com>
To: iommu@lists.linux.dev
Cc: Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>, 
	Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>, Mostafa Saleh <smostafa@google.com>, 
	Nicolin Chen <nicolinc@nvidia.com>, Daniel Mentz <danielmentz@google.com>, 
	Ashish Mhetre <amhetre@nvidia.com>, linux-arm-kernel@lists.infradead.org, 
	Thomas Gleixner <tglx@kernel.org>, Radu Rendec <radu@rendec.net>, Bjorn Helgaas <bhelgaas@google.com>, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, rafael@kernel.org, 
	Danilo Krummrich <dakr@kernel.org>, driver-core@lists.linux.dev, 
	Pranjal Shrivastava <praan@google.com>, Jason Gunthorpe <jgg@nvidia.com>
Content-Type: text/plain; charset="UTF-8"

Refactor arm_smmu_setup_irqs by splitting it into two parts, one for
registering interrupt handlers and the other one for enabling interrupt
generation in the hardware. This refactor helps in re-initialization of
hardware interrupts as part of a subsequent patch that enables runtime
power management for the arm-smmu-v3 driver.

Additionally, pass a 'resume' flag to arm_smmu_device_reset() to skip
registering IRQ handlers again during resume. On probe, handlers are
registered after queues are configured but before enabling translation.

Reviewed-by: Mostafa Saleh <smostafa@google.com>
Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Pranjal Shrivastava <praan@google.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 75 +++++++++++++++------
 1 file changed, 56 insertions(+), 19 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 5732f3ba0122..270e6617a19a 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -4756,14 +4756,55 @@ static void arm_smmu_setup_unique_irqs(struct arm_smmu_device *smmu)
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
+	/*
+	 * Enable interrupt generation on the SMMU.
+	 * As per the ARM SMMUv3 spec section 6.3.17 (SMMU_IRQ_CTRL):
+	 *
+	 * Completion of an Update of x_IRQEN from 0 to 1 guarantees that the
+	 * MSI configuration in SMMU_x_IRQ_CFG{0,1,2} will be used for all
+	 * future MSIs generated from source x. All wired or MSI interrupts
+	 * that are triggered from a source relate to occurrences that happened
+	 * after the completion of the Update that enabled the source. It is
+	 * not permitted to trigger an interrupt that relates to an occurrence
+	 * that happened before the source was enabled, even if the source was
+	 * previously enabled at the time of the occurrence.
+	 */
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
 
-	/* Disable IRQs first */
-	ret = arm_smmu_write_reg_sync(smmu, 0, ARM_SMMU_IRQ_CTRL,
-				      ARM_SMMU_IRQ_CTRLACK);
+	/*
+	 * Disable IRQs first as required by the Arm SMMUv3 spec.
+	 * As per the ARM SMMUv3 spec section 6.3.17 (SMMU_IRQ_CTRL):
+	 *
+	 * An Update of x_IRQEN from 1 to 0 completes when all prior MSIs have
+	 * completed. An MSI has completed when it is visible to its
+	 * Shareability domain, or when it has aborted, and the abort is
+	 * recorded in the appropriate SMMU_(*_)GERROR bit. Completion of this
+	 * Update guarantees that no new MSI writes or wired edge events from
+	 * source x become visible until the source is re-enabled.
+	 */
+	ret = arm_smmu_disable_irqs(smmu);
 	if (ret) {
 		dev_err(smmu->dev, "failed to disable irqs\n");
 		return ret;
@@ -4785,15 +4826,6 @@ static int arm_smmu_setup_irqs(struct arm_smmu_device *smmu)
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
 
@@ -4841,7 +4873,7 @@ static void arm_smmu_write_strtab(struct arm_smmu_device *smmu)
 	writel_relaxed(reg, smmu->base + ARM_SMMU_STRTAB_BASE_CFG);
 }
 
-static int arm_smmu_device_reset(struct arm_smmu_device *smmu)
+static int arm_smmu_device_reset(struct arm_smmu_device *smmu, bool resume)
 {
 	int ret;
 	u32 reg, enables;
@@ -4943,12 +4975,17 @@ static int arm_smmu_device_reset(struct arm_smmu_device *smmu)
 		}
 	}
 
-	ret = arm_smmu_setup_irqs(smmu);
-	if (ret) {
-		dev_err(smmu->dev, "failed to setup irqs\n");
-		return ret;
+	if (!resume) {
+		ret = arm_smmu_setup_irqs(smmu);
+		if (ret) {
+			dev_err(smmu->dev, "failed to setup irqs\n");
+			return ret;
+		}
 	}
 
+	/* Enable interrupt generation on the SMMU */
+	arm_smmu_enable_irqs(smmu);
+
 	if (is_kdump_kernel())
 		enables &= ~(CR0_EVTQEN | CR0_PRIQEN);
 
@@ -5594,7 +5631,7 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
 	arm_smmu_rmr_install_bypass_ste(smmu);
 
 	/* Reset the device */
-	ret = arm_smmu_device_reset(smmu);
+	ret = arm_smmu_device_reset(smmu, false);
 	if (ret) {
 		arm_smmu_device_disable(smmu);
 		return ret;
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

