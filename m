Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D8EB32B9B5;
	Wed, 20 May 2026 16:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779293868; cv=none; b=bDPfxzkEyKHFFT+d43v4zHKM66PT9Vaq6EEVhALkNXb1MwqdEvMmr0esSamtfcOtTdhZ/sbpzrNB/S3tb+Eez4KuJP6SeRQTI1Lwzlks61KjCsuyzEISE191zEC7+lhuRqxAxZv+GxtUcglIHSQGXgogkgplm+PwAewztBwqemc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779293868; c=relaxed/simple;
	bh=b3vKhjIYlsPeDXkc73gbpzqKiZ/oByXD2DsPE/pC1+E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PH0w4iNTZY1AEBzpQjeEeiXo6SSC5t/DEd1JbJM9Q7NaotKWgZFPLWNPPPPTS+Z5Zrsy2dZc+WXu5Tzbdyz4yDEXydOzrr0jlB8G4u8Rv1OHpFX7cQAV6//oHRWxSf+n5QRKwzz34GxA3lLH+yivuShR1q+jjp4KnHdkkbMrv/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iUvpkw++; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iUvpkw++"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89BEE1F000E9;
	Wed, 20 May 2026 16:17:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779293867;
	bh=50nNEwYXko+BmsraW2yGRNKOx6hjeiwEGQR9Xa9Nd+Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=iUvpkw++CXIDgG39Hc92KF9gYAxLGGJGnbXyRg4pKhWDoC3DfFeRUb3X9LuneUjao
	 FXZ/2WUd3RR/KmWcQxc8Y+LTIHA8pAtaRS8sNpCuAoVMnRAZ2PIlWEazDltWGgR9ud
	 CAu20QC9a2NmorfhH4yxKQV2gvL3jFfA2k4qGJ2sPw6MQSn5vDInLNTOIk1l5OAzbn
	 s9i1VQZUa/kXQfJOIpqrjknzEJQR0W3l4O0Fi5e6s6x/pHCmGJK1w0+vQ2nNu5C0gU
	 f1KthJu7CI80H1N9UL5aaMwgwTJoXyvpifKmMkkxWAC/N+WsmxZeHrdwgJ5B5FApkv
	 AyigbNF5qMKgg==
Date: Wed, 20 May 2026 17:17:41 +0100
From: Conor Dooley <conor@kernel.org>
To: Drew Fustini <fustini@kernel.org>
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
Message-ID: <20260520-frayed-fervor-7c887193ab19@spud>
References: <20260520061855.1623468-4-fustini@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="NGNLZDzmLzoPMudc"
Content-Disposition: inline
In-Reply-To: <20260520061855.1623468-4-fustini@kernel.org>


--NGNLZDzmLzoPMudc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 19, 2026 at 11:16:28PM -0700, Drew Fustini wrote:
> From: Nicholas Piggin <npiggin@gmail.com>
>=20
> Extend the binding to cover details specific to the Tenstorrent RISC-V
> IOMMU. In particular, a second register range is added which contains
> M-privileged registers, e.g., PMAs and PMPs.
>=20
> The RISC-V spec S-privileged registers remain in the first register
> range and are compatible with "riscv,iommu" so the Linux driver does not
> notice any difference, but the binding will be used by OpenSBI and
> potentially other M-mode software.
>=20
> Reviewed-by: Joel Stanley <joel@jms.id.au>
> Acked-by: Joerg Roedel <joerg.roedel@amd.com>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> [fustini: fix dt_binding_check errors]
> Signed-off-by: Drew Fustini <fustini@kernel.org>
> ---
> v2 changes:
> - Fix dt_binding_check errors
> - Add the Acked-by: from Joerg
> - Drop RFC prefix
>=20
> Link to v1:
> https://lore.kernel.org/lkml/20260310003850.3837030-1-npiggin@gmail.com/
>=20
>  .../bindings/iommu/riscv,iommu.yaml           | 62 ++++++++++++++++---
>  1 file changed, 55 insertions(+), 7 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/iommu/riscv,iommu.yaml b/D=
ocumentation/devicetree/bindings/iommu/riscv,iommu.yaml
> index d4838c3b3741..5aad8cf67840 100644
> --- a/Documentation/devicetree/bindings/iommu/riscv,iommu.yaml
> +++ b/Documentation/devicetree/bindings/iommu/riscv,iommu.yaml
> @@ -32,22 +32,35 @@ properties:
>    # should be specified along with 'reg' property providing MMIO locatio=
n.
>    compatible:
>      oneOf:
> -      - items:
> +      - description: Platform (non-PCIe) IOMMU implementations
> +        items:
>            - enum:
>                - qemu,riscv-iommu
>            - const: riscv,iommu
> -      - items:
> +      - description: PCIe IOMMU implementations
> +        items:
>            - enum:
>                - pci1efd,edf1
>            - const: riscv,pci-iommu
> +      - description: Tenstorrent IOMMUs implementing "riscv,iommu"
> +        items:
> +          - enum:
> +              - tenstorrent,riscv-iommu
> +          - const: riscv,iommu

You should be able to put this into the enum alongside the qemu
compatible, right?

> =20
>    reg:
> -    maxItems: 1
> +    minItems: 1
> +    maxItems: 2
>      description:
> -      For non-PCI devices this represents base address and size of for t=
he
> -      IOMMU memory mapped registers interface.
> -      For PCI IOMMU hardware implementation this should represent an add=
ress
> -      of the IOMMU, as defined in the PCI Bus Binding reference.
> +      For non-PCI devices the first item represents base address and siz=
e of
> +      for the IOMMU memory mapped registers interface.
> +      For PCI IOMMU hardware implementation the first item should repres=
ent
> +      an address of the IOMMU, as defined in the PCI Bus Binding referen=
ce.
> +
> +  reg-names:
> +    items:
> +      - const: base
> +      - const: machine
> =20
>    '#iommu-cells':
>      const: 1
> @@ -75,6 +88,31 @@ required:
> =20
>  additionalProperties: false
> =20
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - tenstorrent,riscv-iommu
> +    then:
> +      properties:
> +        reg:

> +          items:
> +            - description: IOMMU base registers
> +            - description: Tenstorrent IOMMU machine mode registers.

Should this also have minItems: 2?

> +        reg-names:

> +          items:
> +            - const: base
> +            - const: machine
> +              description:
> +                Region containing platform specific MMRs for machine-mode
> +                configuration, such as PMA and PMP registers.

And this you should replace with minItems: 2 or delete. The reg property
is where your description here belongs and all the names do here is
re-list what's available outside the condition.

> +    else:
> +      properties:
> +        reg:
> +          maxItems: 1
> +
>  examples:
>    - |+
>      /* Example 1 (IOMMU device with wired interrupts) */
> @@ -145,3 +183,13 @@ examples:
>              };
>          };
>      };
> +
> +  - |+
> +    /* Example 5 (Tenstorrent IOMMU device with MSIs) */
> +    iommu5: iommu@d2020000 {
> +        compatible =3D "tenstorrent,riscv-iommu", "riscv,iommu";
> +        reg =3D <0xd2020000 0x10000 0xaa000000 0x10000>;

This is not the correct format for multiple reg properties. Hint: you're
missing ">, <".

pw-bot: changes-requested

Cheers,
Conor.

> +        reg-names =3D "base", "machine";
> +        msi-parent =3D <&imsics_smode>;
> +        #iommu-cells =3D <1>;
> +    };
> --=20
> 2.43.0
>=20

--NGNLZDzmLzoPMudc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCag3epQAKCRB4tDGHoIJi
0kjMAQDoJlJN2dTEH+xMoB8Mnr78NFamKp3i7rYNk1U2RW83OQEA0Id4LMpNIS3S
WT9+SVPfv7/qcHgFS9fmA8jE5nXmkgI=
=qrOu
-----END PGP SIGNATURE-----

--NGNLZDzmLzoPMudc--
