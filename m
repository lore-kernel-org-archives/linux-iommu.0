Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E58DBA2E
	for <iommu@lists.linux.dev>; Fri, 16 Feb 2024 01:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708046604; cv=none; b=Ru7s0PbS0ixqQTXW4WPa/3UdnlUJSgqjoaWX9//IAc1GMT5Rh8btbcn4Ub96Efzcyj/7ReY9yUbUKsRDyGNTlgs712A9twLP/8Xm4BX4DCCksYWydA78nmObBy4YK9t1suRDDYxbwyXUHoNbfNtTCwrztfHyxQMlW3uF+TcgGqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708046604; c=relaxed/simple;
	bh=yOv4lCsMlL/EKUXCC4Ma+3szviWFRNJ0I0zqeqBfOVY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KGOD0m9s8y1WNpyVA60FPdFqgWLJkv5haVsCxb29dMJEvI11iSg80+vFum0/mQryJjDT4NCGD8mG+pptCwiOUqsiR5PN0sldO1w8u3eDK7xeTSESboH9NbhU5xRv09lig0xBVkLxEkC/rwnKrYRYiNeCMrwYXUj7AzqO46+3OdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=mANSFAJj; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="mANSFAJj"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-42db64efac3so9303181cf.3
        for <iommu@lists.linux.dev>; Thu, 15 Feb 2024 17:23:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1708046601; x=1708651401; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eLBxcB96LUnXdvE3EMMcNpcL8B6icUkLMA8zN7Nwyj8=;
        b=mANSFAJj9VH4Hp6IGPZgtCoAV5qmTS/od3Ha3PWrddanLSdasCzwJ9YmzSS6Y5AfYr
         kZp4yqB1UOgNAVBdoo8wJz6VW3grHtTGdmcPxR9xd85uI+ewR5vbLOgOIKMK/858kSTa
         yzc+2Te4Gz+D9cWTBZDSu+omemK04GnSkMY2+ZT+aHME/O5+XD5MaXudhbtATnNC95Ux
         a3p54qLjeKDA5L2vqu7DOyReKh83vgjH9zGbzKRijVZfg8biRHol3f3oQlPrhiyQv0AK
         k0UoJrW0wbRRbzQnOGm9UGtGNlu90DLfxzg18RSRgbpwKVxVK42O3rh91M5+cDEqLfan
         XWzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708046601; x=1708651401;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eLBxcB96LUnXdvE3EMMcNpcL8B6icUkLMA8zN7Nwyj8=;
        b=YmjFtwsAKTEWu/rPbNh0HSNraPOR0B5ix4UQUPPWsdaYmvWTfnLFJfrQlhGLk0E13X
         vPbbsK5tiZY1aGoviEiJhKhpIOgUoz6I0qRrG0iucNGJUUFjwX3Fo3s4bloyPgCCcRgo
         Z07x23TncGxMall/OdDRehYcfUAwwSTouxdRnJ0eEZWsjrBaLWqT0Hauvgzon2f9dEp9
         8XDTU+mHlJF83SH+t2Q4t26eG7mlsppq45XKrdMZsZ1A6FATs6N5sJMj5fvAvroAUkGv
         FzYyLu0uK0kquOmxOaCnuepPAR74NLh0xI2lZEr79acRUi5WwmmzhsIE4vBheHdNvAaG
         OqCQ==
X-Forwarded-Encrypted: i=1; AJvYcCVrfSBoMUAB1fiowFdzX8GoC8cnb57zq+xW+67tNk4zTdNvqU4/cg785yOfe7NNeTF8w03VV6EplS0h84MzOyvHCH0aIsU=
X-Gm-Message-State: AOJu0YwXzIdgqpKDhMoNmW4b99++59J65LZymr9eRczFfbLtEWRiqYuW
	n1pSCGpOU4viIYnmz2pLlyomLhWUvcVj0iDlsaBQP6XhaK4u6qhq+6+9ZYri4swyk7asiHV60zU
	fMBuy7jpT0FFUVIWEqsP8kHLzV2751HGCk6bgIA==
X-Google-Smtp-Source: AGHT+IHdAGPa3f0BFvBlw2QNdQJLAcEidwl+gXCtt3AMFT8zJaebOs+nRCRcB3nHVA77tKuaOx7EkhIR+i04j0HLT/E=
X-Received: by 2002:a05:622a:1a94:b0:42a:48bc:f69 with SMTP id
 s20-20020a05622a1a9400b0042a48bc0f69mr4538976qtc.35.1708046601368; Thu, 15
 Feb 2024 17:23:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240212213922.783301-1-surenb@google.com> <20240212213922.783301-14-surenb@google.com>
 <20240215165438.cd4f849b291c9689a19ba505@linux-foundation.org> <wdj72247rptlp4g7dzpvgrt3aupbvinskx3abxnhrxh32bmxvt@pm3d3k6rn7pm>
In-Reply-To: <wdj72247rptlp4g7dzpvgrt3aupbvinskx3abxnhrxh32bmxvt@pm3d3k6rn7pm>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Thu, 15 Feb 2024 20:22:44 -0500
Message-ID: <CA+CK2bBod-1FtrWQH89OUhf0QMvTar1btTsE0wfROwiCumA8tg@mail.gmail.com>
Subject: Re: [PATCH v3 13/35] lib: add allocation tagging support for memory
 allocation profiling
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, Suren Baghdasaryan <surenb@google.com>, mhocko@suse.com, 
	vbabka@suse.cz, hannes@cmpxchg.org, roman.gushchin@linux.dev, mgorman@suse.de, 
	dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com, 
	corbet@lwn.net, void@manifault.com, peterz@infradead.org, 
	juri.lelli@redhat.com, catalin.marinas@arm.com, will@kernel.org, 
	arnd@arndb.de, tglx@linutronix.de, mingo@redhat.com, 
	dave.hansen@linux.intel.com, x86@kernel.org, peterx@redhat.com, 
	david@redhat.com, axboe@kernel.dk, mcgrof@kernel.org, masahiroy@kernel.org, 
	nathan@kernel.org, dennis@kernel.org, tj@kernel.org, muchun.song@linux.dev, 
	rppt@kernel.org, paulmck@kernel.org, yosryahmed@google.com, yuzhao@google.com, 
	dhowells@redhat.com, hughd@google.com, andreyknvl@gmail.com, 
	keescook@chromium.org, ndesaulniers@google.com, vvvvvv@google.com, 
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
	cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 15, 2024 at 8:00=E2=80=AFPM Kent Overstreet
<kent.overstreet@linux.dev> wrote:
>
> On Thu, Feb 15, 2024 at 04:54:38PM -0800, Andrew Morton wrote:
> > On Mon, 12 Feb 2024 13:38:59 -0800 Suren Baghdasaryan <surenb@google.co=
m> wrote:
> >
> > > +Example output.
> > > +
> > > +::
> > > +
> > > +    > cat /proc/allocinfo
> > > +
> > > +      153MiB     mm/slub.c:1826 module:slub func:alloc_slab_page
> > > +     6.08MiB     mm/slab_common.c:950 module:slab_common func:_kmall=
oc_order
> > > +     5.09MiB     mm/memcontrol.c:2814 module:memcontrol func:alloc_s=
lab_obj_exts
> > > +     4.54MiB     mm/page_alloc.c:5777 module:page_alloc func:alloc_p=
ages_exact
> > > +     1.32MiB     include/asm-generic/pgalloc.h:63 module:pgtable fun=
c:__pte_alloc_one
> >
> > I don't really like the fancy MiB stuff.  Wouldn't it be better to just
> > present the amount of memory in plain old bytes, so people can use sort
> > -n on it?
>
> They can use sort -h on it; the string_get_size() patch was specifically
> so that we could make the output compatible with sort -h
>
> > And it's easier to tell big-from-small at a glance because
> > big has more digits.
> >
> > Also, the first thing any sort of downstream processing of this data is
> > going to have to do is to convert the fancified output back into
> > plain-old-bytes.  So why not just emit plain-old-bytes?
> >
> > If someone wants the fancy output (and nobody does) then that can be
> > done in userspace.
>
> I like simpler, more discoverable tools; e.g. we've got a bunch of
> interesting stuff in scripts/ but it doesn't get used nearly as much -
> not as accessible as cat'ing a file, definitely not going to be
> installed by default.

I also prefer plain bytes instead of MiB. A driver developer that
wants to verify up-to the byte allocations for a new data structure
that they added is going to be disappointed by the rounded MiB
numbers.

The data contained in this file is not consumable without at least
"sort -h -r", so why not just output bytes instead?

There is /proc/slabinfo  and there is a slabtop tool.
For raw /proc/allocinfo we can create an alloctop tool that would
parse, sort and show data in human readable format based on various
criteria.

We should also add at the top of this file "allocinfo - version: 1.0",
to allow future extensions (i.e. column for proc name).

Pasha
