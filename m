Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3449C7477
	for <iommu@lists.linux.dev>; Tue, 22 Nov 2022 16:25:04 +0000 (UTC)
Received: by mail-wr1-f45.google.com with SMTP id z4so10925163wrr.3
        for <iommu@lists.linux.dev>; Tue, 22 Nov 2022 08:25:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KUbsY7ePXJlrYJo3GzHlSRELE0khC6HUiaH0TPVJCl0=;
        b=Kj9CGuLF/61MNCZIpbNvs1tlut/pgQKbQKT0FROY/5UN+RVaq7jj4LDtVm9MRVnC4m
         XDGlHX4uRVqDEr5FN/dSUwTGBB66AgF4FEUtd8/+B/dXUBxSy6XHkNhFSxJ2+GVcDmWI
         AejdaSGJI1DAvwArban9rukEJJV5APpSTEHqckbpwjtMJgSvDnFi8XPcGpFGvA+RUkBW
         /x1f7bC5z8WtHndKGx2ZGaKfdunOqlpgTSg5kqAd4YwzvJrDXEsz+yqOm4Y1zJ0lhO20
         oN96JMfqZxucR/gzYyVndVXBSnVCvl0QAKBa2q6kUdA1yy1RxWhwp6RiacaTzsbQoo47
         bt8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KUbsY7ePXJlrYJo3GzHlSRELE0khC6HUiaH0TPVJCl0=;
        b=4Z2ivvMLzDSr9r6ksqJiYaLB/JYjZcIihfPTb2Z6kFidwGJOWFv4+9VKfBaRBO0fYj
         OvtegKCmjQ/dOD+xphJ/n73/gdOsLog4TG3LtL9bC0y33oD9NKEREEqYMiRZqhFpEheO
         hVAvQHI03krh5z1Pp1hkcjS9ulAqvyDH7n8eqc+i/cY1zFgAVFSJtN57iEkX/Pisiqsc
         Sa9XcpchNrE2JcI/9SJ1/AK3+stPNo37Y6B9n5rmaQYjAgPaZFTyK9g3L4CyFyiABD8j
         MZcTJeShKFcdtTxpYzLOarlYnkDsjXPraaQKYLnnk8gBBZx/smkJ+KTAE9LYEa5aOaIU
         gZnQ==
X-Gm-Message-State: ANoB5pmTK4DNip5owuPjqZWfcUB8xddc8HHwTn9uHKlwmynOU/qWr6Nb
	VeawDG4pumCgIdgVOBQncRE=
X-Google-Smtp-Source: AA0mqf4UmUVT3FkH3QYSEHLuTy5dEpoGCEYf+L+dfFyrESBGCCf5sf1IgYOyuYLsLsTco5qqeT/6ow==
X-Received: by 2002:a5d:6051:0:b0:22f:da60:345 with SMTP id j17-20020a5d6051000000b0022fda600345mr14580850wrt.218.1669134302216;
        Tue, 22 Nov 2022 08:25:02 -0800 (PST)
Received: from [192.168.0.25] ([37.222.251.204])
        by smtp.gmail.com with ESMTPSA id a8-20020adffb88000000b002383fc96509sm14394702wrr.47.2022.11.22.08.24.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Nov 2022 08:25:00 -0800 (PST)
Message-ID: <8549c4b4-bc0a-ab6d-dceb-e694af2e8148@gmail.com>
Date: Tue, 22 Nov 2022 17:24:59 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v7 1/6] iommu/mediatek: Add platform_device_put for
 recovering the device refcnt
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
 <20221018024258.19073-2-yong.wu@mediatek.com>
From: Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20221018024258.19073-2-yong.wu@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 18/10/2022 04:42, Yong Wu wrote:
> Add platform_device_put to match with of_find_device_by_node.
> 
> Meanwhile, I add a new variable "pcommdev" which is for smi common device.
> Otherwise, "platform_device_put(plarbdev)" for smi-common dev may be not
> readable. And add a checking for whether pcommdev is NULL.
> 
> Fixes: d2e9a1102cfc ("iommu/mediatek: Contain MM IOMMU flow with the MM TYPE")
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>

> ---
>   drivers/iommu/mtk_iommu.c | 11 ++++++++---
>   1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
> index 5a4e00e4bbbc..3189b585725f 100644
> --- a/drivers/iommu/mtk_iommu.c
> +++ b/drivers/iommu/mtk_iommu.c
> @@ -1043,7 +1043,7 @@ static int mtk_iommu_mm_dts_parse(struct device *dev, struct component_match **m
>   				  struct mtk_iommu_data *data)
>   {
>   	struct device_node *larbnode, *smicomm_node, *smi_subcomm_node;
> -	struct platform_device *plarbdev;
> +	struct platform_device *plarbdev, *pcommdev;
>   	struct device_link *link;
>   	int i, larb_nr, ret;
>   
> @@ -1074,12 +1074,14 @@ static int mtk_iommu_mm_dts_parse(struct device *dev, struct component_match **m
>   		}
>   		if (!plarbdev->dev.driver) {
>   			of_node_put(larbnode);
> +			platform_device_put(plarbdev);
>   			return -EPROBE_DEFER;
>   		}
>   		data->larb_imu[id].dev = &plarbdev->dev;
>   
>   		component_match_add_release(dev, match, component_release_of,
>   					    component_compare_of, larbnode);
> +		platform_device_put(plarbdev);
>   	}
>   
>   	/* Get smi-(sub)-common dev from the last larb. */
> @@ -1097,12 +1099,15 @@ static int mtk_iommu_mm_dts_parse(struct device *dev, struct component_match **m
>   	else
>   		smicomm_node = smi_subcomm_node;
>   
> -	plarbdev = of_find_device_by_node(smicomm_node);
> +	pcommdev = of_find_device_by_node(smicomm_node);
>   	of_node_put(smicomm_node);
> -	data->smicomm_dev = &plarbdev->dev;
> +	if (!pcommdev)
> +		return -ENODEV;
> +	data->smicomm_dev = &pcommdev->dev;
>   
>   	link = device_link_add(data->smicomm_dev, dev,
>   			       DL_FLAG_STATELESS | DL_FLAG_PM_RUNTIME);
> +	platform_device_put(pcommdev);
>   	if (!link) {
>   		dev_err(dev, "Unable to link %s.\n", dev_name(data->smicomm_dev));
>   		return -EINVAL;
