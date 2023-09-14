Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABFE2EBC
	for <iommu@lists.linux.dev>; Thu, 14 Sep 2023 08:07:44 +0000 (UTC)
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-307d20548adso607997f8f.0
        for <iommu@lists.linux.dev>; Thu, 14 Sep 2023 01:07:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1694678862; x=1695283662; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0JKcQNz7/LxVTphbNd7WfpGxCIp3rFN7/X1ftN+SaLE=;
        b=0QK5PhGSZBtz1qW7l8CECkG1C62uq80yCArb0kUgVfz0QtPzo/46Qbyb5wPJzzuXs/
         xED6a4dBqWAh3atyAIN2hJpZeTS2MvFWX5usAwK9F9yIWyT4faZSecK0tmrTBhZgaUlL
         SWyJtznpXBNRT9+M26tJpe47tPVBnXbWST4uN/8no9hiFNBT9kdTNXubHntuhTfktCvU
         3M5U6ILoRBrIKWtQpL716//8Kr4Z8yVh3vYrKiNnBOXBoETktnQygogKJbIAXrv8Tajm
         GLd7rGtH/TOAeiTRjTz5xRrk2JUyeFLKxSU3qih/ytiTEm18y5Nhm/hMhIJz8O2vN0rH
         dgug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694678862; x=1695283662;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0JKcQNz7/LxVTphbNd7WfpGxCIp3rFN7/X1ftN+SaLE=;
        b=jC+1IMz2+5GWpuUQUZ7Mc+9PTtkUzdLO2gN+ANMohjT8jGAJHVJ09pykhr5FDklRsR
         c3iRe5s/Ui2qLtY+6DztijVS8uaeKm3+abUMxHCgSt4+z1uFqZR/ZrF09hg/hsM9DWJs
         r1K5OA9YsSc8px1MR6jMr/LMz3YU8FmcneSQjqyVKQ1/LhB6yhl61FCD2YulXAML9SlS
         uYXN7TVb8EM4bAmlSWDGAGQc47jiyKEXVV32rh8GqZZoFfL27jS99D4wr7+uvhoCss0m
         6H/5q5xoj7rVA4plzaBjjXtb793UqNGGIzKBGLgO93ZhgVWB9ew55TtZ1COI1dw02ine
         2Rtw==
X-Gm-Message-State: AOJu0YyFSgq3/3qsZBu81jkKXAhJkEYC/xP3D91hJIcb14OS6lOVaPRm
	Y6+FvkssjJ5yE+DeExjS/wUtEw==
X-Google-Smtp-Source: AGHT+IHQwbAwrzoJqX6EDFEjCD6cZ11exncxwjKKLNqXlQ/L9nCe/YfpzClC3irrIQyDR+Bhh+A2TA==
X-Received: by 2002:adf:e984:0:b0:31f:b364:a6ba with SMTP id h4-20020adfe984000000b0031fb364a6bamr3439077wrm.52.1694678862539;
        Thu, 14 Sep 2023 01:07:42 -0700 (PDT)
Received: from ?IPV6:2a04:cec2:21:518d:60be:d1a1:47e5:d622? ([2a04:cec2:21:518d:60be:d1a1:47e5:d622])
        by smtp.gmail.com with ESMTPSA id f13-20020a5d568d000000b0031fd849e797sm1024494wrv.105.2023.09.14.01.07.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Sep 2023 01:07:41 -0700 (PDT)
Message-ID: <68673ccd-d136-075e-6704-7d1558388784@baylibre.com>
Date: Thu, 14 Sep 2023 10:07:37 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 2/3] iommu: mediatek: Add support of unmanaged iommu
 domain
Content-Language: en-US
To: =?UTF-8?B?WW9uZyBXdSAo5ZC05YuHKQ==?= <Yong.Wu@mediatek.com>,
 "robin.murphy@arm.com" <robin.murphy@arm.com>,
 "joro@8bytes.org" <joro@8bytes.org>, "will@kernel.org" <will@kernel.org>
Cc: "linux-mediatek@lists.infradead.org"
 <linux-mediatek@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "robh+dt@kernel.org" <robh+dt@kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "krzysztof.kozlowski@linaro.org" <krzysztof.kozlowski@linaro.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>
References: <20230130102722.133271-1-abailon@baylibre.com>
 <20230130102722.133271-3-abailon@baylibre.com>
 <741920ba-8637-5e28-695c-699b46351590@arm.com>
 <f126c61f-6373-d6c5-59c8-24dea9d9d168@baylibre.com>
 <0e9f677b-846d-809d-9bc3-30906f703fda@arm.com>
 <21fef8eb-6482-fd8c-118a-c4d9da4cfbaf@baylibre.com>
 <2b8e19488386b5ca523f010b8ded750a4213f84e.camel@mediatek.com>
From: Alexandre Bailon <abailon@baylibre.com>
In-Reply-To: <2b8e19488386b5ca523f010b8ded750a4213f84e.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

Sorry for long delay before the response.

On 2/14/23 06:48, Yong Wu (吴勇) wrote:
> On Tue, 2023-01-31 at 16:31 +0100, Alexandre Bailon wrote:
>>
>> On 1/31/23 15:15, Robin Murphy wrote:
>>> On 31/01/2023 1:08 pm, Alexandre Bailon wrote:
>>>> Hi Robin
>>>>
>>>> On 1/30/23 13:04, Robin Murphy wrote:
>>>>> On 2023-01-30 10:27, Alexandre Bailon wrote:
>>>>>> Currently, the driver can allocate an unmanaged iommu domain.
>>>>>> But, this only works for SoC having multiple bank or multiple
>>>>>> iova
>>>>>> region.
>>>>>
>>>>> That is for good reason - there is only a single pagetable per
>>>>> bank,
>>>>> so if there are multiple devices assigned to a single bank,
>>>>> they
>>>>> cannot possibly be attached to different domains at the same
>>>>> time.
>>>>> Hence why the banks are modelled as groups.
>>>>
>>>> I understand.
>>>> I am trying to upstream a remoteproc driver but the remote
>>>> processor is
>>>> behind the iommu.
>>>> remoteproc can manage the iommu but it requires an unmanaged
>>>> domain.
>>>> I tried a couple of things but this cause code duplication,
>>>> implies many hacks and not always reliable.
>>>> Do you have any suggestion ?
>>>
>>> If there are other active devices behind the same IOMMU, and the
>>> remoteproc device cannot be isolated into its own bank using the
>>> existing IOMMU driver logic, then the remoteproc driver cannot
>>> manage
>>> the IOMMU directly, and must just use the regular DMA API. There's
>>> no
>>> way around it; you can't have two different parts of the kernel
>>> both
>>> thinking they have exclusive control of a single IOMMU address
>>> space at
>>> the same time. Similarly, remoteproc also cannot take explicit
>>> control
>>> of a multi-device group if it's not actually in control of the
>>> other
>>> devices, since their drivers will not be expecting the DMA address
>>> space
>>> to suddenly change underfoot - that's why iommu_attach_device() has
>>> the
>>> check which you presumably ran into.
>>
>> Unfortunately, we can't just use the regular DMA API.
>> Basically, the firmware use static addresses (and the remote core is
>> only supposed to access addresses between 0x60000000 and 0x70000000).
>> When we use DMA API, we get a random address that doesn't match what
>> the
>> firmware would expect.
>> remoteproc use directly the iommu API to map physical address to the
>> static address expected by the firmware when DMA API can't be use.
> 
> If this master can only support this special address, We could handle
> it inside this driver.
> 
> Could you help try to add these two patches [3/11] and [4/11]?
> 
> [3/11]
> https://patchwork.kernel.org/project/linux-mediatek/patch/20230214031114.926-4-yong.wu@mediatek.com/
> [4/11]
> https://patchwork.kernel.org/project/linux-mediatek/patch/20230214031114.926-5-yong.wu@mediatek.com/
> 
> 
> and, then add the logical for mt8365(I see the APU is larb0 port10/11
> in the binding):
> --------------------------------
> 
> +#define MT8365_REGION_NR		2
> +
> +static const struct mtk_iommu_iova_region
> mt8365_multi_rgn[MT8365_REGION_NR] = {
> +	{ .iova_base = 0x0,		.size = SZ_4G},	       /* 0 ~
> 4G. */
> +	{ .iova_base = 0x60000000,	.size = SZ_256M},      /* APU
> */
> +};
> +
> 
> xxxxxxxxxxx
> 
> +static const unsigned int
> mt8365_larb_region_msk[MT8365_REGION_NR][MTK_LARB_NR_MAX] = {
> +	[0] = {~(u32)(BIT(10) | BIT(11)), ~0, ~0, ~0, ~0, ~0},
> +	[1] = {[0] = BIT(10) | BIT(11)},
> +};
> +
>   static const struct mtk_iommu_plat_data mt8365_data = {
>   	.m4u_plat	= M4U_MT8365,
>   	.flags		= RESET_AXI | INT_ID_PORT_WIDTH_6,
>   	.inv_sel_reg	= REG_MMU_INV_SEL_GEN1,
>   	.banks_num	= 1,
>   	.banks_enable	= {true},
> -	.iova_region	= single_domain,
> -	.iova_region_nr	= ARRAY_SIZE(single_domain),
> +	.iova_region	= mt8365_multi_rgn,
> +	.iova_region_nr	= ARRAY_SIZE(mt8365_multi_rgn),
> +	.iova_region_larb_msk = mt8365_larb_region_msk,
>   	.larbid_remap	= {{0}, {1}, {2}, {3}, {4}, {5}}, /* Linear
> mapping. */
>   };
> --------------------------------
> 
> After that, If we call DMA API with the device whose dtsi has
> M4U_PORT_APU_READ/M4U_PORT_APU_WRITE. The iova should be located at
> that special address. Sorry, I have no board to test.
> 

I have not yet tested the patches but it will only address one part of 
the problem.
Using your patches, I could allocate some shared memory using DMA API 
but the main issue still remain.
The firmware is not relocatable at all. So, once the firmware is built, 
it is expected to be loaded at a specific address.
Remoteproc framework support this use case. Using the resource table, 
the firmware expose to remoteproc what device address is expect and 
remoteproc manually call iommu_map to satisfy this requirement.
Using DMA_API, I could allocate the memory to load the firmware but I 
could not be sure that the DMA address will be the one expected by firmware.

Thanks,
Alexandre
