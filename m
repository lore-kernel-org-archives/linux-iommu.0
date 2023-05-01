Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED24E5698
	for <iommu@lists.linux.dev>; Mon,  1 May 2023 16:56:07 +0000 (UTC)
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-b9e2b65f2eeso1390727276.2
        for <iommu@lists.linux.dev>; Mon, 01 May 2023 09:56:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682960167; x=1685552167;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=YfoToyHVT1LJlGJVQ6MuRV3hbhaLXh5d5qfc4HkIPik=;
        b=Db2dTvDWbMM6MtFyLXOOyG+p1K651ww8uL+kJDohPMMG6EWYrhfJFGluhHEW0wqXl5
         UKPrByNQ1Z4QXnisfDyfKX7dbeY+3mxaMGuFVRBjDUr3JiqQISt6WeUr2I6JPah8BGyR
         FjdvJFEuIXgNlkkoVLLQxMPMSKPuyrjPesVcRR9te3ugJsI7tT+EXrko3AZ8ov2CcY8R
         JR28aghvPN6+RkIPURXyrGkWco+xEzOLoyotOADRZq9o/XJ68RcgnDEgHpMVXMMei422
         +DGh+VKx3LXxPBgO4eeggvJc6/61DcK7Fvg52O8gRCKPK/nk5YYM+Q4LDqT5D1RFb4LF
         rBwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682960167; x=1685552167;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YfoToyHVT1LJlGJVQ6MuRV3hbhaLXh5d5qfc4HkIPik=;
        b=jTJ/CdZQlf+jEYVLrQUoGNhGYWZXjGGIzLd/giUMuoYOUHocc5pGEpEHoEXjoSJCIv
         I3uB3BM728aNDqhxKTDheM6OAGkJvJveC6+DGERBzUTLFWT2MBfy8dn7diCVRgg3Hkcj
         JpWBaLDx5mMatTsmEdT3RBmj/ipPHKXZf7h0utItEg0Vne4swz4xvadxycX8Z+SIsxwU
         EJvS3spUfz3LCt1O/QuvcgvvQz9LMV38decbJv4kXrvl2T9hPbkMLTd7IRtjvtjICpkL
         XHgv9DeIKhVBiRvcbfmZoYNzxaBXtw48pmjWu+/z+looICnusX62tGqB6RKZgr9Z5p3o
         5wdw==
X-Gm-Message-State: AC+VfDyvqNwKvA64BlUfe6WjrwIs7yjt/vV/vbuh6LPS4BmSf62LIzGz
	OVE6IicCvbCn00JonfA3iPvZUfCLzfg=
X-Google-Smtp-Source: ACHHUZ40g7B5Nzrue3Inkynn2rCW8wBzh6gvt9xgi1/WmwP7LCTtOXWTAuDa8Mc648etXigh7Ci0w5kPSCE=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:6d24:3efd:facc:7ac4])
 (user=surenb job=sendgmr) by 2002:a25:c0ca:0:b0:b9a:7cd6:ba7a with SMTP id
 c193-20020a25c0ca000000b00b9a7cd6ba7amr5449586ybf.12.1682960167516; Mon, 01
 May 2023 09:56:07 -0700 (PDT)
Date: Mon,  1 May 2023 09:54:36 -0700
In-Reply-To: <20230501165450.15352-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20230501165450.15352-1-surenb@google.com>
X-Mailer: git-send-email 2.40.1.495.gc816e09b53d-goog
Message-ID: <20230501165450.15352-27-surenb@google.com>
Subject: [PATCH 26/40] mm/slub: Mark slab_free_freelist_hook() __always_inline
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

From: Kent Overstreet <kent.overstreet@linux.dev>

It seems we need to be more forceful with the compiler on this one.

Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 mm/slub.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/slub.c b/mm/slub.c
index 8f57fd086f69..9dd57b3384a1 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -1781,7 +1781,7 @@ static __always_inline bool slab_free_hook(struct kmem_cache *s,
 	return kasan_slab_free(s, x, init);
 }
 
-static inline bool slab_free_freelist_hook(struct kmem_cache *s,
+static __always_inline bool slab_free_freelist_hook(struct kmem_cache *s,
 					   void **head, void **tail,
 					   int *cnt)
 {
-- 
2.40.1.495.gc816e09b53d-goog

