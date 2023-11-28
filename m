Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BA244F5F1
	for <iommu@lists.linux.dev>; Tue, 28 Nov 2023 11:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KNTqZuLj"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-54af2498e85so5592409a12.0
        for <iommu@lists.linux.dev>; Tue, 28 Nov 2023 03:25:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701170719; x=1701775519; darn=lists.linux.dev;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NNUOJ8uqp2dGRLuoBkbadBA/67h+j2C/uKAs+8CYKXM=;
        b=KNTqZuLj5L3+uHLHFx1M9XBgb6JJ5A7ORrJjzQKC/qRKrVcuIfU81+ykNwV/6wNq9F
         V1dnewJl74R42qteH7393NOeX5kdDk1jpURaJMbtEHyIoUY2aJzwCMO1Chj5Y1E4nIa7
         NjzfC9ojzCB/PBWVfSUUn3ZEcsh+dofBDn4ULu+RW9D3SUhd7Ez7CQR4381P01Mp/B9l
         z4Fvzpqun2rYCxfwl8Dq3nPRVnSfupZuD0Ih7al+/PxrrSDPGzlRVYAUp03jJvl0pP2U
         Si7HSHcHysM58no9k0oIucKQq1Xqhx+yJFBXaTu7BvBTnsD+7L7nlKBWgNGXsboDXd1r
         wwlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701170719; x=1701775519;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NNUOJ8uqp2dGRLuoBkbadBA/67h+j2C/uKAs+8CYKXM=;
        b=vK3eLYTzjpKm7sMEd9mrHIpJW8ctjEW/OZGb8M5lP3Ysrq5/GJJx1rhepFE5IDKFRo
         zyg2ArwD/79ttMkySby8BEphRPj0YyGEj0auGnuaIZpoQuRPr8yEmGZ20KqXIpgo8zcc
         ZQFepClTVABqtugN8aEFO3XHoYzkJWwlyByXnFrndXtkQuex1JtmQREE/RKEYPZu4NCJ
         c3ok1YKzsC6SQ3yiQyp87TGFUBsNnU3BXvcARlYf/Z+rHqgW9CK7UYP8k72TSeepNrHJ
         kzAr8maRUO/OidHBl3MeH7urWAdpTlx+2/AC6NWvd0obdNZoSJfJ0VPlciDLSVQfIWql
         Wy5g==
X-Gm-Message-State: AOJu0Yxc5giNW/x+uvn1ya9up6PTZvIK7yHgAZQR4GUEd+ShKqSAC7gs
	qhA0aXC16PtW+grJ/wPfNcY=
X-Google-Smtp-Source: AGHT+IHqbMoYr9M/PBSf9Q1XSD3aTt9QqOplQiVgAE1r6Wwb8HV4II+bQf9Ppd8QDWo6j6Q7X3fGSg==
X-Received: by 2002:a17:906:7691:b0:a04:837e:87af with SMTP id o17-20020a170906769100b00a04837e87afmr11132340ejm.33.1701170718549;
        Tue, 28 Nov 2023 03:25:18 -0800 (PST)
Received: from orome.fritz.box (p200300e41f0fa600f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f0f:a600:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id pw11-20020a17090720ab00b00a0f1025b17asm2417847ejb.130.2023.11.28.03.25.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 03:25:18 -0800 (PST)
Date: Tue, 28 Nov 2023 12:25:16 +0100
From: Thierry Reding <thierry.reding@gmail.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: Dario Binacchi <dario.binacchi@amarulasolutions.com>,
	linux-kernel@vger.kernel.org, Baolu Lu <baolu.lu@linux.intel.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Krishna Reddy <vdumpa@nvidia.com>,
	Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>,
	iommu@lists.linux.dev, linux-tegra@vger.kernel.org
Subject: Re: [PATCH v2] iommu/tegra-smmu: drop error checking for
 debugfs_create_dir()
Message-ID: <ZWXOHI48GyIJsdnT@orome.fritz.box>
References: <20231025152609.2042815-1-dario.binacchi@amarulasolutions.com>
 <ZWRhDMgPCjP_hlZW@8bytes.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="nNpisfqc0N5bJikl"
Content-Disposition: inline
In-Reply-To: <ZWRhDMgPCjP_hlZW@8bytes.org>
User-Agent: Mutt/2.2.12 (2023-09-09)


--nNpisfqc0N5bJikl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 27, 2023 at 10:27:40AM +0100, Joerg Roedel wrote:
> On Wed, Oct 25, 2023 at 05:25:58PM +0200, Dario Binacchi wrote:
> > The return value of debugfs_create_dir() should be checked using the
> > IS_ERR() function. The patch, however, drops the check statement without
> > fixing it because the subsequent functions (i. e. debugfs_create_file())
> > can handle the case where `@parent` is an error pointer.
>=20
> This deserves a comment in the code explaining why no error checking is
> needed.

This is a duplicate of f7da9c081517 ("iommu/tegra-smmu: Drop unnecessary
error check for for debugfs_create_dir()"), which is already in v6.7-rc1
so I think we can ignore this one.

Thierry

--nNpisfqc0N5bJikl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmVlzhwACgkQ3SOs138+
s6HGDRAAgujp8COqpO6Y7LdZQaRa4p7ssRczFgQWmdy2vpheWyCgu7OyKfl+9EHL
tT5/soH/rqrC0i3oq8qqWHOUjRSYYoIqCGz8j/4y8KkdVYQ8GTto0mp4rtIpB1ie
g1Cc32zVimxrZHqaxU4K0U6Jq6fWM5WWs12ZCzlbdjl7U8hwD44vNh/kS76Y6JZh
XNVuTL1ijVskDAdxQLULdoBW7S5qCOWjfDbNbW3v9AxOyr789oW5llERZwddvw5G
ndiKBnvtfCsA72jGO71z7A/Vg9gXKkfBJLxTsd1aShhOCW/psC3s+jVC27AJ82xo
giT0rssa9TQlgy4foU+N0JRJ30GODYFF5vRApYREIIHU2bb2qaiG3s6Oavl51gVY
jdihwdz31vjcHrHcj4lC93AvIjl+N418uzaAjvGPhPrVsOw3qQI5onR4WMQ0ZwP+
Tk40z9FyDHFQQKpseUo8+S+qrmlUVYZUm950DMA0mzk7d+KpCKEsPswNnTcStsKU
MnPMzS4w35d8k9JOwfILR5cy5ouXtAwOXbrnKdjLMazFNhlpAYyb3MZgMnCQgLtz
f97/E56oMdODosYuc5S42wKn8CR5Xmd7vnXy7+DXXg8aS4LubEE5jk1YGAgdHh3V
A332A20cCAWZKvgFYbE46Tj6A0eQBD4O5edw0bJZxQQofvNYOfY=
=mBlz
-----END PGP SIGNATURE-----

--nNpisfqc0N5bJikl--
