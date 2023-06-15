Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F40F2E0F5
	for <iommu@lists.linux.dev>; Thu, 15 Jun 2023 19:31:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75D75C433C0;
	Thu, 15 Jun 2023 19:31:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1686857518;
	bh=kictF58Z8Tqb0WvcwXz864a+VzNXEgr7VntV2dSR0Ds=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SAQXO2dJSrFg0f7YL7VcbzpYm4NMOqoMCluGrUsiuBb/sYLbvRvCKQNy3+y6UC1V5
	 MAzUteY4hiAJgKHUKzjNyF6cvlI8IUk+zNcocFrBGx6kVflU2ByUfCsfs4UEWF80R3
	 HvozHMkAJI1Fc9OpDUeuJeP4gP8BOkVIxcuYEQFQuqFw8rKmIZgDFXSDjFKPdPOlqP
	 POS32emQCSwXLahcm4DCUXdxz03D3zYA9qOrcvn++MR7C4G6M7lXgQF5mCXlrYuRGP
	 xe9TsgRC0uixNb8646kL1YcV+jsx1bqtgrt0WvK9T8I0ooL+FYt8XD2Z0ts7pVCNbm
	 ss7WSwUV6+zow==
Date: Thu, 15 Jun 2023 20:31:51 +0100
From: Conor Dooley <conor@kernel.org>
To: Saravana Kannan <saravanak@google.com>
Cc: Anup Patel <apatel@ventanamicro.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <maz@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Frank Rowand <frowand.list@gmail.com>,
	Atish Patra <atishp@atishpatra.org>,
	Andrew Jones <ajones@ventanamicro.com>,
	Anup Patel <anup@brainfault.org>, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	iommu@lists.linux.dev
Subject: Re: [PATCH v4 08/10] irqchip: Add RISC-V advanced PLIC driver
Message-ID: <20230615-thyself-doornail-f0545ada9176@spud>
References: <20230613153415.350528-1-apatel@ventanamicro.com>
 <20230613153415.350528-9-apatel@ventanamicro.com>
 <CAGETcx-hoPNanAwe4++6roqBXwSdc7z6Ei=-r9z6qFG1U7xVXg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="SvxDNUXYoM4it6RY"
Content-Disposition: inline
In-Reply-To: <CAGETcx-hoPNanAwe4++6roqBXwSdc7z6Ei=-r9z6qFG1U7xVXg@mail.gmail.com>


--SvxDNUXYoM4it6RY
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Saravana,

On Thu, Jun 15, 2023 at 12:17:08PM -0700, Saravana Kannan wrote:
> On Tue, Jun 13, 2023 at 8:35=E2=80=AFAM Anup Patel <apatel@ventanamicro.c=
om> wrote:

btw, please try to delete the 100s of lines of unrelated context when
replying

> > +static int __init aplic_dt_init(struct device_node *node,
> > +                               struct device_node *parent)
> > +{
> > +       /*
> > +        * The APLIC platform driver needs to be probed early
> > +        * so for device tree:
> > +        *
> > +        * 1) Set the FWNODE_FLAG_BEST_EFFORT flag in fwnode which
> > +        *    provides a hint to the device driver core to probe the
> > +        *    platform driver early.
> > +        * 2) Clear the OF_POPULATED flag in device_node because
> > +        *    of_irq_init() sets it which prevents creation of
> > +        *    platform device.
> > +        */
> > +       node->fwnode.flags |=3D FWNODE_FLAG_BEST_EFFORT;
>=20
> NACK. You are blindly plastering flags without trying to understand
> the real issue and fixing this correctly.
>=20
> > +       of_node_clear_flag(node, OF_POPULATED);
> > +       return 0;
> > +}
> > +IRQCHIP_DECLARE(riscv_aplic, "riscv,aplic", aplic_dt_init);
>=20
> This macro pretty much skips the entire driver core framework to probe
> and calls init and you are supposed to initialize the device when the
> init function is called.
>=20
> If you want your device/driver to follow the proper platform driver
> path (which is recommended), then you need to use the
> IRQCHIP_PLATFORM_DRIVER_BEGIN() and related macros. Grep for plenty of ex=
amples.
>=20
> I offered to help you debug this issue and I asked for a dts file that
> corresponds to a board you are testing this on and seeing an issue.

There isn't a dts file for this because there's no publicly available
hardware that actually has an APLIC. Maybe Ventana have pre-production
silicon that has it, but otherwise it's a QEMU job.

Cheers,
Conor.

> But you haven't answered my question [1] and are pointing to some
> random commit and blaming it. That commit has no impact on any
> existing devices/drivers.
>=20
> Hi Marc,
>=20
> Please consider this patch Nacked as long as FWNODE_FLAG_BEST_EFFORT
> is used or until Anup actually works with us to debug the real issue.
>=20
> -Saravana
> [1] - https://lore.kernel.org/lkml/CAAhSdy2p6K70fc2yZLPdVGqEq61Y8F7WVT2J8=
st5mQrzBi4WHg@mail.gmail.com/

--SvxDNUXYoM4it6RY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZItnJwAKCRB4tDGHoIJi
0oNdAP9y41MDXvHACoZ/dwEG8Hy5OZRNoJvZmNm6Lx2BVfvqWgD+L4A6erWOa4eW
QmND+OPAsLKLIP9O9/cMGnzZJ/jvLQs=
=UPBa
-----END PGP SIGNATURE-----

--SvxDNUXYoM4it6RY--
