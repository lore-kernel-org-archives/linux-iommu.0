Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ED4955E4D
	for <iommu@lists.linux.dev>; Mon, 12 Feb 2024 21:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707774015; cv=none; b=KXI0kZBm7pLyvxBCkvj9YLnUIX9IBY5pvEh07TWopHQfy3Ka/0sFEL38rAgGIr5Eo5aHvvTf4ZDw8PYahYFsaBMb/ilN2wJnoxCBVeisVJwTsyShCTDjG2GLbfSr04DSJBk/VN/VJqropE6QjDWathnYCnekkODyuSVMBfDBYpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707774015; c=relaxed/simple;
	bh=4k57aS8GXMk2iiyKPx5CmNXvPcq94eqkm08DeOX77O0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fV9H7bCSfS+R73WcCE0SatrFMmtkd1dsdThGL/UJp6TSAfzD+N70/olgAZnsSr4KkCAXUcGzHVkHp6v53ItghcluK0EH2J9rMVEVk0Q1P++294CDhsjzlDVY+LK1vVpV2EJDuA7HQxL9mlp5swj55pGLWV7i7SC0yBGTESL1Czg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=I7f3bnGc; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="I7f3bnGc"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-607838c0800so506597b3.1
        for <iommu@lists.linux.dev>; Mon, 12 Feb 2024 13:40:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707774012; x=1708378812; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZrBz9DyywfwO606ZQMwpTbc2aylPEGoXqCQTswmuPUY=;
        b=I7f3bnGcMLGjC6uW0wSymscwARnhsxiMr5q3qJ+4ufrYP6uo3lvcTSPF8b6+vSJhoS
         xnvttVPIAjeUFYRCltMvLRdGyqalWtRgaB07Qy7s7v+P1ZGh0DR+PyJM3Bf8gzKdSj6y
         RISkvCIOuqO0IJPECxY/qQvGgwJb79BF33eDDwO51HFDau83uG2NIif1Jp1GdoZIkKjD
         BKc6ByZTG9RQ1Ja3/Hn0KzbbJbxqmXfz09Bq2K3xMkJ0JLnNfKNWr1aFm0vYC6Yly3uj
         RuOjNI5lvYMKgCx7qWYPJ5D95a8JwkpfLJh2cyO5y1TaS5B7ikIdx7D9o+dL8E5TWrBM
         ucOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707774012; x=1708378812;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZrBz9DyywfwO606ZQMwpTbc2aylPEGoXqCQTswmuPUY=;
        b=Jwof7yz9fA2QnsnvWMtQXwslGc1htRZV3dA+oc35/6vwk8Mm5cgsiYEBSduUXAAHj8
         jN+2XGGWuB30vAdSw0MTdq+m2Ie5bq8QmxLn4WdZdWCBKZzer9kJNxW4I47xbEaSuff9
         0MwzTz9FQealZcTU9fCHEax2w+Oj6LR72He1CjD1r8eBd/PTvvVU/kSRBTd6osU7UiXD
         m7H4cwMfivrRtXCA4WGO/J1nc4EOmv5kP81Q6XNQejvQiC9tGsnLxZRHzkU3SDFKMnQo
         WMDSbbKR7/l2lYyZ/BelP6az9+BgnmeFX/e8RvTI2VMGDGbe+Z1CrGIgxkf9nk0yOH5N
         b34Q==
X-Forwarded-Encrypted: i=1; AJvYcCXhFQxS24zihIcMz6l8oXPm4uudrroSY/TfhLBLsgJdivdKbnsINtkV/xXaznEkSqxfWs4Y6lQaWrv/N0nlxSebwrADwlg=
X-Gm-Message-State: AOJu0YwcS/xFfp90O9/aEmlB8XtthwX6tBeHx0/N8VXcJxBZAG+YvAX9
	FacoYclLWHn/IkDUdjzKkd4e2Li/Ne2/qiklzYaUjlCVHIq3HOR0PHZaprZS4fmqrmnjKUw4Mgb
	l4Q==
X-Google-Smtp-Source: AGHT+IGdELNRz/U7g++PhfoEsyUKyEa0DYZtdFbwbl9fcNHM0h9+fVLMKP8bhlCRwXrMrONYMoTWo6orz2A=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:b848:2b3f:be49:9cbc])
 (user=surenb job=sendgmr) by 2002:a25:ad02:0:b0:dcc:2267:796e with SMTP id
 y2-20020a25ad02000000b00dcc2267796emr133364ybi.2.1707774012029; Mon, 12 Feb
 2024 13:40:12 -0800 (PST)
Date: Mon, 12 Feb 2024 13:39:04 -0800
In-Reply-To: <20240212213922.783301-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20240212213922.783301-1-surenb@google.com>
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
Message-ID: <20240212213922.783301-19-surenb@google.com>
Subject: [PATCH v3 18/35] mm: create new codetag references during page splitting
From: Suren Baghdasaryan <surenb@google.com>
To: akpm@linux-foundation.org
Cc: kent.overstreet@linux.dev, mhocko@suse.com, vbabka@suse.cz, 
	hannes@cmpxchg.org, roman.gushchin@linux.dev, mgorman@suse.de, 
	dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com, 
	corbet@lwn.net, void@manifault.com, peterz@infradead.org, 
	juri.lelli@redhat.com, catalin.marinas@arm.com, will@kernel.org, 
	arnd@arndb.de, tglx@linutronix.de, mingo@redhat.com, 
	dave.hansen@linux.intel.com, x86@kernel.org, peterx@redhat.com, 
	david@redhat.com, axboe@kernel.dk, mcgrof@kernel.org, masahiroy@kernel.org, 
	nathan@kernel.org, dennis@kernel.org, tj@kernel.org, muchun.song@linux.dev, 
	rppt@kernel.org, paulmck@kernel.org, pasha.tatashin@soleen.com, 
	yosryahmed@google.com, yuzhao@google.com, dhowells@redhat.com, 
	hughd@google.com, andreyknvl@gmail.com, keescook@chromium.org, 
	ndesaulniers@google.com, vvvvvv@google.com, gregkh@linuxfoundation.org, 
	ebiggers@google.com, ytcoode@gmail.com, vincent.guittot@linaro.org, 
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com, 
	bristot@redhat.com, vschneid@redhat.com, cl@linux.com, penberg@kernel.org, 
	iamjoonsoo.kim@lge.com, 42.hyeyoo@gmail.com, glider@google.com, 
	elver@google.com, dvyukov@google.com, shakeelb@google.com, 
	songmuchun@bytedance.com, jbaron@akamai.com, rientjes@google.com, 
	minchan@google.com, kaleshsingh@google.com, surenb@google.com, 
	kernel-team@android.com, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev, 
	linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-modules@vger.kernel.org, kasan-dev@googlegroups.com, 
	cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

When a high-order page is split into smaller ones, each newly split
page should get its codetag. The original codetag is reused for these
pages but it's recorded as 0-byte allocation because original codetag
already accounts for the original high-order allocated page.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 include/linux/pgalloc_tag.h | 30 ++++++++++++++++++++++++++++++
 mm/huge_memory.c            |  2 ++
 mm/page_alloc.c             |  2 ++
 3 files changed, 34 insertions(+)

diff --git a/include/linux/pgalloc_tag.h b/include/linux/pgalloc_tag.h
index a060c26eb449..0174aff5e871 100644
--- a/include/linux/pgalloc_tag.h
+++ b/include/linux/pgalloc_tag.h
@@ -62,11 +62,41 @@ static inline void pgalloc_tag_sub(struct page *page, unsigned int order)
 	}
 }
 
+static inline void pgalloc_tag_split(struct page *page, unsigned int nr)
+{
+	int i;
+	struct page_ext *page_ext;
+	union codetag_ref *ref;
+	struct alloc_tag *tag;
+
+	if (!mem_alloc_profiling_enabled())
+		return;
+
+	page_ext = page_ext_get(page);
+	if (unlikely(!page_ext))
+		return;
+
+	ref = codetag_ref_from_page_ext(page_ext);
+	if (!ref->ct)
+		goto out;
+
+	tag = ct_to_alloc_tag(ref->ct);
+	page_ext = page_ext_next(page_ext);
+	for (i = 1; i < nr; i++) {
+		/* New reference with 0 bytes accounted */
+		alloc_tag_add(codetag_ref_from_page_ext(page_ext), tag, 0);
+		page_ext = page_ext_next(page_ext);
+	}
+out:
+	page_ext_put(page_ext);
+}
+
 #else /* CONFIG_MEM_ALLOC_PROFILING */
 
 static inline void pgalloc_tag_add(struct page *page, struct task_struct *task,
 				   unsigned int order) {}
 static inline void pgalloc_tag_sub(struct page *page, unsigned int order) {}
+static inline void pgalloc_tag_split(struct page *page, unsigned int nr) {}
 
 #endif /* CONFIG_MEM_ALLOC_PROFILING */
 
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 94c958f7ebb5..86daae671319 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -38,6 +38,7 @@
 #include <linux/sched/sysctl.h>
 #include <linux/memory-tiers.h>
 #include <linux/compat.h>
+#include <linux/pgalloc_tag.h>
 
 #include <asm/tlb.h>
 #include <asm/pgalloc.h>
@@ -2899,6 +2900,7 @@ static void __split_huge_page(struct page *page, struct list_head *list,
 	/* Caller disabled irqs, so they are still disabled here */
 
 	split_page_owner(head, nr);
+	pgalloc_tag_split(head, nr);
 
 	/* See comment in __split_huge_page_tail() */
 	if (PageAnon(head)) {
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 58c0e8b948a4..4bc5b4720fee 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -2621,6 +2621,7 @@ void split_page(struct page *page, unsigned int order)
 	for (i = 1; i < (1 << order); i++)
 		set_page_refcounted(page + i);
 	split_page_owner(page, 1 << order);
+	pgalloc_tag_split(page, 1 << order);
 	split_page_memcg(page, 1 << order);
 }
 EXPORT_SYMBOL_GPL(split_page);
@@ -4806,6 +4807,7 @@ static void *make_alloc_exact(unsigned long addr, unsigned int order,
 		struct page *last = page + nr;
 
 		split_page_owner(page, 1 << order);
+		pgalloc_tag_split(page, 1 << order);
 		split_page_memcg(page, 1 << order);
 		while (page < --last)
 			set_page_refcounted(last);
-- 
2.43.0.687.g38aa6559b0-goog

