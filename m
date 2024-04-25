Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78E9714B08E
	for <iommu@lists.linux.dev>; Thu, 25 Apr 2024 15:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714059592; cv=none; b=Lw+92ywbPvLhvOjpA+HfTSoJDJ69Dd/DGqJdrgKYI0sMfBZaJxUu5DELhPs0aa425upmeeNbG9t1+99uiYpGP44EWv+wpJfPsF7KlZc1yaBXE4SoL1RtlPtBQbSI/fXQlKpDwbQKNlhqR7N/GrrvR85jqwfj5Nx81HaI9K3tqZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714059592; c=relaxed/simple;
	bh=WF+dlvX2I/JhfKIJrRxXQkXnpq+LBXuSxxxOJYIm9Ew=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nUWmx1EWIG6riEXoKOMdJNfSjFyPPUL0wE5d9RNPRW7kUck+e8BHcY75VvkXTI96mPt0HqghZgQaxNAQp5bhxF8OqOTUldYCkFIqHOH6n30+mJmJCT79v3hBgdPcU+NNstmHoXhXs4hHKPhSuh8KbRNaEHzVeXrCT2jQoMlqXb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=G2FLIJ88; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="G2FLIJ88"
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-de45dba15feso1385019276.3
        for <iommu@lists.linux.dev>; Thu, 25 Apr 2024 08:39:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714059590; x=1714664390; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e0BChCss6w1nIzeILAtQLE3LhBpW3YXUB4HhPqTq7zU=;
        b=G2FLIJ88CMcUBQhJ+3/qfqLSKe3mQg7w8c4Uefq7ioSiYt6UwG5HfEstzb4musMjF2
         CTJVEKB85O/cDP2zG9uqv/uGec4d0IDNkD4K4YSzGb6HT/3d+Z3ZHKupgYdCniW8JI9a
         F2p8EZ+Qc2cKSr11nZnCxlDv0CWqBXha45CAKLPNP2oa01bhVEIxk7qNpC6yzovZTAcd
         Spgn32puiNYLNYDH90gE8aYUFDNoKgXHlNmsls2UZNELUPR9Up2E+ll7fKLZa4fTssYQ
         gJiyEEswNLgIvKrl/7I8zrfU+o3Jp4kvFtu/PswqAXLNZMrGG/DIp1YFVKhFEkw+fMYh
         r6Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714059590; x=1714664390;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e0BChCss6w1nIzeILAtQLE3LhBpW3YXUB4HhPqTq7zU=;
        b=tmc6VWlLHSeVNn2r0/p1URHjZLu+WEDyz8ZfczN7b3gL/nw4GehVpgEg8lA8kXg7vr
         SBaTtxkP4z6py79B8M9HTCpPRqGUDIGeIpOc9JsQVwYBOlREoAV7QitRs1lLALgKAt1C
         wwSYUBdqEFCypgYwX92ameyNkl/Z3zR6WQRACF+frM0rhxEtOLa/YglzLCD5KcIak0Qc
         MmPy6iTh2RPK7WT8dYbaJtgJbEQQqPULL9r5GzwgTy+WDPrOS60K3psqZ4NWTPzvL76Q
         SWjCAccA8kk8cLavbepzhHc0pbRpOjNg0CyYKGp+krVnWdYrONxqJ8ILCl/1uL11s+69
         cINQ==
X-Forwarded-Encrypted: i=1; AJvYcCWIsrbKpP4Pg3VogRGxUHvhRRldpSCnvqrKmipanbyW/Ep19wS2JvMBKhr1INf5SSdCO12FYfs3gyQECSjtRlACFQ/K/Rk=
X-Gm-Message-State: AOJu0Ywy3wVrhYZPLKFuBMgJ6AwKAGciizPTNjNZfLD2aTcZhnPLsgwo
	UR7u+BXVV8CF33+C7c5gokTSMZEP1rNSmphJt+Lvi+riX42e1ZNLbE4LtgAMZ6+C4ZCChEHUHnD
	8m8Awaq9zs1ubzyfxYVY24k0IO2AMKyqiULh8
X-Google-Smtp-Source: AGHT+IHMmrQCod73kiqRAvCkDsnHTcOLVG7U0Dhn6OWsLE5Eza4GBBk8ZEiq+Ddus8vlXjyfwMqyLLjmcyn5VeI1piA=
X-Received: by 2002:a05:6902:54b:b0:de1:849:a6f3 with SMTP id
 z11-20020a056902054b00b00de10849a6f3mr5525501ybs.7.1714059589879; Thu, 25 Apr
 2024 08:39:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240321163705.3067592-1-surenb@google.com> <202404241852.DC4067B7@keescook>
 <3eyvxqihylh4st6baagn6o6scw3qhcb6lapgli4wsic2fvbyzu@h66mqxcikmcp>
In-Reply-To: <3eyvxqihylh4st6baagn6o6scw3qhcb6lapgli4wsic2fvbyzu@h66mqxcikmcp>
From: Suren Baghdasaryan <surenb@google.com>
Date: Thu, 25 Apr 2024 08:39:37 -0700
Message-ID: <CAJuCfpFtj7MVY+9FaKfq0w7N1qw8=jYifC0sBUAySk=AWBhK6Q@mail.gmail.com>
Subject: Re: [PATCH v6 00/37] Memory allocation profiling
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Kees Cook <keescook@chromium.org>, akpm@linux-foundation.org, mhocko@suse.com, 
	vbabka@suse.cz, hannes@cmpxchg.org, roman.gushchin@linux.dev, mgorman@suse.de, 
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
	ndesaulniers@google.com, vvvvvv@google.com, gregkh@linuxfoundation.org, 
	ebiggers@google.com, ytcoode@gmail.com, vincent.guittot@linaro.org, 
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com, 
	bristot@redhat.com, vschneid@redhat.com, cl@linux.com, penberg@kernel.org, 
	iamjoonsoo.kim@lge.com, 42.hyeyoo@gmail.com, glider@google.com, 
	elver@google.com, dvyukov@google.com, songmuchun@bytedance.com, 
	jbaron@akamai.com, aliceryhl@google.com, rientjes@google.com, 
	minchan@google.com, kaleshsingh@google.com, kernel-team@android.com, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	iommu@lists.linux.dev, linux-arch@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-modules@vger.kernel.org, kasan-dev@googlegroups.com, 
	cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 24, 2024 at 8:26=E2=80=AFPM Kent Overstreet
<kent.overstreet@linux.dev> wrote:
>
> On Wed, Apr 24, 2024 at 06:59:01PM -0700, Kees Cook wrote:
> > On Thu, Mar 21, 2024 at 09:36:22AM -0700, Suren Baghdasaryan wrote:
> > > Low overhead [1] per-callsite memory allocation profiling. Not just f=
or
> > > debug kernels, overhead low enough to be deployed in production.
> >
> > Okay, I think I'm holding it wrong. With next-20240424 if I set:
> >
> > CONFIG_CODE_TAGGING=3Dy
> > CONFIG_MEM_ALLOC_PROFILING=3Dy
> > CONFIG_MEM_ALLOC_PROFILING_ENABLED_BY_DEFAULT=3Dy
> >
> > My test system totally freaks out:
> >
> > ...
> > SLUB: HWalign=3D64, Order=3D0-3, MinObjects=3D0, CPUs=3D4, Nodes=3D1
> > Oops: general protection fault, probably for non-canonical address 0xc3=
88d881e4808550: 0000 [#1] PREEMPT SMP NOPTI
> > CPU: 0 PID: 0 Comm: swapper Not tainted 6.9.0-rc5-next-20240424 #1
> > Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 0.0.0 02/06=
/2015
> > RIP: 0010:__kmalloc_node_noprof+0xcd/0x560
> >
> > Which is:
> >
> > __kmalloc_node_noprof+0xcd/0x560:
> > __slab_alloc_node at mm/slub.c:3780 (discriminator 2)
> > (inlined by) slab_alloc_node at mm/slub.c:3982 (discriminator 2)
> > (inlined by) __do_kmalloc_node at mm/slub.c:4114 (discriminator 2)
> > (inlined by) __kmalloc_node_noprof at mm/slub.c:4122 (discriminator 2)
> >
> > Which is:
> >
> >         tid =3D READ_ONCE(c->tid);
> >
> > I haven't gotten any further than that; I'm EOD. Anyone seen anything
> > like this with this series?
>
> I certainly haven't. That looks like some real corruption, we're in slub
> internal data structures and derefing a garbage address. Check kasan and
> all that?

Hi Kees,
I tested next-20240424 yesterday with defconfig and
CONFIG_MEM_ALLOC_PROFILING enabled but didn't see any issue like that.
Could you share your config file please?
Thanks,
Suren.
