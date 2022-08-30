Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B79B762E
	for <iommu@lists.linux.dev>; Tue, 30 Aug 2022 08:16:41 +0000 (UTC)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madras.collabora.co.uk (Postfix) with ESMTPSA id 5279A6601E8E;
	Tue, 30 Aug 2022 09:16:39 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1661847400;
	bh=WZChgXoVHLOIRXF2mN0QrI8uplM6Fh3PZD9YJmLSqxo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=MhBgXvtat6cy9ZP5JOiRoGu+XppJIYp2CuGoxhKEW4pV/eiv/C1CQhtRP51S75xP/
	 PG5ndYriiX4yRP8Ug++15ZBx3aaQqZ9no55ymFdKz1SsJBTWaHv73XTn9ZBPhzjiW1
	 lsbZv4W2xIxyiVf2gQhVHz2mj1cANDhr3v7A7NYKjPrMX8v4N/fYr0+7kWRmr385Xy
	 +26q3LS1uMnMiHbCdi7ukj+SfJhpCWkxeqYgabcGA+LnJOOwDkpEf3YIzU6ZMfnsMJ
	 S1d62v3QLYAvL3/GX5g9WL/SyT/1D33R3GM3DDHbtaIVi1+n3Hzb9E0l3Xu6B4ATzr
	 lpbRC9VgNbCzw==
Message-ID: <62b52d5b-26e7-a629-daa6-8c63265e62e0@collabora.com>
Date: Tue, 30 Aug 2022 10:16:37 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v4 1/6] iommu/mediatek: Add platform_device_put for
 recovering the device refcnt
Content-Language: en-US
To: Yong Wu <yong.wu@mediatek.com>, Joerg Roedel <joro@8bytes.org>,
 Matthias Brugger <matthias.bgg@gmail.com>, Will Deacon <will@kernel.org>
Cc: Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev,
 iommu@lists.linux-foundation.org, linux-mediatek@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 mingyuan.ma@mediatek.com, yf.wang@mediatek.com, libo.kang@mediatek.com,
 chengci.xu@mediatek.com, youlin.pei@mediatek.com, anan.sun@mediatek.com,
 xueqi.zhang@mediatek.com, Guenter Roeck <groeck@chromium.org>,
 Dan Carpenter <dan.carpenter@oracle.com>
References: <20220824064306.21495-1-yong.wu@mediatek.com>
 <20220824064306.21495-2-yong.wu@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220824064306.21495-2-yong.wu@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 24/08/22 08:43, Yong Wu ha scritto:
> Add platform_device_put to match with of_find_device_by_node.
> 
> Meanwhile, I add a new variable "pcommdev" which is for smi common device.
> Otherwise, "platform_device_put(plarbdev)" for smi-common dev may be not
> readable. And add a checking for whether pcommdev is NULL.
> 
> Fixes: d2e9a1102cfc ("iommu/mediatek: Contain MM IOMMU flow with the MM TYPE")
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

