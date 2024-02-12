Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E53758AB9
	for <iommu@lists.linux.dev>; Mon, 12 Feb 2024 21:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707774029; cv=none; b=Z4PGkz6uTNvXNSjmPheZTfugP3WJssDss78RSWoj4fz0+zcgBsmas0po3Had4IF81yM3jCetVc2GzkX4I1K4Z3iFBdpUt2nblu3sdOrsEhWis4OFmH9LrRNhrdieOoDw+sjX8FgTRj35NifU9PaeYHCWTv/xJSBAZwWqVtvuryw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707774029; c=relaxed/simple;
	bh=SPQ6Ysfd7WnLLii6ApAHVobNpCAxJwmzP4EGGARuO/M=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=QRD7SFiMY4YmmOMD9HtaNrtiUxZwqWZwiVLwNk3VmCucnEKH36DDZFe2DZGt8nWLDbVSQulct9q4F79IjopY1tg3m+35Z1Hnm889mWFVEfv/vArxjEn0DzOAHj0+DKtnz1p1OyGZL+fnw6XUnpNAdZ1+07pP7gUQAmi25npCZuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=C0VFGWE3; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="C0VFGWE3"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-604ac3c75ebso68384177b3.0
        for <iommu@lists.linux.dev>; Mon, 12 Feb 2024 13:40:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707774027; x=1708378827; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Uyzb7E9FIhn/mbh3tSg2FbzBy8bNHcnwrWfMf2QZXg0=;
        b=C0VFGWE3WIrcfxZt3uQFUr6+X3dVE5cVN7Q7o8CdOeglDagW3elYk1/uduR/+3YkY8
         z1JlEuDUL3rYSQXoPPmNoSLR9lr+4BfSnzUItCzKyLRrY+n8Npnzpet25WkcdAxkw8Id
         W7Bd7c7pwMKdGgYYp+0bD9fhPEGY9me9PXgVKjioglt3P/U7H24DFKvkGK4GK+7axQMV
         Rc73LVqMaYRMwmENrlSSLpEsUerQAd3g671WX9slJgTO4xhyeRLYmV3PtZmMMptwKMqN
         Su7e6vFKOEdMbnBN29gwhfSiNYV8xfEeBaG4ldHSPB3hcmdl2GjS+DThJ6uikYThFMci
         6o3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707774027; x=1708378827;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Uyzb7E9FIhn/mbh3tSg2FbzBy8bNHcnwrWfMf2QZXg0=;
        b=EV1YMlXUg0Buu1TPture9njCACm+DDtIQT7y2fmASqpYGShkncWBT6Fkc58t8vv184
         z6IzFTyzYdH5mOlX8zDqNWFy0W9Q+uSPpf0C+rFoL7wGEXnMT6U4+9tW3JbZVksVWIkg
         qgBdb7LRLIGFaUvkRDdm46c0B/DnDFYkGUbCjzVfujIMSgJ1+0q/lML8i/Us9yqoH4/f
         gv1ZjUGfGwZrQN+Tr0Gdb4rqPiTfpsmUgqZvgr2dgOy7T5s/JKuiyee50cOZy3wEMZH0
         y1tgoruaDk4992CdxQm+9bK3OWtO9UelDv8zoi7ODVWpEM7YoLlroGGdfo9awyUDhGuW
         tf0g==
X-Forwarded-Encrypted: i=1; AJvYcCXKOwNtlw2i2YdJjJNG2sUW57l9yePKSCrJCCUv8ErLwYWYPSoZnr0i6zVMRPN7CWalh58bEYv8tSbmtchmM7+F8OZYsW8=
X-Gm-Message-State: AOJu0YzGyvOY78lq0G/XWwvZikNHobXjkSLdCyTTkqKWQUZF9HBnC/Xl
	3PAgMhu+aL61PVO0IO81OUN19b8z0kL+gzAchKSfPxzqOcZxVQcUP5ttaUaj7SefK2M9etDpqaN
	3MA==
X-Google-Smtp-Source: AGHT+IE5NPp+ufCGF1WHGTLjC5ri/m4V06t1gtAUtmtnTKuKy22ZlehWWdmQuoopo1S/2T4p6wMzddrrcNE=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:b848:2b3f:be49:9cbc])
 (user=surenb job=sendgmr) by 2002:a05:6902:1505:b0:dc7:48ce:d17f with SMTP id
 q5-20020a056902150500b00dc748ced17fmr2107200ybu.10.1707774026593; Mon, 12 Feb
 2024 13:40:26 -0800 (PST)
Date: Mon, 12 Feb 2024 13:39:11 -0800
In-Reply-To: <20240212213922.783301-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20240212213922.783301-1-surenb@google.com>
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
Message-ID: <20240212213922.783301-26-surenb@google.com>
Subject: [PATCH v3 25/35] xfs: Memory allocation profiling fixups
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

This adds an alloc_hooks() wrapper around kmem_alloc(), so that we can
have allocations accounted to the proper callsite.

Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 fs/xfs/kmem.c |  4 ++--
 fs/xfs/kmem.h | 10 ++++------
 2 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/fs/xfs/kmem.c b/fs/xfs/kmem.c
index c557a030acfe..9aa57a4e2478 100644
--- a/fs/xfs/kmem.c
+++ b/fs/xfs/kmem.c
@@ -8,7 +8,7 @@
 #include "xfs_trace.h"
 
 void *
-kmem_alloc(size_t size, xfs_km_flags_t flags)
+kmem_alloc_noprof(size_t size, xfs_km_flags_t flags)
 {
 	int	retries = 0;
 	gfp_t	lflags = kmem_flags_convert(flags);
@@ -17,7 +17,7 @@ kmem_alloc(size_t size, xfs_km_flags_t flags)
 	trace_kmem_alloc(size, flags, _RET_IP_);
 
 	do {
-		ptr = kmalloc(size, lflags);
+		ptr = kmalloc_noprof(size, lflags);
 		if (ptr || (flags & KM_MAYFAIL))
 			return ptr;
 		if (!(++retries % 100))
diff --git a/fs/xfs/kmem.h b/fs/xfs/kmem.h
index b987dc2c6851..c4cf1dc2a7af 100644
--- a/fs/xfs/kmem.h
+++ b/fs/xfs/kmem.h
@@ -6,6 +6,7 @@
 #ifndef __XFS_SUPPORT_KMEM_H__
 #define __XFS_SUPPORT_KMEM_H__
 
+#include <linux/alloc_tag.h>
 #include <linux/slab.h>
 #include <linux/sched.h>
 #include <linux/mm.h>
@@ -56,18 +57,15 @@ kmem_flags_convert(xfs_km_flags_t flags)
 	return lflags;
 }
 
-extern void *kmem_alloc(size_t, xfs_km_flags_t);
 static inline void  kmem_free(const void *ptr)
 {
 	kvfree(ptr);
 }
 
+extern void *kmem_alloc_noprof(size_t, xfs_km_flags_t);
+#define kmem_alloc(...)			alloc_hooks(kmem_alloc_noprof(__VA_ARGS__))
 
-static inline void *
-kmem_zalloc(size_t size, xfs_km_flags_t flags)
-{
-	return kmem_alloc(size, flags | KM_ZERO);
-}
+#define kmem_zalloc(_size, _flags)	kmem_alloc((_size), (_flags) | KM_ZERO)
 
 /*
  * Zone interfaces
-- 
2.43.0.687.g38aa6559b0-goog

