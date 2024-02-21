Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1C631272AD
	for <iommu@lists.linux.dev>; Wed, 21 Feb 2024 19:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708544536; cv=none; b=XYLf1HK6LbPr7d/LfdnWSKmGv7uLJ3VnICkZTjFXjSA02nVEZ+oi3ceZgiso/Cy186jRaSw2QwStFmrd+Ywenq23bJXgxzBzwNzd7Fu+jYau+/Hh3QbStmFYPFXVwkSYeNJ4bWChIA0A5EqY2gz6zEUK8zoHDSbqv7pA1Vtzh7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708544536; c=relaxed/simple;
	bh=YUaiBKk0yJaoPiPhkAmL3LiC+pv84RILoX6k94HC1UM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=AF2xxRcwJfcyDxXddt6zlhc+4kaPQ9Pg+Jg922Zs+Oi027B/YmTsrs/yksOFgOirYoqiA6WwcV8oMjiLRrZC6ZwRfmwzREtZKIGQy5xRGV429q3mFZDklGVWNckOA4gDE2GxpYPXlQnN1YhlvQjhnyA9jyl3pIOeCeWhoW581/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PkeXPZ9t; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PkeXPZ9t"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dcc0bcf9256so7889469276.3
        for <iommu@lists.linux.dev>; Wed, 21 Feb 2024 11:42:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708544534; x=1709149334; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=8ETkntKf5Z8TKkoIJeAz1krTkKQJvX5Zd0TKA8iBrrk=;
        b=PkeXPZ9t7heUoFoiB4IrOqu8N6wmEIRvADcfab6glD+RjkIJ0wYqw9qkdctsa3x57P
         a3w3czZMb2ig9pG2l0M/GISG1YYUnk+Pp/u+LDt4DtiTjeSunH5Fo9SEO3UMweqnozUm
         GIPiQNMu+b5VxWY24kwym+p517rVvu9hEleNFU8czRkcU4y0+wrG8jF4Vfq8S5g2xnlm
         uMakbQ6D2RoaALxmnFuZ6mCmvtA8GmNCCuLkZ7WIzxzXdfu77j3K6Rldh7Xm9Do5pG7l
         V7CU1IunptmsNVNfJRrXcWXk/MOkiKP+kVULJ3kw/DHHwZ7TqIdQ3Q4Xzmsg7NU2rmRy
         chbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708544534; x=1709149334;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8ETkntKf5Z8TKkoIJeAz1krTkKQJvX5Zd0TKA8iBrrk=;
        b=bsG53aapyIhX2hTQwW8QAD35VEYSS1BNJIWlzsV/HzmaVwVjlwBvnF7+AHdK0/MejL
         2qBKr6yvUQNg888SsBielHlwJbRVRX9j4jrEBmyOH8WF7wY0KtSEftVHVEJcEYyo18rI
         PoOy/LwwBPZG4nSYDSLPb7ATc2t2i93UenxOpTwqSw1GfLpKHDfkOtvPR8WnCqsyGpVA
         nDQa+xvdkiuBB4gDuPgXox++Rnql8t3ewSE5ZsinDB53T5NE5bBCaO9jvRtM0tUuM5wg
         T0ZGdKUhEHRGQGdDJtdrIK4TFK1JMO1cL1EIz0MQJBtTESIIElRpO/OOfMYYz409yDM6
         dPeA==
X-Forwarded-Encrypted: i=1; AJvYcCX01b+xZ3Qc3u9c5nlrwzevMb4ZN4pF0q/PYaNfiQEaVZD3nBzbUqXMbu/N60J6+Rc953yaIxs8VwCavEcZ8zxJt+uEg7I=
X-Gm-Message-State: AOJu0Yz12C0mY6dgR3fP0XLALspN6Vz0pZEaqVd3k5gbUSRPttQsTOff
	MVz/QrS49QUCmFXCnkH+T41i8Y8yPrEL9Vg6wf9fyywe04+k1aJVVb/n4HjMAOAW/NeYozoBjT6
	Dkg==
X-Google-Smtp-Source: AGHT+IGcBk16mzh5/xxbKr6yggh2Yyj7g5lycw9QHRAaELldFsCkqrypZfX0yKxpepdpGv4MQmcqVIlNfo0=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:953b:9a4e:1e10:3f07])
 (user=surenb job=sendgmr) by 2002:a25:844b:0:b0:dc6:ebd4:cca2 with SMTP id
 r11-20020a25844b000000b00dc6ebd4cca2mr14813ybm.11.1708544533985; Wed, 21 Feb
 2024 11:42:13 -0800 (PST)
Date: Wed, 21 Feb 2024 11:40:48 -0800
In-Reply-To: <20240221194052.927623-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20240221194052.927623-1-surenb@google.com>
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
Message-ID: <20240221194052.927623-36-surenb@google.com>
Subject: [PATCH v4 35/36] MAINTAINERS: Add entries for code tagging and memory
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

The new code & libraries added are being maintained - mark them as such.

Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
---
 MAINTAINERS | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 9ed4d3868539..4f131872da27 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5210,6 +5210,13 @@ S:	Supported
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
@@ -14061,6 +14068,16 @@ F:	mm/memblock.c
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
2.44.0.rc0.258.g7320e95886-goog

