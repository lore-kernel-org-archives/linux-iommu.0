Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5C721A239F
	for <iommu@lists.linux.dev>; Wed,  8 Jan 2025 06:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736318888; cv=none; b=M2VATpr/+DIP2s+5wPj409nWBNBq5js0fyCyJiyCSBYhAQr+GTofNTjcvyS+SnAAEtqtcd9ENHzvOp3aDg5ZUt1azFTHgJz4A/eHL8f1niiae8kBCiNLspZWfOtxVGJHV9ukpMjD3WBw+pSIr4MQOOuEW075ET4IC+3I4Hs1AGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736318888; c=relaxed/simple;
	bh=DqehjEbYBNgsSdfrk7Gp0J2UOco4jKErh154ZjgkyFI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m7OP45vFs/L7zTHXK/7b97rIt3iwssisp+jT8qfaWvgOsKa2qEdJg+9WdN4mj0/BbgR6I+eXP5UQd6AY89jBvO2NryMzFt6IPZC8dIuPy8CRJyBsioRkUv1CKlz1Sr1M8G7k1ShAgV2oAazV+gHkiQtZcFLS493gB1ZTWrY+z7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mVuhmCBl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mVuhmCBl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85AE9C4CEE7
	for <iommu@lists.linux.dev>; Wed,  8 Jan 2025 06:48:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736318887;
	bh=DqehjEbYBNgsSdfrk7Gp0J2UOco4jKErh154ZjgkyFI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=mVuhmCBlVSMDypBYVXzkPh5zxvsUPX506H/t+0/zI2IqaFLmYqwt/q+hkOArn3hMk
	 KY1pWZ7XGkEHmk+4q5ZUaTPUM8ojmlwwjCPRNUN2UWT2TYeIXRiRlKe6mIK+r2/d2Y
	 gaNLeTl86U5H2fFRIzMp65qcwaNE2EHNrVYKQfwMRoEYS9jJkI7UccQZlTJb9irMxH
	 IToYgR1dXYOmWO2/NYyCs2J3yQTvm7Gv4ljgikZeIl/wpxZfydlkGyi/sLnkFq4F3t
	 Kru+nlL85tp6MutlxlYyL1zFmAeoBANwKevKIilO42OXrDcEm6CZ6zAx/6Ftefp5du
	 +gAdxwXiXuEIg==
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5d647d5df90so13393457a12.2
        for <iommu@lists.linux.dev>; Tue, 07 Jan 2025 22:48:07 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUy3gIeG4ym38M6QLCnP5o3+lp8kZylwBhYsd2G3xp0j8UVqBwmxU1BDbARJkHn1bAp1pZxHA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy8LyA2PdmM9Thjbcv/N7DVZHSGZ3ND3evpyangWG2BrqxH1EuY
	giqpqGd19K4YpeeEV+itJglZsg6O/YLG97k6NcMhRToWhhoa3PKA/HO8OFT6lcpzNmWYrwinrIE
	ebKd/3aMmi5qtDIVyBFLym5HsINg=
X-Google-Smtp-Source: AGHT+IFQiLj+EqRoItgWkCcqPZHA1BZTCXfkF+nlbvuakdYpnzXgPFNNKhWroWBS2mGtleDRYJs6J5MiQ26cTGoR+pk=
X-Received: by 2002:a05:6402:354b:b0:5d0:f830:ef5b with SMTP id
 4fb4d7f45d1cf-5d972e6e0famr1053043a12.29.1736318886007; Tue, 07 Jan 2025
 22:48:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250103024616.3359159-1-guoren@kernel.org> <a110be11-923e-4943-8741-43b5513c9691@ghiti.fr>
 <92eb2691-3b40-4549-83cf-fbdd0e98bf63@sifive.com>
In-Reply-To: <92eb2691-3b40-4549-83cf-fbdd0e98bf63@sifive.com>
From: Guo Ren <guoren@kernel.org>
Date: Wed, 8 Jan 2025 14:47:54 +0800
X-Gmail-Original-Message-ID: <CAJF2gTQomhrkYZORgG4ufRfQW3LhD4tG21GhX0v2Q=mR77mOKg@mail.gmail.com>
X-Gm-Features: AbW1kvY6SS07dX-cAoOyeK1Th0fzy9g2yBA-bYSqL-ERKUCMjhKHt54-h393Lsk
Message-ID: <CAJF2gTQomhrkYZORgG4ufRfQW3LhD4tG21GhX0v2Q=mR77mOKg@mail.gmail.com>
Subject: Re: [PATCH] iommu/riscv: Fixup compile warning
To: Samuel Holland <samuel.holland@sifive.com>
Cc: Alexandre Ghiti <alex@ghiti.fr>, tjeznach@rivosinc.com, joro@8bytes.org, will@kernel.org, 
	robin.murphy@arm.com, paul.walmsley@sifive.com, palmer@dabbelt.com, 
	baolu.lu@linux.intel.com, zong.li@sifive.com, iommu@lists.linux.dev, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Guo Ren <guoren@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Samuel & Alexandre,

On Tue, Jan 7, 2025 at 1:47=E2=80=AFAM Samuel Holland <samuel.holland@sifiv=
e.com> wrote:
>
> Hi Alex,
>
> On 2025-01-06 4:31 AM, Alexandre Ghiti wrote:
> > On 03/01/2025 03:46, guoren@kernel.org wrote:
> >> From: Guo Ren <guoren@linux.alibaba.com>
> >>
> >> When __BITS_PER_LONG =3D=3D 32, size_t is defined as unsigned int rath=
er
> >
> >
> > RISCV_IOMMU depends on 64BIT so how do you get __BITS_PER_LONG =3D=3D 3=
2?
>
> I am guessing this is from some downstream effort to compile a 64-bit ker=
nel
> with an ILP32 ABI. However unsupported that may be, size_t is the nominal=
 type
> used in both riscv_iommu_pte_fetch() and above in iommu_iotlb_gather_add_=
page(),
> so the change does make sense.
Yes, I'm working on ILP32 ABI on CONFIG_64BIT=3Dy. So, I got the warning
when __BITS_PER_LONG =3D=3D 32.

In riscv_iommu_unmap_pages(), we've written "size_t pte_size;." So, we
should do that in "riscv_iommu_iova_to_phys()".

>
> Regards,
> Samuel
>
> >> than unsigned long. Therefore, we should use size_t to avoid
> >> type-checking errors.
> >>
> >> Fixes: 488ffbf18171 ("iommu/riscv: Paging domain support")
> >> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> >> Signed-off-by: Guo Ren <guoren@kernel.org>
> >> Cc: Tomasz Jeznach <tjeznach@rivosinc.com>
> >> ---
> >>   drivers/iommu/riscv/iommu.c | 2 +-
> >>   1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.c
> >> index 8a05def774bd..38d381164385 100644
> >> --- a/drivers/iommu/riscv/iommu.c
> >> +++ b/drivers/iommu/riscv/iommu.c
> >> @@ -1270,7 +1270,7 @@ static phys_addr_t riscv_iommu_iova_to_phys(stru=
ct
> >> iommu_domain *iommu_domain,
> >>                           dma_addr_t iova)
> >>   {
> >>       struct riscv_iommu_domain *domain =3D iommu_domain_to_riscv(iomm=
u_domain);
> >> -    unsigned long pte_size;
> >> +    size_t pte_size;
> >>       unsigned long *ptr;
> >>         ptr =3D riscv_iommu_pte_fetch(domain, iova, &pte_size);
>


--=20
Best Regards
 Guo Ren
