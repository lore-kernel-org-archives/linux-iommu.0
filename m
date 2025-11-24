Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46C1F32E6A6
	for <iommu@lists.linux.dev>; Mon, 24 Nov 2025 20:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764014905; cv=none; b=oG2wJNYf3+6NjdBOmQMtpEquQDMGNPJj7ajhprvK2H1ShUT7jAI5epoTrp5yAUoSPMkjHR5POEfp7ukI3aDlOuyJXdnPK6H2ZSoWfzyBeW1lRVRuY/a/Rb6L7M0HgE8xotD7gMoCQ+k6uy9LdlJwo3x1Pje/UzOLVT8T5FaiWk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764014905; c=relaxed/simple;
	bh=TVsJmHn/g8h0Lp7hpb6hORyJJugUtdX3dm7v25vtnNo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hb+oImuM3MoehGzpA2uBfmm+uJRdgYHXi95M5FiOWlu2SZ1sDiKdPlTgGvILNzkPP7YRJRgkUjfPdTP0G1BDAy4lXMn7FuroW+MEi+mITwV1Ivqv0ltEvj87QUnXODeIVIpX+DzyAf6Jc+41Z8eSz31GhKkfg4I+ySciQG+P5O0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Gi4Sm64a; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Gi4Sm64a"
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-42b2c8fb84fso2511980f8f.2
        for <iommu@lists.linux.dev>; Mon, 24 Nov 2025 12:08:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764014901; x=1764619701; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=KqKpIBZ5ph2RKHb1Juc+0e0et8fqgEk7XdVd6dRoI5w=;
        b=Gi4Sm64aPqX+2CrZRjPgZulwRqI4D1xqX3jGPvCYy6vOdz2UgpO5aI83qGUgZV8sX4
         lL8mXIEd7Vimlhs0Qi2NVRgxddLoCwMzUGGhvhRAVlDD7GL/6ZXZbH4hYFAaMyAatggG
         CQPD7wKuGpO4iM/Q460QB1fkbIofL28KVY06DwDEvlQ1TAc+YB6HfJAe5LamCTiLtJYF
         waXvT7XXIoIYvaIdn1LW0/QXqBVGm1kekHbq2ZOilvz3MkS807tgbGiiJGU+/XLqzT5m
         CJ7KEJzOavmIGhmPkBqtBbilQGZaOO/TJ0xeiXK7E0K6uG/88wntLkEkDKLgquKCUAIu
         mWew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764014901; x=1764619701;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KqKpIBZ5ph2RKHb1Juc+0e0et8fqgEk7XdVd6dRoI5w=;
        b=K43KRjTYbiHMEqZasIkHcGA+oLWuZFvVphPq+FO+r3jUwaQwK/4/AcPSuCnhymzp6B
         3YRuEMfPMQyHBtUENDspEuE5JFV7aUgOSOONg7qD9RoQfzJWnPdaKUiHzzrOEkhc8Cd3
         pvWcvFHOFNNBc51tObJwKi2DUWt7oEgS6M5hpJbxAOhfBl3cgmny7F3Ff4Sxh4b0ct+n
         GDNPV/1eYK4Kcteabg5J4YjIDXPYBoO71UdJXzoTP4EjN+oF+HDOMcy8+oSYykENfLMG
         L0EOvlVxSSIez8uPOLxCvjIFKIl6VuYaBJMt/bI0GhPziObInoFNoRXhrbvXEgCssa+4
         p/7g==
X-Forwarded-Encrypted: i=1; AJvYcCUtfKycEyzE/WzjNHXK6z+zupMXm0/WmKPl2/mIA+fOqKEoEEeu7YyhJVFohtExMLDkyQqe5w==@lists.linux.dev
X-Gm-Message-State: AOJu0YxrWwgDgRbSrkkuGR9+cYnml7ifrMojY7G5NKDK3NJ6TNItfsZl
	+hPCu69qFLXA37/3VOSybaHUZzLortKNWgmt99BcmC3WL5QmBjmjh2e1WUwv4z7/YR9bVkyMi3+
	hAxQgKPP6Gy+xfw==
X-Google-Smtp-Source: AGHT+IE70jlTwwNL3KJSrpPin8RW4YVzvFsosBLdlm8Ql3ZPiG179UHj7pwJfuv7BMtTrtBrnOC1zPhnDThKiQ==
X-Received: from wrui7.prod.google.com ([2002:a5d:6307:0:b0:428:563f:ce93])
 (user=smostafa job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:40c9:b0:42b:3806:2bb7 with SMTP id ffacd0b85a97d-42e0f1e35c2mr143709f8f.6.1764014900720;
 Mon, 24 Nov 2025 12:08:20 -0800 (PST)
Date: Mon, 24 Nov 2025 20:08:10 +0000
In-Reply-To: <20251124200811.2942432-1-smostafa@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20251124200811.2942432-1-smostafa@google.com>
X-Mailer: git-send-email 2.52.0.460.gd25c4c69ec-goog
Message-ID: <20251124200811.2942432-4-smostafa@google.com>
Subject: [PATCH v3 3/4] drivers/iommu-debug-pagealloc: Track IOMMU pages
From: Mostafa Saleh <smostafa@google.com>
To: linux-mm@kvack.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org
Cc: corbet@lwn.net, joro@8bytes.org, will@kernel.org, robin.murphy@arm.com, 
	akpm@linux-foundation.org, vbabka@suse.cz, surenb@google.com, mhocko@suse.com, 
	jackmanb@google.com, hannes@cmpxchg.org, ziy@nvidia.com, david@redhat.com, 
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, rppt@kernel.org, 
	xiaqinxin@huawei.com, Mostafa Saleh <smostafa@google.com>
Content-Type: text/plain; charset="UTF-8"

Using the new calls, use an atomic refcount to track how many times
a page is mapped in any of the IOMMUs.

For unmap we need to use iova_to_phys() to get the physical address
of the pages.

We use the smallest supported page size as the granularity of tracking
per domain.
This is important as it is possible to map pages and unmap them with
larger sizes (as in map_sg()) cases.

Signed-off-by: Mostafa Saleh <smostafa@google.com>
---
 drivers/iommu/iommu-debug-pagealloc.c | 91 +++++++++++++++++++++++++++
 1 file changed, 91 insertions(+)

diff --git a/drivers/iommu/iommu-debug-pagealloc.c b/drivers/iommu/iommu-debug-pagealloc.c
index 5665fd7360e0..c420b006ef08 100644
--- a/drivers/iommu/iommu-debug-pagealloc.c
+++ b/drivers/iommu/iommu-debug-pagealloc.c
@@ -27,19 +27,110 @@ struct page_ext_operations page_iommu_debug_ops = {
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
+static struct iommu_debug_metadata *get_iommu_data(struct page_ext *page_ext)
+{
+	return page_ext_data(page_ext, &page_iommu_debug_ops);
+}
+
+static void iommu_debug_inc_page(phys_addr_t phys)
+{
+	struct page_ext *page_ext = get_iommu_page_ext(phys);
+	struct iommu_debug_metadata *d = get_iommu_data(page_ext);
+
+	WARN_ON(atomic_inc_return_relaxed(&d->ref) <= 0);
+	page_ext_put(page_ext);
+}
+
+static void iommu_debug_dec_page(phys_addr_t phys)
+{
+	struct page_ext *page_ext = get_iommu_page_ext(phys);
+	struct iommu_debug_metadata *d = get_iommu_data(page_ext);
+
+	WARN_ON(atomic_dec_return_relaxed(&d->ref) < 0);
+	page_ext_put(page_ext);
+}
+
+/*
+ * IOMMU page size doesn't have tomatch the CPU page size. So, we use
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
+	size_t off, end;
+	size_t page_size = iommu_debug_page_size(domain);
+
+	if (WARN_ON(!phys || check_add_overflow(phys, size, &end)))
+		return;
+
+	for (off = 0 ; off < size ; off += page_size) {
+		if (!pfn_valid(__phys_to_pfn(phys + off)))
+			continue;
+		iommu_debug_inc_page(phys + off);
+	}
+}
+
+static void __iommu_debug_update_iova(struct iommu_domain *domain,
+				      unsigned long iova, size_t size, bool inc)
+{
+	size_t off, end;
+	size_t page_size = iommu_debug_page_size(domain);
+
+	if (WARN_ON(check_add_overflow(iova, size, &end)))
+		return;
+
+	for (off = 0 ; off < size ; off += page_size) {
+		phys_addr_t phys = iommu_iova_to_phys(domain, iova + off);
+
+		if (!phys || !pfn_valid(__phys_to_pfn(phys)))
+			continue;
+
+		if (inc)
+			iommu_debug_inc_page(phys);
+		else
+			iommu_debug_dec_page(phys);
+	}
 }
 
 void __iommu_debug_unmap_begin(struct iommu_domain *domain,
 			       unsigned long iova, size_t size)
 {
+	__iommu_debug_update_iova(domain, iova, size, false);
 }
 
 void __iommu_debug_unmap_end(struct iommu_domain *domain,
 			     unsigned long iova, size_t size,
 			     size_t unmapped)
 {
+	if (unmapped == size)
+		return;
+
+	/*
+	 * If unmap failed, re-increment the refcount, but if it unmapped
+	 * larger size, decrement the extra part.
+	 */
+	if (unmapped < size)
+		__iommu_debug_update_iova(domain, iova + unmapped,
+					  size - unmapped, true);
+	else
+		__iommu_debug_update_iova(domain, iova + size,
+					  unmapped - size, false);
 }
 
 void iommu_debug_init(void)
-- 
2.52.0.460.gd25c4c69ec-goog

