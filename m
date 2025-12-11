Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBC2D31280F
	for <iommu@lists.linux.dev>; Thu, 11 Dec 2025 12:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765457981; cv=none; b=cqn8PHj++UQZi3dBORt9rcYpmYuXfF92tKaHy6wjlR1um/YjDwIXhFiQ1cjIprz23gNApUH7S46bkhltR1i9ooW+lFlb1kU/E8Toe8vDReXAOt32vzEtO2VPOpGpG7/YTgRLlvq5ff/JoY3gm8JwejrCAg2HVL69rrL+tbp+gMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765457981; c=relaxed/simple;
	bh=3sl+EeKgoic1meY3AExo8vX55CuahumVE/hloKxx6Fs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=SVo0mGhIdnKLSzSWoX9S3M6r5mYsgUQkTlE4DHcNOMRx70IPC6cKI0tZXQIiypb8h7+0QKiS5COegVi6DSXv9nCrhne4HzexWKdE3mELc8RxrqdS+M3zF+ujJd/XtK3edVGvUbAKQlA8GMdoC2HXNBPOPZST7WglQ4A91qP7qdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZCPYkaAa; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZCPYkaAa"
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-477939321e6so430385e9.0
        for <iommu@lists.linux.dev>; Thu, 11 Dec 2025 04:59:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1765457978; x=1766062778; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z5uF5F4n44uHHmtIbXF2UG9WJO+vO8dPMrZl97vxG7I=;
        b=ZCPYkaAaUpldrytWOo6XV1Rv11HtdOXYCoU1bpRDx02OBXOPIzqzClXY73hY0mcn2P
         PacAC1NhecdyYv4QXCcUceHRobeEAXO4T8dNkrun6Qnv6L8exQj9tUNaeTDvLs5LcoQx
         KRELFsb9MBAbIE10hQLvGr/2rRGmhQbHx74EGjq1Ji+t+2vegUgupvwsZpbuZafeGcKm
         rjNN0nTr5IaSZmkQN6Oz3CHHBmg3DoyjUO/22ui5TIabXguQPJCtTBks067VTr9frclK
         hDE3CdRk8l/7Beq1v8zpAkH4+61hjy141lyGGPkWVszsdiKaNPyMNUvwOMK1rwpTdxZU
         ZQWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765457978; x=1766062778;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Z5uF5F4n44uHHmtIbXF2UG9WJO+vO8dPMrZl97vxG7I=;
        b=lknjApZsfvVtwuU7BfaszxM/g4kPGdABeXg7H6SeN/09xHWnuwsLYz7ZJ72nVRA7xW
         xcFqBV4JgAGK5+CbkBtnYeGFpkG/4fgyQIsmQ/JpJJs7uFzdYQfouu8XlV2f5FccDePa
         dZoYBQnNsH2HmxSIEUGA+tDRq3gdnq+Tl/cKY98vcZRzp4bKFeP10RJEO4ojxxGGpzzo
         f9W6PZdOBfkIfFvcXru0yppfNdj1wuqvyMWbwEPGtoRk1/PnBehOVf9Zguh8gVpUU65k
         gkBjdrTtOdlY1Bb90+no7ntS6mAokSd4ekdutjBTbYRuAHDPLjTQMYN2g6+rxjFBDVot
         aHrw==
X-Forwarded-Encrypted: i=1; AJvYcCVw8ah7ZSkhWwEzF8Fx7VygEdKfRF5QxOXln+JY/mia5bntb8ywyQ5gs/2yuVekWLX5PY2Jyg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy5QEcsKntNMoZKcw7l97Bn+/q8rDNOnBDnutzMuGQ0zO2hQT50
	ANilUgK08a/+66B4PCctQ6I8IHcZItdIX26PM1IBlpHlu56kXtpxQt3cdhY6RxODc+M1FzT76a/
	ObQ5xUzUWco8xkw==
X-Google-Smtp-Source: AGHT+IEzrlA/D2+Mzh+inyFuHFFtWJkme4dxyA7uMTZWAlUftjFK9QGFcKLMuEzVGMzE2aQGlGAf5icqRkZxhw==
X-Received: from wrvk5.prod.google.com ([2002:a5d:5185:0:b0:425:f04a:4d91])
 (user=smostafa job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:2087:b0:42b:4177:7136 with SMTP id ffacd0b85a97d-42fa3afd48dmr6497099f8f.32.1765457978004;
 Thu, 11 Dec 2025 04:59:38 -0800 (PST)
Date: Thu, 11 Dec 2025 12:59:28 +0000
In-Reply-To: <20251211125928.3258905-1-smostafa@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20251211125928.3258905-1-smostafa@google.com>
X-Mailer: git-send-email 2.52.0.223.gf5cc29aaa4-goog
Message-ID: <20251211125928.3258905-5-smostafa@google.com>
Subject: [PATCH v4 4/4] iommu: debug-pagealloc: Check mapped/unmapped kernel memory
From: Mostafa Saleh <smostafa@google.com>
To: linux-mm@kvack.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org
Cc: corbet@lwn.net, joro@8bytes.org, will@kernel.org, robin.murphy@arm.com, 
	akpm@linux-foundation.org, vbabka@suse.cz, surenb@google.com, mhocko@suse.com, 
	jackmanb@google.com, hannes@cmpxchg.org, ziy@nvidia.com, david@redhat.com, 
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, rppt@kernel.org, 
	xiaqinxin@huawei.com, baolu.lu@linux.intel.com, rdunlap@infradead.org, 
	Mostafa Saleh <smostafa@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Now, as the page_ext holds count of IOMMU mappings, we can use it to
assert that any page allocated/freed is indeed not in the IOMMU.

The sanitizer doesn=E2=80=99t protect against mapping/unmapping during this
period. However, that=E2=80=99s less harmful as the page is not used by the
kernel.

Signed-off-by: Mostafa Saleh <smostafa@google.com>
---
 drivers/iommu/iommu-debug-pagealloc.c | 23 +++++++++++++++++++++++
 include/linux/iommu-debug-pagealloc.h | 14 ++++++++++++++
 include/linux/mm.h                    |  5 +++++
 3 files changed, 42 insertions(+)

diff --git a/drivers/iommu/iommu-debug-pagealloc.c b/drivers/iommu/iommu-de=
bug-pagealloc.c
index 4639cf9518e6..424e00cd103b 100644
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
index 7a1819c20643..3763b71a7d3e 100644
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
2.52.0.223.gf5cc29aaa4-goog

