Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 024D5132C3B
	for <iommu@lists.linux.dev>; Thu, 21 Mar 2024 16:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711039093; cv=none; b=BhiDgsFwGnhs5p1aeW0ZbRbGNP8CsS8WyNEa3EF+c8F/lkGlX9iaOde0IxTcMx+tvTDRpl/L0f5cO0IHpSBqEA5XPIDiuqqhtoXIp9PrzWGiQ2jB2HnxybbSx/u690Xv5GQ+DvnTg7WG52wdQsMdyrkDTZMgd52HibuB5VtJebk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711039093; c=relaxed/simple;
	bh=+ModUrXGUZjC5AAS6wB/LjX+0Qg1HpdT5TONNQSJr2U=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=r0SMYZV/2jIKN6C2bOP8eNm4KVDyQ3p8yi5azJwcTXg1h+QSYTCwKAPi6jBn/45yTnqegyRqAS6VFLf6S6KKWMk4Cpygc2baJEZatGJ5E9NWoqTebj99rVT9GvjVMFOqkGfbEhM6Lbg1L48rWVYZqiIWbR5B4bZDC2+RAgf57io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IChQhrUs; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IChQhrUs"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc746178515so1702193276.2
        for <iommu@lists.linux.dev>; Thu, 21 Mar 2024 09:38:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711039089; x=1711643889; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=DhlVYTL0Ii8S3ZK2BTRjXFWA8z6FsoYkfvkLJwCmND0=;
        b=IChQhrUsNcdOqs2ptsrRjFP0GMI9jcqTtamftVTC+pQvSailIJiaCw+NdgN+rBTr0x
         9rjaAcYeQ0Y8nV06taURjuYDtqNbGfAtbreRpeW+nCIE8zxEes+uIoSdgsUTV+uMEWwi
         dimyY0uE6mxG/Ych8WKJuJepbjYoYmodcC+HncPpoXqDa2ybJykOGR1JUmfIxNzSxmpm
         itwPrGWFNdT0JICP8SsHugPHYvzKMOJ8rHpCYn7WDOSq27mWmjAmTbr/i13VrIGBpIbE
         F2YPvMW/yS+FSyeqDZDtjVayyTH8GY1lOToaPkGLZumidJCrFybI027gf5Coi6mFSl2U
         Ui1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711039089; x=1711643889;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DhlVYTL0Ii8S3ZK2BTRjXFWA8z6FsoYkfvkLJwCmND0=;
        b=Ny+aI0LgRsSpTJoVjI4zVJD/4zi8Lf7SHj3/ddsjaVlUXPkclSv1MU4AYN2Un0PWoa
         tGy4Ksa0XpJo5RO9+DH4nmCeMmfE65ugcLuZw4lAv0X8N7RoVeedS0pWkA3rxJav2IyK
         82465XuIV1qQ9KwS6OOWgOoqlOKbcsJuDZSaXsLQDbL9vnxcTNpmCMD2LgxmCFDO+ddL
         57lhJtsxA/9cN6aLFKuQ5NLg1QBTwp6rEmHPqt7wxAFgV+T733MOLdNT01tN7/asjF0K
         pCSMoQB/3rXgmrY8gChUSS6Kld3sD8FTeafYsC5Lq81Y4YMvORwVA3NQ9NcKYRDmyrw8
         LZow==
X-Forwarded-Encrypted: i=1; AJvYcCUhpYfODgvIduPHjXm4+wFVMZ+6S4IvKQf04n2oICVjqULki/pnICA4PEZ/HGBQO6BYap+kamAumIOdNP+04M4Qv1K6O90=
X-Gm-Message-State: AOJu0Yyw4UoVa7Blhu/w8zwEqStFdHK2K9LlrD06djXLNGnwXz2gnvdz
	uE3rirHVMoSYaQxgrtoqm1WN0xuoP/0tVbqFI1VlXQdPv3rbleBrUi/RG55p/n1YBxobBLdE/1K
	3Mw==
X-Google-Smtp-Source: AGHT+IFC+oFCb8HvR8Vt3k92TqGML+O+aM2nK5Ub8xVAQ3egP3eKpX1Sre3j/wPk5Gz2RQOGjx8MvWsloBo=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:a489:6433:be5d:e639])
 (user=surenb job=sendgmr) by 2002:a05:6902:2689:b0:dcb:e4a2:1ab1 with SMTP id
 dx9-20020a056902268900b00dcbe4a21ab1mr2382761ybb.11.1711039088572; Thu, 21
 Mar 2024 09:38:08 -0700 (PDT)
Date: Thu, 21 Mar 2024 09:36:49 -0700
In-Reply-To: <20240321163705.3067592-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20240321163705.3067592-1-surenb@google.com>
X-Mailer: git-send-email 2.44.0.291.gc1ea87d7ee-goog
Message-ID: <20240321163705.3067592-28-surenb@google.com>
Subject: [PATCH v6 27/37] mm: percpu: Introduce pcpuobj_ext
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

Upcoming alloc tagging patches require a place to stash per-allocation
metadata.

We already do this when memcg is enabled, so this patch generalizes the
obj_cgroup * vector in struct pcpu_chunk by creating a pcpu_obj_ext
type, which we will be adding to in an upcoming patch - similarly to the
previous slabobj_ext patch.

Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Dennis Zhou <dennis@kernel.org>
Cc: Tejun Heo <tj@kernel.org>
Cc: Christoph Lameter <cl@linux.com>
Cc: linux-mm@kvack.org
---
 mm/percpu-internal.h | 19 +++++++++++++++++--
 mm/percpu.c          | 30 +++++++++++++++---------------
 2 files changed, 32 insertions(+), 17 deletions(-)

diff --git a/mm/percpu-internal.h b/mm/percpu-internal.h
index cdd0aa597a81..e62d582f4bf3 100644
--- a/mm/percpu-internal.h
+++ b/mm/percpu-internal.h
@@ -32,6 +32,16 @@ struct pcpu_block_md {
 	int			nr_bits;	/* total bits responsible for */
 };
 
+struct pcpuobj_ext {
+#ifdef CONFIG_MEMCG_KMEM
+	struct obj_cgroup	*cgroup;
+#endif
+};
+
+#ifdef CONFIG_MEMCG_KMEM
+#define NEED_PCPUOBJ_EXT
+#endif
+
 struct pcpu_chunk {
 #ifdef CONFIG_PERCPU_STATS
 	int			nr_alloc;	/* # of allocations */
@@ -64,8 +74,8 @@ struct pcpu_chunk {
 	int			end_offset;	/* additional area required to
 						   have the region end page
 						   aligned */
-#ifdef CONFIG_MEMCG_KMEM
-	struct obj_cgroup	**obj_cgroups;	/* vector of object cgroups */
+#ifdef NEED_PCPUOBJ_EXT
+	struct pcpuobj_ext	*obj_exts;	/* vector of object cgroups */
 #endif
 
 	int			nr_pages;	/* # of pages served by this chunk */
@@ -74,6 +84,11 @@ struct pcpu_chunk {
 	unsigned long		populated[];	/* populated bitmap */
 };
 
+static inline bool need_pcpuobj_ext(void)
+{
+	return !mem_cgroup_kmem_disabled();
+}
+
 extern spinlock_t pcpu_lock;
 
 extern struct list_head *pcpu_chunk_lists;
diff --git a/mm/percpu.c b/mm/percpu.c
index 4e11fc1e6def..2e5edaad9cc3 100644
--- a/mm/percpu.c
+++ b/mm/percpu.c
@@ -1392,9 +1392,9 @@ static struct pcpu_chunk * __init pcpu_alloc_first_chunk(unsigned long tmp_addr,
 		panic("%s: Failed to allocate %zu bytes\n", __func__,
 		      alloc_size);
 
-#ifdef CONFIG_MEMCG_KMEM
+#ifdef NEED_PCPUOBJ_EXT
 	/* first chunk is free to use */
-	chunk->obj_cgroups = NULL;
+	chunk->obj_exts = NULL;
 #endif
 	pcpu_init_md_blocks(chunk);
 
@@ -1463,12 +1463,12 @@ static struct pcpu_chunk *pcpu_alloc_chunk(gfp_t gfp)
 	if (!chunk->md_blocks)
 		goto md_blocks_fail;
 
-#ifdef CONFIG_MEMCG_KMEM
-	if (!mem_cgroup_kmem_disabled()) {
-		chunk->obj_cgroups =
+#ifdef NEED_PCPUOBJ_EXT
+	if (need_pcpuobj_ext()) {
+		chunk->obj_exts =
 			pcpu_mem_zalloc(pcpu_chunk_map_bits(chunk) *
-					sizeof(struct obj_cgroup *), gfp);
-		if (!chunk->obj_cgroups)
+					sizeof(struct pcpuobj_ext), gfp);
+		if (!chunk->obj_exts)
 			goto objcg_fail;
 	}
 #endif
@@ -1480,7 +1480,7 @@ static struct pcpu_chunk *pcpu_alloc_chunk(gfp_t gfp)
 
 	return chunk;
 
-#ifdef CONFIG_MEMCG_KMEM
+#ifdef NEED_PCPUOBJ_EXT
 objcg_fail:
 	pcpu_mem_free(chunk->md_blocks);
 #endif
@@ -1498,8 +1498,8 @@ static void pcpu_free_chunk(struct pcpu_chunk *chunk)
 {
 	if (!chunk)
 		return;
-#ifdef CONFIG_MEMCG_KMEM
-	pcpu_mem_free(chunk->obj_cgroups);
+#ifdef NEED_PCPUOBJ_EXT
+	pcpu_mem_free(chunk->obj_exts);
 #endif
 	pcpu_mem_free(chunk->md_blocks);
 	pcpu_mem_free(chunk->bound_map);
@@ -1646,9 +1646,9 @@ static void pcpu_memcg_post_alloc_hook(struct obj_cgroup *objcg,
 	if (!objcg)
 		return;
 
-	if (likely(chunk && chunk->obj_cgroups)) {
+	if (likely(chunk && chunk->obj_exts)) {
 		obj_cgroup_get(objcg);
-		chunk->obj_cgroups[off >> PCPU_MIN_ALLOC_SHIFT] = objcg;
+		chunk->obj_exts[off >> PCPU_MIN_ALLOC_SHIFT].cgroup = objcg;
 
 		rcu_read_lock();
 		mod_memcg_state(obj_cgroup_memcg(objcg), MEMCG_PERCPU_B,
@@ -1663,13 +1663,13 @@ static void pcpu_memcg_free_hook(struct pcpu_chunk *chunk, int off, size_t size)
 {
 	struct obj_cgroup *objcg;
 
-	if (unlikely(!chunk->obj_cgroups))
+	if (unlikely(!chunk->obj_exts))
 		return;
 
-	objcg = chunk->obj_cgroups[off >> PCPU_MIN_ALLOC_SHIFT];
+	objcg = chunk->obj_exts[off >> PCPU_MIN_ALLOC_SHIFT].cgroup;
 	if (!objcg)
 		return;
-	chunk->obj_cgroups[off >> PCPU_MIN_ALLOC_SHIFT] = NULL;
+	chunk->obj_exts[off >> PCPU_MIN_ALLOC_SHIFT].cgroup = NULL;
 
 	obj_cgroup_uncharge(objcg, pcpu_obj_full_size(size));
 
-- 
2.44.0.291.gc1ea87d7ee-goog

