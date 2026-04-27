Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04CF13E9589
	for <iommu@lists.linux.dev>; Mon, 27 Apr 2026 17:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777312607; cv=none; b=tXtQsKk7psgkDdkAi40ZoekMF4h0HzTJgd5E+rMuntN2ql0R0q929f3Cm8gSaEgw6DabJGEcdcxHLXefeOZknWDHDdxmLnu6oQ1I11yltyqQyfda8lTlb32DN5B0AMNgTlYS/MYCv5tpulHTWxj7B3Df/2tYPewQrxlkCzWY7jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777312607; c=relaxed/simple;
	bh=ATCarjiEqzHx7LDveLm2yBVp2zFHpaNFt5llkjd3Ckg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qJUXwsU9qBMg/tXKXprXZhcmifjgnWhgwxPcQQJCpnpDB5n3kwokRGi+2RhFcNR2QN30dfK+DazUOFwaA3U5Chjub0VyyQ8wMPqLnAr1LInkCYYCtTX8jAM77fwMJnkAtlSAK1B4f5RwDO3uIl7GB7fxortUB+beRrJDdQ28gcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HTozYrgE; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HTozYrgE"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-82f07078eaaso7974246b3a.0
        for <iommu@lists.linux.dev>; Mon, 27 Apr 2026 10:56:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777312604; x=1777917404; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=i7gYeH/lHe4hDFDlIxOksTDFIFSqb1DPwjKnJo7j/DQ=;
        b=HTozYrgE9qBCj5DmpUeqi5a4ZVHsPMzBvHIZDNbcoqDahJJpXmC7kF3JWunKdbIW3k
         dY9kBZ6g0GMqUKq1i5mgV7jwwIrqpmFMZsslIELBFI7xoq6/jrMxHHL0JtiJ7KINsi9P
         XnWOVjyvw2MmhYJaL6JipXU0ZZtbD+/p2RARICM16T+p07DKamq5G6U0Nr4H7NkCq3GP
         DDtTHXEsO1zSBw6QR5vVNoH3lqz+COw8pWPw+v184lcDvntACvpbf4ByVy8JA4vQit0U
         geuXO2YTAgrwQdYrZfHnrUE3oGN2H/8enU2CSPVS84XIf4ivVI6FU+NTPRI52U97GYNM
         tbxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777312604; x=1777917404;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i7gYeH/lHe4hDFDlIxOksTDFIFSqb1DPwjKnJo7j/DQ=;
        b=gol/MMi0wkcCa49h9AmqOwWOUmR7GYODowPNi6oHmYdxb9Y+qLojfWBBwqmN+QD87R
         xfU/1aDCX/SPaKxsAH+0xc90b3zVF1O8nHdKwqHaImXBBc8ekHRPJsa0bZ47JEoIdtf2
         +hnwkDmVGdYgN5k0q2THatKkMeLDqrSkFvX4qzuEBx5QAgda/Btk4vuzbNysX49L8eUy
         ypITpmQcHfy7UEaTtaoymN+23g5C6tkTEDSp1asUpSY0Wfe8zdPmH1qMLdFOspSho6rX
         d5SS0dFYTpKHYfGSlf3DrTlw2cUc3qpN+dLUyPLbREf4qNbDjN+d/CMKVn7OCiHjFJm/
         x9ng==
X-Forwarded-Encrypted: i=1; AFNElJ9/Vn9iBiX2eaqhfjMBJf+bwBRNBXTBWAgG1NQrj5ncB7AlEu1ryDBpdVNPkTsaf75JwpeuMA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxxI5RM+fvvZbmCzjdrGNmHCGz1vhL0Sg9pRtkUGFhGPVkhIfej
	7XKV34jKbvnBxbARGuH4aPyWIaGUSsHGfEVJBHt+2rkNaGrI6IthTYTWXpOX6Biu1yQJzTv/7Bj
	Ebo+QEPseZ6Lrww==
X-Received: from pfod24.prod.google.com ([2002:aa7:8698:0:b0:82f:b853:3ba7])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:12c1:b0:82f:44dc:f85c with SMTP id d2e1a72fcca58-834dc2c1cf1mr8043b3a.34.1777312603915;
 Mon, 27 Apr 2026 10:56:43 -0700 (PDT)
Date: Mon, 27 Apr 2026 17:56:22 +0000
In-Reply-To: <20260427175633.1978233-1-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260427175633.1978233-1-skhawaja@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260427175633.1978233-6-skhawaja@google.com>
Subject: [PATCH v2 05/16] iommu/pages: Add APIs to preserve/unpreserve/restore
 iommu pages
From: Samiullah Khawaja <skhawaja@google.com>
To: David Woodhouse <dwmw2@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>, 
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>
Cc: Samiullah Khawaja <skhawaja@google.com>, Robin Murphy <robin.murphy@arm.com>, 
	Kevin Tian <kevin.tian@intel.com>, Alex Williamson <alex@shazbot.org>, Shuah Khan <shuah@kernel.org>, 
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	Saeed Mahameed <saeedm@nvidia.com>, Adithya Jayachandran <ajayachandra@nvidia.com>, 
	Parav Pandit <parav@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, William Tu <witu@nvidia.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	David Matlack <dmatlack@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Chris Li <chrisl@kernel.org>, Pranjal Shrivastava <praan@google.com>, Vipin Sharma <vipinsh@google.com>, 
	YiFei Zhu <zhuyifei@google.com>
Content-Type: text/plain; charset="UTF-8"

IOMMU pages are allocated/freed using APIs using struct ioptdesc. For
the proper preservation and restoration of ioptdesc add helper
functions.

Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
---
 drivers/iommu/iommu-pages.c | 108 ++++++++++++++++++++++++++++++++++--
 drivers/iommu/iommu-pages.h |  30 ++++++++++
 2 files changed, 134 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/iommu-pages.c b/drivers/iommu/iommu-pages.c
index 3bab175d8557..b1ffeb930e6d 100644
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
+ * iommu_unpreserve_page - Unpreserve a page that was preserved in KHO
+ * @virt: Virtual address of a page
+ */
+void iommu_unpreserve_page(void *virt)
+{
+	kho_unpreserve_folio(ioptdesc_folio(virt_to_ioptdesc(virt)));
+}
+EXPORT_SYMBOL_GPL(iommu_unpreserve_page);
+
+/**
+ * iommu_preserve_page - Preserve a page during kexec handover
+ * @virt: Virtual address of the page to preserve
+ *
+ * Returns 0 on success, negative error on failure
+ */
+int iommu_preserve_page(void *virt)
+{
+	return kho_preserve_folio(ioptdesc_folio(virt_to_ioptdesc(virt)));
+}
+EXPORT_SYMBOL_GPL(iommu_preserve_page);
+
+/**
+ * iommu_unpreserve_pages - Unpreserve pages that were preserved in KHO
+ * @list: List of pages to unpreserve
+ */
+void iommu_unpreserve_pages(struct iommu_pages_list *list)
+{
+	struct ioptdesc *iopt;
+
+	list_for_each_entry(iopt, &list->pages, iopt_freelist_elm)
+		kho_unpreserve_folio(ioptdesc_folio(iopt));
+}
+EXPORT_SYMBOL_GPL(iommu_unpreserve_pages);
+
+/**
+ * iommu_restore_page - Restore a page that was preserved in KHO
+ * @phys: Physical address of a page
+ */
+void iommu_restore_page(u64 phys)
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
+EXPORT_SYMBOL_GPL(iommu_restore_page);
+
+/**
+ * iommu_preserve_pages - Preserve pages during kexec handover
+ * @list: List of pages to preserve
+ *
+ * Returns 0 on success, negative error on failure
+ */
+int iommu_preserve_pages(struct iommu_pages_list *list)
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
+EXPORT_SYMBOL_GPL(iommu_preserve_pages);
+#endif
+
 /**
  * iommu_pages_start_incoherent - Setup the page for cache incoherent operation
  * @virt: The page to setup
diff --git a/drivers/iommu/iommu-pages.h b/drivers/iommu/iommu-pages.h
index ae9da4f571f6..7b9b6bb504b2 100644
--- a/drivers/iommu/iommu-pages.h
+++ b/drivers/iommu/iommu-pages.h
@@ -53,6 +53,36 @@ void *iommu_alloc_pages_node_sz(int nid, gfp_t gfp, size_t size);
 void iommu_free_pages(void *virt);
 void iommu_put_pages_list(struct iommu_pages_list *list);
 
+#if IS_ENABLED(CONFIG_IOMMU_LIVEUPDATE)
+int iommu_preserve_page(void *virt);
+void iommu_unpreserve_page(void *virt);
+int iommu_preserve_pages(struct iommu_pages_list *list);
+void iommu_unpreserve_pages(struct iommu_pages_list *list);
+void iommu_restore_page(u64 phys);
+#else
+static inline int iommu_preserve_page(void *virt)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline void iommu_unpreserve_page(void *virt)
+{
+}
+
+static inline int iommu_preserve_pages(struct iommu_pages_list *list)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline void iommu_unpreserve_pages(struct iommu_pages_list *list, int count)
+{
+}
+
+static inline void iommu_restore_page(u64 phys)
+{
+}
+#endif
+
 /**
  * iommu_pages_list_add - add the page to a iommu_pages_list
  * @list: List to add the page to
-- 
2.54.0.545.g6539524ca2-goog

