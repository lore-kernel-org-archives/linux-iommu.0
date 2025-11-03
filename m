Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2F7530DEDF
	for <iommu@lists.linux.dev>; Mon,  3 Nov 2025 12:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762173247; cv=none; b=f11J7kF36DXbJgHEl65pHSYjWOiOICwYbJjEJr97f6Xb89sM3Wp/OGIlllA36llzATiDL5/3KWsQjSJAIcAB78YFosk7O2fu6W7VwlJ1XqRiaBDLeC8EaoeVJYj1ENMuiKJZ4XzyZPtcSmLG4DGdnrY5Gu6YisO9/L/1ee26Y9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762173247; c=relaxed/simple;
	bh=EY2v8ftlRDhqQWW4H3Xk1bbgHzma4n1wHwx/sHkL/Qw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=YtaO0l4bqGRXMRO2R+E3M0vgUwLDPo5ZAXT8MK3oODcQJgCBjDdTdWpAmSx2eS+wYJOA+RWVHyY2MRWMx+JFkcb0u0rLzmWNaIjqjq/Juu81CZXjzp5gQEkxnuU4nrURCr5bGWDFsxA67ES+9PPX6F+hLsWxTJRTDP8S6YwsTag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FMeTA5nl; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FMeTA5nl"
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-47106a388cfso34641855e9.0
        for <iommu@lists.linux.dev>; Mon, 03 Nov 2025 04:34:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762173244; x=1762778044; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=eb5/iRLBLqsffznaL4L+fLHOh9qr7aNQqsvWygVRwbI=;
        b=FMeTA5nlm9bYxkAVs48XT6/fm4hBJmuyL+0MhlV22oEdAis8x7STQXeOUKxH+V9HKw
         PZTE0s6vJp5i3B75YT3ENA7eVFcJx0KFjbqBSK2N4QFhh+7BCBJ72vowR2cqi1n+MHJp
         w5i0jFk7ljC9O4QcX42WpXteFHX3GZEWAPY6hGIfcqTaXlrWBYsdY8JECiO7SZKLg5jt
         la3GkYbq9cUITmNfkpcx5pDzrlY7DjEtYl3ihmsLfog8wuJP9HRTSBigTvB0GNdw0pA0
         ty68F0zVCr7JkPqfwaIeojV1hPMDXXkl9Au97O8zmg+b0Xsn7XUW0Cn5coPT7dorwgSQ
         nT+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762173244; x=1762778044;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eb5/iRLBLqsffznaL4L+fLHOh9qr7aNQqsvWygVRwbI=;
        b=cnkI8TFTvIKFljOLH/S9wSTQHUI3Mo/XmNphtQCKscHnKozwbOCJNkv6Ht0NDKfgpu
         rqsm+0y1H964ZBDZdnO+t1XeSoSYdOVeepbIOHTpMmxXurlzqtJCYQLeM+V/VwphQuIS
         +JImd2C4lr9zoy7jOE/OQ2JRiSbiFR2Q8OR5KUs9RarIsefUuhi8+pw0/jU9DiaTmf5W
         6T3Rp5pMcjbDTrLovIvgppV/1c/bofdDWOx1JgFgh/bQyCeIj7xQfCOz7thRAaXmyzC7
         pKQD+L6hFeqWRUAmbVUkN10IYzdFZXZyc769M7uEzYNIz+5u15zjLdIvuhJNi4B/CkJi
         161A==
X-Gm-Message-State: AOJu0YzEaJ2bWABYw4zs8Z50bxiUVkawZlg8Eg25cSPXlq777pR4sFok
	Ct/nMfwgBFjYLtdDUiZnuCDHaHnhad8ipvLS9IZzj8AOUVUJjJCnx1I19jvVGxpGcNQSTPXgKc1
	AzQ82C3NibHjZn3TJBmZ0lUi7Zeht98GiyvcTzlCUuhoQ5lnXqbkFljlI2zRha5KG1QK1yCf/K5
	lOxAXU8dqaGnRu52q5VyhHaHeD8D/06jwQSTHk6gcBqvDv6A==
X-Google-Smtp-Source: AGHT+IEVmWefjtycrwY1ECoBVYWfmLjbUY7S32z2Glhi1U/9AlZNIJz93PqCys7M1yOpDXipEHbSZOCG4Dm05Q==
X-Received: from wmbdv10.prod.google.com ([2002:a05:600c:620a:b0:475:df4b:95a9])
 (user=smostafa job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:530e:b0:477:1bb6:17e5 with SMTP id 5b1f17b1804b1-47751697433mr11754125e9.30.1762173244166;
 Mon, 03 Nov 2025 04:34:04 -0800 (PST)
Date: Mon,  3 Nov 2025 12:33:51 +0000
In-Reply-To: <20251103123355.1769093-1-smostafa@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20251103123355.1769093-1-smostafa@google.com>
X-Mailer: git-send-email 2.51.1.930.gacf6e81ea2-goog
Message-ID: <20251103123355.1769093-4-smostafa@google.com>
Subject: [PATCH v6 3/4] iommu/io-pgtable-arm-selftests: Modularize the test
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
index 5da6d4b69920..8361d01b49c5 100644
--- a/drivers/iommu/io-pgtable-arm-selftests.c
+++ b/drivers/iommu/io-pgtable-arm-selftests.c
@@ -15,28 +15,28 @@
 
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
@@ -47,9 +47,9 @@ static const struct iommu_flush_ops dummy_tlb_ops __initconst = {
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
@@ -150,15 +150,15 @@ static int __init arm_lpae_run_tests(struct io_pgtable_cfg *cfg)
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
 
@@ -198,4 +198,12 @@ static int __init arm_lpae_do_selftests(void)
 
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
2.51.1.930.gacf6e81ea2-goog

