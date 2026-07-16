Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25287265621
	for <iommu@lists.linux.dev>; Thu, 16 Jul 2026 14:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784212220; cv=none; b=JGm6Ne0T/wlf4vDJLYsgSfbT6fZZzGBaT0aGJgZxSDvz2pODR/MHhGXy149C5SA/IIckvJ41GX4jAZgoUGeUvNtQbx1WEb1fQg1a59stMMiDTQI7dfnORgGb1EpUag6JiO43ZfBCXsoINh/WcHXFjh+OHDKKUbh5izhZ6JIvtKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784212220; c=relaxed/simple;
	bh=AhFdR2QfFg1cCilOo4nyPNsp0iHkjl8xgc5O9th0jWk=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Kk6j7odCICx/yCNWCmyIMUCAovZTejGPvK4/JIFKy7OUTdwW6H3OiEi/KRyK8AMhVoM3NTpMhnPq0qVCiBXZI2PtUXNzHoGXeoy7yftWysq4JLLBEcjiBPOKxcuJh3h074vv/epZZa7fuWGVx9SQ9R0zUneBUoPx9UNAC484z78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aKIJk3Ms; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aKIJk3Ms"
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-474170b59dfso3844669f8f.3
        for <iommu@lists.linux.dev>; Thu, 16 Jul 2026 07:30:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784212215; x=1784817015; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=KK1D0Jn0y9eqfBTpCLM4Znrw9w5QYL14n9pJHOvIIK8=;
        b=aKIJk3MswEFcFYEMWuxnJoWxQ6XrVWZ7wAs64oJbC8i3kh5Gu48skWA+1+5LbxDy1+
         0e0cWD5MYM6hwB0tqVmKwVmb4qUB+ngZw0ETuZASmR3WMN3Z0W1Jt1ObjfTAXflP6+HF
         9J+kNYbalK0djk77D9sJIij1GFaqvtbbTafvPbQa7dDhCxhWujObC5Z7zizRjwaO9b1P
         WRR4WP1LeDiJYUCC9YfmXZaF/qaiommyx4HR+FHWmzGJFB+qAdGMuf30T2FSqPSvZGIE
         +2XVNe1dDvYHVbEaH2MBdLSWqPDR00RZCKa5KTFtxHuQVYOtKNXYfjLRrnKIIObnodNf
         p55g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784212215; x=1784817015;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KK1D0Jn0y9eqfBTpCLM4Znrw9w5QYL14n9pJHOvIIK8=;
        b=HtPuGFCtGWw6a/ri0Ed1Vyrsk+XUs5dZOuPVGzKme1AQzotPezdj2cO/ATueEdLmh2
         v5rNsPWFduyfA4Ebo1li5j8Cqd+LFU9q+AF9ZaKc5ubsfSXswnXwX37EeJGaUph29LGr
         p95hKEK59uySOPpNnNNfO9F9vd70J+2s3i1xTv5EStamt5vLYV/cYS8hHM3iAITWwr0S
         LdLbF/BvQBVZVx0fNGneiVs5FJ9eYbJN4hSjb+2Y7J30OqgLn6FSM5+bkiEy9qzoAPef
         zBkQyW/p2UlsdR5USVESTmONTKmoCvn2YEHxSlA1SyyZUWcrlcsMy5uK/QyN2hUix76a
         qVbg==
X-Forwarded-Encrypted: i=1; AHgh+RrSmQBNhNxPf1i+bX3rtc38SZWhylyTEvHS+zKCsVMAL/oE4MlI/o2E6YXv6ciaq4dhECv7uA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyQWgE/Diwh8spnzIAjmcFAWs81og3gAyRGSDw6ryH+gHRZ7ZB9
	NC20g7KS7rC6d6B8nNz0rCSfFACL97XPHU69i/c2OylSe3G40k38QexL/+i1f+EAegaLYGcegC2
	5MLEnAqXOfeieig==
X-Received: from wmbdr12.prod.google.com ([2002:a05:600c:608c:b0:490:b58a:2c80])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:a4a:b0:495:3e81:770f with SMTP id 5b1f17b1804b1-4953e817874mr72103905e9.15.1784212214740;
 Thu, 16 Jul 2026 07:30:14 -0700 (PDT)
Date: Thu, 16 Jul 2026 14:30:09 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAPHqWGoC/yXMQQqDMBBA0avIrDuQRFDbq5Qu4nSiIyGRTC2Ce
 Pem7fIt/j9AuQgr3JoDCr9FJacKe2mAZp8mRnlWgzOuM73tMOQoGX2MmZAi+7StiiZwa6/jMFh yUNO1cJD9t70//tZtXJhe3xec5wfuKVxBeAAAAA==
X-Change-Id: 20260716-folio-alloc-cleanups-0fe319b881c2
X-Mailer: b4 0.15.2
Message-ID: <20260716-folio-alloc-cleanups-v1-0-5363b8e92d33@google.com>
Subject: [PATCH 0/3] mm: yet more cleanups for page_alloc APIs
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

Based on mm-new.

Align some APIs with recent cleanups [0][1], and hide more mm-internal APIs
from public headers.

Part of this was also proposed by Vlastimil right as I was writing it:
https://lore.kernel.org/all/ed4572f4-0074-45c5-993d-7b6533eddc31@kernel.org/

And just like with my other recent patches, this has the ulterior motive
of enabling later incoming patches to add alloc_flags arguments to these
internal functions. (But, I do think these are justified as cleanups in
their own right).

[0]: https://lore.kernel.org/all/20260715-spin-trylock-followup-v3-0-fc4d246f705d@google.com/
[1]: https://lore.kernel.org/all/20260703-alloc-trylock-v5-0-c87b714e19d3@google.com/

Signed-off-by: Brendan Jackman <jackmanb@google.com>
---
Brendan Jackman (3):
      mm: move internal mempolicy APIs to new internal header
      mm, treewide: replace __folio_alloc_node() with folio_alloc_node()
      mm: move __folio_alloc() to page_alloc.h

 MAINTAINERS                        |  1 +
 drivers/iommu/iommu-pages.c        |  9 +--------
 drivers/irqchip/irq-loongarch-ir.c |  4 ++--
 include/linux/gfp.h                | 25 +++----------------------
 mm/filemap.c                       |  4 +++-
 mm/mempolicy.c                     |  1 +
 mm/mempolicy.h                     | 31 +++++++++++++++++++++++++++++++
 mm/migrate.c                       |  2 +-
 mm/page_alloc.c                    | 18 +++++++++++++++---
 mm/page_alloc.h                    |  4 ++++
 mm/shmem.c                         |  1 +
 mm/swap_state.c                    |  1 +
 net/sunrpc/svc.c                   |  2 +-
 13 files changed, 65 insertions(+), 38 deletions(-)
---
base-commit: 512c82e906fe2c26023e307c7951d53e90910b57
change-id: 20260716-folio-alloc-cleanups-0fe319b881c2

Best regards,
--  
Brendan Jackman <jackmanb@google.com>

