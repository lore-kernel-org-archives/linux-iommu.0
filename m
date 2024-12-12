Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 063E123E6E1
	for <iommu@lists.linux.dev>; Thu, 12 Dec 2024 18:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734026769; cv=none; b=sLhk1li6Z0xtpSWGbQ3IQWjcX4KdfzHFyqxq7vfQhkdguMzHcYxOVOvXfsQ1Gy+he+WHSrttY/DennzgXy4fxw6z2Dpgqy8iwjkb8yrMeDNzETWoh2CyQtk/rfGaM1ugRYv+Z+c3qukC0/i34klFrg1jzp2wvX5gXl9Qae6IRUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734026769; c=relaxed/simple;
	bh=XHk9s5KgEnNMUGLMGLhFngN3D3QuPGl/2qoxo6DFT74=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=pBmziNH+UxLq4DEEA1P1AMJ1JmXMtYyt9WaoLIbgi9LJXc+J81Un69We+kmXPZoHxV19aahJ/QRRfNQlnvmOweTzOwX/q1EUnWo0akljiFYJfOukKegiPT4HNDEDNnqFW9CiNzBpLJrBguxEL7gHiRBwAGuZwFR6RawYHCfkL4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=29IZhcup; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="29IZhcup"
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-436289a570eso3573735e9.0
        for <iommu@lists.linux.dev>; Thu, 12 Dec 2024 10:06:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734026766; x=1734631566; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=rqPsJB88kXVR+TaQlcSaWv/z9lPFdx9zLwQbYqyNGLA=;
        b=29IZhcupaFRJKHz2rA9R2qA8phjTf51ZsN5RRWbjR7H5z1eRrmV8DJP7Q5Vi3aMd4I
         VWvaUkAiecipWx+lrKbauRbndv9e1pJfCsX8Ws9bDfVcdhKapnYl0icT0c175NtpAL0N
         Q9b2TBrSl4Z1CTdO0QdQ5g8bLmmwLWY33Rz7z00xhJI/a+nRJdyBGIRJed7np6f6MY1G
         q0aluCALnkligpNDAVRLRzDdhIJxrvvitZY3JoqCnfMZs+858dCGiiAb0sJoYMwAPtLI
         F0KnFa02q+/PJYQHoMooa2G5fDwvIkP8XzgkO6XUNC65XGGtaY9cIHyZmChmgSixjDlZ
         gbMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734026766; x=1734631566;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rqPsJB88kXVR+TaQlcSaWv/z9lPFdx9zLwQbYqyNGLA=;
        b=ogeXGLrjxxmm4R9i0sAF8dRqhBLUd4wiCl3HYTY6pyBjy2v/DD6zYOJMsmrhOdm5bi
         Iz9jtlHKnUwa/HKU+bM5rYZDthNKiojYdUQam71L3ZqfAE+t5cHzoIclYkjkKW2ECiIs
         5gIQHrS3opNOpqPk7VcZC6hmo/V0tCZ3ivlkqWcpYsV5G0hs/XH0ghl/DrylZGCgARk8
         5j/mnjBIb6ZE3/vI7fM4cuYBlhm1ablGP4uQSwgikWw4ZV+xper+s8Xho4o0Sl2Tcg95
         DpR+VR3qw4PZp4UBhjn/k3gKJRuA4LvvJWP7lyRb6pFQ+n2DQfHDyVSgcuHAzWNKo8bF
         FlzA==
X-Gm-Message-State: AOJu0YyOk949tG5/AZNio9c5VzlRHsLYa6MUgyTfAbmMjCsdSehdTyPF
	nzQkyIjeZcLLz3KhGWDAjtJLWkokZL84VI+Zi9oYPkKEw+hnF3YoGzZ89nXBCP2cfT4zuidkGu5
	0JPUCD3dscqLRT2Mdjs2594ByopdDBuUKSIYhJAM/wmf8fRBkVU+p+TZ0I3V1wYxpZXTC1F4AfB
	V3fv0O+p6+ii7wEDu5+43wO9GbhB1jr34zsVvR3j/IuA==
X-Google-Smtp-Source: AGHT+IEsi+4ZjdjaE64e2fAsGHvL3ha82aYz7MzT70dGqsLuOIBzlVogt+pct6VgpmBHvLpi6wagEZsN2iELKw==
X-Received: from wmos10.prod.google.com ([2002:a05:600c:45ca:b0:434:fa72:f1bf])
 (user=smostafa job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:4450:b0:434:f5c0:329f with SMTP id 5b1f17b1804b1-4361c3bd9e8mr84507805e9.14.1734026765211;
 Thu, 12 Dec 2024 10:06:05 -0800 (PST)
Date: Thu, 12 Dec 2024 18:04:03 +0000
In-Reply-To: <20241212180423.1578358-1-smostafa@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20241212180423.1578358-1-smostafa@google.com>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <20241212180423.1578358-40-smostafa@google.com>
Subject: [RFC PATCH v2 39/58] drivers/iommu: io-pgtable: Add IO_PGTABLE_QUIRK_UNMAP_INVAL
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

Only invalidate PTE without clearing it.

For io-pgtable-armm that also leaves the table allocated after an
unmap as they can't be freed.

This quirk also will allow the page table walker to traverse through
tables invalidated by an unmap, allowing the caller to doing any
booking keeping and freeing the table after.

Signed-off-by: Mostafa Saleh <smostafa@google.com>
---
 drivers/iommu/io-pgtable-arm-common.c | 50 +++++++++++++++++++--------
 include/linux/io-pgtable-arm.h        |  7 +++-
 include/linux/io-pgtable.h            |  5 ++-
 3 files changed, 45 insertions(+), 17 deletions(-)

diff --git a/drivers/iommu/io-pgtable-arm-common.c b/drivers/iommu/io-pgtable-arm-common.c
index 076240eaec19..89be1aa72a6b 100644
--- a/drivers/iommu/io-pgtable-arm-common.c
+++ b/drivers/iommu/io-pgtable-arm-common.c
@@ -42,7 +42,10 @@ static phys_addr_t iopte_to_paddr(arm_lpae_iopte pte,
 static void __arm_lpae_clear_pte(arm_lpae_iopte *ptep, struct io_pgtable_cfg *cfg, int num_entries)
 {
 	for (int i = 0; i < num_entries; i++)
-		ptep[i] = 0;
+		if (cfg->quirks & IO_PGTABLE_QUIRK_UNMAP_INVAL)
+			ptep[i] &= ~ARM_LPAE_PTE_VALID;
+		else
+			ptep[i] = 0;
 
 	if (!cfg->coherent_walk && num_entries)
 		__arm_lpae_sync_pte(ptep, num_entries, cfg);
@@ -170,7 +173,7 @@ static int __arm_lpae_map(struct arm_lpae_io_pgtable *data, unsigned long iova,
 
 	/* Grab a pointer to the next level */
 	pte = READ_ONCE(*ptep);
-	if (!pte) {
+	if (!iopte_valid(pte)) {
 		cptep = __arm_lpae_alloc_pages(tblsz, gfp, cfg, data->iop.cookie);
 		if (!cptep)
 			return -ENOMEM;
@@ -182,9 +185,9 @@ static int __arm_lpae_map(struct arm_lpae_io_pgtable *data, unsigned long iova,
 		__arm_lpae_sync_pte(ptep, 1, cfg);
 	}
 
-	if (pte && !iopte_leaf(pte, lvl, data->iop.fmt)) {
+	if (iopte_valid(pte) && !iopte_leaf(pte, lvl, data->iop.fmt)) {
 		cptep = iopte_deref(pte, data);
-	} else if (pte) {
+	} else if (iopte_valid(pte)) {
 		/* We require an unmap first */
 		return arm_lpae_unmap_empty();
 	}
@@ -316,7 +319,7 @@ void __arm_lpae_free_pgtable(struct arm_lpae_io_pgtable *data, int lvl,
 	while (ptep != end) {
 		arm_lpae_iopte pte = *ptep++;
 
-		if (!pte || iopte_leaf(pte, lvl, data->iop.fmt))
+		if (!iopte_valid(pte) || iopte_leaf(pte, lvl, data->iop.fmt))
 			continue;
 
 		__arm_lpae_free_pgtable(data, lvl + 1, iopte_deref(pte, data));
@@ -401,7 +404,7 @@ static size_t __arm_lpae_unmap(struct arm_lpae_io_pgtable *data,
 	unmap_idx_start = ARM_LPAE_LVL_IDX(iova, lvl, data);
 	ptep += unmap_idx_start;
 	pte = READ_ONCE(*ptep);
-	if (WARN_ON(!pte))
+	if (WARN_ON(!iopte_valid(pte)))
 		return 0;
 
 	/* If the size matches this level, we're in the right place */
@@ -412,7 +415,7 @@ static size_t __arm_lpae_unmap(struct arm_lpae_io_pgtable *data,
 		/* Find and handle non-leaf entries */
 		for (i = 0; i < num_entries; i++) {
 			pte = READ_ONCE(ptep[i]);
-			if (WARN_ON(!pte))
+			if (WARN_ON(!iopte_valid(pte)))
 				break;
 
 			if (!iopte_leaf(pte, lvl, iop->fmt)) {
@@ -421,7 +424,9 @@ static size_t __arm_lpae_unmap(struct arm_lpae_io_pgtable *data,
 				/* Also flush any partial walks */
 				io_pgtable_tlb_flush_walk(iop, iova + i * size, size,
 							  ARM_LPAE_GRANULE(data));
-				__arm_lpae_free_pgtable(data, lvl + 1, iopte_deref(pte, data));
+				if (!(iop->cfg.quirks & IO_PGTABLE_QUIRK_UNMAP_INVAL))
+					__arm_lpae_free_pgtable(data, lvl + 1,
+								iopte_deref(pte, data));
 			}
 		}
 
@@ -523,9 +528,12 @@ static int visit_pgtable_walk(struct io_pgtable_walk_data *walk_data, int lvl,
 	return 0;
 }
 
-static void visit_pgtable_post_table(struct arm_lpae_io_pgtable_walk_data *data,
+static void visit_pgtable_post_table(struct io_pgtable_walk_data *walk_data,
 				     arm_lpae_iopte *ptep, int lvl)
 {
+	struct io_pgtable_walk_common *walker = walk_data->data;
+	struct arm_lpae_io_pgtable_walk_data *data = walker->data;
+
 	if (data->visit_post_table)
 		data->visit_post_table(data, ptep, lvl);
 }
@@ -550,30 +558,41 @@ static int io_pgtable_visit(struct arm_lpae_io_pgtable *data,
 			    arm_lpae_iopte *ptep, int lvl)
 {
 	struct io_pgtable *iop = &data->iop;
+	struct io_pgtable_cfg *cfg = &iop->cfg;
 	arm_lpae_iopte pte = READ_ONCE(*ptep);
 	struct io_pgtable_walk_common *walker = walk_data->data;
+	arm_lpae_iopte *old_ptep = ptep;
+	bool is_leaf, is_table;
 
 	size_t size = ARM_LPAE_BLOCK_SIZE(lvl, data);
 	int ret = walk_data->visit(walk_data, lvl, ptep, size);
 	if (ret)
 		return ret;
 
-	if (iopte_leaf(pte, lvl, iop->fmt)) {
+	if (cfg->quirks & IO_PGTABLE_QUIRK_UNMAP_INVAL) {
+		/* Visitng invalid tables as it still have enteries. */
+		is_table = pte && iopte_table(pte | ARM_LPAE_PTE_VALID, lvl);
+		is_leaf = pte && iopte_leaf(pte | ARM_LPAE_PTE_VALID, lvl, iop->fmt);
+	} else {
+		is_table = iopte_table(pte, lvl);
+		is_leaf = iopte_leaf(pte, lvl, iop->fmt);
+	}
+
+	if (is_leaf) {
 		if (walker->visit_leaf)
 			walker->visit_leaf(iopte_to_paddr(pte, data), size, walker, ptep);
 		walk_data->addr += size;
 		return 0;
 	}
 
-	if (!iopte_table(pte, lvl)) {
+	if (!is_table)
 		return -EINVAL;
-	}
 
 	ptep = iopte_deref(pte, data);
 	ret = __arm_lpae_iopte_walk(data, walk_data, ptep, lvl + 1);
 
 	if (walk_data->visit_post_table)
-		walk_data->visit_post_table(data, ptep, lvl);
+		walk_data->visit_post_table(walk_data, old_ptep, lvl);
 
 	return ret;
 }
@@ -744,7 +763,8 @@ int arm_lpae_init_pgtable_s1(struct io_pgtable_cfg *cfg,
 	if (cfg->quirks & ~(IO_PGTABLE_QUIRK_ARM_NS |
 			    IO_PGTABLE_QUIRK_ARM_TTBR1 |
 			    IO_PGTABLE_QUIRK_ARM_OUTER_WBWA |
-			    IO_PGTABLE_QUIRK_ARM_HD))
+			    IO_PGTABLE_QUIRK_ARM_HD |
+			    IO_PGTABLE_QUIRK_UNMAP_INVAL))
 		return -EINVAL;
 
 	ret = arm_lpae_init_pgtable(cfg, data);
@@ -830,7 +850,7 @@ int arm_lpae_init_pgtable_s2(struct io_pgtable_cfg *cfg,
 	typeof(&cfg->arm_lpae_s2_cfg.vtcr) vtcr = &cfg->arm_lpae_s2_cfg.vtcr;
 
 	/* The NS quirk doesn't apply at stage 2 */
-	if (cfg->quirks)
+	if (cfg->quirks & ~IO_PGTABLE_QUIRK_UNMAP_INVAL)
 		return -EINVAL;
 
 	ret = arm_lpae_init_pgtable(cfg, data);
diff --git a/include/linux/io-pgtable-arm.h b/include/linux/io-pgtable-arm.h
index c00eb0cb7e43..407f05fb300a 100644
--- a/include/linux/io-pgtable-arm.h
+++ b/include/linux/io-pgtable-arm.h
@@ -21,7 +21,7 @@ struct io_pgtable_walk_data {
 	struct io_pgtable_walk_common	*data;
 	int (*visit)(struct io_pgtable_walk_data *walk_data, int lvl,
 		     arm_lpae_iopte *ptep, size_t size);
-	void (*visit_post_table)(struct arm_lpae_io_pgtable_walk_data *data,
+	void (*visit_post_table)(struct io_pgtable_walk_data *walk_data,
 				 arm_lpae_iopte *ptep, int lvl);
 	unsigned long			flags;
 	u64				addr;
@@ -193,6 +193,11 @@ static inline bool iopte_table(arm_lpae_iopte pte, int lvl)
 	return iopte_type(pte) == ARM_LPAE_PTE_TYPE_TABLE;
 }
 
+static inline bool iopte_valid(arm_lpae_iopte pte)
+{
+	return pte & ARM_LPAE_PTE_VALID;
+}
+
 #ifdef __KVM_NVHE_HYPERVISOR__
 #include <nvhe/memory.h>
 #define __arm_lpae_virt_to_phys	hyp_virt_to_phys
diff --git a/include/linux/io-pgtable.h b/include/linux/io-pgtable.h
index 86226571cdb8..ce0aed9c87d2 100644
--- a/include/linux/io-pgtable.h
+++ b/include/linux/io-pgtable.h
@@ -89,6 +89,8 @@ struct io_pgtable_cfg {
 	 *	attributes set in the TCR for a non-coherent page-table walker.
 	 *
 	 * IO_PGTABLE_QUIRK_ARM_HD: Enables dirty tracking in stage 1 pagetable.
+	 *
+	 * IO_PGTABLE_QUIRK_UNMAP_INVAL: Only invalidate PTE on unmap, don't clear it.
 	 */
 	#define IO_PGTABLE_QUIRK_ARM_NS			BIT(0)
 	#define IO_PGTABLE_QUIRK_NO_PERMS		BIT(1)
@@ -97,6 +99,7 @@ struct io_pgtable_cfg {
 	#define IO_PGTABLE_QUIRK_ARM_TTBR1		BIT(5)
 	#define IO_PGTABLE_QUIRK_ARM_OUTER_WBWA		BIT(6)
 	#define IO_PGTABLE_QUIRK_ARM_HD			BIT(7)
+	#define IO_PGTABLE_QUIRK_UNMAP_INVAL		BIT(8)
 	unsigned long			quirks;
 	unsigned long			pgsize_bitmap;
 	unsigned int			ias;
@@ -194,7 +197,7 @@ struct arm_lpae_io_pgtable_walk_data {
 	int level;
 	void *cookie;
 	void (*visit_post_table)(struct arm_lpae_io_pgtable_walk_data *data,
-				 arm_lpae_iopte *ptep, int lvl);
+				 u64 *ptep, int lvl);
 };
 
 /**
-- 
2.47.0.338.g60cca15819-goog

