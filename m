Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F7042C0285
	for <iommu@lists.linux.dev>; Thu, 21 Aug 2025 20:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755806855; cv=none; b=kW8qQN95TjA92CyXHL+kin28m1+f+zY8dSux3ILbvouYVYKrUpDZms712BBRX77vHEVu6NKWzrfeIfRMd8Rq61zNjWNTeJumRJRSvxXtt8hoNTVOXn5aJ3+SZHhFhFDkY3QFs2+oOAjkz7dV5S+1wbRLHWHfjrPRXBbqbO+4LTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755806855; c=relaxed/simple;
	bh=ncGz2ZUizfxPtBenqYCMYHXawyPm3K75je3+1YWzFIk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=VJ1pqrK0mPc4qDSaiET78XGU+WWGFDWbYTMgKx/3THH/INOKYcVVS9qCxPC1kW6yrA63sG94TsmXjHVUFhQLP3VgsZhsJ261hVaeowMumLZiHM9YFW/N6z5O3hXnYV98kljDZZBmOqlg+lCpeBPZwHTTM0D6H0eXDOtGdF1j+M0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EWmTx4Rj; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EWmTx4Rj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755806853;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G9hzYOZv6YXUN4v1wicJ53nqMhopJDezqYU76J2buLg=;
	b=EWmTx4RjZtCZ7kg4HR83O1EJQXuv8z0JaWHNVZmRffw25gjmdbNTqKHFk6fzVe/u4OsvpS
	eBodD6HE0gwQub4KkqnpJU2Djaaqv1zg7PosGVFlsAoys6OnC2dExqc4ngzi+8YZb2zitv
	krL867E357KPmbWQTqrlUVUoberRDFU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-187-4mVE4jyjOoOKMM5o0ZEq9Q-1; Thu, 21 Aug 2025 16:07:31 -0400
X-MC-Unique: 4mVE4jyjOoOKMM5o0ZEq9Q-1
X-Mimecast-MFC-AGG-ID: 4mVE4jyjOoOKMM5o0ZEq9Q_1755806850
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-45a1b05a59cso9773815e9.1
        for <iommu@lists.linux.dev>; Thu, 21 Aug 2025 13:07:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755806850; x=1756411650;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G9hzYOZv6YXUN4v1wicJ53nqMhopJDezqYU76J2buLg=;
        b=IJ6mS/55IWOwvkaBTWnHUqncJ0Lw2vPR0mMsj1SbmMC9Bsf+8cgmdWnI/VZW0BErTz
         kjxhwVUwTnPBvQBtjhPCXv+4uAIkwa4gdFCSyc8GTyZOtlhiITYkryRSiGFo+V4CUw+G
         OfVn3IBdYEzNbuNtSInlnT0CQpEyYgNHuUvRdJTFYzxAei7pv14EdMiZFRgFfEqsb4ea
         LNuE9mb1O18Qj0rmoPScT/Fa5behIQ54AK2XNfTRALCWeVnm7XlFJZWahQv0S/9lT3Oh
         xgdaDdhBOYOWiTX5SVBvSLujAGlz0Mo/1alGIDiZVIVe0TN9uTQVsxoy9PFKmBs540TY
         1pHw==
X-Forwarded-Encrypted: i=1; AJvYcCW0oXUOor5zLe5i130nKF/RWPZcAgfPgk7se5A1vx+aZH0G3KEM7oZUB5O6U2tW0TBsxtCQuw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy3KG1ZWiAk/4shhdknZ2dgdDe5rLthfhPM4htI0IVGoTAIUaUj
	LeCrn6GOJHeCjD/LTjMTjPpNvxdR/A3VLUTaS3Jp/LfnSxDxNQ+ymdc2ZWcJGnm4wTQrJTjsdVj
	607hoUXg9pgyyLoJhBraWvrbha19Np90WSnLwteqjNkuKK95PElNg98qW
X-Gm-Gg: ASbGnctmmp5TZYTiA+0ywzjkJ3qiNiGQBiM7ndDn4QWKh6xwZ2UCjIikA2pbGmC61o7
	jLP0NKH0y79ScDY3lFG7qxfPEPlObeAE0JqRTejrS5t8sBRQbhysmTchROfxlp55QCZcAffKR98
	b8Gw8ygYq8krFPo9IcySPXw7Nu7819Df+Pm2zh7lebcJsjoPHM26DXJMsN5orqU2JBge5G488vu
	cgRjv1GNoamr7GX5k14YgfxEjINvk3LCZ8/iQ76HeDozI7Wnvi1Mr2O57BU/xbc+VXBqEjoiY53
	+A5WEe/EUvun4zB4BJDS3ocUPr0M4u/jTeoB5MEB0HtQzBdHgJK3euwviSOhOj5i8WYJ1S51GiR
	KCnMTAXLUWhh67DBGIzYHWQ==
X-Received: by 2002:a05:600c:1548:b0:459:dfde:3329 with SMTP id 5b1f17b1804b1-45b517ddbe2mr2955735e9.31.1755806849996;
        Thu, 21 Aug 2025 13:07:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHPNoTdvVqQJqQwQf/z0aFpcDb/7HunF1Y6KwbAqmFFF4D3cnAaKEmAnoGbjwE6N5eIepmoyw==
X-Received: by 2002:a05:600c:1548:b0:459:dfde:3329 with SMTP id 5b1f17b1804b1-45b517ddbe2mr2955545e9.31.1755806849496;
        Thu, 21 Aug 2025 13:07:29 -0700 (PDT)
Received: from localhost (p200300d82f26ba0008036ec5991806fd.dip0.t-ipconnect.de. [2003:d8:2f26:ba00:803:6ec5:9918:6fd])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3c3a8980ed5sm7242256f8f.16.2025.08.21.13.07.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Aug 2025 13:07:29 -0700 (PDT)
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
Subject: [PATCH RFC 08/35] mm/hugetlb: check for unreasonable folio sizes when registering hstate
Date: Thu, 21 Aug 2025 22:06:34 +0200
Message-ID: <20250821200701.1329277-9-david@redhat.com>
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
X-Mimecast-MFC-PROC-ID: 3s3Eweq9QD8H0fZ0VL0Szp00UZjvidxBwNwsSCaTJ7Q_1755806850
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Let's check that no hstate that corresponds to an unreasonable folio size
is registered by an architecture. If we were to succeed registering, we
could later try allocating an unsupported gigantic folio size.

Further, let's add a BUILD_BUG_ON() for checking that HUGETLB_PAGE_ORDER
is sane at build time. As HUGETLB_PAGE_ORDER is dynamic on powerpc, we have
to use a BUILD_BUG_ON_INVALID() to make it compile.

No existing kernel configuration should be able to trigger this check:
either SPARSEMEM without SPARSEMEM_VMEMMAP cannot be configured or
gigantic folios will not exceed a memory section (the case on sparse).

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/hugetlb.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 514fab5a20ef8..d12a9d5146af4 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -4657,6 +4657,7 @@ static int __init hugetlb_init(void)
 
 	BUILD_BUG_ON(sizeof_field(struct page, private) * BITS_PER_BYTE <
 			__NR_HPAGEFLAGS);
+	BUILD_BUG_ON_INVALID(HUGETLB_PAGE_ORDER > MAX_FOLIO_ORDER);
 
 	if (!hugepages_supported()) {
 		if (hugetlb_max_hstate || default_hstate_max_huge_pages)
@@ -4740,6 +4741,7 @@ void __init hugetlb_add_hstate(unsigned int order)
 	}
 	BUG_ON(hugetlb_max_hstate >= HUGE_MAX_HSTATE);
 	BUG_ON(order < order_base_2(__NR_USED_SUBPAGE));
+	WARN_ON(order > MAX_FOLIO_ORDER);
 	h = &hstates[hugetlb_max_hstate++];
 	__mutex_init(&h->resize_lock, "resize mutex", &h->resize_key);
 	h->order = order;
-- 
2.50.1

