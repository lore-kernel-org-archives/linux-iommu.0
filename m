Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64CADED0
	for <iommu@lists.linux.dev>; Tue, 22 Nov 2022 16:49:06 +0000 (UTC)
Received: by mail-wm1-f41.google.com with SMTP id o7-20020a05600c510700b003cffc0b3374so11563209wms.0
        for <iommu@lists.linux.dev>; Tue, 22 Nov 2022 08:49:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=z3fcqOHVduVIIg4z4ijk3ykjn2RM3trgK5/ehZ3bY1M=;
        b=GdK7IiaGPYoYt2Cullz/bFXz5P3zaEbhbB2t0ZpbwFzBQeOMMKazdbcRBwospX37Ui
         pqMiIGLcaq9zFfPEICfldvKXfL31lnz0AaqH4lHRW1xbnHaDy/Lg4rdvd7XQjNxtq+ay
         1iqBc+fexaXnaY8vB2aO3JXyzKh/ipGhRImpUWnP3k8BcfmZebvEe4wqfSsUE5LZmN+8
         LmM6RhNUPnWyN7PHzsyFSneAEOivB3ucTrbdj4p7TsX7scxtByO6GWlpXTANw65+rSSo
         fJQ6zBeq9qJWeAL4dyugp+BKONx4Qikr+2fGiGvQOWJomWt9c7/sR/U9dBCEYOn2FDML
         9FtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z3fcqOHVduVIIg4z4ijk3ykjn2RM3trgK5/ehZ3bY1M=;
        b=wo09ta/yFW2MGOIyABkKHd7dgVfRj8N7bfrjfqlhax8G7W3v4ZE74iKsxVAUi3xexr
         PqWCVGWYjZ9RrsM1gCL5jDOugo22YFB4Ztc8lLJ/q5vWwvsJQQNDEr1hbktiRpfkAVON
         VqVSH8HBloEt8jXRROM/ZWTWJqqjCdU0KjiTKr00jc5JFnoEPBBclYSh8USMBRRkmMpl
         14ncYyM0r9NWZT7Yr2WuuSp/+xaItK78XSgzuNH1W71hzxZhs1ud1rgR9SH42+wDyuKb
         hoBLDC5FAgZW5c2fp203UJS6x5PmLZIxr0xHpfbf3erFo/pGKS11p9AHA/CRsnM+VyFJ
         aUIA==
X-Gm-Message-State: ANoB5pndlnjvllngYmftwhnUgEUoNq07GNKwEWu7/N+/Pn4+GgouwX0K
	OMSvb+7L/9VWroponCLtdRk=
X-Google-Smtp-Source: AA0mqf5ZtsT30GoUH/4TBViJcG2p2xVpb/2WXR2KXr7wvrCOOAoP5enGR17CBNRPJryrNLruXod8Yg==
X-Received: by 2002:a05:600c:3590:b0:3d0:1489:78c4 with SMTP id p16-20020a05600c359000b003d0148978c4mr5836156wmq.167.1669135744520;
        Tue, 22 Nov 2022 08:49:04 -0800 (PST)
Received: from [192.168.0.25] ([37.222.251.204])
        by smtp.gmail.com with ESMTPSA id x9-20020a5d6509000000b0023c8026841csm14497653wru.23.2022.11.22.08.49.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Nov 2022 08:49:03 -0800 (PST)
Message-ID: <f51c7f56-4c62-0351-3b01-ae2f6432fb05@gmail.com>
Date: Tue, 22 Nov 2022 17:49:01 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v7 5/6] iommu/mediatek: Improve safety for mediatek,smi
 property in larb nodes
Content-Language: en-US
To: Yong Wu <yong.wu@mediatek.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>
Cc: Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev,
 linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 mingyuan.ma@mediatek.com, yf.wang@mediatek.com, libo.kang@mediatek.com,
 chengci.xu@mediatek.com, youlin.pei@mediatek.com, anan.sun@mediatek.com,
 xueqi.zhang@mediatek.com, Guenter Roeck <groeck@chromium.org>,
 Dan Carpenter <dan.carpenter@oracle.com>
References: <20221018024258.19073-1-yong.wu@mediatek.com>
 <20221018024258.19073-6-yong.wu@mediatek.com>
From: Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20221018024258.19073-6-yong.wu@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 18/10/2022 04:42, Yong Wu wrote:
> No functional change. Just improve safety from dts.
> 
> All the larbs that connect to one IOMMU must connect with the same
> smi-common. This patch checks all the mediatek,smi property for each
> larb, If their mediatek,smi are different, it will return fails.
> Also avoid there is no available smi-larb nodes.
> 
> Suggested-by: Guenter Roeck <groeck@chromium.org>
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>

> ---
>   drivers/iommu/mtk_iommu.c | 53 +++++++++++++++++++++++++++------------
>   1 file changed, 37 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
> index 9cbff48f03c0..f7ac102e343f 100644
> --- a/drivers/iommu/mtk_iommu.c
> +++ b/drivers/iommu/mtk_iommu.c
> @@ -1042,7 +1042,7 @@ static const struct component_master_ops mtk_iommu_com_ops = {
>   static int mtk_iommu_mm_dts_parse(struct device *dev, struct component_match **match,
>   				  struct mtk_iommu_data *data)
>   {
> -	struct device_node *larbnode, *smicomm_node, *smi_subcomm_node;
> +	struct device_node *larbnode, *frst_avail_smicomm_node = NULL;
>   	struct platform_device *plarbdev, *pcommdev;
>   	struct device_link *link;
>   	int i, larb_nr, ret;
> @@ -1054,6 +1054,7 @@ static int mtk_iommu_mm_dts_parse(struct device *dev, struct component_match **m
>   		return -EINVAL;
>   
>   	for (i = 0; i < larb_nr; i++) {
> +		struct device_node *smicomm_node, *smi_subcomm_node;
>   		u32 id;
>   
>   		larbnode = of_parse_phandle(dev->of_node, "mediatek,larbs", i);
> @@ -1094,27 +1095,47 @@ static int mtk_iommu_mm_dts_parse(struct device *dev, struct component_match **m
>   			goto err_larbdev_put;
>   		}
>   
> +		/* Get smi-(sub)-common dev from the last larb. */
> +		smi_subcomm_node = of_parse_phandle(larbnode, "mediatek,smi", 0);
> +		if (!smi_subcomm_node) {
> +			ret = -EINVAL;
> +			goto err_larbdev_put;
> +		}
> +
> +		/*
> +		 * It may have two level smi-common. the node is smi-sub-common if it
> +		 * has a new mediatek,smi property. otherwise it is smi-commmon.
> +		 */
> +		smicomm_node = of_parse_phandle(smi_subcomm_node, "mediatek,smi", 0);
> +		if (smicomm_node)
> +			of_node_put(smi_subcomm_node);
> +		else
> +			smicomm_node = smi_subcomm_node;
> +
> +		/*
> +		 * All the larbs that connect to one IOMMU must connect with the same
> +		 * smi-common.
> +		 */
> +		if (!frst_avail_smicomm_node) {
> +			frst_avail_smicomm_node = smicomm_node;
> +		} else if (frst_avail_smicomm_node != smicomm_node) {
> +			dev_err(dev, "mediatek,smi property is not right @larb%d.", id);
> +			of_node_put(smicomm_node);
> +			ret = -EINVAL;
> +			goto err_larbdev_put;
> +		} else {
> +			of_node_put(smicomm_node);
> +		}
> +
>   		component_match_add(dev, match, component_compare_dev, &plarbdev->dev);
>   		platform_device_put(plarbdev);
>   	}
>   
> -	/* Get smi-(sub)-common dev from the last larb. */
> -	smi_subcomm_node = of_parse_phandle(larbnode, "mediatek,smi", 0);
> -	if (!smi_subcomm_node)
> +	if (!frst_avail_smicomm_node)
>   		return -EINVAL;
>   
> -	/*
> -	 * It may have two level smi-common. the node is smi-sub-common if it
> -	 * has a new mediatek,smi property. otherwise it is smi-commmon.
> -	 */
> -	smicomm_node = of_parse_phandle(smi_subcomm_node, "mediatek,smi", 0);
> -	if (smicomm_node)
> -		of_node_put(smi_subcomm_node);
> -	else
> -		smicomm_node = smi_subcomm_node;
> -
> -	pcommdev = of_find_device_by_node(smicomm_node);
> -	of_node_put(smicomm_node);
> +	pcommdev = of_find_device_by_node(frst_avail_smicomm_node);
> +	of_node_put(frst_avail_smicomm_node);
>   	if (!pcommdev)
>   		return -ENODEV;
>   	data->smicomm_dev = &pcommdev->dev;
