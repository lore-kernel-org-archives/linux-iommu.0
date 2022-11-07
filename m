Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C8E3D531
	for <iommu@lists.linux.dev>; Mon,  7 Nov 2022 16:03:24 +0000 (UTC)
Received: by mail-wm1-f45.google.com with SMTP id m7-20020a05600c090700b003cf8a105d9eso7434193wmp.5
        for <iommu@lists.linux.dev>; Mon, 07 Nov 2022 08:03:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PBi2xYLKBmFsMRr5bdml5VEOoF1d5jHivkd685sMTGo=;
        b=W5O1xeP6CggkYXCMSVUXUHUGa8pIRVHaEOuxx5qKiAeVK7hTmTRU0qoqt/tHxEDDvD
         fxtExCrwL8gz7QJ3e/zRGbK6eJ5YMpCVgU7e+ODdAEum7tnlWa13WXFk1GmcDw05YIoG
         rUybgWvfOcyf2kQmEL4knzuTpmiA4hHnF91jSde4xIBYOJ7oYe33Xiyvsflwmf/PM8hh
         2JXyriGVOpJc8qQ0mepKBy9NxT14g+wjzaLnyrYGwGxtIyWrkMQyq0sjv7uLm9sqmwMc
         kXIvN8XHpD4Q+U3MNjaFAA/ibNIe/NJdcIKiQxjVYfUGIYMUywDctkOfef2AuHQODyn2
         zolw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PBi2xYLKBmFsMRr5bdml5VEOoF1d5jHivkd685sMTGo=;
        b=sURBcTaLeh67S3A9L+wkApMveE40ja4G4SciXZieOeU+/Hl5+d5SqiqXrVAruvzJr2
         GquLDESj6Tly5TxuFWIVtSz0fXB87n7Sm+MaQZj68BCpSA6RXAR5UD3IexgmM6CyKma1
         Pvm79Saq72w6UToPaoPjAJuGTR4i0nD6PS8R+H+hiIhkWZeGqWoBcfFLQgzapmQo5grG
         VnqcltwjNWv/BExEI7Mu4STgiD/ofg1fzdqcBwzTNSa0lcp84HdhOOX8NQ9Gh6GxFe0W
         nbLMeH2vF9I5GWffj/7goDQXBf6GJMT3XmCHNhhrsV7wjxJFmj+YB6+rbU0+xrmOwt9W
         ejEQ==
X-Gm-Message-State: ACrzQf2ug4SA+K4Ddro3FbnAhd0qtatBgGl7x8GnEO8ILV+xt3YeRLMj
	f72gk+PYxQ4b3+gZ02+Hrg8=
X-Google-Smtp-Source: AMsMyM57k0P7AioLzV3L4ioDwDmE9D8OlLmjGSrpQf19iXUZ0eudVbqq4tqQSdeD4Wugx2jd3e3kCA==
X-Received: by 2002:a7b:c40e:0:b0:3cf:497c:c515 with SMTP id k14-20020a7bc40e000000b003cf497cc515mr33770990wmi.41.1667837002700;
        Mon, 07 Nov 2022 08:03:22 -0800 (PST)
Received: from [192.168.2.177] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id k4-20020adfe3c4000000b0022ccae2fa62sm7814697wrm.22.2022.11.07.08.03.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Nov 2022 08:03:21 -0800 (PST)
Message-ID: <d9498f83-14db-79b6-eacb-f7530af02466@gmail.com>
Date: Mon, 7 Nov 2022 17:03:20 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH] iommu/mediatek: check return value after calling
 platform_get_resource()
Content-Language: en-US
To: Yang Yingliang <yangyingliang@huawei.com>, iommu@lists.linux.dev,
 linux-mediatek@lists.infradead.org
Cc: yong.wu@mediatek.com, joro@8bytes.org, will@kernel.org,
 robin.murphy@arm.com
References: <20221029103550.3774365-1-yangyingliang@huawei.com>
From: Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20221029103550.3774365-1-yangyingliang@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 29/10/2022 12:35, Yang Yingliang wrote:
> platform_get_resource() may return NULL pointer, we need check its
> return value to avoid null-ptr-deref in resource_size().
> 
> Fixes: 42d57fc58aeb ("iommu/mediatek: Initialise/Remove for multi bank dev")
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> ---
>   drivers/iommu/mtk_iommu.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
> index 2ab2ecfe01f8..2d14dc846b83 100644
> --- a/drivers/iommu/mtk_iommu.c
> +++ b/drivers/iommu/mtk_iommu.c
> @@ -1173,6 +1173,8 @@ static int mtk_iommu_probe(struct platform_device *pdev)
>   
>   	banks_num = data->plat_data->banks_num;
>   	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (!res)
> +		return -EINVAL;

That would be the case if the DT passed to the kernel isn't correct, but anyway:

Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>

>   	if (resource_size(res) < banks_num * MTK_IOMMU_BANK_SZ) {
>   		dev_err(dev, "banknr %d. res %pR is not enough.\n", banks_num, res);
>   		return -EINVAL;
