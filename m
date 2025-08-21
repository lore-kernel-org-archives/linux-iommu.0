Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFFFC2D7DDB
	for <iommu@lists.linux.dev>; Thu, 21 Aug 2025 20:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755806852; cv=none; b=EKxjLpTJJGMLZcyQV30t7pG65PvmhC0hXRj5qZ4J+BEZ8Gu3adTi3SAJbF27tHTcf13JUoh7yi6A007bxAYx70xtAbqDydbQS7pznC0UF3y5rrt0g0RgdqrVWzsLcPkORXEccNArhVHJcJ4eHtS4hC3e8lMyi8JlpGh8G5wcnvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755806852; c=relaxed/simple;
	bh=s79Oeg502W4xdw3NRVnr9AKhHVyvkgzn8FY1ksnzdKY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=ho72fu2bADavFuxF1tYTxuTJPvuzeQiF++BoR2sAfeIUfoej4D2PzZe1s4uM29qiTJKPwx0xKvUA0MrudbnyNzpwwUcF7GW9iAcO+jfb0jZ8WOru0IFh+VH/a3KVUUcuoUbpSIpjFxLdchdBWbDw3n2Nm6VuMGJ5hgqsw3Q1fdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YjT7EvFr; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YjT7EvFr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755806850;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A9Znt0atqEjtEUkbTSfKRsvBJ9rEcbnqI7Kn1XkJSrA=;
	b=YjT7EvFrJT5scdeM5Zhxs1Qk/Cqch+J+8hIxWxlHb7nVNU02myxpnBeJveCAmU84L9yDad
	vtsRlwxqXN6zx8RcnWcVFKhynJbqTs2VIm3xSpDL2hddvTFVyKK/czblWXG8Igw2XVihhk
	Fb0YTZpxr5lzYg/3oduk7oOlhbYva1I=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-689-5xCEi35fPXaGtMkl5A7jhA-1; Thu, 21 Aug 2025 16:07:28 -0400
X-MC-Unique: 5xCEi35fPXaGtMkl5A7jhA-1
X-Mimecast-MFC-AGG-ID: 5xCEi35fPXaGtMkl5A7jhA_1755806847
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-45a1b05b15eso10516215e9.1
        for <iommu@lists.linux.dev>; Thu, 21 Aug 2025 13:07:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755806847; x=1756411647;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A9Znt0atqEjtEUkbTSfKRsvBJ9rEcbnqI7Kn1XkJSrA=;
        b=Ksfeb3I0y6znXtB1ddxQt7SXQx6wvgNgsi4xr4XoOvsJSPY1DR3ZhCPxs998CwjbyB
         rIMQl4Fk6uYwCtzsWFVd+JYiNE2PbFE+gxG78ejaMgG/GHmV/PJgquX6vbhJmqVMx44O
         OIYSI/zmcn41T2fhEXGJMUecNW18M2IjsxD10YvtZmgO88T7Bu++RXvG6IQGZ+aC4elG
         Vv8yn174N8ZXIwYRRxa0NsVH8zwK7RCpQoVSHapiPFx7jwrGB2KayGqQcUUNRhbL1ZqL
         ee6BP6yeehpQ6jgf0BsPxXwsHqz7Z+OrtAxdGFv0jU8MD2ye/BYicAolMt0LK5RHmxSt
         Hfvg==
X-Forwarded-Encrypted: i=1; AJvYcCULmaMG0RJcePRr7Hb+3TVTVkDgR90tB2m4Gxy5/tGygZpVbbCbuhoGCntecnWkLY64DlEDIw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwMKc5v/gjMJlJ/seOFAKOvtSeqsLGPhMD7Pt9BBON15T9IsdUQ
	SDd3a2wg5O08jaq+jQBYjwyKxA1pbHwf2aGeC/TSTN8s9E/92E/eRvmPfo6xnne5dFtwNbgzbfH
	pAPZVK7rgdsreAF5eLnf2jbvYNHtLPoVSV8I/bmZKrYYjDjARtkRVld7G
X-Gm-Gg: ASbGncusILdHZFaiDizKorRepBTWnVPo5vZ6TwkX2Ls9sn+lVLZO8cMGMdFjCaj1XnH
	YTVno5O6yeAmZsPUfP0wxERna0IkzrXF239F5xJTEOhZCsh2oU9dKF262xCUT6tjEZR0e8LQTJA
	2W8hNxVIE90DjMOa3DxCXF5NXFKSUSIyQdtg8R9FjfU+IBNHM0OeAA6PlKCilfMc00VLzgLV4Gu
	W6fcvDO4KVTNbTAr4qCIUscK/XCbe9+JedFLzqdJiMuUKU1bRSNmTYUhbyWLcatELM2t81M1dmR
	Vg1scjqtwVcxW8dsu/SykKHkYX7M2Vc8a6uSGSIawtcdKRANrgem5nuIjXYL4ac9neb1QHGZU4q
	WIeT6eyIueopNCH57YFyWfQ==
X-Received: by 2002:a05:600c:3552:b0:459:dde3:1a33 with SMTP id 5b1f17b1804b1-45b517d26d4mr2922035e9.26.1755806847208;
        Thu, 21 Aug 2025 13:07:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGUeapMM5JkcwJNJXC+LM6ICHu4lGUEF2ir46AAuHXhYXAFzTcPIdec/q/lplZD/isU7mGEgg==
X-Received: by 2002:a05:600c:3552:b0:459:dde3:1a33 with SMTP id 5b1f17b1804b1-45b517d26d4mr2921795e9.26.1755806846742;
        Thu, 21 Aug 2025 13:07:26 -0700 (PDT)
Received: from localhost (p200300d82f26ba0008036ec5991806fd.dip0.t-ipconnect.de. [2003:d8:2f26:ba00:803:6ec5:9918:6fd])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-45b50d62991sm9535385e9.0.2025.08.21.13.07.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Aug 2025 13:07:26 -0700 (PDT)
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
Subject: [PATCH RFC 07/35] mm/memremap: reject unreasonable folio/compound page sizes in memremap_pages()
Date: Thu, 21 Aug 2025 22:06:33 +0200
Message-ID: <20250821200701.1329277-8-david@redhat.com>
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
X-Mimecast-MFC-PROC-ID: H1wPxBLO0PCEQBx5q4lmHMtRT8o7RX3-B7SJVg2AKEY_1755806847
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Let's reject unreasonable folio sizes early, where we can still fail.
We'll add sanity checks to prepare_compound_head/prepare_compound_page
next.

Is there a way to configure a system such that unreasonable folio sizes
would be possible? It would already be rather questionable.

If so, we'd probably want to bail out earlier, where we can avoid a
WARN and just report a proper error message that indicates where
something went wrong such that we messed up.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/memremap.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mm/memremap.c b/mm/memremap.c
index b0ce0d8254bd8..a2d4bb88f64b6 100644
--- a/mm/memremap.c
+++ b/mm/memremap.c
@@ -275,6 +275,9 @@ void *memremap_pages(struct dev_pagemap *pgmap, int nid)
 
 	if (WARN_ONCE(!nr_range, "nr_range must be specified\n"))
 		return ERR_PTR(-EINVAL);
+	if (WARN_ONCE(pgmap->vmemmap_shift > MAX_FOLIO_ORDER,
+		      "requested folio size unsupported\n"))
+		return ERR_PTR(-EINVAL);
 
 	switch (pgmap->type) {
 	case MEMORY_DEVICE_PRIVATE:
-- 
2.50.1

