Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3EEB7C
	for <iommu@lists.linux.dev>; Wed, 21 Sep 2022 19:05:09 +0000 (UTC)
Received: by mail-lf1-f47.google.com with SMTP id o2so10770129lfc.10
        for <iommu@lists.linux.dev>; Wed, 21 Sep 2022 12:05:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=gxyg5lejj145RAw8dOJUoYM2aA2Z4E6jQKaU5KUCwOA=;
        b=W7Yfd1ZATmMA7G1YK2gicGgV50uVo80uAOamqpGLjJEfhS1JRCNX9x8Y5KB0GQtpQk
         OVYR+g06bW/CBZDLyjzVL6l4cbSTQotfPxEMjXDUyzgeg6GeFUDqWRoPHyeEbBFqWRhP
         lXAu0/VecfTT8AqoFyKGwhrghhqdgcVqnNPf9OYmh8zCYgU98jEh3tRoxBzzY4+xEckI
         q+2Q0mH08bP91Ch7G7adxkV3hfLTi8w9omLYQ/dPm9qc9VXHjsn4E9uJtczEnspOqeNl
         gqRyq6hST2mEs0icD64kpPF3ytj2O9l3gEwD9sQvSFq10D+vK/hwVDxED2nzZ0M/htJK
         K0wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=gxyg5lejj145RAw8dOJUoYM2aA2Z4E6jQKaU5KUCwOA=;
        b=Zu6/TVJHpqaNjbQOJav61gmI8MBqQed4JH7XQ2TO1FB+QAPu+uNhO63u85ITD8epEM
         flioiPh5/0THP9Oh5oc2FTHb7GeDjy7xBpsO+MZyXtI0LIkSddMTbUHACT+oSF7TX5mN
         0yOPnE0+Fs5yyKebK9tri7By0gvaIKKMPSViP4cPor41MWC3Ko7BGFtWs4wK63WIZjIV
         +X+XrLOvfhsSlxIiixLKkwOhmIQjatYlw4Cj8J/BHUb9G7rRQpfvYvEtyrW68bGxfuqh
         qsDGuaxRlvIrH0pEw9a9nWEWh3QuQRhgCYp/lxWwaQAr1vak53th6jLx4avtEONAZZ9u
         wHMg==
X-Gm-Message-State: ACrzQf1KAcBWAhCFz75R96tN3rg6foItyHCcubOK/r7sEu/bEhjeGRgG
	qE3x7gZ1kU2zYLYumTBk+laPxg==
X-Google-Smtp-Source: AMsMyM5H0SLOaDb4+Kn3R9mauXInzsOlfG1UxxCRVwrSauSrBw1qESQrhRRTmBu7Moy0Shv2Jikk0w==
X-Received: by 2002:a19:5f4f:0:b0:49f:543b:190e with SMTP id a15-20020a195f4f000000b0049f543b190emr9868333lfj.547.1663787107834;
        Wed, 21 Sep 2022 12:05:07 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id o4-20020a198c04000000b0049f54a976efsm559227lfd.29.2022.09.21.12.05.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Sep 2022 12:05:06 -0700 (PDT)
Message-ID: <30980ac8-1386-d284-8452-fdc5b7da8343@linaro.org>
Date: Wed, 21 Sep 2022 21:05:05 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 2/2] iommu: arm-smmu-qcom: add sdm670 compatible
Content-Language: en-US
To: Konrad Dybcio <konrad.dybcio@somainline.org>,
 Richard Acayan <mailingradian@gmail.com>, linux-arm-msm@vger.kernel.org
Cc: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Joerg Roedel <joro@8bytes.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Sai Prakash Ranjan <quic_saipraka@quicinc.com>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Rob Clark <robdclark@chromium.org>, Sibi Sankar <sibis@codeaurora.org>,
 Loic Poulain <loic.poulain@linaro.org>, Vinod Koul <vkoul@kernel.org>,
 iommu@lists.linux.dev, devicetree@vger.kernel.org
References: <20220920223955.151507-1-mailingradian@gmail.com>
 <20220920223955.151507-3-mailingradian@gmail.com>
 <77b7d58f-ba85-86de-8635-6efbb1354a08@linaro.org>
 <5c25dc95-d7a4-0b15-5514-6fe3a48e899c@somainline.org>
 <f98ccf6b-34e7-d15f-63f9-928827b52eb8@somainline.org>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <f98ccf6b-34e7-d15f-63f9-928827b52eb8@somainline.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 21/09/2022 20:48, Konrad Dybcio wrote:
> 
> 
> On 21.09.2022 20:47, Konrad Dybcio wrote:
>>
>>
>> On 21.09.2022 09:31, Krzysztof Kozlowski wrote:
>>> On 21/09/2022 00:39, Richard Acayan wrote:
>>>> The Snapdragon 670 needs the IOMMU for GENI I2C. Add a compatible string to
>>>> support it.
>>>>
>>>> Signed-off-by: Richard Acayan <mailingradian@gmail.com>
>>>> ---
>>>>  drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 1 +
>>>>  1 file changed, 1 insertion(+)
>>>>
>>>> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
>>>> index b2708de25ea3..bf9653b9eb89 100644
>>>> --- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
>>>> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
>>>> @@ -431,6 +431,7 @@ static const struct of_device_id __maybe_unused qcom_smmu_impl_of_match[] = {
>>>>  	{ .compatible = "qcom,sc8180x-smmu-500" },
>>>>  	{ .compatible = "qcom,sc8280xp-smmu-500" },
>>>>  	{ .compatible = "qcom,sdm630-smmu-v2" },
>>>> +	{ .compatible = "qcom,sdm670-smmu-500" },
>>>
>>> Why do we keep adding compatibles to the driver for apparently
>>> compatible devices?
>>
>> Because Linux has not funny run on bare Qualcomm hardware ever since at least msm8x60 times and
> s/funny/fully
> 
> unfortunate typo, this is not funny, quite the contrary..
> 
> Konrad
>> we are not interacting with real hardware, only with Qualcomm's flawed virtual implementation
>> of it, that's abstracted to us through various generations of their saddening software stack. This
>> is also the case for many more standard components, even as far as the GIC on recent boards..

Unfortunately I don't get this explanation... you mean some other
firmware requires Linux drivers to use specific compatibles instead of
one fallback?

All of these do not have driver data, so they are essentially compatible
for Linux driver. Growing this list in the driver seems pointless. What
is the benefit of growing driver with same entries, except more patches?

Best regards,
Krzysztof

