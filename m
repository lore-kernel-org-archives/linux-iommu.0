Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C71762DFF1D
	for <iommu@lists.linux.dev>; Sat, 20 Sep 2025 20:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758400750; cv=none; b=Yoax9288RkA8SCnh2jqLILr3zDQz+8MwfsnD8B3qoUCPSg1m5TajvctXnLsaYAefNgcH5Jn6kQKSgqihNbWJChHQk1vxZIrwPPnGdvPfF2uYV0ufMXB0hvRTAdpPSPgB8AlCIjsxYF9ba0UQNQCr84DoYb6YnuawgftNu6MvEbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758400750; c=relaxed/simple;
	bh=L4Ep+IlxKlKfQcYtfM7Ox88ty3BpmqbADwu0iQdcKxY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V7Hann8l/Fg5nBUQRxQ10Wo/1Y+xOqsy3D8snj2gG9ByClfCAaULLw/GRH3xoMooaQfQNDlO53K8/IH+WIRzTfKjflUoniaVYtkdPIPX56IDphmusT2ZWypNDYoQoEAWCGv78JB0/aIGJypXrnwl36h3+JshNnKVposPA6nipuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=ccZ1VwvF; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="ccZ1VwvF"
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-4256f0444caso1691095ab.1
        for <iommu@lists.linux.dev>; Sat, 20 Sep 2025 13:39:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1758400747; x=1759005547; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qLOgLIfPePBzUWNKI9OUk1ZH4Tzzj3tfMuaJlKPwZCo=;
        b=ccZ1VwvF4NVdrl31SpUhPrVs/tn4EgYvJPSueJ6LPXVO7KDo8G7DYglpNZ9nOW7bqr
         1jnLI4au96pAaj8ZRRiyIlmHCnIftlKT0z+81toPJTUtPHd81zx+VkqE9iybGHZyNZhh
         Frv1uiMG6Lbv8sOnQ5QmN/EAWlzzURHE4GlTjw5atQmxK6OUdj00GBbPySOBtbDAPART
         Os/2kIIZ9TYRJ0Wp/ZMcG04MUSN+xn2zY8FkteW/33HcjV0RY79tIj95msbOrQwL5lw4
         KyyOj1IzwvxOsILKlhl46qGM5UhS89Ir26Namw1JyWElI1LfHwakGfeELlwep2mEnfLz
         xCQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758400747; x=1759005547;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qLOgLIfPePBzUWNKI9OUk1ZH4Tzzj3tfMuaJlKPwZCo=;
        b=jAEnPcDLaymc1cnUimUQcbloJ8yvXL3YrlW3fRn1GOsWTwK0oD127+TbFzi/v5jNg1
         tg5uVoQA/iWQeXhrwg+BmTbpipxIudu19lxFqSWCDIB3DqMMog1igmUqm5NQ0echAcfN
         Xo9Q+iEBpNjjcmvgWN4/S6T/KB1xtfSpXDbKuuus1CLr6pHI0t6O6YWqvvjo4GiRgU8t
         zEI7tACsNyN8waGi4R+4OvWkPCecxoqkcZIUC+8Y5CRbzWaTiwJf1YhSPaAYt7rqXscG
         E6YhmiEWTAsMG8jFfNLl6/Uzt5FBZ9eFIH4DfbvvdXLUJFYeFjlrJYmO+5TYgum/J/uf
         DAgw==
X-Gm-Message-State: AOJu0YyxKPJ5ATY6xe59+6ek5t33LyNeBLemzZCBXyluq61Zg3LmkFQr
	Rtt4VXFQFR7mJgWy2S2+oiYnJHRAYpPNDzgS7J3Kw87R7E0lTApZ8d7JBSgozhjnwhYNMqgDgYH
	uG2h9NQo=
X-Gm-Gg: ASbGncvkUXyuzrAb7tbg0bnFEvippwBhtDkNFcbcKqSwGCDvTejzVtk2OQxZyX2R/5D
	UudSE3yEKU1SKkkVrigmwsWdfhRuKeZyJm58MBd+kr0wDWHdroMpuxohz/6a11Z2MM38BJWUa6o
	47Cg4czwq+xcng1PpnilXJ0hwNe8ABPqkerFwprKZQlBlrS+YvMzlFdF7uhk/CwaxgtpxSQBFH5
	f91OvpCoK/VhcWLq/xkFPG3U8wre4Oc7DXIgGALPVzeLEHw7GWE8PdSXXiWRJLNpWcvSp7+lMpv
	+nMTvT4zt5WjlT4FJVM0WUIYkBzUrBRCiQURK3aUmn3Xf9AdGGq6rmnTHdB1X7zJKmL4UgMBvp1
	Li2TM/Z8nhA+iA4qKRrHnzXyb
X-Google-Smtp-Source: AGHT+IEWlWgkYSGO8sbLjeEJVsqweL0Gl+KFRCXKq/6gJAMJHxAY6N4lyWxDMwaZbg9QR7K4TJrpzg==
X-Received: by 2002:a05:6e02:1a64:b0:423:5293:5739 with SMTP id e9e14a558f8ab-424819748bamr113626355ab.19.1758400746834;
        Sat, 20 Sep 2025 13:39:06 -0700 (PDT)
Received: from localhost ([140.82.166.162])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-4244a4938b4sm38308745ab.11.2025.09.20.13.39.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Sep 2025 13:39:06 -0700 (PDT)
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
Subject: [RFC PATCH v2 11/18] iommu/riscv: Maintain each irq msitbl index with chip data
Date: Sat, 20 Sep 2025 15:39:01 -0500
Message-ID: <20250920203851.2205115-31-ajones@ventanamicro.com>
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

Track each IRQ's MSI table index in the IRQ's chip data of the IR
irqdomain along with a generation number. This will be necessary
when support for irq-set-vcpu-affinity is added as the msitbl
configuration will change to match the guest. When a configuration
changes then it may no longer be possible to compute the index from
the target address, hence the need to stash it. Also, if an allocated
IRQ is not mapped with irq-set-vcpu-affinity after a configuration
change (which will unmap everything), then we need to avoid
attempting to unmap it at free-irqs time.

Signed-off-by: Andrew Jones <ajones@ventanamicro.com>
---
 drivers/iommu/riscv/iommu-ir.c | 75 +++++++++++++++++++++++++++++-----
 drivers/iommu/riscv/iommu.h    |  1 +
 2 files changed, 65 insertions(+), 11 deletions(-)

diff --git a/drivers/iommu/riscv/iommu-ir.c b/drivers/iommu/riscv/iommu-ir.c
index b97768cac4be..059671f18267 100644
--- a/drivers/iommu/riscv/iommu-ir.c
+++ b/drivers/iommu/riscv/iommu-ir.c
@@ -164,11 +164,42 @@ static void riscv_iommu_ir_msitbl_inval(struct riscv_iommu_domain *domain,
 	rcu_read_unlock();
 }
 
-static void riscv_iommu_ir_msitbl_map(struct riscv_iommu_domain *domain, size_t idx,
-				      phys_addr_t addr)
+struct riscv_iommu_ir_chip_data {
+	size_t idx;
+	u32 config;
+};
+
+static size_t riscv_iommu_ir_irq_msitbl_idx(struct irq_data *data)
+{
+	struct riscv_iommu_ir_chip_data *chip_data = irq_data_get_irq_chip_data(data);
+
+	return chip_data->idx;
+}
+
+static u32 riscv_iommu_ir_irq_msitbl_config(struct irq_data *data)
+{
+	struct riscv_iommu_ir_chip_data *chip_data = irq_data_get_irq_chip_data(data);
+
+	return chip_data->config;
+}
+
+static void riscv_iommu_ir_irq_set_msitbl_info(struct irq_data *data,
+					       size_t idx, u32 config)
+{
+	struct riscv_iommu_ir_chip_data *chip_data = irq_data_get_irq_chip_data(data);
+
+	chip_data->idx = idx;
+	chip_data->config = config;
+}
+
+static void riscv_iommu_ir_msitbl_map(struct riscv_iommu_domain *domain,
+				      struct irq_data *data,
+				      size_t idx, phys_addr_t addr)
 {
 	struct riscv_iommu_msipte *pte;
 
+	riscv_iommu_ir_irq_set_msitbl_info(data, idx, domain->msitbl_config);
+
 	if (!domain->msi_root)
 		return;
 
@@ -186,9 +217,17 @@ static void riscv_iommu_ir_msitbl_map(struct riscv_iommu_domain *domain, size_t
 	}
 }
 
-static void riscv_iommu_ir_msitbl_unmap(struct riscv_iommu_domain *domain, size_t idx)
+static void riscv_iommu_ir_msitbl_unmap(struct riscv_iommu_domain *domain,
+					struct irq_data *data, size_t idx)
 {
 	struct riscv_iommu_msipte *pte;
+	u32 config;
+
+	config = riscv_iommu_ir_irq_msitbl_config(data);
+	riscv_iommu_ir_irq_set_msitbl_info(data, -1, -1);
+
+	if (WARN_ON_ONCE(config != domain->msitbl_config))
+		return;
 
 	if (!domain->msi_root)
 		return;
@@ -219,11 +258,11 @@ static int riscv_iommu_ir_irq_set_affinity(struct irq_data *data,
 {
 	struct riscv_iommu_info *info = data->domain->host_data;
 	struct riscv_iommu_domain *domain = info->domain;
-	phys_addr_t old_addr, new_addr;
 	size_t old_idx, new_idx;
+	phys_addr_t new_addr;
 	int ret;
 
-	old_idx = riscv_iommu_ir_get_msipte_idx_from_target(domain, data, &old_addr);
+	old_idx = riscv_iommu_ir_irq_msitbl_idx(data);
 
 	ret = irq_chip_set_affinity_parent(data, dest, force);
 	if (ret < 0)
@@ -234,8 +273,8 @@ static int riscv_iommu_ir_irq_set_affinity(struct irq_data *data,
 	if (new_idx == old_idx)
 		return ret;
 
-	riscv_iommu_ir_msitbl_unmap(domain, old_idx);
-	riscv_iommu_ir_msitbl_map(domain, new_idx, new_addr);
+	riscv_iommu_ir_msitbl_unmap(domain, data, old_idx);
+	riscv_iommu_ir_msitbl_map(domain, data, new_idx, new_addr);
 
 	return ret;
 }
@@ -254,11 +293,16 @@ static int riscv_iommu_ir_irq_domain_alloc_irqs(struct irq_domain *irqdomain,
 {
 	struct riscv_iommu_info *info = irqdomain->host_data;
 	struct riscv_iommu_domain *domain = info->domain;
+	struct riscv_iommu_ir_chip_data *chip_data;
 	struct irq_data *data;
 	phys_addr_t addr;
 	size_t idx;
 	int i, ret;
 
+	chip_data = kzalloc(sizeof(*chip_data), GFP_KERNEL_ACCOUNT);
+	if (!chip_data)
+		return -ENOMEM;
+
 	ret = irq_domain_alloc_irqs_parent(irqdomain, irq_base, nr_irqs, arg);
 	if (ret)
 		return ret;
@@ -266,8 +310,9 @@ static int riscv_iommu_ir_irq_domain_alloc_irqs(struct irq_domain *irqdomain,
 	for (i = 0; i < nr_irqs; i++) {
 		data = irq_domain_get_irq_data(irqdomain, irq_base + i);
 		data->chip = &riscv_iommu_ir_irq_chip;
+		data->chip_data = chip_data;
 		idx = riscv_iommu_ir_get_msipte_idx_from_target(domain, data, &addr);
-		riscv_iommu_ir_msitbl_map(domain, idx, addr);
+		riscv_iommu_ir_msitbl_map(domain, data, idx, addr);
 	}
 
 	return 0;
@@ -280,14 +325,22 @@ static void riscv_iommu_ir_irq_domain_free_irqs(struct irq_domain *irqdomain,
 	struct riscv_iommu_info *info = irqdomain->host_data;
 	struct riscv_iommu_domain *domain = info->domain;
 	struct irq_data *data;
-	phys_addr_t addr;
+	u32 config;
 	size_t idx;
 	int i;
 
 	for (i = 0; i < nr_irqs; i++) {
 		data = irq_domain_get_irq_data(irqdomain, irq_base + i);
-		idx = riscv_iommu_ir_get_msipte_idx_from_target(domain, data, &addr);
-		riscv_iommu_ir_msitbl_unmap(domain, idx);
+		config = riscv_iommu_ir_irq_msitbl_config(data);
+		/*
+		 * Only irqs with matching config versions need to be unmapped here
+		 * since config changes will unmap everything.
+		 */
+		if (config == domain->msitbl_config) {
+			idx = riscv_iommu_ir_irq_msitbl_idx(data);
+			riscv_iommu_ir_msitbl_unmap(domain, data, idx);
+		}
+		kfree(data->chip_data);
 	}
 
 	irq_domain_free_irqs_parent(irqdomain, irq_base, nr_irqs);
diff --git a/drivers/iommu/riscv/iommu.h b/drivers/iommu/riscv/iommu.h
index aeb5642f003c..130f82e8392a 100644
--- a/drivers/iommu/riscv/iommu.h
+++ b/drivers/iommu/riscv/iommu.h
@@ -36,6 +36,7 @@ struct riscv_iommu_domain {
 	struct riscv_iommu_msipte *msi_root;
 	refcount_t *msi_pte_counts;
 	raw_spinlock_t msi_lock;
+	u32 msitbl_config;
 	u64 msi_addr_mask;
 	u64 msi_addr_pattern;
 	u32 group_index_bits;
-- 
2.49.0

