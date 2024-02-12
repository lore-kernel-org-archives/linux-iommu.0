Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 144895EE9C
	for <iommu@lists.linux.dev>; Mon, 12 Feb 2024 21:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707774047; cv=none; b=ewPyLH/AGi4pqCef8eob5Mfon7ZY/W7+oq9B5OXrYQkcMq66b+F6iGICAnKqdd2TvExpJLpDJPM+aqNk8IO2t+g945mZ1gmn+fKFbf8QhIV6cFV50Hu9WNObbMairYsdltentNFL8z2zbpG9lZChA3MBLAmfSrWqMYY+abuBMw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707774047; c=relaxed/simple;
	bh=YSv5f7I2dnKMkhKo6foFZjKi7C7ZfZQ0Dh90Hrbid3I=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jKO3Kv2Nb+sP32y10TE1DEmtHxUOh3+OOXraDNndOV6Y8bjVe8O0tYR8jNoBpr7Nfj4FOmI+OLoMYws6oMUD5Cp46YJ6S4DyoRc5lnUzxwmR8p5+R1sJp58ZrD3gdAAeFVt/itC047xyq6XzQiiUaPbER7BLFThSf/o65XhRdLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KUVkTpeJ; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KUVkTpeJ"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-60781e8709eso1278927b3.1
        for <iommu@lists.linux.dev>; Mon, 12 Feb 2024 13:40:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707774044; x=1708378844; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=DSEwnOfj2VuhpdkIHZ8VNVuKfvBXo1I5xAUr9MF0J1M=;
        b=KUVkTpeJZKWKzv8GTcvP1dzPDm0nC3sML751ydxY1aJrJUIApCmil8rmc+3FLlTsUh
         XqiIufeJxv+mHDOZFBkEJp58wwUiKcRjRVTLI9A142EWflrOF/Wse08pDBx4x6VGPg+p
         fZ738ra8BVuoLsQj0oT+JWUYM1k/CZ5v8ZOaTF8FazlkjkV55kkUmOrwQtmmAo7M6wjN
         mLNkMvCAFDup1JHCBnukm6Ub8OpKDwcW+o6/Of1HJLZlT8szb8W2b3PCgx0LW/hZt7Mj
         /EICvXd2GVYRL2NAU4jnOCGvyramiQk95WI3dkLZsWE87LR/7lKEijn+vNIZB1/odzTm
         y2gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707774044; x=1708378844;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DSEwnOfj2VuhpdkIHZ8VNVuKfvBXo1I5xAUr9MF0J1M=;
        b=M6Y4dDBE0ZPSIl+dIWZhFPJ5yL/8sOtyPbvpqHN2HqvzYLPUiY0kcBPniGwnyULvMX
         hNRzWLrW8E5doF94bGfbn+4BjamLqgowDvuYBjwMab00clJfslkWy2hvNgOLDAiMh2HE
         XIpZD+g4vz5ShoxgZILr8re23SPFgEUTCITqMdkFD/TnjnUHYhW4N4j/DulTJG9qTv0C
         b3v0unTsJzU0WqCNaS/k5KnECi1oqvJG2ofebxDYipV08JopVjwd/O/YJLYUTlqE/EYM
         x9JH3Gk4Diqa5AIVUwq3Wpfo/IfHLzOCCMbZ3gMqzJbdinhYOBbIb6/GG3+o91TnMeCq
         IH0g==
X-Forwarded-Encrypted: i=1; AJvYcCUNfKA56jp9x8Ns3+zQSUsUAXTvXq2SceBenokI5raUNmncbI1aIn3CJTiWNK8/M7IS0n63GAVHeBulFlNzVmR6y0tzDRw=
X-Gm-Message-State: AOJu0Yx477EdzHW841DaeF58n44R6miTlzkGWakN1m6glj6bmhIt9jC8
	7G6XeQPsMI2U4pj6PpEZUgz92HpslI43WQ0zU+VH6Yttw6WQ/jGuSXb4TZpj5391fQDDz01eRag
	CRA==
X-Google-Smtp-Source: AGHT+IFtNaKOZcDNkW8O/y0IS6dfwCCkuRAaS6+IZN21h1P/6QI7aHSb74NpkK/DZ6QgX1s1BGxeLh90Utw=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:b848:2b3f:be49:9cbc])
 (user=surenb job=sendgmr) by 2002:a0d:e8c2:0:b0:607:79be:9120 with SMTP id
 r185-20020a0de8c2000000b0060779be9120mr169543ywe.0.1707774044127; Mon, 12 Feb
 2024 13:40:44 -0800 (PST)
Date: Mon, 12 Feb 2024 13:39:19 -0800
In-Reply-To: <20240212213922.783301-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20240212213922.783301-1-surenb@google.com>
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
Message-ID: <20240212213922.783301-34-surenb@google.com>
Subject: [PATCH v3 33/35] codetag: debug: mark codetags for reserved pages as empty
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

To avoid debug warnings while freeing reserved pages which were not
allocated with usual allocators, mark their codetags as empty before
freeing.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 include/linux/alloc_tag.h   | 2 ++
 include/linux/mm.h          | 8 ++++++++
 include/linux/pgalloc_tag.h | 2 ++
 mm/mm_init.c                | 9 +++++++++
 4 files changed, 21 insertions(+)

diff --git a/include/linux/alloc_tag.h b/include/linux/alloc_tag.h
index 1f3207097b03..102caf62c2a9 100644
--- a/include/linux/alloc_tag.h
+++ b/include/linux/alloc_tag.h
@@ -95,6 +95,7 @@ static inline void set_codetag_empty(union codetag_ref *ref)
 #else /* CONFIG_MEM_ALLOC_PROFILING_DEBUG */
 
 static inline bool is_codetag_empty(union codetag_ref *ref) { return false; }
+static inline void set_codetag_empty(union codetag_ref *ref) {}
 
 #endif /* CONFIG_MEM_ALLOC_PROFILING_DEBUG */
 
@@ -155,6 +156,7 @@ static inline void alloc_tag_sub(union codetag_ref *ref, size_t bytes) {}
 static inline void alloc_tag_sub_noalloc(union codetag_ref *ref, size_t bytes) {}
 static inline void alloc_tag_add(union codetag_ref *ref, struct alloc_tag *tag,
 				 size_t bytes) {}
+static inline void set_codetag_empty(union codetag_ref *ref) {}
 
 #endif
 
diff --git a/include/linux/mm.h b/include/linux/mm.h
index f5a97dec5169..ac1b661987ed 100644
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
@@ -3112,6 +3113,13 @@ extern void reserve_bootmem_region(phys_addr_t start,
 /* Free the reserved page into the buddy system, so it gets managed. */
 static inline void free_reserved_page(struct page *page)
 {
+	union codetag_ref *ref;
+
+	ref = get_page_tag_ref(page);
+	if (ref) {
+		set_codetag_empty(ref);
+		put_page_tag_ref(ref);
+	}
 	ClearPageReserved(page);
 	init_page_count(page);
 	__free_page(page);
diff --git a/include/linux/pgalloc_tag.h b/include/linux/pgalloc_tag.h
index 0174aff5e871..ae9b0f359264 100644
--- a/include/linux/pgalloc_tag.h
+++ b/include/linux/pgalloc_tag.h
@@ -93,6 +93,8 @@ static inline void pgalloc_tag_split(struct page *page, unsigned int nr)
 
 #else /* CONFIG_MEM_ALLOC_PROFILING */
 
+static inline union codetag_ref *get_page_tag_ref(struct page *page) { return NULL; }
+static inline void put_page_tag_ref(union codetag_ref *ref) {}
 static inline void pgalloc_tag_add(struct page *page, struct task_struct *task,
 				   unsigned int order) {}
 static inline void pgalloc_tag_sub(struct page *page, unsigned int order) {}
diff --git a/mm/mm_init.c b/mm/mm_init.c
index e9ea2919d02d..f5386632fe86 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -2566,6 +2566,7 @@ void __init set_dma_reserve(unsigned long new_dma_reserve)
 void __init memblock_free_pages(struct page *page, unsigned long pfn,
 							unsigned int order)
 {
+	union codetag_ref *ref;
 
 	if (IS_ENABLED(CONFIG_DEFERRED_STRUCT_PAGE_INIT)) {
 		int nid = early_pfn_to_nid(pfn);
@@ -2578,6 +2579,14 @@ void __init memblock_free_pages(struct page *page, unsigned long pfn,
 		/* KMSAN will take care of these pages. */
 		return;
 	}
+
+	/* pages were reserved and not allocated */
+	ref = get_page_tag_ref(page);
+	if (ref) {
+		set_codetag_empty(ref);
+		put_page_tag_ref(ref);
+	}
+
 	__free_pages_core(page, order);
 }
 
-- 
2.43.0.687.g38aa6559b0-goog

