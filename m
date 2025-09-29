Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7027230C101
	for <iommu@lists.linux.dev>; Mon, 29 Sep 2025 15:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759161014; cv=none; b=lh/tLRCq5tS5rN4pKXqLCIan810xl8VaURCvkFL1jcNN4IdGGuddIHT/iIBcra71ZkcvdwsfcPtya1Mm9iBqdnzx5pTNIObKOyEzgwcNGiMzLUf5+F+OqVb4nYIWb4ns55bVPbr8AqPDs5kgZmY1ft0spRKayJTehu83opBXRyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759161014; c=relaxed/simple;
	bh=TL4oPh6meYp0II69UhIyt5mu/R9VyyO3WgVP9oaFG1Q=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Mm/vcJXDF3dgAF22BHa99cinw34C/1+Qv1eIW+PrBq2ZXnbdw12fcv2BXLc75fLBbjtmXbpsADDjdCG4OUY3oIq/139MyWZ1GoWsJwMfLiup6I1ihudXweLqjqALz+a9LrxCY8Yzi5t6ghY8SwQbbpNozwWbHte3C7qO48I7n7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ya+4ImBL; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ya+4ImBL"
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-46e36686ca1so37046565e9.2
        for <iommu@lists.linux.dev>; Mon, 29 Sep 2025 08:50:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759161011; x=1759765811; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=NJHC5+QTP14fX//LZe/mxMEbJxRo0xwg0ar5poMq1uA=;
        b=Ya+4ImBL5BoET/N0OCG24eTOdTkjewBdDaf3e2Xl5Ql/zqJ/0Dudq0yDOIEL/RqwsP
         MV1FpS1FDKtBg7IBjjz52hFgdxP+r5Jso2FaL8RSeOElWxEd/b0/lsFjEmADbWnsp4y1
         LAmkmWDnjrme0sKRtPxsJJxExbbaG6sBNgoqnC6aaUg9SqQUmTt8jVvTWJZ2z9ObtrXp
         zrBJ23i8i4zIvBceJBt+cUz6G+6kG+4ab8oXrqugfRt0QAbN+ru5Lq8C8AJsrtINrZ1v
         t1vSxN5bDUEzO2GknpXf4cWmJ6G4+W0KBBcK4JqQ+1YPeufHV32CANYT/GfniMx5ZTAQ
         KbXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759161011; x=1759765811;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NJHC5+QTP14fX//LZe/mxMEbJxRo0xwg0ar5poMq1uA=;
        b=APnxEYkHnkY+qq92rF8n7fanIYCTTTljhUYArpsgwScsjy9CdOYFIWfIQicHdSO5mK
         SHA6mlRLidlqWOH2W3gREwN2s5PdwXQRLtV8uT/ss3z3KdG+ZvZ+vAdscFg0v27uJbV2
         8bMbyIEggUKVIpgWmPlHsb0mjCf3iT5h5p1s4iTgby8O9u/kQadcGEwGE7Aret8sSU1U
         iJEJpgEhFK7jrKTKEMhzvRzfgkqSn9oKNbG8f6xe97GRSpB4dfhoq4gpqgT9FYOjcqou
         wNtk+xdFPJD4c+Ez9JHvwIM2XQcdXCtH6QM1rAKStirHUN4zxb6mYaDCDe48DSp6EKbo
         zGgw==
X-Gm-Message-State: AOJu0Yy6r7UQyGapRZBpw/aqFh1lLOkBvKU8lhX0GV2EfZdEKaN2FSEr
	E8Zs92s4/67sKphHkHBHvyWagKF34TE4FW77rBInSfZkC1bIV8UFgjjdzJ9OHesat4xhFuLMI+F
	7sne7ADkRnb99VrYLqZ9N4QzrB2CKRLspt3bvoDOFH1a8PvJ9vEazYUmZBJFzaI8vTjDsC377YQ
	Bf1zvlb6erj0E0oHTClErfEaTpe66qhl3INNkznAcESrqGAw==
X-Google-Smtp-Source: AGHT+IGJdB4UkTz6NAZVLYJ2/soJK1B0n31V38CHkgl+oXUofMABzkVMr26Gvt6jH1taH1deIPwoc1q3Va7b8Q==
X-Received: from wmv18.prod.google.com ([2002:a05:600c:26d2:b0:46e:37a7:48c1])
 (user=smostafa job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:444d:b0:45b:7a93:f108 with SMTP id 5b1f17b1804b1-46e3299a5b5mr158005385e9.3.1759161010656;
 Mon, 29 Sep 2025 08:50:10 -0700 (PDT)
Date: Mon, 29 Sep 2025 15:49:58 +0000
In-Reply-To: <20250929155001.3287719-1-smostafa@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250929155001.3287719-1-smostafa@google.com>
X-Mailer: git-send-email 2.51.0.536.g15c5d4f767-goog
Message-ID: <20250929155001.3287719-4-smostafa@google.com>
Subject: [PATCH v5 3/4] iommu/io-pgtable-arm-selftests: Modularize the test
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
Reviewed-by: Pranjal Shrivastava <praan@google.com>
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
index 6ee5329c06c2..32c6a5c7af53 100644
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
 	struct io_pgtable_cfg *cfg = &io_pgtable_ops_to_pgtable(ops)->cfg;
 
@@ -53,9 +53,9 @@ static void __init arm_lpae_dump_ops(struct io_pgtable_ops *ops)
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
@@ -156,15 +156,15 @@ static int __init arm_lpae_run_tests(struct io_pgtable_cfg *cfg)
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
 
@@ -204,4 +204,12 @@ static int __init arm_lpae_do_selftests(void)
 
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
2.51.0.536.g15c5d4f767-goog

