Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5265B11191
	for <iommu@lists.linux.dev>; Fri, 19 May 2023 16:00:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C9FAC433EF;
	Fri, 19 May 2023 16:00:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1684512037;
	bh=so6sZQRjmbILO79b+dPaCdsSDrsOoHzIlXUlWO3H+30=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=H7/oE6AOlYHjm3zhqSR/or5vRYxv+vH4IbFnURZU7JP/Fvr4xyoRjCZIdiRiFuFYn
	 NojJ0WgKPem9bzMztUN2/4UkyHl/KKccTpA8vHw4CdxMTH1fm2NCBEqaN+cg5Gmmyg
	 TFoFDTxhlA8764PuaREvXTmbyLnIZN4+m24PEHUzv4w49VqyZfHtMIfoCyZZ8Ymp1X
	 3TNmMyBvEVjOdVZvbWrjElT1Eo8IVy323jddyJgIjnJ4+2YPVeKE/MEXqVwcwjrgKB
	 5Ym9gWWpOxR9I0FgTHacMh0gTHSNOENh0Uvtd9DbbWfka24rz0oswcBryVVCf3dsII
	 zoK1eC4VGkPbA==
Date: Fri, 19 May 2023 17:00:30 +0100
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
Subject: Re: [PATCH 4/8] dt-bindings: arm-smmu: Add SDX75 SMMU compatible
Message-ID: <20230519-passerby-upheaval-899205409553@spud>
References: <1684487350-30476-1-git-send-email-quic_rohiagar@quicinc.com>
 <1684487350-30476-5-git-send-email-quic_rohiagar@quicinc.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="RuBcisQOkwlJ93ST"
Content-Disposition: inline
In-Reply-To: <1684487350-30476-5-git-send-email-quic_rohiagar@quicinc.com>


--RuBcisQOkwlJ93ST
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 19, 2023 at 02:39:06PM +0530, Rohit Agarwal wrote:
> Add devicetree binding for Qualcomm SDX75 SMMU.
>=20
> Signed-off-by: Rohit Agarwal <quic_rohiagar@quicinc.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

--RuBcisQOkwlJ93ST
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZGedHgAKCRB4tDGHoIJi
0vAjAP9O9UeAwk5YI7aSf10G3YRugv2uXYTq+jC7o12iE3q4fAD/UhJ43B0gZI54
qM+Jzq0vRX1/6jagqe5zwe/YH6yz2QE=
=BxdN
-----END PGP SIGNATURE-----

--RuBcisQOkwlJ93ST--
