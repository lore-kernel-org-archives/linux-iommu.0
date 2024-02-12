Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A5274D584
	for <iommu@lists.linux.dev>; Mon, 12 Feb 2024 22:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707776061; cv=none; b=mZ6XtDUY7AalJOZBXRRtlDbBcSxq0LReXzfEiZJ0NOrZAngk0QGLcT6hdWzIKyCZbnz6jO0HSy+Px+wciAjviLmMqIVEhTy4hScHJJNln9EjGty4caM/oZWCas6u/DC6Ev5LMmBoM1S5T1CU/eMGIy8nZV5NGnSPjDWze292Bso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707776061; c=relaxed/simple;
	bh=16fk7xoE50+bBNfgxcCm+Ee3v/cfVODmJmytJVNx6ZE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GrHbvcKNIN1rY3MkU1RyEzYMwcQ35g5PqZavSX34QYzH6h5hkbFM2XUY2dUHp50eULBSDpKa7tti2P5knNv7kxXfz/uC0due9XQTwSf/O8rXXRNXZNvJzVAvzkFrWTtagSQf1y/WfCyTd/ujPa39jmSn6TqYMC4ghWmBgmi8CHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=A/KFg6SM; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="A/KFg6SM"
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-6e2e44aad03so943636a34.2
        for <iommu@lists.linux.dev>; Mon, 12 Feb 2024 14:14:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1707776057; x=1708380857; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wZiXjxKnrMyz6iBNN8FZ/8Z5umOyXaSKjAB1K7uHil4=;
        b=A/KFg6SMnOewFLZDT6JQMo30CqS9nx1oXzyeHt+n3Z6GPS3OXYty8bQi5iHdpqgEqc
         wfzcWTgfFv1L2Erd6Mr1rTT1MTzw31+BuBBVXVsdGfNqTF0KX7u6Buj4KcPSDu3kCqIR
         xvfKyLdPOIUj28pmL7Xf4Kv3SQH/6cic3sObM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707776057; x=1708380857;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wZiXjxKnrMyz6iBNN8FZ/8Z5umOyXaSKjAB1K7uHil4=;
        b=WcH973w+XT+mmaKJmRvi79fEoDvzWdDtu0C3E8TIm5BDt8Y1Ji1Ln/N/HCq7U2WcVD
         n7M4uq6ON5eYCp1aSRCzXr504sbn8z4Es6nCK0N91XxQT79xTECOt6xWe3us39NQn4pT
         SEFDjpVkl1Y3R/NKbkfRVcMFYhS6evdnw9vNmBcvGLh7XGg0DsA2zrWLNnkXuHxZxNQx
         nUO+BROi8bz1RhNXVllR6d/hJcyoctMlLllCHMS/GRlmrGtGc768wYf6xu8lF6gtdlnU
         CB3L8gumeTTPdv+OjG5nx9U/2Cp9Gh1F7uRyBJd4VWd9Or9S38LKWGre0SmUdtwwoKJm
         qOMA==
X-Forwarded-Encrypted: i=1; AJvYcCU66XiTSe8yxHzymKpjcCyc5L/OCaTYECoCzpgr5vilH5/H2ZF6tLznXEcIKAyd/ioYhXIPwMtNAWrG+NB2iqE4RHsy7WQ=
X-Gm-Message-State: AOJu0Yx6yVxvAIc3VBGQ75Q4p8XDEd+j6tVmD0xBycQxJJzDx0L56BMS
	PZbTnfi9aFTXSV/VaWHtHnM27BwWvEi7MIwvOlDpA0qYP2zHbhp08Wqcv2yb5A==
X-Google-Smtp-Source: AGHT+IFJECsPbCNbGliZWvIYHRL4c/uXXAZZuCyqsAn1ZVqvZdYBLBf67fObnnMqVDNeWoqRd4Gw6Q==
X-Received: by 2002:a05:6358:7e41:b0:17a:ec8c:72cd with SMTP id p1-20020a0563587e4100b0017aec8c72cdmr2085486rwm.16.1707776057707;
        Mon, 12 Feb 2024 14:14:17 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWg3dML8VKifNsHk2CVNShk758+NTmByKLZI72E1V2q4Wu9oUmJYkccV4vQiDGOQgADidt5TguGkvh7V4YwOg63GLUryvPiyAQ7f48JUGKHk5FmbcUkOWNBC3Ux7+ARsfis4drosOSrq4FcO2E/nb4nKPd5tTo1IpF7Z2ZQEg+WFRPMypAJ1e34DAT+XFI/el7dGRYPGKNGvKQ6aS8/NETGtgnEw4gK8U9U1Hv73eJqHAkKRRk3J8Ph4Ck//KLXOSNRvO+rAIzUOniypVv1/4JK6yXaykyMLrjMOY39G+2fpgxPBGFw3nZ/LH0KQIjw0EkWhY3rJoqcS/NUxqyJmBf0+SxOykkUoB0LcAsReO1NjiWu0KRnzfLjhQG17Mx1k6lSx7ZZighHq1IIEqMNKmrf+vg0gcVHjQdB9dMPLIKL8hpNfHfvE4J6f62rNrCDo8Bd7E53U+GZrPnL0LkHPW+og8Hr772ylPjBjfFLnALXxOiqaNCPEiXgFsI4tlEu7NYq0RiV8tZ22FLSM13tuC21ckHIWSqolHrrEG281jvnKKCQqMQuN+O/NTCkXba09zfBsvtBX8T2lqUmkKdD00zzZRvUtnr587FITudCjm3qCRbvrPscljCRS1dQo3iBQh8Zy18C+pJxaLHX0SyV1nKKQzyumJgyrZRPaWmuLpyLmJijRnh1cQeWSVGBxt1Wxl7ZPOvMuLO8rM6/m1ZJffXJtGOBjfOlZIyZ/d2SeZ/s9b2tmn7hjA==
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id le22-20020a056a004fd600b006e0a30c8c8dsm5334232pfb.117.2024.02.12.14.14.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 14:14:16 -0800 (PST)
Date: Mon, 12 Feb 2024 14:14:16 -0800
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
Subject: Re: [PATCH v3 05/35] mm: introduce slabobj_ext to support slab
 object extensions
Message-ID: <202402121413.94791C74D5@keescook>
References: <20240212213922.783301-1-surenb@google.com>
 <20240212213922.783301-6-surenb@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240212213922.783301-6-surenb@google.com>

On Mon, Feb 12, 2024 at 01:38:51PM -0800, Suren Baghdasaryan wrote:
> Currently slab pages can store only vectors of obj_cgroup pointers in
> page->memcg_data. Introduce slabobj_ext structure to allow more data
> to be stored for each slab object. Wrap obj_cgroup into slabobj_ext
> to support current functionality while allowing to extend slabobj_ext
> in the future.
> 
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>

It looks like this doesn't change which buckets GFP_KERNEL_ACCOUNT comes
out of, is that correct? I'd love it if we didn't have separate buckets
so GFP_KERNEL and GFP_KERNEL_ACCOUNT came from the same pools (so that
the randomized pools would cover GFP_KERNEL_ACCOUNT ...)

Regardless:

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
