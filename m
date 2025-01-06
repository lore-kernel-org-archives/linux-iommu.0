Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 814E01D88BE
	for <iommu@lists.linux.dev>; Mon,  6 Jan 2025 08:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736152295; cv=none; b=M84m5rwoVcIhxf0xKDCkhR4MIxrRXd66iDB3HXQnpzQKZxZKxCnife+xHC0SJSIy+qGRB/7+wCP20SY9kHw7srTDI6Hp3XcW/0nAkqn2CsHtdfEnPCOWwAaSIg7PBetr2OuL37fdmk3U2uj6CJ1h3861lZoQuMumEamnTwnk27I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736152295; c=relaxed/simple;
	bh=mdW1Dhp8mTPIbOJSIufuNdW74kuICsBuLYeqGtO4PG4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=q7cEMg7eWzC7Ff9kht2zI2Iatc/6GlgdiNMUA2B/cZt6aaQPaVNo70uhbs5g5sscnkI68NSUJZJzUp5zU/QFQxs1Q+iPh+m8l7wbCkh2P+SbMW91m/ueYen1/BJjmxK/PgEntmlZr5AplFq++09Bl5AvdaXcAuzPjcAcjSM6vtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1tUiVn-0003Dn-TL; Mon, 06 Jan 2025 09:30:59 +0100
Received: from lupine.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::4e] helo=lupine)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1tUiVj-0078KE-2q;
	Mon, 06 Jan 2025 09:30:56 +0100
Received: from pza by lupine with local (Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1tUiVk-0008wh-1m;
	Mon, 06 Jan 2025 09:30:56 +0100
Message-ID: <ee93bdca7fddb03a1d1e8997ce21a9cb7339ae63.camel@pengutronix.de>
Subject: Re: [PATCH RESEND 09/22] iommu: sun50i: make reset control optional
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Parthiban Nallathambi <parthiban@linumiz.com>, Joerg Roedel
 <joro@8bytes.org>, Will Deacon <will@kernel.org>, Robin Murphy
 <robin.murphy@arm.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai
 <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland
 <samuel@sholland.org>, Maxime Ripard <mripard@kernel.org>, Maarten
 Lankhorst <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann
 <tzimmermann@suse.de>,  David Airlie <airlied@gmail.com>, Simona Vetter
 <simona@ffwll.ch>, Michael Turquette <mturquette@baylibre.com>,  Stephen
 Boyd <sboyd@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Vinod
 Koul <vkoul@kernel.org>,  Kishon Vijay Abraham I <kishon@kernel.org>
Cc: iommu@lists.linux.dev, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, 
	linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-phy@lists.infradead.org
Date: Mon, 06 Jan 2025 09:30:56 +0100
In-Reply-To: <20241227-a133-display-support-v1-9-abad35b3579c@linumiz.com>
References: <20241227-a133-display-support-v1-0-abad35b3579c@linumiz.com>
	 <20241227-a133-display-support-v1-9-abad35b3579c@linumiz.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: iommu@lists.linux.dev

On Fr, 2024-12-27 at 18:30 +0530, Parthiban Nallathambi wrote:
> A133/A100 SoC doesn't have reset control from the CCU. Get reset
> control line optionally.
>=20
> Signed-off-by: Parthiban Nallathambi <parthiban@linumiz.com>
> ---
>  drivers/iommu/sun50i-iommu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/iommu/sun50i-iommu.c b/drivers/iommu/sun50i-iommu.c
> index 8d8f11854676..2ba804d682dc 100644
> --- a/drivers/iommu/sun50i-iommu.c
> +++ b/drivers/iommu/sun50i-iommu.c
> @@ -1030,7 +1030,7 @@ static int sun50i_iommu_probe(struct platform_devic=
e *pdev)
>  		goto err_free_cache;
>  	}
> =20
> -	iommu->reset =3D devm_reset_control_get(&pdev->dev, NULL);
> +	iommu->reset =3D devm_reset_control_get_optional(&pdev->dev, NULL);
>  	if (IS_ERR(iommu->reset)) {
>  		dev_err(&pdev->dev, "Couldn't get our reset line.\n");
>  		ret =3D PTR_ERR(iommu->reset);

With dt-bindings changed to require resets on those platforms that do,

Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>

regards
Philipp
