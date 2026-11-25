Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795603985;
	b=Ft5HIwYkZvIAfzZfNwP+XUh2G/jpPsKJ2TTF6AAsLh00fTWl1yiSF+dPXw1TIsb/XopI
	 3yRjeziCN8/RNtc98IkHl6jFDIz6/i9v/yP/dPZqmusNjnhJoGG1ourxN1URpcptXVHs1
	 5J69sT4iwtt+qb9TqFe9ednyUFQ2taMvwuX9jS6keVQ7ASczAmzU4S7w5EF01bumMdgt1
	 WqedyyfKLN7u++AfQlZHNP49ho/9bD/hEQc+mB0yEzt/f9rrMlJzoFKoFLAcVYfYCjPZz
	 zcWtFMN9ZlPa7BA64LGSskudW9uABaWB3OAl3R+9r7QJYxVArIFIFZjl4D8ahfMcEWg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795603985;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=GtyqZEMexnqUKbDqv2TlW/7VEDcPuxK4TtntSukqHfg=;
	b=dwtUOEi0tyXJLVyXjxyOkxZRIuKgVco5MnvKJdWQ461i+GKT7cYk4MnLWeKci2vcMKEI
	 MZATWW/1lB2m3dkjGMSIONgMKKaH0ed5svMcDfgH3Ugq4iBO35P8S/CFcbMG4PiTu+WEt
	 6PwQ88wZxVJ/HwPa6stIgE1WNg8Gtgh97FuosGo95nqFPVHKuJNQnoqd5+auY2JW/VS8H
	 VXADke9PXLkQdWCOlRi20TqLz0F7+BwrGEUzVY676Yd8oLVPwymVwZUsuAVzbU9e4t2Ef
	 lo8TUi2yI6a/QGeTtibLtFDOhfMikurgdU2wJBWB3jK9IyuKfTTX19tOJjhFJatvl5g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=baylibre.com;
	spf=pass smtp.mailfrom=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=ZNXIZbyN;
	arc=none smtp.remote-ip=209.85.128.49
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 824E8606A32A
	for <iommu@lists.linux.dev>; Wed, 25 Nov 2026 10:53:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 824E8606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=ZNXIZbyN
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4bb85e07aadso69445025e9.1
        for <iommu@lists.linux.dev>; Wed, 25 Nov 2026 02:53:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1795603983; x=1796208783; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=GtyqZEMexnqUKbDqv2TlW/7VEDcPuxK4TtntSukqHfg=;
        b=ZNXIZbyNjbI20j8cE6WFBhFIyO4oc5NzfHT5v6sNO83fV1MVaZUEkZGJCRIBqrgqMp
         Mao/j9QAccAS3nHrKLLN/Q6Nom75QQbwKol3Ee8IUtVOoj0mWnC37gshn1WP7bZA6/jX
         k17Fa3nmHYj2LIH2lL7HPIQqdWyEor4AlXyiKrfTuwP5KSYwLYG1kwVoD6v3UYlu0KKx
         AqriTPVgYDueZqgAtxxhLfqi7dwXqfvZzFyJt5WZSbrmAmjdOa9h4oi94QErofmSi3a/
         CR/ZjBOujps3wfL06iW0byXnQIcF+ux2qXe5hO397qsDRT8LtaLX7+l0lHFq2j9xCoLy
         dVSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795603983; x=1796208783;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GtyqZEMexnqUKbDqv2TlW/7VEDcPuxK4TtntSukqHfg=;
        b=0jWrdrO2hVWY+DTXdjhzoY5ZvIC8SxiXCJQ5B2y6pQpSJqTwiMXusS6bh52RUrMefH
         ucxW5/dx8dG43UlMBVnzD6QHKMrZAS3mFIEuGx6nGWjqEjgzT5iMygPkxvveNLo8Csf0
         J62VdyeMM3ZcTORo9KybOsw/8ollotQFjHcJl1qMZh9B3hmWLkj084kZW9bTfjhj7by5
         XdLpXtRsODAqoN+1zKHETYMKR4kDtoDeMXkQH7U1AWzJ0ypu5ahts/eKzRy0H0OGlMp+
         bAtH1iPTqd4LLezUbOXwELbUvu/XXNdEFeNDahn6EJMXUgEd/xyM2PLyinQEgRs7QGSZ
         peTw==
X-Forwarded-Encrypted: i=1; AL+hErGBbiUTHWCJdkaThOy/8JywCZADTrninYWyA40sdT8pfOYIMUIKQQ5wtpJPb7Gzz+Yzp2xTag==@lists.linux.dev
X-Gm-Message-State: APuU4Z+rD9sPyx+R7DxQIiR7oMVHB/+uLBkvt/5OkyQRH7Eog/ug5CsQ
	TGsxOcOd3Wru3USKBSi7/Qnlurdphq4d0mmHA811ZvuuXXrPZcCnaO0k/cBYL3HThyw=
X-Gm-Gg: AZFdTZdeA4iGn3Vh8I6nD18LKEF2h8W59FJ2szcm9DXtohARYqTgwxYMURRDXlsGRwd
	cGrKfAzCwwYU2GaNuBREO9oNrGtgbwuQZhpPsI2tujlaicn8uF60gd7uCaoFYzt+jerrEM4Gh29
	wc9oFolFM9VpexnjmCGVymaKpoIU3iuRj9y3oL1X/B6Sp+MWSxG6R5Ix8tdDnWr1T9tN04gyroC
	7IlmUQo2FXKzK9BoF0Q3yAxbRuDAlhr8L9jHnO7D3S/LjyUKLTqrnhRKo0ptwTVYZRPc9a4HEFI
	g1rR+Tcop1pnOpQSFzWaz3m8t4ym4sF7yYPDm0CNo0DxxHvZ/anIwcL8M6/RLXhxkTc0jelSdc+
	vgusN0HA7Grfy9S5M93t/oTJAVNvH+TE+8SZKkhEv6gB5LuzZo0vC325+WH4WPBDbaHd3m+0WkT
	M/r1hKjWKoC+Nv/IHXCNo/o9gKPTlQFttn0ci7MOdHwTdhD0LK1tNnynH8vm1wZXcCkvYLjmQC6
	8aRvJ3S9NL8/l8aljf11QSf6ARJb5H8CJR9BZdogJ8A8mKnvYec7op8prcnq6HJ8qJyffxwDrqq
	Lv4qnbayP5R5wT+Tff2XDqLHwPf3Y4QDgYnJqH2kkSCZAwR5kUAy5YoqxlAej89y6n3DD0tzfKt
	Fvb398xASEws69ggP
X-Received: by 2002:a05:600c:638f:b0:4aa:2339:a375 with SMTP id 5b1f17b1804b1-4bb8880607cmr329616615e9.13.1795603982845;
        Wed, 25 Nov 2026 02:53:02 -0800 (PST)
Received: from localhost (p200300f65f19a9043ef7230869dfba63.dip0.t-ipconnect.de. [2003:f6:5f19:a904:3ef7:2308:69df:ba63])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4bb853a12acsm539176075e9.8.2026.11.25.02.53.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 02:53:02 -0800 (PST)
Date: Wed, 25 Nov 2026 11:53:00 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Magnus Lindholm <linmag7@gmail.com>, Jakub Kicinski <kuba@kernel.org>, 
	Marek Szyprowski <m.szyprowski@samsung.com>
Cc: richard.henderson@linaro.org, mattst88@gmail.com, 
	linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org, linux-next@vger.kernel.org, 
	netdev@vger.kernel.org, iommu@lists.linux.dev, joro@8bytes.org, will@kernel.org, 
	Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3 2/2] alpha: enable contiguous memory allocation for
 coherent DMA
Message-ID: <awa6Owm3eDW3EitJ@monoceros>
References: <20261115103809.1288167-1-linmag7@gmail.com>
 <20261115103809.1288167-3-linmag7@gmail.com>
 <awVzJMLVw4wUSqky@monoceros>
 <CGME20261124232303eucas1p10f2da7a94c8aa19fa4e406d089c1367e@eucas1p1.samsung.com>
 <CA+=Fv5QJxoxEoKxRpm5Hisdf=y+VpmM-s_VBC1tDQ2FTCfb08w@mail.gmail.com>
 <3467269e-9929-4c9f-bc19-847976f49527@samsung.com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="6sn276mtbb7rvtiq"
Content-Disposition: inline
In-Reply-To: <3467269e-9929-4c9f-bc19-847976f49527@samsung.com>


--6sn276mtbb7rvtiq
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3 2/2] alpha: enable contiguous memory allocation for
 coherent DMA
MIME-Version: 1.0

Hello,

On Wed, Nov 25, 2026 at 09:54:08AM +0100, Marek Szyprowski wrote:
> Hi Magnus,
>=20
> On 25.11.2026 00:22, Magnus Lindholm wrote:
> > Thanks for catching this and identifying the interacting commits.
> >
> > I reproduced the error on next-20261123. In
> > arch/alpha/kernel/pci_iommu.c, I changed:
> >
> > page =3D (gfp & GFP_DMA) ? NULL : dma_alloc_contiguous(dev, size, gfp);
> >
> > to:
> >
> > page =3D (gfp & GFP_DMA) ? NULL :
> > dma_alloc_contiguous(dev, size, gfp, dev_to_node(dev));
> >
> > This fixes the allmodconfig pci_iommu.o build. A full DP264 UP build
> > with CMA enabled also passed, as did an object build with CMA disabled.
> > The full allmodconfig build hit an unrelated cgroup sample error
> > involving PATH_MAX and LINE_MAX.
> >
> > I'd prefer to keep the Alpha tree independent of the DMA series.

That's up to you, but in my eyes merging in the immutable branch
provided by Jakub into your tree (or rebasing on top of it as suggested
by Marek) is really the easiest option. That way you don't have to wait
for the change to hit Linus' tree and there is no further need for
coordination or others paying attention to not create non-bisectable
commit graphs.

However looking at the immutable branch I see it contains both the dma
API change and then separately various adaptions to ethernet drivers.
IMHO the immutable branch should only contain the API changes (that is
the commits up to 31f7e12d621b) to reduce the amount of possible
conflict.

Best regards
Uwe

--6sn276mtbb7rvtiq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmsGvgoACgkQj4D7WH0S
/k7oNAgAknak/QZHg7BqHZFzHCe4qtzYco0MHY20TLpuveFkHfRuLa9UVG2bG0Ww
LQZfbq0hnFip66k6fjmWJ+mGt0QyF7sJj/DpkCtXlI6aQtnnm3D3slJhpH/bWjue
fk1SdxjYh64pzlg1UF9rEJri73sW9fln2Gz2EK1iHllG2Z1XRGwb4bBzh6WpzAxc
AuLAWN7R4PJvFLQ+kNkR4YocW5+EV0RnYb7/i7Fb9ABP1MxCxi+4OM8+uD8MGuGZ
OFggCxgES6vXm2Ostds9EY3vRvG+zs6/ZpyofM5BxVfPInkgG1teIzoXDpivIgkA
C+dJzsR+ixI93VaJu1B++KrDBjHhlw==
=UmCO
-----END PGP SIGNATURE-----

--6sn276mtbb7rvtiq--
