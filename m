Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFF9B28726E
	for <iommu@lists.linux.dev>; Mon, 22 Sep 2025 09:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758531614; cv=none; b=gTV8dIB2j1Jo/HD7dCffRejdTQwOM3dLCk45B+Hu271p1H/G1UtoMOCkwrjZcBDz48m8D2zsv6IWI2SzXnNSVRtiu8gksLRj/V0v8JtYgAxSJnLldPOkZHPFZ/pmR2WfHPVaEa1Ux1pSMpKAslpUifgpTE5/3mQJxnYWp/KR/aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758531614; c=relaxed/simple;
	bh=G27qEXWQqpyS77HZ4Ggj3iTnX1m9X4z98mMc0f/SONs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=iGR0GyU76n4MbsIt5wS/jXq6X+ry5aV974tDe2xn+bviNGujV4YWmsqx8N6r8fY2LvvuKYKAWd3/Jp5XC4eCzHhQSP2ORA3V9e2mFc8g3hMjyOdN4f9GlvX9aEgzqlXB5PT8I/PIb9qTR8AxExBcILOkhI8AlZy9vhlH4csL2Wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XjOiXed+; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XjOiXed+"
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-46b303f6c9cso11966725e9.2
        for <iommu@lists.linux.dev>; Mon, 22 Sep 2025 02:00:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758531609; x=1759136409; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=mi6TD8VyLf+L2Nc6qgjtgNBQkwWi+DuvkEzgMSAI6jo=;
        b=XjOiXed+WE+yPjcSqw1i5blVbH3PWybk27NSNtZXXqLpcFmqWz2Rb4GQnW96w76hfa
         iwYfKUsf3jQtEd3xcmKpipXtzFFInMUAbzT6l+hBJzfk6uDT2r6IubhB9aUikZ5zC38R
         1aVSoy4JSXdCW0kpHPHxEgLdzMXA839u+SVdF5yYlpXbiGFri3ceTUZiaUgx4RuuHBkL
         Ib91tWm31RSes4LGgz16GEjbG13hKdDDHPvVM8HM/ldIsesuHmNpGpQAS7i7McWqHKig
         Fi9WXbwGa6rvD1KvXmVPS/hbL7cdYSnDL0PGOtS1YVaXaraUMlh7wBaj7pK0fpqPCsh6
         zbfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758531609; x=1759136409;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mi6TD8VyLf+L2Nc6qgjtgNBQkwWi+DuvkEzgMSAI6jo=;
        b=dEQubc92bI/yu4EGytQ1/3zgpE3pJnU2sNMugRc6gDaBCQ/QEiJM/PX6jcJPNsRQrq
         vnwj9s8t60LbnS7eQfrIRHQarl1/uVYXsw3MVPgIfTZZFXUburdXoL7RptGRHyrma+sa
         XZh2REcSR/p2Psht39Oa0Yi2KlOJFg+/e9hI/0OqAnT5a/TXTtDW1Rr+hYB0U61lhFv4
         cBM4oynO4S63K43p7rqRIVo4ykdcvI8s8G6+DZjMMQeO4suCJRHRr68Ojg0qa6fwfSiF
         aqpZdqIFaHEfGJAMvq95/li9E9CX9HhycsNZlgqL1uM+ek55PG8mDu1qV3vAv8tucxK7
         u0nQ==
X-Gm-Message-State: AOJu0YwvPsecfYW+XEcjecdC9tjxS7jqiEc9TBtHfURwz2xlQ9te7f1e
	1BNSgdYc33t+c4tKUQBhq94dq7nmXmx5j302CvTs+6+qjcGotLhV7wV0nVlZA4xK78GAz9oG/id
	FSRB7EmbJvsyTv78hP1CXM7l26TCX5YNUOs344gcE2f8x9ylWaXgHHiTiBURAwmUXrPD6ZPjyvD
	8sGJegKSYohLsT6UQE58z+tbQ/Bi5SjLEVq1yUWvNaN8K23g==
X-Google-Smtp-Source: AGHT+IHEl5s+QPaPzGfgCuRqhCMt6KCfe3mA0A/82HtqGagB0IP7AhZDyC3DDVBt3JAEbplLYzuZt2vDDFw8ww==
X-Received: from wmtk8.prod.google.com ([2002:a05:600c:c4a8:b0:45b:885a:402d])
 (user=smostafa job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:4f44:b0:46d:996b:8291 with SMTP id 5b1f17b1804b1-46d996b8960mr13252115e9.34.1758531609366;
 Mon, 22 Sep 2025 02:00:09 -0700 (PDT)
Date: Mon, 22 Sep 2025 08:59:28 +0000
In-Reply-To: <20250922090003.686704-1-smostafa@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250922090003.686704-1-smostafa@google.com>
X-Mailer: git-send-email 2.51.0.534.gc79095c0ca-goog
Message-ID: <20250922090003.686704-5-smostafa@google.com>
Subject: [PATCH v4 4/4] iommu/io-pgtable-arm-selftests: Use KUnit
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
index 50350e88d9b4..fc18bd54a315 100644
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
 #include <linux/slab.h>
@@ -48,13 +49,14 @@ static void arm_lpae_dump_ops(struct io_pgtable_ops *ops)
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
@@ -70,7 +72,7 @@ static int arm_lpae_run_tests(struct io_pgtable_cfg *cfg)
 		cfg_cookie = cfg;
 		ops = alloc_io_pgtable_ops(fmts[i], cfg, cfg);
 		if (!ops) {
-			pr_err("selftest: failed to allocate io pgtable ops\n");
+			kunit_err(test, "selftest: failed to allocate io pgtable ops\n");
 			return -ENOMEM;
 		}
 
@@ -79,13 +81,13 @@ static int arm_lpae_run_tests(struct io_pgtable_cfg *cfg)
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
@@ -98,16 +100,16 @@ static int arm_lpae_run_tests(struct io_pgtable_cfg *cfg)
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
@@ -118,18 +120,18 @@ static int arm_lpae_run_tests(struct io_pgtable_cfg *cfg)
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
@@ -145,11 +147,11 @@ static int arm_lpae_run_tests(struct io_pgtable_cfg *cfg)
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
@@ -157,7 +159,7 @@ static int arm_lpae_run_tests(struct io_pgtable_cfg *cfg)
 	return 0;
 }
 
-static int arm_lpae_do_selftests(void)
+static void arm_lpae_do_selftests(struct kunit *test)
 {
 	static const unsigned long pgsize[] = {
 		SZ_4K | SZ_2M | SZ_1G,
@@ -170,18 +172,19 @@ static int arm_lpae_do_selftests(void)
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
@@ -190,9 +193,9 @@ static int arm_lpae_do_selftests(void)
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
@@ -200,17 +203,20 @@ static int arm_lpae_do_selftests(void)
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
2.51.0.534.gc79095c0ca-goog

