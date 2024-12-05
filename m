Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00A8E217735
	for <iommu@lists.linux.dev>; Thu,  5 Dec 2024 15:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733413960; cv=none; b=HPUZeg/1XDQpa8D++wAcY0IY2wuZf6cg59YLDD9W+TDnIolPkf2NqEN/cPZAX0fmYaRhEGMg/OK81KHHyiDQycSeQSS6F+7/ihkwOWZCkoJZnAQoIVOU4jQodTyWBUtJUlwxvjeoS47YnNVIPegHIF8OHzQemgop4s3mgsjzMoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733413960; c=relaxed/simple;
	bh=dERsIp8tPP6UBc7oXjwNPGVHBsb0amguO+a1FAAuG18=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rm2Yns75Oc8L4aYrnn+T9sm0Ox1joMb8qfu2U0LWJ8xGTceZvV/H7BAZBRcBRCYHPI1nPKbOL8NGAPZLQgTddaugOaEG+5RnrFFtiQMYzFPoPDzLtA4nvl69I1ITzawhBQhS1FOXaRFmA0GFCE46sRw933mBOYJTJgtwzVmheS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qo2GyXoT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qo2GyXoT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73320C4CED1;
	Thu,  5 Dec 2024 15:52:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733413959;
	bh=dERsIp8tPP6UBc7oXjwNPGVHBsb0amguO+a1FAAuG18=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qo2GyXoT6wDZ2QYe4Qo0VoQgMoyqKWrYZxKnTo9kqONUlKcEhkuDqJwUpgnBTAe6U
	 HLIRDam9EaqDH33BMYnq+nZ5roxkSCLm0l0z1d6bdasYhZuWSX7dz5kR49LY9qOAkZ
	 gHizCodgge+XxZqcHumu+w0O9W92Hls518mpKISm0pAuW/xir9Q41j+k26FFmym5aJ
	 q5zyKcsbceUETA9Fs/U6+WOe7u7/m9c65UJb+j+/0TSFLjs6fle5+yWMZSh6BCKmYm
	 sHNMNnQYYmXg7xDc9pvi5dWUfEpnvQ8sytgaVpQ/UMLzWv2BvSRId8P8XM9ZcnoucO
	 +KA9oqETCKJFA==
Date: Thu, 5 Dec 2024 15:52:34 +0000
From: Mark Brown <broonie@kernel.org>
To: Mark Rutland <mark.rutland@arm.com>
Cc: Robin Murphy <robin.murphy@arm.com>, will@kernel.org,
	catalin.marinas@arm.com, joro@8bytes.org, jean-philippe@linaro.org,
	iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	joey.gouly@arm.com, ryan.roberts@arm.com
Subject: Re: [PATCH 2/2] arm64: cpufeature: Add GCS to cpucap_is_possible()
Message-ID: <1e967066-c89d-4b0d-b055-356cd688f72a@sirena.org.uk>
References: <68a37b00a720f0827cac0e4f40e4d3a688924054.1733406275.git.robin.murphy@arm.com>
 <416c7369fcdce4ebb2a8f12daae234507be27e38.1733406275.git.robin.murphy@arm.com>
 <051c017c-a60f-48a7-b09f-07f0f32e48e3@sirena.org.uk>
 <Z1HJiUg60kZP4zPb@J2N7QTR9R3>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="F/Mf2luQPazU5+IJ"
Content-Disposition: inline
In-Reply-To: <Z1HJiUg60kZP4zPb@J2N7QTR9R3>
X-Cookie: System checkpoint complete.


--F/Mf2luQPazU5+IJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 05, 2024 at 03:40:57PM +0000, Mark Rutland wrote:

> In <asm/cpufeature.h>, only system_supports_gcs() and
> system_supports_haft() don't use cpucap_is_possible(); all the other
> IS_ENABLED() checks are for additional dependent properties, and rely on
> the base case being handled in cpucap_is_possible().

Ah, yes - I got lost in indirections while checking. =20

--F/Mf2luQPazU5+IJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmdRzEEACgkQJNaLcl1U
h9BXQAf/f+4Z3TtWSTR8bvwDVZvax9ZMbM1uwwp2GLZDtjBtjhDexKy3HJDeEUtf
ce0oxssvN755npxceLm4ANPv4cEaIxlPS4YVAXWEggLnKeJ7Cc4Z7yce7GU1xoth
FDdGLpRA4Pveg8htVRUtQrKh5PPNmgaoAnAlzqU1Y3xdymFiJES1oSwIMl7E8ocq
aSdSvUxRNUFhs8hca4f+294Z75oN/pNILeyBGfPXjWiazZRV0G9HVuZUNnRo0oPu
mkjDqKJEBBXdmdhj15B6QfbfbbV79ahUJTCjfrlHELUdILXm+bwNB2IUd/I5SVSn
RwUOSIsV1v0cTaR5BOOePyKSpVAzvQ==
=m5VG
-----END PGP SIGNATURE-----

--F/Mf2luQPazU5+IJ--
