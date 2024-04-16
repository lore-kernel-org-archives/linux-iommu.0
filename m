Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56B34137C35
	for <iommu@lists.linux.dev>; Tue, 16 Apr 2024 19:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713295662; cv=none; b=hLfxCYmLUrw/1ELuGc4L+Fv4TAGV5ZaviOfM7FwZB9hiC5Jj5o2AeOTih03wu8/KPebZCj3WZNy2Of3NmdRuKbDUEMz1O2ZqN9d9UKgkCCdYdBxim8niHddLnT1et7xXogjuUmZjumGW726oNyAgEIIuXV0yMTsv5ZMssYQQmJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713295662; c=relaxed/simple;
	bh=RufGQt9my60Mib6mWU1jcDTJNb1IE0wkA2B8tPsK8us=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Wt+WHb8iZLfof4EODLb0zmfTumjTRAvREyuGbyrYsxegePws+YMRElTUXwtxum8rJIIbmMb13yspPGNdTLqTWA/wln0KG3d+a3ddmfwlw4AbtVCwgSpv6c7sChvR7N4EF0v+/MAecT6RkwfqKx22hJpGcUSz/iiT+5A3fGp8xkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--souravpanda.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=04DT4SiV; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--souravpanda.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="04DT4SiV"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2a49440f7b5so4438333a91.1
        for <iommu@lists.linux.dev>; Tue, 16 Apr 2024 12:27:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713295661; x=1713900461; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=KsLs5TwgQbCoTsIhV0PbmPPMuBa5UPbtwmIm4dUFoNk=;
        b=04DT4SiVFMHym7k+EBBV1Sv/8fHUdsKYGG2ZCx2r32n6uyVTTV0fWYs01FzTH1NxB8
         Wz38xyDcxa+7yG5HH04xtb+eIt9RcJRvNBCwkI5DWhkc8o9ZmGCe77/7mPBThDTymSjA
         ZF14yGBPmzRS37yru1BV6KC3Es1iYu32bq9oxu3TFQkTZotOSjwX/Sga+rkRdo91xZ+n
         YiIXKbKRTkrBnYyzgTxA5XpIusiFYaMC7Nt4ZJvfyBY/FOr1l5nTb7i/hPbDyMNjZTxD
         ull1HLzieMtP6yg0rs+XT7HUyXJkqAMjgTUMbhik2Eee3ONEXnYOQYQwjwthrzW1XStw
         Qh6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713295661; x=1713900461;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KsLs5TwgQbCoTsIhV0PbmPPMuBa5UPbtwmIm4dUFoNk=;
        b=DmWAhSVeL4FrBkpyHbq4QLYNLC582PP8hAUrqHrg/NVuR5rU+sKYn0CouDDO9AGISI
         t8ErwYMINiNcL33liuVyXHCpPgqvlo6xyowCl1vXiUjQW0Ryrs8bmfI7SF4CFe690xov
         vDdd2Zt59DBQt2xqTWXJc77gSYAWn4DIAWFbIFK/7UzEZBXx3i7M0Bakc9PFLY5zaT0q
         /b/M2IqP6oHhkY/cO8e1FoNAVrSkO6KDHFNhWIOhslMwmVC14zdGHJZWmqodaP2IjtQq
         6AikbZEs34aVusHeJnnt6TDLoQy4UG3ddlY4L0zyzaxMGvxsxfhPIfwUGvl4gAZBQIrU
         NChA==
X-Forwarded-Encrypted: i=1; AJvYcCUjPjM1NMK3zDkCjsbzRNKyCjAAlTySruXZcaDyGMLlSeJab9OYsi8dJNNrmYyjHFqAG8qUnR0URLmW2GHcwg+vIGcZuWU=
X-Gm-Message-State: AOJu0YwjftoyrZ/yEJ23VvCs9xb+qbE+H4XTITRAKJ9t+7RT9T2zR1Nj
	IO0qaHLc6ngjpwYoL5o24XqcLqXtIaoQdeQD8vrzpiMJu8qC6RDHx7ui+jOisikhG1Kpqb7Vson
	bn6Kg0nRQV0dFv/73wQNRzQ==
X-Google-Smtp-Source: AGHT+IED/ON5W+u4mp98k4aqr7W8SbX1tGPdGimAJ5/wpGhdwwYIMlKzk0LXAacFJYRY3XXR8O+beFOD5S0sddsmYg==
X-Received: from souravbig.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3b3a])
 (user=souravpanda job=sendgmr) by 2002:a17:90b:3bc8:b0:2a2:8b25:745e with
 SMTP id ph8-20020a17090b3bc800b002a28b25745emr87242pjb.0.1713295660670; Tue,
 16 Apr 2024 12:27:40 -0700 (PDT)
Date: Tue, 16 Apr 2024 19:27:38 +0000
In-Reply-To: <20240321163705.3067592-31-surenb@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20240321163705.3067592-31-surenb@google.com>
X-Mailer: git-send-email 2.44.0.683.g7961c838ac-goog
Message-ID: <20240416192738.3429967-1-souravpanda@google.com>
Subject: Re: [PATCH v6 30/37] mm: vmalloc: Enable memory allocation profiling
From: Sourav Panda <souravpanda@google.com>
To: surenb@google.com
Cc: 42.hyeyoo@gmail.com, akpm@linux-foundation.org, aliceryhl@google.com, 
	andreyknvl@gmail.com, arnd@arndb.de, axboe@kernel.dk, bristot@redhat.com, 
	bsegall@google.com, catalin.marinas@arm.com, cgroups@vger.kernel.org, 
	cl@linux.com, corbet@lwn.net, dave.hansen@linux.intel.com, dave@stgolabs.net, 
	david@redhat.com, dennis@kernel.org, dhowells@redhat.com, 
	dietmar.eggemann@arm.com, dvyukov@google.com, ebiggers@google.com, 
	elver@google.com, glider@google.com, gregkh@linuxfoundation.org, 
	hannes@cmpxchg.org, hughd@google.com, iamjoonsoo.kim@lge.com, 
	iommu@lists.linux.dev, jbaron@akamai.com, jhubbard@nvidia.com, 
	juri.lelli@redhat.com, kaleshsingh@google.com, kasan-dev@googlegroups.com, 
	keescook@chromium.org, kent.overstreet@linux.dev, kernel-team@android.com, 
	liam.howlett@oracle.com, linux-arch@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-modules@vger.kernel.org, masahiroy@kernel.org, mcgrof@kernel.org, 
	mgorman@suse.de, mhocko@suse.com, minchan@google.com, mingo@redhat.com, 
	muchun.song@linux.dev, nathan@kernel.org, ndesaulniers@google.com, 
	pasha.tatashin@soleen.com, paulmck@kernel.org, penberg@kernel.org, 
	penguin-kernel@i-love.sakura.ne.jp, peterx@redhat.com, peterz@infradead.org, 
	rientjes@google.com, roman.gushchin@linux.dev, rostedt@goodmis.org, 
	rppt@kernel.org, songmuchun@bytedance.com, tglx@linutronix.de, tj@kernel.org, 
	vbabka@suse.cz, vincent.guittot@linaro.org, void@manifault.com, 
	vschneid@redhat.com, vvvvvv@google.com, will@kernel.org, willy@infradead.org, 
	x86@kernel.org, yosryahmed@google.com, ytcoode@gmail.com, yuzhao@google.com, 
	souravpanda@google.com
Content-Type: text/plain; charset="UTF-8"

> -void *__vcalloc(size_t n, size_t size, gfp_t flags)
> +void *__vcalloc_noprof(size_t n, size_t size, gfp_t flags)
>  {
>  	return __vmalloc_array(n, size, flags | __GFP_ZERO);
>  }
> -EXPORT_SYMBOL(__vcalloc);
> +EXPORT_SYMBOL(__vcalloc_noprof);

__vmalloc_array should instead be __vmalloc_array_noprof. This is because
we would want the more specific tag present in /proc/allocinfo
