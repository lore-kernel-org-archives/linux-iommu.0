Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CCC1376BFF
	for <iommu@lists.linux.dev>; Tue,  3 Feb 2026 22:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770156600; cv=none; b=BxI3FYW/7zp9N6JyawpXttgjmlqaWi0UgqUU73LCiIoHEa7x5IUL8ZpJUVbGPNEKd0tZH48fGLHJmmj9f9tvH+P8bRKe+Hl5e0/VmlOhyNa0GfQSwruDpuxh7CkS45AtxMj/rcPDOLa65ERZWag9ZzI1fbAozxWlsR8m9658v0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770156600; c=relaxed/simple;
	bh=5oimeBpjR9ySAyBwN7duv7K3nB4HOiM5cRVJaWv274o=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=PNp73IhyZyZZHMUopXf0ZScZHiKYGdnzoA2zqwofQpsErupx3B4H72kb13cZhH4gC0kAEJyZKIaoRSAEFuzztu2U36N2FTYORi4hNTpUDn56CorYXylORvMxNOBqYdAXOliE/dF3SSsT/fX5LJ+SKKHNrEPt/rybpJ7jL03/VPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=32/TSImf; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="32/TSImf"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2a76f2d7744so60077135ad.3
        for <iommu@lists.linux.dev>; Tue, 03 Feb 2026 14:09:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770156597; x=1770761397; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Lp/+9SAp3L8mfYjwbkh3T/evpw/YswqyzsO+xOxb2eg=;
        b=32/TSImf2Cvu+5nxazQBQNwLiPIgFhiiwjwMtS2BAoO6a5DLJrUkyBRV9NnoVjKNkl
         /OcfEdpbYiiz8L0XI8KQAea8ySDIQ8t8e9xOCEgoWLIuIrWOKS90aO6gzx+FQ7SRJfXy
         BzGS3CtnJSyVb+kCWd4WAHCj2BC4Popds2xeRwWkrZwbCPFrzkCD9R8bXeXW5ACPiWg+
         GcMVcSODlf5RHzxMA29VQNXuujXoIrpyhXgWWQOAIIIS0fNAGBPDoSH+1kd3bh8/NuUj
         vI2ojY6PwFw0I7DRaZ6ydFzjH+yViKeGtAjEcVfn1JebVHuK8CgeaQtWnFmMkaraMwx+
         fNQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770156597; x=1770761397;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Lp/+9SAp3L8mfYjwbkh3T/evpw/YswqyzsO+xOxb2eg=;
        b=babX/sPpWWgIM80inW4VXym4cIrv/0mhrIfTe5QkCinenq5HEO4jX8yLIrLp61p0Ue
         sumlT5B2ba5/g3et/fex9uMp2HYFQSDtHSTy9CHAH8E5ek8hruKdKMhnuySgX0hdpoSW
         pRp+G8EPI/cKLMYVHlS9Ihw8U5pQREVWO+2NAo3jdYHCkBcOSQZgy/gL8SlN8KodobZy
         l6vI1ON2V5DSudMct+aaiaHqkRIRnANZpkOjb3M4lXNNRp8Mi6CZSHnNZGI+z5oMIGgI
         eqSInwG6EbWAQQyUcoHLSmRrCIIGWjdu5oZtYgTzHXthfpUkoTqpLt5JSjTAKyF3NJbm
         io8Q==
X-Forwarded-Encrypted: i=1; AJvYcCUKyDkHinnAujQYaL29q5i7W66uaceB4I7k6Hqzy1sDBIM0GecwG7atuOcWVSKT9x+x7edIcw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyyC508TgsTuNK0tWR/cbcxr2MrT4g3xhtvWotgYMM0HxMTpKB8
	OcizFVc10WJuiEtbGbGsjcmjCoNGFdsTGB6wphBdfuGa26dGv2VKIozmt1wKUdNJEyHP2wg/u5v
	q1JgTlzM/Iv5bJA==
X-Received: from plbmf3.prod.google.com ([2002:a17:902:fc83:b0:2a1:1c0e:70b9])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:c411:b0:295:b46f:a6c2 with SMTP id d9443c01a7336-2a933fba80bmr6525215ad.37.1770156597010;
 Tue, 03 Feb 2026 14:09:57 -0800 (PST)
Date: Tue,  3 Feb 2026 22:09:38 +0000
In-Reply-To: <20260203220948.2176157-1-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260203220948.2176157-1-skhawaja@google.com>
X-Mailer: git-send-email 2.53.0.rc2.204.g2597b5adb4-goog
Message-ID: <20260203220948.2176157-5-skhawaja@google.com>
Subject: [PATCH 04/14] iommu/pages: Add APIs to preserve/unpreserve/restore
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
 drivers/iommu/iommu-pages.c | 74 +++++++++++++++++++++++++++++++++++++
 drivers/iommu/iommu-pages.h | 30 +++++++++++++++
 2 files changed, 104 insertions(+)

diff --git a/drivers/iommu/iommu-pages.c b/drivers/iommu/iommu-pages.c
index 3bab175d8557..588a8f19b196 100644
--- a/drivers/iommu/iommu-pages.c
+++ b/drivers/iommu/iommu-pages.c
@@ -6,6 +6,7 @@
 #include "iommu-pages.h"
 #include <linux/dma-mapping.h>
 #include <linux/gfp.h>
+#include <linux/kexec_handover.h>
 #include <linux/mm.h>
 
 #define IOPTDESC_MATCH(pg_elm, elm)                    \
@@ -131,6 +132,79 @@ void iommu_put_pages_list(struct iommu_pages_list *list)
 }
 EXPORT_SYMBOL_GPL(iommu_put_pages_list);
 
+#if IS_ENABLED(CONFIG_IOMMU_LIVEUPDATE)
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
+	if (!count)
+		return;
+
+	/* If less than zero then unpreserve all pages. */
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
index ae9da4f571f6..bd336fb56b5f 100644
--- a/drivers/iommu/iommu-pages.h
+++ b/drivers/iommu/iommu-pages.h
@@ -53,6 +53,36 @@ void *iommu_alloc_pages_node_sz(int nid, gfp_t gfp, size_t size);
 void iommu_free_pages(void *virt);
 void iommu_put_pages_list(struct iommu_pages_list *list);
 
+#if IS_ENABLED(CONFIG_IOMMU_LIVEUPDATE)
+int iommu_preserve_page(void *virt);
+void iommu_unpreserve_page(void *virt);
+int iommu_preserve_pages(struct iommu_pages_list *list);
+void iommu_unpreserve_pages(struct iommu_pages_list *list, int count);
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
2.53.0.rc2.204.g2597b5adb4-goog

