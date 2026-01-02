Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 346082BE646
	for <iommu@lists.linux.dev>; Fri,  2 Jan 2026 20:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767387245; cv=none; b=ZeY/aPHBse8w5uV+s46pPAZ5/E7vu4VTkrCfb2tTc1nmModMe3Q+8QseyUHvhMvKfuACajHv/ftf0e7heNFr9uDh07dVfF573+/eFO9ZNSGHgBvQf7HQBrSKPve4czi/4yMdCPEDVDkn7gQSJ73T6/IeLvnZaRw3N8GALV+5gUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767387245; c=relaxed/simple;
	bh=XmoopGdAZcGgVQUGdaq6sywxmAcnCwUnv1l2+kwt/1s=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=SXYnA8KXghBPzL/boQp3Ow1jkvq54bp1QLSa8f59iG04F0xvCSGtkFeDaoKwFG1Grbpyimtct8PynBa7xHF+/9v+BDyjJy5qr59uAf8DyLKDVPM7pxLIAnnTeMiKbgeF95S2sqMKt1CvX8P7u4Rxtz+uOyjrC9uCbEv7BeF1JqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lYLvL2Br; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lYLvL2Br"
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-4325cc15176so5928991f8f.1
        for <iommu@lists.linux.dev>; Fri, 02 Jan 2026 12:54:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767387241; x=1767992041; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=QAiES4ydkx/sE81xhOe/Mnr1MZ9dy5PjroYTENfcCYY=;
        b=lYLvL2BrF5dCQKP0aLS0a1nt2kwG5Nwwmtrt7AewOzBAB+d3CAshUXu3AbUKZib4ct
         HXJwE+Kx7rUXiAGC+h+jT8XbRJ9MO7OZvh6+C0zD+X2sVLMaIgcy8qgapr5rO9vhbxGF
         kpbJPIpAWkm4H7KQQqnHRR/T4OLkNWC803XFX+jZbB6RkNd6+3juhmHdG6KV51CDxM/z
         ir6d0MgdOY4RSvsmJpP7BTHGl75pMu3VTwll7i8mqX30bmhRe4JEKPQ84N/h7IDnDXgL
         609BYByDW/baio+96aLnvMfk772Znx1xkk6oYjfcTq3/Kp0ywHcJnsmf62yhrvhT71s8
         29lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767387241; x=1767992041;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QAiES4ydkx/sE81xhOe/Mnr1MZ9dy5PjroYTENfcCYY=;
        b=CkQZtRT+fuFjs7FciXldleMHPwO4IYusPiv8rNVBrjowOHjPZHivA6I+LHa9Qo+j+K
         unIaB8HWqJN/U5AAFqZs7mOUL69h6SnIHMnVbjpraExeljnpf4ynmqmlJ4ujPt5/6bLV
         QUGK0khtajCXdd3jjq8KYbwPZPT6i3WZCbtJBdIFFx9rP0BuLi1ijbmOiCj/9AYZIwQB
         E7SJ2GQXDcGkL00rjj5Ifekf6i5KRLwiUnVnEgBvHmiJ0ZgBgFAVrJz1Ea2Rhsyag1pL
         TY1/j+HXKk9GnLMX4qDYo8bSkIipexnzTHxhjItZ5PhEfBr1c4u+lRNdvC0dOJ6lw66h
         s//g==
X-Gm-Message-State: AOJu0YxnrPzoEPb2z3UPn9knwgrVe6o7zyRwBTNgM2KQy+lzBhf5ruEr
	OY70gh2mDt8slLPJvM69bPzwWvPfs9YALXm9+LnuZ/7g9IaH2PO/u5xrftJ5esVsp0nhRUHP2YU
	7Q1k6xK1Kv+h2KV7rgxupvBNnE1eQZyapOa6EVbidwijOCDlp6pIaZN6SHhD1Jv7xhpQ2EMiwQr
	vAGyF+QJkI3l7vrXPnFHv3kFJu2VA5P6jAKfvBAaGkprMjLA==
X-Google-Smtp-Source: AGHT+IFCfqRVI6Uhl1ADxzrnaLqH6bdZb69W6Eaty3oAr+lEqEgaoNlylt3n+Pn7rT0RzZhlQc+mMngowh5RnA==
X-Received: from wrgb4.prod.google.com ([2002:a05:6000:3c4:b0:432:88c1:541b])
 (user=smostafa job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:430b:b0:431:808:2d32 with SMTP id ffacd0b85a97d-4324e4c716dmr50567943f8f.7.1767387241484;
 Fri, 02 Jan 2026 12:54:01 -0800 (PST)
Date: Fri,  2 Jan 2026 20:53:52 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
X-Mailer: git-send-email 2.52.0.351.gbe84eed79e-goog
Message-ID: <20260102205353.2725509-1-smostafa@google.com>
Subject: [PATCH RESEND] iommu/arm-smmu-v3: Remove IAS
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
2.52.0.351.gbe84eed79e-goog

