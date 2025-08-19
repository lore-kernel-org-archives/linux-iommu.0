Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BC1134DCFF
	for <iommu@lists.linux.dev>; Tue, 19 Aug 2025 21:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755640374; cv=none; b=lPDY9oKhQSOedQF1jXRDjBnA9DSSjUraYu6iITbwdWAozfOCSETQk7ddHBQA69cl421Mj3HyOO5T8BIeTr0VvuXHVKqyq0yaWTdmIfS5/tg1hpLvMpSDcmmhyK03mD0gH6+HosulK2J2jYQo91K87UmhgrIDmQlIL541l7/hlG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755640374; c=relaxed/simple;
	bh=ouFg05ZUoCgKsBBLYpEzl0x2/Hx613KSJzCk/sH774M=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=nNskOmsOme10ZlawofkOtDlmpo89uA5QAf0is3qtaZW+AfeRlpZJleBAPXjckF1VIsW/7bBMyq1W5caWu49+mXUrVzIsRzFt7SNSHgXMuZqFCrIsQHwrhfUMlEKIhf9Q5S9Al3LrC3N7w5UOrwlAGaFAzwdzu8Boir61QiKIiGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4ou49ezk; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4ou49ezk"
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-45a1b0c5377so25525245e9.3
        for <iommu@lists.linux.dev>; Tue, 19 Aug 2025 14:52:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755640371; x=1756245171; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=NAhjHEW7JiGbHkZ3+MEbEcd94kVTPfsHqLQCKJs7pUU=;
        b=4ou49ezkTZipq60VeFPpT1TRTefB0Q31qLcDVnZumFYMBSLlyacU425ti60eY65lnU
         9T7EJNbq/Q9UzPpSTBeUfBWY/7T5gRDHtIZLuGKaJnfN+XLPAP8YDGRcQp9yzkduGTQR
         5RmuZ6Dys5PXQya8eF4oHlEtm+m6n/9/I3is4vStC3QP+MXp9x6QeuC6j8okpkwh9T4s
         bCgl3H+n3faItv9/6uH9Frj5PBYyOlb0dWJZL+brrzepypsEie6mhk/Lzczt/M0YVIEw
         +JwOG7BU0FE3EOUQyolbGLnmKJKiRddcKMEXo/Zr9UNvzdtbECWLoeeuvBrVj8yaDR3c
         X5zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755640371; x=1756245171;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NAhjHEW7JiGbHkZ3+MEbEcd94kVTPfsHqLQCKJs7pUU=;
        b=PrfR+k/uHxrCQ45TUvJ11r12TNluDJ2AOrYwQiHBEs+gaCqwJTnDXp6aJkbFa3VhbV
         tjHy9uT7jTlcBnOfReRR6x1vrvoPctLnsVM7UxH0MgWDJRHBIZSm0M0cTemVJgBe98RG
         UOXx0TDzIzmSs88naUUwC/Kv3O7vW/c3ei6Wg5eqsrnd5tZX2BrZjn9Vf4rRvnLy/r6V
         IqQWy9Y48gxRbTcSzz1m6KCV8gAi9wwryDAxgoG1/1CLThXCQ59wtaW3mUvJyFMVxfiI
         qfwWwjgJPfvZjXtdT1TAK9MIVxfl36cBwffgW1teJB77tc981NHkC7wuUw5V/opldofQ
         HPbw==
X-Forwarded-Encrypted: i=1; AJvYcCV0hiH703JeqhBOSD2PfdWd5myd7Z8AlUWl5l/+7gj3V8RUaZrKnt4yT2JdfhjBjrnV/2Xr3w==@lists.linux.dev
X-Gm-Message-State: AOJu0Yyh2f5HrwzBvjCCuKfBAX8i0pfGiFNVinL3rBZjkoqpit572Vle
	gev2A3UZnTh8DIY/eqW2EEHwI9ljMmrV8k8Ui13ES/4EvMp2kW8P0TgMn0afZ5sg1pBjGrd7aDd
	DQw2uEovE8PqwzA==
X-Google-Smtp-Source: AGHT+IEZystQ29Iwydry030qs2Gr/OWu/XIzN2opOZePf7XxWhuKurUI07dQ/jVoWuLSREf7SL8Xi1ULimkXvw==
X-Received: from wmbhj7.prod.google.com ([2002:a05:600c:5287:b0:456:111e:4717])
 (user=smostafa job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:4f4d:b0:459:d5d1:d602 with SMTP id 5b1f17b1804b1-45b479a3f4dmr3809755e9.3.1755640370667;
 Tue, 19 Aug 2025 14:52:50 -0700 (PDT)
Date: Tue, 19 Aug 2025 21:51:56 +0000
In-Reply-To: <20250819215156.2494305-1-smostafa@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250819215156.2494305-1-smostafa@google.com>
X-Mailer: git-send-email 2.51.0.rc1.167.g924127e9c0-goog
Message-ID: <20250819215156.2494305-29-smostafa@google.com>
Subject: [PATCH v4 28/28] iommu/arm-smmu-v3-kvm: Enable nesting
From: Mostafa Saleh <smostafa@google.com>
To: linux-kernel@vger.kernel.org, kvmarm@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev
Cc: maz@kernel.org, oliver.upton@linux.dev, joey.gouly@arm.com, 
	suzuki.poulose@arm.com, yuzenghui@huawei.com, catalin.marinas@arm.com, 
	will@kernel.org, robin.murphy@arm.com, jean-philippe@linaro.org, 
	qperret@google.com, tabba@google.com, jgg@ziepe.ca, mark.rutland@arm.com, 
	praan@google.com, Mostafa Saleh <smostafa@google.com>
Content-Type: text/plain; charset="UTF-8"

Now, as the hypervisor controls the command queue, stream table,
and shadows the stage-2 page table.
Enable stage-2 in case the host puts an STE in bypass or stage-1.

Signed-off-by: Mostafa Saleh <smostafa@google.com>
---
 .../iommu/arm/arm-smmu-v3/pkvm/arm-smmu-v3.c  | 72 ++++++++++++++++++-
 1 file changed, 70 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/pkvm/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/pkvm/arm-smmu-v3.c
index 2d4ff21f83f9..5be44a37d581 100644
--- a/drivers/iommu/arm/arm-smmu-v3/pkvm/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/pkvm/arm-smmu-v3.c
@@ -336,6 +336,46 @@ static int smmu_init_cmdq(struct hyp_arm_smmu_v3_device *smmu)
 	return 0;
 }
 
+static void smmu_attach_stage_2(struct hyp_arm_smmu_v3_device *smmu, struct arm_smmu_ste *ste)
+{
+	unsigned long vttbr;
+	unsigned long ts, sl, ic, oc, sh, tg, ps;
+	unsigned long cfg;
+	struct io_pgtable_cfg *pgt_cfg =  &idmap_pgtable->cfg;
+
+	cfg = FIELD_GET(STRTAB_STE_0_CFG, ste->data[0]);
+	if (!FIELD_GET(STRTAB_STE_0_V, ste->data[0]) ||
+	    (cfg == STRTAB_STE_0_CFG_ABORT))
+		return;
+	/* S2 is not advertised, that should never be attempted. */
+	if (WARN_ON(cfg == STRTAB_STE_0_CFG_NESTED))
+		return;
+	vttbr = pgt_cfg->arm_lpae_s2_cfg.vttbr;
+	ps = pgt_cfg->arm_lpae_s2_cfg.vtcr.ps;
+	tg = pgt_cfg->arm_lpae_s2_cfg.vtcr.tg;
+	sh = pgt_cfg->arm_lpae_s2_cfg.vtcr.sh;
+	oc = pgt_cfg->arm_lpae_s2_cfg.vtcr.orgn;
+	ic = pgt_cfg->arm_lpae_s2_cfg.vtcr.irgn;
+	sl = pgt_cfg->arm_lpae_s2_cfg.vtcr.sl;
+	ts = pgt_cfg->arm_lpae_s2_cfg.vtcr.tsz;
+
+	ste->data[1] |= FIELD_PREP(STRTAB_STE_1_SHCFG, STRTAB_STE_1_SHCFG_INCOMING);
+	/* The host shouldn't write dwords 2 and 3, overwrite them. */
+	ste->data[2] = FIELD_PREP(STRTAB_STE_2_VTCR,
+				  FIELD_PREP(STRTAB_STE_2_VTCR_S2PS, ps) |
+				  FIELD_PREP(STRTAB_STE_2_VTCR_S2TG, tg) |
+				  FIELD_PREP(STRTAB_STE_2_VTCR_S2SH0, sh) |
+				  FIELD_PREP(STRTAB_STE_2_VTCR_S2OR0, oc) |
+				  FIELD_PREP(STRTAB_STE_2_VTCR_S2IR0, ic) |
+				  FIELD_PREP(STRTAB_STE_2_VTCR_S2SL0, sl) |
+				  FIELD_PREP(STRTAB_STE_2_VTCR_S2T0SZ, ts)) |
+		 FIELD_PREP(STRTAB_STE_2_S2VMID, 0) |
+		 STRTAB_STE_2_S2AA64 | STRTAB_STE_2_S2R;
+	ste->data[3] = vttbr & STRTAB_STE_3_S2TTB_MASK;
+	/* Convert S1 => nested and bypass => S2 */
+	ste->data[0] |= FIELD_PREP(STRTAB_STE_0_CFG, cfg | BIT(1));
+}
+
 /* Get an STE for a stream table base. */
 static struct arm_smmu_ste *smmu_get_ste_ptr(struct hyp_arm_smmu_v3_device *smmu,
 					     u32 sid, u64 *strtab)
@@ -394,6 +434,10 @@ static void smmu_reshadow_ste(struct hyp_arm_smmu_v3_device *smmu, u32 sid, bool
 	struct arm_smmu_ste *host_ste_ptr = smmu_get_ste_ptr(smmu, sid, host_ste_base);
 	struct arm_smmu_ste *hyp_ste_ptr = smmu_get_ste_ptr(smmu, sid, hyp_ste_base);
 	int i;
+	struct arm_smmu_ste target = {};
+	struct arm_smmu_cmdq_ent cfgi_cmd = {
+		.opcode = CMDQ_OP_CFGI_ALL,
+	};
 
 	/*
 	 * Linux only uses leaf = 1, when leaf is 0, we need to verify that this
@@ -409,8 +453,32 @@ static void smmu_reshadow_ste(struct hyp_arm_smmu_v3_device *smmu, u32 sid, bool
 		hyp_ste_ptr = smmu_get_ste_ptr(smmu, sid, hyp_ste_base);
 	}
 
-	for (i = 0; i < STRTAB_STE_DWORDS; i++)
-		WRITE_ONCE(hyp_ste_ptr->data[i], host_ste_ptr->data[i]);
+	memcpy(target.data, host_ste_ptr->data, STRTAB_STE_DWORDS << 3);
+
+	/*
+	 * Typically, STE update is done as the following
+	 * 1- Write last 7 dwords, while STE is invalid
+	 * 2- CFGI
+	 * 3- Write first dword, making STE valid
+	 * 4- CFGI
+	 * As the SMMU has to least to load 64 bits atomically
+	 * that gurantees that there is no race between writing
+	 * the STE and the CFGI where the SMMU observes parts
+	 * of the STE.
+	 * In the shadow we update the STE to enable nested translation,
+	 * which requires updating first 3 dwords.
+	 * That is only done if the STE is valid and not in abort.
+	 * Which means it happens at step 4)
+	 * So we need to also write the last 7 dwords and send CFGI
+	 * before writing the first dword.
+	 * There is no need for last CFGI as the host will do that.
+	 */
+	smmu_attach_stage_2(smmu, &target);
+	for (i = 1; i < STRTAB_STE_DWORDS; i++)
+		WRITE_ONCE(hyp_ste_ptr->data[i], target.data[i]);
+
+	WARN_ON(smmu_send_cmd(smmu, &cfgi_cmd));
+	WRITE_ONCE(hyp_ste_ptr->data[0], target.data[0]);
 }
 
 static int smmu_init_strtab(struct hyp_arm_smmu_v3_device *smmu)
-- 
2.51.0.rc1.167.g924127e9c0-goog

