Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AC4E3E0724
	for <iommu@lists.linux.dev>; Tue, 19 May 2026 13:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779198820; cv=none; b=kIQ8RRJgnpyaqjH/EOKj0BPlscyQYJMU9vqeJyIugMCEKLxO6e7OQFkdPhbCQsXqYNGYrDI2Q4vX+XIt7U77N8qiK12pK0buFqiz3jNE3rYjI1PYiOQc0w+eqEgl9xPx3g05x78aaFNsQHZWdY7VcVa/0/grN00ycxtH0/CIr28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779198820; c=relaxed/simple;
	bh=HNcI1kNzIGfM0x3r8RbKIKrdoY5+TDkvSLJtco1ZEO4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Knze2SYbuk15xK9IGkIi3NUy7Wzm9MyNeY8gezRBbiK9hR0gxuqHcyCCEwtSFEZk4jB+jqGMMhhybKc9HmYbAUX/wJG3uBzOt9wwoKAYR6rdYyJNDNRt9PRHRR2yDdBPz5zhwvwzccq3JN+D8wKyns948G/1N0mb9h89EMOCLAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XBxhJYGQ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=gfCV9PPH; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XBxhJYGQ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="gfCV9PPH"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64JDVOAY2975785
	for <iommu@lists.linux.dev>; Tue, 19 May 2026 13:53:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	SHd/seu6GWeewtLPWuKEX1k3PpnC+gd0X961ojf5+Tc=; b=XBxhJYGQgHoNEFMl
	89KArmF0aZ/h9a2LoUeXhUrYySj9Y1oaF8J8BR7JC1ZWz8QTTHnSksW4EhBh4Jbx
	9OTdEZVwd735yccEBgkFaekYCtS0lESzk8YcOQAQsC/9J39+sSF5e87uI8Wwjj57
	weG/UlD/ZpTD8XudL+6M8ErVvAKzawCgqfi0PMvU7lFe+4+Av3jE/+PvpdH6A6Ce
	IQvAM7Sw8DTDoG63APSaxxA0faWxLTZU7ywBpi8xuezyMq9ggYz3s496JfVfVwsH
	QEchz1Y19grGgFYd87dOHI+0Ji4EMTLBAFW4t5lm/yMpWafVph5RTGdfcZiU5X1J
	Lvag9g==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e84v4ct0y-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Tue, 19 May 2026 13:53:38 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-367fd7b8825so3543604a91.0
        for <iommu@lists.linux.dev>; Tue, 19 May 2026 06:53:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779198818; x=1779803618; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SHd/seu6GWeewtLPWuKEX1k3PpnC+gd0X961ojf5+Tc=;
        b=gfCV9PPHBKFIY4wjDkBjC6zgZQHLa/NOZE0I1ETIXIeSTM1FHrpMydaxPXKo9G8wwV
         bpx91TgTs+Y3Cw2fXOWJQ/QPifKZJHSPFTGKXiS+oHPEIEVhEaqSQfr12cP6a9EHRjRn
         f8cX3kZGFDvAn/vvnjZlSvceVQDjhOxZ/XF9AfV6Y8jPsLitehf3gNs+jlkgy865HpsW
         XbJ8G5OW/EjmeV4E6PI0DfGBxj+6EqqMzxw80/i5bhLXDdua8lJ9DD4LhYRWNqkXy2ws
         myup/FCqCV8TOOEU/6kC0D52VHK2jsNMhEsl7VdVak7esLeKFQ80EChqfwJbpEyMm9mS
         WCYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779198818; x=1779803618;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SHd/seu6GWeewtLPWuKEX1k3PpnC+gd0X961ojf5+Tc=;
        b=rQIB8SXr0YGNSgfIWyQ5B4F/ctrrLvKQC0d7F1E0v5UMYJ7BP5Sl9cProJ46RW47x2
         hsXFI5bqkOE6mAp61m19nYLeZWrJ57Lan6PhabrUQ0fyjzRxFFQQMtXjzJU3awm61FKf
         Pf+wROhiswMAvROqb7cFbcO33Q0OWpdaN3+BdAaGQhn1U2lmdo0pKAsW3zgmOhjq1DuA
         uM5tnztMUOcc1cs5ocL/4BiQC5eOXcBdJbdNerjyoaTjM9hLCj+ivIkZ2OFgCjCBflcJ
         4JEPejz/lxXkZkr/1DQcv10X5gQgHDNLM+cT+s0sadZfMQ8gFJ4sNS2++mpKwb2xohoD
         NWVQ==
X-Forwarded-Encrypted: i=1; AFNElJ8Ocmj47hevvFNV5coVjQYyTfP/t7oXrleK8Z4A0oFmKS4RlStuNvF48Hk/SA11TOAaiNv3uw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxVK5PoxYRDuDbectUhLF6U0gdyAXGkZB7OVwc6wndzlggJ36/W
	2wETlQSFPzzJ8NdGpEyPmDoGfjH5x4XpEgQKRt1u+/rQ36nVyxlwOZdVT+kyIGMjvta77vSgNFj
	OWNj/vRvItaDbzDRv15VXZ8z7R8yiFcPTg7kflPKgZMMZdldhM85uG50/QSIwyEsQ6Q==
X-Gm-Gg: Acq92OFgo9JYwjRFyvvqzW7xjETVUA5fzdGFD0TOlI9ZxB8QpwtJ7Z05vLy6J2Xsdfb
	MdPOMx6YBIIlmsGloULJqX0HR/6ym3KyM+EfBVAJfaxJ+Qh3rYUYZ0uHxlqobbsyDoDlC0/DV36
	iK4o0VpxvKVGGMEzOFbRKMTHjYVYQPIy9hYF8S8s1mcs4P3C2CY7gvJ78dSoUj7aV4aR3GKBkqa
	gqcPjzdeOMkvPDKnDKaQn925HqOiZd9h3eqWWLlbhx2yNlNtC7ZAIgjaYFwgooYAgzMgxB96yV4
	+jTb9dTBmT74BTuqXuKzSUXDfM6zZL7Wq+1jkMn6CBcSe+l5SHFWOyuKkme4PyzJEonnoUp7zg9
	kFXS+tHVCPBtBOaktGIX67pEVewndzxeFwLEmbguqadJVtFgl
X-Received: by 2002:a17:90b:3505:b0:368:9da3:c496 with SMTP id 98e67ed59e1d1-36951ca7638mr19545335a91.24.1779198817950;
        Tue, 19 May 2026 06:53:37 -0700 (PDT)
X-Received: by 2002:a17:90b:3505:b0:368:9da3:c496 with SMTP id 98e67ed59e1d1-36951ca7638mr19545289a91.24.1779198817413;
        Tue, 19 May 2026 06:53:37 -0700 (PDT)
Received: from [10.219.56.98] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-369c4bb4d4dsm3568780a91.1.2026.05.19.06.53.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 May 2026 06:53:37 -0700 (PDT)
Message-ID: <a437f9f9-3560-40f8-85ea-35433e33c428@oss.qualcomm.com>
Date: Tue, 19 May 2026 19:23:09 +0530
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: iommu: arm,smmu: Document optional
 interconnects property
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260516-smmu_interconnect_addition-v1-0-f889d933f5c1@oss.qualcomm.com>
 <20260516-smmu_interconnect_addition-v1-1-f889d933f5c1@oss.qualcomm.com>
 <20260518-mellow-robust-caterpillar-93fcaa@quoll>
Content-Language: en-US
From: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
In-Reply-To: <20260518-mellow-robust-caterpillar-93fcaa@quoll>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=VJPtWdPX c=1 sm=1 tr=0 ts=6a0c6b62 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=E2rNws97cCCTNOQwQB8A:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-ORIG-GUID: ZByfI61RYmC7zoghvlZbewR_e5ww3VaV
X-Proofpoint-GUID: ZByfI61RYmC7zoghvlZbewR_e5ww3VaV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE5MDEzNyBTYWx0ZWRfX4euqC9HqbU2I
 MyijdGOE6sHbg4rSnu64MeCRbA7C/8gHdtCbc037FmjJV5NpnENv18B859+YNyo04rJaA54/iCR
 lvb1i2xWSwoIWHynU0rwLhr+PNZnWHRn4zILSHyirC58ieOrolDLe9rZKTSWTfeLJXhO7HrKutC
 XcHYehECDi+3x6C9sJSK7y0yfS5LPizWLqkdlEW6R39So4//wx5XwE9FAv6JWLeZsDpHcE0NPU/
 W7PywfrDYkYMKTq6DvRxgO2cy8BMZU2+8UMkCQTCNBsbtyzFW+CKssPzIYws3UJHfIn4dptAJyC
 7IJSAqQncuJ0KQucfs6yZHK40oxOk/cQRaPlch0vc6Sgu4xh+jA2iU0cTMFsEuKrPPNPwnrZQpu
 thtbYcl3Z4MDUTMgXlW7pxtFBxiIWehvsZZzrWvE9te74TM92uys97g5B/KlBia80sAGMUL3lVL
 F0oRM7RWu7P4bvc9AFg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-19_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 adultscore=0 malwarescore=0 bulkscore=0
 spamscore=0 suspectscore=0 lowpriorityscore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605190137



On 5/18/2026 6:03 PM, Krzysztof Kozlowski wrote:
> On Sat, May 16, 2026 at 06:04:03PM +0530, Bibek Kumar Patro wrote:
>> Some SoC implementations require a bandwidth vote on an interconnect
> 
> Then this should be disallowed for other devices in "allOf:".
> 

As of now, we still are checking which all SoCs do not need this 
interconnects field. So would we need to add the allOf here for now?

>> path before the SMMU register space is accessible. Add the optional
>> 'interconnects' property to the binding to allow platform DT nodes
>> to describe this path.
>>
>> The arm-smmu driver uses these properties to vote for bandwidth before
>> accessing any SMMU registers and releases the vote on runtime suspend.
>>
>> Signed-off-by: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
>> ---
>>   Documentation/devicetree/bindings/iommu/arm,smmu.yaml | 9 +++++++++
>>   1 file changed, 9 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
>> index 06fb5c8e7547cb7a92823adc2772b94f747376a6..5cbf944f2d3e178b3723d4dbaa19ee0d33446979 100644
>> --- a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
>> +++ b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
>> @@ -243,6 +243,15 @@ properties:
>>       minItems: 1
>>       maxItems: 3
>>   
>> +  interconnects:
>> +    maxItems: 1
>> +    description:
>> +      Optional interconnect path to the SMMU register space. On some SoCs
>> +      the SMMU registers are only accessible after a bandwidth vote has been
> 
> Drivers are irrelevant here, drop. Also first sentence is redundant.
> Schema says what is and what is not optional.
> 

Sure, got it. I will remove the "driver" quotation and "optional"
wording from both binding description and commit text.

Thanks & regards,
Bibek

> Best regards,
> Krzysztof
> 

