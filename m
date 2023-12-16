Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18E292FE3A
	for <iommu@lists.linux.dev>; Sat, 16 Dec 2023 16:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TAItclRv"
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-50e24e92432so935897e87.2
        for <iommu@lists.linux.dev>; Sat, 16 Dec 2023 08:15:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702743333; x=1703348133; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qeLT1e+qbSgjrGyqQZvrpiOzUZfbAwmDa6RwR6n1lNI=;
        b=TAItclRv/Q6RjA3BRMz0l7sywxFzbhhBimKG5dRMnjcWeHlyy/pH0PE7N6U1ApBp3h
         OGeby9eoZllV7LYH1ttXnFzlqkf5ewrwh8HCJas0VdiCtB1+aV3SSWWLUtNStz/HaaWC
         3hhui8SrSPDyfGt4UzDTIqGT90kOjf/QA1x5z5PVsU/HjNECKhIrHO/3Ieh9LbMN7QB8
         IHbcXqtPJYb0M/3ftcpHd//i3gIvAY7ZuDuDrYse8dV54d8RCHECLzavP0gjEZ2zpi3q
         T+GmR5tTVg9eXUePiM5LpPKGkut7HvkVRNlgxNe4lQqi0UTApG64Yf0fu+JB8AfDkMMe
         JDtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702743333; x=1703348133;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qeLT1e+qbSgjrGyqQZvrpiOzUZfbAwmDa6RwR6n1lNI=;
        b=D0qvufb7TdmrSncAnbxnrtZ86LsiEikzRXnDcehw1kXcPYmqCTq1MBaFTraMSvfbt3
         AUyY2RIX7kj3y3cKDHsQUCwm6cVKvNrWO/lPQGxU78nGZ/rsSKWrQaPnLE7UbFRaXHd7
         wzQ0Ia7JZyJQeCl3CNpzWH9/YKfSAtgL6qxSZkC2m1elnZH8Uag3jjNhXNAmwiNgpRpp
         Y+1c9T6iaXt32NajdatLtEjrvHCTEPBbYKVwzA6bHpBJW2poRB6u5Gq21Ppa3mNna/AA
         r/EV4S+eClMU/+QXFKMlKneI3EN+mF++5Cc5ngh2slmrqEa2sZx9VVcfC/1Ot4AqsR1r
         uJQg==
X-Gm-Message-State: AOJu0YwAf5mfZgEjieCi7itlVxVl5IZEoVrXzl6wO68BiwxUUveGWZph
	JkqoBl7q//ut6iY6YRK4I7HgVg==
X-Google-Smtp-Source: AGHT+IFyBlyr8IarwaY/KXA21ZvD5LEXaXoXhH/9GPTJG6o1Hz7429JcjKoJncDWK7Cq3G0gWU28jQ==
X-Received: by 2002:ac2:464f:0:b0:50c:de34:d8d7 with SMTP id s15-20020ac2464f000000b0050cde34d8d7mr5603036lfo.127.1702743332893;
        Sat, 16 Dec 2023 08:15:32 -0800 (PST)
Received: from ?IPV6:2001:14ba:a0db:1f00::227? (dzdqv0yyyyyyyyyyyykxt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::227])
        by smtp.gmail.com with ESMTPSA id m2-20020a0565120a8200b0050e17621ea4sm712657lfu.23.2023.12.16.08.15.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 16 Dec 2023 08:15:32 -0800 (PST)
Message-ID: <42d627af-164b-4b50-973e-fa71d86cb84c@linaro.org>
Date: Sat, 16 Dec 2023 18:15:31 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/5] iommu/arm-smmu: add ACTLR data and support for
 SM8550
To: Konrad Dybcio <konrad.dybcio@linaro.org>,
 Robin Murphy <robin.murphy@arm.com>,
 Bibek Kumar Patro <quic_bibekkum@quicinc.com>
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
 <1eee8bae-59f0-4066-9d04-8c3a5f750d3a@linaro.org>
Content-Language: en-GB
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <1eee8bae-59f0-4066-9d04-8c3a5f750d3a@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 16/12/2023 02:03, Konrad Dybcio wrote:
> On 15.12.2023 13:54, Robin Murphy wrote:
>> On 2023-12-15 12:20 pm, Bibek Kumar Patro wrote:
>>>
>>>
>>> On 12/15/2023 4:14 PM, Dmitry Baryshkov wrote:
>>>> On Fri, 15 Dec 2023 at 12:19, Bibek Kumar Patro
>>>> <quic_bibekkum@quicinc.com> wrote:
>>>>>
>>>>> Add ACTLR data table for SM8550 along with support for
>>>>> same including SM8550 specific implementation operations.
>>>>>
>>>>> Signed-off-by: Bibek Kumar Patro <quic_bibekkum@quicinc.com>
>>>>> ---
>>>>>    drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 89 ++++++++++++++++++++++
>>>>>    1 file changed, 89 insertions(+)
>>>>>
>>>>> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
>>>>> index cb49291f5233..d2006f610243 100644
>>>>> --- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
>>>>> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
>>>>> @@ -20,6 +20,85 @@ struct actlr_config {
>>>>>           u32 actlr;
>>>>>    };
>>>>>
>>>>> +/*
>>>>> + * SMMU-500 TRM defines BIT(0) as CMTLB (Enable context caching in the
>>>>> + * macro TLB) and BIT(1) as CPRE (Enable context caching in the prefetch
>>>>> + * buffer). The remaining bits are implementation defined and vary across
>>>>> + * SoCs.
>>>>> + */
>>>>> +
>>>>> +#define PREFETCH_DEFAULT       0
>>>>> +#define PREFETCH_SHALLOW       BIT(8)
>>>>> +#define PREFETCH_MODERATE      BIT(9)
>>>>> +#define PREFETCH_DEEP          (BIT(9) | BIT(8))
>>>>
>>>> I thin the following might be more correct:
>>>>
>>>> #include <linux/bitfield.h>
>>>>
>>>> #define PREFETCH_MASK GENMASK(9, 8)
>>>> #define PREFETCH_DEFAULT FIELD_PREP(PREFETCH_MASK, 0)
>>>> #define PREFETCH_SHALLOW FIELD_PREP(PREFETCH_MASK, 1)
>>>> #define PREFETCH_MODERATE FIELD_PREP(PREFETCH_MASK, 2)
>>>> #define PREFETCH_DEEP FIELD_PREP(PREFETCH_MASK, 3)
>>>>
>>>
>>> Ack, thanks for this suggestion. Let me try this out using
>>> GENMASK. Once tested, will take care of this in next version.
>>
>> FWIW the more typical usage would be to just define the named macros for the raw field values, then put the FIELD_PREP() at the point of use. However in this case that's liable to get pretty verbose, so although I'm usually a fan of bitfield.h, the most readable option here might actually be to stick with simpler definitions of "(0 << 8)", "(1 << 8)", etc. However it's not really a big deal either way, and I defer to whatever Dmitry and Konrad prefer, since they're the ones looking after arm-smmu-qcom the most :)
> My 5 cents would be to just use the "common" style of doing this, so:
> 
> #define ACTRL_PREFETCH	GENMASK(9, 8)
>   #define PREFETCH_DEFAULT 0
>   #define PREFETCH_SHALLOW 1
>   #define PREFETCH_MODERATE 2
>   #define PREFETCH_DEEP 3
> 
> and then use
> 
> | FIELD_PREP(ACTRL_PREFETCH, PREFETCH_x)
> 
> it can get verbose, but.. arguably that's good, since you really want
> to make sure the right bits are set here

Sounds good to me.


-- 
With best wishes
Dmitry

