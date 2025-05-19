Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FFD928982F
	for <iommu@lists.linux.dev>; Mon, 19 May 2025 17:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747677267; cv=none; b=dZgsddmuHZxmnifKP8xxMfKnL2EdMJpIqQZ+diecwSPx/xj2jmgHJmxbN37zZeJoELQw0ubiobsboVyHKEqsDd7BelZVpJpK/xOlmw+PZ6+t8TmasBCjX9HxOyEZNEhTFiWYYNQq5uTRQYMME94EOkeajFvujug1MxYUWGoyPg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747677267; c=relaxed/simple;
	bh=/jfmZZExg+Wzp+4EZ6rojxHF6RgLrIAptiF8m9AlQpM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GmeaLwg93pNaZVjBV75cEnxyzWnRkk/PHW/YUyLZ9pbmXnS5589MxRqmtwF4YkX7bLNIccd0Ppmu6A/DVSCYkQut+xXROVwehpURhgCsPWCU7XbCjX9Gev9FyQ/0LKl+I5aFG2JZbMVx4Bn4ysbKMXq4O+ymFBH0U3/pBR6PDsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ae+4Wr6A; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ae+4Wr6A"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-7fd35b301bdso5308337a12.2
        for <iommu@lists.linux.dev>; Mon, 19 May 2025 10:54:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747677265; x=1748282065; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kXQcDRAe4EWVXNL5yTAKMixST4qgC4DZfdrTRe+HbCQ=;
        b=ae+4Wr6A/k2580l61IjEHN8IS1gupUif3xoEDovi0TVJUMvcU12J/t/loYtRY9A+QN
         Tr+5F2IbcsnFNtN2MH8BNFISa9if5wPx3EHOZWA2yCJaF4jH2zW/7d9C3+WtFdefLRqR
         rXmHrzSmwWOqozF8MZBOF+gOksNrf7ktZ3eB/kCLqc0X1iEV2QTyE0WDmelLLPVXIC0U
         RDsUZvdZ6vD7u/zCyI9b69zVIiV36JqBDW6MZTEsFpUbojUmIii3mHjC1EFaGw92TDwl
         SKoxECjEUa0PhxnEb+iIBNoGWWbDUP8pQJ5nQUvF0kLv5BhihMfKtxNS8AfuByQEowIv
         Aong==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747677265; x=1748282065;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kXQcDRAe4EWVXNL5yTAKMixST4qgC4DZfdrTRe+HbCQ=;
        b=s+zx81EGPeRXqUUoACEFy412mz8s4NxoTWy0aMnGZYI1x/MHGCuEl6RC3+Oq4RxaBE
         R00ynoSTJVBFpTykIgwUqF3ZlL4c5njuPisFBINLBBrOu4l3VSaYdZvWLQSkiT4LlGx2
         kCEAvob4oXA1fYBkqGqUTzTmgCpY+lZC8C5DDiqJmivNLQ5ox30+moe49UIUwvkoAShz
         hbU9KDjhgFNrTptxad0fOkLI2hiJGP4zPka+0tvsfUDreYGKEWrmBZQHzpf8L4zNw1EG
         x+YU+KW2KPguZEG7m+xeGhHfD5aNZpHcnm43T7BSFaYcNiJXzwqKda/3cb2f23AuHFzn
         ZNSg==
X-Forwarded-Encrypted: i=1; AJvYcCUvcEPjfOkzVrefnWPTfhxh3fyxqjGwnVuvF+1tSBf7QOVlFgJzINnmxj8yMw2+RRojRH+uYA==@lists.linux.dev
X-Gm-Message-State: AOJu0YygxYSrFB9VQqX9oxAzYzmpu5D7pGeRAH6H722oB7N5rrPenOmt
	jp8cY7NsDPsGvJsz3tTBTL5/uu/z8D2l+SOUxpaeeNvykcXxDDucsh56
X-Gm-Gg: ASbGncvxBr3bAksyI7gFf+eoc7HHAs6xJ802u181kETy8r353MgegfcYIrSpJj67l3t
	McsZm56FLrltqlIYqNx+CGmUW5JhMKt+iK7lRSt9tDXN5vanB56BJJEexbhuVs4ZxdD9v9LTWQq
	i8aCrEOrw6jXy6A2x9CSaW78h4I2ZdGQvuNVs2o+MfiOYLvGvRMGB2h24wE5UWbPmVzii9iNLP9
	9jBhbI6pwOzh2hchKaPCnBFquxuJu9N4NlqbdDDNTxEfHCsWDbuPjMjF2uSuy1YN9vy55J1xvtV
	Pe10CKB85k6uU1Y3NWNKEi+3yAC5f/uqBliki7+V3bpZaNRE7jdzdYizzbupx43ekLqSxATRdUX
	9WqjxgrgHpL+31THJRPkeC+7Fwg==
X-Google-Smtp-Source: AGHT+IH9o+jDU8SCOf6p2dYQ3xG9pg+wpXFHI4AQ16YbWVrsnqHFvIYpaqIH85X0Xd/j1VubslNPjQ==
X-Received: by 2002:a17:902:ea12:b0:231:c6d0:f784 with SMTP id d9443c01a7336-231de37623amr210055535ad.28.1747677264644;
        Mon, 19 May 2025 10:54:24 -0700 (PDT)
Received: from localhost ([2a00:79e0:3e00:2601:3afc:446b:f0df:eadc])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-231d4e9605csm62543565ad.123.2025.05.19.10.54.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 May 2025 10:54:24 -0700 (PDT)
From: Rob Clark <robdclark@gmail.com>
To: dri-devel@lists.freedesktop.org
Cc: freedreno@lists.freedesktop.org,
	linux-arm-msm@vger.kernel.org,
	Connor Abbott <cwabbott0@gmail.com>,
	Rob Clark <robdclark@chromium.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Will Deacon <will@kernel.org>,
	Joerg Roedel <joro@8bytes.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Joao Martins <joao.m.martins@oracle.com>,
	linux-arm-kernel@lists.infradead.org (moderated list:ARM SMMU DRIVERS),
	iommu@lists.linux.dev (open list:IOMMU SUBSYSTEM),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v5 05/40] iommu/io-pgtable-arm: Add quirk to quiet WARN_ON()
Date: Mon, 19 May 2025 10:51:28 -0700
Message-ID: <20250519175348.11924-6-robdclark@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250519175348.11924-1-robdclark@gmail.com>
References: <20250519175348.11924-1-robdclark@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Rob Clark <robdclark@chromium.org>

In situations where mapping/unmapping sequence can be controlled by
userspace, attempting to map over a region that has not yet been
unmapped is an error.  But not something that should spam dmesg.

Now that there is a quirk, we can also drop the selftest_running
flag, and use the quirk instead for selftests.

Signed-off-by: Rob Clark <robdclark@chromium.org>
Acked-by: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 drivers/iommu/io-pgtable-arm.c | 27 ++++++++++++++-------------
 include/linux/io-pgtable.h     |  8 ++++++++
 2 files changed, 22 insertions(+), 13 deletions(-)

diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
index f27965caf6a1..a535d88f8943 100644
--- a/drivers/iommu/io-pgtable-arm.c
+++ b/drivers/iommu/io-pgtable-arm.c
@@ -253,8 +253,6 @@ static inline bool arm_lpae_concat_mandatory(struct io_pgtable_cfg *cfg,
 	       (data->start_level == 1) && (oas == 40);
 }
 
-static bool selftest_running = false;
-
 static dma_addr_t __arm_lpae_dma_addr(void *pages)
 {
 	return (dma_addr_t)virt_to_phys(pages);
@@ -373,7 +371,7 @@ static int arm_lpae_init_pte(struct arm_lpae_io_pgtable *data,
 	for (i = 0; i < num_entries; i++)
 		if (iopte_leaf(ptep[i], lvl, data->iop.fmt)) {
 			/* We require an unmap first */
-			WARN_ON(!selftest_running);
+			WARN_ON(!(data->iop.cfg.quirks & IO_PGTABLE_QUIRK_NO_WARN_ON));
 			return -EEXIST;
 		} else if (iopte_type(ptep[i]) == ARM_LPAE_PTE_TYPE_TABLE) {
 			/*
@@ -475,7 +473,7 @@ static int __arm_lpae_map(struct arm_lpae_io_pgtable *data, unsigned long iova,
 		cptep = iopte_deref(pte, data);
 	} else if (pte) {
 		/* We require an unmap first */
-		WARN_ON(!selftest_running);
+		WARN_ON(!(cfg->quirks & IO_PGTABLE_QUIRK_NO_WARN_ON));
 		return -EEXIST;
 	}
 
@@ -649,8 +647,10 @@ static size_t __arm_lpae_unmap(struct arm_lpae_io_pgtable *data,
 	unmap_idx_start = ARM_LPAE_LVL_IDX(iova, lvl, data);
 	ptep += unmap_idx_start;
 	pte = READ_ONCE(*ptep);
-	if (WARN_ON(!pte))
-		return 0;
+	if (!pte) {
+		WARN_ON(!(data->iop.cfg.quirks & IO_PGTABLE_QUIRK_NO_WARN_ON));
+		return -ENOENT;
+	}
 
 	/* If the size matches this level, we're in the right place */
 	if (size == ARM_LPAE_BLOCK_SIZE(lvl, data)) {
@@ -660,8 +660,10 @@ static size_t __arm_lpae_unmap(struct arm_lpae_io_pgtable *data,
 		/* Find and handle non-leaf entries */
 		for (i = 0; i < num_entries; i++) {
 			pte = READ_ONCE(ptep[i]);
-			if (WARN_ON(!pte))
+			if (!pte) {
+				WARN_ON(!(data->iop.cfg.quirks & IO_PGTABLE_QUIRK_NO_WARN_ON));
 				break;
+			}
 
 			if (!iopte_leaf(pte, lvl, iop->fmt)) {
 				__arm_lpae_clear_pte(&ptep[i], &iop->cfg, 1);
@@ -976,7 +978,8 @@ arm_64_lpae_alloc_pgtable_s1(struct io_pgtable_cfg *cfg, void *cookie)
 	if (cfg->quirks & ~(IO_PGTABLE_QUIRK_ARM_NS |
 			    IO_PGTABLE_QUIRK_ARM_TTBR1 |
 			    IO_PGTABLE_QUIRK_ARM_OUTER_WBWA |
-			    IO_PGTABLE_QUIRK_ARM_HD))
+			    IO_PGTABLE_QUIRK_ARM_HD |
+			    IO_PGTABLE_QUIRK_NO_WARN_ON))
 		return NULL;
 
 	data = arm_lpae_alloc_pgtable(cfg);
@@ -1079,7 +1082,8 @@ arm_64_lpae_alloc_pgtable_s2(struct io_pgtable_cfg *cfg, void *cookie)
 	struct arm_lpae_io_pgtable *data;
 	typeof(&cfg->arm_lpae_s2_cfg.vtcr) vtcr = &cfg->arm_lpae_s2_cfg.vtcr;
 
-	if (cfg->quirks & ~(IO_PGTABLE_QUIRK_ARM_S2FWB))
+	if (cfg->quirks & ~(IO_PGTABLE_QUIRK_ARM_S2FWB |
+			    IO_PGTABLE_QUIRK_NO_WARN_ON))
 		return NULL;
 
 	data = arm_lpae_alloc_pgtable(cfg);
@@ -1320,7 +1324,6 @@ static void __init arm_lpae_dump_ops(struct io_pgtable_ops *ops)
 #define __FAIL(ops, i)	({						\
 		WARN(1, "selftest: test failed for fmt idx %d\n", (i));	\
 		arm_lpae_dump_ops(ops);					\
-		selftest_running = false;				\
 		-EFAULT;						\
 })
 
@@ -1336,8 +1339,6 @@ static int __init arm_lpae_run_tests(struct io_pgtable_cfg *cfg)
 	size_t size, mapped;
 	struct io_pgtable_ops *ops;
 
-	selftest_running = true;
-
 	for (i = 0; i < ARRAY_SIZE(fmts); ++i) {
 		cfg_cookie = cfg;
 		ops = alloc_io_pgtable_ops(fmts[i], cfg, cfg);
@@ -1426,7 +1427,6 @@ static int __init arm_lpae_run_tests(struct io_pgtable_cfg *cfg)
 		free_io_pgtable_ops(ops);
 	}
 
-	selftest_running = false;
 	return 0;
 }
 
@@ -1448,6 +1448,7 @@ static int __init arm_lpae_do_selftests(void)
 		.tlb = &dummy_tlb_ops,
 		.coherent_walk = true,
 		.iommu_dev = &dev,
+		.quirks = IO_PGTABLE_QUIRK_NO_WARN_ON,
 	};
 
 	/* __arm_lpae_alloc_pages() merely needs dev_to_node() to work */
diff --git a/include/linux/io-pgtable.h b/include/linux/io-pgtable.h
index bba2a51c87d2..639b8f4fb87d 100644
--- a/include/linux/io-pgtable.h
+++ b/include/linux/io-pgtable.h
@@ -88,6 +88,13 @@ struct io_pgtable_cfg {
 	 *
 	 * IO_PGTABLE_QUIRK_ARM_HD: Enables dirty tracking in stage 1 pagetable.
 	 * IO_PGTABLE_QUIRK_ARM_S2FWB: Use the FWB format for the MemAttrs bits
+	 *
+	 * IO_PGTABLE_QUIRK_NO_WARN_ON: Do not WARN_ON() on conflicting
+	 *	mappings, but silently return -EEXISTS.  Normally an attempt
+	 *	to map over an existing mapping would indicate some sort of
+	 *	kernel bug, which would justify the WARN_ON().  But for GPU
+	 *	drivers, this could be under control of userspace.  Which
+	 *	deserves an error return, but not to spam dmesg.
 	 */
 	#define IO_PGTABLE_QUIRK_ARM_NS			BIT(0)
 	#define IO_PGTABLE_QUIRK_NO_PERMS		BIT(1)
@@ -97,6 +104,7 @@ struct io_pgtable_cfg {
 	#define IO_PGTABLE_QUIRK_ARM_OUTER_WBWA		BIT(6)
 	#define IO_PGTABLE_QUIRK_ARM_HD			BIT(7)
 	#define IO_PGTABLE_QUIRK_ARM_S2FWB		BIT(8)
+	#define IO_PGTABLE_QUIRK_NO_WARN_ON		BIT(9)
 	unsigned long			quirks;
 	unsigned long			pgsize_bitmap;
 	unsigned int			ias;
-- 
2.49.0

