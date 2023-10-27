Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E30E9374DA
	for <iommu@lists.linux.dev>; Fri, 27 Oct 2023 15:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hfO9Lv6S"
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2c50305c5c4so33010381fa.1
        for <iommu@lists.linux.dev>; Fri, 27 Oct 2023 08:28:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698420500; x=1699025300; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pNsl5MInPLJ8RSTN609h9x1G8bOqBML3/WHWrkX2PGU=;
        b=hfO9Lv6S0a2klDqnyLWPLCGE47kluYe7Nv2V4NiC5x02Yq1Z63EzshUfSiydRHQnqr
         lhJEgJuhNKoUHIU4dVAUrDW523md/zpKT7eQ/82R3+5j+hM2QkJ06z2AHIBix9C3mfDc
         D9MMpAoxv6kwSJEoh6pLo2ECG0XjSe9ZgHZK7wBbyT19+w/dRUrfbRDfrTszkkckC0xd
         raJkloC9iSvYEWM64kDwT28hhYm02yM5Mxxh2UMaZtV8MVuXPexKKf/rOnz5PG5YJJev
         SyIHL+6khtlrvMTh26ASX/juDU82b4qHI4rVTQnS6hL4b/ZScTwrgFLHMYIlmuI6RCCP
         if3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698420500; x=1699025300;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pNsl5MInPLJ8RSTN609h9x1G8bOqBML3/WHWrkX2PGU=;
        b=oGHBZpHOT8LvY/4ElXeLWrckA3esdevGsGCFIuWAYIGes4X0V04AEWhCqqAV/lgtmu
         6eLGHcvYU90ItltxyD13G6LpPW52nVEA+6shmIlEUEN0w9M1bIQMQw3bdKnlGQPTJag5
         cFdy/ugLcXTtcjtfVcdxN9d5bbzhvvok4gCYhNozJeJKEQlwizMo0SxIPMvu2zXjgoZQ
         WT/swD6Ba6jSF+jYT79EguWcn2MRiopHsd+AtUYmqEG57ZZtR3zWgx0LZux2fuc9BzaK
         L6ER0jXgXNVY5dYMC9OhKhcD6+V8IhsCr9BEx1TyNsRbbxVBATQ0Jjse2T/0x5M/JWJH
         1zKQ==
X-Gm-Message-State: AOJu0YzqgS5I0k3966zq2qS3nosr8/z+T9jjszEKh4pDRJM9G27RaLpC
	WuHXn6nQVL95jFZJgYnwiBVgMplw8KHG6W/eXgsd7w==
X-Google-Smtp-Source: AGHT+IHhztclk1FNuTavfV09vRrRQcRnx6lXYSGYBX+I6vgMiVsYpEDbYR5+xRzUeW2IFeyne8V1kWZ8Fus2muopy04=
X-Received: by 2002:a05:651c:1070:b0:2c5:47f:8ff7 with SMTP id
 y16-20020a05651c107000b002c5047f8ff7mr2161033ljm.18.1698420499387; Fri, 27
 Oct 2023 08:28:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20231024134637.3120277-1-surenb@google.com> <20231024134637.3120277-29-surenb@google.com>
 <87h6me620j.ffs@tglx> <CAJuCfpH1pG513-FUE_28MfJ7xbX=9O-auYUjkxKLmtve_6rRAw@mail.gmail.com>
 <87jzr93rxv.ffs@tglx> <20231026235433.yuvxf7opxg74ncmd@moria.home.lan> <b20fe713-28c6-4ca8-b64a-df017f161524@app.fastmail.com>
In-Reply-To: <b20fe713-28c6-4ca8-b64a-df017f161524@app.fastmail.com>
From: Nick Desaulniers <ndesaulniers@google.com>
Date: Fri, 27 Oct 2023 08:28:08 -0700
Message-ID: <CAKwvOdnKwGnxZnnDW-miaUO+M5AN_Np1A0fmj18Mz1AV2aQPzg@mail.gmail.com>
Subject: Re: [PATCH v2 28/39] timekeeping: Fix a circular include dependency
To: Arnd Bergmann <arnd@arndb.de>
Cc: Kent Overstreet <kent.overstreet@linux.dev>, Thomas Gleixner <tglx@linutronix.de>, 
	Suren Baghdasaryan <surenb@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Michal Hocko <mhocko@suse.com>, Vlastimil Babka <vbabka@suse.cz>, Johannes Weiner <hannes@cmpxchg.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Mel Gorman <mgorman@suse.de>, 
	Davidlohr Bueso <dave@stgolabs.net>, Matthew Wilcox <willy@infradead.org>, 
	"Liam R. Howlett" <liam.howlett@oracle.com>, Jonathan Corbet <corbet@lwn.net>, void@manifault.com, 
	Peter Zijlstra <peterz@infradead.org>, juri.lelli@redhat.com, ldufour@linux.ibm.com, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	peterx@redhat.com, David Hildenbrand <david@redhat.com>, Jens Axboe <axboe@kernel.dk>, 
	Luis Chamberlain <mcgrof@kernel.org>, Masahiro Yamada <masahiroy@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, dennis@kernel.org, Tejun Heo <tj@kernel.org>, 
	Muchun Song <muchun.song@linux.dev>, Mike Rapoport <rppt@kernel.org>, 
	"Paul E. McKenney" <paulmck@kernel.org>, pasha.tatashin@soleen.com, yosryahmed@google.com, 
	Yu Zhao <yuzhao@google.com>, David Howells <dhowells@redhat.com>, Hugh Dickins <hughd@google.com>, 
	Andrey Konovalov <andreyknvl@gmail.com>, Kees Cook <keescook@chromium.org>, vvvvvv@google.com, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Eric Biggers <ebiggers@google.com>, ytcoode@gmail.com, 
	Vincent Guittot <vincent.guittot@linaro.org>, dietmar.eggemann@arm.com, 
	Steven Rostedt <rostedt@goodmis.org>, bsegall@google.com, bristot@redhat.com, 
	vschneid@redhat.com, Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>, 
	Joonsoo Kim <iamjoonsoo.kim@lge.com>, Hyeonggon Yoo <42.hyeyoo@gmail.com>, 
	Alexander Potapenko <glider@google.com>, Marco Elver <elver@google.com>, Dmitry Vyukov <dvyukov@google.com>, 
	Shakeel Butt <shakeelb@google.com>, Muchun Song <songmuchun@bytedance.com>, 
	Jason Baron <jbaron@akamai.com>, David Rientjes <rientjes@google.com>, minchan@google.com, 
	kaleshsingh@google.com, kernel-team@android.com, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev, 
	Linux-Arch <linux-arch@vger.kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, linux-modules@vger.kernel.org, kasan-dev@googlegroups.com, 
	cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 26, 2023 at 11:35=E2=80=AFPM Arnd Bergmann <arnd@arndb.de> wrot=
e:
>
> On Fri, Oct 27, 2023, at 01:54, Kent Overstreet wrote:
> > On Fri, Oct 27, 2023 at 01:05:48AM +0200, Thomas Gleixner wrote:
> >> On Thu, Oct 26 2023 at 18:33, Suren Baghdasaryan wrote:
> >> > On Wed, Oct 25, 2023 at 5:33=E2=80=AFPM Thomas Gleixner <tglx@linutr=
onix.de> wrote:
> >> >> > This avoids a circular header dependency in an upcoming patch by =
only
> >> >> > making hrtimer.h depend on percpu-defs.h
> >> >>
> >> >> What's the actual dependency problem?
> >> >
> >> > Sorry for the delay.
> >> > When we instrument per-cpu allocations in [1] we need to include
> >> > sched.h in percpu.h to be able to use alloc_tag_save(). sched.h
> >>
> >> Including sched.h in percpu.h is fundamentally wrong as sched.h is the
> >> initial place of all header recursions.
> >>
> >> There is a reason why a lot of funtionalitiy has been split out of
> >> sched.h into seperate headers over time in order to avoid that.
> >
> > Yeah, it's definitely unfortunate. The issue here is that
> > alloc_tag_save() needs task_struct - we have to pull that in for
> > alloc_tag_save() to be inline, which we really want.
> >
> > What if we moved task_struct to its own dedicated header? That might be
> > good to do anyways...
>
> Yes, I agree that is the best way to handle it. I've prototyped
> a more thorough header cleanup with good results (much improved
> build speed) in the past, and most of the work to get there is
> to seperate out structures like task_struct, mm_struct, net_device,
> etc into headers that only depend on the embedded structure
> definitions without needing all the inline functions associated
> with them.

This is something I'll add to our automation todos which I plan to
talk about at plumbers; I feel like it should be possible to write a
script that given a header and identifier can split whatever
declaration out into a new header, update the old header, then add the
necessary includes for the newly created header to each dependent
(optional).
--=20
Thanks,
~Nick Desaulniers
