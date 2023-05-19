Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4948811191
	for <iommu@lists.linux.dev>; Fri, 19 May 2023 16:00:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75E3EC433EF;
	Fri, 19 May 2023 16:00:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1684512016;
	bh=ZyZ/+2MJq2lVKT2IYjT9LJulxzZ6Fzj2kwU3siAJmi4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=N+j1BhOSZWNQx5HSucYRm7Oq5wYlr4p/DCjIOiz8T/kyYyj163KHtcRswCujrMeRU
	 l/xJqFHQ3BNp8QQkiwgXlClpBviOBtJOn6/EnpkRQneK+B9eXUhtV+PeUoJRC/SZwi
	 YJMDHPr6U9txS7h42PMkK6kUkdo5O6Yz1DYmukusOmIrpTV7u7GSv/esCPACbGZVux
	 r+4z8xpJDUSVOy4dpNPzB1PfQtfFzFe7Wis5u8fRPZFrMaKYgMTVkgRYkdySxvt5PA
	 k4GS0Bx6SwXYTW/aAdWBTbHHWXMFGMF1aDC5EUB3psLlVGby1B504E8WnYzs95synG
	 Sbp+5pRB+QwWA==
Date: Fri, 19 May 2023 17:00:09 +0100
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
Subject: Re: [PATCH 2/8] dt-bindings: firmware: scm: Add compatible for SDX75
Message-ID: <20230519-slapping-tactful-3a14c3eb7d96@spud>
References: <1684487350-30476-1-git-send-email-quic_rohiagar@quicinc.com>
 <1684487350-30476-3-git-send-email-quic_rohiagar@quicinc.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="kITg+Ca1cV/cm+yf"
Content-Disposition: inline
In-Reply-To: <1684487350-30476-3-git-send-email-quic_rohiagar@quicinc.com>


--kITg+Ca1cV/cm+yf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 19, 2023 at 02:39:04PM +0530, Rohit Agarwal wrote:
> Add devicetree compatible for SCM present in SDX75 platform.
>=20
> Signed-off-by: Rohit Agarwal <quic_rohiagar@quicinc.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

--kITg+Ca1cV/cm+yf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZGedCQAKCRB4tDGHoIJi
0uGSAQCXOvVkb3gbmv5fkkAq3pcz4OjUQ4qUAqmx1oD5giULPgEAvzyEgk2OxlCE
oTXOPs/Smb5hxkybtJdCqdiCy461cQQ=
=Dca/
-----END PGP SIGNATURE-----

--kITg+Ca1cV/cm+yf--
