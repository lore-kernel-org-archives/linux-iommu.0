Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB9D22EC16
	for <iommu@lists.linux.dev>; Wed, 14 Jun 2023 19:27:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4C2FC433C0;
	Wed, 14 Jun 2023 19:27:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1686770849;
	bh=T2ORHO5yFSlNbPCHm8exnTbQMAiovym6Yw8Agz5UFng=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mTMCil+hklnlF1wdBdgexpCOuFi7k1H8k1v4rWagRqV3dxUorHBVWLvou82XCQT8/
	 jGgNlk8Ejwuimir91p35ihiH6bHZUUrwQqRDeRZgQL1tDYxS/Ig7Y28b2KpoP74PQP
	 kjFwt2HNJmkbJL06LaIx9f95tFxmKDQAkPlvRt0PTrDM/HhW3/Bm1lH46mPgZ2kYA3
	 AkRZ7zBaMSKFK5ptaSPTUDDg+omBNLLOKpL41HRYpqsUsDS37laN3QtBlcz1E3dMGk
	 JXhBGHlC+rn9z6ohcuooizlA1WQTPc5Jc1eq9JeNUTEIu7fvwCZjNQBV1UBO6JP6Ck
	 2bTCSnLKgL2KQ==
Date: Wed, 14 Jun 2023 20:27:23 +0100
From: Conor Dooley <conor@kernel.org>
To: Anup Patel <apatel@ventanamicro.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <maz@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Frank Rowand <frowand.list@gmail.com>,
	Atish Patra <atishp@atishpatra.org>,
	Andrew Jones <ajones@ventanamicro.com>,
	Saravana Kannan <saravanak@google.com>,
	Anup Patel <anup@brainfault.org>, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	iommu@lists.linux.dev
Subject: Re: [PATCH v4 07/10] dt-bindings: interrupt-controller: Add RISC-V
 advanced PLIC
Message-ID: <20230614-devotee-repave-37d670dbfb7c@spud>
References: <20230613153415.350528-1-apatel@ventanamicro.com>
 <20230613153415.350528-8-apatel@ventanamicro.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="5BjMorMatJMI/kO2"
Content-Disposition: inline
In-Reply-To: <20230613153415.350528-8-apatel@ventanamicro.com>


--5BjMorMatJMI/kO2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hey Anup,

Mostly looks good, once minor comment.

On Tue, Jun 13, 2023 at 09:04:12PM +0530, Anup Patel wrote:

> +  riscv,children:
> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> +    minItems: 1
> +    maxItems: 1024
> +    items:
> +      maxItems: 1
> +    description:
> +      A list of child APLIC domains for the given APLIC domain. Each child
> +      APLIC domain is assigned a child index in increasing order, with the
> +      first child APLIC domain assigned child index 0. The APLIC domain child
> +      index is used by firmware to delegate interrupts from the given APLIC
> +      domain to a particular child APLIC domain.
> +
> +  riscv,delegation:
> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> +    minItems: 1
> +    maxItems: 1024
> +    items:
> +      items:
> +        - description: child APLIC domain phandle
> +        - description: first interrupt number of the parent APLIC domain (inclusive)
> +        - description: last interrupt number of the parent APLIC domain (inclusive)
> +    description:
> +      A interrupt delegation list where each entry is a triple consisting
> +      of child APLIC domain phandle, first interrupt number of the parent
> +      APLIC domain, and last interrupt number of the parent APLIC domain.
> +      Firmware must configure interrupt delegation registers based on
> +      interrupt delegation list.
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupt-controller
> +  - "#interrupt-cells"
> +  - riscv,num-sources
> +
> +anyOf:
> +  - required:
> +      - interrupts-extended
> +  - required:
> +      - msi-parent

Not sure if you missed this from the last version, but I asked if we
needed a
	dependencies:
	  riscv,delegate: [ riscv,children ]

IOW, I don't think it is valid to have a delegation without having
children?

Otherwise,
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

--5BjMorMatJMI/kO2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZIoUmwAKCRB4tDGHoIJi
0s8OAQC9Z5JXorm19qiau/8bfDQbErjoln46aJVOZhOB61Zs4AEAldzBD4e5sVZx
BB4EhiqD4OULcq1ms+OtgVW6TW7zIgE=
=hrI0
-----END PGP SIGNATURE-----

--5BjMorMatJMI/kO2--
