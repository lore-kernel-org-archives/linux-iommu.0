Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F8D78464
	for <iommu@lists.linux.dev>; Tue, 20 Jun 2023 10:02:22 +0000 (UTC)
Received: from [IPV6:2001:b07:2ed:14ed:c5f8:7372:f042:90a2] (unknown [IPv6:2001:b07:2ed:14ed:c5f8:7372:f042:90a2])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madras.collabora.co.uk (Postfix) with ESMTPSA id 756F06606F23;
	Tue, 20 Jun 2023 11:02:19 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1687255340;
	bh=RLHVI/wjjEu7tgaFY7P5mxMUKibf2l0LJy6KXwWfTcA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=MNBGt+PAu1mufc3pOtgjMZsDRsZVkBktZDjH9Dz7Uj7xuARm3UE1Hp+m1EuAIkv1B
	 wsq6HxhL47hyFqG48h1AfLyEMdcZsEm0/sSi/U9RmHlRp92TaYQ+I/IBQ1CRI0TpL0
	 UZH2wsHoxlN5X0vH2NahxbvGryTduWB+/Bu5n9jlo8uFISCOE69AArOmnuKga363U4
	 ZTLQKgeyWz4WLy76ZsYBMetcLMh9wOugHPNULDaww5W4x8zAMemG0KQnL3cz74M+vs
	 +LflWzhOmPJXhdCE4lDo68BVQwnIOdTiPxnHCKfh/uElBlSBNNhpyMR/xEPikge/JQ
	 t4n5olsHSPtmA==
Message-ID: <491fab1f-e1fe-4388-52a7-05adb17c2c36@collabora.com>
Date: Tue, 20 Jun 2023 12:02:16 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v3 0/6] Add support for Qualcomm's legacy IOMMU v2
Content-Language: en-US
To: Luca Weiss <luca@z3ntu.xyz>, agross@kernel.org
Cc: andersson@kernel.org, konrad.dybcio@linaro.org, joro@8bytes.org,
 will@kernel.org, robin.murphy@arm.com, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, robdclark@gmail.com,
 linux-arm-msm@vger.kernel.org, iommu@lists.linux.dev,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, marijn.suijten@somainline.org,
 kernel@collabora.com, a39.skl@gmail.com, phone-devel@vger.kernel.org,
 ~postmarketos/upstreaming@lists.sr.ht,
 =?UTF-8?Q?Matti_Lehtim=c3=a4ki?= <matti.lehtimaki@gmail.com>
References: <20221115101122.155440-1-angelogioacchino.delregno@collabora.com>
 <254cfbb5-c8b8-0abc-e6bc-5007fe757004@collabora.com>
 <2759637.mvXUDI8C0e@z3ntu.xyz>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <2759637.mvXUDI8C0e@z3ntu.xyz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 19/06/23 23:42, Luca Weiss ha scritto:
> On Mittwoch, 22. Februar 2023 10:57:47 CEST AngeloGioacchino Del Regno wrote:
>> Il 15/11/22 11:11, AngeloGioacchino Del Regno ha scritto:
>>> This series adds support for handling "v2" firmware's IOMMU, found
>>> on at least MSM8956 and MSM8976 (some other SoCs also need the same
>>> but I honestly don't remember which ones precisely).
>>>
>>> This is strictly required to get functional IOMMUs on these SoCs.
>>>
>>> I'm sorry for not performing a much needed schema conversion on
>>> qcom,iommu.txt, but I really didn't have time to do that :-(
>>>
>>> This series was tested on Sony Xperia X and X Compact (MSM8956):
>>> ADSP, LPASS, Venus, MSS, MDP and GPU are happy :-)
>>
>> Hello,
>> this series is really old and got sent and resent many times.
>> The first time I've sent this one was .. I think in 2019, then, at the
>> end of 2022, I had some time to actually respin it and send another
>> three versions. It's been 3 long years :-)
>> The third version got the last comments addressed.
>>
>> Since this didn't get any more feedback for 3 months, I'm worried that it
>> will be forgotten again, hence:
>>
>> Is there any more feedback? Anything else to fix?
>> If not, can this be picked, please?
> 
> Hi Angelo,
> 
> there's some open review comments since March now on this series. Since some
> of these patches are also needed for msm8953 and msm8974 IOMMU it would be
> nice if you could respin :)
> 

Hello Luca,

I've just sent a v4, but I'm sorry I forgot to Cc you. Please find it at [1].

[1]: 
https://lore.kernel.org/all/20230620095127.96600-1-angelogioacchino.delregno@collabora.com/

Cheers,
Angelo

> Regards
> Luca
> 
>>
>> Thank you.
>>
>> Best regards,
>> Angelo
>>
>>> Changes in v3:
>>>    - Removed useless FSRRESTORE reset and definition as pointed
>>>    
>>>      out in Robin Murphy's review
>>>    
>>>    - Fixed qcom,iommu.txt changes: squashed MSM8976 compatible
>>>    
>>>      string addition with msm-iommu-v2 generics addition
>>>
>>> Changes in v2:
>>>    - Added back Marijn's notes (sorry man!)
>>>    - Added ARM_SMMU_CB_FSRRESTORE definition
>>>    - Changed context bank reset to properly set FSR and FSRRESTORE
>>>
>>> AngeloGioacchino Del Regno (6):
>>>     dt-bindings: iommu: qcom,iommu: Document qcom,ctx-num property
>>>     iommu/qcom: Use the asid read from device-tree if specified
>>>     iommu/qcom: Properly reset the IOMMU context
>>>     iommu/qcom: Index contexts by asid number to allow asid 0
>>>     dt-bindings: iommu: qcom,iommu: Document QSMMUv2 and MSM8976
>>>     
>>>       compatibles
>>>     
>>>     iommu/qcom: Add support for QSMMUv2 and QSMMU-500 secured contexts
>>>    
>>>    .../devicetree/bindings/iommu/qcom,iommu.txt  |  9 +++
>>>    drivers/iommu/arm/arm-smmu/qcom_iommu.c       | 78 +++++++++++++++----
>>>    2 files changed, 70 insertions(+), 17 deletions(-)
> 
> 
> 
> 
> 
