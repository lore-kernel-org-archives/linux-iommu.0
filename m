Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EB827B
	for <iommu@lists.linux.dev>; Tue, 18 Oct 2022 10:21:13 +0000 (UTC)
Received: by mail-lf1-f45.google.com with SMTP id o12so13274499lfq.9
        for <iommu@lists.linux.dev>; Tue, 18 Oct 2022 03:21:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ImdG91jhrrzmS1iN+qqP32S8nYR25WcABr8VO01wMLk=;
        b=yHFx4Q46G6RvTWdcb1rp5JOFE9Xv4o0ty99a0EyRj4YZBa+lrTrk9Yswl1/oQdDCeT
         7riEj6qZxOMaPUH4TRGsfPUQ1N5FgT+ioO6XaIaqHgMVRBUKLAtRffZ/ZK3owqeZRCPH
         5nxt8NPm19upkoWczgQw3VO9pyEZjD2Ni+PKeTgbZSED1CbXl1EzoJQCsg3QrXhyLMpP
         wOJ4P01GUYkNreEARQeJ+NY3/HvsvNZ9xUltP4haaxo273+MS8hrrL94cFNfA5lOP2LF
         +rcmPLtFbghTLtZ6Ht5UQ/KcbpaoB+BTAcMQGv5x60GJy6LshQsPfv1zxAcggWXWMbAm
         VpZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ImdG91jhrrzmS1iN+qqP32S8nYR25WcABr8VO01wMLk=;
        b=gELVWxzvVj4uQlvgbNOmwMmYZsvfAObgKLW5kcLx55V6+LzqJ0ou57RUT4+H4OfrTF
         MLVmDCng9GqQRzYAfKxNrdpsycKnXCNXqSxp4NsChi4DKRmktbQV/Uhsv1ejFVV1aNGB
         qfFXu9RB2sJjrpkcnx7otFs3u1UVnZEP3Sah0fodny2eOkXYcEaSUsHOQ3tUiE3/KVt/
         v5lernM5+uZkdK9mUIR988ROyhQdoGma19qd3XglAnWhQdbQsXp4v25Cx4luJWQ8Aefs
         DGhOcd+mIE/hayMtyVEJHbWeqsMGP9/W1wSD2BKyiJfkRXvIhPTHxdypx57rVR6kaepq
         Xr1Q==
X-Gm-Message-State: ACrzQf2W+kWoAdxIj3TIkIodrHeIUWKGZOvGLN3lpr7VgMBbGr9EeRKk
	ihs9LOM7fYpfRq2bkrIBYMcr9A==
X-Google-Smtp-Source: AMsMyM4zOeVqtDuCEaldEcfm17Y13rZqma66cN/wUSr3RgVgVAWoxTMuB2OrZdEtpPYv2abkZPCZSA==
X-Received: by 2002:a05:6512:3e16:b0:4a2:5e01:87df with SMTP id i22-20020a0565123e1600b004a25e0187dfmr705855lfv.254.1666088471541;
        Tue, 18 Oct 2022 03:21:11 -0700 (PDT)
Received: from [10.10.15.130] ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id i23-20020a0565123e1700b00497a99e7b73sm1785080lfv.246.2022.10.18.03.21.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Oct 2022 03:21:11 -0700 (PDT)
Message-ID: <27ac4191-2082-4769-a1c2-057baed60554@linaro.org>
Date: Tue, 18 Oct 2022 13:21:10 +0300
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH 2/2] iommu: arm-smmu-qcom: add sdm670 compatible
Content-Language: en-GB
To: Konrad Dybcio <konrad.dybcio@somainline.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Richard Acayan <mailingradian@gmail.com>, linux-arm-msm@vger.kernel.org
Cc: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Joerg Roedel <joro@8bytes.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Sai Prakash Ranjan <quic_saipraka@quicinc.com>,
 Rob Clark <robdclark@chromium.org>, Sibi Sankar <sibis@codeaurora.org>,
 Loic Poulain <loic.poulain@linaro.org>, Vinod Koul <vkoul@kernel.org>,
 iommu@lists.linux.dev, devicetree@vger.kernel.org
References: <20220920223955.151507-1-mailingradian@gmail.com>
 <20220920223955.151507-3-mailingradian@gmail.com>
 <77b7d58f-ba85-86de-8635-6efbb1354a08@linaro.org>
 <5c25dc95-d7a4-0b15-5514-6fe3a48e899c@somainline.org>
 <f98ccf6b-34e7-d15f-63f9-928827b52eb8@somainline.org>
 <30980ac8-1386-d284-8452-fdc5b7da8343@linaro.org>
 <5f629a95-8ee4-7cf8-f471-0b50e311d3b7@somainline.org>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <5f629a95-8ee4-7cf8-f471-0b50e311d3b7@somainline.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 22/09/2022 00:14, Konrad Dybcio wrote:
> 
> 
> On 21.09.2022 21:05, Krzysztof Kozlowski wrote:
>> On 21/09/2022 20:48, Konrad Dybcio wrote:
>>>
>>>
>>> On 21.09.2022 20:47, Konrad Dybcio wrote:
>>>>
>>>>
>>>> On 21.09.2022 09:31, Krzysztof Kozlowski wrote:
>>>>> On 21/09/2022 00:39, Richard Acayan wrote:
>>>>>> The Snapdragon 670 needs the IOMMU for GENI I2C. Add a compatible string to
>>>>>> support it.
>>>>>>
>>>>>> Signed-off-by: Richard Acayan <mailingradian@gmail.com>
>>>>>> ---
>>>>>>   drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 1 +
>>>>>>   1 file changed, 1 insertion(+)
>>>>>>
>>>>>> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
>>>>>> index b2708de25ea3..bf9653b9eb89 100644
>>>>>> --- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
>>>>>> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
>>>>>> @@ -431,6 +431,7 @@ static const struct of_device_id __maybe_unused qcom_smmu_impl_of_match[] = {
>>>>>>   	{ .compatible = "qcom,sc8180x-smmu-500" },
>>>>>>   	{ .compatible = "qcom,sc8280xp-smmu-500" },
>>>>>>   	{ .compatible = "qcom,sdm630-smmu-v2" },
>>>>>> +	{ .compatible = "qcom,sdm670-smmu-500" },
>>>>>
>>>>> Why do we keep adding compatibles to the driver for apparently
>>>>> compatible devices?
>>>>
>>>> Because Linux has not funny run on bare Qualcomm hardware ever since at least msm8x60 times and
>>> s/funny/fully
>>>
>>> unfortunate typo, this is not funny, quite the contrary..
>>>
>>> Konrad
>>>> we are not interacting with real hardware, only with Qualcomm's flawed virtual implementation
>>>> of it, that's abstracted to us through various generations of their saddening software stack. This
>>>> is also the case for many more standard components, even as far as the GIC on recent boards..
>>
>> Unfortunately I don't get this explanation... you mean some other
>> firmware requires Linux drivers to use specific compatibles instead of
>> one fallback?
> No, perhaps I misunderstood you.
> 
>>
>> All of these do not have driver data, so they are essentially compatible
>> for Linux driver. Growing this list in the driver seems pointless. What
>> is the benefit of growing driver with same entries, except more patches?
> Compatible lists in smmu-impl files allow matching driver quirks for SMMUs themselves
> and consumer devices (such as MDSS). The situation is more complicated, because some
> qcom SMMUs also require more quirks than others (think 8974 vs 8994 vs 8996/pro&660&8998
> vs 845+ vs adreno smmu in various flavours), so all qcom SMMUs need to use
> `qcom_smmu_impl` and some others need even more quirks on top of that (that generally
> hurt performance or functionality, so we don't want them when they're unnecessary).
> If all generations of qcom SMMU implementation that bear the same name behaved anywhere
> near consistent, there would be no need for keeping this around, instead requiring only
> "qcom,broken-smmu" or something".

Excuse me for bumping this thread, I successfully forgot this message in 
drafts folder.

Granted the driver, your pending smmu patches and the current list of 
quirks (which includes qcom,msm8996-smmu-v2 and qcom,sdm845-smmu-500, 
and Konrad's unmerged quirks for -v2), I'd second the suggestion of 
adding a single qcom,msm-smmu-500 (or qcom,arm-smmu-500) entry as a 
generic fallback. Downstream device trees support this name by using the 
-v500 suffix (yes, it's a light argument, but still). This way we can 
apply SoC-specific quirks, while still retaining the generic entry here.

What's definitely has to be done is the merge of the platform data from 
arm-smmu-qcom-debug.c into arm-smmu-qcom.c. And having identical entries 
there just drives me crazy. I'll work on a patch later today.

For -v2 we already have the generic compat, however granted the lack of 
proper quirks in place, I'd abstain from reworking this part for now.

BTW: I'm trying to follow the commit a242f4297cfe ("iommu/arm-smmu-qcom: 
Skip the TTBR1 quirk for db820c."). It adds msm8996-specific quirk, but 
we lack the msm8996 compat entry in the array. Does this work at all?

> 
> Konrad
>>
>> Best regards,
>> Krzysztof
>>

-- 
With best wishes
Dmitry

