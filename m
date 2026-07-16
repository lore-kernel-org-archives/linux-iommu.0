Received: from mail-ed1-f74.google.com (mail-ed1-f74.google.com [209.85.208.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99FE242E8C9
	for <iommu@lists.linux.dev>; Thu, 16 Jul 2026 14:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784212225; cv=none; b=JQKhLjJF6CSDMP87Hidngfptw0/emyERLZ6+X7HBAI6m43mFDamidE0W1TutMPT7v3OBVQxuHIvDIbJuySLH+dFEG998dO8xLddxBPWOxsaHPMTAe6/Dvg4vv+01uU/UE8r/9no03ckVS44DFniS3Dy5m6eZUoJwPjUphRV6Ed4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784212225; c=relaxed/simple;
	bh=qzD/CNlHTImzTpy/YkW9yoSxvDfct3ktpkoKGeDbIF4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=feXdfsGrKMPwuMvK83/Ed3+QVYa/jNkpOQWLXTIk+QbzlGnUqrgiFVgQRDfj6FTMIlwiQiZce/Q7orC7m7xmHXvgGyhXQyIOriDK7Uydwbye9UNQ5dtU1eEr3BPajtxrmVNgBJ3jX0Y+gOyBw5k/uH0lSxo2X82yXgm/iP4fOxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jOWvp0qp; arc=none smtp.client-ip=209.85.208.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jOWvp0qp"
Received: by mail-ed1-f74.google.com with SMTP id 4fb4d7f45d1cf-69a1ab55774so9450375a12.1
        for <iommu@lists.linux.dev>; Thu, 16 Jul 2026 07:30:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784212222; x=1784817022; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qPPMQZI6K5BD2JSD4w/twAcndg7pfdwRcZm6mUR6S/U=;
        b=jOWvp0qpRg9J/UUeVtXtfQsoZhpBOK3QEnWA2iMw9zpbVMBtGR1nOBLEdAze5RmwS/
         o6G9qlk2kjv5uKEm3WZTG9uMD8fuxIxxi1Klqwfm4xDZWNqp7YUid0OyuRc0/xdP/awL
         aJL8K9we+OX7F9ejbVVZNM6cZ6l2syE1FLpG8cV14yD5siGmMnQqZ8Mw/oKkWw0avhqw
         9vUsRYieuzkgA5RAU8RiX1CqS5piq8zv0kNQw5LsAJqahbnb4ruwZzoEGnqKg+NgJtJB
         skxSTk1lr++XYORg/Exa/yqgYML9E7ln4IxfryxI/QbwU/w52eFgwlYApyhlbj3CHzk7
         P0yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784212222; x=1784817022;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qPPMQZI6K5BD2JSD4w/twAcndg7pfdwRcZm6mUR6S/U=;
        b=Pp43QeFfsXomxTaLdgJqKBnpMZsDJO7Gk/wE3QsykB4FJ3o6vUd/X0nlPoEPEuxMsX
         /3mC4xjnLfYgU7fLHVLZOG3IOqZcilpCUyOkXzrAhpfiPdj3EXJYD66sq9KqGVRN43tw
         2JeZl0JIiP0YVMRBiQqH3cmG6WNqYOufq7antN+Pso6nhSdoMjDoRuyBa5J6u2Sfjvdf
         zb6TH6jrl+XpJOFOn5xV8zD2oZCwyLrPay40otRgiDUdazNQQttPP9B+sqh/ciACcTRJ
         ud8EjRlcu+ZroLI3TJaTbY0NoVjlhbZQ9Xisd5gGNYakJ2cIs24Ruq3lpxu7JJpKE/SC
         hNTQ==
X-Forwarded-Encrypted: i=1; AHgh+RpJQvB81cZaw1U3zw5S6qRu0iBw4+zCiGS4I3RPg2Le3oOHFfIl7LNc8XUia6DRF4AMWvCGNg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxHgVqVsR1K3SlkmSkQWk6lOU0OZmCAqwLrLV2HfHrEp3tjrooa
	p8jMgahASDRaYJiHEV51p9N839B0Hn4wHpyG/+VrVsdTpLo4WXKW3stZiPaXtRovYsjyrKuE2E2
	geZDeQ0Xlhptb6A==
X-Received: from edl2-n2.prod.google.com ([2002:a05:6402:4242:20b0:698:c0d2:794d])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:3596:b0:69c:72e2:a3d9 with SMTP id 4fb4d7f45d1cf-69e199c3870mr3879463a12.21.1784212219530;
 Thu, 16 Jul 2026 07:30:19 -0700 (PDT)
Date: Thu, 16 Jul 2026 14:30:12 +0000
In-Reply-To: <20260716-folio-alloc-cleanups-v1-0-5363b8e92d33@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260716-folio-alloc-cleanups-v1-0-5363b8e92d33@google.com>
X-Mailer: b4 0.15.2
Message-ID: <20260716-folio-alloc-cleanups-v1-3-5363b8e92d33@google.com>
Subject: [PATCH 3/3] mm: move __folio_alloc() to page_alloc.h
From: Brendan Jackman <jackmanb@google.com>
To: Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@kernel.org>, 
	Lorenzo Stoakes <ljs@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
	Joshua Hahn <joshua.hahnjy@gmail.com>, Byungchul Park <byungchul@sk.com>, 
	Gregory Price <gourry@gourry.net>, Ying Huang <ying.huang@linux.alibaba.com>, 
	Alistair Popple <apopple@nvidia.com>, Hugh Dickins <hughd@google.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Chris Li <chrisl@kernel.org>, 
	Kairui Song <kasong@tencent.com>, Kemeng Shi <shikemeng@huaweicloud.com>, 
	Nhat Pham <nphamcs@gmail.com>, Baoquan He <baoquan.he@linux.dev>, Barry Song <baohua@kernel.org>, 
	Youngjun Park <youngjun.park@lge.com>, "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Huacai Chen <chenhuacai@kernel.org>, 
	WANG Xuerui <kernel@xen0n.name>, Thomas Gleixner <tglx@kernel.org>, Chuck Lever <cel@kernel.org>, 
	Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>, 
	Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, 
	Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org, iommu@lists.linux.dev, 
	loongarch@lists.linux.dev, linux-nfs@vger.kernel.org, netdev@vger.kernel.org, 
	Brendan Jackman <jackmanb@google.com>
Content-Type: text/plain; charset="utf-8"

This is no longer used outside of mm so reduce the scope.

Ulterior motive for the move to mm/: A later patch will add an
alloc_flags arg here.

Signed-off-by: Brendan Jackman <jackmanb@google.com>
---
 include/linux/gfp.h | 4 ----
 mm/page_alloc.c     | 1 -
 mm/page_alloc.h     | 4 ++++
 3 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/include/linux/gfp.h b/include/linux/gfp.h
index 572605d84e30e..17c14b8ca007d 100644
--- a/include/linux/gfp.h
+++ b/include/linux/gfp.h
@@ -203,10 +203,6 @@ static inline void arch_free_page(struct page *page, int order) { }
 static inline void arch_alloc_page(struct page *page, int order) { }
 #endif
 
-struct folio *__folio_alloc_noprof(gfp_t gfp, unsigned int order, int preferred_nid,
-		nodemask_t *nodemask);
-#define __folio_alloc(...)			alloc_hooks(__folio_alloc_noprof(__VA_ARGS__))
-
 unsigned long alloc_pages_bulk_noprof(gfp_t gfp, int preferred_nid,
 				nodemask_t *nodemask, int nr_pages,
 				struct page **page_array);
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 86922270df157..ff8515e173e1e 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -5446,7 +5446,6 @@ struct folio *__folio_alloc_noprof(gfp_t gfp, unsigned int order, int preferred_
 				    preferred_nid, nodemask, ALLOC_DEFAULT);
 	return page_rmappable_folio(page);
 }
-EXPORT_SYMBOL(__folio_alloc_noprof);
 
 struct folio *folio_alloc_node_noprof(gfp_t gfp, unsigned int order, int nid)
 {
diff --git a/mm/page_alloc.h b/mm/page_alloc.h
index b9259deddb59d..409be31898ae7 100644
--- a/mm/page_alloc.h
+++ b/mm/page_alloc.h
@@ -258,6 +258,10 @@ struct page *__alloc_pages_noprof(gfp_t gfp, unsigned int order, int preferred_n
 		nodemask_t *nodemask, unsigned int alloc_flags);
 #define __alloc_pages(...)			alloc_hooks(__alloc_pages_noprof(__VA_ARGS__))
 
+struct folio *__folio_alloc_noprof(gfp_t gfp, unsigned int order, int preferred_nid,
+		nodemask_t *nodemask);
+#define __folio_alloc(...)			alloc_hooks(__folio_alloc_noprof(__VA_ARGS__))
+
 extern void zone_pcp_reset(struct zone *zone);
 extern void zone_pcp_disable(struct zone *zone);
 extern void zone_pcp_enable(struct zone *zone);

-- 
2.54.0

