Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9417612DD8C
	for <iommu@lists.linux.dev>; Tue, 26 Mar 2024 06:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711434219; cv=none; b=Glc818UiZ93Qc2W+39Nto/sKB/jKF7/RcoleSQya8BR2urTGCIXcaMg7uEF4yupZEHZ7SK96osplagsZrjTznnAqqocv6kh9g9+/WfhFJVfp8DD1akQg1QtusxMFLEc/a0dC1Zpmf8qpXfrjxgsXj+MdvtzAMVAXEezBoT+VbEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711434219; c=relaxed/simple;
	bh=1vPnDmB9pDj0OJfEqjDZCv6xNP3XvTJ8rn8qLgfyVhA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bFkU6Zi/9AvtQD/TZHRin5cEDy87EouERNVNrMvCuPGtcPktk4tWmnWzOuFC0ilw2LNflQX6eAfBht0K/UzG+2MBbIZxyKWvfNYGTmvFv15vlOaxEppN+TOSx8ESF3NXE7ZZq2TJ8IYZacoWKjn4L3h3X7J5Gi1Fy06kO4KMn3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PW8JcpGL; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PW8JcpGL"
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-dbed0710c74so4269240276.1
        for <iommu@lists.linux.dev>; Mon, 25 Mar 2024 23:23:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711434216; x=1712039016; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hY2WNNA6khj/wLxlBTVDg0e/YVgDEc7zpROxMWd3xhs=;
        b=PW8JcpGL8R2sHr2D63sF4ZDRStvdJmo4pezuYDd8MtodHaS9d9lptsFkeytENuOInS
         RNa5eIB1ENACX4I4jXOXkLrO+YRZbeOA6vxuCWCAz+Ri5Zige18fVgLuxcU5f7H5OfMI
         oEZGy0iYgEm+9JuUEUjO5K+OjNzwzo6HpZOKYc9sb0rRMddiCxW7rsDBbt7kZb4W/EgK
         lCYnRBhYu6ii2lhyZySCfea1eqsqq5sWC/9FZBEQbFzN/616kf+2yxSiblJhRNdG60gO
         HLcBjtstrMA7RLUW/vzO9n7JUhkWtL8uafHHcWqkX2hqf+IJlkoErhad9PX9REuyCUJ8
         8C4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711434216; x=1712039016;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hY2WNNA6khj/wLxlBTVDg0e/YVgDEc7zpROxMWd3xhs=;
        b=WvaZiU2ia+Hfv9Y6kAbKDbvV8heyFJhI9Hu4jJUk4yvC37v187yGwLghj0wH/crGi4
         yiq5gYXTAM2chPQbSQyAypXaD5n7InZo4uYJlPnOcHlQH6Psors/7YMUh/QsSpzq5w53
         9i6sg8NqLYrwkTeJuQPh8Yw3oUxehILg7V8UbxK0Sj7Jc2aAtWGBgZjyXz+JmNlduz8R
         clAminYs+xtMDqDnq60fhRVjP2wSSdsl4N3xaW5ayLbjly/L6LDHkWFgQ3Tw7BiSK5Qz
         pUhEf+ARJ+z3hwFOHIQjo99mN34JUDhifIhrJNjLsNnGV2NScIrESWXDNs6LvaBe45bx
         TDrA==
X-Forwarded-Encrypted: i=1; AJvYcCVFg/gpJAB1d6hNvLgE9QL9hBnAxnp3BMgLbfuBZmDZn4k4Uf6W7ekgku2GaPU4CPHG9/oF1CjZkejI02SEqWdZU39F5Tg=
X-Gm-Message-State: AOJu0YzAc2pTrEgxZXywXvSssKhIOq0POmsjRqQDZSWmTuXJUApjFl+2
	Ii+LupcpVBGyWDYhEV+zp4Mc3NEAxiM+UpZHPL3aptt3ZLuLqkdNUHX2WqnPGXPxTjyEo3H6rYG
	/l0Wun5YRY3MCqVPCe8U04H6x+93knQkcf77L
X-Google-Smtp-Source: AGHT+IG0Gky/CBeJB0rm/0hu0j5w1H7Rs/NYjEm4sYKK7iwNm6xWETNlnSAhCMgOK//6yiQJTSFCTE29ikghtZ8wfEk=
X-Received: by 2002:a05:6902:4d3:b0:dc6:d457:ac92 with SMTP id
 v19-20020a05690204d300b00dc6d457ac92mr7166050ybs.31.1711434216382; Mon, 25
 Mar 2024 23:23:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240321163705.3067592-1-surenb@google.com> <20240321163705.3067592-15-surenb@google.com>
 <ZgI9Iejn6DanJZ-9@casper.infradead.org>
In-Reply-To: <ZgI9Iejn6DanJZ-9@casper.infradead.org>
From: Suren Baghdasaryan <surenb@google.com>
Date: Mon, 25 Mar 2024 23:23:25 -0700
Message-ID: <CAJuCfpGvviA5H1Em=ymd8Yqz_UoBVGFOst_wbaA6AwGkvffPHg@mail.gmail.com>
Subject: Re: [PATCH v6 14/37] lib: introduce support for page allocation tagging
To: Matthew Wilcox <willy@infradead.org>
Cc: akpm@linux-foundation.org, kent.overstreet@linux.dev, mhocko@suse.com, 
	vbabka@suse.cz, hannes@cmpxchg.org, roman.gushchin@linux.dev, mgorman@suse.de, 
	dave@stgolabs.net, liam.howlett@oracle.com, 
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

On Mon, Mar 25, 2024 at 8:12=E2=80=AFPM Matthew Wilcox <willy@infradead.org=
> wrote:
>
> On Thu, Mar 21, 2024 at 09:36:36AM -0700, Suren Baghdasaryan wrote:
> > +++ b/include/linux/pgalloc_tag.h
> > @@ -0,0 +1,78 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/*
> > + * page allocation tagging
> > + */
> > +#ifndef _LINUX_PGALLOC_TAG_H
> > +#define _LINUX_PGALLOC_TAG_H
> > +
> > +#include <linux/alloc_tag.h>
> > +
> > +#ifdef CONFIG_MEM_ALLOC_PROFILING
> > +
> > +#include <linux/page_ext.h>
> > +
> > +extern struct page_ext_operations page_alloc_tagging_ops;
> > +extern struct page_ext *page_ext_get(struct page *page);
> > +extern void page_ext_put(struct page_ext *page_ext);
>
> Why are you duplicating theses two declarations?
>
> I just deleted them locally and don't see any build problems.  tested wit=
h
> x86-64 defconfig (full build), allnoconfig full build and allmodconfig
> mm/ and fs/ (nobody has time to build allmodconfig drivers/)

Ah, good eye! We probably didn't include page_ext.h before and then
when we did I missed removing these declarations. I'll post a fixup.
Thanks!
