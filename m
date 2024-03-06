Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A065A1509B4
	for <iommu@lists.linux.dev>; Wed,  6 Mar 2024 18:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709749558; cv=none; b=YVrH+9/g0aeWNepgD3YikX+1f4daII3wWByeS+Hb1944sYebs52RgU9p+37PBaeAHGOvtKrV5Law+Ncnec4lYNTScCNISN7nGmHFVQ/zRMrbu3DMZNfnAFm/X/vyXRpiZ6pgfP224Gu6VuPEiVytNx5vvT/bOCa7voyDGS/vj9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709749558; c=relaxed/simple;
	bh=L9xZd/8dD/B+wVgzLMXnQW4+21qHfcs5mXi5Enxm84s=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=AvNIcvyrNP/KWsxfbV5iCM9kv5S9DoNEToIojb1sd9zhLXioGzM3YRMF4RUQZUlEjMj56kOXz9/32IeGTcI/UoyOnbFZJ8NURSKgoV1HeRTxJML5ySBJ2xi/1gwBqxF34UOTsWGCnfAgewqEeZqeXkj4m6bPy0j0bdKIgj/b0cY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZnBjn0ji; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZnBjn0ji"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-5f38d676cecso15116057b3.0
        for <iommu@lists.linux.dev>; Wed, 06 Mar 2024 10:25:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709749556; x=1710354356; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=O0frA1qINx6EEpp9W3MZZMQxDt0vbebTSbODwHd6D+c=;
        b=ZnBjn0jiSW9gri1PtVJsy4y0zQ41wjdH7QMd9JuraQ358Bk4lJn4wqv4/ieRRuRY25
         kQFjiFwlN2NjbH8Ym8hKrA/UDyubss53qY4QxZzTTu+oxOR6G839JzKYBqSAufNd4OaE
         ptHRazX8kdM6O+UzRTMWvmI8PA5Bx1BPH0+0i/ySD3nfCYKMlZjdKIL6kXjIGyCcH0Ge
         gw/LhXSVfQUnyMThn8RKE12gb274/M+kf1ZTyxJe0IWdpgIgBBTOZdXNtiYqYaazUlwM
         FMDieA6UpauKAXyMFKufw4z6DjGwzpZbhNPyX3bxXngtOpxS8WE3JW2G+bP8HQ34AwGO
         k8bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709749556; x=1710354356;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O0frA1qINx6EEpp9W3MZZMQxDt0vbebTSbODwHd6D+c=;
        b=oLwWPj9xnddk/h29Lczjupg4PpLxpoNaFNWA2NzkMjhVLCP+tmye3fgx2VCjcKYqEk
         Q6khOEV6lDIA4trbwDl+DDEjzau8sGA5R9OYJPFGR5vIbcj3dVuQjG9XHiKsFEiQxP7W
         IuYwMGrlS70cZYNKbGrvITmIL5qknHyGSMCqMPh9ML6sSbKq8SlUkqok55z+6tnC96vg
         DfPObO24C3ZZiH1r+WtCdyAjUPnWGeD6+v1Pr7+etlJYfwcRxT7sGXq4uRz2QdepbQKn
         gNb38u4eMLHxoMfbLP7jbAbldc84FZU94AUE0C6aUg2WQ6jSE+m5agQSmD6hKdE7L55X
         eZpQ==
X-Forwarded-Encrypted: i=1; AJvYcCUwauq4/u4LnkD1KrPCBP2efUAdYJ5oiCNkmW3e9eg0DXBXjO0cODlwYoJXG2SRBUXwkP1Bk62MLKp8YKi5cirTv20S2UI=
X-Gm-Message-State: AOJu0YzB2iW7284rE21veJnYHj6CBm8aNj41PHQCmqZvmIzUbpHjcBXD
	1lKCz4h15oSFDUybDbwP0uWfgj4iBBt2bI0eKxfkzJP/3MjhiDcDv3JDg1gS9CP8lU0F2gypHs6
	vcA==
X-Google-Smtp-Source: AGHT+IEXefXvPH1tjm5HxKdrHK6H7bskL9rQoKUPz6GiJtbM4dOshetWTVsxTxg9M/C0/zg3HXT9l9SvJvs=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:85f0:e3db:db05:85e2])
 (user=surenb job=sendgmr) by 2002:a05:6902:705:b0:dbe:d0a9:2be3 with SMTP id
 k5-20020a056902070500b00dbed0a92be3mr1901493ybt.3.1709749555637; Wed, 06 Mar
 2024 10:25:55 -0800 (PST)
Date: Wed,  6 Mar 2024 10:24:31 -0800
In-Reply-To: <20240306182440.2003814-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20240306182440.2003814-1-surenb@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Message-ID: <20240306182440.2003814-34-surenb@google.com>
Subject: [PATCH v5 33/37] codetag: debug: skip objext checking when it's for
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
index aefe3c81a1e3..c30e6c944353 100644
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
@@ -140,6 +161,11 @@ static inline void alloc_tag_sub(union codetag_ref *ref, size_t bytes)
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
index 5e6d68d05740..4a396e1315ae 100644
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
@@ -1923,6 +1947,7 @@ static int alloc_slab_obj_exts(struct slab *slab, struct kmem_cache *s,
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
2.44.0.278.ge034bb2e1d-goog

