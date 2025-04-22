Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23BCB19F13F
	for <iommu@lists.linux.dev>; Tue, 22 Apr 2025 22:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745360503; cv=none; b=rDM/wQsEa9BMVuURYkwLKCMNm6eEsCEd0LWc3u5AkVxJvSWqC5x2OEIvGalrtkX3xdPUOGc34x+IdDQ0DZ8Y3tDGdA0mwufzHE5H3+TEtWUIVCcOo0Wx0lwYmcqg61xPNefAIxrUn6PGx8bnBOTILWXbwB+7FlkuFMnT3umtNHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745360503; c=relaxed/simple;
	bh=OMajJGOYOM80T8XOi8EmEsK5+/OYko020cjWF3DYVFE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NlgUzEQ9JJl/KGaqMv1XDex/jaJN+dkRkgT6nY/CsOi4TGAKxn9rwzNQCEhRpJlu6k5geu1WERsDlqCRL/+7+DcwhFW+Y9Rth73QzC4potheohf3EWSj56IrO4eSt8UUmvOEk0/vMCRz93hQowDkdbg3d75DYJ3xmkQx+i+MhpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=OYw7mRRn; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="OYw7mRRn"
Date: Tue, 22 Apr 2025 18:21:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1745360498;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1kjDPiTvtrUS828kXClEO+meshTtGoc7Lw5B1i+KsT4=;
	b=OYw7mRRnyhGu94Y30UFMbMR+XjM8+Q/9gIeWcdXGKDL63oxVaeWij5Tr1MoYhvxQb+2Eam
	m/gGTcGPetWw67JTRjIHukoRM2dFhtS7WAMns0Brqy8FkKeN9BJRS6ZGG0wryHBzi7EL2a
	usVjI0h7YYuGiv0FHu3O3VO0OKRKtlc=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ben Collins <ben.collins@linux.dev>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>, 
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] fsl_pamu: Use 40-bits for addressing where appropriate
Message-ID: <2025042218-beneficial-wildcat-77dd3e@boujee-and-buff>
Mail-Followup-To: Jason Gunthorpe <jgg@ziepe.ca>, iommu@lists.linux.dev, 
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <2025042122-prudent-dogfish-eac6bf@boujee-and-buff>
 <20250422190921.GB1213339@ziepe.ca>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="plgvsw3l3hufgtb4"
Content-Disposition: inline
In-Reply-To: <20250422190921.GB1213339@ziepe.ca>
X-Migadu-Flow: FLOW_OUT


--plgvsw3l3hufgtb4
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] fsl_pamu: Use 40-bits for addressing where appropriate
MIME-Version: 1.0

On Tue, Apr 22, 2025 at 04:09:21PM -0500, Jason Gunthorpe wrote:
> On Mon, Apr 21, 2025 at 10:46:19PM -0400, Ben Collins wrote:
> > diff --git a/drivers/iommu/fsl_pamu_domain.c b/drivers/iommu/fsl_pamu_d=
omain.c
> > index 30be786bff11e..a4bc6482a00f7 100644
> > --- a/drivers/iommu/fsl_pamu_domain.c
> > +++ b/drivers/iommu/fsl_pamu_domain.c
> > @@ -214,9 +214,10 @@ static struct iommu_domain *fsl_pamu_domain_alloc(=
unsigned type)
> >  	INIT_LIST_HEAD(&dma_domain->devices);
> >  	spin_lock_init(&dma_domain->domain_lock);
> > =20
> > -	/* default geometry 64 GB i.e. maximum system address */
> > +	/* Set default geometry based on physical address limit. */
> >  	dma_domain->iommu_domain. geometry.aperture_start =3D 0;
> > -	dma_domain->iommu_domain.geometry.aperture_end =3D (1ULL << 36) - 1;
> > +	dma_domain->iommu_domain.geometry.aperture_end =3D
> > +		(1ULL << PAMU_MAX_PHYS_BITS) - 1;
> >  	dma_domain->iommu_domain.geometry.force_aperture =3D true;
>=20
> What on earth does this even do? There is no map_range() callback in
> this driver, so nothing should be reading geometry..

I dunno, but your "FIXME this is broken" comments are all over it from a
year and a half ago:

Author: Jason Gunthorpe <jgg@ziepe.ca>
Date:   Wed Sep 13 10:43:38 2023 -0300

    iommu/fsl_pamu: Implement a PLATFORM domain

       /*
        * FIXME: This isn't creating an unmanaged domain since the
        * default_domain_ops do not have any map/unmap function it doesn't =
meet
        * the requirements for __IOMMU_DOMAIN_PAGING. The only purpose seem=
s to
        * allow drivers/soc/fsl/qbman/qman_portal.c to do
        * fsl_pamu_configure_l1_stash()
        */

The logic hasn't really been touched in 10 years.

--=20
 Ben Collins
 https://libjwt.io
 https://github.com/benmcollins
 --
 3EC9 7598 1672 961A 1139  173A 5D5A 57C7 242B 22CF

--plgvsw3l3hufgtb4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEPsl1mBZylhoRORc6XVpXxyQrIs8FAmgIFmwACgkQXVpXxyQr
Is+CzRAAq4Doy76vP/uvrf7LUhsshA5BRHPEh895UKM7rKUTz85JnB71LPZMOFvY
tPQ5Eb+LCiFfLS4tz+0TvTxsNQkTIoD8nPslbzW7HYOphrvJsetEmK/MzFtJD03M
JBRM4gGZzAxDZ1la8k7Jy2AUHhYbHGareuy84OU99Vb45rtMdXJ9maontA+kuPkT
uqjyAN5R86A1rG5DQWkIHQ500AN3+OR0BnZJPlYY2ehp0c3HpCSNPC7/hntoOCrl
MlMMF+WxsZ3PVnA9Ym4/fzzhQ+9fDkiqd7+wXqaLTGocfY7L3CAxQz4xphhuxBQd
SOO9Fk0mKaRt/bTfl39Yq/xYewLLvRT1yVD2dWEhwV7PVqG4oHL3fQBjaoBVxrdY
4sBjdevOxpwEujcSc10H4cNuFvUuHjpfN6QOnbwo9AOzEppQsxwbReXYpSiWCtgx
uG8MWTUyLLEJqe1q+eIioE0BuVLigduyuBLZzOKkbA1N1QRb9IOoE8+dUbmDLdHS
Ty0QMK1xQpdmhit6qUzR3wU4m+PGj7yVR6MR6eERzjt4WL418MdSg+H0YfjLiEFF
ZzIuJrvKeP9hxfaZ65tyqecjcm7CoO0MD8npjO7D1zuj8CAcAezSrxgrawCXBX5P
reBSfzP/zFm1Cy6Ps5GtW38eMzK/AOyE2T3K0u9Bm/cGFG3qqR4=
=cpPe
-----END PGP SIGNATURE-----

--plgvsw3l3hufgtb4--
