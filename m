Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDEF813777A
	for <iommu@lists.linux.dev>; Thu, 21 Mar 2024 16:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711039067; cv=none; b=XIOUnsGq30vvycn7pDmpkAjBfaL5x4N4gzQPnX6hmabOl0JiVtisSvDcciO+Gy2VbmgoN6o9iCLeLJ2smeBB/xOa92IdS8qHUl0osXWzQ/z9QRnG62M22m0dEzbYwbEZwBOKD681o69ejA29/9yL65WIkA7vlcTp96JM1ZOIOwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711039067; c=relaxed/simple;
	bh=8zCwJvSNaJ7p3GYWvtF+uEjaWu4osVUHKZZpZlUWdhc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=NJzh4OycLgFKxDyQjgGWl4FZwsLs+NvZvpi9yxn8ESvbmWc+NINUUnnAwinwSZ60kq1Xq2hlrzoKQfnAoSP2v4Wzf82R0BQYlgEr0ona3S4v362ren2qDMbY3drMLMQzqPy7A46haKAHYT8OcsNjf0TEI0Z722aBVPrJFS7cD/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qrl65L1c; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qrl65L1c"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-60a2386e932so22617947b3.1
        for <iommu@lists.linux.dev>; Thu, 21 Mar 2024 09:37:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711039063; x=1711643863; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=BfPuXrQNw6sP43MOvy7juBQZEF5XCZI3rVOwMSUBcyU=;
        b=qrl65L1cZLo6UDHN4mQQWvF8Nu0ycmv3atftbZOd0y6PMiSAaDHWrP1+b6rsNW0D82
         Dazl6WzeeBDhy8g8UTVkP2FWrhFH6HXALlYruMJWglxkNAyWr9h+HQajmNOisoJC/iX1
         4esoZVZeO9d3s//cVvdKBbewGaUQ4t8UQhPsh0ltkw0v9xnRQ0/jh5LTRhHVLEJrhIyU
         RCCqeygoeZvtIi90j8xZ1Cej3tXEe1qrxen2gKwYcb5spEFxnXkErVnxPVsgatYpqWKl
         3bK4kTv/Y8upyRMSJYXIcwGZoTbNJNhWrPGLKPzjnGtP9LNZhk0uRexdJ0s3Ep/ZSWd2
         9Tyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711039063; x=1711643863;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BfPuXrQNw6sP43MOvy7juBQZEF5XCZI3rVOwMSUBcyU=;
        b=N3IQv+OB5lxpMFMi5tBMbCEVZRCUK5HbIBP/fetvUnOqbIv0jN1sCik9UZfSigLFRg
         3TwfAjLNcd1rFxKDKjTC6RC4fcDajXsuN6bwsLSHVkZisB8bFxt4GfuJWjnLyNDqwuMl
         Ogh/n72JZiSGt0Qf+Lr5rQ7iGjFZYrjWfbeRu/NJC4H2eD+U06e6wns131nWYz821O0s
         F7Rm0Ch9f5HI7MD45UkYEPqByvK7enUh2UF5LXE7GV7lB73SBO6XZgAUPJ2qw8qOsJPz
         vJgLt8YeFCrvoayUOeJB7IirUryyX9MDAbUapKaLG+E5neVy5kQqAVX9oMeoRgAM/Syv
         Tdvw==
X-Forwarded-Encrypted: i=1; AJvYcCXum2YNQU7YUXYrV8THGrastqBdS341NQTUMbWJpwFzwblVnuK+eYsLtTWSib0jfVZYHkCYsTKKj/dDmt+0UoVc9L/CKTI=
X-Gm-Message-State: AOJu0YwWEqEUL495hKHq1iWaHeclcdWSAMZbThykxOblLlX6KOMG9EKe
	guFTChKrX0obku5UAfEyDdlzkJxH0IbzltW4Vj/5Ig86cc0z4SLFaodlOF8G6t7NExm//O1ULQj
	ZPg==
X-Google-Smtp-Source: AGHT+IF0jEtLINTH4On1VBGvIr2Jc0SGzS38YLdjNwaqc8VhKxt4NeXt5PC/R2alQ3iBswciTecJTdFY/QM=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:a489:6433:be5d:e639])
 (user=surenb job=sendgmr) by 2002:a05:690c:39b:b0:60c:d162:7abc with SMTP id
 bh27-20020a05690c039b00b0060cd1627abcmr2322702ywb.1.1711039062719; Thu, 21
 Mar 2024 09:37:42 -0700 (PDT)
Date: Thu, 21 Mar 2024 09:36:37 -0700
In-Reply-To: <20240321163705.3067592-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20240321163705.3067592-1-surenb@google.com>
X-Mailer: git-send-email 2.44.0.291.gc1ea87d7ee-goog
Message-ID: <20240321163705.3067592-16-surenb@google.com>
Subject: [PATCH v6 15/37] lib: introduce early boot parameter to avoid
 page_ext memory overhead
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

The highest memory overhead from memory allocation profiling comes from
page_ext objects. This overhead exists even if the feature is disabled
but compiled-in. To avoid it, introduce an early boot parameter that
prevents page_ext object creation. The new boot parameter is a tri-state
with possible values of 0|1|never. When it is set to "never" the
memory allocation profiling support is disabled, and overhead is minimized
(currently no page_ext objects are allocated, in the future more overhead
might be eliminated). As a result we also lose ability to enable memory
allocation profiling at runtime (because there is no space to store
alloctag references). Runtime sysctrl becomes read-only if the early boot
parameter was set to "never". Note that the default value of this boot
parameter depends on the CONFIG_MEM_ALLOC_PROFILING_ENABLED_BY_DEFAULT
configuration. When CONFIG_MEM_ALLOC_PROFILING_ENABLED_BY_DEFAULT=n
the boot parameter is set to "never", therefore eliminating any overhead.
CONFIG_MEM_ALLOC_PROFILING_ENABLED_BY_DEFAULT=y results in boot parameter
being set to 1 (enabled). This allows distributions to avoid any overhead
by setting CONFIG_MEM_ALLOC_PROFILING_ENABLED_BY_DEFAULT=n config and
with no changes to the kernel command line.
We reuse sysctl.vm.mem_profiling boot parameter name in order to avoid
introducing yet another control. This change turns it into a tri-state
early boot parameter.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
---
 lib/alloc_tag.c | 41 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 40 insertions(+), 1 deletion(-)

diff --git a/lib/alloc_tag.c b/lib/alloc_tag.c
index cb5adec4b2e2..617c2fbb6673 100644
--- a/lib/alloc_tag.c
+++ b/lib/alloc_tag.c
@@ -116,9 +116,46 @@ static bool alloc_tag_module_unload(struct codetag_type *cttype,
 	return module_unused;
 }
 
+#ifdef CONFIG_MEM_ALLOC_PROFILING_ENABLED_BY_DEFAULT
+static bool mem_profiling_support __meminitdata = true;
+#else
+static bool mem_profiling_support __meminitdata;
+#endif
+
+static int __init setup_early_mem_profiling(char *str)
+{
+	bool enable;
+
+	if (!str || !str[0])
+		return -EINVAL;
+
+	if (!strncmp(str, "never", 5)) {
+		enable = false;
+		mem_profiling_support = false;
+	} else {
+		int res;
+
+		res = kstrtobool(str, &enable);
+		if (res)
+			return res;
+
+		mem_profiling_support = true;
+	}
+
+	if (enable != static_key_enabled(&mem_alloc_profiling_key)) {
+		if (enable)
+			static_branch_enable(&mem_alloc_profiling_key);
+		else
+			static_branch_disable(&mem_alloc_profiling_key);
+	}
+
+	return 0;
+}
+early_param("sysctl.vm.mem_profiling", setup_early_mem_profiling);
+
 static __init bool need_page_alloc_tagging(void)
 {
-	return true;
+	return mem_profiling_support;
 }
 
 static __init void init_page_alloc_tagging(void)
@@ -158,6 +195,8 @@ static int __init alloc_tag_init(void)
 	if (IS_ERR_OR_NULL(alloc_tag_cttype))
 		return PTR_ERR(alloc_tag_cttype);
 
+	if (!mem_profiling_support)
+		memory_allocation_profiling_sysctls[0].mode = 0444;
 	register_sysctl_init("vm", memory_allocation_profiling_sysctls);
 	procfs_init();
 
-- 
2.44.0.291.gc1ea87d7ee-goog

