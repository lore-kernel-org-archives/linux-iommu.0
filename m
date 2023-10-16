Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78F47273FE
	for <iommu@lists.linux.dev>; Mon, 16 Oct 2023 12:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="YIkx0kwI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1697460987; x=1728996987;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=owu+iKqUzWkQLtSBTtxj1zT2rwGvuD6S/GZDMO70pg0=;
  b=YIkx0kwIhS7Mdh+oFbrpkzBiUEyDIFYS2Iq10WMA98xB+GA4BTELNQRr
   pwOqWqLW6lFUZ273ZCAUeUisUtjkMk0ZaBX7VHuAPGzWHh3AzBz/oy6X8
   NczPpudc0jWjvcyQVW1xvUiLstVeklmmx532IH6ZdhDuuDG3Dh3hHY9t5
   3U4Y4TaInT6uC+2TsWncjpSVZLgg4qQT2DJY2bi9jgRsHh8zwLsyOsM7t
   IC8ze9MyB1qvprOkHMvtmOZj3RjmPUuAh/4N659YVbG/22U0a/ZpHeero
   rOGokSHSn7R5FOyVaxiPjSqmbsVaGJA9CY/wWw151UYp8UKqKOpB3pECo
   w==;
X-CSE-ConnectionGUID: MUYjPoOnQe+6O7A6bgCR6A==
X-CSE-MsgGUID: HFcEOj/NRFqcOiHhwh4vUQ==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.03,229,1694761200"; 
   d="asc'?scan'208";a="177204000"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Oct 2023 05:56:23 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 16 Oct 2023 05:56:06 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex01.mchp-main.com (10.10.85.143)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Mon, 16 Oct 2023 05:56:02 -0700
Date: Mon, 16 Oct 2023 13:55:40 +0100
From: Conor Dooley <conor.dooley@microchip.com>
To: Christoph Hellwig <hch@lst.de>
CC: Greg Ungerer <gerg@linux-m68k.org>, <iommu@lists.linux.dev>, Paul Walmsley
	<paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Conor Dooley
	<conor@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm
	<magnus.damm@gmail.com>, Robin Murphy <robin.murphy@arm.com>, Marek
 Szyprowski <m.szyprowski@samsung.com>, Geert Uytterhoeven
	<geert@linux-m68k.org>, Wei Fang <wei.fang@nxp.com>, Shenwei Wang
	<shenwei.wang@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>, NXP Linux Team
	<linux-imx@nxp.com>, <linux-m68k@lists.linux-m68k.org>,
	<netdev@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
	<linux-renesas-soc@vger.kernel.org>, Jim Quinlan <james.quinlan@broadcom.com>
Subject: Re: [PATCH 02/12] riscv: only select DMA_DIRECT_REMAP from
 RISCV_ISA_ZICBOM
Message-ID: <20231016-chomp-vitally-b6c004be7809@wendy>
References: <20231016054755.915155-1-hch@lst.de>
 <20231016054755.915155-3-hch@lst.de>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Ihs0Gu2JVloYpIJM"
Content-Disposition: inline
In-Reply-To: <20231016054755.915155-3-hch@lst.de>

--Ihs0Gu2JVloYpIJM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 16, 2023 at 07:47:44AM +0200, Christoph Hellwig wrote:
> RISCV_DMA_NONCOHERENT is also used for whacky non-standard
> non-coherent ops that use different hooks in dma-direct.
>=20
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

> ---
>  arch/riscv/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index 0ac0b538379718..9c48fecc671918 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -273,7 +273,6 @@ config RISCV_DMA_NONCOHERENT
>  	select ARCH_HAS_SYNC_DMA_FOR_CPU
>  	select ARCH_HAS_SYNC_DMA_FOR_DEVICE
>  	select DMA_BOUNCE_UNALIGNED_KMALLOC if SWIOTLB
> -	select DMA_DIRECT_REMAP if MMU
> =20
>  config RISCV_NONSTANDARD_CACHE_OPS
>  	bool
> @@ -549,6 +548,7 @@ config RISCV_ISA_ZICBOM
>  	depends on RISCV_ALTERNATIVE
>  	default y
>  	select RISCV_DMA_NONCOHERENT
> +	select DMA_DIRECT_REMAP
>  	help
>  	   Adds support to dynamically detect the presence of the ZICBOM
>  	   extension (Cache Block Management Operations) and enable its
> --=20
> 2.39.2
>=20

--Ihs0Gu2JVloYpIJM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZS0yzAAKCRB4tDGHoIJi
0hjvAQCuU+lkdZEJGHqzkwUX3I/m5Rjm/NNqvKylHzOsHPnU9wD+O+V5jY/UGcxC
5Y5HrOaAn3eYO5OnNXk29wyRBjksoAU=
=pzeO
-----END PGP SIGNATURE-----

--Ihs0Gu2JVloYpIJM--
