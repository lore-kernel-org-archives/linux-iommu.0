Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDDCB39FE5
	for <iommu@lists.linux.dev>; Wed, 11 Sep 2024 02:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726020800; cv=none; b=dXGi5bPL2UeiZVfxiyKL0KWO5sEuhtCMjQ0SLPxPAldgg9vAVVC3PAgJzw9XIFPxJa25e874xA1kSZ5i6wqNlTnlQoxcDmsOLkt8Nwr8tZUktFnHmCseh7cnCKVzwUlW94/GYx/uILfUCL0ly88Z0Z96lMqjxNh1BaeikE7G8RU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726020800; c=relaxed/simple;
	bh=2dO+R1LckxvNT8IJ2u0yIjONA/5/I/RS8hvjUMm3CtE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I4vt7Y+uYnBcrNnFRrni2rQo3LTYzyg8yA7G0tspYoAZOrIxGlQgzIzcY/mMC/Vb5KXB5rg+TsEPPyn+U9YNsR3LPyyO0wZZgHrAGs1lyvgsjrLTON3cLWNYNeWV6svmiYg6gGerIgRwqldXuznF34wx78kAJkl3OJOp4+0Doog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T/k0uHL0; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T/k0uHL0"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-7cd8d2731d1so4308514a12.3
        for <iommu@lists.linux.dev>; Tue, 10 Sep 2024 19:13:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726020798; x=1726625598; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Up5aAc37wiZUjA07VRYBFQt8t+5bxdupJEMSmpLJ8uQ=;
        b=T/k0uHL0PtMAtWm0JTcB27CSn2fCsZYQYaMD0ypbfAy5sYg6NEttPUeK3QVDZRAaf0
         13zsqHJJdcLQwPefuIErn0n+sp8pqNalBWL5FgWyNC6JyEOO+sOGQmlvzKB68oFfHFeb
         GECjFAoMkdwRmVajQI0i6uldGA3CvnTSTdtQqiDU438fQZYNa6eaJifyissFg71KX/Mj
         4qDNZCWgnQNVqHKC0A8GH4afNGjFqRRWHFaW2rsNslv/UZLGVERoubHqatcm6XwnTeHn
         ZlY8CTT0XMpM6tsODbYz0GojMtaJDpOU8n2ZmIV6vHOD5YLq7ZNqmNjytVTLjeQJBNJK
         yPXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726020798; x=1726625598;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Up5aAc37wiZUjA07VRYBFQt8t+5bxdupJEMSmpLJ8uQ=;
        b=hYpzVSHw9jHrUx+tXXFDZwMdGco4Ig42Nl9QsvhxooIwBi/TYGN51Jaqd+3r5m2j/s
         2wLaj3JsMnXT/OA5pkLdS00vi+Uen44arfS4JSQ+2B0BYsgCrSmTekJ+NkuXi7kLQc0y
         JZaGARV/xFoFf8vXOrmQKRooA31DtixKIHQk4/pXvLWyUGFeeXwsY9z467NLmL2Kvs7u
         /l8C56zYcqpIH52U6mtNDJ1DJnw+MS2VCxXFw5uPIZGbuMcsB7sUTGpUvcMehR5qEvAc
         zbk90h2ONpE8oYE3lOYNx1PlmJHCES2qDDkNXq+NLy37uGfzKmRuBthdh8DnFdHmF/bT
         VNJA==
X-Forwarded-Encrypted: i=1; AJvYcCWvRcJUF8wkljE205is0WpNni8Q4/6jXIjE/PrX5iQTf5DaZhCGSgSmB3cXwd6Vli1h74cTnQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzgoxfwhtdsMuu7iw/SGq/cwSqrHnohFCeVVZmZcYSOT5vXuAct
	ajYP1k1honAr+Cr1OWV5yvb9M/Bnljb0HL21SSgey9WD9IQh+QCt
X-Google-Smtp-Source: AGHT+IFcqn+IrTCB5YA14HVO4XXkklrs9Z6HiKvHeMXYHpWbuWAB5hsLrX/yPnKWiWQKUA2+dX39dg==
X-Received: by 2002:a17:90a:ac16:b0:2d8:7f5c:6030 with SMTP id 98e67ed59e1d1-2dad512c8eemr15785165a91.38.1726020797556;
        Tue, 10 Sep 2024 19:13:17 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2db049873b0sm7162501a91.47.2024.09.10.19.13.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2024 19:13:17 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 5B2014A0EB87; Wed, 11 Sep 2024 09:13:11 +0700 (WIB)
Date: Wed, 11 Sep 2024 09:13:10 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Nicolin Chen <nicolinc@nvidia.com>, jgg@nvidia.com,
	kevin.tian@intel.com
Cc: corbet@lwn.net, iommu@lists.linux.dev, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, yi.l.liu@intel.com,
	eric.auger@redhat.com, shameerali.kolothum.thodi@huawei.com,
	smostafa@google.com, baolu.lu@linux.intel.com
Subject: Re: [PATCH] Documentation: userspace-api: iommufd: Update
 HWPT_PAGING and HWPT_NESTED
Message-ID: <ZuD8tsci0JPikUYL@archie.me>
References: <20240910204111.7969-1-nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="l5WlQuJtypFpj+Ea"
Content-Disposition: inline
In-Reply-To: <20240910204111.7969-1-nicolinc@nvidia.com>


--l5WlQuJtypFpj+Ea
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 10, 2024 at 01:41:11PM -0700, Nicolin Chen wrote:
> +- IOMMUFD_OBJ_HWPT_NESTED, representing an actual hardware I/O page table
> +  (i.e. a single struct iommu_domain) managed by user space (e.g. guest =
OS).
> +  "NESTED" indicates that this type of HWPT can be linked to an HWPT_PAG=
ING.
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
> =20
> <snipped>...=20
> +   this completes the device could do DMA. Note that every iommu_domain =
inside
> +   the IOAS is also represented to userspace as an IOMMUFD_OBJ_HWPT_PAGI=
NG.
> +
> +   IOMMUFD_OBJ_HWPT_PAGING can be also manually created via the IOMMU_HW=
PT_ALLOC
> +   uAPI, provided an ioas_id via @pt_id to associate the new HWPT_PAGING=
 object
> +   to the corresponding IOAS object. The benefit of this manual allocati=
on is to
> +   provide allocation flags (defined in enum iommufd_hwpt_alloc_flags), =
e.g. it
> +   allocates a nesting parent HWPT_PAGING, if the IOMMU_HWPT_ALLOC_NEST_=
PARENT
> +   flag is set.

Nested bullet list fits:

---- >8 ---
diff --git a/Documentation/userspace-api/iommufd.rst b/Documentation/usersp=
ace-api/iommufd.rst
index 3b0e46017dce22..e3ff476aba097e 100644
--- a/Documentation/userspace-api/iommufd.rst
+++ b/Documentation/userspace-api/iommufd.rst
@@ -115,21 +115,21 @@ creating the objects and links::
=20
 3. IOMMUFD_OBJ_HWPT_PAGING can be created in two ways:
=20
-   IOMMUFD_OBJ_HWPT_PAGING is created when an external driver calls the IO=
MMUFD
-   kAPI to attach a bound device to an IOAS. Similarly the external driver=
 uAPI
-   allows userspace to initiate the attaching operation. If a compatible
-   pagetable already exists then it is reused for the attachment. Otherwis=
e a
-   new pagetable object and iommu_domain is created. Successful completion=
 of
-   this operation sets up the linkages among IOAS, device and iommu_domain=
=2E Once
-   this completes the device could do DMA. Note that every iommu_domain in=
side
-   the IOAS is also represented to userspace as an IOMMUFD_OBJ_HWPT_PAGING.
+   * IOMMUFD_OBJ_HWPT_PAGING is created when an external driver calls the =
IOMMUFD
+     kAPI to attach a bound device to an IOAS. Similarly the external driv=
er uAPI
+     allows userspace to initiate the attaching operation. If a compatible
+     pagetable already exists then it is reused for the attachment. Otherw=
ise a
+     new pagetable object and iommu_domain is created. Successful completi=
on of
+     this operation sets up the linkages among IOAS, device and iommu_doma=
in. Once
+     this completes the device could do DMA. Note that every iommu_domain =
inside
+     the IOAS is also represented to userspace as an IOMMUFD_OBJ_HWPT_PAGI=
NG.
=20
-   IOMMUFD_OBJ_HWPT_PAGING can be also manually created via the IOMMU_HWPT=
_ALLOC
-   uAPI, provided an ioas_id via @pt_id to associate the new HWPT_PAGING o=
bject
-   to the corresponding IOAS object. The benefit of this manual allocation=
 is to
-   provide allocation flags (defined in enum iommufd_hwpt_alloc_flags), e.=
g. it
-   allocates a nesting parent HWPT_PAGING, if the IOMMU_HWPT_ALLOC_NEST_PA=
RENT
-   flag is set.
+   * IOMMUFD_OBJ_HWPT_PAGING can be also manually created via the IOMMU_HW=
PT_ALLOC
+     uAPI, provided an ioas_id via @pt_id to associate the new HWPT_PAGING=
 object
+     to the corresponding IOAS object. The benefit of this manual allocati=
on is to
+     provide allocation flags (defined in enum iommufd_hwpt_alloc_flags), =
e.g. it
+     allocates a nesting parent HWPT_PAGING, if the IOMMU_HWPT_ALLOC_NEST_=
PARENT
+     flag is set.
=20
 4. IOMMUFD_OBJ_HWPT_NESTED can be only manually created via the IOMMU_HWPT=
_ALLOC
    uAPI, provided an hwpt_id via @pt_id to associate the new HWPT_NESTED o=
bject

> <snipped>...
> +      When @pt_id carries an ioas_id to an IOAS object, the IOMMU_HWPT_A=
LLOC
> +      call is instructed to allocate an HWPT_PAGING object only.
> +      When @pt_id carries an hwpt_id to an HWPT_PAGING object, the uAPI =
call
         "If instead @pt_id ..."
> +      is instructed to allocate an HWPT_NESTED object only.
> +      If any other type of object is passed in via the @pt_id, the uAPI =
call
> +      will fail.

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--l5WlQuJtypFpj+Ea
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZuD8rQAKCRD2uYlJVVFO
o/PNAP9gmYscQYFW4myLa5hHVblURAm3B+6QurV16tg1ViEvKQEA4VWBaSrSVH4c
0yXoOOp2DmReQzFIioBwAfvC+oEZigE=
=nnk7
-----END PGP SIGNATURE-----

--l5WlQuJtypFpj+Ea--
