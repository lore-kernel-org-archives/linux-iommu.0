Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D00383B7A8;
	Tue, 25 Jun 2024 21:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719350754; cv=none; b=rHTpBOphwds47aAx/uJtLsN/LgvCmmnH+Xcfwuz3Hs+JaIRCmSuY/mH+V1hDTCHHapzvGxonzI01/n6R3ADLobQdg0qvo5eXVuOjIxA+x+gUpEBW/G7ibnbe/+SM3fmFPWd0MprbWC4+bUV+3PRWDCr1Y/zyBQDVegXMMIxnVy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719350754; c=relaxed/simple;
	bh=2fpgo7wWPpnHiHwgIsqvXf8aq+M/0Mjk/P4VKhmqk9g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fnqpxYJ5CFuQpp9s824ZaqPwZJcdFMvw0Zp7AuGIlLzngs3fVO+ZXFTchBVc/UeVlp1vy3hMtROWC21D/2+B6NPaBQiJ+XG4BR0wv7VBy4GyNQu0NUJQ6fnAL/OJzI8MSY9bCjBCxAduDTENLrdk2RBEABk/63OIwZv4IF7BUfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oEiDbm9y; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oEiDbm9y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF14EC32781;
	Tue, 25 Jun 2024 21:25:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719350754;
	bh=2fpgo7wWPpnHiHwgIsqvXf8aq+M/0Mjk/P4VKhmqk9g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oEiDbm9yxknpltYIgrfYLyaP7Bls6wfZZ1GnEI7Xx2/Yc4CpIhBhEiba25HOhokrh
	 RZj9WDfLXKZFKgdxDjR37qg7Dgr0gmgFpImRkXOkZzU9C5ur/Ji9PZY8mnTlCLqFiQ
	 KJ+SRXhUsSzeevRs8o4kVel1VKJ+xGOI1MPDSKN5grEsP2+bvodeveJ2SavHisb99P
	 naEYdMJc+BrqDLJOBfGA9qoe+jTy6nBkWHKgJpq52BYK2d+KWM1ueokIhY3O7S1co0
	 0l5kx/OkzOdb7vY7oEIFRSSJjNsXbyp70qdHwgOhp4NF4YP9ulhJeMY+OM0GyprFE/
	 rGheLG9gLYjmg==
Date: Tue, 25 Jun 2024 22:25:48 +0100
From: Mark Brown <broonie@kernel.org>
To: Nathan Chancellor <nathan@kernel.org>
Cc: Oreoluwa Babatunde <quic_obabatun@quicinc.com>, robh@kernel.org,
	saravanak@google.com, hch@lst.de, m.szyprowski@samsung.com,
	robin.murphy@arm.com, will@kernel.org, catalin.marinas@arm.com,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev, kernel@quicinc.com
Subject: Re: [PATCH v6 1/4] of: reserved_mem: Restruture how the reserved
 memory regions are processed
Message-ID: <abab36b4-e9ef-40ff-adbd-fde0f016f3b8@sirena.org.uk>
References: <20240528223650.619532-1-quic_obabatun@quicinc.com>
 <20240528223650.619532-2-quic_obabatun@quicinc.com>
 <20240610213403.GA1697364@thelio-3990X>
 <Zmd0Zg7oMneJLyHd@finisterre.sirena.org.uk>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="laeNYeGrVdu/YCAl"
Content-Disposition: inline
In-Reply-To: <Zmd0Zg7oMneJLyHd@finisterre.sirena.org.uk>
X-Cookie: Some equipment shown is optional.


--laeNYeGrVdu/YCAl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 10, 2024 at 10:47:18PM +0100, Mark Brown wrote:
> On Mon, Jun 10, 2024 at 02:34:03PM -0700, Nathan Chancellor wrote:
> > On Tue, May 28, 2024 at 03:36:47PM -0700, Oreoluwa Babatunde wrote:
>=20
> > > fdt_init_reserved_mem() is also now called from within the
> > > unflatten_device_tree() function so that this step happens after the
> > > page tables have been setup.
>=20
> > > Signed-off-by: Oreoluwa Babatunde <quic_obabatun@quicinc.com>
>=20
> > I am seeing a warning when booting aspeed_g5_defconfig in QEMU that I
> > bisected to this change in -next as commit a46cccb0ee2d ("of:
> > reserved_mem: Restruture how the reserved memory regions are
> > processed").
>=20
> I'm also seeing issues in -next which I bisected to this commit, on the
> original Raspberry Pi the cpufreq driver fails to come up and I see
> (potentially separate?) backtraces:

This is still in -next and breaking boot as reported above.

--laeNYeGrVdu/YCAl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmZ7NdwACgkQJNaLcl1U
h9CRmgf+MxWrqBIy6qcWxT4vhYq3B4GVJxOVx75T9RjVBoUn4kzuzulvobVPKw8Z
+oSESmos/Ztwu54PdEcoJgz9sE9bdBEZloJQzNd7bTKrAoaiS0NlWRFNwUIr5veL
W2VixUC7euUW3rInnaSRktlVGCdcmf9+7xYnfoMD18Ecqy++kSrTSPqCmMKJEvOG
nRsx4hXrdLyj10h539snjBbuvIcjWC4jfEqaqB5P8H6u9HVQuRP4eMD9cTHK8Mf1
djdK2W2ZzPa1U+P/6B0ORFloA3Vg4udYMOKP6WBAFFCVY1r1uBrg8nlKt1cnNyT3
mK9860YyHJk9+HWIFb1skmm6XJ98/A==
=N6M3
-----END PGP SIGNATURE-----

--laeNYeGrVdu/YCAl--
