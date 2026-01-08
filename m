Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2CDE26C39E
	for <iommu@lists.linux.dev>; Thu,  8 Jan 2026 16:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767889286; cv=pass; b=dmXArRuDfylFOaZD8ugPmjJ/BNhsAwl9kEFyIXEpbf2knCZXlPvRmoyjt/s6ojeLPo1RkziVk779KwcPqF+tIFOyHAgT1nQvb/7raKrWAQsv7HqIa+FH385ib8Y/K1XXR18BZZ4qr2F2NOhEjkPEwmCeO9m35qJgkBCrNhVbaGY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767889286; c=relaxed/simple;
	bh=HJoZfm5SHVdr1yyHhKTweECAeQtP5+kYrvSv/kZ9VQk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o9qMi1DMK8KO01viki4+vhhqmK3DunVlH3AV5yK4RZibQ6iL57ww6opWY6vFC0j1CFsMPeUVi+8ZlCCqzvlNxMhSpLpZ5n4p0JvQccIVK4Wb4E3aEIM/nYvhwBluVn/eP9fvBUe1eN7mrpF8FM5uT/nPbA+1Y/n3zGvnzajq7Ak=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0O2M7H+T; arc=pass smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0O2M7H+T"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-64baa44df99so20139a12.0
        for <iommu@lists.linux.dev>; Thu, 08 Jan 2026 08:21:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1767889283; cv=none;
        d=google.com; s=arc-20240605;
        b=Pt/W+drqKRQ5tRWNZduPjs1F437p8qQBbSgo5ik2oPs/47PpN8Z+MWyXMpltSDFli5
         q2MMeVYPv7egpCCo3Kur/6Xtpad/mDuaxrb/OFobmvw6aj/UxZEjaXXUkSL/zjtttEVY
         NfqzuxsFOb9jqv7XHFVlIm6c2IpwGfpAAgW72ksW2tyMqCcba+XWePue9lK/1XURInDn
         VdYvLDSVYqr87HqxfNQyPkk2Od8hH7RsY6H4la61PGYmKcNtFIUGqyQhb/RKygS6viQi
         3aJjxV0OhhnOikeVO5oap6XDsn+RrqWqzlMeLGamFYuFfvM7/P+J5iEvYU5V1ovkWfRz
         JQQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=HJoZfm5SHVdr1yyHhKTweECAeQtP5+kYrvSv/kZ9VQk=;
        fh=QdQdILWvlLc2hQqnp0n/8wdU4F3LkmOj3Hx2ZzpVSAk=;
        b=ArfQbIkAU+zMNxKyivSNpoR8RhqvPATYD0i+uT0tT14KTga4me/M/MYSm+nTue+Y1w
         IDbG6/906mUNRtq3fflaSeu+y/ThSrzfT7vRkSHvEwS8s5/rUqN/ifVzKDkqiQDBjSGz
         GkTt0JcjngdZ6AUOQdusnMCjODIf49vJZANtm50Ac7yGsNuR5najymzLl3aQlbVYYVdX
         leI0vu6aZP8eJDdyt1rIONUuApIGl4EHSOkXRAlwiPqmN/elhVdaK5JMg2T89x8eupLZ
         zefGUKToPfzlVCc6WTARw08wWd0trEdR2UbIp3mMX5fXSMXg2gmm78SrceTXjhXAi8Xr
         ui+A==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767889283; x=1768494083; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HJoZfm5SHVdr1yyHhKTweECAeQtP5+kYrvSv/kZ9VQk=;
        b=0O2M7H+Tcz6iVjJBRwq9Zv2vQ3NYWxRzdVf8SU+tPMm9F5czg2yuMNMOmqTaVVsv4D
         GGoUmB+HqRvhzYGBd1NxF3O7/jC8rHasdopm3R9Q6ZNsNyoVUMqpJqZyagv8KSVlAJUt
         JTz1R/EJmAdXZ+cYEeaOLWAyYE2CC9o97LErugmrPVjTOLq/CR5xW02DsI2WbVH+AN7a
         nzUG/qSItyoGr1n3meyjpgFLyi6b0RIyxvDOpoKL6Fwz5kcQyfzZeqorNf+64tOmIScT
         lzFOTAtb1XoPXNaFpohjV1oxcl3psD5bvgyboVLAUV98IyeR8t3nrBhBHkCaqrxTxgC3
         qH1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767889283; x=1768494083;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HJoZfm5SHVdr1yyHhKTweECAeQtP5+kYrvSv/kZ9VQk=;
        b=LpzL9pIvJweaPCiZwV4mJD8Y6MeKanYve/w49s/Veuf3pA/qZscQJdvv/uelA7h6BB
         pgdiquIS4a2vbaRfyDKJkLdV77aZd5dwfIwn0RUVEtRLmUCFJACdq92TIe5hell42hlB
         59xkWrAADvmmDMryBoCI5nPzyr3XW/oXz5ybMDEf6US9uPWunCilL4oT1grLIVmXtAan
         nzYrFczFjJbINfZusbi7X8+MIVQYeRNkdYy4lTh27a0OA49aEFa5pBKZKHG6w+kg7i35
         dwFCJ9QRZd88WONTiJdqyolRPja+nWQyBmZBCaeAGNowVTG11CYgOVl11yDCn960FVLg
         vr2Q==
X-Gm-Message-State: AOJu0Yxfy/kt/zhMxQEHs4APRBDyVm6qeNy6LmyygX0tD6fUuScMC1RH
	oKvtWUKru4ieBV0Z0ut8yIKvQt1R4b2AL3EHFTHS0XTa7NNypeTJ19F1AZbEA91a11JUouUzwJ3
	EZn6JUA3JIXmKeJROk2HM/J1zE4JfBoJbKCBFou4d
X-Gm-Gg: AY/fxX7Q1bfA0jYCBAJiOiorWQDaDh/AGtJ3YkU64O7MOirTrYIbRT3XVBarFaCTWvf
	VMWiYun0PNNP0p0KYTEtBokdfMXO5NMMEymxyw91iwfgqUmel5otLuLyvhE/fJ53iMejJTY+QnI
	FfvwBqpEqIwMnbG1bMDsjW+bBrDPN7tLTP2yyIZH+yXOOxdzNWKt8o54A6NjsmpyoFn1xzDJDGm
	8nLn2ZlnTig9PAB1XKx6Zc1V+5RDB5JMylJEhUhiNAHzBZY8XWbaaJZJiNPgsvYNqb1gJbF0D1d
	lUnotN0Dof9vIWRm2qPZd0wqvsGMow==
X-Received: by 2002:aa7:d305:0:b0:64f:8fc5:251c with SMTP id
 4fb4d7f45d1cf-650b8824940mr27337a12.18.1767889282916; Thu, 08 Jan 2026
 08:21:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260108113846.56179-1-smostafa@google.com> <20260108125934.GB545276@ziepe.ca>
 <CAFgf54ocNybHR_Mp1+i7cff-jkeMUV1QxBCt04jnKxwfwnyUfQ@mail.gmail.com>
 <CAFgf54o+YZUyZTszFt-uBW4ZhjrAMsfPFUb9kKTK1uHWdS+++w@mail.gmail.com> <20260108144520.GE545276@ziepe.ca>
In-Reply-To: <20260108144520.GE545276@ziepe.ca>
From: Mostafa Saleh <smostafa@google.com>
Date: Thu, 8 Jan 2026 16:21:10 +0000
X-Gm-Features: AQt7F2q7zAjQEJb7B7Z3UzD_3MZv9K7QzyaGgeYqN-ppW1uuZW9n5E_HzFAEE-c
Message-ID: <CAFgf54rkwipUMQH6452xoKXT_FwcE2s=TNwoTZd3_TrK5WJNCg@mail.gmail.com>
Subject: Re: [PATCH] iommu/io-pgtable-arm: Drop DMA API usage for CMOs
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, robin.murphy@arm.com, will@kernel.org, 
	joro@8bytes.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 8, 2026 at 2:45=E2=80=AFPM Jason Gunthorpe <jgg@ziepe.ca> wrote=
:
>
> On Thu, Jan 08, 2026 at 01:44:51PM +0000, Mostafa Saleh wrote:
> > On Thu, Jan 8, 2026 at 1:27=E2=80=AFPM Mostafa Saleh <smostafa@google.c=
om> wrote:
> > >
> > > On Thu, Jan 8, 2026 at 12:59=E2=80=AFPM Jason Gunthorpe <jgg@ziepe.ca=
> wrote:
> > > >
> > > > On Thu, Jan 08, 2026 at 11:38:46AM +0000, Mostafa Saleh wrote:
> > > > > Jason pointed out that the DMA-API calls are not really needed [2=
].
> > > > >
> > > > > Looking more into this. Initially, the io-pgtable API let drivers
> > > > > do the CMOs using tlb::flush_pgtable() where drivers were using t=
he
> > > > > DMA API (map/unmap_single) only to do CMOs as the low-level cache
> > > > > functions won=E2=80=99t be available for modules.
> > > >
> > > > This isn't what I ment at all, the iommu-pages.h could do the flush
> > > > inside itself using the already existing
> > > > iommu_pages_flush_incoherent() instead of open coding the dma api
> > > > calls everwhere, and maybe that could directly call the arch functi=
on
> > > > on arm (as x86 does) which would be easier to implement in pkvm's
> > > > hypervisor.
> > > >
> > >
> > > I see, so basically, we add the check for IOMMU_PAGES_USE_DMA_API in
> > > iommu_pages_flush_incoherent() with the DMA-API stuff and call it fro=
m
> > > the io-pgtable-arm instead.
> > >
> >
> > iommu_pages_flush_incoherent() is also used to flush non-cacheable
> > pages in generic_pt from flush_writes_*(), so it might not be that
> > simple; We might need to add a new variant.
>
> There are no non-cachable pages in the iommu-pages system???
>

Sorry I meant to flush writes for memory accessed by not-coherent IOMMUs.

> All memory comes from folios and is mapped to the CPU cachable.
>
> The general API requires the user of iommu-pages to know if the
> underlying HW is going to do non-coherent DMA, in this case it must
> call iommu_pages_flush_incoherent() before the HW does DMA.
>
> Effectively what I'm saying here is to convert the arm page table to
> use iommu-pages and then put your pkvm abstraction at the iommu-pages
> level instead of trying to hack up all these users.
>

I see, I need to check how that plays with the custom allocator in the
io-pgtable though. I will look further into it.

Thanks,
Mostafa

> You can also do the same conversion to the smmu driver to use
> iommu-pages instead of DMA API, AMD and Intel are doing this already.
>
> Jason
