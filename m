Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A9BE24A05D
	for <iommu@lists.linux.dev>; Fri,  7 Nov 2025 05:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762492481; cv=none; b=aczsbCJCtto1e62B7MadbzlX8DP+xEaWAkRqbSv2Gl8Sx86O6YxZTK4t5ME8rgO36+2665wRs1Z78iARAF84r8rXaeIFFNnbKlpQEBf/P1JB49GzzHWONHUbFP1TYx59mi+lCczfyO22bhj931cAS5VWoIod9P4iiLobSrQc5D8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762492481; c=relaxed/simple;
	bh=wFgazZHwRKDC0b+E3ALvNq+/41+FCsmrjBSYyzfDEw8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JFRCI+gWC2Ss9cbY8WOHcFi+2w5hBLEaKGzpgU3tghgnLdYOEdkbSnsMXQL89GWgCAeGtzwtZBWoI5vOzeAOy1nFHuag7kNTStwvEfDvBnb2I8ck0AXsEvlztR57TVobzORzTr0qsKDkI96LMkxpJT7VLA03G2LAWT1U1VfhKVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y8J4S4Fh; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y8J4S4Fh"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2958db8ae4fso3212455ad.2
        for <iommu@lists.linux.dev>; Thu, 06 Nov 2025 21:14:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762492479; x=1763097279; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EXckxvr0vYaJfRakg7xejcSzoqy5VEAgGRFPyHXgVxQ=;
        b=Y8J4S4FhObFBc+ejzdkgOHA91kq4Dvda3QUsHs+bJSPNkL+IpCtfQDe+HtYDzrm+q9
         dd4wLYkBllHqSNNfKGtkqE9rCIBpobFNAFt+1pTlA1UsML259nTfVfjIUUErqCgkcELN
         WuK7QbUQQKNLx/vbFfy8TKECm9TMV46eS9YQ8ud5vWq+Ib4x9jU0eLxzeQ7zm+kDIXK9
         ig/jbi6vyigg/pGCQriNlSMdObuVXLe3QGHq2+etZV00C+r8TENU72bqAcg/9KSs4zID
         98LTpHHbM8Q/FCmObd4w3WJFLDaSHJpA66pavDd2j8D6AQgBsJZdEYwUMhh/uCbqtQfI
         hIUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762492479; x=1763097279;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EXckxvr0vYaJfRakg7xejcSzoqy5VEAgGRFPyHXgVxQ=;
        b=VazxnoaTfS5KCqyWpfPGcLN8mzqi6vM1gW/gigD9Fn6YWveAO3nq1UVzOhSD8yuypr
         WEBRv4RFFFNvfKWLqmowfbYiUM37PUWaMOKdcbl5d1CxbsJBg7+h/j1/YfChNg431Lre
         Dc/vRH6qJvzjRziDhDESLz57sowj16fv6QhRW/16FH8I6Dml5Yt8Zff+ykD8k2z2Awqe
         JTe9PIkGKyYgMctTN0yPzRzHd0IluoPaNk60hsQknBE3H2W2KFDtInzyEQmajIoDbd2+
         uVcytsuq9RafhhVcSpZabacBAq7ySLfie0LxsUF+cbQoc/bag11jApa2ISj5VnGO2WyA
         0qXg==
X-Forwarded-Encrypted: i=1; AJvYcCVqvh7MOa/ul8zMgVFqLd9EvWkn+yXDFKg6r3ZBS+R2FeuREO8G1YliWVRObTFU5yzmcwbpyw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyImkLLqyrS14p/L67c+3hkm9RXim9cbWWxB8DHEmQj5DnXFiTi
	gg8Tlr0ayODl0OyfsFgPfAqJN2004aOLezRqNbNLex83kzteJFVWOtO7
X-Gm-Gg: ASbGncuN2G+wqiPUwR9zz8qLnR8JK8UQMtAUOXxwUW7GExAk98tTbMrTTvx8EqiCUxG
	pq4kch1nagqPEPQW1ToQ0zcPR3dTU58+5NWxz3CF074JOeBoKzQbcbrNpI7jwpocGQsm0lgpvWv
	mvLn/VOQNN9S5s+Tk2DfUxfVRFD7BUGge7q+LtZcMJVWrDQCSIgY7+sHNtyoQEOxJckMz1X6Z2Y
	vpCxMF6M/lcjhL9lewn5hwGYrfrMylpkQpKsIOiC5I7TiVGljMnVNcjHTuY9kIi4ACW2W/oTndt
	f6g4sqShBALdgvWDoPIEEkdFTafKT0p8DHZvM9+dxSrkR0hB9TE3EGT2SJjCCWCPAUkoLkcr3j0
	nu9xLZIFwSc7zj50i1k+uQ7LG+xuX30P4vOoT5gairGd8scDlShoseZr6jiA5PjtDkEAf7tsv5o
	NyvRZetxeOc+E=
X-Google-Smtp-Source: AGHT+IH+frnSJQgDrVAXIYJKyu7mYXKAiPFwbWjawyyleHXAbYs2NV3FQSsq73qfRHjXOM8oDAMAIQ==
X-Received: by 2002:a17:902:c943:b0:290:91d2:9304 with SMTP id d9443c01a7336-297c03a5e59mr26729835ad.4.1762492479156;
        Thu, 06 Nov 2025 21:14:39 -0800 (PST)
Received: from archie.me ([210.87.74.117])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2964f2a9716sm47872335ad.0.2025.11.06.21.14.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 21:14:37 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
	id 1354842EFE93; Fri, 07 Nov 2025 12:14:29 +0700 (WIB)
Date: Fri, 7 Nov 2025 12:14:29 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Jason Gunthorpe <jgg@ziepe.ca>, Randy Dunlap <rdunlap@infradead.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux IOMMU <iommu@lists.linux.dev>,
	Jonathan Corbet <corbet@lwn.net>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>
Subject: Re: [PATCH 2/2] iommupt: Describe @bitnr parameter
Message-ID: <aQ2ANX6V3F1qfKdE@archie.me>
References: <20251106073845.36445-1-bagasdotme@gmail.com>
 <20251106073845.36445-3-bagasdotme@gmail.com>
 <9dba0eb7-6f32-41b7-b70b-12379364585f@infradead.org>
 <20251107003541.GA1792527@ziepe.ca>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="x3hfNvsCBYLDwZJH"
Content-Disposition: inline
In-Reply-To: <20251107003541.GA1792527@ziepe.ca>


--x3hfNvsCBYLDwZJH
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 06, 2025 at 08:35:41PM -0400, Jason Gunthorpe wrote:
> On Thu, Nov 06, 2025 at 03:48:10PM -0800, Randy Dunlap wrote:
> > > diff --git a/drivers/iommu/generic_pt/pt_common.h b/drivers/iommu/gen=
eric_pt/pt_common.h
> > > index b5628f47e0db40..54c16355be2842 100644
> > > --- a/drivers/iommu/generic_pt/pt_common.h
> > > +++ b/drivers/iommu/generic_pt/pt_common.h
> > > @@ -354,6 +354,7 @@ static inline unsigned int pt_max_sw_bit(struct p=
t_common *common);
> > >  /**
> > >   * pt_test_sw_bit_acquire() - Read a software bit in an item
> > >   * @pts: Entry to set
> > > + * @bitnr: Bit to set
> >=20
> > Shouldn't both of these (above) to "to read" instead of "to set"?
>=20
> Yes, that's right, Bagas could you fold that into a v2?

OK, thanks!

--=20
An old man doll... just what I always wanted! - Clara

--x3hfNvsCBYLDwZJH
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCaQ2AMAAKCRD2uYlJVVFO
o07hAQCrjQK1FVbRPucfTlsUP3cQYw/+poMRTLSUUh6cilN7yAEArVh7GTezT4vr
RzS5LgwIZmkWSYMZpirFqHJfOD+03gA=
=3Jmb
-----END PGP SIGNATURE-----

--x3hfNvsCBYLDwZJH--
