Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795129731;
	b=onYu42PXAe98kWkgmmkPl0cj9Nv8+mUFgLBwNyetq73MkgNuzG5vNE14/Am7r/QDCX5b
	 omgan7SDSsRB7SK7wWsvnDHCS07H2Gp1N8vJrE82uoCXuI/7aXlb6gjdAFzPo+n8wAoVO
	 d07Gs8BoD9ml4/c+XceS9JVXRx+ZlrG215kBewwwnwQNnJD5i/Bdg2Oxbq/Th4PoNqN4U
	 iwaH4Z/xLEVtEiD4lYJ+9L491O+gYqcSHmYLks1Fr7M6FJdNlJmXHcbTqbUX5meLUP9XU
	 YLZ5cwv6l+ga5JcZsd65yTty1fVT24BetJgOA0K16ZTknYSu7xZOjtsU2Ex/1h5PArA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795129731;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Cookie;
	bh=wEZkBab7UqRfMrX7O5m1ZmNVlSf+C6CU+1tcpFcU1rY=;
	b=m3pW0lm7xZ15XjoU9TJl3b9x3h2mjngh9dDanyj8q28/VZ9yhQUjrKEfV4ChyfyyNmgq
	 zrCbN41QW8gX0WQTmD93p3TL1YGFHUkBPCrMbjp2Ne80j3eU203uYT0s+j7nnFWgLXC4k
	 n9A/D0moj19JMFQBAHufeEV5tGGYEaq3Jqmv2f4klZ2QlLiQ0obPd/Bes1WLeOeemrisc
	 W1r5Ku+j7w+04M9Xry/bqrBNLY5kQJtWLGd9O8sMZGBVz/QLSJxbYzIPVh5H6aUQxPCjo
	 IenEM9aXUQ6XGb8cC6KJqzuqLgU1Fg/Oy0DNN6kQAfBux0R891VsgtCLHjfq0VnLtdw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Aog1mzOk;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A198606A326;
	Thu, 19 Nov 2026 23:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Aog1mzOk
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2B1C1F000C4;
	Thu, 19 Nov 2026 23:08:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795129731;
	bh=wEZkBab7UqRfMrX7O5m1ZmNVlSf+C6CU+1tcpFcU1rY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Aog1mzOkqQ7jjJze7fklA8q3RYQyFc/V/VGL2lGoDxtnIEvuRiN1jtsoDOe3JR1TF
	 rVMlxWqL7l+83figGswkTV59u9kYatrwfuKm1GshDpR5KWrRUfVg2EEV3Wz60NTYwl
	 jcOHCbXM3YXCXQF/8HW0iZqbmVSHlYdW95XbbDwyzpGJPZpusVjHJ4Fw5EoPN3aJNb
	 Rny2BGnqhQtv3sTwoXa3whMioqYCykBKgAYtakYLsf3tJPDsCOnPhVx3pCjlz6jsr1
	 N8faTCTvcs++TO2e0wEnJRgfmftOoIsqgybQ/iL+p7ig+h9GHz3qDJbE4VEUY+zPYo
	 PsDcQYtr5IwIA==
Date: Thu, 19 Nov 2026 23:08:44 +0000
From: Mark Brown <broonie@kernel.org>
To: Mohit Sharma <mohit.sharma@oss.qualcomm.com>
Cc: Srinivas Kandagatla <srini@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Ajay Kumar Nandam <ajay.nandam@oss.qualcomm.com>,
	Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Rob Clark <robin.clark@oss.qualcomm.com>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Abel Vesa <abelvesa@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>, linux-sound@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
	iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] dt-bindings: sound: qcom,q6apm-dai: allow Shikra
 compatible
Message-ID: <edf0e84b-9512-4fcb-8ca9-ada287d2a00d@sirena.org.uk>
References: <20261119164705.1594066-1-mohit.sharma@oss.qualcomm.com>
 <20261119164705.1594066-2-mohit.sharma@oss.qualcomm.com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="IUg61mMA2sBAk5Yq"
Content-Disposition: inline
In-Reply-To: <20261119164705.1594066-2-mohit.sharma@oss.qualcomm.com>
X-Cookie: I'm into SOFTWARE!


--IUg61mMA2sBAk5Yq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Nov 19, 2026 at 10:17:02PM +0530, Mohit Sharma wrote:
> Shikra's q6apm DAI needs a SoC-specific compatible so that the Qualcomm
> SMMU implementation can select the identity domain required by its
> firmware ABI.  The ASoC driver continues to bind using the generic
> fallback compatible.

Please submit patches using subject lines reflecting the style for the
subsystem, this makes it easier for people to identify relevant patches.
Look at what existing commits in the area you're changing are doing and
make sure your subject lines visually resemble what they're doing.
There's no need to resubmit to fix this alone.

--IUg61mMA2sBAk5Yq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmr/gXsACgkQJNaLcl1U
h9DLegf8Dmpq6RqPrhHE1XLwNIHftQu0DFDGB1QevWyLOXMc+yCPYPFwtNjtCP41
/iRlczHbACudNwezzaxEiZ/NFXHV4PUWctEzx5LROtVcpDAgOJMIRtYgWTNixBKP
6ZwVa76xyyDTmVRKgzGxTn4tJdwSHi2KFVTHT/FRktaQHUUpbbVDcqHZ84eMKskG
HamZ5V8UEypMC2xZXpGh82IobL2yhOjkTG3gQQlJT5xodnWg075N+II3lGIv1a1a
QZGP1LbjEy75eyXuXqkxphAqZyagRGXCvS26O9++t3D2gK6nqaJ0QRtaUb+MvYZB
B99IzWATW9svq8SLEUNiiMpbOKZPsA==
=0Oos
-----END PGP SIGNATURE-----

--IUg61mMA2sBAk5Yq--
