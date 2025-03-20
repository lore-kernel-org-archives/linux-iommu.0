Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D13B1226CE7
	for <iommu@lists.linux.dev>; Thu, 20 Mar 2025 17:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742492382; cv=none; b=HmQ8wvnTKrllsFn6QtYV/SKn7l4v9oS4prhruWtSBKwCPnywupY6ZMXJz5QBRBtEs9gi5mEOWB+62Hai/FK7uCu4JFCYYKl3HvXo+sFppd9nfmjj3EHJFkoJzSZ7U+q+ca7FH/C+ZB6R83WdW+oKg/aCEBEkGzXICRTaQ9udXjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742492382; c=relaxed/simple;
	bh=/GCpGVOT7OdG6BMZ0eppGKF2eeuXHrVXsB4ZgTs1Sno=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=L5SPllvzK96LUg4R3iu10NpuAFMy+dn+4CDwieQl98qb3lWWwvM7Ur0+WZsHGcCmepu7YYqhw4acqYxdkOUI6u6cmB5y51CmDdG315q6xuHGsQyvdjtR+OCu4X9+wu0CGLoGpw0wzgAuC7elE6s2S2x4WDbelWvdnVLm8u+yMd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kZdDG2XK; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kZdDG2XK"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2262051205aso9807865ad.3
        for <iommu@lists.linux.dev>; Thu, 20 Mar 2025 10:39:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742492380; x=1743097180; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=L1LeZ1NqRBiJP18aw9wNSepnO5CEnnjsFwRWiKcady0=;
        b=kZdDG2XKCjoowxAYE5DiMEGBr4TQr/J0pLQmL2AqTFwPkSUJpaN9W58tb+hBw0X6NU
         d2e7e1ebBW58ajwI1fH12EdsxqVuaIcMbPYqUKbIXjhcSrnkF0WIgsgPxCLE62Sc4hC3
         OEG/JRwGPx0NrFB1EfRZnYnREhC5ygi1oEtH+I+8ijIu/yu9xRR6GHhBv/TQ9EjcOQxW
         wMMePo27rN9Lz+tyD02jfkSiu1uSUqYDtOzV02BulPs/rsjXCJjz0NMaCD1QAuJy6Rru
         BjpBblLgesKz1/BY0KvB1Br7UfsM7pNZh9oB4JAjxDjD47nLK0hahb9bfmrx9UQxIAwO
         s9JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742492380; x=1743097180;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L1LeZ1NqRBiJP18aw9wNSepnO5CEnnjsFwRWiKcady0=;
        b=H7OAu/uprCf7gpsmvwQjC/dGDdI8KljfmUdLzimyVYmWqYP9STfnjD2Up4hdAspb9L
         Qb1PDHjocRVvUzJuKOMSEVdn5/qXY5Bsviz4zCJ1HNS6B83dbRpuFTOiTt/q7xqeUyjn
         Q1D2ijygbgLBO/NvLqi/Q8DKO2ifJODLxiHqlL+6mHScSzS+GlJKnlIm8zTOztMKTw8A
         FLSx70/H05uITDog7yE04Gmw5gEfwQqRUV3u1F0VLL+uuxJiYg42tMgtmZLJ7xoPXwsY
         MDFoleJPnPDQI2WCpXGCmFcWpCYbaKxc/B+BmhvclRWh/hdq7WuNzMSsaOO2MHxeqjrE
         Cmqw==
X-Forwarded-Encrypted: i=1; AJvYcCVdVDj4lC/Ml2F+8qnUD0wGS1Bd/0kzr27QOCYGZgly7e+XxpsSJYHIkI4rD3gbWS9zyp3P9Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YzUMbJ5l+TfSB7IWY36IoTj2z9EkFgdYp9nuLIIBkIDyB6ezMuJ
	1gtQDDjmVZbpmAdLFJaMhwKLvtLcznPHrOclQv5DYnsK+5mxi2SoQnGSAUQF4JYf/b/etNOuwJO
	qBw==
X-Google-Smtp-Source: AGHT+IFIgtoncBq9NM/3xD7Imlcbq1xmz7ZhqdBzB7CyCMtuFxcwQyRcHUOe3EsR477ZgjHZHfVYEHABcPU=
X-Received: from plbkj16.prod.google.com ([2002:a17:903:6d0:b0:220:ecac:27e5])
 (user=surenb job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:e888:b0:223:35cb:e421
 with SMTP id d9443c01a7336-22780e258cemr2827355ad.49.1742492380069; Thu, 20
 Mar 2025 10:39:40 -0700 (PDT)
Date: Thu, 20 Mar 2025 10:39:31 -0700
In-Reply-To: <20250320173931.1583800-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250320173931.1583800-1-surenb@google.com>
X-Mailer: git-send-email 2.49.0.395.g12beb8f557-goog
Message-ID: <20250320173931.1583800-4-surenb@google.com>
Subject: [RFC 3/3] mm: integrate GCMA with CMA using dt-bindings
From: Suren Baghdasaryan <surenb@google.com>
To: akpm@linux-foundation.org
Cc: willy@infradead.org, david@redhat.com, vbabka@suse.cz, 
	lorenzo.stoakes@oracle.com, liam.howlett@oracle.com, alexandru.elisei@arm.com, 
	peterx@redhat.com, hannes@cmpxchg.org, mhocko@kernel.org, 
	m.szyprowski@samsung.com, iamjoonsoo.kim@lge.com, mina86@mina86.com, 
	axboe@kernel.dk, viro@zeniv.linux.org.uk, brauner@kernel.org, 
	hch@infradead.org, jack@suse.cz, hbathini@linux.ibm.com, 
	sourabhjain@linux.ibm.com, ritesh.list@gmail.com, aneesh.kumar@kernel.org, 
	bhelgaas@google.com, sj@kernel.org, fvdl@google.com, ziy@nvidia.com, 
	yuzhao@google.com, minchan@kernel.org, surenb@google.com, linux-mm@kvack.org, 
	linuxppc-dev@lists.ozlabs.org, linux-block@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Minchan Kim <minchan@google.com>
Content-Type: text/plain; charset="UTF-8"

This patch introduces a new "guarantee" property for shared-dma-pool.
With this property, admin can create specific memory pool as
GCMA-based CMA if they care about allocation success rate and latency.
The downside of GCMA is that it can host only clean file-backed pages
since it's using cleancache as its secondary user.

Signed-off-by: Minchan Kim <minchan@google.com>
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 arch/powerpc/kernel/fadump.c |  2 +-
 include/linux/cma.h          |  2 +-
 kernel/dma/contiguous.c      | 11 ++++++++++-
 mm/cma.c                     | 33 ++++++++++++++++++++++++++-------
 mm/cma.h                     |  1 +
 mm/cma_sysfs.c               | 10 ++++++++++
 6 files changed, 49 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/kernel/fadump.c b/arch/powerpc/kernel/fadump.c
index 4b371c738213..4eb7be0cdcdb 100644
--- a/arch/powerpc/kernel/fadump.c
+++ b/arch/powerpc/kernel/fadump.c
@@ -111,7 +111,7 @@ void __init fadump_cma_init(void)
 		return;
 	}
 
-	rc = cma_init_reserved_mem(base, size, 0, "fadump_cma", &fadump_cma);
+	rc = cma_init_reserved_mem(base, size, 0, "fadump_cma", &fadump_cma, false);
 	if (rc) {
 		pr_err("Failed to init cma area for firmware-assisted dump,%d\n", rc);
 		/*
diff --git a/include/linux/cma.h b/include/linux/cma.h
index 62d9c1cf6326..3207db979e94 100644
--- a/include/linux/cma.h
+++ b/include/linux/cma.h
@@ -46,7 +46,7 @@ extern int __init cma_declare_contiguous_multi(phys_addr_t size,
 extern int cma_init_reserved_mem(phys_addr_t base, phys_addr_t size,
 					unsigned int order_per_bit,
 					const char *name,
-					struct cma **res_cma);
+					struct cma **res_cma, bool gcma);
 extern struct page *cma_alloc(struct cma *cma, unsigned long count, unsigned int align,
 			      bool no_warn);
 extern bool cma_pages_valid(struct cma *cma, const struct page *pages, unsigned long count);
diff --git a/kernel/dma/contiguous.c b/kernel/dma/contiguous.c
index 055da410ac71..a68b3123438c 100644
--- a/kernel/dma/contiguous.c
+++ b/kernel/dma/contiguous.c
@@ -459,6 +459,7 @@ static int __init rmem_cma_setup(struct reserved_mem *rmem)
 	unsigned long node = rmem->fdt_node;
 	bool default_cma = of_get_flat_dt_prop(node, "linux,cma-default", NULL);
 	struct cma *cma;
+	bool gcma;
 	int err;
 
 	if (size_cmdline != -1 && default_cma) {
@@ -476,7 +477,15 @@ static int __init rmem_cma_setup(struct reserved_mem *rmem)
 		return -EINVAL;
 	}
 
-	err = cma_init_reserved_mem(rmem->base, rmem->size, 0, rmem->name, &cma);
+	gcma = !!of_get_flat_dt_prop(node, "guarantee", NULL);
+#ifndef CONFIG_GCMA
+	if (gcma) {
+		pr_err("Reserved memory: unable to setup GCMA region, GCMA is not enabled\n");
+		return -EINVAL;
+	}
+#endif
+	err = cma_init_reserved_mem(rmem->base, rmem->size, 0, rmem->name,
+				    &cma, gcma);
 	if (err) {
 		pr_err("Reserved memory: unable to setup CMA region\n");
 		return err;
diff --git a/mm/cma.c b/mm/cma.c
index b06d5fe73399..f12cef849e58 100644
--- a/mm/cma.c
+++ b/mm/cma.c
@@ -26,6 +26,7 @@
 #include <linux/cma.h>
 #include <linux/highmem.h>
 #include <linux/io.h>
+#include <linux/gcma.h>
 #include <linux/kmemleak.h>
 #include <trace/events/cma.h>
 
@@ -165,11 +166,18 @@ static void __init cma_activate_area(struct cma *cma)
 			count = cmr->early_pfn - cmr->base_pfn;
 			bitmap_count = cma_bitmap_pages_to_bits(cma, count);
 			bitmap_set(cmr->bitmap, 0, bitmap_count);
+		} else {
+			count = 0;
 		}
 
-		for (pfn = cmr->early_pfn; pfn < cmr->base_pfn + cmr->count;
-		     pfn += pageblock_nr_pages)
-			init_cma_reserved_pageblock(pfn_to_page(pfn));
+		if (cma->gcma) {
+			gcma_register_area(cma->name, cmr->early_pfn,
+					   cma->count - count);
+		} else {
+			for (pfn = cmr->early_pfn; pfn < cmr->base_pfn + cmr->count;
+			     pfn += pageblock_nr_pages)
+				init_cma_reserved_pageblock(pfn_to_page(pfn));
+		}
 	}
 
 	spin_lock_init(&cma->lock);
@@ -270,7 +278,7 @@ static void __init cma_drop_area(struct cma *cma)
 int __init cma_init_reserved_mem(phys_addr_t base, phys_addr_t size,
 				 unsigned int order_per_bit,
 				 const char *name,
-				 struct cma **res_cma)
+				 struct cma **res_cma, bool gcma)
 {
 	struct cma *cma;
 	int ret;
@@ -301,6 +309,7 @@ int __init cma_init_reserved_mem(phys_addr_t base, phys_addr_t size,
 	cma->ranges[0].count = cma->count;
 	cma->nranges = 1;
 	cma->nid = NUMA_NO_NODE;
+	cma->gcma = gcma;
 
 	*res_cma = cma;
 
@@ -721,7 +730,8 @@ static int __init __cma_declare_contiguous_nid(phys_addr_t base,
 		base = addr;
 	}
 
-	ret = cma_init_reserved_mem(base, size, order_per_bit, name, res_cma);
+	ret = cma_init_reserved_mem(base, size, order_per_bit, name, res_cma,
+				    false);
 	if (ret)
 		memblock_phys_free(base, size);
 
@@ -815,7 +825,13 @@ static int cma_range_alloc(struct cma *cma, struct cma_memrange *cmr,
 
 		pfn = cmr->base_pfn + (bitmap_no << cma->order_per_bit);
 		mutex_lock(&cma->alloc_mutex);
-		ret = alloc_contig_range(pfn, pfn + count, MIGRATE_CMA, gfp);
+		if (cma->gcma) {
+			gcma_alloc_range(pfn, count);
+			ret = 0;
+		} else {
+			ret = alloc_contig_range(pfn, pfn + count, MIGRATE_CMA,
+						 gfp);
+		}
 		mutex_unlock(&cma->alloc_mutex);
 		if (ret == 0) {
 			page = pfn_to_page(pfn);
@@ -992,7 +1008,10 @@ bool cma_release(struct cma *cma, const struct page *pages,
 	if (r == cma->nranges)
 		return false;
 
-	free_contig_range(pfn, count);
+	if (cma->gcma)
+		gcma_free_range(pfn, count);
+	else
+		free_contig_range(pfn, count);
 	cma_clear_bitmap(cma, cmr, pfn, count);
 	cma_sysfs_account_release_pages(cma, count);
 	trace_cma_release(cma->name, pfn, pages, count);
diff --git a/mm/cma.h b/mm/cma.h
index 41a3ab0ec3de..c2a5576d7987 100644
--- a/mm/cma.h
+++ b/mm/cma.h
@@ -47,6 +47,7 @@ struct cma {
 	char name[CMA_MAX_NAME];
 	int nranges;
 	struct cma_memrange ranges[CMA_MAX_RANGES];
+	bool gcma;
 #ifdef CONFIG_CMA_SYSFS
 	/* the number of CMA page successful allocations */
 	atomic64_t nr_pages_succeeded;
diff --git a/mm/cma_sysfs.c b/mm/cma_sysfs.c
index 97acd3e5a6a5..4ecc36270a4d 100644
--- a/mm/cma_sysfs.c
+++ b/mm/cma_sysfs.c
@@ -80,6 +80,15 @@ static ssize_t available_pages_show(struct kobject *kobj,
 }
 CMA_ATTR_RO(available_pages);
 
+static ssize_t gcma_show(struct kobject *kobj,
+			 struct kobj_attribute *attr, char *buf)
+{
+	struct cma *cma = cma_from_kobj(kobj);
+
+	return sysfs_emit(buf, "%d\n", cma->gcma);
+}
+CMA_ATTR_RO(gcma);
+
 static void cma_kobj_release(struct kobject *kobj)
 {
 	struct cma *cma = cma_from_kobj(kobj);
@@ -95,6 +104,7 @@ static struct attribute *cma_attrs[] = {
 	&release_pages_success_attr.attr,
 	&total_pages_attr.attr,
 	&available_pages_attr.attr,
+	&gcma_attr.attr,
 	NULL,
 };
 ATTRIBUTE_GROUPS(cma);
-- 
2.49.0.rc1.451.g8f38331e32-goog

