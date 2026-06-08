Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0E7136C9EC
	for <iommu@lists.linux.dev>; Mon,  8 Jun 2026 18:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780944916; cv=pass; b=WVg+pMkLglENYLK2lwrqc4yzpySYuy0YqNdrG/cmzcK64VPpB5xLjEV9EuKQBfUeg97odOmWjz82Vj8LbtEgZP33oROF7uZQq/m26l3gH3OzVudTodC/mj/ZYlm70WZehdJCPBKW/ryrY0ihhScPAbpS0fp/8MHTulT+kWfqSF4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780944916; c=relaxed/simple;
	bh=zKNEWyIdx6AUnE+D5RSyECXmUt7mDFTSd+8dDxmh9dw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kPDWzpAClYk5xd/SsUpJMdvatyT1YAaQUuaLl3iIdQbQV8/1Nhwk0CezRB9UtohWcU4cZUBo7BNI70fuP38OcYkYKHbd6QN3+A6lbrA8ug/FjuGBvnaBJvDNwDJHq7zDqw/Gksgz0EBLxiM0RaUhVDuyk8l+9Mkzkg/5ZlBV2ms=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OWh9vQmN; arc=pass smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OWh9vQmN"
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5aa62bd04fbso22922e87.0
        for <iommu@lists.linux.dev>; Mon, 08 Jun 2026 11:55:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780944913; cv=none;
        d=google.com; s=arc-20240605;
        b=HSnaQQb5fiEI7MCheDWVpjyWD5NQXq2Xb7Zuej9ns9SeCBTAN3uDrQRdBSMK1u/mNP
         9xFJ4OncBaREBF1G1mhjU5926yRk5Q6Avm/EdbejPdW3Q9SKsCKXOo3FvT103263WR7E
         m6aGfwf2d/CuAjtH7BpwRXi+0N2cKZIoZb8BgUHuc83rYgIzhxQuvGy3pa26fpidTEUZ
         YVMntF31uAXopj32A4vqtmPTfObwCwyXxVnN8EALaXcIx33162qg41MsL+uXZ8XZfg8e
         369lNipn/CAgOBiyM9wBk1OhAF0YfxY1nLYF5VeSjl2jTHUPed3+BRbdaUHvg7QwRIXm
         OWuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Dw+WR3kgPsmomU5BDy/wi1DbnucrDq50YuLE+lo/Shg=;
        fh=5Kr7ew0cIdblcZWF7lgMMiy+uIP0zODUJr4MgzI5GZ4=;
        b=al/rPPK2tHXgwFpeekxk2pB+19WXL0KLYY4vTpgIl+H6xZ3gH5+lOqm4+CJFoQ0+3M
         nDv++OyEnvhgSet7oRXTkzujzhbTUtBiMrzoQEJKIMTxZmYWDHXhDFwFlr5oUcpZmIdL
         mLUVHfwqyOpWqP/VHhoVtYDiPUV+fxURjbOx7XXTq5N4POeVcfcXp7SymVZA+E/B0bzM
         uQPcyR/8e/hYwrtdMKqh55v02TvWHp2bvNHWPPdtMBai4OVuC+apfREs312ErEykV3T6
         vLz2gzFkmT7AHZ8sjaBhhzF5Q0ERUWudnPdW6c7PV1MPlc2ALSi+gSGcX3bDfpCDLObD
         ThXg==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780944913; x=1781549713; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dw+WR3kgPsmomU5BDy/wi1DbnucrDq50YuLE+lo/Shg=;
        b=OWh9vQmNpxFQlle2HCxI9TLOTPh7bcrHa3weCDuxxRCRhxck/MPkJdvK7AAI5jr8XX
         HPWH6FoU9GnXLWyIYC4QQgdz6kB7D1kzrHIdsUmEW5oiR+t+zpneF84CZ3lGntCl97Zw
         SM/a15/ugRxljk/XjpZe936B3WoGBlssjkCZY6AlTVoeh7Qn7sQz++NZE1WWkXe5x0Km
         CvkDfiuP4AILRjFMEYOQ2Ej8kYHeRx6nfRGSrIietaY0tcC+GbuWNFgVKEOZy8Oau9fa
         uVuktEMGatJtsrqxBBswI85NsY33GR/mCJCodNeTWEEMuI6mPNwEq7dof8fmKbNVHzI1
         odfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780944913; x=1781549713;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Dw+WR3kgPsmomU5BDy/wi1DbnucrDq50YuLE+lo/Shg=;
        b=fRkftVeV6ox75tnumFVBKsW0/wl2V2icZjb3XbNnOfsWmLtcn+/a5iSMAlywVN/p2L
         2hfrfsjYVlpGSUUuCpDx06saNu1B3NLlMCtGztxx1j44mdrw2xir8kBn4w3GPAvA2En5
         gRNOzA29eYBj30TtruPf9qBKxZhiTSSbKWF46li1BGjE/EZat0e255JpuifyJkUu1wQP
         wmL21W4o8xklQ+FysCSNpN38hmOWjlLDDyAnc2yZiNgYFIJ8Fo0nmzlTCxBwfZW2zQ0z
         JjF7+9hCrSEkDVMHKWDBA/+nkZZNt3Q0ONFGSvzxkK8sUmXC/MeIP3twPE/izskBgYRt
         bQrw==
X-Forwarded-Encrypted: i=1; AFNElJ92xvu0ZRnGI9GYxMeKX1bkrXVZslmGwbEye/JtYUmZtn2OceIh2X4bp6nBZTHyYT7ZvMMgYA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwztE7O4R/Qn99P2mPW0/AgiOIAR6hO+p/K5ITMx4jIWizW75Ms
	mC1UWvZIDs1JqPgFyiTz2LGyml8ua6ZxqNQhidp9EX02j+H4ahGjHGH+msZFO8UO+PmgipEIKxO
	tzEaQMgq3UUyYXwwfU13unBLiWU+8AjKrewS1bcI=
X-Gm-Gg: Acq92OH+HjBDzyBzRq+ccBABDK4JJUqbF2Til948BmLRZAdQvd3Kl3bwTFM/XtfKdVp
	fTwKZIuhu1RRDctTmngsFoB78zbT5qX4utj1pT4tpUGRcbuCzqBC7lW9etttBBTbOwh+nsR89MR
	e/0jzAPF23fGjL8suEHL9BvQUeeOLe5r3O9Fj3vjTr37oASARUqvYFTqYjCtJb7vfTuv5dxDDRD
	WO83yY1tB7at0JlNdlkCrqbgyUlsvaqE74vNTG2IZdUgeabHwM4lES12rbLiW9WgQ7SCosuv/nV
	Z0UqyZ3b+L8nCtmzdyeVkyjTWfUqP/H0T9Lu7JhFX39GQZncsxKWki8=
X-Received: by 2002:a05:6512:3341:b0:5a1:274b:de2b with SMTP id
 2adb3069b0e04-5aa88640402mr537440e87.9.1780944912435; Mon, 08 Jun 2026
 11:55:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260601200012.3872274-1-xuehaohu@google.com> <20260604094344.GB245424@unreal>
 <CAPd9Lg_JkRdtNa=n+HE9SP+NFCSB+X_97eiPBqiONVLwV0pHwQ@mail.gmail.com> <20260607080244.GA327369@unreal>
In-Reply-To: <20260607080244.GA327369@unreal>
From: David Hu <xuehaohu@google.com>
Date: Mon, 8 Jun 2026 14:54:59 -0400
X-Gm-Features: AVVi8CcrgIqNX---JRMNN-9SsXpCXMWpb_Y08c-v1_nrKhDd232Ciz6Ae661o0I
Message-ID: <CAPd9Lg94nGnn7HQPNiSS7w2QQjVAuJ_FkMggR=JfSGVJyAsgeg@mail.gmail.com>
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

On Sun, Jun 7, 2026 at 4:02=E2=80=AFAM Leon Romanovsky <leon@kernel.org> wr=
ote:
>
> On Thu, Jun 04, 2026 at 03:36:48PM -0400, David Hu wrote:
> > On Thu, Jun 4, 2026 at 5:43=E2=80=AFAM Leon Romanovsky <leon@kernel.org=
> wrote:
> > >
> > > On Mon, Jun 01, 2026 at 08:00:12PM +0000, David Hu wrote:
> > > > @@ -133,6 +137,11 @@ struct sg_table *dma_buf_phys_vec_to_sgt(struc=
t dma_buf_attachment *attach,
> > > >       }
> > > >
> > > >       nents =3D calc_sg_nents(dma->state, phys_vec, nr_ranges, size=
);
> > > > +     if (!nents) {
> > > > +             ret =3D -EINVAL;
> > > > +             goto err_free_state;
> > > > +     }
> > >
> > > Technically, this hunk is not necessary, since sg_alloc_table() will
> > > return -EINVAL when nents =3D=3D 0. At least, that is the behavior I =
relied on.
> >
> > I originally added this explicit check in v5 to address Jason's
> > feedback, and to make the
> > failure explicit rather than relying on `sg_alloc_table()` failing
> > silently on `nents=3D0`.
>
> I prefer explicit checks, but I am not in favor of duplicating them.
> Since sg_alloc_table() already validates this condition, we do not need
> to repeat the same check in dma-buf. A comment should be sufficient to
> inform future reviewers that nents =3D=3D 0 is already handled.
>
> Thanks

Hi Leon,

Thank you for clarifying this further. Removing the duplication here
sounds good to
me. I'll drop the hunk, add a comment for posterity noting that `nents
=3D 0` is
handled by `sg_alloc_table()`, and send out a v6 shortly.

Thanks a bunch,
David
