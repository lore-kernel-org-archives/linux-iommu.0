Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD85B2105
	for <iommu@lists.linux.dev>; Wed, 10 May 2023 12:20:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1683721256; x=1715257256;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=TcX1IaLwnXYJEIt2VotXZBEoSrQM67d7M4Y9YenCRXg=;
  b=pvJ3GnrniUHRApRdlsPnMPxrISaBwxwKz42jLVjEAO6D0BIFnyRYOKQe
   9wDVuINxWo+KthEzDWvzTSPzdTV5cwA7uvUUMXAU/uywbF3YFk8m/8aN6
   7KD0h0mOSRC8Q7InhFmyCMcDfaHdds8kOhZ51fdtLSEb6YL0PUQyFY8lr
   PYZrHhu+aUFfXc9kRN6Z4RyOLT8i3tzF/LnsxbYoR4H1zfKJkMOVDVoGR
   +UYLbnphvhwgXgL5T7SFfqTzIgUU8ZXGbEHStBi8wv1H/xEyF6MWOqGRY
   ymDSatjoCalOb6J+pQa8rRbYLLYfB7IAbxqa9QWwx4DcUc1MgmXEWWKZn
   A==;
X-IronPort-AV: E=Sophos;i="5.99,264,1677567600"; 
   d="asc'?scan'208";a="210554051"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 10 May 2023 05:20:54 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 10 May 2023 05:20:47 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Wed, 10 May 2023 05:20:44 -0700
Date: Wed, 10 May 2023 13:20:24 +0100
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
Subject: Re: [PATCH v3 10/11] RISC-V: Select APLIC and IMSIC drivers
Message-ID: <20230510-maybe-wrongly-14914a15c044@wendy>
References: <20230508142842.854564-1-apatel@ventanamicro.com>
 <20230508142842.854564-11-apatel@ventanamicro.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="3u5hYZkmsjkmqqoH"
Content-Disposition: inline
In-Reply-To: <20230508142842.854564-11-apatel@ventanamicro.com>

--3u5hYZkmsjkmqqoH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

--3u5hYZkmsjkmqqoH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZFuMCAAKCRB4tDGHoIJi
0peMAPsF88TZqTDIFWCvsuDyzGB5/8W3/VHbAHHmMC5kyZPYzwEAhbStO8c+fjsD
mgqW/ghiLkALyo3FoMQwSXlsbmYyZw8=
=HWkU
-----END PGP SIGNATURE-----

--3u5hYZkmsjkmqqoH--
