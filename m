Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A0CE1C4A20
	for <iommu@lists.linux.dev>; Mon, 26 Jan 2026 01:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769391796; cv=pass; b=adcTxIUN9KS2wZQflpSQYP9cHSw9UfUSqaeKfCKmoT2yMo+UlXQuOWK81xZTUaKc2luYCd6weP/TMDkz1jBclsWaHvNkjLe6ocUbPiC1huL0Srekg7VGaESrvHJJgKIHmo4lU7qP6uxLLHtAerbR8/HjVDC37NtKKvxboBDejXQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769391796; c=relaxed/simple;
	bh=ShqFT9AIDvn/Aacc2hNx3D4aX32pq+QTgFv1oZuGe/U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=awgo/n4ujE04iLvra9v+5OkRE57nIA5MqqRmBwJu9Ah6t82eI0Opk5UPySO0duxh8MyeUzVIsfPfwmFdSP4b7UqLI3gZRCQ4IIvkEY++mKhGLfqh2SiD9erTOeibfvG1V1FOIbj7KQhi/ofXkWnO8QMBuhbdyS4S2sSxwLGXrCA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CMQ48KvJ; arc=pass smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CMQ48KvJ"
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-8887ac841e2so33891206d6.2
        for <iommu@lists.linux.dev>; Sun, 25 Jan 2026 17:43:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769391794; cv=none;
        d=google.com; s=arc-20240605;
        b=Chw9DbXCyhJF4jJ/uH7qAPJOGfxYtvjI/Rs0sxaGMidXTkpvzclAlas3M8vDfSIxqt
         BDezilfg0FKgxyJiW8UDQ6qnk6KC2kyIkzcHP64+6OQ6X+zH/MnX/9HUWqnW0fsktsrc
         sgSR6TrdMLY06NaXCapDfmq6i/1G30Hj9SbjLgel6I5BUIBmni6K45M4ZODvQ7bpTMNF
         4ww4TDFdBXpXHGCcNvOSQMDbjXhYBjs0cMaV9c+JmcEPh2Xgh9VZg2Uf44U//G53sNCJ
         dpaAxeNGV5Vn1pxaTQpyHN0PdBen8BoOjTIUt29GDioF8zY1RohnAEkAV8VytMYTn/NY
         I4Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Td4QUCSFnNiGlIQcniNA/rp8ZfKnX5RqAxkcu4MfCJE=;
        fh=ooHqn3+NgbbG8ZG+vTT5dXNhL3GsYofizUUIbAwAeNk=;
        b=jG9ul/+FU0bqSUqXqvTrGEi6wUZyEL5LmjvJznwveaKF4xJY6E2jhIdnHGri/rGwqD
         ga3O4syKprobpp2veIL+vlrhd7PvlHgLQO/Qpbu62tTBNnx0XmONBNqqjVn5zxS/OeEl
         Ssio56OtTc6H45Acp6VdHt/Gyr0uzXaFu0St4NfX85e31vbBXdP2WuKPIhKamfFCNaKF
         /fbkvrUInuEDEvr8Aaj/Zgak2Um+34+zp/h8a1tQiMgfuN+eu+CT0qk4P6dOUG7JCVqW
         j9p/o+getZrzCc5m+RxqaUJPLbCtJ7HfP3ezRVxE87sELv9WlDEkarPUyvq0yGtvqe/w
         wpLA==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769391794; x=1769996594; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Td4QUCSFnNiGlIQcniNA/rp8ZfKnX5RqAxkcu4MfCJE=;
        b=CMQ48KvJazx7b2Oena1od3ikzp9J2c28ooIHPQzKdfY32xMkQBYi3R9htIaG5Qwzl8
         VPYZfTanMPJpp2MBRaF+Q67pA8fmFNiDtuLpaMUxxtIXhgMQqGYba6SC8NFaWBJoi5cg
         nBb9FjGA6aX1g562J8RT6qhsB/vYm1O8gSxt7FOhCRwHgdFaI16JB9ajoWl4WelQYgih
         eFUkg53iCZgcqWXW/luS/kJh21JLYBBN8p5B2861E4l8DUFE/LMz7AKH+pHrFlt8WZ4x
         1dgLFRQ8B3juisNYHxRjHZf/3VNMXtl6js/kVTSYPvR3MR0U8TpfWTr8MZCy7A8pXISg
         LAfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769391794; x=1769996594;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Td4QUCSFnNiGlIQcniNA/rp8ZfKnX5RqAxkcu4MfCJE=;
        b=HPqWBj1ZM64F2WYfpSfasIgRTTa1ZklggLARlBvQ7CnZ/2Y8hvPwCcp4kMZKuKVj7e
         GsG5ghj/df8okuAqR8s+iQCXjQibRLPZ9trosEGGtgAfUC26k2v0CS0S6X1Q3ZIQY/uJ
         xSCpfwFNx1VUWBmWw+0S2BMi/GXzC6KFn7/UANRK8W0c0XYdOEXjDA9f7xtpxmEvOS+k
         Ts1VG9l3u+qf3UnYMYFDUTvtBoZOurLfHk35QdtVCugv9MPS2TiHwCTQ4DbBq4cClRsc
         VtbgqRLxrjBSD2XCys82L4bh252iPynMG4r3d8vORmyUVReAXWu+9j/+CIdS0LQu+ApC
         RCuQ==
X-Forwarded-Encrypted: i=1; AJvYcCWRiO7AQw19NPYbJlWeG9evxvB4P/GcMAZxAuIx0ffMLKCYj5HvWoSRNnfNkkeTOlz5uWLyVA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz7PgKxPQYHiTB2ZTv7EzZd9SQC1R6Qiopzcu8fE4xcfTQE3ECa
	zuY2vmXldXM7u9EGY8AK/Si2Px0v8gVIicbB71gU20CBYEhpbVeUfxeBhQhPv/RSkAfJx2xW9cS
	9hW9gqL9A7n7gZYZQ3R9QUU3cZIWIUO4=
X-Gm-Gg: AZuq6aKjoshN8twQlgUE27dXFAMajzPhdH9hgpFC5UKahZSNKu2Zw8KBK7xmlVsEnNv
	Del7ckvRlb3gf56ndg13XLh6EKU2cXQ+JU81g1ywqibnFXMiv4bvnxcmXgMJio+vvrfiGPOkRpE
	o2VLMdd/PI+l28oOFoG7WX0YIPePICzLj9UYpaB0KFvwlZ7RaYMWD5dNhYzlpg1BocBWy7rwaDF
	GKuKBloZGB5N4r+ppqB4TIgwwTdl0bAv/dQ0UNvCrSxmNWkyLualBc/Ngy4Bi2EQJYWX9Ji4w==
X-Received: by 2002:a05:6214:d85:b0:88a:4452:750b with SMTP id
 6a1803df08f44-894b0792ademr38139946d6.60.1769391793952; Sun, 25 Jan 2026
 17:43:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251226225254.46197-1-21cnbao@gmail.com> <20251226225254.46197-2-21cnbao@gmail.com>
 <aW90tXGtLVC0mKWP@willie-the-truck>
In-Reply-To: <aW90tXGtLVC0mKWP@willie-the-truck>
From: Barry Song <21cnbao@gmail.com>
Date: Mon, 26 Jan 2026 09:43:02 +0800
X-Gm-Features: AZwV_QjeDywrcz2eWqXN9SXa7QL5VefpgErEyUZbE549AGDu67lQKOvE9Fh-udU
Message-ID: <CAGsJ_4wDYTbuuzzfGNWqp1+ca1cAkg0XMgbgkspRGdKKAx_Ymg@mail.gmail.com>
Subject: Re: [PATCH v2 1/8] arm64: Provide dcache_by_myline_op_nosync helper
To: Will Deacon <will@kernel.org>
Cc: catalin.marinas@arm.com, m.szyprowski@samsung.com, robin.murphy@arm.com, 
	iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org, 
	Leon Romanovsky <leon@kernel.org>, Ada Couprie Diaz <ada.coupriediaz@arm.com>, 
	Ard Biesheuvel <ardb@kernel.org>, Marc Zyngier <maz@kernel.org>, 
	Anshuman Khandual <anshuman.khandual@arm.com>, Ryan Roberts <ryan.roberts@arm.com>, 
	Suren Baghdasaryan <surenb@google.com>, Tangquan Zheng <zhengtangquan@oppo.com>
Content-Type: text/plain; charset="UTF-8"

[...]

> >   */
> > -     .macro dcache_by_myline_op op, domain, start, end, linesz, tmp, fixup
> > +     .macro raw_dcache_by_myline_op op, start, end, linesz, tmp, fixup
> >       sub     \tmp, \linesz, #1
> >       bic     \start, \start, \tmp
> >  .Ldcache_op\@:
> > @@ -402,14 +401,13 @@ alternative_endif
> >       add     \start, \start, \linesz
> >       cmp     \start, \end
> >       b.lo    .Ldcache_op\@
> > -     dsb     \domain
>
> Naming nit, but I'd prefer this to be dcache_by_myline_op_nosync() for
> consistency with the other macros that you're adding. The 'raw' prefix
> is used by raw_dcache_line_size() to indicate that we're getting the
> value from the underlying hardware register.

Ok. thanks!

>
> >
> >       _cond_uaccess_extable .Ldcache_op\@, \fixup
> >       .endm
> >
> >  /*
> >   * Macro to perform a data cache maintenance for the interval
> > - * [start, end)
> > + * [start, end) and wait for completion
> >   *
> >   *   op:             operation passed to dc instruction
> >   *   domain:         domain used in dsb instruction
> > @@ -420,7 +418,23 @@ alternative_endif
> >   */
> >       .macro dcache_by_line_op op, domain, start, end, tmp1, tmp2, fixup
> >       dcache_line_size \tmp1, \tmp2
> > -     dcache_by_myline_op \op, \domain, \start, \end, \tmp1, \tmp2, \fixup
> > +     raw_dcache_by_myline_op \op, \start, \end, \tmp1, \tmp2, \fixup
> > +     dsb \domain
> > +     .endm
>
> This could just be dcache_by_line_op_nosync() + dsb.

Ok. thanks!

Best Regards
Barry
