Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6436C369D5E
	for <iommu@lists.linux.dev>; Fri, 19 Jun 2026 09:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781862715; cv=none; b=q6YvKf7H70s/y7X+OfIQCE8QrnSBFHlzkR6Iwi3bYHjQfiOERSmg+5wngw6VG3z1L3k4wKAg8pJ2ByB0JfGfkYErg9+MW5Z70dAQ452ZgW+w4L3v0WK+zVGru19eNPK+4htxPY4tyKi+A6FASc9Ew5lO+AbQ/OT7m4noqSEqdo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781862715; c=relaxed/simple;
	bh=/kWU03eUjVye6hhg9NUKgjZ45aHcq/mzn3B0UlaFXtg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l39coU8DOWf5ypFDa4tI2DVQ7VJN60H00TX7moLbYfmzpD9DApJyOAk7XVSsdrt2M2QunjfLANwrry0mt28Su9Gruh3eKgwdcfpjkPaWaeqzXb5Mk7QFe0vJaE0rpFPMFXqsBz2wjsAD88Oeo2HJ9fUcV8/Bqfq14ggfuTADBaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dTeWe7Q9; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=AQFFHYFZ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dTeWe7Q9";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="AQFFHYFZ"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65J9eaNK368238
	for <iommu@lists.linux.dev>; Fri, 19 Jun 2026 09:51:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	2h6bbHMCKo8QBg0xCoQbI1gK6dLPx7ToSsyB1dQ41Lo=; b=dTeWe7Q992PCmQNw
	hydDFe4n7/Yo6D2UA/JrjX3/IhxUSmsZVVbk5i1ysZYlHqaCPF3EZ9dMKSL4T1MG
	HJN27oz+qa7jBkUSXofWGEI1FJjmvfcYjn5YM0UjyzKRXZVVCy3aosCS+JRrK4o3
	afPUf9NjyWPv5iey0fT+oUBXfqJReZ+SNAj39a81jlfetUwSOkdU0M2kSyQoz9AA
	BOwMkQ7FjmKgkSdhmlP0KI06EYCtjGyNqEebk85hffhLSPekLwzmm0wMgg7kN1jQ
	j9B+r3lVZgqukv3PBezzIdvanCwccxLXVqrW3/eCKsTqPjVGi2KwHF3bbyHSqega
	Co7BwQ==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4evm22bf7c-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Fri, 19 Jun 2026 09:51:47 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2c6bbd0afffso39182655ad.0
        for <iommu@lists.linux.dev>; Fri, 19 Jun 2026 02:51:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781862707; x=1782467507; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2h6bbHMCKo8QBg0xCoQbI1gK6dLPx7ToSsyB1dQ41Lo=;
        b=AQFFHYFZxRjn+AzF/HEJKTU5lW5IFCsKjX8r0HfuoAlqkmRTBchmmCppBnmsc9o9mt
         scOmAksnyc98q67kqJekwJ7rymlufC/21tWA7CihNcj1I68u6JQSgbyCq23yQvkyJOQx
         uHNnTXekVkCkoHwGRM2OsCMbNIjJ36dTwD2xZIr1/5yBaA3MJlAxp93w0IpzDVBjZ8i1
         xEV3zZtv/jc5+dFlUCWxe1GXl4YidOCS2uvet5NRcyLGwti/ZZz6OJaWWr9iMOfLHEEI
         Sc2UggMyaPG6BqGdG1H3qWYP5NKxT02WCshDHocEFJzpi3cEZ8bfkV+lbcHbbq7IpcJc
         yVGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781862707; x=1782467507;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2h6bbHMCKo8QBg0xCoQbI1gK6dLPx7ToSsyB1dQ41Lo=;
        b=OPXYDHcKdUl0WplZ13WFocCsJBfidZWJxm1hx/pgo8hSqm4PQeQO9N2EvZXzrF3s0e
         vvwuOF93C3c5QRO6heFjTDWgd1TWVDHJEmusibrbgdIEhP7gXdms5zX71FgxVXTYy4C2
         bWSQU4QI+WPcfhEU/IW1RajPTPm8yvQi2Ab06b353sMwD5ssMZ2qjhEIT92HOQ0eJZmG
         wc8uBUbNhEGZeXg3HeObXgTP+PjFV9d2XcA3ZuDg2JpsnT9HyJ7LTZ+nZmYIwiwsot1H
         mvCAmkwstdpm6kxXSw0qZ6RXK5IOfwgAhHWi+jxOFaoneJzcfdMK8xuFfgSG4Bhs1YDF
         zURg==
X-Forwarded-Encrypted: i=1; AFNElJ89r0xe2MrNNjhvRB3nZ0wzPdDBsLywbeAEgNBL8qtUMPQEZ1JnkIceJ9Wrf0e+V/gTf9MAxw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyozQ5wd37hReslkd1I9/KB+fgAqnkP6SRjVaOUBtKQE8TUhdj2
	/8r2zhTFKw70YgzRLJiR1S82WdahelH9VEypP0iyOmq+IBNQr6d8ZxydEyRCTCyfF+QhH0tg6aD
	smpzlslHIhLt3Sb/CYHIWSxHcTeESFk97HiKvqqn3Fe13eozouzl3pMv5fw==
X-Gm-Gg: AfdE7cl6JQNRHiSuUSciBv1K9xyX2FCHr2O8KDwPO7P9TNc4ectEEUWbV6qmxJtGq+3
	9BkxeU0htx69nTGVXZTnl2V+78g8yheffZ7+Kl8kNjqU6n7585fRmRGKOmA4cbYOE996d3ZIaSx
	EmfUaRMOPCR3U+rY+2OF6wEhPLT1PZvKIuFwMkyYFFewajvZcXYonVb74PJKnp6XTHo5Z1TldXg
	eu47gCOQvl2Pqm1DF4rqoIyN4RKlNWOnodQHFzO6aF3pbTWiTO8bvO7BagN7eCPIOM093dT+HWJ
	7gnUB1b33OJStxI/LuJrqvC7wIhflIaZTwYmRpqH6I/ukkbMrut5smf0OVOQTmZqzZnEjVwVMkN
	0Xa8BnGFdjFkfspo7n/BMDTK2hn1TCMfa/VuipA==
X-Received: by 2002:a17:902:ec82:b0:2c0:cf44:3b3b with SMTP id d9443c01a7336-2c725d7c843mr21063475ad.24.1781862706868;
        Fri, 19 Jun 2026 02:51:46 -0700 (PDT)
X-Received: by 2002:a17:902:ec82:b0:2c0:cf44:3b3b with SMTP id d9443c01a7336-2c725d7c843mr21063035ad.24.1781862706405;
        Fri, 19 Jun 2026 02:51:46 -0700 (PDT)
Received: from [10.219.56.41] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c720c23b8bsm17913045ad.80.2026.06.19.02.51.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Jun 2026 02:51:45 -0700 (PDT)
Message-ID: <b8ef8488-7585-4226-9b8b-c79f8caaffeb@oss.qualcomm.com>
Date: Fri, 19 Jun 2026 15:21:40 +0530
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/6] arm64: dts: qcom: kodiak: Add GEM_NOC interconnect
 for adreno SMMU
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
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
 <20260526-smmu_interconnect_addition-v2-3-2a6d8ca30d63@oss.qualcomm.com>
 <p4xnrkcpbufkkbv4kq5civbt6hiwv3warrz7jiyinsfkihfedh@jfa7sgyzot6j>
 <26d51cbb-2d87-4564-b3c6-cc61ab900e19@oss.qualcomm.com>
 <3384ecdf-599f-4862-a3c4-9f54b4ddfe63@oss.qualcomm.com>
Content-Language: en-US
From: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
In-Reply-To: <3384ecdf-599f-4862-a3c4-9f54b4ddfe63@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=YN+vDxGx c=1 sm=1 tr=0 ts=6a351133 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=u9O3v9hlqvzur-BCVJ8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-GUID: Js6zrfN9fI__iyroyk0zfAf6v5SCoM6R
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE5MDA5MSBTYWx0ZWRfX5JzwzeOEzx3X
 1mArEY6napCtKX6SulsZ85lFRf4TDjtpWYk65Cv/KqQwmHIJaPHOl9zrQrIfRZSl2sg6koQV/3H
 MnGqTmjoLkD78uMY5QSuYEsqph/Wjak=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE5MDA5MSBTYWx0ZWRfX/b0nAJw8bcod
 mZ6VG0hdhz8umhikevHpLMxns/NozwIpgYiQQBPiyH/lpI+WljwjWxrOtU6Pc13vbzXtpsyENIu
 +jLlS6tKzKt2pBkEBq34jsgBNsLyKarZ0w9tC9tCOTgBItBkFxn7uZOfkK0XMon1esVidrgfzi0
 d3hffg0annuJC1eMXD5vBxI6ccX/5qraMc30NKzy3R05vufFreRnKEQbPQ5r8QejkcZ6U3z7CkF
 Gc94uBIJAzCzMJAZ+8GVzlL5Pud2rPYbFVaVsUHGbanVmiXGq1oY4avBs19IBQEp4DLvxVCN+k4
 EGPmENOTAkFm6qsByeBwFdOvPcdZ21UDJp++NXo6V8YPkhkMBiqYU1dvxlcBmiUtb1HXf+O5vM0
 1unRbdzqh0hM5wPp+grfBKM2hneDCeZNrwn+6Ud2A3+1yhCcbqj5lJb2JLI2zsL3wkDcpwwZPzO
 URDLUqJavwR45+IH1dw==
X-Proofpoint-ORIG-GUID: Js6zrfN9fI__iyroyk0zfAf6v5SCoM6R
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-19_02,2026-06-18_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 adultscore=0 clxscore=1015 impostorscore=0
 phishscore=0 lowpriorityscore=0 malwarescore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606190091



On 6/18/2026 2:56 PM, Konrad Dybcio wrote:
> On 6/8/26 4:37 PM, Bibek Kumar Patro wrote:
>>
>>
>> On 6/8/2026 7:27 PM, Dmitry Baryshkov wrote:
>>> On Tue, May 26, 2026 at 08:12:04PM +0530, Bibek Kumar Patro wrote:
>>>> On Kodiak platforms, the Adreno SMMU requires a bandwidth vote on
>>>> the GEM_NOC path (MASTER_GPU_TCU -> SLAVE_EBI1) before its registers
>>>> are accessible. Without this vote, the SMMU may become unreachable,
>>>> leading to intermittent probe failures and runtime issues.
>>>>
>>>> Add the required interconnect to ensure reliable register access.
>>>
>>> Does it only concern the GPU SMMU? What about the APPS SMMU? Should it
>>> be voting on other interconnects too? I guess so, because currently I
>>> see that TBUs vote for various interconnects. BTW: should apps_smmu also
>>> vote on the power domains?
>>>
>>
>> This race mainly occurs in GPU SMMU, where the GDSC can have an
> 
> Mainly or exclusively?
> 

It is exclusively in GPU SMMU as of now. We haven't seen any instance on 
other SMMU, e.g pcie AMMU, APPS SMMU.
Also as per my understanding of the architecture which i mentioned 
earlier [1], this issue will only arise in GPU SMMU.

Thanks & regards,
Bibek



> Konrad
> 
>> independent vote on the Adreno SMMU. However, the GEM_NOC vote may
>> already have been removed by the GPU (or any consumer of adreno_smmu,
>> e.g gmu), unless it is explicitly voted by the GPU SMMU (which acts as a
>> supplier for the GPU). This mismatch can lead to SHUB timeouts or NoC
>> errors.
>>
>> Mostly this race reported in suspend/resume cycle (when gpu/gmu devices moves to slumber/suspend state before adreno_smmu powers down
>> and the later doesn't have explicit interconnect voting).
>>
>> In the case of APPS SMMU, such a race is not expected for any known
>> use case. APPS SMMU is part of a shared infrastructure block, and its
>> power is typically kept enabled as long as attached master devices are
>> active. Therefore, explicit power-domain voting from APPS SMMU may not
>> be required.
>>

[1]

>> Thanks,
>> Bibek
>>
>>
>>>>
>>>> Signed-off-by: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
>>>> ---
>>>>    arch/arm64/boot/dts/qcom/kodiak.dtsi | 2 ++
>>>>    1 file changed, 2 insertions(+)
>>>>
>>>> diff --git a/arch/arm64/boot/dts/qcom/kodiak.dtsi b/arch/arm64/boot/dts/qcom/kodiak.dtsi
>>>> index fa540d8c2615dc02d941eb16bc7253204c2750bd..eefa4b836a81374ff437ab4bbcbc3fecc1590ab6 100644
>>>> --- a/arch/arm64/boot/dts/qcom/kodiak.dtsi
>>>> +++ b/arch/arm64/boot/dts/qcom/kodiak.dtsi
>>>> @@ -3386,6 +3386,8 @@ adreno_smmu: iommu@3da0000 {
>>>>                  power-domains = <&gpucc GPU_CC_CX_GDSC>;
>>>>                dma-coherent;
>>>> +            interconnects = <&gem_noc MASTER_GPU_TCU QCOM_ICC_TAG_ALWAYS
>>>> +                     &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>;
>>>>            };
>>>>              gfx_0_tbu: tbu@3dd9000 {
>>>>
>>>> -- 
>>>> 2.34.1
>>>>
>>>
>>
>>

