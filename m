Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6200F3603C1
	for <iommu@lists.linux.dev>; Thu, 26 Feb 2026 16:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772125147; cv=pass; b=trv5otkVjiz8V/J8EMlBTNEkfTgT7n0HX6mXFaI0hRBxE+tx6ULwDGqsk53x4tUfD+fNLs5GJtcEuCb6OUZqoDkFpQdLnTC5XA5Zk64Nbx87UvuPzTBTqFUCkgR9CNkd/HCukVsZ4ZVUIfi/UykjyocnJdVF4kSNrXGple9a5nI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772125147; c=relaxed/simple;
	bh=AH7fFA2R32bYr6PwRcky2ytsG7fZdObmn2E9Be7X+EE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LOWDSmWOYiE0xAyHjC86QzvsvRXMKyTfaTEeZUi8DgEPrNaeBlyosqqFKIM0+bsW/UlseExt7qH1nNycleTdD4j1c01gsRxMiRXE2CdYRTSYnjr0cV6GBi+b45WFPqgni2DP4cQx6kXKSSq/eV5bCSKQN1aI3K0DSFPrsyRwtwc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LV3HRj6z; arc=pass smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LV3HRj6z"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-48318d08ec2so73025e9.1
        for <iommu@lists.linux.dev>; Thu, 26 Feb 2026 08:59:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772125144; cv=none;
        d=google.com; s=arc-20240605;
        b=FyZ5I8Z3FXRZueek3k4YJ2i/lxZszqvlziasHr8JPrAIbvZU2NFbVIz9vNQjcAYsBP
         S0Q9IgaR22eta+V6D/7bnELKsKlXkdjm1htRNWbgJlLB0ZG6X55z3RihSbUs5Zt/migM
         60XeITAFm1uEj4SixLSDQaR28klg1Z4RdgvSFUmLbmF6QbCMEJ1bF/302k5dXN+47uic
         08QUeIz8VRtBhDZDv7FZToQgGsTd6imX/E0dFpQZmhraYcSede9ywhgjx/GLGztqBXx2
         JWK+TMBL92Quui/YLNNM+n8qIVJcEw/vnGSt/OkRvcKP0p8AiBvmZ321PQZaL4hyziwM
         kBwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=GaC7hfbtyJLGGerhfBe2P9Hj0mHnDOXyDJFEYnDiBqY=;
        fh=wEu1gQ++JO1n9sxeFrAYHECBHx48WUmuy5ottGRnIRI=;
        b=SIDGt7YgW+ieoek4P1rUc+HpORXRnI9+sHhrU9vMb89o+17Y4qFecnjPXKJVVIaCWs
         EnT/uhxHOVO7Fm2NBN06Ag8RKSHG9Yuytz3f4Lcn2V3nJraAZs5f5RUhm10+xrH5Ldk6
         wTOq9fOYK1AKw4/59kbi38DXQ2bPS4ppqHi97P6IsVkR72VoCACNARgzqnWhPj8MVwJ7
         KFjCqNX0YUZVg8N413bUS5x74K0QQIsnQSkWILtmX2hl8D6h3Q7+18QEh/yAIqNebhHx
         zXHWlBYVf98OPzHrq4s5SNGhn22cnHwvG+Gz3Cw5vuDneTMwZi1rGbYhjSt8FCF1mXl5
         Y9wg==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772125144; x=1772729944; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GaC7hfbtyJLGGerhfBe2P9Hj0mHnDOXyDJFEYnDiBqY=;
        b=LV3HRj6zPoKGH2LjeJR3BsGMzhtOoTvDYuR3nT7HU4MqnHE0JOstFW24hQGRGPOQ/3
         Ntjt9cA5+dt4kXHHd1Z6+I1aTH5GTwyq3pkBlrtvpc9xesjycjyeNrH+01iNT1New4uM
         P+nRpfsVdNx+mjVgpTZNXuubGZRPYcqc8tzLsnYoO/uRaSyH2tz8Vx9DjZT/X9TbVqUB
         YPtobfCnLULIjaFTrTIsF8NTzNR7MCVM1R7dQsg1vXBfW/Yz4rc0pOU2e6qJOmwMohdz
         n3wwTLQy9hN7QyrgEeNACvayFH8FDTFbSKmXruxxWdRTr5qzG3Krcr4ibY4gul8FpDDS
         DwOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772125144; x=1772729944;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GaC7hfbtyJLGGerhfBe2P9Hj0mHnDOXyDJFEYnDiBqY=;
        b=iAEXc9Z/coGwE+9VgucgNDqLZd52Hi4fErgBv67ouB9qdbN04KCmf3GTnTuJaj3uM7
         cbjVFE8asRH1I1uZ6QAES8BdXUPkRqphCJ9+ux3SF3zCb0BcrW5JgVtVllhoc5Ndhthw
         p0PWa63oMASBiCrb16RQBHXsEDfnST6SdOOXwYuH3npezxXBhLPvPnXPSGc1uPuXthEU
         AhCZqHhM2mpx9Ub+OKLlpkFF83rkq/J3MsspKrSbe39mWmSAKW01t9DDt633Czjt0VwH
         kAjIOeRoUdVWrhGtAzIHuKGlS+pSSOqK32pohmSuZZAJEjGyWEKHWmtm/19HGKf1dmqV
         vVCQ==
X-Forwarded-Encrypted: i=1; AJvYcCUS+1HRXbhWEcOICWmdKOc1v13zFj8w2a3UoJAcsL0NFc8a6l037Er+OQYCfd9ahNELHNT6pw==@lists.linux.dev
X-Gm-Message-State: AOJu0YywdFuKmKeNRnVfKwRn3vmQQ94pbl5wffODaXwi9vVTO071jfF1
	0mAWXXTYJOF5nHPVOd39YUw9gcrWqiXPKPNPlwoAHjlyXr2MH8/DVx1UOPO7i6Vff+qw/eIacYi
	aiOH8cat1NZk4WXVN9Hs7tOo2BnrvYS06+9EMS8vB
X-Gm-Gg: ATEYQzz5gnhGuY/e1qtA24NFm8xKMhkeu9Nly1cogqgvgy4PGWq5axcWWgU+RzLU4vB
	q+vW15RR/LIlWxbTG660LzcPuQkmB1rfmkCSdiVqKzRrR2PA8DlIHghguQJrCqae+DTZclS1A9v
	L6jqnqZSMilQX752DvWI+ET/OCjsOArqZLUTVUeEOxW81F3GkFtnFmTj7JbLLFBz03sl21lipqp
	C9zgiELEI+iaW9mivJ0h/WwkzTx84QX16VCN5CdxoV+RRYr6Qi1pG8wO7UZ/bfivrcTa6ynXk8P
	bJ5rg2cRC95szPrtAtMBidHhq4qQKBXlhLu7V3pO6ekvhYWtpKA7LbWs0TU3a5c8nVZuXg==
X-Received: by 2002:a05:600c:4f16:b0:47e:de1d:ce99 with SMTP id
 5b1f17b1804b1-483c31a76e5mr1276055e9.12.1772125143309; Thu, 26 Feb 2026
 08:59:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260225-dma-buf-heaps-as-modules-v1-0-2109225a090d@kernel.org>
 <20260225-dma-buf-heaps-as-modules-v1-2-2109225a090d@kernel.org>
 <60ecebf2-a708-4797-bedd-588c3e9931ff@kernel.org> <20260226-impetuous-analytic-jellyfish-d4a86d@penduick>
In-Reply-To: <20260226-impetuous-analytic-jellyfish-d4a86d@penduick>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Thu, 26 Feb 2026 08:58:51 -0800
X-Gm-Features: AaiRm51ICxvhnfb6IRxyaVo1JANC2yUPYPY4UyYDMkMh1Zp0Qc24kArQnpKFuW4
Message-ID: <CABdmKX0KZLGaJWBoo3tkCxLvby3f4Fn0nMCLyz4a-H-9J_CtPQ@mail.gmail.com>
Subject: Re: [PATCH 2/7] mm: cma: Export cma_alloc and cma_release
To: Maxime Ripard <mripard@kernel.org>
Cc: "David Hildenbrand (Arm)" <david@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>, 
	Benjamin Gaignard <benjamin.gaignard@collabora.com>, Brian Starkey <Brian.Starkey@arm.com>, 
	John Stultz <jstultz@google.com>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org, 
	iommu@lists.linux.dev, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 26, 2026 at 2:38=E2=80=AFAM Maxime Ripard <mripard@kernel.org> =
wrote:
>
> Hi David,
>
> On Thu, Feb 26, 2026 at 11:25:24AM +0100, David Hildenbrand (Arm) wrote:
> > On 2/25/26 17:41, Maxime Ripard wrote:
> > > The CMA dma-buf heap uses cma_alloc() and cma_release() to allocate a=
nd
> > > free, respectively, its CMA buffers.
> > >
> > > However, these functions are not exported. Since we want to turn the =
CMA
> > > heap into a module, let's export them both.
> > >
> > > Signed-off-by: Maxime Ripard <mripard@kernel.org>
> > > ---
> > >  mm/cma.c | 2 ++
> > >  1 file changed, 2 insertions(+)
> > >
> > > diff --git a/mm/cma.c b/mm/cma.c
> > > index 94b5da468a7d719e5144d33b06bcc7619c0fbcc9..be142b473f3bd41b9c7d8=
ba4397f018f6993d962 100644
> > > --- a/mm/cma.c
> > > +++ b/mm/cma.c
> > > @@ -949,10 +949,11 @@ struct page *cma_alloc(struct cma *cma, unsigne=
d long count,
> > >     if (page)
> > >             set_pages_refcounted(page, count);
> > >
> > >     return page;
> > >  }
> > > +EXPORT_SYMBOL_GPL(cma_alloc);
> > >
> > >  static struct cma_memrange *find_cma_memrange(struct cma *cma,
> > >             const struct page *pages, unsigned long count)
> > >  {
> > >     struct cma_memrange *cmr =3D NULL;
> > > @@ -1025,10 +1026,11 @@ bool cma_release(struct cma *cma, const struc=
t page *pages,
> > >
> > >     __cma_release_frozen(cma, cmr, pages, count);
> > >
> > >     return true;
> > >  }
> > > +EXPORT_SYMBOL_GPL(cma_release);
> > >
> > >  bool cma_release_frozen(struct cma *cma, const struct page *pages,
> > >             unsigned long count)
> > >  {
> > >     struct cma_memrange *cmr;
> > >
> >
> > I'm wondering whether we want to restrict all these exports to the
> > dma-buf module only using EXPORT_SYMBOL_FOR_MODULES().
>
> TIL about EXPORT_SYMBOL_FOR_MODULES, thanks.

Ohh, ditto.

> > Especially dma_contiguous_default_area() (patch #4), I am not sure
> > whether we want arbitrary modules to mess with that.
>
> Yeah, I wasn't too fond about that one either. Alternatively, I guess we
> could turn dev_get_cma_area into a non-inlined function and export that
> instead?

I checked the history to see if dev_get_cma_area was converted to
inline at some point for performance, but it has always been that way
since 3.5. That'd be my only worry with un-inlining and exporting it.
EXPORT_SYMBOL_FOR_MODULES sounds like a better way to me.

> Or we could do both.
>
> Maxime
