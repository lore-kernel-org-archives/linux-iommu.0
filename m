Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EE311487E8
	for <iommu@lists.linux.dev>; Wed, 21 Feb 2024 19:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708544502; cv=none; b=bEycIwqFiRCEtJVkluuX5WQu+ksyCxV7ifPPzDD26YemiB9dWIB+kI00pfXPvdd1byjhxVdjoXOIOJdLKxshCIHnaRplibjGLCRqqCReIWQG65wWCXtJ6h24CRxxTJ9N2/xIPZUCIKBJ2i2UGlUTxg/jTq7M/Uw8su0kTYG+qh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708544502; c=relaxed/simple;
	bh=vicr63sJKc1o/siGbzRTyI8A3E1968FkjrlbTO/oYk4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=EYEVQRLo+4FEgVkavab/dQwrC3S9gUPwD+SSPCvKL8BRn97I0EQpTQBCZbxokBdhI5uFVR8SL2AOaMkPs8YUrBwurPdALTzoEGSltaPIsPhhU/71cb7OG8YDrQKCDC6jUMrmCTVcK/JnAHyZb1MnPtNoxq0knbMgWnSuo3peqLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=irFCa3My; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="irFCa3My"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dce775fa8adso2077433276.1
        for <iommu@lists.linux.dev>; Wed, 21 Feb 2024 11:41:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708544498; x=1709149298; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=1hWNqJFIgMmzuIRMCt7lzLBdngxXaEaZ9g59MUlptRo=;
        b=irFCa3My/kjl4kRtByHnhaBDvAj/DNXwuZ/USBmqyAjQZtgAyDhlwt9W0+C/ZCwhYD
         ckJ5ryigXX6r+SXknSN5Zx4X3tlLNRjEChaXZC8/Wb98RFbt44opKJcewrtr+W9SJrJO
         SsYcClux/3l+oXYdPbve99bOZGtY9Kqbbr6M8O/PaIEwILI1eAJe5010o3ouSAYkkcjm
         0ikiRY7WVknfIgsiNEq6t1hqv8epwC4X4J6weFfWY+1rUyDopDeXo0CvdUO4MZD8qYA4
         Su2jE/9sbfknDDU2fMxAkZTy2ydkkDyl2xir4W+gmw0ZNs981Y3uOlkD/vdFPcKH0+gX
         2R5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708544498; x=1709149298;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1hWNqJFIgMmzuIRMCt7lzLBdngxXaEaZ9g59MUlptRo=;
        b=ZXPmZ5TNr9x5ATB4Ps++NWjAwHzX9kW8VW7egGCkMv4XZcLmgUlWQpTEsZjEzZq5DH
         hFiQCl+jF/vRQP0gP+tHFE8K6WNceD3mERpfiIF4dz1Y/Mv37AN+Oiv/h7MhxxLF48GB
         B60kQ58iId6eRYJ38IbZ+4H3Wga5YwwhQQclto7PX2LBXkeRm/wnGV6u7ZwyvnN9BwNs
         QKoVH2VnUAo7hfAJU73HgO+PanSG3ZWaReB8eW7XlZ/nTHQmgvUM/dReDLU3rRvBF2qn
         ml+DCFjDZRDvrWOHQ4AuFjBQjL5brhx8b3i7X7tn/oDDBo//rOmdoZHjfUWOIXBHFZRs
         /q3Q==
X-Forwarded-Encrypted: i=1; AJvYcCXZj3RLMZ3GHbLDAVY6eAO/51L3HpFBNMHdKt8CEnqxVVxO7AipULIyz46eNIpZk8UTutbWSaBel2aPGCsodxjX74LyPos=
X-Gm-Message-State: AOJu0Yx2kzSQPX5MEOrY910l73nm9SWuxKF9H7My/bitNfyVOuGDkF2Y
	T3LObz5zeEQxVSBXE0XorWXbPERMlRTiJV/Fs0GT4NsgqI/S7mXY4AGGxfLdecs8B/ssE2MoXhv
	egA==
X-Google-Smtp-Source: AGHT+IF+lk/FYOD/Yxg3sPkq6eArvA9PdzVkhKYXiOVnRPx3H40+bQfIfbP0HZr0UMzCJhoN0p6KojopSmw=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:953b:9a4e:1e10:3f07])
 (user=surenb job=sendgmr) by 2002:a05:6902:18d6:b0:dc6:dfc6:4207 with SMTP id
 ck22-20020a05690218d600b00dc6dfc64207mr68537ybb.10.1708544498016; Wed, 21 Feb
 2024 11:41:38 -0800 (PST)
Date: Wed, 21 Feb 2024 11:40:32 -0800
In-Reply-To: <20240221194052.927623-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20240221194052.927623-1-surenb@google.com>
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
Message-ID: <20240221194052.927623-20-surenb@google.com>
Subject: [PATCH v4 19/36] mm: create new codetag references during page splitting
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
index b49ab955300f..9e6ad8e0e4aa 100644
--- a/include/linux/pgalloc_tag.h
+++ b/include/linux/pgalloc_tag.h
@@ -67,11 +67,41 @@ static inline void pgalloc_tag_sub(struct page *page, unsigned int order)
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
+		/* Set new reference to point to the original tag */
+		alloc_tag_ref_set(codetag_ref_from_page_ext(page_ext), tag);
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
2.44.0.rc0.258.g7320e95886-goog

