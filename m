Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06CC981AA3
	for <iommu@lists.linux.dev>; Thu, 25 Apr 2024 09:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714036420; cv=none; b=fqFU/FhUk4pyaJEwJida+N75PO+4WF+LbmDZ2aiVBA8kwTdLwiQeuJivTncpRyLjwzfmujdTiqVRo58aeEBbDHtZaBhBy2MTBUtN8mrwCEqmJ2etovuRrGxLzDPTpB+PaXtyVeBFK6Hvx/FIx8dtTmkCtlV/UkuL1s99bEpKFI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714036420; c=relaxed/simple;
	bh=eobe3x7c9CyI2IUIU9H13+fYzPpeASRF8Xdxx5XJjYA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BisDirj9ebqHY5F+piGC48z9ZdLI2u7C+mBePH38kfwQWxsfwHNNeFGGbDxnFZzxv5rR2E/bg8GdgRE3kiIkv7J5R1n/sGbxV2EQu1qw9aN4FR4M6nBUx9uwrb0o+hvBpPVAo8UzMUl8qPrkCjnEuMV2TJeizvYDR/aJK8VjREY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vwb44/ng; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vwb44/ng"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-6ed04c91c46so784393b3a.0
        for <iommu@lists.linux.dev>; Thu, 25 Apr 2024 02:13:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714036418; x=1714641218; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eobe3x7c9CyI2IUIU9H13+fYzPpeASRF8Xdxx5XJjYA=;
        b=Vwb44/ngs3MtJu/Yr2l20mfWTaC8suC5F3f88pGfEHQO9/9vjBIrT4Cl9OP9/1aNVp
         vI1f0NeOBzlS5V++NC51aCGgluP0ZA4jzQZTmUT4pXrusUt46S6eB7k7pJWDm7DxUJFW
         zw7OM+H04wlnlK1H30yJj2v7N+uc+2x2u6gqeykwqDYw/lggJ9Sv7jh0le45QMjdtiF8
         8j/GXZF41KC9ziuUYLzYb8bqtyyGPkwvb5B8+6LkoJ1GyfCutycZNKOrszQKDNX9nyId
         QYolWWDoNLY8WJIyrMIZQUdxi3Mp7G+oUcaI0JDV1ZW0QzZ6tJvFFAzE7kiOg/f4y09u
         wOug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714036418; x=1714641218;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eobe3x7c9CyI2IUIU9H13+fYzPpeASRF8Xdxx5XJjYA=;
        b=sPbhQH2vsNfICOGS3Ug3Hr7kmJbVMIz8gM/s/yx5alx1c2I3a//8L+wtwY+An4SCR8
         WrfuBdvLLgvsRBRFCBSIZ9WHe4xAR+nY3PzPTrJywAWlOXyUehekZxzVoN/YKhg1UU3s
         1JVyDjoX4VcI8ulqBGf2+hnfEePHSOBzWFa7OG8MJ+qBj9dUkiUE+FI7qW3dg/dVqdRk
         zQfhS7ul2D1hm+kf03jeBWBnhIqNTEpZFLR38fHADI6zni5Bwm3bgqhSjlHRELnFrWBV
         4obqNX/7CA8Mt1wJV03fbpuzffrwzGQRT27aeRQoBCVFRwZi0U53uHFrUEadhthveQ/7
         FGkA==
X-Forwarded-Encrypted: i=1; AJvYcCXaTWjaZ1lFpSAK7wps+RLOoOyWUimMaa1nMkp0jeZ9DFwBECoxxaomR0QmvyTDyoXu5NzlFEDWGVls3OwgT2p/XtvMWlo=
X-Gm-Message-State: AOJu0Yy/iioOUdNQM8FSQx0vuS49Lrc+tuPzLRmw4iL9iKmyjg75hSS0
	BPIM0vSrsF7x9wIkRasvyvL45/H5TLbfPIoNaX7tgOKDEwoJpckVik/qPg==
X-Google-Smtp-Source: AGHT+IEcl6IzLLKiM9OnGHl9KJWuISOkQx1HFxAPlzz5abY7e+KR16xrC66zK2tX4k7qPamThBER9w==
X-Received: by 2002:a05:6a21:350d:b0:1ad:8334:df97 with SMTP id zc13-20020a056a21350d00b001ad8334df97mr5611859pzb.5.1714036418263;
        Thu, 25 Apr 2024 02:13:38 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id k124-20020a633d82000000b005f7d61ec8afsm10854365pga.91.2024.04.25.02.13.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Apr 2024 02:13:37 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 703DA1995D6D0; Thu, 25 Apr 2024 16:13:33 +0700 (WIB)
Date: Thu, 25 Apr 2024 16:13:32 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: mhklinux@outlook.com, robin.murphy@arm.com, joro@8bytes.org,
	will@kernel.org, hch@lst.de, m.szyprowski@samsung.com,
	corbet@lwn.net, iommu@lists.linux.dev,
	Linux Kernel Maling List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>, petr@tesarici.cz,
	roberto.sassu@huaweicloud.com
Cc: Mao Zhu <zhumao001@208suo.com>, Ran Sun <sunran001@208suo.com>,
	Xiang wangx <wangxiang@cdjrlc.com>,
	Shaomin Deng <dengshaomin@cdjrlc.com>,
	Charles Han <hanchunchao@inspur.com>,
	Attreyee M <tintinm2017@gmail.com>, Josh Don <joshdon@google.com>,
	YouHong Li <liyouhong@kylinos.cn>
Subject: Re: [PATCH v2 1/1] Documentation/core-api: Add swiotlb documentation
Message-ID: <ZioevHI3wok_yiSv@archie.me>
References: <20240424150253.560999-1-mhklinux@outlook.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="6+EK+eavKzI6maIW"
Content-Disposition: inline
In-Reply-To: <20240424150253.560999-1-mhklinux@outlook.com>


--6+EK+eavKzI6maIW
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 24, 2024 at 08:02:53AM -0700, mhkelley58@gmail.com wrote:
> From: Michael Kelley <mhklinux@outlook.com>
>=20
> There's currently no documentation for the swiotlb. Add documentation
> describing usage scenarios, the key APIs, and implementation details.
> Group the new documentation with other DMA-related documentation.
>=20
> Signed-off-by: Michael Kelley <mhklinux@outlook.com>

The doc LGTM, thanks!

Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>

--=20
An old man doll... just what I always wanted! - Clara

--6+EK+eavKzI6maIW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZioetwAKCRD2uYlJVVFO
o3WBAP9d21rIomzf/1Ba3BKC836P2zEVgmENMEMVr3xzUNPp8gEAkEaSxCqc4bbC
FbUDRlMjRROKs/jYO2ln7Xxgto0xXQ0=
=uLGe
-----END PGP SIGNATURE-----

--6+EK+eavKzI6maIW--
