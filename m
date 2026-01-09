Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB16A3659E6
	for <iommu@lists.linux.dev>; Fri,  9 Jan 2026 17:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767979101; cv=none; b=YLpSSe0GeaN7jjyjAQKFOV1crvO56Qx1uJMjMrR1DgAvQaqh8ksHaGGEBitqVTUpikDGmvnIJyvQy/OUEKov4IFZNf4JvQ1xJhK3IUbaJUvaQD2WtSvaPpbi7Bmoz5XKtg/TGmxPMfVEh06MA1iDlerRjgtP5IwSs6l9A+jQaLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767979101; c=relaxed/simple;
	bh=JyxK9DCFit9BHgUZF8EAQgzBS/s8P5HYnNwnkPHg5Qw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=QS2TAPR6tCa/fQSPh79JV7jGNJeXtmO8pkZrb3yhHdYHQ95dXCTdjyWoU+PV7lbvXQeNjYfhz0fWS8NIVr2TCdUvoqVFmjHINYO2f+E2GA5FOopkupgx4PgUc3OyGy+/uYpPUlDhWogE9Xa2zRcpLT9hyjTxYpV9Qh0JG4mYxx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hyYLkvcd; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hyYLkvcd"
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-47d3c9b8c56so46030585e9.0
        for <iommu@lists.linux.dev>; Fri, 09 Jan 2026 09:18:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767979095; x=1768583895; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=rXKfhlVn2c+6UG0/zcj6FymOVg8M3bXQ+ReLnrZOk7w=;
        b=hyYLkvcdH9x+ZVWOvd3GJtqGT/O4sQ0RYyK5f9DYIBmSA7cWsODuJJuVd4byUwKKA7
         HtIhSZKAOp6jbuQX228WDAd8dsuD3TkChdiyLmZpxbezV1I1xcAB6KWEZzl3VdCik8bV
         gDrzIkJCyYQK6rC9re3WdedO0wSalpP6CRnA62pQvhkTPC4l5OFHykNn1X6/Q0BUC7ic
         xB8qnaJN/VjVKWUKKQDkj/RSZ9UsAZFWuA7+Fgx9bB9Mx0G+YcPKxZJY25rm+8VdBnJv
         fwiEN3GIpSkhSQ89D5+I2aVUsMiMuKCLxdpaMmQ7dCvj3MvL7nUaCegEP4ohMmSpISLv
         2DgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767979095; x=1768583895;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rXKfhlVn2c+6UG0/zcj6FymOVg8M3bXQ+ReLnrZOk7w=;
        b=aynHYk2CqbPsZU/fRV3abfBfGpIPkmw/mo2TlLMYgOJ/oUNo6D/qt47K7lWPtapszc
         Eu4CPn1sNXRjtzWdnsyR85rWq7XBmbEwxDP+C5kiiVCsjVyOtUnxLPdBwHiQ1KqjwDm2
         uvjZxiSdqoNRVVw46J3k31nMS9bjX0DQhd9WQzsiFxQO+Ts3EoQv0WmbpXvTo3wkCp7d
         +LG8XIbtTfZX8qQeCPuHv2BacZmjF6GGXARgGT7tFlj15BTKag2g397CBr2prFom7evy
         22pwnAjLUD6GqhT/my5aHX0If+xxHccBPpSIaFXQUMgxnL7XS+jGo/VGTYuhV9Vw0xZU
         Pf1A==
X-Forwarded-Encrypted: i=1; AJvYcCU5bsQnslVKgtpjtoGTiV4iZ5g9UzzzN4rYaEaX1ykpBdMBMq7aeZ2TzLIhPeIvL3r9vOx/yA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzjPhFBeRu51h6twT8bZRXC/FOwI/AzlYwTp7dQEfIGJlGXhFq3
	zHI2rBc43+4/gQoC/mP+LaUejU7vrIqlBlQXSoRXGort1yp+rQG4SKA/hzQqXqTza5ytgu8vIb/
	oFhCjcjHhUHXAdw==
X-Google-Smtp-Source: AGHT+IFk02O2PK0We+1RMI+gkP8sH7Gfm0sE0Pyah5F14OonFiV3bx+oHBAF9FOQ2GaQcAwCLdJfSABlkCnRwQ==
X-Received: from wmbdx10.prod.google.com ([2002:a05:600c:63ca:b0:477:3fdf:4c24])
 (user=smostafa job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:46c4:b0:47d:403e:4eaf with SMTP id 5b1f17b1804b1-47d84b18ef7mr134197875e9.10.1767979095241;
 Fri, 09 Jan 2026 09:18:15 -0800 (PST)
Date: Fri,  9 Jan 2026 17:18:04 +0000
In-Reply-To: <20260109171805.901995-1-smostafa@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260109171805.901995-1-smostafa@google.com>
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260109171805.901995-4-smostafa@google.com>
Subject: [PATCH v6 3/4] iommu: debug-pagealloc: Track IOMMU pages
From: Mostafa Saleh <smostafa@google.com>
To: linux-mm@kvack.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org
Cc: corbet@lwn.net, joro@8bytes.org, will@kernel.org, robin.murphy@arm.com, 
	akpm@linux-foundation.org, vbabka@suse.cz, surenb@google.com, mhocko@suse.com, 
	jackmanb@google.com, hannes@cmpxchg.org, ziy@nvidia.com, david@redhat.com, 
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, rppt@kernel.org, 
	xiaqinxin@huawei.com, baolu.lu@linux.intel.com, rdunlap@infradead.org, 
	Mostafa Saleh <smostafa@google.com>, Samiullah Khawaja <skhawaja@google.com>
Content-Type: text/plain; charset="UTF-8"

Using the new calls, use an atomic refcount to track how many times
a page is mapped in any of the IOMMUs.

For unmap we need to use iova_to_phys() to get the physical address
of the pages.

We use the smallest supported page size as the granularity of tracking
per domain.
This is important as it is possible to map pages and unmap them with
larger sizes (as in map_sg()) cases.

Reviewed-by: Samiullah Khawaja <skhawaja@google.com>
Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Mostafa Saleh <smostafa@google.com>
---
 drivers/iommu/iommu-debug-pagealloc.c | 84 +++++++++++++++++++++++++++
 1 file changed, 84 insertions(+)

diff --git a/drivers/iommu/iommu-debug-pagealloc.c b/drivers/iommu/iommu-debug-pagealloc.c
index 1d343421da98..9eb49e1230ee 100644
--- a/drivers/iommu/iommu-debug-pagealloc.c
+++ b/drivers/iommu/iommu-debug-pagealloc.c
@@ -29,19 +29,103 @@ struct page_ext_operations page_iommu_debug_ops = {
 	.need = need_iommu_debug,
 };
 
+static struct page_ext *get_iommu_page_ext(phys_addr_t phys)
+{
+	struct page *page = phys_to_page(phys);
+	struct page_ext *page_ext = page_ext_get(page);
+
+	return page_ext;
+}
+
+static struct iommu_debug_metadata *get_iommu_data(struct page_ext *page_ext)
+{
+	return page_ext_data(page_ext, &page_iommu_debug_ops);
+}
+
+static void iommu_debug_inc_page(phys_addr_t phys)
+{
+	struct page_ext *page_ext = get_iommu_page_ext(phys);
+	struct iommu_debug_metadata *d = get_iommu_data(page_ext);
+
+	WARN_ON(atomic_inc_return_relaxed(&d->ref) <= 0);
+	page_ext_put(page_ext);
+}
+
+static void iommu_debug_dec_page(phys_addr_t phys)
+{
+	struct page_ext *page_ext = get_iommu_page_ext(phys);
+	struct iommu_debug_metadata *d = get_iommu_data(page_ext);
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

