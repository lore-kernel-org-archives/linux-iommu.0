Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 718933988F8
	for <iommu@lists.linux.dev>; Mon,  8 Jun 2026 13:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780926293; cv=none; b=L9YQxB+LFofFgiw4PGkxV2SXWjYn4DewOkQUMNDM5V9b7pDbcRR5fX638sBPKzJmA478ReRP3QD3v/MwWI5/6bkiBjS6qVpl7HA8PRe/gXwZgFukhoPvQeuXAm9kPPGPM5St2rSMxWNpzXzIyXHofYaxQvNUgAdW95qKMVB7j5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780926293; c=relaxed/simple;
	bh=ADv8HQSn0bAWEjRLgvvHbC8lDudXzS5pm8sdS5zAgW0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lBfdexRZBkO5IXGUpjPeUEKi3tJ4QKUhVmNXadf5lLLkDCJTe4KOxzEl6HGB9ts64BoH2g2womVwpX2ISOhkGADdlCgS4eowoXZ0Y7Gs3ZFG4QASvVMil+PubrzbzU8Ltig3EAf/XUwCh2hYug/uLMzd9mk3TBtuLmG+U17a+0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Rk4qYFZp; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=MyYTlwlS; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Rk4qYFZp";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="MyYTlwlS"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 658DRBWT3783150
	for <iommu@lists.linux.dev>; Mon, 8 Jun 2026 13:44:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	UBeLLeGd6D9gfelgbASleoaGWcIHd60b02pysLN6WeQ=; b=Rk4qYFZpGnlkGGw0
	R3e/WBEm9RaoOSBpuO65hpi+rZ3tPqtV1E9zMZ2HqK9xdim43SifwVfqbo07GHrM
	Ju5dw0NOumxW0CEDPfaJ30J+lDNgKkUsoF6WCZEh4N2Wb+KMRfa+QRgFkprQWFTk
	iunZ+6qnCMVFMxu6pAJ0J+3LTJoDbpyT+cZYY//NyyXHWArvYc8qEmuRSgBDCUux
	NxDFHKhAJG0LCkk/eAKucK+LXxCAKcQabgOugfozTymldl8iDtm48NhNCrktjlqA
	ATL+7rp16SUgQIXbWD78hULIbIGtCx85dFsMd2JLM+KhemVstOmLtODKZlRwSbrv
	GPetDw==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4enxee05kf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Mon, 08 Jun 2026 13:44:51 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2c0c3315d31so48014145ad.3
        for <iommu@lists.linux.dev>; Mon, 08 Jun 2026 06:44:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780926290; x=1781531090; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UBeLLeGd6D9gfelgbASleoaGWcIHd60b02pysLN6WeQ=;
        b=MyYTlwlSNIFfqxvE/+CEH9gi7MVyTUWaqPU7AFxi9L/Pap6JdrExKFavkp3RS9N5tQ
         V6vXIzo55WZDQXljCMgiF0jh9Y3vDtWtyKrvq0WDo+mg+nmI+vIrN6euJ5IlmhKibU6S
         CudEDAwT/yUeOxuGx1I1vvT4UEHFkmbrHa/glCkLySLSUI9q6YTw5AjN8xm7o4PBZ+fD
         6TCa4RzQosC6PijxyxkjPdMrvqzAo7PqpJb0vWhEGFzIGTkSv+e+ply/fNHu9tKOffNw
         j63t78Nw8VecV4PGxO6cwmiud+BlQB7IosM8ni1h2rLbHfhOW5pJMpS287shDI97sKVF
         wB/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780926290; x=1781531090;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UBeLLeGd6D9gfelgbASleoaGWcIHd60b02pysLN6WeQ=;
        b=tJTcBqtJe2pw5wy5J8bVvu5pgUDPxAZVX3gBVHMq/lM70E55jlIPEAZg9PSH9d5Xkv
         ldC+Ewp2Gpzq7l2sVEM1kcxpLt0DO1hz94R/r8yeFQWtH8HBFqy/r3oEIJHdQox7j117
         8H06xW3Lg3zfY4f7/5pjJY1ycsk5YumqjcNuilZpGI71ctXvLAADu0qklPwsiclrlLSG
         /2K5r226xLwZwD9DvRfMRU1RMZxIaQalN+XLMT7rNpgZD2Fwqlsf+7GXd23T7k9i2HpT
         dqXGYKfEC1bg+7JlFbhjiaoMFAHNEzQ7nq81y+oy6EelVuoT8uFJ7QxFdeJ3peNVr2Zx
         emuw==
X-Forwarded-Encrypted: i=1; AFNElJ9KoJ3S6JnKckk7hYTO2GGsB2Ivsp3w+EPnoBiANTvGiHUYr7FXUK5REg68EvoqgEX2Be+3aQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxbITW8v1NnRMd+cWXlLQGyy18ZwUG0CKXuqMFafxt8RBrPaI5p
	RBPofHN/CEpHc0Z3iCnx8+BS4rBiNE2+o7nEzh3ztIjW2HH05ooPXWdP/kAZVLSeNpTlHb2CG/k
	Uf0hH0UgAZog96keO6JS8tpdnUOU2Aa/Kx+wm7bl+TdTCxnwWwBuLOB37iw==
X-Gm-Gg: Acq92OGLLznNYH1aC7uZAJrK2V95AnMh+9wkwnnIf4bynktKfiIlc61JiYIVKFGRLaF
	OTrYtSXRGqFlgkOdj7IIZK6zFbiRAA8YAhxTjrSu97dGI47V7Kl20ziGmLBdY3ZOHNSujd9A3yy
	Z2PUu0nT0mAoh49Qww653JW0QUetBAB1E12LSj0MI+CE1XWXtW4Hc1Q5iBFY3sj+4ZqBL2U073Y
	MdFJPAACWXuxCqCI3P5O/6ZrQDmU4JIPrVcTk226x+inKTwmrNXpcFIODPjzU3k4DCdtdkgwL9z
	haROU/4gTlNR7qiGrwRrbIlac7hPCyCYHqsGlAEntpzu7vi623avwSSXX32+sMsePt0VlMjeg1A
	rlwRk4Bh07vzwh9anQX8UN+elyV06wXXJxWk1mPnbJKLfdv1YImViNfh2Nsdf
X-Received: by 2002:a17:902:f543:b0:2c2:27be:39a3 with SMTP id d9443c01a7336-2c227be3b4fmr113831905ad.29.1780926290263;
        Mon, 08 Jun 2026 06:44:50 -0700 (PDT)
X-Received: by 2002:a17:902:f543:b0:2c2:27be:39a3 with SMTP id d9443c01a7336-2c227be3b4fmr113831305ad.29.1780926289645;
        Mon, 08 Jun 2026 06:44:49 -0700 (PDT)
Received: from [10.218.33.224] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c164f88473sm200506985ad.25.2026.06.08.06.44.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jun 2026 06:44:49 -0700 (PDT)
Message-ID: <0ded611e-1932-470c-8e80-9a5e94268583@oss.qualcomm.com>
Date: Mon, 8 Jun 2026 19:14:43 +0530
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/6] dt-bindings: iommu: arm,smmu: Document
 interconnects property
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
References: <20260526-smmu_interconnect_addition-v2-0-2a6d8ca30d63@oss.qualcomm.com>
 <20260526-smmu_interconnect_addition-v2-1-2a6d8ca30d63@oss.qualcomm.com>
 <1b5ef5b8-c9f2-4eea-8040-22c1d704b529@oss.qualcomm.com>
Content-Language: en-US
From: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
In-Reply-To: <1b5ef5b8-c9f2-4eea-8040-22c1d704b529@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDEzMCBTYWx0ZWRfXwHSED3BcZI88
 N/VPf4GD7Ol4dXp1Oci6oW3b09eW4HHt+PbnVPvPzxI8tS6sFk/NRTaS0TrobMplHaHPF6RhUmH
 xx6P+r06iUr9QiM4OqGFG3bCir9WSXangI7HXGB+YdjlE6DJipKS86XotChFfxmxyrJZwqsaTRS
 bWNTWcMqMzc3gvyaxIAXNKUyJOUgvBdRtYmhvXOTwDCO0V5q+HnLYCvtdELUWz5be7RpA/PfspT
 xnOviQQEitnfo2I1tEb1aNxg9sbaIHi4qAg7ewqSTHm8ARQptTRimXjJPaOwgB53DujjfTjcx95
 O11klZ3E4gQmKybEL4DVscT9S2ur0ElP13nqu7mLBelOZtGl/9FwYB5PYogWYaOVzT6Xba8Uitg
 dX4PdbBKL0tScH7MPwgOKIEJMOe7ZuV5ZvSjYTWvOOAQAIN9E0EKlJPRLlLi2IAwGQsDRHc0C0v
 NuSTG+84cEtJWNAqn7g==
X-Authority-Analysis: v=2.4 cv=V6BNF+ni c=1 sm=1 tr=0 ts=6a26c753 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=NEAV23lmAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=nHMyhPlvQ-XDY_K2CzoA:9
 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-GUID: 8y2mRqfiTZHR804RtAb83slXb7cqSxRf
X-Proofpoint-ORIG-GUID: 8y2mRqfiTZHR804RtAb83slXb7cqSxRf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_03,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 spamscore=0 malwarescore=0 clxscore=1015
 lowpriorityscore=0 suspectscore=0 bulkscore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606080130



On 6/8/2026 3:22 PM, Konrad Dybcio wrote:
> On 5/26/26 4:42 PM, Bibek Kumar Patro wrote:
>> Some SoC implementations require a bandwidth vote on an interconnect
>> path before the SMMU register space is accessible. Add the optional
>> 'interconnects' property to the binding to allow platform DT nodes
>> to describe this path.
>>
>> Signed-off-by: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
>> ---
>>   .../devicetree/bindings/iommu/arm,smmu.yaml        | 27 ++++++++++++++++++++++
>>   1 file changed, 27 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
>> index 06fb5c8e7547cb7a92823adc2772b94f747376a6..3a677ff1a18fcdf5c0ca9ec8a017d41f9eb5ff09 100644
>> --- a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
>> +++ b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
>> @@ -243,6 +243,13 @@ properties:
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
>> @@ -602,6 +609,26 @@ allOf:
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
> 
> This is a list of targets that happen to be supported by QLI.. but should
> this list not contain _all_ Qualcomm SoCs, or at least a much broader range?
> 
> Perhaps
> 
> if: properties: compatible: contains: qcom,adreno-smmu
> 
> ?
> 

As of now platforms where the issues [1] getting reported are added, the
list will grow.
<We still have to evaluate and test on other non-QLI platforms hosted in
upstream [2]>

[1]: https://github.com/qualcomm-linux/kernel/issues/297
[2]: 
https://lore.kernel.org/all/a437f9f9-3560-40f8-85ea-35433e33c428@oss.qualcomm.com/

> Konrad

