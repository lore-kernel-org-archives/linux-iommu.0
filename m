Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC07532C6F
	for <iommu@lists.linux.dev>; Tue, 24 Oct 2023 13:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cdgZsGof"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-d9b9f56489fso5395354276.1
        for <iommu@lists.linux.dev>; Tue, 24 Oct 2023 06:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698155262; x=1698760062; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=wChZbZdPrjdzw8yNa1DdlAJuF9I/RLt/gyhxqa0kGe0=;
        b=cdgZsGofyuiHKv0T6tzy05qogvBz71RmaK6487jSwH9rh+ckabMcnig5ZuveCG2W/e
         9pK06SPVb3zyYnFQOnz8V6E3d/Se5vQdm09HII35rvfLvjOoQ95bpqsqsR7h3l3kMi0W
         DPbQlXp/oY7t0V7e0wxysWPDn+/DKesUEoKbe22ictucKUa1NRJgEcZVj5uTDfkspxbM
         +/NGVbla3K2PGD2takICLWK/ENhd2EU7Nc5FKIjfa1LaZfvilHH9gwXaeJc72VAubnMc
         rppYjfQnXpGcWJjBv3ERm+tQFOvmUn5Oeavlur5zC99J9YcV0xG/34QH14qn0ZXwZffV
         n2eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698155262; x=1698760062;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wChZbZdPrjdzw8yNa1DdlAJuF9I/RLt/gyhxqa0kGe0=;
        b=OnGO1wBhzAMVXX/I04IuppdMgjewh4LEGbtoPMHhw9JhLSW6iaNdVtBbsaVOHvQBAN
         NMduDPALq9fk/4V/e1WInz7lQJy5MDGYlgdyY+dQDK4tQm8qqu1ax/Cl0HsMPDc6cpxi
         9rwIZQq7OrCOChlAz8g7leMcba7LUUyTpwJ+pKFbI4ntPBnWGmol+kklO8XZE+dRcGkv
         Z+mwpQP7ZOfBNHVIjds2j+Wwvd1PnigEKUWE79x5JmM8TFmL9HKeeZsVnjWK4LEira0M
         sAjnMz0/KouFagRyE9coNjEmDlSkzdboU9W1nSMI70GT9THzQAkKs4WmK+Na2yBoi82M
         eiEw==
X-Gm-Message-State: AOJu0YyrlxWXI0+t0poj1jHdX/ZnTorQiYhujtJv6PVn4Bw8frkFEk1c
	87nev9f6g43ijsrZ7YlN+lGEh5hwnWs=
X-Google-Smtp-Source: AGHT+IGcrV5EmbtfxBae51aMAnIIsiAAzPfQg3R0miJy2XM7/Ak0S71e3wg0OW88a6RB4IGUgmC4AuntPsg=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:45ba:3318:d7a5:336a])
 (user=surenb job=sendgmr) by 2002:a25:7755:0:b0:d9a:519f:d0e6 with SMTP id
 s82-20020a257755000000b00d9a519fd0e6mr234250ybc.6.1698155261852; Tue, 24 Oct
 2023 06:47:41 -0700 (PDT)
Date: Tue, 24 Oct 2023 06:46:24 -0700
In-Reply-To: <20231024134637.3120277-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20231024134637.3120277-1-surenb@google.com>
X-Mailer: git-send-email 2.42.0.758.gaed0368e0e-goog
Message-ID: <20231024134637.3120277-28-surenb@google.com>
Subject: [PATCH v2 27/39] xfs: Memory allocation profiling fixups
From: Suren Baghdasaryan <surenb@google.com>
To: akpm@linux-foundation.org
Cc: kent.overstreet@linux.dev, mhocko@suse.com, vbabka@suse.cz, 
	hannes@cmpxchg.org, roman.gushchin@linux.dev, mgorman@suse.de, 
	dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com, 
	corbet@lwn.net, void@manifault.com, peterz@infradead.org, 
	juri.lelli@redhat.com, ldufour@linux.ibm.com, catalin.marinas@arm.com, 
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
2.42.0.758.gaed0368e0e-goog

