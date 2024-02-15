Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC1E7136644
	for <iommu@lists.linux.dev>; Thu, 15 Feb 2024 16:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708015695; cv=none; b=FUW5vkQRKmUT2u5XMLhA25ABO2Esq9FRZxeTXF6qxhuDzKsqURmMDLrdH+wd83KyjyDGAk8SXQ+1guRBov/kvfVQGVVLAJ9un0QY5r+1NgNt4H6OXi3zkOfw2OQET/5UeeD06S/nPSe+v3Gp4YG9sI8WBKB3CaN3XiWwFEGHaSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708015695; c=relaxed/simple;
	bh=9TO9rM05PYsgFPIWymZY990BiwuTMGTPoVWKOTW/5Ag=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XZT9IOJaOcqYmtwZy5u1Ta2nXltlDZxxbZV335zIs1dtiinmgColydJykxnx6sVX8OBmRP1bAVrshV/8ixUL4FpKQvbT1G5JelpUy3p4e785MzwPJ9UebEECShRkjjJmNgOTR1Sd5cMtjo6nsVY5AybC62T80xmeDS2eIIwDOU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=g3+ez9uC; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="g3+ez9uC"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-607e54b6cf5so3425747b3.0
        for <iommu@lists.linux.dev>; Thu, 15 Feb 2024 08:48:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708015693; x=1708620493; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1tI+hCE30y1jp9jG4DD8d4tpJXQ3JxVVysbuWcCVNic=;
        b=g3+ez9uCiuLwCqe3uvY/B6dVXHRIcKTA3Gkd3emHH0BFJEjAN8hzhku3XUVH6v2Hp1
         KYGoQcuVVyjXQ8AK+mSKlhSNh5yo227Dh+I7i91AkB7Owf6IWc4eWkUCXF9piMwctjWj
         A7uqbf7VFa6Y89db9ddY98uRkl8UgXi4lNgTa1yEd4vMjcaLHV9hWqxCBGOgaA0+LEWF
         kG4zS8GCwQJ/fzvra9KdVlLqmQcZvO+2trKLlROVN13/OA8QwDQpB4k9UsoMIHe6+Fta
         kFXc36SIgEHkUg8BNcDnKoJNpPFZJ4UWJXAnWQ6jPsp4aFxsCh/3iZH4wUqZ4BTvvLg0
         NmWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708015693; x=1708620493;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1tI+hCE30y1jp9jG4DD8d4tpJXQ3JxVVysbuWcCVNic=;
        b=v43z0d3HW5LhaMm/NaXOT5ZIPzE1oprm20tmhziyJfPFz8EgA0jXYcDBEwYVodptUj
         ILjHJhvhaIgx1A1QkwT8If+mxLTWaMh0gpEW7cd/FX5NM3dWN4bZwS1z/CS/ghOjCISE
         n4qXot+vKGoBNQXmmHcJsa6/Qh+RFbi69024hjO1Ex4BLd4/rKEAQ/5lZ44Ph3RlFICt
         IS65r5zOW4fqSyoHzSTvOHbCZpL16OLx/cP1j+mgZbefeRre5z10VsDfxomulpFFlx19
         gH0dOl0RqPPh+SjFtIYgLqKlvjVKFFaI8xFwZV19LcgYB36o5w+89izypFGw+j6PeZjd
         iZ1A==
X-Forwarded-Encrypted: i=1; AJvYcCUSAlmuR90LtEoSyTd9JV9wSB65lE0RwoAk6BNWQ/n+dsfaOibNaVYdOpwkm+Ze2l/VmbAs810U76z+1tY+co72iQ8SrOM=
X-Gm-Message-State: AOJu0Yy5+J3HVuMrC+wBftL7V5ba/fk24humo1Ar6lV9f3B6R8UbjuYS
	rdK/ahQrf4Qp6vhwrfUwE3l5AtQhNd4LeiJSYWbQcZnDESMSLQEA09C6ug02VzqJ7gxvxcK7eah
	QEdApGsHsoy13TkFl+mFDgn7rntFKTe8Ow2LT
X-Google-Smtp-Source: AGHT+IEpKo2L6oplIyxSXpvbYHFzpW3S2D2HSJYFHw3+xQqVKIR17Ywy1D0gSKm8xVOUSCj/xezJ/KNnf15e7J0VTMo=
X-Received: by 2002:a0d:e284:0:b0:607:77bd:711 with SMTP id
 l126-20020a0de284000000b0060777bd0711mr1808635ywe.11.1708015692595; Thu, 15
 Feb 2024 08:48:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240212213922.783301-1-surenb@google.com> <20240212213922.783301-32-surenb@google.com>
 <Zc3X8XlnrZmh2mgN@tiehlicka> <CAJuCfpHc2ee_V6SGAc_31O_ikjGGNivhdSG+2XNcc9vVmzO-9g@mail.gmail.com>
 <Zc4_i_ED6qjGDmhR@tiehlicka>
In-Reply-To: <Zc4_i_ED6qjGDmhR@tiehlicka>
From: Suren Baghdasaryan <surenb@google.com>
Date: Thu, 15 Feb 2024 08:47:59 -0800
Message-ID: <CAJuCfpHq3N0h6dGieHxD6Au+qs=iKAifFrHAMxTsHTcDrOwSQA@mail.gmail.com>
Subject: Re: [PATCH v3 31/35] lib: add memory allocations report in show_mem()
To: Michal Hocko <mhocko@suse.com>
Cc: akpm@linux-foundation.org, kent.overstreet@linux.dev, vbabka@suse.cz, 
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

On Thu, Feb 15, 2024 at 8:45=E2=80=AFAM Michal Hocko <mhocko@suse.com> wrot=
e:
>
> On Thu 15-02-24 06:58:42, Suren Baghdasaryan wrote:
> > On Thu, Feb 15, 2024 at 1:22=E2=80=AFAM Michal Hocko <mhocko@suse.com> =
wrote:
> > >
> > > On Mon 12-02-24 13:39:17, Suren Baghdasaryan wrote:
> > > [...]
> > > > @@ -423,4 +424,18 @@ void __show_mem(unsigned int filter, nodemask_=
t *nodemask, int max_zone_idx)
> > > >  #ifdef CONFIG_MEMORY_FAILURE
> > > >       printk("%lu pages hwpoisoned\n", atomic_long_read(&num_poison=
ed_pages));
> > > >  #endif
> > > > +#ifdef CONFIG_MEM_ALLOC_PROFILING
> > > > +     {
> > > > +             struct seq_buf s;
> > > > +             char *buf =3D kmalloc(4096, GFP_ATOMIC);
> > > > +
> > > > +             if (buf) {
> > > > +                     printk("Memory allocations:\n");
> > > > +                     seq_buf_init(&s, buf, 4096);
> > > > +                     alloc_tags_show_mem_report(&s);
> > > > +                     printk("%s", buf);
> > > > +                     kfree(buf);
> > > > +             }
> > > > +     }
> > > > +#endif
> > >
> > > I am pretty sure I have already objected to this. Memory allocations =
in
> > > the oom path are simply no go unless there is absolutely no other way
> > > around that. In this case the buffer could be preallocated.
> >
> > Good point. We will change this to a smaller buffer allocated on the
> > stack and will print records one-by-one. Thanks!
>
> __show_mem could be called with a very deep call chains. A single
> pre-allocated buffer should just do ok.

Ack. Will do.

>
> --
> Michal Hocko
> SUSE Labs
