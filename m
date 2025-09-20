Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39FED2E11C8
	for <iommu@lists.linux.dev>; Sat, 20 Sep 2025 20:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758400753; cv=none; b=dbMiMwY92zqJY6XD8xDe1/VOYFftGz17UINuRzidL44q3DdPkkfwO2h+xRgoSWALj5B0otaMNgrgGXrh+65ndsghw8+D1rpSDoq4oAxVKFdZAG32h9YZApFP0Jd/90TO3LsW0Ir7SZWmIWhz+Q1FIZPc0AyeO7FnfPvekX2ykOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758400753; c=relaxed/simple;
	bh=ASU49Pf0Kl4bub9yLW0Cs6Vci2cgvd1+yolRR1XpqNI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jplr9fWxk6VaLLtw6WgQMH/BlUu7mJ3qTjhpkl5YVhYZARAKAeZisUBg3D08GS09xAr+04OaBy49/ew/74FsP1wnc00Z5rB+mj+6zv33sq8R+n3/gSt/cZKW10Y1jCpUSEIWlxS6ZllugZTo54Gp8BJtlcfF1co3MqLg54r+nsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=SYWWtVp2; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="SYWWtVp2"
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-887764c2834so229015339f.1
        for <iommu@lists.linux.dev>; Sat, 20 Sep 2025 13:39:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1758400748; x=1759005548; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hI0KkCC908juzA+gLK6iwf+tDIKeFweMVpvJKlXZSdQ=;
        b=SYWWtVp2gzcXqjaaxEGfkCMYjVhanEbVt3XYpOwIGz3wf4MUfwzs5KUNchQzr/mRhX
         2fwPfcoZ2QZkz3S3340aPFuFFVZW5O6DmMMMgBEsrBjrO4uDluWoQvqUrko17uZYkpkw
         eudPHqo95UQf8+CFFtqIXo35q3qccNrNuN5Pp5x7tAlm3Bh727o95itGgeXBN9Hblm2U
         LT/EN0wZD55JjSMqwEDIdbCN4VDbA/oaKAgDyAtpdxevTM517Intc+fnwjHy+eR6y3pb
         xOsU7t8huKE0fZ1Emu1eB3C8y+vNmKlBauICh5lBdyEg5GODS6+AWSf25sVNwr3gQ/h4
         0k4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758400748; x=1759005548;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hI0KkCC908juzA+gLK6iwf+tDIKeFweMVpvJKlXZSdQ=;
        b=ZihZ6Xg92G+JXWFVBifP/NWAU2Nnwye87/RtHiamoAC+NetSnTX4hrosAvh91fUeXn
         kMKG7PXSUNEvV1UfinPUxxEZOThk3fA/yBZJTktC2eblQrHHhUQwu8RmoGLDBiGeMEmU
         1UqW1w1pkJnWjTgGGHcGIgGZ8JmkMhoIKuV50OffWqAqulida3rEmxKecE2Puh3D5Uwl
         rq+xaL5eQO6M59Q3H520ZFfMrtcxWs9OBA9jIQJdQYmHfH1GQbN+zuppQ0Ffp8vVjGln
         PodMCe9/pYSxdM4MhTS1urOdGA5cmJY02z7Ylw+flUh3gcn1QyYqXprFp8TfszqZysE9
         ghGw==
X-Gm-Message-State: AOJu0YxvJrl3FIK1YqRRO7e3iSa7jlJHppx+m6gBbHd5MLuzlnXyBfGh
	q5fTCH18nAgNq/Go5iM0gPIaYatu627IaHXGta4cDTw9dlR9TVJUGoXRBVOu/5TTK9Fs/gKWBUs
	muK4eqoI=
X-Gm-Gg: ASbGncsYqoghHzQiXn+NpHKtXyc+Rbp2s1UovybEwTt5nA+TiUwLQUsAx7NIBquDi3a
	SI2tpFZ3AqQuGqMloGAkLijix5IkNLsoSUuuVjmIBVKtSizEwjPLLshk/pLcwPj1t7I3/wqpYd/
	FbOhQjHdj20jw2Vpm7uDoLUIlYMhVgIiXxMGmrPOgCIav8HM3vpBmLU/PfSYroVOdQk7D0KS5co
	G9BQ7UcVw8JQtbyyKdOiCSfXlxbn1+Mc0bORWgUAqnl8xqc5OeXK0V1LGIk38BAP3ExCtVtB+BW
	KNEdg/ue401CbZll+axO9KCVpJ75MeXy1zqCQiXBD0PmPpPhEhOc7VLKMAf0VgqP4+/+C11h9ah
	1wDU5obU+mXT9bmc9538Gynxn
X-Google-Smtp-Source: AGHT+IFJgtbAqkbkjXlxObLQUPDKlz44e0dr9Vutprt6NCQKthpg1P2JZGIWX+/KF2ezfdpqgFeHqw==
X-Received: by 2002:a05:6602:4897:b0:8a6:d20a:ee1 with SMTP id ca18e2360f4ac-8ade0ed8ff3mr1019606639f.18.1758400748282;
        Sat, 20 Sep 2025 13:39:08 -0700 (PDT)
Received: from localhost ([140.82.166.162])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-8a46da3e981sm283735739f.9.2025.09.20.13.39.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Sep 2025 13:39:07 -0700 (PDT)
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
Subject: [RFC PATCH v2 12/18] iommu/riscv: Add guest file irqbypass support
Date: Sat, 20 Sep 2025 15:39:02 -0500
Message-ID: <20250920203851.2205115-32-ajones@ventanamicro.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250920203851.2205115-20-ajones@ventanamicro.com>
References: <20250920203851.2205115-20-ajones@ventanamicro.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement irq_set_vcpu_affinity() in the RISCV IOMMU driver.
irq_set_vcpu_affinity() is the channel from a hypervisor to the
IOMMU needed to ensure that assigned devices which direct MSIs to
guest IMSIC addresses will have those MSI writes redirected to
their corresponding guest interrupt files.

Signed-off-by: Andrew Jones <ajones@ventanamicro.com>
---
 drivers/iommu/riscv/iommu-ir.c | 165 ++++++++++++++++++++++++++++++++-
 drivers/iommu/riscv/iommu.c    |   5 +-
 drivers/iommu/riscv/iommu.h    |   4 +
 3 files changed, 171 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/riscv/iommu-ir.c b/drivers/iommu/riscv/iommu-ir.c
index 059671f18267..48f424ce1a8d 100644
--- a/drivers/iommu/riscv/iommu-ir.c
+++ b/drivers/iommu/riscv/iommu-ir.c
@@ -10,6 +10,8 @@
 #include <linux/msi.h>
 #include <linux/sizes.h>
 
+#include <asm/irq.h>
+
 #include "../iommu-pages.h"
 #include "iommu.h"
 
@@ -164,6 +166,48 @@ static void riscv_iommu_ir_msitbl_inval(struct riscv_iommu_domain *domain,
 	rcu_read_unlock();
 }
 
+static void riscv_iommu_ir_msitbl_clear(struct riscv_iommu_domain *domain)
+{
+	for (size_t i = 0; i < riscv_iommu_ir_nr_msiptes(domain); i++) {
+		riscv_iommu_ir_clear_pte(&domain->msi_root[i]);
+		refcount_set(&domain->msi_pte_counts[i], 0);
+	}
+}
+
+static void riscv_iommu_ir_msiptp_update(struct riscv_iommu_domain *domain)
+{
+	struct riscv_iommu_bond *bond;
+	struct riscv_iommu_device *iommu, *prev;
+	struct riscv_iommu_dc new_dc = {
+		.ta = FIELD_PREP(RISCV_IOMMU_PC_TA_PSCID, domain->pscid) |
+		      RISCV_IOMMU_PC_TA_V,
+		.fsc = FIELD_PREP(RISCV_IOMMU_PC_FSC_MODE, domain->pgd_mode) |
+		       FIELD_PREP(RISCV_IOMMU_PC_FSC_PPN, virt_to_pfn(domain->pgd_root)),
+		.msiptp = virt_to_pfn(domain->msi_root) |
+			  FIELD_PREP(RISCV_IOMMU_DC_MSIPTP_MODE,
+				     RISCV_IOMMU_DC_MSIPTP_MODE_FLAT),
+		.msi_addr_mask = domain->msi_addr_mask,
+		.msi_addr_pattern = domain->msi_addr_pattern,
+	};
+
+	/* Like riscv_iommu_ir_msitbl_inval(), synchronize with riscv_iommu_bond_link() */
+	smp_mb();
+
+	rcu_read_lock();
+
+	prev = NULL;
+	list_for_each_entry_rcu(bond, &domain->bonds, list) {
+		iommu = dev_to_iommu(bond->dev);
+		if (iommu == prev)
+			continue;
+
+		riscv_iommu_iodir_update(iommu, bond->dev, &new_dc);
+		prev = iommu;
+	}
+
+	rcu_read_unlock();
+}
+
 struct riscv_iommu_ir_chip_data {
 	size_t idx;
 	u32 config;
@@ -279,12 +323,127 @@ static int riscv_iommu_ir_irq_set_affinity(struct irq_data *data,
 	return ret;
 }
 
+static bool riscv_iommu_ir_vcpu_check_config(struct riscv_iommu_domain *domain,
+					     struct riscv_iommu_ir_vcpu_info *vcpu_info)
+{
+	return domain->msi_addr_mask == vcpu_info->msi_addr_mask &&
+	       domain->msi_addr_pattern == vcpu_info->msi_addr_pattern &&
+	       domain->group_index_bits == vcpu_info->group_index_bits &&
+	       domain->group_index_shift == vcpu_info->group_index_shift;
+}
+
+static int riscv_iommu_ir_vcpu_new_config(struct riscv_iommu_domain *domain,
+					  struct irq_data *data,
+					  struct riscv_iommu_ir_vcpu_info *vcpu_info)
+{
+	struct riscv_iommu_msipte *pte;
+	size_t idx;
+	int ret;
+
+	if (domain->pgd_mode)
+		riscv_iommu_ir_unmap_imsics(domain);
+
+	riscv_iommu_ir_msitbl_clear(domain);
+
+	domain->msi_addr_mask = vcpu_info->msi_addr_mask;
+	domain->msi_addr_pattern = vcpu_info->msi_addr_pattern;
+	domain->group_index_bits = vcpu_info->group_index_bits;
+	domain->group_index_shift = vcpu_info->group_index_shift;
+	domain->imsic_stride = SZ_4K;
+	domain->msitbl_config += 1;
+
+	if (domain->pgd_mode) {
+		/*
+		 * As in riscv_iommu_ir_irq_domain_create(), we do all stage1
+		 * mappings up front since the MSI table will manage the
+		 * translations.
+		 *
+		 * XXX: Since irq-set-vcpu-affinity is called in atomic context
+		 * we need GFP_ATOMIC. If the number of 4K dma pte allocations
+		 * is considered too many for GFP_ATOMIC, then we can wrap
+		 * riscv_iommu_pte_alloc()'s iommu_alloc_pages_node_sz() call
+		 * in a mempool and try to ensure the pool has enough elements
+		 * in riscv_iommu_ir_irq_domain_enable_msis().
+		 */
+		ret = riscv_iommu_ir_map_imsics(domain, GFP_ATOMIC);
+		if (ret)
+			return ret;
+	}
+
+	idx = riscv_iommu_ir_compute_msipte_idx(domain, vcpu_info->gpa);
+	pte = &domain->msi_root[idx];
+	riscv_iommu_ir_irq_set_msitbl_info(data, idx, domain->msitbl_config);
+	riscv_iommu_ir_set_pte(pte, vcpu_info->hpa);
+	riscv_iommu_ir_msitbl_inval(domain, NULL);
+	refcount_set(&domain->msi_pte_counts[idx], 1);
+
+	riscv_iommu_ir_msiptp_update(domain);
+
+	return 0;
+}
+
+static int riscv_iommu_ir_irq_set_vcpu_affinity(struct irq_data *data, void *arg)
+{
+	struct riscv_iommu_info *info = data->domain->host_data;
+	struct riscv_iommu_domain *domain = info->domain;
+	struct riscv_iommu_ir_vcpu_info *vcpu_info = arg;
+	struct riscv_iommu_msipte pteval;
+	struct riscv_iommu_msipte *pte;
+	bool inc = false, dec = false;
+	size_t old_idx, new_idx;
+	u32 old_config;
+
+	if (!domain->msi_root)
+		return -EOPNOTSUPP;
+
+	old_idx = riscv_iommu_ir_irq_msitbl_idx(data);
+	old_config = riscv_iommu_ir_irq_msitbl_config(data);
+
+	if (!vcpu_info) {
+		riscv_iommu_ir_msitbl_unmap(domain, data, old_idx);
+		return 0;
+	}
+
+	guard(raw_spinlock)(&domain->msi_lock);
+
+	if (!riscv_iommu_ir_vcpu_check_config(domain, vcpu_info))
+		return riscv_iommu_ir_vcpu_new_config(domain, data, vcpu_info);
+
+	new_idx = riscv_iommu_ir_compute_msipte_idx(domain, vcpu_info->gpa);
+	riscv_iommu_ir_irq_set_msitbl_info(data, new_idx, domain->msitbl_config);
+
+	pte = &domain->msi_root[new_idx];
+	riscv_iommu_ir_set_pte(&pteval, vcpu_info->hpa);
+
+	if (pteval.pte != pte->pte) {
+		*pte = pteval;
+		riscv_iommu_ir_msitbl_inval(domain, pte);
+	}
+
+	if (old_config != domain->msitbl_config)
+		inc = true;
+	else if (new_idx != old_idx)
+		inc = dec = true;
+
+	if (dec && refcount_dec_and_test(&domain->msi_pte_counts[old_idx])) {
+		pte = &domain->msi_root[old_idx];
+		riscv_iommu_ir_clear_pte(pte);
+		riscv_iommu_ir_msitbl_inval(domain, pte);
+	}
+
+	if (inc && !refcount_inc_not_zero(&domain->msi_pte_counts[new_idx]))
+		refcount_set(&domain->msi_pte_counts[new_idx], 1);
+
+	return 0;
+}
+
 static struct irq_chip riscv_iommu_ir_irq_chip = {
 	.name			= "IOMMU-IR",
 	.irq_ack		= irq_chip_ack_parent,
 	.irq_mask		= irq_chip_mask_parent,
 	.irq_unmask		= irq_chip_unmask_parent,
 	.irq_set_affinity	= riscv_iommu_ir_irq_set_affinity,
+	.irq_set_vcpu_affinity	= riscv_iommu_ir_irq_set_vcpu_affinity,
 };
 
 static int riscv_iommu_ir_irq_domain_alloc_irqs(struct irq_domain *irqdomain,
@@ -334,7 +493,11 @@ static void riscv_iommu_ir_irq_domain_free_irqs(struct irq_domain *irqdomain,
 		config = riscv_iommu_ir_irq_msitbl_config(data);
 		/*
 		 * Only irqs with matching config versions need to be unmapped here
-		 * since config changes will unmap everything.
+		 * since config changes will unmap everything and irq-set-vcpu-affinity
+		 * irq deletions unmap at deletion time. An example of stale indices that
+		 * don't need to be unmapped are those of irqs allocated by VFIO that a
+		 * guest driver never used. The config change made for the guest will have
+		 * already unmapped those, though, so there's no need to unmap them here.
 		 */
 		if (config == domain->msitbl_config) {
 			idx = riscv_iommu_ir_irq_msitbl_idx(data);
diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.c
index 440c3eb6f15a..02f38aa0b231 100644
--- a/drivers/iommu/riscv/iommu.c
+++ b/drivers/iommu/riscv/iommu.c
@@ -957,8 +957,9 @@ static void riscv_iommu_iotlb_inval(struct riscv_iommu_domain *domain,
  * device is not quiesced might be disruptive, potentially causing
  * interim translation faults.
  */
-static void riscv_iommu_iodir_update(struct riscv_iommu_device *iommu,
-				     struct device *dev, struct riscv_iommu_dc *new_dc)
+void riscv_iommu_iodir_update(struct riscv_iommu_device *iommu,
+			      struct device *dev,
+			      struct riscv_iommu_dc *new_dc)
 {
 	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
 	struct riscv_iommu_dc *dc;
diff --git a/drivers/iommu/riscv/iommu.h b/drivers/iommu/riscv/iommu.h
index 130f82e8392a..5ab2b4d6ee88 100644
--- a/drivers/iommu/riscv/iommu.h
+++ b/drivers/iommu/riscv/iommu.h
@@ -124,6 +124,10 @@ int riscv_iommu_init(struct riscv_iommu_device *iommu);
 void riscv_iommu_remove(struct riscv_iommu_device *iommu);
 void riscv_iommu_disable(struct riscv_iommu_device *iommu);
 
+void riscv_iommu_iodir_update(struct riscv_iommu_device *iommu,
+			      struct device *dev,
+			      struct riscv_iommu_dc *new_dc);
+
 void riscv_iommu_cmd_send(struct riscv_iommu_device *iommu,
 			  struct riscv_iommu_command *cmd);
 void riscv_iommu_cmd_sync(struct riscv_iommu_device *iommu, unsigned int timeout_us);
-- 
2.49.0

