Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3EE81420CC
	for <iommu@lists.linux.dev>; Wed, 14 Feb 2024 22:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707950181; cv=none; b=KBGXhhKBocD89oaE+rycRY0GC3/wVyZSoVW1HpFLcbKgmtrQnJw6NYJT7zyKaFS+orDh7T0DM1BUmZkyuNcYUwqb5voKMjIBvIepxvwCDZEzO/rk77V4CkIzhYTn/B+xs52qjTxksiuziWBKiV2m6ciXqopesxqdmwLuB9m66xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707950181; c=relaxed/simple;
	bh=C0crMXEshWXmvClKWRf7fOFqj/1UG01MNn2e/g61qyA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bEmVNRmbRrMTanbJBKqRXrcdLA/zkHaLOWCtaRRCpk8HSgEzFD7NzbtosWg69DSQvS9mwIu5VTyJzM09hOdBA/tkHMkNgpzbiHuGcdQQhAt4zO+3I/z0cZon/Yw4qXkI5ns4eMjHHPHXRemXTuBFMSs6nGRLyLury+e2gjsb4MI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oAsZ7FF+; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oAsZ7FF+"
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-dcc80d6004bso223073276.0
        for <iommu@lists.linux.dev>; Wed, 14 Feb 2024 14:36:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707950178; x=1708554978; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mIZ+3Vimc+Fu9uNEqwRF3MpLhrYbsxAAnrlrt3WNttw=;
        b=oAsZ7FF+N3gNVpas5K0Z6uGjrMs1WV/0V3kH4hSKPpHQQmIswGlezIjf/BHQRLmC4e
         KLy1nBPxvdL6ggvyGV5SxRkVK3FNJRdmg5J8ybMLAT0WbS6U8jKDnYMqlKCiLv9dsicJ
         Bp+bJzDRVEaq2GN+RrmBoUIbiR8cMJyCNG35JRMiv9XRG6qSSVuPmO+xZfv+cDp3OSQJ
         cHOxVEv9jfqMfkUjRlzeV3lZECkfHvwZHwCIFUQICh3vzMzvCpUWUXqQfDwdt23Ak0TA
         nKY9eQOSzuLhWjM5IlopljSE8btNOdYUdQ8ClPizWC2NH9tg11G2kCIuaSeKTRoke9ZO
         rJ0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707950178; x=1708554978;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mIZ+3Vimc+Fu9uNEqwRF3MpLhrYbsxAAnrlrt3WNttw=;
        b=EKHmYg+MnQR9yibY6JXnFTMdc7H/oHlkt3TXgk+v4shnz49DUI2J/aFsUpnj+e5++i
         OK/qeZ9xX9YOCjuEseNZi+T1XTar4ly099WfwS8Wa9RD/rpbKLiCCDBf5gmBmBNvhwnO
         yOx5G42icOjdx35pZwsVj6TG6GwAs6Lp5vUPm35/lIgr7ggn3Ok0u1EWwR4pxK9idaRB
         YkQnZNekPgIPpk7BK/hU3MdrnPuV/mllMfJrNh73Y8kEGo8zEXhMJQgLL0lcy1QvSJAh
         TDnl2oj+1T1HM87RFqfWdXEXUW4JZb9ZR/+RerHM7aEDyyCTTFDFE7Wtyl3hERFsSkjj
         tIOg==
X-Forwarded-Encrypted: i=1; AJvYcCVOF9hIXin6fQ4oCZI/FEOTLWJQzIkTdNUIbM/R/aYtsEqDqS2FB1qSFgSdCftpYHQrM2rLgJjknAmLiwtk6u0mU0lB2gI=
X-Gm-Message-State: AOJu0YxHm/8HrGBa799qnrCspJG0/M0fHY7kKM7kYPcMUaxyeilUqL8F
	b7/6v4e4ZYCuzcLQ64mzle+ui+aNkm6gwNzGzM4QgWOpUbuCnIfhzc7ZOiO0epnBRVLtGFHd6JU
	M8iTE9gMGVJ7hL+/1r3lyZB919YUwP2gvzhWL
X-Google-Smtp-Source: AGHT+IFGMo5QMzgB4haA8j4PHefAYH0QGMXhhajKI9bA2/lcKpgWtoNuuV25DDWG2rPEqNS3u8mi+lX2wk/W+0Ufusg=
X-Received: by 2002:a25:208:0:b0:dc6:9c4f:9e85 with SMTP id
 8-20020a250208000000b00dc69c4f9e85mr3483617ybc.49.1707950178324; Wed, 14 Feb
 2024 14:36:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240212213922.783301-1-surenb@google.com> <20240212213922.783301-26-surenb@google.com>
 <Zc09KRo7nMlSGpG6@dread.disaster.area>
In-Reply-To: <Zc09KRo7nMlSGpG6@dread.disaster.area>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 14 Feb 2024 14:36:06 -0800
Message-ID: <CAJuCfpGPyf9VzohFi8HzvT0XsW4bd3EAnCAb6xxedfJGtzZbBA@mail.gmail.com>
Subject: Re: [PATCH v3 25/35] xfs: Memory allocation profiling fixups
To: Dave Chinner <david@fromorbit.com>
Cc: akpm@linux-foundation.org, kent.overstreet@linux.dev, mhocko@suse.com, 
	vbabka@suse.cz, hannes@cmpxchg.org, roman.gushchin@linux.dev, mgorman@suse.de, 
	dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com, 
	corbet@lwn.net, void@manifault.com, peterz@infradead.org, 
	juri.lelli@redhat.com, catalin.marinas@arm.com, will@kernel.org, 
	arnd@arndb.de, tglx@linutronix.de, mingo@redhat.com, 
	dave.hansen@linux.intel.com, x86@kernel.org, peterx@redhat.com, 
	david@redhat.com, axboe@kernel.dk, mcgrof@kernel.org, masahiroy@kernel.org, 
	nathan@kernel.org, dennis@kernel.org, tj@kernel.org, muchun.song@linux.dev, 
	rppt@kernel.org, paulmck@kernel.org, pasha.tatashin@soleen.com, 
	yosryahmed@google.com, yuzhao@google.com, dhowells@redhat.com, 
	hughd@google.com, andreyknvl@gmail.com, keescook@chromium.org, 
	ndesaulniers@google.com, vvvvvv@google.com, gregkh@linuxfoundation.org, 
	ebiggers@google.com, ytcoode@gmail.com, vincent.guittot@linaro.org, 
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com, 
	bristot@redhat.com, vschneid@redhat.com, cl@linux.com, penberg@kernel.org, 
	iamjoonsoo.kim@lge.com, 42.hyeyoo@gmail.com, glider@google.com, 
	elver@google.com, dvyukov@google.com, shakeelb@google.com, 
	songmuchun@bytedance.com, jbaron@akamai.com, rientjes@google.com, 
	minchan@google.com, kaleshsingh@google.com, kernel-team@android.com, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	iommu@lists.linux.dev, linux-arch@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-modules@vger.kernel.org, kasan-dev@googlegroups.com, 
	cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 14, 2024 at 2:22=E2=80=AFPM Dave Chinner <david@fromorbit.com> =
wrote:
>
> On Mon, Feb 12, 2024 at 01:39:11PM -0800, Suren Baghdasaryan wrote:
> > From: Kent Overstreet <kent.overstreet@linux.dev>
> >
> > This adds an alloc_hooks() wrapper around kmem_alloc(), so that we can
> > have allocations accounted to the proper callsite.
> >
> > Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > ---
> >  fs/xfs/kmem.c |  4 ++--
> >  fs/xfs/kmem.h | 10 ++++------
> >  2 files changed, 6 insertions(+), 8 deletions(-)
> >
> > diff --git a/fs/xfs/kmem.c b/fs/xfs/kmem.c
> > index c557a030acfe..9aa57a4e2478 100644
> > --- a/fs/xfs/kmem.c
> > +++ b/fs/xfs/kmem.c
> > @@ -8,7 +8,7 @@
> >  #include "xfs_trace.h"
> >
> >  void *
> > -kmem_alloc(size_t size, xfs_km_flags_t flags)
> > +kmem_alloc_noprof(size_t size, xfs_km_flags_t flags)
> >  {
> >       int     retries =3D 0;
> >       gfp_t   lflags =3D kmem_flags_convert(flags);
> > @@ -17,7 +17,7 @@ kmem_alloc(size_t size, xfs_km_flags_t flags)
> >       trace_kmem_alloc(size, flags, _RET_IP_);
> >
> >       do {
> > -             ptr =3D kmalloc(size, lflags);
> > +             ptr =3D kmalloc_noprof(size, lflags);
> >               if (ptr || (flags & KM_MAYFAIL))
> >                       return ptr;
> >               if (!(++retries % 100))
> > diff --git a/fs/xfs/kmem.h b/fs/xfs/kmem.h
> > index b987dc2c6851..c4cf1dc2a7af 100644
> > --- a/fs/xfs/kmem.h
> > +++ b/fs/xfs/kmem.h
> > @@ -6,6 +6,7 @@
> >  #ifndef __XFS_SUPPORT_KMEM_H__
> >  #define __XFS_SUPPORT_KMEM_H__
> >
> > +#include <linux/alloc_tag.h>
> >  #include <linux/slab.h>
> >  #include <linux/sched.h>
> >  #include <linux/mm.h>
> > @@ -56,18 +57,15 @@ kmem_flags_convert(xfs_km_flags_t flags)
> >       return lflags;
> >  }
> >
> > -extern void *kmem_alloc(size_t, xfs_km_flags_t);
> >  static inline void  kmem_free(const void *ptr)
> >  {
> >       kvfree(ptr);
> >  }
> >
> > +extern void *kmem_alloc_noprof(size_t, xfs_km_flags_t);
> > +#define kmem_alloc(...)                      alloc_hooks(kmem_alloc_no=
prof(__VA_ARGS__))
> >
> > -static inline void *
> > -kmem_zalloc(size_t size, xfs_km_flags_t flags)
> > -{
> > -     return kmem_alloc(size, flags | KM_ZERO);
> > -}
> > +#define kmem_zalloc(_size, _flags)   kmem_alloc((_size), (_flags) | KM=
_ZERO)
> >
> >  /*
> >   * Zone interfaces
> > --
> > 2.43.0.687.g38aa6559b0-goog
>
> These changes can be dropped - the fs/xfs/kmem.[ch] stuff is now
> gone in linux-xfs/for-next.

Thanks for the note. Will drop in the next submission.

>
> -Dave.
> --
> Dave Chinner
> david@fromorbit.com
