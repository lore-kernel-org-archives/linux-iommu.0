Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F111223E6ED
	for <iommu@lists.linux.dev>; Thu, 12 Dec 2024 18:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734026770; cv=none; b=jLa5VNn+zTOHBSfzPQNrp19azriqaAPxtvKqCkNdrJOLYiqavTOH7i0v6soTId8RyTTE06wG6PkpdX54iUzAUAMT0HGtQ8pAs1QauJ5eude6FfidHDYSAHVjdnN7oK2bggzlde/Jojh7EhnhaHEgzZDzqrpAmxNu7FTLtp0R0zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734026770; c=relaxed/simple;
	bh=onbrJ9zcCDEgz4deQmM2rr2og6c6fCddvp2W4BDAzsY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=bAgOXQN2NM0QANwM9W+Z6HXzmFdAsDNrsP7hEFMvCzVQtjuGTz8LDNmwSrr1tNgyV9VwiMbzsIuIU3I3l55YhGhC3JIqem7W+9HsJ2QO7Y8D2ezhpVA1FpOcQHa7yQ/HvXg6xTupTbnRbN2mRuoTN11CyxUtNbU++KD3lq4C52g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=h+dT7/2x; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="h+dT7/2x"
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-43627bb20b5so4509815e9.1
        for <iommu@lists.linux.dev>; Thu, 12 Dec 2024 10:06:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734026767; x=1734631567; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=gI/xVfW0NJIG4pabP2PrJlF4/ywCtn5dWW4kgaXryCA=;
        b=h+dT7/2xHOI+aGzTAMZkJwxVoKIJeziynVQHxxKn+cnK+fmEfmmbk+3+uCi5Y+jOhT
         ipW3HUZndi+jiltO/nBj5Ji/Bx9EkD6iOcrmuPlpAQe9wK6gtkKoo3XDNqjDP8x+u/v8
         8fPlMm77h4f1lZ8WTCn0u81e+4R6m9iWgcLnTxNQ2DUDdVFSCwKhCSpMBSZbDOLHOA4q
         zBVsX6bC4phxX0SRUIZhhGw9SXHb2/z7WtwUoT2KLWom6GENnqgZcBT4jzSXbBHd2tDS
         FKRcFFdbSgBQfb9cQyDM3Eh+fh9IWpabeEzXWI+t312qTqTDt3pWuM7upHvYZ2/ZEjFM
         aiCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734026767; x=1734631567;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gI/xVfW0NJIG4pabP2PrJlF4/ywCtn5dWW4kgaXryCA=;
        b=lIGteu/mUJHUZSIs2Kew+3FY0LqNoxqtNn+45SCfp9lACBSlOaEE8p7EOXeVpMU6xE
         dcGotDKxIkG0geXj7pF3Jra4bFWNadTUUtDUUCzaneAtnSpbfTtKC4HFy2M3MZXIBTGS
         l1+7jpNZXS//eYsoQL7zG1n42Y4xUKt2zxJGJgEvzhdkkpykkZqs8KzCF7NN5ZqUdBf5
         tFU9aJJCjoKR+1mMmCVeMC6X1GS6WTAgDEtwyloGRH1XYnFRtRq4mzyriAEnXvEKenq2
         LpeSt8YxdDOQpy0PgUdLv9NknHc789XKdO8RoSdItzR51AZl1hldULNSK3M/2d0XQavj
         acaA==
X-Gm-Message-State: AOJu0YxVS71CDxlSK3SnDqL6E9UyRSmZpFi9j78MAJApIciRZRaKC4+g
	+7012t84JruK4ZJPruvcNV3GTQPidkrIbgtnUZTlubdQ4r0IWclPHPTPyNIAnMnmZNgSj9HDKMe
	rEvhVj7j/EqX/dM3A+8//L1kbmmdQRKs6bupa/uHBWvEy2KPjMz2R04sKa8i3dqpkoYTHu9bmEx
	crcp6p3kYki2DOMTbOprcCngnEe7KqIHPYf2N5aL8LpA==
X-Google-Smtp-Source: AGHT+IHQ4cd+c/HRUSDI+U6v3tD80p/r2kIFY0himPqzGsq85TsqDSkq/5V4+Is4wQaH97N2w1ilsWBcofMkbQ==
X-Received: from wmgg16.prod.google.com ([2002:a05:600d:10:b0:434:a7ee:3c40])
 (user=smostafa job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:19ca:b0:434:f819:251a with SMTP id 5b1f17b1804b1-4362282ab8emr40017385e9.9.1734026767627;
 Thu, 12 Dec 2024 10:06:07 -0800 (PST)
Date: Thu, 12 Dec 2024 18:04:04 +0000
In-Reply-To: <20241212180423.1578358-1-smostafa@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20241212180423.1578358-1-smostafa@google.com>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <20241212180423.1578358-41-smostafa@google.com>
Subject: [RFC PATCH v2 40/58] KVM: arm64: smmu-v3: Add map/unmap pages and iova_to_phys
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

Add map_pages and iova_to_phys HVC code, which
mainly calls the io-pgtable.

For unmap_pages, we rely on IO_PGTABLE_QUIRK_UNMAP_INVAL, where the
driver first calls unmap_pages which invalidate all the pages as
a typical unmap, issuing all the necessary TLB invalidations.
Then, we will start a page table with 2 callbacks:
- visit_leaf: for each unmapped leaf, it would decrement the refcount
  of the page using __pkvm_host_unuse_dma(), reversing the what IOMMU
  core does in map.
- visit_post_table: this would free any invalidated tables as they
  wouldn't be freed because of the quirk.

Signed-off-by: Mostafa Saleh <smostafa@google.com>
---
 arch/arm64/kvm/hyp/nvhe/iommu/arm-smmu-v3.c | 147 ++++++++++++++++++++
 1 file changed, 147 insertions(+)

diff --git a/arch/arm64/kvm/hyp/nvhe/iommu/arm-smmu-v3.c b/arch/arm64/kvm/hyp/nvhe/iommu/arm-smmu-v3.c
index ec3f8d9749d3..1821a3420a4d 100644
--- a/arch/arm64/kvm/hyp/nvhe/iommu/arm-smmu-v3.c
+++ b/arch/arm64/kvm/hyp/nvhe/iommu/arm-smmu-v3.c
@@ -808,15 +808,74 @@ static const struct iommu_flush_ops smmu_tlb_ops = {
 	.tlb_add_page	= smmu_tlb_add_page,
 };
 
+static void smmu_unmap_visit_leaf(phys_addr_t addr, size_t size,
+				  struct io_pgtable_walk_common *data,
+				  void *wd)
+{
+	u64 *ptep = wd;
+
+	WARN_ON(__pkvm_host_unuse_dma(addr, size));
+	*ptep = 0;
+}
+
+/*
+ * On unmap with the IO_PGTABLE_QUIRK_UNMAP_INVAL, unmap doesn't clear
+ * or free any tables, so after the unmap walk the table and on the post
+ * walk we free invalid tables.
+ * One caveat, is that a table can be unmapped while it points to other
+ * tables which would be valid, and we would need to free those also.
+ * The simples solution is to look at the walk PTE info and if any of
+ * the parents is invalid it means that this table also needs to freed.
+ */
+static void smmu_unmap_visit_post_table(struct arm_lpae_io_pgtable_walk_data *walk_data,
+					arm_lpae_iopte *ptep, int lvl)
+{
+	struct arm_lpae_io_pgtable *data = walk_data->cookie;
+	size_t table_size;
+	int i;
+	bool invalid = false;
+
+	if (lvl == data->start_level)
+		table_size = ARM_LPAE_PGD_SIZE(data);
+	else
+		table_size = ARM_LPAE_GRANULE(data);
+
+	for (i = 0 ; i <= lvl ; ++i)
+		invalid |= !iopte_valid(walk_data->ptes[lvl]);
+
+	if (!invalid)
+		return;
+
+	__arm_lpae_free_pages(ptep, table_size, &data->iop.cfg, data->iop.cookie);
+	*ptep = 0;
+}
+
 static void smmu_iotlb_sync(struct kvm_hyp_iommu_domain *domain,
 			    struct iommu_iotlb_gather *gather)
 {
 	size_t size;
+	struct hyp_arm_smmu_v3_domain *smmu_domain = domain->priv;
+	struct io_pgtable *pgtable = smmu_domain->pgtable;
+	struct arm_lpae_io_pgtable *data = io_pgtable_to_data(pgtable);
+	struct arm_lpae_io_pgtable_walk_data wd = {
+		.cookie = data,
+		.visit_post_table = smmu_unmap_visit_post_table,
+	};
+	struct io_pgtable_walk_common walk_data = {
+		.visit_leaf = smmu_unmap_visit_leaf,
+		.data = &wd,
+	};
 
 	if (!gather->pgsize)
 		return;
 	size = gather->end - gather->start + 1;
 	smmu_tlb_inv_range(domain, gather->start, size,  gather->pgsize, true);
+
+	/*
+	 * Now decrement the refcount of unmapped pages thanks to
+	 * IO_PGTABLE_QUIRK_UNMAP_INVAL
+	 */
+	pgtable->ops.pgtable_walk(&pgtable->ops, gather->start, size, &walk_data);
 }
 
 static int smmu_domain_config_s2(struct kvm_hyp_iommu_domain *domain,
@@ -966,6 +1025,7 @@ static int smmu_domain_finalise(struct hyp_arm_smmu_v3_device *smmu,
 			.oas = smmu->ias,
 			.coherent_walk = smmu->features & ARM_SMMU_FEAT_COHERENCY,
 			.tlb = &smmu_tlb_ops,
+			.quirks = IO_PGTABLE_QUIRK_UNMAP_INVAL,
 		};
 	} else {
 		cfg = (struct io_pgtable_cfg) {
@@ -975,6 +1035,7 @@ static int smmu_domain_finalise(struct hyp_arm_smmu_v3_device *smmu,
 			.oas = smmu->oas,
 			.coherent_walk = smmu->features & ARM_SMMU_FEAT_COHERENCY,
 			.tlb = &smmu_tlb_ops,
+			.quirks = IO_PGTABLE_QUIRK_UNMAP_INVAL,
 		};
 	}
 
@@ -1125,6 +1186,89 @@ static int smmu_detach_dev(struct kvm_hyp_iommu *iommu, struct kvm_hyp_iommu_dom
 	return ret;
 }
 
+static int smmu_map_pages(struct kvm_hyp_iommu_domain *domain, unsigned long iova,
+			  phys_addr_t paddr, size_t pgsize,
+			  size_t pgcount, int prot, size_t *total_mapped)
+{
+	size_t mapped;
+	size_t granule;
+	int ret;
+	struct hyp_arm_smmu_v3_domain *smmu_domain = domain->priv;
+	struct io_pgtable *pgtable = smmu_domain->pgtable;
+
+	if (!pgtable)
+		return -EINVAL;
+
+	granule = 1UL << __ffs(smmu_domain->pgtable->cfg.pgsize_bitmap);
+	if (!IS_ALIGNED(iova | paddr | pgsize, granule))
+		return -EINVAL;
+
+	hyp_spin_lock(&smmu_domain->pgt_lock);
+	while (pgcount && !ret) {
+		mapped = 0;
+		ret = pgtable->ops.map_pages(&pgtable->ops, iova, paddr,
+					     pgsize, pgcount, prot, 0, &mapped);
+		if (ret)
+			break;
+		WARN_ON(!IS_ALIGNED(mapped, pgsize));
+		WARN_ON(mapped > pgcount * pgsize);
+
+		pgcount -= mapped / pgsize;
+		*total_mapped += mapped;
+		iova += mapped;
+		paddr += mapped;
+	}
+	hyp_spin_unlock(&smmu_domain->pgt_lock);
+
+	return 0;
+}
+
+static size_t smmu_unmap_pages(struct kvm_hyp_iommu_domain *domain, unsigned long iova,
+			       size_t pgsize, size_t pgcount, struct iommu_iotlb_gather *gather)
+{
+	size_t granule, unmapped, total_unmapped = 0;
+	size_t size = pgsize * pgcount;
+	struct hyp_arm_smmu_v3_domain *smmu_domain = domain->priv;
+	struct io_pgtable *pgtable = smmu_domain->pgtable;
+
+	if (!pgtable)
+		return -EINVAL;
+
+	granule = 1UL << __ffs(smmu_domain->pgtable->cfg.pgsize_bitmap);
+	if (!IS_ALIGNED(iova | pgsize, granule))
+		return 0;
+
+	hyp_spin_lock(&smmu_domain->pgt_lock);
+	while (total_unmapped < size) {
+		unmapped = pgtable->ops.unmap_pages(&pgtable->ops, iova, pgsize,
+						    pgcount, gather);
+		if (!unmapped)
+			break;
+		iova += unmapped;
+		total_unmapped += unmapped;
+		pgcount -= unmapped / pgsize;
+	}
+	hyp_spin_unlock(&smmu_domain->pgt_lock);
+	return total_unmapped;
+}
+
+static phys_addr_t smmu_iova_to_phys(struct kvm_hyp_iommu_domain *domain,
+				     unsigned long iova)
+{
+	phys_addr_t paddr;
+	struct hyp_arm_smmu_v3_domain *smmu_domain = domain->priv;
+	struct io_pgtable *pgtable = smmu_domain->pgtable;
+
+	if (!pgtable)
+		return -EINVAL;
+
+	hyp_spin_lock(&smmu_domain->pgt_lock);
+	paddr = pgtable->ops.iova_to_phys(&pgtable->ops, iova);
+	hyp_spin_unlock(&smmu_domain->pgt_lock);
+
+	return paddr;
+}
+
 /* Shared with the kernel driver in EL1 */
 struct kvm_iommu_ops smmu_ops = {
 	.init				= smmu_init,
@@ -1134,4 +1278,7 @@ struct kvm_iommu_ops smmu_ops = {
 	.iotlb_sync			= smmu_iotlb_sync,
 	.attach_dev			= smmu_attach_dev,
 	.detach_dev			= smmu_detach_dev,
+	.map_pages			= smmu_map_pages,
+	.unmap_pages			= smmu_unmap_pages,
+	.iova_to_phys			= smmu_iova_to_phys,
 };
-- 
2.47.0.338.g60cca15819-goog

