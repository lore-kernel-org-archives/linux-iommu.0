Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C60928C10
	for <iommu@lists.linux.dev>; Tue, 31 Jan 2023 15:31:02 +0000 (UTC)
Received: by mail-wr1-f43.google.com with SMTP id q5so14616243wrv.0
        for <iommu@lists.linux.dev>; Tue, 31 Jan 2023 07:31:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LNHg+3VGzgNlbuSbTVuo88oNplb0rm3LEdUfokdqDlg=;
        b=RCHkxpAWnQSqHPdnpp6ePitnHgP5WVPogB8f4u0fTq40Rqx8pgjf0347MqkJRxynb3
         B9ijSs+0b/JWGxtBgA+ZeCIhr7K6c6+PLW4xMI/ZOfxt5wQU54RgTAFcb0zdb5eVlKBA
         Eh4BjJFUwN0O50CF8aA6LYnAPVYj2W8Q8RX71si2HdGc/Uqy7Nou3KLW4B/PG1PZod4t
         ywjwZ86pNhuWMWA3h2dM/5ystXzDgz1jwrSVZoZdvyAY/EJKJj4kHiKivf5v72MnwVuo
         j6+FWNImer03bd5e1umGwjFtjzCIf2pVubgtWLw3bIuGdCutkH2Va8fBoNtMJ+62wci2
         JaTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LNHg+3VGzgNlbuSbTVuo88oNplb0rm3LEdUfokdqDlg=;
        b=Y+ViDC5pLr17qt/iLFHsNi+WR/Urb7jRmKFkXcFlKTYkmEKlr500BGhi6LZNKeNdaW
         R31bIPO0HRvgplGwOWzjIIKS9svC+FCppKdf21hvjwu8TZ6jE0D5c4e/3bsnBJE9BQyW
         rpJGqakDznG1gvU71+8V3bcki2hX3KNhvhoLdL1KpjOGAq5o3zIzW4NwUuJ8QMAe282Y
         E1fIiwX7Cc5ryNA1JBYCvkvJ3L0v3FSbB69FEZhF0iGp0NuXLIyHQjEpTfixuohaeup+
         xbVS95mwU6e9+Z59jd3gnfcFN50SZp6QPQVaL5QbqTIxHDUNfN1Pyby9UR2QdEpIkNv4
         zuhA==
X-Gm-Message-State: AO0yUKVwTcsFbcPNca6taV596z9rH8Re3fw/O1OCslMQ3a2Mxse2JdEO
	5I2gkBblXNRmbHsNmVDlk8cmXw==
X-Google-Smtp-Source: AK7set9IQ7yWTwyiPAv7mBA1PbDTtpyNBAOCky4AcErrqoNQA9Poy8RWuBQOGbUKoTkPmUImtL4p2g==
X-Received: by 2002:a5d:64a6:0:b0:2bf:b11d:91b with SMTP id m6-20020a5d64a6000000b002bfb11d091bmr3938165wrp.44.1675179060974;
        Tue, 31 Jan 2023 07:31:00 -0800 (PST)
Received: from [10.1.4.104] (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id m14-20020a5d6a0e000000b002bfd09f2ca6sm13091544wru.3.2023.01.31.07.30.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Jan 2023 07:31:00 -0800 (PST)
Message-ID: <21fef8eb-6482-fd8c-118a-c4d9da4cfbaf@baylibre.com>
Date: Tue, 31 Jan 2023 16:31:48 +0100
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
Content-Language: en-US
To: Robin Murphy <robin.murphy@arm.com>, yong.wu@mediatek.com,
 joro@8bytes.org, will@kernel.org
Cc: matthias.bgg@gmail.com, krzysztof.kozlowski@linaro.org,
 robh+dt@kernel.org, iommu@lists.linux.dev,
 linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20230130102722.133271-1-abailon@baylibre.com>
 <20230130102722.133271-3-abailon@baylibre.com>
 <741920ba-8637-5e28-695c-699b46351590@arm.com>
 <f126c61f-6373-d6c5-59c8-24dea9d9d168@baylibre.com>
 <0e9f677b-846d-809d-9bc3-30906f703fda@arm.com>
From: Alexandre Bailon <abailon@baylibre.com>
In-Reply-To: <0e9f677b-846d-809d-9bc3-30906f703fda@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 1/31/23 15:15, Robin Murphy wrote:
> On 31/01/2023 1:08 pm, Alexandre Bailon wrote:
>> Hi Robin
>>
>> On 1/30/23 13:04, Robin Murphy wrote:
>>> On 2023-01-30 10:27, Alexandre Bailon wrote:
>>>> Currently, the driver can allocate an unmanaged iommu domain.
>>>> But, this only works for SoC having multiple bank or multiple iova 
>>>> region.
>>>
>>> That is for good reason - there is only a single pagetable per bank, 
>>> so if there are multiple devices assigned to a single bank, they 
>>> cannot possibly be attached to different domains at the same time. 
>>> Hence why the banks are modelled as groups.
>> I understand.
>> I am trying to upstream a remoteproc driver but the remote processor is
>> behind the iommu.
>> remoteproc can manage the iommu but it requires an unmanaged domain.
>> I tried a couple of things but this cause code duplication,
>> implies many hacks and not always reliable.
>> Do you have any suggestion ?
> 
> If there are other active devices behind the same IOMMU, and the 
> remoteproc device cannot be isolated into its own bank using the 
> existing IOMMU driver logic, then the remoteproc driver cannot manage 
> the IOMMU directly, and must just use the regular DMA API. There's no 
> way around it; you can't have two different parts of the kernel both 
> thinking they have exclusive control of a single IOMMU address space at 
> the same time. Similarly, remoteproc also cannot take explicit control 
> of a multi-device group if it's not actually in control of the other 
> devices, since their drivers will not be expecting the DMA address space 
> to suddenly change underfoot - that's why iommu_attach_device() has the 
> check which you presumably ran into.
Unfortunately, we can't just use the regular DMA API.
Basically, the firmware use static addresses (and the remote core is 
only supposed to access addresses between 0x60000000 and 0x70000000).
When we use DMA API, we get a random address that doesn't match what the
firmware would expect.
remoteproc use directly the iommu API to map physical address to the
static address expected by the firmware when DMA API can't be use.

Thanks,
Alexandre

