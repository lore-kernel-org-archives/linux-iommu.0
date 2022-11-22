Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F66E7477
	for <iommu@lists.linux.dev>; Tue, 22 Nov 2022 16:29:04 +0000 (UTC)
Received: by mail-wr1-f54.google.com with SMTP id n3so8977095wrp.5
        for <iommu@lists.linux.dev>; Tue, 22 Nov 2022 08:29:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ri7F1S4pLcMxIqjAu0KioPz4x8UzFumJZoJlr3Ul9aA=;
        b=iL/3dbSN6JIadgGbQyFSPNrufc3sS6tL14gE5qWA17O3qnMAnv6s9s58mHJW0vJhc1
         I9iB0a8c/s821dbPo47o00RNEptev9gj4jjk96mgDX8AHw+1Kz3hWwYVgWg+qVpf5BfJ
         z+W/L1i5dCz7tjzVG+vRZUJoPSubD36hiUdokWG/EfAH0JYjxiy6FWF5lvDzx8YOpJQ6
         q7XyEVcymhYVAsc/w48eeZz15SNtkPNG3oMcQxDYsaageSkF73V+V82e6W8+I3DsU6zt
         snqM0RIseGnmnJXCSMFJtjtSYxsMKBtKhtt2unbslggojpPBqIHSGExVkBb25JaqKpKY
         K4hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ri7F1S4pLcMxIqjAu0KioPz4x8UzFumJZoJlr3Ul9aA=;
        b=T8DImdQGLM6aDmx71dF7isec/NaZhw0scphayia0FBlJjp4giOWhjp/zPE+BM2Rz1l
         o220P7Z41tFaQugua+KA4MkVfd4mjLLF1ezolsAVl4L7Hb325kyKyO3zVl8/7KD/TyD7
         /VvzBfzRpYTcMYF1cGgyQv2mLP5CqlQ0Y+9Uh5gRdDobdCJyUZRSBuTeX7xcaf/ELCpz
         3Yu6NKsoLPhOnSIqfWwhy0eKJMSNMsmaHmenDeg8eRpCLEsEKoTN+2PgwCLpAlj9OITD
         HoPjrPfxWwjou+S7V3PEFlPEa3m4Z7opquzQoDzrFC0skbl4UgdTVQqgT7ZpG2Bo4IY1
         dIsA==
X-Gm-Message-State: ANoB5pn4qdic4Rqw3915u/BYazHRONMeZVJtdcpSHtxo2Pbjv1bCjX3c
	ssqQXBRxJbRToXFzmJvRbzMtBcBXYSMU7A==
X-Google-Smtp-Source: AA0mqf4+ga2CUanb3QmE8qQV12cTEWEsslAcVL4sAJOytJ1vcghhfvz3fGBaJJDGVjoIHbM2vU2/Dg==
X-Received: by 2002:a5d:4568:0:b0:241:e8b0:cdcc with SMTP id a8-20020a5d4568000000b00241e8b0cdccmr640819wrc.581.1669134542632;
        Tue, 22 Nov 2022 08:29:02 -0800 (PST)
Received: from [192.168.0.25] ([37.222.251.204])
        by smtp.gmail.com with ESMTPSA id p11-20020a05600c468b00b003c65c9a36dfsm19810612wmo.48.2022.11.22.08.29.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Nov 2022 08:29:01 -0800 (PST)
Message-ID: <451e69dc-ad89-9ffc-1e91-70796e908003@gmail.com>
Date: Tue, 22 Nov 2022 17:28:58 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v7 2/6] iommu/mediatek: Use component_match_add
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
 <20221018024258.19073-3-yong.wu@mediatek.com>
From: Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20221018024258.19073-3-yong.wu@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 18/10/2022 04:42, Yong Wu wrote:
> In order to simplify the error patch(avoid call of_node_put), Use
> component_match_add instead component_match_add_release since we are only
> interested in the "device" here. Then we could always call of_node_put in
> normal path.
> 
> Strictly this is not a fixes patch, but it is a prepare for adding the
> error path, thus I add a Fixes tag too.
> 
> Fixes: d2e9a1102cfc ("iommu/mediatek: Contain MM IOMMU flow with the MM TYPE")
> Suggested-by: Robin Murphy <robin.murphy@arm.com>
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>

> ---
>   drivers/iommu/mtk_iommu.c | 10 ++++------
>   1 file changed, 4 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
> index 3189b585725f..38112ad87d70 100644
> --- a/drivers/iommu/mtk_iommu.c
> +++ b/drivers/iommu/mtk_iommu.c
> @@ -1068,19 +1068,17 @@ static int mtk_iommu_mm_dts_parse(struct device *dev, struct component_match **m
>   			id = i;
>   
>   		plarbdev = of_find_device_by_node(larbnode);
> -		if (!plarbdev) {
> -			of_node_put(larbnode);
> +		of_node_put(larbnode);
> +		if (!plarbdev)
>   			return -ENODEV;
> -		}
> +
>   		if (!plarbdev->dev.driver) {
> -			of_node_put(larbnode);
>   			platform_device_put(plarbdev);
>   			return -EPROBE_DEFER;
>   		}
>   		data->larb_imu[id].dev = &plarbdev->dev;
>   
> -		component_match_add_release(dev, match, component_release_of,
> -					    component_compare_of, larbnode);
> +		component_match_add(dev, match, component_compare_dev, &plarbdev->dev);
>   		platform_device_put(plarbdev);
>   	}
>   
