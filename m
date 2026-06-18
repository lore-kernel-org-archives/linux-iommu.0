Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28BED3BBFB3
	for <iommu@lists.linux.dev>; Thu, 18 Jun 2026 09:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781774801; cv=none; b=kq1p1T9ufSJ+EEERuoe7nmXgZS49slSCWiSpzvS+TjMDTlWxJpDdcd2nHj9z9gHnSUHaJYeOMQFb1aj0Q/ireKPCYVMGdLsVG7PhHU/bm/WfYpxTNYRmmdxma4SpthLwoUPCce8WmtmuyX0tDqncCMUDO5Y4lAzynvMIaF4DDv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781774801; c=relaxed/simple;
	bh=PQFzKq4u1Zz/DS7sc8HllALi6A+WiTA8yxPA4PvNbK4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DX0IBe1nRu44Hc/jaAi58LM3T49VDYB8NlQFeLE0Oiq5ViPdCgBvssAv3zII4kt7WHz24E2tVlCa8ysD82G42l8sZWDBQ6TqV747SQj2icMhSvyT7dlJhf46BgpQjgkjFMfEHJOHapjVpklSuNJ6iAIXwn8IeoFg1stL0G1uegU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=iaLU2eiK; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=WiuEiJqn; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="iaLU2eiK";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="WiuEiJqn"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65I8FudW1252624
	for <iommu@lists.linux.dev>; Thu, 18 Jun 2026 09:26:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ce3Ew1kgGBzVv6bcwdm6x/HblgO4rzUZSXd+QkZ2/04=; b=iaLU2eiKyGioQKfF
	/1fGySA5k47KEhF5b7rmC+ewjIjlpA8gHmg1f2K1rynLSajU8h3loDZFIzXimb7U
	5Td/y5PXvhBxvY7hi0F0W7TOoNeJsCTT3O8mfhL8d7pLvup+prt1hIiqJcn6cUmY
	OU17XVNl3Uevnom7ONAipUD/sFYQTqDwTrJI8K2SSViWZqze7un2V+JaK1/E18Ef
	JKwKRR5OVCcSvbUX8UkMQq7IGCWNAX8d3xtojTjKDlgouxO6hmsQ7F9yFHb04HJt
	fN+1MT/OC5Nt/WWguR4EMqsV8IqhFPFc3zk9Jmzp4XRq0yJ1UuCau4T8T/GDxd16
	ER0Jzg==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ev0g7k07x-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Thu, 18 Jun 2026 09:26:37 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-915976b2dffso15148785a.3
        for <iommu@lists.linux.dev>; Thu, 18 Jun 2026 02:26:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781774797; x=1782379597; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ce3Ew1kgGBzVv6bcwdm6x/HblgO4rzUZSXd+QkZ2/04=;
        b=WiuEiJqnu2+M9dzrBJqDcXKK18sGFseYIpUArBnSJZcUMTRn0SaqrvMpDOr/1QxpaG
         1YcPdSk0YbdLRyVmUZe+NRNeeKp7swhJ36v0rGHZJCFQPac/bbvrVC1lN/CMTslsbbiu
         k6f6vMLkCtSrXDWHTE8UtLPhGRzeFHNeWcrScCutVzovHQ+a3r5mteHCN7ro4HBFmLf4
         +UwQWA1mN7BuJOnLKLgUTAsFy0xROy70LRFeHObs4iG7y07BRA/imEoTXn2XgfP30Nex
         eRLKkCCYXOhAxbZDLvYYwgBLJtoRhofxw+K5X9b2RDFl4eWLFKN1ZYF2ZKpF3Puht2wJ
         49yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781774797; x=1782379597;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ce3Ew1kgGBzVv6bcwdm6x/HblgO4rzUZSXd+QkZ2/04=;
        b=PH5gih0CXP/2LKtMwDB4f9CUX6YiRePKCZsJVI8zMw+1qrEr54m+KcHdDutcOCP4YL
         Q2C6ql3E5F6njiWKNZhBz9W9ULtHIBZPO31EnJr2Z6FdbqvP02DN94xvMjgibdm1sJpz
         NXGoDZl9XdkQ4PblA3GBoZa8SzaHO/4UmPQVtQWwmnjhElgpxeQwSnWd2gC7v+rd/iE/
         C50xNIdOpkhakfB+jclyVJ8NVX/jMVoI84c8NF4L/KYPQuDrMRUq4YFnsIW/6zPKxieK
         3Ff7iDQzpMcue2z2YcjnrQpDmBB3PQBzTBRHW9CfTYSCVaXlqDD1O8AFGCY47YYz6UBR
         Ii2Q==
X-Forwarded-Encrypted: i=1; AFNElJ+hUCmTupa8E91gEQc5hBx5UZ1FUpPAQ9f+qHw0p1zYQ1x658Fxz5hWUaZcawJVj07MDV8Xkg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxYrSIgrdx8CGOGP3404mvVBAC+1ohCL9hJpO23W2ZCkr7viPJl
	C7zbmziUzk6hP+36cH0C343Bm4KfYkhvUn6r1nvZgjF6KTk3IrsZIHmmfZqzl5mHyZcjYm7qnvt
	pXs4Efuv4dgTlUqExt+xVYkFBSXFyUrCMKZmmOp9TFJrJgKGOIJmx/VPQag==
X-Gm-Gg: Acq92OErmfmaBDk4HKWMhqzlcdVcqwNoiKbSLyJ6BspDs9ZwKHvm8L+za6is+M82TI0
	+b2YMfhY/nBxw7jy8zHpAQlHdO18pEanUQRDAHX9L69tkv/bKFcx3EyEaMOBd/zzdpieUIvza5z
	wxfI/KRNJqWrcF3rJeJCuLdIhcfFb1esapj0PLvrCpehSyFv9m8V95k268bYtWMwdKBlZ/4JNHe
	ZGbbvQ57b+92k/EkfeH3zgzpmuNgEw9Hw6TuL2ZMLcm97K6uz7/cOcW8Ttu+ooELZM9BbJrRfn1
	+yOpkClTEQVTaMEsSehEHQRnjNHPvWTsuHD6SOq00b985jCiJ3JoaB3yRtlf+0iuUzZ+LP4nCx8
	6TUlL6UU4FO+hmg1E4THSEllG0LCjWFZ2rAQ=
X-Received: by 2002:a05:620a:458a:b0:90d:11b2:80f3 with SMTP id af79cd13be357-91f2b477d71mr290818085a.7.1781774797394;
        Thu, 18 Jun 2026 02:26:37 -0700 (PDT)
X-Received: by 2002:a05:620a:458a:b0:90d:11b2:80f3 with SMTP id af79cd13be357-91f2b477d71mr290814085a.7.1781774796807;
        Thu, 18 Jun 2026 02:26:36 -0700 (PDT)
Received: from [192.168.120.170] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bfdb83428a8sm925516266b.44.2026.06.18.02.26.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jun 2026 02:26:35 -0700 (PDT)
Message-ID: <3384ecdf-599f-4862-a3c4-9f54b4ddfe63@oss.qualcomm.com>
Date: Thu, 18 Jun 2026 11:26:33 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/6] arm64: dts: qcom: kodiak: Add GEM_NOC interconnect
 for adreno SMMU
To: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>,
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
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <26d51cbb-2d87-4564-b3c6-cc61ab900e19@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE4MDA4NiBTYWx0ZWRfX+1LpMaYTK9pf
 EZIm2bamfyG6rrKsRisOzglIWKu1Te7H6TjDB1jcZ6MnUplJzrSiQPGFs64SECR6mlh4qu85OeC
 qQw+VlQR7tgn96LT6jcMMeEpPRMIqxURy+D+3Kh6+3PnJAQ/65JZoWNt9u4DU7t+e4gz/A6Pmve
 Kg7NieMshH9PlHDITZgt1D0dsY76u0/Ax37cF+CE8DAQHz1DtyZT+kkcRXybK514MX1/JsnxjzI
 1EBnTsb+ZjB08YAG+lGhPSWKGqtOEbjo3IJS/ncMhEOxBsnSC/dgdXwMudDo9Sim3u3XbIzC6K7
 1DvuJGl/1nCY80muAFyzF5AzuvwdnuKl5E+F95yy8QgywuYRucynSG9VKM7K1cYA2k5cLqyMZ/K
 eQImnr77Zl0BdYV2KA9YBbYMtmhPcLcR4sFkKXnrBOV1L5IoLjH5a8jUuKgXljHmSm3kS/VyatR
 AEIn8gjw5l2kET+L+TQ==
X-Proofpoint-GUID: NLx3jYPsFQ1LlzxPotOXg5sS77xjniMC
X-Proofpoint-ORIG-GUID: NLx3jYPsFQ1LlzxPotOXg5sS77xjniMC
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE4MDA4NiBTYWx0ZWRfX8npcJo95OK5M
 ftF7maoY6yphT0NtN63WRsZT32hWQ9+QLhePkE9aQoKU9Q5stbvD4p0B6/gi6tnPleIIpZKwEUB
 OMizVgQkGGuNkviQU1waKu3iKbd3rOg=
X-Authority-Analysis: v=2.4 cv=YrI/gYYX c=1 sm=1 tr=0 ts=6a33b9ce cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=HaZQysj9wVKA4b69cM0A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-18_01,2026-06-17_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 malwarescore=0 bulkscore=0 suspectscore=0
 priorityscore=1501 impostorscore=0 phishscore=0 spamscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606180086

On 6/8/26 4:37 PM, Bibek Kumar Patro wrote:
> 
> 
> On 6/8/2026 7:27 PM, Dmitry Baryshkov wrote:
>> On Tue, May 26, 2026 at 08:12:04PM +0530, Bibek Kumar Patro wrote:
>>> On Kodiak platforms, the Adreno SMMU requires a bandwidth vote on
>>> the GEM_NOC path (MASTER_GPU_TCU -> SLAVE_EBI1) before its registers
>>> are accessible. Without this vote, the SMMU may become unreachable,
>>> leading to intermittent probe failures and runtime issues.
>>>
>>> Add the required interconnect to ensure reliable register access.
>>
>> Does it only concern the GPU SMMU? What about the APPS SMMU? Should it
>> be voting on other interconnects too? I guess so, because currently I
>> see that TBUs vote for various interconnects. BTW: should apps_smmu also
>> vote on the power domains?
>>
> 
> This race mainly occurs in GPU SMMU, where the GDSC can have an

Mainly or exclusively?

Konrad

> independent vote on the Adreno SMMU. However, the GEM_NOC vote may
> already have been removed by the GPU (or any consumer of adreno_smmu,
> e.g gmu), unless it is explicitly voted by the GPU SMMU (which acts as a
> supplier for the GPU). This mismatch can lead to SHUB timeouts or NoC
> errors.
> 
> Mostly this race reported in suspend/resume cycle (when gpu/gmu devices moves to slumber/suspend state before adreno_smmu powers down
> and the later doesn't have explicit interconnect voting).
> 
> In the case of APPS SMMU, such a race is not expected for any known
> use case. APPS SMMU is part of a shared infrastructure block, and its
> power is typically kept enabled as long as attached master devices are
> active. Therefore, explicit power-domain voting from APPS SMMU may not
> be required.
> 
> Thanks,
> Bibek
> 
> 
>>>
>>> Signed-off-by: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
>>> ---
>>>   arch/arm64/boot/dts/qcom/kodiak.dtsi | 2 ++
>>>   1 file changed, 2 insertions(+)
>>>
>>> diff --git a/arch/arm64/boot/dts/qcom/kodiak.dtsi b/arch/arm64/boot/dts/qcom/kodiak.dtsi
>>> index fa540d8c2615dc02d941eb16bc7253204c2750bd..eefa4b836a81374ff437ab4bbcbc3fecc1590ab6 100644
>>> --- a/arch/arm64/boot/dts/qcom/kodiak.dtsi
>>> +++ b/arch/arm64/boot/dts/qcom/kodiak.dtsi
>>> @@ -3386,6 +3386,8 @@ adreno_smmu: iommu@3da0000 {
>>>                 power-domains = <&gpucc GPU_CC_CX_GDSC>;
>>>               dma-coherent;
>>> +            interconnects = <&gem_noc MASTER_GPU_TCU QCOM_ICC_TAG_ALWAYS
>>> +                     &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>;
>>>           };
>>>             gfx_0_tbu: tbu@3dd9000 {
>>>
>>> -- 
>>> 2.34.1
>>>
>>
> 
> 
