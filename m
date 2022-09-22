Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B77B41FBA
	for <iommu@lists.linux.dev>; Thu, 22 Sep 2022 02:40:12 +0000 (UTC)
Received: by mail-il1-f179.google.com with SMTP id a2so475862iln.13
        for <iommu@lists.linux.dev>; Wed, 21 Sep 2022 19:40:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=YS6Dg5osr6nCJxEVuPdfQt0cZfWWG2Q/unzoo9QoBKs=;
        b=NvuA8N/8RKjR5vm0qEUfonZC98zcavJV+DuFgNw20rZCSD/VuKU62dLQB6ueutjXIG
         O67UGfpetZwhGo4lnBM8NmgUwUydXvfhb9RY2vOOFu+WAVaU7bmloXZjVzcSDfNPgfVd
         lWMi2HtqijFxQY7tVN23VRXoBGNNOj2WIDKwWLsO/9j9yCNyKARG+scxTcmTO/47YO+7
         VQkhKBKBC6kNbOnmKqEgJvGlgX/aH7UWxS2Agr1ZY2zOBTKtmw+OUNfwBnFMhIni5QMp
         VMg4cPR24eIe0RFgPCxS7asC8pDR9syuMxRJnj+V5yu1wq2yTJzh58m7FFq+zkqsmgyr
         z1zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=YS6Dg5osr6nCJxEVuPdfQt0cZfWWG2Q/unzoo9QoBKs=;
        b=YRRi1UuXLmNGdeUUofGy1mQwTtylUjDhDrQsnJsntEFV58CIUHAKq1DA1ct+w1yzAC
         zrkVENo9ruiFBABdFvdCGYkiQT3mn1gOyM9KknOJZiqWA+6O5XdreT7bfnPWW5ejt6ZP
         slKo2FummPX6TLUk9qHhiKfiuKuJqEHULEaF8mIEl0lwAEfqofSBQo0XeK7fOF7839XY
         Vf/cHEXvi7MUdHDrFjPbypEDvcOGt921tS7JSLgvq325tQqrCWYuKu3/2+25cqxX1qxM
         sdq5hRoBxqJE2V3ZsBUOfbO2T0kltTybq8FOGNQ+RLkez4PMPliQe5e3Chl4nT5Nbp1M
         1kUw==
X-Gm-Message-State: ACrzQf2YFhbaVt0DhNtHy3NFKIVos07ZBVCvh4B0PkUPDay9j6UCrDIb
	ct/gvEcq6UJ0faop2X8nK1I=
X-Google-Smtp-Source: AMsMyM4T4LztPLLiQ3WiN86RqKrZQ/wMq1uMh/Em6rBkulzQwwvH/ilwkXrjUbkxmiIUWMk4gJ8LEA==
X-Received: by 2002:a05:6e02:1d18:b0:2f6:65c9:91 with SMTP id i24-20020a056e021d1800b002f665c90091mr609072ila.164.1663814411729;
        Wed, 21 Sep 2022 19:40:11 -0700 (PDT)
Received: from localhost ([2607:fea8:a2e2:2d00::61a4])
        by smtp.gmail.com with UTF8SMTPSA id b27-20020a026f5b000000b00349d4ee2a4asm1689487jae.91.2022.09.21.19.40.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Sep 2022 19:40:11 -0700 (PDT)
From: Richard Acayan <mailingradian@gmail.com>
To: Konrad Dybcio <konrad.dybcio@somainline.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Richard Acayan <mailingradian@gmail.com>,
	linux-arm-msm@vger.kernel.org,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Sai Prakash Ranjan <quic_saipraka@quicinc.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Rob Clark <robdclark@chromium.org>,
	Sibi Sankar <sibis@codeaurora.org>,
	Loic Poulain <loic.poulain@linaro.org>,
	Vinod Koul <vkoul@kernel.org>,
	iommu@lists.linux.dev,
	devicetree@vger.kernel.org
Subject: Re: [PATCH 2/2] iommu: arm-smmu-qcom: add sdm670 compatible
Date: Wed, 21 Sep 2022 22:38:34 -0400
Message-Id: <20220922023833.178076-1-mailingradian@gmail.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <5f629a95-8ee4-7cf8-f471-0b50e311d3b7@somainline.org>
References: <5f629a95-8ee4-7cf8-f471-0b50e311d3b7@somainline.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

>On 21.09.2022 21:05, Krzysztof Kozlowski wrote:
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
>>>>>>  drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 1 +
>>>>>>  1 file changed, 1 insertion(+)
>>>>>>
>>>>>> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
>>>>>> index b2708de25ea3..bf9653b9eb89 100644
>>>>>> --- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
>>>>>> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
>>>>>> @@ -431,6 +431,7 @@ static const struct of_device_id __maybe_unused qcom_smmu_impl_of_match[] = {
>>>>>>  	{ .compatible = "qcom,sc8180x-smmu-500" },
>>>>>>  	{ .compatible = "qcom,sc8280xp-smmu-500" },
>>>>>>  	{ .compatible = "qcom,sdm630-smmu-v2" },
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
>and consumer devices (such as MDSS). The situation is more complicated, because some
>qcom SMMUs also require more quirks than others (think 8974 vs 8994 vs 8996/pro&660&8998
>vs 845+ vs adreno smmu in various flavours), so all qcom SMMUs need to use
> `qcom_smmu_impl` and some others need even more quirks on top of that (that generally
>hurt performance or functionality, so we don't want them when they're unnecessary).
> If all generations of qcom SMMU implementation that bear the same name behaved anywhere
>near consistent, there would be no need for keeping this around, instead requiring only
> "qcom,broken-smmu" or something".

Hi, just stopping by to share my own thoughts.

First, I don't mind if this series doesn't get applied as-is. After seeing
the eMMC driver in its current state:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/mmc/host/sdhci-msm.c?h=v6.0-rc6#n2437

I can understand that the devicetree maintainers don't want to see new SoCs
touching drivers unnecessarily. Second, I don't see enough quirks to
justify needing all compatible strings in the driver (2 quirky SoCs
compared to 16 total not counting adreno iommu):

    $ grep qcom, drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
    	if (of_device_is_compatible(np, "qcom,msm8996-smmu-v2"))
    	* All targets that use the qcom,adreno-smmu compatible string *should*
    	{ .compatible = "qcom,adreno" },
    	{ .compatible = "qcom,mdp4" },
    	{ .compatible = "qcom,mdss" },
    	{ .compatible = "qcom,sc7180-mdss" },
    	{ .compatible = "qcom,sc7180-mss-pil" },
    	{ .compatible = "qcom,sc7280-mdss" },
    	{ .compatible = "qcom,sc7280-mss-pil" },
    	{ .compatible = "qcom,sc8180x-mdss" },
    	{ .compatible = "qcom,sm8250-mdss" },
    	{ .compatible = "qcom,sdm845-mdss" },
    	{ .compatible = "qcom,sdm845-mss-pil" },
    	if (of_device_is_compatible(np, "qcom,sdm845-smmu-500"))
    	{ .compatible = "qcom,msm8998-smmu-v2" },
    	{ .compatible = "qcom,qcm2290-smmu-500" },
    	{ .compatible = "qcom,sc7180-smmu-500" },
    	{ .compatible = "qcom,sc7280-smmu-500" },
    	{ .compatible = "qcom,sc8180x-smmu-500" },
    	{ .compatible = "qcom,sc8280xp-smmu-500" },
    	{ .compatible = "qcom,sdm630-smmu-v2" },
    	{ .compatible = "qcom,sdm670-smmu-500" },
    	{ .compatible = "qcom,sdm845-smmu-500" },
    	{ .compatible = "qcom,sm6125-smmu-500" },
    	{ .compatible = "qcom,sm6350-smmu-500" },
    	{ .compatible = "qcom,sm6375-smmu-500" },
    	{ .compatible = "qcom,sm8150-smmu-500" },
    	{ .compatible = "qcom,sm8250-smmu-500" },
    	{ .compatible = "qcom,sm8350-smmu-500" },
    	{ .compatible = "qcom,sm8450-smmu-500" },
    	if (of_device_is_compatible(np, "qcom,adreno-smmu"))

I don't know if it's better to get myself involved in fixing this, though.
There is no fallback that encompasses qcom devices but not all arm devices.
Either way, I'll have to add a new compatible string to the driver.

If something like this is fine for now, I'll format it properly tomorrow:

--- a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
+++ b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
@@ -48,6 +48,13 @@ properties:
               - qcom,sm8350-smmu-500
               - qcom,sm8450-smmu-500
           - const: arm,mmu-500
+
+      - description: Qcom SoCs implementing "qcom,smmu-500"
+        items:
+          - enum:
+              - qcom,sdm670-smmu-500
+          - const: qcom,smmu-500
+
       - description: Qcom Adreno GPUs implementing "arm,smmu-v2"
         items:
           - enum:
--- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
@@ -424,6 +424,7 @@ static struct arm_smmu_device *qcom_smmu_create(struct arm_smmu_device *smmu,
 }
 
 static const struct of_device_id __maybe_unused qcom_smmu_impl_of_match[] = {
+       { .compatible = "qcom,smmu-500" },
        { .compatible = "qcom,msm8998-smmu-v2" },
        { .compatible = "qcom,qcm2290-smmu-500" },
        { .compatible = "qcom,sc7180-smmu-500" },

>
> Konrad
>> 
>> Best regards,
>> Krzysztof
>> 
