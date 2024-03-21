Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9052413173E
	for <iommu@lists.linux.dev>; Thu, 21 Mar 2024 16:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711039039; cv=none; b=dNplI6/ZMhZKZXhsVms1ng/VtgHIu5X2F1V1mIO4WTzHc+RS0hdIMQbofPdB8JIGyjx+IIhmv9o7ftBmnZIEnPB5me3Jrs6oL1lqgIS1xsPD/dcHB/zK/JHcNB3BzFrH006gFZMysSWgMxCSanc/RvDMekuYfkHbaNTw5wzJDDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711039039; c=relaxed/simple;
	bh=HDNKqGkk/azPcTtEhJHN+gpMAx3GoPDUVnE3EYb5Lwg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=elqMevOeMZMA5mcCr2BQm5R06hOosCTKzu9PIb/GQb7PexmCCD6p6CwOP/ocsyhUI3NPkQyQ/m+7hD9CikubqKD5m+TVOaBLjWNIyOs9YHMa4cgnuz+wwshhPvNmrrDNj6yGAtMFHN+5zhc0F1km+z3yrw4kd/TJgzSR9n7x9HU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yS+lXG/Z; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yS+lXG/Z"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-60ccc3cfa39so16709707b3.2
        for <iommu@lists.linux.dev>; Thu, 21 Mar 2024 09:37:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711039037; x=1711643837; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=cRKfaiB6dOVHxpZUYVy57amQHTHiIgtHPVa28h/bxKY=;
        b=yS+lXG/Z775NiheLg9qdp1BbAAKHM37ywPxwS+SyV1zO5caLRIgAsjZJHObhNmjPbZ
         IopCV5Qae7TEoU8ViixMXzeMG4KtOvRDACgzSOv8tNJD7Kbe8jSQGVpeJhiIp7WQ4JP+
         DDD+m7ul1hIcnDopWbWF8HPvgAsa6sA77xG4soYB6kjw0KjsOomFZv93ULXN+hL5yjs+
         bFkPQVwXtTFQ462tCMhizQmzhYRdY3g2IjUYO0At5C/wWChomdTcX7ONmSi4yuqodyCl
         ulEx37vJ9sh0N90ZIR9E4KTxVBf67/om8pHQIMBJJ/M0JxUOP+zGvLkR4e84X4DvVSse
         Vb1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711039037; x=1711643837;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cRKfaiB6dOVHxpZUYVy57amQHTHiIgtHPVa28h/bxKY=;
        b=WzKhhoiEG4gnw36LyMZeAnMXMYDZcNXS2kgqXe5e7GWdWOAXMZFLsApwd6wF9ojF1T
         /6AviB6ybHlv+s5qRFdMjGnIOO6T79y54wRoqiq42/SUU5ZzjQK7YtEGDDI290nuBQV1
         ow5RtTrhJ9ff3+XkGO14ZQVvdJ3xRcj9j76qzIfHszLeGHvGTYLczGQm/6VWk/EVmOIS
         GfXSaFhqdttKX5uwoX+ATxKSHo3yy8ofr8wHpfsb9Vxxc5PRys9WSaNwKVl1Yf842we8
         2NJ/JT5ez7WUKQei4cra/5D4yJf4bbkJNXplC0QEp6SvxIaJJ+5zpDPP4/xjWlBcDUtV
         3+IQ==
X-Forwarded-Encrypted: i=1; AJvYcCWLKehqG7cYL4uw4SHTBkpffHchTVqZAaj8h3Lt62HUspisCx6QErX+vIeSmjZi4BJdetNmP+tRof1FNFTF5FjLpjou4cI=
X-Gm-Message-State: AOJu0Yytu7OHn0U9nMW5kEfvkdYQw7vmDaniovrzIhIWQpL4ittVXbaQ
	ohT1LMhWHa/2tWmhGENCv8CAcoVwhF4n8elCJ6PCJkmC/BSPoBgkKTNVouBKm0eFBFeo9MvDc19
	wgA==
X-Google-Smtp-Source: AGHT+IFYgw5ohbM2qs9qWLSKEHVv/3K2+6lhzKzCxOpGXwJ9EG3Fd8M+K30yKZwcBlNXdCTg4+rc5Suy1A8=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:a489:6433:be5d:e639])
 (user=surenb job=sendgmr) by 2002:a05:690c:f88:b0:610:f11e:9d24 with SMTP id
 df8-20020a05690c0f8800b00610f11e9d24mr1686171ywb.4.1711039036599; Thu, 21 Mar
 2024 09:37:16 -0700 (PDT)
Date: Thu, 21 Mar 2024 09:36:25 -0700
In-Reply-To: <20240321163705.3067592-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20240321163705.3067592-1-surenb@google.com>
X-Mailer: git-send-email 2.44.0.291.gc1ea87d7ee-goog
Message-ID: <20240321163705.3067592-4-surenb@google.com>
Subject: [PATCH v6 03/37] mm/slub: Mark slab_free_freelist_hook() __always_inline
From: Suren Baghdasaryan <surenb@google.com>
To: akpm@linux-foundation.org
Cc: kent.overstreet@linux.dev, mhocko@suse.com, vbabka@suse.cz, 
	hannes@cmpxchg.org, roman.gushchin@linux.dev, mgorman@suse.de, 
	dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com, 
	penguin-kernel@i-love.sakura.ne.jp, corbet@lwn.net, void@manifault.com, 
	peterz@infradead.org, juri.lelli@redhat.com, catalin.marinas@arm.com, 
	will@kernel.org, arnd@arndb.de, tglx@linutronix.de, mingo@redhat.com, 
	dave.hansen@linux.intel.com, x86@kernel.org, peterx@redhat.com, 
	david@redhat.com, axboe@kernel.dk, mcgrof@kernel.org, masahiroy@kernel.org, 
	nathan@kernel.org, dennis@kernel.org, jhubbard@nvidia.com, tj@kernel.org, 
	muchun.song@linux.dev, rppt@kernel.org, paulmck@kernel.org, 
	pasha.tatashin@soleen.com, yosryahmed@google.com, yuzhao@google.com, 
	dhowells@redhat.com, hughd@google.com, andreyknvl@gmail.com, 
	keescook@chromium.org, ndesaulniers@google.com, vvvvvv@google.com, 
	gregkh@linuxfoundation.org, ebiggers@google.com, ytcoode@gmail.com, 
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org, 
	bsegall@google.com, bristot@redhat.com, vschneid@redhat.com, cl@linux.com, 
	penberg@kernel.org, iamjoonsoo.kim@lge.com, 42.hyeyoo@gmail.com, 
	glider@google.com, elver@google.com, dvyukov@google.com, 
	songmuchun@bytedance.com, jbaron@akamai.com, aliceryhl@google.com, 
	rientjes@google.com, minchan@google.com, kaleshsingh@google.com, 
	surenb@google.com, kernel-team@android.com, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev, 
	linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-modules@vger.kernel.org, kasan-dev@googlegroups.com, 
	cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Kent Overstreet <kent.overstreet@linux.dev>

It seems we need to be more forceful with the compiler on this one.
This is done for performance reasons only.

Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/slub.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index 1bb2a93cf7b6..bc9f40889834 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -2106,9 +2106,9 @@ bool slab_free_hook(struct kmem_cache *s, void *x, bool init)
 	return !kasan_slab_free(s, x, init);
 }
 
-static inline bool slab_free_freelist_hook(struct kmem_cache *s,
-					   void **head, void **tail,
-					   int *cnt)
+static __fastpath_inline
+bool slab_free_freelist_hook(struct kmem_cache *s, void **head, void **tail,
+			     int *cnt)
 {
 
 	void *object;
-- 
2.44.0.291.gc1ea87d7ee-goog

