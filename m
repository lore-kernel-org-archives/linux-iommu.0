Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 307A9C143
	for <iommu@lists.linux.dev>; Fri,  5 May 2023 18:10:33 +0000 (UTC)
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-b9ef06cb784so2755447276.0
        for <iommu@lists.linux.dev>; Fri, 05 May 2023 11:10:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683310232; x=1685902232;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QVZYG1JecNO86jzNV6C/AMNw6VQt+fJvqwCxq5mp/Nc=;
        b=JuehaV/RJK9Y4fUOdxkcZEuqDGAuEF/acJdDqJ45XbKARUoqq4czDg4ZH8mqWvQs0W
         C3cMUZ3VtCr6q/eI+6qJp58nulUMjZvQdZpvpUFXRdmOfRfhasZuNayk1xVHyGVy9Mwz
         ItoP45q/KUOjBJ5HUc+Vlm240zAnqes7cusDh4wsBFNSxkmDsbQVgr1QY7ENaCb2Pf+o
         stmyjKNibly7r3/lcAzIGX4ZSS4stgbgtYjMfq5c0cI/ZADNQtKt98fqV/f8MiQv11Tt
         rfeoXeDHmM1lnkcbyLTsW9UrOEazY/VwbfsLiL1Vyfp7oqXyyedjHeSP3hv1vKGbwqQn
         8juQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683310232; x=1685902232;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QVZYG1JecNO86jzNV6C/AMNw6VQt+fJvqwCxq5mp/Nc=;
        b=JjR9qFD0MufaupcizqleCDcBtnvgYlP4FrbLPb3RODKgP3sYfVyiZgoqDzXeH9n8t+
         Qq9zH/LzKXyHNWn0dKPqMiz2pUD//og70alCdx+e1CD/OIQpwRja6QF319YTUbCWFV98
         DpRCaWzm2rvP2YpA5B/1gJMXXhApvZxVe2F98xVaMbrS7+iLw6RCkx2lrGelR4vmiVKv
         i+fF9+bZ1oWJKnx+wyP8IR8qZMOGL5wPvVrL5loa3N5LR5Tkl4O1uN2FQ6FekvKLwAwn
         U3zY8GWC3a1mINyBtBRBn34dMG5zzcT0luDGrzgELDoHGkmrPEH0yuY7r0nNqwJlI85Q
         xqKw==
X-Gm-Message-State: AC+VfDxzWicxSykcqvybi0eepOrdcPgmCo/8AuoWD0JvQD0wn8t1Jubt
	kX62OhVKxm+1IpiQM7V16Wpin6s94aE6SzqyRjVKsQ==
X-Google-Smtp-Source: ACHHUZ7QHqfeTFCV6iTpJ174mK2XnlUcdiV6R/LWDFZ2cFLepn3d5BnEaLb2X1/400R6vZerp7fSwFYV9RLQ6kw5Ucs=
X-Received: by 2002:a25:19d7:0:b0:b97:1e2e:a4e5 with SMTP id
 206-20020a2519d7000000b00b971e2ea4e5mr2351347ybz.40.1683310231779; Fri, 05
 May 2023 11:10:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20230501165450.15352-1-surenb@google.com> <20230501165450.15352-36-surenb@google.com>
 <ZFIPmnrSIdJ5yusM@dhcp22.suse.cz> <CAJuCfpGsvWupMbasqvwcMYsOOPxTQqi1ed5+=vyu-yoPQwwybg@mail.gmail.com>
 <ZFNoVfb+1W4NAh74@dhcp22.suse.cz> <CAJuCfpGUtw6cbjLsksGJKATZfTV0FEYRXwXT0pZV83XqQydBgg@mail.gmail.com>
 <ZFTA8xVzxWc345Ug@dhcp22.suse.cz>
In-Reply-To: <ZFTA8xVzxWc345Ug@dhcp22.suse.cz>
From: Suren Baghdasaryan <surenb@google.com>
Date: Fri, 5 May 2023 11:10:20 -0700
Message-ID: <CAJuCfpFOLyZKvtqHuukOZvegxGHVUcAtbh3Egt+01yZ9kcEAew@mail.gmail.com>
Subject: Re: [PATCH 35/40] lib: implement context capture support for tagged allocations
To: Michal Hocko <mhocko@suse.com>
Cc: akpm@linux-foundation.org, kent.overstreet@linux.dev, vbabka@suse.cz, 
	hannes@cmpxchg.org, roman.gushchin@linux.dev, mgorman@suse.de, 
	dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com, 
	corbet@lwn.net, void@manifault.com, peterz@infradead.org, 
	juri.lelli@redhat.com, ldufour@linux.ibm.com, catalin.marinas@arm.com, 
	will@kernel.org, arnd@arndb.de, tglx@linutronix.de, mingo@redhat.com, 
	dave.hansen@linux.intel.com, x86@kernel.org, peterx@redhat.com, 
	david@redhat.com, axboe@kernel.dk, mcgrof@kernel.org, masahiroy@kernel.org, 
	nathan@kernel.org, dennis@kernel.org, tj@kernel.org, muchun.song@linux.dev, 
	rppt@kernel.org, paulmck@kernel.org, pasha.tatashin@soleen.com, 
	yosryahmed@google.com, yuzhao@google.com, dhowells@redhat.com, 
	hughd@google.com, andreyknvl@gmail.com, keescook@chromium.org, 
	ndesaulniers@google.com, gregkh@linuxfoundation.org, ebiggers@google.com, 
	ytcoode@gmail.com, vincent.guittot@linaro.org, dietmar.eggemann@arm.com, 
	rostedt@goodmis.org, bsegall@google.com, bristot@redhat.com, 
	vschneid@redhat.com, cl@linux.com, penberg@kernel.org, iamjoonsoo.kim@lge.com, 
	42.hyeyoo@gmail.com, glider@google.com, elver@google.com, dvyukov@google.com, 
	shakeelb@google.com, songmuchun@bytedance.com, jbaron@akamai.com, 
	rientjes@google.com, minchan@google.com, kaleshsingh@google.com, 
	kernel-team@android.com, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev, 
	linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-modules@vger.kernel.org, kasan-dev@googlegroups.com, 
	cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 5, 2023 at 1:40=E2=80=AFAM Michal Hocko <mhocko@suse.com> wrote=
:
>
> On Thu 04-05-23 09:22:07, Suren Baghdasaryan wrote:
> [...]
> > > But even then I really detest an additional allocation from this cont=
ext
> > > for every single allocation request. There GFP_NOWAIT allocation for
> > > steckdepot but that is at least cached and generally not allocating.
> > > This will allocate for every single allocation.
> >
> > A small correction here. alloc_tag_create_ctx() is used only for
> > allocations which we requested to capture the context. So, this last
> > sentence is true for allocations we specifically marked to capture the
> > context, not in general.
>
> Ohh, right. I have misunderstood that part. Slightly better, still
> potentially a scalability issue because hard to debug memory leaks
> usually use a generic caches (for kmalloc). So this might be still a lot
> of objects to track.

Yes, generally speaking, if a single code location is allocating very
frequently then enabling context capture for it will generate many
callstack buffers.

Your note about use of generic caches makes me think we still have a
small misunderstanding. We tag at the allocation call site, not based
on which cache is used. Two kmalloc calls from different code
locations will have unique codetags for each, so enabling context
capture for one would not result in context capturing for the other
one.

>
> > > There must be a better way.
> >
> > Yeah, agree, it would be good to avoid allocations in this path. Any
> > specific ideas on how to improve this? Pooling/caching perhaps? I
> > think kmem_cache does some of that already but maybe something else?
>
> The best I can come up with is a preallocated hash table to store
> references to stack depots with some additional data associated. The
> memory overhead could be still quite big but the hash tables could be
> resized lazily.

Ok, that seems like the continuation of you suggestion in another
thread to combine identical callstack traces. That's an excellent
idea! I think it would not be hard to implement. Thanks!

> --
> Michal Hocko
> SUSE Labs
