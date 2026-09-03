Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A50B4B512A;
	Thu,  3 Sep 2026 18:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788458515; cv=none; b=ELkoI0+SHu8XrONBEgBE1/2HgPj1pzhfMpuFkblgV1DhgRbpggQqOW4W2hakMxj7sheyQMg+6Un7p3STBAdilDyKShuA4gQ6oKCsf3TUFEueINcozsZ5O4uX00rO8/09g5zmeO6gVUrdm0GPxgHSDoMt2AHYObNi9HqFUmdIG5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788458515; c=relaxed/simple;
	bh=5A1QYfa6A6TwbHZ40DsvlwxTmcMjlVcOQHbaH73blu0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y7eXisAZScVctDOQdtVXSAUS6+gjQJ2oAKk3ET9DFzz24LbRwPx7WAnlB/Cv034Ndh3KrrNkAlQYl9eJwb8/EUBsTTINFuI6Pf2RB+AK0QvSRkvKYeZlFZwNEmY4WTt6Q9xvFh8N7z2a4qDH54lJVYbk3zfPaN2aTuos2dxPPi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LGgqy440; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LGgqy440"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C7551F000E9;
	Thu,  3 Sep 2026 18:01:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788458513;
	bh=5A1QYfa6A6TwbHZ40DsvlwxTmcMjlVcOQHbaH73blu0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=LGgqy440wXjW4z+2ej4u2b4i0GXg+WhbIy3OSPK2T8EnQeTv97lOTo1HBuZExQuau
	 utxcsrjiFdtV4uH20iMAjhw1GOpdVjC+WYCkI3iTsEEaooKBp5NIopFiAJuhSXzzBW
	 qhAEGu/OFRIvC/9nxFafESHVsu46agx8gOidMyyQTTtbF8eeHuPV+PaHzyV/rQJWe2
	 oO28qKDpDKvQL/4fPa+gIxMT90aQMSGuLCqYsbbInWGv+QIhEJu8EiLdZElSx9eVlW
	 Thvhw+++DDOz+yk1mWOMjTR2XmERgyPfSXGGZ2YjzDyOC38YXiXX1njmx/g4QA/aNz
	 FPdhl7ut8vxPg==
Date: Thu, 3 Sep 2026 19:01:49 +0100
From: Conor Dooley <conor@kernel.org>
To: Janne Grunau <j@jannau.net>
Cc: Sven Peter <sven@kernel.org>, Neal Gompa <neal@gompa.dev>,
	"Joerg Roedel (AMD)" <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] dt-bindings: iommu: dart: Support specifying the
 DMA aperture
Message-ID: <20260903-uptight-lifter-fa7519487839@spud>
References: <20260902-iommu-apple-dart-aperture-v3-0-252ce55b7001@jannau.net>
 <20260902-iommu-apple-dart-aperture-v3-1-252ce55b7001@jannau.net>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="P9Nxr44pFcdtpVBU"
Content-Disposition: inline
In-Reply-To: <20260902-iommu-apple-dart-aperture-v3-1-252ce55b7001@jannau.net>

--P9Nxr44pFcdtpVBU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--P9Nxr44pFcdtpVBU
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCapm2DQAKCRB4tDGHoIJi
0uC4AQDQIi8jH2g1PVdYyk/QAhScZWhhLt/8d1AAueQhbMe9zQEAzmP/bNMIrhWH
QzUpM1skvbDONjwjgUjC3gF28M/4qw4=
=gvlv
-----END PGP SIGNATURE-----

--P9Nxr44pFcdtpVBU--
