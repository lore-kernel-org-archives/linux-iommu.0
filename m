Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 867952068D
	for <iommu@lists.linux.dev>; Tue, 23 May 2023 16:49:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0D08C433D2;
	Tue, 23 May 2023 16:49:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1684860598;
	bh=UV5bsKa/DBQmuTfOD0yfXML3WqEBfjvCNjnvfqNgkRE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ACrAhgKD+OYLCr/Y062rwu/P88jDHYmsjVxirxMBCyxEcingqk/jg1mhpS4DuJAKh
	 r7I8Pe49A1fmUsQKqeblz2V3o8b23G0PsCjBH7lDT4CSOhXM0g0eJbhIrpGYoyl0im
	 +BSTWopzw+fO4SP2E0YiPHeq8hfop8Y0Pl2lrSvxQEQcK9u40wMMGGaT+FZGm6aSy9
	 2wh2IOIYu4t10ZvDTNTprKoiTTD43sjp2vCEwwnCBivqrL7NDP/HN0w14XtmSTG4hj
	 bIcYIlvklCJqVjf1Yc6cmOVJbuBsf8BEyq4O6R7r6rOnmOYqnSd/V4ajto8Rh/fuYR
	 6af5HPsRQ7G/g==
Date: Tue, 23 May 2023 17:49:53 +0100
From: Conor Dooley <conor@kernel.org>
To: Bjorn Andersson <quic_bjorande@quicinc.com>
Cc: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Joerg Roedel <joro@8bytes.org>,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: arm-smmu: Fix SC8280XP Adreno binding
Message-ID: <20230523-surviving-maverick-85f8294c008b@spud>
References: <20230523010441.63236-1-quic_bjorande@quicinc.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="0JTGO0kGTlpCkGjq"
Content-Disposition: inline
In-Reply-To: <20230523010441.63236-1-quic_bjorande@quicinc.com>


--0JTGO0kGTlpCkGjq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 22, 2023 at 06:04:41PM -0700, Bjorn Andersson wrote:
> The qcom,sc8280xp-smmu-500 Adreno SMMU binding has clocks, so fix up the
> binding to allow this.
>=20
> Fixes: 38db6b41b2f4 ("dt-bindings: arm-smmu: Add compatible for Qualcomm =
SC8280XP")
> Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

--0JTGO0kGTlpCkGjq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZGzusQAKCRB4tDGHoIJi
0onBAQCrdQ+srOKGMJhFkarvamoqjZTheYwAH1qqKYnNEopQlAD9GgEpsAdqz4Rz
5kOUvQjUwkVi+dSnftVMLnn8TkOS1QU=
=K0b0
-----END PGP SIGNATURE-----

--0JTGO0kGTlpCkGjq--
