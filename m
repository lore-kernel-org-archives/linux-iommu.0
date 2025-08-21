Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7375352FEA
	for <iommu@lists.linux.dev>; Thu, 21 Aug 2025 20:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755806931; cv=none; b=GP9SAXB1UL6h+D8dhD1Wdn5dYrqk73Xl3xYI5eUfusfhhfj83xLMgcKDtCjquiTA4CWobdt1OcmawS2ZBdIZvhcuCeMhPk+76gHy2Tm/0JzBOpFx/x+oi7LE0h6X+erLtcKWeyqbebZi7LTLzsR62dyc3pVEcCS3PceOXXOBTiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755806931; c=relaxed/simple;
	bh=vBZZGz0SB0V7Hvywd1N29mvuGT2dBN/lU5Bb9Xz8Q6s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=KuLKEDI1RxYV7jNzL7BVseetvA4Xrvo3kwHmww4zkwNPOdUffgcyJEp7y9H6pnhRUtxW0Ju2PrRxUlC4mXTODe0IQBqQFFqLvTSv0JSmt3FdKn3igjUnOjMeUb6odRORBGXinhKR0lKe0BLM/UHOqQzNFxjk+wT/cO7ICGaIFp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=E+EKZVNo; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E+EKZVNo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755806928;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8aQmj/0+AYT4mPx/DatgQPPbmq0Lkvm9KCqKkKCdC9Q=;
	b=E+EKZVNoIN341jMTTRkCIXdmOqy0S50EZmPngqAufEwPbx8Oovknj/Of1Vh+DK6sLftdgY
	L++eBcRmIkt7n+h5FO9EfzS43bnLz3RahmZyzXuxYejpK2VM4NKGP871WLsIEKMqLyzFZW
	j9CGwzD4GF76CZDfMH8D9xnFLWmSOgg=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-593-jTrmTw4yPI63_LsUUkaIHg-1; Thu, 21 Aug 2025 16:08:46 -0400
X-MC-Unique: jTrmTw4yPI63_LsUUkaIHg-1
X-Mimecast-MFC-AGG-ID: jTrmTw4yPI63_LsUUkaIHg_1755806925
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-45a1b0071c1so6423045e9.0
        for <iommu@lists.linux.dev>; Thu, 21 Aug 2025 13:08:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755806925; x=1756411725;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8aQmj/0+AYT4mPx/DatgQPPbmq0Lkvm9KCqKkKCdC9Q=;
        b=mwWNwWQZPCg4TVC4YPoU4TvtMxtNA+BP8/K1pimf0XHlznPC91arYK3iIv1O4GtP6c
         WPc6vT3abS3Ca8mixvc0LMhfp+qZJgDtwMn0/Tfw1yITRKzh8UeBsitXxfz6+7LxTPcm
         rhcST6QNtzN7G/rIvV9Vjn3mlqE+ieiMMLCrVN0o2K+9h6np42wfXx0nPrOSW9MSitNS
         h+Sz/gFXBfSZVlreRCWvAJUHZpIwepWBKTY27zrUeO03u2Hvmhdo/AptG9NZVROtqI9l
         WlAuUnWAkxs6lmAwvmInD/mFhMLs0klyo0EmzFH5splPysCgs58zqUFM6NAYCoZeI8yO
         2lYg==
X-Forwarded-Encrypted: i=1; AJvYcCX3dMvbGjpqi+W8bAGtMvumVSMCK78jWl6e3l7ZdoH5kBQ00nNVgNAwLZ+V5rvFUSDjXFndvQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzrHx/EKxmLYkyw6OyxukxJPYY4N92/3FCMeynDCdZBzbXeVbOf
	ReaiSJ+XNCTDY/8QvEaTCWNs9NZCDnK1CXMSzELPsbiizMiswSTdIBi0ABFAntoDUSwfFXfaijX
	MkpzKHGYkjt35veAoCSOHpQv0BNjGhAvfdnJoWMq1nnjGcTaWK+vX2Bln
X-Gm-Gg: ASbGncsAKbr3jV4qzcq97tvEFcj92Grud/iNube59dm9sO3TEaVvj+N4vcp5PsS4/6O
	MsCcBRBrmIS+Kco2F+QTt2Skh/vw1tA4mSNGRE0p4OgQh4prTRk7MX2zN0FyX/EIVCgjYdGrDz3
	0wjz8sO8X2/6QdfshcBznM86xyXibtpYMIKMcCCrE+1k2bnAcDbSmd4ECAhqhQOw+qKaEXpsoCM
	nLvlY79GCYqopS+fgIhvwLAfcjK2bwJyPxVF+67NmcGahuqj9LIoUCmOap9o48XCBJnUQdGarF1
	ROl/CQxQEd3K32klW5veMg5RycVuy9h1j0C6kcP6gkPyFQp6qhyBLDiJ5aPgz3ZB/4xoU0h8OTr
	nA7ytieevKBdFvSSgW8koJg==
X-Received: by 2002:a05:600c:3b25:b0:459:da89:b06 with SMTP id 5b1f17b1804b1-45b517b008dmr3774175e9.16.1755806925516;
        Thu, 21 Aug 2025 13:08:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHDDv+I9AWZPVyKVFD2prHDmQqsK3mzEWwP5yNf0oRJXtHjmqgi3hMC3hwAmszm5rTAtK85Rg==
X-Received: by 2002:a05:600c:3b25:b0:459:da89:b06 with SMTP id 5b1f17b1804b1-45b517b008dmr3774035e9.16.1755806925116;
        Thu, 21 Aug 2025 13:08:45 -0700 (PDT)
Received: from localhost (p200300d82f26ba0008036ec5991806fd.dip0.t-ipconnect.de. [2003:d8:2f26:ba00:803:6ec5:9918:6fd])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-45b50e0a479sm8895255e9.21.2025.08.21.13.08.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Aug 2025 13:08:44 -0700 (PDT)
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
Subject: [PATCH RFC 35/35] mm: remove nth_page()
Date: Thu, 21 Aug 2025 22:07:01 +0200
Message-ID: <20250821200701.1329277-36-david@redhat.com>
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
X-Mimecast-MFC-PROC-ID: LxZa_NAkT_Gltq6xwI6Zfx9pTgQM2vOsMm9jb1A-ucg_1755806925
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Now that all users are gone, let's remove it.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/linux/mm.h                   | 2 --
 tools/testing/scatterlist/linux/mm.h | 1 -
 2 files changed, 3 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index f59ad1f9fc792..3ded0db8322f7 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -210,9 +210,7 @@ extern unsigned long sysctl_admin_reserve_kbytes;
 
 #if defined(CONFIG_SPARSEMEM) && !defined(CONFIG_SPARSEMEM_VMEMMAP)
 bool page_range_contiguous(const struct page *page, unsigned long nr_pages);
-#define nth_page(page,n) pfn_to_page(page_to_pfn((page)) + (n))
 #else
-#define nth_page(page,n) ((page) + (n))
 static inline bool page_range_contiguous(const struct page *page,
 		unsigned long nr_pages)
 {
diff --git a/tools/testing/scatterlist/linux/mm.h b/tools/testing/scatterlist/linux/mm.h
index 5bd9e6e806254..121ae78d6e885 100644
--- a/tools/testing/scatterlist/linux/mm.h
+++ b/tools/testing/scatterlist/linux/mm.h
@@ -51,7 +51,6 @@ static inline unsigned long page_to_phys(struct page *page)
 
 #define page_to_pfn(page) ((unsigned long)(page) / PAGE_SIZE)
 #define pfn_to_page(pfn) (void *)((pfn) * PAGE_SIZE)
-#define nth_page(page,n) pfn_to_page(page_to_pfn((page)) + (n))
 
 #define __min(t1, t2, min1, min2, x, y) ({              \
 	t1 min1 = (x);                                  \
-- 
2.50.1

