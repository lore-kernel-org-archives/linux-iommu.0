Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6BF630F954
	for <iommu@lists.linux.dev>; Fri, 19 Sep 2025 13:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758288806; cv=none; b=QfEFLBu2JLOxYNzXmaldzbfez2QZV75s6NGcebDnc5NY96xwCkGtd948d+755dMkaGCPFqDKGqjhwi8+Z93n2/2Kyhk69/qBkwtA1Gu545j4G5akltdX+LycswMDWwvKs/0olyU4g06WoYAPore7KaS3ltvQ44yzRLjVphBBfsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758288806; c=relaxed/simple;
	bh=7oXYl5Po4AjfBd/5rYjBxuYp+0gnhDH956S33u0vZDA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qBgCdgJUN6kVjKUBZlCVt0R5OXCDWCY9KAIN4uWfe8mZKviK8M9Shyc83QQevpFVCMiLiO4tRvD2LODc1jKHJMlwASckTnuu3MfLw9Gjy4WQl+qwOeIE57cHMXOFcRx9QnKUW5ZJ7I4Tm6y+SA7t6xS758E9+m2qRJS1I25BJ20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CDDHwTP6; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CDDHwTP6"
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-45f28552927so17257915e9.2
        for <iommu@lists.linux.dev>; Fri, 19 Sep 2025 06:33:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758288803; x=1758893603; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=v+B9Rd0QSKX3f0a8GqzDwyxDt6n7MbipsBAu2cM0NNI=;
        b=CDDHwTP65TjolUjsOOsUkhfuTAATo8uUw9w0An8DV4kao7B2xoQg8Q4QuDQXh8KxS+
         J7euJwxqoZ8P+k5XbIk0aIqB5pRBAK/AbpX7Ri+y4KO4gTXkyXejTdtQtTlSUu4wffUG
         fcwvzpvbNQy2MeUgon2uhgXe0NiZWQHqxZp5CqH7zyslIInPBNI+C9U0pkGJ7OkHcvmf
         PW2sT+W/J/XaMkL/q2xE+D+ceEAbSCC7Vp/jgAALPAciAfjuU6SneIga4jFfK/vK1tXN
         fi885khwKJRkKPJaKYSHdD47tJqQM69OiE/YevGEFaYgt8dbKYGaGK2zhMMX88agI7iG
         cXhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758288803; x=1758893603;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v+B9Rd0QSKX3f0a8GqzDwyxDt6n7MbipsBAu2cM0NNI=;
        b=v+OamnfPPEE4Y4Yz8DvkJOczUzjNAI6rQTqp2S3dZT5g4kGudNPCNJW6Sp+i3Ptk/e
         piirHrLyN2jfEROzByuJSC48WEj5qL1Ce10z4rQEB61SAzGX0Gdc3yGTIfm5YNogOdbZ
         E7zhAL1W1egp9Uh8bepc2fBJuOlvkrNSKhQvupBlXF2wuyegTsYiuCV7s3IG+2R2aeKn
         2TmMi5LGBqo0UegAYKkMrbNLHYo+s6d61rTzxcIlr/Xk+XAYffMTlOtYDia4AlYbpcB5
         f+TADg63ujnKG2prODmWu8UEgDUERd0Chmco3Iy81sniedpee9J5BRbot+hOExJPHNpd
         Q7bw==
X-Gm-Message-State: AOJu0YxQ1P1ePh+WalkrkMpEgvvhQIAXKY4XR7AV1Yxa6E+jq9NYDcu6
	I77XYBAixfJmoKYiv2umRCNP4Wjq7ZcUDOfvtnFtXXl3uwPFj24JI5KO8eZZIjDkBgnhy4gNs5B
	7BVeZrv3C/6J7ozLrAV66RkhRO2dXH2tg4qE5NKaWwpE6wHr6/MdUUsR5ZXoI5uHHf17sSpkzEO
	BbKovzhNLiloeKURR3PtkoPqzIyDbZZi/SD7Ld2eSdstwXPg==
X-Google-Smtp-Source: AGHT+IHgv9Oc1Q90zGIOvBR/gtnADwG6axckvKn1MbwYC6fQkHZhHVTfgauS5SWZ9dYzPTFs0YjJunsuQ96/hQ==
X-Received: from wmbeq6.prod.google.com ([2002:a05:600c:8486:b0:45d:e59b:2eb0])
 (user=smostafa job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:3595:b0:458:bf0a:6061 with SMTP id 5b1f17b1804b1-467f00c5fd6mr42464245e9.24.1758288803025;
 Fri, 19 Sep 2025 06:33:23 -0700 (PDT)
Date: Fri, 19 Sep 2025 13:33:12 +0000
In-Reply-To: <20250919133316.2741279-1-smostafa@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250919133316.2741279-1-smostafa@google.com>
X-Mailer: git-send-email 2.51.0.534.gc79095c0ca-goog
Message-ID: <20250919133316.2741279-4-smostafa@google.com>
Subject: [PATCH v3 3/4] iommu/io-pgtable-arm-selftests: Modularize the test
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
 drivers/iommu/io-pgtable-arm-selftests.c | 34 +++++++++++++++---------
 2 files changed, 22 insertions(+), 14 deletions(-)

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
index 17f48216647c..4c3dee4ba895 100644
--- a/drivers/iommu/io-pgtable-arm-selftests.c
+++ b/drivers/iommu/io-pgtable-arm-selftests.c
@@ -13,28 +13,28 @@
 
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

