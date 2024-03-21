Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92581143C60
	for <iommu@lists.linux.dev>; Thu, 21 Mar 2024 16:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711039106; cv=none; b=r4/Ui47lX8L3qgfyyKjsMu5HfoHZ1XWD4oxSAxNFMVaPzI+O63VD4xNomU/oVLKbmXjYlSVGUByx6yTV3QZNHzAgtsljhM1rFRP9hHWS5Ju42es7LG3Pm1q7M80kdQ44Bnk9HZHBy09C/3mxS6Nl8tHLcIYYDgJ4FrYWoTgafuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711039106; c=relaxed/simple;
	bh=ygJGtJU4SJLojLPssViMygN5fauvJAqTfNcBwf8ltc8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=p+GSLmHWBfE9/aigN+eI8kKgidIkTyHSfXcE7wjX/PI9qy5lNQB/Kv+ci2Ft/giDtNvZYCwcFqpYjTOkREAq8xT94ZsXYxOXzAoYW5cKbaczVEVgrfwqOvnin3tVe5m6rWxOPYQG2jioXvXNeCVeyuCsjuiRSNIPOaX0uCfTUVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LTAjXP/w; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LTAjXP/w"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dd933a044baso2906462276.0
        for <iommu@lists.linux.dev>; Thu, 21 Mar 2024 09:38:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711039104; x=1711643904; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=fkzGAdcAIO9V5Ziif/kwje70ys4aQ86/VyfgELZXTD4=;
        b=LTAjXP/wgQ5KQUqryub0Fvji5B9azXSqJchC04g3LdeYvWGaGeMuH88ByfMYuwm/PL
         3qSMMvmo3t4yO2mROWGSJIqPOSz7B0GTCi5CCoKxDrSgn/gdhoki1lgaV6Ba22PO+A+K
         LXiRKrbLhAkGuMw9MANyiaXCNfHZwNLYKJVyg4eegOvv2NXJRrK+zxtVdWSpxYplzfTW
         ymtVmo9vmE8YuDZY9zq3ViNYvbnrAc+/VDFCPLzsprrq5bj3tu732x8O6B1SmVaY6l3W
         EYJVZXpnpSVf8ytLFPG6TKAsVNOwOEttVqjNkLUQmJBgz4QP1AtGWoUm/goD2CcNptCS
         HVpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711039104; x=1711643904;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fkzGAdcAIO9V5Ziif/kwje70ys4aQ86/VyfgELZXTD4=;
        b=DuS1bv1OGh7bSZpLJfDu3V6rBWKgumSooDUKlerACcvt/oecvWpalUaMlpmORPMGMQ
         6l13iAK5KaSPpnsUo1uDJByKDOULr0Vn05JIGbwGgRQyDC9U050mIKgN8HF5QDORNpMM
         qabjS3cwp7qPkYgM6F5bB3kPw6+csfCTS2vW1sNaW5JjHs4LedG95od7wyPmNFVnY4uY
         QrP+uy57F+Z6CQM3TmKCwlqMBb+qNwsVodHGd1IG+pSux9WkMGf7Bmkz8nuBNsZEUmQh
         0gFLeChAfQEA4PT8tsBc+qThZzhH0dcwhuiSZ9vvE9GpEClwX9U/5MCGToEu2Z/+oD+0
         K3aw==
X-Forwarded-Encrypted: i=1; AJvYcCX+1xTa8zSIS/759GixnEW5QDBhXZNXIJDG5OjH9x1Dfz/yf0stOTTWCuxaqmk6mILpSY8R7Jt+Fy7PCZT1aczAuAkeVW0=
X-Gm-Message-State: AOJu0YzMORpduMzRKpDqKI/yddcDqWZyAYvPpy4zxrSPBksGfTw2AW25
	vk9lhblFn2r4AKw8aAvCst5bft9UIft1Xyb3ZCRh1wjN1ns1drnue8OgupHBna9wXi4SvWVWOVl
	l3g==
X-Google-Smtp-Source: AGHT+IGsZeht1WnRv54WdZCsHHkevoWEcBuLsOMdDTLOZ/BEZ/G/n2nCv8k8gfmNzlHHNHWmAN7X+BiTyog=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:a489:6433:be5d:e639])
 (user=surenb job=sendgmr) by 2002:a25:dbd2:0:b0:dc6:b7c2:176e with SMTP id
 g201-20020a25dbd2000000b00dc6b7c2176emr610053ybf.4.1711039103623; Thu, 21 Mar
 2024 09:38:23 -0700 (PDT)
Date: Thu, 21 Mar 2024 09:36:56 -0700
In-Reply-To: <20240321163705.3067592-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20240321163705.3067592-1-surenb@google.com>
X-Mailer: git-send-email 2.44.0.291.gc1ea87d7ee-goog
Message-ID: <20240321163705.3067592-35-surenb@google.com>
Subject: [PATCH v6 34/37] codetag: debug: mark codetags for reserved pages as empty
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
index c30e6c944353..100ddf66eb8e 100644
--- a/include/linux/alloc_tag.h
+++ b/include/linux/alloc_tag.h
@@ -46,6 +46,7 @@ static inline void set_codetag_empty(union codetag_ref *ref)
 #else /* CONFIG_MEM_ALLOC_PROFILING_DEBUG */
 
 static inline bool is_codetag_empty(union codetag_ref *ref) { return false; }
+static inline void set_codetag_empty(union codetag_ref *ref) {}
 
 #endif /* CONFIG_MEM_ALLOC_PROFILING_DEBUG */
 
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 8147b1302413..2615aa69c823 100644
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
@@ -3132,6 +3133,14 @@ extern void reserve_bootmem_region(phys_addr_t start,
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
index 50d212330bbb..62d8dad74b37 100644
--- a/include/linux/pgalloc_tag.h
+++ b/include/linux/pgalloc_tag.h
@@ -120,6 +120,8 @@ static inline void pgalloc_tag_sub_pages(struct alloc_tag *tag, unsigned int nr)
 
 #else /* CONFIG_MEM_ALLOC_PROFILING */
 
+static inline union codetag_ref *get_page_tag_ref(struct page *page) { return NULL; }
+static inline void put_page_tag_ref(union codetag_ref *ref) {}
 static inline void pgalloc_tag_add(struct page *page, struct task_struct *task,
 				   unsigned int nr) {}
 static inline void pgalloc_tag_sub(struct page *page, unsigned int nr) {}
diff --git a/mm/mm_init.c b/mm/mm_init.c
index 3e48afcd0faa..c7d6376a180c 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -2510,7 +2510,6 @@ void *__init alloc_large_system_hash(const char *tablename,
 void __init memblock_free_pages(struct page *page, unsigned long pfn,
 							unsigned int order)
 {
-
 	if (IS_ENABLED(CONFIG_DEFERRED_STRUCT_PAGE_INIT)) {
 		int nid = early_pfn_to_nid(pfn);
 
@@ -2522,6 +2521,17 @@ void __init memblock_free_pages(struct page *page, unsigned long pfn,
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
2.44.0.291.gc1ea87d7ee-goog

