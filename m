Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0A6858129
	for <iommu@lists.linux.dev>; Mon, 12 Feb 2024 21:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707774025; cv=none; b=YxIilJXvqoq7xee2bH4B6is7q49UvcCyr9qtPBTfRjZKes20pH5UB7o6joeX3ylMRqsD0PB9bGvE8go2EaAK/FN/WiOXVxtckj2Fb/KLHyKpBXMuTwWt04HyEuoUli6pdPnbmsT0giPtP5ArZ5geXiatHVp/SlEQ4BM5wUjHWLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707774025; c=relaxed/simple;
	bh=mETHOHGta/ApXOLd4cZ9kSxCTLotDnWcLiMxmS8gzhM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Luv0ffdaROWJkCq+jBUsjLcwXVB75B+QVci0sThYK1alyxcKSGYKikyirCq1LUX167hZ/+DLX63g3Eer41HVml8gGwdCrk7i5j1d4YhJb8MVFc9t3l1QM/iCA2amrPvrz7s103n+4Ri6awAO9GjRSz/zMrwbQeDDaxqsFp2l0Cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1YFCee3y; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1YFCee3y"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dcbee93a3e1so863510276.3
        for <iommu@lists.linux.dev>; Mon, 12 Feb 2024 13:40:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707774023; x=1708378823; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=QVjGOqS2/C9DQQqaQQFc7iw3YwNnxSDsGz2z4KoUl2k=;
        b=1YFCee3y4xO5AruHnmHq01Tk/D9gGrP76Oncr1aANVHAmRcaxsXKeohnW+JWf8+ZhD
         UvzqS9Ct0HCyCYoTsQo7/22dwlWmnyXWo2ndTyJxalAOf5E6w6C6s4HO2AeHp3N7OLS0
         Ux9XoWO5RoPm0B3OL03n814/SuceerQEzxO4oUMBDAvXXwI5EMyvVhgXqIr6iNFQv8WT
         nT+/QWm9/7wEobnbETEhTQF0YEZxQLYBfeIK7fFvHme6NeKOe6lQtQOdWh8ktfeX+79T
         om3KiVXctTrS7PI6Hl20Uir1kt6Vn+lnh1DLqr9bCocVPWTv4rQiAyBFX36glwJnBdY7
         n1pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707774023; x=1708378823;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QVjGOqS2/C9DQQqaQQFc7iw3YwNnxSDsGz2z4KoUl2k=;
        b=FP+palwPqhqeYqWjH6NcvV6evts43OYfR8muhfDdKVGnXcKNlCXwQ2S4+NpLyPiMm2
         xrLgyZZaru+8O8VZTlk78PHL8neB6qvlFwXEx1wYM5+A24LYbx9IJ8EP+/7Ua6xpiUBR
         xo01K+rWwLtoXZMqhFCqb4T2lO0KWSTNr1j/K0l7eFnvZSu0YW5tIV7QHaUwvJoDjmz3
         HXZ2bwrVHrovVuyWJXNeGNZrHuSjY9ZrgYKsoYphp+KI28pBW9Tto41KXDAdJQtPhvUO
         Z8bCi2v0Do4lGqM+zIfewcAO7q7QrVoznqufLr6KZQ30pLA2P6bsIgQnIePLYZ7KFuYg
         k56w==
X-Forwarded-Encrypted: i=1; AJvYcCWnve0FIbUoQynWfdb3UBj67SLzSwz8J1y1Ie9/hY4B1rA1maDROuaaitt+cB2wvhpoG8/T5nafo2D/Vo3i69BMwZuF90E=
X-Gm-Message-State: AOJu0YyYVqbcZWYGrZNENnfeYvV6yRO2Vaj2IC+IPDqUrAGRIo8nm161
	BQH+rYmdfYD8vw8pSxFYiBFbRoYiJr3xPUQvRRVHVdGHsFROyziCRMROjcLp5RP0Uqc4hTPxMOW
	DPg==
X-Google-Smtp-Source: AGHT+IHcBrIgMIQ03gLdwIObn4fTPAITy7Rn+dgjwGrjWr5hIgaJ7mUN+6YCHWnvHC5rR1WgctLJs84VL90=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:b848:2b3f:be49:9cbc])
 (user=surenb job=sendgmr) by 2002:a05:6902:709:b0:dbd:73bd:e55a with SMTP id
 k9-20020a056902070900b00dbd73bde55amr364194ybt.4.1707774022635; Mon, 12 Feb
 2024 13:40:22 -0800 (PST)
Date: Mon, 12 Feb 2024 13:39:09 -0800
In-Reply-To: <20240212213922.783301-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20240212213922.783301-1-surenb@google.com>
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
Message-ID: <20240212213922.783301-24-surenb@google.com>
Subject: [PATCH v3 23/35] mm/slub: Mark slab_free_freelist_hook() __always_inline
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

It seems we need to be more forceful with the compiler on this one.

Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 mm/slub.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/slub.c b/mm/slub.c
index 9ea03d6e9c9d..4d480784942e 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -2124,7 +2124,7 @@ bool slab_free_hook(struct kmem_cache *s, void *x, bool init)
 	return !kasan_slab_free(s, x, init);
 }
 
-static inline bool slab_free_freelist_hook(struct kmem_cache *s,
+static __always_inline bool slab_free_freelist_hook(struct kmem_cache *s,
 					   void **head, void **tail,
 					   int *cnt)
 {
-- 
2.43.0.687.g38aa6559b0-goog

