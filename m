Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D0FB2B5D4
	for <iommu@lists.linux.dev>; Tue, 24 Oct 2023 13:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yv0NQ5LG"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-da05c625cb9so179237276.2
        for <iommu@lists.linux.dev>; Tue, 24 Oct 2023 06:47:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698155224; x=1698760024; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=YHgfLVMScT5H/FxRnxJh+3xP9v/l17ghYQJMJklbWxc=;
        b=yv0NQ5LGzl1ayxCGF7tsGIcJKz8JgeNq4JVSTPoDdIb2rh7MvYRBAK7vodHM65tmTc
         tbJXoweyxex+U9Oqhk/9WtQEruaXEK49Ee0oCaO+ZaIYsxjwrhTqXJdayKi1LzRnMsJL
         CQvPYINTj2J+qzlVoMK0N6xeNkRxJh6UDO8Pf4AuhZ02wpblQAJSA3GWnHAfUrKg6//x
         Weo0xN6WiAJtfkXqwe7keO2f37h+azi8xF3g78gno9cs4pZyFBJpclD+48yja2nbCXaa
         uwe+cMYNbQgy3c3cmBJkgHjMPvrllCxAGu02oihxqap7RvlrHqQxLchtVqhZTQOojCWO
         xmrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698155224; x=1698760024;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YHgfLVMScT5H/FxRnxJh+3xP9v/l17ghYQJMJklbWxc=;
        b=UiwU/+iEczzCINNVijqpH5ZZNY/Yq7H+jnFTeiiudvJVyNTOMkkhJOUGDKL5TgFYyd
         5bbH3+EJN0N/CA3vhVMhLBdXfCR2ZuYD/P9R0w27IHYWSrUbrL2hMTFDJnutCQGrS0Fr
         9LDWMAmpoMaO09VMbnbsOpBjmdlBeGJIU50XtBWrYEs71GDXtdp2M2tsTxi2Caw/3oet
         3YAXaI0FoGW7LR1uWmLm3WsHufYqBsHw/fH9ELa4hvIrIB8tpHEMK9mbeumZ01onQ5u3
         QS3Xb87N1RFh9TApy2tydeV3j7U4a2fdbGygcUVOTfBr30SdXc9nBuD5qqJyHJdxUHz+
         tCAQ==
X-Gm-Message-State: AOJu0YwcBu1ghBZT721B7wm3VgYJCek0hnN40XOuszcc1tUVhdRFwItk
	wIztxuFQWSJYkRsXRQFenxtAhHVNJJ8=
X-Google-Smtp-Source: AGHT+IHeBKvEZxCc8z4s40S7ha5hgPZX8U0NGngnhsFR9kbksVyPLDfdSNwpUqF/X+vAqjdciG/7nvEnCYM=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:45ba:3318:d7a5:336a])
 (user=surenb job=sendgmr) by 2002:a25:297:0:b0:d9a:4c45:cfd0 with SMTP id
 145-20020a250297000000b00d9a4c45cfd0mr213074ybc.2.1698155223878; Tue, 24 Oct
 2023 06:47:03 -0700 (PDT)
Date: Tue, 24 Oct 2023 06:46:07 -0700
In-Reply-To: <20231024134637.3120277-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20231024134637.3120277-1-surenb@google.com>
X-Mailer: git-send-email 2.42.0.758.gaed0368e0e-goog
Message-ID: <20231024134637.3120277-11-surenb@google.com>
Subject: [PATCH v2 10/39] mm: prevent slabobj_ext allocations for slabobj_ext
 and kmem_cache objects
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

Use __GFP_NO_OBJ_EXT to prevent recursions when allocating slabobj_ext
objects. Also prevent slabobj_ext allocations for kmem_cache objects.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 mm/slab.h        | 6 ++++++
 mm/slab_common.c | 2 ++
 2 files changed, 8 insertions(+)

diff --git a/mm/slab.h b/mm/slab.h
index 5a47125469f1..187acc593397 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -489,6 +489,12 @@ prepare_slab_obj_exts_hook(struct kmem_cache *s, gfp_t flags, void *p)
 	if (!need_slab_obj_ext())
 		return NULL;
 
+	if (s->flags & SLAB_NO_OBJ_EXT)
+		return NULL;
+
+	if (flags & __GFP_NO_OBJ_EXT)
+		return NULL;
+
 	slab = virt_to_slab(p);
 	if (!slab_obj_exts(slab) &&
 	    WARN(alloc_slab_obj_exts(slab, s, flags, false),
diff --git a/mm/slab_common.c b/mm/slab_common.c
index 2b42a9d2c11c..446f406d2703 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -222,6 +222,8 @@ int alloc_slab_obj_exts(struct slab *slab, struct kmem_cache *s,
 	void *vec;
 
 	gfp &= ~OBJCGS_CLEAR_MASK;
+	/* Prevent recursive extension vector allocation */
+	gfp |= __GFP_NO_OBJ_EXT;
 	vec = kcalloc_node(objects, sizeof(struct slabobj_ext), gfp,
 			   slab_nid(slab));
 	if (!vec)
-- 
2.42.0.758.gaed0368e0e-goog

