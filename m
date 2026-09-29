Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60A05560ABC;
	Tue, 29 Sep 2026 18:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790707888; cv=none; b=pQbXfjdN+SDr05IS9k7M9EludPSHKk8gyd0m302PydOCp5SY9t/3b4RGKiwOWJqdlZxdp8BTld7mRIt4104nX0mWeDoZbBoWMfZ3n7EvyuokYVxdC9iV403Aa1kjHjOYqFKuCLMh0Ntx7GBKFETqnFoEIcFwPmIBKjjsvV4KSzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790707888; c=relaxed/simple;
	bh=VsRpLKKg8AuLklLizckVFXMKQubrVkPG/ZgxEupnPNk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O8GZLcNyWmOovnCJK9W7lRwH6sAiyqES4VOMbK7vUXzy1jLJ4x8I9SiI1IZwVznf5d5wtP6cfhE6vJOeUxq5XLIG+aXBXrerxscA2Kd9l1ohH38Ko0F40RM/nyQrPR+P9mA07sHARdEg+cWluQV6QpGaohxHe9yCSreAPQHvWDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EeCb5904; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EeCb5904"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F4811F000FF;
	Tue, 29 Sep 2026 18:51:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790707885;
	bh=/WMI8lfF/OSrttALYjpfUBi10UnOZ9MwedFyUxvaAbA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=EeCb5904S2ffg/WWZNEkHiFLiIst0KEkW7s7e/DKqtHosRZFbvSUM528WQUBfCrER
	 /gIWP17U+z4/iDSTPjMDbhbRLzFydlWXFVQiwhn5mqjRYZ9aQMbpe5bsKFMbCy6GwT
	 hwOnNd8mP9cQLkDS1lAn8hZVxnhCvd+gZi0C2G/vxbe/iD34iNOihiS/+03dSntIpk
	 v5QFsCi2cEyLW3vfm3zsM/zS247R4LMtHB78ox9HfqkRNUr3J5HjR8ZsMJainxKnjT
	 fs47ndSB3X8JQ49wOvTbYf1YdnxDKQ0zAoqx1R4db0bA6UiZx4H1HSbhBK5UoDgxg/
	 /gVJJMuFXzbFw==
Date: Tue, 29 Sep 2026 19:51:18 +0100
From: Conor Dooley <conor@kernel.org>
To: Luna Jernberg <droidbittin@gmail.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Janne Grunau <j@jannau.net>,
	Sven Peter <sven@kernel.org>, Neal Gompa <neal@gompa.dev>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"Joerg Roedel (AMD)" <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Jassi Brar <jassisinghbrar@gmail.com>,
	Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, Jens Axboe <axboe@kernel.dk>,
	linux-nvme@lists.infradead.org, asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, iommu@lists.linux.dev
Subject: Re: [PATCH 2/7] dt-bindings: mailbox: Add Apple M3 compatibles
Message-ID: <20260929-wrongful-shirt-2920bcdab205@spud>
References: <20260925-apple-m3-nvme-v1-0-5e832e2f4aa9@jannau.net>
 <20260925-apple-m3-nvme-v1-2-5e832e2f4aa9@jannau.net>
 <20260929-debonair-busy-hamster-be2fda@quoll>
 <CADo9pHg2JyGyOA=_6orXdhDwj7NaKRBciyQMG2w7fQcPm0MNwg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="94Nbq7tBACJ51b1N"
Content-Disposition: inline
In-Reply-To: <CADo9pHg2JyGyOA=_6orXdhDwj7NaKRBciyQMG2w7fQcPm0MNwg@mail.gmail.com>

--94Nbq7tBACJ51b1N
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 29, 2026 at 03:22:09PM +0200, Luna Jernberg wrote:
> https://youtu.be/TPwe53kCJuM

Why are you linking this here? Is there something relevant to this
series in that stream?

Confused,
Conor.

>=20
> Den tis 29 sep. 2026 kl 10:21 skrev Krzysztof Kozlowski <krzk@kernel.org>:
> >
> > On Fri, Sep 25, 2026 at 10:22:49AM +0200, Janne Grunau wrote:
> > > The ASC mailbox on Apple M3, M3 Pro and M3 Max/Ultra is compatible to
> > > the mailbox on M1 ("apple,asc-mailbox-v4"). Add their per-SoC
> > > compatibles "apple,t8122-asc-mailbox", "apple,t6030-asc-mailbox" and
> > > "apple,t6031-asc-mailbox" to its dt-bindings.
> > >
> > > Signed-off-by: Janne Grunau <j@jannau.net>
> > > ---
> > >  Documentation/devicetree/bindings/mailbox/apple,mailbox.yaml | 3 +++
> > >  1 file changed, 3 insertions(+)
> >
> > Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> >
> > Best regards,
> > Krzysztof
> >
> >

--94Nbq7tBACJ51b1N
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCarwIpgAKCRB4tDGHoIJi
0mYQAP9UIJeKqv9AhxyIQM+FA4DJ02DszB2mvYOx9cyyt0PHiwD/TTKncTdmGbHf
cbaZwKF3EvrrClbOBuC2WjwU1nMvGwE=
=hd1e
-----END PGP SIGNATURE-----

--94Nbq7tBACJ51b1N--
