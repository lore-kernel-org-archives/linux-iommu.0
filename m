Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26B9312AAE4
	for <iommu@lists.linux.dev>; Wed, 21 Feb 2024 19:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708544477; cv=none; b=vDsrvIY7fTrlilqKvoqt7vT9DePcCeOKoBH8+lHwfuVwniXj6wKuM17U4YkVQueeGVhU5ZcDuWZht5/+J1rvG3YajxhheXhKDGVVAN3np6sxNESIXERcQ4dejO7spqZRv/bDDZ+lgi1Z4jooEH3nW+tEPlMH13LKZQzWwNhCciU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708544477; c=relaxed/simple;
	bh=m5EGKOdquvmbILeFjjFHSeqjG9nrbDblZ38R+K7TUkQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=oriLuRXqcdvdTy/ORXO2gfsGP4k/z0Db3pl2e7mMH2cyAZKAX8ctJh2WWyegqYs7JqKX0i4VKqU/mFFRPnR3kpfGvNcRNryarCX1Yjpfz5I2A7kJXQHa7StHaVetg2l+IveVZXth8vLrHwMBbJk26VZCD7QptBS8qe2ybre47kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=irvAwcDH; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="irvAwcDH"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6088fa18619so9932647b3.2
        for <iommu@lists.linux.dev>; Wed, 21 Feb 2024 11:41:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708544474; x=1709149274; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=DcVDeB20sah+c6m+q7qbj/Bohzcv0RbxXXpsl4x4Og4=;
        b=irvAwcDHRd/tACo5zSMs2UzrRKvp/jT2oU9iHio5zIe+0uheHohjJK2mmpwn/+ewvo
         nPsOdYe3t8MK711AT6wSjHmoFbJrMkgJsNpUnj4UDb5sQFpbONo3f/zjdJXqcdCwAxjd
         jQrgDe0Oziirftp9q7lVIdEYZ8FSjZDNT0CefexzkdkHr7YGflVWTEIGxO7Nc0VE75ZD
         7H6tkH5bY9a1dxcI+gVHsfgUEVSDqPZq1nFSlENAQ4OJIyNbWA957W24av8oNW8ygZpD
         dQFTpH0+2YIbHACVi1UxDc8Q4NsbOI2feYuXSXyU1/A9DYXLb60X0tVqxd6EuKFN1z2G
         QnTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708544474; x=1709149274;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DcVDeB20sah+c6m+q7qbj/Bohzcv0RbxXXpsl4x4Og4=;
        b=vpn8YFI/Z9NDW+zsKoHrmyikU/7mJqYRiWC3YagujdCblhR32BI351rUiy3H4HnScM
         4i768KW9JtLC9SQBNYP+LqTMGpeGzKYhG8HQb/Nh+9H06eJkHBo135W054/qnk7/Rayx
         2nyD2CDZKBUeZFCvJO5wjHwHr4HBa4u2B8B0SMGD8zlGS8O79LWJiBLqTks+Ao0s2PUV
         3Es7zs8x7yrWKZ1rdq0ADOPZWsF7Av9fzBj2G9J/+7OVelNt7u1uBolcthX+1mfW9ecX
         rWybaVOL2r+plrNDNttAkZjTgKNOXO63iQoh7HfzGnT/4hAqq9c1jh5fHmW6USJky5t4
         b2/Q==
X-Forwarded-Encrypted: i=1; AJvYcCVcPYVv7DzxSwtALPiF7RWzsT7wKSzECeTU8o/Zuz3mE0qFmei9uzjTZsnBj8JOHzXCAxoqedMsUsq1ifv1/e2fEjJkT6U=
X-Gm-Message-State: AOJu0Yy130tZ7pNHCI3J3KwbtLhwQiOIZQ/+eMVCwvNRzDNd4SYuutl9
	p8QXmwaJY1A3OGAn0UqwgvU0PlC37XYk+0gJOzkkVqZ0k7BEVLHboY4JG8sKpU5TjLDI8ADG/9x
	0dQ==
X-Google-Smtp-Source: AGHT+IH75M2lZrHB2S9wjqCstmCY896frmoFhg/GjACV0w0wTBslVAISl72HA0I1QmkMPlsLusmP2hmQVrQ=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:953b:9a4e:1e10:3f07])
 (user=surenb job=sendgmr) by 2002:a81:4ecd:0:b0:608:9561:fdbe with SMTP id
 c196-20020a814ecd000000b006089561fdbemr96126ywb.2.1708544474186; Wed, 21 Feb
 2024 11:41:14 -0800 (PST)
Date: Wed, 21 Feb 2024 11:40:21 -0800
In-Reply-To: <20240221194052.927623-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20240221194052.927623-1-surenb@google.com>
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
Message-ID: <20240221194052.927623-9-surenb@google.com>
Subject: [PATCH v4 08/36] mm: introduce __GFP_NO_OBJ_EXT flag to selectively
 prevent slabobj_ext creation
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

Introduce __GFP_NO_OBJ_EXT flag in order to prevent recursive allocations
when allocating slabobj_ext on a slab.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
---
 include/linux/gfp_types.h | 11 +++++++++++
 mm/slub.c                 |  2 ++
 2 files changed, 13 insertions(+)

diff --git a/include/linux/gfp_types.h b/include/linux/gfp_types.h
index 868c8fb1bbc1..e36e168d8cfd 100644
--- a/include/linux/gfp_types.h
+++ b/include/linux/gfp_types.h
@@ -52,6 +52,9 @@ enum {
 #endif
 #ifdef CONFIG_LOCKDEP
 	___GFP_NOLOCKDEP_BIT,
+#endif
+#ifdef CONFIG_SLAB_OBJ_EXT
+	___GFP_NO_OBJ_EXT_BIT,
 #endif
 	___GFP_LAST_BIT
 };
@@ -93,6 +96,11 @@ enum {
 #else
 #define ___GFP_NOLOCKDEP	0
 #endif
+#ifdef CONFIG_SLAB_OBJ_EXT
+#define ___GFP_NO_OBJ_EXT       BIT(___GFP_NO_OBJ_EXT_BIT)
+#else
+#define ___GFP_NO_OBJ_EXT       0
+#endif
 
 /*
  * Physical address zone modifiers (see linux/mmzone.h - low four bits)
@@ -133,12 +141,15 @@ enum {
  * node with no fallbacks or placement policy enforcements.
  *
  * %__GFP_ACCOUNT causes the allocation to be accounted to kmemcg.
+ *
+ * %__GFP_NO_OBJ_EXT causes slab allocation to have no object extension.
  */
 #define __GFP_RECLAIMABLE ((__force gfp_t)___GFP_RECLAIMABLE)
 #define __GFP_WRITE	((__force gfp_t)___GFP_WRITE)
 #define __GFP_HARDWALL   ((__force gfp_t)___GFP_HARDWALL)
 #define __GFP_THISNODE	((__force gfp_t)___GFP_THISNODE)
 #define __GFP_ACCOUNT	((__force gfp_t)___GFP_ACCOUNT)
+#define __GFP_NO_OBJ_EXT   ((__force gfp_t)___GFP_NO_OBJ_EXT)
 
 /**
  * DOC: Watermark modifiers
diff --git a/mm/slub.c b/mm/slub.c
index 76fb600fbc80..ca803b2949fc 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -1899,6 +1899,8 @@ int alloc_slab_obj_exts(struct slab *slab, struct kmem_cache *s,
 	void *vec;
 
 	gfp &= ~OBJCGS_CLEAR_MASK;
+	/* Prevent recursive extension vector allocation */
+	gfp |= __GFP_NO_OBJ_EXT;
 	vec = kcalloc_node(objects, sizeof(struct slabobj_ext), gfp,
 			   slab_nid(slab));
 	if (!vec)
-- 
2.44.0.rc0.258.g7320e95886-goog

