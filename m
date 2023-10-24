Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2D8732C72
	for <iommu@lists.linux.dev>; Tue, 24 Oct 2023 13:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Xjkg+e3r"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-d9cfec5e73dso4391818276.2
        for <iommu@lists.linux.dev>; Tue, 24 Oct 2023 06:47:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698155253; x=1698760053; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=jxcZ43bmgT/q64Ul96+yH7BdLzW8wJzWTibIuRMuFN0=;
        b=Xjkg+e3rrWtaOMC1yQFWZNylCpddCMKHbm3vhKo+UbUUzSaGAt6Jt8jc8tdaZcaGdL
         sXVHYE5G+uWU6m6/tXbTnZmC5BoPlL2vSCRNNlw0+hvu7dEU3eOd37XT1zC8pUK7ouzJ
         ozlulcC4cQy/gsubb5CbhZB82OXHO9Z+bYex14gBaOmL3i7Ah5o0HZeOxDbTsrDcfWXt
         eRKXjPyH4/KvgGxmusCkV3WGo/iKSHIadiN3rxgyr5LRHECpPHWR+qx6psq+UWHXSnAD
         F80Ct22M3/M4jr3dmV180FWoBOnqE/OMfFi9sCC/uXC3MG5+lymLVcuzU927SwMfYDZJ
         97Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698155253; x=1698760053;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jxcZ43bmgT/q64Ul96+yH7BdLzW8wJzWTibIuRMuFN0=;
        b=jYqs5Q+QnrpsTccrHL0VQhCoHa2dPu6JbhiFU1SC+wcTWVF/eLzOPG74mJUlE0OhhT
         NjB11Jqaj+VaSif/SeE+yMU/N7HOwOHWGC3NAv3BWiIgMXz0fxAhnoGJx6We8RpXHeoB
         NxmBxByq8G8gHyNvlJ2TE3Z43MOqpVddj8y631vu95vzHUq5eH53dOFSPL7I4Qpjnnpv
         qFHbOtZZ+7AOYT1ckWBsreM2NhIB+KeUJVd4VG1l5oVFBNxG5Wn0/LsarsDSlptwLfYI
         X8gLmPTjTyav0VZg1mPsw7Q8C1k1M+lD+qhVFcs3Bpu5y0MOcQvVckIlYqlMspHNLKax
         XR6g==
X-Gm-Message-State: AOJu0Yw+I9F9sUgC4BzB2keODoJqYijLPnWnDRAUHBsip8N8seDbQp1y
	QzS80YxRlt597T1x8Rnq0cEqiXKHomU=
X-Google-Smtp-Source: AGHT+IHLiWJmtuPzRqvJDSScUKUh0y8YokFyWjfHx2rxdH2c6l653IiepUePcxPp47iOlZTgh6t0s/pZmOY=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:45ba:3318:d7a5:336a])
 (user=surenb job=sendgmr) by 2002:a25:d05:0:b0:d9a:5b63:a682 with SMTP id
 5-20020a250d05000000b00d9a5b63a682mr216305ybn.13.1698155252840; Tue, 24 Oct
 2023 06:47:32 -0700 (PDT)
Date: Tue, 24 Oct 2023 06:46:20 -0700
In-Reply-To: <20231024134637.3120277-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20231024134637.3120277-1-surenb@google.com>
X-Mailer: git-send-email 2.42.0.758.gaed0368e0e-goog
Message-ID: <20231024134637.3120277-24-surenb@google.com>
Subject: [PATCH v2 23/39] mm/slab: add allocation accounting into slab
 allocation and free paths
From: Suren Baghdasaryan <surenb@google.com>
To: akpm@linux-foundation.org
Cc: kent.overstreet@linux.dev, mhocko@suse.com, vbabka@suse.cz, 
	hannes@cmpxchg.org, roman.gushchin@linux.dev, mgorman@suse.de, 
	dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com, 
	corbet@lwn.net, void@manifault.com, peterz@infradead.org, 
	juri.lelli@redhat.com, ldufour@linux.ibm.com, catalin.marinas@arm.com, 
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

Account slab allocations using codetag reference embedded into slabobj_ext.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
Co-developed-by: Kent Overstreet <kent.overstreet@linux.dev>
Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
---
 include/linux/slab_def.h |  2 +-
 include/linux/slub_def.h |  4 ++--
 mm/slab.c                |  4 +++-
 mm/slab.h                | 32 ++++++++++++++++++++++++++++++++
 4 files changed, 38 insertions(+), 4 deletions(-)

diff --git a/include/linux/slab_def.h b/include/linux/slab_def.h
index a61e7d55d0d3..23f14dcb8d5b 100644
--- a/include/linux/slab_def.h
+++ b/include/linux/slab_def.h
@@ -107,7 +107,7 @@ static inline void *nearest_obj(struct kmem_cache *cache, const struct slab *sla
  *   reciprocal_divide(offset, cache->reciprocal_buffer_size)
  */
 static inline unsigned int obj_to_index(const struct kmem_cache *cache,
-					const struct slab *slab, void *obj)
+					const struct slab *slab, const void *obj)
 {
 	u32 offset = (obj - slab->s_mem);
 	return reciprocal_divide(offset, cache->reciprocal_buffer_size);
diff --git a/include/linux/slub_def.h b/include/linux/slub_def.h
index deb90cf4bffb..43fda4a5f23a 100644
--- a/include/linux/slub_def.h
+++ b/include/linux/slub_def.h
@@ -182,14 +182,14 @@ static inline void *nearest_obj(struct kmem_cache *cache, const struct slab *sla
 
 /* Determine object index from a given position */
 static inline unsigned int __obj_to_index(const struct kmem_cache *cache,
-					  void *addr, void *obj)
+					  void *addr, const void *obj)
 {
 	return reciprocal_divide(kasan_reset_tag(obj) - addr,
 				 cache->reciprocal_size);
 }
 
 static inline unsigned int obj_to_index(const struct kmem_cache *cache,
-					const struct slab *slab, void *obj)
+					const struct slab *slab, const void *obj)
 {
 	if (is_kfence_address(obj))
 		return 0;
diff --git a/mm/slab.c b/mm/slab.c
index cefcb7499b6c..18923f5f05b5 100644
--- a/mm/slab.c
+++ b/mm/slab.c
@@ -3348,9 +3348,11 @@ static void cache_flusharray(struct kmem_cache *cachep, struct array_cache *ac)
 static __always_inline void __cache_free(struct kmem_cache *cachep, void *objp,
 					 unsigned long caller)
 {
+	struct slab *slab = virt_to_slab(objp);
 	bool init;
 
-	memcg_slab_free_hook(cachep, virt_to_slab(objp), &objp, 1);
+	memcg_slab_free_hook(cachep, slab, &objp, 1);
+	alloc_tagging_slab_free_hook(cachep, slab, &objp, 1);
 
 	if (is_kfence_address(objp)) {
 		kmemleak_free_recursive(objp, cachep->flags);
diff --git a/mm/slab.h b/mm/slab.h
index 293210ed10a9..4859ce1f8808 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -533,6 +533,32 @@ prepare_slab_obj_exts_hook(struct kmem_cache *s, gfp_t flags, void *p)
 
 #endif /* CONFIG_SLAB_OBJ_EXT */
 
+#ifdef CONFIG_MEM_ALLOC_PROFILING
+
+static inline void alloc_tagging_slab_free_hook(struct kmem_cache *s, struct slab *slab,
+					void **p, int objects)
+{
+	struct slabobj_ext *obj_exts;
+	int i;
+
+	obj_exts = slab_obj_exts(slab);
+	if (!obj_exts)
+		return;
+
+	for (i = 0; i < objects; i++) {
+		unsigned int off = obj_to_index(s, slab, p[i]);
+
+		alloc_tag_sub(&obj_exts[off].ref, s->size);
+	}
+}
+
+#else
+
+static inline void alloc_tagging_slab_free_hook(struct kmem_cache *s, struct slab *slab,
+					void **p, int objects) {}
+
+#endif /* CONFIG_MEM_ALLOC_PROFILING */
+
 #ifdef CONFIG_MEMCG_KMEM
 void mod_objcg_state(struct obj_cgroup *objcg, struct pglist_data *pgdat,
 		     enum node_stat_item idx, int nr);
@@ -827,6 +853,12 @@ static inline void slab_post_alloc_hook(struct kmem_cache *s,
 					 s->flags, flags);
 		kmsan_slab_alloc(s, p[i], flags);
 		obj_exts = prepare_slab_obj_exts_hook(s, flags, p[i]);
+
+#ifdef CONFIG_MEM_ALLOC_PROFILING
+		/* obj_exts can be allocated for other reasons */
+		if (likely(obj_exts) && mem_alloc_profiling_enabled())
+			alloc_tag_add(&obj_exts->ref, current->alloc_tag, s->size);
+#endif
 	}
 
 	memcg_slab_post_alloc_hook(s, objcg, flags, size, p);
-- 
2.42.0.758.gaed0368e0e-goog

