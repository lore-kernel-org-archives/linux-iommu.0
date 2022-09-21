Received: from m-r1.th.seeweb.it (m-r1.th.seeweb.it [5.144.164.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8524C7C
	for <iommu@lists.linux.dev>; Wed, 21 Sep 2022 18:48:47 +0000 (UTC)
Received: from [192.168.1.101] (95.49.29.188.neoplus.adsl.tpnet.pl [95.49.29.188])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by m-r1.th.seeweb.it (Postfix) with ESMTPSA id 2BA0320202;
	Wed, 21 Sep 2022 20:48:44 +0200 (CEST)
Message-ID: <f98ccf6b-34e7-d15f-63f9-928827b52eb8@somainline.org>
Date: Wed, 21 Sep 2022 20:48:43 +0200
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
From: Konrad Dybcio <konrad.dybcio@somainline.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
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
In-Reply-To: <5c25dc95-d7a4-0b15-5514-6fe3a48e899c@somainline.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 21.09.2022 20:47, Konrad Dybcio wrote:
> 
> 
> On 21.09.2022 09:31, Krzysztof Kozlowski wrote:
>> On 21/09/2022 00:39, Richard Acayan wrote:
>>> The Snapdragon 670 needs the IOMMU for GENI I2C. Add a compatible string to
>>> support it.
>>>
>>> Signed-off-by: Richard Acayan <mailingradian@gmail.com>
>>> ---
>>>  drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 1 +
>>>  1 file changed, 1 insertion(+)
>>>
>>> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
>>> index b2708de25ea3..bf9653b9eb89 100644
>>> --- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
>>> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
>>> @@ -431,6 +431,7 @@ static const struct of_device_id __maybe_unused qcom_smmu_impl_of_match[] = {
>>>  	{ .compatible = "qcom,sc8180x-smmu-500" },
>>>  	{ .compatible = "qcom,sc8280xp-smmu-500" },
>>>  	{ .compatible = "qcom,sdm630-smmu-v2" },
>>> +	{ .compatible = "qcom,sdm670-smmu-500" },
>>
>> Why do we keep adding compatibles to the driver for apparently
>> compatible devices?
> 
> Because Linux has not funny run on bare Qualcomm hardware ever since at least msm8x60 times and
s/funny/fully

unfortunate typo, this is not funny, quite the contrary..

Konrad
> we are not interacting with real hardware, only with Qualcomm's flawed virtual implementation
> of it, that's abstracted to us through various generations of their saddening software stack. This
> is also the case for many more standard components, even as far as the GIC on recent boards..
> 
> Konrad
>>
>>
>> Best regards,
>> Krzysztof
