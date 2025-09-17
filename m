Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B56FE323404
	for <iommu@lists.linux.dev>; Wed, 17 Sep 2025 14:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758117753; cv=none; b=J3kFKyODjTp0wylKNLr0Vv8cYNdinIFOscv8pHb+v/NefOmKNz2Y2C/md6YwvFa9JueGzgrYO9bZJr0NcFwtmUt+tx1h7rAi/q+xHvhKa2PRi19FUIk90zsyClwEG6bEINJ0HXxhfePcl1XIRs5oiUr6fCOIgpq2jdKqv4/9tQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758117753; c=relaxed/simple;
	bh=ATUgOY5cIoYJVQrhEZ4LhDX2L/+l3r8cGRPjFTceEV0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ILHG9ZT+j+FWhSDv8bOPNhhEYxM3BiHB8CsnWZTS20i/csLb1BOO2ABcLDhBrfhALxMoyO9a9WkeinRT8PLh+bz75NNANa3qbqpn7NV7SfWbEr0D9z+pO5yudldxbEqQiq2jrzJ3cA1gUNPJJ1Q+oojxwe9C4C90QSznadqAGd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=G7O5Yek0; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="G7O5Yek0"
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-3eb536ac039so2077354f8f.1
        for <iommu@lists.linux.dev>; Wed, 17 Sep 2025 07:02:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758117749; x=1758722549; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=dPTm9ldH05FB4Yw+nXjL4CLcI1O0tCdKN6q7o4MyyHk=;
        b=G7O5Yek0j/EymuXfVujbChkGy2EiD2cOkx9Uzw9Uz/R1mwQlpCdcBaGX4SBOrasVvI
         IRPKeiEpuL5R8xH6lEPiYM8qONJz02FyNX5l1N+uu8kTH9BFs24KzkMddH6nt6ppcwHR
         BLDNDuKir6BmYYyswqbkHcji3mB7qG0cC5MVPtDbpyY7xsUo26g0QzV0H4pOR1yvsRxh
         olfXDT0JWRxQzQbOK/dIcv7buulF1yWoNJ161zTHD0iAYAgGvkrZyZvmxZImk01oQpFF
         7O4QcxHsyAgZhBZZISrpo0t9rEkrDOhK1j/JZPJUYZWW9ghC8kY3939YLyu2mRu1WfEY
         lQ+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758117749; x=1758722549;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dPTm9ldH05FB4Yw+nXjL4CLcI1O0tCdKN6q7o4MyyHk=;
        b=nPWZcraLvux+IyLsC1YqQjMETGvf5h8k1FSKNKZtqaEDQhkGzy6N8y9F6Z9gZJlSWn
         41jskebhHFio/8M3MsV0Tbx5MWxVLehprhbIWSkWV8T3+RBpQX8IhEoGdkXwUR8+WsGX
         entQoYa8U3GhAsfhukM7qgqba2TLMXTj0gXtcAqZwpnl7EjLmsEATyN0+P8aLmWWxUZz
         HNUZNZLU+SV7K/K3enmWSwtdr8jpTCJNxDd//WaJkcXD8Ny5gFcS52RCj2Mu+uCoS5Mh
         SndQyEWgOGBF0/OfPJzLTzGVbEoe5h68Nil8W2L4Tbv+M5v1Itxf8cMMlFJTVtwTqClm
         Ynnw==
X-Gm-Message-State: AOJu0YwbJgbbh+42EBzkyMjaUyj51hSZkGN/MQGRM+f1WdHCUPml1KsY
	seP8HwyJ7kN0ZAvrCnF6BnNRwvKO0QLO+iBhc0uDqD++M7xCaGUvtLvbOeuKJC7Afg7zGdrtmQ9
	52UCkzdICYVBSqIXfHI/bC/XJ6JAOmDVOf2mFU5HPueNk9oGnvvk/NYPQREs9VQIzGk2iA2vLIl
	eQFvIIQVZZSPrGe5IvJpGBWOPNGAj2BJwM95y4c7vsrbWG3A==
X-Google-Smtp-Source: AGHT+IEaQio/Zs7puieg6tM047i35YMeLXuQUx6Kkae+qk+M5jpGAX1GbglUvmZjLAougtbpym7PZT/84AZH5g==
X-Received: from wrfu4.prod.google.com ([2002:a05:6000:384:b0:3ea:af7:bb94])
 (user=smostafa job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:420a:b0:3ec:db18:1695 with SMTP id ffacd0b85a97d-3ecdfa2af44mr2483150f8f.45.1758117748915;
 Wed, 17 Sep 2025 07:02:28 -0700 (PDT)
Date: Wed, 17 Sep 2025 14:02:02 +0000
In-Reply-To: <20250917140216.2199055-1-smostafa@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250917140216.2199055-1-smostafa@google.com>
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
Message-ID: <20250917140216.2199055-2-smostafa@google.com>
Subject: [PATCH 1/2] iommu/io-pgtable-arm: Move selftests to a separate file
From: Mostafa Saleh <smostafa@google.com>
To: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Cc: robin.murphy@arm.com, will@kernel.org, joro@8bytes.org, jgg@ziepe.ca, 
	praan@google.com, Mostafa Saleh <smostafa@google.com>
Content-Type: text/plain; charset="UTF-8"

Clean up the io-pgtable-arm library by moving the selftests out.
Next the tests will be registered with kunit.

This is useful also to factor out kernel specific code out, so
it can compiled as part of the hypervisor object.

Signed-off-by: Mostafa Saleh <smostafa@google.com>
---
 drivers/iommu/Makefile                   |   1 +
 drivers/iommu/io-pgtable-arm-selftests.c | 211 ++++++++++++++++++++
 drivers/iommu/io-pgtable-arm.c           | 243 -----------------------
 drivers/iommu/io-pgtable-arm.h           |  41 ++++
 4 files changed, 253 insertions(+), 243 deletions(-)
 create mode 100644 drivers/iommu/io-pgtable-arm-selftests.c

diff --git a/drivers/iommu/Makefile b/drivers/iommu/Makefile
index 355294fa9033..5250a2eea13f 100644
--- a/drivers/iommu/Makefile
+++ b/drivers/iommu/Makefile
@@ -12,6 +12,7 @@ obj-$(CONFIG_IOMMU_DMA) += dma-iommu.o
 obj-$(CONFIG_IOMMU_IO_PGTABLE) += io-pgtable.o
 obj-$(CONFIG_IOMMU_IO_PGTABLE_ARMV7S) += io-pgtable-arm-v7s.o
 obj-$(CONFIG_IOMMU_IO_PGTABLE_LPAE) += io-pgtable-arm.o
+obj-$(CONFIG_IOMMU_IO_PGTABLE_LPAE_SELFTEST) += io-pgtable-arm-selftests.o
 obj-$(CONFIG_IOMMU_IO_PGTABLE_DART) += io-pgtable-dart.o
 obj-$(CONFIG_IOMMU_IOVA) += iova.o
 obj-$(CONFIG_OF_IOMMU)	+= of_iommu.o
diff --git a/drivers/iommu/io-pgtable-arm-selftests.c b/drivers/iommu/io-pgtable-arm-selftests.c
new file mode 100644
index 000000000000..f7746ff2c7a0
--- /dev/null
+++ b/drivers/iommu/io-pgtable-arm-selftests.c
@@ -0,0 +1,211 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * CPU-agnostic ARM page table allocator.
+ *
+ * Copyright (C) 2014 ARM Limited
+ *
+ * Author: Will Deacon <will.deacon@arm.com>
+ */
+#include <linux/device/faux.h>
+#include <linux/kernel.h>
+#include <linux/slab.h>
+
+#include "io-pgtable-arm.h"
+
+static struct io_pgtable_cfg *cfg_cookie __initdata;
+
+static void __init dummy_tlb_flush_all(void *cookie)
+{
+	WARN_ON(cookie != cfg_cookie);
+}
+
+static void __init dummy_tlb_flush(unsigned long iova, size_t size,
+				   size_t granule, void *cookie)
+{
+	WARN_ON(cookie != cfg_cookie);
+	WARN_ON(!(size & cfg_cookie->pgsize_bitmap));
+}
+
+static void __init dummy_tlb_add_page(struct iommu_iotlb_gather *gather,
+				      unsigned long iova, size_t granule,
+				      void *cookie)
+{
+	dummy_tlb_flush(iova, granule, granule, cookie);
+}
+
+static const struct iommu_flush_ops dummy_tlb_ops __initconst = {
+	.tlb_flush_all	= dummy_tlb_flush_all,
+	.tlb_flush_walk	= dummy_tlb_flush,
+	.tlb_add_page	= dummy_tlb_add_page,
+};
+
+static void __init arm_lpae_dump_ops(struct io_pgtable_ops *ops)
+{
+	struct arm_lpae_io_pgtable *data = io_pgtable_ops_to_data(ops);
+	struct io_pgtable_cfg *cfg = &data->iop.cfg;
+
+	pr_err("cfg: pgsize_bitmap 0x%lx, ias %u-bit\n",
+		cfg->pgsize_bitmap, cfg->ias);
+	pr_err("data: %d levels, 0x%zx pgd_size, %u pg_shift, %u bits_per_level, pgd @ %p\n",
+		ARM_LPAE_MAX_LEVELS - data->start_level, ARM_LPAE_PGD_SIZE(data),
+		ilog2(ARM_LPAE_GRANULE(data)), data->bits_per_level, data->pgd);
+}
+
+#define __FAIL(ops, i)	({						\
+		WARN(1, "selftest: test failed for fmt idx %d\n", (i));	\
+		arm_lpae_dump_ops(ops);					\
+		-EFAULT;						\
+})
+
+static int __init arm_lpae_run_tests(struct io_pgtable_cfg *cfg)
+{
+	static const enum io_pgtable_fmt fmts[] __initconst = {
+		ARM_64_LPAE_S1,
+		ARM_64_LPAE_S2,
+	};
+
+	int i, j;
+	unsigned long iova;
+	size_t size, mapped;
+	struct io_pgtable_ops *ops;
+
+	for (i = 0; i < ARRAY_SIZE(fmts); ++i) {
+		cfg_cookie = cfg;
+		ops = alloc_io_pgtable_ops(fmts[i], cfg, cfg);
+		if (!ops) {
+			pr_err("selftest: failed to allocate io pgtable ops\n");
+			return -ENOMEM;
+		}
+
+		/*
+		 * Initial sanity checks.
+		 * Empty page tables shouldn't provide any translations.
+		 */
+		if (ops->iova_to_phys(ops, 42))
+			return __FAIL(ops, i);
+
+		if (ops->iova_to_phys(ops, SZ_1G + 42))
+			return __FAIL(ops, i);
+
+		if (ops->iova_to_phys(ops, SZ_2G + 42))
+			return __FAIL(ops, i);
+
+		/*
+		 * Distinct mappings of different granule sizes.
+		 */
+		iova = 0;
+		for_each_set_bit(j, &cfg->pgsize_bitmap, BITS_PER_LONG) {
+			size = 1UL << j;
+
+			if (ops->map_pages(ops, iova, iova, size, 1,
+					   IOMMU_READ | IOMMU_WRITE |
+					   IOMMU_NOEXEC | IOMMU_CACHE,
+					   GFP_KERNEL, &mapped))
+				return __FAIL(ops, i);
+
+			/* Overlapping mappings */
+			if (!ops->map_pages(ops, iova, iova + size, size, 1,
+					    IOMMU_READ | IOMMU_NOEXEC,
+					    GFP_KERNEL, &mapped))
+				return __FAIL(ops, i);
+
+			if (ops->iova_to_phys(ops, iova + 42) != (iova + 42))
+				return __FAIL(ops, i);
+
+			iova += SZ_1G;
+		}
+
+		/* Full unmap */
+		iova = 0;
+		for_each_set_bit(j, &cfg->pgsize_bitmap, BITS_PER_LONG) {
+			size = 1UL << j;
+
+			if (ops->unmap_pages(ops, iova, size, 1, NULL) != size)
+				return __FAIL(ops, i);
+
+			if (ops->iova_to_phys(ops, iova + 42))
+				return __FAIL(ops, i);
+
+			/* Remap full block */
+			if (ops->map_pages(ops, iova, iova, size, 1,
+					   IOMMU_WRITE, GFP_KERNEL, &mapped))
+				return __FAIL(ops, i);
+
+			if (ops->iova_to_phys(ops, iova + 42) != (iova + 42))
+				return __FAIL(ops, i);
+
+			iova += SZ_1G;
+		}
+
+		/*
+		 * Map/unmap the last largest supported page of the IAS, this can
+		 * trigger corner cases in the concatednated page tables.
+		 */
+		mapped = 0;
+		size = 1UL << __fls(cfg->pgsize_bitmap);
+		iova = (1UL << cfg->ias) - size;
+		if (ops->map_pages(ops, iova, iova, size, 1,
+				   IOMMU_READ | IOMMU_WRITE |
+				   IOMMU_NOEXEC | IOMMU_CACHE,
+				   GFP_KERNEL, &mapped))
+			return __FAIL(ops, i);
+		if (mapped != size)
+			return __FAIL(ops, i);
+		if (ops->unmap_pages(ops, iova, size, 1, NULL) != size)
+			return __FAIL(ops, i);
+
+		free_io_pgtable_ops(ops);
+	}
+
+	return 0;
+}
+
+static int __init arm_lpae_do_selftests(void)
+{
+	static const unsigned long pgsize[] __initconst = {
+		SZ_4K | SZ_2M | SZ_1G,
+		SZ_16K | SZ_32M,
+		SZ_64K | SZ_512M,
+	};
+
+	static const unsigned int address_size[] __initconst = {
+		32, 36, 40, 42, 44, 48,
+	};
+
+	int i, j, k, pass = 0, fail = 0;
+	struct faux_device *dev;
+	struct io_pgtable_cfg cfg = {
+		.tlb = &dummy_tlb_ops,
+		.coherent_walk = true,
+		.quirks = IO_PGTABLE_QUIRK_NO_WARN,
+	};
+
+	dev = faux_device_create("io-pgtable-test", NULL, 0);
+	if (!dev)
+		return -ENOMEM;
+
+	cfg.iommu_dev = &dev->dev;
+
+	for (i = 0; i < ARRAY_SIZE(pgsize); ++i) {
+		for (j = 0; j < ARRAY_SIZE(address_size); ++j) {
+			/* Don't use ias > oas as it is not valid for stage-2. */
+			for (k = 0; k <= j; ++k) {
+				cfg.pgsize_bitmap = pgsize[i];
+				cfg.ias = address_size[k];
+				cfg.oas = address_size[j];
+				pr_info("selftest: pgsize_bitmap 0x%08lx, IAS %u OAS %u\n",
+					pgsize[i], cfg.ias, cfg.oas);
+				if (arm_lpae_run_tests(&cfg))
+					fail++;
+				else
+					pass++;
+			}
+		}
+	}
+
+	pr_info("selftest: completed with %d PASS %d FAIL\n", pass, fail);
+	faux_device_destroy(dev);
+
+	return fail ? -EFAULT : 0;
+}
+subsys_initcall(arm_lpae_do_selftests);
diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
index 7e8e2216c294..b1d968edccd6 100644
--- a/drivers/iommu/io-pgtable-arm.c
+++ b/drivers/iommu/io-pgtable-arm.c
@@ -12,10 +12,7 @@
 #include <linux/atomic.h>
 #include <linux/bitops.h>
 #include <linux/io-pgtable.h>
-#include <linux/kernel.h>
-#include <linux/device/faux.h>
 #include <linux/sizes.h>
-#include <linux/slab.h>
 #include <linux/types.h>
 #include <linux/dma-mapping.h>
 
@@ -24,33 +21,6 @@
 #include "io-pgtable-arm.h"
 #include "iommu-pages.h"
 
-#define ARM_LPAE_MAX_ADDR_BITS		52
-#define ARM_LPAE_S2_MAX_CONCAT_PAGES	16
-#define ARM_LPAE_MAX_LEVELS		4
-
-/* Struct accessors */
-#define io_pgtable_to_data(x)						\
-	container_of((x), struct arm_lpae_io_pgtable, iop)
-
-#define io_pgtable_ops_to_data(x)					\
-	io_pgtable_to_data(io_pgtable_ops_to_pgtable(x))
-
-/*
- * Calculate the right shift amount to get to the portion describing level l
- * in a virtual address mapped by the pagetable in d.
- */
-#define ARM_LPAE_LVL_SHIFT(l,d)						\
-	(((ARM_LPAE_MAX_LEVELS - (l)) * (d)->bits_per_level) +		\
-	ilog2(sizeof(arm_lpae_iopte)))
-
-#define ARM_LPAE_GRANULE(d)						\
-	(sizeof(arm_lpae_iopte) << (d)->bits_per_level)
-#define ARM_LPAE_PGD_SIZE(d)						\
-	(sizeof(arm_lpae_iopte) << (d)->pgd_bits)
-
-#define ARM_LPAE_PTES_PER_TABLE(d)					\
-	(ARM_LPAE_GRANULE(d) >> ilog2(sizeof(arm_lpae_iopte)))
-
 /*
  * Calculate the index at level l used to map virtual address a using the
  * pagetable in d.
@@ -156,18 +126,6 @@
 #define iopte_set_writeable_clean(ptep)				\
 	set_bit(ARM_LPAE_PTE_AP_RDONLY_BIT, (unsigned long *)(ptep))
 
-struct arm_lpae_io_pgtable {
-	struct io_pgtable	iop;
-
-	int			pgd_bits;
-	int			start_level;
-	int			bits_per_level;
-
-	void			*pgd;
-};
-
-typedef u64 arm_lpae_iopte;
-
 static inline bool iopte_leaf(arm_lpae_iopte pte, int lvl,
 			      enum io_pgtable_fmt fmt)
 {
@@ -1267,204 +1225,3 @@ struct io_pgtable_init_fns io_pgtable_arm_mali_lpae_init_fns = {
 	.alloc	= arm_mali_lpae_alloc_pgtable,
 	.free	= arm_lpae_free_pgtable,
 };
-
-#ifdef CONFIG_IOMMU_IO_PGTABLE_LPAE_SELFTEST
-
-static struct io_pgtable_cfg *cfg_cookie __initdata;
-
-static void __init dummy_tlb_flush_all(void *cookie)
-{
-	WARN_ON(cookie != cfg_cookie);
-}
-
-static void __init dummy_tlb_flush(unsigned long iova, size_t size,
-				   size_t granule, void *cookie)
-{
-	WARN_ON(cookie != cfg_cookie);
-	WARN_ON(!(size & cfg_cookie->pgsize_bitmap));
-}
-
-static void __init dummy_tlb_add_page(struct iommu_iotlb_gather *gather,
-				      unsigned long iova, size_t granule,
-				      void *cookie)
-{
-	dummy_tlb_flush(iova, granule, granule, cookie);
-}
-
-static const struct iommu_flush_ops dummy_tlb_ops __initconst = {
-	.tlb_flush_all	= dummy_tlb_flush_all,
-	.tlb_flush_walk	= dummy_tlb_flush,
-	.tlb_add_page	= dummy_tlb_add_page,
-};
-
-static void __init arm_lpae_dump_ops(struct io_pgtable_ops *ops)
-{
-	struct arm_lpae_io_pgtable *data = io_pgtable_ops_to_data(ops);
-	struct io_pgtable_cfg *cfg = &data->iop.cfg;
-
-	pr_err("cfg: pgsize_bitmap 0x%lx, ias %u-bit\n",
-		cfg->pgsize_bitmap, cfg->ias);
-	pr_err("data: %d levels, 0x%zx pgd_size, %u pg_shift, %u bits_per_level, pgd @ %p\n",
-		ARM_LPAE_MAX_LEVELS - data->start_level, ARM_LPAE_PGD_SIZE(data),
-		ilog2(ARM_LPAE_GRANULE(data)), data->bits_per_level, data->pgd);
-}
-
-#define __FAIL(ops, i)	({						\
-		WARN(1, "selftest: test failed for fmt idx %d\n", (i));	\
-		arm_lpae_dump_ops(ops);					\
-		-EFAULT;						\
-})
-
-static int __init arm_lpae_run_tests(struct io_pgtable_cfg *cfg)
-{
-	static const enum io_pgtable_fmt fmts[] __initconst = {
-		ARM_64_LPAE_S1,
-		ARM_64_LPAE_S2,
-	};
-
-	int i, j;
-	unsigned long iova;
-	size_t size, mapped;
-	struct io_pgtable_ops *ops;
-
-	for (i = 0; i < ARRAY_SIZE(fmts); ++i) {
-		cfg_cookie = cfg;
-		ops = alloc_io_pgtable_ops(fmts[i], cfg, cfg);
-		if (!ops) {
-			pr_err("selftest: failed to allocate io pgtable ops\n");
-			return -ENOMEM;
-		}
-
-		/*
-		 * Initial sanity checks.
-		 * Empty page tables shouldn't provide any translations.
-		 */
-		if (ops->iova_to_phys(ops, 42))
-			return __FAIL(ops, i);
-
-		if (ops->iova_to_phys(ops, SZ_1G + 42))
-			return __FAIL(ops, i);
-
-		if (ops->iova_to_phys(ops, SZ_2G + 42))
-			return __FAIL(ops, i);
-
-		/*
-		 * Distinct mappings of different granule sizes.
-		 */
-		iova = 0;
-		for_each_set_bit(j, &cfg->pgsize_bitmap, BITS_PER_LONG) {
-			size = 1UL << j;
-
-			if (ops->map_pages(ops, iova, iova, size, 1,
-					   IOMMU_READ | IOMMU_WRITE |
-					   IOMMU_NOEXEC | IOMMU_CACHE,
-					   GFP_KERNEL, &mapped))
-				return __FAIL(ops, i);
-
-			/* Overlapping mappings */
-			if (!ops->map_pages(ops, iova, iova + size, size, 1,
-					    IOMMU_READ | IOMMU_NOEXEC,
-					    GFP_KERNEL, &mapped))
-				return __FAIL(ops, i);
-
-			if (ops->iova_to_phys(ops, iova + 42) != (iova + 42))
-				return __FAIL(ops, i);
-
-			iova += SZ_1G;
-		}
-
-		/* Full unmap */
-		iova = 0;
-		for_each_set_bit(j, &cfg->pgsize_bitmap, BITS_PER_LONG) {
-			size = 1UL << j;
-
-			if (ops->unmap_pages(ops, iova, size, 1, NULL) != size)
-				return __FAIL(ops, i);
-
-			if (ops->iova_to_phys(ops, iova + 42))
-				return __FAIL(ops, i);
-
-			/* Remap full block */
-			if (ops->map_pages(ops, iova, iova, size, 1,
-					   IOMMU_WRITE, GFP_KERNEL, &mapped))
-				return __FAIL(ops, i);
-
-			if (ops->iova_to_phys(ops, iova + 42) != (iova + 42))
-				return __FAIL(ops, i);
-
-			iova += SZ_1G;
-		}
-
-		/*
-		 * Map/unmap the last largest supported page of the IAS, this can
-		 * trigger corner cases in the concatednated page tables.
-		 */
-		mapped = 0;
-		size = 1UL << __fls(cfg->pgsize_bitmap);
-		iova = (1UL << cfg->ias) - size;
-		if (ops->map_pages(ops, iova, iova, size, 1,
-				   IOMMU_READ | IOMMU_WRITE |
-				   IOMMU_NOEXEC | IOMMU_CACHE,
-				   GFP_KERNEL, &mapped))
-			return __FAIL(ops, i);
-		if (mapped != size)
-			return __FAIL(ops, i);
-		if (ops->unmap_pages(ops, iova, size, 1, NULL) != size)
-			return __FAIL(ops, i);
-
-		free_io_pgtable_ops(ops);
-	}
-
-	return 0;
-}
-
-static int __init arm_lpae_do_selftests(void)
-{
-	static const unsigned long pgsize[] __initconst = {
-		SZ_4K | SZ_2M | SZ_1G,
-		SZ_16K | SZ_32M,
-		SZ_64K | SZ_512M,
-	};
-
-	static const unsigned int address_size[] __initconst = {
-		32, 36, 40, 42, 44, 48,
-	};
-
-	int i, j, k, pass = 0, fail = 0;
-	struct faux_device *dev;
-	struct io_pgtable_cfg cfg = {
-		.tlb = &dummy_tlb_ops,
-		.coherent_walk = true,
-		.quirks = IO_PGTABLE_QUIRK_NO_WARN,
-	};
-
-	dev = faux_device_create("io-pgtable-test", NULL, 0);
-	if (!dev)
-		return -ENOMEM;
-
-	cfg.iommu_dev = &dev->dev;
-
-	for (i = 0; i < ARRAY_SIZE(pgsize); ++i) {
-		for (j = 0; j < ARRAY_SIZE(address_size); ++j) {
-			/* Don't use ias > oas as it is not valid for stage-2. */
-			for (k = 0; k <= j; ++k) {
-				cfg.pgsize_bitmap = pgsize[i];
-				cfg.ias = address_size[k];
-				cfg.oas = address_size[j];
-				pr_info("selftest: pgsize_bitmap 0x%08lx, IAS %u OAS %u\n",
-					pgsize[i], cfg.ias, cfg.oas);
-				if (arm_lpae_run_tests(&cfg))
-					fail++;
-				else
-					pass++;
-			}
-		}
-	}
-
-	pr_info("selftest: completed with %d PASS %d FAIL\n", pass, fail);
-	faux_device_destroy(dev);
-
-	return fail ? -EFAULT : 0;
-}
-subsys_initcall(arm_lpae_do_selftests);
-#endif
diff --git a/drivers/iommu/io-pgtable-arm.h b/drivers/iommu/io-pgtable-arm.h
index ba7cfdf7afa0..a06a23543cff 100644
--- a/drivers/iommu/io-pgtable-arm.h
+++ b/drivers/iommu/io-pgtable-arm.h
@@ -2,6 +2,8 @@
 #ifndef IO_PGTABLE_ARM_H_
 #define IO_PGTABLE_ARM_H_
 
+#include <linux/io-pgtable.h>
+
 #define ARM_LPAE_TCR_TG0_4K		0
 #define ARM_LPAE_TCR_TG0_64K		1
 #define ARM_LPAE_TCR_TG0_16K		2
@@ -27,4 +29,43 @@
 #define ARM_LPAE_TCR_PS_48_BIT		0x5ULL
 #define ARM_LPAE_TCR_PS_52_BIT		0x6ULL
 
+/* Struct accessors */
+#define io_pgtable_to_data(x)						\
+	container_of((x), struct arm_lpae_io_pgtable, iop)
+
+#define io_pgtable_ops_to_data(x)					\
+	io_pgtable_to_data(io_pgtable_ops_to_pgtable(x))
+
+struct arm_lpae_io_pgtable {
+	struct io_pgtable	iop;
+
+	int			pgd_bits;
+	int			start_level;
+	int			bits_per_level;
+
+	void			*pgd;
+};
+
+#define ARM_LPAE_MAX_ADDR_BITS		52
+#define ARM_LPAE_S2_MAX_CONCAT_PAGES	16
+#define ARM_LPAE_MAX_LEVELS		4
+
+/*
+ * Calculate the right shift amount to get to the portion describing level l
+ * in a virtual address mapped by the pagetable in d.
+ */
+#define ARM_LPAE_LVL_SHIFT(l,d)						\
+	(((ARM_LPAE_MAX_LEVELS - (l)) * (d)->bits_per_level) +		\
+	ilog2(sizeof(arm_lpae_iopte)))
+
+#define ARM_LPAE_GRANULE(d)						\
+	(sizeof(arm_lpae_iopte) << (d)->bits_per_level)
+#define ARM_LPAE_PGD_SIZE(d)						\
+	(sizeof(arm_lpae_iopte) << (d)->pgd_bits)
+
+#define ARM_LPAE_PTES_PER_TABLE(d)					\
+	(ARM_LPAE_GRANULE(d) >> ilog2(sizeof(arm_lpae_iopte)))
+
+typedef u64 arm_lpae_iopte;
+
 #endif /* IO_PGTABLE_ARM_H_ */
-- 
2.51.0.384.g4c02a37b29-goog

