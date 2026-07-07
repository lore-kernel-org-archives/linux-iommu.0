Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C4883D891D
	for <iommu@lists.linux.dev>; Tue,  7 Jul 2026 12:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783427858; cv=none; b=BUvdv766+rCtS3SIzfXO+fljgrlacL/NMJMApCyBYZ6HdO8GqOS6zUOUmeksdh/S0mre5oMyi1Ab/6b89B6j9nd06E4e5xQHH6wqO5O0Q/zfH39HC71HRwrXgYhEz5+IX5IEMAgehysYaZeS4ZtfCxTobGz2TItvUg+JZoqm+hE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783427858; c=relaxed/simple;
	bh=vhGncwJZ9wKzKg6h4u79wj/q2EUUFPEE7blDTnJndOc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QBR5E4w4Vvtkne7AQkHK0wppitsIEPF/0hQjhW2SekkqDp90ESLRyCwE9fx0skC/FkGsfX1fCT+RroMXsYFoqcHZpb1rV/xNkP4EvHFbpZ9wPYzYcEm9yRY301Y+24b8vfsFl5JS6vyNj+0gtl0F6x19xcczDxqhhAO7gaMRnWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hqMqG54h; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=cqes029i; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hqMqG54h";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="cqes029i"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 667C9LHx3740880
	for <iommu@lists.linux.dev>; Tue, 7 Jul 2026 12:37:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	YnmIedkr7Tr8vwNi0AdmSRDuxImVFUdc0vBJaAbaSA0=; b=hqMqG54h4QbHLTUR
	JtWmWqM6Hv3A88fG31J0Y/jNV34Az/XYukWTcC13ffIGypAt7KNDBRSv1vOi1Eo6
	vEbBerzrxKLD/h9Gxf35aPAAj4jvCv4luuQ9zyTSoiPlwbGol9xBUJS+vkJ7Yxst
	wvQqSJxNMnvV2COl0PtRMXSZ0vsrKgp20H5Q01lF0dRWDcA7g0j2ZEII1sc06Czy
	ZkPS4rbFVAZAlSMWg3ouagoAfa4//+6NUj27Yhv86gIjoOvTEWfsp18WwFo6VZLx
	diV/l0zJY6rmlz9GuAiAibKg39nZ37lhBSbX4ujVZ4DNLf/qqoFTPGuUbXjWBE0S
	Bli5FA==
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com [209.85.210.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f8v9a9eyt-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Tue, 07 Jul 2026 12:37:36 +0000 (GMT)
Received: by mail-ot1-f72.google.com with SMTP id 46e09a7af769-7e9e741693bso2229936a34.0
        for <iommu@lists.linux.dev>; Tue, 07 Jul 2026 05:37:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783427855; x=1784032655; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YnmIedkr7Tr8vwNi0AdmSRDuxImVFUdc0vBJaAbaSA0=;
        b=cqes029iRm3o8BsOEFYwJOeRHBbLKDpejV+YxbAa93YXTK9zAcH2py/Rvrx4xSa7eY
         h5jDaizbZaDGw9366qwtG7c9HgiH/3YTUTAZ2aAb/Y8YjsC8k94ya/S0AOJ2hdpX/gyC
         Vy08+R7aeorBO/fGp+c9PXqLwjOR8nj9uTue1SR/uQbsQAs+/QTUGzCqB2vZzXKNm8HS
         6lwu2jio+q+0KL73r/XW6zoIxohO2zmDATHwxt1mfn313UAPK/zInJ6YUDGnRrbpcgVY
         hYl9zQdRr8pDm/362bxE1gmAIEZF5xYOrsf6zRrCBXJnOwflWAVlpcKGl+HI/TnBQHll
         ob2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783427855; x=1784032655;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YnmIedkr7Tr8vwNi0AdmSRDuxImVFUdc0vBJaAbaSA0=;
        b=BrAd4UEMyDqCFIGqNjkOp+TGg7KVOD7CK9bZqOiZVsZL9CFzYFGyKVOexMMUO/Nl9D
         i4ww5u7kJGAOSjmiWQo7r//CyZQ3dAgC2710bMAhSfvSdbMmz/llEu8hjgh1/5hCtSHa
         PXWTaMIDXuLnFBMglgmX3N7fn5rZzQEoJSHpE/d6J7DgOnA7RGiqA8437DHON6n+VSgS
         wJkdHubtVKYNTLlAK/ImoKbiLOwVJXdX4hfSqnWTNmpsDM8BWv39JEpLX6Gj+eXggm+S
         tI1Nt+B/u8m8505VxbtfuSwRRB24A3LnvZM6UXfJp85UYahNHlQ24zBOa4E/oh6lMw/+
         oG7w==
X-Forwarded-Encrypted: i=1; AFNElJ9ydOtU3oNaHuaEmE4a/gPzkWUtU3gW6a1Rc6cdolGhlmjmdepfRJ7RPsQ9yCHUgRVXDUdIJQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwO1ET8gKqFbAdqrTDyghRX7dkqr6jDKJemlwSap4RhsRFaJ1lT
	BGjJZRU/lh+T2UzhNIGDu1in2jhTrpLNzDP7Is3bjRpC10FvZwZFtjxaX0TXgzZ68BWLd80IYrk
	qBDVOl8ieX3mAIPqm0O8CaxqymFsSW814mAjr3s0Q7pRf8QUhtSEw6L7ShQ==
X-Gm-Gg: AfdE7ckgTnMdHntmOwZv9EFFGyA0rFGsYtEPLHJUY5hGq/KG2WygRLdQ/1GCKYm2ry3
	bQXKDr1DBqEp9s9d1/VXTPkMJ4Ujd7O85su5L/one688afNq0MoxHczcAMT0vhfdr4VJiZBy2It
	+G94Rp03/RWOR7zbWCZ+rkZLbIBmWGDU4B5Ei9e3ewk4/8v6wiieFJ0cjC3rAPhxAopm0RUzY8F
	kCDyW+r1iBZgRT5oJraI31xfDSakzvo4sYM3cqMqf+kof32swysHgjnKGLdb8AI9qIHFtlAGtE4
	otNfHz55jbF/rBng3iEEsjUasHmX2voxyHyQZWG5k/yv90w5xtuYBxKiGNNSCU0OgA//00lxt9A
	aTtSc/r3A0orqt+mdVUBX8oQkJlLpQiOfjciqwXo=
X-Received: by 2002:a05:6830:67da:b0:7e7:76f:3ec0 with SMTP id 46e09a7af769-7ebb233a1c7mr3266287a34.15.1783427855365;
        Tue, 07 Jul 2026 05:37:35 -0700 (PDT)
X-Received: by 2002:a05:6830:67da:b0:7e7:76f:3ec0 with SMTP id 46e09a7af769-7ebb233a1c7mr3266269a34.15.1783427854922;
        Tue, 07 Jul 2026 05:37:34 -0700 (PDT)
Received: from [10.219.56.198] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7eb542ebf72sm15010628a34.9.2026.07.07.05.37.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jul 2026 05:37:34 -0700 (PDT)
Message-ID: <e8b247d9-d60d-497f-a831-a9772d27481a@oss.qualcomm.com>
Date: Tue, 7 Jul 2026 18:06:59 +0530
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/6] dt-bindings: iommu: arm,smmu: Document
 interconnects property
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
References: <20260706-smmu_interconnect_addition-v3-0-afdca0125a65@oss.qualcomm.com>
 <20260706-smmu_interconnect_addition-v3-1-afdca0125a65@oss.qualcomm.com>
 <nrht4irqtvt2vk3lrqvljonarc4kanht2nrwjt7pppsfhozffv@o4xei47l6gcj>
Content-Language: en-US
From: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
In-Reply-To: <nrht4irqtvt2vk3lrqvljonarc4kanht2nrwjt7pppsfhozffv@o4xei47l6gcj>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: fIeKx7jqAiDr2qR12UnAoHjf5s1M9Pm5
X-Proofpoint-ORIG-GUID: fIeKx7jqAiDr2qR12UnAoHjf5s1M9Pm5
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA3MDEyMiBTYWx0ZWRfXyWjGqpBPa8yN
 eMKdTFzk7LKUSmXaO/+e35/mh7BTtNe5WxmCNAZbobivaRXq5+PoqFItRaFZUKjvPf7uYZTqpaG
 6b38+o/P02vHG6jxen9X7ylwqm8MKi8=
X-Authority-Analysis: v=2.4 cv=b9yCJNGx c=1 sm=1 tr=0 ts=6a4cf310 cx=c_pps
 a=+3WqYijBVYhDct2f5Fivkw==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=1xpCzd4iWPYukUP1q-QA:9 a=QEXdDO2ut3YA:10
 a=eYe2g0i6gJ5uXG_o6N4q:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA3MDEyMiBTYWx0ZWRfXzz8Np3lQ6hDi
 hDdnDR5DW34vW1ZNQJWdOeanUc3AKbjpBhqJIZH1zFMIsvzL+rnxeQocFHbqNwEAJaGqYUKn555
 iJ0Mo13n4gnrLVUvgYxe1CjA3WBYln65XLYNY6m6WGa4bMMm073iG4y5LAu6j+ojdj4wDhwui3j
 y9l6cBCJMym1FDhYWITam7VFp6AWSxPxyiFJY8I6JIczm1fs6Aq2GPujN3fOcyWcetx6AXfjBHE
 6IorqZKdICrsBnn03R7xSkLVF0lPZ6gNy9ePoIvdzxViV6LGZAoNHRzSaaD0EcDxi1xoAUXmsGw
 lNtlk9DB5TMKjujkDYhMKBCZnS1qhRqPzfZY9jRwfMJ/9He6gKjMi6lkV1d3XmkNAlpQCAyxhll
 VqCxp6839NRqFWnRx2qoLKtkbdF5ztcHxYvsQ1vOWUSKdCmLg6+gNXMPkCzbh9eoVy0u8IUeM1A
 /1j07iPXoK4xtlBQQ4A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_03,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 priorityscore=1501 adultscore=0 malwarescore=0
 bulkscore=0 spamscore=0 lowpriorityscore=0 phishscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607070122



On 7/6/2026 11:09 PM, Dmitry Baryshkov wrote:
> On Mon, Jul 06, 2026 at 10:26:34PM +0530, Bibek Kumar Patro wrote:
>> Some SoC implementations require a bandwidth vote on an interconnect
>> path before the SMMU register space is accessible. Add the optional
> 
> Why is it limited only to those SoCs? Is it also applicable to other
> Qualcomm SoCs?
> 

I was hoping to keep this series focused on the core infrastructure
changes: the bindings, base ICC bandwidth-voting support, and DT
interconnect properties for the platforms currently supported on
Qualcomm Linux and have been validated so far.

The additional targets have not been tested yet, so I'd prefer
to add their support in a separate follow-up series once validation
is complete, rather than growing this series further. WDYT?

>> 'interconnects' property to the binding to allow platform DT nodes
>> to describe this path.
>>
>> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
>> Signed-off-by: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
>> ---
>>   .../devicetree/bindings/iommu/arm,smmu.yaml        | 27 ++++++++++++++++++++++
>>   1 file changed, 27 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
>> index a701dec2fa0a..fab8944d7b63 100644
>> --- a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
>> +++ b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
>> @@ -246,6 +246,13 @@ properties:
>>       minItems: 1
>>       maxItems: 3
>>   
>> +  interconnects:
>> +    maxItems: 1
>> +    description:
>> +      Interconnect path to the SMMU register space. Required on SoCs
>> +      where the SMMU registers are only accessible after a bandwidth
>> +      vote has been placed on the interconnect fabric.
>> +
>>     nvidia,memory-controller:
>>       description: |
>>         A phandle to the memory controller on NVIDIA Tegra186 and later SoCs.
>> @@ -644,6 +651,26 @@ allOf:
>>           clock-names: false
>>           clocks: false
>>   
>> +  - if:
>> +      properties:
>> +        compatible:
>> +          items:
>> +            - enum:
>> +                - qcom,qcs615-smmu-500
>> +                - qcom,qcs8300-smmu-500
>> +                - qcom,sa8775p-smmu-500
>> +                - qcom,sc7280-smmu-500
>> +            - const: qcom,adreno-smmu
>> +            - const: qcom,smmu-500
>> +            - const: arm,mmu-500
> 
> Can we be more idiomatic here?
> Something like:
> 
> if:
>    allOf:
>      - properties:
>          compatible:
>            contains:
>              enum:
>                - qcom,qcs615-smmu-500
>                - qcom,qcs8300-smmu-500
>                - qcom,sa8775p-smmu-500
>                - qcom,sc7280-smmu-500
>      - properties:
>          compatible:
>            contains:
>              const: qcom,adreno-smmu
> 
> In the end, we don't need to list the full list of compats. We need to
> specify that it's Adreno SMMU on one of the listed platforms.
> 

Agreed.
We need the interconnect property for any of the listed platform using
the adreno-smmu only.

Additionally in following e.g.

compatible = "qcom,adreno-smmu",
              "qcom,sc7280-smmu-500",
              "qcom,smmu-500",
              "arm,mmu-500",
              "qcom,new-string";

The current schema could miss enforcing the interconnect property
when new compatible strings are introduced, whereas the approach you
suggested continues to handle such cases correctly.

I'll update the binding accordingly in the next revision.

Thanks & regards,
Bibek


> 

