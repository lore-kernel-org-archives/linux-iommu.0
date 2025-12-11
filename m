Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2245E192D8A
	for <iommu@lists.linux.dev>; Thu, 11 Dec 2025 13:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765459129; cv=none; b=qdn6qgLAOJS0h/BYwkcJ6NFIbjtrUo33g3rxmQ+BWwn2dhNC+BxIu4pzTK91I9fiMgzpUgB6KcuM/ID7J4BpmV0+J9+GY6PAjYG8Dk61mT7oOHHAvvm7I4IsaOdmpSw8ejdQk/6GJXPua8dRBUO4hlRrs8ew8Ed5oHE6nGiOSKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765459129; c=relaxed/simple;
	bh=ATQjRK+44UuDq3xcHATwC3hMr4lSUfXqatHKxvQB1pw=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=R76hC4g5nTUv/n2DKZJHyqOhlUp3W19YwIKTstaTFAiCK0aRU5DWH2BrO9vXJae5z9Bna2cuDy3BNqSGd6NKLyqXLHe2162wfuVYATT2yx8HLzvBpNI7Bwbn2hHoYSij3P59Lfi55bPWfS0ZmutnAN1QV+34twrSbRsE1KoAD0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gG6zIkbj; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gG6zIkbj"
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-4779b432aecso646745e9.0
        for <iommu@lists.linux.dev>; Thu, 11 Dec 2025 05:18:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1765459126; x=1766063926; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fCP4+P1Uat64E8FLxH7dgYB4wgA5K2BDbEnRT5pBDjU=;
        b=gG6zIkbjxHU6ygn4uq1COrNSHucQzn0DuyumwjtQY8odCrz7t5aQasJY9cjai7R5f3
         tyoqT0mnLTPdQ96kIYdNgkC31yN7Qw3Qm0Ad4eVNdU9pEy1QtheLvPV4ZPeGoQPrLIP3
         hx1mgZKmKtg8IZmo9Ol+3n6oIZ7+/MU6lh3B1910TrM3PAw9DBMIlbD8iqn1Kl8DXeuL
         7WZEyxmO6qHV/JC5YaNl6yp7fkjsy0b+5HZKHjhgF9R+WZHDKAY5UkkqFWcCo9i1TSwl
         yAvNXI4HQnCHG3MtQOc5kN7PwpNMtgkLthXjnwuM83NkHMzePyi+OrXYwPBlf5zxmqLf
         X8ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765459126; x=1766063926;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fCP4+P1Uat64E8FLxH7dgYB4wgA5K2BDbEnRT5pBDjU=;
        b=rYO+X6axPrz/O7nQZctXs2dCy8zIhQ5QAXIChK4U/m62uIC2ev2KUUau0QdRvJ9Yw5
         4ktBZctOkouhn4MWpz4SlwpqZE4k+Rhcv/5qEAcg+5R/Iwe4n/+84jbCBeQFJsg0qA12
         1rcK6CTOMOw5fplzDUyjbnCYNig55UMOzS5hn6El3jC0kJmPz3xpdHFARRhm4P9TCGxg
         EmFBL7GNsts2txkhtqUziSiiOG1IJqPkUhFgegVNJnUXM+fzfxwlmHGnua32a5IKw+Qs
         zNtGlNRNhkWR8EHgTezMtFOwid546ZcUJ2Yi8bzmcfY+3iXGWH66oMfUTLb67t4G0qVo
         xCjQ==
X-Gm-Message-State: AOJu0YxoNnkqzn5p9Sdw6i85feS/aCexaVdOAPI1K+KhN5mEUBypSeUO
	bRezonBGKgml9l3oicnHgQfLuMJuiuSMYqALIBdDN7Vq/53BITDb7I6Vxg7eqP/WTw7WdtqI72z
	3QMkTIt9TtZcHd/l+tbZx8rTcOFBR0BMM5UZf4zERcegAW3LQY7ZtyZIdTLSTnL4STP507Xi9OQ
	qcam0q5peSkF7BXGGhvARarYsAujGJh1RZuD5JSV3iVinUXQ==
X-Google-Smtp-Source: AGHT+IHxQzCKoPeh6QNrsoFvProfgVB+npSZJAPrg1Gr3F0q1Y23acQghLVWzGrQIXSd6SL6PIvTg2IKVEi2Kg==
X-Received: from wmgp17.prod.google.com ([2002:a05:600c:2051:b0:477:9b36:954d])
 (user=smostafa job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:1389:b0:471:1765:839c with SMTP id 5b1f17b1804b1-47a8383c89amr54081315e9.20.1765459126513;
 Thu, 11 Dec 2025 05:18:46 -0800 (PST)
Date: Thu, 11 Dec 2025 13:18:35 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
X-Mailer: git-send-email 2.52.0.223.gf5cc29aaa4-goog
Message-ID: <20251211131835.3267022-1-smostafa@google.com>
Subject: [PATCH] iommu/arm-smmu-v3: Remove IAS
From: Mostafa Saleh <smostafa@google.com>
To: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Cc: robin.murphy@arm.com, will@kernel.org, joro@8bytes.org, 
	Mostafa Saleh <smostafa@google.com>, Tomasz Nowicki <tnowicki@google.com>
Content-Type: text/plain; charset="UTF-8"

The driver only supports AArch64 page tables where OAS == IAS.

Remove the extra IAS tracking for AArch32 as this feature was
never implemented and that was creating BAD_STEs for SMMUv3
with stage-2 and OAS < 40.

Further discussion on this in:
https://lore.kernel.org/linux-iommu/20251130194506.593700-1-smostafa@google.com/

Reported-by: Tomasz Nowicki <tnowicki@google.com>
Fixes: f0c453dbcce7 ("iommu/arm-smmu: Ensure IAS is set correctly for AArch32-capable SMMUs")
Signed-off-by: Mostafa Saleh <smostafa@google.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 18 +++++-------------
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  2 --
 2 files changed, 5 insertions(+), 15 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index d16d35c78c06..019211db621d 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -2551,7 +2551,7 @@ static int arm_smmu_domain_finalise(struct arm_smmu_domain *smmu_domain,
 				     ARM_SMMU_FEAT_VAX) ? 52 : 48;
 
 		pgtbl_cfg.ias = min_t(unsigned long, ias, VA_BITS);
-		pgtbl_cfg.oas = smmu->ias;
+		pgtbl_cfg.oas = smmu->oas;
 		if (enable_dirty)
 			pgtbl_cfg.quirks |= IO_PGTABLE_QUIRK_ARM_HD;
 		fmt = ARM_64_LPAE_S1;
@@ -2561,7 +2561,7 @@ static int arm_smmu_domain_finalise(struct arm_smmu_domain *smmu_domain,
 	case ARM_SMMU_DOMAIN_S2:
 		if (enable_dirty)
 			return -EOPNOTSUPP;
-		pgtbl_cfg.ias = smmu->ias;
+		pgtbl_cfg.ias = smmu->oas;
 		pgtbl_cfg.oas = smmu->oas;
 		fmt = ARM_64_LPAE_S2;
 		finalise_stage_fn = arm_smmu_domain_finalise_s2;
@@ -4395,13 +4395,7 @@ static int arm_smmu_device_hw_probe(struct arm_smmu_device *smmu)
 	}
 
 	/* We only support the AArch64 table format at present */
-	switch (FIELD_GET(IDR0_TTF, reg)) {
-	case IDR0_TTF_AARCH32_64:
-		smmu->ias = 40;
-		fallthrough;
-	case IDR0_TTF_AARCH64:
-		break;
-	default:
+	if (!(FIELD_GET(IDR0_TTF, reg) & IDR0_TTF_AARCH64)) {
 		dev_err(smmu->dev, "AArch64 table format not supported!\n");
 		return -ENXIO;
 	}
@@ -4514,8 +4508,6 @@ static int arm_smmu_device_hw_probe(struct arm_smmu_device *smmu)
 		dev_warn(smmu->dev,
 			 "failed to set DMA mask for table walker\n");
 
-	smmu->ias = max(smmu->ias, smmu->oas);
-
 	if ((smmu->features & ARM_SMMU_FEAT_TRANS_S1) &&
 	    (smmu->features & ARM_SMMU_FEAT_TRANS_S2))
 		smmu->features |= ARM_SMMU_FEAT_NESTING;
@@ -4525,8 +4517,8 @@ static int arm_smmu_device_hw_probe(struct arm_smmu_device *smmu)
 	if (arm_smmu_sva_supported(smmu))
 		smmu->features |= ARM_SMMU_FEAT_SVA;
 
-	dev_info(smmu->dev, "ias %lu-bit, oas %lu-bit (features 0x%08x)\n",
-		 smmu->ias, smmu->oas, smmu->features);
+	dev_info(smmu->dev, "oas %lu-bit (features 0x%08x)\n",
+		 smmu->oas, smmu->features);
 	return 0;
 }
 
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index ae23aacc3840..0a5bb57dbdfe 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -43,7 +43,6 @@ struct arm_vsmmu;
 #define IDR0_COHACC			(1 << 4)
 #define IDR0_TTF			GENMASK(3, 2)
 #define IDR0_TTF_AARCH64		2
-#define IDR0_TTF_AARCH32_64		3
 #define IDR0_S1P			(1 << 1)
 #define IDR0_S2P			(1 << 0)
 
@@ -784,7 +783,6 @@ struct arm_smmu_device {
 	int				gerr_irq;
 	int				combined_irq;
 
-	unsigned long			ias; /* IPA */
 	unsigned long			oas; /* PA */
 	unsigned long			pgsize_bitmap;
 
-- 
2.52.0.223.gf5cc29aaa4-goog

