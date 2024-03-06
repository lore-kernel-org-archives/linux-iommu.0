Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C67813F455
	for <iommu@lists.linux.dev>; Wed,  6 Mar 2024 18:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709749494; cv=none; b=RIsglu+uJOdgzlcdaoHRbzwe1QpjBvQaRu/Q88CxHwrKiAS/NtnclY13r5jGUDk0tl+0GuE1H4no2F2CPEa7WjxGE0I7BrdwVbUx+WgR86I8PdXLiAGrxHD+IZhs7uewqc+kgRwvHWqrKylLmB+MAONFDk+eXZut01cvD+A1UrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709749494; c=relaxed/simple;
	bh=mZlZ4aAM1x7pkztROKSVF7CfVo40AKOzii/60d0+0u4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=cl2baneWIvxxfVbKAQpTTvUEfFhfIwPkUaV0IK3rFbEm53dW61ZL40Gl9/+wICUBQZwrC4dj6Pr2s1F+Ej7kH+UDRkmjhDbFZPeaQoTfSB7aL+IX3a2xOBLBXbXSYKCBi7wxQCkREJ/jH9vmranhDI1ptyIT0xMxkvur7/rjuoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zuor8ESW; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zuor8ESW"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dcf22e5b70bso12444296276.1
        for <iommu@lists.linux.dev>; Wed, 06 Mar 2024 10:24:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709749491; x=1710354291; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=NeN+jv49ztz1DkBAYeWMzQyB4IxgpHbFtvet8rPjepw=;
        b=zuor8ESW3ckhybDGhEMysnIIs7sRq2qUleAw34I4/qk8R5DzbwJeHgQxvJXfPYZbs1
         8Ja99Tn9vtx/p0zAPlboMCh68Em3E7KhAUkGpteEsFxFqjrtHXtsDs+Wivx7YvpvvRW7
         5tGSyWTYwq8yfXPpUtqvMPPKsz3PlpmpUkB2LLmOl6FbvzkodI+c1qW86kcakL4gCOR1
         UhSwFfFDGQ+0mUPTdw1yvPQLr7Ey1vwSzfHkJDbbRPUsIUUt9SVERLKrzhs75NF4pOJw
         zxq7jZm1Y8hwxn+qJMdwyzSbq8YoY12ypRo6j+sBgn7nnCWF7AwrPxoKTY/eiZjdFvuE
         CWnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709749491; x=1710354291;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NeN+jv49ztz1DkBAYeWMzQyB4IxgpHbFtvet8rPjepw=;
        b=hbOfI89lYmfN/RJxOECWNH0XUdTVqpuwUmgKFVXUgbVTzStq1dH6SgCFKj+W1voHCl
         uBOfKDUR2ED6eTbs8TFUK8f5diZGPrcI107LeYy4llLJVNK6CbsaeDaEWFDgX3XTiyuN
         raAemfjF4G/b+pIa744RAPZ1qCC/gvoPWszo8n9+WnzIEO3wUmDiKi07Ny7G6T2n7Kca
         34DPa3NhtVCU1Al/qbCCGJoe/h8ojvZFz/HrJci+70KVqnOgFbciuzdVYvBE1Ul01HJj
         jwMeaw3+JAt89cbC57fevmyyTz+mIbIwno6JMQyUs1pwETtpbPyF7T/Ycx5jttz6KV7O
         ZGMQ==
X-Forwarded-Encrypted: i=1; AJvYcCW6IWPhWRyfzv/XOZafuC04tGlp1a4X7wx9rxWzEF7cAf76AK+DdWsN9KnNc7WAw0/0ps7PRhiuBHfdwOTsL4Ra0Y32TFI=
X-Gm-Message-State: AOJu0YzdTvVu/DsXCQtk4qZOs4hdto6VmL+lgMxhorREXPijuJdMOnbE
	hAm3EBFFIlhyxykA167BDvxrxAbzyX31GqEm/KwWMYAuNp084WvvqmPGp3WVXnqRoF8vhaHxupH
	1LQ==
X-Google-Smtp-Source: AGHT+IEhO5aEi5nmrgTX3yTDU5CUyz1hSmpU3f2fCr4To3c82DT/ejxK9TArxLseWogn2XsiLsKy5eHr87g=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:85f0:e3db:db05:85e2])
 (user=surenb job=sendgmr) by 2002:a05:6902:f0d:b0:dcd:4286:4498 with SMTP id
 et13-20020a0569020f0d00b00dcd42864498mr559510ybb.6.1709749491385; Wed, 06 Mar
 2024 10:24:51 -0800 (PST)
Date: Wed,  6 Mar 2024 10:24:01 -0800
In-Reply-To: <20240306182440.2003814-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20240306182440.2003814-1-surenb@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Message-ID: <20240306182440.2003814-4-surenb@google.com>
Subject: [PATCH v5 03/37] mm/slub: Mark slab_free_freelist_hook() __always_inline
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

From: Kent Overstreet <kent.overstreet@linux.dev>

It seems we need to be more forceful with the compiler on this one.
This is done for performance reasons only.

Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 mm/slub.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index 2ef88bbf56a3..0f3369f6188b 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -2121,9 +2121,9 @@ bool slab_free_hook(struct kmem_cache *s, void *x, bool init)
 	return !kasan_slab_free(s, x, init);
 }
 
-static inline bool slab_free_freelist_hook(struct kmem_cache *s,
-					   void **head, void **tail,
-					   int *cnt)
+static __fastpath_inline
+bool slab_free_freelist_hook(struct kmem_cache *s, void **head, void **tail,
+			     int *cnt)
 {
 
 	void *object;
-- 
2.44.0.278.ge034bb2e1d-goog

