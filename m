Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BA9DFC1E
	for <iommu@lists.linux.dev>; Thu,  4 May 2023 16:22:22 +0000 (UTC)
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-30626f4d74aso508635f8f.0
        for <iommu@lists.linux.dev>; Thu, 04 May 2023 09:22:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683217341; x=1685809341;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gsk62XwjD8JjQowiDifvFLPW2uokrx3QTotNr7V9c/A=;
        b=N2omhOqN0t8842htyS6nnpZshEM5FDOq00/oUCOZjkt9wVW+RXOiRTAWifBvBL06xW
         wsHTkzbJEKwGODr+x5nVM6iRWj4zkpHHW5yK8xJ+u2OEsRUc0F9YAaD2jBIDN40/ZVT5
         uWwr+CwwSqK3NqlABylMov+XVGgJLKg/ZjrMzJpoLIL0fxdtJEmf5mUu11lS1AnjywIE
         XrebqkMLaMdLW3UnduL/5lCuwNEgX/dNGtbgb0bdEU1ltu6ukDE5/UAE9u1JdHh8RfK3
         WQKtDqKrfN5dSTdoMZ+3cuZyCB8sKMgynF2baw36KScS7qCcyW0QlHaCQwE+Yb7TPhAl
         uleA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683217341; x=1685809341;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gsk62XwjD8JjQowiDifvFLPW2uokrx3QTotNr7V9c/A=;
        b=OzA4RxKyMPFAvo50CkEUcpKsfy5pFSz6QewTMxd4yVxjvu/eDxfTAIi+Ho4gEx6CLg
         3HvV78nYANMrxXqCm+ZwYP2Ta/iEulDbCB1UnUv2FosgLtkoNa+GF/dHa5U5VDOwaxis
         jZRcSMR3s2OxNsjJAXulZMjCVodrlZCKn298AltXKUQNJc+omA5TCUwMmyouX5azl+mm
         qxD0SvOaeDdYtLyYwHE0UyqmlqU6abJ8TVFh2tZ2+FhVUXDszBLUMPRP4ML6CGP+a/22
         AlpXCEIpTXD00DBlP7aCpLSZ0VV/uBvcUOp553ZS3xhBz+xAhV4ZAguRFePxYaIQr9oc
         mlvg==
X-Gm-Message-State: AC+VfDz989WkllgjtcsXw7w405V8ozVuRQHdYSoHpizX/aYYrUnDO3FF
	KHdPU6vvFXdyRMAS3BJm1loiOMImNBT7/X6VdnyT4A==
X-Google-Smtp-Source: ACHHUZ6W7LU6+7sJ+JIBNyUc93OdZBrKmPb6kgAM40ObN2WRJqo/GOAU298MN4AghxYk5WmY9UXzE3DSoSxQENd3Lcc=
X-Received: by 2002:a05:6000:120a:b0:2fc:7b62:f459 with SMTP id
 e10-20020a056000120a00b002fc7b62f459mr2840579wrx.32.1683217340407; Thu, 04
 May 2023 09:22:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20230501165450.15352-1-surenb@google.com> <20230501165450.15352-36-surenb@google.com>
 <ZFIPmnrSIdJ5yusM@dhcp22.suse.cz> <CAJuCfpGsvWupMbasqvwcMYsOOPxTQqi1ed5+=vyu-yoPQwwybg@mail.gmail.com>
 <ZFNoVfb+1W4NAh74@dhcp22.suse.cz>
In-Reply-To: <ZFNoVfb+1W4NAh74@dhcp22.suse.cz>
From: Suren Baghdasaryan <surenb@google.com>
Date: Thu, 4 May 2023 09:22:07 -0700
Message-ID: <CAJuCfpGUtw6cbjLsksGJKATZfTV0FEYRXwXT0pZV83XqQydBgg@mail.gmail.com>
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

On Thu, May 4, 2023 at 1:09=E2=80=AFAM Michal Hocko <mhocko@suse.com> wrote=
:
>
> On Wed 03-05-23 08:24:19, Suren Baghdasaryan wrote:
> > On Wed, May 3, 2023 at 12:39=E2=80=AFAM Michal Hocko <mhocko@suse.com> =
wrote:
> > >
> > > On Mon 01-05-23 09:54:45, Suren Baghdasaryan wrote:
> > > [...]
> > > > +struct codetag_ctx *alloc_tag_create_ctx(struct alloc_tag *tag, si=
ze_t size)
> > > > +{
> > > > +     struct alloc_call_ctx *ac_ctx;
> > > > +
> > > > +     /* TODO: use a dedicated kmem_cache */
> > > > +     ac_ctx =3D kmalloc(sizeof(struct alloc_call_ctx), GFP_KERNEL)=
;
> > >
> > > You cannot really use GFP_KERNEL here. This is post_alloc_hook path a=
nd
> > > that has its own gfp context.
> >
> > I missed that. Would it be appropriate to use the gfp_flags parameter
> > of post_alloc_hook() here?
>
> No. the original allocation could have been GFP_USER based and you do
> not want these allocations to pullute other zones potentially. You want
> GFP_KERNEL compatible subset of that mask.

Ack.

>
> But even then I really detest an additional allocation from this context
> for every single allocation request. There GFP_NOWAIT allocation for
> steckdepot but that is at least cached and generally not allocating.
> This will allocate for every single allocation.

A small correction here. alloc_tag_create_ctx() is used only for
allocations which we requested to capture the context. So, this last
sentence is true for allocations we specifically marked to capture the
context, not in general.

> There must be a better way.

Yeah, agree, it would be good to avoid allocations in this path. Any
specific ideas on how to improve this? Pooling/caching perhaps? I
think kmem_cache does some of that already but maybe something else?
Thanks,
Suren.

> --
> Michal Hocko
> SUSE Labs
