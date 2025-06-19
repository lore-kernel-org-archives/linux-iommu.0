Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62E1D278753;
	Thu, 19 Jun 2025 15:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750345362; cv=none; b=TMvXbnz4LZA2WDHgnoy+lDMz13o35dYlCc1YnNXB5PzamfXbjv7UT+B2tYbe9/zp1SFlhsZvrGEyyqw7NlvcwRWtkpyc18Wkb2GFZQDDL44fS0rQN5ceeDQEK0UTxXtYPWfKtYfY3+DUOVjdKvAwuioIJxKcblyADfwpmJ+UFLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750345362; c=relaxed/simple;
	bh=WMUgOCPru52VAFqEHtr6GwXaBkUBQdB2s1jxRDDNld0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=us6XRKv1rcUQ0Ak7HuXHBfGjcBy2mGgayG37JXky3S5mTavG8kkxnKEZdvtyCmBuDjh6kjxfCVBKANJn1wDGI9UjBNBHote+OuQE5kmz1iqMcoMY8B0SXnbObr0LlxOqzrcFhqxU3RRnLNz5K7E3lwPrK1/AqoUEACXk12XfraM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YX0TziWK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YX0TziWK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD4C4C4CEEA;
	Thu, 19 Jun 2025 15:02:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750345361;
	bh=WMUgOCPru52VAFqEHtr6GwXaBkUBQdB2s1jxRDDNld0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YX0TziWK1LG1a7QkFBlLUDt9JBwOReEQ9+u42HbJfQwQFeLvUjfTgbpIedIwqhvT2
	 IJqmHF6ev3cY1lPLf/l0TJebZiPvvp1YXfAmB7kWYNXtFJaQKyV0gz+GnlgYVWpq9W
	 1tHjLm3EDkj/QmvXjX7lfsTq5zfABrg4eUjbIuJCFZl4iKsHdpYYLvbIAFCbteRaBr
	 vXTKnEIXRniwycPDhoHypmCNdghR35KGofNaOBYiid1nnuLRkiNYKUbS8nmhZWuW8d
	 uMb0oiQtuQDlpZuPqQLZn53O0B4/cdDz4G2//V8GYYoTchb7xsswUbhLbEkmiBFqtX
	 vl+UdsYqQVbhQ==
Date: Thu, 19 Jun 2025 16:02:36 +0100
From: Conor Dooley <conor@kernel.org>
To: Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: Benjamin Gaignard <benjamin.gaignard@collabora.com>, joro@8bytes.org,
	will@kernel.org, robin.murphy@arm.com, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, heiko@sntech.de,
	nicolas.dufresne@collabora.com, jgg@ziepe.ca, iommu@lists.linux.dev,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, kernel@collabora.com
Subject: Re: [PATCH v3 2/5] dt-bindings: iommu: verisilicon: Add binding for
 VSI IOMMU
Message-ID: <20250619-nape-iphone-0fd4f9889452@spud>
References: <20250619131232.69208-1-benjamin.gaignard@collabora.com>
 <20250619131232.69208-3-benjamin.gaignard@collabora.com>
 <n5ddeogrpgctrljnxjfxqaz22qfnxsgm6ro7qihbjeyhd5br44@ojlzlz7gsuzb>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ZsCqWODAaq6bj8Vt"
Content-Disposition: inline
In-Reply-To: <n5ddeogrpgctrljnxjfxqaz22qfnxsgm6ro7qihbjeyhd5br44@ojlzlz7gsuzb>


--ZsCqWODAaq6bj8Vt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 19, 2025 at 04:19:32PM +0200, Sebastian Reichel wrote:
> Hi,
>=20
> On Thu, Jun 19, 2025 at 03:12:23PM +0200, Benjamin Gaignard wrote:
> > +properties:
> > +  compatible:
> > +    items:
> > +      - const: verisilicon,iommu
> > +      - const: rockchip,rk3588-iommu-1.2
>=20
> The entries should be ordered the other way around, so that the
> "generic" compatible is the fallback. Also the 1.2 version is from
> Verisilicon. It does not really make sense for Rockchip. So I
> think it should look like this:
>=20
> properties:
>   compatible:
>     items:
>       - const: rockchip,rk3588-av1-iommu
>       - const: verisilicon,iommu-1.2

If you're not sure Benjamin, please just ask questions. There's been
like 3 versions of this patch, soon to be 4, in like 3 days, two of
which could have been avoided if you just asked "is this what you mean"?

--ZsCqWODAaq6bj8Vt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaFQmjAAKCRB4tDGHoIJi
0mu2AQDy10QjeZsSnzVsEXfW6RViKo+rWauSa17R3QQdXnwOggEArRSd9DXggCSu
+9Yh5AMC+TMbCL1HN15ms1SSzBkkVgY=
=sX7T
-----END PGP SIGNATURE-----

--ZsCqWODAaq6bj8Vt--
