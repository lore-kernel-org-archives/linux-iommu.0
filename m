Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61D4B3A63E6
	for <iommu@lists.linux.dev>; Wed, 14 Jan 2026 16:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768409018; cv=none; b=UjrNQ1bjELssoYX1HJha+ghhPDUihOYn75NwJSAg80AA6WUl4By4cfESHIXGCbRUiYrrDXWRAzm+SqsQA8HWfs58QRyY+BGbO7Pnceh0wo7JwpyemrhFM3t7+izycQ6Ol/o4PkbJ/09qNUJFRnb70Q+d46WsbZ/KCnoZKlrwxB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768409018; c=relaxed/simple;
	bh=dzaYjfbIZZavp/S2MnKk+6oK1c7oQVF6rcvC3rrGw2Q=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=YZ5Asamq1yebjSCAUNw8t5YDlbWkMJUN0zI+pOUjPozSA50gp73EwOYE4yGAU6K6B+2nZLETjuylWF0jDeKhmXYCuISBP+ov+n4/XSclcFD+s8+5NNmJBj541IPlKMogMnl+XLRu4QdPO1TllUOXlYy20aK+j2QZEqtUp8KGClg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0VPBtFmo; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0VPBtFmo"
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-432db1a9589so33146f8f.0
        for <iommu@lists.linux.dev>; Wed, 14 Jan 2026 08:43:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768409015; x=1769013815; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lp9W32Kped56Je6lvPD7Xlxv6Ozf5Aka/rllxnPof5w=;
        b=0VPBtFmoesEWaHM1H79ZnwzL4VlLn/urHKbc8nGlDdRfGJ6uuCuKvYCk02dU/eqmRG
         r6GuOxXJu/D8ZO7qxg7gqjk8nClCcUsg8BIEa2cml8JZO9Lj6RGdVoLXdxPP0ipJA1lf
         hSV5ZZ9d3BLx89vj52ip8HPtU/MzbODpdKhziDaajD8lwO8l+WXbGWcxO0pS9q7Vzqpv
         nh+0Bes9VFsNsQT+C3M1dlHpAwP+rrDr5LoiVELCJQuOqReL1xaz7ve/zHdU0mbO9YEt
         hMUFfulTWCSsnLKm6r2K2PEc39RF+A1qm+OIMLwP3BLvKTqVmxxYgYqBp2OoJEu0lI12
         WmHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768409015; x=1769013815;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=lp9W32Kped56Je6lvPD7Xlxv6Ozf5Aka/rllxnPof5w=;
        b=gdy1CTNHbXLM2aW0NblI27Mp4cYblVrVgeJNvrp7JoBbP8GnXkM0MFa7SB22cAmH0A
         PR+UAV1XQzZxi698IaP31jHhKhrffICr17jnkLFmbRWd2rn1wF46w5G/q2pTpdxnuUVU
         jfKeem7LyCQZS5/jTB/AdiE32Oz47Q6qMONUHx9fmH1sxNVfHFign9R4bMS2l9p57F4F
         P/vbs4E1rRZCd+0StbFbnpf4qqhoKxCiLmWQ3eJ836u1H3xGE87Bguo0v8Hn+qXQhKc9
         eDbbpxDfI/zhnRpL+lzbp9FnZPOzK6R9cuoC1s2bA//eQt5GtqKSjnO4lSbdv6nTWVyD
         UCaQ==
X-Forwarded-Encrypted: i=1; AJvYcCWwP5fNtr3oFERz6yCN7bjs3jFN4p6EUi/dad68JTyC0PeJFL3p5Cb0y9ISL2lwgJnGPfD+YA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwezMXQxJ8p6a5J95J7eSDHntQCCUgjljyNMcLhS2sdA6BQhFIj
	5QwWTqyR2nnBvuzWMefSREeY1XSCtJLd8de3Ofi6Q3fW9fAEMs/MsJiI62VLr62SsIPhv/LJphy
	wc4oBmmVOoCP7Cg==
X-Received: from wmbd23.prod.google.com ([2002:a05:600c:58d7:b0:477:9654:b44c])
 (user=smostafa job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:5285:b0:477:7ab8:aba with SMTP id 5b1f17b1804b1-47ee32e0be0mr36180785e9.1.1768409014935;
 Wed, 14 Jan 2026 08:43:34 -0800 (PST)
Date: Wed, 14 Jan 2026 16:43:22 +0000
In-Reply-To: <20260114164322.787125-1-smostafa@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260114164322.787125-1-smostafa@google.com>
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260114164322.787125-6-smostafa@google.com>
Subject: [PATCH v7 5/5] iommu: debug-pagealloc: Check mapped/unmapped kernel memory
From: Mostafa Saleh <smostafa@google.com>
To: linux-mm@kvack.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org
Cc: corbet@lwn.net, joro@8bytes.org, will@kernel.org, robin.murphy@arm.com, 
	akpm@linux-foundation.org, vbabka@suse.cz, surenb@google.com, mhocko@suse.com, 
	jackmanb@google.com, hannes@cmpxchg.org, ziy@nvidia.com, david@redhat.com, 
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, rppt@kernel.org, 
	xiaqinxin@huawei.com, baolu.lu@linux.intel.com, rdunlap@infradead.org, 
	Mostafa Saleh <smostafa@google.com>, Samiullah Khawaja <skhawaja@google.com>, 
	Pranjal Shrivastava <praan@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Now, as the page_ext holds count of IOMMU mappings, we can use it to
assert that any page allocated/freed is indeed not in the IOMMU.

The sanitizer doesn=E2=80=99t protect against mapping/unmapping during this
period. However, that=E2=80=99s less harmful as the page is not used by the
kernel.

Reviewed-by: Samiullah Khawaja <skhawaja@google.com>
Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Pranjal Shrivastava <praan@google.com>
Signed-off-by: Mostafa Saleh <smostafa@google.com>
---
 drivers/iommu/iommu-debug-pagealloc.c | 23 +++++++++++++++++++++++
 include/linux/iommu-debug-pagealloc.h | 14 ++++++++++++++
 include/linux/mm.h                    |  5 +++++
 3 files changed, 42 insertions(+)

diff --git a/drivers/iommu/iommu-debug-pagealloc.c b/drivers/iommu/iommu-de=
bug-pagealloc.c
index 3ce3385588b2..a283b5dbe26f 100644
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
@@ -75,6 +76,28 @@ static size_t iommu_debug_page_size(struct iommu_domain =
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

