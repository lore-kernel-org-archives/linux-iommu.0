Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6495937F0F3
	for <iommu@lists.linux.dev>; Mon, 19 Jan 2026 14:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768832575; cv=none; b=OJ43OutHd7X2UYFggUUehyxh8zA3I+RfbSJjppGQUisHawjgvAalaHJpsvspHSpG3MT/XmLb5VCFlDqNSYPcwI8PzKZrH8DU5PdJ+3W1wSIVeHEFddvZ5u56ona6JLi9zkNV1Pt7XRMEYrL8edDXMtR3QZc9Z2ymIoI8LhE345A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768832575; c=relaxed/simple;
	bh=etOSXYsmYRMQFELu3qc1hkWPdFr4xMVn+jE7/2P81kE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Wa/WAuIwxxStBQFbGkXOCQWuNoqttxo3U089OqJb6B5bXCApqhNtKt4D9RGIS5mWRlWKQW49OPtfq5rOUahXzCidemOALTMT+Lv3ClI3oLcWiuehFl2dzFSQfIUqXtIeBQKwENYE3KJkWptzN5uC5VA2lin0fsKK1LDC7TDujw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=C0uUUIhK; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="C0uUUIhK"
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-4325b182e3cso2685675f8f.2
        for <iommu@lists.linux.dev>; Mon, 19 Jan 2026 06:22:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768832573; x=1769437373; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ctFjNYhvimSO0VVR6mHcQICH1dILW4P6822Kd8ujTu4=;
        b=C0uUUIhKV/feh/LL4oXK3wM70g1N7ECJjdWudUjbM+NbEgXbpb2KKblMnVdMB/fonz
         CAFPInuy41t4P3e9eMcRvVEvcEAoqhtymsJao/p78vLxaJ4XJbkXa5BLDdsMO+BP5Mbs
         vByp7DehDqWi3ujfKm8MBypJTZ2Q5Ilq7GncUlTZs82JwMWfwTal1ct/6Z2EN96Mobqt
         Vn6OFmZqmM8GQSHNKO9O/BzY40WgKnABF4j2PHqfwzzyquS/MYcrUyEsB801cX88AowU
         /JmI82JhfuI425y+iwqqz8RDfAnB3WzGD7H+zmC7jvt/QyJS+fN8Qz6LFI1lPooNeBFi
         fPbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768832573; x=1769437373;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ctFjNYhvimSO0VVR6mHcQICH1dILW4P6822Kd8ujTu4=;
        b=tOy+xTPg9Ta5wgLQkvyzDwCqE6AYOdn2rlkpVVOc/wHO1jszjXhCRWfu/+MavJOan/
         RGEErj31Vu7QuEQWIlp0StZTyqsSUDBcodeUvyPv1iJ0k3pvyeMDfwz/mXYQi1fCZb6r
         nWvcnxoZ9U3QqyGu2aHHdTmdpGmkFefbCbuPFKeRTr1zdN20H6My1pnCNgKMTEOk7UQ+
         Dx3Y9q20sKasf8CU+8eJSKJEJuZD5hY2aycEJIvo7iu+tify4JbldKOvTRPvM4XlZRVc
         89mOhAxN1BVz51NTZ9yroHpGKMLn7i3wAMvWC2khakE6oOBk64ysNQGqQ8WWmPxIKi/R
         2zyQ==
X-Forwarded-Encrypted: i=1; AJvYcCU+X1fHmfYCqQRRtuG+Ax/7FvNWp1eoqNMhsnAhpeSZqhsYVHbeDLrmr4IUbflUbHYr1+10gw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxIJrKoO2Wv+V+AA4/vOjpWjEwEKjtWqiQFnWEX5nD0sL4FNOLw
	SqQojZl3ivRUunkCr2nyivRNkMkmT+yWMLBFwxbsxLa4lTPficlVG/6OMOi9bckXh3ToIu0+kAz
	KK3RQ2GPaxb4lwQ==
X-Received: from wrwj14.prod.google.com ([2002:a5d:564e:0:b0:432:85e9:432f])
 (user=smostafa job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:8b81:b0:477:9a28:b0a4 with SMTP id 5b1f17b1804b1-4801e2a2176mr148484965e9.0.1768832572948;
 Mon, 19 Jan 2026 06:22:52 -0800 (PST)
Date: Mon, 19 Jan 2026 14:22:46 +0000
In-Reply-To: <20260119142246.3821052-1-smostafa@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260119142246.3821052-1-smostafa@google.com>
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260119142246.3821052-3-smostafa@google.com>
Subject: [PATCH 2/2] iommu: debug-pagealloc: Use page_ext_get_phys()
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

Instead of calling pfn_valid() and then getting the page, call
the newly added function page_ext_get_phys(), which would also
check for MMIO and offline memory and return NULL in that case.

Signed-off-by: Mostafa Saleh <smostafa@google.com>
---
 drivers/iommu/iommu-debug-pagealloc.c | 31 ++++++++++++---------------
 1 file changed, 14 insertions(+), 17 deletions(-)

diff --git a/drivers/iommu/iommu-debug-pagealloc.c b/drivers/iommu/iommu-debug-pagealloc.c
index c080a38f45a4..9343af3bdbb6 100644
--- a/drivers/iommu/iommu-debug-pagealloc.c
+++ b/drivers/iommu/iommu-debug-pagealloc.c
@@ -30,14 +30,6 @@ struct page_ext_operations page_iommu_debug_ops = {
 	.need = need_iommu_debug,
 };
 
-static struct page_ext *get_iommu_page_ext(phys_addr_t phys)
-{
-	struct page *page = phys_to_page(phys);
-	struct page_ext *page_ext = page_ext_get(page);
-
-	return page_ext;
-}
-
 static struct iommu_debug_metadata *get_iommu_data(struct page_ext *page_ext)
 {
 	return page_ext_data(page_ext, &page_iommu_debug_ops);
@@ -45,18 +37,26 @@ static struct iommu_debug_metadata *get_iommu_data(struct page_ext *page_ext)
 
 static void iommu_debug_inc_page(phys_addr_t phys)
 {
-	struct page_ext *page_ext = get_iommu_page_ext(phys);
-	struct iommu_debug_metadata *d = get_iommu_data(page_ext);
+	struct page_ext *page_ext = page_ext_get_phys(phys);
+	struct iommu_debug_metadata *d;
+
+	if (!page_ext)
+		return;
 
+	d = get_iommu_data(page_ext);
 	WARN_ON(atomic_inc_return_relaxed(&d->ref) <= 0);
 	page_ext_put(page_ext);
 }
 
 static void iommu_debug_dec_page(phys_addr_t phys)
 {
-	struct page_ext *page_ext = get_iommu_page_ext(phys);
-	struct iommu_debug_metadata *d = get_iommu_data(page_ext);
+	struct page_ext *page_ext = page_ext_get_phys(phys);
+	struct iommu_debug_metadata *d;
+
+	if (!page_ext)
+		return;
 
+	d = get_iommu_data(page_ext);
 	WARN_ON(atomic_dec_return_relaxed(&d->ref) < 0);
 	page_ext_put(page_ext);
 }
@@ -104,11 +104,8 @@ void __iommu_debug_map(struct iommu_domain *domain, phys_addr_t phys, size_t siz
 	if (WARN_ON(!phys || check_add_overflow(phys, size, &end)))
 		return;
 
-	for (off = 0 ; off < size ; off += page_size) {
-		if (!pfn_valid(__phys_to_pfn(phys + off)))
-			continue;
+	for (off = 0 ; off < size ; off += page_size)
 		iommu_debug_inc_page(phys + off);
-	}
 }
 
 static void __iommu_debug_update_iova(struct iommu_domain *domain,
@@ -123,7 +120,7 @@ static void __iommu_debug_update_iova(struct iommu_domain *domain,
 	for (off = 0 ; off < size ; off += page_size) {
 		phys_addr_t phys = iommu_iova_to_phys(domain, iova + off);
 
-		if (!phys || !pfn_valid(__phys_to_pfn(phys)))
+		if (!phys)
 			continue;
 
 		if (inc)
-- 
2.52.0.457.g6b5491de43-goog

