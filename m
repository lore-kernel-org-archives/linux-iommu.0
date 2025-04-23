Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C531B1EB5DB
	for <iommu@lists.linux.dev>; Wed, 23 Apr 2025 00:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745369385; cv=none; b=Jpmx851u44E2BqjvjUJq+3HwDi1YSF8UYl/6iYAD/pXODVAXxmwZHvqYGjrmYCyan/DuiqAT0uvfsGwrkiOytNcYy+Ren9sCTM0dyJTRaXB8j1CqyqyI4owyi2mzazSBr9bg6rtsHx+7QOdupVP/eFY8SDl4aLzWMDSXqYukRZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745369385; c=relaxed/simple;
	bh=jBPIBabkzrFOOQQwwHw5ecxZZU/Hd7iJJ9SE8CoDgxg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=awArPRiSHDcoJOQGHFo6SRoodwTzUYi3RBT2v11s6acetdECf0z9U3UOasEoYPAivieZ0F/C6vVmtYPuN+Tm6/xf7AbKOZrHQi7N8/GGpq96Lu2bURPtDmX7QNT0y1QT0HnRgjp88Gc7woyl/UXfR2iHQiJ18/+viy6+KBYV4Rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=MnbNLGo5; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="MnbNLGo5"
Date: Tue, 22 Apr 2025 20:49:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1745369381;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jolpnzqBJC76dGIx+wLxcnOr5e8HUwAoVgt4XMVdOIg=;
	b=MnbNLGo5u9aflgcq4BpTwi3ql3OrswS9g0Fn7jCYHozlWIjLm8ZwuaC71zZhVUGnc75woi
	J7haRgY7k7+1H2+a7ZFCXA/ik4urvncEVtRLL2lFk01XDio5maIZRnztOHPrcqCKr35P63
	mQWMB6fXzEbj+V77DWupvgMwtrhEH/8=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ben Collins <ben.collins@linux.dev>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>, 
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] fsl_pamu: Use 40-bits for addressing where appropriate
Message-ID: <2025042220-courageous-hyena-c5076b@boujee-and-buff>
Mail-Followup-To: Jason Gunthorpe <jgg@ziepe.ca>, iommu@lists.linux.dev, 
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <2025042122-prudent-dogfish-eac6bf@boujee-and-buff>
 <20250422190921.GB1213339@ziepe.ca>
 <2025042218-beneficial-wildcat-77dd3e@boujee-and-buff>
 <20250422234305.GE1213339@ziepe.ca>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="4pqwsvg6fw4bmp2w"
Content-Disposition: inline
In-Reply-To: <20250422234305.GE1213339@ziepe.ca>
X-Migadu-Flow: FLOW_OUT


--4pqwsvg6fw4bmp2w
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] fsl_pamu: Use 40-bits for addressing where appropriate
MIME-Version: 1.0

On Tue, Apr 22, 2025 at 08:43:05PM -0500, Jason Gunthorpe wrote:
> On Tue, Apr 22, 2025 at 06:21:32PM -0400, Ben Collins wrote:
> > On Tue, Apr 22, 2025 at 04:09:21PM -0500, Jason Gunthorpe wrote:
> > > On Mon, Apr 21, 2025 at 10:46:19PM -0400, Ben Collins wrote:
> > > > diff --git a/drivers/iommu/fsl_pamu_domain.c b/drivers/iommu/fsl_pa=
mu_domain.c
> > > > index 30be786bff11e..a4bc6482a00f7 100644
> > > > --- a/drivers/iommu/fsl_pamu_domain.c
> > > > +++ b/drivers/iommu/fsl_pamu_domain.c
> > > > @@ -214,9 +214,10 @@ static struct iommu_domain *fsl_pamu_domain_al=
loc(unsigned type)
> > > >  	INIT_LIST_HEAD(&dma_domain->devices);
> > > >  	spin_lock_init(&dma_domain->domain_lock);
> > > > =20
> > > > -	/* default geometry 64 GB i.e. maximum system address */
> > > > +	/* Set default geometry based on physical address limit. */
> > > >  	dma_domain->iommu_domain. geometry.aperture_start =3D 0;
> > > > -	dma_domain->iommu_domain.geometry.aperture_end =3D (1ULL << 36) -=
 1;
> > > > +	dma_domain->iommu_domain.geometry.aperture_end =3D
> > > > +		(1ULL << PAMU_MAX_PHYS_BITS) - 1;
> > > >  	dma_domain->iommu_domain.geometry.force_aperture =3D true;
> > >=20
> > > What on earth does this even do? There is no map_range() callback in
> > > this driver, so nothing should be reading geometry..
> >=20
> > I dunno, but your "FIXME this is broken" comments are all over it from a
> > year and a half ago:
>=20
> Yes, I know, but you are changing this - are you changing it because
> something is broken without making this change, if so what, or are you
> changing it because it looked like it needed changing?
>=20
> > The logic hasn't really been touched in 10 years.
>=20
> Yeah, so I'm surprised someone still cares about it :)

Ironically, this patch sat collecting dust for 10 years until recently
when I revived my T4240 system :)

The change is mostly to be "correct" in as much as the code can be
correct when it's a little broken. Does it fix anything? It does. PAMU
gets a little miffed about my liodn tags being up near the 1TiB boundary.

If it makes you feel any better about it, I've added fsl_pamu to the
list of things I'm fixing for this board, for the hell of it. I have a
pex8724 to program to get 2 of the 4 nvme slots up, a DPAA driver to
build to get the RIO up (and likely some tweaking to program the IDT SRIO
switch to work across the fabric).

IOW, I think I can maybe help get rid of your FIXMEs. For reference:

https://www.manualslib.com/manual/1061198/Vvdn-T4mfcs-Scaleout.html

Plus I have a couple P4080 systems for regression testing with a 36-bit
addressing space.

--=20
 Ben Collins
 https://libjwt.io
 https://github.com/benmcollins
 --
 3EC9 7598 1672 961A 1139  173A 5D5A 57C7 242B 22CF

--4pqwsvg6fw4bmp2w
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEPsl1mBZylhoRORc6XVpXxyQrIs8FAmgIOSEACgkQXVpXxyQr
Is8yEA//dOT4mcL1ndAWfPtP79qsvj3ISOiHns3yG0hWTd60fHTZG9KAaG/2r8eb
QdTeMbsleUsEVHZDsjf1qvi1TK4/6oveTptzWeVepGymL1wjMty2Iaen9RkzJqzw
Qp5KooKFsyIdeYoeDZUI1TFLcVvO7fSUAjEes9TQwhgk+rmOF6rmWoxqFlnT+UeL
Ln3MB8TZdyr1whxBSRKvjNkIX2XiLsOdyr6sS1cqn9nNtXQS9HZ4BYf9CtlvkuJi
FsjgAWjFK7rlEtrs1fkozoWqYD3Ysm/ltJ+ElzdeJJcjo3SQeCmxNXQaWJFNvqbY
2mdgqQG0L5IxbgBiyRIPHzNgbcIhApuoYDMd7Xm0oLE4+tkwo3KaQohydBSZJldB
zXmM/HcN4Eqh1QSeai81KM7wK91A1Dy41HTrdg/g7jXTnbfXyMxtAyrtKCz5w3uO
eYdZGtEBFahpStVZU80GayoqCRD/76H8WXa3YxHOm/r45j8ovay0AqNcSrz/s6dl
eCNd7qm6rOgVoUbQqsZkgo+F6wMLViY7PHF3Epe7DlAFuPBtlerneaC/mtvXJjj6
cFSa9IqFLi/9G4g1XtErzWy1bQ79bSK10d2UKjgcs5vfsRX9BGUMUqyPiWfLgJAB
IKONOASzu9VxJhxh6l3qnFsjoWyH4pZ4Gk434HTP+JO8G4MZk4Q=
=gVYE
-----END PGP SIGNATURE-----

--4pqwsvg6fw4bmp2w--
