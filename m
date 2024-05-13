Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76C9283CD3
	for <iommu@lists.linux.dev>; Mon, 13 May 2024 21:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715637280; cv=none; b=t5X66vkNnKe3xlmdVFS+J7DkOd5ODSQ4yWGfEDIbic2Xgb1Q8xlbjMWsBGq4luvbbDr/WhcacaNBjM9Zv0vJzu15RmUpAssBumzM+KqjAiCzsNSthskGrv5MdZI7FiLd2fAsUA+OHNJMvaRRzDYIA4qYuy96dAcgC1/XbgQkyk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715637280; c=relaxed/simple;
	bh=PGx7jAlb854zlrbJriM88KSJOdVA+QqeMq4AogsG2Kw=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=o4eYE+75p0JNHvcUKs4mfyo1GQamNH/lK3G+uCw4HzWnrJf/Btm8rMD+wrvj0GqIJF1R+sD6916PYcrDGrbFaSMN9Z/g508FKqDRtgPYlJuQege578sfv8k9TQwYvO16tOBXy5pQYPsZjv825GW0osf/YYfOhv38isYaQgWjcBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--danielmentz.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gkS9Mz89; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--danielmentz.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gkS9Mz89"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-61be4b79115so94974717b3.1
        for <iommu@lists.linux.dev>; Mon, 13 May 2024 14:54:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715637278; x=1716242078; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nLCfu/fqBdgUhwrBItdRpAkKl/eJY8dzIchUYWaFit4=;
        b=gkS9Mz89Me4IT1dmjNLFFx2RYJhvl4giTZrbD9Y6azY6i1nN1FnXbApkmBwhRmbIAH
         s80DN0ZBKndB8aHeJ/FWdt4c/XLIpMNOzofvX26ehOmvdFjDnOGum5m6vWIm1kthERqZ
         zAMyWJCE6Xf93MY7xvNVkEtkbh0ZGQfuwSTlg7wvs8IbdRVXlFfyZOVxst1ATBiX8r4Z
         KQY70jeG6wpgN10ZVzDOC41MtRStJNiUn/t+3prEQYoQ9+PUTDKp8WwPKkz7BslDMTBw
         9Za7bJUGQC1k63019TRE+xdKb9MDDId4vMTlBC33URuxsDDxEst+NZVZkn3Ojsl5YwDQ
         Ugwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715637278; x=1716242078;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nLCfu/fqBdgUhwrBItdRpAkKl/eJY8dzIchUYWaFit4=;
        b=V3PJvQ5j6Gp/XqHeAN9F0RXMcLuiXGYmBhfoYFt2rGgaarY/HewDDu0wnjoEmjs1HN
         1ibrJcdIWuqBpThZtcfawnAL9qV399/H7M/hub36y9ME85Vsanah7PCs6KEV3zQCOOMs
         xO1mlXBgMynb/zVqdJa5UiWScKbKty/CMNvdou7UyyV8jnKJl7KAXfd+aC7EisU8qnOD
         w/vjhTuqTkuESQ76Ig/GhOuGIC4HBs9DRLp7mljqgeTX4x0g2rL3+ah5hTfljNBURpqF
         tuXlVFpLnd+LIhzfT6w2IDLGcD4YsjzQr3eLUWmBVX5XzEOPT+LnpR4CM34G3NJ0hVig
         DS1A==
X-Gm-Message-State: AOJu0YyQIh+ZNNTpIGXkRoeYfnPxbtNsS48zzeZXzuXPKJz5GSyIavu2
	kVvV+qmloglWYSgIrJJbvbl1GZ1zdzQe7qQa8vQ1QOwFnG3L8WEvw3LdAMoi4cRq6xTsFHd7nxy
	f+wPawJsayJKDT/xi92IoZCfCMknccdulmzRgfd4TZPjrvQTwsFAxpD4aDwd6HIWDRonV3GUxzN
	MZQKPh8ckxDJbn1tUVtUmgL1utxJ4zk2D6o+OUt4Rw/zzAWlNW11kmmCzcTg==
X-Google-Smtp-Source: AGHT+IEzFQYlYFIgc/e9f7z4iewBzdLW8Aw+EWSr+VLf+czjs9zn80/GyVgkRdrc/WgprqJbLeW/K6zMmdrgWqpC3Q==
X-Received: from danielmentz2.mtv.corp.google.com ([2620:15c:72:202:dff:1e7e:4b2a:dbc6])
 (user=danielmentz job=sendgmr) by 2002:a05:6902:102d:b0:dee:6802:dc49 with
 SMTP id 3f1490d57ef6-dee6802f337mr1995744276.1.1715637278308; Mon, 13 May
 2024 14:54:38 -0700 (PDT)
Date: Mon, 13 May 2024 14:54:20 -0700
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.0.118.g7fe29c98d7-goog
Message-ID: <20240513215420.408374-1-danielmentz@google.com>
Subject: [PATCH] iommu/arm-smmu-v3: Skip prefetch cmd for MMU-600, MMU-700
From: Daniel Mentz <danielmentz@google.com>
To: iommu@lists.linux.dev
Cc: Nicolin Chen <nicolinc@nvidia.com>, Robin Murphy <robin.murphy@arm.com>, 
	Daniel Mentz <danielmentz@google.com>
Content-Type: text/plain; charset="UTF-8"

Arm CoreLink MMU-600 and MMU-700 both silently ignore the
CMD_PREFETCH_CONFIG command. Let's not waste cycles adding this command to
the command queue if it is ignored anyway.

Signed-off-by: Daniel Mentz <danielmentz@google.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index aa62f0ecd053..98f1c4b44ef3 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -3684,6 +3684,8 @@ static void arm_smmu_device_iidr_probe(struct arm_smmu_device *smmu)
 	case IIDR_IMPLEMENTER_ARM:
 		switch (productid) {
 		case IIDR_PRODUCTID_ARM_MMU_600:
+			/* MMU-600 silently ignores CMD_PREFETCH_CONFIG */
+			smmu->options |= ARM_SMMU_OPT_SKIP_PREFETCH;
 			/* Arm erratum 1076982 */
 			if (variant == 0 && revision <= 2)
 				smmu->features &= ~ARM_SMMU_FEAT_SEV;
@@ -3692,6 +3694,8 @@ static void arm_smmu_device_iidr_probe(struct arm_smmu_device *smmu)
 				smmu->features &= ~ARM_SMMU_FEAT_NESTING;
 			break;
 		case IIDR_PRODUCTID_ARM_MMU_700:
+			/* MMU-700 silently ignores CMD_PREFETCH_CONFIG */
+			smmu->options |= ARM_SMMU_OPT_SKIP_PREFETCH;
 			/* Arm erratum 2812531 */
 			smmu->features &= ~ARM_SMMU_FEAT_BTM;
 			smmu->options |= ARM_SMMU_OPT_CMDQ_FORCE_SYNC;
-- 
2.45.0.118.g7fe29c98d7-goog

