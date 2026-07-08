Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EA4B3AB29B
	for <iommu@lists.linux.dev>; Wed,  8 Jul 2026 23:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783554551; cv=none; b=AaWlwh5CqJ24Ib3wmPxMnF++4i13araceLc2Oxk9G1FHEE0tXpppkEQX0kpK305GRgwxznpwg3gHvXBlmhSFlNWKPqMkBOML5wVPwUbZFZQSWHrqXllRdgvDGMGZoRngfcM+dCBFyDWby9X46lisT8xiL/OT9TnuMaN9fzgSa+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783554551; c=relaxed/simple;
	bh=xvmVHa4hCcznKkcyaXYan04H3jeN72BcslQLFo9Drrg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=NvY6o4zyf44+plKeHrLPz10whwIP/rtNmMurtVGOfYvgvpnRrzQWsZ0kwBlRCJD6jFylOX84taVuq8ZwCm+AXhkAqE+FOAk0RPb4ZseXhxfbSVk/I2OZnEpcRT/NlKrRDV9Q95gB19Q85sNlWqXB5HJXkKMLxmsUTglPfZ7Kv9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=v4lucM37; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="v4lucM37"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2ca5d2474c7so35813685ad.2
        for <iommu@lists.linux.dev>; Wed, 08 Jul 2026 16:49:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783554544; x=1784159344; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KvwcKqkHQyZ2uoR9E1ljTn+X3nC24ulgVhMt0Kon6RQ=;
        b=v4lucM371X3Be9rGGptpw41ma2vW42FFQQdQpSkwGQYqNtrqQBnpZx+KETudtgh3H1
         cu5ZTFxS4WrZibtyI8SxDIGcr0bQML/axHxdpIBy2RT8fcX33HbSd7JNwYtkFIeyhcZX
         jNZj7+OdcBv1OiXjL8D1SQsdIe9/3MgMFHItcae1WR7uHxhcOsJ7MiRwUazVCrkCbwEg
         9up4pbVxYDQHpRr4uwQt858F7ThsXG9JiUsgKAYTXW+p7g0jaX3Mxa6QpIMAr9Qk8Xsy
         Q+u5sPIhW6lSZifuSUSFhVt6OU1yCoZn0M6Ow58RT4Em8j+1D/oM4HelQ5DDPENMr+QS
         f6iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783554544; x=1784159344;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KvwcKqkHQyZ2uoR9E1ljTn+X3nC24ulgVhMt0Kon6RQ=;
        b=n3Pc/NkrHO+CoucjsRY+AaVk2sx/mwFyeUXs5vqvtXljL4TXf59dLm4kFeYuWgdLkX
         htd2gYMr3YddZF2teTZOY0hTimPx8WF9/p2PoR61MIH1WIO7Ujsxr6inkiTB6dpuG+mx
         c8vocXlamw5CUssbTIkWEkZELTGRVdBXJ0uPaDn/5rht70l0Cq69mNU03GIZPzXSkSEX
         58/yk6S2MtfMCBbcF/SvrJlXtCMpJZnwG8rP8I8jzYHh9SRFWZAHAoibWkylSfTTAhFi
         NWc2Zn8CnFE4QCuFqDUvm7Di2m0gSxND5YWs0lSSM9lFxvFsLFUdLR+6Iwefxqspm6Nz
         bDuw==
X-Forwarded-Encrypted: i=1; AHgh+RokSrgLo0ZFgP/RtI8FsKlt9+5LrDGVy0rgXA0rHc1ghXFQTpjSHzuY50+rTZ7lt/9qoX5gxA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxDDUq60Awi7T0ESqV/a9J7y1ZUkGLhlWfzdDbyBgfD6PxQTV4J
	Kice7y66+0bONbePafCWd14WPfIF0PgMVGRH9X6IHUIzfYKdJh2pOV4OpsR4L6RC0/xsLTKvbYO
	0aprlAqZiF+MkGg==
X-Received: from pgh2.prod.google.com ([2002:a05:6a02:4e02:b0:c93:e04b:d9ad])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:9191:b0:3bf:6c08:284d with SMTP id adf61e73a8af0-3c0bd294eb5mr5386341637.60.1783554543571;
 Wed, 08 Jul 2026 16:49:03 -0700 (PDT)
Date: Wed,  8 Jul 2026 23:48:54 +0000
In-Reply-To: <20260708234854.4044652-1-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260708234854.4044652-1-skhawaja@google.com>
X-Mailer: git-send-email 2.55.0.795.g602f6c329a-goog
Message-ID: <20260708234854.4044652-11-skhawaja@google.com>
Subject: [RFC PATCH v2 10/10] dma-direct: Add KUnit test for liveupdate preservation
From: Samiullah Khawaja <skhawaja@google.com>
To: Marek Szyprowski <m.szyprowski@samsung.com>, Will Deacon <will@kernel.org>, 
	Jason Gunthorpe <jgg@ziepe.ca>
Cc: Samiullah Khawaja <skhawaja@google.com>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Mike Rapoport <rppt@kernel.org>, Pratyush Yadav <pratyush@kernel.org>, Alexander Graf <graf@amazon.com>, 
	Robin Murphy <robin.murphy@arm.com>, Kevin Tian <kevin.tian@intel.com>, iommu@lists.linux.dev, 
	kexec@lists.infradead.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	David Matlack <dmatlack@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Pranjal Shrivastava <praan@google.com>, Vipin Sharma <vipinsh@google.com>
Content-Type: text/plain; charset="UTF-8"

Use the KHO kunit stubs to mock the KHO preserve/unpreserve/restore API
and tests the preservation of DMA allocations with,

- Device being coherent or non-coherent.
- Atomic or non-atomic context.
- Various allocation sizes.
- Managed DMA allocations

Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
---
 kernel/dma/Kconfig       |   8 ++
 kernel/dma/Makefile      |   1 +
 kernel/dma/direct_test.c | 208 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 217 insertions(+)
 create mode 100644 kernel/dma/direct_test.c

diff --git a/kernel/dma/Kconfig b/kernel/dma/Kconfig
index d93958931303..48bc74af551a 100644
--- a/kernel/dma/Kconfig
+++ b/kernel/dma/Kconfig
@@ -269,3 +269,11 @@ config DMA_MAP_BENCHMARK
 config DMA_LIVEUPDATE
 	bool "Enable preservation of DMA direct allocations"
 	depends on LIVEUPDATE
+
+config DMA_LIVEUPDATE_KUNIT_TEST
+	tristate "KUnit test for DMA direct liveupdate preservation"
+	depends on KUNIT
+	depends on DMA_LIVEUPDATE
+	help
+	  This builds the KUnit tests for the DMA direct liveupdate
+	  preservation and restoration logic.
diff --git a/kernel/dma/Makefile b/kernel/dma/Makefile
index 6977033444a3..03703542ee79 100644
--- a/kernel/dma/Makefile
+++ b/kernel/dma/Makefile
@@ -10,3 +10,4 @@ obj-$(CONFIG_SWIOTLB)			+= swiotlb.o
 obj-$(CONFIG_DMA_COHERENT_POOL)		+= pool.o
 obj-$(CONFIG_MMU)			+= remap.o
 obj-$(CONFIG_DMA_MAP_BENCHMARK)		+= map_benchmark.o
+obj-$(CONFIG_DMA_LIVEUPDATE_KUNIT_TEST)	+= direct_test.o
diff --git a/kernel/dma/direct_test.c b/kernel/dma/direct_test.c
new file mode 100644
index 000000000000..f8403ec47807
--- /dev/null
+++ b/kernel/dma/direct_test.c
@@ -0,0 +1,208 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * KUnit test for DMA allocation live update preservation.
+ */
+
+#include <kunit/test.h>
+#include <linux/module.h>
+#include <kunit/static_stub.h>
+#include <linux/dma-map-ops.h>
+#include <linux/dma-mapping.h>
+#include <linux/dma-direct.h>
+#include <linux/kho/abi/dma_alloc.h>
+#include <linux/kexec_handover.h>
+#include <linux/slab.h>
+
+static const size_t dma_test_sizes[] = {
+	128,
+	PAGE_SIZE,
+	2 * PAGE_SIZE,
+	3 * PAGE_SIZE,
+	8 * PAGE_SIZE,
+};
+
+static void dma_size_desc(const size_t *size, char *desc)
+{
+	snprintf(desc, KUNIT_PARAM_DESC_SIZE, "size=%zu", *size);
+}
+
+KUNIT_ARRAY_PARAM(dma_size, dma_test_sizes, dma_size_desc);
+
+static struct page *mock_kho_restore_pages(phys_addr_t phys, unsigned long nr_pages)
+{
+	struct page *page = phys_to_page(phys);
+
+	if (!kho_test_pages_preserved(phys, nr_pages))
+		return NULL;
+
+	kho_unpreserve_pages(page, nr_pages);
+	return page;
+}
+
+static struct folio *mock_kho_restore_folio(phys_addr_t phys)
+{
+	struct folio *folio = page_folio(phys_to_page(phys));
+
+	if (!kho_test_pages_preserved(phys, (1 << folio_order(folio))))
+		return NULL;
+
+	kho_unpreserve_folio(folio);
+	return folio;
+}
+
+static void test_dma_direct_preserve_restore_common(struct kunit *test,
+						    bool coherent,
+						    bool atomic,
+						    size_t size)
+{
+	unsigned long nr_pages = 1 << get_order(size);
+	dma_addr_t handle1, handle2;
+	int ret, expected_ret = 0;
+	struct device dev = {0};
+	gfp_t gfp = GFP_KERNEL;
+	void *addr1, *addr2;
+	u64 state;
+
+	kunit_activate_static_stub(test, kho_restore_pages, mock_kho_restore_pages);
+	kunit_activate_static_stub(test, kho_restore_folio, mock_kho_restore_folio);
+
+	device_initialize(&dev);
+	dev.coherent_dma_mask = DMA_BIT_MASK(64);
+	dev.dma_mask = &dev.coherent_dma_mask;
+#if defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_DEVICE) || \
+    defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_CPU) || \
+    defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_CPU_ALL)
+	dev.dma_coherent = coherent;
+#endif
+
+	if (atomic)
+		gfp = GFP_ATOMIC;
+
+	addr1 = dma_alloc_coherent(&dev, size, &handle1, gfp);
+	if (!addr1) {
+		kunit_skip(test, "DMA allocation failed (unsupported configuration)");
+		return;
+	}
+
+	if (IS_ENABLED(CONFIG_DMA_COHERENT_POOL) && dma_is_from_pool(addr1, size)) {
+		expected_ret = -EOPNOTSUPP;
+		kunit_info(test, "DMA allocation using pool, expecting -EOPNOTSUPP");
+	} else if (dma_is_from_cma(dma_to_phys(&dev, handle1), size)) {
+		expected_ret = -EOPNOTSUPP;
+		kunit_info(test, "DMA allocation using CMA, expecting -EOPNOTSUPP");
+	}
+
+	ret = dma_preserve_coherent_allocation(&dev, addr1, size, handle1, &state);
+	KUNIT_ASSERT_EQ(test, ret, expected_ret);
+
+	if (!expected_ret) {
+		KUNIT_EXPECT_TRUE_MSG(test,
+				      kho_test_pages_preserved(dma_to_phys(&dev, handle1), nr_pages),
+				      "Allocated block not tracked in KHO");
+
+		addr2 = dma_restore_coherent_allocation(&dev, size, &handle2, gfp, state);
+		KUNIT_ASSERT_NOT_NULL(test, addr2);
+
+		KUNIT_EXPECT_EQ(test, handle1, handle2);
+		dma_free_coherent(&dev, size, addr2, handle2);
+		KUNIT_EXPECT_FALSE_MSG(test,
+				       kho_test_pages_preserved(dma_to_phys(&dev, handle1), nr_pages),
+				       "Allocated block still tracked after free");
+	} else {
+		dma_free_coherent(&dev, size, addr1, handle1);
+	}
+}
+
+static void test_dma_direct_coherent(struct kunit *test)
+{
+	const size_t *size = test->param_value;
+
+	test_dma_direct_preserve_restore_common(test, true, false, *size);
+}
+
+static void test_dma_direct_non_coherent(struct kunit *test)
+{
+	const size_t *size = test->param_value;
+
+	test_dma_direct_preserve_restore_common(test, false, false, *size);
+}
+
+static void test_dma_direct_coherent_atomic(struct kunit *test)
+{
+	const size_t *size = test->param_value;
+
+	test_dma_direct_preserve_restore_common(test, true, true, *size);
+}
+
+static void test_dma_direct_non_coherent_atomic(struct kunit *test)
+{
+	const size_t *size = test->param_value;
+
+	test_dma_direct_preserve_restore_common(test, false, true, *size);
+}
+
+static void test_dmam_preservation(struct kunit *test)
+{
+	dma_addr_t handle, non_dmam_handle;
+	void *addr, *non_dmam_addr;
+	struct device dev = {0};
+	size_t size = 128;
+	u64 state;
+	int ret;
+
+	kunit_activate_static_stub(test, kho_restore_pages, mock_kho_restore_pages);
+	kunit_activate_static_stub(test, kho_restore_folio, mock_kho_restore_folio);
+
+	device_initialize(&dev);
+	dev.coherent_dma_mask = DMA_BIT_MASK(64);
+	dev.dma_mask = &dev.coherent_dma_mask;
+#if defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_DEVICE) || \
+    defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_CPU) || \
+    defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_CPU_ALL)
+	dev.dma_coherent = true;
+#endif
+
+	non_dmam_addr = dma_alloc_coherent(&dev, size, &non_dmam_handle, GFP_KERNEL);
+	if (!non_dmam_addr) {
+		kunit_skip(test, "DMA allocation failed");
+		return;
+	}
+
+	ret = dmam_preserve_coherent_allocation(&dev, non_dmam_addr, size, non_dmam_handle, &state);
+	KUNIT_EXPECT_EQ_MSG(test, ret, -EINVAL, "Preserving non-devres allocation should fail");
+	dma_free_coherent(&dev, size, non_dmam_addr, non_dmam_handle);
+
+	addr = dmam_alloc_coherent(&dev, size, &handle, GFP_KERNEL);
+	if (!addr) {
+		kunit_skip(test, "DMA allocation failed");
+		return;
+	}
+
+	ret = dmam_preserve_coherent_allocation(&dev, addr, size, handle, &state);
+	KUNIT_ASSERT_EQ_MSG(test, ret, 0, "Failed to preserve dmam allocation");
+	KUNIT_EXPECT_TRUE(test, kho_test_pages_preserved(dma_to_phys(&dev, handle), 1));
+
+	dmam_unpreserve_coherent_allocation(&dev, addr, size, handle, state);
+	KUNIT_EXPECT_FALSE(test, kho_test_pages_preserved(dma_to_phys(&dev, handle), 1));
+
+	dmam_free_coherent(&dev, size, addr, handle);
+}
+
+static struct kunit_case dma_direct_test_cases[] = {
+	KUNIT_CASE_PARAM(test_dma_direct_coherent, dma_size_gen_params),
+	KUNIT_CASE_PARAM(test_dma_direct_non_coherent, dma_size_gen_params),
+	KUNIT_CASE_PARAM(test_dma_direct_coherent_atomic, dma_size_gen_params),
+	KUNIT_CASE_PARAM(test_dma_direct_non_coherent_atomic, dma_size_gen_params),
+	KUNIT_CASE(test_dmam_preservation),
+	{}
+};
+
+static struct kunit_suite dma_direct_test_suite = {
+	.name = "dma_direct_liveupdate",
+	.test_cases = dma_direct_test_cases,
+};
+kunit_test_suite(dma_direct_test_suite);
+
+MODULE_IMPORT_NS("EXPORTED_FOR_KUNIT_TESTING");
+MODULE_DESCRIPTION("KUnit test for DMA direct live update preservation");
+MODULE_LICENSE("GPL");
-- 
2.55.0.795.g602f6c329a-goog

