Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ACED1D7E57
	for <iommu@lists.linux.dev>; Wed,  2 Apr 2025 12:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743596418; cv=none; b=quxEVHCg6xECmIr+z1W49sEjP1pl72gI/ortieAaJdfJHPXdaki5Hgyo6rigvbXBo7X2lkplzWkAobvBNU4mXYCpphGtwQ378MU9iLKpqvNiv5tGGss7mOq53jKlyLxaUmdsi5ipTCWN2iJOn+ycEB8kawuGzLc5N+ODTAjh1Dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743596418; c=relaxed/simple;
	bh=2bqiVwG6B9b93pHmMU3Wt9WeVY2w2INe21iLiS7fKnA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Fv6DPPpYV3fY/Exxh5x4T2MyGZvKq6lnfs99sJZMgs68xLrRAQOajE2cAlNXMOTLkRWyHXi3YkSyEzPtUYevqugvb6YoHpg9g2SaozTO2YpzjfxMaC+iTSzNd6HIpi7vil933nKTD6/xAHMB68K0jKzn0iuFr/ys79N2nQMOStQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=ECqRemGx; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="ECqRemGx"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-af9065f0fc0so38325a12.2
        for <iommu@lists.linux.dev>; Wed, 02 Apr 2025 05:20:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1743596416; x=1744201216; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YWJxBNwkAmqL2G8fzcWM9thfWI+FACEvfsrq+gEk/S0=;
        b=ECqRemGxCLM9mXzEEJrA8NbOXsVFNjIJCfubNr2xTLZgE/YHQgaWAY18iLfe/52gGQ
         GVO9U0hVu+Xh3m4Wxo5ACDkGl0fFuW5v3xrEwxBjnhzBZ/I9sxokxVRf+lAHSOliQrAh
         6nbvaJrR/G43Nw4HAIYwaNPTDZ4UINRNmutxjzpNDefcxBFV3B4NnBFFZOk14qfIoJBb
         tiJmu+6ZyVNj9sfXCXsBsfl8TscTUktY2y10hYcHJ3qXOGCIBp7MRWZzYO0Ety7r6WO6
         Y99jO+yZxO6nC2n5YgqahBr/VT7ZAUgtM+irWEoJhDBCY7fabogmxUXCSIUTpS1grVXn
         O4Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743596416; x=1744201216;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YWJxBNwkAmqL2G8fzcWM9thfWI+FACEvfsrq+gEk/S0=;
        b=wrYGXYwCSR7P7CFiRv9yZU4fxiygb92+MELw9yyyMrc/dSHObnVqSAYfTdyp3evUNX
         7/0UKXAMgcTGh+JJnaCLZD4YbnjX6K9etc4+OS0hy3w1Pm1yk1pVfKH5jreKuMLZ/8KA
         NG8NFxKlDTmOhNvuWIMALDIdysO1UqZGcS1yP7lrBAYGR9IxG/7La442EVqNS0Ib4wvi
         KDhKhg4Hjgux/z0wV12Pb2fm3CyqFxur1f9lBhVWEqiNkKKewMI1DOLTo29GsaFzQI6+
         vifuDREgH8L48kApDQBZjy9RcDgq92fT68ipxd/EbYEbvPGSOn1hXkFCLYg1x/gR4q9u
         5w7w==
X-Forwarded-Encrypted: i=1; AJvYcCW39NGwd7NE8GtlrCZKG1LwckC8QpB2hvQe6SAZQsyOR53F8jLVjdJY+dAMeH1clEGio/q6YQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxxwdE7B4NFfWV+ZNnnhkWhDnDxRS0KtGuqZS2YeHqsjdmDhRgK
	+UzqjlYoNXB0VVcbEUhOeYBT7W5s6o4mtmkc/9TNrhwH/U1NMrfchHU2anbsOOvL553EgbkhBOt
	icoQw1kbCo4uC9AC7pGwqUIzKujVqTnX2AhoHug==
X-Gm-Gg: ASbGncsZB7k0CcScG3ybUl2PWb5l953b5I8uagxE3pNTp2fyTeC+gkqrPHRpD5pCa6z
	Tq/gdosQcz+yPY7mWaMdidhI8ilPKIV+fY8IjfpRJiQenefRQ1pHaOJLKb+pomxz3cBzcWjEprk
	e5YWokE8yLe2ZIq7D8CoOCGIP0FPOiEp7Ag+vMXDRaykawSafuYg==
X-Google-Smtp-Source: AGHT+IG9C4OmAcA1BcvJZJK8vgSK/DWCvtCqpq1tzxaqNCtVF3YEFGKjwNPiS170vkEx7SYXHsTEXZvGHRmNASAO4vI=
X-Received: by 2002:a17:90b:28c4:b0:2ff:58a4:9db3 with SMTP id
 98e67ed59e1d1-3053215d8aemr22113172a91.35.1743596415763; Wed, 02 Apr 2025
 05:20:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250325144252.27403-1-luxu.kernel@bytedance.com>
 <9F043708-3BB6-46CF-BEC3-2636E9A388B7@jrtc27.com> <CAPYmKFtAWNz7nCDDD7rjGeV2fRBgy5Kt6KR60pEyXAM=bb7r4g@mail.gmail.com>
 <20250401154412.GI186258@ziepe.ca> <20250401220201.1fa3ec76@pumpkin>
In-Reply-To: <20250401220201.1fa3ec76@pumpkin>
From: Xu Lu <luxu.kernel@bytedance.com>
Date: Wed, 2 Apr 2025 20:20:04 +0800
X-Gm-Features: AQ5f1JoCpzXNEfUDVMpNcZU9VBfEeMyRz89Td3As3soGZh_OUSrxjWt-F5xQW4s
Message-ID: <CAPYmKFtOV6JfAudcw4gfWpgQv8k3Q6dNrTynqYo2tSdZEAwKHA@mail.gmail.com>
Subject: Re: [External] Re: [PATCH] iommu: riscv: Split 8-byte accesses on 32
 bit I/O bus platform
To: David Laight <david.laight.linux@gmail.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Jessica Clarke <jrtc27@jrtc27.com>, tjeznach@rivosinc.com, 
	joro@8bytes.org, will@kernel.org, robin.murphy@arm.com, alex@ghiti.fr, 
	lihangjing@bytedance.com, xieyongji@bytedance.com, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	iommu@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi David,

All these 64 bit registers are updated during initialization (when
allocating page table and iommu queues) and destruction (when
disabling interrupts and iommu queues) in the existing iommu driver.
There won't be multiple cpu operating simultaneously.

Some 64 bit pmu registers are also updated during pmu event
initialization and overflow handling in the oncoming iommu pmu
driver[1]. There will also be no concurrency issues due to the pmu
framework unless the ACPI/DTS is misconfigured and two iommus get the
same register resources.

So maybe a lock is not necessary. Please correct me if I missed anything.

[1] https://lore.kernel.org/all/20250115030306.29735-1-zong.li@sifive.com/

Best regards,
Xu Lu

On Wed, Apr 2, 2025 at 5:02=E2=80=AFAM David Laight
<david.laight.linux@gmail.com> wrote:
>
> On Tue, 1 Apr 2025 12:44:12 -0300
> Jason Gunthorpe <jgg@ziepe.ca> wrote:
>
> > On Wed, Mar 26, 2025 at 11:26:07AM +0800, Xu Lu wrote:
> > > Hi Jessica,
> > >
> > > > Is such a platform conformant to the specification?
> > >
> > > We have talked about this before [1]. I think the IOMMU spec does not
> > > mandate the implementation of 8-byte access functionality. The relate=
d
> > > sentences are listed below:
> > >
> > > "The 8-byte IOMMU registers are defined in such a way that software
> > > can perform two individual 4-byte accesses, or hardware can perform
> > > two independent 4-byte transactions resulting from an 8-byte access,
> > > to the high and low halves of the register, in that order, as long as
> > > the register semantics, with regard to side-effects, are respected
> > > between the two software accesses, or two hardware transactions,
> > > respectively."
> >
> > I think the commit message should explain an anyalsis that the code is
> > safe against the mentioned side effects due to ordering.
> >
> > And a comment should explain this:
> >
> > +#define riscv_iommu_writeq(iommu, addr, val) \
> > +       ((addr =3D=3D RISCV_IOMMU_REG_IOHPMCYCLES) ? \
> > +        lo_hi_writeq_relaxed((val), (iommu)->reg + (addr)) : \
> > +        hi_lo_writeq_relaxed((val), (iommu)->reg + (addr)))
> >
> > As the naive reading of the above spec paragraph doesn't seem like
> > there are exceptions or why one register has to be the opposite order.
> >
> > Also missing () around addr
>
> It is also double-evaluating (addr).
>
> I hope there is a lock, interleaved accesses from multiple cpu
> may not work.



>
>         David
>
> >
> > Jason
> >
>
