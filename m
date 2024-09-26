Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50A5F1BC4E;
	Thu, 26 Sep 2024 16:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727366575; cv=none; b=TJulGAB5S1SBbftxaFSHm2nhWDJgwpLLLrwmOA+1K5HjU6uJTlENoc6E4RUHWd3ID3sPZ7U4uri/vT0BTiLa1cMEkkVY6wjMVqxv9lRN+wP5GLHNODlROe/Vt/LwjzVY8gMqdYj7zBo6ItrMx9f3++a/rQoyrQ3UuWXzDvuEDF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727366575; c=relaxed/simple;
	bh=cFX2iwcGY8smAIVYvPnkwYiVZqSHddjY3KSuwun+Y+0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UW0Hp0Gva8bCeCAkUDhvZZMf6OmQ8QWW/p7CiPQt+G6gv5NTEWO+i6ZtCUokhgHcG5KadFqOzOf1U3CMfCwuhP3i/ZqWdDgSfVAJGnWXKfSRl+Z6OQQ8VDftb3mvh36EfoOdxoweUAbenBYccpRr+9QgpGBy9AvmzN3CeVj+BYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aThwMZ7n; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aThwMZ7n"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1329CC4CEC5;
	Thu, 26 Sep 2024 16:02:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727366574;
	bh=cFX2iwcGY8smAIVYvPnkwYiVZqSHddjY3KSuwun+Y+0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aThwMZ7ntlmNOCFu3DQ+T0K1QIlQab3w4DPhMzpJ1JdhseWgub0g0zEDmBGlErwJF
	 FWlVM8N89QkWz50P6pyfNalJO2ApU+QWedSNWKHfYIK3iGIKtBfz/Xu8SMYc+GWUSj
	 ezHcu3fciWPAamHaBDhctOLJw/ptBPTRu5yRcZ7eO0BeOCgURf9/g/zLYXOWWjWUWr
	 dQ+BN13pq7yRb37TwZgPTZPCyDLZhjKil9GV7rmQr6FYzo+HN5C031Npy3CelQtxJQ
	 EACzmJPZi5U3t06UDrfbWPpjRvC8qFr6kpXq5KvL9CpUyRfWnlqPNfo/T19vXIlDEi
	 HpunNQgRx7pdA==
Date: Thu, 26 Sep 2024 17:02:45 +0100
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
Subject: Re: [PATCH v2 2/5] dt-bindings: iommu: mediatek: Fix interrupt count
 constraint for new SoCs
Message-ID: <20240926-unbounded-gosling-6b4303106f27@spud>
References: <20240926111449.9245-1-macpaul.lin@mediatek.com>
 <20240926111449.9245-2-macpaul.lin@mediatek.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ZBg8ybapNV2iZUhq"
Content-Disposition: inline
In-Reply-To: <20240926111449.9245-2-macpaul.lin@mediatek.com>


--ZBg8ybapNV2iZUhq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 26, 2024 at 07:14:46PM +0800, Macpaul Lin wrote:
> The infra-iommu node in mt8195.dtsi was triggering a CHECK_DTBS error due
> to an excessively long 'interrupts' property. The error message was:
>=20
>   infra-iommu@10315000: interrupts: [[0, 795, 4, 0], [0, 796, 4, 0],
>                      [0, 797, 4, 0], [0, 798, 4, 0], [0, 799, 4, 0]]
>                      is too long
>=20
> To address this issue, add "minItems: 1" and "maxItems: 5" constraints to
> the 'interrupts' property in the DT binding schema. This change allows for
> flexibility in the number of interrupts for new SoCs.
> The purpose of these 5 interrupts is also added.
>=20
> Fixes: bca28426805d ("dt-bindings: iommu: mediatek: Convert IOMMU to DT s=
chema")
> Signed-off-by: Macpaul Lin <macpaul.lin@mediatek.com>
> ---
>  .../bindings/iommu/mediatek,iommu.yaml        | 25 ++++++++++++++++++-
>  1 file changed, 24 insertions(+), 1 deletion(-)
>=20
> Changes for v2:
>  - commit message: re-formatting and add a description of adding 5 interr=
upts.
>  - add 'description' and 'maxItems: 5' for 'interrupt' property of
>    'mt8195-iommu-infra'
>  - others keeps 'maxItems: 1'
>=20
> diff --git a/Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml =
b/Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml
> index ea6b0f5f24de..fdd2996d2a31 100644
> --- a/Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml
> +++ b/Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml
> @@ -96,7 +96,8 @@ properties:
>      maxItems: 1
> =20
>    interrupts:
> -    maxItems: 1
> +    minItems: 1
> +    maxItems: 5
> =20
>    clocks:
>      items:
> @@ -210,6 +211,28 @@ allOf:
>        required:
>          - mediatek,larbs
> =20
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - mediatek,mt8195-iommu-infra
> +
> +    then:
> +      properties:
> +        interrupts:
> +          description: |
> +            The IOMMU of MT8195 has 5 banks: 0/1/2/3/4.
> +            Each bank has a set of APB registers corresponding to the
> +            normal world, protected world 1/2/3, and secure world, respe=
ctively.
> +            Therefore, 5 interrupt numbers are needed.

> +          maxItems: 5

You repeat here the constraint from the original definition. Should this
be minitems: 5?

> +
> +    else:
> +      properties:
> +        interrupts:
> +          maxItems: 1
> +
>  additionalProperties: false
> =20
>  examples:
> --=20
> 2.45.2
>=20

--ZBg8ybapNV2iZUhq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZvWFpQAKCRB4tDGHoIJi
0ibCAPsHAeniGCRX+/+yKW9HldPNK9p8nlwfyNOBwMEhVkN6jQEAgjDWVAroTKmU
yK1gwHOVL51DUKPX8wUsyKexjwYaGwU=
=HLVk
-----END PGP SIGNATURE-----

--ZBg8ybapNV2iZUhq--
