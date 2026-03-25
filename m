Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFDB43368B3
	for <iommu@lists.linux.dev>; Wed, 25 Mar 2026 21:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774473073; cv=none; b=ry2pmVppU7V/Lri6oiRxD55QyCZXZSgrNfYa9whYLyPbcloiKnEzEjXbNXMXCYDyLkwFnDlo6v9LtrWcefmYyXOn+C0SA3pmgo0Na1lgINdQTjOVnErb2oNNjO7vXz9PPpVw1c64N6X4hilv7tBfOpNEUBN7y8tlIrG5OSCeiVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774473073; c=relaxed/simple;
	bh=c9MHl6wwCqZZZNdguQdAF7xL+qjBzLIdLAmWzKLWIrs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=h77fzlXRkMGNIwZrcB0TlmxSBbyQsiHvFwR0eGrKnFlL2FVhSi++RH8RkTiRYlokEl2EFrLdZhu0PIuI83ItvsxbjyhAIawiB4ngk/9PpX1L9Bwd/8kxMqZGeFzSCI+F+lrSxDUvEvxcTHE+OCsK4tEZLWhqpWPiF7FWe72oT1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HJWBFztL; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HJWBFztL"
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-38bd15d82bdso2179671fa.2
        for <iommu@lists.linux.dev>; Wed, 25 Mar 2026 14:11:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774473070; x=1775077870; darn=lists.linux.dev;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BFJKPQI5/sac9me8amIP9+ekaSHHOonqJLT2WhRtyac=;
        b=HJWBFztLLuykOOLTkV62qxdmAwKrEQ0vUUnuK57Can/i82QP/oBqlPEf4DvVybrHX8
         lkwLOZWzso/BmHoVKxYf8nbnSWZyIi1n7deRfuuaepgp9qlBeQeVwy2abT4YvfDhk/Ul
         +dIEqYqJcO+DixEs+Xaru/OKLcTLBy26l2YASLMDcFWaLeNXp/V7N1gpI5EU0uDXFvlR
         xd3g/n3TNlfsweSNoeZa9c3LNYF3w7WCKmwHWPnxWJvWhMt4GCal65riQs3V6OfaH0+g
         GtR4iDAIyORGQptHMJkErkvnqOZTvqelmS0pA0gq/85T3V7ohOMSJezhNpyzkxeol8uy
         FG4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774473070; x=1775077870;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BFJKPQI5/sac9me8amIP9+ekaSHHOonqJLT2WhRtyac=;
        b=d/l0MhK316vKnuV84KFtiyTPh8/AAfhl2Icq2tR7dnw01dcpQMKfBm5Wsm1HWsZUqs
         g2WncK9Ebej6v29xTN9xxNTPnArDqFDBHtv7t6IdqvL3D0APhhwuF6bzF3NvSqfskvu3
         Kb9K+LYvA0xm7wA0eSb9RQfonaaV8jo3C1uKKIEZYf4C2suTkUqTIl0+qYTKa5ClVG2f
         Ko7LzjguX9bAU49qNGtJ/hk0wfdKnBwS0BUZ3vZTGZUyj7CGdsz3cNDMPbB4Az4jVIVm
         HoKwZSsFCVLKGfYEkB7tftc4h88QKthhtaolROn0Fj+g1l1KxexQ8Ia/3jjTRB6FigQq
         I4OA==
X-Gm-Message-State: AOJu0Yz5lVBEdx0BHPI5Sz0sOjHNKCGB1H5h0HfFQzp7dDks5ESvVbtz
	2ey+a5oFbRlxevAOiUaZRq/hXCZZseDJj6iPfYYaueDljgHi1wzi6JI=
X-Gm-Gg: ATEYQzytnZght7eNvzSr8b90UcSB8EexqAZr12fQMZx+8uVNycWZh/944gBGMhVHgh7
	JH5iw/KPmvg+tiljQt0F9TPNnOK2Trvea+mGJIj2AMPiilEThjiuB+BdQuKyuo/E7TxFY7xaQ8z
	6n37FFttlkeiRpJto/K2Uq/OyMtv+hGgO/ra2j6W4KiGsyyXmipNx6Djlob81OZT0kEpkOjN/rB
	Ml6pdhMkvazlnegi5wan8wr8mLohL3x7WIb8OHJTcKaF2acoP1ZKdkg1XCOckxoOE3c910KQtxr
	kLh3Is/APJX73dau8VaRCuDyZh28q0KIlKkeBbTlo8OYGhp8AE30gzGLwMTPOpkaJEpGt5BUyD2
	rKRQ0pUiGZdvH+IsVUkfFA6sNz+AmUVzn8smX1fpjWZ8rauldJ5Da/IlQLV1uuf6b0x5T2d/8Q/
	YIxUz0rFgApAv5HIYLg28aNJRnB3ju1t3xuactKlZqa2Lmr8rVf1iaMbpFKmk7x5JraHgT2mqUe
	9oB+GDpQxHt+O5owou7i3N5
X-Received: by 2002:a2e:bcc4:0:b0:387:d29:fd4f with SMTP id 38308e7fff4ca-38c43053841mr18578111fa.1.1774473069655;
        Wed, 25 Mar 2026 14:11:09 -0700 (PDT)
Received: from [192.168.1.17] (host-79-52-171-101.retail.telecomitalia.it. [79.52.171.101])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-38c52fac168sm1524821fa.11.2026.03.25.14.11.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2026 14:11:09 -0700 (PDT)
From: Anna Maniscalco <anna.maniscalco2000@gmail.com>
Date: Wed, 25 Mar 2026 22:11:03 +0100
Subject: [PATCH v2] iommu: arm-smmu-qcom: Ensure smmu is powered up in
 set_ttbr0_cfg
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260325-qcom_smmu_pmfix-v2-1-ba769a6ad0be@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3WNTQ6CMBBGr0JmbU07oBhX3sMQUsoIk1jAVhsN6
 d0d2bt8L9/PCpECU4RzsUKgxJHnSQB3BbjRTgMp7oUBNR41Gq0ebvZt9P7VLv7Gb4WWbI+drQg
 1SGsJJHpbvDbCI8fnHD7bQTI/+38rGWVUfepqU5XW6UN5Gbzl+15i0OScvxkVNjWuAAAA
X-Change-ID: 20260210-qcom_smmu_pmfix-2aead2ba4e20
To: Rob Clark <robin.clark@oss.qualcomm.com>, Will Deacon <will@kernel.org>, 
 Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>
Cc: iommu@lists.linux.dev, linux-arm-msm@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Anna Maniscalco <anna.maniscalco2000@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774473068; l=1749;
 i=anna.maniscalco2000@gmail.com; s=20240815; h=from:subject:message-id;
 bh=c9MHl6wwCqZZZNdguQdAF7xL+qjBzLIdLAmWzKLWIrs=;
 b=nZxsZvGAgjyLb36vu1D/zn/oDYONnycLHZGwePaIYT75gLjwmEB/AP/WcoAECO0yu57KZ+ikU
 XNixHH2ZPVhDYRs4ADLGfLw/0OhzZBIQ0C9H4Duz9/j7FQodQ3+oErp
X-Developer-Key: i=anna.maniscalco2000@gmail.com; a=ed25519;
 pk=0zicFb38tVla+iHRo4kWpOMsmtUrpGBEa7LkFF81lyY=

Previously the device was being accessed while potentially in a
suspended state.

Signed-off-by: Anna Maniscalco <anna.maniscalco2000@gmail.com>
---
Changes in v2:
- Simplify patch by acquiring device just around the call that needs it
- Link to v1: https://lore.kernel.org/r/20260210-qcom_smmu_pmfix-v1-1-78b7143ac053@gmail.com
---
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
index 573085349df3..cab7d110aaf5 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
@@ -231,6 +231,7 @@ static int qcom_adreno_smmu_set_ttbr0_cfg(const void *cookie,
 	struct io_pgtable *pgtable = io_pgtable_ops_to_pgtable(smmu_domain->pgtbl_ops);
 	struct arm_smmu_cfg *cfg = &smmu_domain->cfg;
 	struct arm_smmu_cb *cb = &smmu_domain->smmu->cbs[cfg->cbndx];
+	int ret;
 
 	/* The domain must have split pagetables already enabled */
 	if (cb->tcr[0] & ARM_SMMU_TCR_EPD1)
@@ -260,8 +261,16 @@ static int qcom_adreno_smmu_set_ttbr0_cfg(const void *cookie,
 		cb->ttbr[0] |= FIELD_PREP(ARM_SMMU_TTBRn_ASID, cb->cfg->asid);
 	}
 
+	ret = pm_runtime_resume_and_get(smmu_domain->smmu->dev);
+	if (ret < 0) {
+		dev_err(smmu_domain->smmu->dev, "failed to get runtime PM: %d\n", ret);
+		return -ENODEV;
+	}
+
 	arm_smmu_write_context_bank(smmu_domain->smmu, cb->cfg->cbndx);
 
+	pm_runtime_put_autosuspend(smmu_domain->smmu->dev);
+
 	return 0;
 }
 

---
base-commit: 50c4a49f7292b33b454ea1a16c4f77d6965405dc
change-id: 20260210-qcom_smmu_pmfix-2aead2ba4e20

Best regards,
-- 
Anna Maniscalco <anna.maniscalco2000@gmail.com>

