Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7DF31A2C2D
	for <iommu@lists.linux.dev>; Wed, 28 Aug 2024 15:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724857966; cv=none; b=hZmp5j6LK86EJL9uaqw342d9dJoWX+/1vl2NGWUR3CQwgLG8Z61WFMu4SRaqFx0r1ytghMG3L371s56Z/uQ/FpnRkQEuw0NCXvpyFq+wHlDa5xzaAdQLE31PQ92mfWIng7vcN5zRZHavnSaVc6ynOriLFeuzis/KdJjYGvr4rIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724857966; c=relaxed/simple;
	bh=/IyRKuOeEvyqdB4QfYijTcKAfdptVOGW+q1DNzAAB5Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pJaP8C5JFLlZgL8yM5ZJdpAX4tOF+OdtFxWDcoUyFUTOrQnJVYK6Ay3y9PaKCayDy+wPGE4pp46kg2ngXVSE91f5gPzJSdPS3GR5NOSkrk2AQmYEb20JoVCr55NKZeXfER+4YxpK8Eamxg740iEBhq/vMPhtPM2/ENo4qEay29s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LTgETd2b; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LTgETd2b"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-428178fc07eso57779475e9.3
        for <iommu@lists.linux.dev>; Wed, 28 Aug 2024 08:12:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724857963; x=1725462763; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kbaH3V7Lk+uax03Oqau7bBE1nBYKOYJZ2EVryMzrRy4=;
        b=LTgETd2b4DdYbJJ1ztAP7iEDw5KYQDf4GkNHW7jSfgmqMCgY9dr+vXnFyWXVGOP3Og
         08Fhix3rJkOs9WvcIpvStd+gJOqNJsJwAP3gq9pd7VbgJJ+aae3ufJhhX87ynAd76or1
         dGZnukpzf0v6hy8E2irdiW7FXRUAuzFq4x+sAztqiNwaMi9MOphlzMwQddI26PNlnnuK
         p+4KnsmhOsW9E4AB1NWTKRsx/TKorU1xpU18g6/THVi4+2uhMXbC7UlpDSvetfrO5Fyv
         1GKwAASEJIC5aGNp0OOt58x2GpONyqVtC15CZg4R/F18CqM1Ol0uuEWlhh+p/ezU+QeT
         r7Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724857963; x=1725462763;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kbaH3V7Lk+uax03Oqau7bBE1nBYKOYJZ2EVryMzrRy4=;
        b=AI+C1S0WIH8ZeEvulEZ4xzalHn8r2gAnWwLlRo0DY5wPKp6abO/8KfhBXRxg7EDbPQ
         5dNkhB0TV2WF876PouiolAQ3EzAisTJ6WWK8SCURPVLxg5ZFHqJT7NDxFZq2LBP/WpQ0
         LjPU/ORKnj6DUblikVwVZwVQEwaLPxKkO4WeEyBChk+P873unBk1t2+Yybn1DvM2bVh5
         n0WhB2yK9GeKQ43e7I7D3xtES/ZNBxRjPl9BL+wfJWj3XLwOzm56duJJks79m3XDFlW9
         JyiHnZ9fyLwcIfEg38afeo1ycn3bkwDKZFmNmf91cTnf6QR+4/FNcAA9S5iV3GULBSzS
         UycQ==
X-Forwarded-Encrypted: i=1; AJvYcCUeTAxnbK1o6EruG411JjX29itZ2M1/UZ77GIzQELqibe3+pc/wearT6zlK7SVVfCcukyxpkw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwCSHXQ0X5NhED8kBk/kLN707EW5q+LyNzHsNI4g6/YvC4O19za
	VxuhYhyao7E9DSyJr2kFowqBiTcx+R8P8Ii4ksiLu5OX5pFU5Okd
X-Google-Smtp-Source: AGHT+IGQW0+v8moibSdO2Q/RDfDjaFv/WD0sbqLqA5iBEEKPuRh2zkLaDWQrYYlWkKTTw2QwiUONiA==
X-Received: by 2002:a05:600c:310f:b0:426:51ce:bb14 with SMTP id 5b1f17b1804b1-42acd5d79b1mr105634055e9.30.1724857962403;
        Wed, 28 Aug 2024 08:12:42 -0700 (PDT)
Received: from orome (p200300e41f29d300f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f29:d300:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42ba63965dbsm24684245e9.6.2024.08.28.08.12.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 08:12:42 -0700 (PDT)
Date: Wed, 28 Aug 2024 17:12:40 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Mikko Perttunen <mperttunen@nvidia.com>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, Joerg Roedel <joro@8bytes.org>, 
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>, 
	dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH 1/1] gpu: host1x: Use iommu_paging_domain_alloc()
Message-ID: <5bckndhbbvbvkt2bqxseyeo43qzvy6h2oykqbkhnfrpw7zjwu4@ziztccfxccv6>
References: <20240812071605.9513-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="7mk5vwuaumccccci"
Content-Disposition: inline
In-Reply-To: <20240812071605.9513-1-baolu.lu@linux.intel.com>


--7mk5vwuaumccccci
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 12, 2024 at 03:16:05PM GMT, Lu Baolu wrote:
> An iommu domain is allocated in host1x_iommu_attach() and is attached to
> host->dev. Use iommu_paging_domain_alloc() to make it explicit.
>=20
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Link: https://lore.kernel.org/r/20240610085555.88197-8-baolu.lu@linux.int=
el.com
> ---
>  drivers/gpu/host1x/dev.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)

Applied, thanks.

Thierry

--7mk5vwuaumccccci
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmbPPmgACgkQ3SOs138+
s6ErLBAArXWV8KB6676S4Mww6EFpvjmqtdeUPZADFF5+D4qAXK+eqPe/rprOAwCd
6+tCPTAkEGrym0m4qeV44txjQOtxEM4a+YWx6WxQfCYg+oprDa/jtEF+ysICSiwe
3fJRnrb16N/fFTaEHub+y+gAtr1BlhHmRt+zZKyNv7eCfM3tk5sMd6WcR8UCp/Ey
zBFXXmcC5ugNsZtxITQWGcHaY6dotmlkqQpRq41NMRr4tSnJgmR3z0PwCVftt23x
B+agCPY9txwY+vSCIwrQ/zQwP924utFtkf2avxSLhU8E/RabXCJFUtbKhe017SJC
mNw7Ahz2a5QHaXKTjNCrO/xczR2i9RK9VOsJUgOl85zQEVE66XoFzMlkpKNZZKze
B5jMd5Lm19Cqpl2wTRgqK5B4oulDKgwkusWOXuPTFZjocpKOzW6SsKzrmy/+/Ie+
ICZNIv3Op1m6Bc8rK5WWHFYsY7584/3yDqmpI9pb3JeB9+VMU0UCEz7bNBHTZCAK
kcj4LAOzk9oSvlN2h1oUBQzM+3tqh4v7Y++VVJxPi8ecNbgXekw8V76uKW0iKz9O
uzq198fgfG0P1TvN15AtUueY3d6J8lGZuVH8FEphvkNagj6+x/dx/dJW9tu//poK
Y8pQfxFEVSY4oC8gRlgIPwCEgFCSWKRatLXAokmYvhy3IRNc6Dc=
=cWHB
-----END PGP SIGNATURE-----

--7mk5vwuaumccccci--
