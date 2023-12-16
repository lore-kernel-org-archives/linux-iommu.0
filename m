Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B0B0883D
	for <iommu@lists.linux.dev>; Sat, 16 Dec 2023 00:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rgviHEK1"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a1f8a1e9637so214052166b.1
        for <iommu@lists.linux.dev>; Fri, 15 Dec 2023 16:03:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702684990; x=1703289790; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bZ7CYe2npAANXdtUrU9jI0jn87kP/74n2PFavC5qkjA=;
        b=rgviHEK1aZUd1P3ApLtxleMO4usyeok+W72vGA2gpz+v2zwyTXrH6IX4fxOk29rmAk
         8Vl7g6QmFl5VXiUd071oW5wrdCVnITEdpobiEPIyi4jxVMN5QBfx3ph/nfvgziqLveh0
         lFHNa4R1i4ookfPY3xR9NiXFOAMeULrC9QW5D+6uGYM5c/oCkq2F30fn7Xoa4mPF7CGI
         Nh2utRIVL4soKn2EeUHvoNz8BQ/YB91Fat6ZZueFDw69M6m34Pe4b4egN2SAxvkYx2Ys
         60D0JaPoMukoaBqGw4/ZfsvxXUh1ahbAsKSnJWjybAOJueAAfAqtHjhzRPks8tYvxtXt
         chPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702684990; x=1703289790;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bZ7CYe2npAANXdtUrU9jI0jn87kP/74n2PFavC5qkjA=;
        b=M5qB0V/wdSZDJ/o41pxOT/zLdmZmBs0r5PzFIPvzlyh+TgRk6TgUSw65Dw6CGYYsie
         ZbWfozYXr8WYtOwFYncsdleqak0CDNf/ee9JnCJzysJnFVP/0mfVMqPa3Ujnetiv8KE1
         NPV+woPqL8NQki+EN6Fs5JyBsnqYfj5t3Ao7eFKneT9PZXhDZFceENtTvCG1uAwjDa/x
         VsfdMuVDaFXpwYu51ceAwZC9Pn/85tEcGWwT9+4NDvTzxGBjCBmngCvSIVx65j9ljAro
         9CvIHJIYFvD4rY4yWTVgqNCpEPcQ8RAUM3JkgBaqxwR2NptLCXVySfQC9hhjd5CNM2Y/
         5OXA==
X-Gm-Message-State: AOJu0Yw46w3GcxNxYLs+GXOmmGtirsAFbKC5dOq27ta9Xf/G5L33O7x6
	baSQ6Vi/j0tdPVs5AN/vrsNCBA==
X-Google-Smtp-Source: AGHT+IFFLbaw5X4Tftfj22SLofa2om+UIAlecqqdrks7DNY0JT7P+X493M9L3tWYA/1rhgG6AVIN0A==
X-Received: by 2002:a17:906:55:b0:a1b:7700:2c0b with SMTP id 21-20020a170906005500b00a1b77002c0bmr13876599ejg.19.1702684990512;
        Fri, 15 Dec 2023 16:03:10 -0800 (PST)
Received: from [192.168.199.59] (178235179137.dynamic-4-waw-k-1-3-0.vectranet.pl. [178.235.179.137])
        by smtp.gmail.com with ESMTPSA id tm6-20020a170907c38600b00a1ca6f5f189sm11420733ejc.179.2023.12.15.16.03.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Dec 2023 16:03:10 -0800 (PST)
Message-ID: <1eee8bae-59f0-4066-9d04-8c3a5f750d3a@linaro.org>
Date: Sat, 16 Dec 2023 01:03:07 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/5] iommu/arm-smmu: add ACTLR data and support for
 SM8550
Content-Language: en-US
To: Robin Murphy <robin.murphy@arm.com>,
 Bibek Kumar Patro <quic_bibekkum@quicinc.com>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: will@kernel.org, joro@8bytes.org, jsnitsel@redhat.com,
 quic_bjorande@quicinc.com, mani@kernel.org, quic_eberman@quicinc.com,
 robdclark@chromium.org, u.kleine-koenig@pengutronix.de, robh@kernel.org,
 vladimir.oltean@nxp.com, quic_pkondeti@quicinc.com,
 quic_molvera@quicinc.com, linux-arm-msm@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, qipl.kernel.upstream@quicinc.com
References: <20231215101827.30549-1-quic_bibekkum@quicinc.com>
 <20231215101827.30549-4-quic_bibekkum@quicinc.com>
 <CAA8EJppcsr1sbeD1fK0nZ+rASABNcetBK3yMvaP7OiA4JPwskw@mail.gmail.com>
 <c9493c5f-ccf8-4e21-b00c-5fbc2a5f2edb@quicinc.com>
 <b7f2bbf9-fb5a-430d-aa32-3a220b46c2f0@arm.com>
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <b7f2bbf9-fb5a-430d-aa32-3a220b46c2f0@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 15.12.2023 13:54, Robin Murphy wrote:
> On 2023-12-15 12:20 pm, Bibek Kumar Patro wrote:
>>
>>
>> On 12/15/2023 4:14 PM, Dmitry Baryshkov wrote:
>>> On Fri, 15 Dec 2023 at 12:19, Bibek Kumar Patro
>>> <quic_bibekkum@quicinc.com> wrote:
>>>>
>>>> Add ACTLR data table for SM8550 along with support for
>>>> same including SM8550 specific implementation operations.
>>>>
>>>> Signed-off-by: Bibek Kumar Patro <quic_bibekkum@quicinc.com>
>>>> ---
>>>>   drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 89 ++++++++++++++++++++++
>>>>   1 file changed, 89 insertions(+)
>>>>
>>>> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
>>>> index cb49291f5233..d2006f610243 100644
>>>> --- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
>>>> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
>>>> @@ -20,6 +20,85 @@ struct actlr_config {
>>>>          u32 actlr;
>>>>   };
>>>>
>>>> +/*
>>>> + * SMMU-500 TRM defines BIT(0) as CMTLB (Enable context caching in the
>>>> + * macro TLB) and BIT(1) as CPRE (Enable context caching in the prefetch
>>>> + * buffer). The remaining bits are implementation defined and vary across
>>>> + * SoCs.
>>>> + */
>>>> +
>>>> +#define PREFETCH_DEFAULT       0
>>>> +#define PREFETCH_SHALLOW       BIT(8)
>>>> +#define PREFETCH_MODERATE      BIT(9)
>>>> +#define PREFETCH_DEEP          (BIT(9) | BIT(8))
>>>
>>> I thin the following might be more correct:
>>>
>>> #include <linux/bitfield.h>
>>>
>>> #define PREFETCH_MASK GENMASK(9, 8)
>>> #define PREFETCH_DEFAULT FIELD_PREP(PREFETCH_MASK, 0)
>>> #define PREFETCH_SHALLOW FIELD_PREP(PREFETCH_MASK, 1)
>>> #define PREFETCH_MODERATE FIELD_PREP(PREFETCH_MASK, 2)
>>> #define PREFETCH_DEEP FIELD_PREP(PREFETCH_MASK, 3)
>>>
>>
>> Ack, thanks for this suggestion. Let me try this out using
>> GENMASK. Once tested, will take care of this in next version.
> 
> FWIW the more typical usage would be to just define the named macros for the raw field values, then put the FIELD_PREP() at the point of use. However in this case that's liable to get pretty verbose, so although I'm usually a fan of bitfield.h, the most readable option here might actually be to stick with simpler definitions of "(0 << 8)", "(1 << 8)", etc. However it's not really a big deal either way, and I defer to whatever Dmitry and Konrad prefer, since they're the ones looking after arm-smmu-qcom the most :)
My 5 cents would be to just use the "common" style of doing this, so:

#define ACTRL_PREFETCH	GENMASK(9, 8)
 #define PREFETCH_DEFAULT 0
 #define PREFETCH_SHALLOW 1
 #define PREFETCH_MODERATE 2
 #define PREFETCH_DEEP 3

and then use 

| FIELD_PREP(ACTRL_PREFETCH, PREFETCH_x)

it can get verbose, but.. arguably that's good, since you really want
to make sure the right bits are set here

Konrad
