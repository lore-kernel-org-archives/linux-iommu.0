Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C4E1158D6F
	for <iommu@lists.linux.dev>; Thu, 22 Feb 2024 17:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708623603; cv=none; b=qvUX6EatuOLYNKnie84AcCCbfnLY7F+OVf0rizFZXDA+pbHusclZvO2VcR2Ql0XIyHGZRp/OO/+2GKTAIOF5AuY88JjUPaOmGdsYXxK9C5anxHePN724k/sKCjCNaSjcMSq/xiC2CbE68dP3LiFsDpo+BiFdKxyCIag2Q+5QXL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708623603; c=relaxed/simple;
	bh=1YoYeatwE0jJRPo4fjMAz9I4YBLnIqISqkXjJpSRXIY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sO1HMomCTLs5feC+ekYCXl+dNtbYUg2MFYY/KXDyXWo6gonAaBWQM/K/cRGdd+L6JADtJJARMMt+8YamzTjA4jBWYXxKHRa5g907OlWAtRLw9XORiAxOtpfeFTQ/pm71P3NAeTTkcftlWVbpYGkH5wnfCpija17XIDe6Fh/sIyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=KTIV3XU1; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="KTIV3XU1"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-42c758f075dso10247531cf.0
        for <iommu@lists.linux.dev>; Thu, 22 Feb 2024 09:39:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1708623595; x=1709228395; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V0ReaiTECyup4iu8c9tFSBLtkPVhLn8yFZIGfl9p6vs=;
        b=KTIV3XU1Ws/L17e2nsTLpJVqJe0CYBgLxRPA96nDK9rnltfutunlqbsVbj7wzMIOa0
         yju/ASuf9A8HAyITYzvuAEQELsmM9cqbbmFjzWosFsdJBcYQkYMUrwYiwkXqG9kac/a5
         zSS2kkoD3PxDsMX1RYiVRVwZjLeq9mDxByiUvebW+BpTQe8kQEnDOq70dHJZTydIXMpL
         H6aQ6CXxpgTZbh3Jw9EfsKTrpceLwH9uimhvUWjQA2nK6T0KBTtKt6yzJ2VEDoHNAGeG
         Mh7uXb/rAjQTqqtgo0mjwPduKfByMb//HoBHPz/rhEo8qCxdpnvTH0rlpeW/0vh8lruA
         Fkag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708623595; x=1709228395;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V0ReaiTECyup4iu8c9tFSBLtkPVhLn8yFZIGfl9p6vs=;
        b=jT+ktUDxqL3dXDfC4WY2CicqLAHoH7aBPeyEQQwku6SrxgDb4w2NQqATzg/TS3tipu
         VA0h0W4bqVV/VU2PQnh9XivaRB+P6KHMjGNCki0KdRVAmHYsgm6YUIjaTioC0+qW9QXq
         DkO5TXgbRP4lwgDkOgTyisvLXXJbpbyrjwrxQpo4JBr7TkSpQNk7lrI9u5+ErbGjZYUg
         GCyEXLXOrZpQKJ6agZwjSOqXIAqJfFudzyJ1U6wq8pOZx4BMeR8Zs7lqlXys+ZkB3lZN
         VMNwWqFcCViwFUqTqBCSSXzVoiHZdiBK1CBoulf1k3PyZz1Ex/9sTb/r+1cffo44D7r6
         dzFg==
X-Forwarded-Encrypted: i=1; AJvYcCXt7W797WLqBO23cGKfhRyArqdKZnagjrNsXwq7mQ4N1WNbYn5y8iAvRhovdWW/n5MsYMCIfz0TchkTgexWKVSA3fSzb6Q=
X-Gm-Message-State: AOJu0Yy+4EjZdkeIyXoyai0I+Q6gI+6NVNs+TQ8ZSWV3Ic31aXmWbl9X
	3daDrTErif1/pFJLlNwTDLGhp+OIR2jdxWXRJ/1LQxXqANAhjbRvf4t3l4TcAdxaMigDtNRUDur
	V
X-Google-Smtp-Source: AGHT+IEfgzE/uC4xDSwqJvxbjnpMCM7aGgkDw9ad0MN7VOXeeW4kWverRuOWKwGaZsiVILRRW0AILg==
X-Received: by 2002:ac8:6c2:0:b0:42d:f128:eccf with SMTP id j2-20020ac806c2000000b0042df128eccfmr3903788qth.33.1708623595045;
        Thu, 22 Feb 2024 09:39:55 -0800 (PST)
Received: from soleen.c.googlers.com.com (249.240.85.34.bc.googleusercontent.com. [34.85.240.249])
        by smtp.gmail.com with ESMTPSA id f17-20020ac86ed1000000b0042e5ab6f24fsm259682qtv.7.2024.02.22.09.39.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 09:39:54 -0800 (PST)
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
Subject: [PATCH v5 10/11] iommu: observability of the IOMMU allocations
Date: Thu, 22 Feb 2024 17:39:36 +0000
Message-ID: <20240222173942.1481394-11-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
In-Reply-To: <20240222173942.1481394-1-pasha.tatashin@soleen.com>
References: <20240222173942.1481394-1-pasha.tatashin@soleen.com>
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
index 35bfa369b134..daac2da00e40 100644
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
index a497f189d988..bb6bc504915a 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -203,6 +203,9 @@ enum node_stat_item {
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
2.44.0.rc0.258.g7320e95886-goog

