Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D3CD635
	for <iommu@lists.linux.dev>; Sat, 14 Sep 2024 03:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726285623; cv=none; b=N6+olBM5n4fEXkuP+SLGFILAx08aRAsOW1qEuunmCAvMs2HpfVERfYvlR1+Gv5E/kkWiKsbV7nvGUEvZqTdcuFg4DMBpHV4XpUXV37cSzjAO4Kq7w3/ctSpsO4wX24aKahE4mu2Ra1+vgoZfJcCavKKt1+mm/uxda9dEgu+sS4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726285623; c=relaxed/simple;
	bh=UOGC/8KQyUmk/djAeqsWg+upqOqROGfOn5+f87rsqlQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z8tzCyQw12vot0CJEGjp1kFFIzQ0L2hyBlL0IVtC7mAd7jbuh0Cb7riQLXSnoDZh2YfXQQj/yYxCpCJevZy4dfl2AFh6a5y1VSW/BIIiwTJ29rnzKF2hqoBt/H2kcMgCzvAJ543oXK4gJdQfwHmzXGBwpoNy0le1ulQlIjHe0nM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TjH87wAJ; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TjH87wAJ"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-20573eb852aso25656775ad.1
        for <iommu@lists.linux.dev>; Fri, 13 Sep 2024 20:47:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726285621; x=1726890421; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UOGC/8KQyUmk/djAeqsWg+upqOqROGfOn5+f87rsqlQ=;
        b=TjH87wAJj3I59fW4zCsA37+X57g0EmYAq//vMPj6QQIXYa73B+fMdb293hoBOU8Hlb
         o9tvJZbGY7HdiO0zChTrAQ4ZMXsoa7iUh536tBgG1IZ8B5vti3G8fixM0p0BExF/NEd2
         oGIA3pACGpuiP+jiH3mxrgN/9ey3t1D1Nrc6XGHuhHP2GVI8vduIMFSPYUm190sIuzjh
         Lv3DqujdDLnbOcvBqA4oEMO1/vNlkZg1SlujO+nWZbZcSPB6ItD6NuL5r7UYeRqEZu45
         VbQbSO5bWVXdljJXeKPyuxNt+1Gi+Rw7uAEgjpAGH0LAFmfFnQV4MpJHvMN9H9/DI8/e
         ph2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726285621; x=1726890421;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UOGC/8KQyUmk/djAeqsWg+upqOqROGfOn5+f87rsqlQ=;
        b=M0nLp0TaN0pYVxn07wz9Osra2TWZyvPgQVhhweYjmdX0OdTuRFcqXyLoK67lVFCZWF
         6YpAGUWKoqtDm1nLJ483X4r1UdoFEngDQcJSw4LoKP6ukE+JhXHz3bA7g0WJ0/m4ZaZA
         20434fcBi8DEYrxCcvnmReWkUQKgJxaOrgSVkeIZJdptGAhQHRjQfcOV2wsdM0wqukCy
         k6k4xZ85suoPNFjPGHUaLVgK1fmjTCIgQRN9Fh/Ehboxbr33bBghGe3VHKx0QWu5xzD+
         M33YbecyOr0zvdeNvbFQN+/LU5v0aOal/HKwtX9flt1uJ+sZk7d61tjNPgg5Z6sm+CXe
         lSHg==
X-Forwarded-Encrypted: i=1; AJvYcCWBdmmSBymERyQHLRPtNPi7kVWQI/qaKUnoWu2DtwtOEFo1Nv7Jnaw5wVsHY9Aj39Wgi+jh8A==@lists.linux.dev
X-Gm-Message-State: AOJu0YyH6al/7RGzsVS/vzH5LA4n2OwxDgkFnHaLF4yL2j72beYNGA9H
	96+7Qf0PYe7cEMu7RdRXcfeBQ7sFGpKZ/X9XeChkWVEZNSD1QVak
X-Google-Smtp-Source: AGHT+IExTh4sE2dSavfpwo4le+w02Q/wEN2CuAipPKijPK4VJUyg2q5Zn8F/TmmAXocQ0Y+9QvxwMA==
X-Received: by 2002:a17:902:d501:b0:205:7b04:dde1 with SMTP id d9443c01a7336-2074c6df55dmr214950935ad.20.1726285620519;
        Fri, 13 Sep 2024 20:47:00 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20794731606sm2978505ad.270.2024.09.13.20.46.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2024 20:46:59 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 332114A0EB86; Sat, 14 Sep 2024 10:46:56 +0700 (WIB)
Date: Sat, 14 Sep 2024 10:46:55 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Nicolin Chen <nicolinc@nvidia.com>, jgg@nvidia.com
Cc: kevin.tian@intel.com, corbet@lwn.net, iommu@lists.linux.dev,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	yi.l.liu@intel.com, eric.auger@redhat.com,
	shameerali.kolothum.thodi@huawei.com, smostafa@google.com,
	baolu.lu@linux.intel.com
Subject: Re: [PATCH v3] Documentation: userspace-api: iommufd: Update
 HWPT_PAGING and HWPT_NESTED
Message-ID: <ZuUHL7HXAe0vANdY@archie.me>
References: <20240913052519.2153-1-nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="PBkg31RWqd7Uf7Oh"
Content-Disposition: inline
In-Reply-To: <20240913052519.2153-1-nicolinc@nvidia.com>


--PBkg31RWqd7Uf7Oh
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 12, 2024 at 10:25:19PM -0700, Nicolin Chen wrote:
> The previous IOMMUFD_OBJ_HW_PAGETABLE has been reworked to two separated
> objects: IOMMUFD_OBJ_HWPT_PAGING and IOMMUFD_OBJ_HWPT_NESTED in order to
> support a nested translation context.
>=20
> Corresponding to the latest iommufd APIs and uAPIs, update the doc so as
> to reflect the new design.
>=20

LGTM, thanks!

Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>

--=20
An old man doll... just what I always wanted! - Clara

--PBkg31RWqd7Uf7Oh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZuUHKQAKCRD2uYlJVVFO
owvjAQDSw5TgYY8NMgLw+QyfLivJhB7uKdT02aP1nAn6TtpTfQD/QNhgfBqI6HQK
JvLMcrifmDGlSUVtqide+k63/C3V1As=
=Mu1T
-----END PGP SIGNATURE-----

--PBkg31RWqd7Uf7Oh--
