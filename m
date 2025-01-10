Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C587C215F5A
	for <iommu@lists.linux.dev>; Fri, 10 Jan 2025 20:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736542105; cv=none; b=K/dzanFyBsJvyf6ahzWkbvWeBiIWAF7ljFtRBkwLepkLBSlpRjxPrgsHCnrdz4bkNj36t8SOTXAYAjwR++faV3HX3gOTafbUopltu9m4tu2gEIjmt7pNRDRom+HKD+dN+3gr3vXeQ0exkPURO20Oa1e70O0XT9Yep1J3rfV5j0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736542105; c=relaxed/simple;
	bh=VuGhPf2yImvwlNcae5ao4dAdW/s0SL0WrNfNTBobds0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JKWZHfv/811fOpxuv8YWjoAzBFYol524odL9KnsSLyseUquyxgWArLylhY93mbinWdzCk4XAlgl3vi4ZfxAkyRADVocyG0gHl8yva/uqbk+6zMG07cRnE/82mLa23VtL3zrxLPHiIK1CXjd7Vq9elrOQ50EdyJEU+1ad5qzAzME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=BWAS6ijg; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="BWAS6ijg"
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-3a77980fe3aso7650075ab.0
        for <iommu@lists.linux.dev>; Fri, 10 Jan 2025 12:48:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1736542103; x=1737146903; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C3JFV56nbjgPx94a42Ef7RFHZlbLzNHms4G/1GzXED8=;
        b=BWAS6ijgNoWvTOkFBxcZKB61+JYAO0MlQGG1EWz71PaishnzBYQhSzFnAiJWc0Rbv9
         95H8pGaD6OFteDAgdZcmE9zi7wZrT/k1BA8rkyLzKfVXNfvb704uStjYGdtIGPTf0+iP
         Mk8b+shpIDArfury+OILjto9J86e4z7sL5BF/fDLCF6NqCpT+v4d6fgGA9on6P7x/3sc
         WFhBQ1jMj00YZOjnZIxbjxbnboe1h01ibv4YtR5GXuhuTlikTbopAQHbM1dDaEUeAc73
         XYZVyU9s5Zywx2/FWdExvb4FChvhIl6TVgaoTWq0dXPNpXPB+LDAH1jIx0GL/ju2jvwu
         J1Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736542103; x=1737146903;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C3JFV56nbjgPx94a42Ef7RFHZlbLzNHms4G/1GzXED8=;
        b=i15J/YqjAnU+ivPah0HKKA8rPIEvpejI0aLA95S0A9r/vu3jmXlW6Tm39Fa9Apeujc
         XTz+jmndvg2W7YSyku1MPN71Tg/pN0SySPZdgbR1TdWhU/4+o4SqWhbXVo/HGkK6X/5e
         QNeHBCfqm6HB1isn2w1RM5aqEBztqe7SDGONJgNykxrozsJnphMaA62pXWJf+2QrSnA8
         8LFQPxzXkL1Cxvt8ph5dLj5eiZ1F6ExgSyF0m7XVvKreWaLkZrv0vZMUJF7uEn5+Mwob
         QskoEfSVCDvHWAaOaglglTve/9XY77uvJDJCFDnnHomm9SvHti6DcnN+ia5sldcE+M0J
         bJdg==
X-Forwarded-Encrypted: i=1; AJvYcCUnjK2hlD7Ytn4PVHHWKT5zcewzIOG88MXsJ6U0prNPPpZbYEcoH4l0q6xR9jKfefV+iU0eGA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw7RFZtlCdS0dH3zdAWAKjFrJagDEp7m6AeRUFz6KoMk0li9ok6
	qeevweahGA+xv5KqVNNYCYMRwZmn8x0mMCCgagQ0yK3YFMQ4R5E7A0LukNLuSaLtjREuEZX0RfG
	aSulnygYnMVJ0QwxI0h7IDvfTOEhQTqqBbf/gpg==
X-Gm-Gg: ASbGnctR3cPLNRZh9A172Z1LZSXuMhJmOxvO12fWbhK7d7aNsXChLNRTdO+z447+Tnp
	AOb+ztkOCTrzh0CHvZAEVbXlroB4An76b1pzXLQ==
X-Google-Smtp-Source: AGHT+IGaVBsQzJt2X5m/CW4/nbtDNJCmepn0QUZ4oXFhVYof2srhepeK9PBG9lGW9sbM4bw2dOIf1oolgAzWwgcTprU=
X-Received: by 2002:a05:6e02:3313:b0:3cd:e9a0:3c3d with SMTP id
 e9e14a558f8ab-3ce4af9463cmr66122455ab.2.1736542102941; Fri, 10 Jan 2025
 12:48:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250103024616.3359159-1-guoren@kernel.org> <a110be11-923e-4943-8741-43b5513c9691@ghiti.fr>
 <92eb2691-3b40-4549-83cf-fbdd0e98bf63@sifive.com> <CAJF2gTQomhrkYZORgG4ufRfQW3LhD4tG21GhX0v2Q=mR77mOKg@mail.gmail.com>
In-Reply-To: <CAJF2gTQomhrkYZORgG4ufRfQW3LhD4tG21GhX0v2Q=mR77mOKg@mail.gmail.com>
From: Tomasz Jeznach <tjeznach@rivosinc.com>
Date: Fri, 10 Jan 2025 12:48:12 -0800
X-Gm-Features: AbW1kvaUzgPnWKD6v5lrZokE5U8BwE1gIyIKM9yEaUeUfakmC3sPneNPZHxJNzg
Message-ID: <CAH2o1u7UiNpAKfyJJ6t+yaQY_VpCOeXjki4BQLwsQuEEyG=c9A@mail.gmail.com>
Subject: Re: [PATCH] iommu/riscv: Fixup compile warning
To: Guo Ren <guoren@kernel.org>
Cc: Samuel Holland <samuel.holland@sifive.com>, Alexandre Ghiti <alex@ghiti.fr>, joro@8bytes.org, 
	will@kernel.org, robin.murphy@arm.com, paul.walmsley@sifive.com, 
	palmer@dabbelt.com, baolu.lu@linux.intel.com, zong.li@sifive.com, 
	iommu@lists.linux.dev, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Guo Ren <guoren@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 7, 2025 at 10:48=E2=80=AFPM Guo Ren <guoren@kernel.org> wrote:
>
> Hi Samuel & Alexandre,
>
> On Tue, Jan 7, 2025 at 1:47=E2=80=AFAM Samuel Holland <samuel.holland@sif=
ive.com> wrote:
> >
> > Hi Alex,
> >
> > On 2025-01-06 4:31 AM, Alexandre Ghiti wrote:
> > > On 03/01/2025 03:46, guoren@kernel.org wrote:
> > >> From: Guo Ren <guoren@linux.alibaba.com>
> > >>
> > >> When __BITS_PER_LONG =3D=3D 32, size_t is defined as unsigned int ra=
ther
> > >
> > >
> > > RISCV_IOMMU depends on 64BIT so how do you get __BITS_PER_LONG =3D=3D=
 32?
> >
> > I am guessing this is from some downstream effort to compile a 64-bit k=
ernel
> > with an ILP32 ABI. However unsupported that may be, size_t is the nomin=
al type
> > used in both riscv_iommu_pte_fetch() and above in iommu_iotlb_gather_ad=
d_page(),
> > so the change does make sense.
> Yes, I'm working on ILP32 ABI on CONFIG_64BIT=3Dy. So, I got the warning
> when __BITS_PER_LONG =3D=3D 32.
>
> In riscv_iommu_unmap_pages(), we've written "size_t pte_size;." So, we
> should do that in "riscv_iommu_iova_to_phys()".
>

Thanks for pointing this out.
Do we have to change other relevant uses of `unsigned long` to either
`phys_addr_t` or `dma_addr_t` to avoid type mismatch and get ILP32
working correctly?

Anyway, for quick warning fix:
Reviewed-by: Tomasz Jeznach <tjeznach@rivosinc.com>

> >
> > Regards,
> > Samuel
> >
> > >> than unsigned long. Therefore, we should use size_t to avoid
> > >> type-checking errors.
> > >>
> > >> Fixes: 488ffbf18171 ("iommu/riscv: Paging domain support")
> > >> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> > >> Signed-off-by: Guo Ren <guoren@kernel.org>
> > >> Cc: Tomasz Jeznach <tjeznach@rivosinc.com>
> > >> ---
> > >>   drivers/iommu/riscv/iommu.c | 2 +-
> > >>   1 file changed, 1 insertion(+), 1 deletion(-)
> > >>
> > >> diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu=
.c
> > >> index 8a05def774bd..38d381164385 100644
> > >> --- a/drivers/iommu/riscv/iommu.c
> > >> +++ b/drivers/iommu/riscv/iommu.c
> > >> @@ -1270,7 +1270,7 @@ static phys_addr_t riscv_iommu_iova_to_phys(st=
ruct
> > >> iommu_domain *iommu_domain,
> > >>                           dma_addr_t iova)
> > >>   {
> > >>       struct riscv_iommu_domain *domain =3D iommu_domain_to_riscv(io=
mmu_domain);
> > >> -    unsigned long pte_size;
> > >> +    size_t pte_size;
> > >>       unsigned long *ptr;
> > >>         ptr =3D riscv_iommu_pte_fetch(domain, iova, &pte_size);
> >
>
>
> --
> Best Regards
>  Guo Ren
