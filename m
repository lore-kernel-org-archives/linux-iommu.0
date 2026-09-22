Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com [209.85.208.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 828785592E7
	for <iommu@lists.linux.dev>; Tue, 22 Sep 2026 13:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790082818; cv=none; b=Lm9Cl6AvED0u0Rw5QUzbPnoDJ4shhH0F1RDrOuLad7ZtjMb0HxA1Y1smiaiT94RLGDQRMArWhTvcp0Lk87kxXBPvzFxhNiobWv0c7deWB4M1ZfSvSHuhCxFfgV6sD8meR5dr8muJYYSbXfJ/lZ7KXmfAGcaiGFT0vdY6Qxwhmck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790082818; c=relaxed/simple;
	bh=E2DLmDPzNZlSKKL6JJDQS3FYAGA/WLF+RiEGF3VgGe4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=cy7i4SvG2Ur1Qm7NqQH5FtZx1Y6aM2cM/F5k3uEMs5teEKmUaOZrZeA1A+J4NvShlyeo9WPBn+RExCfzTwme2uLYKijhVbtkf1t8gHgr/wG1h/IWAdi3c8SBhjWchte3zqNgvgfr62ilBcSsuU0VFSgcDEKQLuMAuYtz/RHAA+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MS+D44sk; arc=none smtp.client-ip=209.85.208.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MS+D44sk"
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-6a9bb406f0cso4470596a12.1
        for <iommu@lists.linux.dev>; Tue, 22 Sep 2026 06:13:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790082812; x=1790687612; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7x6tfErkSiFlzGsGfOwlIUPo7E3FNSLjiZHvuCyhifo=;
        b=MS+D44skKtFAn7PzFaIT7oUf34j6k9qdW3N8R8RP1DTrCXcR9u0gqtWbnoZn4EFmh7
         5u3OKpq7Mk9TutrQ7xbk3Y6+Y0SHHcVwBgF+JNbffFjjCryw1IcqwvrxcJqozXai4F5f
         V64BZvHX4fHFADsTEELmLDzBWAYJWfTtQRa1vs6+sZh2MdhAT8PivYgO/0IqkK/zRdZc
         xQOv1RhRW+XoG+WEV9Cwt5W/9EfXpHOWOmPYrocYB/lA+htT4I9peJgRUGs1AAFPibny
         8zQIn076P1s5zudVZDKfBa5jPyy/uSO3XuQGnIRxSXYEQtq3LNqlqXRJtPwxorpQRyU1
         nXzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790082812; x=1790687612;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7x6tfErkSiFlzGsGfOwlIUPo7E3FNSLjiZHvuCyhifo=;
        b=fXo2oIAb5fDoRKkLZz5R1W6x8EGfbsIOkud/ConpuPQCk0ClWu/dRMlUn/d5tN4tgK
         hB9lnrnBu29N0ZviO0uX2fbZwGYhbxE47iSxVaJ4YZcwwJDrgEnyputam7gYSXrwnrpF
         /88R3pJRODajaER+RpGJkS8joNi0lpT8V8TnjeVNeSnbfgePURG24zhzi7YY01GbHwh7
         jQxHu7fczyMMYxutNGcASFgS8m2arXDOkhot4DaNvSGFX/vPVugYQUmEaV+PP5Ycpl8y
         bHzquCwhMJrEuSkWgqSZJQ75Hfz5L7CUpc92F6XVLGLYO5/dfr9w8NJIYxtKXhYnUiTh
         I06A==
X-Forwarded-Encrypted: i=1; AKwUvByOrFvLNRJ4pqWc67+QiPPCpwQ/mtb43Izapkd+2oqUwOhd88MO5FJzI9tKI0d1OgeJY+0Vyg==@lists.linux.dev
X-Gm-Message-State: AFuF++lg7ikojGEhnomd3kZsoJFaDSwLCtonQEh0E/Dew1phOggX5jb4
	cF4Bc9ilVVoEXJKbbzUJBVASGkZ/bbT57bQ+/CA8x3Wy73AuKkmMiWTtEy2TELYqksYUaDETOo8
	Rjd8+MGjMylgSxg==
X-Received: from edyc10.prod.google.com ([2002:aa7:df0a:0:b0:6aa:13a8:bf07])
 (user=smostafa job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:1942:b0:6aa:a133:cfd1 with SMTP id 4fb4d7f45d1cf-6aaa133d1e9mr2304164a12.20.1790082811557;
 Tue, 22 Sep 2026 06:13:31 -0700 (PDT)
Date: Tue, 22 Sep 2026 13:12:57 +0000
In-Reply-To: <20260922131259.2975334-1-smostafa@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260922131259.2975334-1-smostafa@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <20260922131259.2975334-25-smostafa@google.com>
Subject: [PATCH v8 24/25] iommu/arm-smmu-v3-kvm: Enable nesting
From: Mostafa Saleh <smostafa@google.com>
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	kvmarm@lists.linux.dev, iommu@lists.linux.dev
Cc: catalin.marinas@arm.com, will@kernel.org, maz@kernel.org, 
	oliver.upton@linux.dev, joey.gouly@arm.com, suzuki.poulose@arm.com, 
	yuzenghui@huawei.com, joro@8bytes.org, jgg@ziepe.ca, mark.rutland@arm.com, 
	qperret@google.com, tabba@google.com, vdonnefort@google.com, 
	sebastianene@google.com, keirf@google.com, 
	Mostafa Saleh <smostafa@google.com>
Content-Type: text/plain; charset="UTF-8"

As now the hypervisor controls the command queue, stream table,
and shadows the stage-2 page table, we enable stage-2 translation
in case the host puts an STE in bypass or stage-1.

The hypervisor will control the S2 part of the STE and sanitize it.

Signed-off-by: Mostafa Saleh <smostafa@google.com>
---
 .../iommu/arm/arm-smmu-v3/pkvm/arm-smmu-v3.c  | 109 +++++++++++++++++-
 1 file changed, 103 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/pkvm/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/pkvm/arm-smmu-v3.c
index 5417a5c2bf58..39c97404e039 100644
--- a/drivers/iommu/arm/arm-smmu-v3/pkvm/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/pkvm/arm-smmu-v3.c
@@ -461,6 +461,57 @@ static int smmu_init_cmdq(struct hyp_arm_smmu_v3_device *smmu)
 	return 0;
 }
 
+static int smmu_attach_stage_2(struct arm_smmu_ste *ste)
+{
+	unsigned long vttbr, cfg;
+	unsigned long ts, sl, ic, oc, sh, tg, ps;
+	struct io_pgtable_cfg *pgt_cfg = &idmap_pgtable->cfg;
+
+	cfg = FIELD_GET(STRTAB_STE_0_CFG, le64_to_cpu(ste->data[0]));
+	if (!FIELD_GET(STRTAB_STE_0_V, le64_to_cpu(ste->data[0])) ||
+	    (cfg == STRTAB_STE_0_CFG_ABORT)) {
+		return 0;
+	}
+	/* S2 is not advertised, that should never be attempted. */
+	if ((cfg == STRTAB_STE_0_CFG_S2_TRANS) ||
+	    (cfg == STRTAB_STE_0_CFG_NESTED))
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
+	ste->data[1] &= ~cpu_to_le64(STRTAB_STE_1_EATS | STRTAB_STE_1_S2FWB | STRTAB_STE_1_STRW);
+
+	/* The host shouldn't write dwords 2 and 3, overwrite them. */
+	ste->data[2] = cpu_to_le64(FIELD_PREP(STRTAB_STE_2_VTCR,
+					      FIELD_PREP(STRTAB_STE_2_VTCR_S2PS, ps) |
+					      FIELD_PREP(STRTAB_STE_2_VTCR_S2TG, tg) |
+					      FIELD_PREP(STRTAB_STE_2_VTCR_S2SH0, sh) |
+					      FIELD_PREP(STRTAB_STE_2_VTCR_S2OR0, oc) |
+					      FIELD_PREP(STRTAB_STE_2_VTCR_S2IR0, ic) |
+					      FIELD_PREP(STRTAB_STE_2_VTCR_S2SL0, sl) |
+					      FIELD_PREP(STRTAB_STE_2_VTCR_S2T0SZ, ts)) |
+				   FIELD_PREP(STRTAB_STE_2_S2VMID, 0) |
+				   STRTAB_STE_2_S2AA64 | STRTAB_STE_2_S2R |
+#ifdef __BIG_ENDIAN
+				   STRTAB_STE_2_S2ENDI |
+#endif
+				   STRTAB_STE_2_S2PTW);
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
@@ -490,12 +541,40 @@ static int smmu_get_host_l2_ste(struct hyp_arm_smmu_v3_device *smmu, u32 sid,
 	return 0;
 }
 
+struct smmu_ste_writer {
+	struct arm_smmu_entry_writer writer;
+	struct hyp_arm_smmu_v3_device *smmu;
+	u32 sid;
+};
+
+static void smmu_ste_writer_sync_entry(struct arm_smmu_entry_writer *writer)
+{
+	struct smmu_ste_writer *ste_writer =
+		container_of(writer, struct smmu_ste_writer, writer);
+	struct arm_smmu_cmd cfgi_cmd = arm_smmu_make_cmd_cfgi_ste(ste_writer->sid, true);
+
+	WARN_ON(smmu_send_cmd(ste_writer->smmu, &cfgi_cmd));
+}
+
+static const struct arm_smmu_entry_writer_ops smmu_ste_writer_ops = {
+	.get_used = arm_smmu_get_ste_used,
+	.get_update_safe = arm_smmu_get_ste_update_safe,
+	.sync = smmu_ste_writer_sync_entry,
+};
+
 static int smmu_reshadow_ste(struct hyp_arm_smmu_v3_device *smmu, u32 sid, bool leaf)
 {
 	struct arm_smmu_strtab_cfg *cfg = &smmu->strtab_cfg;
-	struct arm_smmu_ste *hyp_ste_ptr, *host_ste_ptr, host_ste_copy;
+	struct arm_smmu_ste *hyp_ste_ptr;
 	u64 *hyp_ste_base = strtab_hyp_base(smmu);
+	__le64 used[STRTAB_STE_DWORDS] = {};
+	struct arm_smmu_ste target = {};
 	int ret, i;
+	struct smmu_ste_writer ste_writer = {
+		.writer.ops = &smmu_ste_writer_ops,
+		.smmu = smmu,
+		.sid = sid,
+	};
 
 	/* Leaf = 0 is not supported, as the kernel driver. */
 	if (!leaf || !is_smmu_enabled(smmu) ||
@@ -511,7 +590,7 @@ static int smmu_reshadow_ste(struct hyp_arm_smmu_v3_device *smmu, u32 sid, bool
 			return -E2BIG;
 
 		hyp_ste_ptr = &hyp_table[sid];
-		host_ste_ptr = &host_table[sid];
+		memcpy(target.data, host_table[sid].data, STRTAB_STE_DWORDS << 3);
 	} else {
 		struct arm_smmu_strtab_l1 *l1tab = (struct arm_smmu_strtab_l1 *)hyp_ste_base;
 		u32 l1_idx = arm_smmu_strtab_l1_idx(sid);
@@ -520,8 +599,7 @@ static int smmu_reshadow_ste(struct hyp_arm_smmu_v3_device *smmu, u32 sid, bool
 		if (l1_idx >= cfg->l2.num_l1_ents)
 			return -E2BIG;
 
-		host_ste_ptr = &host_ste_copy;
-		ret = smmu_get_host_l2_ste(smmu, sid, host_ste_ptr);
+		ret = smmu_get_host_l2_ste(smmu, sid, &target);
 		if (ret)
 			return ret;
 
@@ -541,8 +619,27 @@ static int smmu_reshadow_ste(struct hyp_arm_smmu_v3_device *smmu, u32 sid, bool
 		hyp_ste_ptr = &l2ptr->stes[arm_smmu_strtab_l2_idx(sid)];
 	}
 
-	for (i = 0; i < STRTAB_STE_DWORDS; ++i)
-		WRITE_ONCE(hyp_ste_ptr->data[i], host_ste_ptr->data[i]);
+	/*
+	 * Summary of each host emulated state vs real HW.
+	 * |	Host	|	HW	|
+	 * ==============================
+	 * |	V=0	|	V=0	|
+	 * |	Abort	|	Abort	|
+	 * |	Bypass	|	S2	|
+	 * |	S1	|	S1+S2	|
+	 */
+	ret = smmu_attach_stage_2(&target);
+	if (ret)
+		return ret;
+
+	/* The HW ignores unused fields, don't let the host set them. */
+	arm_smmu_get_ste_used(target.data, used);
+	for (i = 0; i < STRTAB_STE_DWORDS; i++)
+		target.data[i] &= used[i];
+
+	hyp_spin_lock(&smmu->hw_lock);
+	arm_smmu_write_entry(&ste_writer.writer, hyp_ste_ptr->data, target.data);
+	hyp_spin_unlock(&smmu->hw_lock);
 	return 0;
 }
 
-- 
2.55.0.1082.g2b9226bbc0-goog

