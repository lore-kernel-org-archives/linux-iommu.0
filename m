Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F9FD1AB534;
	Tue, 24 Sep 2024 16:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727193781; cv=none; b=SZb8r8/sWBB+QRPapbXJf15euZxY5lredX89IdHG4ktpKbjb9jI2ikFVFs9Rh4UcEjsK2aaUHGZ5xvTHqRvB8IZDssdhYovihp1pg8zFgUnDTuFZvei3XCe5Pu/31RjPSEo68FIotYGHvj5YefW8z4QYKCua9AkNrRBx1+ssdFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727193781; c=relaxed/simple;
	bh=gNBST40WMUJwlZASY6q+rRAwgxHXwJRFWLXq+ARmaaw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WNPPdkfJc0N5orkZEY0rdlo55/XwAjIkx8gKXUx2mT4OsL75AbXk4hsEz0P7M5Ywy8XAs7fOFw6k5aqbZYL1l7bGd0/roHEmAlWP4/PaTv4u1CG5tleyNMs5aY+iHheyBs8F75G3qN7HKrymtDHQJxFmY3KgFiifE8edsHHAjOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EAqVdc6A; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EAqVdc6A"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D8BFC4CEC4;
	Tue, 24 Sep 2024 16:02:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727193780;
	bh=gNBST40WMUJwlZASY6q+rRAwgxHXwJRFWLXq+ARmaaw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EAqVdc6A0KBeMrsaRZ8EFB352zM4hbWTUfu7glhXJLZNlIOlSI4F1w+ysHKilo3Su
	 bN8S7HbO1pzZL3ScTi4wdq7HmDp4fM2HSUthPyqxrYspktSaYAdACu6Qy3FgP23t6b
	 UvwL81EYw7a/iTTHVq1gOGeUWOagk02BLiDEDVEqQIZOSfDGMjQU3Uan1EdPchwWuC
	 tQRyHHAu8jm7dExE60yfxEORrzap1lUje9jCK9+Z5Nd1wG6lACrn8W39EOI1yAw+af
	 4u7VMvsHxRqUY1KJZ6SJbSNgH6itI1Ohf0UJI8ObRPJvrKy+QJP2LfhLQXhdruwOnp
	 6C4oW7nkxlJlA==
Date: Tue, 24 Sep 2024 17:02:53 +0100
From: Conor Dooley <conor@kernel.org>
To: Macpaul Lin <macpaul.lin@mediatek.com>
Cc: Chun-Kuang Hu <chunkuang.hu@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Yong Wu <yong.wu@mediatek.com>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	dri-devel@lists.freedesktop.org, linux-mediatek@lists.infradead.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	Alexandre Mergnat <amergnat@baylibre.com>,
	Bear Wang <bear.wang@mediatek.com>,
	Pablo Sun <pablo.sun@mediatek.com>, Macpaul Lin <macpaul@gmail.com>,
	Sen Chu <sen.chu@mediatek.com>,
	Chris-qj chen <chris-qj.chen@mediatek.com>,
	MediaTek Chromebook Upstream <Project_Global_Chrome_Upstream_Group@mediatek.com>,
	Chen-Yu Tsai <wenst@chromium.org>
Subject: Re: [PATCH 2/6] dt-bindings: iommu: mediatek: Fix interrupt count
 constraint for new SoCs
Message-ID: <20240924-haiku-drudge-79e5824d4b6f@spud>
References: <20240924103156.13119-1-macpaul.lin@mediatek.com>
 <20240924103156.13119-2-macpaul.lin@mediatek.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="jUN0h7erQf3dJLyh"
Content-Disposition: inline
In-Reply-To: <20240924103156.13119-2-macpaul.lin@mediatek.com>


--jUN0h7erQf3dJLyh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 24, 2024 at 06:31:52PM +0800, Macpaul Lin wrote:
> The infra-iommu node in mt8195.dtsi was triggering a CHECK_DTBS error due
> to an excessively long 'interrupts' property. The error message was:
>=20
>   infra-iommu@10315000: interrupts: [[0, 795, 4, 0], [0, 796, 4, 0],
>                      [0, 797, 4, 0], [0, 798, 4, 0], [0, 799, 4, 0]]
>                      is too long
>=20
> To address this issue, add "minItems: 1" and "maxItems: 5" constraints to
> the 'interrupts' property in the DT binding schema. This change allows for
> flexibility in the number of interrupts for new SoCs
>=20
> Fixes: bca28426805d ("dt-bindings: iommu: mediatek: Convert IOMMU to DT s=
chema")
>=20

This space should be removed.

> Signed-off-by: Macpaul Lin <macpaul.lin@mediatek.com>
> ---
>  Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml =
b/Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml
> index ea6b0f5f24de..a00f1f0045b1 100644
> --- a/Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml
> +++ b/Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml
> @@ -96,7 +96,8 @@ properties:
>      maxItems: 1
> =20
>    interrupts:
> -    maxItems: 1
> +    minItems: 1
> +    maxItems: 5

You need to add an items list here, and probably some per compatible
constraints. What are each of the itnerrupts for?

> =20
>    clocks:
>      items:
> --=20
> 2.45.2
>=20

--jUN0h7erQf3dJLyh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZvLirAAKCRB4tDGHoIJi
0qsPAP99nNo/hdDREunSkJ59dRVvVSRDmf4UoBpnLL9JFTwMHgD/SjkR4sBd/XO9
MrEk/KC97quNhDCBzV3CTBvOk8laPww=
=PT+k
-----END PGP SIGNATURE-----

--jUN0h7erQf3dJLyh--
