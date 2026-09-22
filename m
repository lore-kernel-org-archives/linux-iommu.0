Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com [209.85.128.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DCFC54854A
	for <iommu@lists.linux.dev>; Tue, 22 Sep 2026 13:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790082805; cv=none; b=C4fO3qWakOSJCQ3RkJz4kCfLlYM1bMSZBbrNlhnmEpuyAmI+3g+R5aCoDiMrrhdeU4O2739gDY3peUzt4xNWztznIZ04o8z2M+sGZNtyBiP6cC43eMXvYIMOLz6XCUWwnW8AG12qwvA1Sg1Uos2SDtE8Jh1ZhA2W+O0v5Um+22I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790082805; c=relaxed/simple;
	bh=UUvNqmut7UEKlF4jh6JlVZDEBcMpAxt56G4w6FnCqKg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=VFo6uUMEM3+gR5EpGb32QchrYNFwlouep0ma+03sg3+cyN5QuAST3VPC7Iguko7+W2vtDizu0ehOXvr9zgCPCe/B1Vg0wqnm2S3aJwq/ccyuP4KjNT7j9BnsxXmrirjhIrdTU5trJmbhR8MyRkn2+yHj7AC1BjqFRcX9807GLxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PjZ6d8Xo; arc=none smtp.client-ip=209.85.128.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PjZ6d8Xo"
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-49e76a80fe5so57903165e9.2
        for <iommu@lists.linux.dev>; Tue, 22 Sep 2026 06:13:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790082800; x=1790687600; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kXio9q3HXbV99t7QvdKbUG1SAfPkxiR4UmV0lVPZQhU=;
        b=PjZ6d8Xocu4kIZNbxdarmwCrM/GLzSdRr/6akV3sSLBMUpGtN6Hh5UchEnsvQMi0lY
         n5cD5v7oCZlxKU+1Osc0RmCwgDNKxvp/YZJGKlf6nadyk+xaSp2shzPElaaDR+uZSc1q
         R532zpn5wtNgvWaT51cBxJgTgEg4G3MOzcDeuSAcugg5I2n0M32DhYYQOU3rT78696Ao
         qp9CTaplHP5LItuuERUlbsQpdQdWUjE0KojfTe/EdK2IHRLEsPwEdVE/2bybSe1E6UQH
         o4HNZhpfhtZ5e8fTF9YyhCCNINFGkqy4BcTVxcQy+1fnORlZSGCRqVq+LG0I8sqKhhh5
         thaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790082800; x=1790687600;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kXio9q3HXbV99t7QvdKbUG1SAfPkxiR4UmV0lVPZQhU=;
        b=RQJOS84H+CAWfNNQNeAZSn6A5J7TTLoUrLl/ZSp4KqmvvQAcZvfGcTVKdnIobIjchY
         w8QMmwSg/ozgKmX/vwHPRmbHMjmzCAjKv5NS0zh57Ju0FhAbpJBVPp5sNRQ9y5iR3QRO
         XCswHdmzFkEslStafEsvvxaCPX6iO6I/SeClWnZIA3+WydypkILbleVQUR7SAhCHaMFv
         I8g8vMfcrH8wbBLnQUinZKrxvPlQ5WcJpBDSFLARQbrZnlHwxLDbv4KkUajHG+Cpvgys
         Yzexe7B2I5ML+ZYF7wEXVu3l43X2ndbM5EzcOxT8VGfwQk1AH3Ur6t8e/ndMv4vjXG5F
         GzhQ==
X-Forwarded-Encrypted: i=1; AKwUvByN7uW1amX25+jig+D7mzB1bh9wifHEQ/B/H5aOLX6SKtjJepz5FZKITUOrM2Z6+rfDsS1VMg==@lists.linux.dev
X-Gm-Message-State: AFuF++lXcMbPkiHmf+XC5DgkEtEV7AqBhHONpeHtN1tIMAW2x+jUK/lC
	BZc0I4Xw8zog+3f+D9OeWGoT2DMhWXBXpwJnXmugCTZ3Ftr9YBAsDx+xW4RhFV0AI2BREL6pssA
	1/zGeiDanfdDbyA==
X-Received: from wmhf5.prod.google.com ([2002:a7b:cc05:0:b0:49d:e4a3:4a99])
 (user=smostafa job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:1548:b0:49e:6ac4:b76e with SMTP id 5b1f17b1804b1-49fc574eed4mr206100225e9.30.1790082799463;
 Tue, 22 Sep 2026 06:13:19 -0700 (PDT)
Date: Tue, 22 Sep 2026 13:12:47 +0000
In-Reply-To: <20260922131259.2975334-1-smostafa@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260922131259.2975334-1-smostafa@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <20260922131259.2975334-15-smostafa@google.com>
Subject: [PATCH v8 14/25] iommu/arm-smmu-v3-kvm: Shadow the command queue
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

At boot, allocate a command queue per SMMU which is used as a shadow
by the hypervisor.

The command queue size is 64K which is more than enough, as the
hypervisor would consume all the entries per a command queue prod
write, which means it can handle up to 4096 at a time.

Then, the host command queue needs to be pinned in a shared state, so
it can't be donated to VMs, and avoid tricking the hypervisor into
accessing them. This is done each time the command queue is enabled,
and undone each time the command queue is disabled.
The hypervisor won't access the host command queue when it is disabled
from the host.

Signed-off-by: Mostafa Saleh <smostafa@google.com>
---
 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-kvm.c   |  25 ++++
 .../arm/arm-smmu-v3/pkvm/arm-smmu-v3-hyp.h    |  10 ++
 .../iommu/arm/arm-smmu-v3/pkvm/arm-smmu-v3.c  | 124 ++++++++++++++++++
 3 files changed, 159 insertions(+)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-kvm.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-kvm.c
index 9947d3a44304..28f8b1fba8f7 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-kvm.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-kvm.c
@@ -15,6 +15,8 @@
 #include "arm-smmu-v3.h"
 #include "pkvm/arm-smmu-v3-hyp.h"
 
+#define SMMU_KVM_CMDQ_ORDER		get_order(MAX(SZ_64K, PAGE_SIZE))
+
 extern struct pkvm_iommu_ops kvm_nvhe_sym(smmu_ops);
 
 static size_t				kvm_arm_smmu_count;
@@ -24,6 +26,15 @@ static size_t				kvm_arm_smmu_cur;
 static void kvm_arm_smmu_array_free(void)
 {
 	int order;
+	int i;
+
+	for (i = 0 ; i < kvm_arm_smmu_cur ; ++i) {
+		struct hyp_arm_smmu_v3_device *smmu = &kvm_arm_smmu_array[i];
+
+		if (smmu->cmdq.base_dma)
+			free_pages((unsigned long)phys_to_virt(smmu->cmdq.base_dma),
+				   SMMU_KVM_CMDQ_ORDER);
+	}
 
 	order = get_order(kvm_arm_smmu_count * sizeof(*kvm_arm_smmu_array));
 	free_pages((unsigned long)kvm_arm_smmu_array, order);
@@ -70,6 +81,7 @@ static int smmuv3_nesting_probe(struct platform_device *pdev)
 	struct hyp_arm_smmu_v3_device *smmu = &kvm_arm_smmu_array[kvm_arm_smmu_cur];
 	struct device *dev = &pdev->dev;
 	struct resource *res;
+	void *cmdq_base;
 
 	/* Only device tree, ACPI not supported. */
 	if (!dev->of_node)
@@ -92,6 +104,19 @@ static int smmuv3_nesting_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
+	/*
+	 * Allocate the shadow command queue, it doesn't have to be the same
+	 * size as the host.
+	 * Only populate base_dma and llq.max_n_shift, the hypervisor will init
+	 * the rest.
+	 */
+	cmdq_base = (void *)__get_free_pages(GFP_KERNEL | __GFP_ZERO, SMMU_KVM_CMDQ_ORDER);
+	if (!cmdq_base)
+		return -ENOMEM;
+
+	smmu->cmdq.base_dma = virt_to_phys(cmdq_base);
+	smmu->cmdq.llq.max_n_shift = SMMU_KVM_CMDQ_ORDER + PAGE_SHIFT - CMDQ_ENT_SZ_SHIFT;
+
 	if (of_dma_is_coherent(dev->of_node))
 		smmu->features |= ARM_SMMU_FEAT_COHERENCY;
 
diff --git a/drivers/iommu/arm/arm-smmu-v3/pkvm/arm-smmu-v3-hyp.h b/drivers/iommu/arm/arm-smmu-v3/pkvm/arm-smmu-v3-hyp.h
index 58fa14c239e3..39afdeffcd63 100644
--- a/drivers/iommu/arm/arm-smmu-v3/pkvm/arm-smmu-v3-hyp.h
+++ b/drivers/iommu/arm/arm-smmu-v3/pkvm/arm-smmu-v3-hyp.h
@@ -8,6 +8,8 @@
 #include <nvhe/spinlock.h>
 #endif
 
+#include "../arm-smmu-v3.h"
+
 /*
  * Parameters from the trusted host:
  * @mmio_addr		base address of the SMMU registers
@@ -21,6 +23,10 @@
  * @lock		Lock to protect SMMU emulation
  * @hw_lock		Lock to protect SMMU HW (as CMDQ)
  *			Order smmu.lock => host_mmu.lock => smmu.hw_lock
+ * @cmdq		CMDQ as observed by HW
+ * @cmdq_host		Host view of the CMDQ, only q_base and llq used.
+ * @cmdq_max_shift	Max shift for the CMDQ probed from HW.
+ * @cr0			Last value of CR0
  */
 struct hyp_arm_smmu_v3_device {
 	phys_addr_t		mmio_addr;
@@ -38,6 +44,10 @@ struct hyp_arm_smmu_v3_device {
 	u32			lock;
 	u32			hw_lock;
 #endif
+	struct arm_smmu_queue	cmdq;
+	struct arm_smmu_queue	cmdq_host;
+	u32			cmdq_max_shift;
+	u32			cr0;
 };
 
 extern size_t kvm_nvhe_sym(kvm_hyp_arm_smmu_v3_count);
diff --git a/drivers/iommu/arm/arm-smmu-v3/pkvm/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/pkvm/arm-smmu-v3.c
index 7a51cb70205f..b26c21b595b4 100644
--- a/drivers/iommu/arm/arm-smmu-v3/pkvm/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/pkvm/arm-smmu-v3.c
@@ -22,11 +22,68 @@ struct hyp_arm_smmu_v3_device *kvm_hyp_arm_smmu_v3_smmus;
 	     (smmu) != &kvm_hyp_arm_smmu_v3_smmus[kvm_hyp_arm_smmu_v3_count]; \
 	     (smmu)++)
 
+#define cmdq_size(cmdq)	((1 << ((cmdq)->llq.max_n_shift)) * CMDQ_ENT_DWORDS * 8)
+
+static bool is_cmdq_enabled(struct hyp_arm_smmu_v3_device *smmu)
+{
+	return FIELD_GET(CR0_CMDQEN, smmu->cr0);
+}
+
+/*
+ * CMDQ, STE host copies are accessed by the hypervisor, we share them to
+ * - Prevent the host from passing protected VM memory.
+ * - Having them mapped in the hyp page table.
+ */
+static int smmu_share_pages(phys_addr_t addr, size_t size)
+{
+	size_t nr_pages = PAGE_ALIGN(size + (addr & ~PAGE_MASK)) >> PAGE_SHIFT;
+	phys_addr_t base = addr & PAGE_MASK;
+	int i, ret;
+
+	for (i = 0; i < nr_pages; ++i) {
+		if (__pkvm_host_share_hyp((base + i * PAGE_SIZE) >> PAGE_SHIFT)) {
+			while (i--)
+				__pkvm_host_unshare_hyp((base + i * PAGE_SIZE) >> PAGE_SHIFT);
+			return -EPERM;
+		}
+	}
+
+	ret = hyp_pin_shared_mem(hyp_phys_to_virt(base),
+				 hyp_phys_to_virt(base + nr_pages * PAGE_SIZE));
+	if (ret) {
+		for (i = 0; i < nr_pages; ++i)
+			__pkvm_host_unshare_hyp((base + i * PAGE_SIZE) >> PAGE_SHIFT);
+	}
+
+	return ret;
+}
+
+static int smmu_unshare_pages(phys_addr_t addr, size_t size)
+{
+	size_t nr_pages = PAGE_ALIGN(size + (addr & ~PAGE_MASK)) >> PAGE_SHIFT;
+	phys_addr_t base = addr & PAGE_MASK;
+	int i, ret;
+
+	hyp_unpin_shared_mem(hyp_phys_to_virt(base),
+			     hyp_phys_to_virt(base + nr_pages * PAGE_SIZE));
+
+	for (i = 0; i < nr_pages; ++i) {
+		ret = __pkvm_host_unshare_hyp((base + i * PAGE_SIZE) >> PAGE_SHIFT);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
 /* Put the device in a state that can be probed by the host driver. */
 static void smmu_deinit_device(struct hyp_arm_smmu_v3_device *smmu)
 {
 	WARN_ON(__pkvm_hyp_donate_host_mmio(hyp_phys_to_pfn(smmu->mmio_addr),
 					    smmu->mmio_size >> PAGE_SHIFT));
+	if (smmu->cmdq.base)
+		WARN_ON(__pkvm_hyp_donate_host(smmu->cmdq.base_dma >> PAGE_SHIFT,
+					       PAGE_ALIGN(cmdq_size(&smmu->cmdq)) >> PAGE_SHIFT));
 	smmu->base = NULL;
 }
 
@@ -53,6 +110,7 @@ static int smmu_probe(struct hyp_arm_smmu_v3_device *smmu)
 		return -EINVAL;
 
 	smmu->sid_bits = FIELD_GET(IDR1_SIDSIZE, reg);
+	smmu->cmdq_max_shift = FIELD_GET(IDR1_CMDQS, reg);
 	/* Follows the kernel logic */
 	if (smmu->sid_bits <= STRTAB_SPLIT)
 		smmu->features &= ~ARM_SMMU_FEAT_2_LVL_STRTAB;
@@ -71,6 +129,33 @@ static int smmu_probe(struct hyp_arm_smmu_v3_device *smmu)
 	return 0;
 }
 
+/*
+ * The kernel part of the driver will allocate the shadow cmdq,
+ * and zero it. This function only donates it.
+ */
+static int smmu_init_cmdq(struct hyp_arm_smmu_v3_device *smmu)
+{
+	size_t cmdq_nr_pages;
+	int ret;
+
+	smmu->cmdq.llq.max_n_shift = min(smmu->cmdq.llq.max_n_shift, smmu->cmdq_max_shift);
+	cmdq_nr_pages = PAGE_ALIGN(cmdq_size(&smmu->cmdq)) >> PAGE_SHIFT;
+	ret = __pkvm_host_donate_hyp(smmu->cmdq.base_dma >> PAGE_SHIFT, cmdq_nr_pages);
+	if (ret)
+		return ret;
+
+	smmu->cmdq.base = hyp_phys_to_virt(smmu->cmdq.base_dma);
+	smmu->cmdq.prod_reg = smmu->base + ARM_SMMU_CMDQ_PROD;
+	smmu->cmdq.cons_reg = smmu->base + ARM_SMMU_CMDQ_CONS;
+	smmu->cmdq.q_base = smmu->cmdq.base_dma |
+			    FIELD_PREP(Q_BASE_LOG2SIZE, smmu->cmdq.llq.max_n_shift);
+	smmu->cmdq.ent_dwords = CMDQ_ENT_DWORDS;
+	writel_relaxed(0, smmu->cmdq.prod_reg);
+	writel_relaxed(0, smmu->cmdq.cons_reg);
+	writeq_relaxed(smmu->cmdq.q_base, smmu->base + ARM_SMMU_CMDQ_BASE);
+	return 0;
+}
+
 static int smmu_init_device(struct hyp_arm_smmu_v3_device *smmu)
 {
 	unsigned long haddr;
@@ -92,7 +177,12 @@ static int smmu_init_device(struct hyp_arm_smmu_v3_device *smmu)
 	if (ret)
 		goto out_ret;
 
+	ret = smmu_init_cmdq(smmu);
+	if (ret)
+		goto out_ret;
+
 	return 0;
+
 out_ret:
 	smmu_deinit_device(smmu);
 	return ret;
@@ -132,6 +222,23 @@ static int smmu_init(void)
 	return ret;
 }
 
+static void smmu_emulate_cmdq_enable(struct hyp_arm_smmu_v3_device *smmu)
+{
+	u32 shift = smmu->cmdq_host.q_base & Q_BASE_LOG2SIZE;
+
+	smmu->cmdq_host.llq.max_n_shift = min(shift, smmu->cmdq_max_shift);
+	smmu->cmdq_host.base_dma = smmu->cmdq_host.q_base & Q_BASE_ADDR_MASK;
+	smmu->cmdq_host.base_dma &= ~(cmdq_size(&smmu->cmdq_host) - 1);
+	WARN_ON(smmu_share_pages(smmu->cmdq_host.base_dma,
+				 cmdq_size(&smmu->cmdq_host)));
+}
+
+static void smmu_emulate_cmdq_disable(struct hyp_arm_smmu_v3_device *smmu)
+{
+	WARN_ON(smmu_unshare_pages(smmu->cmdq_host.base_dma,
+				   cmdq_size(&smmu->cmdq_host)));
+}
+
 static bool smmu_dabt_device(struct hyp_arm_smmu_v3_device *smmu,
 			     struct user_pt_regs *regs,
 			     u64 esr, u32 off)
@@ -158,6 +265,14 @@ static bool smmu_dabt_device(struct hyp_arm_smmu_v3_device *smmu,
 		break;
 	/* Passthrough the register access for bisectability, handled later */
 	case ARM_SMMU_CMDQ_BASE:
+		if (is_write) {
+			/* Not allowed by the architecture */
+			if (is_cmdq_enabled(smmu))
+				break;
+			smmu->cmdq_host.q_base = val;
+		}
+		mask = read_write;
+		break;
 	case ARM_SMMU_CMDQ_PROD:
 	case ARM_SMMU_CMDQ_CONS:
 	case ARM_SMMU_STRTAB_BASE:
@@ -168,6 +283,15 @@ static bool smmu_dabt_device(struct hyp_arm_smmu_v3_device *smmu,
 	case ARM_SMMU_CR0:
 		if (len != sizeof(u32))
 			break;
+		if (is_write) {
+			bool last_cmdq_en = is_cmdq_enabled(smmu);
+
+			smmu->cr0 = val;
+			if (!last_cmdq_en && is_cmdq_enabled(smmu))
+				smmu_emulate_cmdq_enable(smmu);
+			else if (last_cmdq_en && !is_cmdq_enabled(smmu))
+				smmu_emulate_cmdq_disable(smmu);
+		}
 		mask = read_write;
 		break;
 	case ARM_SMMU_CR1:
-- 
2.55.0.1082.g2b9226bbc0-goog

