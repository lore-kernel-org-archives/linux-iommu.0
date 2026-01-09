Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B56B9365A1A
	for <iommu@lists.linux.dev>; Fri,  9 Jan 2026 17:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767979102; cv=none; b=pu6ahJL1gBcUp+RewGCXVwqes160I+9N/SL8dicKYge2L1Wz7NtVfFV5/WKcAbK5Ks3qhWMvBvb5vCKRf1vJCs4797K1H9ncOpQ75O2PeTybH/2Xd9/BDhGzzDdV78PcyVjmIltpio/Pdi6Ap5nWKqCUnAN/9Tz+FCsv/Vai3Nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767979102; c=relaxed/simple;
	bh=0zzYxycXQ+kI4IOQMPNP1Taa4EJAWWJz6xTPzxIuMvU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tga5BNdu1BhHGaFpF3dVb4pGQfCTkAeqjwQx60XLhW2thjffSvanfFYup5WKENuLitGAAsoIpp4E2lLhObPDwsDjCUB8U6Q/67vzyfahDA4Car2st4nnCwA06Q3hJtbRkfItQSaDjsafIOy+izjF4v7eImXNDPjai6nTevvW/Zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xj7nSItu; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xj7nSItu"
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-477a11d9e67so30463285e9.2
        for <iommu@lists.linux.dev>; Fri, 09 Jan 2026 09:18:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767979096; x=1768583896; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z5ROaQbDPNg/Pz9koleFUeugi8CxogCP+iCj0oWGRhs=;
        b=xj7nSItuEPjTv+fYseLKLfNkkBM00h2YzUWGQAENaTZTtZo7V5aRLhGDE69fcvE5GG
         36ihg0hgRpU3aIzFCVgELFiegajejoQsV0nfuaa/l/7lJa4SOGwxbszh3/H354q/V9na
         K+1q6LYHschVD5bVcaswFAuYf0Y29suROLpcj38jSlXRxsOkOfOeeCxz/7uYP0+GptFC
         wvGdeILqNNiO7/jSNm5Ir0MpaJDeP7xaHyBof/T4icI2iCHlxzlhgvsH4TOdtxWdWTzo
         9dOkzIjpE/YD9Kj60Mwd9EOQTinkH6z0uGIwf+A6P0BkXOrdZRxiK153LtD41HHeQXFL
         LbyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767979096; x=1768583896;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Z5ROaQbDPNg/Pz9koleFUeugi8CxogCP+iCj0oWGRhs=;
        b=H3c18v3D3r8KRBwkMTIYvrV3mNXOUkmWHcMjnAHnC6w0acUGqIuiamWZ9zVBZ2XMXj
         7OP0I2WdxAW4rUq9x1ncmoYXJnYrH+OO1mwm1lJMmA7Hksm+jimczueDWdCOucivZINQ
         6I1r9KJdsP9kshWEFNMuwYEsdwGg9CkdJRGDrfG5jLtm3hLG88erGFtQOf51kwdy4PB9
         75Ov4lJ8zi4wLX/JpnhOcv8mGPszepyb8ZbX5U6JyXyJUM5uJPibbnXZgppHRIPj4QoW
         OOW6K+XqangHDP4czy5iSIuCii64TFdGvHkCtJSNQ8fQ2c7ynKKwMWQKHvpEzI5TEoMT
         RlJw==
X-Forwarded-Encrypted: i=1; AJvYcCUBTOxl3/PQi9BXfZkzcb8/jL+fzm+//0386mDA/W6VP7nuqYfqFR0/qsWB3J3XPgp8rxAPWg==@lists.linux.dev
X-Gm-Message-State: AOJu0YyXH0bQ8mzMbz9U26Y5na/+JmklqCQU7aWTfRKoRHDrW8pZsykB
	bU9Rm9dxy0E74Lt4idMBqDO5r/UyOgritUTP7e/UmJx2msQvJFM7F/LfxxFobvKdkr8EznOHD4w
	+rN8/hXQeImyAqw==
X-Google-Smtp-Source: AGHT+IGOoyMNz9SX5heA0+Ad8u3Mb3ue4F3q3Dm7Zb68ZiR2w+PZXKYiFFyi252YwvzslTXfx08Zaf+yul64YA==
X-Received: from wmcq2.prod.google.com ([2002:a05:600c:c102:b0:47b:daaa:51cf])
 (user=smostafa job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:458e:b0:47b:e29f:e067 with SMTP id 5b1f17b1804b1-47d84b0b21dmr111247725e9.6.1767979096375;
 Fri, 09 Jan 2026 09:18:16 -0800 (PST)
Date: Fri,  9 Jan 2026 17:18:05 +0000
In-Reply-To: <20260109171805.901995-1-smostafa@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260109171805.901995-1-smostafa@google.com>
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260109171805.901995-5-smostafa@google.com>
Subject: [PATCH v6 4/4] iommu: debug-pagealloc: Check mapped/unmapped kernel memory
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
Content-Transfer-Encoding: quoted-printable

Now, as the page_ext holds count of IOMMU mappings, we can use it to
assert that any page allocated/freed is indeed not in the IOMMU.

The sanitizer doesn=E2=80=99t protect against mapping/unmapping during this
period. However, that=E2=80=99s less harmful as the page is not used by the
kernel.

Reviewed-by: Samiullah Khawaja <skhawaja@google.com>
Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Mostafa Saleh <smostafa@google.com>
---
 drivers/iommu/iommu-debug-pagealloc.c | 23 +++++++++++++++++++++++
 include/linux/iommu-debug-pagealloc.h | 14 ++++++++++++++
 include/linux/mm.h                    |  5 +++++
 3 files changed, 42 insertions(+)

diff --git a/drivers/iommu/iommu-debug-pagealloc.c b/drivers/iommu/iommu-de=
bug-pagealloc.c
index 9eb49e1230ee..c080a38f45a4 100644
--- a/drivers/iommu/iommu-debug-pagealloc.c
+++ b/drivers/iommu/iommu-debug-pagealloc.c
@@ -9,6 +9,7 @@
 #include <linux/iommu-debug-pagealloc.h>
 #include <linux/kernel.h>
 #include <linux/page_ext.h>
+#include <linux/page_owner.h>
=20
 #include "iommu-priv.h"
=20
@@ -73,6 +74,28 @@ static size_t iommu_debug_page_size(struct iommu_domain =
*domain)
 	return 1UL << __ffs(domain->pgsize_bitmap);
 }
=20
+static bool iommu_debug_page_count(const struct page *page)
+{
+	unsigned int ref;
+	struct page_ext *page_ext =3D page_ext_get(page);
+	struct iommu_debug_metadata *d =3D get_iommu_data(page_ext);
+
+	ref =3D atomic_read(&d->ref);
+	page_ext_put(page_ext);
+	return ref !=3D 0;
+}
+
+void __iommu_debug_check_unmapped(const struct page *page, int numpages)
+{
+	while (numpages--) {
+		if (WARN_ON(iommu_debug_page_count(page))) {
+			pr_warn("iommu: Detected page leak!\n");
+			dump_page_owner(page);
+		}
+		page++;
+	}
+}
+
 void __iommu_debug_map(struct iommu_domain *domain, phys_addr_t phys, size=
_t size)
 {
 	size_t off, end;
diff --git a/include/linux/iommu-debug-pagealloc.h b/include/linux/iommu-de=
bug-pagealloc.h
index a439d6815ca1..46c3c1f70150 100644
--- a/include/linux/iommu-debug-pagealloc.h
+++ b/include/linux/iommu-debug-pagealloc.h
@@ -13,6 +13,20 @@ DECLARE_STATIC_KEY_FALSE(iommu_debug_initialized);
=20
 extern struct page_ext_operations page_iommu_debug_ops;
=20
+void __iommu_debug_check_unmapped(const struct page *page, int numpages);
+
+static inline void iommu_debug_check_unmapped(const struct page *page, int=
 numpages)
+{
+	if (static_branch_unlikely(&iommu_debug_initialized))
+		__iommu_debug_check_unmapped(page, numpages);
+}
+
+#else
+static inline void iommu_debug_check_unmapped(const struct page *page,
+					      int numpages)
+{
+}
+
 #endif /* CONFIG_IOMMU_DEBUG_PAGEALLOC */
=20
 #endif /* __LINUX_IOMMU_DEBUG_PAGEALLOC_H */
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 6f959d8ca4b4..32205d2a24b2 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -36,6 +36,7 @@
 #include <linux/rcuwait.h>
 #include <linux/bitmap.h>
 #include <linux/bitops.h>
+#include <linux/iommu-debug-pagealloc.h>
=20
 struct mempolicy;
 struct anon_vma;
@@ -4133,12 +4134,16 @@ extern void __kernel_map_pages(struct page *page, i=
nt numpages, int enable);
 #ifdef CONFIG_DEBUG_PAGEALLOC
 static inline void debug_pagealloc_map_pages(struct page *page, int numpag=
es)
 {
+	iommu_debug_check_unmapped(page, numpages);
+
 	if (debug_pagealloc_enabled_static())
 		__kernel_map_pages(page, numpages, 1);
 }
=20
 static inline void debug_pagealloc_unmap_pages(struct page *page, int nump=
ages)
 {
+	iommu_debug_check_unmapped(page, numpages);
+
 	if (debug_pagealloc_enabled_static())
 		__kernel_map_pages(page, numpages, 0);
 }
--=20
2.52.0.457.g6b5491de43-goog

