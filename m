Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 974FE2853F1
	for <iommu@lists.linux.dev>; Mon, 28 Jul 2025 17:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753725235; cv=none; b=Cj1Uj4VDFUiSdpfHcVAUH4/F+fimdJhbSVpedOy3nobTB8L0QUHuGrLgzFErtxPXvhtIV5GaEPeEqRq4MfOTQ4tmEtDUV6iVkvbH3/aj3FF5NJiDJG/WoY3JBrxFtOa+VguPFx7trdbgMLsg/YYAMxYJNG3GLSLAJXDMvMO/rlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753725235; c=relaxed/simple;
	bh=+pifKQr5Qh4NMurqKawmpfa05NihZwVLx0NY9kl4hVw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=W/YzVOWxXxhe8wN+X2yepL/ZcMFwWhl4cdQ5YqpYb8A6gDsoG9CPX8wx7zluGdnYpC+WOOzYX/EKdGVxun7GKcCSUXnjxJEzD59TaNof61L2JCaprSpIRJNz0IFbGgfqJNuCMDEwTXWs1e6s/65xeclAvntc1f8SsfiEZ3n9nms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ujrnxjuu; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ujrnxjuu"
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-45611579300so32007285e9.0
        for <iommu@lists.linux.dev>; Mon, 28 Jul 2025 10:53:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753725231; x=1754330031; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=l5usyBMYtPhEtq515HRsyRf5iQD/7LGEqXNtQxILf1Y=;
        b=Ujrnxjuu8E/Tt5nBy1JpKkJOUNQbxu8LVDYptpl3U8JvYWrwJvlbtZNvrX2CjqGHLJ
         qbwpFlNS7k3mjeJOLp9W7CTRV8AnCF1ePn24o1zZM18aC6nuc1N9bH6u5ouTmyO7JQoT
         XErWnHSnsi5+fqQnKGavWPAs7dXkRCkXCmGloC561gPTcr7/3zv1YcwmoP58KnG62Es/
         GvsRyoiTp4IAsOrQaN1L7EoPBKAYeEseLvDaZwrtfc9EJiNMFucbsFBa7DSimlnGIpxV
         22yOLjZ+J8ing+Sh0FYjZN1AK/hd4ZLpozZhW9S2BdE30FIjqGC4Fy20vnTVZlRfYgfd
         RN9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753725231; x=1754330031;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l5usyBMYtPhEtq515HRsyRf5iQD/7LGEqXNtQxILf1Y=;
        b=R5jPm8Y1Up3R41HtgkMLOmRPQDci8WRbq3FJQ0MzbGgh1PsSZJeT0EGaFBUJYDa8k4
         fUY5cBnYFHMX56RechZYMK8kDyitkpvnTgBBS9VeWoCrTYefTbG3wrM2sSKodrGEzbf5
         hkFYOoY0/sh+jISXynloynUbdO4GYjw8sRnA6Q/fUOVwjNOgJ0y9kj0k0BSAcEf34l5r
         D3jf26ZcD/8JGeOgpz4QyT8xTNYIgDDIW1Ls3Wys1XaNpo6uw8QZKmoWPbjya0UDE9HX
         Z+yIUaXE+ezWr+e/CqS8dDN27CdxplBecC+PhYTW+voFNQc1gKI/sVrqG/Dux3QOBW1P
         k3gQ==
X-Forwarded-Encrypted: i=1; AJvYcCVj2aoIk/uUkbUC/EN11Vj04mwwsEJk2enhzSO3UFVFS1ValdmQEtt9SLnBUz9PML28wrQ4yA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy7HHdtuXWgp2DgQqBHmPOPeKk4ryU6uEClCTSzDjzucQDE7tAr
	vp3HijVJezNAlIG2ewcpZB4V+HAUOE7bzVHclCVKwKvdINZia/o037zEpmT5/kV0mfV1nQxCEJS
	vWVPeB28uEmYqDQ==
X-Google-Smtp-Source: AGHT+IEOasiCkaHWORBz/kHZ+SsH5TCiId9F4oswqdHG41LqtBvjent3B9CKHId8hskBgKaxbm/Ao9Q5mfQBGA==
X-Received: from wmsd5.prod.google.com ([2002:a05:600c:3ac5:b0:456:134a:a210])
 (user=smostafa job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:1d24:b0:455:de98:c504 with SMTP id 5b1f17b1804b1-4588b5fb608mr28234885e9.0.1753725230800;
 Mon, 28 Jul 2025 10:53:50 -0700 (PDT)
Date: Mon, 28 Jul 2025 17:53:08 +0000
In-Reply-To: <20250728175316.3706196-1-smostafa@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250728175316.3706196-1-smostafa@google.com>
X-Mailer: git-send-email 2.50.1.552.g942d659e1b-goog
Message-ID: <20250728175316.3706196-22-smostafa@google.com>
Subject: [PATCH v3 21/29] iommu/arm-smmu-v3-kvm: Setup stream table
From: Mostafa Saleh <smostafa@google.com>
To: linux-kernel@vger.kernel.org, kvmarm@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev
Cc: maz@kernel.org, oliver.upton@linux.dev, joey.gouly@arm.com, 
	suzuki.poulose@arm.com, yuzenghui@huawei.com, catalin.marinas@arm.com, 
	will@kernel.org, robin.murphy@arm.com, jean-philippe@linaro.org, 
	qperret@google.com, tabba@google.com, jgg@ziepe.ca, mark.rutland@arm.com, 
	praan@google.com, Mostafa Saleh <smostafa@google.com>
Content-Type: text/plain; charset="UTF-8"

Map the stream table allocated by the host into the hypervisor address
space. When the host mappings are finalized, the table is unmapped from
the host. Depending on the host configuration, the stream table may have
one or two levels. Populate the level-2 stream table lazily.

Also, add accessors for STEs.

Signed-off-by: Mostafa Saleh <smostafa@google.com>
Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 .../arm/arm-smmu-v3/arm-smmu-v3-common.h      |  16 +++
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  16 ---
 .../iommu/arm/arm-smmu-v3/pkvm/arm-smmu-v3.c  | 102 +++++++++++++++++-
 .../iommu/arm/arm-smmu-v3/pkvm/arm_smmu_v3.h  |   2 +
 4 files changed, 119 insertions(+), 17 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-common.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-common.h
index ab6db8b4b9f2..a24fdbdaeb74 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-common.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-common.h
@@ -499,6 +499,22 @@ struct arm_smmu_queue {
 					 Q_IDX(&((q)->llq), p) *	\
 					 (q)->ent_dwords)
 
+struct arm_smmu_strtab_cfg {
+	union {
+		struct {
+			struct arm_smmu_ste *table;
+			dma_addr_t ste_dma;
+			unsigned int num_ents;
+		} linear;
+		struct {
+			struct arm_smmu_strtab_l1 *l1tab;
+			struct arm_smmu_strtab_l2 **l2ptrs;
+			dma_addr_t l1_dma;
+			unsigned int num_l1_ents;
+		} l2;
+	};
+};
+
 static inline void arm_smmu_write_strtab_l1_desc(struct arm_smmu_strtab_l1 *dst,
 						 dma_addr_t l2ptr_dma)
 {
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index f9a496e0bd94..480463ec118a 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -232,22 +232,6 @@ struct arm_smmu_s2_cfg {
 	u16				vmid;
 };
 
-struct arm_smmu_strtab_cfg {
-	union {
-		struct {
-			struct arm_smmu_ste *table;
-			dma_addr_t ste_dma;
-			unsigned int num_ents;
-		} linear;
-		struct {
-			struct arm_smmu_strtab_l1 *l1tab;
-			struct arm_smmu_strtab_l2 **l2ptrs;
-			dma_addr_t l1_dma;
-			unsigned int num_l1_ents;
-		} l2;
-	};
-};
-
 struct arm_smmu_impl_ops {
 	int (*device_reset)(struct arm_smmu_device *smmu);
 	void (*device_remove)(struct arm_smmu_device *smmu);
diff --git a/drivers/iommu/arm/arm-smmu-v3/pkvm/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/pkvm/arm-smmu-v3.c
index c3d67c603619..74e6dfb53528 100644
--- a/drivers/iommu/arm/arm-smmu-v3/pkvm/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/pkvm/arm-smmu-v3.c
@@ -119,7 +119,6 @@ static int smmu_sync_cmd(struct hyp_arm_smmu_v3_device *smmu)
 	return smmu_wait_event(smmu, smmu_cmdq_empty(&smmu->cmdq));
 }
 
-__maybe_unused
 static int smmu_send_cmd(struct hyp_arm_smmu_v3_device *smmu,
 			 struct arm_smmu_cmdq_ent *cmd)
 {
@@ -131,6 +130,80 @@ static int smmu_send_cmd(struct hyp_arm_smmu_v3_device *smmu,
 	return smmu_sync_cmd(smmu);
 }
 
+__maybe_unused
+static int smmu_sync_ste(struct hyp_arm_smmu_v3_device *smmu, u32 sid, unsigned long ste)
+{
+	struct arm_smmu_cmdq_ent cmd = {
+		.opcode = CMDQ_OP_CFGI_STE,
+		.cfgi.sid = sid,
+		.cfgi.leaf = true,
+	};
+
+	/*
+	 * In case of 2 level STEs, L2 is allocated as cacheable, so flush it everytime
+	 * we update the STE.
+	 */
+	if (!(smmu->features & ARM_SMMU_FEAT_COHERENCY) &&
+	    (smmu->features & ARM_SMMU_FEAT_2_LVL_STRTAB))
+		kvm_flush_dcache_to_poc(ste, sizeof(struct arm_smmu_ste));
+	return smmu_send_cmd(smmu, &cmd);
+}
+
+static int smmu_alloc_l2_strtab(struct hyp_arm_smmu_v3_device *smmu, u32 sid)
+{
+	struct arm_smmu_strtab_cfg *cfg = &smmu->strtab_cfg;
+	struct arm_smmu_strtab_l1 *l1_desc;
+	struct arm_smmu_strtab_l2 *l2table;
+
+	l1_desc = &cfg->l2.l1tab[arm_smmu_strtab_l1_idx(sid)];
+	if (l1_desc->l2ptr)
+		return 0;
+
+	l2table = kvm_iommu_donate_pages(get_order(sizeof(*l2table)));
+	if (!l2table)
+		return -ENOMEM;
+
+	arm_smmu_write_strtab_l1_desc(l1_desc, hyp_virt_to_phys(l2table));
+	if (!(smmu->features & ARM_SMMU_FEAT_COHERENCY))
+		kvm_flush_dcache_to_poc(l1_desc, sizeof(*l1_desc));
+	return 0;
+}
+
+static struct arm_smmu_ste *
+smmu_get_ste_ptr(struct hyp_arm_smmu_v3_device *smmu, u32 sid)
+{
+	struct arm_smmu_strtab_cfg *cfg = &smmu->strtab_cfg;
+
+	if (smmu->features & ARM_SMMU_FEAT_2_LVL_STRTAB) {
+		u32 l1_idx = arm_smmu_strtab_l1_idx(sid);
+		struct arm_smmu_strtab_l2 *l2ptr;
+
+		if (l1_idx >= cfg->l2.num_l1_ents)
+			return NULL;
+		l2ptr = hyp_phys_to_virt(cfg->l2.l1tab[l1_idx].l2ptr & STRTAB_L1_DESC_L2PTR_MASK);
+		/* Two-level walk */
+		return &l2ptr->stes[arm_smmu_strtab_l2_idx(sid)];
+	}
+
+	if (sid >= cfg->linear.num_ents)
+		return NULL;
+	/* Simple linear lookup */
+	return &cfg->linear.table[sid];
+}
+
+__maybe_unused
+static struct arm_smmu_ste *
+smmu_get_alloc_ste_ptr(struct hyp_arm_smmu_v3_device *smmu, u32 sid)
+{
+	if (smmu->features & ARM_SMMU_FEAT_2_LVL_STRTAB) {
+		int ret = smmu_alloc_l2_strtab(smmu, sid);
+
+		if (ret)
+			return NULL;
+	}
+	return smmu_get_ste_ptr(smmu, sid);
+}
+
 static int smmu_init_registers(struct hyp_arm_smmu_v3_device *smmu)
 {
 	u64 val, old;
@@ -205,6 +278,29 @@ static int smmu_init_cmdq(struct hyp_arm_smmu_v3_device *smmu)
 	return 0;
 }
 
+static int smmu_init_strtab(struct hyp_arm_smmu_v3_device *smmu)
+{
+	size_t strtab_size;
+	u64 strtab_base;
+	struct arm_smmu_strtab_cfg *cfg = &smmu->strtab_cfg;
+	enum kvm_pgtable_prot prot = PAGE_HYP;
+
+	if (!(smmu->features & ARM_SMMU_FEAT_COHERENCY))
+		prot |= KVM_PGTABLE_PROT_NORMAL_NC;
+
+	if (smmu->features & ARM_SMMU_FEAT_2_LVL_STRTAB) {
+		strtab_size = PAGE_ALIGN(cfg->l2.num_l1_ents * sizeof(struct arm_smmu_strtab_l1));
+		strtab_base = (u64)cfg->l2.l1_dma;
+		cfg->linear.table = hyp_phys_to_virt(strtab_base);
+	} else {
+		strtab_size = PAGE_ALIGN(cfg->linear.num_ents * sizeof(struct arm_smmu_ste));
+		strtab_base = (u64)cfg->linear.ste_dma;
+		cfg->l2.l1tab = hyp_phys_to_virt(strtab_base);
+	}
+	return ___pkvm_host_donate_hyp(hyp_phys_to_pfn(strtab_base),
+				       strtab_size >> PAGE_SHIFT, prot);
+}
+
 static int smmu_init_device(struct hyp_arm_smmu_v3_device *smmu)
 {
 	int i;
@@ -233,6 +329,10 @@ static int smmu_init_device(struct hyp_arm_smmu_v3_device *smmu)
 	if (ret)
 		goto out_err;
 
+	ret = smmu_init_strtab(smmu);
+	if (ret)
+		goto out_err;
+
 	return ret;
 
 out_err:
diff --git a/drivers/iommu/arm/arm-smmu-v3/pkvm/arm_smmu_v3.h b/drivers/iommu/arm/arm-smmu-v3/pkvm/arm_smmu_v3.h
index f639312cf295..d188537545b1 100644
--- a/drivers/iommu/arm/arm-smmu-v3/pkvm/arm_smmu_v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/pkvm/arm_smmu_v3.h
@@ -13,6 +13,7 @@
  * @base		Virtual address of SMMU registers
  * @features		SMMUv3 features as defined in arm-smmu-v3-common.h
  * @cmdq		CMDQ queue struct
+ * @strtab_cfg		stream table config, strtab_cfg.l2.l2ptrs is not used
  * Other members are filled and used at runtime by the SMMU driver.
  */
 struct hyp_arm_smmu_v3_device {
@@ -21,6 +22,7 @@ struct hyp_arm_smmu_v3_device {
 	void __iomem		*base;
 	unsigned long		features;
 	struct arm_smmu_queue	cmdq;
+	struct arm_smmu_strtab_cfg strtab_cfg;
 };
 
 extern size_t kvm_nvhe_sym(kvm_hyp_arm_smmu_v3_count);
-- 
2.50.1.552.g942d659e1b-goog

