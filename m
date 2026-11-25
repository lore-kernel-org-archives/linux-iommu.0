Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.43
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795607536;
	b=RsTQOm+3UibmMxF/k2Ae4LtKfQGsepGbMDu5x/hZSixnAamwpx/jOQ9/IyjKeJutgBru
	 DzpAT78wBpFgJiUkuKIjBEjXxoFjin50u5aYMvCu3TuyITHWg9f9uXBgU+ScQmMlNlrJA
	 5UwJ8m9hl15fWpNJeebU9gwqlAwIoQD98belHwJrTn1P3+ELRmzkICAS3c5BfJBabZRqI
	 Ds/c4GusroXsr09HRj0iaIMCigCTkfauaZgZGcYW2R0AxAPZHbNQdS2diR/mWzbThPVV6
	 a2X6v7T14XFPQxaa98Yg38PTrhl4PclS5iJjR28704iGI66SMOBeMB44OXaxwY+ghbw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795607536;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=JiTLwnT8J6kdyIB5NBxt5frLTB5XA5RQrMtJGgcHBbQ=;
	b=LI9u7nunVpR4eMps3+u8wo49qwPTRvegNrT02cKWA1DY3IBai0v7ADVztiqXmZaOgN7p
	 0NBuIhJZ7b+wUP9GVcDzdVw+noOwN31RtmGio516l16t3LN7nU3O/nbrQ1NoNf+LcRrP6
	 s71zmVe8n5Dm050toeFmpF2c7JpR/Y9JHQNwqXEjgtkE9IASbI5OpDU+SWEYY3dEny0pF
	 ovnKIzVH4gnAUnhjsD1MKaS3gfo84mMHGE8/+b+x9Nx0DcZOnZN55ha4xV2f8md2dvysO
	 vQ0VFgAguVCjzU9feeJe9HT+mGJMw2yk89DY2+hDax9HmMMCbcD9LAOj1/CYr/9oTcg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wG3m4svQ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.43
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61F05606A329
	for <iommu@lists.linux.dev>; Wed, 25 Nov 2026 11:52:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 61F05606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wG3m4svQ
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-6b86bbce3d1so7646036a12.0
        for <iommu@lists.linux.dev>; Wed, 25 Nov 2026 03:52:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795607535; cv=none;
        d=google.com; s=arc-20260327;
        b=eg7xc2/iuGF0evyV5xSCLY1B+IuQQS9VaPRZA8AiTx2k7iw92/3IMybFWC7o1v4BgP
         FH2PQnI2QfAc8idJZZI3uqn7JYhbx9pRTp3hCvsvFKvWSgoVcIqI/0/YP12o0R8HwJmm
         7//TEY2G+wHsBZc9bI5WxhN9jHg5LdllopLw7xCKiwFtVjdS4Zc0n/jzuaDQOWLuE3fM
         FOJgNB/mr9x9U5gI0fLgsWt387gU/gQdLVEMA3n0PAmXfia3k609A7ViGxlX6jit3pKY
         uOS3J+0NsvjHQ0UwVh5mvAh/SnYd8gqF0uSsqHauxfCc2YxaOMPX5vJrI4NV9bLRrrDh
         I3IA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=JiTLwnT8J6kdyIB5NBxt5frLTB5XA5RQrMtJGgcHBbQ=;
        fh=j0YtO37gWnPGdA2lehhmB5R8oj5RCPDIAC9lIZD6wZE=;
        b=mh8+3XSaJ7RyzXj08NPBN4awxqRDzJljxf7riMaQBIhXRtdrXEU4Pws9EnvF22IquW
         wnApW6G4uLhpjsXSqbTfGAKYYp11KKl9/06z6PcEEajSOJrsY5i7EgqaUKaY/qAtxipx
         dY+fDoKF6qY4wF1dbuX+WPBxdJlPMqgan+LugtVx9Z3W8Ck8u7gqSQ+2rgJmqV948jqc
         ijq6Qy/IyE3TjvtC8gSKou/EpF23g+A6vm1bBwC3Un3AcJ70W7GeNRV1MNmmmndklgyn
         2QhEhatjgv1Hwba0IZrOjGK01MGOSvIGPn9NeenfN4VGlXnh+3dJ+KmIj0K3e1BP983l
         eETg==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795607535; x=1796212335; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=JiTLwnT8J6kdyIB5NBxt5frLTB5XA5RQrMtJGgcHBbQ=;
        b=wG3m4svQmUgQQFs+PGXPgJr8qcoLBRwBAQXsl6XNfZB2VYix2EiLEX8jcHHsiv6Q/R
         2EAraNEqahzk2SmdRUE0AO8M6YK84bZmAi85AG2Wbgo2llD+OXU1Dk4rF4fik9S9cGBw
         xzQV3pk5UoNdNKnLxafZOK7fI9rcW4TmBCiqtBFA6PYMyRn/JK9CUHfxORRQrDOWzRD7
         Zg47Vu6gqjAbcpG//Aw21e2mmG2EOyCLCzgfMOvEX/ZYy0ttxgLaxLVe5KE0qs9Pyy/c
         BF+11Sj9McciVWlIBZVUCXAvBCZZ1YzNxybiVsMI9dcoRWiPD9mFWbWbbIULQ7sr14TC
         zu5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795607535; x=1796212335;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JiTLwnT8J6kdyIB5NBxt5frLTB5XA5RQrMtJGgcHBbQ=;
        b=UqANDyG2sApfPmZSVwd7lpt1FsTvHZ1hgi+Et0M/6K/LamDVRK3DbiOVhaIPgrjSM6
         5j0cnvV+htK3IQJjRLk9DZauPA+AMDr2w2TxqJkfXBedKg3m7yGz3q3pLAvEb/qV4kxZ
         hhWQMBUD2ypZpLv3z7yBum82gmrcw3KxoUK8gm51vvJWTmL1hUb3CskRoU/IDaOX6jGK
         7bKejNqlACutYQGAuoThTkOWObdZYV6JiX0+HlcKWQq/kO4E8IqQk1X9YIMikdk6Z0xN
         KXNFnzOpK1w7sLcon0i1RyC7xBmqY7BnxAvuu9FXXKSIbCydErNkMk+/NcoSIIUBtA4s
         vDLw==
X-Forwarded-Encrypted: i=1; AL+hErHYUOYq7HOoGLfxO9az20nW9DC+h9caPDfrpBZBAgwvYcE6iR8k5jUELl3cx4yf3tt/QgGTCw==@lists.linux.dev
X-Gm-Message-State: APuU4Z8KFxvlbbzpBwDOt8FixZzJQlEAE6io5+JStDR5puj93HYuVdXP
	5JsSFQYsTE4IMJi23xGSozbKGMGTKHIL5ohL0TkWG+NvLfz7hDt/92Uo1ep4ojYC3VvuGOzbtPd
	TL+eAUN5zBP8VXw8GfIqPOy0Mor8SgFc=
X-Gm-Gg: AZFdTZeBUWTuEIo+MJI93DgluIF7yDzjHKw0JbyjvTFtrih5Z1oGX2OM+pPCxmSnu9H
	fmVS8Ced6SY3Zdksi0mjDw9q20Pl44sdL1PKS6kQpMRhdAaWVLcEk/jYgjzpgwFxwXcA731R7ob
	dzJrJCPKOiZ0KjeeAD1+eo6BtuX80WtOm14nJn34JcYy49ZZpgP2b9B+WfNBLBMGQuPuWmk19dm
	OTX379T1K+ai6XFGo3+2C2yESxWSe10tZFYlZU9ovnn5d9fNDwozWIYdodbxG9LXv3Xg+x/Fmnb
	VOdNY6QUT2nZ7MlEwc1OaRe5CV5wu1809IwcIWnF9S9QgUv+yDNNjA8mzHoEDIMT8yywN81hoJm
	J2VH3MbNR31xk9LLmjILtbgGEtvpietJgO6wMx9BswqQ+B2wO/gu6vIr8DzyYQe7Gq6iVpg==
X-Received: by 2002:a05:6402:a592:10b0:6b8:8706:8e91 with SMTP id
 4fb4d7f45d1cf-6ba37d6526dmr10123892a12.12.1795607534606; Wed, 25 Nov 2026
 03:52:14 -0800 (PST)
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
References: <20261115103809.1288167-1-linmag7@gmail.com> <20261115103809.1288167-3-linmag7@gmail.com>
 <awVzJMLVw4wUSqky@monoceros> <CGME20261124232303eucas1p10f2da7a94c8aa19fa4e406d089c1367e@eucas1p1.samsung.com>
 <CA+=Fv5QJxoxEoKxRpm5Hisdf=y+VpmM-s_VBC1tDQ2FTCfb08w@mail.gmail.com>
 <3467269e-9929-4c9f-bc19-847976f49527@samsung.com> <awa6Owm3eDW3EitJ@monoceros>
In-Reply-To: <awa6Owm3eDW3EitJ@monoceros>
From: Magnus Lindholm <linmag7@gmail.com>
Date: Wed, 25 Nov 2026 12:52:02 +0100
X-Gm-Features: Aa3M54p8sDF24v9l5vsIDk_y4hlZnLV9zBkxaSf0Tu8Y_d4WDzlfpPV0l4Su2os
Message-ID: <CA+=Fv5RttOgZp9vftYN2XfmV31TyC_o_eSejruM_bbf6v7zfBQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] alpha: enable contiguous memory allocation for
 coherent DMA
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Marek Szyprowski <m.szyprowski@samsung.com>, 
	richard.henderson@linaro.org, mattst88@gmail.com, 
	linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org, 
	linux-next@vger.kernel.org, netdev@vger.kernel.org, iommu@lists.linux.dev, 
	joro@8bytes.org, will@kernel.org, Mark Brown <broonie@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Uwe, Marek, Jakub,

On Wed, Nov 25, 2026 at 11:53=E2=80=AFAM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@baylibre.com> wrote:
>
> Hello,
>
> On Wed, Nov 25, 2026 at 09:54:08AM +0100, Marek Szyprowski wrote:
> > Hi Magnus,
> >
> > On 25.11.2026 00:22, Magnus Lindholm wrote:
> > > Thanks for catching this and identifying the interacting commits.
> > >
> > > I reproduced the error on next-20261123. In
> > > arch/alpha/kernel/pci_iommu.c, I changed:
> > >
> > > page =3D (gfp & GFP_DMA) ? NULL : dma_alloc_contiguous(dev, size, gfp=
);
> > >
> > > to:
> > >
> > > page =3D (gfp & GFP_DMA) ? NULL :
> > > dma_alloc_contiguous(dev, size, gfp, dev_to_node(dev));
> > >
> > > This fixes the allmodconfig pci_iommu.o build. A full DP264 UP build
> > > with CMA enabled also passed, as did an object build with CMA disable=
d.
> > > The full allmodconfig build hit an unrelated cgroup sample error
> > > involving PATH_MAX and LINE_MAX.
> > >
> > > I'd prefer to keep the Alpha tree independent of the DMA series.
>
> That's up to you, but in my eyes merging in the immutable branch
> provided by Jakub into your tree (or rebasing on top of it as suggested
> by Marek) is really the easiest option. That way you don't have to wait
> for the change to hit Linus' tree and there is no further need for
> coordination or others paying attention to not create non-bisectable
> commit graphs.
>
> However looking at the immutable branch I see it contains both the dma
> API change and then separately various adaptions to ethernet drivers.
> IMHO the immutable branch should only contain the API changes (that is
> the commits up to 31f7e12d621b) to reduce the amount of possible
> conflict.

Thanks, that makes sense. I guess best is for me  to rebase the Alpha chang=
es
onto the shared DMA API changes and update the caller in my CMA commit.

As you point out, using only the four API commits through 31f7e12d621b
would avoid bringing the Ethernet driver conversions into the Alpha tree.

Jakub, Marek, would that commit be a suitable immutable base for this?
A separate stable tag at that point would be helpful.

I'll then rebase, retest, and notify Mark before updating for-next.

Thanks,
Magnus

>
> Best regards
> Uwe
