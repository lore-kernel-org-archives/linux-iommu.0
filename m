Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 197E814EA29
	for <iommu@lists.linux.dev>; Wed,  6 Mar 2024 18:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709749548; cv=none; b=VpyXsA5OlCyoYdBwLkPyO1PntGqruc0c6tv0ki7nOuYS8ft22JH4o5BPrltsjpeycEJ+pIm3DjMaecIX/00fUaoVIRAzWkXR6KvAQEVi4AOLcQADrCcAX2OtWvLMt7clklHAsv3dHdKw6PX6cogsWltMea37+bhhvyXRyzia2JM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709749548; c=relaxed/simple;
	bh=DYhMOOsPSI1brVv3PkUP6bsEduZ0IpFXTziSOU03ows=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=RAU0mVcHWRcIIyLCMQq7Vzi8AflZV99MkqRDDhzJLDMtxdd8tWFqvlAPG6trxWugg6cwA+An7972GAOB4/3/1kCxwgDjKyI8kxT6/cj+gYECzQTmKzLM/eYon33HrMxLXdoP707vZP3pQtMLdcOI1ONWhK2feQHIgqjkXb/UXsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FoMJEHTa; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FoMJEHTa"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6096c745c33so158837b3.3
        for <iommu@lists.linux.dev>; Wed, 06 Mar 2024 10:25:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709749545; x=1710354345; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=uTM4daMpjhNnHNsVheTGd2gBho3MSeHG2jrz4iVybwI=;
        b=FoMJEHTaYrwqgSelt5zm5HxtQUmD0LXalpLMheSQgaGiFxm2YuoGkKdm3cWyzL4tEE
         A/DcjnND92KrobPNDTI7gur6aalJ26Xo+cqQH87FXs9eg5018kpk8oPMLlba8pGZMts9
         3MoNu8mVZSKsinw0D+/6YNpjmYwK95eKn6UWbDa/UUZg2bCwZYjx7++zxLvYO0vhczH/
         YO/b+AVAjSEAyl2Dz50mC4wAv3VUtDuIHYePQl92c3ejieT8jFtM3N7UwcN+thwftUeT
         3ljrBfITa7I6xefOS3ow9+WSumPn0BNpLlLs1Z1ZIz9ZSNYamahX+pL5IY6INJPeXXWJ
         GtXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709749545; x=1710354345;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uTM4daMpjhNnHNsVheTGd2gBho3MSeHG2jrz4iVybwI=;
        b=suh0s7NW49ub4OdWKYfOx6NhSPRPE20XQiYPEbsQD1Kt7GwCVns9XB/GMWEN51gusU
         LEP7VE837uX3DYzMJ9SNlGZdamjn+zvVTWvyl8ounYIR/uAPKFPf0LmOV5javidGiIaa
         A5LPGzlOPyHeKeoIuoEBf7iGOXsOsATTy9CMku+GxQNHt1CjTT90979txv3ynb2iSkER
         sNXv2vH8HvPJq1EiU/dR18wJMJBGCc1PAcSfxe/thJxcYHdxTQvX62QJCvWh7xUDZyVh
         cQKMrRAAo+fDNKjtZuCQDwfloDYnb934kyXSjQiZeyHJt8XOLUknEEx4ve9mmMyNiX2I
         wbYA==
X-Forwarded-Encrypted: i=1; AJvYcCU6BCxIzgIKwJit0OOX3Gg9/kemnFBW90W7qoHVg5hYZVNp9z4JluQy4EoRqpBKEyg4JPkumwpU43Fde/C48yTZVBWOJMI=
X-Gm-Message-State: AOJu0YyZLGbnXhf6pU1WmmWLRs24/4G/3/OcvXPXxXLkVv8ViNeqiu69
	6gkLShvGMJSFNrhE68GFoYf0EggNUsIVA2Ihlzx8fdXBSewCkEHx9WDqbQ7udVmDx42qTHffO4B
	brw==
X-Google-Smtp-Source: AGHT+IEnKzMil/vcPtNXvwckm3OECYjnTJYXETMu8tDMF6y1iGrklNs9lczJgJmwr4/pSL8XxNI2NQuejS8=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:85f0:e3db:db05:85e2])
 (user=surenb job=sendgmr) by 2002:a05:690c:e18:b0:609:247a:bdc5 with SMTP id
 cp24-20020a05690c0e1800b00609247abdc5mr4410842ywb.4.1709749545152; Wed, 06
 Mar 2024 10:25:45 -0800 (PST)
Date: Wed,  6 Mar 2024 10:24:26 -0800
In-Reply-To: <20240306182440.2003814-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20240306182440.2003814-1-surenb@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Message-ID: <20240306182440.2003814-29-surenb@google.com>
Subject: [PATCH v5 28/37] mm: percpu: Add codetag reference into pcpuobj_ext
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
index 2e5edaad9cc3..90e9e4004ac9 100644
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
+		alloc_tag_sub(&chunk->obj_exts[off >> PCPU_MIN_ALLOC_SHIFT].tag, size);
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
2.44.0.278.ge034bb2e1d-goog

