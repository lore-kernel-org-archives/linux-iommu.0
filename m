Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B70A9139584
	for <iommu@lists.linux.dev>; Thu, 21 Mar 2024 16:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711039077; cv=none; b=bkPvkTSPegzJdc4AZV6jLamlQqX34Ko2mRQzkAD6w+YpXnNVN27e6vXa5aJLQgbdgFrCnwAgA1zrgJKJ5ZvMYe6M2Vckqcsc5ooeS2y1vzGkwgrRXEv8YGt0UCDbvxHO+yxPoQok1t+964i5qcKpVzb1DcKTmG9PUMgi096pR7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711039077; c=relaxed/simple;
	bh=q3rjzWyhmG5cuSNHeqibvv4qQMuWF17WVodXZAuRHsE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=BVN6cMQN69soF//354Nk8S2UEMyGkNrlB9QAq4svJLg9faSr1KEdOkPcINN1bnQ1Uq1ngV7NPAXncGjh4lMDYrYcYhmKCM/Xop4T0zCoakxl+gisDRGiU43okzHJ6e8s1S0F9zNM+hkqbxrSQMyHuawGxz6SldpPSyroeYQEmF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wTBnjbv1; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wTBnjbv1"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-60cd62fa1f9so19237737b3.0
        for <iommu@lists.linux.dev>; Thu, 21 Mar 2024 09:37:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711039074; x=1711643874; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=/zyX0GCVbwAVqAn+thP4TQZbJ1DZ8xPrkSKdxK+srAs=;
        b=wTBnjbv1WucwVtA0bdT0H0bk8pybhvEKxFP/5bmuECi2YiOuAGoI0XDnwNtzawkpe5
         JcwI0jrDN9P6OIrqHCeMMimKzkeVes/sqjBf2Ei5TrJHihhbuMPDIJ5HHqTzoRzt42o+
         aLpmupVL8Hyz7VFjR/ebrTPAJLbto8KGiJFB0tVXIPng5dqTZxSxlINMeQ7SaMpKJlqw
         BXxnbtKwuovZGuRoPSNoQh3sJX75uLXvaHB5WjyGlP3E2x5vo8kZ2BMfxZfXLymrycpg
         D6phi3NAbmT7op4cltn+6UTBRrqQLo1IZi8zCok5LpfsIWUfmi31zhaW5qAJPJUdDXw4
         MaGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711039074; x=1711643874;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/zyX0GCVbwAVqAn+thP4TQZbJ1DZ8xPrkSKdxK+srAs=;
        b=cwC+A83v0Q1FQ9yX7PUlOanuIBBuO5NX5FIRsPue9ZMrckoycIwa8qWZI9fAw7RY7v
         JUZcAUNQHiZPHwfkUNxjw/XtMwuOs6c708m75FUxdw0ekW6SCsOofOv3xPxqaCunCZeC
         PiyMWqoX/ON5Pa5u1P/7L6obSf9jTDZLp3F0+4wMcCahdPnggWZb0hbky2pFFndyRYoK
         lsq3fO1trzEeGR9yHQPFu2nDZQ4qDyueAazght0iV1qB+qmfx8OMKARkIpX19tNr3Onk
         mhEI1GPlTb7AHYKtWUxHVugWcBoHSA0WqIrTVUUu5xRKAo2/EmOJ/2dRHo51svUSqbVy
         g8FQ==
X-Forwarded-Encrypted: i=1; AJvYcCU8xaJgMrfRe+N/xQzbHCIKP/rAGl9+RXMZmtXizHuboEl4lVlnJggFOf5EvQ6KF/F7SCRDQBTmi+vSkcdOzt5LpK1y8WU=
X-Gm-Message-State: AOJu0Yx/r/B3++RF3qaVQem3tiHTKX0CXRw1cjBKMlaAcCD3B4QzLkUs
	R9xjo8unkgbfSyMrUA8IsqUJ0AGgLgMyC74xKAH2qNmb2qVqnxFeKfUrHBbUIHzyTWufGCgPfQE
	K/Q==
X-Google-Smtp-Source: AGHT+IGl7/sqfjKOff0ZjNp0/9geWcByH3EbVIixPqUdOWI6lFEA8KUqGJXoRB+ynXILrSpbs71KJ/Vx4lo=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:a489:6433:be5d:e639])
 (user=surenb job=sendgmr) by 2002:a05:6902:218c:b0:dcc:4785:b51e with SMTP id
 dl12-20020a056902218c00b00dcc4785b51emr980431ybb.12.1711039073381; Thu, 21
 Mar 2024 09:37:53 -0700 (PDT)
Date: Thu, 21 Mar 2024 09:36:42 -0700
In-Reply-To: <20240321163705.3067592-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20240321163705.3067592-1-surenb@google.com>
X-Mailer: git-send-email 2.44.0.291.gc1ea87d7ee-goog
Message-ID: <20240321163705.3067592-21-surenb@google.com>
Subject: [PATCH v6 20/37] mm: fix non-compound multi-order memory accounting
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
	glider@google.com, elver@google.com, dvyukov@google.com, 
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
put_page(). However the page passed to put_page() is indistinguishable
from an order-0 page, so it cannot do the accounting, just as it cannot
free the subsequent pages.  Do the accounting here, where we free the
pages.

Reported-by: Vlastimil Babka <vbabka@suse.cz>
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 include/linux/pgalloc_tag.h | 24 ++++++++++++++++++++++++
 mm/page_alloc.c             |  5 ++++-
 2 files changed, 28 insertions(+), 1 deletion(-)

diff --git a/include/linux/pgalloc_tag.h b/include/linux/pgalloc_tag.h
index 093edf98c3d7..50d212330bbb 100644
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
+static inline void pgalloc_tag_sub_pages(struct alloc_tag *tag, unsigned int nr)
+{
+	if (mem_alloc_profiling_enabled() && tag)
+		this_cpu_sub(tag->counters->bytes, PAGE_SIZE * nr);
+}
+
 #else /* CONFIG_MEM_ALLOC_PROFILING */
 
 static inline void pgalloc_tag_add(struct page *page, struct task_struct *task,
 				   unsigned int nr) {}
 static inline void pgalloc_tag_sub(struct page *page, unsigned int nr) {}
 static inline void pgalloc_tag_split(struct page *page, unsigned int nr) {}
+static inline struct alloc_tag *pgalloc_tag_get(struct page *page) { return NULL; }
+static inline void pgalloc_tag_sub_pages(struct alloc_tag *tag, unsigned int nr) {}
 
 #endif /* CONFIG_MEM_ALLOC_PROFILING */
 
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index fd1cc5b80a56..00e0ae4cbf2d 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -4700,12 +4700,15 @@ void __free_pages(struct page *page, unsigned int order)
 {
 	/* get PageHead before we drop reference */
 	int head = PageHead(page);
+	struct alloc_tag *tag = pgalloc_tag_get(page);
 
 	if (put_page_testzero(page))
 		free_the_page(page, order);
-	else if (!head)
+	else if (!head) {
+		pgalloc_tag_sub_pages(tag, (1 << order) - 1);
 		while (order-- > 0)
 			free_the_page(page + (1 << order), order);
+	}
 }
 EXPORT_SYMBOL(__free_pages);
 
-- 
2.44.0.291.gc1ea87d7ee-goog

