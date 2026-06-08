Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9F443BE647
	for <iommu@lists.linux.dev>; Mon,  8 Jun 2026 14:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780929437; cv=none; b=LatV1K+7gHBXsZzPrRsdtomxFb3zW445GrwmxI0q9UVDVCHXq/Fs3jpYKotUSjCA7ErboegwEpOV2agzZZ/f6fxA59dQLx1J1bukhfhRVTJqzcr9uW4Gl84Jnlp+JDvotvAxxLVv+ES8asF7tgkwj37qNFlr9layjn9fgHqMDtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780929437; c=relaxed/simple;
	bh=GhxPscyjTdRqvnuHsPORS2ylxlI4B7zrF6GCR8tfbkI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EITc5Y6YAKJu3G6QPwPtGtUQ+lamzNPc8N7rEbdueL0CZZesd7pE4+yfG1UkdvxP2Cznp2ueUjLpa3Kci6jjXNg/WOqyjxWYuizZVHByPhb9hbYYcsr3Dnhb62cN435l5p1J4k8/sQRjzAAm1KCAYe+eKJdOZtJvQ0CHNTovuZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kvp+drH3; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=dSS7jbUz; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kvp+drH3";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dSS7jbUz"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 658EXsKn3872648
	for <iommu@lists.linux.dev>; Mon, 8 Jun 2026 14:37:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	phyB/f/MmGVDBTTZHnGaVeW2BAL985CqIC01PeAdgi8=; b=kvp+drH3ktQlQkD5
	z97b6zFqqntjW16AtiJ6RlbqmRsNm2oc9usjfGX/TYZaEdbQ+Gw/k7ooh2n4YgOK
	TfUcrcjE/IRF0xVJrv8Sj3BtU7m2PZjQU88LLht8airbemCq9Dmgg0PF6uojBTg7
	JNfIGUSndCF6U+cRcHUJj2SPKkmG08vT6TGTNixBz9KDn3VyjPCDo/DehY12l+E8
	Q+on8JjHKEXqp3jgsezBzXIicBCmSYWlU0YxBM0EgfTehFcapN0lX6PujEI31n2Z
	jtH+Q4+YMZtfQDbxt+ApCFsvzjy5xzFh3EBtbiaCdgF3oUUUuc730yquXHZrJssw
	h5gODg==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4enupth6x4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Mon, 08 Jun 2026 14:37:14 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-8423770d72dso5722725b3a.3
        for <iommu@lists.linux.dev>; Mon, 08 Jun 2026 07:37:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780929434; x=1781534234; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=phyB/f/MmGVDBTTZHnGaVeW2BAL985CqIC01PeAdgi8=;
        b=dSS7jbUzvnKLjsJEXg3dZiTxwwPH2jNu8LcxXJ98yM3irLgkjlH4ZlzMkbmNy8s2LS
         axRDtt/Qve4FVqVMUo/LJlXBMMd4P25n87tRgSavIqKmNcUGPSyjwZ6C0CPspXfwAkba
         l7irAF5FzX8nZbOgxFdlfBZnGOwtHxqRwFUDGomn5FpezF07IqSwUR6GtYMKTxcurx8/
         i4A/q5P7yfIuggUK2ZTdlm0ZNUftlGsfZKPE+wMn1nMxptgj5EY7r2Jk5IlL7OoYVd5o
         dhVDtEDCki2AZQwjD+P7bl/IG+SKLfGuOlVi3zzMftqNdY0qRf3177P4MokLv9879u2G
         zEHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780929434; x=1781534234;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=phyB/f/MmGVDBTTZHnGaVeW2BAL985CqIC01PeAdgi8=;
        b=lby3GiYS1DdLIQTkqV8kjuUZ4LlSd8IONK9YAPtkDenKBOd/7qRbTxWAWM1Ygboqs4
         JB90XdCNNe/fQ2z45wycDqUyn1+XEpe3kdUeMzxQAufqrGejy3bpQ96GhZldWW/15rFF
         pI4ns9if6rE4GuC+7fbS/qnY2zB4fOJrfTB5c5wju7rngwdAO6ouGoztZb59om0C0099
         LeZZn1xNeuLWDxb5Tjg+Cyb9cWiwZsds6ka+VMyE3o8p1A60QAh6oJH4AVKOFnInqJ+O
         muhshMprEZScIYrm07m1GiLV3jMxjCfj8ICKPjpaRez9uTrMmaFJhSXBuNTnGGXY7HUV
         b1NQ==
X-Forwarded-Encrypted: i=1; AFNElJ+TgU7OedRRRKxDQlPtKsNe7zlhug+VGgtnpMbwsUZ+qO81i5+H2NnCTEygyzg2UY4BNcaCHw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyWWdzsi60+2Cicsvt2hs6azYGKf4feo2iZpP2Xa7Uye2dz7pcq
	BNCf8DJ1CSw0s8VN+iQiO4KCQcnBT2KnonjsLbOc8iwVevAewQ3Ads+CaeSB65JK49N7TuJvbFg
	7mSqAFP43sH7SuGyStBcvZeqrIcH+vl7s1F7WvBIOxIqNJZ5qPEcHDFEb4g==
X-Gm-Gg: Acq92OGQ3bt4s5YmjuIjmRHqfMd1jC92ccVfOIqnGvP4WewZ+CJTcHAzUn/2nKo7oza
	VZefCfFZ1N+rZ4hwAZJjJ+yL+yDLFg8yApcy8JgEzVZIAxV3IzSiLloHrWNmZ8z5lG9yr6eaNcV
	MNcDRgvHB4qKvfMs1B4W4JPy1DXnddk+EdACQg5d3k4eQNymlpufr6paCenbc/HgvXiN1oOktRD
	fF9u5fb0QILW7WpidxiESG1gMwutvyzSblzS66NvrDN5VhLeqPCglxGKRN8QEnYs+sN09ncBKDL
	hM09sHqAhiU8OHCbmD/J07ODSq+o8Vgfn6YrZ7FvK9qRH2Y+WQ2OCbuhM06MqFtualNzM1Mphp5
	fkIVgdUf7T7oSd6ZDJoA820+q2tpZpc4jPGAQr9DAS2XhqgI+KvJWtfVLmr6p
X-Received: by 2002:a05:6a00:4c0a:b0:842:708f:39a6 with SMTP id d2e1a72fcca58-842b0e1e208mr15671460b3a.10.1780929433671;
        Mon, 08 Jun 2026 07:37:13 -0700 (PDT)
X-Received: by 2002:a05:6a00:4c0a:b0:842:708f:39a6 with SMTP id d2e1a72fcca58-842b0e1e208mr15671413b3a.10.1780929433126;
        Mon, 08 Jun 2026 07:37:13 -0700 (PDT)
Received: from [10.219.56.113] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84282221470sm19692216b3a.6.2026.06.08.07.37.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jun 2026 07:37:12 -0700 (PDT)
Message-ID: <26d51cbb-2d87-4564-b3c6-cc61ab900e19@oss.qualcomm.com>
Date: Mon, 8 Jun 2026 20:07:07 +0530
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/6] arm64: dts: qcom: kodiak: Add GEM_NOC interconnect
 for adreno SMMU
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
 <20260526-smmu_interconnect_addition-v2-3-2a6d8ca30d63@oss.qualcomm.com>
 <p4xnrkcpbufkkbv4kq5civbt6hiwv3warrz7jiyinsfkihfedh@jfa7sgyzot6j>
Content-Language: en-US
From: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
In-Reply-To: <p4xnrkcpbufkkbv4kq5civbt6hiwv3warrz7jiyinsfkihfedh@jfa7sgyzot6j>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: TbRPj0cDniaWkwjE8do4cwJPkev8dIVd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDEzOCBTYWx0ZWRfX7XznRBKXmgLt
 VqvFf5X/qAHS3Q61LCBS8HtnZ4/1QaEUpYtH2/Tua2HNc5FSdBqh0lcCftFV9tgq2i2h+c2Wv43
 9NLebvda2iNhG0hlXD2/HuOPlZSXHBRPHJI/cPU2MRouZYFx9MxApbY9rIPE99uB7yzXnZtvf/j
 hteQKsy7R45YJms3eeZsoUThFL5K2jqHHERoTvRArqd9Gku81/26KaIEcrbsmqdzmaQhq5/PB0O
 Xn0VsIslFK/vYSTsMYHdwT/SvV/xw2KpOMXgyqOb5NmcRIkIqfmMfpynFCK/4Yk4Lc1a317lCXO
 z7T4lwRW/dwQ9+6O51me0AbDZygg2AXntXTnTMfhXHx6OHFqvndE/iviZkgejroX54XSTzJI+76
 gL8h6TW8FRcDV8FHVs+31zj/T66KV19N9uVwGRMdWpxLG5M+WPjKNJePK9cNF2QXxbj6BQxsdi8
 2P/us1KMc2PM2+m/HAw==
X-Authority-Analysis: v=2.4 cv=XKAAjwhE c=1 sm=1 tr=0 ts=6a26d39a cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=5xEeDdGLKqE-Cjx_tAgA:9 a=QEXdDO2ut3YA:10
 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-GUID: TbRPj0cDniaWkwjE8do4cwJPkev8dIVd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_04,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0
 suspectscore=0 malwarescore=0 spamscore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606080138



On 6/8/2026 7:27 PM, Dmitry Baryshkov wrote:
> On Tue, May 26, 2026 at 08:12:04PM +0530, Bibek Kumar Patro wrote:
>> On Kodiak platforms, the Adreno SMMU requires a bandwidth vote on
>> the GEM_NOC path (MASTER_GPU_TCU -> SLAVE_EBI1) before its registers
>> are accessible. Without this vote, the SMMU may become unreachable,
>> leading to intermittent probe failures and runtime issues.
>>
>> Add the required interconnect to ensure reliable register access.
> 
> Does it only concern the GPU SMMU? What about the APPS SMMU? Should it
> be voting on other interconnects too? I guess so, because currently I
> see that TBUs vote for various interconnects. BTW: should apps_smmu also
> vote on the power domains?
> 

This race mainly occurs in GPU SMMU, where the GDSC can have an
independent vote on the Adreno SMMU. However, the GEM_NOC vote may
already have been removed by the GPU (or any consumer of adreno_smmu,
e.g gmu), unless it is explicitly voted by the GPU SMMU (which acts as a
supplier for the GPU). This mismatch can lead to SHUB timeouts or NoC
errors.

Mostly this race reported in suspend/resume cycle (when gpu/gmu devices 
moves to slumber/suspend state before adreno_smmu powers down
and the later doesn't have explicit interconnect voting).

In the case of APPS SMMU, such a race is not expected for any known
use case. APPS SMMU is part of a shared infrastructure block, and its
power is typically kept enabled as long as attached master devices are
active. Therefore, explicit power-domain voting from APPS SMMU may not
be required.

Thanks,
Bibek


>>
>> Signed-off-by: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
>> ---
>>   arch/arm64/boot/dts/qcom/kodiak.dtsi | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/kodiak.dtsi b/arch/arm64/boot/dts/qcom/kodiak.dtsi
>> index fa540d8c2615dc02d941eb16bc7253204c2750bd..eefa4b836a81374ff437ab4bbcbc3fecc1590ab6 100644
>> --- a/arch/arm64/boot/dts/qcom/kodiak.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/kodiak.dtsi
>> @@ -3386,6 +3386,8 @@ adreno_smmu: iommu@3da0000 {
>>   
>>   			power-domains = <&gpucc GPU_CC_CX_GDSC>;
>>   			dma-coherent;
>> +			interconnects = <&gem_noc MASTER_GPU_TCU QCOM_ICC_TAG_ALWAYS
>> +					 &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>;
>>   		};
>>   
>>   		gfx_0_tbu: tbu@3dd9000 {
>>
>> -- 
>> 2.34.1
>>
> 

