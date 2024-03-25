Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52E2359157
	for <iommu@lists.linux.dev>; Mon, 25 Mar 2024 17:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711389556; cv=none; b=BRzl+ncSuIXxZzfN1WG+W/hcZqCng4OLkk2FUrik6YepjHkxPDmqDXvOQ63qmVJAClH6yuxGGMzC+romAgtempen7hWd2o5aS777WzDJ92c0ROuL45DwX1LVECQen1Sta0axCZfNwuovxYUtCz3prhO5HtSnvSCaHnO7OD3QaEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711389556; c=relaxed/simple;
	bh=YUkn5bDTJvtPOe4CbVEJJ+OysGCk8+HwOuI6bpiCxQQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uN0rvRWGhrSB6NZiZ2LZ0tjChCVSZ0HNrSbCLadk+6N4pD7wIX/nhO63i7DwC7P14HS2bz9ySUD/dtBuZ+6a793CEpQiCGy/06LMhDgK0BOR5/f/XOSz/sJ3VKYRtYDUFKnyodZEos5Dw5gxdo2s6q+85U+z40k58PdllSMmADg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HQOemwAW; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HQOemwAW"
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-dc745927098so4259963276.3
        for <iommu@lists.linux.dev>; Mon, 25 Mar 2024 10:59:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711389553; x=1711994353; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g1H2/sqpi/sh2ma0fgAVRjfY65QgsbrlBKsllNKG2ck=;
        b=HQOemwAWha0fOYNxOK6weG52FfXlzpZr8YXYQLfo8Ia41nXgrGc7e8z/ZcfXDKEcP8
         prWnabJehr9Om27Njj7vvTrM7AX1HP9MpFNdto0u4ChSz7EN2PNM51rykbb4ZE+hTW3e
         0jeHkXtab+2pgTFKAHtv9+xS2vPSaGxdy0hBDtZCiEad3q8xEVBiZ9Z/aHiqWopsxmSS
         L5HK2QCGhhgZb+uIlR9aNtRK2DB5ALV58yvBpTrk7CJCjGlateL5Whwmnvtt9fC1+YBp
         sVBqUOdh9sgNO2TQe4uvBdZX8kYbkxnsWyou5fPwA3B9XdBXJlXah6SE3fjwmt10ODk2
         q4Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711389553; x=1711994353;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g1H2/sqpi/sh2ma0fgAVRjfY65QgsbrlBKsllNKG2ck=;
        b=FJDJfPwndGnkgSbOjx8RdwQWhy4kad7yHgnlgsyPkiD7zjhrEdGGh6nSrF5/YQhocl
         9Kr0kTYih+m7dOKccvmLRiqB4UElfs4NMTENweKUsoqyZvh4CyfaECAVgQga1f88/e1i
         uBzo9UOcwaQMhjQrEN0RfPhGfFDml55afvaVgnl+fK99w50vF7qq+x32mA47AONZg+qU
         Xy7HyLp4VkI5j/ynRe214PLLOcZRHJ9GXuUpo2Na40lWW9jazUH2bs+pkXesFg91Rddr
         dIRPIk5j4ccC7VgXk4qzQw8KZbSspwNdmZ50dw1PBhcLwohGUQ2ZKaM53d14ZOMQ7FlZ
         wnAw==
X-Forwarded-Encrypted: i=1; AJvYcCWeCUpuqvHPFK95OTSZkViUVCUjM2Q2fbWSVqrDnU2Ohkw5lzsfCikgV3jv61WjbfgXPQ2TlYd+eJsNdbeN5Uz+cEdKQrg=
X-Gm-Message-State: AOJu0YzhipRZom3S72oc3KTASGe0XS/OK16LxuPQUZVTqnZTuPLuZSxz
	OJdkr/HhnfkI0nAd+c47W2tjkdvsSjAubAAmlf3Uq55QJ2YGzk2xVhzznlXllElQWgF65T8Owag
	sXU9QXucslfaIkU8Wd27aNwMuSwHVEvZv42qB
X-Google-Smtp-Source: AGHT+IEgRKkwT38dzLm3NHYgLzcPYKNKFESgwIB1AubKuEz+z0q+SxXd0EUwkL4MQOex5Dj9zrOPFPjYxYadJTqh2sQ=
X-Received: by 2002:a25:acd6:0:b0:dc7:4067:9f85 with SMTP id
 x22-20020a25acd6000000b00dc740679f85mr6265207ybd.58.1711389552854; Mon, 25
 Mar 2024 10:59:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAJuCfpFnGmt8Q7ZT2Z+gvz=DkRzionXFZ0i5Y1B=UKF6LLqxXA@mail.gmail.com>
 <20240325174934.229745-1-sj@kernel.org>
In-Reply-To: <20240325174934.229745-1-sj@kernel.org>
From: Suren Baghdasaryan <surenb@google.com>
Date: Mon, 25 Mar 2024 10:59:01 -0700
Message-ID: <CAJuCfpGiuCnMFtViD0xsoaLVO_gJddBQ1NpL6TpnsfN8z5P6fA@mail.gmail.com>
Subject: Re: [PATCH v6 30/37] mm: vmalloc: Enable memory allocation profiling
To: SeongJae Park <sj@kernel.org>
Cc: mhocko@suse.com, vbabka@suse.cz, hannes@cmpxchg.org, 
	roman.gushchin@linux.dev, mgorman@suse.de, dave@stgolabs.net, 
	willy@infradead.org, liam.howlett@oracle.com, 
	penguin-kernel@i-love.sakura.ne.jp, corbet@lwn.net, void@manifault.com, 
	peterz@infradead.org, juri.lelli@redhat.com, catalin.marinas@arm.com, 
	will@kernel.org, arnd@arndb.de, tglx@linutronix.de, mingo@redhat.com, 
	dave.hansen@linux.intel.com, x86@kernel.org, peterx@redhat.com, 
	david@redhat.com, axboe@kernel.dk, mcgrof@kernel.org, masahiroy@kernel.org, 
	nathan@kernel.org, dennis@kernel.org, jhubbard@nvidia.com, tj@kernel.org, 
	muchun.song@linux.dev, rppt@kernel.org, paulmck@kernel.org, 
	pasha.tatashin@soleen.com, yosryahmed@google.com, yuzhao@google.com, 
	dhowells@redhat.com, hughd@google.com, andreyknvl@gmail.com, 
	keescook@chromium.org, ndesaulniers@google.com, vvvvvv@google.com, 
	gregkh@linuxfoundation.org, ebiggers@google.com, ytcoode@gmail.com, 
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org, 
	bsegall@google.com, bristot@redhat.com, vschneid@redhat.com, cl@linux.com, 
	penberg@kernel.org, iamjoonsoo.kim@lge.com, 42.hyeyoo@gmail.com, 
	glider@google.com, elver@google.com, dvyukov@google.com, 
	songmuchun@bytedance.com, jbaron@akamai.com, aliceryhl@google.com, 
	rientjes@google.com, minchan@google.com, kaleshsingh@google.com, 
	kernel-team@android.com, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev, 
	linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-modules@vger.kernel.org, kasan-dev@googlegroups.com, 
	cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 25, 2024 at 10:49=E2=80=AFAM SeongJae Park <sj@kernel.org> wrot=
e:
>
> On Mon, 25 Mar 2024 14:56:01 +0000 Suren Baghdasaryan <surenb@google.com>=
 wrote:
>
> > On Sat, Mar 23, 2024 at 6:05=E2=80=AFPM SeongJae Park <sj@kernel.org> w=
rote:
> > >
> > > Hi Suren and Kent,
> > >
> > > On Thu, 21 Mar 2024 09:36:52 -0700 Suren Baghdasaryan <surenb@google.=
com> wrote:
> > >
> > > > From: Kent Overstreet <kent.overstreet@linux.dev>
> > > >
> > > > This wrapps all external vmalloc allocation functions with the
> > > > alloc_hooks() wrapper, and switches internal allocations to _noprof
> > > > variants where appropriate, for the new memory allocation profiling
> > > > feature.
> > >
> > > I just noticed latest mm-unstable fails running kunit on my machine a=
s below.
> > > 'git-bisect' says this is the first commit of the failure.
> > >
> > >     $ ./tools/testing/kunit/kunit.py run --build_dir ../kunit.out/
> > >     [10:59:53] Configuring KUnit Kernel ...
> > >     [10:59:53] Building KUnit Kernel ...
> > >     Populating config with:
> > >     $ make ARCH=3Dum O=3D../kunit.out/ olddefconfig
> > >     Building with:
> > >     $ make ARCH=3Dum O=3D../kunit.out/ --jobs=3D36
> > >     ERROR:root:/usr/bin/ld: arch/um/os-Linux/main.o: in function `__w=
rap_malloc':
> > >     main.c:(.text+0x10b): undefined reference to `vmalloc'
> > >     collect2: error: ld returned 1 exit status
> > >
> > > Haven't looked into the code yet, but reporting first.  May I ask you=
r idea?
> >
> > Hi SeongJae,
> > Looks like we missed adding "#include <linux/vmalloc.h>" inside
> > arch/um/os-Linux/main.c in this patch:
> > https://lore.kernel.org/all/20240321163705.3067592-2-surenb@google.com/=
.
> > I'll be posing fixes for all 0-day issues found over the weekend and
> > will include a fix for this. In the meantime, to work around it you
> > can add that include yourself. Please let me know if the issue still
> > persists after doing that.
>
> Thank you, Suren.  The change made the error message disappears.  However=
, it
> introduced another one.

Ok, let me investigate and I'll try to get a fix for it today evening.
Thanks,
Suren.

>
>     $ git diff
>     diff --git a/arch/um/os-Linux/main.c b/arch/um/os-Linux/main.c
>     index c8a42ecbd7a2..8fe274e9f3a4 100644
>     --- a/arch/um/os-Linux/main.c
>     +++ b/arch/um/os-Linux/main.c
>     @@ -16,6 +16,7 @@
>      #include <kern_util.h>
>      #include <os.h>
>      #include <um_malloc.h>
>     +#include <linux/vmalloc.h>
>
>      #define PGD_BOUND (4 * 1024 * 1024)
>      #define STACKSIZE (8 * 1024 * 1024)
>     $
>     $ ./tools/testing/kunit/kunit.py run --build_dir ../kunit.out/
>     [10:43:13] Configuring KUnit Kernel ...
>     [10:43:13] Building KUnit Kernel ...
>     Populating config with:
>     $ make ARCH=3Dum O=3D../kunit.out/ olddefconfig
>     Building with:
>     $ make ARCH=3Dum O=3D../kunit.out/ --jobs=3D36
>     ERROR:root:In file included from .../arch/um/kernel/asm-offsets.c:1:
>     .../arch/x86/um/shared/sysdep/kernel-offsets.h:9:6: warning: no previ=
ous prototype for =E2=80=98foo=E2=80=99 [-Wmissing-prototypes]
>         9 | void foo(void)
>           |      ^~~
>     In file included from .../include/linux/alloc_tag.h:8,
>                      from .../include/linux/vmalloc.h:5,
>                      from .../arch/um/os-Linux/main.c:19:
>     .../include/linux/bug.h:5:10: fatal error: asm/bug.h: No such file or=
 directory
>         5 | #include <asm/bug.h>
>           |          ^~~~~~~~~~~
>     compilation terminated.
>
>
> Thanks,
> SJ
>
> [...]
