Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80418126F14
	for <iommu@lists.linux.dev>; Wed, 21 Feb 2024 19:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708544466; cv=none; b=oCz+wEJ4jFz5SVN4XzKu7ptSGOF+/RXaeIbdfgJGE8/FIca2YatzT5oGf/Gq9CDXePsspvyIgfLFTJKEFx3/BIciyDJ77ifgXUIy3aWvGmf2BHgWVe6cM8RSKNTmcFQkBHVFFcEt8h6/wQiSwXPmkykJyUmLIGfr2Fmtd772zxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708544466; c=relaxed/simple;
	bh=0jXC3LDzUrrolAiGzpejaFGts6g9gPbvSne6eR9EGZ0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=DAPLnTykwPLno8oUpY98xUQGrjNW1T4XdMZsf6hKKwMH+nb8h9ja9nOQMzl6kglxP3mqHjlvlKiRVYBqtBcwj63JifwDJbXlk9xxFeWGhk7x+iVBCiNWfberEy+atGdNxRntJ2sM5VyS0CuNVWWCProArVg8pquaxl5S1qYnrZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SvlgsZ2+; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SvlgsZ2+"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-60770007e52so82264947b3.1
        for <iommu@lists.linux.dev>; Wed, 21 Feb 2024 11:41:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708544463; x=1709149263; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=aDZXV5wClyo81E7oQNbL7t5gFNRFpKZi8JXsyoMDgnM=;
        b=SvlgsZ2+XoE6OT5krh6FbyvAdx0tted+ZAmAehwHVtO6o8TooK2HE8cPDCS509lksh
         UlxpLoXObrxIsrUgr6V8Z7d7Ui1I36/O3E5vrNG6PbsgLKt+U8H6fDFUpjT39YLNI9DL
         6BNMUitE3Alje4v37GB4qr2atMq0VaGKm3tfxINN2HXi1Uiy3KUwhzHgr+mh5MTZT3eT
         E9H5Vz64zP5VCLRMiJ9AS/MyXJoKli8r8hd6uPHHEm+9CMRbUvewwt5Acv5a6RYC2/5S
         3Nh/xqzIVp5ZHLrYrwZVuzcyVmAosZ6Bq2n6oky3DTRf/MCXDI0hkEcibW7pU8MljBqe
         JhIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708544463; x=1709149263;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aDZXV5wClyo81E7oQNbL7t5gFNRFpKZi8JXsyoMDgnM=;
        b=oVjzk4uRwG4EXSdfa98lap/kovR+tIuOU5vmzQxb08hS1acHDX2fyYxbRslevhyCVI
         cjP+eUp9juAGkgELzV3XYNCULRGlb6YaQxOYRqvw90N8cseKrqB1WFk3Atd8RiZpvjYw
         hOTXMQETDIODo6d0CvsFMgPGxKHUzE51kPP0tWng8Xz9/tFBMD6agznmxDxG+JXjI2xt
         hEEELhjmbZm5t9PI9fbtUEsTihCT1eAufXrsQoBbwhtnnULsjLraMN7RCe+ad+Cvum/B
         RPR9odylq4c4/tUAQ3PxV2QrLsNB8IUG/cGQa8vKPjZ0UZIc9RnTK4vDkSV8Ll1344yk
         1wdg==
X-Forwarded-Encrypted: i=1; AJvYcCXAQPezvECBl+w2KFoHnZR9plQP7Rl2fMwRVLhRcd0f9dpxdxlLieuMZ0T0VDJzygTIpyzHaoshsVZHV0gbKnsSV6eFmcU=
X-Gm-Message-State: AOJu0YxkhThOXc+RAWccjN6QVkDUQXOLsCKfq9/IKtyJbPgGgH4iSRfY
	AebjaNH4KJ+yLH1aid4Asu07CkCEMXaHG2f85oCsnen583ZrsNhceJmIEWBi8qhiBfwt8/oV4yd
	CSw==
X-Google-Smtp-Source: AGHT+IHYTX89gbhdUEyuW7HvamV6v1+4UrLx/voxHAa1LwjOId1uGP/0Vg+lc29zmz5uf9mDtRdIligkWrQ=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:953b:9a4e:1e10:3f07])
 (user=surenb job=sendgmr) by 2002:a05:6902:1008:b0:dc6:d9eb:6422 with SMTP id
 w8-20020a056902100800b00dc6d9eb6422mr17397ybt.10.1708544463028; Wed, 21 Feb
 2024 11:41:03 -0800 (PST)
Date: Wed, 21 Feb 2024 11:40:16 -0800
In-Reply-To: <20240221194052.927623-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20240221194052.927623-1-surenb@google.com>
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
Message-ID: <20240221194052.927623-4-surenb@google.com>
Subject: [PATCH v4 03/36] mm/slub: Mark slab_free_freelist_hook() __always_inline
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

From: Kent Overstreet <kent.overstreet@linux.dev>

It seems we need to be more forceful with the compiler on this one.
This is done for performance reasons only.

Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
---
 mm/slub.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/slub.c b/mm/slub.c
index 2ef88bbf56a3..d31b03a8d9d5 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -2121,7 +2121,7 @@ bool slab_free_hook(struct kmem_cache *s, void *x, bool init)
 	return !kasan_slab_free(s, x, init);
 }
 
-static inline bool slab_free_freelist_hook(struct kmem_cache *s,
+static __always_inline bool slab_free_freelist_hook(struct kmem_cache *s,
 					   void **head, void **tail,
 					   int *cnt)
 {
-- 
2.44.0.rc0.258.g7320e95886-goog

