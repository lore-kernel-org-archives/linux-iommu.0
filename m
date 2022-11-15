Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88D3A28ED
	for <iommu@lists.linux.dev>; Tue, 15 Nov 2022 09:52:56 +0000 (UTC)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madras.collabora.co.uk (Postfix) with ESMTPSA id 8E9916602A0B;
	Tue, 15 Nov 2022 09:52:53 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1668505974;
	bh=fTz1/LN3UJg7iGi864PNg/UpPBmLtN7Aac88qggrMqc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=fnK2ETBoLYl0jFzGtqol98jYRtaoaU2ghK6T6YxMvG6AWKtz1sTk2+/raMyvhYa01
	 qDQs9wRUxrhEZ3IOoZb/pWUIAcYR71xq57IudW1u6ErKbATs6qE/Fmmp+pp52y2RNt
	 89bUWxbQo7A57BSmfvOAgEGI7J6iJR5kWjEnKmHGQLDYjvSpg/sMrmq3lIVgCt0yfm
	 8SFxaL3BT19jdF44+W9hto0JHj4b1ks2enjhbSqEZmMEWpE1Quijc1NsgLLk3lNE2C
	 nFX8MFUdDlFMWpENTXF/Drf3uTS8cV1biqXRM28JlSqXSHhL0hzw8NHMknjIgkKRSs
	 2cUbXwYp1f0Yw==
Message-ID: <2883ef06-7293-d5fd-4b62-ba796a6a2c69@collabora.com>
Date: Tue, 15 Nov 2022 10:52:50 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH v2 8/8] dt-bindings: iommu: qcom,iommu: Document MSM8976
 compatible
Content-Language: en-US
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, agross@kernel.org
Cc: andersson@kernel.org, konrad.dybcio@linaro.org, joro@8bytes.org,
 will@kernel.org, robin.murphy@arm.com, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, robdclark@gmail.com,
 linux-arm-msm@vger.kernel.org, iommu@lists.linux.dev,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, marijn.suijten@somainline.org,
 kernel@collabora.com, luca@z3ntu.xyz, a39.skl@gmail.com,
 phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
References: <20221111145919.221159-1-angelogioacchino.delregno@collabora.com>
 <20221111145919.221159-9-angelogioacchino.delregno@collabora.com>
 <92a75ab2-ffb9-9acd-4a98-a91589ad7e14@linaro.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <92a75ab2-ffb9-9acd-4a98-a91589ad7e14@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 14/11/22 09:22, Krzysztof Kozlowski ha scritto:
> On 11/11/2022 15:59, AngeloGioacchino Del Regno wrote:
>> Add "qcom,msm8976-iommu" to support IOMMUs on this SoC.
>>
>> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>> ---
>>   Documentation/devicetree/bindings/iommu/qcom,iommu.txt | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/devicetree/bindings/iommu/qcom,iommu.txt b/Documentation/devicetree/bindings/iommu/qcom,iommu.txt
>> index b762772f80e7..b7a5822ac00d 100644
>> --- a/Documentation/devicetree/bindings/iommu/qcom,iommu.txt
>> +++ b/Documentation/devicetree/bindings/iommu/qcom,iommu.txt
>> @@ -9,7 +9,8 @@ to non-secure vs secure interrupt line.
>>   
>>   - compatible       : Should be one of:
>>   
>> -                        "qcom,msm8916-iommu"
>> +                        - "qcom,msm8916-iommu"
>> +                        - "qcom,msm8976-iommu"
> 
> Shouldn't the new compatible be followed by IOMMU v2, not v1?
> 

Yes, effectively, it should.

I'll have to partially rewrite also commit 6/8, so I'll have to drop your
Acked-by tag on both....
Will send a new one shortly.

Cheers,
Angelo

