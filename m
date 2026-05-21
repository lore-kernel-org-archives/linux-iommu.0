Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02AD923EA8B;
	Thu, 21 May 2026 20:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779394124; cv=none; b=a+wvixJXT2k2GzYm8yRcLl4INKBQnPSiAjudcFB11/gqLJ0fsllLM/7IlnbL8nhJhLOnJOazLWFJdRTdOQ6RdeZFS65+o6SJOAEXdgFQ6CuTybxECoVG3QU8QWJjVteukZjo5XUSM9Jk8NHnlOc0qI5l35n2b9/9kPnOSHbVKbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779394124; c=relaxed/simple;
	bh=LX25OAouGCUkwIUsH/CgO/KHGaNp0WXm0L13yzUGE9s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BQdHBtUwSIRgX6d2qc7v9h8SH8K7PJdTbt9RFuq3M3OhWQ4CbZbpmfmDHzhXo4Nm8zYdridGtW7dPeolThE9ZSVnFxUQ0T8BUCrKr+eQiGXZH7SAXawJZxbzGQSGVq6AEMTmbI66JOUnyrT6RCPfQ3F6/PgsMk9RqGhosS7+mUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i+QvHvUJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i+QvHvUJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 301021F000E9;
	Thu, 21 May 2026 20:08:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779394123;
	bh=LX25OAouGCUkwIUsH/CgO/KHGaNp0WXm0L13yzUGE9s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=i+QvHvUJ5rP8KILkj9S0qJ9caOpGy//mbvHRkbux0e8U4epJEEt7KNa36cFXd2y4E
	 pJXmadLuJaipUja77UccM6WOs9EFLziCnx7Ywj22Evdodrw7bDkmsFRIxMFD1OV9Fm
	 iqQTUfsy5Uv6j23fA+jYUp0SztnvQnnYD8tIRPUzok5Npxm+mxqAdE/smkFVFgIOLe
	 F1xeFXwSdLspcemVUWsVjyZ0Obi7ZbMLfeMtUgbixDUV7orDDPwb7PQedTdu2PUrnO
	 KeDG+V1gnbtHqntN0up/OR0p7CGMIoLS+ZFfPI/J6QerY52D62m06ab/xaOnrBlU/q
	 qd16erxI2ktFQ==
Date: Thu, 21 May 2026 21:08:38 +0100
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
Subject: Re: [PATCH v4] dt-bindings: iommu: riscv: Add bindings for
 Tenstorrent RISC-V IOMMU
Message-ID: <20260521-suitably-garbage-92893a650399@spud>
References: <20260521170652.1880662-2-fustini@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="8kRpkwagpEPKzIo+"
Content-Disposition: inline
In-Reply-To: <20260521170652.1880662-2-fustini@kernel.org>


--8kRpkwagpEPKzIo+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--8kRpkwagpEPKzIo+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCag9mRgAKCRB4tDGHoIJi
0kkfAQCEPEV84IChw1+tVxeKSuSuVeIGVSqqvtIut5hq89RTQwEAvB09+rxsdwVY
CAyXvLRgCDpQRJz5nDwmr822zC65+Qc=
=4J9n
-----END PGP SIGNATURE-----

--8kRpkwagpEPKzIo+--
