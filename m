Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 802DC3C199D
	for <iommu@lists.linux.dev>; Tue, 20 Jan 2026 09:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768900777; cv=none; b=LpzdU/3oAMb8Jc/WfeV68FN3k/COVPBbMLexMlOYzt6nCCd407MY/Bfr49/vlEHv4L9tntyejG4+gyQ6K12GSNye4U1uAXAykuNc/nva73vK3E5FHGgH94T5Al+ihSzBqBRQ3iYZhqi5dwVqO/C+XCMmmrJQ9NCTIUbOeS08EqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768900777; c=relaxed/simple;
	bh=CMIYGf5nfdXqhWds/ATv/N0CqWGuXJv4QazfjRiiXbk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=c0zNDwnSW5c6BcrRaXQST5FzLhEQeS4qzZck+y0CG6XYFlq2ogiRcYIICc+DH5AlqystcfeZ2NNNgHq9ao4qZuU7aTVDH0VUV/3VUtqHJcGzqE1CV0earwes10N2cQGJnjBUN6u7v/EOPjrqs6JoaznOvgpdvn6PXZicu5LGIXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LJO0hESV; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LJO0hESV"
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-432488a0ce8so4240778f8f.2
        for <iommu@lists.linux.dev>; Tue, 20 Jan 2026 01:19:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768900774; x=1769505574; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=AU5Nlg7dydy9DysYi/5+drcb7JZfuoXoKO5f+zthvtA=;
        b=LJO0hESVOI99RYOuftzkbnCG61XckB2gdSARlb5WEH3HSkaDKc2rEWgmjcS1iVdWNa
         FBp3erVeTJhc41diCqOeu4J9AFkS1yGd5yO3tEzVQLkNf+rcbKla2322WicTE6ilrjRY
         bX2QYrcmWcwtDOxrTG8JguRAcpmoyEy2tTPIM/WBhSwVJOQ27GJuVIi5vh7PBzoxH73M
         V/uszjNfKLBTnbhvayVGshffSd+QOTycy4LrrI3OzXp6WzBdiDqTMe7YS7W4w+t6iCdF
         v2c5LxMSXSEnmYZtWHKDbz0e7vn9KORk3QyJuN0aFjpmWEtGlKM/iuoIOr8C+sIxpL4K
         BbuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768900774; x=1769505574;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AU5Nlg7dydy9DysYi/5+drcb7JZfuoXoKO5f+zthvtA=;
        b=FPC26aB+Q2unaf6p9FFKkNqbx+RHMnnZGBNxoxJlukXMidiEM6pctizMZZoI6sok8p
         2BI1/iemZ/kEWwF6RNQBvPxH5ZIbK9hTfQEhUs+oimkWuPMFD2A+/5u4LEK+kNpJqffN
         qBRbKqNH9rgrxT3nfv7+TGtji5AoE34xncIZNenNfx2RIqfLAGtKo6L3Oc05sXk4EFqX
         BL4ovcuZZXVKQ5HimAStEpP2zRCCUwYOj3m4BtEq1xTdGtwJdzV/XTC6HHjX5XmvG1dh
         sKsZLfzWK/BeTqnFhc/i7UgIQ++BDZQfS13vNeWKUnncIXvRWNDHr9QR10noZccWr06m
         FhNw==
X-Forwarded-Encrypted: i=1; AJvYcCX3tnnIbkgZpUaIpG/WjfcJxVg8v1UuND9u/DAS+VzuFcJI3Vmetm+Z37li+IrD5SbRFGniEA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxxjgggooo0nlHM06FnJkKunRsgQOO5xzzv+LXmlb7c7RFH3Us2
	bIuTaP840M3ZlJMLS/SUrW6dMs2CWCX73o9gHOmsROpz+PepR/lP9+ieuAjrAqU6IedfmStiVL5
	siX1LQ8JRCaITQg==
X-Received: from wrbef5.prod.google.com ([2002:a05:6000:2185:b0:435:8d79:2bc8])
 (user=smostafa job=prod-delivery.src-stubby-dispatcher) by
 2002:a5d:5f90:0:b0:42f:bc61:d1bd with SMTP id ffacd0b85a97d-4358ff62652mr1802129f8f.45.1768900773611;
 Tue, 20 Jan 2026 01:19:33 -0800 (PST)
Date: Tue, 20 Jan 2026 09:19:26 +0000
In-Reply-To: <20260120091926.670155-1-smostafa@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260120091926.670155-1-smostafa@google.com>
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260120091926.670155-3-smostafa@google.com>
Subject: [PATCH v2 2/2] iommu: debug-pagealloc: Use page_ext_get_from_phys()
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
the newly added function page_ext_get_from_phys(), which would
also check for MMIO and offline memory and return NULL in that
case.

Signed-off-by: Mostafa Saleh <smostafa@google.com>
---
 drivers/iommu/iommu-debug-pagealloc.c | 31 ++++++++++++---------------
 1 file changed, 14 insertions(+), 17 deletions(-)

diff --git a/drivers/iommu/iommu-debug-pagealloc.c b/drivers/iommu/iommu-debug-pagealloc.c
index c080a38f45a4..80164df5bab1 100644
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
+	struct page_ext *page_ext = page_ext_from_phys(phys);
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
+	struct page_ext *page_ext = page_ext_from_phys(phys);
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

