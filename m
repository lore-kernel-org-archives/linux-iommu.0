Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5215C4C7E;
	Thu, 26 Sep 2024 15:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727366388; cv=none; b=djgX0nsQiZ5gQD2O3SX77vgCHJbwBo1iF51TsJNAkOvYK5WPYqLEh3jj2M7eNAY3HFkcPnzzaetpPJ95e43j/qh+pk9ghrp0usUf+blFul1wyk3gE4XYXc59dHgUTtW+48gov5Mo3vt/LUx7/BsyCeQjzt3xlbR2H1m4SKs4QSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727366388; c=relaxed/simple;
	bh=5WPiZotTJNjDA/yWMHXdhILtKuuGmQdF3mrjZNA821k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YxQFPHoCUUANRQqlMvsadLKITBGmDoz+I2ipPUqo2eQRD83f9qF3m93JQG55g7s/o7SVlcGNGOp5r/BTn4nihJeom87zq1ez+gnCOUC90ARxzgxsdyYCAX7gL9QjOuW17rERy4WpmVjH7TzrLq1lmA6sRI5zmosrs9y0R9rW1vA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GEauHDz/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GEauHDz/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2596DC4CEC5;
	Thu, 26 Sep 2024 15:59:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727366387;
	bh=5WPiZotTJNjDA/yWMHXdhILtKuuGmQdF3mrjZNA821k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GEauHDz/vBRh7M8Li+EvWJ4ck1kr2Is+EqOj9sPiez6/KYucxWXoVT1x40jwiRhef
	 SkdDhc63WWETfh82y06j5gywdfdpE/K9C3RqdiqfFy2XNhHdvLIL5UIK0v31NpxkgD
	 63H9Amiwokhi7Jzk9BjiyrwgFxN+pLHppfNyqQYbo6SxWX4hTF/MppGveN3p6sBhYN
	 SXT87+siB6j3SV8VUh8tI6EHMfqREe4POKBt7P8DiPFH/UQscKZQ1rMtvFClXK0Y5l
	 eDjQLnMqfHLOBN4kwc/I4slu0Mp5Ry9f4NWAtugJWqYY3f9foMZph03OeDmBUGrxxD
	 y7kr8m7kRvbMQ==
Date: Thu, 26 Sep 2024 16:59:39 +0100
From: Conor Dooley <conor@kernel.org>
To: Macpaul Lin <macpaul.lin@mediatek.com>
Cc: Chun-Kuang Hu <chunkuang.hu@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Yong Wu <yong.wu@mediatek.com>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	CK Hu <ck.hu@mediatek.com>, Jitao shi <jitao.shi@mediatek.com>,
	Tinghan Shen <tinghan.shen@mediatek.com>,
	Seiya Wang <seiya.wang@mediatek.com>,
	Ben Lok <ben.lok@mediatek.com>,
	"Nancy . Lin" <nancy.lin@mediatek.com>,
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
Subject: Re: [PATCH v2 5/5] dt-bindings: display: mediatek: dpi: Add mt8195
 support in power domains
Message-ID: <20240926-visible-harmonica-a7cda103ff70@spud>
References: <20240926111449.9245-1-macpaul.lin@mediatek.com>
 <20240926111449.9245-5-macpaul.lin@mediatek.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="IMup/vqcFMn6Sn9a"
Content-Disposition: inline
In-Reply-To: <20240926111449.9245-5-macpaul.lin@mediatek.com>


--IMup/vqcFMn6Sn9a
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 26, 2024 at 07:14:49PM +0800, Macpaul Lin wrote:
> Add power domain binding to the mediatek DPI controller for MT8185.

This wording is confusing, no binding is being added here, you're just
allowing one property.

> The dpi node in mt8195.dtsi was triggering a dtbs_check error:
>   dp-intf@1c113000: power-domains: False schema does not allow [[44, 18]]

And while it is good to have the warning, it would be better to explain
here that there are actually power domains, since the dts could be wrong
here also.

Otherwise,
Acked-by: Conor Dooley <conor.dooley@microchip.com>

> Fixes: 5474d49b2f79 ("dt-bindings: display: mediatek: dpi: Add power doma=
ins")
> Signed-off-by: Macpaul Lin <macpaul.lin@mediatek.com>
> ---
>  .../devicetree/bindings/display/mediatek/mediatek,dpi.yaml       | 1 +
>  1 file changed, 1 insertion(+)
>=20
> Changes for v2:
>  - Because of the corresponding dts fix has been reviewed with a Reviewed=
-by: tag.
>    [1] https://lore.kernel.org/all/20240925080515.16377-1-macpaul.lin@med=
iatek.com/
>    We still need this change to fix the 2 dtbs_check errors.
>    So keeps no change here.
>=20
> diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,=
dpi.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,dpi.=
yaml
> index 3a82aec9021c..07acc8a76bfc 100644
> --- a/Documentation/devicetree/bindings/display/mediatek/mediatek,dpi.yaml
> +++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,dpi.yaml
> @@ -89,6 +89,7 @@ allOf:
>                  - mediatek,mt6795-dpi
>                  - mediatek,mt8173-dpi
>                  - mediatek,mt8186-dpi
> +                - mediatek,mt8195-dp-intf
>      then:
>        properties:
>          power-domains: false
> --=20
> 2.45.2
>=20

--IMup/vqcFMn6Sn9a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZvWE6gAKCRB4tDGHoIJi
0o8/AQDZGYmuC7hP+2xaTqwKXghh85TysD+qSjWhvV4FfeR+gQD8DbK1R1oHhLRL
a08ypff9VkE92E4iJH4I3W5M8tHjQQc=
=C4PU
-----END PGP SIGNATURE-----

--IMup/vqcFMn6Sn9a--
