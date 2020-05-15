Return-Path: <SRS0=PRYs=65=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25709C433DF
	for <iommu@archiver.kernel.org>; Fri, 15 May 2020 09:50:46 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A6C322065C
	for <iommu@archiver.kernel.org>; Fri, 15 May 2020 09:50:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6C322065C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 697FA85BE4;
	Fri, 15 May 2020 09:50:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dUZMiQaPlFGE; Fri, 15 May 2020 09:50:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 793D985D37;
	Fri, 15 May 2020 09:50:40 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 60820C0859;
	Fri, 15 May 2020 09:50:40 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2B8C8C016F
 for <iommu@lists.linux-foundation.org>; Fri, 15 May 2020 08:15:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 3E8DD86D9D
 for <iommu@lists.linux-foundation.org>; Fri, 15 May 2020 08:15:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6cALmF7oPUAV for <iommu@lists.linux-foundation.org>;
 Fri, 15 May 2020 08:15:41 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net
 [217.70.183.201])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 0798A858A6
 for <iommu@lists.linux-foundation.org>; Fri, 15 May 2020 08:15:40 +0000 (UTC)
X-Originating-IP: 93.29.109.196
Received: from aptenodytes (196.109.29.93.rev.sfr.net [93.29.109.196])
 (Authenticated sender: paul.kocialkowski@bootlin.com)
 by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id 6C5C51BF208;
 Fri, 15 May 2020 08:15:34 +0000 (UTC)
Date: Fri, 15 May 2020 10:15:33 +0200
From: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To: Maxime Ripard <maxime@cerno.tech>
Subject: Re: [PATCH v4 5/5] drm/sun4i: mixer: Call of_dma_configure if
 there's an IOMMU
Message-ID: <20200515081533.GA2486@aptenodytes>
References: <cover.b27dedd61e008ffcf55a028ccddda3bb4d21dfc8.1589378833.git-series.maxime@cerno.tech>
 <9a4daf438dd3f2fe07afb23688bfb793a0613d7d.1589378833.git-series.maxime@cerno.tech>
MIME-Version: 1.0
In-Reply-To: <9a4daf438dd3f2fe07afb23688bfb793a0613d7d.1589378833.git-series.maxime@cerno.tech>
X-Mailman-Approved-At: Fri, 15 May 2020 09:50:39 +0000
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 iommu@lists.linux-foundation.org, Maxime Ripard <mripard@kernel.org>,
 Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
 Frank Rowand <frowand.list@gmail.com>, linux-arm-kernel@lists.infradead.org
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============3098638967616801775=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


--===============3098638967616801775==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="vkogqOf2sHV7VnPd"
Content-Disposition: inline


--vkogqOf2sHV7VnPd
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed 13 May 20, 16:07, Maxime Ripard wrote:
> The main DRM device is actually a virtual device so it doesn't have the
> iommus property, which is instead on the DMA masters, in this case the
> mixers.
>=20
> Add a call to of_dma_configure with the mixers DT node but on the DRM
> virtual device to configure it in the same way than the mixers.

Although I'm not very familiar with the DMA API, this looks legit to me and
matches what's already done in sun4i_backend for the interconnect. So:

Reviewed-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>

Cheers,

Paul

> Signed-off-by: Maxime Ripard <maxime@cerno.tech>
> ---
>  drivers/gpu/drm/sun4i/sun8i_mixer.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/sun4i/sun8i_mixer.c b/drivers/gpu/drm/sun4i/=
sun8i_mixer.c
> index 56cc037fd312..cc4fb916318f 100644
> --- a/drivers/gpu/drm/sun4i/sun8i_mixer.c
> +++ b/drivers/gpu/drm/sun4i/sun8i_mixer.c
> @@ -363,6 +363,19 @@ static int sun8i_mixer_bind(struct device *dev, stru=
ct device *master,
>  	mixer->engine.ops =3D &sun8i_engine_ops;
>  	mixer->engine.node =3D dev->of_node;
> =20
> +	if (of_find_property(dev->of_node, "iommus", NULL)) {
> +		/*
> +		 * This assume we have the same DMA constraints for
> +		 * all our the mixers in our pipeline. This sounds
> +		 * bad, but it has always been the case for us, and
> +		 * DRM doesn't do per-device allocation either, so we
> +		 * would need to fix DRM first...
> +		 */
> +		ret =3D of_dma_configure(drm->dev, dev->of_node, true);
> +		if (ret)
> +			return ret;
> +	}
> +
>  	/*
>  	 * While this function can fail, we shouldn't do anything
>  	 * if this happens. Some early DE2 DT entries don't provide
> --=20
> git-series 0.9.1
>=20
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--=20
Paul Kocialkowski, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

--vkogqOf2sHV7VnPd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEJZpWjZeIetVBefti3cLmz3+fv9EFAl6+T6UACgkQ3cLmz3+f
v9H/UAgAkvadU2hkk0g8AzqD7A8wD9HZa1w2iDr5XqyJebfprIsxG8x5MpZWf9BQ
RTe1YsTxBBAeX49KifKGTI+TxipHj2A0Ebt9nIDUpP6vXQ7q/t24R8VhOeRiFLLM
Ke2pNX4F6XaV0CHM5YeQOp1OndJgZ1ioWlfqp+296kTRC1+8L7l6BPI1HkT8WVOi
mi8+8iBF3szadtkUm+h33BwKNxAnkWsybWK06pg+VNUT4dcld6RUH/c+XCFOr39j
2c617QVi3poan+h3psdcEFwnrbKwGyR8YsqHyBOwAZkW/2l4ItTUE3A6SFLKguca
BeSlxCAarYm3YuaLzCm6TgeX+7u68w==
=r6Qc
-----END PGP SIGNATURE-----

--vkogqOf2sHV7VnPd--

--===============3098638967616801775==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============3098638967616801775==--
