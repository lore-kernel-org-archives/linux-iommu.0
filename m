Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E032FED0
	for <iommu@lists.linux.dev>; Tue, 22 Nov 2022 16:43:49 +0000 (UTC)
Received: by mail-wr1-f51.google.com with SMTP id d1so13486311wrs.12
        for <iommu@lists.linux.dev>; Tue, 22 Nov 2022 08:43:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QZEV3ONJefJj1H5plqVub6jL7aLk8MUsgBjZIyffLHc=;
        b=pKGGkWMvt7udHJ04Un7aA7GLATGb+YsuQ/iINuTHrA/6okbGTmY81YBVGwNPdrQVOv
         Oud9UKnRqqyja0Fwa1jlF6cgRoQmH3pxATXVk6aYZ/q/VXzGchtFX5MbjfFJbd2xaMXu
         xdQ/kIQYqOmkxc/TXRl56eWhItwC9VQ3QCUOkIlPOhQDh0Cq8fZWbk+jpEE2Ys/251/p
         4jJz55qJG1An51S8pfZ5Ydan1jFspY6P72GJgOPU88Idi4VHPJsBC1dzcTT026Opiq01
         7EqAOm4L3SYxKDW44o0krEF44aKxmZqOltBGq2l+wn/xj4aD9JZk/06tdkOutx8Fsyek
         tjWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QZEV3ONJefJj1H5plqVub6jL7aLk8MUsgBjZIyffLHc=;
        b=KsL59UszNfzRRsxKNUbRcHXMFh9jxQzVl8QdfUbuM3L9sMTJsLxt2qFMyfyq+H2ncO
         MtAgWOEk0Koz3c+GcDM7lBS1TRFjHyNc55xx5C/NCmDZ+AiTFsEE6Z2Ssa3H2LvvR+os
         4HrP8Dc8mwLaPX/apRGSoiRucssnM5y4vn8CRZGo70les2oV6/kxlmo7pZRhVuxjPsw9
         FNwHWh0LkdsWkmIUu5Mbmy95aBQ0GisXeYCRgZZ3FvOuvDBKqgIhzsoVqPAyYdSJzuGy
         3DsST8spdZ3wGtp6+JTbmWxKhURamnrRUDim0XCgYz4BEvAi1w6RCpI6DXsDvqhG0+h+
         4Y0A==
X-Gm-Message-State: ANoB5pn2H7OgBPh2MtrHlpGlu2F6uIY2XK5CmT5vTTGoz3rJE/LWxfaz
	L+Bshl8aWbm7jlYnUVqG0kE=
X-Google-Smtp-Source: AA0mqf6WanR/TJ+ZU+8PUxq4CBmgmbSqoFtEAXiJebu/YtVtA+nRrx786Q5Ef9GQwuISQANV5s/qcw==
X-Received: by 2002:a5d:6503:0:b0:22e:35e8:382d with SMTP id x3-20020a5d6503000000b0022e35e8382dmr14817028wru.475.1669135427963;
        Tue, 22 Nov 2022 08:43:47 -0800 (PST)
Received: from [192.168.0.25] ([37.222.251.204])
        by smtp.gmail.com with ESMTPSA id q14-20020a05600c46ce00b003c5571c27a1sm22110175wmo.32.2022.11.22.08.43.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Nov 2022 08:43:46 -0800 (PST)
Message-ID: <f3c1c76c-ef61-ab68-e6db-ebcf408d42d6@gmail.com>
Date: Tue, 22 Nov 2022 17:43:45 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v7 4/6] iommu/mediatek: Validate number of phandles
 associated with "mediatek,larbs"
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
 <20221018024258.19073-5-yong.wu@mediatek.com>
From: Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20221018024258.19073-5-yong.wu@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 18/10/2022 04:42, Yong Wu wrote:
> From: Guenter Roeck <groeck@chromium.org>
> 
> Fix the smatch warnings:
> drivers/iommu/mtk_iommu.c:878 mtk_iommu_mm_dts_parse() error: uninitialized
> symbol 'larbnode'.
> 
> If someone abuse the dtsi node(Don't follow the definition of dt-binding),
> for example "mediatek,larbs" is provided as boolean property, "larb_nr"
> will be zero and cause abnormal.
> 
> To fix this problem and improve the code safety, add some checking
> for the invalid input from dtsi, e.g. checking the larb_nr/larbid valid
> range, and avoid "mediatek,larb-id" property conflicts in the smi-larb
> nodes.
> 
> Fixes: d2e9a1102cfc ("iommu/mediatek: Contain MM IOMMU flow with the MM TYPE")
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Guenter Roeck <groeck@chromium.org>
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>

> ---
>   drivers/iommu/mtk_iommu.c | 12 ++++++++++++
>   1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
> index 912322494bc0..9cbff48f03c0 100644
> --- a/drivers/iommu/mtk_iommu.c
> +++ b/drivers/iommu/mtk_iommu.c
> @@ -1050,6 +1050,8 @@ static int mtk_iommu_mm_dts_parse(struct device *dev, struct component_match **m
>   	larb_nr = of_count_phandle_with_args(dev->of_node, "mediatek,larbs", NULL);
>   	if (larb_nr < 0)
>   		return larb_nr;
> +	if (larb_nr == 0 || larb_nr > MTK_LARB_NR_MAX)
> +		return -EINVAL;
>   
>   	for (i = 0; i < larb_nr; i++) {
>   		u32 id;
> @@ -1068,6 +1070,11 @@ static int mtk_iommu_mm_dts_parse(struct device *dev, struct component_match **m
>   		ret = of_property_read_u32(larbnode, "mediatek,larb-id", &id);
>   		if (ret)/* The id is consecutive if there is no this property */
>   			id = i;
> +		if (id >= MTK_LARB_NR_MAX) {
> +			of_node_put(larbnode);
> +			ret = -EINVAL;
> +			goto err_larbdev_put;
> +		}
>   
>   		plarbdev = of_find_device_by_node(larbnode);
>   		of_node_put(larbnode);
> @@ -1075,6 +1082,11 @@ static int mtk_iommu_mm_dts_parse(struct device *dev, struct component_match **m
>   			ret = -ENODEV;
>   			goto err_larbdev_put;
>   		}
> +		if (data->larb_imu[id].dev) {
> +			platform_device_put(plarbdev);
> +			ret = -EEXIST;
> +			goto err_larbdev_put;
> +		}
>   		data->larb_imu[id].dev = &plarbdev->dev;
>   
>   		if (!plarbdev->dev.driver) {
