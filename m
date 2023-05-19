Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C0C411191
	for <iommu@lists.linux.dev>; Fri, 19 May 2023 15:58:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B4CDC433EF;
	Fri, 19 May 2023 15:57:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1684511880;
	bh=8q0QgbAxigpEHZ0G2EVkTNAC2ayJfznro/ZRHZZlKpE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fGAMgSIQieHCpZOWtnGUopTwrPyrbB3NCQmtgTq1XwLsJiQ9HZrTmom2EzUw+J5Jl
	 vFzKov0X4FPddiCr0jI2UuaA1DhVqlV7/kTY3URLKzvJKeGJrIMW3Ksiy3DjS6zChC
	 SwyPFyC/BTSblOfPueg67CSAGXPwj/T7t0z9OYAZLCxQp3fq8xkIhorQTszVdZupQW
	 WtKQedAa7n/MWgsazY1YdR6ImBbWTVyD9T69sFEYB5PfXSfGjK3by5J984B/ULLBCf
	 3fnzOEyuTWE1j2qUGYV0pc+yPtglTtgTkTwbfv3v6+KFKUVnxwXTS78HbVyoanY+Zl
	 8yr/Xc1I9XSqA==
Date: Fri, 19 May 2023 16:57:54 +0100
From: Conor Dooley <conor@kernel.org>
To: Rohit Agarwal <quic_rohiagar@quicinc.com>
Cc: agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, tglx@linutronix.de, maz@kernel.org,
	will@kernel.org, robin.murphy@arm.com, joro@8bytes.org,
	robimarko@gmail.com, quic_gurus@quicinc.com,
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev
Subject: Re: [PATCH 1/8] dt-bindings: arm: qcom: Document SDX75 platform and
 boards
Message-ID: <20230519-unbend-freight-34ef34f342f8@spud>
References: <1684487350-30476-1-git-send-email-quic_rohiagar@quicinc.com>
 <1684487350-30476-2-git-send-email-quic_rohiagar@quicinc.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="vz7beVG27M3oWpDZ"
Content-Disposition: inline
In-Reply-To: <1684487350-30476-2-git-send-email-quic_rohiagar@quicinc.com>


--vz7beVG27M3oWpDZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 19, 2023 at 02:39:03PM +0530, Rohit Agarwal wrote:
> Document the SDX75 platform binding and also the boards using it.
>=20
Acked-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

--vz7beVG27M3oWpDZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZGecggAKCRB4tDGHoIJi
0idDAP9XMk+6D6GHaLTN72GayAB7qNstlnTLkZB9erQEBf6sVwEA7rhasjA79ahe
ToVsaE0PsX/9Oieq2laU3j+AF6/ftwo=
=9QM1
-----END PGP SIGNATURE-----

--vz7beVG27M3oWpDZ--
