Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34E383AD525
	for <iommu@lists.linux.dev>; Tue, 23 Jun 2026 21:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782248622; cv=pass; b=k2tEXpurESTZjIMjat6AkelAvnQ9q0nHG6knikKLjKjjN1oOcGrj6rqu0K0mMj5DdO7xNP2cVmCK5AYRzc2PxbyoUlbF/O4j4z69gkSYA/QsxoK2R9/XkEYIph0AGI9gGzprcSjcL2WYFYrBBumY7re7BnEiBJK/kIDRD1YC66s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782248622; c=relaxed/simple;
	bh=Slm3EEkSH4PB9RQu260syQQELF+PaB3Sj0996Hd4Y1A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lBqS51mgWBVzcAHSpcg7AfXZTolZZD4ce75wl+C/0FGBWK8gHpeacHz6z+C8DeweACmYHkA0qWmxuCXNwLZsq8xuBI7i97vwiOIzCyOKMzJEKztUF9Jn3mU0N/8VdSMRqNBVwR6tCe80BZkcdY1RLBAz8aYxF6JIjMS6huTcpEE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=P9fwF2mQ; arc=pass smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="P9fwF2mQ"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4924933d072so3395e9.1
        for <iommu@lists.linux.dev>; Tue, 23 Jun 2026 14:03:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782248619; cv=none;
        d=google.com; s=arc-20260327;
        b=gsMfo+6nLbkuePPcFo5R/cjB1GNVXhpRXefXJC+Xn+E3NY+eoL6kUw1ioCuqLH7cr7
         /W5FlLLs0u5T86fyUB6II2b5hqbLV5bQ/Wo4nA7x5fCHh2RyDkITsIUp6lnef/co5UJT
         KZ9c9/5XgIzxrbUnkPuy4dLnHpXxKn9apuV0WDFiRwLRtkD088paF8F6mDTySM/3w03e
         nb27rr2FKpnSu5YwcxihQqRS9jHZi3N1S65iP2FaN/Y28fVOMUEZNafgZzRNtEvxCwzK
         pjOzKofBhD95ksJVTn/S9o/VHYb0q67qG1mkYIfzTdGCDPD4IMvYIHORbsfy0tI7wl5N
         nDMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Slm3EEkSH4PB9RQu260syQQELF+PaB3Sj0996Hd4Y1A=;
        fh=3Qa4UeVF5d+yjIHbcpxS70uL5AE3rY8+bQbdPIwDaL0=;
        b=T4++J/rQV1Pl79867CUDVgCzBO1XM5T4jdp7SASPzvUjdre8HrTCU5xI5Ef8ffl2Uu
         3/KLB4UKHg63fco2Ly82z1aHbM3NzU12yfFi6duMTh9Yl5OyfI9jnWFrxpcaDHhjnppw
         ZsKfy4c90IQM/iT272cydBcf9btrsRQW0tyqfZI3m946ux+a/slL17R4SgJcUZs9Js4u
         FR41wP+zK26zKHvlrs/WH0/d99lJG+Y7inR8QIU3yJAFLWi0V7Lq5P/yy4p5yu/olb1l
         rmVjBOfUwxoHnXgCdjB6iS5LHfMu9Dhg7eioQRP8/DF8FJ/pBZBJErG6CYKsOjpK/SFA
         WYUA==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782248619; x=1782853419; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Slm3EEkSH4PB9RQu260syQQELF+PaB3Sj0996Hd4Y1A=;
        b=P9fwF2mQQIWKDZEBWf6i3I9iyy8rTlbjFXohlqGG8tmC2/+Wb8Z/vCqKOwb8LiHbMp
         k7reOfOTXLGAQQb/cHxDHXQncB4CN9+dMeJK0c0VCPNVqOtDTqd9zpuAgSk/nl49YWvW
         XOEkv2adM9IKY4KmQJzdCG3Co/IRH4AetRDLSpnjVTEHYIOR3+8ryxurAdSppJJABv/F
         ztLzyIriB5OQ3d/CONBW8phIpqidqiAWXL9SEKlafZBOGvsqMdOPhSsAOglHKPRVnPY5
         k1ncE0OogWbF3gsvmdw+cJpwoDYyEoT273q9xbwgQKnjAAC+24/Vu3/yk5YfraSNSgE+
         eCVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782248619; x=1782853419;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Slm3EEkSH4PB9RQu260syQQELF+PaB3Sj0996Hd4Y1A=;
        b=TCXlmZ1PPl+bZzHNHNNtGTpBMbXAZdhvLUNgfG5uT3Wt7VKalK4KY2fhVOEApOtbSS
         dZnAnhA6A00+cyXS746K6Jwl3gkXeIz5SQeMEyywPL5pjVZy5v4+JB1EQb8ekZzXk4ZG
         ljwE2VEIy7s4jbauENnOM/8rakkWuxHPPuTOhhDO4gj59PaIhvP9kkkSC36ksr5hDyVN
         /OZikqB1L+qr7IWyoaWEvlOxnUbRBlC11pAijTthp390YHCHg6CHDzphzN2xyjKUS3q9
         C855BOk+ikmwfcH0gEx4dVbYdBBPKqq4xxz0g5O2lDGZLGQ4AJZP3+ZeS40xjt+YhwCd
         Y2mw==
X-Forwarded-Encrypted: i=1; AFNElJ+1tu/rzSBWZ2FcUlk5YyYcHe/UeX02X4wSADwKXk4kHTiTxZPbNn1zAwZYE0C9SlypSQR6mA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxhE5/+B4eZ5XvpzE5C9Oxi/oS9EeRXQF8xvbMuiQ2xuvIHBo8W
	kz/JViRcAk5CmKGaiqqDypRS248llZXiwYCWmymA/RdRiy+WHkz1t2Hnim2hfhdJb3jiLSDDIIL
	nXTDJfIIOsmDocB9Ew8wuHaFWJTNeqsdU7JeACD8=
X-Gm-Gg: AfdE7ckp9RaRk95v2ZuN8n6MrVTaveqJK1mwBASIXR2qsAdelfQqPM+4tHlNeNmYpz6
	vGzE0UtQpZuDHuteFukIbFrUlEsLuSNqL0aI826OI5vXoxW1CYsEGBfKpdNh3Iz4lqYZMFS9Sld
	mAkI6BaAUDeNR2zoNEDyf3SIeV0EwI3f4+G2ZwIj5XgJQxWuKgE4ihUBM7Z68Kz5k/WvJP8oRHU
	yfQJrP2vpcogBu+z/+Fj+dTVsl8FOwlFb9qWcrMIrBVc7624/1QcGELwX4kWRV+yIjUzSGfnpRP
	cPc=
X-Received: by 2002:a05:600c:16d3:b0:485:1a54:9407 with SMTP id
 5b1f17b1804b1-492603072camr290785e9.0.1782248619190; Tue, 23 Jun 2026
 14:03:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260621222130.1667453-1-xuehaohu@google.com> <20260622091344.794e0d74@pumpkin>
 <CAPd9Lg9+d=Rw4230FdcMFd0VYfyhXhD=eju53iURR8c61iXsWw@mail.gmail.com> <20260623092501.17bef195@pumpkin>
In-Reply-To: <20260623092501.17bef195@pumpkin>
From: David Hu <xuehaohu@google.com>
Date: Tue, 23 Jun 2026 17:03:26 -0400
X-Gm-Features: AVVi8CftE4Qz-bzNimcxnNDxPCuT9w5jszdF7jgeQ4PkwmMrpP9oMduQaXpAyA0
Message-ID: <CAPd9Lg-i8Agh7_E5cd2CmtWww1cM2PW3A243qtQaHxhvHdjCQw@mail.gmail.com>
Subject: Re: [PATCH] dma-buf: Split sgl by largest page-aligned chunk
To: David Laight <david.laight.linux@gmail.com>
Cc: Sumit Semwal <sumit.semwal@linaro.org>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Nicolin Chen <nicolinc@nvidia.com>, Leon Romanovsky <leon@kernel.org>, 
	Kevin Tian <kevin.tian@intel.com>, Ankit Agrawal <ankita@nvidia.com>, 
	Alex Williamson <alex@shazbot.org>, linux-media@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, 
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev, jmoroni@google.com, 
	praan@google.com, kpberry@google.com, sashiko-bot <sashiko-bot@kernel.org>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 23, 2026 at 4:25=E2=80=AFAM David Laight
<david.laight.linux@gmail.com> wrote:
>
> On Mon, 22 Jun 2026 17:26:10 -0400
> David Hu <xuehaohu@google.com> wrote:
>
> > On Mon, Jun 22, 2026 at 4:13=E2=80=AFAM David Laight
> > <david.laight.linux@gmail.com> wrote:
> > >
> >
> > Hi David,
> >
> > Thank you for your review. You raised many good points regarding
> > optimizations here. I'll switch to using 2G as the max entry size
> > (`SZ_2G` from `linux/sizes.h`), and remove divisions and
> > multiplications. I'll also replace the `for()` loop with `while
> > (length)`, and drop `min_t()` in favor of `min()` by casting `SZ_2G`
> > to `size_t`.
>
> You shouldn't need a cast at all.

Hi David,

You are right. It looks like `min(length, CONSTANT)` works well here
without triggering any type mismatch warnings, regardless of whether
`CONSTANT` is `SZ_1G` (`int`), `SZ_2G` (`unsigned int`), `SZ_4G`
(`unsigned long long`), or larger. I'll drop the cast and send out a
v3 shortly.

Thanks,
David
