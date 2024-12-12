Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 098C4239BD5
	for <iommu@lists.linux.dev>; Thu, 12 Dec 2024 18:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734026757; cv=none; b=SCgYUpHTyaqvs2RDWlnFOUD+a6VdtrV22VckVdQOsfHkqFZKsEfMivjidJKxZgDtRU3gjBA7Wk+4Nic+HkcPY8zZTwETe4S1Wf81nvQgeKFuuI9BnqM2DHacUr8R8qUo/Q6oEKUMmKx1Bp6JeOzt2ynn5WQCKmFF4Rydqi+s1uA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734026757; c=relaxed/simple;
	bh=aMJpNnqVCqfIZxdPd82zCfyFBJH1oACArK53wQftNKU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=kSX/GIP8UJbsGUvuMYjAaP/aJ0z0BlD4w4O6nyuYFPT8eWD6xJE3HrsmCbZtJOb/YKlcc9HGmUh7HLb1saq03XtTdDCzsD8rQ7a6lY2mIeqwg7pe3b2adigFfcxcvMJx0NX5U00XBAwTO74TND3EZmH0ekUC/VORGQ4NFw+L/sA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BLyV7PGr; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BLyV7PGr"
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-4361b090d23so5677745e9.0
        for <iommu@lists.linux.dev>; Thu, 12 Dec 2024 10:05:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734026752; x=1734631552; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=0JvanTJSMR+XI/Wjo2HTOKln5DEsfQoh3Hho27FSuog=;
        b=BLyV7PGrXba5b5/pNA/p3X3GobKEiZ3bv2Qh75mr7t0tVcO7KtBAQt0q21XaQ00YgL
         o/yhoZukI9PSD/tgem0fxcglRKuNZUOeZpmKcm8mxcm37uyb+3d1lGamI9SDpyBWg+Fz
         21n4HFMlp6lRMaEbhqXS2s+4UOdkCbUTpG0tpiub9zyVhUmnffwGfVCdOAnhDw/v69O2
         0rSQVw2Y1yDserqJb8pzCbVE8YbOc99DmWGw5jkqXDJoaTzPtplAyPVXCOHqti7u4CTr
         S1KTWUCY6eKJe+SrB8c0XzdXfgTbuLaOVeI3Egz6R+OZpZL3Tx74e1ewriDomFT+DBkF
         amSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734026752; x=1734631552;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0JvanTJSMR+XI/Wjo2HTOKln5DEsfQoh3Hho27FSuog=;
        b=nRrYcTGOl4WRuDo6pyeB9Ju3JRnBi18wp2hE647VnaUhs/2MyBg7ww5N+QCsDTWhKK
         rUFsTfyj2XTRvK95H0LOM25TM91Ln9PGqy7I9E3C78McAsY+wRAVeG3x8qhUYuYdX6MW
         k394Be8kRIu+fhUOJLqoScMKiVmVjVjeSWb9B1250XT7f7ib2KHgjVmyEaeGD5juhN3L
         xmVWdHLvmyCaekBuPF4sMe1dwChQEUlRrvxJN3XP+3S/gWiC2IXeSMcQQz8iXGlTtwFF
         WhLgVFtTQ+fxUptVNDfPmjOmvbWUxBFFOjr0qtZNb0qns6zF6OtSpvr+ETSMxWJWhEA1
         tYvA==
X-Gm-Message-State: AOJu0YzhgzsO19WO+cOa08+xfeiyC/YyfO6cLT3Gj/wwGSzlA4DhYk2o
	678BRPO2rtk2QjLeD+DYKSbBVm1JFAv70z6p4mgXyy4B7Q4Fv1nzg7N51c7eTDuJunDoO006LlV
	m5/tA+4AZ6mmPlmYD/DFLcXrJFm5q+S8IkCwKRyeItKPeOjtzNtP33EnmKgm2/u8rWfcPIrRtZX
	dFlwFxgJ/Q0sTnJLJpxY7NTyZPvitS94XVsYZJidYbuA==
X-Google-Smtp-Source: AGHT+IGWGdZgTY7Fu4Fy8oS8GVUUpzVpI6h6GF8Kt9ZH/qx6w2Z6AjSEvrQ/zUVQNCjYoCTIQFsDcTLIxiWTaw==
X-Received: from wmkz18.prod.google.com ([2002:a7b:c7d2:0:b0:434:a15f:e7ea])
 (user=smostafa job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:4e4b:b0:434:a239:d2fe with SMTP id 5b1f17b1804b1-4361c400c1bmr52688975e9.28.1734026752664;
 Thu, 12 Dec 2024 10:05:52 -0800 (PST)
Date: Thu, 12 Dec 2024 18:03:57 +0000
In-Reply-To: <20241212180423.1578358-1-smostafa@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20241212180423.1578358-1-smostafa@google.com>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <20241212180423.1578358-34-smostafa@google.com>
Subject: [RFC PATCH v2 33/58] KVM: arm64: smmu-v3: Add TLB ops
From: Mostafa Saleh <smostafa@google.com>
To: iommu@lists.linux.dev, kvmarm@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: catalin.marinas@arm.com, will@kernel.org, maz@kernel.org, 
	oliver.upton@linux.dev, joey.gouly@arm.com, suzuki.poulose@arm.com, 
	yuzenghui@huawei.com, robdclark@gmail.com, joro@8bytes.org, 
	robin.murphy@arm.com, jean-philippe@linaro.org, jgg@ziepe.ca, 
	nicolinc@nvidia.com, vdonnefort@google.com, qperret@google.com, 
	tabba@google.com, danielmentz@google.com, tzukui@google.com, 
	Mostafa Saleh <smostafa@google.com>
Content-Type: text/plain; charset="UTF-8"

Add TLB invalidation functions would be used next from the page table
code and attach/detach functions.

Signed-off-by: Mostafa Saleh <smostafa@google.com>
Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 arch/arm64/kvm/hyp/nvhe/iommu/arm-smmu-v3.c | 167 ++++++++++++++++++++
 1 file changed, 167 insertions(+)

diff --git a/arch/arm64/kvm/hyp/nvhe/iommu/arm-smmu-v3.c b/arch/arm64/kvm/hyp/nvhe/iommu/arm-smmu-v3.c
index 3181933e9a34..5f00d5cdf5bc 100644
--- a/arch/arm64/kvm/hyp/nvhe/iommu/arm-smmu-v3.c
+++ b/arch/arm64/kvm/hyp/nvhe/iommu/arm-smmu-v3.c
@@ -602,10 +602,177 @@ static void smmu_free_domain(struct kvm_hyp_iommu_domain *domain)
 	hyp_free(smmu_domain);
 }
 
+static void smmu_inv_domain(struct hyp_arm_smmu_v3_domain *smmu_domain)
+{
+	struct kvm_hyp_iommu_domain *domain = smmu_domain->domain;
+	struct hyp_arm_smmu_v3_device *smmu = smmu_domain->smmu;
+	struct arm_smmu_cmdq_ent cmd = {};
+
+	if (smmu_domain->pgtable->cfg.fmt == ARM_64_LPAE_S2) {
+		cmd.opcode = CMDQ_OP_TLBI_S12_VMALL;
+		cmd.tlbi.vmid = domain->domain_id;
+	} else {
+		cmd.opcode = CMDQ_OP_TLBI_NH_ASID;
+		cmd.tlbi.asid = domain->domain_id;
+	}
+
+	if (smmu->iommu.power_is_off)
+		return;
+
+	WARN_ON(smmu_send_cmd(smmu, &cmd));
+}
+
+static void smmu_tlb_flush_all(void *cookie)
+{
+	struct kvm_hyp_iommu_domain *domain = cookie;
+	struct hyp_arm_smmu_v3_domain *smmu_domain = domain->priv;
+	struct hyp_arm_smmu_v3_device *smmu = smmu_domain->smmu;
+
+	kvm_iommu_lock(&smmu->iommu);
+	smmu_inv_domain(smmu_domain);
+	kvm_iommu_unlock(&smmu->iommu);
+}
+
+static int smmu_tlb_inv_range_smmu(struct hyp_arm_smmu_v3_device *smmu,
+				   struct kvm_hyp_iommu_domain *domain,
+				   struct arm_smmu_cmdq_ent *cmd,
+				   unsigned long iova, size_t size, size_t granule)
+{
+	int ret = 0;
+	unsigned long end = iova + size, num_pages = 0, tg = 0;
+	size_t inv_range = granule;
+	struct hyp_arm_smmu_v3_domain *smmu_domain = domain->priv;
+
+	kvm_iommu_lock(&smmu->iommu);
+	if (smmu->iommu.power_is_off)
+		goto out_ret;
+
+	/* Almost copy-paste from the kernel dirver. */
+	if (smmu->features & ARM_SMMU_FEAT_RANGE_INV) {
+		/* Get the leaf page size */
+		tg = __ffs(smmu_domain->pgtable->cfg.pgsize_bitmap);
+
+		num_pages = size >> tg;
+
+		/* Convert page size of 12,14,16 (log2) to 1,2,3 */
+		cmd->tlbi.tg = (tg - 10) / 2;
+
+		/*
+		 * Determine what level the granule is at. For non-leaf, both
+		 * io-pgtable and SVA pass a nominal last-level granule because
+		 * they don't know what level(s) actually apply, so ignore that
+		 * and leave TTL=0. However for various errata reasons we still
+		 * want to use a range command, so avoid the SVA corner case
+		 * where both scale and num could be 0 as well.
+		 */
+		if (cmd->tlbi.leaf)
+			cmd->tlbi.ttl = 4 - ((ilog2(granule) - 3) / (tg - 3));
+		else if ((num_pages & CMDQ_TLBI_RANGE_NUM_MAX) == 1)
+			num_pages++;
+	}
+
+	while (iova < end) {
+		if (smmu->features & ARM_SMMU_FEAT_RANGE_INV) {
+			/*
+			 * On each iteration of the loop, the range is 5 bits
+			 * worth of the aligned size remaining.
+			 * The range in pages is:
+			 *
+			 * range = (num_pages & (0x1f << __ffs(num_pages)))
+			 */
+			unsigned long scale, num;
+
+			/* Determine the power of 2 multiple number of pages */
+			scale = __ffs(num_pages);
+			cmd->tlbi.scale = scale;
+
+			/* Determine how many chunks of 2^scale size we have */
+			num = (num_pages >> scale) & CMDQ_TLBI_RANGE_NUM_MAX;
+			cmd->tlbi.num = num - 1;
+
+			/* range is num * 2^scale * pgsize */
+			inv_range = num << (scale + tg);
+
+			/* Clear out the lower order bits for the next iteration */
+			num_pages -= num << scale;
+		}
+		cmd->tlbi.addr = iova;
+		WARN_ON(smmu_add_cmd(smmu, cmd));
+		BUG_ON(iova + inv_range < iova);
+		iova += inv_range;
+	}
+
+	ret = smmu_sync_cmd(smmu);
+out_ret:
+	kvm_iommu_unlock(&smmu->iommu);
+	return ret;
+}
+
+static void smmu_tlb_inv_range(struct kvm_hyp_iommu_domain *domain,
+			       unsigned long iova, size_t size, size_t granule,
+			       bool leaf)
+{
+	struct hyp_arm_smmu_v3_domain *smmu_domain = domain->priv;
+	unsigned long end = iova + size;
+	struct arm_smmu_cmdq_ent cmd;
+
+	cmd.tlbi.leaf = leaf;
+	if (smmu_domain->pgtable->cfg.fmt == ARM_64_LPAE_S2) {
+		cmd.opcode = CMDQ_OP_TLBI_S2_IPA;
+		cmd.tlbi.vmid = domain->domain_id;
+	} else {
+		cmd.opcode = CMDQ_OP_TLBI_NH_VA;
+		cmd.tlbi.asid = domain->domain_id;
+		cmd.tlbi.vmid = 0;
+	}
+	/*
+	 * There are no mappings at high addresses since we don't use TTB1, so
+	 * no overflow possible.
+	 */
+	BUG_ON(end < iova);
+	WARN_ON(smmu_tlb_inv_range_smmu(smmu_domain->smmu, domain,
+					&cmd, iova, size, granule));
+}
+
+static void smmu_tlb_flush_walk(unsigned long iova, size_t size,
+				size_t granule, void *cookie)
+{
+	smmu_tlb_inv_range(cookie, iova, size, granule, false);
+}
+
+static void smmu_tlb_add_page(struct iommu_iotlb_gather *gather,
+			      unsigned long iova, size_t granule,
+			      void *cookie)
+{
+	if (gather)
+		kvm_iommu_iotlb_gather_add_page(cookie, gather, iova, granule);
+	else
+		smmu_tlb_inv_range(cookie, iova, granule, granule, true);
+}
+
+__maybe_unused
+static const struct iommu_flush_ops smmu_tlb_ops = {
+	.tlb_flush_all	= smmu_tlb_flush_all,
+	.tlb_flush_walk = smmu_tlb_flush_walk,
+	.tlb_add_page	= smmu_tlb_add_page,
+};
+
+static void smmu_iotlb_sync(struct kvm_hyp_iommu_domain *domain,
+			    struct iommu_iotlb_gather *gather)
+{
+	size_t size;
+
+	if (!gather->pgsize)
+		return;
+	size = gather->end - gather->start + 1;
+	smmu_tlb_inv_range(domain, gather->start, size,  gather->pgsize, true);
+}
+
 /* Shared with the kernel driver in EL1 */
 struct kvm_iommu_ops smmu_ops = {
 	.init				= smmu_init,
 	.get_iommu_by_id		= smmu_id_to_iommu,
 	.alloc_domain			= smmu_alloc_domain,
 	.free_domain			= smmu_free_domain,
+	.iotlb_sync			= smmu_iotlb_sync,
 };
-- 
2.47.0.338.g60cca15819-goog

