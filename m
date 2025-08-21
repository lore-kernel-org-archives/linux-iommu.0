Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEBAA37E91F
	for <iommu@lists.linux.dev>; Thu, 21 Aug 2025 20:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755806924; cv=none; b=a+JFZAGSjY2Xf48aEg9nr7x8IAZeu9euvoMuceFbY2QDV7I5UEEbAfv5gBSc8jnk08k5ZD9T8F4bRRBg8O0EW2aV+IrHHqi+Gzr2R7qczadQsutAJN5mFhkNOauOXDDMuZJdxemmEPCSLb1Zu2RD8tfnZMtp1AeGY6iXdTPryfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755806924; c=relaxed/simple;
	bh=tCsSQl+WRq69JZRVPLbubBOBHgSgQIUjNop92vdLyr4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=vFhZC56h/vAc7o8rIsUvTEGZ+NRG1qiN5cQoHH5vT9QCixM9obBH57zNhP6QeyQ4B7Eomqa0gSMI9kTz01nFq0/P/CyIEqXRV6LK2KmtSIbfKiq3qgnnSvJGHIM98pHaTvfPIcrhr/dU4WNCZ0WafKJ9CkIZ4PVTfRSvcbliuBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fOD49HRF; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fOD49HRF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755806920;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wK69Pd9CHZjKZhmlaft7kkJNdToX7IH/S9WvVIRScQg=;
	b=fOD49HRFKqBx+Jh+YkATToKV9bMInucg7AS0hzHpNKARRp1dprl6+iaqjuE27C/lFKIN6W
	dmqPhLKblNQy1oZ5uTWhnn1afLrnKSRxlIaV/6hNuVFw4Q3qkFR1TKK+XMEsQS1s8l22rO
	gWSSaO3J2B4md5pg/bQzbWez8iOVZjY=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-661-E29iMc8MNJ-RnwhBXQzZZw-1; Thu, 21 Aug 2025 16:08:39 -0400
X-MC-Unique: E29iMc8MNJ-RnwhBXQzZZw-1
X-Mimecast-MFC-AGG-ID: E29iMc8MNJ-RnwhBXQzZZw_1755806918
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3b9edf332faso441497f8f.3
        for <iommu@lists.linux.dev>; Thu, 21 Aug 2025 13:08:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755806918; x=1756411718;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wK69Pd9CHZjKZhmlaft7kkJNdToX7IH/S9WvVIRScQg=;
        b=p54Eb1gkxWqvgQfxAgnauvfTUuel1lEhtQ2wspvSWgGlARWftfXMBd596CwIoMqrMj
         Q1EIsLB8exYCAKlBfESP7IKclZQCjhL2SJezRITCodOasfqRBvgZUPtvoXVJkTxTGroH
         7TJp7ZXW//tHNfbXmVoXvJtiHFCVQrfV1PvsDj6Y68iXEcfXNUHPybTXuN6e5N6QEiev
         iZQGeeaxyH+dmWB6FDscLoZndhknuXv08zgA+SVtXoUikunIiE0kq/fNA/9VHeMOREhm
         TCZISxNpMyYjbN88a/N115/Mx5exsV/dPECXL92OBdzVsc6o1UIgJnR18uK93083jqs2
         3UMQ==
X-Forwarded-Encrypted: i=1; AJvYcCUoQh9l1FBLl6O6KFYaAB1in5nfm8rfWG0wgSuy6TmiNY9B0057wakO87sJqrU54lNGkUeX/w==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw+V2p7kAu0CNQZqJsu2mUMqxbA8f+he2FySWlsH/bpmaX0mdSl
	hLgmesGWFkf8ASnRptldAjih+RZtC878MMLjE6RaWx8TqfF9FCyZrI5BC+Wgs8/wSc37liKGgJ/
	BIa8DUDJGIvdrwY7YxASZ8ZfS9A/qmGhb2DSDsOUFEnZuE1+3MTvRhqpI
X-Gm-Gg: ASbGncsWaqqAGuqwstjWJtOKnrWaKjsiDnIIrjrx+pZMkjCaxaVyqcf9r79diWSRr4n
	3vQddz/+IQuZ8KSMVDx18MftaFzV8gSE7OeiGrQdXtJB6dXghPOIBqVEWecKOc9f4jTGnVrBWoT
	OEqFjXzl71IlI1mVh63H80RuPvlhEUTIE9M6jjW7MRHOdQNyggVZ96t0BoJhyl6DknHdi9kkso2
	Xtgb8Nbtp4wLIkidH6gZ6w0bhPa+GWZtBCrdPkDl7TfyWVfsdvBuhPGOKLWm6OY4pf6M7wkzWK/
	erKMy4MdB4THsdPdLlBusEhX6q4ah75qFfg600rvInp3E5oRv6rNnQq+vKymCcLvia11lRuEtJY
	dyvN7rdDA/fvgWa6O99x8BQ==
X-Received: by 2002:a5d:64e9:0:b0:3b8:d7c7:62d7 with SMTP id ffacd0b85a97d-3c5daefc298mr218309f8f.16.1755806917853;
        Thu, 21 Aug 2025 13:08:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IETBfJ8klmP3LMs+G3FmlUfLKA9Qlb/rzelQ5gyETYamNwKefh2PCq6Da3p1XS4Ia+K1NPGrw==
X-Received: by 2002:a5d:64e9:0:b0:3b8:d7c7:62d7 with SMTP id ffacd0b85a97d-3c5daefc298mr218279f8f.16.1755806917364;
        Thu, 21 Aug 2025 13:08:37 -0700 (PDT)
Received: from localhost (p200300d82f26ba0008036ec5991806fd.dip0.t-ipconnect.de. [2003:d8:2f26:ba00:803:6ec5:9918:6fd])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3c4ccbf04fasm3355197f8f.7.2025.08.21.13.08.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Aug 2025 13:08:36 -0700 (PDT)
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
Subject: [PATCH RFC 32/35] mm/gup: drop nth_page() usage in unpin_user_page_range_dirty_lock()
Date: Thu, 21 Aug 2025 22:06:58 +0200
Message-ID: <20250821200701.1329277-33-david@redhat.com>
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
X-Mimecast-MFC-PROC-ID: 88M-KI3twgfBwCjOiZZlsIABUn9XTsVMQBt8mcMJTLw_1755806918
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

There is the concern that unpin_user_page_range_dirty_lock() might do
some weird merging of PFN ranges -- either now or in the future -- such
that PFN range is contiguous but the page range might not be.

Let's sanity-check for that and drop the nth_page() usage.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/gup.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/mm/gup.c b/mm/gup.c
index f017ff6d7d61a..0a669a766204b 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -237,7 +237,7 @@ void folio_add_pin(struct folio *folio)
 static inline struct folio *gup_folio_range_next(struct page *start,
 		unsigned long npages, unsigned long i, unsigned int *ntails)
 {
-	struct page *next = nth_page(start, i);
+	struct page *next = start + i;
 	struct folio *folio = page_folio(next);
 	unsigned int nr = 1;
 
@@ -342,6 +342,9 @@ EXPORT_SYMBOL(unpin_user_pages_dirty_lock);
  * "gup-pinned page range" refers to a range of pages that has had one of the
  * pin_user_pages() variants called on that page.
  *
+ * The page range must be truly contiguous: the page range corresponds
+ * to a contiguous PFN range and all pages can be iterated naturally.
+ *
  * For the page ranges defined by [page .. page+npages], make that range (or
  * its head pages, if a compound page) dirty, if @make_dirty is true, and if the
  * page range was previously listed as clean.
@@ -359,6 +362,8 @@ void unpin_user_page_range_dirty_lock(struct page *page, unsigned long npages,
 	struct folio *folio;
 	unsigned int nr;
 
+	VM_WARN_ON_ONCE(!page_range_contiguous(page, npages));
+
 	for (i = 0; i < npages; i += nr) {
 		folio = gup_folio_range_next(page, npages, i, &nr);
 		if (make_dirty && !folio_test_dirty(folio)) {
-- 
2.50.1

