Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BD223EAC82;
	Wed, 20 May 2026 18:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779300875; cv=none; b=kF2eQhpRWYdgjbngFciuE8fKkBN4C3j6KFgqeL+13N0rYS6k4xrNmGg2LBhiScuIxSgiDS3V8L3YzgPaC5iwvBuEsUtd9fy5d98jdZ/0qxP+/ODrSco2ihRM3rqyv3E/um8avuyn4AhQAHMaxZS5TLIbVLPHq3u6VoPgxV2b1ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779300875; c=relaxed/simple;
	bh=alXDT0HTDrZ0vU9K84ji4wLDOI8SK2YegmpOArGpruk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o7JxxVTureshFNB+7OvywnaWf/zQITanWu5kP8k3/S0aCyQpolYiHoxuxVHwoodMsh7Eotoa/M/tu9gt+zUF84LZQFY9dV4s3QEYH3zOX62tmJTlH+ISDpj7E9fPFfpkJp3S36Jq4moRCOYRamG/cBa9RMXi/OV9g3ih62N99ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q4SI655J; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q4SI655J"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61D051F000E9;
	Wed, 20 May 2026 18:14:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779300873;
	bh=BGBszge9vQulelJ4juObSE+D6PPOGDG420pjFZMqYjE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Q4SI655JpsOeDedSSlGyk1TnKl4jp5wgVqnYn+Am9tukdG1cWsV6wErApbFCWzsCt
	 +KaZ7b5TKTaSADkUydBu7Wuy+LR/p5kGWD2PZUicgKqCnCmyxgHVGfswvFjGS4zn3I
	 qTBXYnafMw4J4eg73pr2eFS0dJSaHnWpS9CjKppvhMgZIXFM8c4zw7jjBLs/i81Wt+
	 eCZqMQfWxVygUtMprU8iujT9wL9kiqve0enOEtSEiABfQ4ceH3f1TdJ5OHNVf76lWz
	 d28l3xzlNr+pcrD3Ky2stPnHFlwmVrMoOBDhc0gVB9ih+UENCA3zi+CN5imNuhz2ru
	 5Iy+cTgwsZ5dQ==
Date: Wed, 20 May 2026 11:14:32 -0700
From: Drew Fustini <fustini@kernel.org>
To: Conor Dooley <conor@kernel.org>
Cc: Tomasz Jeznach <tomasz.jeznach@linux.dev>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	iommu@lists.linux.dev, linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Joel Stanley <joel@jms.id.au>, Joerg Roedel <joerg.roedel@amd.com>,
	Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v2] dt-bindings: iommu: riscv: Add bindings for
 Tenstorrent RISC-V IOMMU
Message-ID: <ag36CHVAERc3ZYmi@x1>
References: <20260520061855.1623468-4-fustini@kernel.org>
 <20260520-frayed-fervor-7c887193ab19@spud>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="/FRbjWFmhZcRL80s"
Content-Disposition: inline
In-Reply-To: <20260520-frayed-fervor-7c887193ab19@spud>


--/FRbjWFmhZcRL80s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 20, 2026 at 05:17:41PM +0100, Conor Dooley wrote:

Thanks for the review...

> On Tue, May 19, 2026 at 11:16:28PM -0700, Drew Fustini wrote:
> > From: Nicholas Piggin <npiggin@gmail.com>
> >=20
> > Extend the binding to cover details specific to the Tenstorrent RISC-V
> > IOMMU. In particular, a second register range is added which contains
> > M-privileged registers, e.g., PMAs and PMPs.
> >=20
> > The RISC-V spec S-privileged registers remain in the first register
> > range and are compatible with "riscv,iommu" so the Linux driver does not
> > notice any difference, but the binding will be used by OpenSBI and
> > potentially other M-mode software.
> >=20
> > Reviewed-by: Joel Stanley <joel@jms.id.au>
> > Acked-by: Joerg Roedel <joerg.roedel@amd.com>
> > Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> > [fustini: fix dt_binding_check errors]
> > Signed-off-by: Drew Fustini <fustini@kernel.org>
> > ---
> > v2 changes:
> > - Fix dt_binding_check errors
> > - Add the Acked-by: from Joerg
> > - Drop RFC prefix
> >=20
> > Link to v1:
> > https://lore.kernel.org/lkml/20260310003850.3837030-1-npiggin@gmail.com/
> >=20
> >  .../bindings/iommu/riscv,iommu.yaml           | 62 ++++++++++++++++---
> >  1 file changed, 55 insertions(+), 7 deletions(-)
> >=20
> > diff --git a/Documentation/devicetree/bindings/iommu/riscv,iommu.yaml b=
/Documentation/devicetree/bindings/iommu/riscv,iommu.yaml
> > index d4838c3b3741..5aad8cf67840 100644
> > --- a/Documentation/devicetree/bindings/iommu/riscv,iommu.yaml
> > +++ b/Documentation/devicetree/bindings/iommu/riscv,iommu.yaml
> > @@ -32,22 +32,35 @@ properties:
> >    # should be specified along with 'reg' property providing MMIO locat=
ion.
> >    compatible:
> >      oneOf:
> > -      - items:
> > +      - description: Platform (non-PCIe) IOMMU implementations
> > +        items:
> >            - enum:
> >                - qemu,riscv-iommu
> >            - const: riscv,iommu
> > -      - items:
> > +      - description: PCIe IOMMU implementations
> > +        items:
> >            - enum:
> >                - pci1efd,edf1
> >            - const: riscv,pci-iommu
> > +      - description: Tenstorrent IOMMUs implementing "riscv,iommu"
> > +        items:
> > +          - enum:
> > +              - tenstorrent,riscv-iommu
> > +          - const: riscv,iommu
>=20
> You should be able to put this into the enum alongside the qemu
> compatible, right?

Good point, I'll move tenstorrent,riscv-iommu to the enum with
qemu,riscv-iommu.

> > +allOf:
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          contains:
> > +            enum:
> > +              - tenstorrent,riscv-iommu
> > +    then:
> > +      properties:
> > +        reg:
>=20
> > +          items:
> > +            - description: IOMMU base registers
> > +            - description: Tenstorrent IOMMU machine mode registers.
>=20
> Should this also have minItems: 2?

I think items: with 2 items implies minItems: 2 but I see your later
point about the description and names don't belong in the allOf: block.

>=20
> > +        reg-names:
>=20
> > +          items:
> > +            - const: base
> > +            - const: machine
> > +              description:
> > +                Region containing platform specific MMRs for machine-m=
ode
> > +                configuration, such as PMA and PMP registers.
>=20
> And this you should replace with minItems: 2 or delete. The reg property
> is where your description here belongs and all the names do here is
> re-list what's available outside the condition.

Ah, so I just have minItems: 2 here and rely on the reg: section to have
the descriptions.

> > +  - |+
> > +    /* Example 5 (Tenstorrent IOMMU device with MSIs) */
> > +    iommu5: iommu@d2020000 {
> > +        compatible =3D "tenstorrent,riscv-iommu", "riscv,iommu";
> > +        reg =3D <0xd2020000 0x10000 0xaa000000 0x10000>;
>=20
> This is not the correct format for multiple reg properties. Hint: you're
> missing ">, <".

Thanks, I'll fix that.

-Drew

--/FRbjWFmhZcRL80s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSy8G7QpEpV9aCf6Lbb7CzD2SixDAUCag36AAAKCRDb7CzD2Six
DAbHAQDI8harIo/I9V4a7tM1mvAiTRjwsbfDx9qcEXfqctGFxQEAqNTzD7k59K0s
62Yzl0w6qzRZRPFcwzTyMIchGmGu0wI=
=T+gz
-----END PGP SIGNATURE-----

--/FRbjWFmhZcRL80s--
