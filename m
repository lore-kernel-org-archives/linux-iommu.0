Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10D5B3002DC
	for <iommu@lists.linux.dev>; Wed, 17 Sep 2025 19:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758136318; cv=none; b=oiYMPw3SXejSOliQdcT/1jl2Inm2W0q1YK5CvKO6nZYX90u/K3dq3iJOqLAWdBQjGui5c9eNH8Cn3KChGtGP5gCiwdWOg06BJ5k8Ulm3u8ur0kltyAYg0B9Efj9+S53+BPCAqRTGjkRX9u2PoHYEqO/8jkDocYkcS2s2SWXqnAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758136318; c=relaxed/simple;
	bh=OXNC2NhJUIJ9sBeSJ2n+PhGJZrxOs7RFB/5bSZ9yPWw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=N+sQIut9NwAVBrxOnEA31w6XuuwkyFP7rNYXSPaGeFIiQZkPmxeuGs45SuwLbljIbdLigib4Mx2dNmbhVzSmjYT2jjjm3SBj6vvPzioI5Mk6cJuJCNcYWwyL41dk5swAQenzSJfcSGYDnmN4LA0e9Gcp/vTG+lRDjV/JZGLLoi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lYqiS+ps; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lYqiS+ps"
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-45b98de0e34so1314135e9.0
        for <iommu@lists.linux.dev>; Wed, 17 Sep 2025 12:11:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758136315; x=1758741115; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=/5kKzg8OPO0Cw4eskhZqcihDqdYuLltlJ6a6ZgtbvOg=;
        b=lYqiS+pssJkvBvxrDch91zpzsRolWxD/hLfum7/SgNWX1IwLjzmlfsoHhdJB0fOnzN
         D/Dx5xZdAcUUTq0MzXct3rKwH5DAcmFGQdGS0kbsAWWWi6ddWBBejwJV2tpONkR7FBBM
         os4KHPNsvJyTxbfE1qMUYpdkri/VYmSF6OnlOFYAJB2i/d09U9QaT5MNShau5Fn46wfd
         xqqLBy9fKnKDg2JJ+vMI82BUIOzI+QNVbquUxwlWoEPqU8q60K+QBp2q6PlK90vT9Di9
         0soKuYdWbulPFNGVkq9AETzrj2cm3dnecpKLnOrFKZdbvPKefjAEXMEUXPP2K7KDZNAs
         k+Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758136315; x=1758741115;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/5kKzg8OPO0Cw4eskhZqcihDqdYuLltlJ6a6ZgtbvOg=;
        b=WbN0Myiad3hAtmCzv8aA3VkvLpmUg74sFUG0hqKV/TK55I1y3W4zUfbCHpMXVtC79g
         AdHLnG/e62GyQVEBPzk9GZsrq3YVMWqEPFhh6M1pjWX51jSAVZBZDxBjktM5bfyA9tPQ
         zrCtgMQqo36dZ+ZKJjZdeY+wYz4Ack2DVkvzmUSGcf62vMuQzfzZRH6m+AEhWxqFMR+3
         AIq+08xP8aJjIVX6ZF3OZ/E7h+qzXd+fBj2tdNirBu2aWkVy/wlwf1lK1wd3kQ6vCPPX
         MAf4K3uQ2HYNzgOkAWoEjwHSDKUP5zWjMtSGlvqea9nzpyq9oW1a82jK2Otg7cgxmvW9
         AxVA==
X-Gm-Message-State: AOJu0YzPxJEukOylSzbHf9FesQyQJyRBOMO3frNvEyDWQvuoHxbQieMB
	bYttJyP4/6QVLWT53fApSghB01jTLlKXybybli+xRJ0zTqSMnPZmdT/WCmSQ2F2xxzCSaHRlbWw
	sSkYVzdJE/gk1XvuE6nWMnOWUypYH+0Qd13TqwvaPIyzxkNOCZWlsOqrk+r6VvdKIEsHUr5Zche
	gv/TiFsd3cEz2scyHHq2wURwRnp5GPUg7Io6/g4ahKHWk8UQ==
X-Google-Smtp-Source: AGHT+IFOU7LN1P9SI2vg/wWZstNB2r3hO1DClo1GN39AeEZT7OFuBcSCZpdcfIdpWCtlY2IVLQVavjRwLe6APw==
X-Received: from wmbbi16.prod.google.com ([2002:a05:600c:3d90:b0:45b:7fa6:f2ef])
 (user=smostafa job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:42c1:b0:45c:b6fa:352e with SMTP id 5b1f17b1804b1-462d4ca0573mr19699685e9.18.1758136315274;
 Wed, 17 Sep 2025 12:11:55 -0700 (PDT)
Date: Wed, 17 Sep 2025 19:11:39 +0000
In-Reply-To: <20250917191143.3847487-1-smostafa@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250917191143.3847487-1-smostafa@google.com>
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
Message-ID: <20250917191143.3847487-3-smostafa@google.com>
Subject: [PATCH v2 2/3] iommu/io-pgtable-arm-selftests: Modularize the test
From: Mostafa Saleh <smostafa@google.com>
To: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Cc: robin.murphy@arm.com, will@kernel.org, joro@8bytes.org, jgg@ziepe.ca, 
	praan@google.com, Mostafa Saleh <smostafa@google.com>
Content-Type: text/plain; charset="UTF-8"

Remove the __init constraint, as the test will be converted to KUnit,
it can run on-demand after later.

Also, as KUnit can be a module, make this test modular.

Signed-off-by: Mostafa Saleh <smostafa@google.com>
---
 drivers/iommu/Kconfig                    |  2 +-
 drivers/iommu/io-pgtable-arm-selftests.c | 36 +++++++++++++++---------
 2 files changed, 23 insertions(+), 15 deletions(-)

diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index 70d29b14d851..553522ef3ca9 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -41,7 +41,7 @@ config IOMMU_IO_PGTABLE_LPAE
 	  up to 48-bits in size.
 
 config IOMMU_IO_PGTABLE_LPAE_SELFTEST
-	bool "LPAE selftests"
+	tristate "LPAE selftests"
 	depends on IOMMU_IO_PGTABLE_LPAE
 	help
 	  Enable self-tests for LPAE page table allocator. This performs
diff --git a/drivers/iommu/io-pgtable-arm-selftests.c b/drivers/iommu/io-pgtable-arm-selftests.c
index f7746ff2c7a0..5ac3e792c56d 100644
--- a/drivers/iommu/io-pgtable-arm-selftests.c
+++ b/drivers/iommu/io-pgtable-arm-selftests.c
@@ -12,34 +12,34 @@
 
 #include "io-pgtable-arm.h"
 
-static struct io_pgtable_cfg *cfg_cookie __initdata;
+static struct io_pgtable_cfg *cfg_cookie;
 
-static void __init dummy_tlb_flush_all(void *cookie)
+static void dummy_tlb_flush_all(void *cookie)
 {
 	WARN_ON(cookie != cfg_cookie);
 }
 
-static void __init dummy_tlb_flush(unsigned long iova, size_t size,
-				   size_t granule, void *cookie)
+static void dummy_tlb_flush(unsigned long iova, size_t size,
+			    size_t granule, void *cookie)
 {
 	WARN_ON(cookie != cfg_cookie);
 	WARN_ON(!(size & cfg_cookie->pgsize_bitmap));
 }
 
-static void __init dummy_tlb_add_page(struct iommu_iotlb_gather *gather,
-				      unsigned long iova, size_t granule,
-				      void *cookie)
+static void dummy_tlb_add_page(struct iommu_iotlb_gather *gather,
+			       unsigned long iova, size_t granule,
+			       void *cookie)
 {
 	dummy_tlb_flush(iova, granule, granule, cookie);
 }
 
-static const struct iommu_flush_ops dummy_tlb_ops __initconst = {
+static const struct iommu_flush_ops dummy_tlb_ops = {
 	.tlb_flush_all	= dummy_tlb_flush_all,
 	.tlb_flush_walk	= dummy_tlb_flush,
 	.tlb_add_page	= dummy_tlb_add_page,
 };
 
-static void __init arm_lpae_dump_ops(struct io_pgtable_ops *ops)
+static void arm_lpae_dump_ops(struct io_pgtable_ops *ops)
 {
 	struct arm_lpae_io_pgtable *data = io_pgtable_ops_to_data(ops);
 	struct io_pgtable_cfg *cfg = &data->iop.cfg;
@@ -57,9 +57,9 @@ static void __init arm_lpae_dump_ops(struct io_pgtable_ops *ops)
 		-EFAULT;						\
 })
 
-static int __init arm_lpae_run_tests(struct io_pgtable_cfg *cfg)
+static int arm_lpae_run_tests(struct io_pgtable_cfg *cfg)
 {
-	static const enum io_pgtable_fmt fmts[] __initconst = {
+	static const enum io_pgtable_fmt fmts[] = {
 		ARM_64_LPAE_S1,
 		ARM_64_LPAE_S2,
 	};
@@ -160,15 +160,15 @@ static int __init arm_lpae_run_tests(struct io_pgtable_cfg *cfg)
 	return 0;
 }
 
-static int __init arm_lpae_do_selftests(void)
+static int arm_lpae_do_selftests(void)
 {
-	static const unsigned long pgsize[] __initconst = {
+	static const unsigned long pgsize[] = {
 		SZ_4K | SZ_2M | SZ_1G,
 		SZ_16K | SZ_32M,
 		SZ_64K | SZ_512M,
 	};
 
-	static const unsigned int address_size[] __initconst = {
+	static const unsigned int address_size[] = {
 		32, 36, 40, 42, 44, 48,
 	};
 
@@ -208,4 +208,12 @@ static int __init arm_lpae_do_selftests(void)
 
 	return fail ? -EFAULT : 0;
 }
+
+static void arm_lpae_exit_selftests(void)
+{
+}
+
 subsys_initcall(arm_lpae_do_selftests);
+module_exit(arm_lpae_exit_selftests);
+MODULE_DESCRIPTION("io-pgtable-arm library selftest");
+MODULE_LICENSE("GPL");
-- 
2.51.0.384.g4c02a37b29-goog

