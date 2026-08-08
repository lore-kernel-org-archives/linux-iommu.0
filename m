Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B098C2C026C
	for <iommu@lists.linux.dev>; Sat,  8 Aug 2026 02:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786156049; cv=none; b=rYPA6pJR3nwA3+kQO7FHRanK2T2l5J6Yur/pOW5C8DRbA8JpQnnxsTfO1ADlntD0XDgYekDvCll+UgBW5jWIRP+H0BZcxHyT/DmLEK6Aaec738KHvDDgJqpVngF3TFvjtmHlQ1Hl7TWS6GiDBFC4NiuR/R/mlfePcv92/26pF9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786156049; c=relaxed/simple;
	bh=hvc4sChU1zYRyCYy56LSYGC/4J5BHZmxu3246c51Qwk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=m3n0y7hqPR5tv3z5NrgSj2qTdvESP0La/IV07XYyVQwBnCfdOEA4JdkXKhHTmdjpKvBzB06YS3NdhqA6kR+xVm9dvwDN+P3WYKlNj1SKF0ghIz1THmoEoW7fRaGYQoior+AGSddJTagoToZGoSBCdop5jac/bQGYJ3nYqirEATA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PESWqbH6; arc=none smtp.client-ip=209.85.210.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PESWqbH6"
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-84859a64079so262893b3a.3
        for <iommu@lists.linux.dev>; Fri, 07 Aug 2026 19:27:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786156047; x=1786760847; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RLrpkCzlvvEgnlzC1Ye64k2MeVsxQQxVHyL6u9eNslk=;
        b=PESWqbH6ZJ8t2yHzB+d2lIFD1zDB/J7kB/NBF4x26W18JfgEyqgn1Vgy11WosKy7hB
         e4lUqW2zpVQkXmL28VtpmVcF+Mm3hWlcQuFe2ZDBKTONjG/jApEpJY3Idsyi/aQ/JMOT
         ohCimqWJb/RFrPgyFL4hFnEcOhp+0tTtEpbouenmqOdHHhLfnuDQH1f37qunlAi3glAX
         1yOG1HyyWKpNdJ1ov04kFv7ilk76/5kxfz18KZsrUwLlFOmb4EUhkaBTv7gk0EEgmYKs
         Bl4GzlGL+VJiSCetavtI7O0+voV23KUixcX9ukbb2szvJl4DXTLHCA9zlOHuAATVzqZr
         Vd+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786156047; x=1786760847;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RLrpkCzlvvEgnlzC1Ye64k2MeVsxQQxVHyL6u9eNslk=;
        b=c6p4yL6r7R4aT1q2MYZaVnUsZjt9nNd7tQeT5MmFk9ZOxjmLQmloWCgBj96WODmTgs
         4jHmLKwPiuQiYysUHmoR5DRZ+eSqbKeTXTzOyMOuY4SDGq3PT/kWNK/hl4QIDsmOInyF
         /0p0Y9RZgmZ00nejLqM1EnEbPJPOgNiLmxduBXxLNdn/XSWouQmriLyUQol3E704K3X7
         sdrj6+aPBJJ7TwlrnEiczOJXbjNWLlgzx8nJsOMbhbyd10Kjiyvqi4/BaLhBWBvTBvs8
         HafC9xT3tprdY3nWlAvPshtJtKzahdIPG64hkeZbo6K5/DgKvC4kzzLk6JM8rpXe/MBk
         TJZQ==
X-Forwarded-Encrypted: i=1; AHgh+Rpu/xf4N63ZZJjR8bI5TQcOjwoPDWxECrk0LnvUlYgkD6uamdxVhXY/hO246ETvUE6752hsiw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwB09WaBkrl8eUhYJ/b4RpPLOUfFDSEqVJJjf9aP5owxgjdUMyQ
	nItM5VXy3PQqNPbKk5gblAouiIt0Z6+Qbtgm0qR2KxoAZDdNxIMfFegskBlwQB+bLqkYo75AWkx
	Dx3amMJqwqL3jWA==
X-Received: from pfwy32.prod.google.com ([2002:a05:6a00:1ca0:b0:84c:586:a7ea])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:1388:b0:82f:3a1e:5618 with SMTP id d2e1a72fcca58-84f2e017478mr29152470b3a.22.1786156046606;
 Fri, 07 Aug 2026 19:27:26 -0700 (PDT)
Date: Sat,  8 Aug 2026 02:27:08 +0000
In-Reply-To: <20260808022723.3893618-1-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260808022723.3893618-1-skhawaja@google.com>
X-Mailer: git-send-email 2.55.0.679.g6767b8d81c-goog
Message-ID: <20260808022723.3893618-4-skhawaja@google.com>
Subject: [PATCH v4 03/18] iommu/pages: Add APIs to preserve/unpreserve/restore
 iommu pages
From: Samiullah Khawaja <skhawaja@google.com>
To: David Woodhouse <dwmw2@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>, 
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>
Cc: Samiullah Khawaja <skhawaja@google.com>, Robin Murphy <robin.murphy@arm.com>, 
	Kevin Tian <kevin.tian@intel.com>, Alex Williamson <alex@shazbot.org>, Shuah Khan <shuah@kernel.org>, 
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	Pratyush Yadav <pratyush@kernel.org>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	David Matlack <dmatlack@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Pranjal Shrivastava <praan@google.com>, Vipin Sharma <vipinsh@google.com>
Content-Type: text/plain; charset="UTF-8"

IOMMU pages are allocated/freed using APIs using struct ioptdesc. For
the proper preservation and restoration of ioptdesc add helper
functions.

Reviewed-by: Pranjal Shrivastava <praan@google.com>
Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
---
 drivers/iommu/iommu-pages.c | 108 ++++++++++++++++++++++++++++++++++--
 drivers/iommu/iommu-pages.h |  30 ++++++++++
 2 files changed, 134 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/iommu-pages.c b/drivers/iommu/iommu-pages.c
index 3bab175d8557..96cc935fb4e1 100644
--- a/drivers/iommu/iommu-pages.c
+++ b/drivers/iommu/iommu-pages.c
@@ -6,6 +6,7 @@
 #include "iommu-pages.h"
 #include <linux/dma-mapping.h>
 #include <linux/gfp.h>
+#include <linux/kexec_handover.h>
 #include <linux/mm.h>
 
 #define IOPTDESC_MATCH(pg_elm, elm)                    \
@@ -28,6 +29,13 @@ static inline size_t ioptdesc_mem_size(struct ioptdesc *desc)
 	return 1UL << (folio_order(ioptdesc_folio(desc)) + PAGE_SHIFT);
 }
 
+static inline void iommu_folio_update_stats(struct folio *folio,
+					    unsigned long nr_pages)
+{
+	mod_node_page_state(folio_pgdat(folio), NR_IOMMU_PAGES, nr_pages);
+	lruvec_stat_mod_folio(folio, NR_SECONDARY_PAGETABLE, nr_pages);
+}
+
 /**
  * iommu_alloc_pages_node_sz - Allocate a zeroed page of a given size from
  *                             specific NUMA node
@@ -80,8 +88,7 @@ void *iommu_alloc_pages_node_sz(int nid, gfp_t gfp, size_t size)
 	 * rather large, i.e. multiple gigabytes in size.
 	 */
 	pgcnt = 1UL << order;
-	mod_node_page_state(folio_pgdat(folio), NR_IOMMU_PAGES, pgcnt);
-	lruvec_stat_mod_folio(folio, NR_SECONDARY_PAGETABLE, pgcnt);
+	iommu_folio_update_stats(folio, pgcnt);
 
 	return folio_address(folio);
 }
@@ -95,8 +102,7 @@ static void __iommu_free_desc(struct ioptdesc *iopt)
 	if (IOMMU_PAGES_USE_DMA_API)
 		WARN_ON_ONCE(iopt->incoherent);
 
-	mod_node_page_state(folio_pgdat(folio), NR_IOMMU_PAGES, -pgcnt);
-	lruvec_stat_mod_folio(folio, NR_SECONDARY_PAGETABLE, -pgcnt);
+	iommu_folio_update_stats(folio, -pgcnt);
 	folio_put(folio);
 }
 
@@ -131,6 +137,100 @@ void iommu_put_pages_list(struct iommu_pages_list *list)
 }
 EXPORT_SYMBOL_GPL(iommu_put_pages_list);
 
+#if IS_ENABLED(CONFIG_IOMMU_LIVEUPDATE)
+/**
+ * iommu_unpreserve_pages - Unpreserve pages that were preserved in KHO
+ * @virt: Virtual address of page to be unpreserved
+ */
+void iommu_unpreserve_pages(void *virt)
+{
+	kho_unpreserve_folio(ioptdesc_folio(virt_to_ioptdesc(virt)));
+}
+EXPORT_SYMBOL_GPL(iommu_unpreserve_pages);
+
+/**
+ * iommu_preserve_pages - Preserve pages using KHO
+ * @virt: Virtual address of page to preserve
+ *
+ * Returns 0 on success, negative error on failure
+ */
+int iommu_preserve_pages(void *virt)
+{
+	return kho_preserve_folio(ioptdesc_folio(virt_to_ioptdesc(virt)));
+}
+EXPORT_SYMBOL_GPL(iommu_preserve_pages);
+
+/**
+ * iommu_unpreserve_pages_list - Unpreserve a list of KHO preserved pages
+ * @list: List of pages to unpreserve
+ */
+void iommu_unpreserve_pages_list(struct iommu_pages_list *list)
+{
+	struct ioptdesc *iopt;
+
+	list_for_each_entry(iopt, &list->pages, iopt_freelist_elm)
+		kho_unpreserve_folio(ioptdesc_folio(iopt));
+}
+EXPORT_SYMBOL_GPL(iommu_unpreserve_pages_list);
+
+/**
+ * iommu_restore_pages - Restore pages that were preserved in KHO
+ * @phys: Physical address of page to restore
+ */
+void iommu_restore_pages(u64 phys)
+{
+	struct ioptdesc *iopt;
+	struct folio *folio;
+	unsigned long pgcnt;
+	unsigned int order;
+
+	folio = kho_restore_folio(phys);
+	BUG_ON(!folio);
+
+	iopt = folio_ioptdesc(folio);
+
+	/*
+	 * For the restored pages incoherent is set to false as these are not
+	 * mapped using the DMA_API. The remapping of these pages using DMA_API
+	 * is not needed as these are not going to be written to by the new
+	 * kernel.
+	 */
+	iopt->incoherent = false;
+
+	order = folio_order(folio);
+	pgcnt = 1UL << order;
+	iommu_folio_update_stats(folio, pgcnt);
+}
+EXPORT_SYMBOL_GPL(iommu_restore_pages);
+
+/**
+ * iommu_preserve_pages_list - Preserve list of pages using KHO
+ * @list: List of pages to preserve
+ *
+ * Returns 0 on success, negative error on failure
+ */
+int iommu_preserve_pages_list(struct iommu_pages_list *list)
+{
+	struct ioptdesc *iopt;
+	int ret;
+
+	list_for_each_entry(iopt, &list->pages, iopt_freelist_elm) {
+		ret = kho_preserve_folio(ioptdesc_folio(iopt));
+		if (ret)
+			goto err;
+	}
+
+	return 0;
+
+err:
+	list_for_each_entry_continue_reverse(iopt, &list->pages, iopt_freelist_elm)
+		kho_unpreserve_folio(ioptdesc_folio(iopt));
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(iommu_preserve_pages_list);
+#endif
+
 /**
  * iommu_pages_start_incoherent - Setup the page for cache incoherent operation
  * @virt: The page to setup
diff --git a/drivers/iommu/iommu-pages.h b/drivers/iommu/iommu-pages.h
index e9e605b5fa3a..3c409ec3d170 100644
--- a/drivers/iommu/iommu-pages.h
+++ b/drivers/iommu/iommu-pages.h
@@ -53,6 +53,36 @@ void *iommu_alloc_pages_node_sz(int nid, gfp_t gfp, size_t size);
 void iommu_free_pages(void *virt);
 void iommu_put_pages_list(struct iommu_pages_list *list);
 
+#if IS_ENABLED(CONFIG_IOMMU_LIVEUPDATE)
+int iommu_preserve_pages(void *virt);
+void iommu_unpreserve_pages(void *virt);
+int iommu_preserve_pages_list(struct iommu_pages_list *list);
+void iommu_unpreserve_pages_list(struct iommu_pages_list *list);
+void iommu_restore_pages(u64 phys);
+#else
+static inline int iommu_preserve_pages(void *virt)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline void iommu_unpreserve_pages(void *virt)
+{
+}
+
+static inline int iommu_preserve_pages_list(struct iommu_pages_list *list)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline void iommu_unpreserve_pages_list(struct iommu_pages_list *list)
+{
+}
+
+static inline void iommu_restore_pages(u64 phys)
+{
+}
+#endif
+
 /**
  * iommu_pages_list_add - add the page to a iommu_pages_list
  * @list: List to add the page to
-- 
2.55.0.679.g6767b8d81c-goog

