Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F4213629A5
	for <iommu@lists.linux.dev>; Thu, 21 Aug 2025 20:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755806886; cv=none; b=AhUVHbIw1hdvUq+jobNJkYHjbKcIl5MNNWef2AdZDTjJ4JSTVVzTWSKrIkBa52SJK3j6nY4FXsHIBpSroTJ9SdXgCjgRcygphfdJF9cU4bYXNP4W7jDExQbw68XZrXEsXRrw4r2mwvYv3+ejdewXveqMB8AOLeUvt+i2nAkC0yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755806886; c=relaxed/simple;
	bh=E88hXeAEs+yXdxHqIfTWo/GvQIeDr+kkFObDidynu1s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=FuxbQSjxJGUAjeLjT17lFa5U9AItM1i+zLFkG70MfMvgbXDtfjBniHXGXD1UmlmIacaN5Ro3yylNZyHw6PIUqNf4zLtnfzwffauUyfbxUYkuBeHWuQ5Qu8PEuRLWXrD7VW/2yW+oEffJURktV4QIOfFUav+yCQXjNRauJpBW5QI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jDPfnpv3; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jDPfnpv3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755806882;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w6VkvDa+3msZeC5nA9B9+aDln+Mg2ABReefULBX94/4=;
	b=jDPfnpv3+N2oUxzL5Ms/5QeVqCMWtriLWVMs1G7Kk3oF7j6obMtvwE4/l4Rl3RVImRwBMJ
	tYlwCX+2//9mdOdWxx7BRMqQeSIGCfrjNDue+zl1985K4KJuXla1qfTmWwK0XOlsaknX3K
	estHeUaIsFKzD8WJkn1aT3SLSx0o5BE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-304-OzV4IiA1O1-1Lh3jfSunDA-1; Thu, 21 Aug 2025 16:08:01 -0400
X-MC-Unique: OzV4IiA1O1-1Lh3jfSunDA-1
X-Mimecast-MFC-AGG-ID: OzV4IiA1O1-1Lh3jfSunDA_1755806880
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-45a15fd6b45so10808075e9.1
        for <iommu@lists.linux.dev>; Thu, 21 Aug 2025 13:08:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755806880; x=1756411680;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w6VkvDa+3msZeC5nA9B9+aDln+Mg2ABReefULBX94/4=;
        b=vzO0Vd/QWyyWXnVcATiZPYqGShh8QfSqLw6ar6IYq4yi6CzbY2PZ1e+ByXmLa+VrXO
         1Ptf60EHlbWLvOHpmxAcTkWcma/h0Wgo6blwPRx13eo+WyhFt5TAsRZuRrqJsD9hRXJe
         j9Yro8jYgo4JROiOxWQhdDxrei9t9q6b3HgfFxi5Z00AIQIC+cx5S7XmU6GMSIdVHQOy
         /bd5hK93S4hCYl+mRg2aIo23bTNK9r6ctQSYkhVdNoTZEowo/OeDx0N9IpSmxT2OrChe
         C7qfk0rsfQj0WY0PZT7AO09sKPM5VxgsABvJdZSa4TozdAbo8JeF5KHfWgjbC6wWAqpO
         KQsw==
X-Forwarded-Encrypted: i=1; AJvYcCWIthl/Os68MsgfK7tplfUi8Jbnls8UM+9zMEAYJOh4Jvl4Z7zPKhQUZfLaVIZediPPxqcllA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxAcCNVGAwlHJYUx18V44pRRo9IZdClfKN7K9VrAw8GZYP883Yb
	cHetNJbBiq5ILuujYA11Mw5Es8W1O756dsj40JFk2UUjZ+5heTpXUzcjkuYzlRQ/TQ2tm5AwySV
	2WF4Mn6Ql+LfiCyq3TdGVmcsUlETIixcijOGqL8FaM1UGfax1hJoD0cbj
X-Gm-Gg: ASbGncu5Hop4hp3vcJW2Gw0T3xezFYAoaeYJ3JluFxeymPZ/nExBOWFyS9AMdIa/pZ3
	OFSUsOBkeh7RJmN7IHcxQTgB1V0E1zB5ps3sNcO9yF2QlvuVZFxGePwKXL6gW7FfYn8w8F8cg2L
	+fJsXHGbmcDqYxj/m41eqBk+ALO5f2ZnSlG3Lf/KLKFDVJXT6NsKcG3Mz4kdk7yuyjO38C1vr39
	pu5AlJlnji1w/ev/vlGnvMhNRlGkMVCCk6Wht67f1zv2fqkIOlV+qi0rbY+OxadRqvmdYthpACn
	vyfvRoA4ExeJva/cbOvZJif43cBV7x/kUFy93q4Dmg49RBxQKp5PBqfOPZQWJk5BtaKeLFE+YBm
	Po3P4ySAEtcv3YLdI7rW9eQ==
X-Received: by 2002:a05:600c:1c87:b0:456:942:b162 with SMTP id 5b1f17b1804b1-45b51792539mr3328675e9.11.1755806880045;
        Thu, 21 Aug 2025 13:08:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG9ciI0WdoI3CxhUtu7m/cESVsdReJmvmXFWCMaWsO+hhXySreox2GeOL2sJ8kVyLPwCYhbEA==
X-Received: by 2002:a05:600c:1c87:b0:456:942:b162 with SMTP id 5b1f17b1804b1-45b51792539mr3328365e9.11.1755806879543;
        Thu, 21 Aug 2025 13:07:59 -0700 (PDT)
Received: from localhost (p200300d82f26ba0008036ec5991806fd.dip0.t-ipconnect.de. [2003:d8:2f26:ba00:803:6ec5:9918:6fd])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3c07778939bsm12219075f8f.46.2025.08.21.13.07.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Aug 2025 13:07:59 -0700 (PDT)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: David Hildenbrand <david@redhat.com>,
	Jens Axboe <axboe@kernel.dk>,
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
Subject: [PATCH RFC 19/35] io_uring/zcrx: remove nth_page() usage within folio
Date: Thu, 21 Aug 2025 22:06:45 +0200
Message-ID: <20250821200701.1329277-20-david@redhat.com>
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
X-Mimecast-MFC-PROC-ID: zg3kQzj0m9myO38PRoTVTdkZsBmqgYoDXqxiBSRvgw4_1755806880
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Within a folio/compound page, nth_page() is no longer required.
Given that we call folio_test_partial_kmap()+kmap_local_page(), the code
would already be problematic if the src_pages would span multiple folios.

So let's just assume that all src pages belong to a single
folio/compound page and can be iterated ordinarily.

Cc: Jens Axboe <axboe@kernel.dk>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 io_uring/zcrx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/io_uring/zcrx.c b/io_uring/zcrx.c
index f29b2a4867516..107b2a1b31c1c 100644
--- a/io_uring/zcrx.c
+++ b/io_uring/zcrx.c
@@ -966,7 +966,7 @@ static ssize_t io_copy_page(struct page *dst_page, struct page *src_page,
 		size_t n = len;
 
 		if (folio_test_partial_kmap(page_folio(src_page))) {
-			src_page = nth_page(src_page, src_offset / PAGE_SIZE);
+			src_page += src_offset / PAGE_SIZE;
 			src_offset = offset_in_page(src_offset);
 			n = min(PAGE_SIZE - src_offset, PAGE_SIZE - dst_offset);
 			n = min(n, len);
-- 
2.50.1

