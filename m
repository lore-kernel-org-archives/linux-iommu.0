Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3278AD5F
	for <iommu@lists.linux.dev>; Tue,  7 Mar 2023 16:47:36 +0000 (UTC)
Received: by mail-lj1-f178.google.com with SMTP id h9so13832439ljq.2
        for <iommu@lists.linux.dev>; Tue, 07 Mar 2023 08:47:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678207654;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=miubZc3CtDbzJl53cM6P+MCImyMemBlZXFn3W2kwl5E=;
        b=YVIVbvYVE9eGrTyx8hARPRWJK6c8HJayfhsGrJaLe7yxQPtNbGFYK39eH4LV3WMEss
         yxWNmzxA01gmuqorwe36v6twZKqcmqjtGz5VUchhKHkPrMUjIytMjEINw/TEQgPJFRhQ
         7I4OFhSQt8uI298CWgI1HWrTKq0MAdZeLwdqLIo1q7mJ4r8yXN6UfqVAqJVSpjGUMjRq
         ITC79DOiBEdzFhfdRvV89hlzrCvns0XrSn84X12PROvPnYJxTYIe1MICGudoj/SrGEky
         B+OK2CCo8uA3u16dwL0UpRDqdVna2wglliFdhSExtbsJmK7gmH1cOJwTLQOG3Szv3wHD
         0VUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678207654;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=miubZc3CtDbzJl53cM6P+MCImyMemBlZXFn3W2kwl5E=;
        b=3KArGupMwF9aHAs6XrBs35DlD8+sPNOIODuJ5EtYUc5zDsAp05A9vhGa5srLdySA7D
         4EsziucAKLHw/Nxbg/ybOoGb6USY6t02cEgiPoR+LAY04697Uew/Uidny/RNju1KST29
         yq07ah6bmNz+o0SYsxRESbrcmJGuZyoIT2io3VsmzvBDNGZixOd2RCx1yOLdqEk4HRYh
         9y6FpK9zZWxAdkf2H+8Eq8vH0fN1dwF/yVDjQJabFZVx1OnVE7+XxXvknmeiS3rc+Arn
         NXiS00KwcuxDth2uNdeCdBUFhP+725+M6TfbIH1EHXNNhHWGbgERPY6WLCkE1+/Pv949
         yQPg==
X-Gm-Message-State: AO0yUKVlZWHwXKZUJGUGRWi8MfV/pKog6FwPgnFLUTO1YaICiwnWMIwp
	EL4jaUZHPuX4/nhJ1ft5DWsdvA==
X-Google-Smtp-Source: AK7set+3vw5K04+n8GjmNt7a8Fo4Kmc6WId+tcCTsw47pJ6eOSwFijvph/LKR1HJ3CaWNCiWlA7ECw==
X-Received: by 2002:a2e:a98c:0:b0:298:39e6:cc1a with SMTP id x12-20020a2ea98c000000b0029839e6cc1amr4612782ljq.9.1678207654624;
        Tue, 07 Mar 2023 08:47:34 -0800 (PST)
Received: from [192.168.1.101] (abyj16.neoplus.adsl.tpnet.pl. [83.9.29.16])
        by smtp.gmail.com with ESMTPSA id z5-20020a2e7e05000000b002958a51df76sm2230447ljc.92.2023.03.07.08.47.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Mar 2023 08:47:34 -0800 (PST)
Message-ID: <bb0ffb47-c015-6315-2da4-341529a4a8ed@linaro.org>
Date: Tue, 7 Mar 2023 17:47:32 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v3 2/6] iommu/qcom: Use the asid read from device-tree if
 specified
Content-Language: en-US
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 agross@kernel.org
Cc: andersson@kernel.org, joro@8bytes.org, will@kernel.org,
 robin.murphy@arm.com, robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 robdclark@gmail.com, linux-arm-msm@vger.kernel.org, iommu@lists.linux.dev,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, marijn.suijten@somainline.org,
 kernel@collabora.com, luca@z3ntu.xyz, a39.skl@gmail.com,
 phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
References: <20221115101122.155440-1-angelogioacchino.delregno@collabora.com>
 <20221115101122.155440-3-angelogioacchino.delregno@collabora.com>
 <12f0800c-beb3-6fdc-b743-8624f0d5d6ac@linaro.org>
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <12f0800c-beb3-6fdc-b743-8624f0d5d6ac@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 7.03.2023 17:44, Dmitry Baryshkov wrote:
> On 15/11/2022 12:11, AngeloGioacchino Del Regno wrote:
>> As specified in this driver, the context banks are 0x1000 apart but
>> on some SoCs the context number does not necessarily match this
>> logic, hence we end up using the wrong ASID: keeping in mind that
>> this IOMMU implementation relies heavily on SCM (TZ) calls, it is
>> mandatory that we communicate the right context number.
>>
>> Since this is all about how context banks are mapped in firmware,
>> which may be board dependent (as a different firmware version may
>> eventually change the expected context bank numbers), introduce a
>> new property "qcom,ctx-num": when found, the ASID will be forced
>> as read from the devicetree.
>>
>> When "qcom,ctx-num" is not found, this driver retains the previous
>> behavior as to avoid breaking older devicetrees or systems that do
>> not require forcing ASID numbers.
>>
>> Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
>> [Marijn: Rebased over next-20221111]
>> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>> ---
>>   drivers/iommu/arm/arm-smmu/qcom_iommu.c | 18 +++++++++++++++---
>>   1 file changed, 15 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/iommu/arm/arm-smmu/qcom_iommu.c b/drivers/iommu/arm/arm-smmu/qcom_iommu.c
>> index bfd7b51eb5db..491a8093f3d6 100644
>> --- a/drivers/iommu/arm/arm-smmu/qcom_iommu.c
>> +++ b/drivers/iommu/arm/arm-smmu/qcom_iommu.c
>> @@ -551,7 +551,8 @@ static int qcom_iommu_of_xlate(struct device *dev, struct of_phandle_args *args)
>>        * index into qcom_iommu->ctxs:
>>        */
>>       if (WARN_ON(asid < 1) ||
>> -        WARN_ON(asid > qcom_iommu->num_ctxs)) {
>> +        WARN_ON(asid > qcom_iommu->num_ctxs) ||
>> +        WARN_ON(qcom_iommu->ctxs[asid - 1] == NULL)) {
> 
> Separate change in my opinion. Please split it to a separate patch with proper Fixes: tag.
> 
>>           put_device(&iommu_pdev->dev);
>>           return -EINVAL;
>>       }
>> @@ -638,7 +639,8 @@ static int qcom_iommu_sec_ptbl_init(struct device *dev)
>>     static int get_asid(const struct device_node *np)
>>   {
>> -    u32 reg;
>> +    u32 reg, val;
>> +    int asid;
>>         /* read the "reg" property directly to get the relative address
>>        * of the context bank, and calculate the asid from that:
>> @@ -646,7 +648,17 @@ static int get_asid(const struct device_node *np)
>>       if (of_property_read_u32_index(np, "reg", 0, &reg))
Use platform_get_resource(pdev, IORESOURCE_MEM, 0); reg = res->start
or something like this, the current approach relies on #address-cells = <1>

Konrad
>>           return -ENODEV;
>>   -    return reg / 0x1000;      /* context banks are 0x1000 apart */
>> +    /*
>> +     * Context banks are 0x1000 apart but, in some cases, the ASID
>> +     * number doesn't match to this logic and needs to be passed
>> +     * from the DT configuration explicitly.
>> +     */
>> +    if (of_property_read_u32(np, "qcom,ctx-num", &val))
>> +        asid = reg / 0x1000;
>> +    else
>> +        asid = val;
> 
> As a matter of preference (and logic) I'd have written that as:
> 
> if (!of_property_read(np, "qcom,ctx-num", &val))
>     asid = val;
> else
>     asid = reg / 0x1000;
> 
> LGTM otherwise
> 
>> +
>> +    return asid;
>>   }
>>     static int qcom_iommu_ctx_probe(struct platform_device *pdev)
> 
