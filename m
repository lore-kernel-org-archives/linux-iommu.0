Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com [209.85.128.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 554C658E2A3
	for <iommu@lists.linux.dev>; Thu, 15 Oct 2026 20:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792094974; cv=none; b=jdqTU3CyamWDYt/nD7t2igX9+Mcf/ylvMvaX2hFjJ2JdS05B3aYJETdeukueTwl0R5l5+TZ/6YURKRgwwJ3/bS0o/NOEFzrf4znyGSJ/ES4iCUSaqXDSk3D2buVCpkEYj2WfuOVeolczJAxPRnvKmcL0cAGLgGIvO5PPjqqIrj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792094974; c=relaxed/simple;
	bh=ZJK1kmjG/RFwnOjvDQYvKcQ3fO2aN12GQvMf9Dol6VY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=LDoYHL5FnaT56TGHAdZ2ZnXxzUVRPsU4BfQ7DeDV8NTFTIPx0/QSLjNlCVhGayIWoaf1gdUzuOCgBpS1PIG76B518VSrixIMpQZq3rjEIs0RyI6lC72tbswJFs48ZCCx1Rj6P2Zeen2M3n/DO2nPsRV4+LPkSXS2cD31T5juC5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RqXIttp7; arc=none smtp.client-ip=209.85.128.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RqXIttp7"
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4a1ac6663e1so30979035e9.0
        for <iommu@lists.linux.dev>; Thu, 15 Oct 2026 13:09:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792094970; x=1792699770; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0Bi/zP2WEVGciETaGfBszben9Iy5rJdDBhJW2dD5Omo=;
        b=RqXIttp73YwQHUAmXvk2rrcFHrHuR1pWi1bQjxJ5TB08Cu1hNWovLJk7v7RnA6n0aC
         /xyhrXeqGUVBk3Op/QahsotKf/jSiOMKLIE7HkT+3XDcIWJqAGeeaCXpZQwHrkM6HIhI
         8PpRPS1QWww9CBY2BqQ304pMpBlotF9L3fXgnSoSWD35aRKTl5Ss+EbNu/JXJpMH9NPi
         2yp7mzAdySW8tZBs0fhWbBE7jswhyeVVp7Dck3lH1reAd8m9ztY5fNSTs/mQD/RqMED0
         r9qyTRHOhnvKDIBVxv9U+yhqCFpLfj/bgpQS1JHIXh4mJ4cEaCogHjilPB8OrhoeEBCi
         KG2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792094970; x=1792699770;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0Bi/zP2WEVGciETaGfBszben9Iy5rJdDBhJW2dD5Omo=;
        b=eKKIFQqtustBP9n2LMH4oW/G40fYoxN6DAbhr5kP3ie7w3j7Bzyg+PkpFVoWiqGyvg
         jPmJsriEiw9U9YZXvoSGK5mQ7r5s595oMqvRuZnEJD8mfjC5dwq5hgD1HU6Ws5qXdagx
         /UD0EPaw3dA7N6H4NhAqmDqOCZVXEqngJDoskDyVn3McGjicxieknBMeDJcdqSXDi9bq
         wIi0gKB14dyTmlffB7JOFUy7cyUtgb5Xn2oOTGtw2yOpvqUhMHqSStXS0iAwsEsZ82Rw
         usq4z1FMTMxscb05oPJr9q2ejdpGqCqf3zVaECQztDOAhNBXLQhIUt1aPEMDdyXyaOKv
         TIuQ==
X-Forwarded-Encrypted: i=1; AKwUvByb4pYteNUv1ekBTDTBaLC9VeZl5wW0DzPhqhACptar9qgRjDNRNq35hvhxGgDyEYbBsV1mdQ==@lists.linux.dev
X-Gm-Message-State: AFq9FYLdmIU7t3LOtln8m9gWYOweo3W9MxVw9PMMK9MXQ1NEtsjCT5te
	XL02tTYyHBiPfXNdd0MNcwd4ELVb35rphAKQ0oKReFXf7EoDACTlcMyyPqqg6mgvb8gSqYgD1YY
	wdD4nP4snaejD2w==
X-Received: from wmsp12.prod.google.com ([2002:a05:600c:1d8c:b0:4a1:c745:6233])
 (user=smostafa job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:19c8:b0:4a1:7bae:d80a with SMTP id 5b1f17b1804b1-4a18e47ad49mr419007385e9.9.1792094970227;
 Thu, 15 Oct 2026 13:09:30 -0700 (PDT)
Date: Thu, 15 Oct 2026 20:08:47 +0000
In-Reply-To: <20261015200903.2735565-1-smostafa@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20261015200903.2735565-1-smostafa@google.com>
X-Mailer: git-send-email 2.56.0.176.g3575e65682-goog
Message-ID: <20261015200903.2735565-17-smostafa@google.com>
Subject: [PATCH v9 16/25] iommu/arm-smmu-v3-kvm: Emulate CMDQ for host
From: Mostafa Saleh <smostafa@google.com>
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	kvmarm@lists.linux.dev, iommu@lists.linux.dev
Cc: catalin.marinas@arm.com, will@kernel.org, maz@kernel.org, 
	oliver.upton@linux.dev, joey.gouly@arm.com, suzuki.poulose@arm.com, 
	yuzenghui@huawei.com, joro@8bytes.org, jgg@ziepe.ca, mark.rutland@arm.com, 
	qperret@google.com, tabba@google.com, vdonnefort@google.com, 
	nicolinc@nvidia.com, Mostafa Saleh <smostafa@google.com>
Content-Type: text/plain; charset="UTF-8"

Take the command queue away from the host:
- ARM_SMMU_CMDQ_BASE: writes are only accepted while the command queue
  is disabled and record the host queue base. Reads return the saved
  value.
- ARM_SMMU_CMDQ_PROD: writes run the emulation, which copies, checks
  and filters every pending command into the shadow queue, ends the
  batch with a CMD_SYNC and waits for the hardware to drain it, so the
  host's view of CONS never runs ahead of completion. Reads return the
  host copy.
- ARM_SMMU_CMDQ_CONS: writes update the software copy and are only
  accepted while the queue is disabled, so the host cannot skip
  submitted commands. Reads return the emulated value plus the error
  bits of the hardware CONS.

Commands the filter rejects are fatal, as no well-behaved host issues
them.

Also emulate IDR1.CMDQS to advertise the shadow queue size, which can
be smaller than the hardware's.

Signed-off-by: Mostafa Saleh <smostafa@google.com>
---
 .../arm/arm-smmu-v3/pkvm/arm-smmu-v3-hyp.c    | 150 +++++++++++++++++-
 1 file changed, 145 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/pkvm/arm-smmu-v3-hyp.c b/drivers/iommu/arm/arm-smmu-v3/pkvm/arm-smmu-v3-hyp.c
index c9fc21e405e7..dc9b1e659a42 100644
--- a/drivers/iommu/arm/arm-smmu-v3/pkvm/arm-smmu-v3-hyp.c
+++ b/drivers/iommu/arm/arm-smmu-v3/pkvm/arm-smmu-v3-hyp.c
@@ -113,7 +113,6 @@ static int smmu_unshare_pages(phys_addr_t addr, size_t size)
 	return 0;
 }
 
-__maybe_unused
 static bool smmu_cmdq_has_space(struct arm_smmu_queue *cmdq, u32 n)
 {
 	struct arm_smmu_ll_queue *llq = &cmdq->llq;
@@ -344,6 +343,104 @@ static int smmu_init(void)
 	return ret;
 }
 
+static bool smmu_filter_command(struct hyp_arm_smmu_v3_device *smmu, u64 *command)
+{
+	u64 type = FIELD_GET(CMDQ_0_OP, command[0]);
+
+	switch (type) {
+	case CMDQ_OP_CFGI_STE:
+		/* TBD: SHADOW_STE*/
+		break;
+	case CMDQ_OP_CFGI_ALL:
+	{
+		/*
+		 * Linux doesn't use range STE invalidation, and only use this
+		 * for CFGI_ALL, which is done on reset and not on an new STE
+		 * being used.
+		 * Although, this is not architectural we rely on the current Linux
+		 * implementation.
+		 */
+		if ((FIELD_GET(CMDQ_CFGI_1_RANGE, command[1]) != 31))
+			return true;
+		break;
+	}
+	case CMDQ_OP_TLBI_NH_ASID:
+	case CMDQ_OP_TLBI_NH_VA:
+	case CMDQ_OP_TLBI_NH_ALL:
+	case 0x13: /* CMD_TLBI_NH_VAA: Not used by Linux */
+	{
+		/* Only allow VMID = 0 */
+		if (FIELD_GET(CMDQ_TLBI_0_VMID, command[0]) != 0)
+			return true;
+		break;
+	}
+	case CMDQ_OP_PREFETCH_CFG:
+	case CMDQ_OP_CFGI_CD:
+	case CMDQ_OP_CFGI_CD_ALL:
+	case CMDQ_OP_TLBI_NSNH_ALL:
+	case CMDQ_OP_PRI_RESP:
+	case CMDQ_OP_RESUME:
+		break;
+	case CMDQ_OP_CMD_SYNC:
+		if (FIELD_GET(CMDQ_SYNC_0_CS, command[0]) == CMDQ_SYNC_0_CS_IRQ) {
+			/* Do not allow MSI */
+			command[0] &= ~CMDQ_SYNC_0_CS;
+			command[0] |= FIELD_PREP(CMDQ_SYNC_0_CS, CMDQ_SYNC_0_CS_SEV);
+			command[1] &= ~CMDQ_SYNC_1_MSIADDR_MASK;
+		}
+		break;
+	default:
+		/* Deny unknown commands */
+		return true;
+	}
+
+	return false;
+}
+
+static int smmu_emulate_cmdq_insert(struct hyp_arm_smmu_v3_device *smmu)
+{
+	u64 *host_cmdq = hyp_phys_to_virt(smmu->cmdq_host.base_dma);
+	u64 cmd[CMDQ_ENT_DWORDS];
+	int idx, ret;
+	u32 pending;
+	bool skip;
+
+	if (!is_cmdq_enabled(smmu))
+		return 0;
+
+	pending = (1 << (smmu->cmdq_host.llq.max_n_shift)) - queue_space(&smmu->cmdq_host.llq);
+
+	hyp_spin_lock(&smmu->hw_lock);
+	/* Wait for the command queue to have some space. */
+	ret = smmu_wait(false, smmu_cmdq_has_space(&smmu->cmdq, pending));
+	if (ret) {
+		hyp_spin_unlock(&smmu->hw_lock);
+		return ret;
+	}
+
+	while (pending--) {
+		int i;
+
+		idx = Q_IDX(&smmu->cmdq_host.llq, smmu->cmdq_host.llq.cons);
+		queue_inc_cons(&smmu->cmdq_host.llq);
+
+		/* Copy the command to local buffer avoiding TOCTOU */
+		for (i = 0; i < CMDQ_ENT_DWORDS; ++i)
+			cmd[i] = le64_to_cpu(READ_ONCE(host_cmdq[idx * CMDQ_ENT_DWORDS + i]));
+
+		skip = smmu_filter_command(smmu, cmd);
+		if (WARN_ON(skip))
+			continue;
+		smmu_add_cmd_raw(smmu, cmd);
+	}
+
+	writel(smmu->cmdq.llq.prod, smmu->cmdq.prod_reg);
+
+	ret = smmu_wait(false, smmu_cmdq_empty(&smmu->cmdq));
+	hyp_spin_unlock(&smmu->hw_lock);
+	return ret;
+}
+
 static void smmu_emulate_cmdq_enable(struct hyp_arm_smmu_v3_device *smmu)
 {
 	u32 shift = smmu->cmdq_host.q_base & Q_BASE_LOG2SIZE;
@@ -385,18 +482,51 @@ static bool smmu_dabt_device(struct hyp_arm_smmu_v3_device *smmu,
 		 */
 		mask = read_only & ~(IDR0_S2P | IDR0_VMID16 | IDR0_MSI | IDR0_HYP | IDR0_ATS);
 		break;
-	/* Passthrough the register access for bisectability, handled later */
 	case ARM_SMMU_CMDQ_BASE:
+		/*
+		 * Although allowed to use smaller size, we rely on the SMMUv3 driver
+		 * using 64-bit store instruction for simplicity.
+		 */
+		if (len != sizeof(u64))
+			break;
 		if (is_write) {
 			/* Not allowed by the architecture */
 			if (is_cmdq_enabled(smmu))
 				break;
 			smmu->cmdq_host.q_base = val;
+			goto out_ret;
+		} else {
+			val = smmu->cmdq_host.q_base;
+			goto out_update_regs;
 		}
-		mask = read_write;
-		break;
 	case ARM_SMMU_CMDQ_PROD:
+		if (len != sizeof(u32))
+			break;
+		if (is_write) {
+			smmu->cmdq_host.llq.prod = val;
+			WARN_ON(smmu_emulate_cmdq_insert(smmu));
+			goto out_ret;
+		} else {
+			val = smmu->cmdq_host.llq.prod;
+			goto out_update_regs;
+		}
 	case ARM_SMMU_CMDQ_CONS:
+		if (len != sizeof(u32))
+			break;
+		if (is_write) {
+			if (WARN_ON(is_cmdq_enabled(smmu)))
+				break;
+
+			smmu->cmdq_host.llq.cons = val;
+			goto out_ret;
+		} else {
+			/* Propagate errors back to the host.*/
+			u32 cons = readl_relaxed(smmu->base + ARM_SMMU_CMDQ_CONS);
+
+			val = smmu->cmdq_host.llq.cons | (CMDQ_CONS_ERR & cons);
+			goto out_update_regs;
+		}
+	/* Passthrough the register access for bisectability, handled later */
 	case ARM_SMMU_STRTAB_BASE:
 	case ARM_SMMU_STRTAB_BASE_CFG:
 	case ARM_SMMU_GBPA:
@@ -481,10 +611,20 @@ static bool smmu_dabt_device(struct hyp_arm_smmu_v3_device *smmu,
 		mask = read_write;
 		break;
 	/* Allowed RO 32 bit registers. */
+	case ARM_SMMU_IDR1:
+		if (len != sizeof(u32))
+			break;
+		/* Cap CMDQS to the shadow queue size. */
+		if (!is_write) {
+			val = readl_relaxed(smmu->base + ARM_SMMU_IDR1);
+			val &= ~IDR1_CMDQS;
+			val |= FIELD_PREP(IDR1_CMDQS, smmu->cmdq.llq.max_n_shift);
+			goto out_update_regs;
+		}
+	fallthrough;
 	case ARM_SMMU_IIDR:
 	case ARM_SMMU_IDR5:
 	case ARM_SMMU_IDR3:
-	case ARM_SMMU_IDR1:
 	case ARM_SMMU_IRQ_CTRLACK:
 	case ARM_SMMU_GERROR:
 		if (len != sizeof(u32))
-- 
2.56.0.176.g3575e65682-goog

