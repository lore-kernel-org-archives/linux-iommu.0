Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9C93192591
	for <iommu@lists.linux.dev>; Fri, 30 Aug 2024 11:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725015842; cv=none; b=IOsZRMogldGtYcp81Mj1ZpnvOOvvNRcveCG+ccb7IJviQhyclIezpeF4pzugnfcQCBIjg0qKj3F5/NxDujf8XqMoDYnKZ9Q+MLjevf10cUCflOpcp3AkUZtdYFUf7uhbGHtkjJqUMeZ6ZG9DARglNVe8sgpKE+d7nkHnanIyLxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725015842; c=relaxed/simple;
	bh=+K0m8Z/tfxXArd2ca1OsFLwOmWFwm4/wH1OpiRtKoks=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=AP9CWtjMFknJshs4icQmF4xRiOzHiAHdh72NvkxbrI5DEBdJvk2cB/tFXTs39r3QLX1da2Rr4J0y+W3Q0xDmhyJ482Xl8JeuCM/NaO8QeY0PfDFawL6ewi+iIBn+NLcw3/zTvpkcX3JcSrd7WJbNXvRWnnQOuUmnrE/qsOuCjDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VfgRjP7U; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VfgRjP7U"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6b4270bdea3so38364587b3.3
        for <iommu@lists.linux.dev>; Fri, 30 Aug 2024 04:04:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725015839; x=1725620639; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ic37IELEQRRYuBS18VKDjuHeMlY5e56pj2JA+eqlY6M=;
        b=VfgRjP7UuzzogUQpBj+QOr754GabsUidGeFZyJ/2R1EDUs5BMzrPrJG7MZuYpDZrIm
         2yi5JWIFNuR8Nitnnp+CQL3b0Nvmm3fPslr46oVYX7eL4f+W5IRBhZht9irEC8fYLmxy
         w6teJUFtED8NE/2e0zZ88MHMZiaA5K2tDwlLADRwFvyiRtPUGBGXY7Xwae1ly2xnwhDA
         bjbOaiZgePfCYc30Nll3gRB4u5u2XBL24/KmeLO6g7sZ1wsHeKuhaYlWXxS/5eLtiTwm
         ziPw9wtTAv+umTrHtUlcxiL/Mzvfku3RZZQKzK271UIhL+WaG2qIt/ClduJdF4G3O0E0
         skow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725015839; x=1725620639;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Ic37IELEQRRYuBS18VKDjuHeMlY5e56pj2JA+eqlY6M=;
        b=iYwzECbQgKobo5Sb7iMz16C+st4vHasFUWL9osa6zXgLlGK7mCjtuS21uIxLQrSzNS
         EIG7sOQLmPuDHUW/b4r2uyfOjP/UpgcShJjNGpVrdOq+8YZyOp4JBRfR9VL/H7szm0Kg
         nJ1dpOzXTPMBCHm5ewx2aFEMDPR0tXK/p+0c0XKsVlA3b/Q1P/MD7TPeMPOKweCqlK1H
         qky8vfrl40tidaGcj/RCLsvi06RrGe5vmf6g85F7H2WQAY1ipPmRM3E7G/zLffN7ClqW
         BmCCYfbzvsKcXbyDcnqq2tmWtakS28s8j5HakY+XzCjsTvH1cZ4H40CX+xn571IWZ8/3
         o7UA==
X-Forwarded-Encrypted: i=1; AJvYcCXVFixLTiua6vIv+DcXA9QgDZh8Bfq3HKlI7/lJsq5DtkTbkNI8mAPv7AQI4sRnk6xe2kvVuw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy24SRmANjzA9X7Ei0O+3zqDMIAJYkRGMjV3WIqh7QvSaeg9WDe
	1lYy4taj9MbAFJtzv2u42lgd4Zv41pwLUPaz2w2nCQwDR9IroLTavjm1ywnrrKI5Y7KPS6rSazp
	Dr3F2PVPYuQ==
X-Google-Smtp-Source: AGHT+IEhIgqCCVpoJF04izZWNpGhj9w4DRkBO4N4vRbTNO83ovpMlTZbUepHXnCpHONa5Hk4mWllX9/lH0OXjQ==
X-Received: from mostafa.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:333c])
 (user=smostafa job=sendgmr) by 2002:a05:690c:3744:b0:64b:5cc7:bcb7 with SMTP
 id 00721157ae682-6d40d890122mr37757b3.1.1725015839642; Fri, 30 Aug 2024
 04:03:59 -0700 (PDT)
Date: Fri, 30 Aug 2024 11:03:47 +0000
In-Reply-To: <20240830110349.797399-1-smostafa@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20240830110349.797399-1-smostafa@google.com>
X-Mailer: git-send-email 2.46.0.469.g59c65b2a67-goog
Message-ID: <20240830110349.797399-2-smostafa@google.com>
Subject: [PATCH v4 1/2] iommu/arm-smmu-v3: Match Stall behaviour for S2
From: Mostafa Saleh <smostafa@google.com>
To: linux-kernel@vger.kernel.org, iommu@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, will@kernel.org, robin.murphy@arm.com, 
	joro@8bytes.org
Cc: jean-philippe@linaro.org, jgg@ziepe.ca, nicolinc@nvidia.com, 
	mshavit@google.com, Mostafa Saleh <smostafa@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

According to the spec (ARM IHI 0070 F.b), in
"5.5 Fault configuration (A, R, S bits)":
    A STE with stage 2 translation enabled and STE.S2S =3D=3D 0 is
    considered ILLEGAL if SMMU_IDR0.STALL_MODEL =3D=3D 0b10.

Also described in the pseudocode =E2=80=9CSteIllegal()=E2=80=9D
    if STE.Config =3D=3D '11x' then
        [..]
        if eff_idr0_stall_model =3D=3D '10' && STE.S2S =3D=3D '0' then
            // stall_model forcing stall, but S2S =3D=3D 0
            return TRUE;

Which means, S2S must be set when stall model is
"ARM_SMMU_FEAT_STALL_FORCE", but currently the driver ignores that.

Although, the driver can do the minimum and only set S2S for
=E2=80=9CARM_SMMU_FEAT_STALL_FORCE=E2=80=9D, it is more consistent to match=
 S1
behaviour, which also sets it for =E2=80=9CARM_SMMU_FEAT_STALL=E2=80=9D if =
the
master has requested stalls.

Also, since S2 stalls are enabled now, report them to the IOMMU layer
and for VFIO devices it will fail anyway as VFIO doesn=E2=80=99t register a=
n
iopf handler.

Signed-off-by: Mostafa Saleh <smostafa@google.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 8 +++-----
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h | 1 +
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/ar=
m/arm-smmu-v3/arm-smmu-v3.c
index a31460f9f3d4..a0044ff2facf 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -1012,7 +1012,8 @@ void arm_smmu_get_ste_used(const __le64 *ent, __le64 =
*used_bits)
 		used_bits[2] |=3D
 			cpu_to_le64(STRTAB_STE_2_S2VMID | STRTAB_STE_2_VTCR |
 				    STRTAB_STE_2_S2AA64 | STRTAB_STE_2_S2ENDI |
-				    STRTAB_STE_2_S2PTW | STRTAB_STE_2_S2R);
+				    STRTAB_STE_2_S2PTW | STRTAB_STE_2_S2S |
+				    STRTAB_STE_2_S2R);
 		used_bits[3] |=3D cpu_to_le64(STRTAB_STE_3_S2TTB_MASK);
 	}
=20
@@ -1646,6 +1647,7 @@ void arm_smmu_make_s2_domain_ste(struct arm_smmu_ste =
*target,
 		STRTAB_STE_2_S2ENDI |
 #endif
 		STRTAB_STE_2_S2PTW |
+		(master->stall_enabled ? STRTAB_STE_2_S2S : 0) |
 		STRTAB_STE_2_S2R);
=20
 	target->data[3] =3D cpu_to_le64(pgtbl_cfg->arm_lpae_s2_cfg.vttbr &
@@ -1739,10 +1741,6 @@ static int arm_smmu_handle_evt(struct arm_smmu_devic=
e *smmu, u64 *evt)
 		return -EOPNOTSUPP;
 	}
=20
-	/* Stage-2 is always pinned at the moment */
-	if (evt[1] & EVTQ_1_S2)
-		return -EFAULT;
-
 	if (!(evt[1] & EVTQ_1_STALL))
 		return -EOPNOTSUPP;
=20
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/ar=
m/arm-smmu-v3/arm-smmu-v3.h
index 14bca41a981b..0dc7ad43c64c 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -267,6 +267,7 @@ struct arm_smmu_ste {
 #define STRTAB_STE_2_S2AA64		(1UL << 51)
 #define STRTAB_STE_2_S2ENDI		(1UL << 52)
 #define STRTAB_STE_2_S2PTW		(1UL << 54)
+#define STRTAB_STE_2_S2S		(1UL << 57)
 #define STRTAB_STE_2_S2R		(1UL << 58)
=20
 #define STRTAB_STE_3_S2TTB_MASK		GENMASK_ULL(51, 4)
--=20
2.46.0.469.g59c65b2a67-goog

