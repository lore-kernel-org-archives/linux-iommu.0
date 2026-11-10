Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.70
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794283716;
	b=kAq5VAPLMm/+HYitlBb4QrPpXIYEPHm9xu5fDspV7Gd+sRLg3ZFoGcy9ldEIabz7j2Bv
	 s7O0vGvkALL/3cAQQT/39DshDF9+WRxtzLA4I2lfm0cD1oJ2OHybjgrVhM0XsLiDpSM/+
	 jv6CXnt0ZgRgpcWA35sbw5Iy1m02ovOITRXcruEXwxYtKVpbozvBH4JkpGrzZ2HT5eYXd
	 oN2SwUMhBp5gnFnadOENwtPr4icGz6jSztsYsYlikOhF3twUiwhn5BMb5qxI9lZk6S09E
	 HNYYkTHXOsz6dU1PaY5Yxbq+QVvx78AjOLFBSgYLSUpxQ4GuSHS/jOa4s+3k59/yIqQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794283716;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=uMd6uU1Ewixftd9E5ZXDo/AGJ0QrsvaDjKM9cvmsWw4=;
	b=fu7vpmEvz4xNJOgeSLQNWoJy2pJVI10FFVkJGB3BhrRYOYg07Az20wlrHaDMZWTUFQy4
	 UMU5L16S626+llJMQCk1fdt+O4m728OKGmeJf9ep0BBNhvnFo0WlBxv83nI2fa4tCJ42V
	 6+0wYq+u8BgzVGWGMMzFRYXyoxkQ9364v57n5k+vjn9dazxFjsexpuicbC2/SkyRqB3Mv
	 ht69NILcnKF2X6p/u1qZRoj4DtUAnIO9HHrAeFdhDoZn6XbKZPHQ2mB5ygyIreWXbX802
	 lY5R6KoOiJmjDXbosEpz9aOorgK87ThAonk/wTuQf/koX0W5wsjdWKCzxBsv9DoHw+Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=WaKtw3f8;
	arc=none smtp.remote-ip=209.85.210.70
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com [209.85.210.70])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2DEF606A33E
	for <iommu@lists.linux.dev>; Tue, 10 Nov 2026 04:08:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A2DEF606A33E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=WaKtw3f8
Received: by mail-ot1-f70.google.com with SMTP id 46e09a7af769-844bc76180bso2124742a34.2
        for <iommu@lists.linux.dev>; Mon, 09 Nov 2026 20:08:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794283715; x=1794888515; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uMd6uU1Ewixftd9E5ZXDo/AGJ0QrsvaDjKM9cvmsWw4=;
        b=WaKtw3f8LxHSde85rB8vrjWz1xxfcaWmdwA/XLafRbFUb9r69dMguyiUl7drs5koaG
         9LqfZ6u2QJtysOGlu96qBQg9wkLLmvoQ8vbPmSuy8hwNkrwVDoIBoPTzzWS1uZ8cV2FA
         nB1PdEIgesS1tTLAXKsChnX8W+IpFY8U3HIHGQZdgvo0HHAO5BQ+wkAC8eiD0QHhhlPe
         jdgaSf+wItGmjHrCKEqucuv6K/rYllonn62TBkPq+zwtr2/2JAQt0yIQ5KfmSE7cb213
         vxdMdjbUeJKuCmc0b0hxgzsh758Q4BbXbUC3qWdPSDMYxRgVcJixpPjkwfjetxR1Xvm/
         FPXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794283715; x=1794888515;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uMd6uU1Ewixftd9E5ZXDo/AGJ0QrsvaDjKM9cvmsWw4=;
        b=FH0qBCNFFpgla8OQ7TDjAUinriI2OxCT7oEKeum9WY10KcogqIpoJwHrBCLpWNd4Cv
         fz5E0tBFybbqwVsl+xx2He3MHEVx0ZBXlnbU+5Ch+qrmCwZgdTisK+g4tKkJNdBS2ii6
         xa1bkyU1+Hb4ykLjc7pE/E3+OVA0p8drXDR9BKgJVNZT0Sh6VzcoOIuxqw6ZQ1eHlAT+
         ZgLiS62uRD2eYkqFTMnaW9+c1v1yHQ2/dYvViAsbPiUkeZCAqw4DW57fIT7lRtg75+Eq
         DKyEopXdGC/zNvlpPqxZm7boij3tFGawbbb5/fEDMgKIegRlyqTReJObavNL+twFf+p8
         0gjA==
X-Forwarded-Encrypted: i=1; AL+hErFrqu9J7F5+Lh1OMqXq1F53kMkCX33o5trBNNUDQRF1FekmVmMtRHVM1HUPJkgKRR/u9Eh34Q==@lists.linux.dev
X-Gm-Message-State: APuU4Z+SjYZljObPdqLBkc1OucYC15QJr7agOdpJ8yI/z2pHFgAVRnZB
	4AmOaH1nKKf7VyoMgfUtlJ4AJBj5fY90K9m1mIBUSpcaQMTMBjGoP+nwPBaS0BGKFvNMigRD17y
	ZGfd3gGTcgpV8hg==
X-Received: from iobi4-n1.prod.google.com ([2002:a05:6602:c684:10b0:9d3:b408:7991])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6808:bd6:b0:4ec:d580:2440 with SMTP id 5614622812f47-5683cb3907cmr1189129b6e.54.1794283714349;
 Mon, 09 Nov 2026 20:08:34 -0800 (PST)
Date: Tue, 10 Nov 2026 04:08:08 +0000
In-Reply-To: <20261110040828.1774343-1-skhawaja@google.com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
Mime-Version: 1.0
References: <20261110040828.1774343-1-skhawaja@google.com>
X-Mailer: git-send-email 2.56.0.506.g506a7eabc5-goog
Message-ID: <20261110040828.1774343-3-skhawaja@google.com>
Subject: [PATCH v7 02/18] iommu/pages: Add APIs to preserve/unpreserve/restore
 iommu pages
From: Samiullah Khawaja <skhawaja@google.com>
To: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Lu Baolu <baolu.lu@linux.intel.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	David Woodhouse <dwmw2@infradead.org>
Cc: Samiullah Khawaja <skhawaja@google.com>, Pranjal Shrivastava <praan@google.com>, 
	Robin Murphy <robin.murphy@arm.com>, Kevin Tian <kevin.tian@intel.com>, 
	Alex Williamson <alex@shazbot.org>, Shuah Khan <shuah@kernel.org>, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	Pratyush Yadav <pratyush@kernel.org>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	David Matlack <dmatlack@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Vipin Sharma <vipinsh@google.com>, Ankit Soni <Ankit.Soni@amd.com>, 
	Nicolin Chen <nicolinc@nvidia.com>, John Starks <dev@jstarks.net>
Content-Type: text/plain; charset="UTF-8"

IOMMU pages are allocated/freed using APIs using struct ioptdesc. For
the proper preservation and restoration of ioptdesc add helper
functions.

Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
Reviewed-by: Pranjal Shrivastava <praan@google.com>
Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
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
2.56.0.506.g506a7eabc5-goog

