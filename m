Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 115131B964
	for <iommu@lists.linux.dev>; Sat, 13 Apr 2024 00:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712967940; cv=none; b=lbmaH8XGh4SyOsmdoCcbBNItWS6tgfkmA0XmEABFnoQ8x+CPIv5+1EnQf9mmYNAWEtBNOPZA/A1LU6ZH/O8cufyY8xs8WJSywgwBTI6BJ3EuQ6kETqToqM8lksfL9USuwrM3QddSmzNaTOFiKBimjK9gyfh0gRGmm5NhdjZAUPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712967940; c=relaxed/simple;
	bh=S/sBR1NCxNI/U5SAtH05O6LxOFmnYHqMGvt3EyOOqMw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qXRqcrWEb1EUMbkMLNXlKDz9mRa2GUJ4XkagNTEEj/mPSxDzdH9EzIAP4LHrHGVEVubCEaieB0ec8QAlKftHA0WrYZEmEbFNIIOfmRJVkc828XzKZI41yTxCoiLVgXAC12WuJu6ezzqe3AYs5tk2LMnmEfnEVkvbed6yocEmdEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=n4gDUV5Q; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="n4gDUV5Q"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-78ecd752a7cso58095385a.0
        for <iommu@lists.linux.dev>; Fri, 12 Apr 2024 17:25:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1712967935; x=1713572735; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lsGN5WIIRNrc7OxFwMhPRXWLlVhvYQL3ZDijKX4hJeQ=;
        b=n4gDUV5QZ3Cd7oWwKWW0HP5HqzdLls910Grsp9G2fcdOuL91ZOe6YUIc3hYI3+OJnv
         ub8w1NLivbZkF2XSBBIafSEEXmddgBnKSV56GETJ2AcX4ujgjI+M5qmsEJPKdLsZS5vJ
         okTrqLj+pqwO7K8D6Rf+2bjXu3mnSlJZW6pzcsivp+mcqMTWbd9HoMN/N7/RCbO0I4uL
         A/O7xR1yPIQf6WdZXM7WIxwyB3oZhPzkkJhWZF8trAwutwhCyzrM28CVgNjtPvcSErzN
         VAQwG1tJpAZpOJYybbs6duSxs56AZAz0yxOVP0zHLZGLdG9s3b2xuLMIDyPt6CRNWXvX
         czvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712967935; x=1713572735;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lsGN5WIIRNrc7OxFwMhPRXWLlVhvYQL3ZDijKX4hJeQ=;
        b=BOmE9UW1AAzpdF9BoVLxOy3lO0fTcff4Qfx0xUMQrH+9z7kCWg7kyo2UbMHW1LJEpL
         AiuMR+x4uqtN4aMs5aTc2geJ6WN53kcyzCtnBdxU8Qi6ECEpoUTrlQhyaooeSjMX3RYw
         nhl9vVGZdbC/Z8N5OL8Y3/aF6dmtTTNUSn7okCD0vsSGFtj662BKRgJjEk2n+LUeYcDM
         /XHp5NFV3fAR9I58jz5OQeD2oR/Dhk9rVYv6NUTP1R4SXsEK7OSdSuqbFk4FSTdP6C3E
         6i1xjCtvrLq0crRXP0AHiFGkedUiUb8o17p4aUMACRfX4DbSZnX2GzmP8nmIbgmZShkX
         3KtQ==
X-Forwarded-Encrypted: i=1; AJvYcCX41uepGAvl+/ZTheyjIufHe1CZ+FdYYZrSKqOYyDavEeClNXD2k/zlAtV7TJtQkOe7VF+xuRck88/ll52XH534WEj8ge4=
X-Gm-Message-State: AOJu0YyjMrfplHeEDfPk5kXggd9HwtOLAaCf7UMmmBUh2d1uC122DPgy
	4RB/b2urMIa1NDVNYofbqbGUCIH1DXcmKw9Ycn3gSX7tB1sGPV9Nkblcw5gqTOY=
X-Google-Smtp-Source: AGHT+IFlAsPoHG2FDkZGPGOgYKbc0L/VN/uoaQSjmKoP15ZCmJynTAbwXmhrnqPB3wz5ZBdnnVJffA==
X-Received: by 2002:a05:620a:b41:b0:78d:53eb:c256 with SMTP id x1-20020a05620a0b4100b0078d53ebc256mr4232583qkg.72.1712967934863;
        Fri, 12 Apr 2024 17:25:34 -0700 (PDT)
Received: from soleen.c.googlers.com.com (128.174.85.34.bc.googleusercontent.com. [34.85.174.128])
        by smtp.gmail.com with ESMTPSA id wl25-20020a05620a57d900b0078d5fece9a6sm3053490qkn.101.2024.04.12.17.25.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Apr 2024 17:25:34 -0700 (PDT)
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: akpm@linux-foundation.org,
	alim.akhtar@samsung.com,
	alyssa@rosenzweig.io,
	asahi@lists.linux.dev,
	baolu.lu@linux.intel.com,
	bhelgaas@google.com,
	cgroups@vger.kernel.org,
	corbet@lwn.net,
	david@redhat.com,
	dwmw2@infradead.org,
	hannes@cmpxchg.org,
	heiko@sntech.de,
	iommu@lists.linux.dev,
	jernej.skrabec@gmail.com,
	jonathanh@nvidia.com,
	joro@8bytes.org,
	krzysztof.kozlowski@linaro.org,
	linux-doc@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-rockchip@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	linux-sunxi@lists.linux.dev,
	linux-tegra@vger.kernel.org,
	lizefan.x@bytedance.com,
	marcan@marcan.st,
	mhiramat@kernel.org,
	m.szyprowski@samsung.com,
	pasha.tatashin@soleen.com,
	paulmck@kernel.org,
	rdunlap@infradead.org,
	robin.murphy@arm.com,
	samuel@sholland.org,
	suravee.suthikulpanit@amd.com,
	sven@svenpeter.dev,
	thierry.reding@gmail.com,
	tj@kernel.org,
	tomas.mudrunka@gmail.com,
	vdumpa@nvidia.com,
	wens@csie.org,
	will@kernel.org,
	yu-cheng.yu@intel.com,
	rientjes@google.com,
	bagasdotme@gmail.com,
	mkoutny@suse.com
Subject: [PATCH v6 10/11] iommu: observability of the IOMMU allocations
Date: Sat, 13 Apr 2024 00:25:21 +0000
Message-ID: <20240413002522.1101315-11-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.44.0.683.g7961c838ac-goog
In-Reply-To: <20240413002522.1101315-1-pasha.tatashin@soleen.com>
References: <20240413002522.1101315-1-pasha.tatashin@soleen.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add NR_IOMMU_PAGES into node_stat_item that counts number of pages
that are allocated by the IOMMU subsystem.

The allocations can be view per-node via:
/sys/devices/system/node/nodeN/vmstat.

For example:

$ grep iommu /sys/devices/system/node/node*/vmstat
/sys/devices/system/node/node0/vmstat:nr_iommu_pages 106025
/sys/devices/system/node/node1/vmstat:nr_iommu_pages 3464

The value is in page-count, therefore, in the above example
the iommu allocations amount to ~428M.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
Acked-by: David Rientjes <rientjes@google.com>
Tested-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 drivers/iommu/iommu-pages.h | 30 ++++++++++++++++++++++++++++++
 include/linux/mmzone.h      |  3 +++
 mm/vmstat.c                 |  3 +++
 3 files changed, 36 insertions(+)

diff --git a/drivers/iommu/iommu-pages.h b/drivers/iommu/iommu-pages.h
index 5a222d0ad25c..1264b0f6b6c3 100644
--- a/drivers/iommu/iommu-pages.h
+++ b/drivers/iommu/iommu-pages.h
@@ -20,6 +20,30 @@
  * large, i.e. multiple gigabytes in size.
  */
 
+/**
+ * __iommu_alloc_account - account for newly allocated page.
+ * @page: head struct page of the page.
+ * @order: order of the page
+ */
+static inline void __iommu_alloc_account(struct page *page, int order)
+{
+	const long pgcnt = 1l << order;
+
+	mod_node_page_state(page_pgdat(page), NR_IOMMU_PAGES, pgcnt);
+}
+
+/**
+ * __iommu_free_account - account a page that is about to be freed.
+ * @page: head struct page of the page.
+ * @order: order of the page
+ */
+static inline void __iommu_free_account(struct page *page, int order)
+{
+	const long pgcnt = 1l << order;
+
+	mod_node_page_state(page_pgdat(page), NR_IOMMU_PAGES, -pgcnt);
+}
+
 /**
  * __iommu_alloc_pages - allocate a zeroed page of a given order.
  * @gfp: buddy allocator flags
@@ -35,6 +59,8 @@ static inline struct page *__iommu_alloc_pages(gfp_t gfp, int order)
 	if (unlikely(!page))
 		return NULL;
 
+	__iommu_alloc_account(page, order);
+
 	return page;
 }
 
@@ -48,6 +74,7 @@ static inline void __iommu_free_pages(struct page *page, int order)
 	if (!page)
 		return;
 
+	__iommu_free_account(page, order);
 	__free_pages(page, order);
 }
 
@@ -67,6 +94,8 @@ static inline void *iommu_alloc_pages_node(int nid, gfp_t gfp, int order)
 	if (unlikely(!page))
 		return NULL;
 
+	__iommu_alloc_account(page, order);
+
 	return page_address(page);
 }
 
@@ -147,6 +176,7 @@ static inline void iommu_put_pages_list(struct list_head *page)
 		struct page *p = list_entry(page->prev, struct page, lru);
 
 		list_del(&p->lru);
+		__iommu_free_account(p, 0);
 		put_page(p);
 	}
 }
diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index c11b7cde81ef..be17195f6f86 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -206,6 +206,9 @@ enum node_stat_item {
 #endif
 	NR_PAGETABLE,		/* used for pagetables */
 	NR_SECONDARY_PAGETABLE, /* secondary pagetables, e.g. KVM pagetables */
+#ifdef CONFIG_IOMMU_SUPPORT
+	NR_IOMMU_PAGES,		/* # of pages allocated by IOMMU */
+#endif
 #ifdef CONFIG_SWAP
 	NR_SWAPCACHE,
 #endif
diff --git a/mm/vmstat.c b/mm/vmstat.c
index db79935e4a54..8507c497218b 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -1242,6 +1242,9 @@ const char * const vmstat_text[] = {
 #endif
 	"nr_page_table_pages",
 	"nr_sec_page_table_pages",
+#ifdef CONFIG_IOMMU_SUPPORT
+	"nr_iommu_pages",
+#endif
 #ifdef CONFIG_SWAP
 	"nr_swapcached",
 #endif
-- 
2.44.0.683.g7961c838ac-goog

