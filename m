Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 707E52F83A2
	for <iommu@lists.linux.dev>; Tue, 14 Apr 2026 19:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776196051; cv=none; b=RnvX8fnRmQCfMbRyBLSmiqutP+DFC/iE4va8T3wJSSsq960vzIxeQvCtig/y19rkgbVP940PJDWeV7jHy9GqeEozJ25U19nKf8ngfELw06Ogo/k+ByuEG56N0C5G7TPkvCfYOq0whv7mwiWBbnGJMPMatrduVJKLTQZhNSJgyDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776196051; c=relaxed/simple;
	bh=9Zvme3YTWuIvZ5hhVXrPF7JsaSdgwUvMOZZxIGNi77g=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=bLsmKOYnr7wLeaPocb48FgGoTQ2WuUGW/U6YHlCbp+ZQOKkkCzYVxRkLVFUoGG29J3SaNnJlUtpRtDiPdxbx4HycheVFt/gB1qTtcM+Vu0Hufa+5MX/PuPDcNhy0TLeTQGcK95GdM/28GJ/xm2lWCRaZtbf1pNIct/VxDbtqO1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DL7Bv8/Q; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DL7Bv8/Q"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-82c1e1a6cfbso4229613b3a.0
        for <iommu@lists.linux.dev>; Tue, 14 Apr 2026 12:47:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776196050; x=1776800850; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=hngVf6SoNrkCsXbVj2QIuInJCQPbjRbNPL0Szvmy8sU=;
        b=DL7Bv8/QTFHrj4h+2XfPqmcemgfFuT8iMMVzPWhWMsKpMMIDMXrrB4mA19Twm+MsLT
         PQWI/ldgcBk8uL/Dpf377RessQ5pWbyunf5X4AP0yfQ2frZrcXHfpeA9KGS9371CNi3R
         FRocG6olSNKaNitfUH5O74ESQfJdMvAx8nzMbRP5DH5Y0O3VMOW4rL1HSfMfjHyhCKTD
         T23eVyYRioOkoNZQl9mSxLKdhcaNUpBTFRu/3kRo+XqjydlqxViFhiqnbN/XrENwukDn
         dsLJnSffXFA5Ed3PRGkOaABeLysjGVdk4lwag7rhwWxTo93+rAOFNcXP4sGVMjlNQ+8Y
         6uHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776196050; x=1776800850;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hngVf6SoNrkCsXbVj2QIuInJCQPbjRbNPL0Szvmy8sU=;
        b=Fh4UH4nQ/CN5nt+1DUqDH61vSgh9rIiWagC9y5yotpzuunNWHmUIvuJIeLQe9Ym7Gs
         V9xoXN/kaEV2lOXPKAhRyHSLx3JQvUqBYzJhexrNTgwUA5KDxpKCVQPKF6b5JTmvZRrR
         fGrngWXi0931DzHVBpvMhsmIrAzn1rhxoVgF3tzMuSslGMXMaV9r/mA49KDacvhceIok
         SyDGxonsRQ3htiafpeOEENzyBen8gJab8TwegSvnkyg8xuyrTjxJomwI17X0fsyjJWm8
         j14XIQXa/x4pP6ri/LK3oTW308ZpVTq3J1nYjGPlxpD82AcZaW/lIhgAZOhLGzlThvdJ
         zA8g==
X-Gm-Message-State: AOJu0Ywe8cYRf7f8LZA1Ic5zC2x06GPh3t17rx3CZORmcd1PmFDDkgiL
	/GqtMiUsKgzemLxIVnhmtqdgBf2lDVoEve4yvW59yij9/4NfG0xEFCxgBDp/rOVyyelmYhziqyS
	rpYDP5OCpA/W+HwVnIXuDs6woFXyK+jf0dtTj/PyYKHJA1D197TRb4IFgoORc/X1ZOqVJjinsL2
	f7beVATqWpJaEYCJ+jYIRSh/M7HadpFw==
X-Received: from pfjd14.prod.google.com ([2002:a05:6a00:244e:b0:82c:70d1:f303])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:3907:b0:82c:7876:a027
 with SMTP id d2e1a72fcca58-82f0c2aa7f4mr19940725b3a.18.1776196049336; Tue, 14
 Apr 2026 12:47:29 -0700 (PDT)
Date: Tue, 14 Apr 2026 19:47:00 +0000
In-Reply-To: <20260414194702.1229094-1-praan@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260414194702.1229094-1-praan@google.com>
X-Mailer: git-send-email 2.54.0.rc0.605.g598a273b03-goog
Message-ID: <20260414194702.1229094-9-praan@google.com>
Subject: [PATCH v6 08/10] iommu/arm-smmu-v3: Handle gerror during suspend
From: Pranjal Shrivastava <praan@google.com>
To: iommu@lists.linux.dev
Cc: Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>, 
	Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>, Mostafa Saleh <smostafa@google.com>, 
	Nicolin Chen <nicolinc@nvidia.com>, Daniel Mentz <danielmentz@google.com>, 
	Ashish Mhetre <amhetre@nvidia.com>, Pranjal Shrivastava <praan@google.com>, Jason Gunthorpe <jgg@nvidia.com>
Content-Type: text/plain; charset="UTF-8"

The GERROR register's state might be lost when the SMMU is powered down
during runtime suspend. Handle any pending errors before suspending.

Refactor the gerror handling logic into a helper function and invoke it
from the runtime suspend callback after disabling the SMMU. This ensures
that any late-breaking gerrors are logged and ack'ed before the hardware
state is lost.

Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Pranjal Shrivastava <praan@google.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index a6aee4538b57..28d7e82e4692 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -2453,10 +2453,9 @@ static irqreturn_t arm_smmu_priq_thread(int irq, void *dev)
 
 static int arm_smmu_device_disable(struct arm_smmu_device *smmu);
 
-static irqreturn_t arm_smmu_gerror_handler(int irq, void *dev)
+static irqreturn_t arm_smmu_handle_gerror(struct arm_smmu_device *smmu)
 {
 	u32 gerror, gerrorn, active;
-	struct arm_smmu_device *smmu = dev;
 
 	gerror = readl_relaxed(smmu->base + ARM_SMMU_GERROR);
 	gerrorn = readl_relaxed(smmu->base + ARM_SMMU_GERRORN);
@@ -2496,9 +2495,17 @@ static irqreturn_t arm_smmu_gerror_handler(int irq, void *dev)
 		arm_smmu_cmdq_skip_err(smmu);
 
 	writel(gerror, smmu->base + ARM_SMMU_GERRORN);
+
 	return IRQ_HANDLED;
 }
 
+static irqreturn_t arm_smmu_gerror_handler(int irq, void *dev)
+{
+	struct arm_smmu_device *smmu = dev;
+
+	return arm_smmu_handle_gerror(smmu);
+}
+
 static irqreturn_t arm_smmu_combined_irq_thread(int irq, void *dev)
 {
 	struct arm_smmu_device *smmu = dev;
-- 
2.54.0.rc0.605.g598a273b03-goog

