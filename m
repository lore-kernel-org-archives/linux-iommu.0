Received: from mail-ed1-f74.google.com (mail-ed1-f74.google.com [209.85.208.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6685D277C96
	for <iommu@lists.linux.dev>; Mon, 28 Jul 2025 17:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753725221; cv=none; b=U5dbtKYZOWsjEW3cAFbUBko6tj8BPelWbBty8UujPu1WFv0QeXZbEtd2Vj5Sx3q0THmkfbjq1prhCL+K/snKHc03KRhGwyCfx5TiZz1rjU0eRvYaQMBMEwvIs17joVWedcwVj8RKaAvTkU781CXvjHe6FXUKaidSJF9smn/43GQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753725221; c=relaxed/simple;
	bh=cc4qIV7R4IboXoEryrgrWSTN4pA0n7UvacWmOG9Xt0g=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=RzhUstk+ZIPlqxH8MSKwI1+6BIVANnCukqupXdaYb6d0wurEysTOMVm1ajiHl9xsW5Kpd+qCZYXfSrnR4G5LMz1zGQG650kabJHO6tnPpHmdq65Z4JdCYBxwIELtLg0Jj/yTSbGCTn00NejD8yHO9HstsMMpYWPvWBDetn95FAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=37+/lzga; arc=none smtp.client-ip=209.85.208.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="37+/lzga"
Received: by mail-ed1-f74.google.com with SMTP id 4fb4d7f45d1cf-61525af8a0bso1818644a12.2
        for <iommu@lists.linux.dev>; Mon, 28 Jul 2025 10:53:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753725217; x=1754330017; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=R18CRwRipna7yM1UAYryO2eun2b5lSz7TequZZhl+Fo=;
        b=37+/lzgaIpqLP4ps0qBXaAASHPA7ajqKSRdx2yUu3TLDJYN4wGA/A6Re/Nf93de5UY
         9GEgEMUsFKUFcGFalmxztPBTczbWxbkSQ0nI0l9TcfqGfuVsfd8w0bQOE49PBYcSlI7z
         DFicPDFH1dZH8Lhtt5p+9xV4JmZIS/nc+a6bGGyQAvFFQ4wzl/mqwrbKVbsJeHBlqxsn
         rpfJ+Tb4eWdfx2RT8zWODyi3UCxgA7DxcXfvxgpyXjv36SioQqjOPwDOYwyYFDhc6i1a
         fH2+BKfGRdzVsaARHIvZ7ZoWUGE+RwmyI+eio8l37aEAPNXovfZWzqNznatLc7N22t1Y
         GIzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753725218; x=1754330018;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R18CRwRipna7yM1UAYryO2eun2b5lSz7TequZZhl+Fo=;
        b=F3GwFGyaZ+bYI89zDza+8fMgui2Vyqc/sbHltq8bRCNtWePZdskTgAbrK/aEUsrsGC
         LHAAZrhpRa69CuU9Im0pdK6BDkpsO8vHYUmoOXMqRF4IB8ioiWDmit3SSaFFEZ8Qm0DR
         TRk+WLCQOdzLEqck4jbIh34ZnD8jKCzeG58H5krQ6wzJtcw6hbba51ufRTuZO4AB6JPW
         yrYYJ13W1r5cSpOm5CdJmzfp3ZuNYZo9xalUdHOXJR0K/ybiVFTDSZIFGLrAzJ0fVf/F
         jZ077bhYYlBcoFJCSN3jyoXhQtd66KX+aH1qzX3DkJ7he7nrOS9T7lUqKF4oXRRrVbXn
         2Rfw==
X-Forwarded-Encrypted: i=1; AJvYcCUqQw8JecUed7HEKd8IkwySBrEDHbzGM9O1Cj9wAfEW9UazvmkCeDB2/1BoGoLxour1I40oWg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yyu7HG9kyD0/JC+N1T7pnez+FplR/+TiE1EjcoLRFWvhIDyzS64
	vAlyBiIndxnFVwGi2IOIfNiHVt8QLc5c5TszH7kcLvCfGbX4MKbA97ulirI8+zZleJRhW4+dp5b
	ODUecTb8chpAddA==
X-Google-Smtp-Source: AGHT+IGIrNMQeE/kWCI/brr7kS87BOY/bq6CCQ1xjchC98i6bmhfhF9J/7LevHBGbUwRoLbmWwCwzxtv61jC5A==
X-Received: from eddf14.prod.google.com ([2002:a05:6402:354e:b0:612:c149:d25d])
 (user=smostafa job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:268f:b0:60c:9d90:93c7 with SMTP id 4fb4d7f45d1cf-614f1f12240mr12562721a12.34.1753725217591;
 Mon, 28 Jul 2025 10:53:37 -0700 (PDT)
Date: Mon, 28 Jul 2025 17:52:54 +0000
In-Reply-To: <20250728175316.3706196-1-smostafa@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250728175316.3706196-1-smostafa@google.com>
X-Mailer: git-send-email 2.50.1.552.g942d659e1b-goog
Message-ID: <20250728175316.3706196-8-smostafa@google.com>
Subject: [PATCH v3 07/29] iommu/arm-smmu-v3: Extract driver-specific bits from
 probe function
From: Mostafa Saleh <smostafa@google.com>
To: linux-kernel@vger.kernel.org, kvmarm@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev
Cc: maz@kernel.org, oliver.upton@linux.dev, joey.gouly@arm.com, 
	suzuki.poulose@arm.com, yuzenghui@huawei.com, catalin.marinas@arm.com, 
	will@kernel.org, robin.murphy@arm.com, jean-philippe@linaro.org, 
	qperret@google.com, tabba@google.com, jgg@ziepe.ca, mark.rutland@arm.com, 
	praan@google.com, Mostafa Saleh <smostafa@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Jean-Philippe Brucker <jean-philippe@linaro.org>

As we're about to share the arm_smmu_device_hw_probe() function with the
KVM driver, extract bits that are specific to the normal driver.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Signed-off-by: Mostafa Saleh <smostafa@google.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 10cc6dc26b7b..801b792dda36 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -4353,7 +4353,7 @@ static int arm_smmu_device_hw_probe(struct arm_smmu_device *smmu)
 
 	if (reg & IDR0_MSI) {
 		smmu->features |= ARM_SMMU_FEAT_MSI;
-		if (coherent && !disable_msipolling)
+		if (coherent)
 			smmu->options |= ARM_SMMU_OPT_MSIPOLL;
 	}
 
@@ -4504,11 +4504,6 @@ static int arm_smmu_device_hw_probe(struct arm_smmu_device *smmu)
 		smmu->oas = 48;
 	}
 
-	if (arm_smmu_ops.pgsize_bitmap == -1UL)
-		arm_smmu_ops.pgsize_bitmap = smmu->pgsize_bitmap;
-	else
-		arm_smmu_ops.pgsize_bitmap |= smmu->pgsize_bitmap;
-
 	/* Set the DMA mask for our table walker */
 	if (dma_set_mask_and_coherent(smmu->dev, DMA_BIT_MASK(smmu->oas)))
 		dev_warn(smmu->dev,
@@ -4522,9 +4517,6 @@ static int arm_smmu_device_hw_probe(struct arm_smmu_device *smmu)
 
 	arm_smmu_device_iidr_probe(smmu);
 
-	if (arm_smmu_sva_supported(smmu))
-		smmu->features |= ARM_SMMU_FEAT_SVA;
-
 	dev_info(smmu->dev, "ias %lu-bit, oas %lu-bit (features 0x%08x)\n",
 		 smmu->ias, smmu->oas, smmu->features);
 	return 0;
@@ -4794,6 +4786,17 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	if (arm_smmu_sva_supported(smmu))
+		smmu->features |= ARM_SMMU_FEAT_SVA;
+
+	if (disable_msipolling)
+		smmu->options &= ~ARM_SMMU_OPT_MSIPOLL;
+
+	if (arm_smmu_ops.pgsize_bitmap == -1UL)
+		arm_smmu_ops.pgsize_bitmap = smmu->pgsize_bitmap;
+	else
+		arm_smmu_ops.pgsize_bitmap |= smmu->pgsize_bitmap;
+
 	/* Initialise in-memory data structures */
 	ret = arm_smmu_init_structures(smmu);
 	if (ret)
-- 
2.50.1.552.g942d659e1b-goog

