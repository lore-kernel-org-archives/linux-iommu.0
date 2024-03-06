Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB4A914AD11
	for <iommu@lists.linux.dev>; Wed,  6 Mar 2024 18:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709749531; cv=none; b=iN1NcHtPs17fBP/ntxY6kSa2A0pDWbi+IpJxQdg3YE6MaAbmBQeSYzi7g/dfqFVPgYbKfcMucOdDvEzITi0bu5Tx5NFi8YkJ6nxracgmVehgXCzC5uIb9CiBXCaYDW9UwxpYQ89ZqSFzupcEUPCWaTBEXieCOBEY+LGjOGxCVKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709749531; c=relaxed/simple;
	bh=U1GwlK71boTuxaedjljr6xYdZS31lmYH7mWe5hsF6dM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=MwbMSsPBQkt68cEHlPM5xAlP+SAh+VsS1ZL4LmSsEcrVknzzi7lUgbIdBiyF1U9TomeBc5H3CyD5w3n9/2hVVdLlguDLfDxwssarxKGN50YVh72oCq1p1ZMErTum8rYjfG2F+BYU1wOFb+V3jyrywt2zppMf8EOr6cxqi5IccUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BKsmZTkP; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BKsmZTkP"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-608dc99b401so718837b3.0
        for <iommu@lists.linux.dev>; Wed, 06 Mar 2024 10:25:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709749528; x=1710354328; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=EvAS1Tk9rG7Nm0pd+ehjWtNqiQusCGfZiqvBjL56bfE=;
        b=BKsmZTkPRseL9D9BT4QZaAvHTd+MucFvj5X58Nyu/q7ac4+gIGsuvasBx2g+UpkFDc
         Co1LVb1cbDj9ppk4tyBlz8x+qCaVcjyHtz5EpSKqvaWCHxABYOYijBl2ZfwgIaydWXGR
         mM9+KnlIcm1xlMl5SZd8wcKg4crORoMRd8QFZZt8VZV8Z6Ai6ob0Tj3wUUDyXNl9WZSO
         o1Y2g8bsZdKL6Vrbn+cLCPyt6Hh/ajD8SZgcNduPB+25Nw88s5rpXCWjMlOGXMxEK/Vt
         4H/+NGytZvbSJ6RIoEN4SA3NsZaY7gviVFFOworKoAowq/mqcyLIt/939tpoXm9SIcnc
         pVxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709749528; x=1710354328;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EvAS1Tk9rG7Nm0pd+ehjWtNqiQusCGfZiqvBjL56bfE=;
        b=QA8opmj7LYBDwJYLiSHFBSObiL9PaJ2NCubwUyB48CI8HRyVbGjnvr3MCYFXTSk/Tm
         259exFInYV/Bo754GDE0tY5RY5pOgdQ5tymC37E+vxOB/g/JS9Al9egdFxVPnSF9lbjR
         CHTs84TQ+YhMHI0ZMzo76BwBsj0Usbps7PQl7hNGkNw2HvJYJ0TLIDFZebGc8eiPccfC
         42/7Os06ZhRJgnufkQ7bIYvUcHEIg5FLACtI2oglPdLuekGT0FhHggaB3RmVjYseYApV
         KkJ9TT61Hh8jo9/r8N7ljfa/0UTdQmmtiPReEP12viabS1V0Hlk3I5bfx1fDxKs+wTAv
         rEVA==
X-Forwarded-Encrypted: i=1; AJvYcCUnHc8Mkf5Q/cBfHzHs0j2vtQ5sUbq8cuJUMx35K3CPk8G3xzRa76TFfR10+l/bKjdCURgfWV/RkeJbnFoN7RVEvbSMUYs=
X-Gm-Message-State: AOJu0YyBlYSqpNRiYVq0Szoh8RWoDrFcqVI+A8Apo4Tca4+lxEX3eKga
	4HN+x25spyu2RWH6xJ+otq4Ac128AmhoNxxGM5ZzBQSo0/EVmDx2OZafwMp+v1yVxjCoQO4MHxz
	inQ==
X-Google-Smtp-Source: AGHT+IFQIptCkWW78zp6nNtKkGuc5SIQRmDLhLOqGJHxbi7rcmsMoDf48+EiK0QB4NL+su2PCoHiqX08ucE=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:85f0:e3db:db05:85e2])
 (user=surenb job=sendgmr) by 2002:a05:690c:fcd:b0:609:33af:cca8 with SMTP id
 dg13-20020a05690c0fcd00b0060933afcca8mr4422200ywb.2.1709749527811; Wed, 06
 Mar 2024 10:25:27 -0800 (PST)
Date: Wed,  6 Mar 2024 10:24:18 -0800
In-Reply-To: <20240306182440.2003814-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20240306182440.2003814-1-surenb@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Message-ID: <20240306182440.2003814-21-surenb@google.com>
Subject: [PATCH v5 20/37] mm: fix non-compound multi-order memory accounting
 in __free_pages
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
	glider@google.com, elver@google.com, dvyukov@google.com, shakeelb@google.com, 
	songmuchun@bytedance.com, jbaron@akamai.com, aliceryhl@google.com, 
	rientjes@google.com, minchan@google.com, kaleshsingh@google.com, 
	surenb@google.com, kernel-team@android.com, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev, 
	linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-modules@vger.kernel.org, kasan-dev@googlegroups.com, 
	cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

When a non-compound multi-order page is freed, it is possible that a
speculative reference keeps the page pinned. In this case we free all
pages except for the first page, which will be freed later by the last
put_page(). However put_page() ignores the order of the page being freed,
treating it as a 0-order page. This creates a memory accounting imbalance
because the pages freed in __free_pages() do not have their own alloc_tag
and their memory was accounted to the first page. To fix this the first
page should adjust its allocation size counter when "tail" pages are freed.

Reported-by: Vlastimil Babka <vbabka@suse.cz>
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 include/linux/pgalloc_tag.h | 24 ++++++++++++++++++++++++
 mm/page_alloc.c             | 11 ++++++++++-
 2 files changed, 34 insertions(+), 1 deletion(-)

diff --git a/include/linux/pgalloc_tag.h b/include/linux/pgalloc_tag.h
index 9e6ad8e0e4aa..59de43172cc2 100644
--- a/include/linux/pgalloc_tag.h
+++ b/include/linux/pgalloc_tag.h
@@ -96,12 +96,36 @@ static inline void pgalloc_tag_split(struct page *page, unsigned int nr)
 	page_ext_put(page_ext);
 }
 
+static inline struct alloc_tag *pgalloc_tag_get(struct page *page)
+{
+	struct alloc_tag *tag = NULL;
+
+	if (mem_alloc_profiling_enabled()) {
+		union codetag_ref *ref = get_page_tag_ref(page);
+
+		alloc_tag_sub_check(ref);
+		if (ref && ref->ct)
+			tag = ct_to_alloc_tag(ref->ct);
+		put_page_tag_ref(ref);
+	}
+
+	return tag;
+}
+
+static inline void pgalloc_tag_sub_bytes(struct alloc_tag *tag, unsigned int order)
+{
+	if (mem_alloc_profiling_enabled() && tag)
+		this_cpu_sub(tag->counters->bytes, PAGE_SIZE << order);
+}
+
 #else /* CONFIG_MEM_ALLOC_PROFILING */
 
 static inline void pgalloc_tag_add(struct page *page, struct task_struct *task,
 				   unsigned int order) {}
 static inline void pgalloc_tag_sub(struct page *page, unsigned int order) {}
 static inline void pgalloc_tag_split(struct page *page, unsigned int nr) {}
+static inline struct alloc_tag *pgalloc_tag_get(struct page *page) { return NULL; }
+static inline void pgalloc_tag_sub_bytes(struct alloc_tag *tag, unsigned int order) {}
 
 #endif /* CONFIG_MEM_ALLOC_PROFILING */
 
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 39dc4dcf14f5..b402149a795f 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -4697,12 +4697,21 @@ void __free_pages(struct page *page, unsigned int order)
 {
 	/* get PageHead before we drop reference */
 	int head = PageHead(page);
+	struct alloc_tag *tag = pgalloc_tag_get(page);
 
 	if (put_page_testzero(page))
 		free_the_page(page, order);
 	else if (!head)
-		while (order-- > 0)
+		while (order-- > 0) {
 			free_the_page(page + (1 << order), order);
+			/*
+			 * non-compound multi-order page accounts all allocations
+			 * to the first page (just like compound one), therefore
+			 * we need to adjust the allocation size of the first
+			 * page as its order is ignored when put_page() frees it.
+			 */
+			pgalloc_tag_sub_bytes(tag, order);
+		}
 }
 EXPORT_SYMBOL(__free_pages);
 
-- 
2.44.0.278.ge034bb2e1d-goog

