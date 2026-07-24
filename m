Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 708441DF75A
	for <iommu@lists.linux.dev>; Fri, 24 Jul 2026 12:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784896806; cv=none; b=l8foIYwXiG/tyL1fCcSc30mrAHDQj/pWf/j2E4FBO4xX79kgQziYz8ghxP2Wm88jSEqyw4+2cUivSNg2ws39yBRDRLwnZ2PJF15sdzOVnL599z4a/lmso+VPZGSKFiI/Wkc7FgZ57yIVvK61F84uQRXvZ7VXc5u1mW1urh9mLPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784896806; c=relaxed/simple;
	bh=pFCouH9HStjiexnZEDkVmIrkzbMeK/R+DZXe5xtheZU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=s5UFvVz9rhwA9RIf2JUr6/v2orWI8uS/jFfsndf1jokIvMgQnF63lazxLzMMFhvTrsrNuHQQaWlDUJ/T7ijNk/5LSQIfdC+UbzyqXjqZLytTahAbwWybYslpI/3G0dwcRPSre/TJMagcAZFQbDc3bfOPMI1dzdTN+dCa58yqjOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WHsZM/h1; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WHsZM/h1"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4954aff6088so3318485e9.3
        for <iommu@lists.linux.dev>; Fri, 24 Jul 2026 05:40:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1784896803; x=1785501603; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PhVyMdGRnv+s4U+VDOdlFYKRx5J7U77NP1muojAh9J0=;
        b=WHsZM/h1WEacpAeetbkxHpsVXIvHPGaSa+nLvKFT5gZG8CAu/L0886bkI7GPVgVp/N
         psavB7CVFUN+Ad4LH0GKCs95C0VQApgJkKfwoG4nX+flrcMzvkBf/MuYt3pPPCNrKhsW
         3HyaPbZeVhNlPOqoRzRxNEwcDEaCM+th+2bWGsjpK4Y7J1tlfiCCGG3f5x+g/mP3O6uF
         8udoKuWnnQVIK0okkXxNBHDEEXm8Xb8Lc1CaUKAm+omKhmEwd6vlIgcjyeQ7hmAo5Z82
         LmINnWGUoodMr/cgxALcN6Ty0aF2zrqmAdDlhTvUY1jY4j2wtkyQg04KNalYZjRXxMiG
         kcJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784896803; x=1785501603;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PhVyMdGRnv+s4U+VDOdlFYKRx5J7U77NP1muojAh9J0=;
        b=XG5RyxXJ6GZ6LlaQUu92FuzpdBDCeMOLvEckNg6kMp7FBqJ8T9xQg6kXgiYVH/vMdW
         szpgNi7Ib25k11D8+ZAgEdfUQRq4g2sw/jh14c+vTlyji78QfX9tXOAABY60ufJ7n+ek
         Czf2rSEa2Ntfkr7mA3Mbj0vTXJwPdPWFPseio6suLTRWOrbkrDUJ0+VBchfmdmqKD0Ac
         2+Vp0mzZHnD4kf0sHIsMAIQ5yJIFVvDT0TYocIZLCOSUZTZtxWN9kOqwCoY183RXPrHO
         9wV6pDNkhEvm0sXLpjirFRZNYNQpt7zje2DXjICInSc1avuQdQT7DV6nJbrcMZreD3mM
         cAuQ==
X-Forwarded-Encrypted: i=1; AHgh+RrSbrU1RJtc0jyfjNz0XSsSFC4n+TlwQcQvQ5DgauFTLMffPpxnW1ppPY9+hnDy8HPImgOVlw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwOl/NUOALEh4n7qGKzPI/a0M6UiigrPj8PtIny1x4hdSyhRjXu
	0o+x/+WfemTIJy1xIxlTrzvWW6OhOi/WfEUZTlmEu100MXhaQILt3Cuq5mTfWIE986s=
X-Gm-Gg: AR+sD11XOCaBK+J7lSA5o/JVF2DzBd0WxeGFm+Gq/y/NwbnVEaH0ufKKsJdonWl6Nfw
	aXybFAnDe7Ue0pL2QlSeJ4pGLJ72ZiHqTZpw6FulWAB7YBZPRlLZ0Yg8u+OeR/hzk3WqXvLr8RJ
	8r26kQfeZZyyEMyrXhuwteHg/+Y6peCTU7EsjvqiOVx25EFF3u1OBLGLXF0ENXEn6sIeBb/o86y
	Rd/bRMP3PWglIy3KbI4abo1SvEhu34pwUC4d9FdiFC+o/A2TGetNLxYtTo2+invaLqIkR+XvdTf
	aw0S5srU5mI/toUsfd23P/EaS8sjtUiGwAnKH0tD62WKRTcuswPmPf7BWuvZX7HdQjftk7vNTni
	Wv2ykpkfTP5GLPBEmx38vVe6TvmzgyEvzqi5JyiEztbZVfZO/xD7cIcZeZTJ5GBTCxqIw1yrMHP
	5h+FFbsOWT15OjXZZKDdEgStYcVHN89p2kLgo=
X-Received: by 2002:a05:600c:5650:b0:495:518a:d95a with SMTP id 5b1f17b1804b1-49573ce9854mr56174435e9.29.1784896802644;
        Fri, 24 Jul 2026 05:40:02 -0700 (PDT)
Received: from gpeter-l.roam.corp.google.com ([2a00:23c7:314c:4601:a07c:a901:acc1:9287])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4957af6b10esm71556795e9.5.2026.07.24.05.40.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 05:40:02 -0700 (PDT)
From: Peter Griffin <peter.griffin@linaro.org>
Date: Fri, 24 Jul 2026 13:39:43 +0100
Subject: [PATCH 2/2] iommu/arm-smmu-v3: Override for Inst/Data attribute
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260724-arm-smmu-v3-instcfg-override-v1-2-e7acf4a8a525@linaro.org>
References: <20260724-arm-smmu-v3-instcfg-override-v1-0-e7acf4a8a525@linaro.org>
In-Reply-To: <20260724-arm-smmu-v3-instcfg-override-v1-0-e7acf4a8a525@linaro.org>
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
 "Joerg Roedel (AMD)" <joro@8bytes.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Pranjal Shrivastava <praan@google.com>, 
 Daniel Mentz <danielmentz@google.com>, Mostafa Saleh <smostafa@google.com>, 
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel-team@android.com, tudor.ambarus@linaro.org, andre.draszik@linaro.org, 
 willmcvicker@google.com, jyescas@google.com, 
 Peter Griffin <peter.griffin@linaro.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=5375;
 i=peter.griffin@linaro.org; h=from:subject:message-id;
 bh=pFCouH9HStjiexnZEDkVmIrkzbMeK/R+DZXe5xtheZU=;
 b=owEBbQKS/ZANAwAKAc7ouNYCNHK6AcsmYgBqY10fmZlGtcMy4zExtxtBdnG/RKzlRBqTBTSyr
 hR8TwwCSmeJAjMEAAEKAB0WIQQO/I5vVXh1DVa1SfzO6LjWAjRyugUCamNdHwAKCRDO6LjWAjRy
 uhAgD/4ip5+/xRQQ4+PRCS/q2v6JzM4H0W5tRGA8jxDbOMqh0Gqg6BsbsmZvtyvUpxdQCrh+6/g
 xGbEHw6WfRnSiV0XhJ0J8q4TG5lU3v1ctEtzBp6LtUjdarJl3NYPaM23ag0mNt01IxRXh2RHpGY
 er2S/Sn1aNw9/dkKoU5aak0YMKTJe/Bw9mNTjxEtb2Eey2FHBbRkKoLTeg9+sJSTzqxxNkXl97k
 UqnUgjBvNpZXzFSxEr3t57nIq+cAmHqgT6Uh7xYhEbD9T+T64n1H7+iBj4Pj9sQj1XJhIl5nn83
 Bnn7PAK4DGTUMqRUzv6bttrvSW3q0bJKT5OkxRolenw49JErCkRqOxsYsqDGghk1dL6PW36GYrW
 3O6GMFIT4efoMWXkC77ceXh+11HxV9R2h2rEQwA3R/i6qwIokfsFcwTcyTKJqkwJRVdO7e0MpKM
 JvZw7Lip/zSYGV5TEgcuD+W7DiU5lprL0nMTlStzRsq6RBFDN7QOVOXWPt2uFNy0w3U84UFqv15
 hzp0dRLGEqMYOkulDk43R6QO2mlPpOUknjvKOKHVOpRFFPI77+T3Ug4wB5GRb694OcwJiheX6oi
 BAocIPcfvhad3kWV30EfkLytdd2Jh6BxHqxa5kz8X8AbLj40nd2i8e3hX3/KgsvRgukAvMgb2WF
 A8hw25P41jrdW2Q==
X-Developer-Key: i=peter.griffin@linaro.org; a=openpgp;
 fpr=0EFC8E6F5578750D56B549FCCEE8B8D6023472BA

Add an option to override the instruction/data attribute
of incoming traffic to Data by setting the INSTCFG override
in all Stream Table Entries.

The option can be provided in the device tree entry for the SMMU
by adding the "arm,instdata-override" property.

Changes by Peter Griffin:
 - Make it apply on vanilla upstream arm-smmu-v3

Signed-off-by: Pranjal Shrivastava <praan@google.com>
Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 26 ++++++++++++++++++++++----
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  7 +++++++
 2 files changed, 29 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 57b750ebcd3d..2b39cb5aa49d 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -82,6 +82,7 @@ DEFINE_MUTEX(arm_smmu_asid_lock);
 static struct arm_smmu_option_prop arm_smmu_options[] = {
 	{ ARM_SMMU_OPT_SKIP_PREFETCH, "hisilicon,broken-prefetch-cmd" },
 	{ ARM_SMMU_OPT_PAGE0_REGS_ONLY, "cavium,cn9900-broken-page1-regspace"},
+	{ ARM_SMMU_OPT_OVR_INSTCFG_DATA, "arm,instdata-override"},
 	{ 0, NULL},
 };
 
@@ -1206,7 +1207,8 @@ void arm_smmu_get_ste_used(const __le64 *ent, __le64 *used_bits)
 			cpu_to_le64(STRTAB_STE_1_S1DSS | STRTAB_STE_1_S1CIR |
 				    STRTAB_STE_1_S1COR | STRTAB_STE_1_S1CSH |
 				    STRTAB_STE_1_S1STALLD | STRTAB_STE_1_STRW |
-				    STRTAB_STE_1_EATS | STRTAB_STE_1_MEV);
+				    STRTAB_STE_1_EATS | STRTAB_STE_1_MEV |
+				    STRTAB_STE_1_INSTCFG);
 		used_bits[2] |= cpu_to_le64(STRTAB_STE_2_S2VMID);
 
 		/*
@@ -1222,7 +1224,8 @@ void arm_smmu_get_ste_used(const __le64 *ent, __le64 *used_bits)
 	if (cfg & BIT(1)) {
 		used_bits[1] |=
 			cpu_to_le64(STRTAB_STE_1_S2FWB | STRTAB_STE_1_EATS |
-				    STRTAB_STE_1_SHCFG | STRTAB_STE_1_MEV);
+				    STRTAB_STE_1_SHCFG | STRTAB_STE_1_MEV |
+				    STRTAB_STE_1_INSTCFG);
 		used_bits[2] |=
 			cpu_to_le64(STRTAB_STE_2_S2VMID | STRTAB_STE_2_VTCR |
 				    STRTAB_STE_2_S2AA64 | STRTAB_STE_2_S2ENDI |
@@ -1835,7 +1838,11 @@ void arm_smmu_make_cdtable_ste(struct arm_smmu_ste *target,
 			 STRTAB_STE_1_S1STALLD :
 			 0) |
 		FIELD_PREP(STRTAB_STE_1_EATS,
-			   ats_enabled ? STRTAB_STE_1_EATS_TRANS : 0));
+			   ats_enabled ? STRTAB_STE_1_EATS_TRANS : 0)) |
+		FIELD_PREP(STRTAB_STE_1_INSTCFG,
+			   smmu->options & ARM_SMMU_OPT_OVR_INSTCFG_DATA ?
+				   STRTAB_STE_1_INSTCFG_DATA :
+				   STRTAB_STE_1_INSTCFG_INCOMING);
 
 	if ((smmu->features & ARM_SMMU_FEAT_ATTR_TYPES_OVR) &&
 	    s1dss == STRTAB_STE_1_S1DSS_BYPASS)
@@ -1887,7 +1894,11 @@ void arm_smmu_make_s2_domain_ste(struct arm_smmu_ste *target,
 
 	target->data[1] = cpu_to_le64(
 		FIELD_PREP(STRTAB_STE_1_EATS,
-			   ats_enabled ? STRTAB_STE_1_EATS_TRANS : 0));
+			   ats_enabled ? STRTAB_STE_1_EATS_TRANS : 0) |
+		FIELD_PREP(STRTAB_STE_1_INSTCFG,
+			   smmu->options & ARM_SMMU_OPT_OVR_INSTCFG_DATA ?
+				   STRTAB_STE_1_INSTCFG_DATA :
+				   STRTAB_STE_1_INSTCFG_INCOMING));
 
 	if (pgtbl_cfg->quirks & IO_PGTABLE_QUIRK_ARM_S2FWB)
 		target->data[1] |= cpu_to_le64(STRTAB_STE_1_S2FWB);
@@ -5087,6 +5098,13 @@ static int arm_smmu_device_hw_probe(struct arm_smmu_device *smmu)
 	if (smmu->sid_bits <= STRTAB_SPLIT)
 		smmu->features &= ~ARM_SMMU_FEAT_2_LVL_STRTAB;
 
+	if (reg & IDR1_ATTR_PERMS_OVR) {
+		smmu->features |= ARM_SMMU_FEAT_PERMS_OVR;
+	} else if (smmu->options & ARM_SMMU_OPT_OVR_INSTCFG_DATA) {
+		dev_err(smmu->dev, "Inst/Data attribute override not supported\n");
+		return -ENXIO;
+	}
+
 	/* IDR3 */
 	reg = readl_relaxed(smmu->base + ARM_SMMU_IDR3);
 	if (FIELD_GET(IDR3_RIL, reg))
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index c909c9a88538..e5f5c0bc6b8a 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -51,6 +51,7 @@ struct arm_vsmmu;
 #define IDR1_QUEUES_PRESET		(1 << 29)
 #define IDR1_REL			(1 << 28)
 #define IDR1_ATTR_TYPES_OVR		(1 << 27)
+#define IDR1_ATTR_PERMS_OVR		(1 << 26)
 #define IDR1_CMDQS			GENMASK(25, 21)
 #define IDR1_EVTQS			GENMASK(20, 16)
 #define IDR1_PRIQS			GENMASK(15, 11)
@@ -283,6 +284,10 @@ static inline u32 arm_smmu_strtab_l2_idx(u32 sid)
 #define STRTAB_STE_1_SHCFG		GENMASK_ULL(45, 44)
 #define STRTAB_STE_1_SHCFG_INCOMING	1UL
 
+#define STRTAB_STE_1_INSTCFG		GENMASK_ULL(51, 50)
+#define STRTAB_STE_1_INSTCFG_INCOMING	0UL
+#define STRTAB_STE_1_INSTCFG_DATA	2UL
+
 #define STRTAB_STE_2_S2VMID		GENMASK_ULL(15, 0)
 #define STRTAB_STE_2_VTCR		GENMASK_ULL(50, 32)
 #define STRTAB_STE_2_VTCR_S2T0SZ	GENMASK_ULL(5, 0)
@@ -921,6 +926,7 @@ struct arm_smmu_device {
 #define ARM_SMMU_FEAT_HD		(1 << 22)
 #define ARM_SMMU_FEAT_S2FWB		(1 << 23)
 #define ARM_SMMU_FEAT_BBML2		(1 << 24)
+#define ARM_SMMU_FEAT_PERMS_OVR		(1 << 25)
 	u32				features;
 
 #define ARM_SMMU_OPT_SKIP_PREFETCH	(1 << 0)
@@ -928,6 +934,7 @@ struct arm_smmu_device {
 #define ARM_SMMU_OPT_MSIPOLL		(1 << 2)
 #define ARM_SMMU_OPT_CMDQ_FORCE_SYNC	(1 << 3)
 #define ARM_SMMU_OPT_TEGRA241_CMDQV	(1 << 4)
+#define ARM_SMMU_OPT_OVR_INSTCFG_DATA	(1 << 5)
 	u32				options;
 
 	struct arm_smmu_cmdq		cmdq;

-- 
2.55.0.229.g6434b31f56-goog

