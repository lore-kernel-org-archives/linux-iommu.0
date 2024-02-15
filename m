Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0252B1384B0
	for <iommu@lists.linux.dev>; Thu, 15 Feb 2024 18:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708023015; cv=none; b=XlC3XBHXfl7JVm+6O31o9jREuH1iBo+8O5+GCOXJukeFTM6BVc5eWSq4qG6SDcjCCByYR2hegFmBWO6+tFysr8wh2WvQI1zrIeCdaqzFDqLEcfpvuICjuASjAvTV3ETR2hc/ramLpl8ruAwPicxLNa8rFII0AFd5UemA0J10fIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708023015; c=relaxed/simple;
	bh=S81pGoJ8PfU6aLi9PbShqhGOm1UW2ATW5Cnzr2dZfPM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tt03yMZT5rr9oNzwxnDs2gKYsiGe3lBCVZ/Km4BZ/IpQ31G7JSN0IMOX7rLUqB0xNcNJq3CqLknpKe5t48NI6Q1v5WXbURfjKSJwBjtsxD06I/lc7DywUzVWA4pRXDZsRQR+a9v2x1CDLJ5hBLKdj54EgQm+63ZQ3g2L/TMs2rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nLXqib4E; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nLXqib4E"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-6077444cb51so17280527b3.1
        for <iommu@lists.linux.dev>; Thu, 15 Feb 2024 10:50:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708023013; x=1708627813; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WUlsSeO8LefyO4xLZYNJ9jNHAOJrLbOdsT9pDfMZXA8=;
        b=nLXqib4EJt3xX1PyIhPkbnMGP/36dVn26pnJHz4fzPm5zsmC9E9JRf9d5A7pVTU8ao
         yOqDqeUHVr2d21Gqi6rheFiGK7mcHbiAClj5giB8G3j6gFLcQe/gHUDT9OVG3vd0aIm3
         TqWRMIcN4DeGPVuEpg2FauRbND+SmircpQp3Lu0j6DYxzLKp51B9c8yEH/Q1Ii2wS8tf
         +iQReUQtUznvtidjRXInlv1K4MIa1jsJwH7vfSMpKbXBMdVlpxudXVq03vcSWQ8wh1Sp
         moCEbyMd+G77wzxHXtk508SJwO9EpdEsKiyN+0C1dTodE1GVk0Mc+eqmkpQN1vIbB6kM
         CPew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708023013; x=1708627813;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WUlsSeO8LefyO4xLZYNJ9jNHAOJrLbOdsT9pDfMZXA8=;
        b=Xm4CqF3M0UqR2NtERk84NschyOpPlpnoWSF93YoYtTG/x5dorf79T1QyDMAASk6qo/
         ks6ddU4m9Xb8fejQueXMVSs1Oc4yga1fHj47FpeRA0M866uo0gDBv8oa4JpH2glalUMH
         JvfvTdzWHXnnHmVNDm8icsCpSI18OHfvEybDnmWNDXQFkjs/+wc7sd0Tm96dao9Gq1VC
         3BFVrwe6bBBtKjKI2NoAJLjCjBMl5CR8MkLkjkf+o8rbwRXky78hlgVcZZdYnALCyB17
         uK/x3AMl/5CzZXm3BtG2O6QbLpHRAbwO/G5sDLg8ve2XlztjVkMdm1jG5yIQBzhRG+5b
         p/BQ==
X-Forwarded-Encrypted: i=1; AJvYcCUwwIj+8/gG7/hrYRHWWiZKeJcXV53KkKRRK0+97O1elOdcEXOW8SxwanspVqpV/cQMqylHJN9+s2CMgx9dBGqVDf3NsM4=
X-Gm-Message-State: AOJu0Yxb+qgmJLla+F2vI4OfFHqgJU2hDGYVf7FoVzFzcp6iLRiimo5Q
	hrA7uyXU6irIAOCIEa6MsHnDQKSoIqiYloKhnr6aDkqCo25mzd2O/d2tOP8PwTB7tVrp7eyc1eq
	Rcs3uSX2j0kP1If/0O0Se9d1A7VXJ6Vt5aCh/
X-Google-Smtp-Source: AGHT+IHQQXGNaksc4ZLhdDELtvsfOEVbOUct07hRFV1UcZvxQkhvZT74vejiVn2ZOSoGey1AwcE3FMB7Y05S+V1u8DE=
X-Received: by 2002:a25:ae28:0:b0:dc2:4fff:75ee with SMTP id
 a40-20020a25ae28000000b00dc24fff75eemr1999749ybj.3.1708023012635; Thu, 15 Feb
 2024 10:50:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240212213922.783301-1-surenb@google.com> <20240212213922.783301-32-surenb@google.com>
 <Zc3X8XlnrZmh2mgN@tiehlicka> <CAJuCfpHc2ee_V6SGAc_31O_ikjGGNivhdSG+2XNcc9vVmzO-9g@mail.gmail.com>
 <Zc4_i_ED6qjGDmhR@tiehlicka> <CAJuCfpHq3N0h6dGieHxD6Au+qs=iKAifFrHAMxTsHTcDrOwSQA@mail.gmail.com>
 <ruxvgrm3scv7zfjzbq22on7tj2fjouydzk33k7m2kukm2n6uuw@meusbsciwuut> <Zc5a8MsJyt27jeJC@tiehlicka>
In-Reply-To: <Zc5a8MsJyt27jeJC@tiehlicka>
From: Suren Baghdasaryan <surenb@google.com>
Date: Thu, 15 Feb 2024 10:49:59 -0800
Message-ID: <CAJuCfpH2EF8DZhBp_7324ka7mnMkUdWyqTs+ZiMhwjm_nmcwZQ@mail.gmail.com>
Subject: Re: [PATCH v3 31/35] lib: add memory allocations report in show_mem()
To: Michal Hocko <mhocko@suse.com>
Cc: Kent Overstreet <kent.overstreet@linux.dev>, akpm@linux-foundation.org, vbabka@suse.cz, 
	hannes@cmpxchg.org, roman.gushchin@linux.dev, mgorman@suse.de, 
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

On Thu, Feb 15, 2024 at 10:41=E2=80=AFAM Michal Hocko <mhocko@suse.com> wro=
te:
>
> On Thu 15-02-24 13:29:40, Kent Overstreet wrote:
> > On Thu, Feb 15, 2024 at 08:47:59AM -0800, Suren Baghdasaryan wrote:
> > > On Thu, Feb 15, 2024 at 8:45=E2=80=AFAM Michal Hocko <mhocko@suse.com=
> wrote:
> > > >
> > > > On Thu 15-02-24 06:58:42, Suren Baghdasaryan wrote:
> > > > > On Thu, Feb 15, 2024 at 1:22=E2=80=AFAM Michal Hocko <mhocko@suse=
.com> wrote:
> > > > > >
> > > > > > On Mon 12-02-24 13:39:17, Suren Baghdasaryan wrote:
> > > > > > [...]
> > > > > > > @@ -423,4 +424,18 @@ void __show_mem(unsigned int filter, nod=
emask_t *nodemask, int max_zone_idx)
> > > > > > >  #ifdef CONFIG_MEMORY_FAILURE
> > > > > > >       printk("%lu pages hwpoisoned\n", atomic_long_read(&num_=
poisoned_pages));
> > > > > > >  #endif
> > > > > > > +#ifdef CONFIG_MEM_ALLOC_PROFILING
> > > > > > > +     {
> > > > > > > +             struct seq_buf s;
> > > > > > > +             char *buf =3D kmalloc(4096, GFP_ATOMIC);
> > > > > > > +
> > > > > > > +             if (buf) {
> > > > > > > +                     printk("Memory allocations:\n");
> > > > > > > +                     seq_buf_init(&s, buf, 4096);
> > > > > > > +                     alloc_tags_show_mem_report(&s);
> > > > > > > +                     printk("%s", buf);
> > > > > > > +                     kfree(buf);
> > > > > > > +             }
> > > > > > > +     }
> > > > > > > +#endif
> > > > > >
> > > > > > I am pretty sure I have already objected to this. Memory alloca=
tions in
> > > > > > the oom path are simply no go unless there is absolutely no oth=
er way
> > > > > > around that. In this case the buffer could be preallocated.
> > > > >
> > > > > Good point. We will change this to a smaller buffer allocated on =
the
> > > > > stack and will print records one-by-one. Thanks!
> > > >
> > > > __show_mem could be called with a very deep call chains. A single
> > > > pre-allocated buffer should just do ok.
> > >
> > > Ack. Will do.
> >
> > No, we're not going to permanently burn 4k here.
> >
> > It's completely fine if the allocation fails, there's nothing "unsafe"
> > about doing a GFP_ATOMIC allocation here.
>
> Nobody is talking about safety. This is just a wrong thing to do when
> you are likely under OOM situation. This is a situation when you
> GFP_ATOMIC allocation is _likely_ to fail. Yes, yes you will get some
> additional memory reservers head room, but you shouldn't rely on that
> because that will make the output unreliable. Not something you want in
> situation when you really want to know that information.
>
> More over you do not need to preallocate a full page.

Folks, please stop arguing about it. We have more important things to
do. I'll fix it to use a small preallocated buffer.

>
> --
> Michal Hocko
> SUSE Labs
