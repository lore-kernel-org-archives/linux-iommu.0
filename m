Received: from mail-ed1-f73.google.com (mail-ed1-f73.google.com [209.85.208.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49DCA32E6A8
	for <iommu@lists.linux.dev>; Mon, 24 Nov 2025 20:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764014906; cv=none; b=jR61iOSIolftrzKTz89Q7IHqkID8GWVgcEfbyZB0ng5CqzF4kl0Xx/5uoxEQAzQPm3/TF9Wd3Ep5WigLH3nOJMPEEjSGAxvx33KfBgRyGgKlzsTx/IZDux3PdBoiWtsKeWPWn+xJAujSczJJ42WumNBiYzYisvAB4x15sL+lwu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764014906; c=relaxed/simple;
	bh=O8Koz3AbdH0zY/93LMrN2NnYfabvIvEIDenhNeorr4U=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=FkvNFNR6UJuVHnKuOGp168dcruPsK/3ohNLNotadpa0lEA+2xOT1OJ4oYroxC4ODhsiPaOLgfzModN+2D+xwefbWroRD1GCJKEwzwuQHhZqDEGQVb8QsXpnYqPVkP5twPjZRuYwuD4Ai0/6JWIHkCQ4WzMCPUUJV3EakAxkLjhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LOOQMkUX; arc=none smtp.client-ip=209.85.208.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LOOQMkUX"
Received: by mail-ed1-f73.google.com with SMTP id 4fb4d7f45d1cf-6450f3e7e71so4229688a12.3
        for <iommu@lists.linux.dev>; Mon, 24 Nov 2025 12:08:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764014902; x=1764619702; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3xSmEu5ZIQLRYpzloFi758DLZmW8jyYxJ7x9EopwKAk=;
        b=LOOQMkUXDMmnYwpkvZ95v+6sQNG1J/T272bJ/aNfdWf016l4spIc7xfbL+xg6nQi9C
         rNtxGVctUlSNym19Paf+cZvaJTb/jmaH7Y0OQGGo9O06U1qsvNsU733opI8S5IKukxp2
         fptu3I1aFawE+aE7xeBrsKziPo3gTHWflqgnDTa+5iYsdHVASQFtZ95g0hgIbX/M4uE/
         GKraWOpQFi0TzrJX+DpHpbH0csxVC/D8EnL3FMywOyYRjymU5rhj9as3VN8r0WXpOJG5
         FbwbFamW0NTkmeOjFmBhg2gItrbNkwFUOue1CJoMe46BFxNLcJRvzZVISW0e6ufKfEcy
         B/Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764014902; x=1764619702;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3xSmEu5ZIQLRYpzloFi758DLZmW8jyYxJ7x9EopwKAk=;
        b=hODIvfNQ/wRgAt70U5G70e1xWjELdeRfkmfDDtxb8KMVlp5vp8DpsYQjraniC1ZqCl
         r/kiCZrZQp7aFmM24PXRD7QezPXaurfzLqmCWyiE3WV+9t7MAhE6DuIc7AdVunYBlfiE
         qloR+DfbMIhKJCBtGZIn5TufOUkqajcXkYIlTAhsDxJQkwJZ+MvPf6MglJbPwnce87f8
         8G22o8W5RPvhPHXlXjsJfBgUxSEO3tusEHxSm8Qsct+8qPAJzDYCkgDlUsr9MozWgqXH
         KN4F9DB4KDJsmad5IE1bjf28QR7VHBJsRXUvXl6omw0XIjUXKKFyKwquQA77/0ALFOfP
         iJbQ==
X-Forwarded-Encrypted: i=1; AJvYcCX0aqyzjfy0mPNC9VKcaYa0JWu1ch5x+m9se0EiIFT8/Pq9aZD5Y41+yg+L4S+WRsAuYwxPJA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyHFpcWTMSWOpiMaRQbf+Ev3C51RDPv179mSCLNL18X349P6h/4
	upVAeAtSRYLhbNtmMqO2bTpdXBBXEg6dAT5HWmVlLw2UDO0NkQw4sD5L+6+WaHM+lGvg2lmSxk8
	UjXoaGeW42bsPyA==
X-Google-Smtp-Source: AGHT+IGX7qo6LNh60g3Sq15t12MDYxJDdl6W4Tqa/ummJmpe3KeIBfOpR/I35oLis22vg0LAmBuTLJWllweoYw==
X-Received: from edbin10.prod.google.com ([2002:a05:6402:208a:b0:641:6d32:a6d6])
 (user=smostafa job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:2687:b0:638:74dc:cf78 with SMTP id 4fb4d7f45d1cf-645eb79fd02mr191410a12.34.1764014901656;
 Mon, 24 Nov 2025 12:08:21 -0800 (PST)
Date: Mon, 24 Nov 2025 20:08:11 +0000
In-Reply-To: <20251124200811.2942432-1-smostafa@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20251124200811.2942432-1-smostafa@google.com>
X-Mailer: git-send-email 2.52.0.460.gd25c4c69ec-goog
Message-ID: <20251124200811.2942432-5-smostafa@google.com>
Subject: [PATCH v3 4/4] drivers/iommu-debug-pagealloc: Check mapped/unmapped
 kernel memory
From: Mostafa Saleh <smostafa@google.com>
To: linux-mm@kvack.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org
Cc: corbet@lwn.net, joro@8bytes.org, will@kernel.org, robin.murphy@arm.com, 
	akpm@linux-foundation.org, vbabka@suse.cz, surenb@google.com, mhocko@suse.com, 
	jackmanb@google.com, hannes@cmpxchg.org, ziy@nvidia.com, david@redhat.com, 
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, rppt@kernel.org, 
	xiaqinxin@huawei.com, Mostafa Saleh <smostafa@google.com>
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
 include/linux/iommu-debug-pagealloc.h | 12 ++++++++++++
 include/linux/mm.h                    |  5 +++++
 3 files changed, 40 insertions(+)

diff --git a/drivers/iommu/iommu-debug-pagealloc.c b/drivers/iommu/iommu-de=
bug-pagealloc.c
index c420b006ef08..8af11630d0e3 100644
--- a/drivers/iommu/iommu-debug-pagealloc.c
+++ b/drivers/iommu/iommu-debug-pagealloc.c
@@ -9,6 +9,7 @@
 #include <linux/iommu-debug-pagealloc.h>
 #include <linux/kernel.h>
 #include <linux/page_ext.h>
+#include <linux/page_owner.h>
=20
 static bool needed;
 DEFINE_STATIC_KEY_FALSE(iommu_debug_initialized);
@@ -71,6 +72,28 @@ static size_t iommu_debug_page_size(struct iommu_domain =
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
index 454303ec09c2..87f593305465 100644
--- a/include/linux/iommu-debug-pagealloc.h
+++ b/include/linux/iommu-debug-pagealloc.h
@@ -22,6 +22,7 @@ void __iommu_debug_unmap_begin(struct iommu_domain *domai=
n,
 			       unsigned long iova, size_t size);
 void __iommu_debug_unmap_end(struct iommu_domain *domain,
 			     unsigned long iova, size_t size, size_t unmapped);
+void __iommu_debug_check_unmapped(const struct page *page, int numpages);
=20
 static inline void iommu_debug_map(struct iommu_domain *domain,
 				   phys_addr_t phys, size_t size)
@@ -45,6 +46,12 @@ static inline void iommu_debug_unmap_end(struct iommu_do=
main *domain,
 		__iommu_debug_unmap_end(domain, iova, size, unmapped);
 }
=20
+static inline void iommu_debug_check_unmapped(const struct page *page, int=
 numpages)
+{
+	if (static_branch_unlikely(&iommu_debug_initialized))
+		__iommu_debug_check_unmapped(page, numpages);
+}
+
 void iommu_debug_init(void);
=20
 #else
@@ -68,6 +75,11 @@ static inline void iommu_debug_init(void)
 {
 }
=20
+static inline void iommu_debug_check_unmapped(const struct page *page,
+					      int numpages)
+{
+}
+
 #endif /* CONFIG_IOMMU_DEBUG_PAGEALLOC */
=20
 #endif /* __LINUX_IOMMU_DEBUG_PAGEALLOC_H */
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 7c79b3369b82..739cd3e168d7 100644
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
@@ -3818,12 +3819,16 @@ extern void __kernel_map_pages(struct page *page, i=
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
2.52.0.460.gd25c4c69ec-goog

