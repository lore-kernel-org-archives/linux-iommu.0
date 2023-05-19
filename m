Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3403D11191
	for <iommu@lists.linux.dev>; Fri, 19 May 2023 15:58:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CDE4C433D2;
	Fri, 19 May 2023 15:58:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1684511901;
	bh=LC6PcaBY4YfGm3Kw6jQO/40YFqlZ2fHoiFiPjCm+frk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=J4CbgkhF+V9w51/QCHJJhNJqrb/S/A8YvRWMROB3HXR5gfr5CsntI8Iqh8EA3Tp0U
	 cl+rNglK/dxf/FPuuLZgSIBWwTv+BLsRtHtsHDHX5Itj4jnmBWQZKj+PNtOfpFUd2F
	 jI6TfNFslueB+K74vZdKgOjCzga53+gvamysyDjIPBpT2n/jVaZ9XfqGXaFp47FWC9
	 VijhesyPJlivzOZK5d1H12bCJQbmGeSYFiZM98Oy3aeXSyDptPfhTuTUVRLadXHEVk
	 HjuYhtjN2nx2UW4jkj+70d9KcOq99AzXr1V6M17G7fXFZnysWfn3Bz7jzo429tu8Li
	 BTEhhcPHVDlDA==
Date: Fri, 19 May 2023 16:58:14 +0100
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
Subject: Re: [PATCH 3/8] dt-bindings: interrupt-controller: Add SDX75 PDC
 compatible
Message-ID: <20230519-refutable-driller-4a00748f887f@spud>
References: <1684487350-30476-1-git-send-email-quic_rohiagar@quicinc.com>
 <1684487350-30476-4-git-send-email-quic_rohiagar@quicinc.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="7fDnlwn1h0elCcSx"
Content-Disposition: inline
In-Reply-To: <1684487350-30476-4-git-send-email-quic_rohiagar@quicinc.com>


--7fDnlwn1h0elCcSx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 19, 2023 at 02:39:05PM +0530, Rohit Agarwal wrote:
> Add device tree bindings for PDC on SDX75 SOC.
>=20
Acked-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

--7fDnlwn1h0elCcSx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZGeclgAKCRB4tDGHoIJi
0rSSAPwIn2e6W1u5UBCOK0Eay5g1fokOGE3V6Yjd03iWXmAzngEAuQoKayqRVrg/
4fg1AjCTzPnGRq3H40eAryAcif0N/QY=
=d9Qk
-----END PGP SIGNATURE-----

--7fDnlwn1h0elCcSx--
