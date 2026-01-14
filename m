Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D4C23A4F56
	for <iommu@lists.linux.dev>; Wed, 14 Jan 2026 16:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768409017; cv=none; b=SMP9puREPPJ1EhRx2UMKYmtkmWZf0wVTNZx/ilrtmATukszHPSaZ1lG3A5CRf/O53880utKzGCMzkE8lz0qQVmVtUKWtCi6y/CV72uUf7huGlwA6AWNhwEwKJj4qvip6bQ0LcFhdttENBT9sEVoyqShCeEcncoOydVsoip0/q6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768409017; c=relaxed/simple;
	bh=oTypUmL8Y7fARfHGzXR113k/PBV6oYH6cemBWWQriHU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jaOUfXLMXOtrJQgSeHZPetkW5DSe5iCR/zXdMeIwIihIsP6oSsNqX8dgRFDpAptWr9zeg54JphzXt6O+lgz/oyT17qM+nu0mFULkvLnKC67mucAIwBsuxQXG+/FSWk5VGc9oJPAsxUxrAd8xIQbESKUJVxuzZixZ8l2Tlmbfp7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0rEA4z7E; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0rEA4z7E"
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-43284edbbc8so42593f8f.0
        for <iommu@lists.linux.dev>; Wed, 14 Jan 2026 08:43:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768409014; x=1769013814; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=tdaemC/8rVdnYF36w5DJ/vmlH80Wji91vs6XJXHQNS8=;
        b=0rEA4z7EXTy13KDVouEVnffOXPpZa+n50GhtoWXWd+E1LPfOQLgjyzEjJtXrSGwSBf
         qI4nCbJwAqL+e1M9LzOt/goEbw1Avn33ODtk18S5OkrfiK8LN0983rvAAya4bqydE4HK
         1wc3Dnh6U1hnSSARQKSHF970C0fdH7zKOWgvza732jigRWtwszghJJceyS3iv1mSguN+
         +tV64JiPT+VnZYLXdy8cpmNXmKviEWXvtq86tlaM3Zcjj+gwUO+z7bGSgBEexLyRpn2m
         AYmizu6o8FIzxZwUguhiAaW+Wgi9nfHFqB+isDZPrS8msIiSh4+Oe4CtGKmA8S+HGhB+
         IqkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768409014; x=1769013814;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tdaemC/8rVdnYF36w5DJ/vmlH80Wji91vs6XJXHQNS8=;
        b=VmxJbTFCwtx+bq/beLF7LqmrsNNM/xk0slS8BzgDWMU50STiEpKVyxQGLcXZLT0pDp
         Y/Eq12gHMRjHrRFDofCGR7VEjq2xkpTOz0QxfGPJAKcLxmDDcoGqnssQUV92S7zqr0NJ
         2c1q2JJRvJRNGQ8yT8wEYrTODpKz4wvtlIaTU1cC+YrnsNuoGOOyQDoaX0NPpkz6f6IM
         zx0y4kUjc2qRJ0qyRU43/R3mI3dGRc4mSPDQb3zChcmduDr90agiVThYLCCO5+MaavZG
         DHLLxjWjcFsA15DPm002FppwwoMAjoecCbbiYPkD0g9+hN6G3TZXr6A1m/3RcLpe4xtD
         mlLQ==
X-Forwarded-Encrypted: i=1; AJvYcCWip/AerWFFGnepA/6hDjgQU1y4KzIDGTqI+EePcBxIm46vdioXujLU4vNIkU/dxldoZXplEA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzyHCVQMwixHgcw4pdSATMcr3HMbgDyD9Idz4RZZ3vYoTGhHUJV
	k2fJiQTrwycWFb1mJuC51MLBG1smHUwMvdXsIFK0WbAWgwiZ2Xvu6vJFLjSLc31kuaYWkmkv4z+
	a+6VECrPrRlR8Mw==
X-Received: from wrwe15.prod.google.com ([2002:a5d:65cf:0:b0:430:f6cb:a9d2])
 (user=smostafa job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:4304:b0:430:fdfc:7dd3 with SMTP id ffacd0b85a97d-4342c5537ffmr3522133f8f.50.1768409014021;
 Wed, 14 Jan 2026 08:43:34 -0800 (PST)
Date: Wed, 14 Jan 2026 16:43:21 +0000
In-Reply-To: <20260114164322.787125-1-smostafa@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260114164322.787125-1-smostafa@google.com>
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260114164322.787125-5-smostafa@google.com>
Subject: [PATCH v7 4/5] iommu: debug-pagealloc: Track IOMMU pages
From: Mostafa Saleh <smostafa@google.com>
To: linux-mm@kvack.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org
Cc: corbet@lwn.net, joro@8bytes.org, will@kernel.org, robin.murphy@arm.com, 
	akpm@linux-foundation.org, vbabka@suse.cz, surenb@google.com, mhocko@suse.com, 
	jackmanb@google.com, hannes@cmpxchg.org, ziy@nvidia.com, david@redhat.com, 
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, rppt@kernel.org, 
	xiaqinxin@huawei.com, baolu.lu@linux.intel.com, rdunlap@infradead.org, 
	Mostafa Saleh <smostafa@google.com>
Content-Type: text/plain; charset="UTF-8"

Using the new calls, use an atomic refcount to track how many times
a page is mapped in any of the IOMMUs.

For unmap we need to use iova_to_phys() to get the physical address
of the pages.

We use the smallest supported page size as the granularity of tracking
per domain.
This is important as it is possible to map pages and unmap them with
larger sizes (as in map_sg()) cases.

Signed-off-by: Mostafa Saleh <smostafa@google.com>
---
 drivers/iommu/iommu-debug-pagealloc.c | 86 +++++++++++++++++++++++++++
 1 file changed, 86 insertions(+)

diff --git a/drivers/iommu/iommu-debug-pagealloc.c b/drivers/iommu/iommu-debug-pagealloc.c
index 1d343421da98..3ce3385588b2 100644
--- a/drivers/iommu/iommu-debug-pagealloc.c
+++ b/drivers/iommu/iommu-debug-pagealloc.c
@@ -29,19 +29,105 @@ struct page_ext_operations page_iommu_debug_ops = {
 	.need = need_iommu_debug,
 };
 
+static struct iommu_debug_metadata *get_iommu_data(struct page_ext *page_ext)
+{
+	return page_ext_data(page_ext, &page_iommu_debug_ops);
+}
+
+static void iommu_debug_inc_page(phys_addr_t phys)
+{
+	struct page_ext *page_ext = page_ext_get_phys(phys);
+	struct iommu_debug_metadata *d;
+
+	if (!page_ext)
+		return;
+
+	d = get_iommu_data(page_ext);
+
+	WARN_ON(atomic_inc_return_relaxed(&d->ref) <= 0);
+	page_ext_put(page_ext);
+}
+
+static void iommu_debug_dec_page(phys_addr_t phys)
+{
+	struct page_ext *page_ext = page_ext_get_phys(phys);
+	struct iommu_debug_metadata *d;
+
+	if (!page_ext)
+		return;
+
+	d = get_iommu_data(page_ext);
+
+	WARN_ON(atomic_dec_return_relaxed(&d->ref) < 0);
+	page_ext_put(page_ext);
+}
+
+/*
+ * IOMMU page size doesn't have to match the CPU page size. So, we use
+ * the smallest IOMMU page size to refcount the pages in the vmemmap.
+ * That is important as both map and unmap has to use the same page size
+ * to update the refcount to avoid double counting the same page.
+ * And as we can't know from iommu_unmap() what was the original page size
+ * used for map, we just use the minimum supported one for both.
+ */
+static size_t iommu_debug_page_size(struct iommu_domain *domain)
+{
+	return 1UL << __ffs(domain->pgsize_bitmap);
+}
+
 void __iommu_debug_map(struct iommu_domain *domain, phys_addr_t phys, size_t size)
 {
+	size_t off, end;
+	size_t page_size = iommu_debug_page_size(domain);
+
+	if (WARN_ON(!phys || check_add_overflow(phys, size, &end)))
+		return;
+
+	for (off = 0 ; off < size ; off += page_size) {
+		if (!pfn_valid(__phys_to_pfn(phys + off)))
+			continue;
+		iommu_debug_inc_page(phys + off);
+	}
+}
+
+static void __iommu_debug_update_iova(struct iommu_domain *domain,
+				      unsigned long iova, size_t size, bool inc)
+{
+	size_t off, end;
+	size_t page_size = iommu_debug_page_size(domain);
+
+	if (WARN_ON(check_add_overflow(iova, size, &end)))
+		return;
+
+	for (off = 0 ; off < size ; off += page_size) {
+		phys_addr_t phys = iommu_iova_to_phys(domain, iova + off);
+
+		if (!phys || !pfn_valid(__phys_to_pfn(phys)))
+			continue;
+
+		if (inc)
+			iommu_debug_inc_page(phys);
+		else
+			iommu_debug_dec_page(phys);
+	}
 }
 
 void __iommu_debug_unmap_begin(struct iommu_domain *domain,
 			       unsigned long iova, size_t size)
 {
+	__iommu_debug_update_iova(domain, iova, size, false);
 }
 
 void __iommu_debug_unmap_end(struct iommu_domain *domain,
 			     unsigned long iova, size_t size,
 			     size_t unmapped)
 {
+	if ((unmapped == size) || WARN_ON_ONCE(unmapped > size))
+		return;
+
+	/* If unmap failed, re-increment the refcount. */
+	__iommu_debug_update_iova(domain, iova + unmapped,
+				  size - unmapped, true);
 }
 
 void iommu_debug_init(void)
-- 
2.52.0.457.g6b5491de43-goog

