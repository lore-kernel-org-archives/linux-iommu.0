Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D7143BB57
	for <iommu@lists.linux.dev>; Wed, 15 Nov 2023 16:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NMVWqR96"
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-507a29c7eefso9828292e87.1
        for <iommu@lists.linux.dev>; Wed, 15 Nov 2023 08:42:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700066522; x=1700671322; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=u5FiyfL45nK0ILrQvVCbcGAZ+fU64odztAJCZA6s8wQ=;
        b=NMVWqR96UTd0w1Lrmn8xNE8bB0xbPiSscnzzsMzHUeghTs8IUXzXMPcR+Enibl5kgJ
         k+5tqjN+luCj7GEigDjuJXiNnQySYqdocufL6f7R71D+QZcNS4HQvebi/suRl0xZ1DDd
         f+6ml7T7jt0ai2E4aN7/TWgMY4m5dLgKnr++dp2saicXgASUF6gDC3QpB2roTVXeksjB
         6WKF4ephFa55K3W/5i8jVPbEUoFtUvLtqE5tQ+7UyVf9qrWzcF/x0FPPTx2yEDZfxVJr
         K+E6ixyFOqTVlOYIS5BwCWX6vKFnZoeVSlq/7N+Pck6HO3nEi/q1fOAKV9oA29OTYmyk
         fRdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700066522; x=1700671322;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u5FiyfL45nK0ILrQvVCbcGAZ+fU64odztAJCZA6s8wQ=;
        b=dMMNyUOXKcs0uFZ0u+QlrJf+u60sjbG50irPixiknTPLHMFJF2CtZ9wgTeI7O9+Ho8
         sF4j5k2N98uxavRbJ5SO0kklJq4NKVz3n0P6sdMfPp2991hSo/qgtZHNRhWUEeajtjBf
         F5hV483bnwThoTNeRGhEYKSX8zCVitk8qsTB5x6V2HEUw6IJ62Lc3JswezAVzZhhoasW
         4M+N5vYbfYlI50HRtf06jRHYImfORUVe4ef6rCmcD41K5bCrx1ftg9czQkfM58YyYe33
         Z/35xQylEknbXLkwyZz6v/e4ReIBDTD8x/5xRIGsRACrRVQUSTDVd5q/0iz18dabQEFP
         MDwg==
X-Gm-Message-State: AOJu0Yw25Y//XxFiJzu7XDY6BgvK39MV4+naZCQzux9RoY0bGgEZz85P
	7FLKjVkZLjBW1ztsorRmG6C/Hw==
X-Google-Smtp-Source: AGHT+IFWMZo39Dt217xz3YvNvg1OMFxweVuoh5j1w9Sgi0b6RPHP9gLOt/PkYJVEHjLB5ztGS8bf8Q==
X-Received: by 2002:a05:6512:234d:b0:508:268b:b087 with SMTP id p13-20020a056512234d00b00508268bb087mr11812039lfu.26.1700066522540;
        Wed, 15 Nov 2023 08:42:02 -0800 (PST)
Received: from [172.30.204.150] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id d27-20020a19385b000000b0050a026d3a26sm1705739lfj.227.2023.11.15.08.42.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Nov 2023 08:42:01 -0800 (PST)
Message-ID: <be9675a6-a01e-4cf7-95b3-174220d4a042@linaro.org>
Date: Wed, 15 Nov 2023 17:42:00 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] iommu/arm-smmu: add ACTLR data and support for
 SM8550
Content-Language: en-US
To: Bibek Kumar Patro <quic_bibekkum@quicinc.com>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: will@kernel.org, robin.murphy@arm.com, joro@8bytes.org,
 a39.skl@gmail.com, quic_pkondeti@quicinc.com, quic_molvera@quicinc.com,
 linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 qipl.kernel.upstream@quicinc.com
References: <20231114135654.30475-1-quic_bibekkum@quicinc.com>
 <20231114135654.30475-3-quic_bibekkum@quicinc.com>
 <CAA8EJpr1NzqiuNVZ0YcLpJ=yeOYFbLouAFgN9VMOiKpmoGVdtQ@mail.gmail.com>
 <7edad996-f148-42d5-8e72-0334d3b9101f@quicinc.com>
 <CAA8EJpqzEvC-LEjJrOk6Ed8utFNnqgP=qkb0mq-dOfMZd5ij4Q@mail.gmail.com>
 <dba223a1-0456-40b8-b295-ea960867dcf9@quicinc.com>
 <CAA8EJpqvXb_Zdmq0O0KEA8mn5UkSriCZ02w16dts7Gd84R30oQ@mail.gmail.com>
 <aebdf7f6-48b7-43d3-95af-83859ddc593f@quicinc.com>
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <aebdf7f6-48b7-43d3-95af-83859ddc593f@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 11/15/23 13:49, Bibek Kumar Patro wrote:
> 
> 
> On 11/15/2023 4:15 PM, Dmitry Baryshkov wrote:
>> On Wed, 15 Nov 2023 at 11:51, Bibek Kumar Patro
>> <quic_bibekkum@quicinc.com> wrote:
>>>
>>>
>>>
>>> On 11/15/2023 3:08 PM, Dmitry Baryshkov wrote:
>>>> On Wed, 15 Nov 2023 at 11:22, Bibek Kumar Patro
>>>> <quic_bibekkum@quicinc.com> wrote:
>>>>>
>>>>>
>>>>>
>>>>> On 11/14/2023 7:42 PM, Dmitry Baryshkov wrote:
>>>>>> On Tue, 14 Nov 2023 at 15:57, Bibek Kumar Patro
>>>>>> <quic_bibekkum@quicinc.com> wrote:
>>>>>>>
>>>>>>> Add ACTLR data table for SM8550 along with support for
>>>>>>> same including SM8550 specific implementation operations.
>>>>>>>
>>>>>>> Signed-off-by: Bibek Kumar Patro <quic_bibekkum@quicinc.com>
>>>>>>> ---
>>>>>>>     drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 92 +++++++++++++++++++++-
>>>>>>>     1 file changed, 88 insertions(+), 4 deletions(-)
>>>>>>>
>>>>>>> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
>>>>>>> index 578c662c7c30..0eaf6f2a2e49 100644
>>>>>>> --- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
>>>>>>> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
>>>>>>> @@ -25,6 +25,70 @@ struct actlr_data {
>>>>>>>            u32 actlr;
>>>>>>>     };
>>>>>>>
>>>>>>> +#define PRE_FETCH_1    0
>>>>>>> +#define PRE_FETCH_2    BIT(8)
>>>>>>> +#define PRE_FETCH_3    (BIT(9) | BIT(8))
>>>>>>
>>>>>> What is the difference between PRE_FETCH_3 and PRE_FETCH_2? And
>>>>>> PRE_FETCH_1? Are these real numbers that refer to some amount / count
>>>>>> or just dummy names?
>>>>>>
>>>>>
>>>>> No,these are not real numbers, but prefetch settings for a particular
>>>>> perfect configuration.
>>>>
>>>> Then I'd ask for some better names or descriptions.
>>>>
>>>
>>> Noted, PREFETCH_SETTING_n / PREFETCH_OPTION_n sounds like a better name
>>> in the following case. Would it be okay to use this name instead?
>>
>> Not really.
>>
> 
> Any suggestion you have in mind, if not this nomenclature?
Dmitry's concern seems to be that you provide:

PRE_FETCH_1 /* prefetcher with settings preset no. 1 */
PRE_FETCH_2 /* prefetcher with settings preset no. 2 */
PRE_FETCH_3 /* prefetcher with settings preset no. 3 */

whereas it would be both useful and interesting to see what these
settings mean, i.e. what differences there are between all of
these presets.

Konrad
