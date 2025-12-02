Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42BCA2FFFB3
	for <iommu@lists.linux.dev>; Tue,  2 Dec 2025 23:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764716603; cv=none; b=jeIMdRhdKgxVXP6AX4doZLviUkl8LBd0oKi9kbBSfgnntYIU/iY1x095uiPcVJjnvXfTob2X10FNe9c9VtrLosZnR2+vIEJAYCePgSvzk5Kz9CHU7U0UbMc/g+CdrvF9WgKTqyo3kXJ0rClSJp9OfreINl8CiYKbjGBIGCTfhmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764716603; c=relaxed/simple;
	bh=wbS80YRzP6HQ1mk9Zgm1QNuvC4z9OIAWk5rpB+SP67s=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=IpS1iYXhXMZOy/6fwujdPplUposMGvPf40qsN1z7LQQOtvteY70WW2MGfcesNqZ0Om+4YbTIdZqVLax05jtG5H6mH6/U/pbWVCKsaDc9mmWEp8ceZArWSp3GUq9eBNmrp90YHdmYF3Wr1BnTxPpUZqnhUWWKWMz/0Jg3jxUR1nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=R/v4G36t; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="R/v4G36t"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2980ef53fc5so135222845ad.1
        for <iommu@lists.linux.dev>; Tue, 02 Dec 2025 15:03:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764716602; x=1765321402; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=pdgzhYNfjIdTL/eG3cF5Z6AQsPCrOwVXSPRWTTBl/Rw=;
        b=R/v4G36tAXJJpBVDVfQ4UDLgjnLaEAVrdyxku0zCTuRjtSnqpdxbyQ2QsB2xLL/fTr
         d3glvkuigBZ4V67Ul5NsOx2NXfQW4vo3UqBUeSfbIfx9yAOyBxOcnBm6QDfLNfBVoFcs
         b7jogCoUpuSNRy1NzayENoCzQKOpK1Nx3mcGvK+m1TSeLXkUk8+6ncVRSd/FfcIdRF7H
         +SlUuBUTrbqL6LlqfWsEnOgDhgShBHZAKUiS+LlfuxzL09jDl7nc38L0qguoAK1XUPTH
         3lXHGgmlwIAnSY3qJtohmBnyGWuv4R4+2Ns49YKnQG/JIcWthzeoBh6mcR1HDtJkXD8f
         nx+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764716602; x=1765321402;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pdgzhYNfjIdTL/eG3cF5Z6AQsPCrOwVXSPRWTTBl/Rw=;
        b=wjab0NEoVg+5zZ+N6rpacxDdgb3zgNwUmY485uKEneb/5TTfDD1pca5dhaWFV6j+Zn
         g1l8kTw+gzBTrqVTMxw/W6MliVBYxCFX+1JhwqUsc7/dMMMrUSAjNl+dx8Uet7s7yJGq
         wYRf/0CjT5r2Iwl3201UmLc87+9YIw9wtHjhwGVlLa7KXeBPIBauVzsJ9pZZlnuYBzch
         g5Uo5libcsyJTORor7KA9lchVF2mbFG6XNJ2whGPNURPRLH1fNkubQVn7fueMLw7yKIO
         t6aqWkc3kMQXqrYi7r/8kMTKRSKsHinmLm01K6ViYg8Zna6qnfAqyYMprqWMojCuJe9p
         9ceQ==
X-Forwarded-Encrypted: i=1; AJvYcCWGgSmCbnImPrT1L1/FzgoojjjZW6i2TOI5ePjipjRIyrNfL34qPDxd3G0+bz98rXUBVM8z0g==@lists.linux.dev
X-Gm-Message-State: AOJu0YxtmquWVjIv8fF6x2XBB5LdksrLmvtuoE8C6tHxPdE99RvewfdD
	xbLUYAq+pL8iL1uzh8wbeAlOvia9b9LM+JTo+gQAeJgfIIYpbZDYT6cYd8HAbF6juALb/skA3oo
	cmh9eLlbAFB03lA==
X-Google-Smtp-Source: AGHT+IHBhqwUWNFFs/zSxpUxLtaFweT97baBO05WXbNjXDrV/S+Y3+rnz+5xR7EyyF3jIBOeQtRiauGmHWkASg==
X-Received: from plbje22.prod.google.com ([2002:a17:903:2656:b0:29d:5afa:2c2])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:ef01:b0:295:425a:350e with SMTP id d9443c01a7336-29d682a9d76mr2117075ad.8.1764716601632;
 Tue, 02 Dec 2025 15:03:21 -0800 (PST)
Date: Tue,  2 Dec 2025 23:02:41 +0000
In-Reply-To: <20251202230303.1017519-1-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20251202230303.1017519-1-skhawaja@google.com>
X-Mailer: git-send-email 2.52.0.158.g65b55ccf14-goog
Message-ID: <20251202230303.1017519-12-skhawaja@google.com>
Subject: [RFC PATCH v2 11/32] iommu/pages: Add APIs to preserve/unpreserve/restore
 iommu pages
From: Samiullah Khawaja <skhawaja@google.com>
To: David Woodhouse <dwmw2@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>, 
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Jason Gunthorpe <jgg@ziepe.ca>, iommu@lists.linux.dev
Cc: Samiullah Khawaja <skhawaja@google.com>, Robin Murphy <robin.murphy@arm.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Kevin Tian <kevin.tian@intel.com>, 
	Alex Williamson <alex@shazbot.org>, linux-kernel@vger.kernel.org, 
	Saeed Mahameed <saeedm@nvidia.com>, Adithya Jayachandran <ajayachandra@nvidia.com>, 
	Parav Pandit <parav@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, William Tu <witu@nvidia.com>, 
	Vipin Sharma <vipinsh@google.com>, dmatlack@google.com, YiFei Zhu <zhuyifei@google.com>, 
	Chris Li <chrisl@kernel.org>, praan@google.com
Content-Type: text/plain; charset="UTF-8"

IOMMU pages are allocated/freed using APIs using struct ioptdesc. For
the proper preservation and restoration of ioptdesc add helper
functions.

Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
---
 drivers/iommu/iommu-pages.c | 70 +++++++++++++++++++++++++++++++++++++
 drivers/iommu/iommu-pages.h |  8 +++++
 2 files changed, 78 insertions(+)

diff --git a/drivers/iommu/iommu-pages.c b/drivers/iommu/iommu-pages.c
index 3bab175d8557..14669b0f498f 100644
--- a/drivers/iommu/iommu-pages.c
+++ b/drivers/iommu/iommu-pages.c
@@ -6,6 +6,7 @@
 #include "iommu-pages.h"
 #include <linux/dma-mapping.h>
 #include <linux/gfp.h>
+#include <linux/kexec_handover.h>
 #include <linux/mm.h>
 
 #define IOPTDESC_MATCH(pg_elm, elm)                    \
@@ -131,6 +132,75 @@ void iommu_put_pages_list(struct iommu_pages_list *list)
 }
 EXPORT_SYMBOL_GPL(iommu_put_pages_list);
 
+#if IS_ENABLED(CONFIG_LIVEUPDATE)
+void iommu_unpreserve_page(void *virt)
+{
+	kho_unpreserve_folio(ioptdesc_folio(virt_to_ioptdesc(virt)));
+}
+EXPORT_SYMBOL_GPL(iommu_unpreserve_page);
+
+int iommu_preserve_page(void *virt)
+{
+	return kho_preserve_folio(ioptdesc_folio(virt_to_ioptdesc(virt)));
+}
+EXPORT_SYMBOL_GPL(iommu_preserve_page);
+
+void iommu_unpreserve_pages(struct iommu_pages_list *list, int count)
+{
+	struct ioptdesc *iopt;
+
+	if (count < 0)
+		count = 0;
+
+	list_for_each_entry(iopt, &list->pages, iopt_freelist_elm) {
+		kho_unpreserve_folio(ioptdesc_folio(iopt));
+		if (count > 0 && --count ==  0)
+			break;
+	}
+}
+EXPORT_SYMBOL_GPL(iommu_unpreserve_pages);
+
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
+	order = folio_order(folio);
+	pgcnt = 1UL << order;
+	mod_node_page_state(folio_pgdat(folio), NR_IOMMU_PAGES, pgcnt);
+	lruvec_stat_mod_folio(folio, NR_SECONDARY_PAGETABLE, pgcnt);
+}
+EXPORT_SYMBOL_GPL(iommu_restore_page);
+
+int iommu_preserve_pages(struct iommu_pages_list *list)
+{
+	struct ioptdesc *iopt;
+	int count = 0;
+	int ret;
+
+	list_for_each_entry(iopt, &list->pages, iopt_freelist_elm) {
+		ret = kho_preserve_folio(ioptdesc_folio(iopt));
+		if (ret) {
+			iommu_unpreserve_pages(list, count);
+			return ret;
+		}
+
+		++count;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(iommu_preserve_pages);
+
+#endif
+
 /**
  * iommu_pages_start_incoherent - Setup the page for cache incoherent operation
  * @virt: The page to setup
diff --git a/drivers/iommu/iommu-pages.h b/drivers/iommu/iommu-pages.h
index ae9da4f571f6..ec1787776edd 100644
--- a/drivers/iommu/iommu-pages.h
+++ b/drivers/iommu/iommu-pages.h
@@ -53,6 +53,14 @@ void *iommu_alloc_pages_node_sz(int nid, gfp_t gfp, size_t size);
 void iommu_free_pages(void *virt);
 void iommu_put_pages_list(struct iommu_pages_list *list);
 
+#if IS_ENABLED(CONFIG_LIVEUPDATE)
+int iommu_preserve_page(void *virt);
+void iommu_unpreserve_page(void *virt);
+int iommu_preserve_pages(struct iommu_pages_list *list);
+void iommu_unpreserve_pages(struct iommu_pages_list *list, int count);
+void iommu_restore_page(u64 phys);
+#endif
+
 /**
  * iommu_pages_list_add - add the page to a iommu_pages_list
  * @list: List to add the page to
-- 
2.52.0.158.g65b55ccf14-goog

