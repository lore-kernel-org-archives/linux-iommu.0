Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79D58142919
	for <iommu@lists.linux.dev>; Thu, 21 Mar 2024 16:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711039100; cv=none; b=DDMqPlAq8ESYPQM9vy2YBHfj7yZIUvZfbdfXfVM7VgcVuwKmLM9RoxlCQhiFLjYTkKTFUmM5DKDRp6QcPvAiWk8XbmRQ+1BLHLrAK3//BQal1MHAeTkPmsDOiJk+WaIGLeOijVWYHl7Uf4zVAvBGwPfqwAdalzGG//fmz6mSx6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711039100; c=relaxed/simple;
	bh=dLP/xEKvAlFy0CEGgcN9QUf+tNZYc143hgSrqnBpNn8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ptMLGhTc/9ss0YD7LAcbF/Uwr1VlEONZkB20h34rw5AtB1sKUROfXzlU+2s2ycAPUUbYmQTWpT2aA6BURvK4k0eW4QPnqnEy49QyrinxCGPOjxhZAGuHl4xnDJ8+mw+QC7bBimHEWhGdDF7ryr0U/MRKq1x+hg46kQ+yGHaEWno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VRo+WqES; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VRo+WqES"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dcbee93a3e1so1862216276.3
        for <iommu@lists.linux.dev>; Thu, 21 Mar 2024 09:38:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711039097; x=1711643897; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=XaC6gpRUGM+qkcKqV2c0VBwhZNh1AuaCpOBKo907lO0=;
        b=VRo+WqESAlyEPgWPKsYX6F+TAAgDsCfbfpYVp8ZGH55j7YSbEMoYSHn/Cl6F5vTgWu
         Hu1uoUvw1RhUL0/byZhtUbH23Fsxna3xWAbk7716xWtxCmaH5Rm2gt4wJPtKSPZntL0b
         weuNac+AeSiqhuGtrLXIC+bp6UEZB3In0UuLe3qsXMhA/uFg51FNGRcHmpD5cNNcAI42
         Z+7rArfakjDNjFRQxzKz9ZwuPmvNLmwSyM3n+fkgn+Nuz2ghlisbsye1ForGYHRSMMiC
         dT+fFPoLVdEclymMbIQlqNYo33qhyhVP3rwQTiFNlQrbmHMLBmt0hBMxJ0YIMKc3UPOJ
         9OuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711039097; x=1711643897;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XaC6gpRUGM+qkcKqV2c0VBwhZNh1AuaCpOBKo907lO0=;
        b=aX1rxMovNr2Gc1Qfp2OPOqTnoBcsb00S77M7tL8hSqrh5xZZG66vJAiQQsjZ2Fd+Yi
         0QQAkP2v8SFKyMqE3TR1OvhkERddz4eX6N1p7fdFzUR0s6kILSiP4hVEmNQJ5IVakv59
         24WDeWg3DfpBrQf5jFd0aL7E+zMmLXOzC54vVzF8wkgqQAJVoTDSLYMdm92q6Nw5dWc6
         XTbSLMqd8YOI4EYV20cp0fJ0zrIPcyqWl3tG0wHtkQ9CJppIKncMQMZAe0xRqxuErsWQ
         tlSOhI3/EMfK6Y88f2lquxHEbVaq9w9FWJqTDpB208prXF9Cl9vIJUv2Wsh/TtEYtEuB
         TSzQ==
X-Forwarded-Encrypted: i=1; AJvYcCV7hQii7HkE+kEXSd14Npey5hg/ptHzFOcTdLIHMimsXZ4L7nm9fg5+Umj8upjkeHFNxY75Mf2P9ANxaD+J59jMg6mKkcI=
X-Gm-Message-State: AOJu0Yzk+edUgXJHyqXkWJDNZm9E3Mia9F8R/7Rx1ibrxvDv6VGEtUad
	gDTmDGTKUtU1gaySHYgH9P8jX2vs5NqgTDqxJ5bjODI/z2VqJV+1bR4Ds3P6LatM0FXkPXc8zqh
	p3A==
X-Google-Smtp-Source: AGHT+IFJZSHudCuIglXlIopkXnNLMb9lH1yhVoF6leBD0jJ9ERT3JCkQE6hJAbySj4mxb56Bo4c8jp1OowQ=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:a489:6433:be5d:e639])
 (user=surenb job=sendgmr) by 2002:a05:6902:1502:b0:dc6:e823:9edb with SMTP id
 q2-20020a056902150200b00dc6e8239edbmr1143317ybu.12.1711039097346; Thu, 21 Mar
 2024 09:38:17 -0700 (PDT)
Date: Thu, 21 Mar 2024 09:36:53 -0700
In-Reply-To: <20240321163705.3067592-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20240321163705.3067592-1-surenb@google.com>
X-Mailer: git-send-email 2.44.0.291.gc1ea87d7ee-goog
Message-ID: <20240321163705.3067592-32-surenb@google.com>
Subject: [PATCH v6 31/37] rhashtable: Plumb through alloc tag
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

This gives better memory allocation profiling results; rhashtable
allocations will be accounted to the code that initialized the
rhashtable.

Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 include/linux/alloc_tag.h        |  3 +++
 include/linux/rhashtable-types.h | 11 +++++++++--
 lib/rhashtable.c                 | 28 +++++++++++++++++-----------
 3 files changed, 29 insertions(+), 13 deletions(-)

diff --git a/include/linux/alloc_tag.h b/include/linux/alloc_tag.h
index bc9b1b99a55b..cf69e037f645 100644
--- a/include/linux/alloc_tag.h
+++ b/include/linux/alloc_tag.h
@@ -141,6 +141,8 @@ static inline void alloc_tag_sub(union codetag_ref *ref, size_t bytes)
 	ref->ct = NULL;
 }
 
+#define alloc_tag_record(p)	((p) = current->alloc_tag)
+
 #else /* CONFIG_MEM_ALLOC_PROFILING */
 
 #define DEFINE_ALLOC_TAG(_alloc_tag)
@@ -148,6 +150,7 @@ static inline bool mem_alloc_profiling_enabled(void) { return false; }
 static inline void alloc_tag_add(union codetag_ref *ref, struct alloc_tag *tag,
 				 size_t bytes) {}
 static inline void alloc_tag_sub(union codetag_ref *ref, size_t bytes) {}
+#define alloc_tag_record(p)	do {} while (0)
 
 #endif /* CONFIG_MEM_ALLOC_PROFILING */
 
diff --git a/include/linux/rhashtable-types.h b/include/linux/rhashtable-types.h
index b6f3797277ff..015c8298bebc 100644
--- a/include/linux/rhashtable-types.h
+++ b/include/linux/rhashtable-types.h
@@ -9,6 +9,7 @@
 #ifndef _LINUX_RHASHTABLE_TYPES_H
 #define _LINUX_RHASHTABLE_TYPES_H
 
+#include <linux/alloc_tag.h>
 #include <linux/atomic.h>
 #include <linux/compiler.h>
 #include <linux/mutex.h>
@@ -88,6 +89,9 @@ struct rhashtable {
 	struct mutex                    mutex;
 	spinlock_t			lock;
 	atomic_t			nelems;
+#ifdef CONFIG_MEM_ALLOC_PROFILING
+	struct alloc_tag		*alloc_tag;
+#endif
 };
 
 /**
@@ -127,9 +131,12 @@ struct rhashtable_iter {
 	bool end_of_table;
 };
 
-int rhashtable_init(struct rhashtable *ht,
+int rhashtable_init_noprof(struct rhashtable *ht,
 		    const struct rhashtable_params *params);
-int rhltable_init(struct rhltable *hlt,
+#define rhashtable_init(...)	alloc_hooks(rhashtable_init_noprof(__VA_ARGS__))
+
+int rhltable_init_noprof(struct rhltable *hlt,
 		  const struct rhashtable_params *params);
+#define rhltable_init(...)	alloc_hooks(rhltable_init_noprof(__VA_ARGS__))
 
 #endif /* _LINUX_RHASHTABLE_TYPES_H */
diff --git a/lib/rhashtable.c b/lib/rhashtable.c
index 6ae2ba8e06a2..35d841cf2b43 100644
--- a/lib/rhashtable.c
+++ b/lib/rhashtable.c
@@ -130,7 +130,8 @@ static union nested_table *nested_table_alloc(struct rhashtable *ht,
 	if (ntbl)
 		return ntbl;
 
-	ntbl = kzalloc(PAGE_SIZE, GFP_ATOMIC);
+	ntbl = alloc_hooks_tag(ht->alloc_tag,
+			kmalloc_noprof(PAGE_SIZE, GFP_ATOMIC|__GFP_ZERO));
 
 	if (ntbl && leaf) {
 		for (i = 0; i < PAGE_SIZE / sizeof(ntbl[0]); i++)
@@ -157,7 +158,8 @@ static struct bucket_table *nested_bucket_table_alloc(struct rhashtable *ht,
 
 	size = sizeof(*tbl) + sizeof(tbl->buckets[0]);
 
-	tbl = kzalloc(size, gfp);
+	tbl = alloc_hooks_tag(ht->alloc_tag,
+			kmalloc_noprof(size, gfp|__GFP_ZERO));
 	if (!tbl)
 		return NULL;
 
@@ -181,7 +183,9 @@ static struct bucket_table *bucket_table_alloc(struct rhashtable *ht,
 	int i;
 	static struct lock_class_key __key;
 
-	tbl = kvzalloc(struct_size(tbl, buckets, nbuckets), gfp);
+	tbl = alloc_hooks_tag(ht->alloc_tag,
+			kvmalloc_node_noprof(struct_size(tbl, buckets, nbuckets),
+					     gfp|__GFP_ZERO, NUMA_NO_NODE));
 
 	size = nbuckets;
 
@@ -975,7 +979,7 @@ static u32 rhashtable_jhash2(const void *key, u32 length, u32 seed)
 }
 
 /**
- * rhashtable_init - initialize a new hash table
+ * rhashtable_init_noprof - initialize a new hash table
  * @ht:		hash table to be initialized
  * @params:	configuration parameters
  *
@@ -1016,7 +1020,7 @@ static u32 rhashtable_jhash2(const void *key, u32 length, u32 seed)
  *	.obj_hashfn = my_hash_fn,
  * };
  */
-int rhashtable_init(struct rhashtable *ht,
+int rhashtable_init_noprof(struct rhashtable *ht,
 		    const struct rhashtable_params *params)
 {
 	struct bucket_table *tbl;
@@ -1031,6 +1035,8 @@ int rhashtable_init(struct rhashtable *ht,
 	spin_lock_init(&ht->lock);
 	memcpy(&ht->p, params, sizeof(*params));
 
+	alloc_tag_record(ht->alloc_tag);
+
 	if (params->min_size)
 		ht->p.min_size = roundup_pow_of_two(params->min_size);
 
@@ -1076,26 +1082,26 @@ int rhashtable_init(struct rhashtable *ht,
 
 	return 0;
 }
-EXPORT_SYMBOL_GPL(rhashtable_init);
+EXPORT_SYMBOL_GPL(rhashtable_init_noprof);
 
 /**
- * rhltable_init - initialize a new hash list table
+ * rhltable_init_noprof - initialize a new hash list table
  * @hlt:	hash list table to be initialized
  * @params:	configuration parameters
  *
  * Initializes a new hash list table.
  *
- * See documentation for rhashtable_init.
+ * See documentation for rhashtable_init_noprof.
  */
-int rhltable_init(struct rhltable *hlt, const struct rhashtable_params *params)
+int rhltable_init_noprof(struct rhltable *hlt, const struct rhashtable_params *params)
 {
 	int err;
 
-	err = rhashtable_init(&hlt->ht, params);
+	err = rhashtable_init_noprof(&hlt->ht, params);
 	hlt->ht.rhlist = true;
 	return err;
 }
-EXPORT_SYMBOL_GPL(rhltable_init);
+EXPORT_SYMBOL_GPL(rhltable_init_noprof);
 
 static void rhashtable_free_one(struct rhashtable *ht, struct rhash_head *obj,
 				void (*free_fn)(void *ptr, void *arg),
-- 
2.44.0.291.gc1ea87d7ee-goog

