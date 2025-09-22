Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C6C52868B8
	for <iommu@lists.linux.dev>; Mon, 22 Sep 2025 09:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758531612; cv=none; b=jFWKKhi0rxZ/s785U2RPaCwt7hrLXqYe64smwKrTY2lKYRofJ4Jt+uSP55w8NxvXK9R4hzLSClkuF8etmNvR7GMfMXwRtUiQ+T5QIOU3CVkNlkwJf0f9dFD7vsDiXV2BFzQyLFKw0PQU/IKBbu26quYFl8zxOGI6rAB3ASMxRhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758531612; c=relaxed/simple;
	bh=EcV5Ud4O7dddqV6D+cceP3QOprSQAHvyeSV8revOdpQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=g0eI8IFA5DFI8BoHaWdZVpH1g70/L7TRhAPZnDN+fUIs4GGPCoJ/9IMq240iTOSriESQs3YYyN1BzCxU+2FEstPkyIk5yjCg/fgSmUoOIn56viFUPs5h26VV/SuQABjmr/sbVmqTKRMlhm0E/f5XgBCPqJHTDZn866Fw3bDARO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RG8J1ZtP; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RG8J1ZtP"
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-45b986a7b8aso24317245e9.0
        for <iommu@lists.linux.dev>; Mon, 22 Sep 2025 02:00:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758531608; x=1759136408; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=fxsHa5a/TnumwuS8wGt++Dj39uNGV0RG0Oz4S0LjiTY=;
        b=RG8J1ZtPQZW0yc5Fy0hSVI7tJUOoEBzdATudrfuDE8oXPKr3qVcO/1dz8p5vWRb7BU
         XGgoRuLHRae8zDBL1jPUbvrvdVWjLjcTLzO7NPba0BvxdW36NOY4I910Oj2k3ljrsjjK
         66y8Vwl0yX1vSsbO2Zr2er1QBxOnFItFgt3pFZZR3ooV/nzGIeWwKrSuzzSSIic3CgqF
         GrFUxpDyT+1J3IbdFB7DkuutW0wDk/XkKgqiGefOwW6/9Avzu0IvOqIlAQtskAKo9I6q
         2ifnLo4QgoKHTtLXSE1P9h9u/VUek3pakZS9XhV0LnQsr3x/VUR/hbi1iQuyULjiO3y1
         mizQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758531608; x=1759136408;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fxsHa5a/TnumwuS8wGt++Dj39uNGV0RG0Oz4S0LjiTY=;
        b=sfKU38rwks8Lmgb3pRwu/yGD2+afJ0WBOFUCXl4lLPBjmEElMPT9NGZJiV4e4HN+sZ
         ymS5681K3QNCIXU0X3vjtsPqpytIecROoAqybhZf22k5K3Kw5O1XQIzace7hu8gp5xIQ
         MISMuhj4nQQ9W0ASl2EO+Q2euF55hwfpc4I58QIY4ftoKoAnqoye3CLDvxG/RG315hxX
         VQsy6UE8BwGEd/wJe50CbidCqJXYsNxBwO64vq5fZ/vw87WkrXjG4VokfDgyO7CHbPCz
         ADU1rz8mQaaugAYopr7WAyyTl98KPp1Pws00VTrSp0aKk/ZQTRrEJqbF7xOhD9RRBRwE
         VwJA==
X-Gm-Message-State: AOJu0Yw6IIu3sYvFBBC6ZpmNfxxwpuR+TbVYCreHu6uFdLgn1qRNceSe
	rS963kH/p6G8qjJgquRrfpZK71N2aBYmD5q+Ojmj5IOdMEi/NujUH7mbPkPzVz6i1Alr+9WwjiJ
	/hBL3zltsK+7ww8WxRt3iJ9MCJQ199qe2JJ2OTUUupEPl+qjb5ONBOoD/XoPulP6g/os4YkeX/n
	H0Ydgd9EZCt+QYp4kIEEo+4uNXSwWPY2LSsc7zOOD4c07Rwg==
X-Google-Smtp-Source: AGHT+IHget1O4BPqdwANeAahSQkK78lrpcEF2/nHFiBWfVpUCmbTfdZneqa7756vBxWSeKVk9F/QEVfsPjcQ4A==
X-Received: from wmcn18-n1.prod.google.com ([2002:a05:600c:c0d2:10b0:45b:7262:8426])
 (user=smostafa job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:5491:b0:45d:d5df:ab39 with SMTP id 5b1f17b1804b1-467f2cc83afmr101921075e9.26.1758531608493;
 Mon, 22 Sep 2025 02:00:08 -0700 (PDT)
Date: Mon, 22 Sep 2025 08:59:27 +0000
In-Reply-To: <20250922090003.686704-1-smostafa@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250922090003.686704-1-smostafa@google.com>
X-Mailer: git-send-email 2.51.0.534.gc79095c0ca-goog
Message-ID: <20250922090003.686704-4-smostafa@google.com>
Subject: [PATCH v4 3/4] iommu/io-pgtable-arm-selftests: Modularize the test
From: Mostafa Saleh <smostafa@google.com>
To: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Cc: robin.murphy@arm.com, will@kernel.org, joro@8bytes.org, jgg@ziepe.ca, 
	praan@google.com, Mostafa Saleh <smostafa@google.com>, Jason Gunthorpe <jgg@nvidia.com>
Content-Type: text/plain; charset="UTF-8"

Remove the __init constraint, as the test will be converted to KUnit,
it can run on-demand after later.

Also, as KUnit can be a module, make this test modular.

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
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
index 17f48216647c..50350e88d9b4 100644
--- a/drivers/iommu/io-pgtable-arm-selftests.c
+++ b/drivers/iommu/io-pgtable-arm-selftests.c
@@ -13,34 +13,34 @@
 
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
 	struct io_pgtable_cfg *cfg = &io_pgtable_ops_to_pgtable(ops)->cfg;
 
@@ -54,9 +54,9 @@ static void __init arm_lpae_dump_ops(struct io_pgtable_ops *ops)
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
@@ -157,15 +157,15 @@ static int __init arm_lpae_run_tests(struct io_pgtable_cfg *cfg)
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
 
@@ -205,4 +205,12 @@ static int __init arm_lpae_do_selftests(void)
 
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
2.51.0.534.gc79095c0ca-goog

