Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A345A28000B
	for <iommu@lists.linux.dev>; Fri,  7 Nov 2025 23:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762557332; cv=none; b=DucL8dVEcL/aT55VNqeUggyDpCXzJNQq5YnTapWZb+vXQL/LvKku/93NzfbYEyae1hj2GVaEw6DlGuylJL08Dja+yKuAa1I5q9ZcsR3JwbT22VCPEobP6JJVXVxwDWqE/K9xpTvGRgmpCHJNH4c0q0KkFuELi8dNufLpxwo+430=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762557332; c=relaxed/simple;
	bh=1CNW2q7rZ5eZ1hQ3d6f/0/8aleciBSs32cCPnD55gF0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OzN4MdjwBhPAad28SCLptdkLaBf52rDtbVHUTH54ZId0MDoLNJwsR1wHe1LpwmYiDg2Wb6gtw9uEo22BH+HbJHCJXdO/F0L3qKA+6d1jS4IfqyLrwTud/O0SzjqUCYz4ABxvcZBMQwuXZpRAM9t1NcTKDWZHTPU6CQp/tLXKRgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BFDa54ci; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BFDa54ci"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-7ae4656d6e4so1541160b3a.1
        for <iommu@lists.linux.dev>; Fri, 07 Nov 2025 15:15:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762557330; x=1763162130; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Lm3n9qHPKakGyAJDHeR9T+11dprM9YeXc2RscwPCjOI=;
        b=BFDa54ciMWu8POvyfQ4A2fO2M1rD/A1VPf6PrbXguOaZ3k33nOHpo/AsDAEZ6qCr0T
         RnK3zc+1ydDOiBXfwaHiphx3MsJxevkyNf/qlB0C6CZxUO+RH1E82puMfBVSC19NWDHl
         bxYkYJCQQotSci71c159IFuFXiur+FPpElXZJ7NHBS8ZPaviXlGIRAzmjr8t38sWlzK8
         5A6BoWIZU23gI/q+NPtGv94f5Y5yTybZ8yyfARQxOQzvPsmd/QArPolQjn+7nj/fG92r
         phvynxBIyh87EURdtNHyHoACj3fvm+kI2UZFcaeQKkrRiRGkb7Scf004jQT9+YgApkji
         qy9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762557330; x=1763162130;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Lm3n9qHPKakGyAJDHeR9T+11dprM9YeXc2RscwPCjOI=;
        b=S11hEj+YDsYKQM/ZW8Hn+0yyWkHsOWcAxeFiBy7V5VhjVao0JsVbM7UyqYxh7J+lpo
         hKBaYxauPFcReWITFhawfl3C0OQpr6nyz7FYV8ZaOlCuZUqdK8QC5H7JFDRjAW+n/3nl
         ObRODVxVjKE2utImJXIdlnRvuoR1kvBNF8MiR6CKvI1FNRAWXhT0Ifz1wRRA62jqLQfI
         tZuc/2e6RVpGs201lQI8kfwBYg69kYB6AK2DxYe4p8Or75T/E9A8QeBR8J+Q2NR3vW/r
         w0D5AKKw7tbJJEPrsNEtPdftPbWIxWo01/TvDCHJ4V1YE0y4c2ULocXUUNIdqQHU6VQs
         bU8Q==
X-Forwarded-Encrypted: i=1; AJvYcCWS9kwBo6gv7tnOWGwrjg2AGaeA25dH+AjQAkmcWk7c1lSN/PkHHec/81JpUCf5H+CwydLneA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxh0eOe4Loo0tH4j4HjcB/OSjwcxwRJ57R0wwtGyiee7gVpy2gg
	xm7sSDN7QV0mPYx2yXSCUgxfGO0we2Btr6KHqpz0DBwfOgsOsEBG/xCA
X-Gm-Gg: ASbGncujdL3tkeEIKxWbM0Qld/Gi9+F2QzFkcboboeatflnjRPeBPDXOsNLhp4KuqMS
	nf6VXuGSSOM9qhryQ7PfTOSMFGBz+ggcCqg1mBoKmCcehQTCL7ljbY92q/woFKR2C2uq976dTIr
	GqoMKiS6zRFvWIjWAHOtNLZo/PeUmIuSAoSmDe7l5RMUOkOxjIUa/Rd0a3hzy2gns4I8QxZV6DJ
	+6n1Poy14+gwVOoKV43VPUjrIaFzXqLq5E9IVCw9CPeyhvkNOhg6BKSz3UOQfLYCddxIRQqYZZj
	BSqrjLmWkEBVSv11RDcQxLzvJP29m1WJD6WL1/V6DBGSHh49yRST+QRceS6+jPs9z29wWsSmZ3W
	C6u26Awp8ZtG2JUEvOpKcmcRFdpxP9IZuXMAzdHzTv94sVBrMT2z2LDREPoe3coJ7ieeBNzC3Ua
	8B6VAdihxdC08=
X-Google-Smtp-Source: AGHT+IGED60LsdNHAG47E5ek+vWqvgFmd56J6anEw/IyiassMDG+ECL/tyhoZhYvdVdrJbsIiOQYEg==
X-Received: by 2002:a17:902:e888:b0:295:1a5b:f406 with SMTP id d9443c01a7336-297e564f99emr8849895ad.25.1762557329690;
        Fri, 07 Nov 2025 15:15:29 -0800 (PST)
Received: from archie.me ([210.87.74.117])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29651ca4257sm70259405ad.95.2025.11.07.15.15.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 15:15:28 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
	id 88957423BF1E; Sat, 08 Nov 2025 06:15:26 +0700 (WIB)
Date: Sat, 8 Nov 2025 06:15:26 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Randy Dunlap <rdunlap@infradead.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux IOMMU <iommu@lists.linux.dev>
Cc: Jonathan Corbet <corbet@lwn.net>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v2 0/2] genpt documentation fixes
Message-ID: <aQ59jnOE3pFyZPkn@archie.me>
References: <20251107081300.13033-2-bagasdotme@gmail.com>
 <49ff6f64-b664-4628-af2a-1b46e0fd62ad@infradead.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="haSgLIvfV15aCdif"
Content-Disposition: inline
In-Reply-To: <49ff6f64-b664-4628-af2a-1b46e0fd62ad@infradead.org>


--haSgLIvfV15aCdif
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 07, 2025 at 11:16:36AM -0800, Randy Dunlap wrote:
>=20
>=20
> On 11/7/25 12:12 AM, Bagas Sanjaya wrote:
> > Changes since v1 [2]:
> >=20
> >   - s/to set/to read/ (Randy)
>=20
> That's not quite what I said (wrote):
>=20
> > @@ -354,6 +354,7 @@ static inline unsigned int pt_max_sw_bit(struct pt_=
common *common);
> >  /**
> >   * pt_test_sw_bit_acquire() - Read a software bit in an item
> >   * @pts: Entry to set
> > + * @bitnr: Bit to set
>=20
> | Shouldn't both of these (above) to "to read" instead of "to set"?
>=20
>=20
>=20
> No changes to pt_set_sw_bit_release() [which should say "to set" in 2 pla=
ces].
>=20

Oops, I misunderstood the review. Will send the fixup shortly.

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--haSgLIvfV15aCdif
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCaQ59iAAKCRD2uYlJVVFO
o2mPAQCtbCENoydVvPLZcPrSmiIrDBqFuvWPN0Kq1nC14RV9iwD+KCZacoHSjhsN
O6Z8k1VhZ8ialSR19Dwm+CelyQbgTgI=
=3f7R
-----END PGP SIGNATURE-----

--haSgLIvfV15aCdif--
