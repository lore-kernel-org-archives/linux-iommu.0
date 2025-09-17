Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EB0F30BF66
	for <iommu@lists.linux.dev>; Wed, 17 Sep 2025 19:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758136321; cv=none; b=og6KrWtsl/1+/ZmpMCiiT+09+rPAg/jFZ1Mqd8amYiZbYyrv6yYYTLPJRDaWNma2Twe3FrYEJNZhGIR1VFrnUkBEj5gPSZda/sWrqLf36k7ZZTcE3BsU2KPTvEAPDd0QAXENk+ArdjcIx2BA/XJzs7buqCT6WzdwAucPkKddmTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758136321; c=relaxed/simple;
	bh=d14rSa8oJqmVfbXHz5/05zJCECwLsjYpJevYwgIxe1E=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tZ0c8++THcK3Lr+cFvDpOgj7TIpBnVOt7D79iTuAqP7ggCKaLZgmKz0lCg1xZbhnfr4Q3m2Cqn6KsKiZDeyHtBbQp5BQSc3pvoeOjyB3QITPQ5sCk6JtluutxoTH2DJ92IxknXINRFqRi/7lCAS/qgZFwJ9/ONQZFc8Xx9F30No=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ebsDyala; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ebsDyala"
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-45f2f15003aso795735e9.0
        for <iommu@lists.linux.dev>; Wed, 17 Sep 2025 12:11:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758136318; x=1758741118; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=KfzAdmUZnQT+nmiiN7mfGjBmde5r2RVPcb/gr6FSSjg=;
        b=ebsDyalapGG47cGaUwThiSAhttBkZy/21HISnbQq0pSabWNfat4hTgteBu2fbLjDRs
         BNioXt5WKFCLT8z9Q0P1uFLXnMLNRUAfW/sDLKE7aC5FewSyQ3RHSkVmp8xjLRqIKzuj
         VftLva430vYn+2h3n2cbt8CwQj5lrU2C07MdUJE8nXRAUkcUola93FxbbpqgHlcyjB/8
         iMkLoh7llGvW+TyaeHz5V1TvvVqUPkG/6mATvq4btEJZBjQlL/xhPOvmaWVeLw/sunex
         wsRv220IMZDRG3Yi0k2D7IOXuvLTVzA4u4YnTxR8RWOpZEHy35L8bYwr/KJKoGx53moS
         uXIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758136318; x=1758741118;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KfzAdmUZnQT+nmiiN7mfGjBmde5r2RVPcb/gr6FSSjg=;
        b=PCG6Uzyhk97fu/fTVbqhjcyzkyojcgq52ch309cMCCNUzOKwYe9CSuYUgtSDwO3mGK
         y5FVrwoOtshi8r/l2//m2F4S6JSt9khYhlq/ZweD+q7OnBUPOr/G+fFU1LfWJDzPAHEB
         xtNc9YZpIbyF1e1QVPYdOKiAe41zzeKtYYvfUXuinacyiA5Gf4cnY0X4gNG1eV4/KG5i
         +bwIoxrDVZsbhQs5hm3knzNdrf8puntuauTZXqLLh6e+PtJQwKvjGFilzEPBO3YJOPJr
         +5m8Oi3E82KE/NqtEbgeOhTinC8NVdei/56WTuA0YXoaB3iYQt7dSLCeqUs0bYu1fPkX
         RTJg==
X-Gm-Message-State: AOJu0YzpuQvfFTDmvovQGYaVsvY1eo/0MWXIQBnCN+SNrDvv3UVZ2SqN
	Z/qly0VSnb8WWBWvmnEzENApEow159rcwO5Lur17t9cHLI9pybib8gm2TOZijPaPtszs5yoTgA2
	3TvwINE4eFazj3dXFylRJgMskBZ3auAWUfomVYgNezuzbNZm7GVOaDMKflj7gu8gQkZ5KjEJgfk
	F1IAwMJIjUVhmIkNfaA+Fs7qoleWLCF0eg782Yb7Py9uuZeQ==
X-Google-Smtp-Source: AGHT+IEMJRP4sg9BT5V4UpeM5P79U3ojtSeakMWm8SULvgvW6XkVpztKgO9ZPvtMWwSsYvJxOiDWZZ/JO0WHRA==
X-Received: from wmsr5.prod.google.com ([2002:a05:600c:8b05:b0:459:7c15:15b9])
 (user=smostafa job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:548c:b0:45d:84ca:8a7 with SMTP id 5b1f17b1804b1-46202a0e8femr30570705e9.14.1758136317836;
 Wed, 17 Sep 2025 12:11:57 -0700 (PDT)
Date: Wed, 17 Sep 2025 19:11:40 +0000
In-Reply-To: <20250917191143.3847487-1-smostafa@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250917191143.3847487-1-smostafa@google.com>
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
Message-ID: <20250917191143.3847487-4-smostafa@google.com>
Subject: [PATCH v2 3/3] iommu/io-pgtable-arm-selftests: Use KUnit
From: Mostafa Saleh <smostafa@google.com>
To: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Cc: robin.murphy@arm.com, will@kernel.org, joro@8bytes.org, jgg@ziepe.ca, 
	praan@google.com, Mostafa Saleh <smostafa@google.com>
Content-Type: text/plain; charset="UTF-8"

Integrate the selftests as part of kunit, this makes the test
available through debugfs.

Suggested-by: Jason Gunthorpe <jgg@ziepe.ca>
Signed-off-by: Mostafa Saleh <smostafa@google.com>
---
 drivers/iommu/Kconfig                    |  2 +-
 drivers/iommu/io-pgtable-arm-selftests.c | 93 +++++++++++++-----------
 2 files changed, 51 insertions(+), 44 deletions(-)

diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index 553522ef3ca9..f7e6d1db6ce6 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -42,7 +42,7 @@ config IOMMU_IO_PGTABLE_LPAE
 
 config IOMMU_IO_PGTABLE_LPAE_SELFTEST
 	tristate "LPAE selftests"
-	depends on IOMMU_IO_PGTABLE_LPAE
+	depends on IOMMU_IO_PGTABLE_LPAE && KUNIT
 	help
 	  Enable self-tests for LPAE page table allocator. This performs
 	  a series of page-table consistency checks during boot.
diff --git a/drivers/iommu/io-pgtable-arm-selftests.c b/drivers/iommu/io-pgtable-arm-selftests.c
index 5ac3e792c56d..cfff8eb78e04 100644
--- a/drivers/iommu/io-pgtable-arm-selftests.c
+++ b/drivers/iommu/io-pgtable-arm-selftests.c
@@ -6,6 +6,8 @@
  *
  * Author: Will Deacon <will.deacon@arm.com>
  */
+#include <kunit/device.h>
+#include <kunit/test.h>
 #include <linux/device/faux.h>
 #include <linux/kernel.h>
 #include <linux/slab.h>
@@ -39,25 +41,26 @@ static const struct iommu_flush_ops dummy_tlb_ops = {
 	.tlb_add_page	= dummy_tlb_add_page,
 };
 
-static void arm_lpae_dump_ops(struct io_pgtable_ops *ops)
+static void arm_lpae_dump_ops(struct kunit *test, struct io_pgtable_ops *ops)
 {
 	struct arm_lpae_io_pgtable *data = io_pgtable_ops_to_data(ops);
 	struct io_pgtable_cfg *cfg = &data->iop.cfg;
 
-	pr_err("cfg: pgsize_bitmap 0x%lx, ias %u-bit\n",
-		cfg->pgsize_bitmap, cfg->ias);
-	pr_err("data: %d levels, 0x%zx pgd_size, %u pg_shift, %u bits_per_level, pgd @ %p\n",
-		ARM_LPAE_MAX_LEVELS - data->start_level, ARM_LPAE_PGD_SIZE(data),
-		ilog2(ARM_LPAE_GRANULE(data)), data->bits_per_level, data->pgd);
+	kunit_err(test, "cfg: pgsize_bitmap 0x%lx, ias %u-bit\n",
+		  cfg->pgsize_bitmap, cfg->ias);
+	kunit_err(test, "data: %d levels, 0x%zx pgd_size, %u pg_shift, %u bits_per_level, pgd @ %p\n",
+		  ARM_LPAE_MAX_LEVELS - data->start_level, ARM_LPAE_PGD_SIZE(data),
+		  ilog2(ARM_LPAE_GRANULE(data)), data->bits_per_level, data->pgd);
 }
 
-#define __FAIL(ops, i)	({						\
-		WARN(1, "selftest: test failed for fmt idx %d\n", (i));	\
-		arm_lpae_dump_ops(ops);					\
-		-EFAULT;						\
+#define __FAIL(test, ops, i)	({						\
+		KUNIT_FAIL(test, "");						\
+		kunit_err(test, "selftest: test failed for fmt idx %d\n", (i));	\
+		arm_lpae_dump_ops(test, ops);					\
+		-EFAULT;							\
 })
 
-static int arm_lpae_run_tests(struct io_pgtable_cfg *cfg)
+static int arm_lpae_run_tests(struct kunit *test, struct io_pgtable_cfg *cfg)
 {
 	static const enum io_pgtable_fmt fmts[] = {
 		ARM_64_LPAE_S1,
@@ -73,7 +76,7 @@ static int arm_lpae_run_tests(struct io_pgtable_cfg *cfg)
 		cfg_cookie = cfg;
 		ops = alloc_io_pgtable_ops(fmts[i], cfg, cfg);
 		if (!ops) {
-			pr_err("selftest: failed to allocate io pgtable ops\n");
+			kunit_err(test, "selftest: failed to allocate io pgtable ops\n");
 			return -ENOMEM;
 		}
 
@@ -82,13 +85,13 @@ static int arm_lpae_run_tests(struct io_pgtable_cfg *cfg)
 		 * Empty page tables shouldn't provide any translations.
 		 */
 		if (ops->iova_to_phys(ops, 42))
-			return __FAIL(ops, i);
+			return __FAIL(test, ops, i);
 
 		if (ops->iova_to_phys(ops, SZ_1G + 42))
-			return __FAIL(ops, i);
+			return __FAIL(test, ops, i);
 
 		if (ops->iova_to_phys(ops, SZ_2G + 42))
-			return __FAIL(ops, i);
+			return __FAIL(test, ops, i);
 
 		/*
 		 * Distinct mappings of different granule sizes.
@@ -101,16 +104,16 @@ static int arm_lpae_run_tests(struct io_pgtable_cfg *cfg)
 					   IOMMU_READ | IOMMU_WRITE |
 					   IOMMU_NOEXEC | IOMMU_CACHE,
 					   GFP_KERNEL, &mapped))
-				return __FAIL(ops, i);
+				return __FAIL(test, ops, i);
 
 			/* Overlapping mappings */
 			if (!ops->map_pages(ops, iova, iova + size, size, 1,
 					    IOMMU_READ | IOMMU_NOEXEC,
 					    GFP_KERNEL, &mapped))
-				return __FAIL(ops, i);
+				return __FAIL(test, ops, i);
 
 			if (ops->iova_to_phys(ops, iova + 42) != (iova + 42))
-				return __FAIL(ops, i);
+				return __FAIL(test, ops, i);
 
 			iova += SZ_1G;
 		}
@@ -121,18 +124,18 @@ static int arm_lpae_run_tests(struct io_pgtable_cfg *cfg)
 			size = 1UL << j;
 
 			if (ops->unmap_pages(ops, iova, size, 1, NULL) != size)
-				return __FAIL(ops, i);
+				return __FAIL(test, ops, i);
 
 			if (ops->iova_to_phys(ops, iova + 42))
-				return __FAIL(ops, i);
+				return __FAIL(test, ops, i);
 
 			/* Remap full block */
 			if (ops->map_pages(ops, iova, iova, size, 1,
 					   IOMMU_WRITE, GFP_KERNEL, &mapped))
-				return __FAIL(ops, i);
+				return __FAIL(test, ops, i);
 
 			if (ops->iova_to_phys(ops, iova + 42) != (iova + 42))
-				return __FAIL(ops, i);
+				return __FAIL(test, ops, i);
 
 			iova += SZ_1G;
 		}
@@ -148,11 +151,11 @@ static int arm_lpae_run_tests(struct io_pgtable_cfg *cfg)
 				   IOMMU_READ | IOMMU_WRITE |
 				   IOMMU_NOEXEC | IOMMU_CACHE,
 				   GFP_KERNEL, &mapped))
-			return __FAIL(ops, i);
+			return __FAIL(test, ops, i);
 		if (mapped != size)
-			return __FAIL(ops, i);
+			return __FAIL(test, ops, i);
 		if (ops->unmap_pages(ops, iova, size, 1, NULL) != size)
-			return __FAIL(ops, i);
+			return __FAIL(test, ops, i);
 
 		free_io_pgtable_ops(ops);
 	}
@@ -160,7 +163,7 @@ static int arm_lpae_run_tests(struct io_pgtable_cfg *cfg)
 	return 0;
 }
 
-static int arm_lpae_do_selftests(void)
+static void arm_lpae_do_selftests(struct kunit *test)
 {
 	static const unsigned long pgsize[] = {
 		SZ_4K | SZ_2M | SZ_1G,
@@ -173,18 +176,19 @@ static int arm_lpae_do_selftests(void)
 	};
 
 	int i, j, k, pass = 0, fail = 0;
-	struct faux_device *dev;
+	struct device *dev;
 	struct io_pgtable_cfg cfg = {
 		.tlb = &dummy_tlb_ops,
 		.coherent_walk = true,
 		.quirks = IO_PGTABLE_QUIRK_NO_WARN,
 	};
 
-	dev = faux_device_create("io-pgtable-test", NULL, 0);
-	if (!dev)
-		return -ENOMEM;
+	dev = kunit_device_register(test, "io-pgtable-test");
+	KUNIT_EXPECT_NOT_ERR_OR_NULL(test, dev);
+	if (IS_ERR_OR_NULL(dev))
+		return;
 
-	cfg.iommu_dev = &dev->dev;
+	cfg.iommu_dev = dev;
 
 	for (i = 0; i < ARRAY_SIZE(pgsize); ++i) {
 		for (j = 0; j < ARRAY_SIZE(address_size); ++j) {
@@ -193,9 +197,9 @@ static int arm_lpae_do_selftests(void)
 				cfg.pgsize_bitmap = pgsize[i];
 				cfg.ias = address_size[k];
 				cfg.oas = address_size[j];
-				pr_info("selftest: pgsize_bitmap 0x%08lx, IAS %u OAS %u\n",
-					pgsize[i], cfg.ias, cfg.oas);
-				if (arm_lpae_run_tests(&cfg))
+				kunit_info(test, "selftest: pgsize_bitmap 0x%08lx, IAS %u OAS %u\n",
+					   pgsize[i], cfg.ias, cfg.oas);
+				if (arm_lpae_run_tests(test, &cfg))
 					fail++;
 				else
 					pass++;
@@ -203,17 +207,20 @@ static int arm_lpae_do_selftests(void)
 		}
 	}
 
-	pr_info("selftest: completed with %d PASS %d FAIL\n", pass, fail);
-	faux_device_destroy(dev);
-
-	return fail ? -EFAULT : 0;
+	kunit_info(test, "selftest: completed with %d PASS %d FAIL\n", pass, fail);
 }
 
-static void arm_lpae_exit_selftests(void)
-{
-}
+static struct kunit_case io_pgtable_arm_test_cases[] = {
+	KUNIT_CASE(arm_lpae_do_selftests),
+	{},
+};
+
+static struct kunit_suite io_pgtable_arm_test = {
+	.name = "io-pgtable-arm-test",
+	.test_cases = io_pgtable_arm_test_cases,
+};
+
+kunit_test_suite(io_pgtable_arm_test);
 
-subsys_initcall(arm_lpae_do_selftests);
-module_exit(arm_lpae_exit_selftests);
 MODULE_DESCRIPTION("io-pgtable-arm library selftest");
 MODULE_LICENSE("GPL");
-- 
2.51.0.384.g4c02a37b29-goog

