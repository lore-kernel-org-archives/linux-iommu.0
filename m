Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D300238D49
	for <iommu@lists.linux.dev>; Sat, 27 Sep 2025 22:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759012814; cv=none; b=atCynFT5hhqCrKzTgUK7lST5GT+EZDs6f9YUaq9diWhTuczRxS9mRTNIHd7uFhI0oWmwpp43YMcGKSECnM1oR0m3WQFdeCMkJ9Y7WvOUvyJ+yi2dP8BoknJz7aYQiQ59Xv7VKCAUR65qghogl91luHWRHbhCYnDYR5/mivO0F1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759012814; c=relaxed/simple;
	bh=ijTY9kE7P9DtuI/oS4gdvzvtDgwokWIe6WeJuOeZLCk=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=ZmPvOhiCMMEZDlSNuAkGVs+MKLIARPAlv2qqTgfjsknvDtHajSuY/oVie5qdi/3iOum64gNquqel5IGr8csLGrSvHVk1loKMqxMVUo+5x4NNh/DiXVPhU6Ajrkbb6Mh837BngnoudGaIikcRY1ALoDLnLd1PW0ZrX6QpC3SYrbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--danielmentz.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=z5olJ/AU; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--danielmentz.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="z5olJ/AU"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-27c62320f16so37170845ad.1
        for <iommu@lists.linux.dev>; Sat, 27 Sep 2025 15:40:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759012811; x=1759617611; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=cnz30dJx0HiX6zGp2Rht8KTzZqv90TYJIftWrY8q3Gg=;
        b=z5olJ/AUSbdvsFxiKYrRqcEu91lPS9/0PtbkI+ZSWBCX/ZYRsqTFpAJtj/y/NNVrXj
         QGheW5xWMxLufkk/n6pfoy6zno8C+lcUNC9RLVFEP/ETK9KsVL7EeRpONHc091qp5Cbr
         6pywqj/ntaug6Ah22ivCy5GffHp9PZGgRI7AWm/vZCDRj0I9nocoGd20D5ZdzCwmyi96
         5v+qI3v1NldkdNpBncojNaGYJtIRwPMNIckrPBYu4s/mSFBbPdJPs3W+JkHTpgJlNON7
         HCUDBhmNjUIxjvjIMSnvBV/ISZ835UhRfy4jzUFDAlA5q34okF2myRX+IAbnTJrrjsCi
         PJ/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759012811; x=1759617611;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cnz30dJx0HiX6zGp2Rht8KTzZqv90TYJIftWrY8q3Gg=;
        b=SLXtbSQOeeH62xvjPlgTwKSa0bRm80HycT3VqcKcUH8K46e1vHTbuNWirBcXyrw6s5
         SvmhaX+KsGNHqSytOen4bXDF3v2bnlCtftkcIoWBr1Xj1NGuz0LoVv74ls4k7LJ6dM3F
         qa39f4USfKYt2kRBYrUvcQ9STjBOn6t4RXh9HV6GWfc1AbETqC/yS55Kkg9/D5lwewAW
         WsNrwHK4RVP1BUQzUBnHpscxITBFrzPOk0KXL6tGsga1T2hKvZelLvfuJcW3ePXjPBZr
         PUl9LHKRv4IGtIEeox6h6iX8Q/GZFgGT3T3o3XYsvxNvE8exjEq6PTq8axEAoXMe1zZv
         V0fw==
X-Gm-Message-State: AOJu0Yy4+jiJFVnDKDbCFwZEWWG3iZCzbBvZnS4Y6qa3QDC+6awPAeTJ
	xOlb6v2dJ/Up4DBdyw9e1r8WDlQewYVXP9+HFaJTldFteQp++nyIn/DsIa3Boe0Bnloed4vlhI+
	/wryILn+/8vLKoL1AEfGj9taXcFZ3k0YbsegYWWUavOb3FhWGUzpFEClWYWeqfV0cpaGs7CrU83
	qC6LPz3BtixZAD2fKpEn7JZYYp/iB2esZGUPHKMHF42STBGgaWUg3vqpoXdsudGA==
X-Google-Smtp-Source: AGHT+IECGfew5MgnR9KiEYwU/v8iuklwpwLiDW9b1J/HcF8snjUxSTDfH+6CJYvM1BXlIZfXeKTQx/lQkgoINp6NPw==
X-Received: from plso9.prod.google.com ([2002:a17:902:bcc9:b0:24b:1657:c088])
 (user=danielmentz job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:1a0d:b0:27e:d7a4:cd32 with SMTP id d9443c01a7336-27ed7a4cda3mr118708565ad.57.1759012811244;
 Sat, 27 Sep 2025 15:40:11 -0700 (PDT)
Date: Sat, 27 Sep 2025 22:39:52 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.570.gb178f27e6d-goog
Message-ID: <20250927223953.936562-1-danielmentz@google.com>
Subject: [PATCH 1/2] iommu/io-pgtable-arm: Implement .iotlb_sync_map callback
From: Daniel Mentz <danielmentz@google.com>
To: iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Cc: Will Deacon <will@kernel.org>, Mostafa Saleh <smostafa@google.com>, 
	Pranjal Shrivastava <praan@google.com>, Liviu Dudau <liviu.dudau@arm.com>, Jason Gunthorpe <jgg@nvidia.com>, 
	Rob Clark <robin.clark@oss.qualcomm.com>, Daniel Mentz <danielmentz@google.com>
Content-Type: text/plain; charset="UTF-8"

On systems with a non-coherent SMMU, the CPU must perform cache
maintenance operations (CMOs) after updating page table entries (PTEs).
This ensures that the SMMU reads the latest version of the descriptors
and not stale data from memory.

This requirement can lead to significant performance overhead,
especially when mapping long scatter-gather lists where each sg entry
maps into an iommu_map() call that only covers 4KB of address space.

In such scenarios, each small mapping operation modifies a single 8-byte
PTE but triggers a cache clean for the entire cache line (e.g., 64
bytes). This results in the same cache line being cleaned repeatedly,
once for each PTE it contains.

A more efficient implementation performs the cache clean operation only
after updating all descriptors that are co-located in the same cache
line. This patch introduces a mechanism to defer and batch the cache
maintenance:

A new boolean flag, defer_sync_pte, is added to struct io_pgtable_cfg.
When this flag is set, the arm-lpae backend will skip the cache sync
operation for leaf entries within its .map_pages implementation.

A new callback, .iotlb_sync_map, is added to struct io_pgtable_ops.
After performing a series of mapping operations, the caller is
responsible for invoking this callback for the entire IOVA range. This
function then walks the page tables for the specified range and performs
the necessary cache clean operations for all the modified PTEs.

This allows for a single, efficient cache maintenance operation to cover
multiple PTE updates, significantly reducing overhead for workloads that
perform many small, contiguous mappings.

Signed-off-by: Daniel Mentz <danielmentz@google.com>
---
 drivers/iommu/io-pgtable-arm.c | 66 +++++++++++++++++++++++++++++++++-
 include/linux/io-pgtable.h     |  7 ++++
 2 files changed, 72 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
index 7e8e2216c294..a970eefb07fb 100644
--- a/drivers/iommu/io-pgtable-arm.c
+++ b/drivers/iommu/io-pgtable-arm.c
@@ -353,7 +353,7 @@ static void __arm_lpae_init_pte(struct arm_lpae_io_pgtable *data,
 	for (i = 0; i < num_entries; i++)
 		ptep[i] = pte | paddr_to_iopte(paddr + i * sz, data);
 
-	if (!cfg->coherent_walk)
+	if (!cfg->coherent_walk && !cfg->defer_sync_pte)
 		__arm_lpae_sync_pte(ptep, num_entries, cfg);
 }
 
@@ -582,6 +582,69 @@ static int arm_lpae_map_pages(struct io_pgtable_ops *ops, unsigned long iova,
 	return ret;
 }
 
+static int __arm_lpae_iotlb_sync_map(struct arm_lpae_io_pgtable *data, unsigned long iova,
+			      size_t size, int lvl, arm_lpae_iopte *ptep)
+{
+	struct io_pgtable *iop = &data->iop;
+	size_t block_size = ARM_LPAE_BLOCK_SIZE(lvl, data);
+	int ret = 0, num_entries, max_entries;
+	unsigned long iova_offset, sync_idx_start, sync_idx_end;
+	int i, shift, synced_entries = 0;
+
+	shift = (ARM_LPAE_LVL_SHIFT(lvl - 1, data) + ARM_LPAE_PGD_IDX(lvl - 1, data));
+	iova_offset = iova & ((1ULL << shift) - 1);
+	sync_idx_start = ARM_LPAE_LVL_IDX(iova, lvl, data);
+	sync_idx_end = (iova_offset + size + block_size - ARM_LPAE_GRANULE(data)) >>
+		ARM_LPAE_LVL_SHIFT(lvl, data);
+	max_entries = arm_lpae_max_entries(sync_idx_start, data);
+	num_entries = min_t(unsigned long, sync_idx_end - sync_idx_start, max_entries);
+	ptep += sync_idx_start;
+
+	if (lvl < (ARM_LPAE_MAX_LEVELS - 1)) {
+		for (i = 0; i < num_entries; i++) {
+			arm_lpae_iopte pte = READ_ONCE(ptep[i]);
+			unsigned long synced;
+
+			WARN_ON(!pte);
+
+			if (iopte_type(pte) == ARM_LPAE_PTE_TYPE_TABLE) {
+				int n = i - synced_entries;
+
+				if (n) {
+					__arm_lpae_sync_pte(&ptep[synced_entries], n, &iop->cfg);
+					synced_entries += n;
+				}
+				ret = __arm_lpae_iotlb_sync_map(data, iova, size, lvl + 1,
+								iopte_deref(pte, data));
+				synced_entries++;
+			}
+			synced = block_size - (iova & (block_size - 1));
+			size -= synced;
+			iova += synced;
+		}
+	}
+
+	if (synced_entries != num_entries)
+		__arm_lpae_sync_pte(&ptep[synced_entries], num_entries - synced_entries, &iop->cfg);
+
+	return ret;
+}
+
+static int arm_lpae_iotlb_sync_map(struct io_pgtable_ops *ops, unsigned long iova,
+			    size_t size)
+{
+	struct arm_lpae_io_pgtable *data = io_pgtable_ops_to_data(ops);
+	struct io_pgtable_cfg *cfg = &data->iop.cfg;
+	arm_lpae_iopte *ptep = data->pgd;
+	int lvl = data->start_level;
+	long iaext = (s64)iova >> cfg->ias;
+
+	WARN_ON(!size);
+	WARN_ON(iaext);
+
+	return __arm_lpae_iotlb_sync_map(data, iova, size, lvl, ptep);
+}
+
 static void __arm_lpae_free_pgtable(struct arm_lpae_io_pgtable *data, int lvl,
 				    arm_lpae_iopte *ptep)
 {
@@ -949,6 +1012,7 @@ arm_lpae_alloc_pgtable(struct io_pgtable_cfg *cfg)
 	data->iop.ops = (struct io_pgtable_ops) {
 		.map_pages	= arm_lpae_map_pages,
 		.unmap_pages	= arm_lpae_unmap_pages,
+		.iotlb_sync_map	= cfg->coherent_walk ? NULL : arm_lpae_iotlb_sync_map,
 		.iova_to_phys	= arm_lpae_iova_to_phys,
 		.read_and_clear_dirty = arm_lpae_read_and_clear_dirty,
 		.pgtable_walk	= arm_lpae_pgtable_walk,
diff --git a/include/linux/io-pgtable.h b/include/linux/io-pgtable.h
index 138fbd89b1e6..c4927dbc0f61 100644
--- a/include/linux/io-pgtable.h
+++ b/include/linux/io-pgtable.h
@@ -57,6 +57,9 @@ struct iommu_flush_ops {
  * @oas:           Output address (paddr) size, in bits.
  * @coherent_walk  A flag to indicate whether or not page table walks made
  *                 by the IOMMU are coherent with the CPU caches.
+ * @defer_sync_pte A flag to indicate whether pte sync operations for leaf
+ *                 entries shall be skipped during calls to .map_pages. A
+ *                 subsequent call to .iotlb_sync_map is required.
  * @tlb:           TLB management callbacks for this set of tables.
  * @iommu_dev:     The device representing the DMA configuration for the
  *                 page table walker.
@@ -110,6 +113,7 @@ struct io_pgtable_cfg {
 	unsigned int			ias;
 	unsigned int			oas;
 	bool				coherent_walk;
+	bool				defer_sync_pte;
 	const struct iommu_flush_ops	*tlb;
 	struct device			*iommu_dev;
 
@@ -204,6 +208,7 @@ struct arm_lpae_io_pgtable_walk_data {
  * @unmap_pages:  Unmap a range of virtually contiguous pages of the same size.
  * @iova_to_phys: Translate iova to physical address.
  * @pgtable_walk: (optional) Perform a page table walk for a given iova.
+ * @iotlb_sync_map: Sync ptes (Required for non-coherent page table walks)
  *
  * These functions map directly onto the iommu_ops member functions with
  * the same names.
@@ -222,6 +227,8 @@ struct io_pgtable_ops {
 				    unsigned long iova, size_t size,
 				    unsigned long flags,
 				    struct iommu_dirty_bitmap *dirty);
+	int (*iotlb_sync_map)(struct io_pgtable_ops *ops, unsigned long iova,
+			      size_t size);
 };
 
 /**
-- 
2.51.0.570.gb178f27e6d-goog

