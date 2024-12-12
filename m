Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7474239BA8
	for <iommu@lists.linux.dev>; Thu, 12 Dec 2024 18:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734026753; cv=none; b=ruIOZPdIt5E//d/edMsicubzcmOj46zeb5R3gB5plMT5HtbbSGOkyW/l/syLWpz5VX1FHjU9sUmZaHBAGLhS61vhRDSiXuv1G18nClVhp9cl9n2ALmQCOWQ0VwpiETHvlW8YvyY4ySaKy0FfzLh4Yo8MuQ9QERsRX6CCw/cFhHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734026753; c=relaxed/simple;
	bh=rKruoUMFqJDGZAjSYxqmVBeUt8pQ/t5eBu3d7duzRY0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=FOt7WXbYcQyeNLCOY+EAFDm5aDB5rvRtp1SHfgvB3OtrGe9vQshj2f429yTEM9h2n0SxPY1TAik5fNdSfs3b2goIBiHot20hhvDC6u/skUDIztubrOZpXfAKiTIku3x3Nji7NP7IWpAAnRSdv7gZBKFEIcymi74T8l08STGb8Q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MsdO6aiD; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MsdO6aiD"
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-434fe2b605eso5726065e9.2
        for <iommu@lists.linux.dev>; Thu, 12 Dec 2024 10:05:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734026750; x=1734631550; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=i0p39a77mImTT2bcTUkjv5rHSXECPntFQZjkOUsIrRs=;
        b=MsdO6aiDwpVjfobFYe5ZpumtByzIfBcIcKuAEYAbO/RT/zuk3WN4tPJifvckeC08+Y
         O1gyqBaZdGggKPMxrC9kJtqCE7JID6ZQcuTiCVt89C10bqrwnF2i5AEoR9w+SvfLhI+4
         Qkc5D8D/l6wreMtOhz6al/Mk+4xz68nXUm+GD6vp+/sTuRsLdWkKgBsAeR8Q7CiwuNPL
         pYZ73l+ao0xC3UhNrnak63FE17DG3d5gJA0qTsa8Nlni4k5Y7eO3uKwFPwxdmCZEagEZ
         HZhwJxvNtB+wAJF5QI5qfQxWX+DUn7rIhmOnd5zzOJcWhlYVQRHcuBzFMCkZDAOJAbr3
         f6Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734026750; x=1734631550;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i0p39a77mImTT2bcTUkjv5rHSXECPntFQZjkOUsIrRs=;
        b=nmIXonNVxC9I2P5HF9SY+IAlgJWA1XXQ4cSDUGlsH/SpZLyGaf86iueK5GT2vhM+I3
         EukL3jKmq3U/SmnZzmRig5iJFRbUa0gbokot9gt00lBk7D2jA9Ic1UUCygqKXIX6u5xx
         6XZUGpkjCbaj5AxynbvFfyMm+0we1U6+YOT/pJxIa824RCXyaxFlTJLxGZUTW79UrW6C
         iglvZjgfvn/NnOK8fJ0S1RemrEgOJ2tt0WFMqpdyinCPeIABXFTm8I3Sr8lxkG7MAoD4
         Kz/i65J+FAsRGBnwTYDVf2lVdIewSb+IlPp3k1ndeKBVv2+pkM2psxxjw8BrRbcl0NXG
         gAnA==
X-Gm-Message-State: AOJu0YzHWfSumcM9phTkgMTaP3QlilvdB6iGxTHQRafCBtJeENz1Pzhh
	uA0MTDEgCujRU2324bgJuCKuz02Lqs3Ebk9AfJeZJKEKf8DNBbws4PZ9l/zsrHmURK511MaIzi8
	IpWWPmO5JXggAHYGg4gKThQKWfz5UibufNAzJ70yz9+22fJjVyYAJ0bODN0X+XA67RqKtupVfA7
	i/6AiC0l8t7v4SnaqAHUWtNKrkIjLQQjTsybro6Sc16g==
X-Google-Smtp-Source: AGHT+IG1KFj+8kiPF7R9tNS1w0lYL0LFPzKnh4cL4W+DNw5iDRjcSi9WleF5S9ilyTwoZ5oQcyfDOI5ctOSx2A==
X-Received: from wmkz18.prod.google.com ([2002:a7b:c7d2:0:b0:434:a15f:e7ea])
 (user=smostafa job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:a011:b0:434:f623:9fe3 with SMTP id 5b1f17b1804b1-4361c3755bamr72354245e9.16.1734026750412;
 Thu, 12 Dec 2024 10:05:50 -0800 (PST)
Date: Thu, 12 Dec 2024 18:03:56 +0000
In-Reply-To: <20241212180423.1578358-1-smostafa@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20241212180423.1578358-1-smostafa@google.com>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <20241212180423.1578358-33-smostafa@google.com>
Subject: [RFC PATCH v2 32/58] KVM: arm64: smmu-v3: Add {alloc/free}_domain
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

Add SMMUv3 alloc/free domain, as this operations are not
tied to the IOMMU, we can't do much with the io-pgtable
allocation or configuration.

Signed-off-by: Mostafa Saleh <smostafa@google.com>
---
 arch/arm64/kvm/hyp/nvhe/iommu/arm-smmu-v3.c | 64 +++++++++++++++++++++
 include/kvm/arm_smmu_v3.h                   |  6 ++
 2 files changed, 70 insertions(+)

diff --git a/arch/arm64/kvm/hyp/nvhe/iommu/arm-smmu-v3.c b/arch/arm64/kvm/hyp/nvhe/iommu/arm-smmu-v3.c
index 58662c2c4c97..3181933e9a34 100644
--- a/arch/arm64/kvm/hyp/nvhe/iommu/arm-smmu-v3.c
+++ b/arch/arm64/kvm/hyp/nvhe/iommu/arm-smmu-v3.c
@@ -7,6 +7,8 @@
 #include <asm/arm-smmu-v3-common.h>
 #include <asm/kvm_hyp.h>
 #include <kvm/arm_smmu_v3.h>
+#include <linux/io-pgtable-arm.h>
+#include <nvhe/alloc.h>
 #include <nvhe/iommu.h>
 #include <nvhe/mem_protect.h>
 #include <nvhe/mm.h>
@@ -50,6 +52,22 @@ struct hyp_arm_smmu_v3_device *kvm_hyp_arm_smmu_v3_smmus;
 	smmu_wait(_cond);					\
 })
 
+/*
+ * SMMUv3 domain:
+ * @domain: Pointer to the IOMMU domain.
+ * @smmu: SMMU instance for this domain.
+ * @type: Type of domain (S1, S2)
+ * @pgt_lock: Lock for page table
+ * @pgtable: io_pgtable instance for this domain
+ */
+struct hyp_arm_smmu_v3_domain {
+	struct kvm_hyp_iommu_domain     *domain;
+	struct hyp_arm_smmu_v3_device	*smmu;
+	u32				type;
+	hyp_spinlock_t			pgt_lock;
+	struct io_pgtable		*pgtable;
+};
+
 static int smmu_write_cr0(struct hyp_arm_smmu_v3_device *smmu, u32 val)
 {
 	writel_relaxed(val, smmu->base + ARM_SMMU_CR0);
@@ -541,7 +559,53 @@ static int smmu_init(void)
 	return ret;
 }
 
+static struct kvm_hyp_iommu *smmu_id_to_iommu(pkvm_handle_t smmu_id)
+{
+	if (smmu_id >= kvm_hyp_arm_smmu_v3_count)
+		return NULL;
+	smmu_id = array_index_nospec(smmu_id, kvm_hyp_arm_smmu_v3_count);
+
+	return &kvm_hyp_arm_smmu_v3_smmus[smmu_id].iommu;
+}
+
+static int smmu_alloc_domain(struct kvm_hyp_iommu_domain *domain, int type)
+{
+	struct hyp_arm_smmu_v3_domain *smmu_domain;
+
+	if (type >= KVM_ARM_SMMU_DOMAIN_MAX)
+		return -EINVAL;
+
+	smmu_domain = hyp_alloc(sizeof(*smmu_domain));
+	if (!smmu_domain)
+		return -ENOMEM;
+
+	/*
+	 * Can't do much without knowing the SMMUv3.
+	 * Page table will be allocated at attach_dev, but can be
+	 * freed from free domain.
+	 */
+	smmu_domain->domain = domain;
+	smmu_domain->type = type;
+	hyp_spin_lock_init(&smmu_domain->pgt_lock);
+	domain->priv = (void *)smmu_domain;
+
+	return 0;
+}
+
+static void smmu_free_domain(struct kvm_hyp_iommu_domain *domain)
+{
+	struct hyp_arm_smmu_v3_domain *smmu_domain = domain->priv;
+
+	if (smmu_domain->pgtable)
+		kvm_arm_io_pgtable_free(smmu_domain->pgtable);
+
+	hyp_free(smmu_domain);
+}
+
 /* Shared with the kernel driver in EL1 */
 struct kvm_iommu_ops smmu_ops = {
 	.init				= smmu_init,
+	.get_iommu_by_id		= smmu_id_to_iommu,
+	.alloc_domain			= smmu_alloc_domain,
+	.free_domain			= smmu_free_domain,
 };
diff --git a/include/kvm/arm_smmu_v3.h b/include/kvm/arm_smmu_v3.h
index 352c1b2dc72a..ded98cbaebc1 100644
--- a/include/kvm/arm_smmu_v3.h
+++ b/include/kvm/arm_smmu_v3.h
@@ -33,4 +33,10 @@ extern size_t kvm_nvhe_sym(kvm_hyp_arm_smmu_v3_count);
 extern struct hyp_arm_smmu_v3_device *kvm_nvhe_sym(kvm_hyp_arm_smmu_v3_smmus);
 #define kvm_hyp_arm_smmu_v3_smmus kvm_nvhe_sym(kvm_hyp_arm_smmu_v3_smmus)
 
+enum kvm_arm_smmu_domain_type {
+	KVM_ARM_SMMU_DOMAIN_S1,
+	KVM_ARM_SMMU_DOMAIN_S2,
+	KVM_ARM_SMMU_DOMAIN_MAX,
+};
+
 #endif /* __KVM_ARM_SMMU_V3_H */
-- 
2.47.0.338.g60cca15819-goog

