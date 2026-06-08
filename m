Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B37723C4B71
	for <iommu@lists.linux.dev>; Mon,  8 Jun 2026 14:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780927880; cv=none; b=qBh7Ky3/LLkXOrhOsiaW616VnjNEmxcoeAKeXTbBChKJat22+6TGWnEff+g6V77hE6hXjAoJg8kVPVCQ68RRY79Gmj2MZmCYg3gAls5h0y4gqnWgWdQ8SQRStNgD5363g/cHOOQJzt+2m4f4Rdo4f6pgd8nNJDEe0rwzJrYGVFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780927880; c=relaxed/simple;
	bh=uTKV6IvjJ1GeQko3Bl8mkwJGsqYNN/GIKQopjyHCBRg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rVzAYVzcTudvwbulKGQhrptN7Y7FiZDtvN6m62clSysvMhAWkpQaq0GUox3sN60rPR/2VbdyD0WTrhXWTBu0Whg4QJkyXQ6C8UOXYoFQ0PZuKrqyXy73+E5jHwkN5W7w4qjssp6IA9Jh5eKxDBdApNytuL2KuPapxNXfvf9jgIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Qk4+vd44; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=FkBOzp1W; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Qk4+vd44";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FkBOzp1W"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 658DRNkU3764132
	for <iommu@lists.linux.dev>; Mon, 8 Jun 2026 14:11:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Ge2g3qS7PI9YZlh6sQweBknzqeDtO4thMflNb0ch+FA=; b=Qk4+vd4433uTNFtV
	oCiZat1EtNS/KU+LHkc2o12gHeB2kAsJqsNe/q/TJtvOrl3BCkqM9piH0YQbRW9p
	Lciw9X4jmk9dPS11xpiMpVh9ckzhX8ZXNw7BNQEf3BobxzcjXw0cTHQP0/s572Ql
	DrTGi0Ia3bU/QNQfGirm8fAGMNjokrcDyCQspK/Yp0Cklzt9wGhUW1zVJ1vc/vPi
	+PbU6NSaV06gM+p3bGFgm2qyYMWmxDf9yA2KOKd+C7dXrzVUGo66aCCWByVQmGg2
	65ccBHSW/5jQrotU96gkbShajrjTo4o2zVDI8g4bK8jPdOa3wolkwu5fC53Tyf3Q
	bzwUoA==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4enun8h309-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Mon, 08 Jun 2026 14:11:17 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-8428419982eso3758037b3a.3
        for <iommu@lists.linux.dev>; Mon, 08 Jun 2026 07:11:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780927876; x=1781532676; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ge2g3qS7PI9YZlh6sQweBknzqeDtO4thMflNb0ch+FA=;
        b=FkBOzp1WkdX9V/1aZlMsc1muyZI/TQ9OV9hlqnZq/WY0mcbHMca1EWmjEa1fpunUqF
         nNBJiBv7ad/fP2mhtHtNe5Bdact/xlJ2vxQ2m004pfk5xC+VUsOjth2dHAQZ8tgQ8cSd
         UoCYYwWTlhte5I4Pbtw5BUY5ySc3KhQUc1e/o1fv0dlziDS9KIJEzgCx5PIQQ46BFSRV
         YziTqx+Ja3oEYxngAKF0s1TDoT0YGc8WnczlysRVHDnx6Ne7PtjhIFkjbbSSg7mMmPi5
         OnR6zOVmcBOx9ny5ljnH/K+AYbKGAFpEyYZyiFRwyyZ/fETwxhSp9w9vh36dVsKpns3Z
         zJ+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780927876; x=1781532676;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ge2g3qS7PI9YZlh6sQweBknzqeDtO4thMflNb0ch+FA=;
        b=EfdL1B7haFi1R5FXqiqxjn5c8yXy1fUi9MqJwRipVc52GSfkvjV3uKKMLNxVvs1uKy
         RK0GQMfjVKhb6rhYcC76zsdo4W94SDX6cwvbL+NjF61dRBBW0j/z8CN5hyKTr053zB5j
         8jmpDkwNwL7OyoLGQCQTzoLdLVZ1SpZTs7DMAqOMEOx06c+6kLlPADJ7KkUl5ewiUPU5
         ZgXTnFFSRt+LUl/PG4i20MUP16fcjyhTreoMirqp6mVGZOUQruE3xfUPBe7rKQkRfIsb
         Sx22CWRt/ETEVeKaEdLZ/Eczk5nWS6ZZLxdVrzY90tpMc+63HrsV876X6Zvn/ABIGxTv
         nwmQ==
X-Forwarded-Encrypted: i=1; AFNElJ/vzyVTnQOet2xEdnumbpYrlMoaaTv8yzoalpw2J/zwXEVfGKmB7heqP88PiApxyAjovYHmDA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwnV2MmmsWkZfYkyj68D2uFjW73YPwvUaDWwEPiXg/Q6RefeW8w
	vgzp/CzNpzLXIuqdMCyhvXhVnDimoatO3oDFLinE2X1lo0BbarYxbI6+amFHh1sOYWS7G1IFSE/
	ulvfxQScvcdB/llL2X6fyaQ5iuxT/UAMhntKZASai9NOe4s+LT8m16SmPmSL9OAfW4g==
X-Gm-Gg: Acq92OFEJluI4Ag8xXPyU8zq5oRYuveajwadAC+QOliLH4YFnkXC48ijSF9iv4Eb8Jn
	SOWniX0U6zXLOqN+sb0qsWpQGa2RgYTlGrRNsRDwdryYCXHOc7dhWQETvnRekZyAKu8bRVwOSAs
	VUwPaklqk9m8tw5cN7C48X43iWG+8KoO124a2bNdnnYRx+cdbr7rqbpeF35diHU2wykd+9U0L5M
	3VAY4Y6uA3hlglOSoQJFWsxEFVFNuLg0hB9J9KuFICeKmeCubhCFj7xft/G1TpWytRpbdQN2QJF
	l7owZ1QdonyNKT/wwydIz1vKj8iVlzY6UvTuuBJYVuqYBhvIksLewVA2AhJ3qgGUMdkYJwf6xgX
	geyk+9h4D9CHWYcZtjjJKFALoOTQlWlu3cioqbWAy0BNvC5QpnV3CvApS3Mue
X-Received: by 2002:a05:6a00:90a7:b0:842:5634:3c1d with SMTP id d2e1a72fcca58-842b0e835d1mr15041546b3a.19.1780927876553;
        Mon, 08 Jun 2026 07:11:16 -0700 (PDT)
X-Received: by 2002:a05:6a00:90a7:b0:842:5634:3c1d with SMTP id d2e1a72fcca58-842b0e835d1mr15041493b3a.19.1780927876081;
        Mon, 08 Jun 2026 07:11:16 -0700 (PDT)
Received: from [10.219.56.113] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8428706fa9asm17907958b3a.45.2026.06.08.07.11.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jun 2026 07:11:15 -0700 (PDT)
Message-ID: <b0700a75-7585-4779-85b1-5c9a85958b92@oss.qualcomm.com>
Date: Mon, 8 Jun 2026 19:41:10 +0530
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
Cc: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
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
 <naa4rebf2mpn2uybjgmaidtni5fckbc66t2fx3tv3cfklfsnb5@op3qmkovxz7o>
Content-Language: en-US
From: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
In-Reply-To: <naa4rebf2mpn2uybjgmaidtni5fckbc66t2fx3tv3cfklfsnb5@op3qmkovxz7o>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDEzNCBTYWx0ZWRfX1GjekrdnooC5
 EuUDaM+M6WyD46HhKHp/pct5ad7qCSDjiKMoe7uVUWXTelk5eZJ6dHE3FqUrN29IMaw1oVES2C3
 4tC/AqhfCtoDolzHpXutBhXOj2JSSujcteuFZN2v/khAEfbSOBkEI8FjVFvRAdK8xQH5CUvrNqZ
 UyjHgoUlLIG/pD2Ms1Nm5edHBYvroJ9kPUEyj5oerzHSdU3oaFGsPTbsyBV9qD+Q7ZmHFUiOcL3
 vszEJ6DmAXBiKfpQTXcnFuUq/CRsPK7LikLe/COcsZNYJQD5LszT235nCACsngyHF0qfH8tbWdQ
 CFqsOJXrr7lP8uLUX7gCCCNuFoe2T+B8ih+bdtaaebzNiPC+2Kwxlf6uPcg0OgDX0dSRSKhmqPU
 gKbyhA7DwVBXDfnyPhm2PfrIydPR4o1Edwe33J91+SfcnPc9KUBx0YqgXWZGCE66wfA3PI/QcNC
 zZlxqFkKPUcHJn8w4VA==
X-Proofpoint-ORIG-GUID: Lop9PVNz9CFKRz5Itf3rHdgwun2S1vJp
X-Proofpoint-GUID: Lop9PVNz9CFKRz5Itf3rHdgwun2S1vJp
X-Authority-Analysis: v=2.4 cv=Z7rc2nRA c=1 sm=1 tr=0 ts=6a26cd85 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=nHMyhPlvQ-XDY_K2CzoA:9 a=QEXdDO2ut3YA:10
 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_03,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 bulkscore=0 suspectscore=0 adultscore=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606080134



On 6/8/2026 7:18 PM, Dmitry Baryshkov wrote:
> On Tue, May 26, 2026 at 08:12:02PM +0530, Bibek Kumar Patro wrote:
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
> Only these platforms have the interconnect which needs to be voted
> upon?
> 

Apart from these QLI platforms, sm8650 and kaanapali would also need the 
interconnect support as per the SoC documentation, but it hasn't been 
tested yet [1].
So haven't added it as part of the ongoing series, hence as mentioned 
[2] this list might grow to accomodate other platforms.

<The list of non-QLI targets to be evaluated might be extensive>

[1]: 
https://lore.kernel.org/all/a1db573b-bcb4-44a5-89b6-6d1c76f4a18a@oss.qualcomm.com/
[2]: 
https://lore.kernel.org/all/0ded611e-1932-470c-8e80-9a5e94268583@oss.qualcomm.com/

>> +            - const: qcom,adreno-smmu
>> +            - const: qcom,smmu-500
>> +            - const: arm,mmu-500
>> +    then:
>> +      properties:
>> +        interconnects:
>> +          maxItems: 1
>> +    else:
>> +      properties:
>> +        interconnects: false
>> +
>>     - if:
>>         properties:
>>           compatible:
>>
>> -- 
>> 2.34.1
>>
> 

