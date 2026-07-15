Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0BBB4779B9
	for <iommu@lists.linux.dev>; Wed, 15 Jul 2026 11:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784116778; cv=none; b=rswrC+XuoLYDNBiKFrrFU2QS5NwqJLaqDMpdr824v7sQ9dXbJ8P7DyqfngjPa91l7lLXDA0edGoGlP+n2Rjww20YSOeq/joY6nuu5Bj/G3aQ+lBFkkwpsbArNgre4hBcB/54SWLBHBog5TyxEKiZiIVGZOYpWaujG3RxH0bOfmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784116778; c=relaxed/simple;
	bh=YePeblpzE2wwy186w59Vlsd4xF4gXljPMBZRLISQyw0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Jmg1R7v2G+AiESXaWCNQxwMppTEUryD9q2mGSaPVdiwBTUmdKdpZ3knN+UWcVYgSjq5GHvSD4IbK5Gow/WGkWJ0SPzzd+s6rD94Y+bX2GVBpjFKdvlnDPrOteQpJ5sTe/jtjTH7XCR9GAQVxYTkfYn253oSC6qw+QXIKZaqjWV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tWA9vKhm; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tWA9vKhm"
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-473f4a48e9aso3573865f8f.2
        for <iommu@lists.linux.dev>; Wed, 15 Jul 2026 04:59:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784116774; x=1784721574; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=XAFQ5BsXp17z8wDAJzX50F8XvcTlSxFTjmAveWqMmq0=;
        b=tWA9vKhmBugLK0UoFHvo1dhyovoHNPMczE/CUEoQawVmSXk4D0hf7xDhtJNJiZMKs7
         G5sjUHA1zP8mWcjH6M9OdQG9CbtlRar4rDrfHyfrZOGeQbUMpkK2SpuyEbxwRAnTnEpv
         4lJiskLeSItYGaw9qWk7TtzVlzOgc1VTpuK9Jq2nhnQUPrABFT+VaIFgg/KIxv8CyDdH
         SKdBMvTFPkufDbfZMCenHioijX6zRpriQgyhku5pnSbNd72G4uFQJ+xeJkjBiUEmc/vq
         5Ec+g8JxBa+c7KSyQRYnPcIZOyf+tT+gtKOtNg0r4MB3jaRIIj14sXgnyGNn5F6+COYF
         Xk7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784116774; x=1784721574;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XAFQ5BsXp17z8wDAJzX50F8XvcTlSxFTjmAveWqMmq0=;
        b=JjgOxOv+pvVdOEwYOWzWm9siASfPeUse1VlVbsTi5UktkDmyGkS1tL5kqlR5RB/U09
         vhRMX1SI9QuH1FYpigUCX3fsKv/6TqOCsVXQEwE5YMyAj8zhmFhpNMRbAWBXOdMJyrBM
         qNGRMyiOan2lfSlQUm9dHZ6CoilcIdOh+31IWm5LlBy2EqDOIDoUJaiPZhxdD2ph0u7j
         uDzYTkXSg4z2+nSElSPHm9mD073BeElyIzKYbxfYKtOu7EvgfX1VZR5o/asQClD0jMNE
         lQYajbEQjq+SbT1dK7e4VK1q9o5lO3dA66P2JuanzK62xPvF6YHECHttRQNFcWFjhf3+
         pFKQ==
X-Forwarded-Encrypted: i=1; AHgh+RoollHs8eBj58iLeFaOwy3brWLzOC/yLPmQSHy1+7w/z9bodb8DPkSY3CBXcwDJydMnS4X6YQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyK9LmL6Z3T2rPyByUGbpI7ItCwRjHhEF5oIWPokrrhGJoW6bPr
	ZcWu8THJn5eANUNIEsUCSCPw0vuQX6bAINZ0Z8139dOGzRA3tsusg1F/55BewiIOnqcTR3fuZg1
	LsftDLwzsjAkuTQ==
X-Received: from wmga21.prod.google.com ([2002:a05:600c:2d55:b0:490:b58a:2c9b])
 (user=smostafa job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:3486:b0:493:b7a6:3dac with SMTP id 5b1f17b1804b1-4953b156ee2mr37104465e9.33.1784116773557;
 Wed, 15 Jul 2026 04:59:33 -0700 (PDT)
Date: Wed, 15 Jul 2026 11:58:57 +0000
In-Reply-To: <20260715115906.2664882-1-smostafa@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260715115906.2664882-1-smostafa@google.com>
X-Mailer: git-send-email 2.55.0.141.g00534a21ce-goog
Message-ID: <20260715115906.2664882-17-smostafa@google.com>
Subject: [PATCH v7 16/24] iommu/arm-smmu-v3-kvm: Emulate CMDQ for host
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
Content-Transfer-Encoding: quoted-printable

Don=E2=80=99t allow access to the command queue from the host:
- ARM_SMMU_CMDQ_BASE: Only allowed to be written when CMDQ is disabled, we
  use it to keep track of the host command queue base.
  Reads return the saved value.
- ARM_SMMU_CMDQ_PROD: Writes trigger command queue emulation which sanitise
  and filters the whole range. Reads returns the host copy.
- ARM_SMMU_CMDQ_CONS: Writes move the sw copy of the cons, but the host
  can=E2=80=99t skip commands once submitted. Reads return the emulated val=
ue and
  the error bits in the actual cons.

Signed-off-by: Mostafa Saleh <smostafa@google.com>
---
 .../iommu/arm/arm-smmu-v3/pkvm/arm-smmu-v3.c  | 133 +++++++++++++++++-
 1 file changed, 129 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/pkvm/arm-smmu-v3.c b/drivers/iom=
mu/arm/arm-smmu-v3/pkvm/arm-smmu-v3.c
index 8e798fd8fdaa..f62c9e8f2c59 100644
--- a/drivers/iommu/arm/arm-smmu-v3/pkvm/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/pkvm/arm-smmu-v3.c
@@ -105,7 +105,6 @@ static int smmu_unshare_pages(phys_addr_t addr, size_t =
size)
 	return 0;
 }
=20
-__maybe_unused
 static bool smmu_cmdq_has_space(struct arm_smmu_queue *cmdq, u32 n)
 {
 	struct arm_smmu_ll_queue *llq =3D &cmdq->llq;
@@ -330,6 +329,99 @@ static int smmu_init(void)
 	return ret;
 }
=20
+static bool smmu_filter_command(struct hyp_arm_smmu_v3_device *smmu, u64 *=
command)
+{
+	u64 type =3D FIELD_GET(CMDQ_0_OP, command[0]);
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
+		if ((FIELD_GET(CMDQ_CFGI_1_RANGE, command[1]) !=3D 31))
+			return true;
+		break;
+	}
+	case CMDQ_OP_TLBI_NH_ASID:
+	case CMDQ_OP_TLBI_NH_VA:
+	case 0x13: /* CMD_TLBI_NH_VAA: Not used by Linux */
+	{
+		/* Only allow VMID =3D 0 */
+		if (FIELD_GET(CMDQ_TLBI_0_VMID, command[0]) !=3D 0)
+			return true;
+		break;
+	}
+	case CMDQ_OP_PREFETCH_CFG:
+	case CMDQ_OP_CFGI_CD:
+	case CMDQ_OP_CFGI_CD_ALL:
+	case CMDQ_OP_TLBI_NH_ALL:
+	case CMDQ_OP_TLBI_NSNH_ALL:
+		break;
+	case CMDQ_OP_CMD_SYNC:
+		if (FIELD_GET(CMDQ_SYNC_0_CS, command[0]) =3D=3D CMDQ_SYNC_0_CS_IRQ) {
+			/* Allow it, but let the host timeout, as this should never happen. */
+			command[0] &=3D ~CMDQ_SYNC_0_CS;
+			command[0] |=3D FIELD_PREP(CMDQ_SYNC_0_CS, CMDQ_SYNC_0_CS_SEV);
+			command[1] &=3D ~CMDQ_SYNC_1_MSIADDR_MASK;
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
+	u64 *host_cmdq =3D hyp_phys_to_virt(smmu->cmdq_host.base_dma);
+	bool use_wfe =3D smmu->features & ARM_SMMU_FEAT_SEV, skip;
+	u64 cmd[CMDQ_ENT_DWORDS];
+	int idx, ret;
+	u32 space;
+
+	if (!is_cmdq_enabled(smmu))
+		return 0;
+
+	space =3D (1 << (smmu->cmdq_host.llq.max_n_shift)) - queue_space(&smmu->c=
mdq_host.llq);
+
+	/* Wait for the command queue to have some space. */
+	ret =3D smmu_wait(use_wfe, smmu_cmdq_has_space(&smmu->cmdq, space));
+	if (ret)
+		return ret;
+	hyp_spin_lock(&smmu->hw_lock);
+	while (space--) {
+		int i;
+
+		idx =3D Q_IDX(&smmu->cmdq_host.llq, smmu->cmdq_host.llq.cons);
+		queue_inc_cons(&smmu->cmdq_host.llq);
+
+		/* Copy the command to local buffer avoiding TOCTOU */
+		for (i =3D 0 ; i < CMDQ_ENT_DWORDS ; ++i)
+			cmd[i] =3D le64_to_cpu(READ_ONCE(host_cmdq[idx * CMDQ_ENT_DWORDS + i]))=
;
+
+		skip =3D smmu_filter_command(smmu, cmd);
+		if (WARN_ON(skip))
+			continue;
+		smmu_add_cmd_raw(smmu, cmd);
+	}
+
+	writel(smmu->cmdq.llq.prod, smmu->cmdq.prod_reg);
+
+	ret =3D smmu_wait(use_wfe, smmu_cmdq_empty(&smmu->cmdq));
+	hyp_spin_unlock(&smmu->hw_lock);
+	return ret;
+}
+
 static void smmu_emulate_cmdq_enable(struct hyp_arm_smmu_v3_device *smmu)
 {
 	u32 shift =3D smmu->cmdq_host.q_base & Q_BASE_LOG2SIZE;
@@ -371,18 +463,51 @@ static bool smmu_dabt_device(struct hyp_arm_smmu_v3_d=
evice *smmu,
 		 */
 		mask =3D read_only & ~(IDR0_S2P | IDR0_VMID16 | IDR0_MSI | IDR0_HYP | ID=
R0_ATS);
 		break;
-	/* Passthrough the register access for bisectiblity, handled later */
 	case ARM_SMMU_CMDQ_BASE:
+		/*
+		 * Although allowed to use smaller size, we rely on the SMMUv3 driver
+		 * using 64-bit store instruction for simplicity.
+		 */
+		if (len !=3D sizeof(u64))
+			break;
 		if (is_write) {
 			/* Not allowed by the architecture */
 			if (is_cmdq_enabled(smmu))
 				break;
 			smmu->cmdq_host.q_base =3D val;
+			goto out_ret;
+		} else {
+			val =3D smmu->cmdq_host.q_base;
+			goto out_update_regs;
 		}
-		mask =3D read_write;
-		break;
 	case ARM_SMMU_CMDQ_PROD:
+		if (len !=3D sizeof(u32))
+			break;
+		if (is_write) {
+			smmu->cmdq_host.llq.prod =3D val;
+			WARN_ON(smmu_emulate_cmdq_insert(smmu));
+			goto out_ret;
+		} else {
+			val =3D smmu->cmdq_host.llq.prod;
+			goto out_update_regs;
+		}
 	case ARM_SMMU_CMDQ_CONS:
+		if (len !=3D sizeof(u32))
+			break;
+		if (is_write) {
+			if (WARN_ON(is_cmdq_enabled(smmu)))
+				break;
+
+			smmu->cmdq_host.llq.cons =3D val;
+			goto out_ret;
+		} else {
+			/* Propagate errors back to the host.*/
+			u32 cons =3D readl_relaxed(smmu->base + ARM_SMMU_CMDQ_CONS);
+
+			val =3D smmu->cmdq_host.llq.cons | (CMDQ_CONS_ERR & cons);
+			goto out_update_regs;
+		}
+	/* Passthrough the register access for bisectiblity, handled later */
 	case ARM_SMMU_STRTAB_BASE:
 	case ARM_SMMU_STRTAB_BASE_CFG:
 	case ARM_SMMU_GBPA:
--=20
2.55.0.141.g00534a21ce-goog

