Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43F403002A4
	for <iommu@lists.linux.dev>; Sun, 26 Oct 2025 20:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761510993; cv=none; b=ZZMRhKJ1vVVHhsRwdzKkyDhoecUjJowPEzhcN+jqHVEEoaCi5BM1ctOD8NYNUxllugrD9LJqNnfawISn/x6O6Edz9wuNLacxR7ZT0nZLNzGU0VUA8EX+yTbTGFJ9NUG8CobEjXHCj1GWD6FGXFTKaYh+ihR30FAZuwtA/S+xPRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761510993; c=relaxed/simple;
	bh=idCmvwnWfReOd35MC8s7rKZdTVl4Bh6zIiUE7CDDh78=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=cFss1TlUZ62c1NUEcW9FFN9sd0rCTe4n0fWLrePc3e9hDf+nqXnpzwZIahbG/3wC9+vQ2T7xjjtHc1WaTxjPVNQIOCgHoaOvMUTy5U0ww1xZ0AljdpTRyiG9UjcxQPhYjya698yzWHpWNADUrs6LwDu6TmHqa8WguuFy5Ueg/tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IiLq0MQs; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IiLq0MQs"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-290992f9693so37912595ad.1
        for <iommu@lists.linux.dev>; Sun, 26 Oct 2025 13:36:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761510991; x=1762115791; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=W8fKQJfeDm6lPLiecQTGQk23fhbVChRxMsUUt63Q0w4=;
        b=IiLq0MQsRijvOTgmyHqnU0xbWi1uHmo9qjGw8L7g0NiY9T47hw9zRvMRivJ80iDJki
         kpBnIifMArWJmwa4oKacc8ItUzPQ1uCdoCgDbrzdM+qzAV1Oh4sRDzD8kcWA/0oPbKEu
         SKh9DBtTXq5GsrzWs0EqbzvErGNguUOCbil8MqWXOwSsTSNODDGxqfdTjhP9QOwayb0Y
         /eJtGKdNj3AKddSC1Gh55R8wVEQ8GbLlsMF4TPGCyaUkTK8qrWyrM/jyBWI6escfipdA
         qJjsHeWvc8JEdX5nWslC8H8UG4O5IlBBonUr3bAO4y019mrXyTHmrwoxntWhA08HnCaE
         IGUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761510991; x=1762115791;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W8fKQJfeDm6lPLiecQTGQk23fhbVChRxMsUUt63Q0w4=;
        b=RvGOtRUHrQUgjqNT+p7fyonQABqGoUU18tnNqq0sjpO/jGS1c0A0Lm/l74pnCk/Bam
         wd1ITg2YUPf2XtoqCShpLcwWiyERAorLWjsb6fIK1Y5ahAfDwfH7fHsLinYht/bnCLaa
         BCOlQQd5xwjqegnIscXM8BR9R+3Lmf3zczY+aAt8ooIAopFIwTEF2MOZx0gpiALxwmYT
         X6tThOHUx3iOO1pVs/sFKlx2wZQu2BOod2JSoT1kavqW2XEiDFoPzxHzngjgYDoKucK0
         cnxwQ/1guXir8wr/piIOAZiqVILoV6gVh/3fDpuk0EXCdWPRp8o8EVDTEj6SNeShmQIe
         orGw==
X-Forwarded-Encrypted: i=1; AJvYcCXIxNTKGjssPLYi6N+NRPnLRb0EZSSl2D1ofVSFDpUxWx68UyKbTY364mwEYdQNMlVojoqZXA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxe6UF2iz6CSe8qhXL7HUqVDb2LgYmMTV48NBI4Su7KtXCPLvbo
	L5tiuyASXq4QX+6kBpklzz7644eKjSOVcPissi8/A96vHlsmFSBw4faOqHGcOwj6+X61mmTJAMw
	YwY7Wvw==
X-Google-Smtp-Source: AGHT+IF0KfskSdKLpVux68qy5bYP7cU8OOYanXrqoLeO8zCN1YVKm99EcrKefxwR8RyvHyXu3BZDAiNrGaY=
X-Received: from plgs4.prod.google.com ([2002:a17:902:ea04:b0:268:eb:3b3b])
 (user=surenb job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:f64b:b0:274:506d:7fcc
 with SMTP id d9443c01a7336-29489d71137mr117673365ad.6.1761510990611; Sun, 26
 Oct 2025 13:36:30 -0700 (PDT)
Date: Sun, 26 Oct 2025 13:36:10 -0700
In-Reply-To: <20251026203611.1608903-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20251026203611.1608903-1-surenb@google.com>
X-Mailer: git-send-email 2.51.1.851.g4ebd6896fd-goog
Message-ID: <20251026203611.1608903-8-surenb@google.com>
Subject: [PATCH v2 7/8] mm: introduce GCMA
From: Suren Baghdasaryan <surenb@google.com>
To: akpm@linux-foundation.org
Cc: david@redhat.com, lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, 
	vbabka@suse.cz, alexandru.elisei@arm.com, peterx@redhat.com, sj@kernel.org, 
	rppt@kernel.org, mhocko@suse.com, corbet@lwn.net, axboe@kernel.dk, 
	viro@zeniv.linux.org.uk, brauner@kernel.org, hch@infradead.org, jack@suse.cz, 
	willy@infradead.org, m.szyprowski@samsung.com, robin.murphy@arm.com, 
	hannes@cmpxchg.org, zhengqi.arch@bytedance.com, shakeel.butt@linux.dev, 
	axelrasmussen@google.com, yuanchu@google.com, weixugc@google.com, 
	minchan@kernel.org, surenb@google.com, linux-mm@kvack.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	iommu@lists.linux.dev, Minchan Kim <minchan@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Minchan Kim <minchan@google.com>

This patch introduces GCMA (Guaranteed Contiguous Memory Allocator)
cleacache backend which reserves some amount of memory at the boot
and then donates it to store clean file-backed pages in the cleancache.
GCMA aims to guarantee contiguous memory allocation success as well as
low and deterministic allocation latency.

Notes:
Originally, the idea was posted by SeongJae Park and Minchan Kim [1].
Later Minchan reworked it to be used in Android as a reference for
Android vendors to use [2].

[1] https://lwn.net/Articles/619865/
[2] https://android-review.googlesource.com/q/topic:%22gcma_6.12%22

Signed-off-by: Minchan Kim <minchan@google.com>
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 MAINTAINERS          |   2 +
 include/linux/gcma.h |  36 +++++++
 mm/Kconfig           |  15 +++
 mm/Makefile          |   1 +
 mm/gcma.c            | 244 +++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 298 insertions(+)
 create mode 100644 include/linux/gcma.h
 create mode 100644 mm/gcma.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 3aabed281b71..40de200d1124 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16384,6 +16384,7 @@ F:	Documentation/admin-guide/mm/
 F:	Documentation/mm/
 F:	include/linux/cma.h
 F:	include/linux/dmapool.h
+F:	include/linux/gcma.h
 F:	include/linux/ioremap.h
 F:	include/linux/memory-tiers.h
 F:	include/linux/page_idle.h
@@ -16395,6 +16396,7 @@ F:	mm/dmapool.c
 F:	mm/dmapool_test.c
 F:	mm/early_ioremap.c
 F:	mm/fadvise.c
+F:	mm/gcma.c
 F:	mm/ioremap.c
 F:	mm/mapping_dirty_helpers.c
 F:	mm/memory-tiers.c
diff --git a/include/linux/gcma.h b/include/linux/gcma.h
new file mode 100644
index 000000000000..20b2c85de87b
--- /dev/null
+++ b/include/linux/gcma.h
@@ -0,0 +1,36 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __GCMA_H__
+#define __GCMA_H__
+
+#include <linux/types.h>
+
+#ifdef CONFIG_GCMA
+
+int gcma_register_area(const char *name,
+		       unsigned long start_pfn, unsigned long count);
+
+/*
+ * NOTE: allocated pages are still marked reserved and when freeing them
+ * the caller should ensure they are isolated and not referenced by anyone
+ * other than the caller.
+ */
+int gcma_alloc_range(unsigned long start_pfn, unsigned long count, gfp_t gfp);
+int gcma_free_range(unsigned long start_pfn, unsigned long count);
+
+#else /* CONFIG_GCMA */
+
+static inline int gcma_register_area(const char *name,
+				     unsigned long start_pfn,
+				     unsigned long count)
+		{ return -EOPNOTSUPP; }
+static inline int gcma_alloc_range(unsigned long start_pfn,
+				   unsigned long count, gfp_t gfp)
+		{ return -EOPNOTSUPP; }
+
+static inline int gcma_free_range(unsigned long start_pfn,
+				   unsigned long count)
+		{ return -EOPNOTSUPP; }
+
+#endif /* CONFIG_GCMA */
+
+#endif /* __GCMA_H__ */
diff --git a/mm/Kconfig b/mm/Kconfig
index e1a169d5e5de..3166fde83340 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -1097,6 +1097,21 @@ config CMA_AREAS
 
 	  If unsure, leave the default value "8" in UMA and "20" in NUMA.
 
+config GCMA
+       bool "GCMA (Guaranteed Contiguous Memory Allocator)"
+       depends on CLEANCACHE
+	help
+	  This enables the Guaranteed Contiguous Memory Allocator to allow
+	  low latency guaranteed contiguous memory allocations. Memory
+	  reserved by GCMA is donated to cleancache to be used as pagecache
+	  extension. Once GCMA allocation is requested, necessary pages are
+	  taken back from the cleancache and used to satisfy the request.
+	  Cleancache guarantees low latency successful allocation as long
+	  as the total size of GCMA allocations does not exceed the size of
+	  the memory donated to the cleancache.
+
+	  If unsure, say "N".
+
 #
 # Select this config option from the architecture Kconfig, if available, to set
 # the max page order for physically contiguous allocations.
diff --git a/mm/Makefile b/mm/Makefile
index 845841a140e3..05aee66a8b07 100644
--- a/mm/Makefile
+++ b/mm/Makefile
@@ -149,3 +149,4 @@ obj-$(CONFIG_TMPFS_QUOTA) += shmem_quota.o
 obj-$(CONFIG_PT_RECLAIM) += pt_reclaim.o
 obj-$(CONFIG_CLEANCACHE) += cleancache.o
 obj-$(CONFIG_CLEANCACHE_SYSFS)	+= cleancache_sysfs.o
+obj-$(CONFIG_GCMA)	+= gcma.o
diff --git a/mm/gcma.c b/mm/gcma.c
new file mode 100644
index 000000000000..b86f82b8fe9d
--- /dev/null
+++ b/mm/gcma.c
@@ -0,0 +1,244 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * GCMA (Guaranteed Contiguous Memory Allocator)
+ *
+ */
+
+#define pr_fmt(fmt) "gcma: " fmt
+
+#include <linux/cleancache.h>
+#include <linux/gcma.h>
+#include <linux/hashtable.h>
+#include <linux/highmem.h>
+#include <linux/idr.h>
+#include <linux/slab.h>
+#include <linux/xarray.h>
+#include "internal.h"
+
+#define MAX_GCMA_AREAS		64
+#define GCMA_AREA_NAME_MAX_LEN	32
+
+struct gcma_area {
+	int pool_id;
+	unsigned long start_pfn;
+	unsigned long end_pfn;
+	char name[GCMA_AREA_NAME_MAX_LEN];
+};
+
+static struct gcma_area areas[MAX_GCMA_AREAS];
+static atomic_t nr_gcma_area = ATOMIC_INIT(0);
+static DEFINE_SPINLOCK(gcma_area_lock);
+
+static int free_folio_range(struct gcma_area *area,
+			     unsigned long start_pfn, unsigned long end_pfn)
+{
+	unsigned long scanned = 0;
+	unsigned long pfn;
+
+	for (pfn = start_pfn; pfn < end_pfn; pfn++) {
+		int err;
+
+		if (!(++scanned % XA_CHECK_SCHED))
+			cond_resched();
+
+		err = cleancache_backend_put_folio(area->pool_id, pfn_folio(pfn));
+		if (err) {
+			pr_warn("PFN %lu: folio is still in use\n", pfn);
+			return err;
+		}
+	}
+
+	return 0;
+}
+
+static int alloc_folio_range(struct gcma_area *area,
+			      unsigned long start_pfn, unsigned long end_pfn,
+			      gfp_t gfp)
+{
+	unsigned long scanned = 0;
+	unsigned long pfn;
+
+	for (pfn = start_pfn; pfn < end_pfn; pfn++) {
+		int err;
+
+		if (!(++scanned % XA_CHECK_SCHED))
+			cond_resched();
+
+		err = cleancache_backend_get_folio(area->pool_id, pfn_folio(pfn));
+		if (err) {
+			free_folio_range(area, start_pfn, pfn);
+			return err;
+		}
+	}
+
+	return 0;
+}
+
+static struct gcma_area *find_area(unsigned long start_pfn, unsigned long end_pfn)
+{
+	int nr_area = atomic_read_acquire(&nr_gcma_area);
+	int i;
+
+	for (i = 0; i < nr_area; i++) {
+		struct gcma_area *area = &areas[i];
+
+		if (area->end_pfn <= start_pfn)
+			continue;
+
+		if (area->start_pfn > end_pfn)
+			continue;
+
+		/* The entire range should belong to a single area */
+		if (start_pfn < area->start_pfn || end_pfn > area->end_pfn)
+			break;
+
+		/* Found the area containing the entire range */
+		return area;
+	}
+
+	return NULL;
+}
+
+int gcma_register_area(const char *name,
+		       unsigned long start_pfn, unsigned long count)
+{
+	LIST_HEAD(folios);
+	int i, pool_id;
+	int nr_area;
+	int ret = 0;
+
+	pool_id = cleancache_backend_register_pool(name);
+	if (pool_id < 0)
+		return pool_id;
+
+	for (i = 0; i < count; i++) {
+		struct folio *folio;
+
+		folio = pfn_folio(start_pfn + i);
+		folio_clear_reserved(folio);
+		folio_set_count(folio, 0);
+		list_add(&folio->lru, &folios);
+	}
+
+	cleancache_backend_put_folios(pool_id, &folios);
+
+	spin_lock(&gcma_area_lock);
+
+	nr_area = atomic_read(&nr_gcma_area);
+	if (nr_area < MAX_GCMA_AREAS) {
+		struct gcma_area *area = &areas[nr_area];
+
+		area->pool_id = pool_id;
+		area->start_pfn = start_pfn;
+		area->end_pfn = start_pfn + count;
+		strscpy(area->name, name);
+		/* Ensure above stores complete before we increase the count */
+		atomic_set_release(&nr_gcma_area, nr_area + 1);
+	} else {
+		ret = -ENOMEM;
+	}
+
+	spin_unlock(&gcma_area_lock);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(gcma_register_area);
+
+int gcma_alloc_range(unsigned long start_pfn, unsigned long count, gfp_t gfp)
+{
+	unsigned long end_pfn = start_pfn + count;
+	struct gcma_area *area;
+	struct folio *folio;
+	int err, order = 0;
+
+	gfp = current_gfp_context(gfp);
+	if (gfp & __GFP_COMP) {
+		if (!is_power_of_2(count))
+			return -EINVAL;
+
+		order = ilog2(count);
+		if (order >= MAX_PAGE_ORDER)
+			return -EINVAL;
+	}
+
+	area = find_area(start_pfn, end_pfn);
+	if (!area)
+		return -EINVAL;
+
+	err = alloc_folio_range(area, start_pfn, end_pfn, gfp);
+	if (err)
+		return err;
+
+	/*
+	 * GCMA returns pages with refcount 1 and expects them to have
+	 * the same refcount 1 when they are freed.
+	 */
+	if (order) {
+		folio = pfn_folio(start_pfn);
+		post_alloc_hook(&folio->page, order, gfp);
+		set_page_refcounted(&folio->page);
+		prep_compound_page(&folio->page, order);
+	} else {
+		for (unsigned long pfn = start_pfn; pfn < end_pfn; pfn++) {
+			folio = pfn_folio(pfn);
+			post_alloc_hook(&folio->page, order, gfp);
+			set_page_refcounted(&folio->page);
+		}
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(gcma_alloc_range);
+
+int gcma_free_range(unsigned long start_pfn, unsigned long count)
+{
+	unsigned long end_pfn = start_pfn + count;
+	struct gcma_area *area;
+	unsigned long pfn;
+	int err = -EINVAL;
+
+	area = find_area(start_pfn, end_pfn);
+	if (!area)
+		return -EINVAL;
+
+	/* First pass checks and drops folio refcounts */
+	for (pfn = start_pfn; pfn < end_pfn;) {
+		struct folio *folio = pfn_folio(pfn);
+		unsigned long nr_pages = folio_nr_pages(folio);
+
+		if (pfn + nr_pages > end_pfn) {
+			end_pfn = pfn;
+			goto error;
+
+		}
+		if (!folio_ref_dec_and_test(folio)) {
+			end_pfn = pfn + nr_pages;
+			goto error;
+		}
+		pfn += nr_pages;
+	}
+
+	/* Second pass prepares the folios */
+	for (pfn = start_pfn; pfn < end_pfn; pfn++) {
+		struct folio *folio = pfn_folio(pfn);
+
+		free_pages_prepare(&folio->page, folio_order(folio));
+		pfn += folio_nr_pages(folio);
+	}
+
+	err = free_folio_range(area, start_pfn, end_pfn);
+	if (!err)
+		return 0;
+
+error:
+	/* Restore folio refcounts */
+	for (pfn = start_pfn; pfn < end_pfn;) {
+		struct folio *folio = pfn_folio(pfn);
+
+		folio_ref_inc(folio);
+		pfn += folio_nr_pages(folio);
+	}
+
+	return err;
+}
+EXPORT_SYMBOL_GPL(gcma_free_range);
-- 
2.51.1.851.g4ebd6896fd-goog

