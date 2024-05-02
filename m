Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0303DC8F3
	for <iommu@lists.linux.dev>; Thu,  2 May 2024 00:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714610813; cv=none; b=eq07cCyrcN5e4Dn/VHvrhid4AlCb0ZjEnj7vbQZC1s5qE/Y06+TXENFDpQQQMPHDHAlavzFjDDaIb4ZPi/pWn6zNsKwscfzNELcSnIjHvyK9ye6hUD+FUwM/Hqo+LroYriw5edD2ZdrSHlfQTi1AojZVO1fVEt/STu47JKcxY2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714610813; c=relaxed/simple;
	bh=r6vRcnyfra/XvQVBWqFon0COqo1Zoj1iroQVqm6E308=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RyX2fhrJuGWwlucDRXRlUP4oQlIbFlZqsHfM1510JJT53CXRELKD9gSoqRo5d6nRvHS75esHr3FuYd4UOEH6+DwECuej5E6qmp5C60Rq/i8qQ/PEPCAZKM14ufM3B4+CBM6/jKIWzHt/x+zOwmy6jQdcL+igj0rC4sWpvQlgXT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l0ZzSmqS; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l0ZzSmqS"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6ed627829e6so8665861b3a.1
        for <iommu@lists.linux.dev>; Wed, 01 May 2024 17:46:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714610811; x=1715215611; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=r6vRcnyfra/XvQVBWqFon0COqo1Zoj1iroQVqm6E308=;
        b=l0ZzSmqSwmEn3nSHzsj1s6J21+55rNECmujW3lwCa5cKjuMVSboiPaEcW2fsmy/TsB
         Yi9ULUANdd81Qaie6f6vOn+/WP7emX/KIfn3Pe/xUFJvKwTBNmw+R8wKAqIcje21k44l
         VKFt/1QEDL7zphmPvuMOECnLrlnoRoqlHSC5So2S0Kwbu7c3hlf5aCyLCJ1Yw9zzB1G3
         NDEuT8H66EOwCC/DFtbLSpr2d/WIVP9zs/k0V1Lb1wtrZWTAgEcCqMrLOfLQlVP7fU01
         hqjhSoHkDPXHrXGUyBOc02n9h2AnPGPS6Myv/0LvgPPa3xqpqR2ay/WRSFAG3d8SOWca
         Pydg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714610811; x=1715215611;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r6vRcnyfra/XvQVBWqFon0COqo1Zoj1iroQVqm6E308=;
        b=I5cC3TA5zgvl7IrU51/cbOTz80olkpGwyzt82bCmWGVjU5uVsLiirPJnzSqt6dnV5R
         gY4k9mscZbEqjTmzNuDqtXr39nPeYK/tYCVD8HbUhQ7g4LZkXoC7DydMuYOwADjv7RVQ
         PsJFC5aRcnFeJjI+MhCOcxX+4j2ldcbcmmBokm4uk8k8+ucjlkq/+ZvYNbYmgAxCYQqx
         kF4VuwK+ULjO1OK+g8sbU2xpENUZ9AYRcc7MZexAsuF8i8vWMt7ymZadpu62t/nCQUiW
         5sZN68PEQaGfOkYopd8XPFc9/wZDykjtxn2+7i1tByi/dqScJLTNA/p582YGF4ojegO2
         tQLw==
X-Forwarded-Encrypted: i=1; AJvYcCWhuyeVvIK8c3C/FdJ9TrAdtr8a1PQ7cDxAcnbi79xAbP2a7CdFwkEVPdwGjxlhKbxsXMqRjq1qIwX3zRvkZmruwHQvdRM=
X-Gm-Message-State: AOJu0YxaIbDfYQcYZolAckeQKojUFb3utqnZs2emX6FV+U9tO//qo9ZX
	MJ4W+Sdrypa16Z0Q+UO6OOeCb/jFdkIJGLEVpNajrxkSQSBw0g1N
X-Google-Smtp-Source: AGHT+IHwU4/61QY/W4PI397ZvWqj9/LHxy0c+jQK8AspbpBzjbs2tbF+eYJN0yoDRgWGYQujUcR60Q==
X-Received: by 2002:a05:6a00:1ad3:b0:6e8:f66f:6b33 with SMTP id f19-20020a056a001ad300b006e8f66f6b33mr4870989pfv.4.1714610811128;
        Wed, 01 May 2024 17:46:51 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id x37-20020a056a000be500b006edcceffcb0sm23225000pfu.161.2024.05.01.17.46.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 17:46:50 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id E24CA18462B26; Thu, 02 May 2024 07:46:48 +0700 (WIB)
Date: Thu, 2 May 2024 07:46:48 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: mhklinux@outlook.com, robin.murphy@arm.com, joro@8bytes.org,
	will@kernel.org, hch@lst.de, m.szyprowski@samsung.com,
	corbet@lwn.net, iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, petr@tesarici.cz,
	roberto.sassu@huaweicloud.com
Subject: Re: [PATCH v4 1/1] Documentation/core-api: Add swiotlb documentation
Message-ID: <ZjLieHFvjlTJrCUM@archie.me>
References: <20240501151651.2912-1-mhklinux@outlook.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="xmC8L8lm/UzjLhNP"
Content-Disposition: inline
In-Reply-To: <20240501151651.2912-1-mhklinux@outlook.com>


--xmC8L8lm/UzjLhNP
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 01, 2024 at 08:16:51AM -0700, mhkelley58@gmail.com wrote:
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

--xmC8L8lm/UzjLhNP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZjLieAAKCRD2uYlJVVFO
oxauAQDt9V+aVqf0N3EOJm2WLmYhylB3nbvQWXzkMfVxhz7V4wD/Uge4eZdVPJha
nkCxgxnQOBxzAnRSJPmMohaEeSVNUAo=
=IKGL
-----END PGP SIGNATURE-----

--xmC8L8lm/UzjLhNP--
