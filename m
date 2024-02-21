Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C76FB1552EB
	for <iommu@lists.linux.dev>; Wed, 21 Feb 2024 19:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708544518; cv=none; b=F6XjDtSAl21Yf3korgmTG+sj9/cfeXS0oUpvZPEi87HCFYxc5ndteiFJTxp6SVRO8O12Le37Iceri7iKhq5OnDRMM1JssQyb2MBhPn/havUlqoFMtcUVmyr50983TKA8cV8lIEiH5/rY6iufJLqKw53PrT725w08l0aNZPsHgyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708544518; c=relaxed/simple;
	bh=hd1J5dkAabTUxt5fufnQhMf7QryotHszZx321BkoNL8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=dlMjQIJnHMn0+tocjpNhbqzgPV/iP7ZbxbSwZWBGqN+qJ6SckLztbT5S+QkUI4nxZDm8spmcJl+Xuy96EH+3yXmF7JYGuwVWbYBCpL8owK+eO0WHK7lR2sfq6nvXFL3OY2GMQ6Ik4VC/X9xdTmqiRvCAPnAuFv8tBpROjxKftPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=I7eOy2jv; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="I7eOy2jv"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-5ee22efe5eeso102886287b3.3
        for <iommu@lists.linux.dev>; Wed, 21 Feb 2024 11:41:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708544516; x=1709149316; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=uHb4H3aBf7zVkxjSohmSP0JQMXLGrYpxjhF/b1cUoKA=;
        b=I7eOy2jvQVtyH83PRZ0RpgRROTmq2CLtMlr8ozyc35uexF2hzTDIhZLR35L2EfL4O4
         SbXygQ2EoSx947WvVjnKJKSJTNXzFqIYxdQ9lftw+Gjhj8IzFnpWg0mV5i95gARJPtLT
         /Rur/MyHd+tpEJoFsVUqDkWcnA24ZeFT8QmHi1BdmjmpSL3zteeR3DVjsxXYa0LHJU3O
         Iz5B+XlBaCbNaOMuEcvnJb7XRLnX1cqIA3mmCS1Qm2ZZ1ZwxCmV6Wm8iToyRt80ZdV/C
         ART37lAq61eIm4WiiraYy2CS6pW1KAv73Jr1CrFLzsE2VVaZn95gHcmMIdai9SF8RdT4
         uVjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708544516; x=1709149316;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uHb4H3aBf7zVkxjSohmSP0JQMXLGrYpxjhF/b1cUoKA=;
        b=JFm5k/cwkwcA73DwfYYYS7iEVGNjeqUjmdfxbwZKITj37+F8Rugm+Hqc5dpMqcu5D/
         xZqhU5ZaZET8sHj5OhQKQ8KN239aCYzgEUEcqvuHiM2XqwNZGW2GDcwNCwNNBohDn/r0
         MGqjfjRclFEQbMNOLxWdGTHkUh0CRHDOpCrGXylv7G/NNFARDHQ3RmuS8WA88j6Cv/dx
         Rr0AfUaNqkKWx1KyhxuRNtm/mRolat0kt08V9pwP4YsfDIqRSiCU10m6iM5yAzbS3Utu
         Bp4NUqfXQ9b3jZQNbN1zzdLhERhohy2OtuxLcuXVilBhxty2IK7VWRJ5UVyGLioakhR0
         jqvQ==
X-Forwarded-Encrypted: i=1; AJvYcCVKK0fdNJ79E8oi0gPo/87q1h5LvEIWkke02D0LiEfyb6swTThMv+iizBzZui+k2i7ysR+e/nZOJOM6gbN885OfoVCrTbs=
X-Gm-Message-State: AOJu0YxX4vne4h8QcU2GIk0QA3pS0yJXWTm3gyX8pu9Kl1sKR8ppRTXD
	bc7XYg9I1COBoNADDcrEm6ZezLUMUvoePjlstc+KADD9If4Q5ZtdSAtZb5qDqjDuI59DALml7RQ
	hMg==
X-Google-Smtp-Source: AGHT+IFiyKMub1eGZLzZF9NObSWfIJfU8Z6wUZOBIvD/PODcgJqUEzoNtVZWO2NPbtCUhIy8HmGJP9rxfPQ=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:953b:9a4e:1e10:3f07])
 (user=surenb job=sendgmr) by 2002:a0d:d5d7:0:b0:607:9bfd:d0bc with SMTP id
 x206-20020a0dd5d7000000b006079bfdd0bcmr3270706ywd.7.1708544515839; Wed, 21
 Feb 2024 11:41:55 -0800 (PST)
Date: Wed, 21 Feb 2024 11:40:40 -0800
In-Reply-To: <20240221194052.927623-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20240221194052.927623-1-surenb@google.com>
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
Message-ID: <20240221194052.927623-28-surenb@google.com>
Subject: [PATCH v4 27/36] mm: percpu: Add codetag reference into pcpuobj_ext
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

From: Kent Overstreet <kent.overstreet@linux.dev>

To store codetag for every per-cpu allocation, a codetag reference is
embedded into pcpuobj_ext when CONFIG_MEM_ALLOC_PROFILING=y. Hooks to
use the newly introduced codetag are added.

Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 mm/percpu-internal.h | 11 +++++++++--
 mm/percpu.c          | 26 ++++++++++++++++++++++++++
 2 files changed, 35 insertions(+), 2 deletions(-)

diff --git a/mm/percpu-internal.h b/mm/percpu-internal.h
index e62d582f4bf3..7e42f0ca3b7b 100644
--- a/mm/percpu-internal.h
+++ b/mm/percpu-internal.h
@@ -36,9 +36,12 @@ struct pcpuobj_ext {
 #ifdef CONFIG_MEMCG_KMEM
 	struct obj_cgroup	*cgroup;
 #endif
+#ifdef CONFIG_MEM_ALLOC_PROFILING
+	union codetag_ref	tag;
+#endif
 };
 
-#ifdef CONFIG_MEMCG_KMEM
+#if defined(CONFIG_MEMCG_KMEM) || defined(CONFIG_MEM_ALLOC_PROFILING)
 #define NEED_PCPUOBJ_EXT
 #endif
 
@@ -86,7 +89,11 @@ struct pcpu_chunk {
 
 static inline bool need_pcpuobj_ext(void)
 {
-	return !mem_cgroup_kmem_disabled();
+	if (IS_ENABLED(CONFIG_MEM_ALLOC_PROFILING))
+		return true;
+	if (!mem_cgroup_kmem_disabled())
+		return true;
+	return false;
 }
 
 extern spinlock_t pcpu_lock;
diff --git a/mm/percpu.c b/mm/percpu.c
index 2e5edaad9cc3..578531ea1f43 100644
--- a/mm/percpu.c
+++ b/mm/percpu.c
@@ -1699,6 +1699,32 @@ static void pcpu_memcg_free_hook(struct pcpu_chunk *chunk, int off, size_t size)
 }
 #endif /* CONFIG_MEMCG_KMEM */
 
+#ifdef CONFIG_MEM_ALLOC_PROFILING
+static void pcpu_alloc_tag_alloc_hook(struct pcpu_chunk *chunk, int off,
+				      size_t size)
+{
+	if (mem_alloc_profiling_enabled() && likely(chunk->obj_exts)) {
+		alloc_tag_add(&chunk->obj_exts[off >> PCPU_MIN_ALLOC_SHIFT].tag,
+			      current->alloc_tag, size);
+	}
+}
+
+static void pcpu_alloc_tag_free_hook(struct pcpu_chunk *chunk, int off, size_t size)
+{
+	if (mem_alloc_profiling_enabled() && likely(chunk->obj_exts))
+		alloc_tag_sub_noalloc(&chunk->obj_exts[off >> PCPU_MIN_ALLOC_SHIFT].tag, size);
+}
+#else
+static void pcpu_alloc_tag_alloc_hook(struct pcpu_chunk *chunk, int off,
+				      size_t size)
+{
+}
+
+static void pcpu_alloc_tag_free_hook(struct pcpu_chunk *chunk, int off, size_t size)
+{
+}
+#endif
+
 /**
  * pcpu_alloc - the percpu allocator
  * @size: size of area to allocate in bytes
-- 
2.44.0.rc0.258.g7320e95886-goog

