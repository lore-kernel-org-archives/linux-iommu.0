Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 142914A43E8
	for <iommu@lists.linux.dev>; Thu,  1 Oct 2026 22:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790894754; cv=none; b=Fghat4XUozhcBIqzg5r/nHqrVISl/S49Oju0vklrSOcDDXtHYX68BowBZ27FW4GbEUve+b0bNdZH7uZTaIZpW4YwIgSyUwLIDpVRf5nr0DSioutBK0LnVJRZh3Mt7tUfKhfMLk1xPamn81LLNMtsOvwX8E4GJBEE8kPIivbjSyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790894754; c=relaxed/simple;
	bh=nUfqkFlbuPVBGi5zN5hZQzJYCoKidUYPuMDZeGldilE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=csPB5sMuJFmPpFzA8i/me+ljtxrfOYy8bUYCKUCX/mWMASW48/ZznPI2EdRjf5rK8kg7/IcsCApNdzAsHBX6fq9pIxQFdxFIsMel2OAFfvOJhqs6b+B/24EGdzOUK2+Q1SI7ZcmKxnnjqxdWtBjFFFCgZrmDSnS2WaGWld5M6CU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZiIaQ3rN; arc=none smtp.client-ip=209.85.216.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZiIaQ3rN"
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-39512608fb1so11065411a91.1
        for <iommu@lists.linux.dev>; Thu, 01 Oct 2026 15:45:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790894750; x=1791499550; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CAK9NPwX7Ow+EtKIIe3HO24Ti3BDkDgcMm+QryEOtLs=;
        b=ZiIaQ3rNhRvy0YwLYG72UiXRDJujn1STxFWEyEuC0wtmWGQNkLo7uYyl/DWIs62gxJ
         vwXDGbO0X4AzAKECXeB3jzKewGm1JoeeqKeO3pvWWZFFnJrfk4kJRlUur2iVFnkGEwfE
         t2/XA5tpIbZKaVv2sdlSOBRarJnqsXlBvmCyfDY1VvXwy9jAe3e5gKPzFNRW6KACxPEe
         EAkZAaCnLcD9yy8i738nPHbjiWm4vVUZBT39EOLdhFFRgjVyCCIu0UL/AggQyhVJl7xy
         DZMJkCmAGrIwQbDukId4zFB5d/pCKshD/7rkGj1mnqLev54bcvqcvN9CI/p+ruqZHFdm
         nVTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790894750; x=1791499550;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CAK9NPwX7Ow+EtKIIe3HO24Ti3BDkDgcMm+QryEOtLs=;
        b=RCaGp/V33ArXLeEuntnphzHKuhMSlKk8vk8zpGaY+xmgXjIoLhLf/VSsB1Lf0fdAES
         DEyrzGwJHxIndgu2o7KZ9AkvROrIm9lt10v3H+2tjVePdx7EIeXJ8Ov6YP8IMB2ZBo4+
         ADEJ3YIaxs6PDi2WdV1JQRdqKoQLHFCWbih838gz/A7x9LhsfR+8BlaqXlsb3d41oAZT
         NXp+kULp89eKffhKYT+x/ZdQLFvYkqlVpvDTkaYfAbWIBm3K8F9iQHSx+GO8uXEtBNW+
         eMC5tWrD5FjavfnrwAB14XbxG1J2uFHwdq/IOzB9QLTfq03PlsnD3VWcXnzmLqhpeavf
         PtUA==
X-Forwarded-Encrypted: i=1; AKwUvBzvQFiH2IvK1fh3oreNFgLvF1j0XQ32AFvIXAWFYZvZ2akkDehEHub+75yxcBN1oyZ+EoBcQg==@lists.linux.dev
X-Gm-Message-State: AFq9FYLNjUUNZ56lYeMABXONDuxebkxgrSBWWYzTSwIDaWis74lwt0ZT
	bJUal6rYSO6a02EMuF46H0sUku9fpaRmnbmBYaiIaazIKWlPnx8PqFsfL088n+nfQI3nhj2Kh+z
	TKg==
X-Received: from pgww21.prod.google.com ([2002:a05:6a02:2c95:b0:cc9:5e28:9460])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:224e:b0:3a0:2900:f584
 with SMTP id 98e67ed59e1d1-3a6cec4fc80mr957433a91.46.1790894750108; Thu, 01
 Oct 2026 15:45:50 -0700 (PDT)
Date: Thu,  1 Oct 2026 22:45:26 +0000
In-Reply-To: <20261001224531.765278-1-praan@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20261001224531.765278-1-praan@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20261001224531.765278-3-praan@google.com>
Subject: [RFC PATCH 2/7] iommu: Implement domain-attributed page allocation
From: Pranjal Shrivastava <praan@google.com>
To: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>, 
	Alex Williamson <alex@shazbot.org>, David Matlack <dmatlack@google.com>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>
Cc: Mostafa Saleh <smostafa@google.com>, Daniel Mentz <danielmentz@google.com>, 
	Samiullah Khawaja <skhawaja@google.com>, iommu@lists.linux.dev, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org, 
	Logan Odell <loganodell@google.com>, Pranjal Shrivastava <praan@google.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Implement the core logic for per-domain IOPT page accounting.
Introduce iommu_alloc_pages_node_sz_attributed() which increments
the domain's nr_pages counter & stores the domain ptr in the ioptdesc.
Update the free path to recover domain ptr and decrement the count.

Modify iommu_alloc_pages_node_sz() to be a legacy wrapper that passes a
NULL domain, ensuring backwards compatibility for non-domain use-cases.

Co-developed-by: Logan Odell <loganodell@google.com>
Signed-off-by: Logan Odell <loganodell@google.com>
Signed-off-by: Pranjal Shrivastava <praan@google.com>
---
 drivers/iommu/iommu-pages.c | 35 ++++++++++++++++++++++++++++++++---
 drivers/iommu/iommu-pages.h | 17 +++++++++++++++++
 2 files changed, 49 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/iommu-pages.c b/drivers/iommu/iommu-pages.c
index 3bab175d8557..81fa01b763b7 100644
--- a/drivers/iommu/iommu-pages.c
+++ b/drivers/iommu/iommu-pages.c
@@ -29,8 +29,10 @@ static inline size_t ioptdesc_mem_size(struct ioptdesc *desc)
 }
 
 /**
- * iommu_alloc_pages_node_sz - Allocate a zeroed page of a given size from
- *                             specific NUMA node
+ * iommu_alloc_pages_node_sz_attributed - Allocate a zeroed page of a given size
+ *                                        from specific NUMA node for a specific
+ *                                        iommu domain
+ * @domain: IOMMU domain to which the page will belong
  * @nid: memory NUMA node id
  * @gfp: buddy allocator flags
  * @size: Memory size to allocate, rounded up to a power of 2
@@ -40,7 +42,8 @@ static inline size_t ioptdesc_mem_size(struct ioptdesc *desc)
  * returned allocation is round_up_pow_two(size) big, and is physically aligned
  * to its size.
  */
-void *iommu_alloc_pages_node_sz(int nid, gfp_t gfp, size_t size)
+void *iommu_alloc_pages_node_sz_attributed(struct iommu_domain *domain, int nid,
+					   gfp_t gfp, size_t size)
 {
 	struct ioptdesc *iopt;
 	unsigned long pgcnt;
@@ -83,18 +86,44 @@ void *iommu_alloc_pages_node_sz(int nid, gfp_t gfp, size_t size)
 	mod_node_page_state(folio_pgdat(folio), NR_IOMMU_PAGES, pgcnt);
 	lruvec_stat_mod_folio(folio, NR_SECONDARY_PAGETABLE, pgcnt);
 
+	iopt->domain = domain;
+	if (domain)
+		atomic_long_add(pgcnt, &domain->nr_pages);
+
 	return folio_address(folio);
 }
+EXPORT_SYMBOL_GPL(iommu_alloc_pages_node_sz_attributed);
+
+/**
+ * iommu_alloc_pages_node_sz - Allocate a zeroed page of a given size from
+ *                             specific NUMA node
+ * @nid: memory NUMA node id
+ * @gfp: buddy allocator flags
+ * @size: Memory size to allocate, rounded up to a power of 2
+ *
+ * Returns the virtual address of the allocated page. The page must be freed
+ * either by calling iommu_free_pages() or via iommu_put_pages_list(). The
+ * returned allocation is round_up_pow_two(size) big, and is physically aligned
+ * to its size.
+ */
+void *iommu_alloc_pages_node_sz(int nid, gfp_t gfp, size_t size)
+{
+	return iommu_alloc_pages_node_sz_attributed(NULL, nid, gfp, size);
+}
 EXPORT_SYMBOL_GPL(iommu_alloc_pages_node_sz);
 
 static void __iommu_free_desc(struct ioptdesc *iopt)
 {
 	struct folio *folio = ioptdesc_folio(iopt);
 	const unsigned long pgcnt = folio_nr_pages(folio);
+	struct iommu_domain *domain = iopt->domain;
 
 	if (IOMMU_PAGES_USE_DMA_API)
 		WARN_ON_ONCE(iopt->incoherent);
 
+	if (domain)
+		atomic_long_sub(pgcnt, &domain->nr_pages);
+
 	mod_node_page_state(folio_pgdat(folio), NR_IOMMU_PAGES, -pgcnt);
 	lruvec_stat_mod_folio(folio, NR_SECONDARY_PAGETABLE, -pgcnt);
 	folio_put(folio);
diff --git a/drivers/iommu/iommu-pages.h b/drivers/iommu/iommu-pages.h
index edf75c81054f..a4a8e9ba57c5 100644
--- a/drivers/iommu/iommu-pages.h
+++ b/drivers/iommu/iommu-pages.h
@@ -55,6 +55,8 @@ static inline struct ioptdesc *virt_to_ioptdesc(void *virt)
 	return folio_ioptdesc(virt_to_folio(virt));
 }
 
+void *iommu_alloc_pages_node_sz_attributed(struct iommu_domain *domain, int nid,
+					   gfp_t gfp, size_t size);
 void *iommu_alloc_pages_node_sz(int nid, gfp_t gfp, size_t size);
 void iommu_free_pages(void *virt);
 void iommu_put_pages_list(struct iommu_pages_list *list);
@@ -107,6 +109,21 @@ static inline void *iommu_alloc_pages_sz(gfp_t gfp, size_t size)
 	return iommu_alloc_pages_node_sz(NUMA_NO_NODE, gfp, size);
 }
 
+/**
+ * iommu_alloc_pages_sz_attributed - Allocate a zeroed page of a given size from
+ *                                   specific NUMA node for a specific domain
+ * @domain: iommu domain
+ * @gfp: buddy allocator flags
+ * @size: Memory size to allocate, this is rounded up to a power of 2
+ *
+ * Returns the virtual address of the allocated page.
+ */
+static inline void *iommu_alloc_pages_sz_attributed(struct iommu_domain *domain,
+						    gfp_t gfp, size_t size)
+{
+	return iommu_alloc_pages_node_sz_attributed(domain, NUMA_NO_NODE, gfp, size);
+}
+
 int iommu_pages_start_incoherent(void *virt, struct device *dma_dev);
 int iommu_pages_start_incoherent_list(struct iommu_pages_list *list,
 				      struct device *dma_dev);
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

