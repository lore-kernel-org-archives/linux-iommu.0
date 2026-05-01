Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 076043A7598
	for <iommu@lists.linux.dev>; Fri,  1 May 2026 11:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777634438; cv=none; b=hOoYVUJi59c5Z5Is6Mq2eXMNSeUI0RYaYZDgY4Ubyf4T7XRcujJKU4i3jEWD3jrv32bJn42MEmNj+R9PY6Ojnv5i2aFm5y/k3pBna/oqLTMBJSi+Q7CT0HxqPGuHkuJ6XrAZak68x3H4wY6IP3c0SWbjeGNY6tJSQYPCCPZ3skU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777634438; c=relaxed/simple;
	bh=K0ptwM46SUnUhZWwfceVEOB6BIJZjEKLOxtcjcGQS/U=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=kbVY4uHOowiHRejrVNnCod+DVHooMsD6zGIvV+FFdAL9KLCCquY2Gb2boFDPK3HAvVbBSbi5dWbHxnDZiDNl3bzDMnPHebZZBl9TxTdNdBsl/3/W65ncypZi/pvJuI02TZgbI1JqKAh23jqF7L1nwHHvj23ROz9kERVybh2VHs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YYR8Fbwk; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YYR8Fbwk"
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-4837b6f6b93so21239995e9.3
        for <iommu@lists.linux.dev>; Fri, 01 May 2026 04:20:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777634434; x=1778239234; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=cBYFLa+FC4uonW8niogdkcZuL7rcf529F6haDy+QJc8=;
        b=YYR8FbwkCVnEdKqGlO03reJeY3X1md7apns5gMbrm/QfjnMx25M+upn/IuDCYaqUoy
         tsOeyFiu+hud0Zfx1tVTcE7tIEE30b2KbviyNPe1kwp1MxIPcEiMcHSbMXmSrmh+Gezg
         Co6udCoNroTSF6jbAxs6skz0VGg2oCCqVaJRC9Ee72m4JGRScAPJdlcE89qM17hdduwe
         M3ik9zYFq/W2zJ/KWn4tKuYYyMmIchhq+ISJbocsYTBDtapQ+XrH74rPdUwqQIUkoG7o
         Fz8t3YHGsnipIo+wYHDbTmLAf9BCREd+LfntZSNL4zyFaDUz91s8asvNYA3nC4b+bEi2
         6+JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777634434; x=1778239234;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cBYFLa+FC4uonW8niogdkcZuL7rcf529F6haDy+QJc8=;
        b=bHhAwvcqqvwOWvAGoQVKYjbqsqQOV/Jrjhej43Bu7Llo6EjOtYZWUDFkuRSFbNhDAh
         zO71OU4E2J/3hP5b8cXmO+7Z760aq/q/hrOP+6QnDSuCoKaudpLRNFEtr+d88fDdkoPl
         yxlw1vjQtJyD0eRzvRGySH52FKKhloEmT1UY6XP22u4UJ6TIjLk12b+H/yWznMTGfF4i
         tZ/bJnQmayaemhpzeC1b/SeFH2QEsAccaWPRM9ts/XFDv+pT9KamhPSKclDur9Fu7uAA
         9wvIvXKmYlKCVzUyrrb/9QZ5xcR6plXfjNL7UJKB40aRZBqikIWRlg/Ip1jO8qxa1Jj4
         e64A==
X-Forwarded-Encrypted: i=1; AFNElJ+qKODKv/6+yboTmdYSi5CbuYzgZqi5xU8a1WYlpc4/9tVPTy3MHWgmIp0VyfISU0k0o4gsfw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxcETTI7tUoByKNSDOde4v8HpDYmj9BlxnQ9m7qJttmz0DMhj40
	m95agW0bXO2peZYcfgj5ajpEPvQwO+0beysbTUnxsrHKRWy+RnqlWLGz+31nA97JD30OrIUQPYE
	IKOPmDTA9Fl2ZEQ==
X-Received: from wmrk12.prod.google.com ([2002:a05:600c:b4c:b0:489:1dcf:1b38])
 (user=smostafa job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:4588:b0:488:ab1d:dcc5 with SMTP id 5b1f17b1804b1-48a8447f4e9mr111938855e9.27.1777634434360;
 Fri, 01 May 2026 04:20:34 -0700 (PDT)
Date: Fri,  1 May 2026 11:19:26 +0000
In-Reply-To: <20260501111928.259252-1-smostafa@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260501111928.259252-1-smostafa@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260501111928.259252-25-smostafa@google.com>
Subject: [PATCH v6 24/25] iommu/arm-smmu-v3-kvm: Enable nesting
From: Mostafa Saleh <smostafa@google.com>
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	kvmarm@lists.linux.dev, iommu@lists.linux.dev
Cc: catalin.marinas@arm.com, will@kernel.org, maz@kernel.org, 
	oliver.upton@linux.dev, joey.gouly@arm.com, suzuki.poulose@arm.com, 
	yuzenghui@huawei.com, joro@8bytes.org, jean-philippe@linaro.org, jgg@ziepe.ca, 
	mark.rutland@arm.com, qperret@google.com, tabba@google.com, 
	vdonnefort@google.com, sebastianene@google.com, keirf@google.com, 
	Mostafa Saleh <smostafa@google.com>
Content-Type: text/plain; charset="UTF-8"

Now, as the hypervisor controls the command queue, stream table,
and shadows the stage-2 page table.
Enable stage-2 in case the host puts an STE in bypass or stage-1.

Signed-off-by: Mostafa Saleh <smostafa@google.com>
---
 .../iommu/arm/arm-smmu-v3/pkvm/arm-smmu-v3.c  | 108 ++++++++++++++++--
 1 file changed, 101 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/pkvm/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/pkvm/arm-smmu-v3.c
index b73a2462f0dd..3d727d6dfbf0 100644
--- a/drivers/iommu/arm/arm-smmu-v3/pkvm/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/pkvm/arm-smmu-v3.c
@@ -411,6 +411,57 @@ static int smmu_init_cmdq(struct hyp_arm_smmu_v3_device *smmu)
 	return 0;
 }
 
+static int smmu_attach_stage_2(struct arm_smmu_ste *ste)
+{
+	unsigned long vttbr;
+	unsigned long ts, sl, ic, oc, sh, tg, ps;
+	unsigned long cfg;
+	struct io_pgtable_cfg *pgt_cfg =  &idmap_pgtable->cfg;
+
+	cfg = FIELD_GET(STRTAB_STE_0_CFG, le64_to_cpu(ste->data[0]));
+	if (!FIELD_GET(STRTAB_STE_0_V, le64_to_cpu(ste->data[0])) ||
+	    (cfg == STRTAB_STE_0_CFG_ABORT)) {
+		ste->data[2] = 0;
+		ste->data[3] = 0;
+		return 0;
+	}
+	/* S2 is not advertised, that should never be attempted. */
+	if (cfg == STRTAB_STE_0_CFG_NESTED)
+		return -EINVAL;
+	vttbr = pgt_cfg->arm_lpae_s2_cfg.vttbr;
+	ps = pgt_cfg->arm_lpae_s2_cfg.vtcr.ps;
+	tg = pgt_cfg->arm_lpae_s2_cfg.vtcr.tg;
+	sh = pgt_cfg->arm_lpae_s2_cfg.vtcr.sh;
+	oc = pgt_cfg->arm_lpae_s2_cfg.vtcr.orgn;
+	ic = pgt_cfg->arm_lpae_s2_cfg.vtcr.irgn;
+	sl = pgt_cfg->arm_lpae_s2_cfg.vtcr.sl;
+	ts = pgt_cfg->arm_lpae_s2_cfg.vtcr.tsz;
+
+	ste->data[1] &= ~cpu_to_le64(STRTAB_STE_1_SHCFG);
+	ste->data[1] |= cpu_to_le64(FIELD_PREP(STRTAB_STE_1_SHCFG, STRTAB_STE_1_SHCFG_INCOMING));
+
+	/* The host shouldn't write dwords 2 and 3, overwrite them. */
+	ste->data[2] = cpu_to_le64(FIELD_PREP(STRTAB_STE_2_VTCR,
+				  FIELD_PREP(STRTAB_STE_2_VTCR_S2PS, ps) |
+				  FIELD_PREP(STRTAB_STE_2_VTCR_S2TG, tg) |
+				  FIELD_PREP(STRTAB_STE_2_VTCR_S2SH0, sh) |
+				  FIELD_PREP(STRTAB_STE_2_VTCR_S2OR0, oc) |
+				  FIELD_PREP(STRTAB_STE_2_VTCR_S2IR0, ic) |
+				  FIELD_PREP(STRTAB_STE_2_VTCR_S2SL0, sl) |
+				  FIELD_PREP(STRTAB_STE_2_VTCR_S2T0SZ, ts)) |
+		 FIELD_PREP(STRTAB_STE_2_S2VMID, 0) |
+		 STRTAB_STE_2_S2AA64 | STRTAB_STE_2_S2R |
+ #ifdef __BIG_ENDIAN
+		STRTAB_STE_2_S2ENDI |
+#endif
+		STRTAB_STE_2_S2PTW);
+
+	ste->data[3] = cpu_to_le64(vttbr & STRTAB_STE_3_S2TTB_MASK);
+	/* Convert S1 => nested and bypass => S2 */
+	ste->data[0] |= cpu_to_le64(FIELD_PREP(STRTAB_STE_0_CFG, cfg | BIT(1)));
+	return 0;
+}
+
 static int smmu_get_host_l2_ste(struct hyp_arm_smmu_v3_device *smmu, u32 sid,
 				struct arm_smmu_ste *host_ste_out)
 {
@@ -440,9 +491,18 @@ static int smmu_get_host_l2_ste(struct hyp_arm_smmu_v3_device *smmu, u32 sid,
 static int smmu_reshadow_ste(struct hyp_arm_smmu_v3_device *smmu, u32 sid, bool leaf)
 {
 	struct arm_smmu_strtab_cfg *cfg = &smmu->strtab_cfg;
-	struct arm_smmu_ste *hyp_ste_ptr, *host_ste_ptr, host_ste_copy;
+	struct arm_smmu_ste *hyp_ste_ptr;
 	u64 *hyp_ste_base = strtab_hyp_base(smmu);
-	int ret;
+	struct arm_smmu_ste target = {};
+	struct arm_smmu_cmdq_ent cfgi_cmd = {
+		.opcode	= CMDQ_OP_CFGI_STE,
+		.cfgi	= {
+			.sid	= sid,
+			.leaf	= true,
+		},
+	};
+	bool cur_valid, target_valid;
+	int i, ret;
 
 	/*
 	 * Linux only uses leaf = 1, when leaf is 0, we need to verify that this
@@ -463,7 +523,7 @@ static int smmu_reshadow_ste(struct hyp_arm_smmu_v3_device *smmu, u32 sid, bool
 			return -E2BIG;
 
 		hyp_ste_ptr = &hyp_table[sid];
-		host_ste_ptr = &host_table[sid];
+		memcpy(target.data, host_table[sid].data, STRTAB_STE_DWORDS << 3);
 	} else {
 		struct arm_smmu_strtab_l1 *l1tab = (struct arm_smmu_strtab_l1 *)hyp_ste_base;
 		u32 l1_idx = arm_smmu_strtab_l1_idx(sid);
@@ -472,8 +532,7 @@ static int smmu_reshadow_ste(struct hyp_arm_smmu_v3_device *smmu, u32 sid, bool
 		if (l1_idx >= cfg->l2.num_l1_ents)
 			return -E2BIG;
 
-		host_ste_ptr = &host_ste_copy;
-		ret = smmu_get_host_l2_ste(smmu, sid, host_ste_ptr);
+		ret = smmu_get_host_l2_ste(smmu, sid, &target);
 		if (ret)
 			return ret;
 
@@ -491,9 +550,44 @@ static int smmu_reshadow_ste(struct hyp_arm_smmu_v3_device *smmu, u32 sid, bool
 		hyp_ste_ptr = &l2ptr->stes[arm_smmu_strtab_l2_idx(sid)];
 	}
 
-	memcpy(hyp_ste_ptr->data, host_ste_ptr->data, STRTAB_STE_DWORDS << 3);
 
-	return 0;
+	/*
+	 * Summary of each host emulated state vs real HW.
+	 * |	Host	|	HW	|
+	 * ==============================
+	 * |	V=0	|	V=0	|
+	 * |	Abort	|	Abort	|
+	 * |	Bypass	|	S2	|
+	 * |	S1	|	S1+S2	|
+	 *
+	 * For the host, any V=0 transition is not hitless, all other permutations of
+	 * (abort, bypass, S1) transitions are hitless.
+	 * For the HW state, any V=0 transition is not hitless, as all the S2 config is
+	 * always the same (ttbr, vtcr...), all other transitions should be hitless too.
+	 * However, the host is not trusted, which means that any V=0 <=> V=1 transitions
+	 * we need to enforce writing order of the STE and add CFGI.
+	 */
+	cur_valid = FIELD_GET(STRTAB_STE_0_V, le64_to_cpu(hyp_ste_ptr->data[0]));
+	ret = smmu_attach_stage_2(&target);
+	if (ret)
+		return ret;
+	target_valid = FIELD_GET(STRTAB_STE_0_V, le64_to_cpu(target.data[0]));
+	if (cur_valid && !target_valid) {
+		WRITE_ONCE(hyp_ste_ptr->data[0], target.data[0]);
+		WARN_ON(smmu_send_cmd(smmu, &cfgi_cmd));
+		for (i = 1; i < STRTAB_STE_DWORDS; i++)
+			WRITE_ONCE(hyp_ste_ptr->data[i], target.data[i]);
+	} else if (!cur_valid && target_valid) {
+		for (i = 1; i < STRTAB_STE_DWORDS; i++)
+			WRITE_ONCE(hyp_ste_ptr->data[i], target.data[i]);
+		WARN_ON(smmu_send_cmd(smmu, &cfgi_cmd));
+		WRITE_ONCE(hyp_ste_ptr->data[0], target.data[0]);
+	} else {
+		for (i = 0; i < STRTAB_STE_DWORDS; i++)
+			WRITE_ONCE(hyp_ste_ptr->data[i], target.data[i]);
+	}
+
+	return smmu_send_cmd(smmu, &cfgi_cmd);
 }
 
 static int smmu_init_strtab(struct hyp_arm_smmu_v3_device *smmu)
-- 
2.54.0.545.g6539524ca2-goog

