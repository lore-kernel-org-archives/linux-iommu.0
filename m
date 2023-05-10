Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7986C2105
	for <iommu@lists.linux.dev>; Wed, 10 May 2023 12:16:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1683721012; x=1715257012;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=c0LtGL7zvuyoxmCVFA1srE+yHPP0jp3sH5qXd5mFOug=;
  b=Ma9nUqUaNloHrr3LpEi8uA2s2ZkI8wtDR2N4Rl/SIXXCeODmncAb6rny
   4wbCh0Fq4GwDo2w2Pb6UBD/ux0SgJaPvdauvkb5NQY1nDMNGpvJMfwkIt
   B5LUAiRgMJEmLwDUXEUpZDjGbzLj9EkidbsjZ/gLtOWiJSzCK/BFQpwK8
   DlUEb7snYL/902HtkwcbjKLcyt28rr/GabynQkUuvVqAfvNGagaDeB+1t
   GfpJWq3T/bPu1v4UZRCAmmz3ZeCp3x9pND/6cR6BRxBFgCGjnwluDSY28
   v2BSlZqJvHetOC2S2i14HHci9et5UVAaAF0fo6BG2mNx4vU0Zy75rNbRA
   w==;
X-IronPort-AV: E=Sophos;i="5.99,264,1677567600"; 
   d="asc'?scan'208";a="210553509"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 10 May 2023 05:16:50 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 10 May 2023 05:16:45 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Wed, 10 May 2023 05:16:43 -0700
Date: Wed, 10 May 2023 13:16:23 +0100
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
Subject: Re: [PATCH v3 04/11] dt-bindings: interrupt-controller: Add RISC-V
 incoming MSI controller
Message-ID: <20230510-untried-duvet-7e3c230fcefd@wendy>
References: <20230508142842.854564-1-apatel@ventanamicro.com>
 <20230508142842.854564-5-apatel@ventanamicro.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="yuw4pefuYIA+XBN4"
Content-Disposition: inline
In-Reply-To: <20230508142842.854564-5-apatel@ventanamicro.com>

--yuw4pefuYIA+XBN4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hey Anup,

On Mon, May 08, 2023 at 07:58:35PM +0530, Anup Patel wrote:
> +  interrupts-extended:
> +    minItems: 1
> +    maxItems: 16384
> +    description:
> +      This property represents the set of CPUs (or HARTs) for which given
> +      device tree node describes the IMSIC interrupt files. Each node pointed
> +      to should be a riscv,cpu-intc node, which has a riscv node (i.e. RISC-V
> +      HART) as parent.

One minor nit here about wording - "riscv node" doesn't seem
particularly clear to me, should it be s/riscv node/cpu node/?

My only thing last time around was my misunderstanding, and you also
appear to have resolved Rob's complaints, so:
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Just to note, it'd be great if you could CC me on series that I've
already reviewed when you resubmit them?
Although in this case, if you ran get_maintainer.pl on v6.4-rc1 it'd have
told you to CC me anyway ;)

Thanks,
Conor.

--yuw4pefuYIA+XBN4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZFuLFwAKCRB4tDGHoIJi
0rSoAQDigVc1zoOIAq0GeK2C6LRDT48ecB1I90Fv+aw41IVdHwEApAt8ew3bob+u
Bn7gu+nIK1drEkZwQYODA5bMAVpuzwA=
=g+th
-----END PGP SIGNATURE-----

--yuw4pefuYIA+XBN4--
