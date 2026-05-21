Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 237C472621;
	Thu, 21 May 2026 20:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779393954; cv=none; b=VjatoDu992hxaXCQU5izhavXOSqTCsb4BxP8iP7h8kTK7LXT8jaezTJ1D9bwjNzIVR5QIioFdpJPg92vbQRKX9Ds0AefElnowio5qPY6Inm3HGym0l1jrnFLPxPD7wPCuOMPmQreDQBn1M8MTR8VZoe3Oz1xIx60atrwe/hKILE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779393954; c=relaxed/simple;
	bh=cv6uB5jJUAPv3s2OyJc+AWKUtjEFN4V62Cn/PKDP0NI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DVBXGHMZiwD4Vm5W+3RXdgmLHBXPvl+WjfoGH+caew9AozT63Dz42elIr/LeUkEwWLsrceKi6j8vbBrc8j7Bu9DHCubx6vJ3k3/UyClPsDCrVZzKVxSfFQn/0Ev3s4bx/P8g7CVitvZW/a1NYb6lYP2x/jAL10F2wlERMs8NHuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K6i4QeLy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K6i4QeLy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 514121F000E9;
	Thu, 21 May 2026 20:05:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779393952;
	bh=cv6uB5jJUAPv3s2OyJc+AWKUtjEFN4V62Cn/PKDP0NI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=K6i4QeLyErd3OIQtcKDZ5kBvfgE56iEpTI1kVR4QAHiUNKZEv1U/Z/xpYe2xStv56
	 uAf2tQG2sdLJ6RtK6PeiANL9wZoS8czm5p8FgwrSYjiOl1vwYmPvkMOTMc1EjGSNm1
	 mZKHZrn4UrNL5J8zfnu6yUkYWPg3nAZc+GbiO4KMYjwCzZzmbf1KPXBxAUg3Sz7KWt
	 p+2o9weLTNmvzc3J8LC4JeOS4gLj7qm8uXAJ8M41txlmcXJ3hT2ZZOnAvuN/J/z9ie
	 lARMLtQyOMv4Mi6+Dy6vE6GnNVHE0NyZp6oqm/mRhPOCOkckNKWV8pRPea43zzC3te
	 L3EnqmAnfAbLw==
Date: Thu, 21 May 2026 21:05:47 +0100
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
Subject: Re: [PATCH v3] dt-bindings: iommu: riscv: Add bindings for
 Tenstorrent RISC-V IOMMU
Message-ID: <20260521-unfocused-stencil-48520ecfb6e7@spud>
References: <20260521064445.1740782-2-fustini@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="N5nylATt8Y3roeyG"
Content-Disposition: inline
In-Reply-To: <20260521064445.1740782-2-fustini@kernel.org>


--N5nylATt8Y3roeyG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 20, 2026 at 11:41:18PM -0700, Drew Fustini wrote:
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

Discussed on IRC I think, sashiko complaint to be fixed.
pw-bot: changes-requested

--N5nylATt8Y3roeyG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCag9lmwAKCRB4tDGHoIJi
0nWsAP0TygXI7ZXe6ZVsOASVLwHfoMmNZkvxBWlW2Sd40jY25AEAzTJQRZ4uC7Yc
VC88ee2a9taFfVMMmpqdq0fm9xBSiAw=
=vTus
-----END PGP SIGNATURE-----

--N5nylATt8Y3roeyG--
