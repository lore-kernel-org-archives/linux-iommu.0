Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9535B2FC03C
	for <iommu@lists.linux.dev>; Thu, 21 Aug 2025 20:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755806858; cv=none; b=ZuEAwjp3zhdbhHLzYYhO2TwTFNclIII2CcUoAV/BiOnwFBNRcxUh59gZ1Y28aro1kMpNBi9NVw+jz5qeIS5jnYBqxA938qx10seW+Sgle1vJ0ePKCvLPSo7w8GZtMQ2MfSR6GWpMlzlo+/B56A+f/aXxRl167pG/gLex2oLTyFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755806858; c=relaxed/simple;
	bh=+tsaq0kMmRCBgLfPZThux65EZrTtOKARiF8G7W5lNZE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=hq0kgwKqRoZOLTJdBs1KAztwVi4iHlAueWCdSSn81HHTr3FBJWFZ2DvzOeQ34/ogEzR/h/UE8NRTDW3dwjAk5s2NQ+DEpW8BVg6M0fNGCYN6xS8YCNBr/lZSyIGVRvH4b7CACJMmpBqBE5z9ZOdV/ZVmpyfm1QYhwdNEeyfmfI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=E5sl1wE1; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E5sl1wE1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755806855;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=r/kmddABpvZJu5K+QD662cz6jOGE1r8xokeQdlRgepQ=;
	b=E5sl1wE1CIsFxUa+wftRZxms6HR2vxmvN9JdZjJYNl0uTyOJx5CZ0nCloW0VrKdexTfYgZ
	N3+MiM0LTD0pGSt+G0DAUw0xS5VRBIWbGUtIJRjsSdrsQzmH7qeH3FwG7wtuUKGm6qW68O
	nSiCz60weTDbWZ1Z4QK1GAoMaZsCJY0=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-447-I-qd2X5wNFC4TeOKIj8yQA-1; Thu, 21 Aug 2025 16:07:33 -0400
X-MC-Unique: I-qd2X5wNFC4TeOKIj8yQA-1
X-Mimecast-MFC-AGG-ID: I-qd2X5wNFC4TeOKIj8yQA_1755806853
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3b9edf41d07so651781f8f.3
        for <iommu@lists.linux.dev>; Thu, 21 Aug 2025 13:07:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755806853; x=1756411653;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r/kmddABpvZJu5K+QD662cz6jOGE1r8xokeQdlRgepQ=;
        b=Nh8IYmhxXp5SbyCSFxo//4BjZGDo8DE6G/0xEPdCM7JjCi1bFxJnAaB9+Zd02rcFEt
         eNAOpNjyLVBLEXS2RQWdICQwu1whoU4YkCcOzOzbIkB08KttSKgXrlaMlwxP5q42X7ei
         VtSIfo4tFqLcvl4suBlpL2FQX4GLnI7NSxIapx+OGVBhABFvzddczldidag+buqVgL2C
         8iMsuEbYi02ekQHEWPOo6E6LmBffX/hUVlgYXDjlw2Sg1Fj4vMpnc1eJk9FOLPSBtMxW
         wuA96Tel+j5Qo6d3F4CxRVFK2nTtAaYUMPeZbTIeOIugiQNIu4zbMJoVd1SXiygr0MQB
         CM0w==
X-Forwarded-Encrypted: i=1; AJvYcCV9+rsPBYmuwX1UJDKtE9cPlbVEdhiCZmT/gsskOBgD/xFj02X76fTkYfLTY12cR/O2bokheQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxOPsuiXxET8yRngqV7uvGGMmEGVuK5nAbNsxrcigfyHyzsNIap
	bdHG92Ch/dG+dC8PGbuTtIrLQThIBVUvqg2idlQQENCBVPXgKX3wOz4yj++0O7Q58Ua4+tJWmon
	n6mcoqBSVtURK8/RndRi3RJ2YNy2PPTQhOodIkO/kNnWCLSO5AJITH+5m
X-Gm-Gg: ASbGnctjZ4qRe780ndAColP19khh06dKlcoegqtxzhxz3wAccg+2b3J32sAuUykTTrn
	0pkcv+c+voObzNvSJpQQTyDSE21Fa8niBguM7rwMJ/zBqgJ5NHx83NhhHWz14sdZR+uGUgOXR0x
	tu+VVrUfp0xBwNtOlydjfm/dXAIIDpTndX0/UTDUId6IH+tUDzybZW/Sg7VFaXaAZxO40Pxzqt7
	oH3PBGMczM8wpK3cDVaxwbOlIi2a+WwsOFrkfUaYGqBS4A8ck1gNMScf9Mc3z4n56+oYPBJ+Egl
	neq8yF8ANufIErItv9NrOTskk8u+A/Tm1sO6bjIxUQPEWTLhNhDTvAS7dK83asad6B/fh4nHsk1
	/MCpgwVsjoDv/zZQj0T5S8A==
X-Received: by 2002:a05:6000:2dc7:b0:3b9:15eb:6464 with SMTP id ffacd0b85a97d-3c5daefa9e0mr244675f8f.15.1755806852587;
        Thu, 21 Aug 2025 13:07:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHbqF8V2lF/CygktHxSJZNB7+pmyneW6nxhnLwTxWefpTwvecQ9FG1LkYH8lxi0WUYYPrMQFQ==
X-Received: by 2002:a05:6000:2dc7:b0:3b9:15eb:6464 with SMTP id ffacd0b85a97d-3c5daefa9e0mr244660f8f.15.1755806852102;
        Thu, 21 Aug 2025 13:07:32 -0700 (PDT)
Received: from localhost (p200300d82f26ba0008036ec5991806fd.dip0.t-ipconnect.de. [2003:d8:2f26:ba00:803:6ec5:9918:6fd])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3c077789c92sm12629958f8f.52.2025.08.21.13.07.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Aug 2025 13:07:31 -0700 (PDT)
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
Subject: [PATCH RFC 09/35] mm/mm_init: make memmap_init_compound() look more like prep_compound_page()
Date: Thu, 21 Aug 2025 22:06:35 +0200
Message-ID: <20250821200701.1329277-10-david@redhat.com>
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
X-Mimecast-MFC-PROC-ID: RuSmfwoci1bEuv43KYqa-b6cNKQv7hZkcu5aaUqmgd0_1755806853
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Grepping for "prep_compound_page" leaves on clueless how devdax gets its
compound pages initialized.

Let's add a comment that might help finding this open-coded
prep_compound_page() initialization more easily.

Further, let's be less smart about the ordering of initialization and just
perform the prep_compound_head() call after all tail pages were
initialized: just like prep_compound_page() does.

No need for a lengthy comment then: again, just like prep_compound_page().

Note that prep_compound_head() already does initialize stuff in page[2]
through prep_compound_head() that successive tail page initialization
will overwrite: _deferred_list, and on 32bit _entire_mapcount and
_pincount. Very likely 32bit does not apply, and likely nobody ever ends
up testing whether the _deferred_list is empty.

So it shouldn't be a fix at this point, but certainly something to clean
up.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/mm_init.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/mm/mm_init.c b/mm/mm_init.c
index 5c21b3af216b2..708466c5b2cc9 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -1091,6 +1091,10 @@ static void __ref memmap_init_compound(struct page *head,
 	unsigned long pfn, end_pfn = head_pfn + nr_pages;
 	unsigned int order = pgmap->vmemmap_shift;
 
+	/*
+	 * This is an open-coded prep_compound_page() whereby we avoid
+	 * walking pages twice by initializing them in the same go.
+	 */
 	__SetPageHead(head);
 	for (pfn = head_pfn + 1; pfn < end_pfn; pfn++) {
 		struct page *page = pfn_to_page(pfn);
@@ -1098,15 +1102,8 @@ static void __ref memmap_init_compound(struct page *head,
 		__init_zone_device_page(page, pfn, zone_idx, nid, pgmap);
 		prep_compound_tail(head, pfn - head_pfn);
 		set_page_count(page, 0);
-
-		/*
-		 * The first tail page stores important compound page info.
-		 * Call prep_compound_head() after the first tail page has
-		 * been initialized, to not have the data overwritten.
-		 */
-		if (pfn == head_pfn + 1)
-			prep_compound_head(head, order);
 	}
+	prep_compound_head(head, order);
 }
 
 void __ref memmap_init_zone_device(struct zone *zone,
-- 
2.50.1

