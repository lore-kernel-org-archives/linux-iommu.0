Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D391ADF44
	for <iommu@lists.linux.dev>; Wed,  3 May 2023 20:15:20 +0000 (UTC)
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-b9d8b2e1576so8055312276.2
        for <iommu@lists.linux.dev>; Wed, 03 May 2023 13:15:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683144920; x=1685736920;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fJv5xHBTJjNv/pix2rgh9sMW7sCnrk66nOy29HPAlus=;
        b=UCO8xAxPQELEnJ5Z/+6POOiyN0vC8Y3LS4oWyDMuhEhZvFzcfiun+ebWGPwrO+pD6P
         oaWSGqmefHbl5lAEiPf5lmUVnYEfPjsrvltc8OpHClJDRLqR0c6JCt2K4/o8XHiKCVdf
         J53ZnSfM4WQ/BqrKp+eVl6M1p/n6Qe+G3n50PB19Uzdxt6cKRczUS8ApWupvLyGowGSr
         nGY8DkG6nB+Z74vkrN7ka4kE+r+AVY9ut3CcNzBfOZ5eIHL+qS/vkhlLgZTTLFk7Q8GU
         5cYkPlXWlkK/9gZow1krRfzsVVYIijdz+900Nl7CuaPdx5c8WOD0aSivErWELXWkx49V
         I4sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683144920; x=1685736920;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fJv5xHBTJjNv/pix2rgh9sMW7sCnrk66nOy29HPAlus=;
        b=XPJCWaPeyBdTxWIQO8hAKxGDjJ/c1FJtUwr5zHS2rSZjmJ54A2q06ydq6toKrc1LOO
         Cm+XBitRyyK5EG1Ex9h4V68uStx1S5B2CArXC8ClwK7WRrtfhBQCtURnj0BiGcQMP4Pl
         lzgZouP+LJg7lZ22dhxEOBxQPmfJwiXLCdgJ0+XlUxllFnST8JwbiZ1UDpGVLUZIkHZj
         yPqg2uOExckN1pjHG74NWx41kPP2xwkNjjGKApX9HHfsm8bQnr2JQ3GGX4kvqtdRVBhJ
         IZW/S2BC+ab8HnEMFxS0A9nkKxIStJeHNzudYw1DnCk3W5ZFB1i2yvm0EOUMyqAjoZ2r
         E7Cg==
X-Gm-Message-State: AC+VfDzo6eW5wVf/cDYLsUl2xzDmnpDZxHQry2/ixQ2hqUWlbMCIYlwJ
	wHeW6mfS6lvie5oUWYKQzNitAYu6hAi79wOaxz6oyw==
X-Google-Smtp-Source: ACHHUZ7mImQ/1wXTYz0SIgMaa2LSNhSdXyURzMfJt6GpNMGuq33NeGKiMX4mFybM8LMTHwiJs7q6jFVMM1TC3F7btJ0=
X-Received: by 2002:a25:2b45:0:b0:b8e:db20:eccf with SMTP id
 r66-20020a252b45000000b00b8edb20eccfmr22508398ybr.55.1683144919429; Wed, 03
 May 2023 13:15:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <ZFIVtB8JyKk0ddA5@moria.home.lan> <ZFKNZZwC8EUbOLMv@slm.duckdns.org>
 <20230503180726.GA196054@cmpxchg.org> <ZFKlrP7nLn93iIRf@slm.duckdns.org>
 <ZFKqh5Dh93UULdse@slm.duckdns.org> <ZFKubD/lq7oB4svV@moria.home.lan>
 <ZFKu6zWA00AzArMF@slm.duckdns.org> <ZFKxcfqkUQ60zBB_@slm.duckdns.org>
 <CAJuCfpEPkCJZO2svT-GfmpJ+V-jSLyFDKM_atnqPVRBKtzgtnQ@mail.gmail.com>
 <ZFK6pwOelIlhV8Bm@slm.duckdns.org> <ZFK9XMSzOBxIFOHm@slm.duckdns.org>
In-Reply-To: <ZFK9XMSzOBxIFOHm@slm.duckdns.org>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 3 May 2023 13:14:57 -0700
Message-ID: <CAJuCfpE4YD_BumqFf2-NC8KS9D+kq0s_o4gRyWAH-WK4SgqUbA@mail.gmail.com>
Subject: Re: [PATCH 00/40] Memory allocation profiling
To: Tejun Heo <tj@kernel.org>
Cc: Kent Overstreet <kent.overstreet@linux.dev>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@suse.com>, akpm@linux-foundation.org, vbabka@suse.cz, 
	roman.gushchin@linux.dev, mgorman@suse.de, dave@stgolabs.net, 
	willy@infradead.org, liam.howlett@oracle.com, corbet@lwn.net, 
	void@manifault.com, peterz@infradead.org, juri.lelli@redhat.com, 
	ldufour@linux.ibm.com, catalin.marinas@arm.com, will@kernel.org, 
	arnd@arndb.de, tglx@linutronix.de, mingo@redhat.com, 
	dave.hansen@linux.intel.com, x86@kernel.org, peterx@redhat.com, 
	david@redhat.com, axboe@kernel.dk, mcgrof@kernel.org, masahiroy@kernel.org, 
	nathan@kernel.org, dennis@kernel.org, muchun.song@linux.dev, rppt@kernel.org, 
	paulmck@kernel.org, pasha.tatashin@soleen.com, yosryahmed@google.com, 
	yuzhao@google.com, dhowells@redhat.com, hughd@google.com, 
	andreyknvl@gmail.com, keescook@chromium.org, ndesaulniers@google.com, 
	gregkh@linuxfoundation.org, ebiggers@google.com, ytcoode@gmail.com, 
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org, 
	bsegall@google.com, bristot@redhat.com, vschneid@redhat.com, cl@linux.com, 
	penberg@kernel.org, iamjoonsoo.kim@lge.com, 42.hyeyoo@gmail.com, 
	glider@google.com, elver@google.com, dvyukov@google.com, shakeelb@google.com, 
	songmuchun@bytedance.com, jbaron@akamai.com, rientjes@google.com, 
	minchan@google.com, kaleshsingh@google.com, kernel-team@android.com, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	iommu@lists.linux.dev, linux-arch@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-modules@vger.kernel.org, kasan-dev@googlegroups.com, 
	cgroups@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 3, 2023 at 1:00=E2=80=AFPM Tejun Heo <tj@kernel.org> wrote:
>
> Hello,
>
> On Wed, May 03, 2023 at 09:48:55AM -1000, Tejun Heo wrote:
> > > If so, that's the idea behind the context capture feature so that we
> > > can enable it on specific allocations only after we determine there i=
s
> > > something interesting there. So, with low-cost persistent tracking we
> > > can determine the suspects and then pay some more to investigate thos=
e
> > > suspects in more detail.
> >
> > Yeah, I was wondering whether it'd be useful to have that configurable =
so
> > that it'd be possible for a user to say "I'm okay with the cost, please
> > track more context per allocation". Given that tracking the immediate c=
aller
> > is already a huge improvement and narrowing it down from there using
> > existing tools shouldn't be that difficult, I don't think this is a blo=
cker
> > in any way. It just bothers me a bit that the code is structured so tha=
t
> > source line is the main abstraction.
>
> Another related question. So, the reason for macro'ing stuff is needed is
> because you want to print the line directly from kernel, right?

The main reason is because we want to inject a code tag at the
location of the call. If we have a code tag injected at every
allocation call, then finding the allocation counter (code tag) to
operate takes no time.

> Is that
> really necessary? Values from __builtin_return_address() can easily be
> printed out as function+offset from kernel which already gives most of th=
e
> necessary information for triaging and mapping that back to source line f=
rom
> userspace isn't difficult. Wouldn't using __builtin_return_address() make
> the whole thing a lot simpler?

If we do that we have to associate that address with the allocation
counter at runtime on the first allocation and look it up on all
following allocations. That introduces the overhead which we are
trying to avoid by using macros.

>
> Thanks.
>
> --
> tejun
