Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEA4B57317
	for <iommu@lists.linux.dev>; Fri, 12 Jan 2024 10:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LNTAKtpw"
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-50edf4f478eso2432838e87.3
        for <iommu@lists.linux.dev>; Fri, 12 Jan 2024 02:01:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705053683; x=1705658483; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=n6BjmcfWjZQ9/+4cG+gO0wA5RcUkVwPj/srDhWTeVkw=;
        b=LNTAKtpwRuEVnZqYtBAcubD4Rmg60TJ0CuiMiWNnXgs9EfG7CalhaNUtk3XNPniGgB
         DtTzplfNIGiYtr7R875zJwGgcPqur0ZgWvxqv4P6hQ+RD8STR8+Lcfep3d53Fr8j/1It
         D8Nf++WN1VQhXNt3WyW1O51r3Hk4i2NNe+ZqYS3VIyYhE4XDEYAXR/h93vZQA0CNxe/x
         15dJc69XN/CNCkoU1bR2XF+KRXvQiiq1Um+qSl5TzqwNmtPNbeANWfS7LIKxzt7UqdqB
         E5T3CCfsfNS5lKAat0OQ26bNH6CO6F7VUF6xOa1XcahZuQc6NBL+lsoDzQpLsEfqdG+9
         RpWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705053683; x=1705658483;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n6BjmcfWjZQ9/+4cG+gO0wA5RcUkVwPj/srDhWTeVkw=;
        b=eI7UE6Zz7EA6idIVOOPfCAVKVVgBiOy0qYK88+h4WOlMwBvwReqF+nN+GFkKvJBLPb
         hrnIH7QWEwEOgWcFDBzJe9MGal/PxeFJo0ywNPycYmhLh3g3iC1M8lSWFHVEoDTDpUV7
         Wm31li8e6FDzvxzLXOpfTrb/YdDxt8rnTeDAR870W5WsQRHoB/zC5SsePGFNeo4UPj+t
         fW6xDOeXjUV7xGPJSsELIdxO42QRilUcfKnB3uEcH2lePYwDO14F7Xq65mzip5ts1sks
         FEac3/OQjfi/YbRRjlOojABPIyZNKsaLemSmCOP+Rs53/PkxcznH3hr0B3emnzpWo8u0
         SDgA==
X-Gm-Message-State: AOJu0YwZXH8UoKfrdryugqYYd6xyd2P5nRwoWCKDaSKCE2ziNNVw5iJn
	S5HFIuSAJGDVnTyA1abaKm+M5O1xqjnDGg==
X-Google-Smtp-Source: AGHT+IFdf6AxtBCMz972hyGa8aRUo2uXDlIRk0LRgwUwwY0TdQHup04VCkl99x6SMm/BPp1uDhJs3g==
X-Received: by 2002:a2e:8007:0:b0:2cd:63e4:75ff with SMTP id j7-20020a2e8007000000b002cd63e475ffmr517106ljg.35.1705053682887;
        Fri, 12 Jan 2024 02:01:22 -0800 (PST)
Received: from [172.30.204.205] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id x7-20020a2e9c87000000b002cd0435c50bsm407024lji.72.2024.01.12.02.01.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Jan 2024 02:01:22 -0800 (PST)
Message-ID: <babd9514-6202-486f-a7c5-51ad793aaca6@linaro.org>
Date: Fri, 12 Jan 2024 11:01:21 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 3/5] iommu/arm-smmu: introduction of ACTLR for custom
 prefetcher settings
To: Bibek Kumar Patro <quic_bibekkum@quicinc.com>,
 Pavan Kondeti <quic_pkondeti@quicinc.com>
Cc: will@kernel.org, robin.murphy@arm.com, joro@8bytes.org,
 dmitry.baryshkov@linaro.org, jsnitsel@redhat.com, quic_bjorande@quicinc.com,
 mani@kernel.org, quic_eberman@quicinc.com, robdclark@chromium.org,
 u.kleine-koenig@pengutronix.de, robh@kernel.org, vladimir.oltean@nxp.com,
 quic_molvera@quicinc.com, linux-arm-msm@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20240109114220.30243-1-quic_bibekkum@quicinc.com>
 <20240109114220.30243-4-quic_bibekkum@quicinc.com>
 <2ad70157-27d1-41df-8866-c226af690cf6@quicinc.com>
 <ec31fafa-b912-454a-8b64-e0593911aaf2@quicinc.com>
 <4a595815-7fcc-47e2-b22c-dac349af6d79@quicinc.com>
 <492aeca3-a4df-47a3-9c77-02ea4235d736@linaro.org>
 <1a1f9b11-5a6d-41f7-8bcd-533a61a27a65@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <1a1f9b11-5a6d-41f7-8bcd-533a61a27a65@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 1/11/24 19:09, Bibek Kumar Patro wrote:
> 
> 
> On 1/10/2024 11:26 PM, Konrad Dybcio wrote:
>>
>>
>> On 1/10/24 13:55, Bibek Kumar Patro wrote:
>>>
>>>
>>> On 1/10/2024 4:46 PM, Bibek Kumar Patro wrote:
>>>>
>>>>
>>>> On 1/10/2024 9:36 AM, Pavan Kondeti wrote:
>>>
>>> [...]
>>>
>>>>>> @@ -274,6 +321,21 @@ static const struct of_device_id qcom_smmu_client_of_match[] __maybe_unused = {
>>>>>>   static int qcom_smmu_init_context(struct arm_smmu_domain *smmu_domain,
>>>>>>           struct io_pgtable_cfg *pgtbl_cfg, struct device *dev)
>>>>>>   {
>>>>>> +    struct arm_smmu_device *smmu = smmu_domain->smmu;
>>>>>> +    struct qcom_smmu *qsmmu = to_qcom_smmu(smmu);
>>>>>> +    const struct actlr_variant *actlrvar;
>>>>>> +    int cbndx = smmu_domain->cfg.cbndx;
>>>>>> +
>>>>>> +    if (qsmmu->data->actlrvar) {
>>>>>> +        actlrvar = qsmmu->data->actlrvar;
>>>>>> +        for (; actlrvar->io_start; actlrvar++) {
>>>>>> +            if (actlrvar->io_start == smmu->ioaddr) {
>>>>>> +                qcom_smmu_set_actlr(dev, smmu, cbndx, actlrvar->actlrcfg);
>>>>>> +                break;
>>>>>> +            }
>>>>>> +        }
>>>>>> +    }
>>>>>> +
>>>>>
>>>>> This block and the one in qcom_adreno_smmu_init_context() are exactly
>>>>> the same. Possible to do some refactoring?
>>>>>
>>>>
>>>> I will check if this repeated blocks can be accomodated this into qcom_smmu_set_actlr function if that would be fine.
>>>>
>>>
>>> Also adding to this, this might increase the number of indentation inside qcom_smmu_set_actlr as well, to around 5. So wouldn't this
>>> be an issue?
>>
>> By the way, we can refactor this:
>>
>> if (qsmmu->data->actlrvar) {
>>      actlrvar = qsmmu->data->actlrvar;
>>      for (; actlrvar->io_start; actlrvar++) {
>>          if (actlrvar->io_start == smmu->ioaddr) {
>>              qcom_smmu_set_actlr(dev, smmu, cbndx, actlrvar->actlrcfg);
>>              break;
>>          }
>>      }
>> }
>>
>> into
>>
>> // add const u8 num_actlrcfgs to struct actrl_variant to
>> // save on sentinel space:
>> //   sizeof(u8) < sizeof(ptr) + sizeof(resource_size_t)
>>
> 
> Git it, Would it be better to add this in struct qcom_smmu_match_data ?

Yes, right.

> Posted a sample below.
> 
>>
>> [declarations]
>> const struct actlr_variant *actlrvar = qsmmu->data->actlrvar;
>> int i;
>>
>> [rest of the functions]
>>
>> if (!actlrvar)
>>      return 0;
>>  > for (i = 0; i < actrlvar->num_actrlcfgs; i++) {
>>      if (actlrvar[i].io_start == smmu->ioaddr) {
>>          qcom_smmu_set_actlr(dev, smmu, cbndx, actlrvar->actlrcfg);
>>          break;
>>      }
>> }
>>  > Saving both on .TEXT size and indentation levels :)
>>
> Thanks for this suggestion Konrad, will try to implement this, as it would reduce the indent levels to good extent.
> Would something like this be okay?
> 
> static int qcom_smmu_init_context(struct arm_smmu_domain *smmu_domain,
>       struct qcom_smmu *qsmmu = to_qcom_smmu(smmu);
>       const struct actlr_variant *actlrvar;
>       int cbndx = smmu_domain->cfg.cbndx;
> +    int i;
> 
> +    actlrvar = qsmmu->data->actlrvar;
> +
> +    if (!actlrvar)
> +        goto end;
> +
> +    for (i = 0; i < qsmmu->data->num_smmu ; i++) {
> +        if (actlrvar[i].io_start == smmu->ioaddr) {
> +            qcom_smmu_set_actlr(dev, smmu, cbndx,
> +                        actlrvar[i].actlrcfg);
> +            break;
>           }
>       }
> 
> +end:
>       smmu_domain->cfg.flush_walk_prefer_tlbiasid = true;

If you move this assignment before the actlrvar checking (there's no
dependency between them), you will get rid of the goto.

I also noticed that qcom_smmu_match_data.actlrvar could likely be
const struct actlr_variant * const (const pointer to a const
resource), similarly for actlr_variant.actlrcfg

Konrad
