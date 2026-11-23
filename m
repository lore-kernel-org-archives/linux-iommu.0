Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.70
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795409395;
	b=o/Qri+yDTQPeQuWMujxKTqM90H/n2UMlTB/C41h5eTqZ6vFlGNPx3ul1YNK6RNIU0cKz
	 Rn/a6Jb5ZQgQpKWhLtPm0TyMvAeCfuK7+e6/xBNSFqBX58M0xPPtYfnH8qVGuGOga/EUv
	 nULGxJvt7MJutIFAwW2JIf6eKsVjKLQSXkKRtKL6ntMvzNYCAUoPh2he1DbAtnu0YSX90
	 QmiRv7AmroBo6guunGuLo6+EqpDfoyKzKqcCq0b3HPNOg26imIkCtRfDe4M3oFTzssoGA
	 yjgqHY1OKpmLlETza+MDNRAfoiBcWCsRgpAX3NMyA5DPF6LuEwAJgPqgcMksJ/DXdUA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795409395;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=bO1KGG2LtYAShW8IvVbHPY+RtbdGqp650yC0DvHa1oc=;
	b=RbTDifyAXBQUnWO4O9wpS//TONNoTA1rAbnmdjAmfNSXuBCyDhKSc60CT1Ppn0g27FUp
	 cIrb3YF2SgPXpHFWpYd9n+5ZU06ItKkCu89UTM0dXQjMozxrvq/u7Kfd6OZGj3GKG0i9f
	 Bu2aGRnCRylTypGAHX7qn7uyWvFjl7zjOrpneeo3sxipfbces6ouJZe5QBaRYrsdgmwGL
	 pkRW1Q1o+bHvJQsJyyhwPh/kVWG1BxeI7Qt90/eEHBDnSmFPUgNj+GRnloWjkGFkoAtsk
	 n4i4+CYxSzatFl/9YI1QERcueK3ZMyYFm2itILBuPE8kpaKkX8iIx2y5jS9xxa61ThQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=KP7Wi1bW;
	arc=none smtp.remote-ip=209.85.216.70
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D6DE606A690
	for <iommu@lists.linux.dev>; Mon, 23 Nov 2026 04:49:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2D6DE606A690
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=KP7Wi1bW
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3b40e7f4fa2so4555497a91.2
        for <iommu@lists.linux.dev>; Sun, 22 Nov 2026 20:49:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795409394; x=1796014194; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bO1KGG2LtYAShW8IvVbHPY+RtbdGqp650yC0DvHa1oc=;
        b=KP7Wi1bWmzo5tb7+UZ5yxymFw7JfKwBHOi72pSkAHBDtZhkUhpJiZF7WtAuwRW16Q1
         YBhMS4DqYBdmmoyyo/y8fWyuQYVgzW98NJ8oM7Sc9cZ3g4yTKr12IrTqstWDA9ejN6W0
         O2LiXtS+mBZXH4IwdX6NH6ls9XFLVhHaeeBgkJtsSvIs/CYAh0qokwX43jB0PfVcrxQ0
         n1g4ggdAmFqrtysJ5GLa5GTgWULU1X+IrSeSYIWMlE+IporWu7AYraAUegdX/rLwjJFm
         xqcocKN6t6jkL9QPQ6oZ4w7m/f3tdQuayknLwpoMhY1dBnqIqPF1bWVoi/lw6wV+nuhE
         WNvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795409394; x=1796014194;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bO1KGG2LtYAShW8IvVbHPY+RtbdGqp650yC0DvHa1oc=;
        b=i0d9WZKS2JrzGnGK2FmHrLNPm+TKJXegmpjroOv9QYB3XuIvO8lOpWXQNtJbUmkl5W
         2RbHnSrBF023416S1lNK0jXnBMYorGfPK13BWsoyVoEwlmdesQT3jTJcIIi+O8kN9ZZB
         ircEi6eVV5V2tZndvmZOZ7Ovjs4IV8zCF7sIFHJg0Hj+WR8N7ylxL70LhIJNz/lkjiEG
         IeRfQkscvj3rA5gsSeh1YFHEGth7XcZb708PXZyYrtSH8mylm1ssDFhCdBVPFSqvjTfN
         ToAvKAndmG8j7DAY8HpEQq55GtP5D/gVqRlo3mfrC0vNoIiS6sk0MIeTiipPIvao2ukA
         fgaQ==
X-Forwarded-Encrypted: i=1; AL+hErEkLuawbDB7NfYngcSuAUQLwQS0k+hUov/LRIvIYKD7/f1y4R18seylgOz+3lBC9kBv9ak1uw==@lists.linux.dev
X-Gm-Message-State: APuU4Z/B8bvs6s80j7B7Y4/iLR9IzqliScs7NarUmVI21DvC3MDihTAl
	NtdCLHweEvM4mjGgxfKO5/eeLdmBchs4oHwVWG5gcjlQ5ClEMfxEbgac/B/cjdn6DThTWKAOG/Y
	4//NrkJ46HJqfaA==
X-Received: from plup8.prod.google.com ([2002:a17:903:4b28:b0:2eb:337a:cac])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90a:e70c:b0:3a8:6045:5a19 with SMTP id 98e67ed59e1d1-3b41cafcc05mr9926329a91.37.1795409394285;
 Sun, 22 Nov 2026 20:49:54 -0800 (PST)
Date: Mon, 23 Nov 2026 04:49:34 +0000
In-Reply-To: <20261123044949.3610702-1-skhawaja@google.com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
Mime-Version: 1.0
References: <20261123044949.3610702-1-skhawaja@google.com>
X-Mailer: git-send-email 2.56.1.809.ga0b61035b5-goog
Message-ID: <20261123044949.3610702-4-skhawaja@google.com>
Subject: [PATCH v8 03/18] iommu/pages: Add APIs to preserve/unpreserve/restore
 iommu pages
From: Samiullah Khawaja <skhawaja@google.com>
To: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Lu Baolu <baolu.lu@linux.intel.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	David Woodhouse <dwmw2@infradead.org>
Cc: Samiullah Khawaja <skhawaja@google.com>, Pranjal Shrivastava <praan@google.com>, 
	Ankit Soni <Ankit.Soni@amd.com>, Robin Murphy <robin.murphy@arm.com>, 
	Kevin Tian <kevin.tian@intel.com>, Alex Williamson <alex@shazbot.org>, Shuah Khan <shuah@kernel.org>, 
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	Pratyush Yadav <pratyush@kernel.org>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	David Matlack <dmatlack@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Vipin Sharma <vipinsh@google.com>, Nicolin Chen <nicolinc@nvidia.com>, John Starks <dev@jstarks.net>
Content-Type: text/plain; charset="UTF-8"

IOMMU pages are allocated/freed using APIs using struct ioptdesc. For
the proper preservation and restoration of ioptdesc add helper
functions.

Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
Reviewed-by: Pranjal Shrivastava <praan@google.com>
Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Ankit Soni <Ankit.Soni@amd.com>
---
 drivers/iommu/iommu-pages.c | 109 ++++++++++++++++++++++++++++++++++--
 drivers/iommu/iommu-pages.h |  30 ++++++++++
 2 files changed, 135 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/iommu-pages.c b/drivers/iommu/iommu-pages.c
index 3bab175d8557..0aa18c771baa 100644
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
 
@@ -131,6 +137,101 @@ void iommu_put_pages_list(struct iommu_pages_list *list)
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
+	if (!folio)
+		panic("Failed to restore preserved IOMMU page %llx\n", phys);
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
2.56.1.809.ga0b61035b5-goog

