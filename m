Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1E835A7AB
	for <iommu@lists.linux.dev>; Mon, 12 Feb 2024 21:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707774033; cv=none; b=NdPYq9k6tUr86sn0rCnFs1F8shsd5d7mFohyLP290cVMNA9VC+cVGuau3Ydy4+g/3XccqFzUIyiXzSSc6PVV13gaDoKO+selLsq2zCA5ohT3nSbGwcWXVW3ETRItjXvnAjiq/FyRkW/oe/uPng972avATpwtkpsrqxEvXRLribU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707774033; c=relaxed/simple;
	bh=agT5b25ACG41VKpR8q87SrJ3Bcb+qFiIEtA30AzV538=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=JM4yjYLOzgTGERugZ9JoIUUrSC/DwV7clpsNrvr+9fcs6pXKLT2KFH0RdE0GQLjp3iijJgDL+NzPkXjOyuIpmCvLCPYmCr0sMjRUZ2AVGGoCG/3fpLpFztdYkGUNNBRyOzZZ2FemdtX0mwVL/47V8odiwq88bzokeyRNBXcojWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jHe1f9DY; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jHe1f9DY"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc74645bfa8so356739276.1
        for <iommu@lists.linux.dev>; Mon, 12 Feb 2024 13:40:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707774031; x=1708378831; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=X07z1RjJe29sLMh5N/vKSXU8uipRKYcH64glAbq+0r0=;
        b=jHe1f9DY1FQB1EgWXKP9Y9tIxn4198AKZ5dIBGkR3bUY88CX+hLVvC3K84KW5mnkNt
         gAWBqxQjF9i+dyaGvNryCD7bQOPgCVv95xjNYEdmo7mzi3E5FAyub+1CjOl5JO6YfsVJ
         iLuT1SFaNHDYihrgvRdEjxLaj3O9ayam4DM/1ANP+RugQ1FpKJ9L6F6+05nA/tgJoKUd
         taQWjGE70kTIcOd+kVGiKDplUEgd7r60BBCYv3tldfJ5waISlr/zD601JUK624GN+mFu
         7z9vfRWjt1QipDbOYA+tY+wHBFkQ/BbFwoq/4HIqAqiiY5i/YR2vPn/Ez/PUHJvC9OO6
         sYCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707774031; x=1708378831;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X07z1RjJe29sLMh5N/vKSXU8uipRKYcH64glAbq+0r0=;
        b=IK+aekENbe4i4sjY7JWYwttLsiSwTdTlrmY6IDkr3yKL/epEmCYdq77fxya6a8BrTo
         +rkx7IMPP1f9iVfhkOYRRhVQojHoD81urc/td5dzpNSMYe+YsN6nDct6HDlHsoKCPbmn
         9IWV5IwvwAXaiJUmu6gRIvoqFON8XP1u2uds9VY8DBXW0N791HsXrw0nlUSEKzQBCGHc
         QIsd7QWc42PIUIdwv6JjpF+0X7f7iun6TTW6Bn4qbfdjfpHAPa1WZT9Q0AJI7+PiH3BZ
         tsMX/As/oHkTpZyf/5k2Fi5RmBRpzi4ZilG81wWYgNeAdhFKHG0OZ4J1udfIQHeR6+UT
         IjmQ==
X-Forwarded-Encrypted: i=1; AJvYcCUAnNmsv9tF2mAeKzby6YDlNoqWcXte2YMkoMCJdtoHYMyJPPWRRXGMbeb1DJYvLG1+BxrnVmzPt5go2xKoaB6EdVxfcs0=
X-Gm-Message-State: AOJu0YyPMji9zeYvjvTdokBZdxnf7e3mqtAdYFBK/N/4wvftiZyNzqeH
	mbgBnuemk+FzCxNcWy/sRQg9fFx80HrRC+NnM07X/o53ITtTBqPO92ZpeCiR5qXQKbBxM+5Z7li
	O+Q==
X-Google-Smtp-Source: AGHT+IE+9v5iTSehfGXvFLsyFgeYeTOkKmnm1/9Fi71HMokK15QIurDQiuu9x1J7ZwyZ5mBIdOmgWIrIEcg=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:b848:2b3f:be49:9cbc])
 (user=surenb job=sendgmr) by 2002:a05:6902:709:b0:dc7:59d9:7b46 with SMTP id
 k9-20020a056902070900b00dc759d97b46mr291099ybt.3.1707774030642; Mon, 12 Feb
 2024 13:40:30 -0800 (PST)
Date: Mon, 12 Feb 2024 13:39:13 -0800
In-Reply-To: <20240212213922.783301-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20240212213922.783301-1-surenb@google.com>
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
Message-ID: <20240212213922.783301-28-surenb@google.com>
Subject: [PATCH v3 27/35] mm: percpu: Add codetag reference into pcpuobj_ext
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
2.43.0.687.g38aa6559b0-goog

