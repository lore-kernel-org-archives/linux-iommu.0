Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E31519B3DD
	for <iommu@lists.linux.dev>; Tue, 24 Sep 2024 11:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727178126; cv=none; b=QtoX7Px1kN8aBVtTTlh02xdDDP0hLJ+IngMtYamVgoQ8nr7lVtd2TSkdWU9weFqsLWLZ6ZKyIXfXkbQvYtZ+0CLJXpaKWB+zttcrwvwPxZhAqWadPwQO8+oYGlZJr62LjUiD1Ahb1F/BnMMw+0P3s6HEw9Xsl+xo3P7uvn8jTf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727178126; c=relaxed/simple;
	bh=+fsK5xp17nTvCAyZ/wFo8VTI8Bqp558Z+p7y9KUbR8I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B/LcSSjTxtu6/Vazn5BTBITqch8GABaUS2/CvWzM7ZKD9ZWNK2k/brMaOu8t1B8AuR1ZbSxpBZ8HrsWJsBdr+Y4qI1ERYLtgWzEf6N7WzC8BmHIoGYc8czjuxCFgnIJdlO4LMUMwAZ3Lr54N8Uis95n9znl2QSZ++2gfn2BLhQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=TYUC6mb1; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="TYUC6mb1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1727178122;
	bh=+fsK5xp17nTvCAyZ/wFo8VTI8Bqp558Z+p7y9KUbR8I=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=TYUC6mb1OIjY9Tr4ZxGTLJPC5ICHePECuoh+hbdqqWwlnd3qgZaJRM5v6doRGjr4E
	 JssL9RyNYt5kthsIhU+xnWA8wxsQ6HgsAnsCTr+on15AtWym1LAfL3QFAEJQV3UIrE
	 jgNHeU0+9wT2d0+AOn4Nl3kHCb5I+pYYMbBoMiS8MnkGipijHC222pyGsy8wf+DwVy
	 3prdbZ1y6xMH2um7supv3bRfkkPU/FYWqq28nvEfAq2GQMDTmVqFcnBfQgS8SluzAz
	 epQ8kO5TXXkI0TPtiJfC0P4bjNw7dh1f5uRGmP0LAr0Fm2Hb/aerekXUorzNzFbX9S
	 LU2kNeswr0z4Q==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 8DAC317E107A;
	Tue, 24 Sep 2024 13:42:01 +0200 (CEST)
Message-ID: <ffc1900b-3921-48ca-a2b2-1b798c57e572@collabora.com>
Date: Tue, 24 Sep 2024 13:42:01 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/6] dt-bindings: display: mediatek: Fix clocks count
 constraint for new SoCs
To: Macpaul Lin <macpaul.lin@mediatek.com>,
 Chun-Kuang Hu <chunkuang.hu@kernel.org>,
 Philipp Zabel <p.zabel@pengutronix.de>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Yong Wu <yong.wu@mediatek.com>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 Matthias Brugger <matthias.bgg@gmail.com>, dri-devel@lists.freedesktop.org,
 linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org,
 Alexandre Mergnat <amergnat@baylibre.com>
Cc: Bear Wang <bear.wang@mediatek.com>, Pablo Sun <pablo.sun@mediatek.com>,
 Macpaul Lin <macpaul@gmail.com>, Sen Chu <sen.chu@mediatek.com>,
 Chris-qj chen <chris-qj.chen@mediatek.com>,
 MediaTek Chromebook Upstream
 <Project_Global_Chrome_Upstream_Group@mediatek.com>,
 Chen-Yu Tsai <wenst@chromium.org>
References: <20240924103156.13119-1-macpaul.lin@mediatek.com>
 <20240924103156.13119-3-macpaul.lin@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20240924103156.13119-3-macpaul.lin@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 24/09/24 12:31, Macpaul Lin ha scritto:
> The display node in mt8195.dtsi was triggering a CHECK_DTBS error due
> to an excessively long 'clocks' property:
>    display@14f06000: clocks: [[31, 14], [31, 43], [31, 44]] is too long
> 
> To resolve this issue, add "maxItems: 3" to the 'clocks' property in
> the DT schema.
> 
> Fixes: 4ed545e7d100 ("dt-bindings: display: mediatek: disp: split each block to individual yaml")
> Signed-off-by: Macpaul Lin <macpaul.lin@mediatek.com>
> ---
>   .../devicetree/bindings/display/mediatek/mediatek,split.yaml     | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,split.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,split.yaml
> index e4affc854f3d..42d2d483cc29 100644
> --- a/Documentation/devicetree/bindings/display/mediatek/mediatek,split.yaml
> +++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,split.yaml
> @@ -57,6 +57,7 @@ properties:
>     clocks:
>       items:
>         - description: SPLIT Clock

That's at least confusing (granted that it works) - either add a description for
each clock and then set `minItems: 1` (preferred), or remove this "SPLIT Clock"
description and allow a maximum of 3 clocks.

Removing the description can be done - IMO - because "SPLIT Clock" is, well,
saying that the SPLIT block gets a SPLIT clock ... stating the obvious, anyway.

Cheers,
Angelo

> +    maxItems: 3
>   
>   required:
>     - compatible

