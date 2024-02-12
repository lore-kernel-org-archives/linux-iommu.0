Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3AD3524A1
	for <iommu@lists.linux.dev>; Mon, 12 Feb 2024 21:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707773992; cv=none; b=J0IKdlZu/ya270rukzGeBsGm9Ls5KiLEgXIidI8109jDSfA0JScHWOaOAJimFooB/XhuN+j4YQ2Iu7S8i5ECcddvv5SJGKARRHwm+WvAoeJQBS4sPWhgjSTdSLneOFgqlp57pgFxo6AlAiW5EFczZsk9piFacYIODDdPa3LclaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707773992; c=relaxed/simple;
	bh=w44iVPug8jpPRNSPySloNWFf1wUiHVTmGcnwNRfDzpg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=EsxY44JLthv0kouW6ArSoNzfMC3wPSonJQFEbud8OQj7wLjbNFU+YzNVfwKqEFBgx6YGfXU/bgQNrN+pjvL/Kcm9D4bSYbKIHU8IuarM8knm4+Zlk5whG0n3iQScA+dDx3hliHDruu9OPbXTQVyIBj1q6Ih7q5KDuRQ5imFFNvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YJ1upOGb; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YJ1upOGb"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-5fc6463b0edso62932437b3.0
        for <iommu@lists.linux.dev>; Mon, 12 Feb 2024 13:39:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707773990; x=1708378790; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=MHmYMVX3pDUmg31UH8awuyUsQFI7ijlFGj9IhCGVNQw=;
        b=YJ1upOGbnrrTXSc4VuCBW0Dq+EaJgQS4kZuHhKcwu0dj5szL0rd+/qrb66xmhIYqRe
         XtdWVv7+tWBwANOOLVdosLM44VeCjaAJSTxRjFBw/ksNhCzpmB2DjRvEj4tRdi628kKx
         CRIoHGHYavgRTM607+qp38D++6ojkZ6EeBVAUJ01NxhNz9KdSK9T9MrF9S2iWRv6RDit
         gVEvWYD1wn/A/6S3ckmoo4vVwy+VWfapurXG6n9ObEFwqB7SmQaI7YY2mDvyQqinmFEE
         fPa5mStltpZmdju+R5cuxZQ6o8FOZ8tRJ//v1M09amJ44KWyK7cSdnZthGvrdt5hv8cq
         /Ayw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707773990; x=1708378790;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MHmYMVX3pDUmg31UH8awuyUsQFI7ijlFGj9IhCGVNQw=;
        b=LcdE5rnAn83wLCuyB84R8h6KM349Aqpbrb+mYoS+3Z8uVvIB4tcv+bAHE11mI/uFSL
         Wro4H2Vsxg97ERAeehM1u7ovt0SEQr10C6Fm3sEPBuDGVG0gGcJTjvebl9MqtPLVb51f
         9nRG8IFgr33UwwA6d4IxkfkhQrkTpbwH9K7aMZ/JcVx8+/HurK0SSulCPBCNMkvrxUBr
         s96bxziB3clRGCQ9v45H6YCcOm/G6Nf/NOdZb5JxI4yRnZZGLjDE9Fu6IbP8Hdep31kQ
         e58J5UKhCVwxnuIqkyanmjJa16BDEpWaGAORfKt6HYaSO3Q7ZtXNLDxaoMvHF/TuG9df
         Nvjg==
X-Forwarded-Encrypted: i=1; AJvYcCXRv/zZBwjowh4DcRxYejsZdYk5GwkJiudhBPeSWXXsH8nHKWj3z1LnlTwGY3TdlYVHyYKzONAXz9+tg73UUBB0Tfxq0Kc=
X-Gm-Message-State: AOJu0Yy79tFeD7LfutEQMDV9DlmxM4MllAHQfnssDAcYN63LnMfpJ1rP
	5Q7hN6/cAyiZ27mD0OVMGJw0lGgdxXYPJvPShYb5cB7s1isBtPDG6CrcZWIv4Z9XXuYcFgHWdcy
	QOg==
X-Google-Smtp-Source: AGHT+IFDzjF2cGPjf9byIT/iUDxPrFM8RUYETPrPWdKRGwVNA8HPcuChMwLVorzqu+gtL/yYLkx2m1ZVYB4=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:b848:2b3f:be49:9cbc])
 (user=surenb job=sendgmr) by 2002:a05:690c:fd0:b0:602:cd1a:6708 with SMTP id
 dg16-20020a05690c0fd000b00602cd1a6708mr1449899ywb.0.1707773989875; Mon, 12
 Feb 2024 13:39:49 -0800 (PST)
Date: Mon, 12 Feb 2024 13:38:54 -0800
In-Reply-To: <20240212213922.783301-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20240212213922.783301-1-surenb@google.com>
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
Message-ID: <20240212213922.783301-9-surenb@google.com>
Subject: [PATCH v3 08/35] mm: prevent slabobj_ext allocations for slabobj_ext
 and kmem_cache objects
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

Use __GFP_NO_OBJ_EXT to prevent recursions when allocating slabobj_ext
objects. Also prevent slabobj_ext allocations for kmem_cache objects.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 mm/slab.h        | 6 ++++++
 mm/slab_common.c | 2 ++
 2 files changed, 8 insertions(+)

diff --git a/mm/slab.h b/mm/slab.h
index 436a126486b5..f4ff635091e4 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -589,6 +589,12 @@ prepare_slab_obj_exts_hook(struct kmem_cache *s, gfp_t flags, void *p)
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
index 6bfa1810da5e..83fec2dd2e2d 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -218,6 +218,8 @@ int alloc_slab_obj_exts(struct slab *slab, struct kmem_cache *s,
 	void *vec;
 
 	gfp &= ~OBJCGS_CLEAR_MASK;
+	/* Prevent recursive extension vector allocation */
+	gfp |= __GFP_NO_OBJ_EXT;
 	vec = kcalloc_node(objects, sizeof(struct slabobj_ext), gfp,
 			   slab_nid(slab));
 	if (!vec)
-- 
2.43.0.687.g38aa6559b0-goog

