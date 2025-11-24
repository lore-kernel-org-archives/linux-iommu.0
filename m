Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE7AD303A20
	for <iommu@lists.linux.dev>; Mon, 24 Nov 2025 12:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763988320; cv=none; b=VDIQbJCvD9FKBhX+fDFSbl+X9CKHBxhJoOjeGJwO7gV7SwLwKlBTxRSqnW1tFR6iOXnC1wx5M1Cr/1myztL6yyM2PyBxS4HJar0/7rWthm2t3sVtprYRewXjuXyjtmqO/XvyigwusgYTm9blN8v1dtT1ZBSf1sBJWGKG/GDGR6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763988320; c=relaxed/simple;
	bh=n87DmeWhfv8qMsIDQtBKhIM6R09117S4EXj7SWflnKQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X7Dx0b5JCObxHVyj8S47a7qTL3bh9bGDjR8fqc1FpnG1J/WbL0UyhdrKICpK9KCZzkwb8Zh5/xMgD+5wNSqlcLP6WGv2EhrUsgyOUw/2OfsMHKg7QEkhLqUWutRIGhJzPHMiWdEU1rxUfDfIloNpq1Yr74yzoT9OVoxae18E3f4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zDgH+DmP; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zDgH+DmP"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4ee243b98caso479591cf.1
        for <iommu@lists.linux.dev>; Mon, 24 Nov 2025 04:45:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763988317; x=1764593117; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6VWcEmhan/BNwTvurxtnj0t4NznWYHYqF0Rq1JXc1mQ=;
        b=zDgH+DmPijJf6chxpuIWvyL5kwlACbmtCi0+iRfBZBFdeDcxv1KWvU1R2lxns3vIWV
         rt4/8izeruB8sHRbTMkX6c7ho4T2uhBMEd5OZP9teUcy99Uhri3F1EVyd+X87mnvWj0m
         53UQARm3t6T+QIo3sEUKAELcrcXqDWRszAqf4DMp4n46inkzCmvuHfTt7M2XUxrnaeeE
         gefxR03L7MeTXrBheUMQjLzgHgJkhxCL8kUsiwfVDYEH0EiVnquDI7b7gUj9YGh8NjB/
         NyvS7T1AhWayJMxE2TFUM76vS6xbmoYYQtAR37Woqb9zQbNI77AJZVr18exaR2z//NL/
         f/WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763988317; x=1764593117;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6VWcEmhan/BNwTvurxtnj0t4NznWYHYqF0Rq1JXc1mQ=;
        b=TYwKPWbOpILjAIzrpKq93OE8e6Lh2JhRE4ajF/mHwGKNXFF1YjYCgW9XGyGb+Hua5x
         tKq+emhTLBQFR63u6Rw4Axc+taOAQ23akp0Yr4Rn+1KCL8io3NdS9Si+32x/c6Vfc1jg
         i0Y82QyFhqPGAKyKTgaZLMghZbHD7iyeIHwIqmAse7ZTsGptJvszNDT6Sto2Tpvq+HGV
         TLLHLuHdO1ns4OfagSqBnAHLi8W/FgV5168ZepqKXGfo7Gnq42+ebBMPGMnCNuIBqjie
         UguZDf650PQZHTI4f8jG06t3YxH62PFc3i6MtB0jco2MKHbQ6Jvzab/DJFCTsXFAGwN3
         I6EQ==
X-Forwarded-Encrypted: i=1; AJvYcCVBza9MHV9OeJSvW9FWXJyO6BITVKwYRO311rRVHB5lPixkExS5Jkd97xJ6eJJqZ2UfTbIwHw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwHcnV/uO+JGNutfM5vvCmbzVehIucSk5P459keQmaguSy9rAZS
	xPP/ydMmtTPddnigj4VVwMm5tN8Maw1Ai8sh8ZUBt473tn90Wmpy/Vs4YVu0sjzamvSckCLpBQ2
	8vX+MfC/7ELKGiQHZsuxFyHuQuxGtRyRZF/Ne7+6c
X-Gm-Gg: ASbGncsfT5clAjsR/EYGUXViY4JYYoc77CKGw4ao8DC/9jT3NRiFeE1UHGjnWRoJhTO
	Cg9bYsg9HYlR6LJjWLx159Y74KUHlLP0Wco44PbnYg3uYepRENtgYr4fqg9ikAvjv1pbmnsY/mm
	8B4+idROdtZ5FIjk+X9xh5jha1Y8kouSyu2lw2kbDI24UbPIEqIsq5RUEnZbrJxRPx0F6cWLaHJ
	MAmzBvQi7I1t5qNc42qce7ALoqPRx5l7Ci4u5nBqIFxjVIVqA+BxBa2vrj+v7MZMXY5ZQjpcN04
	v8WuHgH+8JlaHb5/LivQ3Uw=
X-Google-Smtp-Source: AGHT+IGPjVCxfR9SKFA3FQOdCOVgD7/O9AanhIhyNvazavihPLZPPKf8lSGLvPhLVXD4pGKivK0LrnCUCoWz3BbimD8=
X-Received: by 2002:ac8:5d14:0:b0:4ed:18ef:4060 with SMTP id
 d75a77b69052e-4ee60ecb032mr9555211cf.8.1763988317334; Mon, 24 Nov 2025
 04:45:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251106163953.1971067-1-smostafa@google.com> <20251106163953.1971067-2-smostafa@google.com>
 <aRWtX3n2I7El4Ykv@willie-the-truck> <aSQ9DsR0nAAvc4Pd@google.com>
In-Reply-To: <aSQ9DsR0nAAvc4Pd@google.com>
From: Mostafa Saleh <smostafa@google.com>
Date: Mon, 24 Nov 2025 12:45:06 +0000
X-Gm-Features: AWmQ_blA1bdjlFzoBd-B3IlCTsIeP9e4yZgrlAzqOFd_qVOZm4_QtkdjmvxtkT8
Message-ID: <CAFgf54p1T_Vsx_QLX1XOJJz6v6K337G5T0Gw=V=9LL4h_CWZHQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] drivers/iommu: Add page_ext for IOMMU_DEBUG_PAGEALLOC
To: Will Deacon <will@kernel.org>
Cc: linux-mm@kvack.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, corbet@lwn.net, joro@8bytes.org, 
	robin.murphy@arm.com, akpm@linux-foundation.org, vbabka@suse.cz, 
	surenb@google.com, mhocko@suse.com, jackmanb@google.com, hannes@cmpxchg.org, 
	ziy@nvidia.com, david@redhat.com, lorenzo.stoakes@oracle.com, 
	Liam.Howlett@oracle.com, rppt@kernel.org, Qinxin Xia <xiaqinxin@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 24, 2025 at 11:10=E2=80=AFAM Mostafa Saleh <smostafa@google.com=
> wrote:
>
> On Thu, Nov 13, 2025 at 10:05:19AM +0000, Will Deacon wrote:
> > Hi Mostafa,
> >
> > On Thu, Nov 06, 2025 at 04:39:50PM +0000, Mostafa Saleh wrote:
> > > Add a new config IOMMU_DEBUG_PAGEALLOC, which registers new data to
> > > page_ext.
> > > This config will be used by the IOMMU API to track pages mapped in
> > > the IOMMU to catch drivers trying to free kernel memory that they
> > > still map in their domains, causing all types of memory corruption.
> > > This behaviour is disabled by default and can be enabled using
> > > kernel cmdline iommu.debug_pagealloc.
> > >
> > > Signed-off-by: Mostafa Saleh <smostafa@google.com>
> > > Tested-by: Qinxin Xia <xiaqinxin@huawei.com>
> > > ---
> > >  .../admin-guide/kernel-parameters.txt         |  6 ++++
> > >  drivers/iommu/Kconfig                         | 15 +++++++++
> > >  drivers/iommu/Makefile                        |  1 +
> > >  drivers/iommu/iommu-debug-pagealloc.c         | 32 +++++++++++++++++=
++
> > >  include/linux/iommu-debug-pagealloc.h         | 17 ++++++++++
> > >  mm/page_ext.c                                 |  4 +++
> > >  6 files changed, 75 insertions(+)
> > >  create mode 100644 drivers/iommu/iommu-debug-pagealloc.c
> > >  create mode 100644 include/linux/iommu-debug-pagealloc.h
> >
> > This looks like a pretty handy feature to me, but I have some nits belo=
w.
>
> Thanks for taking the time to review the patches!
>
> >
> > > diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Docume=
ntation/admin-guide/kernel-parameters.txt
> > > index 6c42061ca20e..9a1c4ac8ba96 100644
> > > --- a/Documentation/admin-guide/kernel-parameters.txt
> > > +++ b/Documentation/admin-guide/kernel-parameters.txt
> > > @@ -2557,6 +2557,12 @@
> > >                     1 - Bypass the IOMMU for DMA.
> > >                     unset - Use value of CONFIG_IOMMU_DEFAULT_PASSTHR=
OUGH.
> > >
> > > +   iommu.debug_pagealloc=3D
> > > +                   [KNL,EARLY] When CONFIG_IOMMU_DEBUG_PAGEALLOC is =
set, this
> > > +                   parameter enables the feature at boot time. By de=
fault, it
> > > +                   is disabled and the system will work mostly the s=
ame as a
> > > +                   kernel built without CONFIG_IOMMU_DEBUG_PAGEALLOC=
.
> >
> > Can you be more specific about "mostly the same"?
>
> The only difference is that the static key to gate the calls, I was not s=
ure if
> saying =E2=80=9Cexactly the same=E2=80=9D is correct, but I think it=E2=
=80=99s better avoid =E2=80=9Cmostly=E2=80=9D as
> it might be confusing and as the data in the cover letter shows no overhe=
ad,
> I will re-write the whole help anyway.
>

Ah, I think I copied the base of this from the documenation of
"debug_pagealloc=3D"
which actually slightly changes system behviour by not using THP on some ar=
chs,
which is not relevant in our case, I will drop it then.

Thanks,
Mostafa

> >
> > > +
> > >     io7=3D            [HW] IO7 for Marvel-based Alpha systems
> > >                     See comment before marvel_specify_io7 in
> > >                     arch/alpha/kernel/core_marvel.c.
> > > diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
> > > index 70d29b14d851..6b5e9a2d936a 100644
> > > --- a/drivers/iommu/Kconfig
> > > +++ b/drivers/iommu/Kconfig
> > > @@ -383,4 +383,19 @@ config SPRD_IOMMU
> > >
> > >       Say Y here if you want to use the multimedia devices listed abo=
ve.
> > >
> > > +config IOMMU_DEBUG_PAGEALLOC
> > > +   bool "Debug page memory allocations against IOMMU"
> >
> > Perhaps "IOMMU mappings" would make this a little clearer?
>
> Will do.
>
> >
> > > +   depends on DEBUG_PAGEALLOC && IOMMU_API && PAGE_EXTENSION
> > > +   help
> > > +     This config checks that a page is freed(unmapped) or mapped by =
the
> > > +     kernel is not mapped in any IOMMU domain.
> >
> > I can't really parse this sentence :/
>
> I will re-write it.
>
> >
> > > It can help with debugging
> > > +     use-after-free or out-of-bound maps from drivers doing DMA thro=
ugh
> > > +     the IOMMU API.
> > > +     This santaizer can have false-negative cases where some problem=
s
> > > +     won't be detected.
> >
> > Maybe just say "The sanitizer is best-effort and can fail to detect pro=
blems
> > in the case that ...".
>
> Makes sense, will do.
>
> >
> > > +     Expect overhead when enabling this and enabling the kernel comm=
and
> > > +     line iommu.debug_pagealloc.
> >
> > I'd reword this to say something like "Due to the overhead of the sanit=
iser,
> > iommu.debug_pagealloc must also be passed on the kernel command-line to
> > enable this feature".
>
> Will do.
>
> >
> > > +
> > > +     If unsure, say N here.
> > > +
> > >  endif # IOMMU_SUPPORT
> > > diff --git a/drivers/iommu/Makefile b/drivers/iommu/Makefile
> > > index 355294fa9033..8f5130b6a671 100644
> > > --- a/drivers/iommu/Makefile
> > > +++ b/drivers/iommu/Makefile
> > > @@ -34,3 +34,4 @@ obj-$(CONFIG_IOMMU_SVA) +=3D iommu-sva.o
> > >  obj-$(CONFIG_IOMMU_IOPF) +=3D io-pgfault.o
> > >  obj-$(CONFIG_SPRD_IOMMU) +=3D sprd-iommu.o
> > >  obj-$(CONFIG_APPLE_DART) +=3D apple-dart.o
> > > +obj-$(CONFIG_IOMMU_DEBUG_PAGEALLOC) +=3D iommu-debug-pagealloc.o
> > > diff --git a/drivers/iommu/iommu-debug-pagealloc.c b/drivers/iommu/io=
mmu-debug-pagealloc.c
> > > new file mode 100644
> > > index 000000000000..385c8bfae02b
> > > --- /dev/null
> > > +++ b/drivers/iommu/iommu-debug-pagealloc.c
> > > @@ -0,0 +1,32 @@
> > > +// SPDX-License-Identifier: GPL-2.0-only
> > > +/*
> > > + * Copyright (C) 2025 - Google Inc
> > > + * Author: Mostafa Saleh <smostafa@google.com>
> > > + * IOMMU API debug page alloc sanitizer
> > > + */
> > > +#include <linux/atomic.h>
> > > +#include <linux/iommu-debug-pagealloc.h>
> > > +#include <linux/kernel.h>
> > > +#include <linux/page_ext.h>
> > > +
> > > +static bool needed;
> > > +
> > > +struct iommu_debug_metadate {
> > > +   atomic_t ref;
> > > +};
> >
> > s/metadate/metadata/
>
> Ah, that's embarrassing, I will fix it.
>
> Thanks,
> Mostafa
>
> >
> > Will
