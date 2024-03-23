Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F98B1E87C
	for <iommu@lists.linux.dev>; Sat, 23 Mar 2024 13:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711201652; cv=none; b=eo1O3L7qfSfIaOntOGtzaC/9AfEMPEZYFxPTVTkQM5Tk+Y+g2WJRrQ4RAxRLMq3pNWZOe8tzg0Xs9y1nSQFgvnCPgw7Zi0jo/mmP8fGC7LbhFkKHTXcl58TwjzyOrI0kspkIir3BhaIJXJpLca7i7mlhXWcqGyO3qcg+9/3PQi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711201652; c=relaxed/simple;
	bh=gIdRxjhlfc39xJ6QlY+t/oQxzd0oKhzjAVoDO3Da65c=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=MKSLbUaDKRJzBqpWJRWsYcl03mczBGo55gt8iq3mVrY8TH1KGl1C7cepIoYgxv2d9uR7kdFL7rJCJteFtajx5QiNXCd0QDIuO7VWnFRu3ZSRyNKqAEOU+280W2igTlJUj05LIz6LXLeAbPo/jdbYTWteOOdOGFj/5bGv6IYP46A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NsRpvVcj; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NsRpvVcj"
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-40e4478a3afso15108995e9.1
        for <iommu@lists.linux.dev>; Sat, 23 Mar 2024 06:47:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711201648; x=1711806448; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=L5mqrlzEcSeLbU4x0lm0UyptckFT3/FDeJJIWvKSG/k=;
        b=NsRpvVcj7ksTjhSSbG0YGBjkaezdxfg4gFUHb7SgsgqHVg0wwwO/a3x52UNoArdR5n
         p1tlJpJk7FeTqWDv5/GV5IiuEf/147HWwO0lcuSF6JKP+Vas8dq5eO7prmuE1ZQl/zBI
         gr82NBFcHGemh2cvPTdPFdkS5COC66r9ldP5+ZM25recYsTTt/cr669DEN710meF6y0V
         wEyBll1/v4AkGJZ4TMi+r1I88yZ74/eZnDMYplgka5JE9wrOD2Hue0JabvC5YUjq3st/
         X8VrPjRyd6OZbzE+mjHDPxX+5Nbtiphvmg3D+YGrm1DsVCrseLPaWefm6BMzXWDIYCB3
         w5hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711201648; x=1711806448;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=L5mqrlzEcSeLbU4x0lm0UyptckFT3/FDeJJIWvKSG/k=;
        b=pqUSFKzhssEpF9du4zEHRDALi8Q8DtO7LcBc94p2l+HdK+exwAUUusMyTIKhoO4w9E
         r/clo7Ai/Q+DxFlC79kieDdrQT8Rg1v5bGuPqYOhM6Fze+1ukbDUHuijd+p2VSsswqgO
         XoVgZEjKhr3R/+O294CaRuBwTs6r0vkXPLprtX39stVN87D+o9ey+Jg2zf0U5Lq2oKND
         BzydBgGvtpzMB9ZM8oacP4/EtTHPcj7kyIhQRou6KE3nzKd07QtViWwX8PkxP2WKUnlB
         n0Q6TwOvqHiz5dHiqXedwitOLpkSZm0BPRtOEKpetjPXtHW600vQ3UfGS7P0wEa9nINA
         CqyA==
X-Forwarded-Encrypted: i=1; AJvYcCVkyShpnyZpLqV6Cq9socTTkShSAYty2wGt53d1AxewaaRvoOtWallME7BJm0RL56e5hgleF1KChPVeThCPkpBOfNRAXTU=
X-Gm-Message-State: AOJu0YzE9zc2pxD9TuYSDpeiXtZ5ejezTm8hLqt9oz6NBmw8VfC/YeSZ
	kzXEEHWYrnoOnwCEgWZY5SFXdSkUrsy1dcvdiA8UHxd6IDEnYXG7QhqOLhkEn0LHfI0dYk4vvDt
	XojSdRqT2UQ==
X-Google-Smtp-Source: AGHT+IG+JI3sPve5ePIPK/vQYX0yMjUamOquW/TsOAtvbYQNtUr1z8F27dMpXxNCU8Wnje0iwBUQu33ESBx5/g==
X-Received: from mostafa.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:333c])
 (user=smostafa job=sendgmr) by 2002:a05:600c:3b07:b0:414:8e1:7185 with SMTP
 id m7-20020a05600c3b0700b0041408e17185mr79580wms.3.1711201647880; Sat, 23 Mar
 2024 06:47:27 -0700 (PDT)
Date: Sat, 23 Mar 2024 13:46:58 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.396.g6e790dbe36-goog
Message-ID: <20240323134658.464743-1-smostafa@google.com>
Subject: [PATCH] iommu/arm-smmu-v3: Fix access for STE.SHCFG
From: Mostafa Saleh <smostafa@google.com>
To: will@kernel.org, robin.murphy@arm.com, 
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev
Cc: linux-kernel@vger.kernel.org, joro@8bytes.org, jgg@nvidia.com, 
	nicolinc@nvidia.com, mshavit@google.com, Mostafa Saleh <smostafa@google.com>
Content-Type: text/plain; charset="UTF-8"

STE attributes(NSCFG, PRIVCFG, INSTCFG) use value 0 for "Use Icomming",
for some reason SHCFG doesn't follow that, and it is defined as "0b01".

Currently the driver sets SHCFG to Use Incoming for stage-2 and bypass
domains.

However according to the User Manual (ARM IHI 0070 F.b):
	When SMMU_IDR1.ATTR_TYPES_OVR == 0, this field is RES0 and the
	incoming Shareability attribute is used.

This patch adds a condition for writing SHCFG to Use incoming to be
compliant with the architecture, and defines ATTR_TYPE_OVR as a new
feature discovered from IDR1.
This also required to propagate the SMMU through some functions args.

There is no need to add similar condition for the newly introduced function
arm_smmu_get_ste_used() as the values of the STE are the same before and
after any transition, so this will not trigger any change. (we already
do the same for the VMID).

Although this is a misconfiguration from the driver, this has been there
for a long time, so probably no HW running Linux is affected by it.

Reported-by: Will Deacon <will@kernel.org>
Closes: https://lore.kernel.org/all/20240215134952.GA690@willie-the-truck/

Signed-off-by: Mostafa Saleh <smostafa@google.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 35 ++++++++++++++-------
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  2 ++
 2 files changed, 25 insertions(+), 12 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 5ed036225e69..67149fe68199 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -1453,14 +1453,17 @@ static void arm_smmu_make_abort_ste(struct arm_smmu_ste *target)
 		FIELD_PREP(STRTAB_STE_0_CFG, STRTAB_STE_0_CFG_ABORT));
 }
 
-static void arm_smmu_make_bypass_ste(struct arm_smmu_ste *target)
+static void arm_smmu_make_bypass_ste(struct arm_smmu_device *smmu,
+				     struct arm_smmu_ste *target)
 {
 	memset(target, 0, sizeof(*target));
 	target->data[0] = cpu_to_le64(
 		STRTAB_STE_0_V |
 		FIELD_PREP(STRTAB_STE_0_CFG, STRTAB_STE_0_CFG_BYPASS));
-	target->data[1] = cpu_to_le64(
-		FIELD_PREP(STRTAB_STE_1_SHCFG, STRTAB_STE_1_SHCFG_INCOMING));
+
+	if (smmu->features & ARM_SMMU_FEAT_ATTR_TYPES_OVR)
+		target->data[1] = cpu_to_le64(FIELD_PREP(STRTAB_STE_1_SHCFG,
+							 STRTAB_STE_1_SHCFG_INCOMING));
 }
 
 static void arm_smmu_make_cdtable_ste(struct arm_smmu_ste *target,
@@ -1523,6 +1526,7 @@ static void arm_smmu_make_s2_domain_ste(struct arm_smmu_ste *target,
 	typeof(&pgtbl_cfg->arm_lpae_s2_cfg.vtcr) vtcr =
 		&pgtbl_cfg->arm_lpae_s2_cfg.vtcr;
 	u64 vtcr_val;
+	struct arm_smmu_device *smmu = master->smmu;
 
 	memset(target, 0, sizeof(*target));
 	target->data[0] = cpu_to_le64(
@@ -1531,9 +1535,11 @@ static void arm_smmu_make_s2_domain_ste(struct arm_smmu_ste *target,
 
 	target->data[1] = cpu_to_le64(
 		FIELD_PREP(STRTAB_STE_1_EATS,
-			   master->ats_enabled ? STRTAB_STE_1_EATS_TRANS : 0) |
-		FIELD_PREP(STRTAB_STE_1_SHCFG,
-			   STRTAB_STE_1_SHCFG_INCOMING));
+			   master->ats_enabled ? STRTAB_STE_1_EATS_TRANS : 0));
+
+	if (smmu->features & ARM_SMMU_FEAT_ATTR_TYPES_OVR)
+		target->data[1] |= cpu_to_le64(FIELD_PREP(STRTAB_STE_1_SHCFG,
+							  STRTAB_STE_1_SHCFG_INCOMING));
 
 	vtcr_val = FIELD_PREP(STRTAB_STE_2_VTCR_S2T0SZ, vtcr->tsz) |
 		   FIELD_PREP(STRTAB_STE_2_VTCR_S2SL0, vtcr->sl) |
@@ -1560,7 +1566,8 @@ static void arm_smmu_make_s2_domain_ste(struct arm_smmu_ste *target,
  * This can safely directly manipulate the STE memory without a sync sequence
  * because the STE table has not been installed in the SMMU yet.
  */
-static void arm_smmu_init_initial_stes(struct arm_smmu_ste *strtab,
+static void arm_smmu_init_initial_stes(struct arm_smmu_device *smmu,
+				       struct arm_smmu_ste *strtab,
 				       unsigned int nent)
 {
 	unsigned int i;
@@ -1569,7 +1576,7 @@ static void arm_smmu_init_initial_stes(struct arm_smmu_ste *strtab,
 		if (disable_bypass)
 			arm_smmu_make_abort_ste(strtab);
 		else
-			arm_smmu_make_bypass_ste(strtab);
+			arm_smmu_make_bypass_ste(smmu, strtab);
 		strtab++;
 	}
 }
@@ -1597,7 +1604,7 @@ static int arm_smmu_init_l2_strtab(struct arm_smmu_device *smmu, u32 sid)
 		return -ENOMEM;
 	}
 
-	arm_smmu_init_initial_stes(desc->l2ptr, 1 << STRTAB_SPLIT);
+	arm_smmu_init_initial_stes(smmu, desc->l2ptr, 1 << STRTAB_SPLIT);
 	arm_smmu_write_strtab_l1_desc(strtab, desc);
 	return 0;
 }
@@ -2637,8 +2644,9 @@ static int arm_smmu_attach_dev_identity(struct iommu_domain *domain,
 					struct device *dev)
 {
 	struct arm_smmu_ste ste;
+	struct arm_smmu_master *master = dev_iommu_priv_get(dev);
 
-	arm_smmu_make_bypass_ste(&ste);
+	arm_smmu_make_bypass_ste(master->smmu, &ste);
 	return arm_smmu_attach_dev_ste(dev, &ste);
 }
 
@@ -3264,7 +3272,7 @@ static int arm_smmu_init_strtab_linear(struct arm_smmu_device *smmu)
 	reg |= FIELD_PREP(STRTAB_BASE_CFG_LOG2SIZE, smmu->sid_bits);
 	cfg->strtab_base_cfg = reg;
 
-	arm_smmu_init_initial_stes(strtab, cfg->num_l1_ents);
+	arm_smmu_init_initial_stes(smmu, strtab, cfg->num_l1_ents);
 	return 0;
 }
 
@@ -3777,6 +3785,9 @@ static int arm_smmu_device_hw_probe(struct arm_smmu_device *smmu)
 		return -ENXIO;
 	}
 
+	if (reg & IDR1_ATTR_TYPES_OVR)
+		smmu->features |= ARM_SMMU_FEAT_ATTR_TYPES_OVR;
+
 	/* Queue sizes, capped to ensure natural alignment */
 	smmu->cmdq.q.llq.max_n_shift = min_t(u32, CMDQ_MAX_SZ_SHIFT,
 					     FIELD_GET(IDR1_CMDQS, reg));
@@ -3992,7 +4003,7 @@ static void arm_smmu_rmr_install_bypass_ste(struct arm_smmu_device *smmu)
 			 * STE table is not programmed to HW, see
 			 * arm_smmu_initial_bypass_stes()
 			 */
-			arm_smmu_make_bypass_ste(
+			arm_smmu_make_bypass_ste(smmu,
 				arm_smmu_get_step_for_sid(smmu, rmr->sids[i]));
 		}
 	}
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 23baf117e7e4..2a19bb63e5c6 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -44,6 +44,7 @@
 #define IDR1_TABLES_PRESET		(1 << 30)
 #define IDR1_QUEUES_PRESET		(1 << 29)
 #define IDR1_REL			(1 << 28)
+#define IDR1_ATTR_TYPES_OVR		(1 << 27)
 #define IDR1_CMDQS			GENMASK(25, 21)
 #define IDR1_EVTQS			GENMASK(20, 16)
 #define IDR1_PRIQS			GENMASK(15, 11)
@@ -647,6 +648,7 @@ struct arm_smmu_device {
 #define ARM_SMMU_FEAT_SVA		(1 << 17)
 #define ARM_SMMU_FEAT_E2H		(1 << 18)
 #define ARM_SMMU_FEAT_NESTING		(1 << 19)
+#define ARM_SMMU_FEAT_ATTR_TYPES_OVR	(1 << 20)
 	u32				features;
 
 #define ARM_SMMU_OPT_SKIP_PREFETCH	(1 << 0)
-- 
2.44.0.396.g6e790dbe36-goog

