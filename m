Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B4AA36932B
	for <iommu@lists.linux.dev>; Thu, 21 Aug 2025 20:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755806895; cv=none; b=fqTEnElcdPGuhVGHGADqnLbzPqQZcihjH4ms3+h16GgDaIUcIgQ2h/9DXysap8LymIpyYF3JKC7KhSzErKZK/AP/4+7eY6KjEDKUmAwyamhxB6F5x7761nA166bNIGc6Xr1n22Ai0c47z7wVPMOaaTctJltRpCrPwyNN1N1lNr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755806895; c=relaxed/simple;
	bh=35i5s1BcLEONuxohRPeqiFHOreLIpfTF289+ZIXZu/s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=GjDsHxGCKs0owTatnjG8I9zj492dI6qatRVCeMmMnuGcdnZCPqK0mcEP1YKj/Bq8FdN2Tvd0yBQMfFl0nwwD1EpbbC0t5GChEn0OgupsgWjd8c+DiTmt/LuNzxlfTLl3dwEWl/K/uItBf+eM6G692Puxu9PkO0joU8j00+BOD3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LAuI4ObQ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LAuI4ObQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755806891;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Pq6EMCEhMXNA7HGNe/O1qYHWHhWZrBzRdRZ7YmKumJw=;
	b=LAuI4ObQ8SK/1nK29SQ4IEJeO17n4p53HUvNerNItBLRh4TlQsyAA9PyGpyeoH4NcTxHAC
	K9wlfm/6fKZWSTr5BDOHiWmzKPrxGtCJGsVIzgrSK99KJpkRgbq1zSw17F/AJhaUnXB3gq
	wsmylcATFHCNgNF9PJ5A09LoNOxU+2g=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-512-AN76Fy3ZNyC_ANlCyChV_w-1; Thu, 21 Aug 2025 16:08:10 -0400
X-MC-Unique: AN76Fy3ZNyC_ANlCyChV_w-1
X-Mimecast-MFC-AGG-ID: AN76Fy3ZNyC_ANlCyChV_w_1755806889
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3b9e4f039ecso759581f8f.2
        for <iommu@lists.linux.dev>; Thu, 21 Aug 2025 13:08:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755806889; x=1756411689;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pq6EMCEhMXNA7HGNe/O1qYHWHhWZrBzRdRZ7YmKumJw=;
        b=AQ1WOAVmmgYY2q83wClBkk1XUYHxs9q8TrdbhIrpPF5UpgL0iVLRPDIvo/djiBtaW/
         4dDQr3bB8xgkFeiJC+Nncvps4s7bCti4sg8436M4q4EytFfKTzloOCpv7X9ZDfqZ3EWH
         McarUQlvhqvKgXInnnDl/1esj/XKt5CWMDIe1Bt0wF1vTQpPpG7cQmGO50vvM6+1J0QS
         S3jg9Y4gN4oLgIuNdyB2noIY46toyf7f9ZBFKAgsgxwppEgO0lSRSYSHEBlgHLc6+B5O
         OUXBR0gcgWEtu1AnTaVxJbwJhbdYCSLMkQbDiIVnYOP/zkAwMR7UBEUH/c4qdTx7uFQH
         5lpA==
X-Forwarded-Encrypted: i=1; AJvYcCV5+NiDka52bYXfxU+8HkPcdKlcjQGsKjman/3ym6bPXoV40ekahc8GQ9Te6r1HG2lEsLtmlA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxPv9GO5PeSestsb4LgBWV2Kvv26pTW8Ed4lJDcAbX6kw0vsevp
	e/lYpmtezCfiN1L00zg0mlyw1KTlxrbFhUwhbbRaYzfpoXXbUOMRmPjacWXRVhafglC18NldTmL
	q3e7+6dWe+kITL6W+TjDii6LM1vdiv2LNGXfkRL7bmxSyrLnPH9AIMSE5
X-Gm-Gg: ASbGncuOZrhMMjPWWyfWG6xkfJDXd9a+3r4QB6goc+yJ68zRv3hclkW3YMnOfs4WvFp
	L0ZJLfMaMC9W2MzUuC6xXGyv5qQHpLzrfinspzasbK+GLumWPZtaf2LCSwLH3VgSKAnrMg808IE
	T2/fJkUvoy7HLOFrZNGrI6M0Hqm+q83cKb3/tb/ZT3Ni7IVN/LkD+uaaJtG85kceYDOrF5KnpPs
	ISVVj5wYW6xmQCfS3W6QDz5AW7csFm1NPBVFYQpRV4gTWCpXL+myjvbw5kEwiaBh2h17rtCOs/Y
	JFIbbQXvpsBIwlhrezUcGU8uqunfFNKJvomESfuVRpRpQQ2PHrxdYwAbVsjSplCtDjhtCdp1zj/
	0jvkd1ppWsRkK8RaKih8+kg==
X-Received: by 2002:a05:6000:40c9:b0:3b7:911c:83f with SMTP id ffacd0b85a97d-3c5da83bf5bmr151970f8f.9.1755806888912;
        Thu, 21 Aug 2025 13:08:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGeHEkncn914iQLB6IDJFbFllUgyuseH1VcCPvg+Bdgchh7CcvmYDhAXktPsYS0hqHcr6hQuQ==
X-Received: by 2002:a05:6000:40c9:b0:3b7:911c:83f with SMTP id ffacd0b85a97d-3c5da83bf5bmr151916f8f.9.1755806888456;
        Thu, 21 Aug 2025 13:08:08 -0700 (PDT)
Received: from localhost (p200300d82f26ba0008036ec5991806fd.dip0.t-ipconnect.de. [2003:d8:2f26:ba00:803:6ec5:9918:6fd])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-45b4e2790a8sm21120815e9.1.2025.08.21.13.08.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Aug 2025 13:08:07 -0700 (PDT)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: David Hildenbrand <david@redhat.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Alexander Potapenko <glider@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Brendan Jackman <jackmanb@google.com>,
	Christoph Lameter <cl@gentwo.org>,
	Dennis Zhou <dennis@kernel.org>,
	Dmitry Vyukov <dvyukov@google.com>,
	dri-devel@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org,
	iommu@lists.linux.dev,
	io-uring@vger.kernel.org,
	Jason Gunthorpe <jgg@nvidia.com>,
	Jens Axboe <axboe@kernel.dk>,
	Johannes Weiner <hannes@cmpxchg.org>,
	John Hubbard <jhubbard@nvidia.com>,
	kasan-dev@googlegroups.com,
	kvm@vger.kernel.org,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-arm-kernel@axis.com,
	linux-arm-kernel@lists.infradead.org,
	linux-crypto@vger.kernel.org,
	linux-ide@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mips@vger.kernel.org,
	linux-mmc@vger.kernel.org,
	linux-mm@kvack.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	linux-scsi@vger.kernel.org,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Marco Elver <elver@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Mike Rapoport <rppt@kernel.org>,
	Muchun Song <muchun.song@linux.dev>,
	netdev@vger.kernel.org,
	Oscar Salvador <osalvador@suse.de>,
	Peter Xu <peterx@redhat.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Tejun Heo <tj@kernel.org>,
	virtualization@lists.linux.dev,
	Vlastimil Babka <vbabka@suse.cz>,
	wireguard@lists.zx2c4.com,
	x86@kernel.org,
	Zi Yan <ziy@nvidia.com>
Subject: [PATCH RFC 22/35] dma-remap: drop nth_page() in dma_common_contiguous_remap()
Date: Thu, 21 Aug 2025 22:06:48 +0200
Message-ID: <20250821200701.1329277-23-david@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250821200701.1329277-1-david@redhat.com>
References: <20250821200701.1329277-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: wfsqArKHUvHgnM_HfMppkbQHy-A33SwQn3vS1JPCSKE_1755806889
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

dma_common_contiguous_remap() is used to remap an "allocated contiguous
region". Within a single allocation, there is no need to use nth_page()
anymore.

Neither the buddy, nor hugetlb, nor CMA will hand out problematic page
ranges.

Cc: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 kernel/dma/remap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/dma/remap.c b/kernel/dma/remap.c
index 9e2afad1c6152..b7c1c0c92d0c8 100644
--- a/kernel/dma/remap.c
+++ b/kernel/dma/remap.c
@@ -49,7 +49,7 @@ void *dma_common_contiguous_remap(struct page *page, size_t size,
 	if (!pages)
 		return NULL;
 	for (i = 0; i < count; i++)
-		pages[i] = nth_page(page, i);
+		pages[i] = page++;
 	vaddr = vmap(pages, count, VM_DMA_COHERENT, prot);
 	kvfree(pages);
 
-- 
2.50.1

