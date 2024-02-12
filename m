Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6773E54BFC
	for <iommu@lists.linux.dev>; Mon, 12 Feb 2024 21:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707774008; cv=none; b=L7LY9w9q5jD1adRLEGptx9kXTULfFsGDjtUndwOqptA2lh7+ys4Q2O97shdOSBUVvKuBYlYlJD8zQbOryaGOJ7fqmZ3tfp6uppbqxh9vH2I9EGL2OdwBNumhg20wHngMlztX/RQ+4stCt5+Zct5ao3L9GcVKp3t0ZirtbsIvZZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707774008; c=relaxed/simple;
	bh=lCACRJohYV6DrxkuBbYJIHOo4uDQQ6vlAkwkYmSc41o=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=j90jHBwPqc18uZsKdaw5fMfF+XNOljqvwkSz9bm0leU/tSx7gPJMgYkDDzQU/uzuviCZDTct/Vg/yx3vs/eFJmCYZrgvUcCrrHINPJYcVDYoSofAyQPpV68mYyuUSTEKnHyU4m5O6m6sAVjGpwX/eyA6zbFL9AFPeavbdYrPySk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Y0GeIRSD; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Y0GeIRSD"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6077ca422d2so6812117b3.1
        for <iommu@lists.linux.dev>; Mon, 12 Feb 2024 13:40:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707774005; x=1708378805; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=8hiMFMYdTb9wRLf05RpnPyNZaK7+4nxliVbJC61s+/Q=;
        b=Y0GeIRSD/sQtyCg6jEuGRY/zscDgLJsGjhtNEwRnn6feLkvvT4Mv4i8wkACPfN36yP
         zFgRGONnoS3BkKSCfSrmOUP0cJf6zIp0QICjgHEeZE8VL4npmFyM650POiZg79+Vavr3
         qGSyyZ3X4cRfDIXlIS/asEtrUeizUsoULmHFKdWJ+yWALocAD5Jgku98McF73Ftvsbmd
         ZfXWW9mFK+l6eO71R73g/fr8GeZyJZWybCqK8GzeahmVM+JBKwEhjWAu9l/B0ssez4+N
         OnA7kzqmvHJkPThFpznnwu/XWLyBgFYcLVnriRwXVXMlicz9Ofs4pgHSmW1zx4fPKchd
         tsfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707774005; x=1708378805;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8hiMFMYdTb9wRLf05RpnPyNZaK7+4nxliVbJC61s+/Q=;
        b=cYyFgDEUZLevgi6SyZn4/ISpOTT0/Fblo6PPFWI8i7hiQpSdZYkABRbgRAWykeB2I2
         j80fVJgMWkJk4Sd5WGRIHDngJvsQU1XOulQeDcrloDTQJRgryr9ou6vIKk5o1fKTEv+f
         I8sPOSfYtnpvn20KWIQT56b6ZnPiEfBzb4IE151x5cPe52pZ5MCzMd6QKCsnnqjF7Rqu
         eXvLZa++kvwjMCHHDDPbAgkjmh9ukZK344KS5DwaRQOmlzz0lQqbs/S5FALB8odDHbm0
         mTN+9w9yaIt6XM5sNFVm/ShuczfLZEpIzbx0s9L0yfQu3zeOP5iuhsgChfmq9gHB6pFN
         hAug==
X-Gm-Message-State: AOJu0Yy+a06aWDLXJjJG1Eh94VJNvqqIjfUrSLW4huwSbMFyqrqcv8If
	a8zaZB0RQbJgQ3HA1ZJ38Lzq4jN4oFZhghNiA1FA2f2IcARFhYgP+jPMfB1zRnGGBIUoiGIk5DV
	grQ==
X-Google-Smtp-Source: AGHT+IHMymVhDhc3vqzIXqR7wXKts/Huwxqw8epMlcUK6WIr6/J3gYxRwjZRSc5OiXO09TM/bRBKSIcClBs=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:b848:2b3f:be49:9cbc])
 (user=surenb job=sendgmr) by 2002:a0d:d650:0:b0:604:7b03:4223 with SMTP id
 y77-20020a0dd650000000b006047b034223mr2206277ywd.2.1707774005345; Mon, 12 Feb
 2024 13:40:05 -0800 (PST)
Date: Mon, 12 Feb 2024 13:39:01 -0800
In-Reply-To: <20240212213922.783301-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20240212213922.783301-1-surenb@google.com>
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
Message-ID: <20240212213922.783301-16-surenb@google.com>
Subject: [PATCH v3 15/35] mm: percpu: increase PERCPU_MODULE_RESERVE to
 accommodate allocation tags
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

As each allocation tag generates a per-cpu variable, more space is required
to store them. Increase PERCPU_MODULE_RESERVE to provide enough area. A
better long-term solution would be to allocate this memory dynamically.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Tejun Heo <tj@kernel.org>
---
 include/linux/percpu.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/percpu.h b/include/linux/percpu.h
index 8c677f185901..62b5eb45bd89 100644
--- a/include/linux/percpu.h
+++ b/include/linux/percpu.h
@@ -14,7 +14,11 @@
 
 /* enough to cover all DEFINE_PER_CPUs in modules */
 #ifdef CONFIG_MODULES
+#ifdef CONFIG_MEM_ALLOC_PROFILING
+#define PERCPU_MODULE_RESERVE		(8 << 12)
+#else
 #define PERCPU_MODULE_RESERVE		(8 << 10)
+#endif
 #else
 #define PERCPU_MODULE_RESERVE		0
 #endif
-- 
2.43.0.687.g38aa6559b0-goog

