Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36429148307
	for <iommu@lists.linux.dev>; Tue, 27 Feb 2024 16:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709050536; cv=none; b=ASOGBo4V+e/PNikKEdVSDe5DFlnhCk+y0knv5VFTtKIsEyBKHNqlqXaLbmnYtt2D0Fi13eIZbGxVvnVVY/ZZwmGobsxa6SzcM+/dk68wxl44IJk+6tx5Iv9MTyyJpbiDa/LSYe2zKN5pRz9BE19Ab0hQUejOZMGIt3H1l7lxOew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709050536; c=relaxed/simple;
	bh=+J92/r3jcnHXJ/0cv7LsIQJtOsDjbMxL06wEUVm7B4Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mpVIYYFJGaxgtZ7mQT40YsoJimKAnTR1u7TrT+txO5Mm5IeKNl9PZQLhHnaM2tLkXRTQk/iSL6wdZx8O7GhBadO7meQf/m5dANJHZMkdHNnZH1w31u18sm+NnCvHBHc+4vjtZkVnktA4CgqU8vgpcEJbhuw4pSk71zEBTjQzyqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=k6E/lrqS; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="k6E/lrqS"
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-dbed0710c74so4032399276.1
        for <iommu@lists.linux.dev>; Tue, 27 Feb 2024 08:15:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709050533; x=1709655333; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZscKwOxqDJIaAnxf3DOisSB4kKJVJaPdUBtyCsbS8zY=;
        b=k6E/lrqS8bJ7NvPMl1wg+fPXnkLFfXMQhdHxkDjLDphMuA/Tc0NIe8zNRxJaNUe+F9
         TDyaJpqEDFECR8GfGzAKq0mJAJBFRN6/3bvKtRYCNZGUz9sTHg2TouDEPs9YByqNjGLg
         c85qgG4IR8txgC4FyF1px5i4ZOMMUL6gRiIVO0lPVCvD/XhsSTLnmYYUYy7Q7NgFdoXp
         ok5GO7ZOD+N/bf/BEKCNoiTjjgW30lNSJ21onTBtS+1ngMcm+JKAcH2pPpOWRfi206aB
         TUweM4xvxCmjq2PzuRmV1E9upmrxdh09cltDsd1AD6cUVaR+FGnOhzmBw8WaFwazHEaI
         D2OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709050533; x=1709655333;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZscKwOxqDJIaAnxf3DOisSB4kKJVJaPdUBtyCsbS8zY=;
        b=JPCnTws2AvzJFQ6O0YpuV+bTspxY4J9IKpyHRPAp+XdRphCl6h1ZhGLFn3KnoE7hdJ
         DXvQEL5qrNowAedXk5MaiorYJHX1M6md1DsK5GDjcOOlFO8SmT0o01DV4bsJQSWNKMQb
         s7Rl/xHLK4x3lZXTU/2+Df1jT5nxo855TBbndrzKqLr3ZJ+M11pRkJn3Z+62bxtmikuP
         x8tKSpkkXk2Z29p5sSISCezw6v/uKR4qboRvYcVOk3yHBk14XOE8gE6xR/GCSQ+5cs4r
         5VQcGgnZbF3SR/oF+rJOPnDypctvRFh1KZJC5j/VgqZ5/lyPnl+K8YM+RkRiSzdDpJUl
         BrtQ==
X-Forwarded-Encrypted: i=1; AJvYcCUbqFirzFi/RaTJeLC4IwmtPYqWGLVzgscd6JK1X1WKY9R7U+8I7w0jZuW9UNti1eJLWHEKnB+RJAY5iUVIHRZDlkVZdF4=
X-Gm-Message-State: AOJu0YyMpUFjGUSZNZfb/ARzOyrbQMQ7vbm9zsWDpN0MflwooJ06Q5w3
	kGS4iyw3a4XoVyySPTweMUs00F3GLRO6/KNTXNQopC0WrTWdHQ1svolAmOcIRYf270Wzg9vtZvn
	LtcmyuTyIpNRcqq1SeaKz+n2BNn4za3bUBBlW
X-Google-Smtp-Source: AGHT+IEw+VgUM8rjFF4tarET9LYSoU4rt/YwPutl48cPMakVPIe4FNGy4MH5hQJmtrlQlJwMQOaq0wT1r6aJOfixfFE=
X-Received: by 2002:a25:aac5:0:b0:dcc:4b84:67cd with SMTP id
 t63-20020a25aac5000000b00dcc4b8467cdmr2309188ybi.9.1709050532850; Tue, 27 Feb
 2024 08:15:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240221194052.927623-1-surenb@google.com> <20240221194052.927623-23-surenb@google.com>
 <4a0e40e5-3542-4d47-bb2b-c0666f6a904d@suse.cz>
In-Reply-To: <4a0e40e5-3542-4d47-bb2b-c0666f6a904d@suse.cz>
From: Suren Baghdasaryan <surenb@google.com>
Date: Tue, 27 Feb 2024 08:15:21 -0800
Message-ID: <CAJuCfpGvSfu5dtxFVxmQ4cMfQti2vGVtkNmm2kqQVPfrpFM1tw@mail.gmail.com>
Subject: Re: [PATCH v4 22/36] mm/slab: add allocation accounting into slab
 allocation and free paths
To: Vlastimil Babka <vbabka@suse.cz>
Cc: akpm@linux-foundation.org, kent.overstreet@linux.dev, mhocko@suse.com, 
	hannes@cmpxchg.org, roman.gushchin@linux.dev, mgorman@suse.de, 
	dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com, 
	penguin-kernel@i-love.sakura.ne.jp, corbet@lwn.net, void@manifault.com, 
	peterz@infradead.org, juri.lelli@redhat.com, catalin.marinas@arm.com, 
	will@kernel.org, arnd@arndb.de, tglx@linutronix.de, mingo@redhat.com, 
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

On Tue, Feb 27, 2024 at 5:07=E2=80=AFAM Vlastimil Babka <vbabka@suse.cz> wr=
ote:
>
>
>
> On 2/21/24 20:40, Suren Baghdasaryan wrote:
> > Account slab allocations using codetag reference embedded into slabobj_=
ext.
> >
> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > Co-developed-by: Kent Overstreet <kent.overstreet@linux.dev>
> > Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
> > Reviewed-by: Kees Cook <keescook@chromium.org>
> > ---
> >  mm/slab.h | 66 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
> >  mm/slub.c |  9 ++++++++
> >  2 files changed, 75 insertions(+)
> >
> > diff --git a/mm/slab.h b/mm/slab.h
> > index 13b6ba2abd74..c4bd0d5348cb 100644
> > --- a/mm/slab.h
> > +++ b/mm/slab.h
> > @@ -567,6 +567,46 @@ static inline struct slabobj_ext *slab_obj_exts(st=
ruct slab *slab)
> >  int alloc_slab_obj_exts(struct slab *slab, struct kmem_cache *s,
> >                       gfp_t gfp, bool new_slab);
> >
> > +static inline bool need_slab_obj_ext(void)
> > +{
> > +#ifdef CONFIG_MEM_ALLOC_PROFILING
> > +     if (mem_alloc_profiling_enabled())
> > +             return true;
> > +#endif
> > +     /*
> > +      * CONFIG_MEMCG_KMEM creates vector of obj_cgroup objects conditi=
onally
> > +      * inside memcg_slab_post_alloc_hook. No other users for now.
> > +      */
> > +     return false;
> > +}
> > +
> > +static inline struct slabobj_ext *
> > +prepare_slab_obj_exts_hook(struct kmem_cache *s, gfp_t flags, void *p)
> > +{
> > +     struct slab *slab;
> > +
> > +     if (!p)
> > +             return NULL;
> > +
> > +     if (!need_slab_obj_ext())
> > +             return NULL;
> > +
> > +     if (s->flags & SLAB_NO_OBJ_EXT)
> > +             return NULL;
> > +
> > +     if (flags & __GFP_NO_OBJ_EXT)
> > +             return NULL;
> > +
> > +     slab =3D virt_to_slab(p);
> > +     if (!slab_obj_exts(slab) &&
> > +         WARN(alloc_slab_obj_exts(slab, s, flags, false),
> > +              "%s, %s: Failed to create slab extension vector!\n",
> > +              __func__, s->name))
> > +             return NULL;
> > +
> > +     return slab_obj_exts(slab) + obj_to_index(s, slab, p);
> > +}
> > +
> >  #else /* CONFIG_SLAB_OBJ_EXT */
> >
> >  static inline struct slabobj_ext *slab_obj_exts(struct slab *slab)
> > @@ -589,6 +629,32 @@ prepare_slab_obj_exts_hook(struct kmem_cache *s, g=
fp_t flags, void *p)
> >
> >  #endif /* CONFIG_SLAB_OBJ_EXT */
> >
> > +#ifdef CONFIG_MEM_ALLOC_PROFILING
> > +
> > +static inline void alloc_tagging_slab_free_hook(struct kmem_cache *s, =
struct slab *slab,
> > +                                     void **p, int objects)
>
> Only used from mm/slub.c so could move?

Ack.

>
> > +{
> > +     struct slabobj_ext *obj_exts;
> > +     int i;
> > +
> > +     obj_exts =3D slab_obj_exts(slab);
> > +     if (!obj_exts)
> > +             return;
> > +
> > +     for (i =3D 0; i < objects; i++) {
> > +             unsigned int off =3D obj_to_index(s, slab, p[i]);
> > +
> > +             alloc_tag_sub(&obj_exts[off].ref, s->size);
> > +     }
> > +}
> > +
> > +#else
> > +
> > +static inline void alloc_tagging_slab_free_hook(struct kmem_cache *s, =
struct slab *slab,
> > +                                     void **p, int objects) {}
> > +
> > +#endif /* CONFIG_MEM_ALLOC_PROFILING */
> > +
> >  #ifdef CONFIG_MEMCG_KMEM
> >  void mod_objcg_state(struct obj_cgroup *objcg, struct pglist_data *pgd=
at,
> >                    enum node_stat_item idx, int nr);
> > diff --git a/mm/slub.c b/mm/slub.c
> > index 5dc7beda6c0d..a69b6b4c8df6 100644
> > --- a/mm/slub.c
> > +++ b/mm/slub.c
> > @@ -3826,6 +3826,7 @@ void slab_post_alloc_hook(struct kmem_cache *s, s=
truct obj_cgroup *objcg,
> >                         unsigned int orig_size)
> >  {
> >       unsigned int zero_size =3D s->object_size;
> > +     struct slabobj_ext *obj_exts;
> >       bool kasan_init =3D init;
> >       size_t i;
> >       gfp_t init_flags =3D flags & gfp_allowed_mask;
> > @@ -3868,6 +3869,12 @@ void slab_post_alloc_hook(struct kmem_cache *s, =
       struct obj_cgroup *objcg,
> >               kmemleak_alloc_recursive(p[i], s->object_size, 1,
> >                                        s->flags, init_flags);
> >               kmsan_slab_alloc(s, p[i], init_flags);
> > +             obj_exts =3D prepare_slab_obj_exts_hook(s, flags, p[i]);
> > +#ifdef CONFIG_MEM_ALLOC_PROFILING
> > +             /* obj_exts can be allocated for other reasons */
> > +             if (likely(obj_exts) && mem_alloc_profiling_enabled())
> > +                     alloc_tag_add(&obj_exts->ref, current->alloc_tag,=
 s->size);
> > +#endif
>
> I think that like in the page allocator, this could be better guarded by
> mem_alloc_profiling_enabled() as the outermost thing.

Oops, missed it. Will fix.

>
> >       }
> >
> >       memcg_slab_post_alloc_hook(s, objcg, flags, size, p);
> > @@ -4346,6 +4353,7 @@ void slab_free(struct kmem_cache *s, struct slab =
*slab, void *object,
> >              unsigned long addr)
> >  {
> >       memcg_slab_free_hook(s, slab, &object, 1);
> > +     alloc_tagging_slab_free_hook(s, slab, &object, 1);
>
> Same here, the static key is not even inside of this?

Ack.

>
> >
> >       if (likely(slab_free_hook(s, object, slab_want_init_on_free(s))))
> >               do_slab_free(s, slab, object, object, 1, addr);
> > @@ -4356,6 +4364,7 @@ void slab_free_bulk(struct kmem_cache *s, struct =
slab *slab, void *head,
> >                   void *tail, void **p, int cnt, unsigned long addr)
> >  {
> >       memcg_slab_free_hook(s, slab, p, cnt);
> > +     alloc_tagging_slab_free_hook(s, slab, p, cnt);
>
> Ditto.

Ack.

>
> >       /*
> >        * With KASAN enabled slab_free_freelist_hook modifies the freeli=
st
> >        * to remove objects, whose reuse must be delayed.
>
> --
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to kernel-team+unsubscribe@android.com.
>
