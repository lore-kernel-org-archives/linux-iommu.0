Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0422C3C276F
	for <iommu@lists.linux.dev>; Thu,  4 Jun 2026 19:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780601827; cv=pass; b=X1GMAK7YeLm9XlHizT01ifHHopelap8TjjQccWOSLPKpT8ynAoqkFGCPXHKFPPOM4peMsTRvisScoi9mhLt/cQ5PrZZlyurDsDhkCuG8uqcZf7KXeBdpo445QHobFpK3qHCeLqmlSIqHe8fk2K4LTLL3A1MAG6wetk5wVHsNS3o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780601827; c=relaxed/simple;
	bh=4ny8mDdyqCfb4288ejqLKiubk6+o7RxTB1IiqZu7ppU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZntRdvyFV4SuZxw+BGIY1wZEZp1Iz1k7iPGgF5ScZWrxnzj32hesJ2kzgkE+H1Qn+v13oRaM3d09pyfugLeoE/NhreldLwaWcTloECpdnpPUIkaGK0SY/qVRcPU07zrQV0Ew322JRQ5dgbdomJlBVOlbivLO596GUo4My9XDcNA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mnMZ6KYE; arc=pass smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mnMZ6KYE"
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5aa64afcfdfso285e87.1
        for <iommu@lists.linux.dev>; Thu, 04 Jun 2026 12:37:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780601821; cv=none;
        d=google.com; s=arc-20240605;
        b=IFdye59lorDZeMO1Xby2260m7LElM9pNbBISQiV27eyfxrW27P0/xZvwKyJfnXzw72
         /6A/K+qXRwHXF81ZazfUhgkgPPDSCgYsbjxsaHYs0EZljGOzJLO+lo3CRLJ1zDLLXVto
         QE00UQpftOoKWR64oJmVMAkhCQB+dSOjAkU7+1SdS6GniloBAz+3CKSVUh5LN9CteOsU
         Zy+qcQWMKMllUVQo1e9zAnZki+FJSJryvQfqmD1XSA/bzjbht9jeiUwmX87q74/aXyiY
         RkQHPeKJiGDfhRMGohgkF4pjCKLfB3gkWGZ3HjNTOpMStKS72W4uqxfV1w707DSOd8zv
         vpUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=KUiC23PK8EOFQC+N7GaZpdkePm+wStyLtAYgas7c/7M=;
        fh=XebutidmHIVVDsAyWYY0111cwbmrWryszsNxXF1PKEc=;
        b=NOJRaXlpBhbWKb9r8EVTbtvjgidbiqfmNzyJj0PNx97Mdgr8BEhbV+DgRWmeXERsRd
         SeZ1Ijnhc//EkL30tFbUu7WpxlymQn1KGOupbDTfofjxBElxeQ/FcF2OVMJ+uzQmACPF
         ddTxmfxZD2OzM4D4vLqOukdu057YllpFdaSzmsqP69JYxbhfyscXyeGQn8xZKoSxe4El
         MwogfSRzE4YcR7Ua10al8IDcoEnFaNZBEiweCRsrSCro07IvJ2rOrQjzcPpuwRa1VhRh
         L2p0Rt1J+LNQgBRnAXiDSzJANhRjuxxftbrqAUnCGAFjU1rxOObLgf/k9ngT90t+H5C8
         nVPQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780601821; x=1781206621; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KUiC23PK8EOFQC+N7GaZpdkePm+wStyLtAYgas7c/7M=;
        b=mnMZ6KYE9mW9JF82czCk6ccE5pHlSzVhGZvGlERd17lV8uTRdWKA1PAkd3kHFdHAnE
         aK8wxC9+Key9mXeojgpWiwuMxFxVZKETy0CGX3zHoArY+6ErP4j0j+xMcpMzFhoXa83x
         XwllDiBycy1VLtLfLBfvPO/VU03ZCRxfs771GMCE1ej8qvC5a+rBPyZWnOVuRZAJGXzO
         6APhUvPGffGTNKljID4/ngSP3NIu72N4O+zXD+/U0jVEOWapSK+kzjQZ2hnO3NH7Gl50
         C7Y5+5JlgfzMPtEkFk08HaKAOmCtU2FeNZPSLlAwofg2EJlguSIsDYK6bZ/LPuPHf87/
         VAUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780601821; x=1781206621;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KUiC23PK8EOFQC+N7GaZpdkePm+wStyLtAYgas7c/7M=;
        b=lerGCI6kIR1xAQSqmb79IgGbeOPib6x+xv5MJghbJxuoSr2itDd0b9AGWgPdhYZfid
         YKZgQitjq7vXwd6i2H9aGgjkV2tZXr65UGjIdT/ZsqbTXVaUXCH1lGiMLRCzbL1rhGAl
         hH8fEVh0QI4N3sjsQHzl4yO/zKYlxsLd8bhwDPDb6lUiynXQrcvQjxKDqIszhVSiers2
         to72z0aUcPpuuMu+eVFDJll7CUAeN+rUri6hpL8+49Sw2tN7lEu+2/anHUdpnIfnzdy4
         NRpN48EBujIVmI76OCFnCMRsDHCl6ya1K8DfsLZbfnZw2iaU3RSxvgPnJDWiEQQySfMG
         6slw==
X-Forwarded-Encrypted: i=1; AFNElJ9vMY/LpD01rtIiQ32rvrU7Lp3exss41pMohCYNtsFbF0HDimAFCE7eKCh4sK5LYnIySaaqdA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx+GoafHYnmJ8J/xYgEf1qdI6UDSAel2ki2G3E63/jdC2v36LZw
	I+rA8FTlVo028Jca4RqaSCUoYQswwgWbRluELEQfVONCFiEr5t6TF8s/9gbnYpfRllrHNnxIvTw
	r/BqSPM7pPZ0XIVCfUYDxE9jZSt5PmslXqrM4ZnM=
X-Gm-Gg: Acq92OGRZfuzyKHl1Pz0AOjjgDR3uDWNnBZanVdPTP/H3RINJt0/lvWucQyYNIlL+Tb
	UU0zgNxZsgGfIGZ5QD/yLLBetwxwOE24JNEN3b9+m+6nkpOQB8tiEB1dNUlzBqGQcdZunEhfyDb
	a25+Iie9xc2Uyszaqp0JE9jvO+DjrAbRbJJdL7Nss8vnEHu1jhNGIcjTykNbDGXCYKANbyS/lLc
	5SwhuTDGuuB65PngEhM0djbLvuBA5ejqWXdmiNgKg3KZ4ypC6f3elxJ7oK7cn3OpNrnVjG40b1U
	rjI33XaaYA0mJ4oeshH4mOPEwz3OiUpboArPIgHfIz7TYmU=
X-Received: by 2002:a05:6512:2446:b0:5aa:6ede:1a68 with SMTP id
 2adb3069b0e04-5aa877c6752mr44886e87.10.1780601820811; Thu, 04 Jun 2026
 12:37:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260601200012.3872274-1-xuehaohu@google.com> <20260604094344.GB245424@unreal>
In-Reply-To: <20260604094344.GB245424@unreal>
From: David Hu <xuehaohu@google.com>
Date: Thu, 4 Jun 2026 15:36:48 -0400
X-Gm-Features: AVHnY4I667s8Q-kTs7E7YlSR5Fzg5WrO7fnNQmow9VUJtwR-GDJeAyWDhu8beOk
Message-ID: <CAPd9Lg_JkRdtNa=n+HE9SP+NFCSB+X_97eiPBqiONVLwV0pHwQ@mail.gmail.com>
Subject: Re: [PATCH v5] dma-buf: Fix silent overflow for phys vec to sgt
To: Leon Romanovsky <leon@kernel.org>
Cc: Sumit Semwal <sumit.semwal@linaro.org>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Nicolin Chen <nicolinc@nvidia.com>, Kevin Tian <kevin.tian@intel.com>, 
	Ankit Agrawal <ankita@nvidia.com>, Alex Williamson <alex@shazbot.org>, linux-media@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, 
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev, jmoroni@google.com, 
	praan@google.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 4, 2026 at 5:43=E2=80=AFAM Leon Romanovsky <leon@kernel.org> wr=
ote:
>
> On Mon, Jun 01, 2026 at 08:00:12PM +0000, David Hu wrote:
> > @@ -36,7 +36,7 @@ static unsigned int calc_sg_nents(struct dma_iova_sta=
te *state,
> >                                 struct phys_vec *phys_vec, size_t nr_ra=
nges,
> >                                 size_t size)
> >  {
> > -     unsigned int nents =3D 0;
> > +     size_t nents =3D 0;
> >       size_t i;
> >
> >       if (!state || !dma_use_iova(state)) {
> > @@ -51,6 +51,9 @@ static unsigned int calc_sg_nents(struct dma_iova_sta=
te *state,
> >               nents =3D DIV_ROUND_UP(size, UINT_MAX);
> >       }
> >
> > +     if (nents > UINT_MAX)
>
> I would suggest to use check_add_overflow() while calculating nents
> instead of this check.

Hi Leon,

Thank you for the review. Using `check_add_overflow()` is a great
suggestion and definitely
cleaner for the accumulation loop. I'll update this for v6.

> > @@ -133,6 +137,11 @@ struct sg_table *dma_buf_phys_vec_to_sgt(struct dm=
a_buf_attachment *attach,
> >       }
> >
> >       nents =3D calc_sg_nents(dma->state, phys_vec, nr_ranges, size);
> > +     if (!nents) {
> > +             ret =3D -EINVAL;
> > +             goto err_free_state;
> > +     }
>
> Technically, this hunk is not necessary, since sg_alloc_table() will
> return -EINVAL when nents =3D=3D 0. At least, that is the behavior I reli=
ed on.

I originally added this explicit check in v5 to address Jason's
feedback, and to make the
failure explicit rather than relying on `sg_alloc_table()` failing
silently on `nents=3D0`.

Jason, do you have a strong preference here? I am happy to drop the
hunk and rely on
`sg_alloc_table()` returning `-EINVAL` if you are both comfortable with tha=
t.

Thanks,
David
