Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5A281A4F0A
	for <iommu@lists.linux.dev>; Tue, 24 Sep 2024 11:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727178152; cv=none; b=A8zFLaS0bo3u1uESsM4+8h3sBHJeBWmPy9klSV1L9PxA53khPGVAo13Uq6RZCTHRgkgcLqxusUNW0vZ6zjsXU5fDy2fvNzGyiraOhTVT5ZWxwf7drfehv53qLp+5VvcKOhV2IbJibIcinAIIX+50ZdPLgw/JpIrpmCaXI7kPEno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727178152; c=relaxed/simple;
	bh=vEVQ1f1TFqVzooCmasQpj1OQzFxx1dYbcywfThJVzsE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nN9DSKJUxFtmjXwgVHkrUIXox1lRzqLKGXDYY+g1JZc2/3RW/vnXyvvnocBN81YNb5eZnHcduknJDllzIIcJ2gq0RfDvqGWF4PKRC2JTMDpVu6OkfNEWF/XAN4GaKtkKVlpN3l2rYW5wWLrpMbyGzB6SMTUrkY4efg9pOQaYEbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=XgFCXLMq; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="XgFCXLMq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1727178148;
	bh=vEVQ1f1TFqVzooCmasQpj1OQzFxx1dYbcywfThJVzsE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=XgFCXLMqrcqtfoN3RKT49uczLvlSssCt+YWhHFYwmQiBihgZUB48mN8r9hgK+nvvI
	 Oi8Urng0owrUnadvk7pkdNBvqNHN6vMCTq4qWjlLvAU1HeMH9EELT6+T5ggZcS/Rgl
	 kD7YVlq7VbhzCbD8EhGMycN+nrD+iSlc9Yp8Nf8r/nGw8oMht4ynaDmr7hyxSe2FRo
	 wO5JVhlt/Q5/ISSUaP83Evlde+JkTlT5aopZ4CKwA8ze9sB7uLI/t31cL90nJXVUQx
	 pMr7czP5yTAWnz/74pmTo21E8ifLIgX7uzN7iuKU6dqduORvnYUv2GeYgapB/HToGp
	 ITTQyihtTO28Q==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id C366B17E107A;
	Tue, 24 Sep 2024 13:42:27 +0200 (CEST)
Message-ID: <04280899-ceec-4083-8f94-0fe8535961d1@collabora.com>
Date: Tue, 24 Sep 2024 13:42:27 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/6] arm64: dts: mediatek: mt8395-genio-1200-evk: Fix
 dtbs_check error for phy
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
 <20240924103156.13119-4-macpaul.lin@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20240924103156.13119-4-macpaul.lin@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 24/09/24 12:31, Macpaul Lin ha scritto:
> The ethernet-phy node in mt8395-genio-1200-evk.dts was triggering a
> dtbs_check error. The error message was:
>    eth-phy0@1: $nodename:0: 'eth-phy0@1' does not match
>                '^ethernet-phy(@[a-f0-9]+)?$'
> Fix this issue by replacing 'eth-phy' node to generic 'ethernet-phy'.
> 
> Fixes: f2b543a191b6 ("arm64: dts: mediatek: add device-tree for Genio 1200 EVK board")
> Signed-off-by: Macpaul Lin <macpaul.lin@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


