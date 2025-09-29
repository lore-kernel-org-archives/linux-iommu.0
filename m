Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9351219F40A
	for <iommu@lists.linux.dev>; Mon, 29 Sep 2025 15:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759161016; cv=none; b=gHCnSUTDbwapjhlToGP8i8vuGKx4oLBb9QAP5li1HuROMpvogWBofkPPJa19dMSldzIIintcoYsze+sVoScB7rBIlF3bv4SMZwHkkyzsnjIDp9ms+CCsnj1R39+Bdv4U0lnjOFik5u/6XcOoK5/wtGAy1zWlCZ2iwfEudqJCuvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759161016; c=relaxed/simple;
	bh=e+dO3TdTPUtOJ9w/cxH12JvpOvQM+TDsOm9CNC0cxF8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=a50iwpSc+cnJ7ZftkocLPyiidJbBx8V6arge5p2PtXnjEO0YoBqjgtas9qbphMiAKVneTO7BAsOEf5uEZEBX5efy6aZeG6oArnZlA7ZCpZcxuL46rUL8hlymioHgk9/1/NokvPTzSSbNYy+NKMM6wADVyQ+WFjy0c2tK3yM58z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zxMPADEv; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zxMPADEv"
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-46e38957979so22846975e9.3
        for <iommu@lists.linux.dev>; Mon, 29 Sep 2025 08:50:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759161012; x=1759765812; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=BEgYRP9pjGI8MH0ERrMYDYhvE9nlc9YIovovBCSH5M4=;
        b=zxMPADEvK2H2Y4X7gfR4bGkXQnMTeRVi9RHEAJa2xJs9dJlTruHSqOlYZ/f7Ub5b7Z
         gxVIToOKf37FKioyTuiCe3D1NdNZw5yCMGKvkll6X0UvprL2y9JEAYFw+5gUv4F/l/bw
         aR3Zef0SulkyfD7gZqZDNJ6QdCjgom5jp2tQ5fmxbHi1EWObArAbt5HhVC8BY9MHGPKi
         UkKkXL2zlot1oUYwl9iLqjjnMbWGlKPW7itc9D54kk2Z9CoHg85EGwsKrHk04fE5oc1i
         GiRV4kyKwXllAGLMrAfVt2IfRy0GajI+vGtHzgKrlyYWbmAO6I+LX8ONKUrZTfVuxr2Q
         44nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759161012; x=1759765812;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BEgYRP9pjGI8MH0ERrMYDYhvE9nlc9YIovovBCSH5M4=;
        b=tgtjScJeu5bKp0hQtwA0Sfw+rXoSbOHiFUCklYsNjEbheKTsin6BK9ic/MLHTWRTOU
         pH9TJ0ZQFewAmN2MC+c0cAm880EYa7KDjIexH6EzgTgMyoXFd/CMjk10LlF2W2GG82l4
         NjhXI5U9reWjMo4TsQSbje0q6cLy3guvnZkfQPTqS4IOu6gxmGdg9Ja/4QrpGl6Es2C0
         mAsn9sD7TPywvvWHT0YWJrGUL8GfRMlElZLqyM+N/hF4qeeigNDD2HZWyCJOfxSByOfS
         3SjuaL49/e9z8uVrXsMsQBhLJgdcNU+V0c1YTK1iRopjqCV2nDmvWzcCBEB/D2s7T+qU
         9log==
X-Gm-Message-State: AOJu0Ywka3OXUIlncJLL8uaizby2uegDcUa7bpCBAERkHDuXG+VNrhx3
	4bnGuCyo4LPNpKUQNV0TWdQ7u65Tfs+56XGbaBFW/cuJZVPy3fGSyhhD9HmLVHkWrMZLxPEfxaY
	7TtWtHHsdIISH5z3z7PdKGGvYqofddplWNkJHIRJ8o4UkyW8uZNRe6CKUR6uwaujaTMIKjq/qOw
	RUJu7vwvy9kxx91Cb60iTD92mE0JZ2eqjrklXnh15u4KTvZQ==
X-Google-Smtp-Source: AGHT+IH02TVx87JZNG4/PbnW2pW4B2Qn/p6OdDDTJVwjoPTklfJoNYTo0+sAfcLhrmO/WJXH64U2N03jAr6p1g==
X-Received: from wmbep21.prod.google.com ([2002:a05:600c:8415:b0:45d:d881:33a7])
 (user=smostafa job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:1d16:b0:45d:84ca:8a7 with SMTP id 5b1f17b1804b1-46e329bb51cmr138280925e9.14.1759161011598;
 Mon, 29 Sep 2025 08:50:11 -0700 (PDT)
Date: Mon, 29 Sep 2025 15:49:59 +0000
In-Reply-To: <20250929155001.3287719-1-smostafa@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250929155001.3287719-1-smostafa@google.com>
X-Mailer: git-send-email 2.51.0.536.g15c5d4f767-goog
Message-ID: <20250929155001.3287719-5-smostafa@google.com>
Subject: [PATCH v5 4/4] iommu/io-pgtable-arm-selftests: Use KUnit
From: Mostafa Saleh <smostafa@google.com>
To: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Cc: robin.murphy@arm.com, will@kernel.org, joro@8bytes.org, jgg@ziepe.ca, 
	praan@google.com, Mostafa Saleh <smostafa@google.com>, Jason Gunthorpe <jgg@nvidia.com>
Content-Type: text/plain; charset="UTF-8"

Integrate the selftests as part of kunit.

Now instead of the test only being run at boot, it can run:

- With CONFIG_IOMMU_IO_PGTABLE_LPAE_KUNIT_TEST=y
  It will automatically run at boot as before.

- Otherwise with CONFIG_IOMMU_IO_PGTABLE_KUNIT_TEST=m:
  1) on module load:
     Once the module load the self test will run
     # modprobe io-pgtable-arm-selftests

  2) debugfs
     With CONFIG_KUNIT_DEBUGFS=y You can run the test with
     # echo 1 > /sys/kernel/debug/kunit/io-pgtable-arm-test/run

  3) Using kunit.py
     You can also use the helper script which uses Qemu in the background

     # ./tools/testing/kunit/kunit.py run --build_dir build_kunit_arm64 --arch arm64 \
       --make_options LLVM=1 --kunitconfig ./kunit/kunitconfig
      [18:01:09] ============= io-pgtable-arm-test (1 subtest) ==============
      [18:01:09] [PASSED] arm_lpae_do_selftests
      [18:01:09] =============== [PASSED] io-pgtable-arm-test ===============
      [18:01:09] ============================================================

Suggested-by: Jason Gunthorpe <jgg@ziepe.ca>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Pranjal Shrivastava <praan@google.com>
Signed-off-by: Mostafa Saleh <smostafa@google.com>
---
 drivers/iommu/Kconfig                    | 11 ++--
 drivers/iommu/Makefile                   |  2 +-
 drivers/iommu/io-pgtable-arm-selftests.c | 82 +++++++++++++-----------
 3 files changed, 51 insertions(+), 44 deletions(-)

diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index 553522ef3ca9..d50685433347 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -40,12 +40,13 @@ config IOMMU_IO_PGTABLE_LPAE
 	  sizes at both stage-1 and stage-2, as well as address spaces
 	  up to 48-bits in size.
 
-config IOMMU_IO_PGTABLE_LPAE_SELFTEST
-	tristate "LPAE selftests"
-	depends on IOMMU_IO_PGTABLE_LPAE
+config IOMMU_IO_PGTABLE_LPAE_KUNIT_TEST
+	tristate "KUnit tests for LPAE"
+	depends on IOMMU_IO_PGTABLE_LPAE && KUNIT
+	default KUNIT_ALL_TESTS
 	help
-	  Enable self-tests for LPAE page table allocator. This performs
-	  a series of page-table consistency checks during boot.
+	  Enable kunit tests for LPAE page table allocator. This performs
+	  a series of page-table consistency checks.
 
 	  If unsure, say N here.
 
diff --git a/drivers/iommu/Makefile b/drivers/iommu/Makefile
index 5250a2eea13f..ac3851570303 100644
--- a/drivers/iommu/Makefile
+++ b/drivers/iommu/Makefile
@@ -12,7 +12,7 @@ obj-$(CONFIG_IOMMU_DMA) += dma-iommu.o
 obj-$(CONFIG_IOMMU_IO_PGTABLE) += io-pgtable.o
 obj-$(CONFIG_IOMMU_IO_PGTABLE_ARMV7S) += io-pgtable-arm-v7s.o
 obj-$(CONFIG_IOMMU_IO_PGTABLE_LPAE) += io-pgtable-arm.o
-obj-$(CONFIG_IOMMU_IO_PGTABLE_LPAE_SELFTEST) += io-pgtable-arm-selftests.o
+obj-$(CONFIG_IOMMU_IO_PGTABLE_LPAE_KUNIT_TEST) += io-pgtable-arm-selftests.o
 obj-$(CONFIG_IOMMU_IO_PGTABLE_DART) += io-pgtable-dart.o
 obj-$(CONFIG_IOMMU_IOVA) += iova.o
 obj-$(CONFIG_OF_IOMMU)	+= of_iommu.o
diff --git a/drivers/iommu/io-pgtable-arm-selftests.c b/drivers/iommu/io-pgtable-arm-selftests.c
index 32c6a5c7af53..b61849a8a685 100644
--- a/drivers/iommu/io-pgtable-arm-selftests.c
+++ b/drivers/iommu/io-pgtable-arm-selftests.c
@@ -6,7 +6,8 @@
  *
  * Author: Will Deacon <will.deacon@arm.com>
  */
-#include <linux/device/faux.h>
+#include <kunit/device.h>
+#include <kunit/test.h>
 #include <linux/io-pgtable.h>
 #include <linux/kernel.h>
 
@@ -47,13 +48,14 @@ static void arm_lpae_dump_ops(struct io_pgtable_ops *ops)
 		cfg->pgsize_bitmap, cfg->ias, cfg->oas);
 }
 
-#define __FAIL(ops, i)	({						\
-		WARN(1, "selftest: test failed for fmt idx %d\n", (i));	\
-		arm_lpae_dump_ops(ops);					\
-		-EFAULT;						\
+#define __FAIL(test, ops, i)	({						\
+		KUNIT_FAIL(test, "");						\
+		kunit_err(test, "selftest: test failed for fmt idx %d\n", (i));	\
+		arm_lpae_dump_ops(ops);						\
+		-EFAULT;							\
 })
 
-static int arm_lpae_run_tests(struct io_pgtable_cfg *cfg)
+static int arm_lpae_run_tests(struct kunit *test, struct io_pgtable_cfg *cfg)
 {
 	static const enum io_pgtable_fmt fmts[] = {
 		ARM_64_LPAE_S1,
@@ -69,7 +71,7 @@ static int arm_lpae_run_tests(struct io_pgtable_cfg *cfg)
 		cfg_cookie = cfg;
 		ops = alloc_io_pgtable_ops(fmts[i], cfg, cfg);
 		if (!ops) {
-			pr_err("selftest: failed to allocate io pgtable ops\n");
+			kunit_err(test, "selftest: failed to allocate io pgtable ops\n");
 			return -ENOMEM;
 		}
 
@@ -78,13 +80,13 @@ static int arm_lpae_run_tests(struct io_pgtable_cfg *cfg)
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
@@ -97,16 +99,16 @@ static int arm_lpae_run_tests(struct io_pgtable_cfg *cfg)
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
@@ -117,18 +119,18 @@ static int arm_lpae_run_tests(struct io_pgtable_cfg *cfg)
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
@@ -144,11 +146,11 @@ static int arm_lpae_run_tests(struct io_pgtable_cfg *cfg)
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
@@ -156,7 +158,7 @@ static int arm_lpae_run_tests(struct io_pgtable_cfg *cfg)
 	return 0;
 }
 
-static int arm_lpae_do_selftests(void)
+static void arm_lpae_do_selftests(struct kunit *test)
 {
 	static const unsigned long pgsize[] = {
 		SZ_4K | SZ_2M | SZ_1G,
@@ -169,18 +171,19 @@ static int arm_lpae_do_selftests(void)
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
@@ -189,9 +192,9 @@ static int arm_lpae_do_selftests(void)
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
@@ -199,17 +202,20 @@ static int arm_lpae_do_selftests(void)
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
2.51.0.536.g15c5d4f767-goog

