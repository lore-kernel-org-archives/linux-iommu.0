Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F5F423BD
	for <iommu@lists.linux.dev>; Mon, 12 Dec 2022 11:21:56 +0000 (UTC)
Received: by mail-lf1-f47.google.com with SMTP id 1so17998425lfz.4
        for <iommu@lists.linux.dev>; Mon, 12 Dec 2022 03:21:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=glTvLRuHC4ZX/EsgPrtjqzGC7be65qHZLQLtVcgtfKE=;
        b=pjU6j75Dgm4RKGxIji8QeCGgIVlHl3X9VAPJf5VvKd4eR0fVmP/9l73xwbirrMqKun
         /p7Q1ETyZIHgzg0D90mr+T8mCdoDEbeUr6ZwhvIQ0JssdUlhV8Z/S/9D+KD37mIwfm25
         0buyzJSfiq+EUspLwgY817cYeGdTUsv/7VZm9yJt3NFPTTetcAzOQREQFucuFI2eNgg3
         8UFc304tzX6W7ALm3Bpj07cawN498+2gLk/30pzkNzkA46+tYe0HXRg8J9TY51+dBsel
         wgU+rOZM3PgURWQIZQ0kerdoFvFShqeno/1zmQvfIB2yK54wQGbNmnTBnmlAIaJ4K/p5
         qY5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=glTvLRuHC4ZX/EsgPrtjqzGC7be65qHZLQLtVcgtfKE=;
        b=3UtwUVz2SjoR2Q+H17uQuHmXwIZuD8FYUhdD7akZ7wWIEd4eNlFmJ4Htp3aDXsurxv
         r5b8POSQhHb/g8a/14vG9xEnkPKmd9MzgHJYcax8hiYIEAQj9hkU6aSA214bS8Ekip9W
         OwVYtyL08TtwoHlvOLKDerzrsWmiK1AkYOU5Hf1UZWnFmb3md3MBEx78kweKCLXtJ2TF
         BcAhxCdVibtnXXT4d7ycE29PI4tXhe0RhrzmZZYt4gqSYBgpAio8myUKxiYj2zUFY+I7
         dUpuSm1c0iCQ95d3k4z8b15sIsv26RgMAh3ixy4XOi00vMuLau8pHC3uFEwo8eKY+QMh
         xplQ==
X-Gm-Message-State: ANoB5pk3AZKSn3ooLBNSbds9Wwf/LzuOYcVf+nrBZQ5vbvHAZfKasn8I
	CsDBsXYQBGk3s090neVg/h2JjA==
X-Google-Smtp-Source: AA0mqf4xh1Suym2+rM2PZHE1O5sparKm3e/R6efWN5I9I4+nFbvi3+H7dif7UWMb1bOBaNGfbvaxPQ==
X-Received: by 2002:ac2:4950:0:b0:4b5:7925:870d with SMTP id o16-20020ac24950000000b004b57925870dmr3819266lfi.12.1670844114618;
        Mon, 12 Dec 2022 03:21:54 -0800 (PST)
Received: from [192.168.1.101] (abxh44.neoplus.adsl.tpnet.pl. [83.9.1.44])
        by smtp.gmail.com with ESMTPSA id g14-20020a0565123b8e00b004b4fefacd89sm1586129lfv.139.2022.12.12.03.21.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Dec 2022 03:21:54 -0800 (PST)
Message-ID: <c0145eca-5cdd-4600-89e1-00c0fd8b22ef@linaro.org>
Date: Mon, 12 Dec 2022 12:21:52 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH] iommu/arm-smmu-qcom: Add SM8150 DPU compatible
Content-Language: en-US
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 linux-arm-msm@vger.kernel.org, andersson@kernel.org, agross@kernel.org,
 krzysztof.kozlowski@linaro.org
Cc: marijn.suijten@somainline.org, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
 Konrad Dybcio <konrad.dybcio@somainline.org>,
 Sai Prakash Ranjan <quic_saipraka@quicinc.com>,
 Rob Clark <robdclark@chromium.org>, Adam Skladowski <a39.skl@gmail.com>,
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20221212100617.18190-1-konrad.dybcio@linaro.org>
 <552EFDD5-4BBE-408D-90EA-C96F4A0876B7@linaro.org>
 <57d3ba20-f1de-d7f3-d689-b25a02174379@linaro.org>
 <CAC2A315-5861-4324-849D-3EBF793146EA@linaro.org>
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <CAC2A315-5861-4324-849D-3EBF793146EA@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 12.12.2022 12:20, Dmitry Baryshkov wrote:
> 
> 
> On 12 December 2022 14:00:10 GMT+03:00, Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
>>
>>
>> On 12.12.2022 11:58, Dmitry Baryshkov wrote:
>>>
>>>
>>> On 12 December 2022 13:06:16 GMT+03:00, Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
>>>> From: Marijn Suijten <marijn.suijten@somainline.org>
>>>>
>>>> Add the SM8150 DPU compatible to clients compatible list, as it also
>>>> needs the workarounds.
>>>
>>> Please rebase on top of linux-next, this part was rewritten.
>> This one wasn't, but yeah it is based on some local changes
>> (see 6350/6375)..
> 
> It was,
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c?h=next-20221208#n498
We're not looking at the same thing, this patch adds a compatible
for 8150's mdss so that it can be matched as a client, not a
compatible for the SMMU itself (which itself has been merged
dinosaur years ago).

Konrad
> 
>>
>> Konrad
>>>
>>>
>>>>
>>>> Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
>>>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>>>> ---
>>>> Depends on the binding here:
>>>>
>>>> [1] https://lore.kernel.org/linux-arm-msm/20221212093315.11390-1-konrad.dybcio@linaro.org/T/#t
>>>>
>>>> drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 1 +
>>>> 1 file changed, 1 insertion(+)
>>>>
>>>> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
>>>> index 6610f5d2877d..cd74c1efcfde 100644
>>>> --- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
>>>> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
>>>> @@ -255,6 +255,7 @@ static const struct of_device_id qcom_smmu_client_of_match[] __maybe_unused = {
>>>> 	{ .compatible = "qcom,sdm845-mss-pil" },
>>>> 	{ .compatible = "qcom,sm6350-mdss" },
>>>> 	{ .compatible = "qcom,sm6375-mdss" },
>>>> +	{ .compatible = "qcom,sm8150-mdss" },
>>>> 	{ .compatible = "qcom,sm8250-mdss" },
>>>> 	{ }
>>>> };
>>>
> 
