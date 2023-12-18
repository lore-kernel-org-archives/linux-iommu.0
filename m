Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DE45129EF7
	for <iommu@lists.linux.dev>; Mon, 18 Dec 2023 14:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DyHq1XKk"
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-50e24e92432so2484232e87.2
        for <iommu@lists.linux.dev>; Mon, 18 Dec 2023 06:21:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702909262; x=1703514062; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XYPn4ya7qFbk7yQY6PKhNIBQN/8dCYyU7fSVPxboeUI=;
        b=DyHq1XKkTz82/uBSIXxfp9HN2zRYdeZISVUUuPOrRoELxttsuTCshAUKvUieYkF72h
         ABmTadN4sfYu++IJZjHYCYw1gBNNXLYo89GRHyjbSBB4DKXZM2+EWe8+TIDN5HxyG/MM
         tQMEdNG54mISrFDfiHZqsQ21DIZCuZZqIdww6xR7CEcm3uRJ4UVI3Lvndm30vWyod9V2
         YyeUFCD5khm05MFuH46JjlDXIlVPu47f6qQLX18IpH5odSM+KEprWxxw4UGQOLB6+zmK
         LPfeKEP9km1CLxZhzaYpDsx/w9lK/qSxvfOgGYHdDMTJHHooJDipBZbKb31MNix1BVEN
         4sag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702909262; x=1703514062;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XYPn4ya7qFbk7yQY6PKhNIBQN/8dCYyU7fSVPxboeUI=;
        b=U4tGrGnkjd0WJASecFvvnvOAeZX4VIeJuqKns06HzJ8wLYCASlxj0CUYzZZjJjbJO4
         OvMzFeHCWI2ivqbbCQMGFMLuGlL88KQOeKyDjfgYdyJgdGi9fqWZr8ex8y2JGf6rYbxp
         G6E09MT8efEyJGZdi53zJAzrAknzie9FhGsRcJQz9sEgRwlIWMzAGnQlQU5CoxCQydJU
         qAKXF97UYywhf88UhHexf/bZ+o6PshUfdiKc2DJzMrGDR483TFdQyE+Kpc6qoRJZ+43i
         IVxQaziLLqPDA52soDi4m4XKDlac0Hcmh6rLIejPoa9fsGAq8qn4koFwFQhbIJrO6hxP
         1bMg==
X-Gm-Message-State: AOJu0Yz5/TH2xnYIYYq45ith8XgpXsQ1fQO5G6jcxAEK9LD6dkDKYYPr
	d8phzFCr0dKUugD8idL6CI9c9Q==
X-Google-Smtp-Source: AGHT+IFtF2Ij+LCFr4dFhD0WTaFZ0SmLLCLrmudrPhSNTXFeEUXTKQlpjj6wvW3CXydHO0QCXe1psw==
X-Received: by 2002:a05:6512:3d11:b0:50e:3df2:c7c0 with SMTP id d17-20020a0565123d1100b0050e3df2c7c0mr672654lfv.21.1702909261958;
        Mon, 18 Dec 2023 06:21:01 -0800 (PST)
Received: from ?IPV6:2001:14ba:a0db:1f00::227? (dzdqv0yyyyyyyyyyyykxt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::227])
        by smtp.gmail.com with ESMTPSA id dw12-20020a0565122c8c00b0050d0b4fc22esm2889485lfb.185.2023.12.18.06.21.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Dec 2023 06:21:01 -0800 (PST)
Message-ID: <8338db1e-0216-4fc5-b6ab-ddf43adf3648@linaro.org>
Date: Mon, 18 Dec 2023 16:21:00 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/5] iommu/arm-smmu: add ACTLR data and support for
 SM8550
Content-Language: en-GB
To: Bibek Kumar Patro <quic_bibekkum@quicinc.com>,
 Konrad Dybcio <konrad.dybcio@linaro.org>, Robin Murphy <robin.murphy@arm.com>
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
 <42d627af-164b-4b50-973e-fa71d86cb84c@linaro.org>
 <aa8b2ccd-33da-404b-9a93-3d88cf63ec77@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <aa8b2ccd-33da-404b-9a93-3d88cf63ec77@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 18/12/2023 13:23, Bibek Kumar Patro wrote:
> 
> 
> On 12/16/2023 9:45 PM, Dmitry Baryshkov wrote:
>> On 16/12/2023 02:03, Konrad Dybcio wrote:
>>> On 15.12.2023 13:54, Robin Murphy wrote:
>>>> On 2023-12-15 12:20 pm, Bibek Kumar Patro wrote:
>>>>>
>>>>>
>>>>> On 12/15/2023 4:14 PM, Dmitry Baryshkov wrote:
>>>>>> On Fri, 15 Dec 2023 at 12:19, Bibek Kumar Patro
>>>>>> <quic_bibekkum@quicinc.com> wrote:
>>>>>>>
>>>>>>> Add ACTLR data table for SM8550 along with support for
>>>>>>> same including SM8550 specific implementation operations.
>>>>>>>
>>>>>>> Signed-off-by: Bibek Kumar Patro <quic_bibekkum@quicinc.com>
>>>>>>> ---
>>>>>>>    drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 89 
>>>>>>> ++++++++++++++++++++++
>>>>>>>    1 file changed, 89 insertions(+)
>>>>>>>
>>>>>>> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c 
>>>>>>> b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
>>>>>>> index cb49291f5233..d2006f610243 100644
>>>>>>> --- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
>>>>>>> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
>>>>>>> @@ -20,6 +20,85 @@ struct actlr_config {
>>>>>>>           u32 actlr;
>>>>>>>    };
>>>>>>>
>>>>>>> +/*
>>>>>>> + * SMMU-500 TRM defines BIT(0) as CMTLB (Enable context caching 
>>>>>>> in the
>>>>>>> + * macro TLB) and BIT(1) as CPRE (Enable context caching in the 
>>>>>>> prefetch
>>>>>>> + * buffer). The remaining bits are implementation defined and 
>>>>>>> vary across
>>>>>>> + * SoCs.
>>>>>>> + */
>>>>>>> +
>>>>>>> +#define PREFETCH_DEFAULT       0
>>>>>>> +#define PREFETCH_SHALLOW       BIT(8)
>>>>>>> +#define PREFETCH_MODERATE      BIT(9)
>>>>>>> +#define PREFETCH_DEEP          (BIT(9) | BIT(8))
>>>>>>
>>>>>> I thin the following might be more correct:
>>>>>>
>>>>>> #include <linux/bitfield.h>
>>>>>>
>>>>>> #define PREFETCH_MASK GENMASK(9, 8)
>>>>>> #define PREFETCH_DEFAULT FIELD_PREP(PREFETCH_MASK, 0)
>>>>>> #define PREFETCH_SHALLOW FIELD_PREP(PREFETCH_MASK, 1)
>>>>>> #define PREFETCH_MODERATE FIELD_PREP(PREFETCH_MASK, 2)
>>>>>> #define PREFETCH_DEEP FIELD_PREP(PREFETCH_MASK, 3)
>>>>>>
>>>>>
>>>>> Ack, thanks for this suggestion. Let me try this out using
>>>>> GENMASK. Once tested, will take care of this in next version.
>>>>
>>>> FWIW the more typical usage would be to just define the named macros 
>>>> for the raw field values, then put the FIELD_PREP() at the point of 
>>>> use. However in this case that's liable to get pretty verbose, so 
>>>> although I'm usually a fan of bitfield.h, the most readable option 
>>>> here might actually be to stick with simpler definitions of "(0 << 
>>>> 8)", "(1 << 8)", etc. However it's not really a big deal either way, 
>>>> and I defer to whatever Dmitry and Konrad prefer, since they're the 
>>>> ones looking after arm-smmu-qcom the most :)
>>> My 5 cents would be to just use the "common" style of doing this, so:
>>>
>>> #define ACTRL_PREFETCH    GENMASK(9, 8)
>>>   #define PREFETCH_DEFAULT 0
>>>   #define PREFETCH_SHALLOW 1
>>>   #define PREFETCH_MODERATE 2
>>>   #define PREFETCH_DEEP 3
>>>
>>> and then use
>>>
>>> | FIELD_PREP(ACTRL_PREFETCH, PREFETCH_x)
>>>
>>> it can get verbose, but.. arguably that's good, since you really want
>>> to make sure the right bits are set here
>>
>> Sounds good to me.
>>
> 
> Konrad, Dimitry, just checked FIELD_PREP() implementation
> 
> #define FIELD_FIT(_mask, _val)
> ({                                                              \
>                   __BF_FIELD_CHECK(_mask, 0ULL, _val, "FIELD_PREP: ");  \
>                   ((typeof(_mask))(_val) << __bf_shf(_mask)) & (_mask); \
> })
> 
> since it is defined as a block, it won't be possible to use FIELD_PREP
> in macro or as a structure value, and can only be used inside a 
> block/function. Orelse would show compilation errors as following
> 
> kernel/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c:94:20: note: in 
> expansion of macro 'PREFETCH_SHALLOW'
>    { 0x1947, 0x0000, PREFETCH_SHALLOW | CPRE | CMTLB },
>                      ^
> kernel/include/linux/bitfield.h:113:2: error: braced-group within 
> expression allowed only inside a function
>    ({        \
>    ^
> 
> So as per my understanding I think, we might need to go ahead with the
> generic implementation only. Let me know if I missed something.

Then anyway (foo << bar) is better compared to BIT(n) | BIT(m).

-- 
With best wishes
Dmitry

