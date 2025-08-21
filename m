Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B91434A337
	for <iommu@lists.linux.dev>; Thu, 21 Aug 2025 20:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755806869; cv=none; b=r3BRGx7tJUU6nVf6HUA0oq/Ux6ohPD2pAVz1azVmpQL+as4jiMxvkngSFuDuGd4JHghxJtjOQM1n3LMQ0V59nYCNh4aoUl6jfGq0LSE+Gn2mL7c4GY0W+jh68pJ4HwB2mLpnVTiXxFGn6lT94pwMXfovbg15BS+VbFc30ZwPCCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755806869; c=relaxed/simple;
	bh=XmsSbVhT3dGsaRmtyroJ024d7WMqPWbEWQJfIPHhOJc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=mLdIjE/UNSaFHYoNHNC0EKd0ttptaz7+Lnxb+pVoE75GDzxMdRVyms9vttlOv8kVXhdIL1FEVHV1LmAaUsDRDi+ifAlr0/UMNR655/bAyJwvpODNrTMV0H/Su/+fiXHumrnpzu8pB7gBhu0zOqHpKIiWzU6hZ3KjXbqk5xuY+Ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZV+YS5Mc; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZV+YS5Mc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755806861;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QQ4Uu4zoWyKmYQrq0i4l3HgKr6VpAHaNUVdQgPTsBAE=;
	b=ZV+YS5MccerI6uY2pqf/7vKplAXlMgD6ISbOe7UToNHf+Pis1Hbm7/0PEJmAxK4QVTKneY
	/SonVCnpG2CQnRZj/aDs3UIU1fxV6K7oi/dIEom4OPfqdNZfdnQtdTrAzceNo8dPO0N2lx
	BHfva8Aq3zEMDeQ+c4MNUSKNksKzMNE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-213-pTJZKmMvN82pJ5Z8Dl4XWQ-1; Thu, 21 Aug 2025 16:07:39 -0400
X-MC-Unique: pTJZKmMvN82pJ5Z8Dl4XWQ-1
X-Mimecast-MFC-AGG-ID: pTJZKmMvN82pJ5Z8Dl4XWQ_1755806858
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-45a1b0511b3so8301535e9.1
        for <iommu@lists.linux.dev>; Thu, 21 Aug 2025 13:07:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755806858; x=1756411658;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QQ4Uu4zoWyKmYQrq0i4l3HgKr6VpAHaNUVdQgPTsBAE=;
        b=uNtW8sjW596q/YACiPrVlgRNi2jS1O79OH+jJslSRlem9yAL4/xiAaP8f1iuaMIIZk
         C0Z1bjkWyMbMxCDZXJknhr/0ey7/9aTYGsqP1hrhqWp87tRu1RiCvckhsWuYpLfBM/pT
         9YgG7zFcvl8pgGcVdBEXJPLmIq5kkeg9tXjiV025C8dd0fg9FMs5q5CswUOhuSNzsefg
         r4vqwSa4gp7VimYJACQm2Shz2g9BqceXKFi9US5RCFXTwJ1yhdJu5I8ECHJR9eSKbkrV
         XTKkrjmLgVyrA0QZ+Nexvk5ILVf16Te0oPjVI1MRblU1w1O8XVLOWLCvntUKMtO20tkq
         X//A==
X-Forwarded-Encrypted: i=1; AJvYcCXn3ix9POS0KtckuM7X3IZn/a/a499HBCZz6emli3OxNL6nNXSmO4s4O80ghGQke3nC7criwg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yyejqh/KeehTkvzA/oQJYL1YlztyMuyarF9vq7/kB0o1QdJw2yP
	K90IDXYE0W7P5RvL0glsFTtAyOJYDMbxq2tPtk7t+6kgDDh70FAt0ZlMWeI6Ep3UeN4sjM1vgf/
	NZ8BhDnXiHbaFt/wc6tE2gjo9mkdza9y5hbn2qbpzmNdve4ZR9Z+0T8SW
X-Gm-Gg: ASbGncsD9n7sqdoA9WpLXK78ay5lirYE+z7oCpEv5KAvglBAFtV5NuLLZ08PeahhQeO
	PRVEHswbuJeBtXZpssTscmUYwm1CRUAvLhv4xvjF0sBFkJCBivm9eO7eB5wF1DU1iAhi/NUEY3b
	H9GJKNaEZiRnMtPCsYzhiVOfF0fqtESGP16dme56/EnUNzUdB5nP0L07IoCTiw+piiH84ZJ+dQc
	3BkHeB7jJYUX7HqPF/XPYeuj3oWoJ2M7RXnUKeiP6BhijoFVM3U+pYLPjIew8c/2IwIDCdetM42
	o/eJnWkrUFiww2j33jVPcu0nxeGZL8JpnXuTy8t8iquWTKoRHvt1zspRTVfZJV/4AM+e2wnqE1Z
	i8w6XYG8EIkkQYjwt3TOP3Q==
X-Received: by 2002:a05:600c:5251:b0:455:f380:32e2 with SMTP id 5b1f17b1804b1-45b517ca54cmr2646445e9.18.1755806857883;
        Thu, 21 Aug 2025 13:07:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHlSU80KqPPviGOLp6CI40u/NjPujjG4FLCG6NoakJIlvY80lRDOTTm20w50mEKFuk0YjVSLQ==
X-Received: by 2002:a05:600c:5251:b0:455:f380:32e2 with SMTP id 5b1f17b1804b1-45b517ca54cmr2646245e9.18.1755806857378;
        Thu, 21 Aug 2025 13:07:37 -0700 (PDT)
Received: from localhost (p200300d82f26ba0008036ec5991806fd.dip0.t-ipconnect.de. [2003:d8:2f26:ba00:803:6ec5:9918:6fd])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-45b4e87858asm18672185e9.3.2025.08.21.13.07.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Aug 2025 13:07:36 -0700 (PDT)
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
Subject: [PATCH RFC 11/35] mm: sanity-check maximum folio size in folio_set_order()
Date: Thu, 21 Aug 2025 22:06:37 +0200
Message-ID: <20250821200701.1329277-12-david@redhat.com>
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
X-Mimecast-MFC-PROC-ID: fxfAq2GWN_2uwl8xUBk4qZMJj_wi7Z68-QPqo8OXmTI_1755806858
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Let's sanity-check in folio_set_order() whether we would be trying to
create a folio with an order that would make it exceed MAX_FOLIO_ORDER.

This will enable the check whenever a folio/compound page is initialized
through prepare_compound_head() / prepare_compound_page().

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/internal.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/internal.h b/mm/internal.h
index 45b725c3dc030..946ce97036d67 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -755,6 +755,7 @@ static inline void folio_set_order(struct folio *folio, unsigned int order)
 {
 	if (WARN_ON_ONCE(!order || !folio_test_large(folio)))
 		return;
+	VM_WARN_ON_ONCE(order > MAX_FOLIO_ORDER);
 
 	folio->_flags_1 = (folio->_flags_1 & ~0xffUL) | order;
 #ifdef NR_PAGES_IN_LARGE_FOLIO
-- 
2.50.1

