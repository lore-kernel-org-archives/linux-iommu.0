Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B2BA3A7D6E
	for <iommu@lists.linux.dev>; Wed,  8 Jul 2026 23:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783554539; cv=none; b=b7Gn6Ys7Mcni2blIF/fyRrxuNZODswtYRmWtV0n3uOtSuTb9Ws1Kl3d2787BytsB1NgHO0hw32k1d14DhAmXqlm2sPo5KjXBwHgsfPCIxPWDrwC8xbXW8EGoAsIGPBWmmQnzlRs/kntQbJXsks9kOrsIPsRqvg7pkO9Sb2OWmR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783554539; c=relaxed/simple;
	bh=DEX0yqNi4VHc6r6nOhjQTu2pYp/qtE5fRwU+aO1mx58=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Ef/bsMX1WRpqwXtjDfJ5LVcZeoUW/ypfjrsjH9AkbuvumVwRFRjpHriyH3Kj1kNPKkT15A571rY2D/yTTSywm2hl0CncJIF1twpBSIXrAFRYX+SzkI1kAmytqOKY9WuJ3fBcKmD5ZKuqNiag/n4I/KmkRF9I/0dskIHK5ruuQIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aePdJg+M; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aePdJg+M"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-847ac21582cso1555152b3a.2
        for <iommu@lists.linux.dev>; Wed, 08 Jul 2026 16:48:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783554537; x=1784159337; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lkcC1WuBJfDnOUDpo4VCYaNuz/sum/AUORjsX5C4m/M=;
        b=aePdJg+MecoxGdato6ZD+xMrSh2DtjrAkMiTrQd7dr0b5Gk3/TRExBmjCF0kOgZpJf
         VnZaYk/ogR0dHlUbhP+Mg7X2zatX9S1oX5K2K8q266/t0rE318KiQifMPrg4Z3AsxyIP
         OzeFAdx0rmX1Wd/jWh31/QdJhSCTSHHdFy9ovvlgFJhC0o6oehvtLEXjFef8k6ONSDsy
         aP5HLUgAnVH/Tn2R/SMB3UMokxucDofmqInpIPAISFBZna8Eo92iCiFbjOPhRnAtcIsS
         udG+xFHrdBACV/tUkbyQipLMWBDl5ONOpKcrv2VKSUN8iDQ5x8QCNboXQx7f8XnSFHmp
         nCkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783554537; x=1784159337;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lkcC1WuBJfDnOUDpo4VCYaNuz/sum/AUORjsX5C4m/M=;
        b=RP65fWlWZ75FT4zGntjy3BPwp70YzuPAjygC7aKR3sO+gEi7kAe7+EFjxLiti0z6zF
         1/Y+TQG5T4jH8J2SzzqdcHFXG75KwvhPY7u0kqMAf+w5I5Bwd7w46PEvKc3jKG0FTk51
         H6ONqgNM7bVPreNVbP0jzJ1E5eKP0hVl5YGqV0GsYELdgQGfrljtXyKts0j4ieLuDg6J
         me2UeDMjdUFn4DSDYPiqj7Fv7/44hQ9LqB/6jZDSn96hEmbBgtXeQ9AvY8S03XD2yqSE
         9fNjey+NxwzTY8Y35OAWW7rlQC9Cau3oOKRiD9J64a+bs3cNL4bjI862gKsHmbVibk1t
         FE2g==
X-Forwarded-Encrypted: i=1; AHgh+RpxomdSXUmG/HFrtAVojg7Az4EesO3QA5ZZZejMyVkIbG44mLxpdbdSzZkmq6xE4PpRh6FciQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwnyUgMiNIQyPss3VPeLE/AKHZIFypgbcxPm2rPUSCMNdmlNeze
	+hzu7Rt7tLwEIR+FA+I0DB2Vg03ttKf4a8gXt71vbAIHlfJl7v4aSyKXVVUlFcErqi/TSkgRJBj
	MA9N1ZAZhYYK1JA==
X-Received: from pgbe38.prod.google.com ([2002:a63:5026:0:b0:c99:aff5:7092])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:e082:b0:3c0:9c19:659f with SMTP id adf61e73a8af0-3c0bd23427fmr5506792637.71.1783554537333;
 Wed, 08 Jul 2026 16:48:57 -0700 (PDT)
Date: Wed,  8 Jul 2026 23:48:47 +0000
In-Reply-To: <20260708234854.4044652-1-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260708234854.4044652-1-skhawaja@google.com>
X-Mailer: git-send-email 2.55.0.795.g602f6c329a-goog
Message-ID: <20260708234854.4044652-4-skhawaja@google.com>
Subject: [RFC PATCH v2 03/10] dma: contiguous: Add API to check if an
 allocation is from CMA
From: Samiullah Khawaja <skhawaja@google.com>
To: Marek Szyprowski <m.szyprowski@samsung.com>, Will Deacon <will@kernel.org>, 
	Jason Gunthorpe <jgg@ziepe.ca>
Cc: Samiullah Khawaja <skhawaja@google.com>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Mike Rapoport <rppt@kernel.org>, Pratyush Yadav <pratyush@kernel.org>, Alexander Graf <graf@amazon.com>, 
	Robin Murphy <robin.murphy@arm.com>, Kevin Tian <kevin.tian@intel.com>, iommu@lists.linux.dev, 
	kexec@lists.infradead.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	David Matlack <dmatlack@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Pranjal Shrivastava <praan@google.com>, Vipin Sharma <vipinsh@google.com>
Content-Type: text/plain; charset="UTF-8"

Add an API that uses cma_for_each() to check whether a DMA allocation is
from a CMA region.

Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
---
 include/linux/dma-map-ops.h |  6 ++++++
 kernel/dma/contiguous.c     | 24 ++++++++++++++++++++++++
 2 files changed, 30 insertions(+)

diff --git a/include/linux/dma-map-ops.h b/include/linux/dma-map-ops.h
index 9382785a2faa..9b91c839ceb5 100644
--- a/include/linux/dma-map-ops.h
+++ b/include/linux/dma-map-ops.h
@@ -106,6 +106,7 @@ struct page *dma_alloc_contiguous(struct device *dev, size_t size, gfp_t gfp);
 void dma_free_contiguous(struct device *dev, struct page *page, size_t size);
 
 void dma_contiguous_early_fixup(phys_addr_t base, unsigned long size);
+bool dma_is_from_cma(phys_addr_t phys, size_t size);
 #else /* CONFIG_DMA_CMA */
 static inline struct cma *dev_get_cma_area(struct device *dev)
 {
@@ -145,6 +146,11 @@ static inline void dma_free_contiguous(struct device *dev, struct page *page,
 {
 	__free_pages(page, get_order(size));
 }
+
+static inline bool dma_is_from_cma(phys_addr_t phys, size_t size)
+{
+	return false;
+}
 #endif /* CONFIG_DMA_CMA*/
 
 #ifdef CONFIG_DMA_DECLARE_COHERENT
diff --git a/kernel/dma/contiguous.c b/kernel/dma/contiguous.c
index 03f52bd17120..0b1702bf39ca 100644
--- a/kernel/dma/contiguous.c
+++ b/kernel/dma/contiguous.c
@@ -130,6 +130,30 @@ struct cma *dev_get_cma_area(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(dev_get_cma_area);
 
+struct dma_cma_check_data {
+	phys_addr_t start;
+	phys_addr_t end;
+};
+
+static int dma_cma_check_area(struct cma *cma, void *data)
+{
+	struct dma_cma_check_data *chk = data;
+
+	if (cma_intersects(cma, chk->start, chk->end))
+		return 1;
+	return 0;
+}
+
+bool dma_is_from_cma(phys_addr_t phys, size_t size)
+{
+	struct dma_cma_check_data chk = {
+		.start = phys,
+		.end = phys + size - 1,
+	};
+
+	return cma_for_each_area(dma_cma_check_area, &chk) != 0;
+}
+
 #ifdef CONFIG_DMA_NUMA_CMA
 
 static struct cma *dma_contiguous_numa_area[MAX_NUMNODES];
-- 
2.55.0.795.g602f6c329a-goog

