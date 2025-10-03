Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24E392DBF75
	for <iommu@lists.linux.dev>; Fri,  3 Oct 2025 17:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759512773; cv=none; b=ESLnytkD+xpw/9IlXiJvW4YHXFAdfz4eHeI2jnpIhS96pwWxi5ZZt9+kXU/nn3RhG8ZArbraRjZhk2tQkWsCYAiDiVAQh0MtqUoChb5DjPxNBa5d4UMH6zUNDHOgGjSl5ojSyxEdG+qPJv7QNjuk0lMe2CObOviBg4IznXtROpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759512773; c=relaxed/simple;
	bh=yI6VMn+rJIop9uglbD/KsbP7syNK0e5JT3wJcuKCcIc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XSEJg0HP0Z0MAkpOQfdGN4PEdvhEVw0+R0DeFFPoJr91dwwHyz89FST1SgLSqZ5YveA21SUiBM4WpDzoAQWodW4qmSFntkL+KpJXnnmgTyRxKzPnw1tpf7Z9uQeyHsjU8fb6qlSyth7EwPEZQKME1R4T0XiMusKp5dcYmXc0bA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mE8nwmXV; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mE8nwmXV"
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-46e4943d713so18227725e9.1
        for <iommu@lists.linux.dev>; Fri, 03 Oct 2025 10:32:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759512768; x=1760117568; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=AgDVF0Sn62dc4Fy33aQ885t/YxSjHp9XC3s20FTM60M=;
        b=mE8nwmXV2HOp9dM2fowhrNWLjrhmD9lx+Kl7Oe9BjwissLNYO9YQkK536FZvvs+wmr
         b7ia/1UegzzCESCdH8Zknif2cY+85RUAO1MUS/tjy0Fq0FVxEX0vMOZMgCuzRPpTN6mg
         rSvvUcc283BskPb7OpFJ6cBEkwBtAsL4B+WO4iN3TRqTlmAVeqtKkNc91IaCQFgxzOhp
         Is2LsCt7EzC/ECgMTmdAYrSbCoyqXdP3YdzfLnF9S6n9WGYm3F34SUC6oEcQWrln5pRU
         V7YLIPs4MHRW3NT0406LKBzwu2HnFEQ5GIE/capm0HmbgxGMoO1EKG5vuYDJuA4+i2/Z
         ZrjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759512768; x=1760117568;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AgDVF0Sn62dc4Fy33aQ885t/YxSjHp9XC3s20FTM60M=;
        b=kd8zMfXcIxglokilEiYqfSdFSEzi6Vz4s7MUeC7jwB/l1wJP/A7sKa0jDBvbQWN5oF
         5CCiGSgrovquZcaER/C46lKs7pWFv7d6ZcHJTIDUDiG9EYJ3Fci5NO1hI2DfYiWOD2CN
         ZxSXZlwQKT+QZan8/0JJfgiz6Id6epuK9Rm2iTOpaE32LjxrDLS3T8KWk8KgXjkUs/P+
         LptfK/pSuCHtsP+pA49Ad5jf7lXJIrth0TF3+GHlWiqwlqg4xa0Lbcd0YYIOO9tqgIbU
         FWW1YuVcofUGiQ4psq0BB0UfjRxeo08//3Ed+yrq27HzpiSYsNn8fCbQeKFszXy4+wnn
         mtsA==
X-Forwarded-Encrypted: i=1; AJvYcCUkt5nCedkypAm1JvyJQJtrl45P9X0iQegCz/W6KLdtDbmam4MMgXoYvCr+lk0QdvuouH9Wug==@lists.linux.dev
X-Gm-Message-State: AOJu0YyyaCFPVZ/zuh/td6p6VmIfbRSW72hx5buLSgbLQonbVNHLbbBe
	IFi8S6m3sfUlI9tOv8qdwEEqm1JMZ0cDtDVMDhQ9+91IMEDudSZTovdd3tF9aUcER8dccOR7zhc
	v9+ECr+AP1QkfVQ==
X-Google-Smtp-Source: AGHT+IE28Cn+D6RTRtX91pYwDnd5zfpJjbOEGfORhMIoLTvvcoagejiT2Mcgwr5tybnnq3WA/m4ZzUqRkVc5Cw==
X-Received: from wmcn6.prod.google.com ([2002:a05:600c:c0c6:b0:45d:d522:48a9])
 (user=smostafa job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:8115:b0:46e:3b81:c3f9 with SMTP id 5b1f17b1804b1-46e71143012mr33226465e9.17.1759512768358;
 Fri, 03 Oct 2025 10:32:48 -0700 (PDT)
Date: Fri,  3 Oct 2025 17:32:28 +0000
In-Reply-To: <20251003173229.1533640-1-smostafa@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20251003173229.1533640-1-smostafa@google.com>
X-Mailer: git-send-email 2.51.0.618.g983fd99d29-goog
Message-ID: <20251003173229.1533640-4-smostafa@google.com>
Subject: [RFC PATCH 3/4] drivers/iommu-debug: Track IOMMU pages
From: Mostafa Saleh <smostafa@google.com>
To: linux-mm@kvack.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org
Cc: corbet@lwn.net, joro@8bytes.org, will@kernel.org, robin.murphy@arm.com, 
	akpm@linux-foundation.org, vbabka@suse.cz, surenb@google.com, mhocko@suse.com, 
	jackmanb@google.com, hannes@cmpxchg.org, ziy@nvidia.com, david@redhat.com, 
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, rppt@kernel.org, 
	Mostafa Saleh <smostafa@google.com>
Content-Type: text/plain; charset="UTF-8"

Using the new calls use an atomic refcount to track how many times
a page is mapped in any of the IOMMUs.

For unmap we need to use iova_to_phys() to get the physical address
of the pages.

We use the smallest supported page size as the granularity of tracking
per domain.
This is important as it possible to map pages and unmap them with
larger sizes (as in map_sg()) cases.

Signed-off-by: Mostafa Saleh <smostafa@google.com>
---
 drivers/iommu/iommu-debug.c | 83 +++++++++++++++++++++++++++++++++++++
 1 file changed, 83 insertions(+)

diff --git a/drivers/iommu/iommu-debug.c b/drivers/iommu/iommu-debug.c
index 607f1fcf2235..cec8f594c7fa 100644
--- a/drivers/iommu/iommu-debug.c
+++ b/drivers/iommu/iommu-debug.c
@@ -27,16 +27,99 @@ struct page_ext_operations page_iommu_debug_ops = {
 	.need = need_iommu_debug,
 };
 
+static struct page_ext *get_iommu_page_ext(phys_addr_t phys)
+{
+	struct page *page = phys_to_page(phys);
+	struct page_ext *page_ext = page_ext_get(page);
+
+	return page_ext;
+}
+
+static struct iommu_debug_metadate *get_iommu_data(struct page_ext *page_ext)
+{
+	return page_ext_data(page_ext, &page_iommu_debug_ops);
+}
+
+static void iommu_debug_inc_page(phys_addr_t phys)
+{
+	struct page_ext *page_ext = get_iommu_page_ext(phys);
+	struct iommu_debug_metadate *d = get_iommu_data(page_ext);
+
+	WARN_ON(atomic_inc_return(&d->ref) <= 0);
+	page_ext_put(page_ext);
+}
+
+static void iommu_debug_dec_page(phys_addr_t phys)
+{
+	struct page_ext *page_ext = get_iommu_page_ext(phys);
+	struct iommu_debug_metadate *d = get_iommu_data(page_ext);
+
+	WARN_ON(atomic_dec_return(&d->ref) < 0);
+	page_ext_put(page_ext);
+}
+
+/*
+ * IOMMU pages size might not match the CPU page size, in that case, we use
+ * the smallest IOMMU page size to refcount the pages in the vmemap.
+ * That's is important as both map and unmap has to use the same page size
+ * to update the refcount to avoid double counting the same page.
+ * And as we can't know from iommu_unmap() what was the original page size
+ * used for map, we just use the minimum supported one for both.
+ */
+static size_t iommu_debug_page_size(struct iommu_domain *domain)
+{
+	return 1UL << __ffs(domain->pgsize_bitmap);
+}
+
 void iommu_debug_map(struct iommu_domain *domain, phys_addr_t phys, size_t size)
 {
+	size_t off;
+	size_t page_size = iommu_debug_page_size(domain);
+
+	if (!static_branch_likely(&iommu_debug_initialized))
+		return;
+
+	for (off = 0 ; off < size ; off += page_size) {
+		if (!pfn_valid(__phys_to_pfn(phys + off)))
+			continue;
+		iommu_debug_inc_page(phys + off);
+	}
 }
 
 void iommu_debug_unmap(struct iommu_domain *domain, unsigned long iova, size_t size)
 {
+	size_t off;
+	size_t page_size = iommu_debug_page_size(domain);
+
+	if (!static_branch_likely(&iommu_debug_initialized))
+		return;
+
+	for (off = 0 ; off < size ; off += page_size) {
+		phys_addr_t phys = iommu_iova_to_phys(domain, iova + off);
+
+		if (!phys || !pfn_valid(__phys_to_pfn(phys + off)))
+			continue;
+
+		iommu_debug_dec_page(phys);
+	}
 }
 
 void iommu_debug_remap(struct iommu_domain *domain, unsigned long iova, size_t size)
 {
+	size_t off;
+	size_t page_size = iommu_debug_page_size(domain);
+
+	if (!static_branch_likely(&iommu_debug_initialized))
+		return;
+
+	for (off = 0 ; off < size ; off += page_size) {
+		phys_addr_t phys = iommu_iova_to_phys(domain, iova + off);
+
+		if (!phys || !pfn_valid(__phys_to_pfn(phys + off)))
+			continue;
+
+		iommu_debug_inc_page(phys);
+	}
 }
 
 void iommu_debug_init(void)
-- 
2.51.0.618.g983fd99d29-goog

