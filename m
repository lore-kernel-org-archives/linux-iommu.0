Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85EDE3A4F2B
	for <iommu@lists.linux.dev>; Wed, 14 Jan 2026 16:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768409013; cv=none; b=hM/BMClSDNS3B5trKMfjrRisuuFb3eDar7EsxGjrrMpV0eXBsGuUEiDw3LeWUXo2h8ClnN02ZAj7z8BaBBz5c3CbU2+EAuwF/S6FX9OtbThBw0Nh+XE/5Cdt5+ghhyap7rxco/aulgxPWGF6mV6jwNzvtzhleiWAXkj8qJ7vKXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768409013; c=relaxed/simple;
	bh=7BYRgRnhfN3fHr35Z4lIewD7nb4bdgg7dJRSYUFPl2k=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=O4+Vvp7EqjylrNeaenE2F10K/tjrrwTIETmEoL3TY4UbG2Ib2to35BkHh2ocEHAiQs3qJDNDnEkvmdBwjKUN8Ba9wnLv8kVc//wIElljBpn4cCQ+Oe8zVPdFI2fyOsONy7a4VCuBrSjykeh5X9SRVkZe8RlEln8hhT5WI2QGczY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fgQSj+Fq; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fgQSj+Fq"
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-47d1622509eso163405e9.3
        for <iommu@lists.linux.dev>; Wed, 14 Jan 2026 08:43:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768409011; x=1769013811; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=NagltRQpX2SlKWY3/YB/PdnajjFmvEiNKHSf6/veCZ0=;
        b=fgQSj+FqKeuIfgG6iTvwybGJCQjIesltuYf/5HeA45P1lpGcDtvwY264uqczJtTYg7
         eLcrUNH9EjlSeZNOTkTym9I8guxHZel70je3B/1QnXJ+2MEgDdL9Q2YQ/EFc9Q8V0b8H
         jJqZosTFz4R67xlf6rtTCzLjQa+wSOVSbPBmnJ0v0wsXyyTZv9EbXx1pU6pgOgV+Ezr9
         PudKrsY6jGg2h01ULCYxZ/I3BKTrA9fxSf/vcqQ6MlccSkNpZc9C9zihX8gCP0pKle6k
         Helrr9eU+yGHjcscF23l1ToP7mzLHCfySkF5Q3JdpIURjEs3J0PJY05ukgCEHzwwUAr9
         9M+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768409011; x=1769013811;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NagltRQpX2SlKWY3/YB/PdnajjFmvEiNKHSf6/veCZ0=;
        b=tixDaKz9OGmbnlKiSM3K7WZQlB4j6mj+y6KaNAgu+nJiA4UBnCk9CmB/TKoN/uVq3g
         pKdYhoB/eNlOdc4V+QLNZObVEx+E423MlUzU/GOQWFkVxlUA3/szhobkrVJ/WuZ0sgHi
         EqLamh79uq06shwymkNLWKxLxwyk/L1BRzMYdl/K5LMgcWpLMoXtIGf7p7Sy5J/czn1k
         u6H207xccajUJOFWqb9O3N2PTKVdXrypYIvoHerngg85V+6QXAaIFaB/5nCiPoOMcNTl
         aqkOVClHOJu6ZCxXRVpdVIrfYAH5JS5yLK+CUCLsXD0BLrsbjP6k2yvWKCkAllsT0bOA
         elGg==
X-Forwarded-Encrypted: i=1; AJvYcCVYzqjWGJFr3ZU2jy/eCYs+Xy2TnWNma8FlkmSV0Ylz2ozVJPYCPpDuOZd1UG2b9NhPfwA34Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YxDo6rqDhnZjMH8N1Q3A6O99dqFgKMW0nUlXwu1TAIKRZDutywS
	rljL2lJOQZk9LRAtFW5VYKN9kDzdvXJCnJYQ79hJcCWAwOastkVx29vsQDypCObBbF5iZsDAVXY
	C9nykY/2ejtDLPA==
X-Received: from wmbd23.prod.google.com ([2002:a05:600c:58d7:b0:477:9654:b44c])
 (user=smostafa job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:8707:b0:477:7f4a:44b4 with SMTP id 5b1f17b1804b1-47ee33192c2mr42786345e9.1.1768409011069;
 Wed, 14 Jan 2026 08:43:31 -0800 (PST)
Date: Wed, 14 Jan 2026 16:43:18 +0000
In-Reply-To: <20260114164322.787125-1-smostafa@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260114164322.787125-1-smostafa@google.com>
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260114164322.787125-2-smostafa@google.com>
Subject: [PATCH v7 1/5] mm/page_ext: Add page_ext_get_phys()
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

In the next patches, IOMMU code will add data to page_ext.
The IOMMU code would operate on physical addresses which
can be outside of system RAM.

Add a new function page_ext_get_phys() to abstract the logic of
checking the address and returning the page_ext.

Signed-off-by: Mostafa Saleh <smostafa@google.com>
---
 include/linux/page_ext.h |  6 ++++++
 mm/page_ext.c            | 23 +++++++++++++++++++++++
 2 files changed, 29 insertions(+)

diff --git a/include/linux/page_ext.h b/include/linux/page_ext.h
index 76c817162d2f..bd373496e166 100644
--- a/include/linux/page_ext.h
+++ b/include/linux/page_ext.h
@@ -93,6 +93,7 @@ static inline bool page_ext_iter_next_fast_possible(unsigned long next_pfn)
 #endif
 
 extern struct page_ext *page_ext_get(const struct page *page);
+extern struct page_ext *page_ext_get_phys(phys_addr_t phys);
 extern void page_ext_put(struct page_ext *page_ext);
 extern struct page_ext *page_ext_lookup(unsigned long pfn);
 
@@ -215,6 +216,11 @@ static inline struct page_ext *page_ext_get(const struct page *page)
 	return NULL;
 }
 
+static inline struct page_ext *page_ext_get_phys(phys_addr_t phys)
+{
+	return NULL;
+}
+
 static inline void page_ext_put(struct page_ext *page_ext)
 {
 }
diff --git a/mm/page_ext.c b/mm/page_ext.c
index d7396a8970e5..95e8c40131b7 100644
--- a/mm/page_ext.c
+++ b/mm/page_ext.c
@@ -534,6 +534,29 @@ struct page_ext *page_ext_get(const struct page *page)
 	return page_ext;
 }
 
+/**
+ * page_ext_get_phys() - Get the page_ext structure for a physical address.
+ * @phys: The physical address to query.
+ *
+ * This function safely gets the `struct page_ext` associated with a given
+ * physical address. It performs validation to ensure the address corresponds
+ * to a valid, online struct page before attempting to access it.
+ * It should return NULL for (MMIO, ZONE_DEVICE, holes, offline memory)
+ *
+ * Return: NULL if no page_ext exists for this physical address.
+ * Context: Any context.  Caller may not sleep until they have called
+ * page_ext_put().
+ */
+struct page_ext *page_ext_get_phys(phys_addr_t phys)
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

