Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0198D1D6BD
	for <iommu@lists.linux.dev>; Wed,  1 May 2024 07:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714549197; cv=none; b=YdXXIDNOELkKhkLfWCzok9QbNUmvpFesmuPXKpnTEdYB+PIVOhxCasr3l04CFGanNb6BpcKTt4JcuNUXr/yGMYBadSB17811y3LdTsIIN74fG9ifFGOjm8+/17eAGR9USaXunDat0oTaqeIB0GOnJmdtavx/TeHI9rqPOvvLSU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714549197; c=relaxed/simple;
	bh=5eWuGHYXfyJHepRujiagDpeV3q8qyo9GkPxVCzukQy4=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FkxfAegtczwnIfz2Swl+O3l4o0gq8NDXpKaAAGX+AgO7cC6/YcSo+nDOQ/JLiUdU8w0wXBjLI2UFFw9dn9lT8FHWs15X0j65sgk0zZugaUpsQIYIGiRrQorsnRwVc17/ie+sFUB0muLLEtUYvtqDWI9UtwDVjL4iVXwcZWZskzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=inGayvyJ; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="inGayvyJ"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1e5c7d087e1so56431705ad.0
        for <iommu@lists.linux.dev>; Wed, 01 May 2024 00:39:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714549195; x=1715153995; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5eWuGHYXfyJHepRujiagDpeV3q8qyo9GkPxVCzukQy4=;
        b=inGayvyJMMxcCc2OpKLd3yh5wyI1WrFYRnv8IK4q1taO4b8BnIWzqvERtZ6tmClcq0
         pbl6+L+UUd3iD+arkoqaMfC5EeA2tZdmDBrtouPCprbF+MX5sIxt5zuB4IT3XbvSbqe9
         CHSsHYTbqkQ+LF6T4Yj0ORse5hVE3ws2m+TPQScbLrWRjFpIByJGXtVJUkR6DzXrjD7P
         2GBFLg6yLnysyzRW4IcIfQtOueQzMvmI7m0gEywulAQG40hrfuH0udvrOPOdDYyhWXOY
         t2ZNCoYjCLVf7NhZfypsxZGsw1+2X3WpKAVHpdFXQMIAz/LHu5mg8WBUIMAAgwaQOXc7
         zhGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714549195; x=1715153995;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5eWuGHYXfyJHepRujiagDpeV3q8qyo9GkPxVCzukQy4=;
        b=NhvkDzMVQSrVz+Uuo9HA96rf+aWWoJqvKkpqD9McIvSY980PyMy5XDK2f/lH4Swi+s
         O16Kbv0t1wn0Sl51srwxk3l4DB4BkqJ1selIzeL3eSYGY8Y5++s89024pcFKPKLrELQL
         NrQBYraf4vYw/FgewdhJMKHoV9NitrAHJQvNmxB2aYta+t7cNZYBcIKJixYjr9eyz8tE
         DnM4LLuY8nSzaCa1JfK5CZdbLefkCjm5AnoCR052PUT1RyHvfM/dNxekuRm3Jkcf62Y6
         dQdANI0GnRW4YVysSEcTowMU7CIToW0NGDxvB44aStjvzUbFQtw0WfKst+mGE6jkUodl
         n5iw==
X-Forwarded-Encrypted: i=1; AJvYcCUBB0wds6ermlhFVcXaqg4L3QdddricwTszdguAy5rXwkOqJJVATlB0g3JxASnbRZAZNwEzAQ6vHjLGO0fNVkntZq67oug=
X-Gm-Message-State: AOJu0YwKL6KjyG6IrulQaUIwxE5kelC5oWCT8Zo+FCicjwqUeO85X4gz
	b2Hs8krSAZOdstxizraPHGt05DrKVovepxRfm519/ko2+/2IOiER
X-Google-Smtp-Source: AGHT+IGtHhq6yEiiulIYwbWbLH9rp2tc+PgviJAeQI/3SWUvHmKXCvEk5gVgKxrvXwKxyIXXBnfupQ==
X-Received: by 2002:a17:902:eb8e:b0:1e4:6253:75db with SMTP id q14-20020a170902eb8e00b001e4625375dbmr2093312plg.17.1714549195020;
        Wed, 01 May 2024 00:39:55 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id q4-20020a170902edc400b001e29c4b7bd2sm23626709plk.240.2024.05.01.00.39.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 00:39:54 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 23CFD18462B23; Wed, 01 May 2024 14:39:51 +0700 (WIB)
Date: Wed, 1 May 2024 14:39:51 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: mhklinux@outlook.com, robin.murphy@arm.com, joro@8bytes.org,
	will@kernel.org, hch@lst.de, m.szyprowski@samsung.com,
	corbet@lwn.net, iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, petr@tesarici.cz,
	roberto.sassu@huaweicloud.com
Subject: Re: [PATCH v3 1/1] Documentation/core-api: Add swiotlb documentation
Message-ID: <ZjHxxzRb-63ARo6Z@archie.me>
References: <20240429151337.1069470-1-mhklinux@outlook.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="SQuUPEbHKzRUh2zX"
Content-Disposition: inline
In-Reply-To: <20240429151337.1069470-1-mhklinux@outlook.com>


--SQuUPEbHKzRUh2zX
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 29, 2024 at 08:13:37AM -0700, mhkelley58@gmail.com wrote:
> From: Michael Kelley <mhklinux@outlook.com>
>=20
> There's currently no documentation for the swiotlb. Add documentation
> describing usage scenarios, the key APIs, and implementation details.
> Group the new documentation with other DMA-related documentation.
>=20
> Signed-off-by: Michael Kelley <mhklinux@outlook.com>

Other than outstanding reviews, the doc LGTM. Thanks!

Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>

--=20
An old man doll... just what I always wanted! - Clara

--SQuUPEbHKzRUh2zX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZjHxwgAKCRD2uYlJVVFO
o3WrAQDvhNlHDw0C1NqqL2yH9OQNIxn9j4y2CY6FFWX/Oz/INwD/WbBcId0StqpV
oVnntracxxAV03zfP4U6+nARrv12Qg0=
=zv+C
-----END PGP SIGNATURE-----

--SQuUPEbHKzRUh2zX--
