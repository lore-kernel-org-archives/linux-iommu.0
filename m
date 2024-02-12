Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 427F14E1D1
	for <iommu@lists.linux.dev>; Mon, 12 Feb 2024 22:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707778179; cv=none; b=Owd6Mkse0jSmHAnaO9pp2bsKfZtf3we/f46i3uLXLIlO/pUnEANsowRTWAbU8rLXAX1+RJnCmbyb/zmQg6pEsJhLJB8qnyJgnlWVveGr6rTMReqYyo9DD/aEVNs+HsrhnWZJ1IhNSMDqUogfw7Vk6hycEvyZ0LGWJWASYLbx1h8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707778179; c=relaxed/simple;
	bh=jJ7Q+uAzBM/2QUtMSW3fMxfNQj/NahTWX0hTiFl7U4E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YzybgfHh/BND6SP2rEy5OS4e0vSx4wrzYUM4airtxUtHiVYBag2qkaObSWzXatPfCSdcY/B2PycnBDiSYeul6HDUyTp4n8oRP9E22orzJnyfWs3LUZoB9ZJx+4WVxK0tLAs+ldzp4BU4wlGi6pj1ukKBskNi6uiZlzhOsDVnEYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=MFJlgScZ; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="MFJlgScZ"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1d73066880eso34759205ad.3
        for <iommu@lists.linux.dev>; Mon, 12 Feb 2024 14:49:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1707778175; x=1708382975; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xx+E2mv21N0lU1zbrbyeE8PV+0+SQ7K7DmnAXJKKlPc=;
        b=MFJlgScZgadtGZ7DhjjwPbJ8l+NtHPYpFa8teJ+4P4LiAI0CCxdrXZdD0doQJqElNE
         jzRwCbgcHmvWta53SruIB3HIqplvjb3G4yMmEQmY7okgNz3jm/5PdthG+x4o9a5MA+KU
         ZiKxgnMgGx7/qfnoVJvrTPEiXcP9BvvWfTwvM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707778175; x=1708382975;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xx+E2mv21N0lU1zbrbyeE8PV+0+SQ7K7DmnAXJKKlPc=;
        b=fb3Pn/6jUPK3ZCQ/jQ8yA7egXYrKUrgG7euC7mcaK2ut850vNgmIavoC5w1aGk5NHG
         TLC0fA6l+u8RCWo9uK1l3dhGMF3UmBENS4OFYf3AxUjF/XZ+l4jAUAcAhCgCToeR6OQw
         vyI2TXbHmUtG8rPhuQ7FpNpMxNRBTbKqHCVonN6uRoV65QQG4c+35kqpMrZ9bWgrQ163
         uWiIcUdEulvzq70a7TKrzZOEDDy21IDLZDglBhtEEmwhcjqa6EpaAkPNE7wa+fZSEos0
         ExhSKktyBnwBR5zt+Jz01/CsgF7SwobbVbfhz8SmbbieikaUfwiYi5tjf1U5M6fMRkf/
         LOWw==
X-Forwarded-Encrypted: i=1; AJvYcCWhce8qgPwtFqcR0RJj+KwLTSHzxUYZQJHE++swP5NoaW/wdTq7LwolUa5lnzI86cue56csPYUJ9V6j99HG42tb+YwZjXE=
X-Gm-Message-State: AOJu0YxYS47rStKhcuezTg6/exS8y9tg8C45wdbnRa4qJKiN7mt2VA/h
	AzmmEgmruj5cz5Awlr/9Dudaio0cEO5W/V3B5aMK2wsfUJ/BZfxWW8hvJZ/0k+MHPulpbh8zDCQ
	=
X-Google-Smtp-Source: AGHT+IFhdBwz0gkUHXypIGqz/59W5VQq7xXUv7g5AJuySlRLjNX5zZEVE7mi47XR/49TsBREqCstWw==
X-Received: by 2002:a17:902:f54e:b0:1d9:4544:ed22 with SMTP id h14-20020a170902f54e00b001d94544ed22mr9047716plf.42.1707778175450;
        Mon, 12 Feb 2024 14:49:35 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUasX8XpzsSiDZ5/EFiO7pro9PNRyHSQqtLX17pXnFY6qHBIb3d0CatX0NjldJ2PIwuY8MFElGCiBNMf1vy8L++HSYbuXBJ6AZvmBWue0hbc7GGdbfvzgL1xNSjTfM9X5+ku0Yd02eXA1Fb287VhTjN4I3F2u/jh5y1xCVgzJR9RKBSTcdsL3dVakoYqC0QGWEcuLIvThYkH09TucQGniMYD9Hy5lpNpuDkIKRIrZtqX15u2ENuIryu60uAgOeNnkC5z9phPyK8U3UIEyEbopJ6O3xKqIXBCuCXLKQSuMwCOAUdQUY8u0MEx4lSn60txGtd6/rcMmjHo8BlE4D91TT5e/PtYivpmNWde+QdxXxO1g1J8Wxp6AjdZqiQvCuJspekBpiI1yois+s9psLLwVurUsoM08nC9VIoLWscj4RAQo7eqcvr3M/CWVxf2Eqf5S5e7dRIGH/475snDdZDbxLykVvtNsfHe0jxNnhuKfMo/sgOqTnAi4/31NC2A/8ttOA3uIN0T5OED1gvzRtZoCCSI4TE8FmGVQHQT09FvO3sHnVyrkDAVSQn6xJiJwRws4QIv4z+F2OLLPP5Yqumj94miFYqmOEEptLqMEb4FNByAGeMRWfIsD5mNQx16rkqPDgxn774LFEHt6u9Rf4B8f4eRWOBTslPPY54XfDRLRhyP9CZDOq2ZhfiJSPdfj6kiDCOaj+DqIgsHECinmKRBHYLRPse782vR1gbs1q6Ldg0Jn9FP81oaA==
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id s13-20020a17090330cd00b001d8d56a8b9fsm846040plc.105.2024.02.12.14.49.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 14:49:34 -0800 (PST)
Date: Mon, 12 Feb 2024 14:49:34 -0800
From: Kees Cook <keescook@chromium.org>
To: Suren Baghdasaryan <surenb@google.com>
Cc: akpm@linux-foundation.org, kent.overstreet@linux.dev, mhocko@suse.com,
	vbabka@suse.cz, hannes@cmpxchg.org, roman.gushchin@linux.dev,
	mgorman@suse.de, dave@stgolabs.net, willy@infradead.org,
	liam.howlett@oracle.com, corbet@lwn.net, void@manifault.com,
	peterz@infradead.org, juri.lelli@redhat.com,
	catalin.marinas@arm.com, will@kernel.org, arnd@arndb.de,
	tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
	x86@kernel.org, peterx@redhat.com, david@redhat.com,
	axboe@kernel.dk, mcgrof@kernel.org, masahiroy@kernel.org,
	nathan@kernel.org, dennis@kernel.org, tj@kernel.org,
	muchun.song@linux.dev, rppt@kernel.org, paulmck@kernel.org,
	pasha.tatashin@soleen.com, yosryahmed@google.com, yuzhao@google.com,
	dhowells@redhat.com, hughd@google.com, andreyknvl@gmail.com,
	ndesaulniers@google.com, vvvvvv@google.com,
	gregkh@linuxfoundation.org, ebiggers@google.com, ytcoode@gmail.com,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, bristot@redhat.com,
	vschneid@redhat.com, cl@linux.com, penberg@kernel.org,
	iamjoonsoo.kim@lge.com, 42.hyeyoo@gmail.com, glider@google.com,
	elver@google.com, dvyukov@google.com, shakeelb@google.com,
	songmuchun@bytedance.com, jbaron@akamai.com, rientjes@google.com,
	minchan@google.com, kaleshsingh@google.com, kernel-team@android.com,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev, linux-arch@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-modules@vger.kernel.org, kasan-dev@googlegroups.com,
	cgroups@vger.kernel.org
Subject: Re: [PATCH v3 34/35] codetag: debug: introduce OBJEXTS_ALLOC_FAIL to
 mark failed slab_ext allocations
Message-ID: <202402121448.AF0AA8E@keescook>
References: <20240212213922.783301-1-surenb@google.com>
 <20240212213922.783301-35-surenb@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240212213922.783301-35-surenb@google.com>

On Mon, Feb 12, 2024 at 01:39:20PM -0800, Suren Baghdasaryan wrote:
> If slabobj_ext vector allocation for a slab object fails and later on it
> succeeds for another object in the same slab, the slabobj_ext for the
> original object will be NULL and will be flagged in case when
> CONFIG_MEM_ALLOC_PROFILING_DEBUG is enabled.
> Mark failed slabobj_ext vector allocations using a new objext_flags flag
> stored in the lower bits of slab->obj_exts. When new allocation succeeds
> it marks all tag references in the same slabobj_ext vector as empty to
> avoid warnings implemented by CONFIG_MEM_ALLOC_PROFILING_DEBUG checks.
> 
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> ---
>  include/linux/memcontrol.h |  4 +++-
>  mm/slab.h                  | 25 +++++++++++++++++++++++++
>  mm/slab_common.c           | 22 +++++++++++++++-------
>  3 files changed, 43 insertions(+), 8 deletions(-)
> 
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index 2b010316016c..f95241ca9052 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -365,8 +365,10 @@ enum page_memcg_data_flags {
>  #endif /* CONFIG_MEMCG */
>  
>  enum objext_flags {
> +	/* slabobj_ext vector failed to allocate */
> +	OBJEXTS_ALLOC_FAIL = __FIRST_OBJEXT_FLAG,
>  	/* the next bit after the last actual flag */
> -	__NR_OBJEXTS_FLAGS  = __FIRST_OBJEXT_FLAG,
> +	__NR_OBJEXTS_FLAGS  = (__FIRST_OBJEXT_FLAG << 1),
>  };
>  
>  #define OBJEXTS_FLAGS_MASK (__NR_OBJEXTS_FLAGS - 1)
> diff --git a/mm/slab.h b/mm/slab.h
> index cf332a839bf4..7bb3900f83ef 100644
> --- a/mm/slab.h
> +++ b/mm/slab.h
> @@ -586,9 +586,34 @@ static inline void mark_objexts_empty(struct slabobj_ext *obj_exts)
>  	}
>  }
>  
> +static inline void mark_failed_objexts_alloc(struct slab *slab)
> +{
> +	slab->obj_exts = OBJEXTS_ALLOC_FAIL;

Uh, does this mean slab->obj_exts is suddenly non-NULL? Is everything
that accesses obj_exts expecting this?

-Kees

> +}
> +
> +static inline void handle_failed_objexts_alloc(unsigned long obj_exts,
> +			struct slabobj_ext *vec, unsigned int objects)
> +{
> +	/*
> +	 * If vector previously failed to allocate then we have live
> +	 * objects with no tag reference. Mark all references in this
> +	 * vector as empty to avoid warnings later on.
> +	 */
> +	if (obj_exts & OBJEXTS_ALLOC_FAIL) {
> +		unsigned int i;
> +
> +		for (i = 0; i < objects; i++)
> +			set_codetag_empty(&vec[i].ref);
> +	}
> +}
> +
> +
>  #else /* CONFIG_MEM_ALLOC_PROFILING_DEBUG */
>  
>  static inline void mark_objexts_empty(struct slabobj_ext *obj_exts) {}
> +static inline void mark_failed_objexts_alloc(struct slab *slab) {}
> +static inline void handle_failed_objexts_alloc(unsigned long obj_exts,
> +			struct slabobj_ext *vec, unsigned int objects) {}
>  
>  #endif /* CONFIG_MEM_ALLOC_PROFILING_DEBUG */
>  
> diff --git a/mm/slab_common.c b/mm/slab_common.c
> index d5f75d04ced2..489c7a8ba8f1 100644
> --- a/mm/slab_common.c
> +++ b/mm/slab_common.c
> @@ -214,29 +214,37 @@ int alloc_slab_obj_exts(struct slab *slab, struct kmem_cache *s,
>  			gfp_t gfp, bool new_slab)
>  {
>  	unsigned int objects = objs_per_slab(s, slab);
> -	unsigned long obj_exts;
> -	void *vec;
> +	unsigned long new_exts;
> +	unsigned long old_exts;
> +	struct slabobj_ext *vec;
>  
>  	gfp &= ~OBJCGS_CLEAR_MASK;
>  	/* Prevent recursive extension vector allocation */
>  	gfp |= __GFP_NO_OBJ_EXT;
>  	vec = kcalloc_node(objects, sizeof(struct slabobj_ext), gfp,
>  			   slab_nid(slab));
> -	if (!vec)
> +	if (!vec) {
> +		/* Mark vectors which failed to allocate */
> +		if (new_slab)
> +			mark_failed_objexts_alloc(slab);
> +
>  		return -ENOMEM;
> +	}
>  
> -	obj_exts = (unsigned long)vec;
> +	new_exts = (unsigned long)vec;
>  #ifdef CONFIG_MEMCG
> -	obj_exts |= MEMCG_DATA_OBJEXTS;
> +	new_exts |= MEMCG_DATA_OBJEXTS;
>  #endif
> +	old_exts = slab->obj_exts;
> +	handle_failed_objexts_alloc(old_exts, vec, objects);
>  	if (new_slab) {
>  		/*
>  		 * If the slab is brand new and nobody can yet access its
>  		 * obj_exts, no synchronization is required and obj_exts can
>  		 * be simply assigned.
>  		 */
> -		slab->obj_exts = obj_exts;
> -	} else if (cmpxchg(&slab->obj_exts, 0, obj_exts)) {
> +		slab->obj_exts = new_exts;
> +	} else if (cmpxchg(&slab->obj_exts, old_exts, new_exts) != old_exts) {
>  		/*
>  		 * If the slab is already in use, somebody can allocate and
>  		 * assign slabobj_exts in parallel. In this case the existing
> -- 
> 2.43.0.687.g38aa6559b0-goog
> 

-- 
Kees Cook
