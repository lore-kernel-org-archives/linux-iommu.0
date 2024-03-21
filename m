Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 068CE8C0A
	for <iommu@lists.linux.dev>; Thu, 21 Mar 2024 17:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711041780; cv=none; b=sMokvKpDSioRs8mryzpKOZ8LyqrXugS2a1aFHwQvwcTvYczX7JoSR6+zYL+XqyHiueBOXEXjkI8hXkJfHDYFGwU+KlAAXZe/3QKDvD1e4USJTMon/uAaiqprKp+uZ5VQ2enoQ4Ks/gPKCmY9Puxm2ws5AVUU9myUCQME9UhX3X0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711041780; c=relaxed/simple;
	bh=Bla6ImeaxPC0l/wXS4fIkd5VYa4ZJlHCrM9gFW+aZB8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ha2RaaA5W/EHhlr5nt24EDJU4VNEbh6zlKk7eXoK0fEWRgF4JMHs1CB6m1Fsl1Tx/vy66sFHkyZ/JOK9+IVkNKmwN9Ezm3rdfMGRBj9NjzOmJjvAeu8y1XRXfzHdiZBNwlvmFfRPOm5yhdYlGFy+cZCcFJ6Je1R6dMJ2WlXhKCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tbkR3mSb; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tbkR3mSb"
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-dcc73148611so1355130276.3
        for <iommu@lists.linux.dev>; Thu, 21 Mar 2024 10:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711041778; x=1711646578; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w4sCto2weX/tSraSWS0s5CjzL8cyi2xaSDvgaVtTzPM=;
        b=tbkR3mSbWmbKT79JEFWiDST8SBYW5i/9jUyXZhF0z7QMerZPl9tgE3ygjwKbCyvEbg
         eEUtzQEeQI5xRa5BSFA5cfFgEDjWt1BoXgmLcm0r5R4cdnnh/+9mznXlm1E8FBUQj3z6
         72jzn13/GvbvXXxxjnmS8gTL9nEEWFrp20PUPvtSOkEnJqoogcEAqC4J1WRLi7r2E1Le
         p/ix8P16Hz0Y3rrRe3wDqW4k0jmiwcu5vCtXTfuqdP5TqPI9Dq+LfGPdaCmg5fJzXiEx
         F9+/mfASfUPS11qk/uxLsGeZuhJ6BB96XYZ/SepkGRhu9f+fS7YO3Q3VbI5169wxqdWz
         TBaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711041778; x=1711646578;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w4sCto2weX/tSraSWS0s5CjzL8cyi2xaSDvgaVtTzPM=;
        b=A73IkYmhpDAxGo0X9lrSYu/nKrtqccJsAKobts6OcjR959eSihp1HiOTzMDesB+3O+
         yrf5ebWiOsxLWRZwrnok51q3OsdKx5fIdmh2fy1R6q7IlDH91fcZq2rAaoAWLAEAXEk2
         h0c1fQIfLI7s9wY9xorP3NLaUkftt9EgUjG+DHMZBUk3MbdmCFLb89yEtcx0atGKLw8t
         dOgL4MHz/W0OvLVge8ZobdOm9w4JbbNaCmpDQUFg21znsrYZXEu6lQq2jsslQ2TLXy1o
         ZIlXDoUnFX47WbicSquRLKTXkZ/GqGpS/MtLcQCf9xJ5QsLpuR2aNJio6Ogj7ahPdTvE
         RC0A==
X-Forwarded-Encrypted: i=1; AJvYcCXG3B+DIap1akRmzh7bbOL5gzv5WUPY5Rq/srLHk77IYoG2IoY80DPJQ8lhrto28j5RgutUeB6cJWBYnwSaIGqdzhmG4KE=
X-Gm-Message-State: AOJu0YwSt3bRsNVkoMH5G5OAt9CEi7vjQQR/xGUBN8zabr2hwH1Km+9b
	Hbyg1Svf37kiaT3W/yfKKNaDCVfMFg5kQOWjk/wSzwambbmzCp/aAwueXIJ6FfCZCecYH92wfga
	doBuNVEtBZ9CKdmDWY2RYv9ooJzHamPL2DY2o
X-Google-Smtp-Source: AGHT+IEchVac4khjBai8ZMUeOEG+pay6R0DITToEq3FetB5+Bz6Fx0tQ3dmiDUpIWg8REeoZLlH/6+Ca7JUBqPCCrBc=
X-Received: by 2002:a25:3607:0:b0:dcc:323e:e1a4 with SMTP id
 d7-20020a253607000000b00dcc323ee1a4mr19870609yba.6.1711041777566; Thu, 21 Mar
 2024 10:22:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240321163705.3067592-1-surenb@google.com> <20240321163705.3067592-21-surenb@google.com>
 <Zfxk9aFhF7O_-T3c@casper.infradead.org> <ZfxohXDDCx-_cJYa@casper.infradead.org>
 <CAJuCfpHjfKYNyGeALZzwJ1k_AKOm_qcgKkx5zR+X6eyWmsZTLw@mail.gmail.com>
In-Reply-To: <CAJuCfpHjfKYNyGeALZzwJ1k_AKOm_qcgKkx5zR+X6eyWmsZTLw@mail.gmail.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Thu, 21 Mar 2024 10:22:46 -0700
Message-ID: <CAJuCfpGeep=4CqW+z4K=hXf2A6V3aWZLi_XSeEuEz1v=S7qKnw@mail.gmail.com>
Subject: Re: [PATCH v6 20/37] mm: fix non-compound multi-order memory
 accounting in __free_pages
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

On Thu, Mar 21, 2024 at 10:19=E2=80=AFAM Suren Baghdasaryan <surenb@google.=
com> wrote:
>
> On Thu, Mar 21, 2024 at 10:04=E2=80=AFAM Matthew Wilcox <willy@infradead.=
org> wrote:
> >
> > On Thu, Mar 21, 2024 at 04:48:53PM +0000, Matthew Wilcox wrote:
> > > On Thu, Mar 21, 2024 at 09:36:42AM -0700, Suren Baghdasaryan wrote:
> > > > +++ b/mm/page_alloc.c
> > > > @@ -4700,12 +4700,15 @@ void __free_pages(struct page *page, unsign=
ed int order)
> > > >  {
> > > >     /* get PageHead before we drop reference */
> > > >     int head =3D PageHead(page);
> > > > +   struct alloc_tag *tag =3D pgalloc_tag_get(page);
> > > >
> > > >     if (put_page_testzero(page))
> > > >             free_the_page(page, order);
> > > > -   else if (!head)
> > > > +   else if (!head) {
> > > > +           pgalloc_tag_sub_pages(tag, (1 << order) - 1);
> > > >             while (order-- > 0)
> > > >                     free_the_page(page + (1 << order), order);
> > > > +   }
> > >
> > > Why do you need these new functions instead of just:
> > >
> > > +     else if (!head) {
> > > +             pgalloc_tag_sub(page, (1 << order) - 1);
> > >               while (order-- > 0)
> > >                       free_the_page(page + (1 << order), order);
> > > +     }
> >
> > Actually, I'm not sure this is safe (I don't fully understand codetags,
> > so it may be safe).  What can happen is that the put_page() can come in
> > before the pgalloc_tag_sub(), and then that page can be allocated again=
.
> > Will that cause confusion?

I indirectly answered your question in the reason #2 but to be clear,
we obtain codetag before we do put_page() here, therefore it's valid.
If another page is allocated and it points to the same codetag, then
it will operate on the same codetag per-cpu counters and that should
not be a problem.

>
> So, there are two reasons I unfortunately can't reuse pgalloc_tag_sub():
>
> 1. We need to subtract `bytes` counter from the codetag but not the
> `calls` counter, otherwise the final accounting will be incorrect.
> This is because we effectively allocated multiple pages with one call
> but freeing them with separate calls here. pgalloc_tag_sub_pages()
> subtracts bytes but keeps calls counter the same. I mentioned this in
> here: https://lore.kernel.org/all/CAJuCfpEgh1OiYNE_uKG-BqW2x97sOL9+AaTX4J=
ct3=3DWHzAv+kg@mail.gmail.com/
> 2. The codetag object itself is stable, it's created at build time.
> The exception is when we unload modules and the codetag section gets
> freed but during module unloading we check that all module codetags
> are not referenced anymore and we prevent unloading this section if
> any of them are still referenced (should not normally happen). That
> said, the reference to the codetag (in this case from the page_ext)
> might change from under us and we have to make sure it's valid. We
> ensure that here by getting the codetag itself with pgalloc_tag_get()
> *before* calling put_page_testzero(), which ensures its stability.
>
> >
