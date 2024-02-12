Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B006F51008
	for <iommu@lists.linux.dev>; Mon, 12 Feb 2024 23:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707778883; cv=none; b=owsn8P1AbsmhB9OUvnDJ6wzgHgX7NDL9DFbQPrzby+0vmT7IcPdBeMre59l+1q+bz98AQNbUuPN8O5sExzoPj/R6ZC5MD4Yx4l5yWdwvu6HepSr2NcEm6iVMSPLkD35KvukFYK+QjtFAfe5JXkwi9jHFHlks7owjDM59jpCGKnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707778883; c=relaxed/simple;
	bh=tTpbh5UfZfyy28Rs/Cv2qtnww4MwOrI6Z7e146A9LpI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JeVYs7WV99/bdUwBCceWHjnx6tx4yEe8FaboTVJoMO2foZeRN80oF7LQbFkdCr/c0vlOrRVONCHCWAXyzdBZGV7g99urZkUUjxpcdCK4ACtAjKLusBLHK8bTkrZzzlth6mf24cUgV8YEFLuSOLDttpjnrm/xlAb/4+PzWxKNPDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=LlQmQj2j; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LlQmQj2j"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-6e08dd0fa0bso2545008b3a.1
        for <iommu@lists.linux.dev>; Mon, 12 Feb 2024 15:01:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1707778881; x=1708383681; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FzsjrPnusIaHUIYYiKKdbD1PNR9YsTLIdgA5piLTr48=;
        b=LlQmQj2jIkc3ukOQkXKDUyvfXJwZNtdR6upCz8EGY5ZvviWu6u/6lc3frOro/uLqav
         C1EaVnTrnLJFE/zniKwIhlxT7Un5ndF2cTGR8MMyl/+wB25ZV1NU/dOcSvUeAtiE9XdP
         Rh3IyJvPKZpSJTCWjV5GemYjde8vxOC0vxRA4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707778881; x=1708383681;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FzsjrPnusIaHUIYYiKKdbD1PNR9YsTLIdgA5piLTr48=;
        b=DB4UOo+y509UCJ1z6F2uoPd5bOnazcnKwoFtP4bv3jbfrYAkLm15p8hW/72uZszHsT
         056rjAtQBcsaZVlgMQM+50o0PIdvNChUDEsMLUIcbV9VDP7HEidQ3dDzfT+yXxfte6Yh
         FqexyXS8WMf/TZfCQ6tzKiORyJKVVIT3DfDKNDnucDKeIzUSAWhQVsOwskzxjUx3F4NO
         3GgKXueNS/mtfR+K6coOFZkzIn0M9zP9N87KnGVa0t2Ex5AYgHjfc//cm+lmtK0lbp/w
         fy/YaBf4uFTcFzg91mGCnFJWOfB3RufojcB4Hxq13l4KrEFiqccVYuTZqZdQz24JjtnV
         gAQw==
X-Forwarded-Encrypted: i=1; AJvYcCXuc3XamsjXyLwaxPsUg9SGAw4N5v1eP9ZDoEo5tIKuSM312YoDYAJZDIRZNS5710ZVFoXciZ59GqKm6GpFfn0fPP9HvWU=
X-Gm-Message-State: AOJu0YypwPZERMxkuoHsKfydWr/+zEycILA3Ae9733F8N9pxkmv1JgDt
	Hml+YFrtct/UnY1mT48zIjPoYCextpr3AJz9xcdSJ316dmn8RiNcFM4Be9JtWA==
X-Google-Smtp-Source: AGHT+IHKYkrvWP6pn+Z0bv1j498bkNcTGlpfF62jfvH5sqEIpqwicwiMKjizBBkpoFi7tjdt3fDdpQ==
X-Received: by 2002:a05:6a00:194c:b0:6e0:6aaf:5e57 with SMTP id s12-20020a056a00194c00b006e06aaf5e57mr1150993pfk.8.1707778881054;
        Mon, 12 Feb 2024 15:01:21 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVqPDglaouwlesQHnb43T4Isv16NQxb4dXSRTJuJSE5aNgdLn5NkEJGctOyntILaXZQS0mnDZpLVHN+/xwOB9IoAgg9x0u29PK/IhT7vjo91yIRFcPvoSMBYBFTzt+86JDN1jgMokFHBEXgSllBDYGACxIo0zUFX17bzZBEU7NwjPK5esvpkzsm8ibJaJyYxi2UJsA8zbTPNgaMTjZhnLBqFB+AILhOnQMu3xiK9ZU4f7GtCTbRmKaQQgFh0z0TRcxbJff4bi+eT3yTtwdcnSLjIvBdWA0x+ELkk+GqvBo+wxUIMd3R/SyxCqpTCriDuDr9DirngV3+ShKRVfu2nluGcwRSZfrhSjApbK/fCGIR4/LdLALZhVz/s56pny6O3gcmucfFvYV4odX4ckaTFciS8AJBREeUfEUPAnq8fWaB96nB3adrPIkjaAnXVxmnTdxL5X6oM/t8wis1hvXbcOnobKCN9fFEDPgjNVeA+QNqNhdzD3YRnTrs3sRnZeZs0tuUf0LW4+UtqwmVIsYxmql8pL7fOpAREfPaCHgqX0NFpVieKkvY0fMMnu3nRh0xKbfllsY9sjEzjpCwyZQCJ/CKBP9jT9n6AKjiVTNe50JwZj4ZeSvaC/a6uMZ0lhgP0nfkvvI7EFxu+TtZRjrzuIHn6E+fxmBlhHOCFV79XFx8fJc/wu0AHsf2VzlWSUIzFXGqPnNMDjAzpTzvx/l9cNLUx4eRQl6ExPiTPL5iDDwJCxAOJ7ppGA==
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id r19-20020aa78b93000000b006da19433468sm6077507pfd.61.2024.02.12.15.01.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 15:01:20 -0800 (PST)
Date: Mon, 12 Feb 2024 15:01:19 -0800
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
Subject: Re: [PATCH v3 22/35] mm/slab: enable slab allocation tagging for
 kmalloc and friends
Message-ID: <202402121500.68DFA4A32D@keescook>
References: <20240212213922.783301-1-surenb@google.com>
 <20240212213922.783301-23-surenb@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240212213922.783301-23-surenb@google.com>

On Mon, Feb 12, 2024 at 01:39:08PM -0800, Suren Baghdasaryan wrote:
> Redefine kmalloc, krealloc, kzalloc, kcalloc, etc. to record allocations
> and deallocations done by these functions.
> 
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> Co-developed-by: Kent Overstreet <kent.overstreet@linux.dev>
> Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>

I'm not a big fan of the _noprof suffix, but anything else I can think
of isn't as descriptive, so:

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
