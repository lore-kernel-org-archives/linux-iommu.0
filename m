Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C9315646E
	for <iommu@lists.linux.dev>; Mon, 12 Feb 2024 21:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707774019; cv=none; b=ULSCQGdNfPa7BMGitaZcfpxkPCh5Z2tV+LJE2pmdqQvAer3iiqmah40v9PpMZD7K/o2KIw0qDtXHrxlTyRP5RL1bH4ubP9kKCkP5+fhSA9MuJv6UgPvS5cdo5dD3STR/4gJeTPONYvHQ6kuVbKovd846dHn1fhHHEgXAE6qPrgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707774019; c=relaxed/simple;
	bh=/ObVYElsMTOqZ264N892FMXju4ko1jf53Il+HTJwMLI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=bf5sw0KbHwkRjuBtOILfgYP8oVd7+smwBePsOPPiR4Xrw2WKcIHhUlKUuUd3qbeJ2fo4oNwaqlQcqnGHeTXTn1qtg6Wxw/kuUGrwNlRILvheqc4bAjYBulu9sr29w+gkpuvdjI4M7/ZHAKEOmG5FsQp4lwbf8QM9tmyRu2htl3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=J/o48wyh; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="J/o48wyh"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc64f63d768so6842918276.2
        for <iommu@lists.linux.dev>; Mon, 12 Feb 2024 13:40:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707774016; x=1708378816; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=xFf/g8Eh9xc1yf0azF3fMp/AEmHqfeMm/yqsFpU3vIo=;
        b=J/o48wyhzm8bPjBboJbLgygV8amPVZ5bpeGjK7DELFtJbuIWaTGlQcJ/TdgE45FSst
         Yi+4oVtUlXe9z5+nx6QkGYJYVM12TxSBcTskBjMg078GSRfS//pOT9qvZLj4AuI9Rg3D
         taFU5HyZgYtWABfT7vBnVNre1okKFxnftCw2o/sAEfnhB+7zuHRDfOWnhFEle6JuAF+x
         mQawkhzDmDRKmkMel6nAMGK+fYAsigQKQVtTxFxWOoZCENAM8xQY3dhPmEGqiReEoU6+
         GyjgIMEmJrgnezzKOCsfZIWKPpQyKSdp6EQHvXNjBLkvE7vc6c7vNbLSXFJFmZvGStqt
         7sTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707774016; x=1708378816;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xFf/g8Eh9xc1yf0azF3fMp/AEmHqfeMm/yqsFpU3vIo=;
        b=TN/EI8C6+4y3sm99LJIMl2prs4PMyRvDOLmUPLDeT29+PZ7O+xLNHCAffTd7wKl5xP
         mnopeoc+u6RSLW/xQQhss5VdsBJhREhkblMqOGuiQlwpsy8JsO33Oc0NIQnlvE7+DtxS
         0AdXDX6FPkCuGOfwHygI/zdqiO0wZcFS39nA7gZI/Lt2aBRmj3IZco8uDAa+vYhL7M45
         aFPN1Hd044cLSVTAH7J1L5z64fQ7imePJeSYOZstl+30omXsgz6ZwJEr6EsPPLiXlc40
         t1WgWMytF3Sn9L53bf8xhtJId2G77g5cE5m7cqKXPS3YNAexUnnZzg9QMYLqW0SyvhW1
         jbaQ==
X-Forwarded-Encrypted: i=1; AJvYcCVhzJdnlFB24H5u40/A851zvhDvvr4e3JEfvr9GzuPuS9cNLryjUkuiGnLQBYbyAj7ArxK9a+r/VzvoeVJM/agEigrwImQ=
X-Gm-Message-State: AOJu0YzwOUUdw7ODwZYUZ2m4rRkksRYVL0gJ87PqJfE90EOJsjkVWIZx
	QXmSDv18iZK+FFrK+IVT7NZOKIUd+umxZIl3+CX6IykstbXydBjjQNamxkov31TQC3ZUEPDQ1mZ
	tqw==
X-Google-Smtp-Source: AGHT+IEjOAHzMTDk3G6Mkq9BQfM87/zY/tGgKD9M86mlp2G5yR63uKFbjyK/9+Jhrb/BiK/AnGAds8f8uig=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:b848:2b3f:be49:9cbc])
 (user=surenb job=sendgmr) by 2002:a25:8391:0:b0:dc2:1cd6:346e with SMTP id
 t17-20020a258391000000b00dc21cd6346emr2029085ybk.8.1707774016324; Mon, 12 Feb
 2024 13:40:16 -0800 (PST)
Date: Mon, 12 Feb 2024 13:39:06 -0800
In-Reply-To: <20240212213922.783301-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20240212213922.783301-1-surenb@google.com>
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
Message-ID: <20240212213922.783301-21-surenb@google.com>
Subject: [PATCH v3 20/35] lib: add codetag reference into slabobj_ext
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

To store code tag for every slab object, a codetag reference is embedded
into slabobj_ext when CONFIG_MEM_ALLOC_PROFILING=y.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
Co-developed-by: Kent Overstreet <kent.overstreet@linux.dev>
Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
---
 include/linux/memcontrol.h | 5 +++++
 lib/Kconfig.debug          | 1 +
 mm/slab.h                  | 4 ++++
 3 files changed, 10 insertions(+)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index f3584e98b640..2b010316016c 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -1653,7 +1653,12 @@ unsigned long mem_cgroup_soft_limit_reclaim(pg_data_t *pgdat, int order,
  * if MEMCG_DATA_OBJEXTS is set.
  */
 struct slabobj_ext {
+#ifdef CONFIG_MEMCG_KMEM
 	struct obj_cgroup *objcg;
+#endif
+#ifdef CONFIG_MEM_ALLOC_PROFILING
+	union codetag_ref ref;
+#endif
 } __aligned(8);
 
 static inline void __inc_lruvec_kmem_state(void *p, enum node_stat_item idx)
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 7bbdb0ddb011..9ecfcdb54417 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -979,6 +979,7 @@ config MEM_ALLOC_PROFILING
 	depends on !DEBUG_FORCE_WEAK_PER_CPU
 	select CODE_TAGGING
 	select PAGE_EXTENSION
+	select SLAB_OBJ_EXT
 	help
 	  Track allocation source code and record total allocation size
 	  initiated at that code location. The mechanism can be used to track
diff --git a/mm/slab.h b/mm/slab.h
index 77cf7474fe46..224a4b2305fb 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -569,6 +569,10 @@ int alloc_slab_obj_exts(struct slab *slab, struct kmem_cache *s,
 
 static inline bool need_slab_obj_ext(void)
 {
+#ifdef CONFIG_MEM_ALLOC_PROFILING
+	if (mem_alloc_profiling_enabled())
+		return true;
+#endif
 	/*
 	 * CONFIG_MEMCG_KMEM creates vector of obj_cgroup objects conditionally
 	 * inside memcg_slab_post_alloc_hook. No other users for now.
-- 
2.43.0.687.g38aa6559b0-goog

