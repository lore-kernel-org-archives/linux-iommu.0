Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F1E83B27E2
	for <iommu@lists.linux.dev>; Mon,  8 Jun 2026 14:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780927375; cv=none; b=MotvKA0lSuO+tAv7L4Ctf8iDH8qj0MbB6bkZzDWsCB5Yw7D53ufGwx+p6w53i+RmfjA1Fq+ui1jtHQppnqiihuinGCY4grGw5CWBgpqnHNIgqMf/bbkNONLmP/zu1HGmgRvzvJiGcZ+w9LZ5tRHJjES46Uo2ronZiKKlHJrsoyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780927375; c=relaxed/simple;
	bh=7eUwF3VpozAWjRC2kEOp0J91+kRbU/gNOu1dAGf/Pjo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QHLjEDxeQqTWc4+US/avsr0Pfx8e3r66mZ8knJR6Wqds78s0XwfHnBgM5e2+719qYFa2Rqu5NXjkyD3QddyYt0h8jeHr5L9ygfBPVJpJECdpv00i/MpPPFaoQsb1FAqu57EQA93vyYGczSD96g3VCz2CF0ZP8RRz01zeGvmfNgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Wdo6rjfu; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=UcRHcs0U; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Wdo6rjfu";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UcRHcs0U"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 658DRAns3340127
	for <iommu@lists.linux.dev>; Mon, 8 Jun 2026 14:02:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	si0lI3WfDCA17zxk71mM2P+Dt0kHG2CEwaIr9z/aN+c=; b=Wdo6rjfujIvTY/9p
	15eP/N8LMz5JgDuO650z57EpNpNumTWOFRlwRw47+U7B1Wnti2d7+5nQBClu7T4U
	XnNYF29aWKIeuuBQE8QHfab58qqvIFP42fd7DPpPScWWhnmoEhil65SXy8Z9OTP9
	mr+lXNIk2RyBP6MuArSbQC9tmw792lSxJNBxTSiK7fjjJEDEvKsU5bpJdbN2AcqM
	FqWsL73tUtVOMWM1oMOJ0LCr88ysdaSxtwjmFAmxlvyMF+L59Xqs5onY/KmjTYP5
	KKT0vr/zeSz/y4bW3/q8iDRcVdpHNdX8WOSKl48WVNPIH/u6WpPrEvf5vaScL/nl
	EAvZQg==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4enw5m0kex-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Mon, 08 Jun 2026 14:02:53 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-36d985df4cfso5083568a91.1
        for <iommu@lists.linux.dev>; Mon, 08 Jun 2026 07:02:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780927373; x=1781532173; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=si0lI3WfDCA17zxk71mM2P+Dt0kHG2CEwaIr9z/aN+c=;
        b=UcRHcs0UVBBMaffhn9qIwNEHtdLsNYRG8OIdFKaSsXuLMlydFw655RRdm6R7foJtEw
         bkWhhN5yZj7vDCn17E1cpZPyMNPEaof/7/7Cqk4PwzH0OMZLYxLqFGGDUfpFOSRM2GsX
         DUw4cKDfTzAarZUIV0e40wmv2utXTi62Se7BuUwYrmn+aNI3CSHScmaAyPQxfVpS+ntw
         lXidbjnsthdW2vpyOH8+BzpK9JDgiaOzvfNn+xydscMACF/MHqQMZ9TNURX8flydW9rh
         YG6ZWye+XF1Ax3WodvYUdpDRueF2LqeiNTWNwSv5ID1419enJJsiyZMPX6S/JEvQ7YJ9
         CFzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780927373; x=1781532173;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=si0lI3WfDCA17zxk71mM2P+Dt0kHG2CEwaIr9z/aN+c=;
        b=hNn0PWwbqK1XtNGaY11R8WzP2WUvKbEf3okbpbECA2+e8mRM72h+4GUj4Ysti1k86g
         LChqnJtmL+c4pbzeRXv8qsMnaRAXhUMZOM97lniyPAy+wCA0VXu68bvAUKvU1bLW3RC3
         ojadTOYvJ2XoE/lwl82zQCYc83iq3Z+Te5aHnDXQEbHWIM2dLnT+/X8zi4yuh+lM+Jo3
         Lyodizcuq+aMbZNs5U1r5eDBwUKgSCC88+HTEvumlA5Yq2rN5uGcJq+3n5ZfsnKNjFrT
         3so7SZjJvdfZFxF7uY46MUdianEX5wGm6usoAM25C2RIYTYJVX0WjHq9x4XNHwVZ4awh
         py1A==
X-Forwarded-Encrypted: i=1; AFNElJ/9ApxflUN+GGYqP9hJ0zb8hP3o7Vi9aUZ9Xmc8FsqCTFCaCX3ebWhQ+HHbvDgmqg7prUqXwg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz0csZiBBbOwX8XTn5omQIhBzVUHlKzGxPZzjicoOUan7z0gLgo
	ElE8fkXEjVm2uCIBG15y/9mSx6GZbjKzg9KoIc8zfxm15X8doXHDGEMgPSjea54P0cTECTnhy5f
	BlQG9G7udajCr96FEv+nUIJZPgo1Dj2Pe887Zev2rH877epdZwYRWDDvQjg==
X-Gm-Gg: Acq92OGu7oziil2HIKTRAsJg3ke/aL7C6Ie0fzouk8uLMyW5jMlCGEW7h2CuFvAj1su
	UenzkVsr6eiMKgAVxEfmiazZgO9mgu+81M20TNlTzl9L6T7lTUvs0F8iEOl/nUs2gauwbTIXOz3
	snkDbxIxXN3fMdhf+y1SnVP1hDGcmPmx2TV0QXIDpGHXE16KrIIj15uDZLcGwSPVkwpRO5gssTW
	4XTHVaMEz81Kf5cnkwL2SDSlw33TIjz1nEkKtBlYLDBU9vRUpc5pnsOTS9+FZMBQBQ+r4ByCayA
	1BoexXTmzTNpzndQpXNHCg24CfpcFW5RO0H/GlcnWJ+8IsLpcU1btd+oVSWUfsfY/xuDE1x4U0f
	qd7AQ58+0wda2yP+JVjd7pOibFh+XRu9wfIaYuxJyan4j4Pzd71uPpJ04NlLO
X-Received: by 2002:a05:6a20:2d14:b0:3aa:ec1c:84e5 with SMTP id adf61e73a8af0-3b4cd09ace8mr18854493637.43.1780927372804;
        Mon, 08 Jun 2026 07:02:52 -0700 (PDT)
X-Received: by 2002:a05:6a20:2d14:b0:3aa:ec1c:84e5 with SMTP id adf61e73a8af0-3b4cd09ace8mr18854371637.43.1780927371975;
        Mon, 08 Jun 2026 07:02:51 -0700 (PDT)
Received: from [10.219.56.113] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c85df03498csm18010993a12.1.2026.06.08.07.02.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jun 2026 07:02:51 -0700 (PDT)
Message-ID: <a1db573b-bcb4-44a5-89b6-6d1c76f4a18a@oss.qualcomm.com>
Date: Mon, 8 Jun 2026 19:32:45 +0530
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/6] dt-bindings: iommu: arm,smmu: Document
 interconnects property
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
References: <20260526-smmu_interconnect_addition-v2-0-2a6d8ca30d63@oss.qualcomm.com>
 <20260526-smmu_interconnect_addition-v2-1-2a6d8ca30d63@oss.qualcomm.com>
 <1b5ef5b8-c9f2-4eea-8040-22c1d704b529@oss.qualcomm.com>
 <0ded611e-1932-470c-8e80-9a5e94268583@oss.qualcomm.com>
 <2roy5rvazzb5p3vl3dyutft635n3acwssqnqvrzqziivh3ebq2@wptxg7exupmr>
Content-Language: en-US
From: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
In-Reply-To: <2roy5rvazzb5p3vl3dyutft635n3acwssqnqvrzqziivh3ebq2@wptxg7exupmr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDEzMyBTYWx0ZWRfX7RkucFCFUpRN
 ZoXpPM8XQeIhsmknqCzKNSKJQwFtAhshBsFsUVyHDSkR8MeeH9LRHQO1dvmKJGZ0Wmi/Fn26Eym
 8Q4HA2ncIRaEfTYLv2qBf88E2S9vVcvtiJXJi2uLjGUyH84QJZLBc4lTY3brCvjU31GjOR45rVp
 q+eY5cMcJPmHaghg3LKs8bX/SmN1/FPrBAV8BMa5OMukCU6UbrPQuCJNjPnOQqWRniXIYRkD5Lo
 ZcrB3Rkq1q1eTdzhMvHpk57Rac4ELkk3H71pRicVHtCV8MZnfLzXFHfpHBqheuHu6pN0zAL3wRj
 SdHFFoRgr0DBTmtQ/MfPstvzkz6djhunsFpBPsiGuVWF7mVUrZLH0bdSXClyydNpEk/VuB/3nby
 TiqrRgD746EAj6zaAhPCtrHHsrGVrkhGNlZbHDaoqGhrjnTYWQ+/97nRn87+4ceg8Pi4UmVFyoA
 8OFFoWsorVVer2FXctQ==
X-Proofpoint-ORIG-GUID: x2n4K_4AbPVishn24YPusa7YRRPYPUkJ
X-Authority-Analysis: v=2.4 cv=UptT8ewB c=1 sm=1 tr=0 ts=6a26cb8d cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=NEAV23lmAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=N6J3eu7hh-G8EisLkUMA:9
 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-GUID: x2n4K_4AbPVishn24YPusa7YRRPYPUkJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_03,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0
 clxscore=1015 malwarescore=0 impostorscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606080133



On 6/8/2026 7:19 PM, Dmitry Baryshkov wrote:
> On Mon, Jun 08, 2026 at 07:14:43PM +0530, Bibek Kumar Patro wrote:
>>
>>
>> On 6/8/2026 3:22 PM, Konrad Dybcio wrote:
>>> On 5/26/26 4:42 PM, Bibek Kumar Patro wrote:
>>>> Some SoC implementations require a bandwidth vote on an interconnect
>>>> path before the SMMU register space is accessible. Add the optional
>>>> 'interconnects' property to the binding to allow platform DT nodes
>>>> to describe this path.
>>>>
>>>> Signed-off-by: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
>>>> ---
>>>>    .../devicetree/bindings/iommu/arm,smmu.yaml        | 27 ++++++++++++++++++++++
>>>>    1 file changed, 27 insertions(+)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
>>>> index 06fb5c8e7547cb7a92823adc2772b94f747376a6..3a677ff1a18fcdf5c0ca9ec8a017d41f9eb5ff09 100644
>>>> --- a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
>>>> +++ b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
>>>> @@ -243,6 +243,13 @@ properties:
>>>>        minItems: 1
>>>>        maxItems: 3
>>>> +  interconnects:
>>>> +    maxItems: 1
>>>> +    description:
>>>> +      Interconnect path to the SMMU register space. Required on SoCs
>>>> +      where the SMMU registers are only accessible after a bandwidth
>>>> +      vote has been placed on the interconnect fabric.
>>>> +
>>>>      nvidia,memory-controller:
>>>>        description: |
>>>>          A phandle to the memory controller on NVIDIA Tegra186 and later SoCs.
>>>> @@ -602,6 +609,26 @@ allOf:
>>>>            clock-names: false
>>>>            clocks: false
>>>> +  - if:
>>>> +      properties:
>>>> +        compatible:
>>>> +          items:
>>>> +            - enum:
>>>> +                - qcom,qcs615-smmu-500
>>>> +                - qcom,qcs8300-smmu-500
>>>> +                - qcom,sa8775p-smmu-500
>>>> +                - qcom,sc7280-smmu-500
>>>
>>> This is a list of targets that happen to be supported by QLI.. but should
>>> this list not contain _all_ Qualcomm SoCs, or at least a much broader range?
>>>
>>> Perhaps
>>>
>>> if: properties: compatible: contains: qcom,adreno-smmu
>>>
>>> ?
>>>
>>
>> As of now platforms where the issues [1] getting reported are added, the
>> list will grow.
>> <We still have to evaluate and test on other non-QLI platforms hosted in
>> upstream [2]>
> 
> Do you really need to test, which platforms have an interconnect, or can
> you predict it by checking the SoC documentation? I strongly belive, the
> latter is the case.
> 

Agree, for interconnect path we can surely predict from the SoC 
documentation,
But for the corresponding FLAGS/values (MASTER_GPU_TCU, SLAVE_EBI1), it 
would need some testing before finalizing the change on corresponding 
platforms.

Thanks,
Bibek

>>
>> [1]: https://github.com/qualcomm-linux/kernel/issues/297
>> [2]: https://lore.kernel.org/all/a437f9f9-3560-40f8-85ea-35433e33c428@oss.qualcomm.com/
>>
>>> Konrad
>>
> 

