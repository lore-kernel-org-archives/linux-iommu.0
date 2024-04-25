Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA4F1101F7
	for <iommu@lists.linux.dev>; Thu, 25 Apr 2024 01:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714010344; cv=none; b=qAH85+L3Dz33bZHvfLb+Hgx/okvV3p4L9vdCEJofc0qjTFdWySQ9tDH6LKcXNWUdUNv2hz+VZsg8wE0JZsQGP+rm1Lu0fiLI7E8vUwQ4VtOJPqt+qWIVVMUXqY10PokK8PuivkRl6TL4WNStzWDMjjt6R4vOfzCBQDM8lrAmZA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714010344; c=relaxed/simple;
	bh=p/cGThLZ3QnfmTN7NW9NTr5bcTYchPjUIQ6WCPhs4IQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L7qGIqFE5RJQn4LHzclEYqqwzN0TsERQxOl5LFfzXE0ELiJXABDmPt2N9AuDAks+DuO2usNhcOjhpuxwcbRp8YrDZV5/aHQ6aORm4xA4tULnoJNXJbTpTgcN5menaIK8kqY3EVhgniigScaoPIOszJkHS3Jd6Nch6q2YL5va7IY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=kEDcYNqk; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kEDcYNqk"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1e8b03fa5e5so4183215ad.1
        for <iommu@lists.linux.dev>; Wed, 24 Apr 2024 18:59:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714010342; x=1714615142; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=S4qlJ+DG6HoUrdCik4e+F/ZipKmWdndDCcmvcXd31J0=;
        b=kEDcYNqkDU7V7FN1tJU85GrglOrrXCegEm+SeQ2FiiIbaAhE6myIpKm/3qRZZndfCU
         /6PVvFBJQzgrrIPwV70yO4N//3R5P7ARC3XhM7xfVJXk7DlCSBMV45oJtKwB7awN+7c2
         uZAcrqDFe+eONMFKbULr8nK3nMD+ht0o1sf4Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714010342; x=1714615142;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S4qlJ+DG6HoUrdCik4e+F/ZipKmWdndDCcmvcXd31J0=;
        b=kal4bn72WTAmeYPC+JM5k6J7DA0v+si+i+ykzkALW0pZlweObOiY63/dLd+H33tO/8
         a/7BrArmFBs9YPJuXIG7TMDrVV22jp4J1df2P+n/8znjyBN4Rrcj1i9sfexAoxx6e63C
         s4oVfhJNW+m5Lob9OHoPcE9Dd+mxvcR3FcdPBJjahliFkOchcD2oxdzaYRV1hRGvkpbh
         r1XafrTIwa8ptEj2WUghaZZFRIr9pRUe15ewKCk6n9TMeCrZz6D2xMx+8mfmqb1qw0/4
         sL31jQvNPfJT8K79mC87QqIDIKT5BPZEoRi9S4MnjQ37s+MH3cfp1/n5Y6bp0VrGxS1A
         hDRQ==
X-Forwarded-Encrypted: i=1; AJvYcCUjNrvGItUwPVFDyNMkU0TVyboZIF8ePJ32sCPaiwngJNtLvtfCDMAw0SC6KGvciZFRb25uCAPlgxnPCsLTYBmGgts5loU=
X-Gm-Message-State: AOJu0YxH0NidFHIqm1T3KbIyAFmclqi0kRMoKJ+V+Uv+BISpLMPact85
	uvfbb5yi2qJyJvfu+Zyen81UQ0ZaJwviVQ8VcmzU2Va2oDJDNgMWGLqAfx9jBA==
X-Google-Smtp-Source: AGHT+IFgnziqKVsPlDFcaVY3O1lcKny/l/El36yYFOjaOKnKn279lG8Ph9ngGazPAxyRWX6j+oUVIg==
X-Received: by 2002:a17:903:2290:b0:1e8:92:c5e2 with SMTP id b16-20020a170903229000b001e80092c5e2mr6592452plh.47.1714010342304;
        Wed, 24 Apr 2024 18:59:02 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id g2-20020a170902934200b001e25da6f2f2sm12553004plp.68.2024.04.24.18.59.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Apr 2024 18:59:01 -0700 (PDT)
Date: Wed, 24 Apr 2024 18:59:01 -0700
From: Kees Cook <keescook@chromium.org>
To: Suren Baghdasaryan <surenb@google.com>
Cc: akpm@linux-foundation.org, kent.overstreet@linux.dev, mhocko@suse.com,
	vbabka@suse.cz, hannes@cmpxchg.org, roman.gushchin@linux.dev,
	mgorman@suse.de, dave@stgolabs.net, willy@infradead.org,
	liam.howlett@oracle.com, penguin-kernel@i-love.sakura.ne.jp,
	corbet@lwn.net, void@manifault.com, peterz@infradead.org,
	juri.lelli@redhat.com, catalin.marinas@arm.com, will@kernel.org,
	arnd@arndb.de, tglx@linutronix.de, mingo@redhat.com,
	dave.hansen@linux.intel.com, x86@kernel.org, peterx@redhat.com,
	david@redhat.com, axboe@kernel.dk, mcgrof@kernel.org,
	masahiroy@kernel.org, nathan@kernel.org, dennis@kernel.org,
	jhubbard@nvidia.com, tj@kernel.org, muchun.song@linux.dev,
	rppt@kernel.org, paulmck@kernel.org, pasha.tatashin@soleen.com,
	yosryahmed@google.com, yuzhao@google.com, dhowells@redhat.com,
	hughd@google.com, andreyknvl@gmail.com, ndesaulniers@google.com,
	vvvvvv@google.com, gregkh@linuxfoundation.org, ebiggers@google.com,
	ytcoode@gmail.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	bristot@redhat.com, vschneid@redhat.com, cl@linux.com,
	penberg@kernel.org, iamjoonsoo.kim@lge.com, 42.hyeyoo@gmail.com,
	glider@google.com, elver@google.com, dvyukov@google.com,
	songmuchun@bytedance.com, jbaron@akamai.com, aliceryhl@google.com,
	rientjes@google.com, minchan@google.com, kaleshsingh@google.com,
	kernel-team@android.com, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, linux-modules@vger.kernel.org,
	kasan-dev@googlegroups.com, cgroups@vger.kernel.org
Subject: Re: [PATCH v6 00/37] Memory allocation profiling
Message-ID: <202404241852.DC4067B7@keescook>
References: <20240321163705.3067592-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240321163705.3067592-1-surenb@google.com>

On Thu, Mar 21, 2024 at 09:36:22AM -0700, Suren Baghdasaryan wrote:
> Low overhead [1] per-callsite memory allocation profiling. Not just for
> debug kernels, overhead low enough to be deployed in production.

Okay, I think I'm holding it wrong. With next-20240424 if I set:

CONFIG_CODE_TAGGING=y
CONFIG_MEM_ALLOC_PROFILING=y
CONFIG_MEM_ALLOC_PROFILING_ENABLED_BY_DEFAULT=y

My test system totally freaks out:

...
SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=4, Nodes=1
Oops: general protection fault, probably for non-canonical address 0xc388d881e4808550: 0000 [#1] PREEMPT SMP NOPTI
CPU: 0 PID: 0 Comm: swapper Not tainted 6.9.0-rc5-next-20240424 #1
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 0.0.0 02/06/2015
RIP: 0010:__kmalloc_node_noprof+0xcd/0x560

Which is:

__kmalloc_node_noprof+0xcd/0x560:
__slab_alloc_node at mm/slub.c:3780 (discriminator 2)
(inlined by) slab_alloc_node at mm/slub.c:3982 (discriminator 2)
(inlined by) __do_kmalloc_node at mm/slub.c:4114 (discriminator 2)
(inlined by) __kmalloc_node_noprof at mm/slub.c:4122 (discriminator 2)

Which is:

        tid = READ_ONCE(c->tid);

I haven't gotten any further than that; I'm EOD. Anyone seen anything
like this with this series?

-Kees

-- 
Kees Cook
