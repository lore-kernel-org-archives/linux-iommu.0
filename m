Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 418863205
	for <iommu@lists.linux.dev>; Wed, 12 Apr 2023 14:34:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44D9DC433EF;
	Wed, 12 Apr 2023 14:34:15 +0000 (UTC)
Message-ID: <f74031f0-3c88-e3b4-0fa1-b406aacb11fd@xs4all.nl>
Date: Wed, 12 Apr 2023 16:34:13 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v7 10/14] media: mtk-jpegdec: Remove the setting for
 dma_mask
Content-Language: en-US
To: Yong Wu <yong.wu@mediatek.com>, Joerg Roedel <joro@8bytes.org>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, Rob Herring <robh+dt@kernel.org>
Cc: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 nfraprado@collabora.com, linux-media@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux.dev,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 mingyuan.ma@mediatek.com, yf.wang@mediatek.com, jianjiao.zeng@mediatek.com,
 Yunfei Dong <yunfei.dong@mediatek.com>,
 kyrie wu <kyrie.wu@mediatek.corp-partner.google.com>,
 chengci.xu@mediatek.com, youlin.pei@mediatek.com, anan.sun@mediatek.com,
 Bin Liu <bin.liu@mediatek.com>, kyrie wu <kyrie.wu@mediatek.com>
References: <20230411093144.2690-1-yong.wu@mediatek.com>
 <20230411093144.2690-11-yong.wu@mediatek.com>
From: Hans Verkuil <hverkuil@xs4all.nl>
In-Reply-To: <20230411093144.2690-11-yong.wu@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/04/2023 11:31, Yong Wu wrote:
> In order to simplify the masters to set their respective dma masks, MTK
> IOMMU helps to centralize the processing. Because all the dma ranges is
> set in IOMMU, IOMMU knows well the dma mask requirements of masters. After
> this patch, the masters code does not need care
> dma-ranges/dma_mask related information.
> 
> Cc: Bin Liu <bin.liu@mediatek.com>
> Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
> Cc: kyrie wu <kyrie.wu@mediatek.com>
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>

Acked-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>

Regards,

	Hans

> ---
>  drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c b/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c
> index 969516a940ba..9b96d2436311 100644
> --- a/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c
> +++ b/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c
> @@ -1757,9 +1757,6 @@ static int mtk_jpeg_probe(struct platform_device *pdev)
>  	jpeg->vdev->device_caps = V4L2_CAP_STREAMING |
>  				  V4L2_CAP_VIDEO_M2M_MPLANE;
>  
> -	if (of_get_property(pdev->dev.of_node, "dma-ranges", NULL))
> -		dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(34));
> -
>  	ret = video_register_device(jpeg->vdev, VFL_TYPE_VIDEO, -1);
>  	if (ret) {
>  		v4l2_err(&jpeg->v4l2_dev, "Failed to register video device\n");

