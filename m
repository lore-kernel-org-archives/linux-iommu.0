Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1694635FC03
	for <iommu@lists.linux.dev>; Thu, 21 Aug 2025 20:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755806881; cv=none; b=Z7P8xoS1sTzN6q+cp3wXmdNopnciL/7WGTX2wHAUNykjl0omcK0mKCtBXEPfceLL9j0tS+7mUt7bGjNZgcmkxthNG6GSKujkM1rotO2kjZagwdsK6TfsJ28ygqzGmA3vJ8rPcNVltuZ/64vT7QvEEY9KyQjUAg8K+TAGNDmRO+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755806881; c=relaxed/simple;
	bh=g5Pqhen6+TGsZaJhVjcxjHrty8uEIOPaJGSbz6Iayeg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=KMrLinbsjhM4eoWwrJrBObM/ZPqELvK+1ExC3xLEPp8u2UK99n8oO09kZ4GW1KIpHqZCAd/P76U8X+N6rcKlfTEGrzBbtvifIH0/VZ7F3MstgGSt/f0bcr3PTr3xTQO0CIpdLG8nRHwwq9fJ0Qemp/Y8nvCTV+qevBP24en6V/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=c3iWzq7g; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c3iWzq7g"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755806877;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TaqjYk7qiFpFT4dP16wKMuC8fiQfbkUwRRgQVKGzHC8=;
	b=c3iWzq7gztm0r/rqmEUVRMpluw2T/1aAtFoghr8g/YbWc/UTUQZqk7iRcOZ66WodcbK83b
	Y3i1vGo0otccyaMkJqlneCc596gErfhzbxI244W0Nd4cSrD0bGDaCXcS8IIpLp1T1zlapL
	2lBXDWvxtFm3eMMDzq/6V1e9qFggdXQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-575-KI4B0ssUMwCvLYs-OZVnjg-1; Thu, 21 Aug 2025 16:07:47 -0400
X-MC-Unique: KI4B0ssUMwCvLYs-OZVnjg-1
X-Mimecast-MFC-AGG-ID: KI4B0ssUMwCvLYs-OZVnjg_1755806866
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-45a1b0bd6a9so6976805e9.2
        for <iommu@lists.linux.dev>; Thu, 21 Aug 2025 13:07:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755806866; x=1756411666;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TaqjYk7qiFpFT4dP16wKMuC8fiQfbkUwRRgQVKGzHC8=;
        b=rl+rVI3Akl2octhtKRbBsZWRqtjnJUm3ePR9FhiUdJx8fXrz3SBwPlNkYXP/botjBA
         Bmwzg148G+sTJwI1T3rxr/0bqQ5mQaZ+jSPMt3WzSQGMWS0VdoeScaPY4f15BM7sTgUE
         C1ZY3BOY4jmDYPD9LUaEFK1LYgQSXY5IrsBwkEmbuI2dCAGAzD55frd2OE1K9QiUQCAQ
         j44yzI6WF0TiE4PMM4nhgu9nLLRGd126yjDNFsADDBgfen95p4iFd3yJMwRbYDlVLPpw
         JBQh6P1bEuC/lJqaV9YMo6Yu1aQb5P0WG+RiuzqtDgeKzCv0T75wOrS2bC0tQlkM8qKc
         90EA==
X-Forwarded-Encrypted: i=1; AJvYcCXGK9ekz5DvNDhbT3jxkOrDM4wOVm7X6g1BnUxDtB9LqgDHIcDUJgjRNich0F1s+XILyOHfTg==@lists.linux.dev
X-Gm-Message-State: AOJu0YyftgQIcpYtXgknrzQwBwlkecz0feoDaVNCZqn/jiol6K5tj5yE
	1CWBq7zawLh9rpCKvhw+jZ3Teg1//JVu/8ajTVUMXO6r3roF+tyebHac4eOJnO9A54A+a2PqNmJ
	qGwnnMQ/JnbZn1lUdpoLnEnNdrL7NhnLoQxf5bHLruHMXvF+lhK+d0O1u
X-Gm-Gg: ASbGncuwJIXXY0phb9Al9RPjlfhhby+NEbs8yJ0spWRrWY/jksILoS59wPk8tlcqb+O
	KnOTg1FRLdo74hiJyqv/bc9gKY/wgpFfWMH4YEWVGwls+6FRwZFEmXmmd445EqyPMc8sXje2pLt
	Ma2YTti1dRq6sGRew8ppY/4alciFGxtm9uPJQx9KZJ0YIsG0G/Sl8PwWwIm/eH/0MkNPVAS3Pii
	3r4/i9u2jBH6Oz8Tq+n5r9zKcpieMpIlEqdbgmFjeqF5EM1E5FnNEAvmu3uIRVBfhBIe3NohiRy
	3SrbvtWXFZ5vceLuVU+8VG92lLXmiENKBO4xhoKMzhHzbKTR7Rsiqnv8EGrGHCC2E04P0BqDjOX
	q0Swe/lRGNneuDdRWBCUx4Q==
X-Received: by 2002:a05:600c:1392:b0:453:5a04:b60e with SMTP id 5b1f17b1804b1-45b517d4e23mr2819475e9.26.1755806866192;
        Thu, 21 Aug 2025 13:07:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHUtzGc4rPv18tjnV22wd1xjfGI25AJiVbHUBF3o7jj7YvZLrrv8XzLc39l/Z4dCqHj4yY2QA==
X-Received: by 2002:a05:600c:1392:b0:453:5a04:b60e with SMTP id 5b1f17b1804b1-45b517d4e23mr2819075e9.26.1755806865726;
        Thu, 21 Aug 2025 13:07:45 -0700 (PDT)
Received: from localhost (p200300d82f26ba0008036ec5991806fd.dip0.t-ipconnect.de. [2003:d8:2f26:ba00:803:6ec5:9918:6fd])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-45b50dd0380sm8632985e9.10.2025.08.21.13.07.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Aug 2025 13:07:45 -0700 (PDT)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: David Hildenbrand <david@redhat.com>,
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
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Michal Hocko <mhocko@suse.com>,
	Mike Rapoport <rppt@kernel.org>,
	Muchun Song <muchun.song@linux.dev>,
	netdev@vger.kernel.org,
	Oscar Salvador <osalvador@suse.de>,
	Peter Xu <peterx@redhat.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Tejun Heo <tj@kernel.org>,
	virtualization@lists.linux.dev,
	Vlastimil Babka <vbabka@suse.cz>,
	wireguard@lists.zx2c4.com,
	x86@kernel.org,
	Zi Yan <ziy@nvidia.com>
Subject: [PATCH RFC 14/35] mm/mm/percpu-km: drop nth_page() usage within single allocation
Date: Thu, 21 Aug 2025 22:06:40 +0200
Message-ID: <20250821200701.1329277-15-david@redhat.com>
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
X-Mimecast-MFC-PROC-ID: hXlA5GAygDkdb85xymQDpBWrUa_U1NBhc0u782QT9dg_1755806866
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

We're allocating a higher-order page from the buddy. For these pages
(that are guaranteed to not exceed a single memory section) there is no
need to use nth_page().

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/percpu-km.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/percpu-km.c b/mm/percpu-km.c
index fe31aa19db81a..4efa74a495cb6 100644
--- a/mm/percpu-km.c
+++ b/mm/percpu-km.c
@@ -69,7 +69,7 @@ static struct pcpu_chunk *pcpu_create_chunk(gfp_t gfp)
 	}
 
 	for (i = 0; i < nr_pages; i++)
-		pcpu_set_page_chunk(nth_page(pages, i), chunk);
+		pcpu_set_page_chunk(pages + i, chunk);
 
 	chunk->data = pages;
 	chunk->base_addr = page_address(pages);
-- 
2.50.1

