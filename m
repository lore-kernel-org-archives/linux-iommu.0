Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7D52145B30
	for <iommu@lists.linux.dev>; Thu, 21 Mar 2024 16:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711039111; cv=none; b=ZOIe2EYgIrZA1RoNBzGw6G2kcE4/MxuCKmVP6PvheeLPd10NBwQoRQ5HwRHAH/NoDqo96hdgqVRBXtBnQ4IJZp1Sqgw0f0PPuW6x09FQuTOEWhPKgEZInZeAnvDyz0sQByCyGYqJ7mxdzt/UlDUwLO+JTedwRGbgmQPP+lXX7FI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711039111; c=relaxed/simple;
	bh=T2jUZ7QMLZPcjI/ns9fVxadJ0NRTRbQsVWpuPq58jmE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mLhe1Fw/NOdTNmFf320WPinUCRpL7QoCfmq9A7iVRAMZ16B05O+U+IZFrOKx6ZfIs56XIG+vMDxbbKDYC3QWilfD4HkAlBeoMx9RccY2slJwlnwLpBYpK+xXzCJy0+tKhs+87mDdNa5gIa8pWVt9k7GkN8/s8krTuyoCw5MlWzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Gb39N1S0; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Gb39N1S0"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc743cc50a6so1522277276.2
        for <iommu@lists.linux.dev>; Thu, 21 Mar 2024 09:38:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711039108; x=1711643908; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=AW33WX/ioh4EflqxU3ax5xPoUVjwxdtM7w8zUOaZaKk=;
        b=Gb39N1S0dHfZE4dkJycAg+jXv1QjNFcOPsdgg99oIC9qh1Rh3WttNYo1RwYSvIqE/6
         c10LM2boRA+YnsOBubwkIWNQwcAvXxb/AdukchVGh0TTgCJLvWpxkSS6dDMktUu4teVH
         gAqP28hH16bgOQ54vNrRwdkws+AnRQPe/doQ+mnHzO18Aj72486naHo358X4Fdb0lOa8
         nOH475c0W/utg9TTBdUoWrQhTVRRjswLYdDRDFROnuTNdteMOlK9v8pd5BVI1GsimcdC
         ShbnS225dSdaMY5ZM+aQiN6YI141wqe9LcL6oClG+oHQ/iaLp3nV2SmmlSkAUhaIdXEF
         4P1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711039108; x=1711643908;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AW33WX/ioh4EflqxU3ax5xPoUVjwxdtM7w8zUOaZaKk=;
        b=PEdTU1nFhGLVeEYDAEBaZlHkLp+5qFg6ayhVag9nMxgsjhgOXIWyeOyls+gjZN4tT1
         PzPIUAKh+/Co1FKP92DcYXgTGlq0//5/QfkuAw/oFTMbXoGGI0Y9nedoBJzfw5HuOHbf
         Yh6JVYqQGuciKASqJ25LQT4SYyy51s7N71rSccyA0wdyTQs8jM8BcECGukmVPM/MKXHE
         57mkmi/lRIXOEgzbqbpvuUZN9BwHrFsQWNeYeTIKCidihJQ/zcu+rL+LtwMJMsScaiY0
         fk2hdpbviAUi9ZzdUckKpVyClZY0TP29QIaFgWv9Oy4wpBkNxbLOw12AJGLxua7LVITO
         ZnxQ==
X-Forwarded-Encrypted: i=1; AJvYcCUV6/rq3Zhk3e6jWRbviqrBpU4dKnoqvHDxwGATLK6QAKWq89DKpFZAwMcftV7PwGxpA6nLwdZnWLzqJarOjOPR+rP3OSo=
X-Gm-Message-State: AOJu0YwExOY+arn71tdyBZqzXEMx+nG1S/NY9ULvdRYluR1JHZUXZXGL
	lQJ2Aug7VSeJ0y5JVqCoY2Juck8jW4lCseM1YI6cD24ghl8ak7MQCdzErAKiv1BJtAHP2rUXrZF
	8ZA==
X-Google-Smtp-Source: AGHT+IF7IbSbPrud7S4q2CO6A5a//4lNXuqCjaSBMjwnNeD7U+hML/0+WVDue04lWzY5rl3DmStBxkMY2eM=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:a489:6433:be5d:e639])
 (user=surenb job=sendgmr) by 2002:a05:6902:11cc:b0:dd9:2789:17fb with SMTP id
 n12-20020a05690211cc00b00dd9278917fbmr720825ybu.3.1711039107919; Thu, 21 Mar
 2024 09:38:27 -0700 (PDT)
Date: Thu, 21 Mar 2024 09:36:58 -0700
In-Reply-To: <20240321163705.3067592-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20240321163705.3067592-1-surenb@google.com>
X-Mailer: git-send-email 2.44.0.291.gc1ea87d7ee-goog
Message-ID: <20240321163705.3067592-37-surenb@google.com>
Subject: [PATCH v6 36/37] MAINTAINERS: Add entries for code tagging and memory
 allocation profiling
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

The new code & libraries added are being maintained - mark them as such.

Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
---
 MAINTAINERS | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index d5f99cc986d1..84c1505bc62a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5241,6 +5241,13 @@ S:	Supported
 F:	Documentation/process/code-of-conduct-interpretation.rst
 F:	Documentation/process/code-of-conduct.rst
 
+CODE TAGGING
+M:	Suren Baghdasaryan <surenb@google.com>
+M:	Kent Overstreet <kent.overstreet@linux.dev>
+S:	Maintained
+F:	include/linux/codetag.h
+F:	lib/codetag.c
+
 COMEDI DRIVERS
 M:	Ian Abbott <abbotti@mev.co.uk>
 M:	H Hartley Sweeten <hsweeten@visionengravers.com>
@@ -14123,6 +14130,16 @@ F:	mm/memblock.c
 F:	mm/mm_init.c
 F:	tools/testing/memblock/
 
+MEMORY ALLOCATION PROFILING
+M:	Suren Baghdasaryan <surenb@google.com>
+M:	Kent Overstreet <kent.overstreet@linux.dev>
+L:	linux-mm@kvack.org
+S:	Maintained
+F:	include/linux/alloc_tag.h
+F:	include/linux/codetag_ctx.h
+F:	lib/alloc_tag.c
+F:	lib/pgalloc_tag.c
+
 MEMORY CONTROLLER DRIVERS
 M:	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
 L:	linux-kernel@vger.kernel.org
-- 
2.44.0.291.gc1ea87d7ee-goog

