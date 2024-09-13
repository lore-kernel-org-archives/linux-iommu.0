Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5A5B4A07
	for <iommu@lists.linux.dev>; Fri, 13 Sep 2024 01:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726190291; cv=none; b=MHS+4Ijin5fyA094TkpFBqzSUarWEaJ9a7UclQmcoY3edJYcJsegeGrjMZrjzgs56qvei01iLF6pX52lUv87YmiYLIUmMD/jvcDbNE1YZjKjh2qehAK90OczO70Kd4ExCDFOkJbLABxwttTjhORw4ravQqAQGC8nnibKA2WS3U4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726190291; c=relaxed/simple;
	bh=Yp6PMUWJlSeoZOwCPYo7ijS5MpmrOP2BcUzEIaBVPcg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VxE4F72dDXmChlJgh2ty+JarTjuUxLYfmE0QFjm7l9x87qCKq3aosaKAsrqlmGKfmeG0Bhp7LBFVnBMnmEblQ2YqxA62QG+uhGyvF99OXcrjCReUNlGwo/rbzAEEpNMCfbRCe22hDLuHriSIBVDYGUH5e0si7pFgEa/f89X2sO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zi2KCkzU; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zi2KCkzU"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7178df70f28so1219680b3a.2
        for <iommu@lists.linux.dev>; Thu, 12 Sep 2024 18:18:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726190289; x=1726795089; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=d9Dv1rZ4lSX5JLn7g5A6qbc9I0zKJhTNVaRog4l8gvk=;
        b=Zi2KCkzU4h7Kattt/VhyKIpp6qMBjihz2+wK4sYy34N6IpeFGUzpupdoELsRr8QXMb
         IUu1/9V1abPMBGxooueXT2B2i/ywbBTpiUitWVBieX20/zupNv8URPWj3BWuJBaHQWLM
         N3MkxMr/JTMzzsYU52lYrwLCZEKAv4VC8loRnA+YXZUPyXhABzXGDHDrA6QzK1OwrGeh
         c4i89yZIGcYVQGoJ4mQxkOtJ5SrAYfoi16ZMjbt8VT9xVa9r0M4Qw5mRvXlOGTHLcqQf
         kegbe6CRg0QwstVNxRRrQRHFn5eur7NG1TDN1xGXBkyhoDUq2hvfwMqht+DIZNX9R//m
         7oYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726190289; x=1726795089;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d9Dv1rZ4lSX5JLn7g5A6qbc9I0zKJhTNVaRog4l8gvk=;
        b=HChU1rVEFKtkuCDpSRwhfr0lZ3h5P8K7u/+03cvcbpuHuliYXbaFKSqE5UcSAN1yDy
         M0lwS4zGYT7V226l6DtWumuuEQ8EnLkthYBD8C9nSiOoqLg/ppWx35JhlGUSRU1V07Wa
         cUo2UrQjyKsfqkaf7TQFIHV+Oo5FmM4Y5kMv8ZSeXvB5MoSguyVJafCvqWClGdIv4dmD
         Ty+k+9r4hk7FcN9F01ixLUxrOrX0CrELOt+6McUJxgxxyq7rnRtrnQ5/439FZCcokEpZ
         iTIYu0fcnUE1u5r5nmjB67wr2Zn2VYm1361AVy0slliVX63NbKYHdqCne539We+2DLzH
         gPYQ==
X-Forwarded-Encrypted: i=1; AJvYcCUVdNnHB9pjLm0cRyke4MCrMfZtpd74D7K+ZIoS70QLw53VC/WCHD7CxnC075ic1wY5UIzx+A==@lists.linux.dev
X-Gm-Message-State: AOJu0YzUKK+K0R9/LwSlNyXbThcZko0R9IyjdA135xNxOBPYFIBijoQ2
	GcH5oShoac6S4WxKLkAJSc2bUkBCrjrUpupWtdgUIz5SHsVjyHxa
X-Google-Smtp-Source: AGHT+IG6Z1K2Jq2CgbYNkWAoessZF2j9kOgTQZdK15l+SPX166vfeZd+aLbSAVSTd/QbfgpqEkcmGA==
X-Received: by 2002:a05:6a00:3cd1:b0:714:1d15:663 with SMTP id d2e1a72fcca58-71926202c98mr7348108b3a.24.1726190288659;
        Thu, 12 Sep 2024 18:18:08 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71908feac91sm5154667b3a.85.2024.09.12.18.18.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2024 18:18:07 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 7260D4A19C6E; Fri, 13 Sep 2024 08:18:03 +0700 (WIB)
Date: Fri, 13 Sep 2024 08:18:03 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Nicolin Chen <nicolinc@nvidia.com>, jgg@nvidia.com,
	kevin.tian@intel.com
Cc: corbet@lwn.net, iommu@lists.linux.dev, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, yi.l.liu@intel.com,
	eric.auger@redhat.com, shameerali.kolothum.thodi@huawei.com,
	smostafa@google.com, baolu.lu@linux.intel.com
Subject: Re: [PATCH v2] Documentation: userspace-api: iommufd: Update
 HWPT_PAGING and HWPT_NESTED
Message-ID: <ZuOSy3ITxJ7tkMnl@archie.me>
References: <20240912021503.205502-1-nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Q6dB82KOjQiJ6b5g"
Content-Disposition: inline
In-Reply-To: <20240912021503.205502-1-nicolinc@nvidia.com>


--Q6dB82KOjQiJ6b5g
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 11, 2024 at 07:15:03PM -0700, Nicolin Chen wrote:
> +- IOMMUFD_OBJ_HWPT_NESTED, representing an actual hardware I/O page table
> +  (i.e. a single struct iommu_domain) managed by user space (e.g. guest =
OS).
> +  "NESTED" indicates that this type of HWPT should be linked to an HWPT_=
PAGING.
> +  It also indicates that it is backed by an iommu_domain that has a type=
 of
> +  IOMMU_DOMAIN_NESTED. This must be a stage-1 domain for a device runnin=
g in
> +  the user space (e.g. in a guest VM enabling the IOMMU nested translati=
on
> +  feature.) So it must be created with a given nesting parent stage-2 do=
main
              "As such, it must be ..."
> +  to associate to. This nested stage-1 page table managed by the user sp=
ace
> +  usually has mappings from guest-level I/O virtual addresses to guest-l=
evel
> +  physical addresses.

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--Q6dB82KOjQiJ6b5g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZuOSwwAKCRD2uYlJVVFO
o0OaAPwM6FumUDIil8nGnHe9Y/dbNttmC+bS+5w4gXSnlpG87AEA5HC2c3jQt49S
VlXWJWQKvlGu5wi0sZOUQXBN9rH+uAc=
=DzZT
-----END PGP SIGNATURE-----

--Q6dB82KOjQiJ6b5g--
