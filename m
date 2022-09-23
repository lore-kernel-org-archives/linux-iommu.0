Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D93884687
	for <iommu@lists.linux.dev>; Fri, 23 Sep 2022 22:24:44 +0000 (UTC)
Received: by mail-il1-f172.google.com with SMTP id a4so847835ilj.8
        for <iommu@lists.linux.dev>; Fri, 23 Sep 2022 15:24:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=sZegk7zG1/iwQ6jNiV8eKrKSA5CJhrOD6RblkDq3hTg=;
        b=E4GfFcE7mti7p+9wlmaZJgBmlTcuMFnbLkh/+fg+cjgKn0e4fF+miDpmXjHDgchotG
         G3Y/OY5ZI3Tb2FfSFdSz+E7/r5xZFftfuF19k2rJNtmrfmz4sFzonNJ7+St2iRbuldBF
         MKLyA2kMOkDe1sbHvSER/4LUFcGIZr9zDzprILv2qbJyv93Xaf8EXE4u7I7f2KfEGkAb
         JwbOaWxQHnzqHG/2qFj5FlsqqIH0V4mTwdUW9hOgqZ4NtPGkAjJkVSCsKUzXG5DWqOXk
         1xiz/+i7hfHk62hQx9D+xw1ywmK7UrMhTizNBznKwP0DdgemdaO/few0APhvRdsD8CUc
         T2sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=sZegk7zG1/iwQ6jNiV8eKrKSA5CJhrOD6RblkDq3hTg=;
        b=bFdlyskOF33Yra4zQExtxQuGnyOzXjHKTJBw3socExe7E6mva4kmIfG6M80K0UTR73
         SNlSLy+ftvPClUe2e0QBIGch8FKgBEWeEzLCRRK0slRYxaRTmv6o8UglQCWh/gRcebSx
         9wUaUwGozUB6IwcyWrcIOp+JcS97syX6a3xP0ylRR8ef+klUPFIQMRrnoBvS7WNjCh1S
         tWHnfeUfC8sFzWcy+NNdOc89TEVFNbkQtOaTkmsJ5Eg+BgDOnkGDrQ14EcHBcYx0obaC
         CsVKmPPbocj607ovawcMVh7RMcvAb6o8szyzMMnPzLX5NktbI292z7ePw+YkN23kN/3K
         JB3w==
X-Gm-Message-State: ACrzQf02XtlYCjbcx6SeFsuzVu3svVkU+3wZkBbq/Bt9hKvDTQ53jzZP
	yNsxW8qXruQvNPiT1t8bf8M=
X-Google-Smtp-Source: AMsMyM5saX5cU4V2YkE3B/16osply4mzT4L3u82IMrfy33R1ZkZJOKHmiWAQpRqXUl7R/EI+RFkSoA==
X-Received: by 2002:a05:6e02:1a87:b0:2f1:dc7a:c512 with SMTP id k7-20020a056e021a8700b002f1dc7ac512mr5232787ilv.146.1663971883815;
        Fri, 23 Sep 2022 15:24:43 -0700 (PDT)
Received: from localhost ([2607:fea8:a2e2:2d00::1eda])
        by smtp.gmail.com with UTF8SMTPSA id f4-20020a05660215c400b00688faad4741sm3989923iow.24.2022.09.23.15.24.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Sep 2022 15:24:43 -0700 (PDT)
From: Richard Acayan <mailingradian@gmail.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc: linux-arm-msm@vger.kernel.org,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>,
	Rob Herring <robh+dt@kernel.org>,
	Konrad Dybcio <konrad.dybcio@somainline.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Sai Prakash Ranjan <quic_saipraka@quicinc.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Rob Clark <robdclark@chromium.org>,
	Sibi Sankar <sibis@codeaurora.org>,
	Loic Poulain <loic.poulain@linaro.org>,
	Vinod Koul <vkoul@kernel.org>,
	iommu@lists.linux.dev,
	devicetree@vger.kernel.org,
	Richard Acayan <mailingradian@gmail.com>
Subject: Re: [PATCH 2/2] iommu: arm-smmu-qcom: add sdm670 compatible
Date: Fri, 23 Sep 2022 18:24:41 -0400
Message-Id: <20220923222441.285033-1-mailingradian@gmail.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <f6c8e1d4-54bd-811c-7322-375f755ad460@linaro.org>
References: <5f629a95-8ee4-7cf8-f471-0b50e311d3b7@somainline.org> <20220922023833.178076-1-mailingradian@gmail.com> <be7a2f12-d6bb-8193-2a56-c31e57f11ce6@linaro.org> <22acebd5-b900-9abd-67e6-522c351da342@somainline.org> <f6c8e1d4-54bd-811c-7322-375f755ad460@linaro.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> On 22/09/2022 12:48, Konrad Dybcio wrote:
>> 
>> 
>> On 22.09.2022 08:41, Krzysztof Kozlowski wrote:
>>> On 22/09/2022 04:38, Richard Acayan wrote:
>>>>> On 21.09.2022 21:05, Krzysztof Kozlowski wrote:
>>>>>> On 21/09/2022 20:48, Konrad Dybcio wrote:
>>>>>>>
>>>>>>>
>>>>>>> On 21.09.2022 20:47, Konrad Dybcio wrote:
>>>>>>>>
>>>>>>>>
>>>>>>>> On 21.09.2022 09:31, Krzysztof Kozlowski wrote:
>>>>>>>>> On 21/09/2022 00:39, Richard Acayan wrote:
>>>>>>>>>> The Snapdragon 670 needs the IOMMU for GENI I2C. Add a compatible string to
>>>>>>>>>> support it.
>>>>>>>>>>
>>>>>>>>>> Signed-off-by: Richard Acayan <mailingradian@gmail.com>
>>>>>>>>>> ---
>>>>>>>>>>  drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 1 +
>>>>>>>>>>  1 file changed, 1 insertion(+)
>>>>>>>>>>
>>>>>>>>>> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
>>>>>>>>>> index b2708de25ea3..bf9653b9eb89 100644
>>>>>>>>>> --- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
>>>>>>>>>> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
>>>>>>>>>> @@ -431,6 +431,7 @@ static const struct of_device_id __maybe_unused qcom_smmu_impl_of_match[] = {
>>>>>>>>>>  	{ .compatible = "qcom,sc8180x-smmu-500" },
>>>>>>>>>>  	{ .compatible = "qcom,sc8280xp-smmu-500" },
>>>>>>>>>>  	{ .compatible = "qcom,sdm630-smmu-v2" },
>>>>>>>>>> +	{ .compatible = "qcom,sdm670-smmu-500" },
>>>>>>>>>
>>>>>>>>> Why do we keep adding compatibles to the driver for apparently
>>>>>>>>> compatible devices?
>>>>>>>>
>>>>>>>> Because Linux has not funny run on bare Qualcomm hardware ever since at least msm8x60 times and
>>>>>>> s/funny/fully
>>>>>>>
>>>>>>> unfortunate typo, this is not funny, quite the contrary..
>>>>>>>
>>>>>>> Konrad
>>>>>>>> we are not interacting with real hardware, only with Qualcomm's flawed virtual implementation
>>>>>>>> of it, that's abstracted to us through various generations of their saddening software stack. This
>>>>>>>> is also the case for many more standard components, even as far as the GIC on recent boards..
>>>>>>
>>>>>> Unfortunately I don't get this explanation... you mean some other
>>>>>> firmware requires Linux drivers to use specific compatibles instead of
>>>>>> one fallback?
>>>>> No, perhaps I misunderstood you.
>>>>>
>>>>>>
>>>>>> All of these do not have driver data, so they are essentially compatible
>>>>>> for Linux driver. Growing this list in the driver seems pointless. What
>>>>>> is the benefit of growing driver with same entries, except more patches?
>>>>> Compatible lists in smmu-impl files allow matching driver quirks for SMMUs themselves
>>>>> and consumer devices (such as MDSS). The situation is more complicated, because some
>>>>> qcom SMMUs also require more quirks than others (think 8974 vs 8994 vs 8996/pro&660&8998
>>>>> vs 845+ vs adreno smmu in various flavours), so all qcom SMMUs need to use
>>>>> `qcom_smmu_impl` and some others need even more quirks on top of that (that generally
>>>>> hurt performance or functionality, so we don't want them when they're unnecessary).
>>>>> If all generations of qcom SMMU implementation that bear the same name behaved anywhere
>>>>> near consistent, there would be no need for keeping this around, instead requiring only
>>>>> "qcom,broken-smmu" or something".
>>>>
>>>> Hi, just stopping by to share my own thoughts.
>>>>
>>>> First, I don't mind if this series doesn't get applied as-is. After seeing
>>>> the eMMC driver in its current state:
>>>>
>>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/mmc/host/sdhci-msm.c?h=v6.0-rc6#n2437
>>>>
>>>> I can understand that the devicetree maintainers don't want to see new SoCs
>>>> touching drivers unnecessarily. Second, I don't see enough quirks to
>>>> justify needing all compatible strings in the driver (2 quirky SoCs
>>>> compared to 16 total not counting adreno iommu):
>>>>
>>>>     $ grep qcom, drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
>>>>     	if (of_device_is_compatible(np, "qcom,msm8996-smmu-v2"))
>>>>     	* All targets that use the qcom,adreno-smmu compatible string *should*
>>>>     	{ .compatible = "qcom,adreno" },
>>>>     	{ .compatible = "qcom,mdp4" },
>>>>     	{ .compatible = "qcom,mdss" },
>>>>     	{ .compatible = "qcom,sc7180-mdss" },
>>>>     	{ .compatible = "qcom,sc7180-mss-pil" },
>>>>     	{ .compatible = "qcom,sc7280-mdss" },
>>>>     	{ .compatible = "qcom,sc7280-mss-pil" },
>>>>     	{ .compatible = "qcom,sc8180x-mdss" },
>>>>     	{ .compatible = "qcom,sm8250-mdss" },
>>>>     	{ .compatible = "qcom,sdm845-mdss" },
>>>>     	{ .compatible = "qcom,sdm845-mss-pil" },
>>>>     	if (of_device_is_compatible(np, "qcom,sdm845-smmu-500"))
>>>>     	{ .compatible = "qcom,msm8998-smmu-v2" },
>>>>     	{ .compatible = "qcom,qcm2290-smmu-500" },
>>>>     	{ .compatible = "qcom,sc7180-smmu-500" },
>>>>     	{ .compatible = "qcom,sc7280-smmu-500" },
>>>>     	{ .compatible = "qcom,sc8180x-smmu-500" },
>>>>     	{ .compatible = "qcom,sc8280xp-smmu-500" },
>>>>     	{ .compatible = "qcom,sdm630-smmu-v2" },
>>>>     	{ .compatible = "qcom,sdm670-smmu-500" },
>>>>     	{ .compatible = "qcom,sdm845-smmu-500" },
>>>>     	{ .compatible = "qcom,sm6125-smmu-500" },
>>>>     	{ .compatible = "qcom,sm6350-smmu-500" },
>>>>     	{ .compatible = "qcom,sm6375-smmu-500" },
>>>>     	{ .compatible = "qcom,sm8150-smmu-500" },
>>>>     	{ .compatible = "qcom,sm8250-smmu-500" },
>>>>     	{ .compatible = "qcom,sm8350-smmu-500" },
>>>>     	{ .compatible = "qcom,sm8450-smmu-500" },
>>>>     	if (of_device_is_compatible(np, "qcom,adreno-smmu"))
>>>>
>>>> I don't know if it's better to get myself involved in fixing this, though.
>>>> There is no fallback that encompasses qcom devices but not all arm devices.
>>>> Either way, I'll have to add a new compatible string to the driver.
>>>>
>>>> If something like this is fine for now, I'll format it properly tomorrow:
>>>
>>> Please wait till we reach some conclusion otherwise your work might be
>>> wasted.
>>>
>>>>
>>>> --- a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
>>>> +++ b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
>>>> @@ -48,6 +48,13 @@ properties:
>>>>                - qcom,sm8350-smmu-500
>>>>                - qcom,sm8450-smmu-500
>>>>            - const: arm,mmu-500
>>>> +
>>>> +      - description: Qcom SoCs implementing "qcom,smmu-500"
>>>> +        items:
>>>> +          - enum:
>>>> +              - qcom,sdm670-smmu-500
>>>> +          - const: qcom,smmu-500
>>>> +
>>>
>>> Someone would have to confirm that smmu-500 is a real device
>>> spec/version. Otherwise this should be device-specific compatible (e.g.
>>> earliest in family).
>> In my view it's hard to name it, downstream uses bool properties for enabling/disabling
>> certain quirks and on different generations there are different combinations of that.
>> Interestingly enough, I vaguely remember that the same quirk names can mean different
>> things on different msm-X.Y versions.. Add to that, different msm-X.Y versions can have
>> different assumptions on what's the default (aka without taking the bool properties into
>> account) behaviour for a given compatible. 
>
> Downstream does not care about ABI, coding style, reasonable approach,
> so it should not wonder that they code things inconsistent.
>
>
>> So I suppose "first in the family" would be
>> the best way to go for mainline, though there are still quite a few families:
>> 
>> <earlier ones used qcom_iommu>
>> - 8996 with quirks that are already accounted for (or one may also say it works by miracle,
>> just like msm8916 - downstream adds more special handling, but looks like the fw is not as
>> restrictive)
>> 
>> - 8996pro + 660 + 8998 with serious unmerged ones [1]
>> 
>> - 845 which seems to be aok
>> 
>> - special case of chromebooks where they only have qcom TZ/XPUs and not the hypervisor to
>> fight with, so ma-a-aybe (no downstream reference & I don't have the hw to confirm) they
>> can get away with less things
>> 
>> - 8[1234]50 which seem to be a mix-and-match of less serious (read: not accounting for them
>> may hurt performance but will not make your device sepuku at SMMU probe) minor quirks
>> [2][3][4][5] (big warning: these may be overriden somewhere in other device tree fragments,
>> the surest option would be to take a compiled dtb and decompile it to be sure about it)
>> 
>> - 4xxx/6xxx series that mostly align with "whatever was there on the flagship soc released
>> a year before"
>
> If the devices are really different, even though it is not visible in
> Linux driver, then indeed there is no point for fake compatibility. I
> raised the question only because the driver does not customize the
> variants, but that might be not enough.

If there are no problems with the original patch, could you please indicate
that? I think this thread is getting a little lengthy for the other
maintainers.

> Linked DTSI use different quirks (assuming quirks would have same
> meaning...), plus they have sometimes different amount of clocks, so in
> total maybe it is not reasonable to make them compatible. On the other
> hand, maybe the programming model is very, very similar thus Linux could
> bind to one fallback and few different bits would be customized with
> specific compatible.

Not to rush you or anything. If you think this should be decided before the
series goes in, it's not urgent.
