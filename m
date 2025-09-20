Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 730C72D9EED
	for <iommu@lists.linux.dev>; Sat, 20 Sep 2025 20:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758400742; cv=none; b=hMCvW+V9xfyQUQ+ywt6QbWqLVRmtUkcvkxsmLEmjTNO/x0mVxGcWCZNsKznWtLMv32GLIefJRFYw/TEiUzi3pwuzjg/q7X0BmRohuKCzqO1twO2h+r8Qsx6dI6mxDLWegNqV9BDXBpBN7I4Hc3Nu37vGNkTYgdPr5yOutqjSwr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758400742; c=relaxed/simple;
	bh=RjwhJA8A/oUnsQw6R1F22fcUWOTwb7V2Ws3LoFKq0Ow=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FWLjlIhLZWxKVlpdt4NZ5L52FnrGr5wjSNOvGgS6IUpp5jIqaDQamUJClOFkxosTugxKKi39QgUL46AQqJmXE2Uk3fPR3fNaAAHFhVL4xm9rtWDU1nR7bK+APpRdq2RB0KytEjCrD5dW30ZNG+zEGXazG2ook1R7UXcZoP5gJZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=jm9ShODu; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="jm9ShODu"
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-890e5bb3100so69273639f.0
        for <iommu@lists.linux.dev>; Sat, 20 Sep 2025 13:39:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1758400740; x=1759005540; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vxzb9rRxjqRKf5XO1kwZTSmIsN5S40FhHTnMmuG0nDs=;
        b=jm9ShODuQeHsU4MkBd/KLjbFTDqUyc+aOmBzac8L7YJEc7BNHBdCcYzLCNmAF7Efs7
         dwbPilfH00UFPXs2CYhBj0FtlC3x4WBIyPTB+Buob/o0nKxAdW1hMS2HuPoWU5W/lM8V
         A8UsONiGMJCjgwyzyU32tIIW94EvYx3io4zaMwgLtnPPoCH2v6rxSMmP1SVc85FWT4VO
         baESxecIJs7lfUN/ZFZeryG+i2kHqd/+BYE9CtkUjJM21uBEsSMNCjH/6URJMlCLg9I/
         HfU/9xvnMn0J4SIKEEq0Y58AqUxy7c0hQZ0SONroVquILlmNL4YCpD3D8nFKwxUWGK+I
         x+/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758400740; x=1759005540;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vxzb9rRxjqRKf5XO1kwZTSmIsN5S40FhHTnMmuG0nDs=;
        b=cSeVqXLt1M6OrMAz1/nnYeYXo/8c2t/K7eV+laMIlq/bIksKEZU9PNuhh7earWwLr0
         KfmclCo/GR57RWSfxpYjNVEC8kt5qJxFeIUNpCtoqYY3Zh+RjXS00361gZQ3egGLPi1X
         RBaoRjEPDcPT3mMV4vpnjejW4Kr+ypUi46jrvNwVfPkYAmXF8fwdWfKoPenAp29PPkGe
         e9LZhjKGlb+tcJwXHEXyEJvxbJVocg9EClPg1gUDqp5FpEBgrLVOE9ale+20UKkZibs4
         6FqlMYXSeBRO/iXBE61YlwYMloI9B6FWaZWi5amJqBKqVnXI2ja5ojRCuE7K/MgLRMQl
         qE7w==
X-Gm-Message-State: AOJu0YyaUfWQtCiXF04MajutUCPl4ZUDLhBHIUKr76a7gCUhK8fu+SD3
	/avhIKKKZZXtkglHup0zJus2FerD5k24uwMtN7rE049KtbDvkZfUS2VY/jUSr0E1EDwddH0r8ln
	T/uC1Y48=
X-Gm-Gg: ASbGncvuN5t7E4HmslWtzkDVLAiWqcOu7SE9syKIhtlEH80xBsl5wzV2t0FQYLcXvSY
	uGu/Qyf6wJ0Vz3wxyy/t3NV4uQdc/6BH+3MIDfOtBCWirZdGgj8RbQ99Uhob3g1S0tqg6teWjWK
	V4WQwb+jbIPhMJMmGfXliHpp0ql1RbZVXhmgOmdGb4HAL1aqNU+/otDLGA7oN3LA2RTlmvjPYmR
	BMlwdU/kmcA3D2VRGxTAkfo+geDflM37rbzTqu7srKQvLMopu8303ceLFC4Jrswb6xy3cX3U0SV
	qW1kD76Nk903eavVu1EQUzGYgLWMAzMp2xBB2/Ii1LvX/4Jxc83p5fpNFdiOu0OJ7YGgkOFJDfF
	+mHM4UI+6J5jufOsKocfclfRh
X-Google-Smtp-Source: AGHT+IGN7JA6HMHp4R5UIXrjGTEkZ7bM+GXI227vKH+W+fzVXTLep0v3OqRrD7H9gufAai1BV1o2GQ==
X-Received: by 2002:a5e:d50b:0:b0:893:2ff0:162c with SMTP id ca18e2360f4ac-8ade197b5efmr1011838239f.9.1758400739613;
        Sat, 20 Sep 2025 13:38:59 -0700 (PDT)
Received: from localhost ([140.82.166.162])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-8a46ad38052sm296133939f.5.2025.09.20.13.38.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Sep 2025 13:38:59 -0700 (PDT)
From: Andrew Jones <ajones@ventanamicro.com>
To: iommu@lists.linux.dev,
	kvm-riscv@lists.infradead.org,
	kvm@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: jgg@nvidia.com,
	zong.li@sifive.com,
	tjeznach@rivosinc.com,
	joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	anup@brainfault.org,
	atish.patra@linux.dev,
	tglx@linutronix.de,
	alex.williamson@redhat.com,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	alex@ghiti.fr
Subject: [RFC PATCH v2 05/18] iommu/riscv: Prepare to use MSI table
Date: Sat, 20 Sep 2025 15:38:55 -0500
Message-ID: <20250920203851.2205115-25-ajones@ventanamicro.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250920203851.2205115-20-ajones@ventanamicro.com>
References: <20250920203851.2205115-20-ajones@ventanamicro.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Capture the IMSIC layout from its config and reserve all the addresses.
Then use the IMSIC layout info to calculate the maximum number of PTEs
the MSI table needs to support and allocate the MSI table when attaching
a paging domain for the first time. Finally, at the same time, map the
IMSIC addresses in the stage1 DMA table when the stage1 DMA table is not
BARE. This ensures it doesn't fault as it will translate the addresses
before the MSI table does.

Signed-off-by: Andrew Jones <ajones@ventanamicro.com>
---
 drivers/iommu/riscv/iommu-ir.c | 186 +++++++++++++++++++++++++++++++++
 drivers/iommu/riscv/iommu.c    |   6 ++
 drivers/iommu/riscv/iommu.h    |   4 +
 3 files changed, 196 insertions(+)

diff --git a/drivers/iommu/riscv/iommu-ir.c b/drivers/iommu/riscv/iommu-ir.c
index 08cf159b587d..bed104c5333c 100644
--- a/drivers/iommu/riscv/iommu-ir.c
+++ b/drivers/iommu/riscv/iommu-ir.c
@@ -4,11 +4,108 @@
  *
  * Copyright © 2025 Ventana Micro Systems Inc.
  */
+#include <linux/irqchip/riscv-imsic.h>
 #include <linux/irqdomain.h>
 #include <linux/msi.h>
+#include <linux/sizes.h>
 
+#include "../iommu-pages.h"
 #include "iommu.h"
 
+static size_t riscv_iommu_ir_group_size(struct riscv_iommu_domain *domain)
+{
+	phys_addr_t mask = domain->msi_addr_mask;
+
+	if (domain->group_index_bits) {
+		phys_addr_t group_mask = BIT(domain->group_index_bits) - 1;
+		phys_addr_t group_shift = domain->group_index_shift - 12;
+
+		mask &= ~(group_mask << group_shift);
+	}
+
+	return (mask + 1) << 12;
+}
+
+static int riscv_iommu_ir_map_unmap_imsics(struct riscv_iommu_domain *domain, bool map,
+					   gfp_t gfp, size_t *unmapped)
+{
+	phys_addr_t base = domain->msi_addr_pattern << 12, addr;
+	size_t stride = domain->imsic_stride, map_size = SZ_4K, size;
+	size_t i, j;
+
+	size = riscv_iommu_ir_group_size(domain);
+
+	if (stride == SZ_4K)
+		stride = map_size = size;
+
+	for (i = 0; i < BIT(domain->group_index_bits); i++) {
+		for (j = 0; j < size; j += stride) {
+			addr = (base + j) | (i << domain->group_index_shift);
+			if (map) {
+				int ret = iommu_map(&domain->domain, addr, addr, map_size,
+						    IOMMU_WRITE | IOMMU_NOEXEC | IOMMU_MMIO, gfp);
+				if (ret)
+					return ret;
+			} else {
+				*unmapped += iommu_unmap(&domain->domain, addr, map_size);
+			}
+		}
+	}
+
+	return 0;
+}
+
+static size_t riscv_iommu_ir_unmap_imsics(struct riscv_iommu_domain *domain)
+{
+	size_t unmapped = 0;
+
+	riscv_iommu_ir_map_unmap_imsics(domain, false, 0, &unmapped);
+
+	return unmapped;
+}
+
+static int riscv_iommu_ir_map_imsics(struct riscv_iommu_domain *domain, gfp_t gfp)
+{
+	int ret;
+
+	ret = riscv_iommu_ir_map_unmap_imsics(domain, true, gfp, NULL);
+	if (ret)
+		riscv_iommu_ir_unmap_imsics(domain);
+
+	return ret;
+}
+
+static size_t riscv_iommu_ir_compute_msipte_idx(struct riscv_iommu_domain *domain,
+						phys_addr_t msi_pa)
+{
+	phys_addr_t mask = domain->msi_addr_mask;
+	phys_addr_t addr = msi_pa >> 12;
+	size_t idx;
+
+	if (domain->group_index_bits) {
+		phys_addr_t group_mask = BIT(domain->group_index_bits) - 1;
+		phys_addr_t group_shift = domain->group_index_shift - 12;
+		phys_addr_t group = (addr >> group_shift) & group_mask;
+
+		mask &= ~(group_mask << group_shift);
+		idx = addr & mask;
+		idx |= group << fls64(mask);
+	} else {
+		idx = addr & mask;
+	}
+
+	return idx;
+}
+
+static size_t riscv_iommu_ir_nr_msiptes(struct riscv_iommu_domain *domain)
+{
+	phys_addr_t base = domain->msi_addr_pattern << 12;
+	phys_addr_t max_addr = base | (domain->msi_addr_mask << 12);
+	size_t max_idx = riscv_iommu_ir_compute_msipte_idx(domain, max_addr);
+
+	return max_idx + 1;
+}
+
 static struct irq_chip riscv_iommu_ir_irq_chip = {
 	.name			= "IOMMU-IR",
 	.irq_ack		= irq_chip_ack_parent,
@@ -90,25 +187,114 @@ struct irq_domain *riscv_iommu_ir_irq_domain_create(struct riscv_iommu_device *i
 	return irqdomain;
 }
 
+static void riscv_iommu_ir_free_msi_table(struct riscv_iommu_domain *domain)
+{
+	iommu_free_pages(domain->msi_root);
+}
+
 void riscv_iommu_ir_irq_domain_remove(struct riscv_iommu_info *info)
 {
+	struct riscv_iommu_domain *domain = info->domain;
 	struct fwnode_handle *fn;
 
 	if (!info->irqdomain)
 		return;
 
+	riscv_iommu_ir_free_msi_table(domain);
+
 	fn = info->irqdomain->fwnode;
 	irq_domain_remove(info->irqdomain);
 	info->irqdomain = NULL;
 	irq_domain_free_fwnode(fn);
 }
 
+static int riscv_ir_set_imsic_global_config(struct riscv_iommu_device *iommu,
+					    struct riscv_iommu_domain *domain)
+{
+	const struct imsic_global_config *imsic_global;
+	u64 mask = 0;
+
+	imsic_global = imsic_get_global_config();
+
+	mask |= (BIT(imsic_global->group_index_bits) - 1) << (imsic_global->group_index_shift - 12);
+	mask |= BIT(imsic_global->hart_index_bits + imsic_global->guest_index_bits) - 1;
+	domain->msi_addr_mask = mask;
+	domain->msi_addr_pattern = imsic_global->base_addr >> 12;
+	domain->group_index_bits = imsic_global->group_index_bits;
+	domain->group_index_shift = imsic_global->group_index_shift;
+	domain->imsic_stride = BIT(imsic_global->guest_index_bits + 12);
+
+	if (iommu->caps & RISCV_IOMMU_CAPABILITIES_MSI_FLAT) {
+		size_t nr_ptes = riscv_iommu_ir_nr_msiptes(domain);
+
+		domain->msi_root = iommu_alloc_pages_node_sz(domain->numa_node, GFP_KERNEL_ACCOUNT,
+							     nr_ptes * sizeof(*domain->msi_root));
+		if (!domain->msi_root)
+			return -ENOMEM;
+	}
+
+	return 0;
+}
+
 int riscv_iommu_ir_attach_paging_domain(struct riscv_iommu_domain *domain,
 					struct device *dev)
 {
+	struct riscv_iommu_device *iommu = dev_to_iommu(dev);
+	struct riscv_iommu_info *info = dev_iommu_priv_get(dev);
+	int ret;
+
+	if (!info->irqdomain)
+		return 0;
+
+	/*
+	 * Do the domain's one-time setup of the msi configuration the
+	 * first time the domain is attached and the msis are enabled.
+	 */
+	if (domain->msi_addr_mask == 0) {
+		ret = riscv_ir_set_imsic_global_config(iommu, domain);
+		if (ret)
+			return ret;
+
+		/*
+		 * The RISC-V IOMMU MSI table is checked after the stage1 DMA
+		 * page tables. If we don't create identity mappings in the
+		 * stage1 table then we'll fault and won't even get a chance
+		 * to check the MSI table.
+		 */
+		if (domain->pgd_mode) {
+			ret = riscv_iommu_ir_map_imsics(domain, GFP_KERNEL_ACCOUNT);
+			if (ret) {
+				riscv_iommu_ir_free_msi_table(domain);
+				return ret;
+			}
+		}
+	}
+
 	return 0;
 }
 
 void riscv_iommu_ir_free_paging_domain(struct riscv_iommu_domain *domain)
 {
+	riscv_iommu_ir_free_msi_table(domain);
+}
+
+void riscv_iommu_ir_get_resv_regions(struct device *dev, struct list_head *head)
+{
+	const struct imsic_global_config *imsic_global;
+	struct iommu_resv_region *reg;
+	phys_addr_t addr;
+	size_t size, i;
+
+	imsic_global = imsic_get_global_config();
+	if (!imsic_global || !imsic_global->nr_ids)
+		return;
+
+	size = BIT(imsic_global->hart_index_bits + imsic_global->guest_index_bits + 12);
+
+	for (i = 0; i < BIT(imsic_global->group_index_bits); i++) {
+		addr = imsic_global->base_addr | (i << imsic_global->group_index_shift);
+		reg = iommu_alloc_resv_region(addr, size, 0, IOMMU_RESV_MSI, GFP_KERNEL);
+		if (reg)
+			list_add_tail(&reg->list, head);
+	}
 }
diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.c
index db2acd9dc64b..0ba6504d4f33 100644
--- a/drivers/iommu/riscv/iommu.c
+++ b/drivers/iommu/riscv/iommu.c
@@ -1423,6 +1423,11 @@ static struct iommu_domain *riscv_iommu_alloc_paging_domain(struct device *dev)
 	return &domain->domain;
 }
 
+static void riscv_iommu_get_resv_regions(struct device *dev, struct list_head *head)
+{
+	riscv_iommu_ir_get_resv_regions(dev, head);
+}
+
 static int riscv_iommu_attach_blocking_domain(struct iommu_domain *iommu_domain,
 					      struct device *dev)
 {
@@ -1561,6 +1566,7 @@ static const struct iommu_ops riscv_iommu_ops = {
 	.blocked_domain = &riscv_iommu_blocking_domain,
 	.release_domain = &riscv_iommu_blocking_domain,
 	.domain_alloc_paging = riscv_iommu_alloc_paging_domain,
+	.get_resv_regions = riscv_iommu_get_resv_regions,
 	.device_group = riscv_iommu_device_group,
 	.probe_device = riscv_iommu_probe_device,
 	.release_device	= riscv_iommu_release_device,
diff --git a/drivers/iommu/riscv/iommu.h b/drivers/iommu/riscv/iommu.h
index 640d825f11b9..dc2020b81bbc 100644
--- a/drivers/iommu/riscv/iommu.h
+++ b/drivers/iommu/riscv/iommu.h
@@ -30,6 +30,9 @@ struct riscv_iommu_domain {
 	struct riscv_iommu_msipte *msi_root;
 	u64 msi_addr_mask;
 	u64 msi_addr_pattern;
+	u32 group_index_bits;
+	u32 group_index_shift;
+	size_t imsic_stride;
 };
 
 /* Private IOMMU data for managed devices, dev_iommu_priv_* */
@@ -97,6 +100,7 @@ void riscv_iommu_ir_irq_domain_remove(struct riscv_iommu_info *info);
 int riscv_iommu_ir_attach_paging_domain(struct riscv_iommu_domain *domain,
 					struct device *dev);
 void riscv_iommu_ir_free_paging_domain(struct riscv_iommu_domain *domain);
+void riscv_iommu_ir_get_resv_regions(struct device *dev, struct list_head *head);
 
 #define riscv_iommu_readl(iommu, addr) \
 	readl_relaxed((iommu)->reg + (addr))
-- 
2.49.0

