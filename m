Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 789E61586F6
	for <iommu@lists.linux.dev>; Wed, 21 Feb 2024 19:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708544531; cv=none; b=DeDsBlDv71ju8uMTPneJh0miVT/l7Y1ZIJ5Z5GKd1MTBwRSige9QG3ctR65h4cANBXBJRKRQ2/jsrhiG+BNbJRE/cj4ADj/1c9pKtcHM4dshEIztB70mEazLd+M3vKwcPv/C9PpFeMLNHQJ9DD5tIoHGaogYfB2A75SJymZoPQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708544531; c=relaxed/simple;
	bh=B9yREK+2m0y6au8+gNCPG8f4DCiVUoiiRYA7mpLHkiA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=QFUQeYSpwzITOO+1SQDk/venUCYRIfnXMmIEtjTWfOBadGhZri6Aw2uWdYMTxyyYiyV7YjzuSRMKXS8maY9iID0qja6arB8xmjbjc/HdtzkOCbQIT1382DKlfc9xW1tYb40dJYrLZHOs68c5/H8XgsbJwDE/kzDxTPoLoDpZOKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kgc7LgVQ; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kgc7LgVQ"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc64b659a9cso12526003276.3
        for <iommu@lists.linux.dev>; Wed, 21 Feb 2024 11:42:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708544527; x=1709149327; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=/f5EOcne7K32iqTM6gsyOYn4NQeb5Q9RrrPaWIBtzrU=;
        b=kgc7LgVQdg9Q6iykdzRnpMhHX71jjN5numCApHX+QeaiYMrMqtcrmGor77lSGrzj6Z
         aZ11wQbhcuq5Z5VAYWj+DaDqON3pldM0sH10dycS5Rw/h/mkxAUJvarF9wedgHKc/S5d
         Q9yl82nA3HKDHS4iA/jTQm6D7NDiNAVvEI7aTSxoftg4y3LKuuEh1FYMcAss7MvNTPqm
         hhM6+OPWUte1eDD0NoTLJZR/YXRarS61NFKj9OKk/DIqYihtfsCvMZ5Abt/N8EIvmGem
         3ERJD+N7cXWgVPx2pvIph81BuqD+HsoLVmxFgYSp42QtNJf/GXayc3PzhcqIbPdOoNn/
         HKUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708544527; x=1709149327;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/f5EOcne7K32iqTM6gsyOYn4NQeb5Q9RrrPaWIBtzrU=;
        b=dBD1cm6ZSMqY/ZrGJQ3ciMLN9uo92Ys7M5znTk1lCkHKrq74DMoCF2DEp+EvT/gN8z
         BBpqhVVLlqhJ2aRu6Mdpu4yFUoM6AnY+4kwvw5PyqL7+u5kvrid06k4r4ByZR9QpEKx6
         enVDbfk+9UlEfmGERyjm7YZf+xnkwT3OEaRURmxx+1WLZfTw2JnJXdL14oOsetPmjt2D
         JLRSvP8SgRWHM1Ym5RXR03IkimAvuWRa7jFwH+uPGpZpUpTa0tFqCMV7zzP8oCxVAtuq
         o5xQ8fEnkyQgxvkTIfTweAR6aJ4zYOQJO5gymKpg5KtZ4xoqyOT+pDfNgiPOqz3Y5AtZ
         BPiw==
X-Forwarded-Encrypted: i=1; AJvYcCW2zMl8d9NyfNzSiNUR8DlV90WAPzYcC7HgoJy/pzwSVHPHiWrAoTkvok1pBUZu9MfzYzJINyzG6vfiC6nxUA6BZPmQ/kU=
X-Gm-Message-State: AOJu0YxWcwVVH+PHUegFbOS/laMfxz3WQJ7/kfcSWEW1IWzKvS5sGln7
	zYv45n3xFqa3LJ7Me5sxvfvxKJciJgmtBJuqJrbX4xYQJF/P4UFL56cUZruxzIxCKSw74dfqLNE
	Xeg==
X-Google-Smtp-Source: AGHT+IGFiWXsCIvnXCn7DCHC4E3aqtfNjiBbLG3wTDrJrg+DapwG+olr3URRZ84R+eZCxmTFvxp+ectvo4c=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:953b:9a4e:1e10:3f07])
 (user=surenb job=sendgmr) by 2002:a05:6902:134d:b0:dcb:e4a2:1ab1 with SMTP id
 g13-20020a056902134d00b00dcbe4a21ab1mr67096ybu.11.1708544527496; Wed, 21 Feb
 2024 11:42:07 -0800 (PST)
Date: Wed, 21 Feb 2024 11:40:45 -0800
In-Reply-To: <20240221194052.927623-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20240221194052.927623-1-surenb@google.com>
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
Message-ID: <20240221194052.927623-33-surenb@google.com>
Subject: [PATCH v4 32/36] codetag: debug: skip objext checking when it's for
 objext itself
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

objext objects are created with __GFP_NO_OBJ_EXT flag and therefore have
no corresponding objext themselves (otherwise we would get an infinite
recursion). When freeing these objects their codetag will be empty and
when CONFIG_MEM_ALLOC_PROFILING_DEBUG is enabled this will lead to false
warnings. Introduce CODETAG_EMPTY special codetag value to mark
allocations which intentionally lack codetag to avoid these warnings.
Set objext codetags to CODETAG_EMPTY before freeing to indicate that
the codetag is expected to be empty.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 include/linux/alloc_tag.h | 26 ++++++++++++++++++++++++++
 mm/slub.c                 | 33 +++++++++++++++++++++++++++++++++
 2 files changed, 59 insertions(+)

diff --git a/include/linux/alloc_tag.h b/include/linux/alloc_tag.h
index 85a24a027403..4a3fc865d878 100644
--- a/include/linux/alloc_tag.h
+++ b/include/linux/alloc_tag.h
@@ -28,6 +28,27 @@ struct alloc_tag {
 	struct alloc_tag_counters __percpu	*counters;
 } __aligned(8);
 
+#ifdef CONFIG_MEM_ALLOC_PROFILING_DEBUG
+
+#define CODETAG_EMPTY	((void *)1)
+
+static inline bool is_codetag_empty(union codetag_ref *ref)
+{
+	return ref->ct == CODETAG_EMPTY;
+}
+
+static inline void set_codetag_empty(union codetag_ref *ref)
+{
+	if (ref)
+		ref->ct = CODETAG_EMPTY;
+}
+
+#else /* CONFIG_MEM_ALLOC_PROFILING_DEBUG */
+
+static inline bool is_codetag_empty(union codetag_ref *ref) { return false; }
+
+#endif /* CONFIG_MEM_ALLOC_PROFILING_DEBUG */
+
 #ifdef CONFIG_MEM_ALLOC_PROFILING
 
 struct codetag_bytes {
@@ -91,6 +112,11 @@ static inline void __alloc_tag_sub(union codetag_ref *ref, size_t bytes)
 	if (!ref || !ref->ct)
 		return;
 
+	if (is_codetag_empty(ref)) {
+		ref->ct = NULL;
+		return;
+	}
+
 	tag = ct_to_alloc_tag(ref->ct);
 
 	this_cpu_sub(tag->counters->bytes, bytes);
diff --git a/mm/slub.c b/mm/slub.c
index 920b24b4140e..3e41d45f9fa4 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -1883,6 +1883,30 @@ static inline enum node_stat_item cache_vmstat_idx(struct kmem_cache *s)
 
 #ifdef CONFIG_SLAB_OBJ_EXT
 
+#ifdef CONFIG_MEM_ALLOC_PROFILING_DEBUG
+
+static inline void mark_objexts_empty(struct slabobj_ext *obj_exts)
+{
+	struct slabobj_ext *slab_exts;
+	struct slab *obj_exts_slab;
+
+	obj_exts_slab = virt_to_slab(obj_exts);
+	slab_exts = slab_obj_exts(obj_exts_slab);
+	if (slab_exts) {
+		unsigned int offs = obj_to_index(obj_exts_slab->slab_cache,
+						 obj_exts_slab, obj_exts);
+		/* codetag should be NULL */
+		WARN_ON(slab_exts[offs].ref.ct);
+		set_codetag_empty(&slab_exts[offs].ref);
+	}
+}
+
+#else /* CONFIG_MEM_ALLOC_PROFILING_DEBUG */
+
+static inline void mark_objexts_empty(struct slabobj_ext *obj_exts) {}
+
+#endif /* CONFIG_MEM_ALLOC_PROFILING_DEBUG */
+
 /*
  * The allocated objcg pointers array is not accounted directly.
  * Moreover, it should not come from DMA buffer and is not readily
@@ -1923,6 +1947,7 @@ int alloc_slab_obj_exts(struct slab *slab, struct kmem_cache *s,
 		 * assign slabobj_exts in parallel. In this case the existing
 		 * objcg vector should be reused.
 		 */
+		mark_objexts_empty(vec);
 		kfree(vec);
 		return 0;
 	}
@@ -1939,6 +1964,14 @@ static inline void free_slab_obj_exts(struct slab *slab)
 	if (!obj_exts)
 		return;
 
+	/*
+	 * obj_exts was created with __GFP_NO_OBJ_EXT flag, therefore its
+	 * corresponding extension will be NULL. alloc_tag_sub() will throw a
+	 * warning if slab has extensions but the extension of an object is
+	 * NULL, therefore replace NULL with CODETAG_EMPTY to indicate that
+	 * the extension for obj_exts is expected to be NULL.
+	 */
+	mark_objexts_empty(obj_exts);
 	kfree(obj_exts);
 	slab->obj_exts = 0;
 }
-- 
2.44.0.rc0.258.g7320e95886-goog

