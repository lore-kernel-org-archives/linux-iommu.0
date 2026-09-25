Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5BF73A9DA5;
	Fri, 25 Sep 2026 16:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790354898; cv=none; b=MfZC+zw5ncJlm97OCV42IWj6J8EYxBLUCn5x3uYLSI41LIGs+fl+mozb6Ai0KtV3B9A6DQtu72uuEwpTkmE6br224TYN/y7RqNiAGhb5vbB8UL3KunSZFI+MvdrPn8qlqQYXzo2r0qUA8jsGyBn0YcumNFtnJ+sCU9cJW3rJGBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790354898; c=relaxed/simple;
	bh=zczJdr4x96q520o3t6HU+u3KmLVhsf3BMnJqd64NB0k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VRkZDvJpA8ezRI6zXLrMkLnLotrXft1gr8BjgWWKDZi9UQBv86yqD9pMHM4gY9MZf6fozZALHcedNs1FWlNZPxjz7sV+Tq6O3O0KbxyxTvhQxW1+3JBuLJaNEyVWXiuC4UxSaXDuo4gpQugHwPjdxb/dF85kcjrBisoLCckPPHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=brXp1DtU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="brXp1DtU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E05021F000FF;
	Fri, 25 Sep 2026 16:48:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790354890;
	bh=zczJdr4x96q520o3t6HU+u3KmLVhsf3BMnJqd64NB0k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=brXp1DtUwDmfFXlJcboWgg1XECzBk1LYm8tGmkSFq1U5qkbn+/8XvUJukZfCdhiU7
	 HdFNq5+Dl7gRGQl7W1LQAmgqRGMNpRODZU4PZ7V0E1VDkd1o37v649Hh/BFhCJFhG8
	 YahYzU5aRLIgSrCGs81gcVfSvDnJYCyebHkh87pKS1BoRCvLjxy5rHF+f5KkFBfByR
	 yGQV4eThyWQdc/3Mbxn8ErXjavxV3z1Jyo0BWrI/EYVggTLMB1iokjkS31zDwF3sIn
	 hN3P8TX4WtbtbB8/nbpP0w7uCLzwrl9zZerx9CPDUlSaYxTRxOIEk/jYb5q/+SWwpy
	 jg3q4rqheD6Jg==
Date: Fri, 25 Sep 2026 17:48:04 +0100
From: Conor Dooley <conor@kernel.org>
To: Daniel Drake <dan@reactivated.net>
Cc: "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	nick.hollinghurst@raspberrypi.com, james.quinlan@broadcom.com,
	Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH v6 3/6] dt-bindings: display: brcm,bcm2835-hvs: Document
 iommus property
Message-ID: <20260925-flattered-thigh-50cc8cd8f9fe@spud>
References: <20260924-bcm2712-iommu-submit-v6-0-7b3cace86973@reactivated.net>
 <20260924-bcm2712-iommu-submit-v6-3-7b3cace86973@reactivated.net>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="8LAgqHSG8PdthsFm"
Content-Disposition: inline
In-Reply-To: <20260924-bcm2712-iommu-submit-v6-3-7b3cace86973@reactivated.net>

--8LAgqHSG8PdthsFm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--8LAgqHSG8PdthsFm
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaralxAAKCRB4tDGHoIJi
0nClAP4qSb3LEvuzORVdDN0PI6kfRuFphwW+o0wepGOBT1ImdAEAlIrQeeTCBnTU
xjRn3e1s5f9rvcd3cBB32d1CylXd8Qg=
=IMHn
-----END PGP SIGNATURE-----

--8LAgqHSG8PdthsFm--
