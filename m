Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 097BF6AB7
	for <iommu@lists.linux.dev>; Wed, 10 May 2023 10:24:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1683714269; x=1715250269;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0/dKuhBAooiK7NxI6ZJD57YCt/AXZDva/ko2oLS9g9Q=;
  b=Fd1GbIgXZXVViU1Va74r4hk2tZo6qUwHFa/qX08f5/a809HLHO0sTr2M
   ORcUDD+ZaP6+T+WzBeuRPPsYvpipao8nbWWJOLsIUlCossB2c8A+S5gam
   5feYtK1xp1YK/b8W5jh9e8VJvGN7yq97t6qoIsMQkaKVvc2sZFVQOjznY
   wnkLHP371Tbt/hco/nh/QhKySoMUwYXk7J65wDzgarZQbP1jbEyI8mhPG
   Wsa050tW6oWmYyh9uVT7WZRdsDm/PK2ypb0kodXBYgR/ky/+/Z5PgFjHw
   MImG8RldKllQ8mIuFd5iJF3gWm2hRlLmlaQ6gCXb/airTaz3tLtHzpt86
   A==;
X-IronPort-AV: E=Sophos;i="5.99,264,1677567600"; 
   d="asc'?scan'208";a="213245200"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 10 May 2023 03:24:27 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 10 May 2023 03:24:25 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Wed, 10 May 2023 03:24:22 -0700
Date: Wed, 10 May 2023 11:24:03 +0100
From: Conor Dooley <conor.dooley@microchip.com>
To: Anup Patel <apatel@ventanamicro.com>
CC: Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley
	<paul.walmsley@sifive.com>, Thomas Gleixner <tglx@linutronix.de>, Marc
 Zyngier <maz@kernel.org>, Rob Herring <robh+dt@kernel.org>, Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Robin Murphy
	<robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>, Will Deacon
	<will@kernel.org>, Frank Rowand <frowand.list@gmail.com>, Atish Patra
	<atishp@atishpatra.org>, Andrew Jones <ajones@ventanamicro.com>, Anup Patel
	<anup@brainfault.org>, <linux-riscv@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<iommu@lists.linux.dev>
Subject: Re: [PATCH v3 00/11] Linux RISC-V AIA Support
Message-ID: <20230510-parchment-saxophone-f91f9d96156c@wendy>
References: <20230508142842.854564-1-apatel@ventanamicro.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="drOWBx1kyE087zJ+"
Content-Disposition: inline
In-Reply-To: <20230508142842.854564-1-apatel@ventanamicro.com>

--drOWBx1kyE087zJ+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Anup,

On Mon, May 08, 2023 at 07:58:31PM +0530, Anup Patel wrote:
> The RISC-V AIA specification is now frozen as-per the RISC-V international
> process. The latest frozen specifcation can be found at:
> https://github.com/riscv/riscv-aia/releases/download/1.0-RC1/riscv-interr=
upts-1.0-RC1.pdf
>=20
> At a high-level, the AIA specification adds three things:
> 1) AIA CSRs
>    - Improved local interrupt support
> 2) Incoming Message Signaled Interrupt Controller (IMSIC)
>    - Per-HART MSI controller
>    - Support MSI virtualization
>    - Support IPI along with virtualization
> 3) Advanced Platform-Level Interrupt Controller (APLIC)
>    - Wired interrupt controller
>    - In MSI-mode, converts wired interrupt into MSIs (i.e. MSI generator)
>    - In Direct-mode, injects external interrupts directly into HARTs
>=20
> For an overview of the AIA specification, refer the recent AIA virtualiza=
tion
> talk at KVM Forum 2022:
> https://static.sched.com/hosted_files/kvmforum2022/a1/AIA_Virtualization_=
in_KVM_RISCV_final.pdf
> https://www.youtube.com/watch?v=3Dr071dL8Z0yo
>=20
> The PATCH3 of this series conflicts with the "irqchip/riscv-intc: Add ACPI
> support" patch of the "Add basic ACPI support for RISC-V" series.
> (Refer, https://lore.kernel.org/linux-riscv/20230508115237.216337-1-sunil=
vl@ventanamicro.com/)

This series does not apply for me (or the patchwork automation) on top of
v6.4-rc1, which was released prior to you sending this & contains the AIA
definitions this series relies on.
You note here that there is a *conflict* with Sunil's series, but what
you actually did, as far as I can tell, is base your series on top of
theirs?
If you're going to do that, at least point it out so that reviewers
don't have to figure out what your intention was :( Better yet, for the
sake of our automation in particular, don't do it at all.

Thanks,
Conor.

--drOWBx1kyE087zJ+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZFtwwwAKCRB4tDGHoIJi
0t1JAQDg/nff4RAapk5rR40Fc9M7gbVoPtea9uxe8wNvwzKrFgD8DzIxMd1/AHTL
9YZT8pbRkIczFFTrwTSfcWJL2zf7Rg4=
=T9IK
-----END PGP SIGNATURE-----

--drOWBx1kyE087zJ+--
