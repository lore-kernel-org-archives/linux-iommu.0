Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6178C249EB
	for <iommu@lists.linux.dev>; Tue, 20 Jan 2026 09:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768900776; cv=none; b=YDDH0sdpSh+OwLMXZuvWHwCcA9Q7M4eM4Ttt8WumTEgNanHbxOPL6HBQRZly7JfoTLI48zNCJZYXgDhl06+xzn02IEz+ax9GEJTN85B2g2fwlimMwIwB5nWx957eaSlenP+0tnd7sKtNq06o2OTKJMLoolwVDkKeNFPY8KbNWG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768900776; c=relaxed/simple;
	bh=PHSBhI8m1+DcVKrA3sW1DexLR5nKSBb/1XCqhctyF0Q=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=X06YH8PE2zdL0/8JchRGyhtWoIQU/PvuQ16Zem7AieZ9I0YYY7E7alI7T9uWUSMHno1gbNJWcq1bwk9iiExkd+6hULWdJVPj05Px/qIFs+9pRj0LGRrPZUvI+xt1GkEdryubt0guVqj8rumDNpWOdrkZX6vPUY+GxBHoP5yHSkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1OTh5BbJ; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1OTh5BbJ"
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-47d62cc05daso35497685e9.3
        for <iommu@lists.linux.dev>; Tue, 20 Jan 2026 01:19:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768900773; x=1769505573; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=X0gVSCji/amPzVpAugMKA+gNQb8Vp/dW4y1DM63bYO0=;
        b=1OTh5BbJLKdB3eOvS0T1F1w1zPwpVpuSaJSwlUbSLaTq27NiYbTbn5jQdwTedDktrT
         Xo4JfQBpXq+zXto8xLFY0Nt5nliIkASpAQpbR5Ej4qRzzas/K2BFu2U3XeH+NXtwy4So
         JTiVo4omg3awHX0UrpU4Y+8LzEIt8qgJ0Ef3EcyQDrb707XMHARYlsCWNa1WKMNuNrEr
         6XieKgfHeG/FmAiuNrduyV2KfOgvjJhWoty+Oh7RjPRwAv9yelPhX7D2T2O1yBmiunbY
         nmAnKeoIWVlH69icQfV0OR5Ab8wmGruMlT7jeidCVrHzmWrcTA7QVA2xKnnOd/VQsm0K
         JFPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768900773; x=1769505573;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X0gVSCji/amPzVpAugMKA+gNQb8Vp/dW4y1DM63bYO0=;
        b=pzwGjv82c3VByCJ5yywQ1HLptlVIJFa2YTIvFhGuUXjZVVRDqcP7eJBlh8DB2JhSpm
         Sc9oWqIW7YWLqpE3looCepWmwX36EGbQUPYkT6EBy5HAkR3PAvXslJSLq+7QjFAhzAXg
         e3LI8zinnyzUcwO9RdFrHFZp+HAbO/7hpi4VXJFjxZ5AIr/r+KzEC21JdP5H9S0vldGK
         DeMgir41CHjtBdyHd0StbDPuydq0XF3fq34wO10ve71+d1mXHM5juPTssTG2VjkLwm7b
         vNwadOM6EgTL7A6u9OfGCdwQrSgzYJApa8OI/bwA8gmqZV1FDO8wpTkwR+y4I4l1uXPh
         mPlA==
X-Forwarded-Encrypted: i=1; AJvYcCV5WqNtrsKq4fsdw3Ipx53B1eBVdYWG2OSLgWo2ERI/n2FhMpKea16cTBEJ1FNzMXFzh5wyPw==@lists.linux.dev
X-Gm-Message-State: AOJu0YywpBnzTyWNRL9vcy2KnOmLb7S1P5N6u0XEUHSBXZoX3DFDgQMn
	ry4OmiBPY947P2nw179esb0jFgkLpt2hLpU9r8IKT62o03xU0HlJlUmLL/G5MCF+H1Xhp27sbqc
	QTJfRrWjDRoBCcQ==
X-Received: from wrbgz21.prod.google.com ([2002:a05:6000:4815:b0:435:64f6:e987])
 (user=smostafa job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:6099:b0:47e:e952:86ca with SMTP id 5b1f17b1804b1-4803e79b81dmr13478605e9.2.1768900772778;
 Tue, 20 Jan 2026 01:19:32 -0800 (PST)
Date: Tue, 20 Jan 2026 09:19:25 +0000
In-Reply-To: <20260120091926.670155-1-smostafa@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260120091926.670155-1-smostafa@google.com>
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260120091926.670155-2-smostafa@google.com>
Subject: [PATCH v2 1/2] mm/page_ext: Add page_ext_get_from_phys()
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

The IOMMU code operates on physical addresses which can be outside
of system RAM.

Add a new function page_ext_get_from_phys() to abstract the logic of
checking the address and returning the page_ext.

Signed-off-by: Mostafa Saleh <smostafa@google.com>
---
 include/linux/page_ext.h |  6 ++++++
 mm/page_ext.c            | 23 +++++++++++++++++++++++
 2 files changed, 29 insertions(+)

diff --git a/include/linux/page_ext.h b/include/linux/page_ext.h
index 76c817162d2f..61e876e255e8 100644
--- a/include/linux/page_ext.h
+++ b/include/linux/page_ext.h
@@ -93,6 +93,7 @@ static inline bool page_ext_iter_next_fast_possible(unsigned long next_pfn)
 #endif
 
 extern struct page_ext *page_ext_get(const struct page *page);
+extern struct page_ext *page_ext_from_phys(phys_addr_t phys);
 extern void page_ext_put(struct page_ext *page_ext);
 extern struct page_ext *page_ext_lookup(unsigned long pfn);
 
@@ -215,6 +216,11 @@ static inline struct page_ext *page_ext_get(const struct page *page)
 	return NULL;
 }
 
+static inline struct page_ext *page_ext_from_phys(phys_addr_t phys)
+{
+	return NULL;
+}
+
 static inline void page_ext_put(struct page_ext *page_ext)
 {
 }
diff --git a/mm/page_ext.c b/mm/page_ext.c
index 297e4cd8ce90..e2e92bd27ebd 100644
--- a/mm/page_ext.c
+++ b/mm/page_ext.c
@@ -538,6 +538,29 @@ struct page_ext *page_ext_get(const struct page *page)
 	return page_ext;
 }
 
+/**
+ * page_ext_from_phys() - Get the page_ext structure for a physical address.
+ * @phys: The physical address to query.
+ *
+ * This function safely gets the `struct page_ext` associated with a given
+ * physical address. It performs validation to ensure the address corresponds
+ * to a valid, online struct page before attempting to access it.
+ * It returns NULL for MMIO, ZONE_DEVICE, holes and offline memory.
+ *
+ * Return: NULL if no page_ext exists for this physical address.
+ * Context: Any context.  Caller may not sleep until they have called
+ * page_ext_put().
+ */
+struct page_ext *page_ext_from_phys(phys_addr_t phys)
+{
+	struct page *page = pfn_to_online_page(__phys_to_pfn(phys));
+
+	if (!page)
+		return NULL;
+
+	return page_ext_get(page);
+}
+
 /**
  * page_ext_put() - Working with page extended information is done.
  * @page_ext: Page extended information received from page_ext_get().
-- 
2.52.0.457.g6b5491de43-goog

