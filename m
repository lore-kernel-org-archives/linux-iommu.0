Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 302663469EC
	for <iommu@lists.linux.dev>; Thu,  6 Nov 2025 16:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762447215; cv=none; b=kQmetLSQGfqTo21GVCJWboQxRnGnNtOxx2eH/Sc9Dlvlbv6xEq4/9uFfHQvztxQCX+A9I8Yhf7NhUwA4/pNRzFWQj1vJ0749xgnKAoLmyDfJr7Oz5ZKx1t8fxZpBtSTnL763yeDu1CwC48H5PMzM9bsABUwmE3gung3T848Gyd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762447215; c=relaxed/simple;
	bh=YwTj3xPUl5UlBDRODGhVqQxa9CgJ+NfuerK8zGcP/W8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Y9yC23egop8uwtYmhQOtNcYoM4Jkr6ZWgjwaZBvuYT6qzZ/n9lMrm87SDS2B3WWJrlHoisaPSDYcyuCLh96+S6izLrUk9Wy52njq+9zgkqaXwtPbh99haH8TPg0HJ0oIED0ctXvImwT+e27poVuDJuYX0DJ5TggaV9O5Ykppfm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Rljf0hnF; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Rljf0hnF"
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-429c5f1e9faso933989f8f.3
        for <iommu@lists.linux.dev>; Thu, 06 Nov 2025 08:40:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762447211; x=1763052011; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=1MuGWRmebEyeJKEBuBok+7/p5tCLW5lhor0NHCb2aik=;
        b=Rljf0hnFoRB3JGdLGRSaU7fRRVP4wWbc8uwGLXDUvGokFLXhAtB4T0j1u/IFRpPFZV
         i516COXxHbwtnLw5KW4Xn5mk6vSCgWcXvgQWmyMMlkZlTD4Nq/tLvEZYrL42odVSfU4A
         /pUbzW+6VKP3BvRlgpQni7h1CO32JvTD/0a1hBax0+kpNWoZ7vvG6ZAgaRwObgewVt7j
         jMnVi+CA5eNFWaF0Q1Gh2C21SRzElHxwn9mNBcWINA3PbHsV0eYhww26bR9tr0vNw760
         Gzge4wZGMYIC4CMIS4g73EO6kFXrePpjTvgMBiUz9MM8wtwfHCoCzp5307Ip0B9KIGZ4
         2RdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762447211; x=1763052011;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1MuGWRmebEyeJKEBuBok+7/p5tCLW5lhor0NHCb2aik=;
        b=PwDDo4uci3Bnln1hQWSgpEtvAEvJQs/MgeNLmyGJ16rSiPdrBYFCb9xx2X9iUa0EME
         xBjExQDDSLn2F0TB6hMCRKW8GayVjUc+BeAL302ttfjl3ak1kUz8SSREqBQH1pFXN5dl
         CQA99rBUgjlfAnZfgph8gJjNz2mp+/0kJT63YIqkIHI65a0WYtXg58ahr1wHRJcvYet5
         Tz6By/PeYb997a2MKYM+jPBOvyqvKyt+b+rdlfecGU1YtFE8o/9zLAxCIqSMG8QrXsAi
         pQt/iCY2QvRpDu4PzYlbg5t48OQ+DjjwgI3swa+2Kum5WwKNUhwPcM2BdWxtSGR2Jw3r
         CIng==
X-Forwarded-Encrypted: i=1; AJvYcCX6bhUlkpgv8i4w6DxsZK232ZNcvDmetaQyyQ5q8tAj0vicnATRTqR2XIjBuTcjZuoVuhnNVQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwevxApVHMdrCNZ8sAU472vwzmV0utgbmasicdukdZCHC+3lwG+
	ZKbcLXiTcXH4U4rODDvn25uMVhxbg2zivSPBNrkIQNbwAt6vkdP5BlfwPiGY8giUa2HJ1pj60gZ
	pxnj2kgeGzMoK1A==
X-Google-Smtp-Source: AGHT+IHysWr4kZOr+q4Pq/IsxPJWwhd0Upf8H/2toPB1V7pns+GJ5i8QYBGBp3tQwp2KTNC96A5o74tpeTcSWw==
X-Received: from wrf23.prod.google.com ([2002:a05:6000:43d7:b0:429:eeb3:9047])
 (user=smostafa job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:220c:b0:429:d4e1:cb9d with SMTP id ffacd0b85a97d-429e32c879dmr5734101f8f.8.1762447211597;
 Thu, 06 Nov 2025 08:40:11 -0800 (PST)
Date: Thu,  6 Nov 2025 16:39:52 +0000
In-Reply-To: <20251106163953.1971067-1-smostafa@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20251106163953.1971067-1-smostafa@google.com>
X-Mailer: git-send-email 2.51.2.1026.g39e6a42477-goog
Message-ID: <20251106163953.1971067-4-smostafa@google.com>
Subject: [PATCH v2 3/4] drivers/iommu-debug-pagealloc: Track IOMMU pages
From: Mostafa Saleh <smostafa@google.com>
To: linux-mm@kvack.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org
Cc: corbet@lwn.net, joro@8bytes.org, will@kernel.org, robin.murphy@arm.com, 
	akpm@linux-foundation.org, vbabka@suse.cz, surenb@google.com, mhocko@suse.com, 
	jackmanb@google.com, hannes@cmpxchg.org, ziy@nvidia.com, david@redhat.com, 
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, rppt@kernel.org, 
	Mostafa Saleh <smostafa@google.com>, Qinxin Xia <xiaqinxin@huawei.com>
Content-Type: text/plain; charset="UTF-8"

Using the new calls, use an atomic refcount to track how many times
a page is mapped in any of the IOMMUs.

For unmap we need to use iova_to_phys() to get the physical address
of the pages.

We use the smallest supported page size as the granularity of tracking
per domain.
This is important as it possible to map pages and unmap them with
larger sizes (as in map_sg()) cases.

Signed-off-by: Mostafa Saleh <smostafa@google.com>
Tested-by: Qinxin Xia <xiaqinxin@huawei.com>
---
 drivers/iommu/iommu-debug-pagealloc.c | 74 +++++++++++++++++++++++++++
 1 file changed, 74 insertions(+)

diff --git a/drivers/iommu/iommu-debug-pagealloc.c b/drivers/iommu/iommu-debug-pagealloc.c
index a6a2f844b09d..0e14104b971c 100644
--- a/drivers/iommu/iommu-debug-pagealloc.c
+++ b/drivers/iommu/iommu-debug-pagealloc.c
@@ -27,16 +27,90 @@ struct page_ext_operations page_iommu_debug_ops = {
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
+ * IOMMU page size might not match the CPU page size, in that case, we use
+ * the smallest IOMMU page size to refcount the pages in the vmemmap.
+ * That is important as both map and unmap has to use the same page size
+ * to update the refcount to avoid double counting the same page.
+ * And as we can't know from iommu_unmap() what was the original page size
+ * used for map, we just use the minimum supported one for both.
+ */
+static size_t iommu_debug_page_size(struct iommu_domain *domain)
+{
+	return 1UL << __ffs(domain->pgsize_bitmap);
+}
+
 void __iommu_debug_map(struct iommu_domain *domain, phys_addr_t phys, size_t size)
 {
+	size_t off;
+	size_t page_size = iommu_debug_page_size(domain);
+
+	for (off = 0 ; off < size ; off += page_size) {
+		if (!pfn_valid(__phys_to_pfn(phys + off)))
+			continue;
+		iommu_debug_inc_page(phys + off);
+	}
 }
 
 void __iommu_debug_unmap(struct iommu_domain *domain, unsigned long iova, size_t size)
 {
+	size_t off;
+	size_t page_size = iommu_debug_page_size(domain);
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
 
 void __iommu_debug_remap(struct iommu_domain *domain, unsigned long iova, size_t size)
 {
+	size_t off;
+	size_t page_size = iommu_debug_page_size(domain);
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
2.51.2.1026.g39e6a42477-goog

