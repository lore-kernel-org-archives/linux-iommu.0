Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8E0D1DA49
	for <iommu@lists.linux.dev>; Fri, 22 Sep 2023 08:11:43 +0000 (UTC)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madras.collabora.co.uk (Postfix) with ESMTPSA id 280926607258;
	Fri, 22 Sep 2023 09:11:41 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1695370301;
	bh=my87UWSGR/4HhyI7T8dI3SDO9uJQh+kcmiCcSmRd+Ow=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Rs4+uNsbKylFPbp1FCA63uzed7ePM8c/oKjNmjWOod/INxHWRQi+aFJfHlq87iutA
	 gpVX1SaxgPcwYlD0nOeZ/AzrbrG2T7RgkWyuBBZCw7M2s8BIS1kxixJy3s0awFiMxn
	 JV0Wv6F8C21RAjWI2c/MDv4w0+XaD2Hyoky/QZN/94zPehmXEa1gS4KUGvwn6/2cjW
	 VWYGiiX0i7fQLwwoZwkUAm8HMSlZDwR7EPHvknM2qtnAvIHXxmJ0VuXAp+a21nVM6d
	 o2ybOrxO68mjPFcaj2pooWuz3zdOaCtfw6C/ENx/mxBdBmHV9Tk1z+4B03NU8QE9u1
	 MIM8VObinboxQ==
Message-ID: <46987054-d763-15b1-7dc8-ae178fed6235@collabora.com>
Date: Fri, 22 Sep 2023 10:11:38 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH] iommu/mediatek: Fix share pgtable for iova over 4GB
Content-Language: en-US
To: Yong Wu <yong.wu@mediatek.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>
Cc: Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev,
 linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, Laura Nao <laura.nao@collabora.com>
References: <20230819081443.8333-1-yong.wu@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230819081443.8333-1-yong.wu@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 19/08/23 10:14, Yong Wu ha scritto:
> In mt8192/mt8186, there is only one MM IOMMU that supports 16GB iova
> space, which is shared by display, vcodec and camera. These two SoC use
> one pgtable and have not the flag SHARE_PGTABLE, we should also keep
> share pgtable for this case.
> 
> In mtk_iommu_domain_finalise, MM IOMMU always share pgtable, thus remove
> the flag SHARE_PGTABLE checking. Infra IOMMU always uses independent
> pgtable.
> 
> Fixes: cf69ef46dbd9 ("iommu/mediatek: Fix two IOMMU share pagetable issue")
> Reported-by: Laura Nao <laura.nao@collabora.com>
> Closes: https://lore.kernel.org/linux-iommu/20230818154156.314742-1-laura.nao@collabora.com/
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> ---
> Base on next-20230818.
> ---
>   drivers/iommu/mtk_iommu.c | 9 ++++-----
>   1 file changed, 4 insertions(+), 5 deletions(-)

Gentle ping for an important fix.

Thanks,
Angelo

