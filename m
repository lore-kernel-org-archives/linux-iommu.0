Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62FA5140E34
	for <iommu@lists.linux.dev>; Wed, 11 Sep 2024 07:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726039742; cv=none; b=QXjH3y3Q9HMNQRaJUwhuACr7V+T4jtzofcgHFfvP9GRlbEC6FpFmyGD/2QcfBaq0PbmlqGFjUa+Jq5/vQuUIHWTY7JMveFS4kNvkzCUYQKHRKsamtmR6HqKD2yBBv6u02381MeFp+pgA3N1ECJ4n77ihEfTRuLKH9Bmp2BFwD5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726039742; c=relaxed/simple;
	bh=iakLmgvnukwcswtCPtzAFI8kmqeVXpVpTFw5LuQno+8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YK4E3/EaoEEczSUyTtrkHRfRqrJ1OStAP6X2/5S2aBFNpXPvkomO2HqPavqCt5y3BJdE3HU3xfdLSaGLzZ52PEvLfr4fTceehUOErVf+d7o5cY+LNRohuZovepAGfz+/2oDFAOfhZ+ijRBH209hP+6mUQVS4s7+QQq6xcUzMc/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A1kXozFr; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A1kXozFr"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-718f4fd89e5so1571326b3a.0
        for <iommu@lists.linux.dev>; Wed, 11 Sep 2024 00:29:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726039741; x=1726644541; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iakLmgvnukwcswtCPtzAFI8kmqeVXpVpTFw5LuQno+8=;
        b=A1kXozFrm86GL48NkRv4LJ/ncn67YsQzN/Tls+I15fFh0zuoThryqbfHgAKT1S6rUZ
         PibhpMxXWF0CqMJjg4+IElfXCJ+nsmEdm0F2+BbDr1fxStI2qsiSTlo7n7Z56GNPhjmf
         qNfQuZrzuw4Tj82MHVrkKiy2XIPVf0DqrWLdilBfZ36vKL+FMWcDCTy6tVmcKMoSwXLq
         HSLCOX+RfxVogwrnpUykYunVoWPg5t86o3j/7pAtgeWyKUY4cTweP0W3wBwOwNDpjtYa
         ++azhPYLIbYdA9Ny/mTI0vqTnnqFPFBsA8HFDEOODMK5igKqkyzshC0EiTWsqaHv6xs/
         KSiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726039741; x=1726644541;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iakLmgvnukwcswtCPtzAFI8kmqeVXpVpTFw5LuQno+8=;
        b=W/VVhfiPiaSZvx+LHpcK81ypaeVsO3G1ujRLzi86n6XRLiDhUNLaA7rzOMg8krLuYy
         unZ0rS6YuOkPiZ8RZ0aD7m+akwySNmt/j5Yk+lKxP96XK+YX5cz1aIOi12bnfYZoziTG
         G+aW0pJ54HAXn2xDx6cV+vlmz3KB6OT3SKMcKtOTpO/0zeyoVA+YtLnaIlt1HgTCBzW6
         iZWAFp+KUvu8vm6jKt8Z3FAyVaaF2LGRChvi7CO3UevI0sFloPZ7vD9SDKiZBCOnY/hR
         qITgGgdhRtEZej5CH7DeEeL2fcfAZMYGs1Wx6bOuUt8/P0S/qT95xq7gLtqbkDGahgiq
         Rxlg==
X-Forwarded-Encrypted: i=1; AJvYcCULW6mURn7Jib+LgG1GznfYUu4yauoVsdzuYWhVHUudHj2PwEcTJOXDzeQ874tFOBuCQKAYlQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwEhxtAzuuAwfTI3CkDzxUEzZNbyF9OKTPBH539XDnRt5zFOdMr
	Qa/sGez2WUSSdBZya8ZGGVsy6GBR/KKDOj36j+hXHyl2Q0SStKLd
X-Google-Smtp-Source: AGHT+IFox3Oy37dkHcW4zCrbt+yyMH8RpvT5yN69nrUau6VYcU+/WxmcW11NcONfdC22LqiM/YfTyQ==
X-Received: by 2002:a05:6a00:928c:b0:714:28c7:2455 with SMTP id d2e1a72fcca58-71916d950a2mr3374011b3a.6.1726039740385;
        Wed, 11 Sep 2024 00:29:00 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7190909226fsm2475877b3a.98.2024.09.11.00.28.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2024 00:28:59 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id D27674A0EB87; Wed, 11 Sep 2024 14:28:47 +0700 (WIB)
Date: Wed, 11 Sep 2024 14:28:47 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: jgg@nvidia.com, kevin.tian@intel.com, corbet@lwn.net,
	iommu@lists.linux.dev, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, yi.l.liu@intel.com,
	eric.auger@redhat.com, shameerali.kolothum.thodi@huawei.com,
	smostafa@google.com, baolu.lu@linux.intel.com
Subject: Re: [PATCH] Documentation: userspace-api: iommufd: Update
 HWPT_PAGING and HWPT_NESTED
Message-ID: <ZuFGr53PK3HvhRHl@archie.me>
References: <20240910204111.7969-1-nicolinc@nvidia.com>
 <ZuD8tsci0JPikUYL@archie.me>
 <ZuEbir5Np3sUFkHz@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="+bsyqXFVwMp8PLlE"
Content-Disposition: inline
In-Reply-To: <ZuEbir5Np3sUFkHz@nvidia.com>


--+bsyqXFVwMp8PLlE
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 10, 2024 at 09:24:42PM -0700, Nicolin Chen wrote:
> I've applied the diff to my local version and will respin another
> version after collecting remarks from others.

OK, thanks!

--=20
An old man doll... just what I always wanted! - Clara

--+bsyqXFVwMp8PLlE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZuFGqwAKCRD2uYlJVVFO
o/miAQDDyi62rowi/sUwnMvXfGllpnhSXAx5LswuPKFU/6HbbgD+JAv+CSyrdd6V
9nVTuBTkoGvsr5MfVDav9vEN5jfDfgo=
=6gHX
-----END PGP SIGNATURE-----

--+bsyqXFVwMp8PLlE--
