Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9280A158D89
	for <iommu@lists.linux.dev>; Wed, 21 Feb 2024 19:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708544532; cv=none; b=eres6faS0XV2HcV6iLjLYol/mFEofEM4aBDX0rKH/yloALuZ0e90H74a8nkjxxH2qeN21QbVCAjgjG6iv5n26WLtHPUwTgx2/p69UEERJz6wJMEu7EvMkHTux9SUwHHLGPy9nvVKNAlZ2VZOQX5PJCjwSooX/jt3mIQJ2ZklHdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708544532; c=relaxed/simple;
	bh=RoZm3YN0uynf4m5K7QVx0oQIBiXR6RrrUDV2dOeXaWo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=i8EkR0B/R3obs7dzXBQJSN82O7TL5ifObeSt7snv+HnqJM4Ra6aQasUNW3EheWVA5XWfKcEJQfRlnJYst3xLr0cVAGKct8g0uMVIQV/IxaUSE+EEFMB3dsQrI6Dksg+4pvMLw1DYX3qsSC9EiV9nvVkP62OzQo26TN3Z4NgaEPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=E5ctwBFz; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="E5ctwBFz"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-60802b0afd2so1243507b3.1
        for <iommu@lists.linux.dev>; Wed, 21 Feb 2024 11:42:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708544530; x=1709149330; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=CzDIuQ0nYms/65bHZ69fKMNRRXjNNeWyOZfzFtq6j+Q=;
        b=E5ctwBFzDpoqfnliCs43guF/7sMR4iyDECgLDpK3mTlkl8l6jlwqWEFXvpdcBOfHdC
         3nwIIMXV1EbgFRAswGyeK5YJFH2+kGzb4C1ET27PgfkvJntKiJNOxtNt1rgcADsuIhrU
         YOEmVJnXgCh/RgzqlDAzP1XkVOPoEv1l4arLkr63/TnDBw8wdYMHi6/z8tVMmACwRVXX
         afNCjTHTx7aQzs9R57R94zMUcMmZutxFLQ9GdsZgoc6svHG77ioSeKDiO82UcN4qmzkJ
         rI1LCi6RDItBSjaZJTExjpmsMFpWSO1cf6B19+muiEgdFsf5QfEaX0MkwASJ3YPSzBwH
         Yh5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708544530; x=1709149330;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CzDIuQ0nYms/65bHZ69fKMNRRXjNNeWyOZfzFtq6j+Q=;
        b=I4Nkv5/y5pymyqNITaT7DB+GtfYn8SUhiZGUCx4UTMIlyzhLz3YkvxxQfMRreIh4tE
         DGHaqJAm1GptWhE1AqcnLkD1j+/9d8TwwYks3AgO9GJK5pMpiwwil+VyQvZVsX8xflDs
         DERrzVQt7oiJ5LaYVo3XF8FtEYxH1wn6khspaNwDbgLDmD3aFDBi2607aoLHsBj+54uk
         M1YGM/IhDxew5RfRiA9TDBRF0PHWbc10yhC9/CuT4f/bO0ZXP22fQYb7c6/McTEbCFAy
         KE8XtxCw4xlC+W/jKt12SLFGeg72co5vQ2hzfXn2K8H9Ngc+Vjy3GPX2wAVQCbB1sZq7
         1fvA==
X-Forwarded-Encrypted: i=1; AJvYcCVSTIDcJdXlleB2xvSWmT4Uhm938bFpQUvUe6nTPPjnoWFGmpPo/fhA4sovxjF+ixFRNLmVf+r7hTg+kTtlsVI68jCFYKw=
X-Gm-Message-State: AOJu0YyHdLwX+OZvGS5kDrGrym009QF8MjEqbclmxAfutusKilV0RjfA
	wwBFz6jfmOnyl82M1NHjMcGwaPlCzKaY17oFHHYuxwP/kySrY7jnf9X5+SbcMvrd6Qzw81AqAE7
	K3g==
X-Google-Smtp-Source: AGHT+IFe7qNCg82jNJD+RarPvS2YBMTSZ7x4HEvuAvHP+lTF13VKJQxl18VpWOGqr99d4PU9keICw1gSItE=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:953b:9a4e:1e10:3f07])
 (user=surenb job=sendgmr) by 2002:a81:b287:0:b0:608:6b9:bf09 with SMTP id
 q129-20020a81b287000000b0060806b9bf09mr97625ywh.1.1708544529717; Wed, 21 Feb
 2024 11:42:09 -0800 (PST)
Date: Wed, 21 Feb 2024 11:40:46 -0800
In-Reply-To: <20240221194052.927623-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20240221194052.927623-1-surenb@google.com>
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
Message-ID: <20240221194052.927623-34-surenb@google.com>
Subject: [PATCH v4 33/36] codetag: debug: mark codetags for reserved pages as empty
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

To avoid debug warnings while freeing reserved pages which were not
allocated with usual allocators, mark their codetags as empty before
freeing.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
---
 include/linux/alloc_tag.h   |  1 +
 include/linux/mm.h          |  9 +++++++++
 include/linux/pgalloc_tag.h |  2 ++
 mm/mm_init.c                | 12 +++++++++++-
 4 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/include/linux/alloc_tag.h b/include/linux/alloc_tag.h
index 4a3fc865d878..64aa9557341e 100644
--- a/include/linux/alloc_tag.h
+++ b/include/linux/alloc_tag.h
@@ -46,6 +46,7 @@ static inline void set_codetag_empty(union codetag_ref *ref)
 #else /* CONFIG_MEM_ALLOC_PROFILING_DEBUG */
 
 static inline bool is_codetag_empty(union codetag_ref *ref) { return false; }
+static inline void set_codetag_empty(union codetag_ref *ref) {}
 
 #endif /* CONFIG_MEM_ALLOC_PROFILING_DEBUG */
 
diff --git a/include/linux/mm.h b/include/linux/mm.h
index f5a97dec5169..b9a4e2cb3ac1 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -5,6 +5,7 @@
 #include <linux/errno.h>
 #include <linux/mmdebug.h>
 #include <linux/gfp.h>
+#include <linux/pgalloc_tag.h>
 #include <linux/bug.h>
 #include <linux/list.h>
 #include <linux/mmzone.h>
@@ -3112,6 +3113,14 @@ extern void reserve_bootmem_region(phys_addr_t start,
 /* Free the reserved page into the buddy system, so it gets managed. */
 static inline void free_reserved_page(struct page *page)
 {
+	if (mem_alloc_profiling_enabled()) {
+		union codetag_ref *ref = get_page_tag_ref(page);
+
+		if (ref) {
+			set_codetag_empty(ref);
+			put_page_tag_ref(ref);
+		}
+	}
 	ClearPageReserved(page);
 	init_page_count(page);
 	__free_page(page);
diff --git a/include/linux/pgalloc_tag.h b/include/linux/pgalloc_tag.h
index 9e6ad8e0e4aa..7a41ed612423 100644
--- a/include/linux/pgalloc_tag.h
+++ b/include/linux/pgalloc_tag.h
@@ -98,6 +98,8 @@ static inline void pgalloc_tag_split(struct page *page, unsigned int nr)
 
 #else /* CONFIG_MEM_ALLOC_PROFILING */
 
+static inline union codetag_ref *get_page_tag_ref(struct page *page) { return NULL; }
+static inline void put_page_tag_ref(union codetag_ref *ref) {}
 static inline void pgalloc_tag_add(struct page *page, struct task_struct *task,
 				   unsigned int order) {}
 static inline void pgalloc_tag_sub(struct page *page, unsigned int order) {}
diff --git a/mm/mm_init.c b/mm/mm_init.c
index e9ea2919d02d..6b5410a5112c 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -2566,7 +2566,6 @@ void __init set_dma_reserve(unsigned long new_dma_reserve)
 void __init memblock_free_pages(struct page *page, unsigned long pfn,
 							unsigned int order)
 {
-
 	if (IS_ENABLED(CONFIG_DEFERRED_STRUCT_PAGE_INIT)) {
 		int nid = early_pfn_to_nid(pfn);
 
@@ -2578,6 +2577,17 @@ void __init memblock_free_pages(struct page *page, unsigned long pfn,
 		/* KMSAN will take care of these pages. */
 		return;
 	}
+
+	/* pages were reserved and not allocated */
+	if (mem_alloc_profiling_enabled()) {
+		union codetag_ref *ref = get_page_tag_ref(page);
+
+		if (ref) {
+			set_codetag_empty(ref);
+			put_page_tag_ref(ref);
+		}
+	}
+
 	__free_pages_core(page, order);
 }
 
-- 
2.44.0.rc0.258.g7320e95886-goog

