Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A54A4134738
	for <iommu@lists.linux.dev>; Wed, 14 Feb 2024 19:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707938405; cv=none; b=Y2ms/2acmb6OlMBLXmBNNyR/M5odqxlpZt8xL9/WUiBLeODKIIjndjAQsbfN+jydpF1ea+utkV3FgsbN0tNWKum3aENtApd1Sp7SkywFK/E1C17zAc4sifhELql+tQUvndWnoNpF49kadK0zJEbiljabX9u3hlsA4Xvagj92gjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707938405; c=relaxed/simple;
	bh=mthDvVI6cDtpS/5u1GLcBFHB8octCFvJ1gmdlmC2/g8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l7wF2dB6ZD8+54OFCQbC+VzgrTnBj9ZuDL88Vun5ZWmTHSg3W7nut+Ol/9g9BnrxP/oEPRcy5j/A/Y/a22ET+J2NXWeoGwg7Zz2wRIJ15tb4G+q6OQnqM0uJNK8vFa6ZvBGNgAc39xNrQ1Cr2+pmgkaAjC6tULjScLyDg77XBPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TKVtRJtV; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TKVtRJtV"
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-dcd7c526cc0so16904276.1
        for <iommu@lists.linux.dev>; Wed, 14 Feb 2024 11:20:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707938402; x=1708543202; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BeLyV2BNkjBFN275c/stAXS4Zt5cMLEm0RT7xxWo7xU=;
        b=TKVtRJtVpz5tCZmKW46FOz5BAsHIr36FX0oUg9d3QKUD26pRiqngc3LThnFD7mWne0
         Qk3OAaLr1Es5SoE6D19c5S3lTJUD6MFCIgJDrq/MefcPfqbiX52pNAWQIpmQPPhOt/pF
         13c9jJfz8a1bYvwLCO6TvnYmLcnjBuJW3kUAP1mLEuijdqPJ0cYX5xd0w27/6BQCv/kQ
         11mDwD/NDmpJsPnGFR17GnKTEqH5M8u1iNM8JxwvG6sov7gY9FrJQu/5BsdvbYjl7Y5F
         C1x9K5o5QVRCCsyOElWszYGRLtRVNMC6BAUMBQZ1yOQ8K6qlDfMxsCaS67pfLixM5mW1
         5BMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707938402; x=1708543202;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BeLyV2BNkjBFN275c/stAXS4Zt5cMLEm0RT7xxWo7xU=;
        b=HeyzyGx5LlM4QG7s9+oFao37FN2p46raMrTjiidD35bPbhg1AK+mWIUAG/7IGhbXwC
         NmDzK4ONz4D+OgfbF2iZGPyP66dQy/IjW/IZhTFwbHKNVsZ0lfiqQ5c6bXbKmma187+W
         piwJrXYkqZ2OF/cMhSuzEKV6NtkMO31K/xM6PSMIuiQLJYArrJ0jcHRdeLOcwEaNS9bF
         N9l3hI6y6wtwrp2ogyVC0kdcLmgbzIaYL+tmOVCM34hEjMkWfzAGxtdPQNPqQs4FXnpM
         qEgflcydcHheUHHh3k5Gw5hDrgF5Nhvp/VwVOPnB9CH/e9BiUDLVpV6tHgk1hjS2L6tF
         SMgw==
X-Forwarded-Encrypted: i=1; AJvYcCVsp7NL7b7BDzqDoApj9X7Uh+M6WRjvlyRsxrQEdVA0LJR2/c8eyzAIBZZ5i9+FO4jpDThs7ZmPzxdv+wG6UbDu+hifg5E=
X-Gm-Message-State: AOJu0Yy+NPtNb5UPb2Wu85b1mLQCeHrkjtOK6OZyazzK6x9ymOVcIhNl
	xYb5DxwM65TPTUjhStnyEeHyJ3fs/AkCyE6Z+g1G6gfM0d8CfP0g8fHvQgw5PZEA6Uo3hrXCfI0
	4czVaWAuuOmcOEVLX20Oj+M5cIpJ7YBj3cbwZ
X-Google-Smtp-Source: AGHT+IF2W3nFVUFRR9wPoi/qm4zOQswf3iODsFgqsQ39xkvihJBeUWVirJIMSGlhcPqgmo6BGDfddGXZmkzLZyBUkMg=
X-Received: by 2002:a25:8708:0:b0:dc6:c617:7ca with SMTP id
 a8-20020a258708000000b00dc6c61707camr3594670ybl.29.1707938402225; Wed, 14 Feb
 2024 11:20:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240212213922.783301-1-surenb@google.com> <20240212213922.783301-6-surenb@google.com>
 <3cf2acae-cb8d-455a-b09d-a1fdc52f5774@suse.cz>
In-Reply-To: <3cf2acae-cb8d-455a-b09d-a1fdc52f5774@suse.cz>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 14 Feb 2024 11:19:51 -0800
Message-ID: <CAJuCfpH6O4tKP5=aD=PHnM8TpDLi_s6cRLHy-1i-7Eie0wqnFA@mail.gmail.com>
Subject: Re: [PATCH v3 05/35] mm: introduce slabobj_ext to support slab object extensions
To: Vlastimil Babka <vbabka@suse.cz>
Cc: akpm@linux-foundation.org, kent.overstreet@linux.dev, mhocko@suse.com, 
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

On Wed, Feb 14, 2024 at 9:59=E2=80=AFAM Vlastimil Babka <vbabka@suse.cz> wr=
ote:
>
> On 2/12/24 22:38, Suren Baghdasaryan wrote:
> > Currently slab pages can store only vectors of obj_cgroup pointers in
> > page->memcg_data. Introduce slabobj_ext structure to allow more data
> > to be stored for each slab object. Wrap obj_cgroup into slabobj_ext
> > to support current functionality while allowing to extend slabobj_ext
> > in the future.
> >
> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
>
> ...
>
> > +static inline bool need_slab_obj_ext(void)
> > +{
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
> > +     slab =3D virt_to_slab(p);
> > +     if (!slab_obj_exts(slab) &&
> > +         WARN(alloc_slab_obj_exts(slab, s, flags, false),
> > +              "%s, %s: Failed to create slab extension vector!\n",
> > +              __func__, s->name))
> > +             return NULL;
> > +
> > +     return slab_obj_exts(slab) + obj_to_index(s, slab, p);
>
> This is called in slab_post_alloc_hook() and the result stored to obj_ext=
s
> but unused. Maybe introduce this only in a later patch where it becomes
> relevant?

Ack. I'll move it into the patch where we start using obj_exts.

>
> > --- a/mm/slab_common.c
> > +++ b/mm/slab_common.c
> > @@ -201,6 +201,54 @@ struct kmem_cache *find_mergeable(unsigned int siz=
e, unsigned int align,
> >       return NULL;
> >  }
> >
> > +#ifdef CONFIG_SLAB_OBJ_EXT
> > +/*
> > + * The allocated objcg pointers array is not accounted directly.
> > + * Moreover, it should not come from DMA buffer and is not readily
> > + * reclaimable. So those GFP bits should be masked off.
> > + */
> > +#define OBJCGS_CLEAR_MASK    (__GFP_DMA | __GFP_RECLAIMABLE | \
> > +                             __GFP_ACCOUNT | __GFP_NOFAIL)
> > +
> > +int alloc_slab_obj_exts(struct slab *slab, struct kmem_cache *s,
> > +                     gfp_t gfp, bool new_slab)
>
> Since you're moving this function between files anyway, could you please
> instead move it to mm/slub.c. I expect we'll eventually (maybe even soon)
> move the rest of performance sensitive kmemcg hooks there as well to make
> inlining possible.

Will do.

>
> > +{
> > +     unsigned int objects =3D objs_per_slab(s, slab);
> > +     unsigned long obj_exts;
> > +     void *vec;
> > +
> > +     gfp &=3D ~OBJCGS_CLEAR_MASK;
> > +     vec =3D kcalloc_node(objects, sizeof(struct slabobj_ext), gfp,
> > +                        slab_nid(slab));
> > +     if (!vec)
> > +             return -ENOMEM;
> > +
> > +     obj_exts =3D (unsigned long)vec;
> > +#ifdef CONFIG_MEMCG
> > +     obj_exts |=3D MEMCG_DATA_OBJEXTS;
> > +#endif
> > +     if (new_slab) {
> > +             /*
> > +              * If the slab is brand new and nobody can yet access its
> > +              * obj_exts, no synchronization is required and obj_exts =
can
> > +              * be simply assigned.
> > +              */
> > +             slab->obj_exts =3D obj_exts;
> > +     } else if (cmpxchg(&slab->obj_exts, 0, obj_exts)) {
> > +             /*
> > +              * If the slab is already in use, somebody can allocate a=
nd
> > +              * assign slabobj_exts in parallel. In this case the exis=
ting
> > +              * objcg vector should be reused.
> > +              */
> > +             kfree(vec);
> > +             return 0;
> > +     }
> > +
> > +     kmemleak_not_leak(vec);
> > +     return 0;
> > +}
> > +#endif /* CONFIG_SLAB_OBJ_EXT */
> > +
> >  static struct kmem_cache *create_cache(const char *name,
> >               unsigned int object_size, unsigned int align,
> >               slab_flags_t flags, unsigned int useroffset,
> > diff --git a/mm/slub.c b/mm/slub.c
> > index 2ef88bbf56a3..1eb1050814aa 100644
> > --- a/mm/slub.c
> > +++ b/mm/slub.c
> > @@ -683,10 +683,10 @@ static inline bool __slab_update_freelist(struct =
kmem_cache *s, struct slab *sla
> >
> >       if (s->flags & __CMPXCHG_DOUBLE) {
> >               ret =3D __update_freelist_fast(slab, freelist_old, counte=
rs_old,
> > -                                         freelist_new, counters_new);
> > +                                         freelist_new, counters_new);
> >       } else {
> >               ret =3D __update_freelist_slow(slab, freelist_old, counte=
rs_old,
> > -                                         freelist_new, counters_new);
> > +                                         freelist_new, counters_new);
> >       }
> >       if (likely(ret))
> >               return true;
> > @@ -710,13 +710,13 @@ static inline bool slab_update_freelist(struct km=
em_cache *s, struct slab *slab,
> >
> >       if (s->flags & __CMPXCHG_DOUBLE) {
> >               ret =3D __update_freelist_fast(slab, freelist_old, counte=
rs_old,
> > -                                         freelist_new, counters_new);
> > +                                         freelist_new, counters_new);
> >       } else {
> >               unsigned long flags;
> >
> >               local_irq_save(flags);
> >               ret =3D __update_freelist_slow(slab, freelist_old, counte=
rs_old,
> > -                                         freelist_new, counters_new);
> > +                                         freelist_new, counters_new);
>
> I can see the mixing of tabs and spaces is wrong but perhaps not fix it a=
s
> part of the series?

I'll fix them in the next version.

>
> >               local_irq_restore(flags);
> >       }
> >       if (likely(ret))
> > @@ -1881,13 +1881,25 @@ static inline enum node_stat_item cache_vmstat_=
idx(struct kmem_cache *s)
> >               NR_SLAB_RECLAIMABLE_B : NR_SLAB_UNRECLAIMABLE_B;
> >  }
> >
> > -#ifdef CONFIG_MEMCG_KMEM
> > -static inline void memcg_free_slab_cgroups(struct slab *slab)
> > +#ifdef CONFIG_SLAB_OBJ_EXT
> > +static inline void free_slab_obj_exts(struct slab *slab)
>
> Right, freeing is already here, so makes sense put the allocation here as=
 well.
>
> > @@ -3817,6 +3820,7 @@ void slab_post_alloc_hook(struct kmem_cache *s, s=
truct obj_cgroup *objcg,
> >               kmemleak_alloc_recursive(p[i], s->object_size, 1,
> >                                        s->flags, init_flags);
> >               kmsan_slab_alloc(s, p[i], init_flags);
> > +             obj_exts =3D prepare_slab_obj_exts_hook(s, flags, p[i]);
>
> Yeah here's the hook used. Doesn't it generate a compiler warning? Maybe =
at
> least postpone the call until the result is further used.

Yes, I'll move that into the patch where we start using it.

Thanks for the review, Vlastimil!

>
> >       }
> >
> >       memcg_slab_post_alloc_hook(s, objcg, flags, size, p);
>
> --
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to kernel-team+unsubscribe@android.com.
>
