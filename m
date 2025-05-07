Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1980C288C15
	for <iommu@lists.linux.dev>; Wed,  7 May 2025 14:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746628203; cv=none; b=oWoRjc36wN3j2Rl6jFIkGP1/7hS18IV4d/INDhpGFOfTXnvZ8xEyJiIR0KZMEGR0UnIGwvI++viXuxS/lpaABx1tiyzjXtpG556TAzIO7aTyrQWl+HH9ILx2BNp8XhbjmPxGLjuG9i5QGn9NPJxlKXrvdSNDCesmKaQdrjEGEkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746628203; c=relaxed/simple;
	bh=Ysdv17ZrAFhu+Z8p5jVB7S0giJ890w/Ep7kXiVFvwEo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=b30ti+WdDaALSa2YiLXENmAjRrsRzfXqRDPSJaMicluY8uVHXzrbbekHtj2gsbWtHzJfW98VwHaG6E7nE7UUHLBYoNM1EN4ree6h2LaN8kcqoLo8JxXESZsANzKHZRLfUwNRZWmbToVOc1Xr5DiICUb2jxDwJx7JkdCEpAK3eIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Oehyjz/w; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Oehyjz/w"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7399a2dc13fso9788579b3a.2
        for <iommu@lists.linux.dev>; Wed, 07 May 2025 07:30:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746628200; x=1747233000; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Tx2+qp5fUFaxyyKDyJusWn86x0QDSb7v4Cx5Hi7px0E=;
        b=Oehyjz/wOlGSsDxTzE9afjhHgPcfCLnIU3N8oTrxUvgkKME/WPVo2ix3NWcWlkxMXS
         73WHt5sLLJQWIBoK8KGainFo8l9SOAoxmAB3gYbF8p2r7p5KV/3VU+WZI26hJQorqAZ+
         rCfj5Ws7zRB9XhXR4/stwDbaxErt47ZlnuNVhpeJfXsC2SSRwJYlv+OxKv2qJhrffJ8s
         jiZzsGthJLTHa74hOKMOj/3hGtJ9BwaGXKHZ8MT3H6pqQeEV5WD8Mva2DRMU08fR4PHt
         Ui/Z9uA5FYb6XNWSgEbFiz8slYzJnqMQNfJfgpl3PyLzXhSljFv3uTAlejSHrCq9loB5
         ue6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746628200; x=1747233000;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Tx2+qp5fUFaxyyKDyJusWn86x0QDSb7v4Cx5Hi7px0E=;
        b=UfjkYLG2rQnJJp1ECuEEDcA/rVYEO3D5gv6C+gLrdfth/NsTEd2zTN6/1VQr6k7D75
         r8FMYjduMHYDygx+rBmDxIsGqAPhw+XSZLU2Sw0ASMmsZRuGC9tArzl7nJDw/CtgJ6+c
         DJOTd8bnpXd/uwR+m7+VnLMsvcX3tsLoLxYiPysD8ahuYh9HCVmJLulJKJfhiyBtrp+5
         iVlloRkV8WKB4F6CZeNfMeOMD/uRY9tXfXuZAfRcClkzQwui/vyupQJ0gkXle6aFvfom
         Qn5ChHSIr3Zbxsk7TxjSte+hkCO1A0NF4CHPpHA5J+PpMmludJC+5e/1NTJekS2qPrIQ
         h+UA==
X-Gm-Message-State: AOJu0Ywq9zoMLWzJI7jX4mACK2uea8c8qEVvb6Oj8xov45qNYIUOa2pP
	dX+UkLN3x5gdX44adLn9UMNrtLn9KVtI+7QVlrg1tQjEsvMcjeejqaiNfA==
X-Gm-Gg: ASbGnctt2xC6Ctj3GLePjmCgtqpNuUTk0Ng+93w9NWuSoPuAdv7s3Wpld06uky/Unyq
	LLYo6/rzCUdNGDPrdeHr/hyJBA3FN/nUunpY0NerFGjxXyWId0qhQdINU/HHP6OFNELKQPoq2Y6
	Kvvyu4tvt0t5NwRaLlEB0kws7WuT389m97kE7Yc5KwuRViRloE4mAbvZk1jeQD+tIlhjHf/22GA
	P02USpzusLi3R0ZfIYM6t6zLfb8IrxK4hSjYwY6ti0Trz1UTqb6g8BzZtRFz4pV682gJd571ARL
	DAbWc7Tef39jDjdyn1dy1VN/M4lwZChR+LM1MbGNdlqcD7+U15a04qaBEttWsvyneqYFt+UWsTR
	ikhE7QPB4Q9ETzGw=
X-Google-Smtp-Source: AGHT+IEfTnLrQfaILn2a1qg9FhcKbdkfEWk7UApwdzBZ8svWHw/KZHdECBQt/Ccuap4IqQpbIJLUkg==
X-Received: by 2002:a05:6a20:3950:b0:20b:a75e:fa32 with SMTP id adf61e73a8af0-2148d42d024mr5379907637.40.1746628199672;
        Wed, 07 May 2025 07:29:59 -0700 (PDT)
Received: from localhost ([2a00:79e0:3e00:2601:3afc:446b:f0df:eadc])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b1fd2f96ec2sm5819027a12.13.2025.05.07.07.29.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 May 2025 07:29:58 -0700 (PDT)
From: Rob Clark <robdclark@gmail.com>
To: iommu@lists.linux.dev
Cc: linux-arm-msm@vger.kernel.org,
	freedreno@lists.freedesktop.org,
	Rob Clark <robdclark@chromium.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Joao Martins <joao.m.martins@oracle.com>,
	linux-arm-kernel@lists.infradead.org (moderated list:ARM SMMU DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2] iommu/io-pgtable-arm: Add quirk to quiet WARN_ON()
Date: Wed,  7 May 2025 07:29:51 -0700
Message-ID: <20250507142953.269300-1-robdclark@gmail.com>
X-Mailer: git-send-email 2.49.0
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
---
Sending v2 stand-alone, since I'm not quite ready to send a new
iteration of the full VM_BIND series.  And with selftest_running
removed, I think this patch stands on it's own.  (And maybe there
is still time to sneak this in for v6.16, removing an iommu dep
for the VM_BIND series in v6.17?)

v2: Drop selftest_running and use IO_PGTABLE_QUIRK_NO_WARN_ON for
    the selftests

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

