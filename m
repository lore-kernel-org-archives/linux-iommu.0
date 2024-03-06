Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8D9513E7E9
	for <iommu@lists.linux.dev>; Wed,  6 Mar 2024 18:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709749502; cv=none; b=K219VrljBp3ftSZyObBCicEO9ECZ3nSFxyeZFDAMQIF6to+lPwsX/tKaEYzYPbSDWCs1WD3Btzh4L45GjvTn0VPwk1dg4zRSSlSeipr2Z1/Ia9PU4xh1+mGfJ7I+X20xPgiaV6q439RJf20mkKxti9FtZNyWGt8Y0GNbsYDCLmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709749502; c=relaxed/simple;
	bh=R2DVckge80A2ruR232rDSrP7/GV74FogObtaXjKjFt4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=WQtHADc7TnysWGvByG+eDZwLI6bh/l8bfaHVHxce8UXZhNDO2f+zZ4jl326fziojPzqV3uMi7WOzMug9xdrKaXKt73LcAGN/XQuYiR/pQus6pxuJTHuwAPRcreeph28DvAJVFQrLF69D1rDUeCyYWA65rs2lnKSVfAeOTEvZ4/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Sgj4lYrK; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Sgj4lYrK"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-d9a541b720aso2307646276.0
        for <iommu@lists.linux.dev>; Wed, 06 Mar 2024 10:25:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709749500; x=1710354300; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=6rH9mI3mTJcaBoi8NvQC9FpkTZd7d5upxL04jrJdHuE=;
        b=Sgj4lYrK1gdxF1+qrWrApXWenmqB4FS5JW8OZ1LantAfz9qfPqp796s9ixWl7GrCWu
         TMZ/lS1QEz7o8s8Dz6ZgSsMXg+RX0hlPp5P6onE4wQsmFW51LZQey6bgzWYHcWKw4xpa
         u5hJbP9BtnysEFmTs6wvKU/mkGtPz5KoDvlzCPO9vEtRA+8K1umEU66145z6OPj3ZE+t
         yLkY3Jz7Wtgonx0st627QqvvK92jdOSAm388zsY4gFy6J/ZILDH+sV/03wxcYofCgCU5
         LmfvnagynIPuadUJ7MTCRNf1S4JDQlFFOoHuKGUTZRdYHY+vtICp5bd/zuKfE15/HWHN
         QSYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709749500; x=1710354300;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6rH9mI3mTJcaBoi8NvQC9FpkTZd7d5upxL04jrJdHuE=;
        b=dc3Xm8ZQE39tmkCKB1HcNZUmyT8FVyR9TNQyWkrt+qhP/Kih3t4PXdk+p4iylMEJGR
         MKIsDQRWeRG8zna4+K1rxBZ7S3C8CBw28I+XnXvU6d+9r8CjY38wSiAxocXfVXJ3J7z1
         MrQFKS/iUW/8PoxYibbzR+oxoTbvY1LDpEuXVzHeYOwpCIVTqCApv6AtiMsXACf1rRxG
         ypLCFAUhoCJXE5YUOhvj3C9dAn7odNZR2JzuBZDge6TW6L5raf93DdAI51BA9Tml2RyA
         lCGZPUh6V9Opvdn9X4fxQEk5ukD7iYlDjED0gf6efAUFkyLg3ReJMpb+HGVKdVmPVSkA
         LcdA==
X-Forwarded-Encrypted: i=1; AJvYcCXOqMYSd6b/kxksOyWYp+uczSirXnobsBwGTI+HGlV89/jPmoYL6tCXzfWVzLmNA92lktqigkDAhBUSXqfhN9WHw+ZBrV0=
X-Gm-Message-State: AOJu0YyBJ4S76yoH/eAR0FQ4+NGVCpxMd1UfAZNykPHdVDAZKXPN9XHx
	PuplV10NH4eJB2nsZVd/YTk++W2LoUalAcl0q8Fd9hAMich4VCD0uSgtu91Gm+6E9aQHUHnVd+G
	hvw==
X-Google-Smtp-Source: AGHT+IHxR0olBWteUpSeEtMuXDZWp8I1meqV0Icf5ps5DXZSQPpSTLoMw3+arJQFndTmnzLC9JieP9mTFwI=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:85f0:e3db:db05:85e2])
 (user=surenb job=sendgmr) by 2002:a05:6902:1885:b0:dc6:207e:e8b1 with SMTP id
 cj5-20020a056902188500b00dc6207ee8b1mr3919663ybb.2.1709749499865; Wed, 06 Mar
 2024 10:24:59 -0800 (PST)
Date: Wed,  6 Mar 2024 10:24:05 -0800
In-Reply-To: <20240306182440.2003814-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20240306182440.2003814-1-surenb@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Message-ID: <20240306182440.2003814-8-surenb@google.com>
Subject: [PATCH v5 07/37] mm: introduce __GFP_NO_OBJ_EXT flag to selectively
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

Introduce __GFP_NO_OBJ_EXT flag in order to prevent recursive allocations
when allocating slabobj_ext on a slab.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
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
index 6ab9f8f38ac5..2ba5d7b2711d 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -1899,6 +1899,8 @@ static int alloc_slab_obj_exts(struct slab *slab, struct kmem_cache *s,
 	void *vec;
 
 	gfp &= ~OBJCGS_CLEAR_MASK;
+	/* Prevent recursive extension vector allocation */
+	gfp |= __GFP_NO_OBJ_EXT;
 	vec = kcalloc_node(objects, sizeof(struct slabobj_ext), gfp,
 			   slab_nid(slab));
 	if (!vec)
-- 
2.44.0.278.ge034bb2e1d-goog

