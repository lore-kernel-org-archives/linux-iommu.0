Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D314E8592F
	for <iommu@lists.linux.dev>; Thu, 21 Mar 2024 16:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711039038; cv=none; b=LppFaYTdDOp3KIPhnSfEEYfdB/m3Cc4NXdcoeKRQrk6VHCljx+6N7fPeY2drzMZ6Wn705nMYhnGWpV3p+av72AmLKqqjsHWqkex+nTdN6kFVX5Ef1xO2u9MaIEmPZoVw5zSjmeTQZEcE2NgAUNvSevJdDn06xBr21EIWeqhgeE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711039038; c=relaxed/simple;
	bh=ujv687cLORDitvw7vHh+8KR/OEd7UGM3fYQWSn6DLm0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=EcI7QN3lTqdx5iM8W1m4Dh9RuQTyZSovk/d2DJGNh+VBWVOP2I5ERtZe96otU/1WZgVAtSOoaz6bFbrmuSJiCShdjk0oZ9xKEO0AooSNxHUSRqq3ciw+srLr5bQvoI2du5nU9rRgoLvq8NWAhxg9KmVaS6fFaMSGCcXK3icnf14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wOG6uEYR; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wOG6uEYR"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dbf618042daso1829091276.0
        for <iommu@lists.linux.dev>; Thu, 21 Mar 2024 09:37:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711039035; x=1711643835; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=WfR76FD4Au5CxbM75qQNdquNFQiSYxURTySBYiFO3v0=;
        b=wOG6uEYRwwC+gBaD54K5hoXhXCMFbNI0AmlVt2mHTmW+Uq2sb2br98sLox3gJ2v8gq
         mxHINbzwXVVbRhrgRtBmbRCejWRsPbOggVrBNMsqBr4RdgamNUYwhNeEM8pq7aMKnwNM
         J5rwI7RJ5CLd41Uooo30Gmf7LHqgyXiILxInVmRb2uPXo+9NAnEbhCKVJCRsUdhpNq6g
         dkCBlAJhQPr8L7XTxAn0DlVoCo6BDKTpzM6m6K8Gyw6noQYWCuPHb7B6vANC31WPcHOD
         sRgGtjETRzNP8khjEo7EeR3mCyJ0tbItWblbEEAl9DJl96z1xkLwlr+We7jBC/uJjP3z
         DmKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711039035; x=1711643835;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WfR76FD4Au5CxbM75qQNdquNFQiSYxURTySBYiFO3v0=;
        b=J0u2ju2Cjngn/gzFH6zHF5PmI+lrNBoKrr2XYHkzrlbXOINbC5ve0K5IzTxT89aeW9
         i2Uq+1dOGpbiE3qjzecOD+FQzispjAEXphu84EdEtmRpbxaUmrbTGm0GfSvmb5/yWqyO
         1ieo4QmrPWIzTPx14UjWGUqFMZRdqGV/cP8Ep8L+vCgTpsVv2MxZY7CvauRkt/XtBTRE
         iMJ0e5KA6VQpnzL986CkmUd9RIJG3xR1x1BbgIi7uJxVKiQqB7wnvluapj6+sJ0B/MBf
         uTD70PBvxvSAYt2Qzajxg4wOJT0VpJqunoiP5wbWV07rf9sMhyuVrbbahTQUNtxs62AH
         QAXw==
X-Forwarded-Encrypted: i=1; AJvYcCXDifP38dRveJW4PM9CeyrFphnIOOvoF9ZQ/+LDR/QpD1AEjmYo01q07yiWuI6Aq8+D3WGRCuwV/reDYAUd6/mXfw2ZY3Y=
X-Gm-Message-State: AOJu0YyvY1kxx60DMTkoeYozw6p9uzufEZo2P/RJCXnBeSGRaf4Bl6sB
	04siXgrfNMUdgq84G23UtMHG28LDVMH3GkXzxKDiYaO9LKq/JzRWd7763maRAtkI9x7FoECD0ka
	HFg==
X-Google-Smtp-Source: AGHT+IFhiFlsQoZCLjLg/oNv4a6rqVLDOqKxMR6InuX/fTP6XDr/Ywkc4XNBxFj0+HwVU6WiRQiaVUB3f4E=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:a489:6433:be5d:e639])
 (user=surenb job=sendgmr) by 2002:a05:6902:102a:b0:dc7:4af0:8c6c with SMTP id
 x10-20020a056902102a00b00dc74af08c6cmr1219995ybt.6.1711039034585; Thu, 21 Mar
 2024 09:37:14 -0700 (PDT)
Date: Thu, 21 Mar 2024 09:36:24 -0700
In-Reply-To: <20240321163705.3067592-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20240321163705.3067592-1-surenb@google.com>
X-Mailer: git-send-email 2.44.0.291.gc1ea87d7ee-goog
Message-ID: <20240321163705.3067592-3-surenb@google.com>
Subject: [PATCH v6 02/37] asm-generic/io.h: Kill vmalloc.h dependency
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
	glider@google.com, elver@google.com, dvyukov@google.com, 
	songmuchun@bytedance.com, jbaron@akamai.com, aliceryhl@google.com, 
	rientjes@google.com, minchan@google.com, kaleshsingh@google.com, 
	surenb@google.com, kernel-team@android.com, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev, 
	linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-modules@vger.kernel.org, kasan-dev@googlegroups.com, 
	cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Kent Overstreet <kent.overstreet@linux.dev>

Needed to avoid a new circular dependency with the memory allocation
profiling series.

Naturally, a whole bunch of files needed to include vmalloc.h that were
previously getting it implicitly.

Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 include/asm-generic/io.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/asm-generic/io.h b/include/asm-generic/io.h
index bac63e874c7b..c27313414a82 100644
--- a/include/asm-generic/io.h
+++ b/include/asm-generic/io.h
@@ -991,7 +991,6 @@ static inline void iowrite64_rep(volatile void __iomem *addr,
 
 #ifdef __KERNEL__
 
-#include <linux/vmalloc.h>
 #define __io_virt(x) ((void __force *)(x))
 
 /*
-- 
2.44.0.291.gc1ea87d7ee-goog

