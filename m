Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 609872874F5
	for <iommu@lists.linux.dev>; Wed,  3 Jun 2026 03:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780456735; cv=pass; b=bOI4sPeRVfKOieKZadpTeW/l0BHypRAqrU+z1Y+rDLOqX5yvDbTtQQrtPrHwvQDuXL/5mwxhIvk1OE6JDti2JRk6pGBI+Bpm4YpCgqIW1KvFikm/mUS31fgFSU53vJX2woPdGm4hMBay4/EGc7Mb5yMPuNtAeedPJTVqVry25f0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780456735; c=relaxed/simple;
	bh=ha2VCrWzIkljoakXF75qVN/CWb62OxPoMCU95MR8FAI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TpfSzFsRmXpUjAh/BjP/Bd6JIOmZDMOzFaC9BXgvoBctERt8L2ckze44fiWTm9q74DgjMy4Tjvpy2orryqugxy/HqYPSkMdBD2HM9I1U0J/X2uVoXBfuklAk94VQGLmpJrJXirOEY9b7uq23AkaWKx3eu6DqfT6NqaTuB+XmGcU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FpWW27PA; arc=pass smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FpWW27PA"
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-39697a4e16cso21995561fa.3
        for <iommu@lists.linux.dev>; Tue, 02 Jun 2026 20:18:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780456733; cv=none;
        d=google.com; s=arc-20240605;
        b=Yqvv/Bs+d5htt1nlxkqR008oLKh0S/QRaWBWkcMMLaGyd7/5G9Yc59wHeNKfmFufgB
         5cDiPSXwSV1cmRFChcAJz3GC4C9x0q8In+DqFGZXUf5U1JqiixlJrdWhDUYyYLEmPRHj
         H6rF8Nv/YVPxfjfUbrwpu/9Jhv5vYZfnADzDQkjDNXBq0sCw5RUAnVSafjNGmxoaBFVl
         +2TsbdbSKCwvtP/+MHAgzxgAX97nfQOd3hd5jxYAy5Pm19YFq/to06wFFcwUwIcNGHqR
         cM36NkIVvMchx9MZk/j65G+Q8BNQpRFofDVrNnswVICnCilfgEP8Pg+Z5esTCRdyS3ab
         jo6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=arpa75Qwe0NNiDqa3IrrWREIx40QLuuKEC2G8l7NiGs=;
        fh=IT9cEIQVbwfo2aGwSfJ9Yr+iZhW9sZflDLKZyHoEL9c=;
        b=N+ES3SC3E937VwyV9AR68JFui+h9adnljwKSLZhqdQ8GmuRJaFjSefvD8GD8hzg0Za
         /jlqFELdJZbThaaWVuTbWayWcRIR7yAnCRhRCKGN+HOadzIrZGGSJ/8afSI8MLf7bdQ6
         1rhiaF0MAFO0dLG0v7w27Sug/zZIN5lTkGqbA3KW1OMSPgVi4Wubo8u0p+N0GdbNZY9f
         ztNNu1VPXsRexwCc68Rh2tNmsVZ4il5eGTWzaXN+CScRW3TtWYBgYeqx0Evfx88jogBK
         vWF0BqdJk4yudmsnkLogN90HPPh8iFVcSofiausxxLH+bQJCJUpP3t1yGpK7j+y3qIGf
         +1CA==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780456733; x=1781061533; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=arpa75Qwe0NNiDqa3IrrWREIx40QLuuKEC2G8l7NiGs=;
        b=FpWW27PAc40F4Vye/rawmQ3idmusFaQL566hLUwjw+TT4+qPH5LGZdeApjmBsSYzfw
         lUBry4IngNwMqW6owogYKm/Dmb9C3ljL2Hx7xIaF9ZhOIGf0OJRL74+tgXViX08P4Th1
         re2wlztG9bOYCB4JDLTa9bn/egNqeT3BHQWgY8kvqzsJPBoi5VeGH/VVZ/YdctnhADda
         YiL1nh7cO+LfIZWcMVTuTwhHxdEG8iZZOrZonCp4evNdOZ/FI6AHniiKLRap6lmagE8Z
         CHFxebvScY/fgnOOThKf704oxcz7J+HoeGumOYH/PLiWSeek98TFzEloVGYuZrsNKDFQ
         D7Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780456733; x=1781061533;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=arpa75Qwe0NNiDqa3IrrWREIx40QLuuKEC2G8l7NiGs=;
        b=TdVHFe/+xkUYkMG4E8fDOM42CZNMmAmjz2rDwt5IL1HZ0csDDE0lbFXauvSeyeM9Do
         qLXMlMf8uiru4YczMvI4zuLSNpUKO5plJJJX4BW+GjUL0o/3gSyze8F1REHe7n+jfKQ6
         WkndC14ygsN8xV4HqGmvnNsrXkwEJa+hXh2mUa0GhJxit3rhwNSOwdUuw8Rj1ILnIKeS
         +vLSGz1Nr11KIp+28H3KSqHk4uWTxlHDKYFyJnyNGw6gkex9Bk0e5S3gTWaw5aa2RRMz
         ZPVntFvxN+YUFTQAKwVBk+kFhJ+uzyYwAosRkYUyllhGpROHHFVPMjBIK0ea1/xfTPqq
         tOpw==
X-Gm-Message-State: AOJu0Yyl4vO1+zF8veMirIX7Xz6g9DPBO/713RzbwclPfA/4u8gXG762
	qV/89LdM9ZAGFTVMb5XrFILlrloxd1XI1b+U/kXFsxMD1NstCM2hBuAHp7PTaFhdHHpYG1VuyuE
	mr1OrE1c0XA+wSd4PBJprDJVfddS7Ngc=
X-Gm-Gg: Acq92OEUiBTVwbi17Q/WAfrsXGCa8XGqI1CW8L6aPeYxbSqnG0GaGwspK1751cJ6jJV
	d3G/+dQ8CFARGt/Pv7qGgyVfOHCUZpSfBzeB6yypVd5a9ifvTD0RGfAkOjQsb8pXVljOCOnMJwo
	zughLoP09OEQ84l2QqfiohZbHxv+c0KphevEtmPwSaNcu7xYHWLcDITWev27RzXFAebhmr8aebu
	/JFFr0NXJ7gZj/aeIYTibOXUTDqjRRS7JMxwiRH5vK6PXwYDh7l82mikf7tFuxCPnOwnzaZ5whE
	Mvl3fRKzst6m14jyvpqDd0RpFbuoGw4tRIR/5J6ckWpkjD2aLosWkg1hOg9SkwdYGOGKaDH8l1O
	NLLR8xpqMt6zvvCkLHeqDxOs8TmQdw2X3T5EPPpj+Do1JMjySXNM2feXHFFZ5hB+g/23mT63/MZ
	Rw0nw=
X-Received: by 2002:a05:6512:8050:b0:5aa:7788:d1d3 with SMTP id
 2adb3069b0e04-5aa7c0ec3b3mr265185e87.23.1780456732296; Tue, 02 Jun 2026
 20:18:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260525220628.94833-1-rosenp@gmail.com> <202606020951.6AD1467B@keescook>
In-Reply-To: <202606020951.6AD1467B@keescook>
From: Rosen Penev <rosenp@gmail.com>
Date: Tue, 2 Jun 2026 20:18:40 -0700
X-Gm-Features: AVHnY4Lw1GRK6hCeEmdqK1CCx2JVGSnFdoljfLVLsP7bAqpTQHxCCJM_QDQI9r8
Message-ID: <CAKxU2N9RjuJnYteS9A38q=Q5nJ+K2VqroHXheW+rd9Vm_8c1XA@mail.gmail.com>
Subject: Re: [PATCH] dma: map_benchmark: turn dma_sg_map_param buf into a
 flexible array
To: Kees Cook <kees@kernel.org>
Cc: iommu@lists.linux.dev, Barry Song <baohua@kernel.org>, linusw@kernel.org, 
	Qinxin Xia <xiaqinxin@huawei.com>, Marek Szyprowski <m.szyprowski@samsung.com>, 
	Robin Murphy <robin.murphy@arm.com>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
	open list <linux-kernel@vger.kernel.org>, 
	"open list:KERNEL HARDENING (not covered by other areas):Keyword:b__counted_by(_le|_be|_ptr)?b" <linux-hardening@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 2, 2026 at 9:52=E2=80=AFAM Kees Cook <kees@kernel.org> wrote:
>
> On Mon, May 25, 2026 at 03:06:28PM -0700, Rosen Penev wrote:
> > The buf pointer was kmalloc_array()'d immediately after the parent
> > struct allocation, with the count (granule, validated to 1..1024 by
> > the ioctl) trivially available beforehand.  Move buf to the struct
> > tail as a flexible array member and fold the two allocations into a
> > single kzalloc_flex(), dropping the kfree(params->buf) in both the
> > prepare error path and unprepare.
> >
> > Add __counted_by for extra runtime analysis.
> >
> > Assisted-by: Claude:Opus-4.7
> > Signed-off-by: Rosen Penev <rosenp@gmail.com>
> > ---
> >  kernel/dma/map_benchmark.c | 29 +++++++++++++----------------
> >  1 file changed, 13 insertions(+), 16 deletions(-)
> >
> > diff --git a/kernel/dma/map_benchmark.c b/kernel/dma/map_benchmark.c
> > index 29eeb5fdf199..a65da5c7710c 100644
> > --- a/kernel/dma/map_benchmark.c
> > +++ b/kernel/dma/map_benchmark.c
> > @@ -121,35 +121,35 @@ static struct map_benchmark_ops dma_single_map_be=
nchmark_ops =3D {
> >  struct dma_sg_map_param {
> >       struct sg_table sgt;
> >       struct device *dev;
> > -     void **buf;
> >       u32 npages;
> >       u32 dma_dir;
> > +     void *buf[] __counted_by(npages);
> >  };
> >
> >  static void *dma_sg_map_benchmark_prepare(struct map_benchmark_data *m=
ap)
> >  {
> > +     struct dma_sg_map_param *params;
> >       struct scatterlist *sg;
> > +     u32 npages;
> >       int i;
> >
> > -     struct dma_sg_map_param *params =3D kzalloc(sizeof(*params), GFP_=
KERNEL);
> > -
> > -     if (!params)
> > -             return NULL;
> >       /*
> >        * Set the number of scatterlist entries based on the granule.
> >        * In SG mode, 'granule' represents the number of scatterlist ent=
ries.
> >        * Each scatterlist entry corresponds to a single page.
> >        */
> > -     params->npages =3D map->bparam.granule;
> > +     npages =3D map->bparam.granule;
> > +
> > +     params =3D kzalloc_flex(*params, buf, npages);
> > +     if (!params)
> > +             return NULL;
> > +
> > +     params->npages =3D npages;
> >       params->dma_dir =3D map->bparam.dma_dir;
> >       params->dev =3D map->dev;
> > -     params->buf =3D kmalloc_array(params->npages, sizeof(*params->buf=
),
> > -                                 GFP_KERNEL);
> > -     if (!params->buf)
> > -             goto out;
> >
> > -     if (sg_alloc_table(&params->sgt, params->npages, GFP_KERNEL))
> > -             goto free_buf;
> > +     if (sg_alloc_table(&params->sgt, npages, GFP_KERNEL))
>
> nit: I think it's better to use the params->npages here just because it
> is obviously tied to params->sgt, and reduces code churn for this patch
> (i.e. that line would be left alone).
Fixed. I only did it to reduce line length.
>
> Otherwise looks good.
>
> -Kees
>
> > +             goto free_params;
> >
> >       for_each_sgtable_sg(&params->sgt, sg, i) {
> >               params->buf[i] =3D (void *)__get_free_page(GFP_KERNEL);
> > @@ -166,9 +166,7 @@ static void *dma_sg_map_benchmark_prepare(struct ma=
p_benchmark_data *map)
> >               free_page((unsigned long)params->buf[i]);
> >
> >       sg_free_table(&params->sgt);
> > -free_buf:
> > -     kfree(params->buf);
> > -out:
> > +free_params:
> >       kfree(params);
> >       return NULL;
> >  }
> > @@ -183,7 +181,6 @@ static void dma_sg_map_benchmark_unprepare(void *mp=
aram)
> >
> >       sg_free_table(&params->sgt);
> >
> > -     kfree(params->buf);
> >       kfree(params);
> >  }
> >
> > --
> > 2.54.0
> >
>
> --
> Kees Cook
