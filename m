Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83D7286641
	for <iommu@lists.linux.dev>; Wed, 21 Feb 2024 19:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708544480; cv=none; b=fnCOxZw6L4S9p7RrgX6DJ5F0r6wKjISPFztOTUi+ICfLCTbupT2JtJedg+jr8VI6iKGIiMwnsbFzC64nloVqcqSdt3I6MRlvsGnnxfoefILOz21qH//zQhzxEAJkORIcQOjEdIDFGfjlJK9BBd35WOrND2WLoAASCJHa92ZJG9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708544480; c=relaxed/simple;
	bh=lJWs+8NUGy1XLba1Ji9bxkypH1bXGGk7YR2c+Vq5GXQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=nPNupEV++AE5GR6mDfKiz5bsiRzYI2JaLuz/yZx4ZOYKV0C7UjURI1oDtPOQmKT3zzfG8Mn159ix7HjZ4o4cnED5Y5SwtldziS8HrAyYAo25Gtb1vq4ZKKMDVP0g6ehsesXx8eO4t+APYi2ooDHJ6FHul1TpAjJey3EK78255G0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lj7NARRl; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lj7NARRl"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc6b26eef6cso10349172276.3
        for <iommu@lists.linux.dev>; Wed, 21 Feb 2024 11:41:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708544476; x=1709149276; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=zEkUZGmdT8FEHHQk8lZ544d0po9Jm+ENmRP2MkpUgMM=;
        b=lj7NARRlCKt+hPg/7Y9ZVy0veUSC7R1nNzYDxOfBQflkICPkSVtUsJJF/IMqA54PYw
         GwjPGeTX5Qp2upPIugrtCeL65yvRI9uwiTbu27YcICAUDH1slwBvbCiOsGKLQpnw7Imp
         Fsh7hwAkoU7FZFzyvfLBrNUIf+MXrLJxCOnVXe38qD1OqYluvWVtfiY6QDODAyMcF3rq
         DuPFqRl5uptAVUKwkpySnepGg+lVJgOQWLYvofTQ9K+qWwo9UOKxrhu+fnZevqjqPT6r
         Rxsqy+CdQbeJiKSW7787Y7tS2Qu72VI0z/Ea0gC5/Y9xD70+8+mB7bxR5Z/2Gg69Ew06
         +eYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708544476; x=1709149276;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zEkUZGmdT8FEHHQk8lZ544d0po9Jm+ENmRP2MkpUgMM=;
        b=oiho0o5cRj3Wxipu04cJU0ygwzVsHlEFPMfffwWsm4TR4gBcN/BF03rmEwHlEHA/lj
         7kWApzBA3Nr7ts0oVabHtbREsBKYBhtunNH45RNSiGgEagx+68FvudIWcp0hXzGZYTlK
         kR9rJP/PP/a3NMZPLjfr9wq/Ae0fbfpVrAs2DL8hXwy+GyhgLtVGEK/9P3fumcDOQ3yq
         ftURgpbjqlwnMe56hdrRyOKJthKcXitBCrqy1z4k4KgtQZeS92Zpns815EHKdFe2ipE/
         VRrN8qtugjhTFpRPUP0v6d6xVnStWLk5f2eaUGodEYGooPOx0v9QJeEQtsNroiM80LOE
         NL1g==
X-Forwarded-Encrypted: i=1; AJvYcCXPTTt+11AtQgzedV7TmQlVK2gf9BNL9v/tw7+PjHnGg+R/4bc3Vg70G1jYsn0UrthjEnkQJn4s2ORMGyRCwyVx6Gm+lQ0=
X-Gm-Message-State: AOJu0YzGDwg0TEJ4KDyAJ82BrO3NrjVB0C/rAxdg0e3gR/CCw4y/bqAl
	U1r3fjsoCr7rXggOIQySaNCXNhDm2HsBlpaMDjarwhksScoQ/p3RmiaICTf6rvXHIr5oQORuJ2h
	Mbg==
X-Google-Smtp-Source: AGHT+IGFqZQMKrIKQYeCMZ0dyCYxCh2jZRWMkTdBUYYdfqnWgxWQSfzS1xjoTphhPvwCFL+Ef45OR+v8sww=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:953b:9a4e:1e10:3f07])
 (user=surenb job=sendgmr) by 2002:a25:26cf:0:b0:dcc:41ad:fb3b with SMTP id
 m198-20020a2526cf000000b00dcc41adfb3bmr6923ybm.10.1708544476345; Wed, 21 Feb
 2024 11:41:16 -0800 (PST)
Date: Wed, 21 Feb 2024 11:40:22 -0800
In-Reply-To: <20240221194052.927623-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20240221194052.927623-1-surenb@google.com>
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
Message-ID: <20240221194052.927623-10-surenb@google.com>
Subject: [PATCH v4 09/36] mm/slab: introduce SLAB_NO_OBJ_EXT to avoid obj_ext creation
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

Slab extension objects can't be allocated before slab infrastructure is
initialized. Some caches, like kmem_cache and kmem_cache_node, are created
before slab infrastructure is initialized. Objects from these caches can't
have extension objects. Introduce SLAB_NO_OBJ_EXT slab flag to mark these
caches and avoid creating extensions for objects allocated from these
slabs.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
---
 include/linux/slab.h | 6 ++++++
 mm/slub.c            | 5 +++--
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/include/linux/slab.h b/include/linux/slab.h
index b5f5ee8308d0..58794043ab5b 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -28,6 +28,12 @@
  */
 /* DEBUG: Perform (expensive) checks on alloc/free */
 #define SLAB_CONSISTENCY_CHECKS	((slab_flags_t __force)0x00000100U)
+/* Slab created using create_boot_cache */
+#ifdef CONFIG_SLAB_OBJ_EXT
+#define SLAB_NO_OBJ_EXT		((slab_flags_t __force)0x00000200U)
+#else
+#define SLAB_NO_OBJ_EXT		0
+#endif
 /* DEBUG: Red zone objs in a cache */
 #define SLAB_RED_ZONE		((slab_flags_t __force)0x00000400U)
 /* DEBUG: Poison objects */
diff --git a/mm/slub.c b/mm/slub.c
index ca803b2949fc..5dc7beda6c0d 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -5697,7 +5697,8 @@ void __init kmem_cache_init(void)
 		node_set(node, slab_nodes);
 
 	create_boot_cache(kmem_cache_node, "kmem_cache_node",
-		sizeof(struct kmem_cache_node), SLAB_HWCACHE_ALIGN, 0, 0);
+			sizeof(struct kmem_cache_node),
+			SLAB_HWCACHE_ALIGN | SLAB_NO_OBJ_EXT, 0, 0);
 
 	hotplug_memory_notifier(slab_memory_callback, SLAB_CALLBACK_PRI);
 
@@ -5707,7 +5708,7 @@ void __init kmem_cache_init(void)
 	create_boot_cache(kmem_cache, "kmem_cache",
 			offsetof(struct kmem_cache, node) +
 				nr_node_ids * sizeof(struct kmem_cache_node *),
-		       SLAB_HWCACHE_ALIGN, 0, 0);
+			SLAB_HWCACHE_ALIGN | SLAB_NO_OBJ_EXT, 0, 0);
 
 	kmem_cache = bootstrap(&boot_kmem_cache);
 	kmem_cache_node = bootstrap(&boot_kmem_cache_node);
-- 
2.44.0.rc0.258.g7320e95886-goog

