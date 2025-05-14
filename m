Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD853283CBE
	for <iommu@lists.linux.dev>; Wed, 14 May 2025 17:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747242207; cv=none; b=uGJvU3zywz08V3zO4zvjYHUktr+1efbzDGVAHeg59Gfz1zKU4CQIIUPK25n3PAgdEFXi9YgTIcpWW2g/uJICfCcO4EqPjMAVJBANALOsdYv8Atk5+PlA2yXCuKX4DSK+N3ZOcWpSAnAwWchRSAIRPXGhy/7o8DrSWdPo/+xv+fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747242207; c=relaxed/simple;
	bh=/jfmZZExg+Wzp+4EZ6rojxHF6RgLrIAptiF8m9AlQpM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uOM3q78dTQKSya6ZkPZ6dvDwnkxxBkaDMyu1g9XFzU/PPif3Gylbr0vBp/1iCFIeINXL+S57zvESIlwqSw3FHoOhc9pNOs7PtPiawYGqZvrYqYvfnq8Gt5gbfJYERAb2WBFeLEAHVL2TKOFMiP/8t0GCmABap4mpTf6HXMD/ovY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h1SCos+c; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h1SCos+c"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-74251cb4a05so133456b3a.3
        for <iommu@lists.linux.dev>; Wed, 14 May 2025 10:03:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747242205; x=1747847005; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kXQcDRAe4EWVXNL5yTAKMixST4qgC4DZfdrTRe+HbCQ=;
        b=h1SCos+cIbnTy3dSpdL+SY1KuWZeKMo2wHdj7I2ZujFmOtFkJgtNrZN3QR1Fu7usFS
         AKOh0scwtW27K9+/w9eWF1kp5YNj+gCrNDazr3/29UunXJdaUDWInv4InwAoRoqia2H0
         jkJ1N3b+59NYjg6XE6C2fWAJtCxpPJuUZf1SyZYDLimU0/aTbRiRswMKULUSZkJwzz2j
         EQiwq5RY/WslhwIKbnjf5d3nsvb5T+YOjVNGIj2HPVsFNYUAvgd+s07hOsLrTEB67HHf
         0Cgwo70uKZemETA0YYPCOlDin/34FBv3Idypsl11XqaOrh2l/uJd+XuOwkMzb02QNe0B
         kKag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747242205; x=1747847005;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kXQcDRAe4EWVXNL5yTAKMixST4qgC4DZfdrTRe+HbCQ=;
        b=gYTJ+yJm3npdAVfzBgO+aoyQ9whOaffmXpmqCbb3S93ViQnhR/rO+Y44gCDYVLp87c
         gmlUd/FiJ4yGQEwqZROahdGjjc6c4+9CbpOV9FzodSQJJ+MDOYYqCTxXblmM9BwARaEi
         DjOcwh1VwMRXjZtTRzNQQgD13RfkR0WocZv/ZN+nFvii7UFYEjsoWsMzjxHVZJYR/W7I
         9athXIPKFgm2TfVSx9if0EG0L5x9ub088XlwwNncdhbDDFtO5cqMi4FHXLhbYF9kTTm/
         57wSHD6RkhzojiDxA1shmF1WYtfibYAkYYit0RXiEhpio21vs6uDNzxtxvrCxLQx/6bF
         jK/g==
X-Forwarded-Encrypted: i=1; AJvYcCVfTdDNffXGvzgnoGiHERE1YVXHiIEwDSymxQyFlOgkEYPhv6mbvcHiWjznh99acSdJwohf1g==@lists.linux.dev
X-Gm-Message-State: AOJu0Yyq6B5NN3NCziiPokV5rJr90/kCJBmW62o1vNzksFR+IdgUbV9p
	EhsTWaS+GMu8zjBtCU+V9nrHN6ilLDAzFnPfv31wKpnD+2u6self
X-Gm-Gg: ASbGncse2e9ikxeSQBDgwgBLqB38myqN5YysJo0vlmivVuEzls1XR1w4re5Iwmrwb2j
	XSM0Ms0rIoSFA2kSVnL7yn6IUgjQNGKAlmA1gyBoZstSbneAiYayrokmdecE5UJUbjEn1HFUPF8
	HMUD44HhaIf4PJVPYX/Fc4cxswCqRW/bSfCv5yBa0Pmq3i/xDHBCTi87iCX8MiP2D+n7hXcb8+v
	OizAd/Mj8lter7t9bG+re5vp6RBo+iHe3CZnpvUp2oB6FDRBPHI9hp2X2IKS+aGZCLPOws+trzR
	CrlZ4VLBM0x/eZOb7CWqJH1NQiWZJODgMWKCLU/VLL3H/gtRA2CgXvYHoFXI7rgu1hCNqZ32LgD
	kmwHUInobLiQLlj8X/4bTggjjww==
X-Google-Smtp-Source: AGHT+IHksyKHL/cAj2IBPQcufM/sbeYjbaaEX1F8jd2jD7SBpRllEzRc2mShwfdtPSsMevJvYm3ogQ==
X-Received: by 2002:a17:903:1aef:b0:220:c164:6ee1 with SMTP id d9443c01a7336-23198129cd1mr71866655ad.32.1747242204951;
        Wed, 14 May 2025 10:03:24 -0700 (PDT)
Received: from localhost ([2a00:79e0:3e00:2601:3afc:446b:f0df:eadc])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22fc828b445sm101230955ad.181.2025.05.14.10.03.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 May 2025 10:03:24 -0700 (PDT)
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
	Kevin Tian <kevin.tian@intel.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Joao Martins <joao.m.martins@oracle.com>,
	linux-arm-kernel@lists.infradead.org (moderated list:ARM SMMU DRIVERS),
	iommu@lists.linux.dev (open list:IOMMU SUBSYSTEM),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v4 05/40] iommu/io-pgtable-arm: Add quirk to quiet WARN_ON()
Date: Wed, 14 May 2025 09:59:04 -0700
Message-ID: <20250514170118.40555-6-robdclark@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250514170118.40555-1-robdclark@gmail.com>
References: <20250514170118.40555-1-robdclark@gmail.com>
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

