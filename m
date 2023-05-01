Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FEB03C29
	for <iommu@lists.linux.dev>; Mon,  1 May 2023 16:55:29 +0000 (UTC)
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-1ab0669d9c5so867975ad.2
        for <iommu@lists.linux.dev>; Mon, 01 May 2023 09:55:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682960129; x=1685552129;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=DK6/s7foZNj5EExVH4gZckioJVPcIxI52cq1C7FfTD8=;
        b=j+Kr4wFQ8hb6ghgASWLoQmwshyZipq1bE+D/CA603zsc4kB1n7R3CTQw1X9N4pK0pE
         0zmuTlr7BciP0EtB463YkQ7YcnZO9MQaA53eLGwRosKH+IiuL9AF+xukRwd1DIpRoQoE
         CuOOiRq7K1VtqSyYvIO65JDUgFMtQPFNC1XFk5UKDZu8zG86BBXEpcIuAsalgfYjpqSk
         4H7kaQB7eIw3KHROJbChdasmtpmhAOtDolQRdOsPV+jVQQISfSODNw3+xILO7OLY0pMp
         pmy+NWFCOxFQwMauo6Mv0q9Qa8hd2IlOPM48vsABoana6/QPtONXZz6Lhi9KWaOg0TwZ
         kOfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682960129; x=1685552129;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DK6/s7foZNj5EExVH4gZckioJVPcIxI52cq1C7FfTD8=;
        b=JQd6rZWoNk0aMbBQlXT1IuQv6okRI+/sHzav1oNJ0TOJlOAOOgj0o0Z07Fzmk5eWDC
         xWmr9nsBL4VF+faQRJBH9G8Azqr75fGryvaCshV60Kapa47YiVjgVLZK1feMkbBMf1Z6
         Ga80ew9ZGfmEQNyJKfbAOjBjVn4OqMDhUDnRwMCLnK0iEm5zNkxn/saJCow3wdKpqFnt
         2Xa2amXKQubkVlE28Fua3a19aK/G0X7ye030oqbEWgiCvNniIb0Plb4f0dMa7NohNeM1
         ZnY4winXG/FJJ/GVDy/oUi4vcTyl4uedW7VtdmePNl76WxBCHrStw6IYclEqx7i9CMsd
         Nbug==
X-Gm-Message-State: AC+VfDyeY96PKeY+Um+O4OPfDvG0f6VuENvklaerbzd5Ijr05tXDJYxO
	YAc7F92SjImRF5f7dTnF8WaLyZoGCYo=
X-Google-Smtp-Source: ACHHUZ501oAX8t/t8FRpUPo9PQ1t5ZgNv7pUhAgWb4tueLlYCBA4gtRhgJc8gsKy6W9D1EibQZVYd1jDC2Q=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:6d24:3efd:facc:7ac4])
 (user=surenb job=sendgmr) by 2002:a17:902:6a84:b0:1a6:4543:d295 with SMTP id
 n4-20020a1709026a8400b001a64543d295mr4657171plk.5.1682960128744; Mon, 01 May
 2023 09:55:28 -0700 (PDT)
Date: Mon,  1 May 2023 09:54:19 -0700
In-Reply-To: <20230501165450.15352-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20230501165450.15352-1-surenb@google.com>
X-Mailer: git-send-email 2.40.1.495.gc816e09b53d-goog
Message-ID: <20230501165450.15352-10-surenb@google.com>
Subject: [PATCH 09/40] mm: introduce __GFP_NO_OBJ_EXT flag to selectively
 prevent slabobj_ext creation
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
	ndesaulniers@google.com, gregkh@linuxfoundation.org, ebiggers@google.com, 
	ytcoode@gmail.com, vincent.guittot@linaro.org, dietmar.eggemann@arm.com, 
	rostedt@goodmis.org, bsegall@google.com, bristot@redhat.com, 
	vschneid@redhat.com, cl@linux.com, penberg@kernel.org, iamjoonsoo.kim@lge.com, 
	42.hyeyoo@gmail.com, glider@google.com, elver@google.com, dvyukov@google.com, 
	shakeelb@google.com, songmuchun@bytedance.com, jbaron@akamai.com, 
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
---
 include/linux/gfp_types.h | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/include/linux/gfp_types.h b/include/linux/gfp_types.h
index 6583a58670c5..aab1959130f9 100644
--- a/include/linux/gfp_types.h
+++ b/include/linux/gfp_types.h
@@ -53,8 +53,13 @@ typedef unsigned int __bitwise gfp_t;
 #define ___GFP_SKIP_ZERO	0
 #define ___GFP_SKIP_KASAN	0
 #endif
+#ifdef CONFIG_SLAB_OBJ_EXT
+#define ___GFP_NO_OBJ_EXT       0x4000000u
+#else
+#define ___GFP_NO_OBJ_EXT       0
+#endif
 #ifdef CONFIG_LOCKDEP
-#define ___GFP_NOLOCKDEP	0x4000000u
+#define ___GFP_NOLOCKDEP	0x8000000u
 #else
 #define ___GFP_NOLOCKDEP	0
 #endif
@@ -99,12 +104,15 @@ typedef unsigned int __bitwise gfp_t;
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
@@ -249,7 +257,7 @@ typedef unsigned int __bitwise gfp_t;
 #define __GFP_NOLOCKDEP ((__force gfp_t)___GFP_NOLOCKDEP)
 
 /* Room for N __GFP_FOO bits */
-#define __GFP_BITS_SHIFT (26 + IS_ENABLED(CONFIG_LOCKDEP))
+#define __GFP_BITS_SHIFT (27 + IS_ENABLED(CONFIG_LOCKDEP))
 #define __GFP_BITS_MASK ((__force gfp_t)((1 << __GFP_BITS_SHIFT) - 1))
 
 /**
-- 
2.40.1.495.gc816e09b53d-goog

