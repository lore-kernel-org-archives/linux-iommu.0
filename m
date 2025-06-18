Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7D11202C3A;
	Wed, 18 Jun 2025 15:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750262165; cv=none; b=tSkzl1f/MSGT1bXg+M6cVW5FGZJY78r4FgN00RJwQQtOqU/oPT3+EjlaNf+DsAvNADKac6SdfVHxBqwTkcFsQSiGS9Ms/OFJWZegHxfgJzYNtuDMKvZDRNefoyKVQa1XHTplqz1E0OBP2fuX34OQz9WIzM+WX6hqYsN9lhmR3hQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750262165; c=relaxed/simple;
	bh=y14ImL1XP5d71TlD/C03rbujmTDgub3jAIW5DPpjTro=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VOw7Nae5vDHxLUB+Fb+Ryf2UNWBHYJSjJS9Osdm/xBzj907WLqGGnpEyw5FtxjNecl9+zx8Y6T1p9niNCmSeOwETaoCYaxuNber7z1fVJpe1moPeGbMBA/vJDhYyguIw3cGM0cegl6U0AzzRVZwXqjapkG341A8Scr9kOk7wO3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tiTLVs24; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tiTLVs24"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64C31C4CEE7;
	Wed, 18 Jun 2025 15:56:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750262164;
	bh=y14ImL1XP5d71TlD/C03rbujmTDgub3jAIW5DPpjTro=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tiTLVs24ov/F6fXLP+VBWrYe/DlTd7uUrvgNJvE1noOe4Py7jE3N21L2npCpagKxj
	 nExCzeEMlhXTJXAd5PrlDJiRiwVgaB7gxJeeuegcH2lmcWK234alCReruO1u/Juw/B
	 aE+jfxwuV0hbkMv/tHdcIhQcYbHH4czrzK53Iurlblvc3kv7DV/budWE4/wsOlpPf4
	 EqGwxR91q5pY3KLD0CwZ7Yw/pYvxKpWqhMYdgz0CZ0eP4cE2/Ad5LIvaLfvnMspi9M
	 V7Do2AdO4783IldIsHnc7v/GesZ44/PelzNtLQjYP6S/qFnOIb4FDlgZ+qwR3y+09y
	 AWEDKk7kL6z+A==
Date: Wed, 18 Jun 2025 16:55:59 +0100
From: Conor Dooley <conor@kernel.org>
To: Benjamin Gaignard <benjamin.gaignard@collabora.com>
Cc: joro@8bytes.org, will@kernel.org, robin.murphy@arm.com, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, heiko@sntech.de,
	nicolas.dufresne@collabora.com, jgg@ziepe.ca, iommu@lists.linux.dev,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, kernel@collabora.com
Subject: Re: [PATCH v2 2/5] dt-bindings: iommu: verisilicon: Add binding for
 VSI IOMMU
Message-ID: <20250618-tighten-morphing-47953075b131@spud>
References: <20250618140923.97693-1-benjamin.gaignard@collabora.com>
 <20250618140923.97693-3-benjamin.gaignard@collabora.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Z++lINJ27TajwB1V"
Content-Disposition: inline
In-Reply-To: <20250618140923.97693-3-benjamin.gaignard@collabora.com>


--Z++lINJ27TajwB1V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 18, 2025 at 04:09:11PM +0200, Benjamin Gaignard wrote:
> Add a device tree binding for the Verisilicon (VSI) IOMMU.
> This IOMMU sits in front of hardware encoder and decoder
> blocks on SoCs using Verisilicon IP, such as the Rockchip RK3588.
>=20
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
> ---
> changes in version 2:
> - Add a compatible "rockchip,rk3588-av1-iommu"
> - Fix clock-names in binding=20
> - Remove "vsi_mmu" label in binding example.
>=20
>  .../bindings/iommu/verisilicon,iommu.yaml     | 72 +++++++++++++++++++
>  1 file changed, 72 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iommu/verisilicon,i=
ommu.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/iommu/verisilicon,iommu.ya=
ml b/Documentation/devicetree/bindings/iommu/verisilicon,iommu.yaml
> new file mode 100644
> index 000000000000..9ae4a45d76f4
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iommu/verisilicon,iommu.yaml
> @@ -0,0 +1,72 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iommu/verisilicon,iommu.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Verisilicon IOMMU
> +
> +maintainers:
> +  - Benjamin Gaignard <benjamin.gaignard@collabora.com>
> +
> +description: |+
> +  A Versilicon iommu translates io virtual addresses to physical address=
es for
> +  its associated video decoder.
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - enum:
> +          - verisilicon,iommu
> +          - rockchip,rk3588-av1-iommu

This isn't right. Firstly, the "oneOf: - enum" construct doesn't do
anything. oneOf one item is just the item. Secondly this still allows
verisilicon,iommu in isolation which is not okay. What you actually want
here is
items:
  - const: a
  - const: b

Thirdly, Nicolas mentioned that the version of this iommu is 1.2.0,
which I would like to see reflected in the compatible.

--Z++lINJ27TajwB1V
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaFLhjgAKCRB4tDGHoIJi
0vB/AQCNK4tUJrrBtB91ikBSoiUUESBAhs91t/tLoNI6BezTNwD/TT+xxCi+29w8
EL8ApkHM1NexQn9tJmglNf0tfkz4rwA=
=ASP4
-----END PGP SIGNATURE-----

--Z++lINJ27TajwB1V--
