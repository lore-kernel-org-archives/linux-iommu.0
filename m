Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 803971741D2
	for <iommu@lists.linux.dev>; Thu, 23 Jan 2025 19:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737662210; cv=none; b=HK2N9/f9ktAPDJcfdSjv+2MfjwQ0+d6OLv4BlojCntv+5hAzM/yylZQXARIFxwbgv1zIF4Qg9iGGPjZvBulHcA2M8zj5W8WIZakFiWbdkKJMsyEdWerG5f8ndTPJTkPJgiA60RWMpH9GACB6rwITu60H/3NfcqNUolZeH8U5RSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737662210; c=relaxed/simple;
	bh=TwvXQRIug8F6RExk6W9gSzMnKMtjxPH6iwFq6uN64cc=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=meYrEr4+bi48rvGehdk7RE34pQ/uiXD+QvYEslTAbqbmo3SWSfHVkmUZU5zExkQrl3SppZ86HpB4WnNoddJWnvk9qhwN93E0+upRM3wPkQtqOiYvs56PQAaJdkk6h6T4HjiFuqIoDzIro4KZ7ArRJNylScGFl7IKsPAAcqWdnrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=X85GLAjy; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="X85GLAjy"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2164861e1feso24899485ad.1
        for <iommu@lists.linux.dev>; Thu, 23 Jan 2025 11:56:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1737662209; x=1738267009; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=wPrd227TNOv8ku/Ix6oUR4h5E0X32O7ITmue7ko05aI=;
        b=X85GLAjyfPdkygFrxaTbf1sFgk4pyyp0FQP+mVu0MvK065fWRkF2zaix6P+0nDVHuk
         R1Sd+px9n6xmsWdcc0LRrasWkY5tKkiloigy9MHF9JUluEGrkZuiqxftSITx4dvyfYKv
         9TQYShBED1BX02MkuExWz9K3DPcpeYn6tqj5qCYfa4s2+kHXpl09JXOXWCxhRvxIjFBH
         piLAuh/ESHCfyG30qAnUplMPm8PaK/CQFh7JwQqelvfIxvC3m9JQ0NxlRL9PapSxNUfb
         PE+lL/N6AgyAT4oaMKKmqbApLrI7w5jTRskSbBsIWlqay5DhTsD/KfXnqMcvkb1CY57A
         rdfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737662209; x=1738267009;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wPrd227TNOv8ku/Ix6oUR4h5E0X32O7ITmue7ko05aI=;
        b=Elud8zilx/Q647LCDcl8rghcS54uVsi5FeNlAfpTxg0C3HkiTvIpD8vnLCgKkxV7+F
         MyvVB0ovr7SkCIvkQ9JN0FozR/29W1gG3LC9D6eWz+/1hw/yaQwG5eZ95vU8c6yoHLZE
         BQKOzeNiYDuGKpjg+rcG7+TmlHQNvGTS/2TKE77dzbG3EvvTrKY8HGXv0p4uWXmW9QDF
         zU418yjWl70ZrNiay7rDzV4UIGgoDqTIcAEA5/ConAeba66lLtmQ4OCkgrJkH3z3VX3X
         XbGs/eJkoiFNFOCuWF2tTX2xaC9wzXznoMv7lKoUFRsznC1AmXoJmfM0PjaHVoaKWn0u
         I76A==
X-Forwarded-Encrypted: i=1; AJvYcCUS+JX3ao8aVyzA5fKERMXIlWvhKVFLiLZic0A0ugIIWJVX0/WQ1iRzMb+cJzfijQTaj8E55A==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw55fDs22zXFD74/P1JwzELXUJaJfEW2Kpko6zEkb8CJ4P8/fuD
	IGpeEN2wm0eFVrC2fq9CzQHrZQg734Y+OKPUrTijG4sTcznGxzeMoF0r3Nfg68pPMN1MgZ1msA=
	=
X-Google-Smtp-Source: AGHT+IHEZtWc1YQsks9jr/IxkrIRNA+XpTNmEkYX61/OJn3xSGXaCCL+yUqYCI/t0GtX64ds2q8FTYn15Q==
X-Received: from pgwg14.prod.google.com ([2002:a65:6cce:0:b0:a87:a3b9:db3d])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:12cf:b0:1e0:e027:2eaf
 with SMTP id adf61e73a8af0-1eb214daa01mr38171889637.19.1737662208782; Thu, 23
 Jan 2025 11:56:48 -0800 (PST)
Date: Thu, 23 Jan 2025 19:56:36 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
X-Mailer: git-send-email 2.48.1.262.g85cc9f2d1e-goog
Message-ID: <20250123195636.4182099-1-praan@google.com>
Subject: [PATCH] iommu/arm-smmu: Set rpm auto_suspend once during probe
From: Pranjal Shrivastava <praan@google.com>
To: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>
Cc: Rob Clark <robdclark@gmail.com>, Mostafa Saleh <smostafa@google.com>, iommu@lists.linux.dev, 
	Daniel Mentz <danielmentz@google.com>, Pranjal Shrivastava <praan@google.com>
Content-Type: text/plain; charset="UTF-8"

The current code calls `arm_smmu_rpm_use_autosuspend` during device
attach, which seems unusual as it sets the autosuspend delay & the
`use_autosuspend` flag for the smmu device. These parameters can be
simply set "once" during the smmu probe and in order to avoid bouncing
rpm states, we can simply "mark_last_busy" during a client dev attach as
discussed in [1].

Move the handling of `arm_smmu_rpm_use_autosuspend` to the SMMU probe
and modify the `arm_smmu_rpm_put` function to "mark_last_busy" before
calling `__pm_runtime_put_autosuspend`. Additionally,
s/pm_runtime_put_autosuspend/__pm_runtime_put_autosuspend to help with
the refactor of the `pm_runtime_put_autosuspend` API [2].

Thanks,
Praan

[1] https://lore.kernel.org/all/20241023164835.GF29251@willie-the-truck/
[2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=b7d46644e554ed017dfabc0841acf418d0584bc9

Signed-off-by: Pranjal Shrivastava <praan@google.com>
---
 drivers/iommu/arm/arm-smmu/arm-smmu.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/arm-smmu/arm-smmu.c
index 79afc92e1d8b..5c26c9328cec 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
@@ -78,8 +78,11 @@ static inline int arm_smmu_rpm_get(struct arm_smmu_device *smmu)
 
 static inline void arm_smmu_rpm_put(struct arm_smmu_device *smmu)
 {
-	if (pm_runtime_enabled(smmu->dev))
-		pm_runtime_put_autosuspend(smmu->dev);
+	if (pm_runtime_enabled(smmu->dev)) {
+		pm_runtime_mark_last_busy(smmu->dev);
+		__pm_runtime_put_autosuspend(smmu->dev);
+
+	}
 }
 
 static void arm_smmu_rpm_use_autosuspend(struct arm_smmu_device *smmu)
@@ -1194,7 +1197,6 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 	/* Looks ok, so add the device to the domain */
 	arm_smmu_master_install_s2crs(cfg, S2CR_TYPE_TRANS,
 				      smmu_domain->cfg.cbndx, fwspec);
-	arm_smmu_rpm_use_autosuspend(smmu);
 rpm_put:
 	arm_smmu_rpm_put(smmu);
 	return ret;
@@ -1217,7 +1219,6 @@ static int arm_smmu_attach_dev_type(struct device *dev,
 		return ret;
 
 	arm_smmu_master_install_s2crs(cfg, type, 0, fwspec);
-	arm_smmu_rpm_use_autosuspend(smmu);
 	arm_smmu_rpm_put(smmu);
 	return 0;
 }
@@ -2245,6 +2246,7 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
 	if (dev->pm_domain) {
 		pm_runtime_set_active(dev);
 		pm_runtime_enable(dev);
+		arm_smmu_rpm_use_autosuspend(smmu);
 	}
 
 	return 0;
-- 
2.48.1.262.g85cc9f2d1e-goog

