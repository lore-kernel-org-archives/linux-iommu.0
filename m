Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E3121C16
	for <iommu@lists.linux.dev>; Mon, 17 Apr 2023 09:04:08 +0000 (UTC)
Received: from [IPV6:2001:b07:2ed:14ed:c5f8:7372:f042:90a2] (unknown [IPv6:2001:b07:2ed:14ed:c5f8:7372:f042:90a2])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madras.collabora.co.uk (Postfix) with ESMTPSA id E3B4D660309E;
	Mon, 17 Apr 2023 10:04:05 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1681722246;
	bh=mmJ0iBDdFxaw1hgC1BUonlQRRJ5YNpa5yzZ59XFkdY8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=IsIwscG9vpQo5g+as2A2VwbuhAaeS91T4rhpvpyRoj2MkE2mMlHPtOGRchRFwTYag
	 3ceHD3BmX3DEoTJ82clCEpWyIXff/9tithcoLlIaZy5/rNSj87pZJq5JzO5Pb5AhTj
	 kDAK7HBB8WNgtWZ6OVxQX1wyJzfR37on8hxp26HGo/G829OwQtVwfBsRQcd6zcaX4S
	 A+8Nw31pUGorLY9CqImD55kLocvlD8biBVvPOeU5k2exJVrNqTrcU2vZXNSt7dU+wV
	 09lJONJies1zQAdacjTtkyry8qv42vEEoaAJmBgKTl6N1hb5234TLC4gz67+XalLyu
	 cptzz1sD80BQg==
Message-ID: <b645c058-9f51-034b-0e81-94c8d69469c1@collabora.com>
Date: Mon, 17 Apr 2023 11:04:03 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v10 7/7] MAINTAINERS: iommu/mediatek: Update the header
 file name
Content-Language: en-US
To: Yong Wu <yong.wu@mediatek.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Matthias Brugger <matthias.bgg@gmail.com>
Cc: Robin Murphy <robin.murphy@arm.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 iommu@lists.linux.dev, linux-mediatek@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, mingyuan.ma@mediatek.com,
 yf.wang@mediatek.com, jianjiao.zeng@mediatek.com, chengci.xu@mediatek.com
References: <20230417073606.25729-1-yong.wu@mediatek.com>
 <20230417073606.25729-8-yong.wu@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230417073606.25729-8-yong.wu@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 17/04/23 09:36, Yong Wu ha scritto:
> We add the prefix "mediatek," for the lastest ports header file name,
> For example, include/dt-bindings/memory/mediatek,mt8188-memory-port.h.
> Update the entry from "mt*" to "m*".
> 
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> ---
>   MAINTAINERS | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index d8ebab595b2a..833d32c356ef 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -13056,7 +13056,7 @@ L:	linux-mediatek@lists.infradead.org (moderated for non-subscribers)
>   S:	Supported
>   F:	Documentation/devicetree/bindings/iommu/mediatek*
>   F:	drivers/iommu/mtk_iommu*
> -F:	include/dt-bindings/memory/mt*-port.h
> +F:	include/dt-bindings/memory/m*-port.h

Stuff that's not MediaTek specific which filename starts by m and ends for -port.h
is really unlikely, but we can prevent future issues.

Perhaps the best idea here would be to keep the mt*-port.h and add a new file entry
with mediatek,mt*-port.h.

Regards,
Angelo

