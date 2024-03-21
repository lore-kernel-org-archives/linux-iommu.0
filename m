Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5A57146002
	for <iommu@lists.linux.dev>; Thu, 21 Mar 2024 16:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711039112; cv=none; b=POK+JsT1YrtZV3DD9M1fXhHxXwHd2s/tGLaZGm+UZbbrIoU8b/hDp5HwL09UnxAwDcVIUgRqaAzzAH+169VXJ1EHuyIysM/A6CkKMbe50+IuDvnzWrdqQW4oiu5H+mwcvo8c5iNL/FtSRYl+Vw7AGf9+Xc7hSvGOniUMbDdEUfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711039112; c=relaxed/simple;
	bh=BFhSOgRWZw49w/nNVhmrLSuZba9C6QEOmpxWTod6ib8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=U0jRJl/JhBDTHRnK5Y4qPmdjNU9vkEg2aFoNe0KWJJsPTVarYdNiryny62AesqsHBXcom/86SzWMP9iWt8/lrvlT+fmu5+olKubUlDrNY76aqssPSYb+ucbibBRx/Oa/E1YlOHKg0uuUpQSpE4/2Tvuk8swXF0JpPYCokE1WRYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=D8fox4mf; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="D8fox4mf"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dced704f17cso1820841276.1
        for <iommu@lists.linux.dev>; Thu, 21 Mar 2024 09:38:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711039110; x=1711643910; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=zMtv/wiplx2DxF9seTFx3IcU+R2+PFSDAr6m0+A1ntI=;
        b=D8fox4mfiP2OmupsxtsYofJrNyOfi+KinT3cwoAEFw1CPw3igZ8MVlNPaVHba3p7tR
         AN1DWfBg5GbGkGF6DznRd0noo+w6krtEU+fwLpjs0YWop0HHxq/IFMXuS+kbOck/8G9g
         ROgK9+cYW7x9Mwgm1fzIkx7fcXq09DbPV+7vmJBqogyIWaRSft/2hzK7m92vezpylsmO
         lZiHOzICShChVauA5cQcqI1TOIzs/0DkvVP12IwqE0VtSR96u1zi8sgmmtha0l2Cf/Df
         zibFwayQ2mIZ2sawI1bTaLax7BObU51v0iL5bewWKh55VUTwtuSubEBUlRBUfKZnMENu
         d+7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711039110; x=1711643910;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zMtv/wiplx2DxF9seTFx3IcU+R2+PFSDAr6m0+A1ntI=;
        b=mZLVWP6fmKZkKMtYIH35xemuGoUVEfShuF+C72bW1prEo0Vevb7018uaKuX5hbXHGm
         4cwBeeoPjn3ctT/3VfI3q3p742oXXv8nSUCuSht2e1ZP1tFYKIH7QzEHHB31eB+WCpHf
         FlzmyvstbXNAEnchE+Z4zmcAAdUgU7z51ZVbAKTbtBzBVORGwT94CE1ggEt+00iVjkgW
         /E+vKZ4hYTLfWLfPcTl9fIuN3b0uaKzG3c2XA15TB7x5pXKyh3tW9yNpJJI9RvgcIEVC
         Sf6USpcwRghTg/O2FI53xNcQzjZ0He7xr0QtKNG5C8IYt/7z6tBvN7bk208ke6PHipHQ
         VWrg==
X-Forwarded-Encrypted: i=1; AJvYcCVyDqNRk9bm+MUrdGnXuIpADLodP1Myg/XkX92gk8CEEpA86QWh6r2s3TfBv1XE8XXC5jb+G52SOERHI/RIVferGWMraL4=
X-Gm-Message-State: AOJu0Yw1EviltCmTb6pc9YLUGZPA7mgvcH4BMbrotHIYk6a/WcP1hWY5
	Bk/TeJxiV+BYbU2uH74vRY+W1ek3VDeREDm4mI/7rTYZaaG57FZEo9NGH5bb+kLkQW9gMalkEIt
	cDw==
X-Google-Smtp-Source: AGHT+IHubMkzttSDdMzbBJ1mYbEtkJMz1sywK2vk2BxZuZG66cHkzs6E2Eyy/Ht6uVFkEMl2Xl2C/1q/RI8=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:a489:6433:be5d:e639])
 (user=surenb job=sendgmr) by 2002:a05:6902:240e:b0:dc2:5273:53f9 with SMTP id
 dr14-20020a056902240e00b00dc2527353f9mr1211362ybb.1.1711039110014; Thu, 21
 Mar 2024 09:38:30 -0700 (PDT)
Date: Thu, 21 Mar 2024 09:36:59 -0700
In-Reply-To: <20240321163705.3067592-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20240321163705.3067592-1-surenb@google.com>
X-Mailer: git-send-email 2.44.0.291.gc1ea87d7ee-goog
Message-ID: <20240321163705.3067592-38-surenb@google.com>
Subject: [PATCH v6 37/37] memprofiling: Documentation
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

Provide documentation for memory allocation profiling.

Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 Documentation/mm/allocation-profiling.rst | 100 ++++++++++++++++++++++
 Documentation/mm/index.rst                |   1 +
 2 files changed, 101 insertions(+)
 create mode 100644 Documentation/mm/allocation-profiling.rst

diff --git a/Documentation/mm/allocation-profiling.rst b/Documentation/mm/allocation-profiling.rst
new file mode 100644
index 000000000000..d3b733b41ae6
--- /dev/null
+++ b/Documentation/mm/allocation-profiling.rst
@@ -0,0 +1,100 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+===========================
+MEMORY ALLOCATION PROFILING
+===========================
+
+Low overhead (suitable for production) accounting of all memory allocations,
+tracked by file and line number.
+
+Usage:
+kconfig options:
+- CONFIG_MEM_ALLOC_PROFILING
+
+- CONFIG_MEM_ALLOC_PROFILING_ENABLED_BY_DEFAULT
+
+- CONFIG_MEM_ALLOC_PROFILING_DEBUG
+  adds warnings for allocations that weren't accounted because of a
+  missing annotation
+
+Boot parameter:
+  sysctl.vm.mem_profiling=0|1|never
+
+  When set to "never", memory allocation profiling overhead is minimized and it
+  cannot be enabled at runtime (sysctl becomes read-only).
+  When CONFIG_MEM_ALLOC_PROFILING_ENABLED_BY_DEFAULT=y, default value is "1".
+  When CONFIG_MEM_ALLOC_PROFILING_ENABLED_BY_DEFAULT=n, default value is "never".
+
+sysctl:
+  /proc/sys/vm/mem_profiling
+
+Runtime info:
+  /proc/allocinfo
+
+Example output::
+
+  root@moria-kvm:~# sort -g /proc/allocinfo|tail|numfmt --to=iec
+        2.8M    22648 fs/kernfs/dir.c:615 func:__kernfs_new_node
+        3.8M      953 mm/memory.c:4214 func:alloc_anon_folio
+        4.0M     1010 drivers/staging/ctagmod/ctagmod.c:20 [ctagmod] func:ctagmod_start
+        4.1M        4 net/netfilter/nf_conntrack_core.c:2567 func:nf_ct_alloc_hashtable
+        6.0M     1532 mm/filemap.c:1919 func:__filemap_get_folio
+        8.8M     2785 kernel/fork.c:307 func:alloc_thread_stack_node
+         13M      234 block/blk-mq.c:3421 func:blk_mq_alloc_rqs
+         14M     3520 mm/mm_init.c:2530 func:alloc_large_system_hash
+         15M     3656 mm/readahead.c:247 func:page_cache_ra_unbounded
+         55M     4887 mm/slub.c:2259 func:alloc_slab_page
+        122M    31168 mm/page_ext.c:270 func:alloc_page_ext
+
+===================
+Theory of operation
+===================
+
+Memory allocation profiling builds off of code tagging, which is a library for
+declaring static structs (that typically describe a file and line number in
+some way, hence code tagging) and then finding and operating on them at runtime,
+- i.e. iterating over them to print them in debugfs/procfs.
+
+To add accounting for an allocation call, we replace it with a macro
+invocation, alloc_hooks(), that
+- declares a code tag
+- stashes a pointer to it in task_struct
+- calls the real allocation function
+- and finally, restores the task_struct alloc tag pointer to its previous value.
+
+This allows for alloc_hooks() calls to be nested, with the most recent one
+taking effect. This is important for allocations internal to the mm/ code that
+do not properly belong to the outer allocation context and should be counted
+separately: for example, slab object extension vectors, or when the slab
+allocates pages from the page allocator.
+
+Thus, proper usage requires determining which function in an allocation call
+stack should be tagged. There are many helper functions that essentially wrap
+e.g. kmalloc() and do a little more work, then are called in multiple places;
+we'll generally want the accounting to happen in the callers of these helpers,
+not in the helpers themselves.
+
+To fix up a given helper, for example foo(), do the following:
+- switch its allocation call to the _noprof() version, e.g. kmalloc_noprof()
+
+- rename it to foo_noprof()
+
+- define a macro version of foo() like so:
+
+  #define foo(...) alloc_hooks(foo_noprof(__VA_ARGS__))
+
+It's also possible to stash a pointer to an alloc tag in your own data structures.
+
+Do this when you're implementing a generic data structure that does allocations
+"on behalf of" some other code - for example, the rhashtable code. This way,
+instead of seeing a large line in /proc/allocinfo for rhashtable.c, we can
+break it out by rhashtable type.
+
+To do so:
+- Hook your data structure's init function, like any other allocation function.
+
+- Within your init function, use the convenience macro alloc_tag_record() to
+  record alloc tag in your data structure.
+
+- Then, use the following form for your allocations:
+  alloc_hooks_tag(ht->your_saved_tag, kmalloc_noprof(...))
diff --git a/Documentation/mm/index.rst b/Documentation/mm/index.rst
index 31d2ac306438..48b9b559ca7b 100644
--- a/Documentation/mm/index.rst
+++ b/Documentation/mm/index.rst
@@ -26,6 +26,7 @@ see the :doc:`admin guide <../admin-guide/mm/index>`.
    page_cache
    shmfs
    oom
+   allocation-profiling
 
 Legacy Documentation
 ====================
-- 
2.44.0.291.gc1ea87d7ee-goog

