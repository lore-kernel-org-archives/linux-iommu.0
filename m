Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 427FB79B82
	for <iommu@lists.linux.dev>; Wed, 28 Feb 2024 18:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709143656; cv=none; b=frTCICezMdHyYco9fPNXITNMg7QpMnyGD2p5bqJEwPrJuipuJBcTSrS5czmJuxHxMs4zDlrSXMwujOUWuO3FD5Z/Lq1qseBHhW8G17hfqLDPkHoYSBUEaP9alL5tvvC495/QukB89nMWFM9RInWWnFt5/ut7pEjNsa7GmUgn0Aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709143656; c=relaxed/simple;
	bh=rv47TPwMaL5mB4Ug9VuCbJFQC3RVZQfJetV44+QcIfk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mdbjSob1t8PMT8Ba3keHx+oOJJbKDCqBBnKjmS+cAXbJ0E7SyUp1VnUbxSh3qNzy/B4xQEllWjJBYm35Ufu/xi2jGUMRAbaAzs7Uhce8lIKerKIkl4H81TIzAk4tYmPAOa0V1E6K5lG33dJd3HV51LY/Swzx5ERghYtUq+L4tnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bAgVe+Ca; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bAgVe+Ca"
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3c19bc08f96so3580097b6e.2
        for <iommu@lists.linux.dev>; Wed, 28 Feb 2024 10:07:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709143653; x=1709748453; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TpJn79d7ymx24Tp5aF1RCceBrMYpEjjJMLmxKg1qMeo=;
        b=bAgVe+CaUJ6rHZN4osJ7InkvI2UfZ1oO0QsHkyu1o+xfk6b4qXlIufGrJepGH6VHti
         AR7OqD/zYKuj7Yzt4Vw/7Slhf1ZyVnGJPKzAkaB273vaqFIqDjtXfiC7PHBeC2+piQDQ
         5VdM2BSji3LYCvUHHc1iAy4kKkBij8LDfxbBhYzMNYkGdZ0ig0Js4Cg+gU0cuLR9mjy7
         YY4Rw4fcMjOxhKXA8Zv9rlXCH6R+yw+/8Coq3fvlXlwLA36IZ/SjEasKWiSGnx1U/u2b
         +YPdzACPKknCLwgAM0z8Agx5g2i0RHPx/tO5ul1CfNaJbva/0D3OoIEb/ngZqrkAOGT/
         /2hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709143653; x=1709748453;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TpJn79d7ymx24Tp5aF1RCceBrMYpEjjJMLmxKg1qMeo=;
        b=vn+DntHfRDVqYlRYE7gn1MKWdw6agy9l6d+O0oHZyKvCZG3wQOI/cqc+t+oSWCeIk1
         0HsUuJ42q8a3YBPC4dqliKxzp6vanpHhT1zFdSt4EYpRZmERva1Sstp4CLSW5oAvbXld
         9pMYLFXBbI3gwsvUDgLOT1uIDJhwv5krnX3SUEsPkmanpkwvJJy4D9sI8j3OMX2AeMAz
         yDUZA4A5MNLj62wRbygXtYtZvo945Vpct8TufLokcFdzUZZgTK/23DGcQXEjh9Gi6IwV
         it8oy7dTTkCS6ZZiKwd9MVv8XvQZ4lL+p6ilcWmyPL7xls/fYiZ9s6rJjKDNQ4EYguEX
         fA1Q==
X-Forwarded-Encrypted: i=1; AJvYcCWoZuYWl25kgFOlkE7KlzjoOOT7eLpbXk33EhBrJqRGHpdz7aUEuLhzW5jrYRm+Phkj0d0b0Tuco8TFaojpw8JisJNHO/w=
X-Gm-Message-State: AOJu0Yz4WU6SUsJ2JIBmEKGqBR8hYhJTM0hLU3lvBE1HRicRcGm2OHVL
	tG1NJhNguwRru355bS1Q1C0ms2xueNHy73m+BkDVHP8I24X615eWi3gIgwS4xaYw3Jj8y0pV9jV
	3y/e0189aqtvoNNf8XUchRitr0mA8//GcpNBQ
X-Google-Smtp-Source: AGHT+IE9fAMwB02uuQ94nEpy4LyanC7xT4icsl4y9kTpTBjAiVMb+QVVN/OZ7PFrRjTuaOAC60zwFIwL5MnGwsnXp9Q=
X-Received: by 2002:a05:6358:80a8:b0:17b:521f:b2ae with SMTP id
 a40-20020a05635880a800b0017b521fb2aemr6472rwk.14.1709143652850; Wed, 28 Feb
 2024 10:07:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240221194052.927623-1-surenb@google.com> <20240221194052.927623-15-surenb@google.com>
 <b62d2ace-4619-40ac-8536-c5626e95d87b@suse.cz>
In-Reply-To: <b62d2ace-4619-40ac-8536-c5626e95d87b@suse.cz>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 28 Feb 2024 18:07:18 +0000
Message-ID: <CAJuCfpEsBEK5M72v1MdSBnh_bFgJLRj3JzDdz1X1BGzfJw6sfw@mail.gmail.com>
Subject: Re: [PATCH v4 14/36] lib: add allocation tagging support for memory
 allocation profiling
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

On Wed, Feb 28, 2024 at 8:41=E2=80=AFAM Vlastimil Babka <vbabka@suse.cz> wr=
ote:
>
> Another thing I noticed, dunno how critical
>
> On 2/21/24 20:40, Suren Baghdasaryan wrote:
> > +static inline void __alloc_tag_sub(union codetag_ref *ref, size_t byte=
s)
> > +{
> > +     struct alloc_tag *tag;
> > +
> > +#ifdef CONFIG_MEM_ALLOC_PROFILING_DEBUG
> > +     WARN_ONCE(ref && !ref->ct, "alloc_tag was not set\n");
> > +#endif
> > +     if (!ref || !ref->ct)
> > +             return;
>
> This is quite careful.
>
> > +
> > +     tag =3D ct_to_alloc_tag(ref->ct);
> > +
> > +     this_cpu_sub(tag->counters->bytes, bytes);
> > +     this_cpu_dec(tag->counters->calls);
> > +
> > +     ref->ct =3D NULL;
> > +}
> > +
> > +static inline void alloc_tag_sub(union codetag_ref *ref, size_t bytes)
> > +{
> > +     __alloc_tag_sub(ref, bytes);
> > +}
> > +
> > +static inline void alloc_tag_sub_noalloc(union codetag_ref *ref, size_=
t bytes)
> > +{
> > +     __alloc_tag_sub(ref, bytes);
> > +}
> > +
> > +static inline void alloc_tag_ref_set(union codetag_ref *ref, struct al=
loc_tag *tag)
> > +{
> > +#ifdef CONFIG_MEM_ALLOC_PROFILING_DEBUG
> > +     WARN_ONCE(ref && ref->ct,
> > +               "alloc_tag was not cleared (got tag for %s:%u)\n",\
> > +               ref->ct->filename, ref->ct->lineno);
> > +
> > +     WARN_ONCE(!tag, "current->alloc_tag not set");
> > +#endif
> > +     if (!ref || !tag)
> > +             return;
>
> This too.
>
> > +
> > +     ref->ct =3D &tag->ct;
> > +     /*
> > +      * We need in increment the call counter every time we have a new
> > +      * allocation or when we split a large allocation into smaller on=
es.
> > +      * Each new reference for every sub-allocation needs to increment=
 call
> > +      * counter because when we free each part the counter will be dec=
remented.
> > +      */
> > +     this_cpu_inc(tag->counters->calls);
> > +}
> > +
> > +static inline void alloc_tag_add(union codetag_ref *ref, struct alloc_=
tag *tag, size_t bytes)
> > +{
> > +     alloc_tag_ref_set(ref, tag);
>
> We might have returned from alloc_tag_ref_set() due to !tag
>
> > +     this_cpu_add(tag->counters->bytes, bytes);
>
> But here we still assume it's valid.

Yes, this is a blunder on my side after splitting alloc_tag_ref_set()
into a separate function. I'll fix this in the next version. Thanks!

>
> > +}
> > +
>
> --
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to kernel-team+unsubscribe@android.com.
>
