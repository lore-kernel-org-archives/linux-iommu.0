Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 092FB3ED13A
	for <iommu@lists.linux.dev>; Wed, 25 Feb 2026 18:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772045507; cv=pass; b=t6B4Fci+vP8+BLb2TUjARiO1lnFxpN6D6wbxvuugYiYb20HL3+rwr1zHyFWcKvpFCMfJDeLEjyZOUCWPuT15qqzt5WySArbqvS4sg/SBev7yyM+hTYWbdKYKj/i2IyYsTuHl6MLJ0+IoxMObWQZrNCeYDkQowvEeArHqiYmFv6Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772045507; c=relaxed/simple;
	bh=I8u5wRsILbockgP7XslREN6a+2ulpwAACQLe++cFxRE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Jvl5PWXNb1Tk8XL49bfR7DKX92g3XoOhHKc5Fs3Auw56h6PBTDpJgQj9Jlx63V6kBWVnOgXrmrI53hiFlP0bPFzu3+QLJdssmF5aHX8l9c1Ay/awOYDDLv9RG7SpGD1wfFnQ4QSMylONHFiJQqQ7l9TtVNje4rTa/ZGkvMIQyxQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=muyVYqog; arc=pass smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="muyVYqog"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b90bc00578cso4133366b.0
        for <iommu@lists.linux.dev>; Wed, 25 Feb 2026 10:51:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772045503; cv=none;
        d=google.com; s=arc-20240605;
        b=OihEJlAgsT64nZ9AV1cr2qbBvc5J8zZyLKotEd59OvNPg5GNZe94zJH7gtqHcJqVir
         l71fr1gXu7DCidBujCwb64SFF//OaMV8dgHVq4Eb5NpQNg5IOLrs/1PwgG+CbZXl5pmP
         zOeTFx5U3iZwDY7cOnQ7AthPuUUJqvWbghu1EepYshLaixzJB9IzPhWb1KZ1nkm7ZJQf
         dW5fTyR9HnR+wGo/CEbrxaoSG172mH5T1RZbeyae/26PWZYliXjaRBjnW+uAFwwgEmwv
         GmlbrphYjOytrLloJAm7U/tSJEw02lEko/KrcUASt/B/3YKYlyrMEYVJzqigrClJdOJx
         oCiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4oh/ifwivL8l9J8VT3JA58Q6ouuCYd8eO2HrHQHPvGw=;
        fh=t/mhJG52W/jyjBBEKxm1F/HkfP6q0UqU0i9ADXAL7/U=;
        b=g0dftfrS8CnLLboes6eFmjoTlGOsRm+Jqg4FNVOvw32xhNPdVHX0+qn6bZWu9Xaxa3
         BeIqPE4Pyavp6kQUD9px9dOWEYpiU9cdPekZSPUpWOYMhAcU3qL2bGm73cNaU1+T2FgD
         MLIhbnFMXDw7YnFJDJ+vam/DE5PaI/kNTP1yBdmdJuYLpoD5KtfQ7OWqzYu+WC88Q0yG
         jeMNSaAAS+g30tqvcN5ZanJ3xEczg+eOWMmjEGvn2C1pK0B6Q2H6BjeLA6aeT0P0XkAW
         Q1zfnsdfoMqy4bXryv9kk2sKtqP76ffpcwM8XxhV7pe95Fl9nkC2kroH98nUwDWieLXJ
         VraQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772045503; x=1772650303; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4oh/ifwivL8l9J8VT3JA58Q6ouuCYd8eO2HrHQHPvGw=;
        b=muyVYqog5yL0mCJ8u+s8CoxLZDjKTCfZkf8ZkJmkecf/wRI2a5jxpiLg9B5oW/s10q
         mDcI7iWbjjM94gO7X0ubDuJz+RM5eI7QNbh8dGTFwNS6cD9CJQ8kOTsRKJsJCoaUpNq9
         /onFgvpzi3r/VCW2ryHJrxDEivID+lz/lPNb/sa4S6z6pSC1S8oB3t7THZBMljZvYg11
         UyBqDhPUrejt6FNTct3y0ukqi+45OmtL4CXrlmETr7GGAakiXcqfbc7/YGIrellUGLCA
         4r/nMSR2fXGNC1rpGjCmYv0og0gUeEcWXH8I/2M8hhGX6gkRwkX0lEIFM0egPnjqzLbj
         KAnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772045503; x=1772650303;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4oh/ifwivL8l9J8VT3JA58Q6ouuCYd8eO2HrHQHPvGw=;
        b=o2TrDyVdImNtqOJFRofdWSweo7LPyUCFuG56kChzRBpkZvVe0c5lOWmssEmLUDxaqT
         KAVbmE9d7wgwIdfpcdjT5NrUBslW/MBkNvDceTcAKreGa20mw6F+T2E/N45SuRUrkvan
         +hpT9S4hjGwcD0nL4qxr2ICdRYvToxaam2rWxyZ7ZFpmrNPFb+WflUCav6i+4w0vkfIw
         PQctRuewMQ7AWn6udmbs0dO7Z7fme77pSWiG13medR3Jm5dWWGDVLgeIGGLYVMLYGbXZ
         82Ys2N/FGgvx5U8FFt5xkodUVVNyHAqqJ6cdc+aPSoq29sb+TjWRiqkDZScTCOLdD9qA
         16TQ==
X-Forwarded-Encrypted: i=1; AJvYcCWjjCQIeMIJ77qE+xBUwBNpxBZzdiiDLSkk7/00kTNV5+uXKjA0b0Fbqzii3swFoCaGUghwjA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxyEgB5qnN6fZRMoCrATaAgs/dcvOH5s/+AD/SdE/maca/JsuFk
	XNh4umNOIU7FPmg3LFsUMr8R1A+CmPbNqSnb5NDVd53xP85sN0Hf3mHlG/1SrXY99chgu/4x59v
	gW/X4DbVwQG1+43VmQFN+zd9RR+0SXnF1gi2wzAs=
X-Gm-Gg: ATEYQzztf3k/DUxPt7qhpQjFmL2tRsdZgAlWmdlbmdOuXbCxGiVLurYO/foSck4R+Wn
	6Jj2etBIVMM+Gu6RbUfGPuy2zD0ljOT4iH8ABbGlMw+/h23us4+Ns2x7607knt+sLZH0Lh1vMZl
	ummxi4tj0n77o4KzBQhVcGap2bcshe+aIaqmyXaAt0geZ6OHnNmLR7MHTwS3zoTpsMYgFhw21AO
	EB9ZfpEdAuDQ4ZcVAuVSEfD1HzjD2EyzjB5ccxmkgFHxLHyyWD3ULs1lIhBgQCxwDudcJ95ABvA
	XVB83xMtUNyDWH3Z4xdeB+B3KGlYlUQ2dFBE
X-Received: by 2002:a17:907:6094:b0:b93:3792:4b03 with SMTP id
 a640c23a62f3a-b933792588fmr385769366b.32.1772045502705; Wed, 25 Feb 2026
 10:51:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260225-dma-buf-heaps-as-modules-v1-0-2109225a090d@kernel.org>
In-Reply-To: <20260225-dma-buf-heaps-as-modules-v1-0-2109225a090d@kernel.org>
From: John Stultz <jstultz@google.com>
Date: Wed, 25 Feb 2026 10:51:30 -0800
X-Gm-Features: AaiRm510JicR5yB6-6HzIZrjZoL6Jbi8o9bjBsqrkrZBCAWaavoCU9peMfkjjyM
Message-ID: <CANDhNCqk9Uk4aXHhUsL4hR1GHNmWZnH3C9Np-A02wdi+J3D7tA@mail.gmail.com>
Subject: Re: [PATCH 0/7] dma-buf: heaps: Turn heaps into modules
To: Maxime Ripard <mripard@kernel.org>
Cc: Sumit Semwal <sumit.semwal@linaro.org>, 
	Benjamin Gaignard <benjamin.gaignard@collabora.com>, Brian Starkey <Brian.Starkey@arm.com>, 
	"T.J. Mercier" <tjmercier@google.com>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, 
	Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@kernel.org>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, linux-media@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, 
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 25, 2026 at 8:42=E2=80=AFAM Maxime Ripard <mripard@kernel.org> =
wrote:
>
> The recent introduction of heaps in the optee driver [1] made possible
> the creation of heaps as modules.
>
> It's generally a good idea if possible, including for the already
> existing system and CMA heaps.
>
> The system one is pretty trivial, the CMA one is a bit more involved,
> especially since we have a call from kernel/dma/contiguous.c to the CMA
> heap code. This was solved by turning the logic around and making the
> CMA heap call into the contiguous DMA code.
>

So heaps-as-modules is common in the Android kernels, and was
attempted to be upstreamed long ago:
  https://lore.kernel.org/lkml/20191025234834.28214-1-john.stultz@linaro.or=
g/

And it got a fairly chilly reception, but maybe having the additional
optee heap (as well as other proposed heaps) might sway folks on this
now.

There is also the kref bits you might need (which Android still carries):
  https://lore.kernel.org/lkml/20200725032633.125006-1-john.stultz@linaro.o=
rg/

thanks
-john
