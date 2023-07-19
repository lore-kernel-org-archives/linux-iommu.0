Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BDA621D28
	for <iommu@lists.linux.dev>; Wed, 19 Jul 2023 20:19:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70FB1C433C8;
	Wed, 19 Jul 2023 20:19:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689797997;
	bh=+dRRWDjMNsYP/s7Jniar5mhvGn3xDY3jYCFUH3EoL8w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WS0Ci6PnEzXe8FvM2OwXBaLdxs8wGr6ur37QLLE46pd6CMwtoICb0cl2iHqKtWbsb
	 YG57ZmOPYJdlwG0uXGl4w7lrrP1XVGGGs3JaEaLVjFn0G+UWBuCZ9keitg68vszqqb
	 YWQnzTscGMwBrYW/B1LwYA0nz7So4n1dCPpXoZGVJyQSmSTmPhh5jzNRlTFH/jT1Hm
	 WzRyYgFy0DAEx17XxM/wkdDURWgDVPw+Tx+WJBt/JxR8FlJ7byOMYIu+7p6Kof/VWa
	 6eqJ7K/viKaaJI2IPwyhBbhWEA0LX5X82faSk+MSDgwa7S2H7JkbqpyyhbN8XzAbH6
	 lcoUi08WziQ4A==
Date: Wed, 19 Jul 2023 21:19:52 +0100
From: Conor Dooley <conor@kernel.org>
To: Tomasz Jeznach <tjeznach@rivosinc.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Anup Patel <apatel@ventanamicro.com>,
	Albert Ou <aou@eecs.berkeley.edu>, linux@rivosinc.com,
	linux-kernel@vger.kernel.org, Sebastien Boeuf <seb@rivosinc.com>,
	iommu@lists.linux.dev, Palmer Dabbelt <palmer@dabbelt.com>,
	Nick Kossifidis <mick@ics.forth.gr>,
	linux-riscv@lists.infradead.org, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 03/11] dt-bindings: Add RISC-V IOMMU bindings
Message-ID: <20230719-unnoticed-scion-744fdf509151@spud>
References: <cover.1689792825.git.tjeznach@rivosinc.com>
 <d62ceb33620cab766d809e6bbf30eaf5b46bc955.1689792825.git.tjeznach@rivosinc.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="rMk0Zx7WotLw1fRI"
Content-Disposition: inline
In-Reply-To: <d62ceb33620cab766d809e6bbf30eaf5b46bc955.1689792825.git.tjeznach@rivosinc.com>


--rMk0Zx7WotLw1fRI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Tomasz,

On Wed, Jul 19, 2023 at 12:33:47PM -0700, Tomasz Jeznach wrote:
> From: Anup Patel <apatel@ventanamicro.com>
>=20
> We add DT bindings document for RISC-V IOMMU platform and PCI devices
> defined by the RISC-V IOMMU specification.
>=20
> Signed-off-by: Anup Patel <apatel@ventanamicro.com>

Your signoff is missing from here.

Secondly, as get_maintainer.pl would have told you, dt-bindings patches
need to be sent to the dt-binding maintainers and list.
+CC maintainers & list.

Thirdly, dt-binding patches should come before their users.

> ---
>  .../bindings/iommu/riscv,iommu.yaml           | 146 ++++++++++++++++++
>  1 file changed, 146 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iommu/riscv,iommu.y=
aml
>=20
> diff --git a/Documentation/devicetree/bindings/iommu/riscv,iommu.yaml b/D=
ocumentation/devicetree/bindings/iommu/riscv,iommu.yaml
> new file mode 100644
> index 000000000000..8a9aedb61768
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iommu/riscv,iommu.yaml
> @@ -0,0 +1,146 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iommu/riscv,iommu.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: RISC-V IOMMU Implementation
> +
> +maintainers:
> +  - Tomasz Jeznach <tjeznach@rivosinc.com>

What about Anup, who seems to have written this?
Or your co-authors of the drivers?

> +
> +description:
> +  The RISC-V IOMMU specificaiton defines an IOMMU for RISC-V platforms
> +  which can be a regular platform device or a PCI device connected to
> +  the host root port.
> +
> +  The RISC-V IOMMU provides two stage translation, device directory tabl=
e,
> +  command queue and fault reporting as wired interrupt or MSIx event for
> +  both PCI and platform devices.
> +
> +  Visit https://github.com/riscv-non-isa/riscv-iommu for more details.
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - description: RISC-V IOMMU as a platform device
> +        items:
> +          - enum:
> +              - vendor,chip-iommu

These dummy compatibles are not valid, as was pointed out to Anup on
the AIA series. Please go look at what was done there instead:
https://lore.kernel.org/all/20230719113542.2293295-7-apatel@ventanamicro.co=
m/

> +          - const: riscv,iommu
> +
> +      - description: RISC-V IOMMU as a PCI device connected to root port
> +        items:
> +          - enum:
> +              - vendor,chip-pci-iommu
> +          - const: riscv,pci-iommu

I'm not really au fait with the arm smmu stuff, but do any of its
versions support being connected to a root port?=20

> +  reg:
> +    maxItems: 1
> +    description:
> +      For RISC-V IOMMU as a platform device, this represents the MMIO ba=
se
> +      address of registers.
> +
> +      For RISC-V IOMMU as a PCI device, this represents the PCI-PCI brid=
ge
> +      details as described in Documentation/devicetree/bindings/pci/pci.=
txt
> +
> +  '#iommu-cells':
> +    const: 2
> +    description: |

|s are only needed where formatting needs to be preserved.

> +      Each IOMMU specifier represents the base device ID and number of
> +      device IDs.
> +
> +  interrupts:
> +    minItems: 1
> +    maxItems: 16

What are any of these interrupts?

> +    description:
> +      The presence of this property implies that given RISC-V IOMMU uses
> +      wired interrupts to notify the RISC-V HARTS (or CPUs).
> +
> +  msi-parent:
> +    description:
> +      The presence of this property implies that given RISC-V IOMMU uses
> +      MSIx to notify the RISC-V HARTs (or CPUs). This property should be
> +      considered only when the interrupts property is absent.
> +
> +  dma-coherent:

RISC-V is dma-coherent by default, should this not be dma-noncoherent
instead?

> +    description:
> +      Present if page table walks and DMA accessed made by the RISC-V IO=
MMU
> +      are cache coherent with the CPU.
> +
> +  power-domains:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - '#iommu-cells'
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    /* Example 1 (IOMMU platform device with wired interrupts) */
> +    immu1: iommu@1bccd000 {

Why is this "immu"? typo or intentional?

> +        compatible =3D "vendor,chip-iommu", "riscv,iommu";
> +        reg =3D <0x1bccd000 0x1000>;
> +        interrupt-parent =3D <&aplic_smode>;
> +        interrupts =3D <32 4>, <33 4>, <34 4>, <35 4>;
> +        #iommu-cells =3D <2>;
> +    };
> +
> +    /* Device with two IOMMU device IDs, 0 and 7 */
> +    master1 {
> +        iommus =3D <&immu1 0 1>, <&immu1 7 1>;
> +    };
> +
> +  - |
> +    /* Example 2 (IOMMU platform device with MSIs) */
> +    immu2: iommu@1bcdd000 {
> +        compatible =3D "vendor,chip-iommu", "riscv,iommu";
> +        reg =3D <0x1bccd000 0x1000>;
> +        msi-parent =3D <&imsics_smode>;
> +        #iommu-cells =3D <2>;
> +    };
> +
> +    bus {
> +        #address-cells =3D <2>;
> +        #size-cells =3D <2>;
> +
> +        /* Device with IOMMU device IDs ranging from 32 to 64 */
> +        master1 {
> +                iommus =3D <&immu2 32 32>;
> +        };
> +
> +        pcie@40000000 {
> +            compatible =3D "pci-host-cam-generic";
> +            device_type =3D "pci";
> +            #address-cells =3D <3>;
> +            #size-cells =3D <2>;
> +            bus-range =3D <0x0 0x1>;
> +
> +            /* CPU_PHYSICAL(2)  SIZE(2) */

These sort of comments seem to just repeat what address-cells &
size-cells has already said, no?

Thanks,
Conor.

--rMk0Zx7WotLw1fRI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZLhFaAAKCRB4tDGHoIJi
0nJLAP0chtdgZE2gZpCi3AaJW9Pe70I3FRYkI9zS5Qvk8D3hVgEApzDYB3fpvX25
uBuRjV6v3RlnZVVcq1tK0tkOckbX5wQ=
=MtQU
-----END PGP SIGNATURE-----

--rMk0Zx7WotLw1fRI--
