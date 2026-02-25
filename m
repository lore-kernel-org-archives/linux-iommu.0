Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A7B43D903B;
	Wed, 25 Feb 2026 16:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772037723; cv=none; b=bYVExsCodPJ+NyqnB/eQKswctDQFg9LIMu+3eXFdzZ1F6deJmrN71wPCVwuUskBh60696EDYwZx/FFN+uhVDzbDROTU+pzZWH/zqSSLBC5y0WQC4m2JbWkE/8w3ibGTsySlFkim9uGf6pGtGJeR/1h2yEKkvnoR2mSwh7D0HX4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772037723; c=relaxed/simple;
	bh=rfgqTaniyFcFynC/obpaUFFlyjqqthgGha52ltIUlUY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uwx9WJP/qiiVmpHrLk5xpirS52eNl0926i5jyInnRrkfMgzKk/87m0GFAVhZqZvYEvxXg9CSu5jAetkCsenuY94qpK+adgHfkhEuznsec7IN/cFD0vlQj4DHszXqe03QgmeA5CviMk7ba+95UdX7UYWSwPstYoFrq6hzNoWS9So=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=csGKWkXe; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="csGKWkXe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83989C116D0;
	Wed, 25 Feb 2026 16:42:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772037723;
	bh=rfgqTaniyFcFynC/obpaUFFlyjqqthgGha52ltIUlUY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=csGKWkXeguSQ37zJjf0IB2wvQOQl3/WLcW4dmFDzDbdcBjbHPT1zkBKm6J29MSeg6
	 xhGvtq3bNTlGh6/EGDE2aTQtaxs4VsiOO8ohZ2uB4qEil0ou0qeDg8Zr7kAe8TBQWh
	 /ZNRi1fKctGSLW4gpZYseuHiM9psy8MQJNSqh/2n2F066mlBVd0PXwhBTZTDlLzCCd
	 6cO4rjPG9kIAF8nlnZMXKsmji5AT5/nOSZdCE576FJIIzyETNCdF3hir5mY3Hafts+
	 qB6j6M+QC+Pyc8JmQdhe60ULJfAb5mmiK2sCdYE4YEMtxEM9uE86j2SXH3mADgDoZA
	 frH/OyTpRyjqQ==
From: Maxime Ripard <mripard@kernel.org>
Date: Wed, 25 Feb 2026 17:41:50 +0100
Subject: [PATCH 2/7] mm: cma: Export cma_alloc and cma_release
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260225-dma-buf-heaps-as-modules-v1-2-2109225a090d@kernel.org>
References: <20260225-dma-buf-heaps-as-modules-v1-0-2109225a090d@kernel.org>
In-Reply-To: <20260225-dma-buf-heaps-as-modules-v1-0-2109225a090d@kernel.org>
To: Sumit Semwal <sumit.semwal@linaro.org>, 
 Benjamin Gaignard <benjamin.gaignard@collabora.com>, 
 Brian Starkey <Brian.Starkey@arm.com>, John Stultz <jstultz@google.com>, 
 "T.J. Mercier" <tjmercier@google.com>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Marek Szyprowski <m.szyprowski@samsung.com>, 
 Robin Murphy <robin.murphy@arm.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 David Hildenbrand <david@kernel.org>, 
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
 Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>, 
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>
Cc: linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org, 
 iommu@lists.linux.dev, linux-mm@kvack.org, 
 Maxime Ripard <mripard@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1196; i=mripard@kernel.org;
 h=from:subject:message-id; bh=rfgqTaniyFcFynC/obpaUFFlyjqqthgGha52ltIUlUY=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDJnz1fxfHNsUEn3B2H5a+v+PEQp7p6W9/xnC8syK+dSd1
 jP7uFa1dUxlYRDmZJAVU2R5IhN2enn74ioH+5U/YOawMoEMYeDiFICJ+OQyNrwRDNz268/LgH9P
 9faUbHvhyCZb/z7vtFLTNmaVGbExClx7qz9r8xUdaLklcuJigejvLYwNfdXrtpw+nXW/t5v7yV3
 1jSov2r2+t+V/2ejWE/CpN/ax103GSc5iU9vnm62Im7lg1bpvAA==
X-Developer-Key: i=mripard@kernel.org; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D

The CMA dma-buf heap uses cma_alloc() and cma_release() to allocate and
free, respectively, its CMA buffers.

However, these functions are not exported. Since we want to turn the CMA
heap into a module, let's export them both.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 mm/cma.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/cma.c b/mm/cma.c
index 94b5da468a7d719e5144d33b06bcc7619c0fbcc9..be142b473f3bd41b9c7d8ba4397f018f6993d962 100644
--- a/mm/cma.c
+++ b/mm/cma.c
@@ -949,10 +949,11 @@ struct page *cma_alloc(struct cma *cma, unsigned long count,
 	if (page)
 		set_pages_refcounted(page, count);
 
 	return page;
 }
+EXPORT_SYMBOL_GPL(cma_alloc);
 
 static struct cma_memrange *find_cma_memrange(struct cma *cma,
 		const struct page *pages, unsigned long count)
 {
 	struct cma_memrange *cmr = NULL;
@@ -1025,10 +1026,11 @@ bool cma_release(struct cma *cma, const struct page *pages,
 
 	__cma_release_frozen(cma, cmr, pages, count);
 
 	return true;
 }
+EXPORT_SYMBOL_GPL(cma_release);
 
 bool cma_release_frozen(struct cma *cma, const struct page *pages,
 		unsigned long count)
 {
 	struct cma_memrange *cmr;

-- 
2.53.0

