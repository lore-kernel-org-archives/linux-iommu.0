Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD52C53B7
	for <iommu@lists.linux.dev>; Tue, 11 Apr 2023 10:13:08 +0000 (UTC)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madras.collabora.co.uk (Postfix) with ESMTPSA id 79EBE66031AD;
	Tue, 11 Apr 2023 11:13:05 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1681207987;
	bh=1H3KWce7lVaN7lBiBpl5nSiFSWCqXnPRyAtBaYBLFVc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=hZTzeZYDKZ3ZldqIgqJCufl0SAwJbxmonCeW8hVZljq4bHLXLMSlQfdJuWwPJvf7h
	 x/oRocUfJSEoozC6q7Fa/viYWxoj8OXyL3eq1luHMJJzXMimUDj+oHs5pCOLoF8zQK
	 a0L2VijRN6dXRTs7FPd3OvdmsnGyS+/pxA0GT0Lwy9A9iwKJ9xRPBbJgeS/15AKuIZ
	 r3D0NlyDvpUYbn8fQZNOMANb/xcs5MPT80GDfoP/n8iB28g982rToCB6IqVtQt8zf/
	 GwFuyCbdmVXGoW7gFDuewEXA0jrVBA+ndGyhdSVQ4/5Y2g0CrBVhDYuGf6HfE5UdTV
	 6CiAIEiXkCALQ==
Message-ID: <9ea6f6f4-5ebf-e9b6-37bc-b8d018b1b25c@collabora.com>
Date: Tue, 11 Apr 2023 12:13:03 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v7 11/14] media: mediatek: vcodec: Remove the setting for
 dma_mask
Content-Language: en-US
To: Yong Wu <yong.wu@mediatek.com>, Joerg Roedel <joro@8bytes.org>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, Rob Herring <robh+dt@kernel.org>
Cc: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Hans Verkuil <hverkuil@xs4all.nl>, nfraprado@collabora.com,
 linux-media@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
 mingyuan.ma@mediatek.com, yf.wang@mediatek.com, jianjiao.zeng@mediatek.com,
 Yunfei Dong <yunfei.dong@mediatek.com>,
 kyrie wu <kyrie.wu@mediatek.corp-partner.google.com>,
 chengci.xu@mediatek.com, youlin.pei@mediatek.com, anan.sun@mediatek.com,
 Tiffany Lin <tiffany.lin@mediatek.com>,
 Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
 irui wang <irui.wang@mediatek.com>
References: <20230411093144.2690-1-yong.wu@mediatek.com>
 <20230411093144.2690-12-yong.wu@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230411093144.2690-12-yong.wu@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 11/04/23 11:31, Yong Wu ha scritto:
> In order to simplify the masters to set their respective dma masks, MTK
> IOMMU helps to centralize the processing. Because all the dma ranges is
> set in IOMMU, IOMMU knows well the dma mask requirements of masters. After
> this patch, the masters(codec here) code does not need care
> dma-ranges/dma_mask related information.
> 
> Cc: Tiffany Lin <tiffany.lin@mediatek.com>
> Cc: Andrew-CT Chen <andrew-ct.chen@mediatek.com>
> Cc: Yunfei Dong <yunfei.dong@mediatek.com>
> Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
> Cc: irui wang <irui.wang@mediatek.com>
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


