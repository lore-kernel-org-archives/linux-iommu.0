Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E7B24C618
	for <iommu@lists.linux.dev>; Fri, 15 Mar 2024 17:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710522409; cv=none; b=I0aTXFE+VJxcUcu0/f4acePGo5zVfHmLMq7IUaNoIiYL8WXo/jWypthAJXuVsUkxo/KSocMJrCbSLwm1yVhy40Pw294/dml84LywUEgAULu+G7Zt3IQiImbcjwLC9EHJazxX5faCNnDGQouBpxXaCP36w6TfAfKq/7lwfKl6RFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710522409; c=relaxed/simple;
	bh=LNQjeHjDBEInTCwCSWcroDRYdeiq48Ic8r1TtkNrkfA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BrG4RE45OjLDT9bzYM8C0U3uRceLFuu/bQ0r+9NqREdXWCEWinmML5eYZbbsDBCJqZvcyrmVZQy5HOFCAdKWkyG5+oOmPSFLnW9IRcwkG2PYTXkG/MEQldFTNJMMqbKoY9IWUp+/lN3uUYpZcQo3zKNh0cvdcXf+mw87YwodpkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xm9qQeaH; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xm9qQeaH"
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-dd161eb03afso2052464276.0
        for <iommu@lists.linux.dev>; Fri, 15 Mar 2024 10:06:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710522406; x=1711127206; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rC572A3yia7X47ZYtWd+ymj431bX9Z5tiP3vPmrWrg8=;
        b=xm9qQeaHcdI4PkgbtoUph6E3ekqnuIlSAWpW6TtqYmvo3IeXYbaDPUJv7iTlLDddmS
         D3ct5JCJdJD5ELhbq6Gz4mgSMTW9tJhfQULJtVvqIVjk4erKAPAGQg9ms26LO3+w0JQx
         pEaQlRxZKlsqh0IPtXrM4GmecZXguQp5i8t03jobT4g5AK1emJ3DJY1vL45/iKz0c53H
         jPF6eX7AJVW3p/rfNvc52bZCBlw5C3oL4LqE+TMi9zSNEbvGShVnUUrZ6gK/7LHBdP64
         eK5vaim5Zwaat6F95rhvxPqVNDpWKYn3325C0R4CvBbS+/PokT6/ME2AldhQpGY6mWom
         nzvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710522406; x=1711127206;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rC572A3yia7X47ZYtWd+ymj431bX9Z5tiP3vPmrWrg8=;
        b=TH3HhXzQ6IM+sYKcXYJJicUUagA2e8yvC25HV6JAaAQza2hYr14y+9Z0KGmoAO6Ioz
         yIY8BxPaAS7dY/3MPJqlDI8KKlTUXm8cXNor8kZUe+yVsI5beGFOHYY1nwaJRd1JuMqm
         glmmb6D3lLxkuG+O/tQD44mWZAvK50py10aKCcBm4CsWBoNQOPnpTJ3DBGyMOyiQY/nU
         raMxIoEUq7hQBTPcZ5lGY+MsqR/17yV1wKec0sw2FOU+fFGyg7z3WS4l7Ktd62247qTp
         IJCSAqMW8iPwR1Ifq5h3KlssNztylNB0UYwVsZXu/7mo5vnZoOsxP/Qmag1/tAjSan1t
         lVUA==
X-Forwarded-Encrypted: i=1; AJvYcCWTSBHlYwobJgSZO90UrRncGSmccYghDKD21g8ku9iBZ5qDi4yOmbXWVaOgZsmTf1ioZI2feNFSxyHHDpAJu0+Y9xFpoVM=
X-Gm-Message-State: AOJu0Yz690fPZLefMXb72PTAt1NvRRY/1xBRYHDA8t/2dSsViul9ruyC
	WmqLWzwYfCZypJ6IPBlOTylv0TEYP4aiBKY5+cAAjPnghhm9TGCNQY2MQ5wf3YHGSpq0/7D/5Wt
	ZvshEHhWG7NtOWa2Mxio6GKG2wxkUie9PJlgl
X-Google-Smtp-Source: AGHT+IG+SAoqNcEaTJHB1lafvOscPKTA59uq+i5wvMJxRbkvSwmj0DhtE9DM8+iuZUaegEqULpfsbKdPtUWThZDcacY=
X-Received: by 2002:a25:dbca:0:b0:dcc:273e:1613 with SMTP id
 g193-20020a25dbca000000b00dcc273e1613mr5471648ybf.40.1710522405619; Fri, 15
 Mar 2024 10:06:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240306182440.2003814-1-surenb@google.com> <20240306182440.2003814-24-surenb@google.com>
 <1f51ffe8-e5b9-460f-815e-50e3a81c57bf@suse.cz> <CAJuCfpE5mCXiGLHTm1a8PwLXrokexx9=QrrRF4fWVosTh5Q7BA@mail.gmail.com>
 <e6e96b64-01b1-4e23-bb0b-45438f9a6cc4@suse.cz>
In-Reply-To: <e6e96b64-01b1-4e23-bb0b-45438f9a6cc4@suse.cz>
From: Suren Baghdasaryan <surenb@google.com>
Date: Fri, 15 Mar 2024 17:06:32 +0000
Message-ID: <CAJuCfpEsAHSAUP_EFP4yZdyZ1hfVPbQSWn9j-eZQdiRLy5MGYg@mail.gmail.com>
Subject: Re: [PATCH v5 23/37] mm/slab: add allocation accounting into slab
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
	nathan@kernel.org, dennis@kernel.org, jhubbard@nvidia.com, tj@kernel.org, 
	muchun.song@linux.dev, rppt@kernel.org, paulmck@kernel.org, 
	pasha.tatashin@soleen.com, yosryahmed@google.com, yuzhao@google.com, 
	dhowells@redhat.com, hughd@google.com, andreyknvl@gmail.com, 
	keescook@chromium.org, ndesaulniers@google.com, vvvvvv@google.com, 
	gregkh@linuxfoundation.org, ebiggers@google.com, ytcoode@gmail.com, 
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org, 
	bsegall@google.com, bristot@redhat.com, vschneid@redhat.com, cl@linux.com, 
	penberg@kernel.org, iamjoonsoo.kim@lge.com, 42.hyeyoo@gmail.com, 
	glider@google.com, elver@google.com, dvyukov@google.com, shakeelb@google.com, 
	songmuchun@bytedance.com, jbaron@akamai.com, aliceryhl@google.com, 
	rientjes@google.com, minchan@google.com, kaleshsingh@google.com, 
	kernel-team@android.com, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev, 
	linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-modules@vger.kernel.org, kasan-dev@googlegroups.com, 
	cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 15, 2024 at 4:52=E2=80=AFPM Vlastimil Babka <vbabka@suse.cz> wr=
ote:
>
> On 3/15/24 16:43, Suren Baghdasaryan wrote:
> > On Fri, Mar 15, 2024 at 3:58=E2=80=AFAM Vlastimil Babka <vbabka@suse.cz=
> wrote:
> >>
> >> On 3/6/24 19:24, Suren Baghdasaryan wrote:
> >> > Account slab allocations using codetag reference embedded into slabo=
bj_ext.
> >> >
> >> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> >> > Co-developed-by: Kent Overstreet <kent.overstreet@linux.dev>
> >> > Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
> >> > Reviewed-by: Kees Cook <keescook@chromium.org>
> >>
> >> Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
> >>
> >> Nit below:
> >>
> >> > @@ -3833,6 +3913,7 @@ void slab_post_alloc_hook(struct kmem_cache *s=
, struct obj_cgroup *objcg,
> >> >                         unsigned int orig_size)
> >> >  {
> >> >       unsigned int zero_size =3D s->object_size;
> >> > +     struct slabobj_ext *obj_exts;
> >> >       bool kasan_init =3D init;
> >> >       size_t i;
> >> >       gfp_t init_flags =3D flags & gfp_allowed_mask;
> >> > @@ -3875,6 +3956,12 @@ void slab_post_alloc_hook(struct kmem_cache *=
s,        struct obj_cgroup *objcg,
> >> >               kmemleak_alloc_recursive(p[i], s->object_size, 1,
> >> >                                        s->flags, init_flags);
> >> >               kmsan_slab_alloc(s, p[i], init_flags);
> >> > +             obj_exts =3D prepare_slab_obj_exts_hook(s, flags, p[i]=
);
> >> > +#ifdef CONFIG_MEM_ALLOC_PROFILING
> >> > +             /* obj_exts can be allocated for other reasons */
> >> > +             if (likely(obj_exts) && mem_alloc_profiling_enabled())
>
> Could you at least flip these two checks then so the static key one goes =
first?

Yes, definitely. I was thinking about removing need_slab_obj_ext()
from prepare_slab_obj_exts_hook() and adding this instead of the above
code:

+        if (need_slab_obj_ext()) {
+                obj_exts =3D prepare_slab_obj_exts_hook(s, flags, p[i]);
+#ifdef CONFIG_MEM_ALLOC_PROFILING
+                /*
+                 * Currently obj_exts is used only for allocation
profiling. If other users appear
+                 * then mem_alloc_profiling_enabled() check should be
added here.
+                 */
+                if (likely(obj_exts))
+                        alloc_tag_add(&obj_exts->ref,
current->alloc_tag, s->size);
+#endif
+        }

Does that look good?

> >> > +#ifdef CONFIG_MEM_ALLOC_PROFILING
> >> > +             /* obj_exts can be allocated for other reasons */
> >> > +             if (likely(obj_exts) && mem_alloc_profiling_enabled())
>
> >> > +                     alloc_tag_add(&obj_exts->ref, current->alloc_t=
ag, s->size);
> >> > +#endif
> >>
> >> I think you could still do this a bit better:
> >>
> >> Check mem_alloc_profiling_enabled() once before the whole block callin=
g
> >> prepare_slab_obj_exts_hook() and alloc_tag_add()
> >> Remove need_slab_obj_ext() check from prepare_slab_obj_exts_hook()
> >
> > Agree about checking mem_alloc_profiling_enabled() early and one time,
> > except I would like to use need_slab_obj_ext() instead of
> > mem_alloc_profiling_enabled() for that check. Currently they are
> > equivalent but if there are more slab_obj_ext users in the future then
> > there will be cases when we need to prepare_slab_obj_exts_hook() even
> > when mem_alloc_profiling_enabled()=3D=3Dfalse. need_slab_obj_ext() will=
 be
> > easy to extend for such cases.
>
> I thought we don't generally future-proof internal implementation details
> like this until it's actually needed. But at least what I suggested above
> would help, thanks.
>
> > Thanks,
> > Suren.
> >
> >>
> >> >       }
> >> >
> >> >       memcg_slab_post_alloc_hook(s, objcg, flags, size, p);
> >> > @@ -4353,6 +4440,7 @@ void slab_free(struct kmem_cache *s, struct sl=
ab *slab, void *object,
> >> >              unsigned long addr)
> >> >  {
> >> >       memcg_slab_free_hook(s, slab, &object, 1);
> >> > +     alloc_tagging_slab_free_hook(s, slab, &object, 1);
> >> >
> >> >       if (likely(slab_free_hook(s, object, slab_want_init_on_free(s)=
)))
> >> >               do_slab_free(s, slab, object, object, 1, addr);
> >> > @@ -4363,6 +4451,7 @@ void slab_free_bulk(struct kmem_cache *s, stru=
ct slab *slab, void *head,
> >> >                   void *tail, void **p, int cnt, unsigned long addr)
> >> >  {
> >> >       memcg_slab_free_hook(s, slab, p, cnt);
> >> > +     alloc_tagging_slab_free_hook(s, slab, p, cnt);
> >> >       /*
> >> >        * With KASAN enabled slab_free_freelist_hook modifies the fre=
elist
> >> >        * to remove objects, whose reuse must be delayed.
> >>
>
> --
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to kernel-team+unsubscribe@android.com.
>
