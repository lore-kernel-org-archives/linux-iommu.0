Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C56921ADBA
	for <iommu@lists.linux.dev>; Fri, 28 Mar 2025 12:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743164025; cv=none; b=CiDkheIabKV54Yu1qEEC4FbyWQHA7g/4pXmWzPXCWLxzk+WpdEZoBke+eRLSwYON/R2gTLC5YyX70HRqTOvA5WNrUN6bZVliVbJ7RWi1C2gKf62zpA7cdgkSaInA2t+5vvgLxllZECleStE9nWIGHRAH7x+H0ORLAjcKf0ocMLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743164025; c=relaxed/simple;
	bh=GZBdXCOccaLT3Rr1h5UZpHp+P0XpQdOS8rWPxo4GXio=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CA+jLCYocZ8NLHhQXJbu0upSc0U1Vu5TNObMCccid0enEc8VCTary45ta/pJr6/HsLFi0baHgS/lgyRgcxHdZsqO59o5n5mMTOtUvXPZMKeb5r+3QIHwfI6zZV+svj/yAwnmFdbuwfFDC+/CYc8MhmiJe+cEhouS0Kxjz4L7DHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SsDnDg7z; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SsDnDg7z"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-227b828de00so37884565ad.1
        for <iommu@lists.linux.dev>; Fri, 28 Mar 2025 05:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743164023; x=1743768823; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GZBdXCOccaLT3Rr1h5UZpHp+P0XpQdOS8rWPxo4GXio=;
        b=SsDnDg7zMnSsZPTO88/M8z+ECoNzDeItr+mJOkGBVTPPmfrfQcJFyVShElToyqgSwn
         CvLWvPy/Z5ITFxn52101+uPcFjnmnLS7NFoTHAuiAx3JAgfZTjFgfsbYVY3unRIs3F2k
         YZusUeVi3amGAOPWWtsyPIaSlZKr4SQdTobtScNTrTkN1yFprh8J77X1WfrZ2/JnRr90
         U8UdcD6v/MaG7r/R+wvIqucSFzfc9I/tCXNqt1cLWKbXDcASgy2MjK4G8btsEadWzCBJ
         hTDO35m5icMz+DrIiBldgyDV+3fXTAKs05t2Zes7/XYZtlb/hYdwmXDuBcFqKNXijYfN
         D7KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743164023; x=1743768823;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GZBdXCOccaLT3Rr1h5UZpHp+P0XpQdOS8rWPxo4GXio=;
        b=vzk7DngeViGxiU9XT6RA9c536M/TMKoYA5EwYo14JQuOVBygLrffU2HBUbNjIaa0It
         oUg0J7fjULm/LylmMNZqg9JBpA6oZ3q9KDC5TYEshYRILO3bV6GeB3d6LEFnZx12cbsK
         t28hHxnGHHz7forHv5dMxfofQX6oQcAr3gyu20uFClDjASbZaCkBIu2Ob2/dEs283SKS
         f8jRUSzR526AoHihyKJWr60OWH8M2am68XilVTVJgdrKgsXtc/cu/6uC+kWoXlmLa+CR
         QP20FAcWX4ykg3HfqPImsuXti4OaGMGMjrk52LLMIkwzVTRz7DQ5izai1S+YasgT8TzQ
         w5Ag==
X-Forwarded-Encrypted: i=1; AJvYcCW2LdVeqC2p9QqaHep1NtxlYyh8U1ylLqQeQ95KPQh1snusAW5dQ/zBxb9/9F/4Oip3b+NmSg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzAwUBrd3K9WJkDdvn/LJlBTD/U3HediW5KUE9dRFkTg/wMlkWJ
	/IyvUrX8f0du0xyxmAxS19NhkNLUUMwSKsgkrneXuWEBB70E2qOoNKcmQg==
X-Gm-Gg: ASbGncuNLG7vb0x+WyDKDbFHIHWjkus7a7mesfUQCBoMwrosU7MKX5AMMGeAouU0/tL
	yinBZoxqAlkfjY2OfA8tbh9+dhLi/qV/PFAyJ7sjoARQOpho6zt88mtwwLfOL2/ovVDA8Ni85R1
	SRcMaIED9HkV8c4/oXh3cMsonua2E95K/refqJXOCHvlrF9ntRXQEt93NKYIN4VwWhxMR+Lte5k
	fE/qdfohl1KwmhEAU73dNjJdlQ1RwI/Y98LZwhNzH2UWJ7KUDjdYS3BcHtyavYfOosyggLaOeEN
	L5NGO7uHTQo5rzZigrguYj793+V3M5cZx0GMPxL0Buis
X-Google-Smtp-Source: AGHT+IHbhHRwAGXrZdFekxoHGN2RLxCEHtVfR3r+fvK3laYBKmHAxg+tc60qZiJGM8EyQfC2jcYuEQ==
X-Received: by 2002:a05:6a21:78a7:b0:1f5:7873:3041 with SMTP id adf61e73a8af0-1fea2d7e078mr13376889637.18.1743164023158;
        Fri, 28 Mar 2025 05:13:43 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-af93ba109a8sm1217447a12.69.2025.03.28.05.13.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Mar 2025 05:13:42 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 55116420A74C; Fri, 28 Mar 2025 19:13:40 +0700 (WIB)
Date: Fri, 28 Mar 2025 19:13:40 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux IOMMU <iommu@lists.linux.dev>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH] iommufd: Fix iommu_vevent_header tables markup
Message-ID: <Z-aSdBvgnMSyT3qL@archie.me>
References: <20250328114654.55840-1-bagasdotme@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="4gh5mVGi1XsFFdpR"
Content-Disposition: inline
In-Reply-To: <20250328114654.55840-1-bagasdotme@gmail.com>


--4gh5mVGi1XsFFdpR
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 28, 2025 at 06:46:54PM +0700, Bagas Sanjaya wrote:
> Stephen Rothwell reports htmldocs warnings on iommu_vevent_header
> tables:

Oops, should've been s/iommu_vevent_header/iommufd_vevent_header/.

Sorry for inconvenience.

--=20
An old man doll... just what I always wanted! - Clara

--4gh5mVGi1XsFFdpR
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZ+aScAAKCRD2uYlJVVFO
o2OoAQDP2ICoV65K5DWjBVDKexlZjQTgjJAtUOo5mVNG2VuFMQEAm+paxJ8p4+zY
T6B+gtKIRHsd+m4GuKku8jTuWWyoFAk=
=81w5
-----END PGP SIGNATURE-----

--4gh5mVGi1XsFFdpR--
