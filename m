Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B818182C6
	for <iommu@lists.linux.dev>; Mon, 30 Oct 2023 15:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J9iMWu/W"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-99de884ad25so709676766b.3
        for <iommu@lists.linux.dev>; Mon, 30 Oct 2023 08:30:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698679850; x=1699284650; darn=lists.linux.dev;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fucSBr7KI97NI+mfq5QKSGfLCAvmSHTUlbKwSB46i8M=;
        b=J9iMWu/WeoaVVEwMZQxEhsyceSIWmLoIk1Vo9TbOnuPqpNtQHcQKbvHmax1cwZ1l25
         y99Q8+Uu1T5iQKEZ/oegVDKuuGJwHHFrwKlixSlJwEip/kwZTlUdFB5PQ2t2jARIMdaz
         ZjC5LhUgzXU1QRZbiOS2HCx619gqPIBBevhgVJfgtghN52DOYlQrhIfsTq9pWsBG5TTo
         g8PEF3pdhfXAtlGZoXhYEiRI3WhqT6/ZRdcefQtWK9TloEyJ6zJjx9xpLxZbRcefiVkU
         HfX0YH6uMg0PeiG/SAxTuUgqh8p/4B0tHxFt1DTJbZ/xOSW1ue12cWY7vRA/o/btnpao
         OPvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698679850; x=1699284650;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fucSBr7KI97NI+mfq5QKSGfLCAvmSHTUlbKwSB46i8M=;
        b=a8QGW/DVWzQ27vkUfaIdwO+ZxU2ZMNmOoZNMr34jZBvBfH2ymR5EKkRv0tGC76LDrg
         JOE5Fx1dr7ySOq8VXzzGzfyfkRuFODDj8QU85NfXVEJq0xPhmo+/n9xVWwgZ3tNNk9u/
         FGqTevRqzFTP0IcB6JpVHG+WXio2cb7jyTjpGZq7wks/K0eHMtxv+VXaSXxa8quuw0jc
         0fDOAw4cpVSTeXAhwPLP2A+G414kvCCdmUMs+EGXaW7iQd2m9xtFLxV+JDAUT5r25Gcd
         r11UedIW79P3QXsCv2HCNnuQwJgtcr53ZPvGW9PaC1w5d6FBvI+iV0cqvlmV78h4bl5i
         CuVQ==
X-Gm-Message-State: AOJu0YwWx/Vjavz2qdQSryjX9UXHGxw03jt+AoMVB6muVPEaJMrOMcDh
	IqktwGA2dMoitp0Ee/o3Mp0=
X-Google-Smtp-Source: AGHT+IHQSz27xYdC8l13VusKgW8ymoWqjteGO/wj2sa3TzwVQ905mfNPeAsWlsqdiV8MCkI5ddpiug==
X-Received: by 2002:a17:907:7f9e:b0:9c6:8190:359f with SMTP id qk30-20020a1709077f9e00b009c68190359fmr9810526ejc.33.1698679850002;
        Mon, 30 Oct 2023 08:30:50 -0700 (PDT)
Received: from orome.fritz.box (p200300e41f3f4900f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f3f:4900:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id q17-20020a17090622d100b0098921e1b064sm6138533eja.181.2023.10.30.08.30.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Oct 2023 08:30:49 -0700 (PDT)
Date: Mon, 30 Oct 2023 16:30:48 +0100
From: Thierry Reding <thierry.reding@gmail.com>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: Dario Binacchi <dario.binacchi@amarulasolutions.com>,
	linux-kernel@vger.kernel.org, Joerg Roedel <joro@8bytes.org>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Krishna Reddy <vdumpa@nvidia.com>,
	Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>,
	iommu@lists.linux.dev, linux-tegra@vger.kernel.org
Subject: Re: [PATCH] iommu/tegra-smmu: fix error checking for
 debugfs_create_dir()
Message-ID: <ZT_MKDVkqMECiv4I@orome.fritz.box>
References: <20231025110140.2034650-1-dario.binacchi@amarulasolutions.com>
 <1acd75d0-67a7-4a17-99c7-707cca305f37@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="tiC6UW8JeMZZZOlp"
Content-Disposition: inline
In-Reply-To: <1acd75d0-67a7-4a17-99c7-707cca305f37@linux.intel.com>
User-Agent: Mutt/2.2.12 (2023-09-09)


--tiC6UW8JeMZZZOlp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 25, 2023 at 07:25:50PM +0800, Baolu Lu wrote:
> On 2023/10/25 19:01, Dario Binacchi wrote:
> > The return value of debugfs_create_dir() should be checked using the
> > IS_ERR() function.
> >=20
> > Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
> > ---
> >=20
> >   drivers/iommu/tegra-smmu.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
> > index e445f80d0226..cd1d80c4c673 100644
> > --- a/drivers/iommu/tegra-smmu.c
> > +++ b/drivers/iommu/tegra-smmu.c
> > @@ -1056,7 +1056,7 @@ DEFINE_SHOW_ATTRIBUTE(tegra_smmu_clients);
> >   static void tegra_smmu_debugfs_init(struct tegra_smmu *smmu)
> >   {
> >   	smmu->debugfs =3D debugfs_create_dir("smmu", NULL);
> > -	if (!smmu->debugfs)
> > +	if (IS_ERR(smmu->debugfs))
> >   		return;
>=20
> This check can be removed, as debugfs_create_file() can handle the case
> where @parent is an error pointer.

A patch for this has been in linux-next for a few weeks, see:

commit f7da9c081517daba70f9f9342e09d7a6322ba323
Author: Jinjie Ruan <ruanjinjie@huawei.com>
Date:   Fri Sep 1 15:30:56 2023 +0800

    iommu/tegra-smmu: Drop unnecessary error check for for debugfs_create_d=
ir()
   =20
    The debugfs_create_dir() function returns error pointers.
    It never returns NULL.
   =20
    As Baolu suggested, this patch removes the error checking for
    debugfs_create_dir in tegra-smmu.c. This is because the DebugFS kernel =
API
    is developed in a way that the caller can safely ignore the errors that
    occur during the creation of DebugFS nodes. The debugfs APIs have
    a IS_ERR() judge in start_creating() which can handle it gracefully. So
    these checks are unnecessary.
   =20
    Fixes: d1313e7896e9 ("iommu/tegra-smmu: Add debugfs support")
    Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
    Suggested-by: Baolu Lu <baolu.lu@linux.intel.com>
    Acked-by: Thierry Reding <treding@nvidia.com>
    Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
    Link: https://lore.kernel.org/r/20230901073056.1364755-1-ruanjinjie@hua=
wei.com
    Signed-off-by: Joerg Roedel <jroedel@suse.de>

Thierry

--tiC6UW8JeMZZZOlp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmU/zCgACgkQ3SOs138+
s6E+Ew//bfW6yOHM4+iM8OVsK+t0vyqrUeQ74ao0+QMKgBje2qbrxeWcV5cIdeaZ
rL39jdMkomI2H3G7JXUrfqigRkRH6y2ObXU5fPX1VbXG9Olom9wqRiN6xCEDKzP1
hI6EbvDYhHB5otD9t9/NUy926QQLrNs2N1g+fHJZjT4H7oZKUg5U/ayO2ZqfBuPI
pG3kb/n+Yr6IGjGtsFaX3xgp8uu0YFe6znrUqIHXgrxga6DmHCSm/TCjb5ykZMKk
s/8fiZKJlAl+emIvzh3h9vyNqjzCTjz5T84KQIFxJFPytmxGqc0kQlmlUOn65Ren
K6XVfcoy0R1XFY+z6uGZwk31qo72afJSvOIG+T299r16mgTfopBpQhXXW1i/FaM2
s8wYy6C33/GbB3pTtbSSuVxbd5ZwPA/eFXZQfn/Zs+J2BgKJ1eG0DULMnGowcNQq
RHox8DQeQpuL52B7ncg1qc4DACuqZPbK+b1BLQ+T9LWILhDnoMVE+l5LfpmVTcXa
Awt5nJnxPQy85qD4fP8Vij+rLwi82NiJRrQzy+P1efAO512SoYAouJ/trug9LkRT
uhzqFB2tUojtdEtxR57uo0EnX6lX7V13yqNJHIkb5PhgKjFOkzFttHB2cj2wDmxD
L/yGOHwED8cXLV4a/WWFStNKeOlCJfUUGfsShh8lsKcpjExog+Y=
=+7dL
-----END PGP SIGNATURE-----

--tiC6UW8JeMZZZOlp--
