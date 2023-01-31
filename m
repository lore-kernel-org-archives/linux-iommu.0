Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC11B6ADE
	for <iommu@lists.linux.dev>; Tue, 31 Jan 2023 13:07:18 +0000 (UTC)
Received: by mail-wm1-f50.google.com with SMTP id bg13-20020a05600c3c8d00b003d9712b29d2so12412030wmb.2
        for <iommu@lists.linux.dev>; Tue, 31 Jan 2023 05:07:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rL3EQFVNMqM8HDiuib6fngQevhM4qWrd4VemXb3oWb4=;
        b=OsCZwh80DbIiJbGFOR31nEMtf9nHLzgyrhH2i+JpftjhJcDu1oICvph8PQ8LsyaE7d
         okaXH1d9iB1pdL/xj5YiEphleZ3390WqzZlYt1uGZqcCG271MxapUiBsmWIYw0Hz6Ds9
         uPMNDk1VMf+V00ak/oYnVmWaEmnCDgz89B1zTe76dsZ3qBXTsT74Vy718ggwCHTGGUcM
         tqvZ9H3DG+w7olkxX/jax1aac8kgNH63nxizH1nxdA/QMFy94qy1fgO2HTvYCGR1Yq2o
         AXd8hqB6Ig1dQyHAuDSmrD6Zo7fToE/dvRVobC3rlvmEqXlhpiiH26aQlf3+zxJ20tA8
         LNvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rL3EQFVNMqM8HDiuib6fngQevhM4qWrd4VemXb3oWb4=;
        b=lW7CHwHTinMEoRFGN50vihvjuMbq9WQDx6qlVvUst0g7FfywMG6PAbLT5V2z6XABKD
         lD5akbyh6ZLol3ra+8KAtkXEtDeL9Cw092+RocDcgAgSQiDTMddCTrKPTrhbGHXPb2/z
         qzKGIR3clf2epukBEQXjRsmRK23dN1NuLtUOEKIlRKinGW0b5kEJeqF4yirANU3b3t3L
         X6UQeIHqk+eOkLwdU/2v+zHse44zNuqSL3vjVQG06PQtnw5CKe9iHPD67TaKv8pH1ko6
         ajd1JQobWiiWXJdZ+R4ywJcygpi7Mi2OIUsuvF6OMagv66la9SzIjU6SzudTldRm8ss4
         O0Uw==
X-Gm-Message-State: AFqh2koOD+tJdPk6n/xkBmTNY1+otOoFc0wJiCuQoIaI5yPwV4SJt2Dp
	906yUuwAA0vJZ5soSZwJ6fpmsg==
X-Google-Smtp-Source: AMrXdXtqRKjiaIS0GDz2pjKZ2gM3eUTTve3hy5/GvVfHu95hi65KBmWvdGv7irjGk/0J5baiC/v8kg==
X-Received: by 2002:a05:600c:4f83:b0:3db:eab:a600 with SMTP id n3-20020a05600c4f8300b003db0eaba600mr49187536wmq.7.1675170437001;
        Tue, 31 Jan 2023 05:07:17 -0800 (PST)
Received: from [10.1.4.104] (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id i27-20020a05600c4b1b00b003dc54d9aeeasm7529000wmp.36.2023.01.31.05.07.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Jan 2023 05:07:16 -0800 (PST)
Message-ID: <f126c61f-6373-d6c5-59c8-24dea9d9d168@baylibre.com>
Date: Tue, 31 Jan 2023 14:08:04 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 2/3] iommu: mediatek: Add support of unmanaged iommu
 domain
To: Robin Murphy <robin.murphy@arm.com>, yong.wu@mediatek.com,
 joro@8bytes.org, will@kernel.org
Cc: matthias.bgg@gmail.com, krzysztof.kozlowski@linaro.org,
 robh+dt@kernel.org, iommu@lists.linux.dev,
 linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20230130102722.133271-1-abailon@baylibre.com>
 <20230130102722.133271-3-abailon@baylibre.com>
 <741920ba-8637-5e28-695c-699b46351590@arm.com>
Content-Language: en-US
From: Alexandre Bailon <abailon@baylibre.com>
In-Reply-To: <741920ba-8637-5e28-695c-699b46351590@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Robin

On 1/30/23 13:04, Robin Murphy wrote:
> On 2023-01-30 10:27, Alexandre Bailon wrote:
>> Currently, the driver can allocate an unmanaged iommu domain.
>> But, this only works for SoC having multiple bank or multiple iova 
>> region.
> 
> That is for good reason - there is only a single pagetable per bank, so 
> if there are multiple devices assigned to a single bank, they cannot 
> possibly be attached to different domains at the same time. Hence why 
> the banks are modelled as groups.
I understand.
I am trying to upstream a remoteproc driver but the remote processor is
behind the iommu.
remoteproc can manage the iommu but it requires an unmanaged domain.
I tried a couple of things but this cause code duplication,
implies many hacks and not always reliable.
Do you have any suggestion ?

Thanks,
Alexandre
> 
> Thanks,
> Robin.
> 
>> This updates the driver to also support unmanaged iommu domain if
>> MTK_UNMANAGED_DEVICE is set in the iommu id.
>>
>> Signed-off-by: Alexandre Bailon <abailon@baylibre.com>
>> ---
>>   drivers/iommu/mtk_iommu.c | 6 ++++++
>>   1 file changed, 6 insertions(+)
>>
>> diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
>> index 2badd6acfb23d..5884a1ad409a0 100644
>> --- a/drivers/iommu/mtk_iommu.c
>> +++ b/drivers/iommu/mtk_iommu.c
>> @@ -858,9 +858,15 @@ static int mtk_iommu_get_group_id(struct device 
>> *dev, const struct mtk_iommu_pla
>>   static struct iommu_group *mtk_iommu_device_group(struct device *dev)
>>   {
>>       struct mtk_iommu_data *c_data = dev_iommu_priv_get(dev), *data;
>> +    struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
>>       struct list_head *hw_list = c_data->hw_list;
>>       struct iommu_group *group;
>>       int groupid;
>> +    int i;
>> +
>> +    for (i = 0; i < fwspec->num_ids; i++)
>> +        if (MTK_M4U_UNMANAGED(fwspec->ids[i]))
>> +            return iommu_group_alloc();
>>       data = mtk_iommu_get_frst_data(hw_list);
>>       if (!data)
