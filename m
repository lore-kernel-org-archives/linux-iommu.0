Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3F7D14BF2C
	for <iommu@lists.linux.dev>; Wed,  6 Mar 2024 18:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709749534; cv=none; b=OpBRhnqb9x2JN7nY0J0um/7xVtqKSlaojmSvZPFKydLFQg17ps82yqX1OvEzMTq0Pq82OUrjJqx1v6wVGA6JpZN/lz9FbfD9oDWtNkrwWYUjTZc0fROXwH2QDJZkwit2q4/vBg3WzBnf1k13bDk6kTiR4qvfwRwlipz0gU97XNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709749534; c=relaxed/simple;
	bh=5X/AexHQW90KeQjyGkMbYKB5WQHanB7BlzRsAd7/9vI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=BiNkFsKLyHgdLh1r2FOituhpGBN8SwZvmO0mI4XVveEq8+6ffA9VpsO7q+jbbzEii5nGhgudHtFtSTnfxJEkNqU+dZdrj+p8BSGwNyRt6RhQotFLWzXx4iZiqcHn2QWTfYuq19b2EIGF+BNxJzbSnH+3NYAhUahUH31x8AovjEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fOB4vwK1; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fOB4vwK1"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-608e4171382so103537b3.3
        for <iommu@lists.linux.dev>; Wed, 06 Mar 2024 10:25:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709749532; x=1710354332; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=rg6IJ0Q4L7KBxRODnLb4yefimTum4BvWKaOTt5/YB2o=;
        b=fOB4vwK1I4IWzenunqW94z4Qlv6svMKsqLsrBfVhIWKv3qQ8WWRtVG7kV+M3vlKxgI
         w0JeCqlNPa0BXzbsOobNv4NTOXSszac5SnUeWH0MeszMZuXrXtUa+/CcKuk24TIq0YrF
         rmzADdCriuTAxS5+4YMoNj019Vei15XnHpXojUQioyUtCBf/2ofHdhqEzct0Kz2HKwbQ
         ke2c1ECdMq4oFg3s7Hilr4VEGIxWEmTHhQUe3lNieskuedJ+wIlBGB8x2Zxpty+GiaLE
         79KosnPLjTBgDWVKzq88csfX0E3j4HgehCwTULEvYfFjl+l8tfq4727xPCBJRXznER46
         mLTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709749532; x=1710354332;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rg6IJ0Q4L7KBxRODnLb4yefimTum4BvWKaOTt5/YB2o=;
        b=Kfw4y7C4fzcrQoBs2MKI+AF/56aNwwgJMK2l8tin1wW8la+mW3K7Cz4hCt+R3P+HTk
         9qwGhKx2L0yyUFFEvkFM1d2qqladl2niCJ+Iy2MV6LCVnw1zDa1R/2tuCimqABnR20wl
         ttDJM9/4HdxgY/papGXQdS48KJ62zYIvpqIVSngkT0xRxH9vZtbsjUd16C5zeYIyvmoA
         l2oRm/VIHgEdY8m+nyXO4Y1ob8CJtVeJItOQmovx/2+lQAuSoI88pvM86gtSG2fcm3xo
         rKQ3ZxaFVzYwvsPPT1fX1qar6+pF6E5NrVh2VsX4T6JBcul5+UYlIcFMX6sMVeF18V0B
         /HSg==
X-Forwarded-Encrypted: i=1; AJvYcCWujqvbRU4JCHBtKoyBD6IygJjDH38HQjQQOUvwYeXgEiZGzBbcS6yhy/KO517Lpq5EyFV1rvZ+/uqNeSB7EHyMzyma7BI=
X-Gm-Message-State: AOJu0YxSE3OHr1GJJBKpJReJ4befuNBBAe/mC7+U7X3O5mJGcPAx8+bH
	RC+Cs3XXIzkcLnrA3Giw4G4qbA7xevQp8KthYivP9lB1bDDcNNWTS5z+67ubY8SWN9bvoclXQKc
	4oQ==
X-Google-Smtp-Source: AGHT+IF+RFcX0NYxjT6uNvnW+K0lH94IF3O72VJ6PT7ea1CL+TwW9QtFKtQNO2MOoPPDxhg0sWNTYKHdXg0=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:85f0:e3db:db05:85e2])
 (user=surenb job=sendgmr) by 2002:a81:9945:0:b0:609:781f:a7ab with SMTP id
 q66-20020a819945000000b00609781fa7abmr3355582ywg.1.1709749532080; Wed, 06 Mar
 2024 10:25:32 -0800 (PST)
Date: Wed,  6 Mar 2024 10:24:20 -0800
In-Reply-To: <20240306182440.2003814-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20240306182440.2003814-1-surenb@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Message-ID: <20240306182440.2003814-23-surenb@google.com>
Subject: [PATCH v5 22/37] lib: add codetag reference into slabobj_ext
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

To store code tag for every slab object, a codetag reference is embedded
into slabobj_ext when CONFIG_MEM_ALLOC_PROFILING=y.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
Co-developed-by: Kent Overstreet <kent.overstreet@linux.dev>
Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
---
 include/linux/memcontrol.h | 5 +++++
 lib/Kconfig.debug          | 1 +
 2 files changed, 6 insertions(+)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 7709fc3f8f5f..33cdb995751e 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -1652,7 +1652,12 @@ unsigned long mem_cgroup_soft_limit_reclaim(pg_data_t *pgdat, int order,
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
index 3e06320474d4..dfb5a03aa47b 100644
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
-- 
2.44.0.278.ge034bb2e1d-goog

