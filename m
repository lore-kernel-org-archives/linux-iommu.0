Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E82214D589
	for <iommu@lists.linux.dev>; Wed, 10 Jan 2024 17:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JMN/2+4W"
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2cd5c55d6b8so35752591fa.3
        for <iommu@lists.linux.dev>; Wed, 10 Jan 2024 09:56:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704909414; x=1705514214; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YPUG8wGHjUncLfJR9e1hMbIghHR8x5XwILqQc+Upn/A=;
        b=JMN/2+4WYhwM+vUGFHqjSNMMu5sl2MkobRL5V0V6Hut39PHk64OQqdknfoW2lat2zG
         GPbx2NkbIacgHEndVZ7ImJm5irs4rbkTHnGlhseLblJhTjOs+f2RUtjJ1HO6xsuPpiYw
         OMBju2QxhrYZQxJ8NO7Wb4BRThNI4Gt8a04j6ooCdBmZzEffXCYJ8R+IPxsrraa/KfQs
         BpLvASkJrFYncdpErgu3bkS7V9zwhz49oCJzkVaaHV1IGo7JNs649EqQNFt0sDwz0g9l
         AQG+ldW94YyzuTByaWe8CLEAgnj7slv1+caKeR/qJsXZHSgLCXz334fs3Lcf/5qLrfSn
         JsYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704909414; x=1705514214;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YPUG8wGHjUncLfJR9e1hMbIghHR8x5XwILqQc+Upn/A=;
        b=uUj41Mv8RkG9tBFqN0tYiGJnkswfDC+UjzzDj+vAqMZMknaWWFpWql5tVp3CKP3nLv
         1gmHRZ4UJ/UOCqIHuLDS1pQJMnPU/pcsLCqtWU+irCGfgFUNsrvHPRuHJZgtRWFb2X0U
         B+xy543QHVEITvPEFOJPm3a1L4rpebmirLDl03ghy9S57NWiZ6XrcLPyszYiV9vMB9jJ
         YdkE7gHdMP6A1P2AZZOSYBFCpoIzuRWyNEGEvHHae7J2mQVsoygliJhyBLGUyExdU7l7
         /SEHaaAr61bEnYPEg0fG9hlsS/Bk39X5m6ELr0S3COUPcN55By2s50Jy7zhYc/B+kQjt
         3PXQ==
X-Gm-Message-State: AOJu0YxqTO8SZMUo/c6a546sGs3fQ3YJYd3hDMUyyPTP7ppeLrpg3+n3
	5r0zmy4WhmXkQ0vTFke5auFQKl3iZLecZg==
X-Google-Smtp-Source: AGHT+IHvrOZ0aqeCr586qVWcuhFyKWtM901HK7CwO0DiO3YJfPrWwlIUBPh0GgYU2a0lKt1fMyeUlQ==
X-Received: by 2002:a05:651c:b23:b0:2cd:7fe1:39c with SMTP id b35-20020a05651c0b2300b002cd7fe1039cmr334267ljr.72.1704909413963;
        Wed, 10 Jan 2024 09:56:53 -0800 (PST)
Received: from [172.30.205.123] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id v17-20020a2ea451000000b002cd1a3bdecbsm829614ljn.22.2024.01.10.09.56.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jan 2024 09:56:53 -0800 (PST)
Message-ID: <492aeca3-a4df-47a3-9c77-02ea4235d736@linaro.org>
Date: Wed, 10 Jan 2024 18:56:51 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 3/5] iommu/arm-smmu: introduction of ACTLR for custom
 prefetcher settings
Content-Language: en-US
To: Bibek Kumar Patro <quic_bibekkum@quicinc.com>,
 Pavan Kondeti <quic_pkondeti@quicinc.com>
Cc: will@kernel.org, robin.murphy@arm.com, joro@8bytes.org,
 dmitry.baryshkov@linaro.org, jsnitsel@redhat.com, quic_bjorande@quicinc.com,
 mani@kernel.org, quic_eberman@quicinc.com, robdclark@chromium.org,
 u.kleine-koenig@pengutronix.de, robh@kernel.org, vladimir.oltean@nxp.com,
 quic_molvera@quicinc.com, linux-arm-msm@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, qipl.kernel.upstream@quicinc.com
References: <20240109114220.30243-1-quic_bibekkum@quicinc.com>
 <20240109114220.30243-4-quic_bibekkum@quicinc.com>
 <2ad70157-27d1-41df-8866-c226af690cf6@quicinc.com>
 <ec31fafa-b912-454a-8b64-e0593911aaf2@quicinc.com>
 <4a595815-7fcc-47e2-b22c-dac349af6d79@quicinc.com>
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <4a595815-7fcc-47e2-b22c-dac349af6d79@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 1/10/24 13:55, Bibek Kumar Patro wrote:
> 
> 
> On 1/10/2024 4:46 PM, Bibek Kumar Patro wrote:
>>
>>
>> On 1/10/2024 9:36 AM, Pavan Kondeti wrote:
> 
> [...]
> 
>>>> @@ -274,6 +321,21 @@ static const struct of_device_id qcom_smmu_client_of_match[] __maybe_unused = {
>>>>   static int qcom_smmu_init_context(struct arm_smmu_domain *smmu_domain,
>>>>           struct io_pgtable_cfg *pgtbl_cfg, struct device *dev)
>>>>   {
>>>> +    struct arm_smmu_device *smmu = smmu_domain->smmu;
>>>> +    struct qcom_smmu *qsmmu = to_qcom_smmu(smmu);
>>>> +    const struct actlr_variant *actlrvar;
>>>> +    int cbndx = smmu_domain->cfg.cbndx;
>>>> +
>>>> +    if (qsmmu->data->actlrvar) {
>>>> +        actlrvar = qsmmu->data->actlrvar;
>>>> +        for (; actlrvar->io_start; actlrvar++) {
>>>> +            if (actlrvar->io_start == smmu->ioaddr) {
>>>> +                qcom_smmu_set_actlr(dev, smmu, cbndx, actlrvar->actlrcfg);
>>>> +                break;
>>>> +            }
>>>> +        }
>>>> +    }
>>>> +
>>>
>>> This block and the one in qcom_adreno_smmu_init_context() are exactly
>>> the same. Possible to do some refactoring?
>>>
>>
>> I will check if this repeated blocks can be accomodated this into qcom_smmu_set_actlr function if that would be fine.
>>
> 
> Also adding to this, this might increase the number of indentation inside qcom_smmu_set_actlr as well, to around 5. So wouldn't this
> be an issue?

By the way, we can refactor this:

if (qsmmu->data->actlrvar) {
	actlrvar = qsmmu->data->actlrvar;
	for (; actlrvar->io_start; actlrvar++) {
		if (actlrvar->io_start == smmu->ioaddr) {
			qcom_smmu_set_actlr(dev, smmu, cbndx, actlrvar->actlrcfg);
			break;
		}
	}
}

into

// add const u8 num_actlrcfgs to struct actrl_variant to
// save on sentinel space:
//   sizeof(u8) < sizeof(ptr) + sizeof(resource_size_t)


[declarations]
const struct actlr_variant *actlrvar = qsmmu->data->actlrvar;
int i;

[rest of the functions]

if (!actlrvar)
	return 0;

for (i = 0; i < actrlvar->num_actrlcfgs; i++) {
	if (actlrvar[i].io_start == smmu->ioaddr) {
		qcom_smmu_set_actlr(dev, smmu, cbndx, actlrvar->actlrcfg);
		break;
	}
}

Saving both on .TEXT size and indentation levels :)

Konrad
