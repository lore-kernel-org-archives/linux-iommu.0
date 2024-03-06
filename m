Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ADB1146006
	for <iommu@lists.linux.dev>; Wed,  6 Mar 2024 18:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709749520; cv=none; b=Nv2+jgR11FWTPTO+I/CmoS9PXgpQlEHMP09MooRikzD79yUKf/RYTpB7MG4Rl+BmZUDwgnSMojdjQwoZjIGGUl4vDxPgDFJG0bfTsPUrdl2db12Y7fMV/xEFz4rkJaBBc9+KfhqJeTW5mEJdrc23USrNj/ue/bbzv27HwezL5Jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709749520; c=relaxed/simple;
	bh=Dv0eI32ABhCg/c3ioBN2YUnGdkO8o8M10k34MMBgAyw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=MExvuqk5jiIsSZKUNdDJXH5c+7EgWKDC4NMM9EvKW5gaCYqBcK5QwUpmXnMIlM10r9hb9gEJwQxUdOxxeEeIggheXGO8uPRKUj8gSIh7ieWNFYB8xAgueYOef4EIvWsGVqI0jdRN2VVt7Yn9a12jfYVUUGpjsI2D3UZBVq6x2Hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bR12Q2jC; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bR12Q2jC"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dcd94cc48a1so11324395276.3
        for <iommu@lists.linux.dev>; Wed, 06 Mar 2024 10:25:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709749517; x=1710354317; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=bHZwja06se4PI5NvmXw6g0w6FqOSRgAaf+Zh29a7Axs=;
        b=bR12Q2jCAMNiDPq8EPtoaHguodBbK5a/UrVM6ElqylzZYTqc4oCmwywC5w86f/+0C2
         lv9DaCRjVCDWwy4TvkQ0jtpJOviJBvwPsH+bbT+DkywPd4cpSrJ9Evrp1oq4HUz3j0Lo
         XOvN6cTm6SEpocPZN+FXjd/AfS5d2IvbgrSM2TzofWUEvUXoOyYPNmpOXoYGSwa5aOzn
         f0rT7ZH2GWoIv47UsseZjgb5fjVxVCO301rtrY7Uiobw0Al1bXhFr6q1VWCM6vSLEuOe
         4MWMRdt+XB+8kYjuAaaFJRk325KZcOlyuT950Eij7icTuBy14q9C5lcBy83Rqi2N4jZr
         kpcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709749517; x=1710354317;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bHZwja06se4PI5NvmXw6g0w6FqOSRgAaf+Zh29a7Axs=;
        b=ENLIfjSZ0Og/nTa2pikEh+Kr45XwPbLqIcrMmMlqapAEYZrhIFTNASDa8yOHQGdcS/
         jX6BWOPBavpkMLaxiFrvqEG03HlmTY+iInM35lWcElnxAUleneRon1g+ar+sPkwe3X/G
         9WG1dQOyy2td67kgauZ404/75SFDgA4BcjZZXK2sWiG1AT47fbkEDJzn6LwjbWuro7ii
         Lj413STI3KvvS7oLoSyw8RiSYOXfLXDwd314rOn/WjaPvj1caXe3CtCQwQ3gKLQHu6uC
         1zxLgCw527bcgQMVO6tZnp6Y17QQf7pp04Tiobwl/bkU8mDHsSvUbygknuC04bgigo0o
         1pjA==
X-Forwarded-Encrypted: i=1; AJvYcCXi10DST2YjNMKOiqFyoBnCgLahBvpWjnMC04YN40hrZ0yslxSMuKUbh4dx/IHKsJcWGRl+0/9g345/sT4vAL1GWAJUA80=
X-Gm-Message-State: AOJu0YwLvkoraJiSQJgyUx0LmsM9/DaBUXrkSV1mLec82/P06iM1VIeW
	pDEWpcvL2FlGihnajHqhsGZ5thymTEQS4HnUdeTmj5NTV2NrfZm2tarvrzATlth1u6E9iNXb/SI
	7PA==
X-Google-Smtp-Source: AGHT+IEY0dq37W/YL8K/UAYJglAS6s8iwOM7lJC17R20EwJUoGE14Vwyo3M1UA8Agcy0JGlj8awomXhRYvE=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:85f0:e3db:db05:85e2])
 (user=surenb job=sendgmr) by 2002:a05:6902:18c9:b0:dcd:5e5d:458b with SMTP id
 ck9-20020a05690218c900b00dcd5e5d458bmr4001383ybb.3.1709749516858; Wed, 06 Mar
 2024 10:25:16 -0800 (PST)
Date: Wed,  6 Mar 2024 10:24:13 -0800
In-Reply-To: <20240306182440.2003814-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20240306182440.2003814-1-surenb@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Message-ID: <20240306182440.2003814-16-surenb@google.com>
Subject: [PATCH v5 15/37] lib: introduce early boot parameter to avoid
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
	glider@google.com, elver@google.com, dvyukov@google.com, shakeelb@google.com, 
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
2.44.0.278.ge034bb2e1d-goog

