Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7985397699
	for <iommu@lists.linux.dev>; Fri, 11 Sep 2026 17:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789148823; cv=none; b=Rj7Fl6xTOeLzYT9n0Uv39OTbhLJnrQluQF9Wir63tacavhLXKR4MPtgHpGl4+zyUet2qdsXepw9/mzEweIcSVYThQn3OSU7BwyHX9a+Ru22ZP6/81A+bGb63iN2b2BtyJcQwWrrqVDwuB8MLcziRE1KLHIEhq0GABoi7k/RFQ68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789148823; c=relaxed/simple;
	bh=8I8OglRCEAVJH2OPdrvFUHnij1NfmtFjfc83aLX5lcw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QYPvgQRGcSkHdQu16ksqlKkb1KAgIR1nSiODNo53BLfOpM91w04zqrGgOvVDZaFHPDjzFrOeaOEDzM/2QO1w53xcAUPmzFGVPU+r3uoX/HVY0ClckJZpAwUze0helSbY4ITrC1SyUUlwTQgxXWiofSfwC3NJAeR5987+thQNn44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hMEf0DKg; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=DZ1Lq/Tb; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hMEf0DKg";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DZ1Lq/Tb"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68BHWFXp809492
	for <iommu@lists.linux.dev>; Fri, 11 Sep 2026 17:47:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	fsgmAPw6yBdhTP5tdUXY2KIVjFb7ZoZOJkT3weJPqcg=; b=hMEf0DKgaxDLZHie
	OQN47RZMrFw779TQBk80AIqOD7gShUZcM6LuGVYVYAA4VtcEJiHzyGddDcBg/Ddj
	v2YS5fwDp6oYrrWwFcE6d0D+00mLZFJh/tj3F5orftjGseMWWq97HhL67aMpFjw5
	EcVpOGoHdHpDcEWTmvddvRGY3MrQBRVXqCdalF9O/bcY8S82IHvSXsyP0oGBUtmq
	UW+Xb5ZmposUlivB2+JJnyCE7G0HT52sKdkOC+g7mHAvdWjps5wXr/gtIOF36QuM
	zcS4ZvTHWJDT+uoYQVSghvWfgMU2F38zCLXejEuLd93NIhtpmSh2OQY8SfEHEujD
	9LdOCg==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gmnv20487-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Fri, 11 Sep 2026 17:46:59 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cc39363cc88so1274085a12.0
        for <iommu@lists.linux.dev>; Fri, 11 Sep 2026 10:46:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789148819; x=1789753619; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fsgmAPw6yBdhTP5tdUXY2KIVjFb7ZoZOJkT3weJPqcg=;
        b=DZ1Lq/TbwwyUaa8QnIJKZePovz7WvJeb8DzrIf9YNPubEYtC5fjeSltZN5WC2TEvBJ
         krRfkzaWfvXhYsp4mDC3hfHf3u8xYgy/e24dOcLa/JERUv0K0KC0cLaKm4vWPpljBQbO
         WOApNuRfEWC6so7BVDRwD7JvYZL/2Youkv6YG2UcM3IcMXp3R9Tc8Pn7KMoUhzdVFGj+
         PJR25iaOliu9Thgvj6zZjVNt9kM/NcjksXri47GEPE1QWgnQeuLbWygYee1ilHlRmesd
         ixh8HSSfGy/0ARTeffwkeK1QFqTnS0kGC4ECdjjzq+WTrWl/IZLNjvy23H9Br6L40LYu
         oZ4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789148819; x=1789753619;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fsgmAPw6yBdhTP5tdUXY2KIVjFb7ZoZOJkT3weJPqcg=;
        b=ofChEV7WscYD+Ge5fEQsqK+4Uu6mhO5bVDQjxeFw/skphzSjKGDQ98R/UkWON4DUbs
         u6ec+c9wn2lkzUWoXPAY1smt32uuwTaYEaES2nTrjtYZmcMUT+WzlupHW4YYkqoa2IgH
         PFR934xxTt+TOgVo3XgRUwyJdb1zh4v51qdDT06AwGLvJD2peS/SSpkdyCpcrG/gdQiK
         0fyMMAGmutOodEhiDxm5qBNaUxF4npI7zB2Mf15DG3s54Qe1MErpbTvgyxkzoXaT+uWa
         NjDtcgskB3oWPe9pllnCFelDaX66xP6lzJ73mZmgBO9H2z83crkpEXUAmHmVXmbPWaYS
         TuJg==
X-Forwarded-Encrypted: i=1; AKwUvBzJ+THjK1gBtu0CHB87ZzAiZ2Jxj+JzIaznVr8MoJxbqSLKl9/gm96JR15ur54axgWeovNMsg==@lists.linux.dev
X-Gm-Message-State: AFuF++lgRqt88QHUxoc31fsWbXcLJ/KTzYuw9a9vYHFIeiNO+1dzdAwv
	m96/hH7l/Yf7U0AaSHSlaF4qvekmlbJvWf+I79AG1r2K+RnY6TBpb0zCLZ7L7t8NCd7zFpH66aP
	eNgwQFvfE8My5hsqzFxaXaOYhJNIIucWdxqZ96tezuqxWC2vfQlym3XNKiw==
X-Gm-Gg: AYBFou2mulobnd+n6fNtaj169W+iF7NO4oMkU8AbfoX543RN7gpfOGEOCDJLpSRtjaI
	+5MQeSk4IzWbRwSx7SCR+ZKH4V9rurMnqPQEhyBmkTEWnUXoC3PC2wnpCeM7JobTJ3leX9bggpA
	yRQvyu8n/er3L9DozDBWKw61b015sf7XOKULiHCKDMrzn22WMCzRIabDzOD17ewuQhrwEvpVPa8
	PUZyeZ/1o9M1W/QOlkXFXsOPjOj9AQou7HWAY//BgQI7Z8qjGRK+FpMDac5jtocMq7/VFCrr83u
	CPIj9wTGRJdDnzZA2R/CxkLh4WdmnvWyoI3YM5THgsG2u3J3iG6skEEC0AiV1qW80IAJo8bpPy2
	pNw5NKuZZgcDjjySp+OOtVN+wMFZUbpsxmvs=
X-Received: by 2002:a17:90b:2f10:b0:38e:5c6:4db9 with SMTP id 98e67ed59e1d1-39d9becda16mr9589980a91.11.1789148818579;
        Fri, 11 Sep 2026 10:46:58 -0700 (PDT)
X-Received: by 2002:a17:90b:2f10:b0:38e:5c6:4db9 with SMTP id 98e67ed59e1d1-39d9becda16mr9589942a91.11.1789148818123;
        Fri, 11 Sep 2026 10:46:58 -0700 (PDT)
Received: from [192.168.0.172] ([183.83.137.104])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33ba4e5182fsm7928959eec.9.2026.09.11.10.46.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Sep 2026 10:46:57 -0700 (PDT)
Message-ID: <fb559fe7-2e63-4d20-b0be-ff788e742cfb@oss.qualcomm.com>
Date: Fri, 11 Sep 2026 23:16:48 +0530
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 02/13] dt-bindings: media: qcom,sm8550-iris: Add
 context bank subnodes
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Stephan Gerhold <stephan.gerhold@linaro.org>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, linux-media@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio
 <konrad.dybcio@oss.qualcomm.com>, iommu@lists.linux.dev,
        Daniel J Blueman <daniel@quora.org>,
        Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
References: <20260909-vpu_iommu_iova_handling-v3-0-2fe43ae45495@oss.qualcomm.com>
 <20260909-vpu_iommu_iova_handling-v3-2-2fe43ae45495@oss.qualcomm.com>
 <20260910-gracious-angelic-frogmouth-bcddc1@quoll>
Content-Language: en-US
From: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
In-Reply-To: <20260910-gracious-angelic-frogmouth-bcddc1@quoll>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTExMDI0OSBTYWx0ZWRfX3HwgYPDeL2tX
 04HBfKeVI+MXdw0c7M/onRnJ8K1uwKNrWA+M01CEzo/kUlUsn5MNITAeaCBjSLpY5gohnoEzGOd
 HBVQVYrUOLNhX6op+TcQOddYLanjISM=
X-Proofpoint-GUID: z11wbWuS99loayrtb93b6I7wdPomzGDe
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTExMDI0OSBTYWx0ZWRfXxnrFDc7Uhvwp
 GsiKq6Q0EiTQ4lqufcq6+9AITJwNmoFwW6288L1WiKIjnIl2JoWMDRC13Iq+bwlUQFHqVr3RWdv
 8Q4W6dVgyuVN22ejqBdP4NkLb9MikNJNd4eZVAhoR490+FjmXzvhz1EB6ZpAlIhUe5qbh347Uu7
 Hjyim5jFFp0M44P9x5xS/5SgLVTj9cdEzcSO55hW2YLBHjv2KQkuVvAJUwtzcGgbvh3dF5EJ1Li
 y9ygZ0YwkRWpCX8+0435K9aolArC4bCySPRELaKTQig+eifAc213Z7FRsBikf5d4Nunx7ON7yxH
 eitxWgwRY8TRYw80GqZTdTmL6E7eZLP4+Ce8c/VC5BJ8es3y/MGgPCcd8oUN0bk5deixjJ5tVLt
 Del9xqZ8PZXZnu1Le5Q83IgFGbl0LCQo0GhO4VeOxsLon/jrwNMZcit+nE/LWHaFDmDF+klTp5Y
 G4VuRuFFCOuXCpT1TGQ==
X-Proofpoint-ORIG-GUID: z11wbWuS99loayrtb93b6I7wdPomzGDe
X-Authority-Analysis: v=2.4 cv=XvdvqlF9 c=1 sm=1 tr=0 ts=6aa43e93 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=TwCXObd+TJU0JWB7kQOUgw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=e5mUnYsNAAAA:8 a=VwQbUJbxAAAA:8 a=NEAV23lmAAAA:8 a=t9ty7G3lAAAA:8
 a=K3eY9hOJoobCHU9vVZQA:9 a=QEXdDO2ut3YA:10 a=bFCP_H2QrGi7Okbo017w:22
 a=Vxmtnl_E_bksehYqCbjh:22 a=CsAS6f0m0zARWR-uHzm3:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-11_06,2026-09-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 priorityscore=1501 phishscore=0 suspectscore=0
 adultscore=0 malwarescore=0 clxscore=1015 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609110249


On 9/10/2026 12:30 PM, Krzysztof Kozlowski wrote:
> On Wed, Sep 09, 2026 at 08:27:09PM +0530, Vikash Garodia wrote:
>> The VPU issues DMA through several SMMU streams, and the hardware does
>> not give every stream the same addressable range. The non-pixel stream
>> cannot address the low 600MB of IOVA space, while the pixel stream can
>> address the full range:
>>      +-----------------------------------------------------------+
>>      | non-pixel stream addressable range (600 MB - 3.5 GB)      |
>>      | 0x25800000 - 0xe0000000                                   |
>>      +-----------------------------------------------------------+
>>      | pixel stream addressable range (0 - 3.5 GB)               |
>>      | 0x00000000 - 0xe0000000                                   |
>>      +-----------------------------------------------------------+
>> A single "iommus" property on the video-codec node puts every stream in
>> one IOMMU domain sharing one IOVA allocator, so nothing restricts a
>> non-pixel buffer to avoid 0 to 600MB. Once an allocation lands below
>> that boundary the hardware faults, which shows up as unhandled SMMU page
>> faults and spontaneous reboots:
>> https://gitlab.freedesktop.org/drm/msm/-/work_items/100
>>
>> Given that the address range restriction is for specific VPU stream, it
>> should be ideally be moved to that stream. To achieve the same, a subset
>> of streams is now represented as subnodes, so that each can be
>> associated with its respective addressable range. The design was
>> discussed and agreed by mainatiners here
>> https://lore.kernel.org/all/c7b956a9-d3e8-4e18-b780-5d08f5cd2ca1@kernel.org
>>
>> In the past, this limitation was addressed with an iommu-map approach,
>> with the iris driver dynamically creating the devices. That approach was
>> later concluded to be a hack to avoid having subnodes, and was NAKed by
>> the iommu maintainers. It was discussed in detail here:
>> https://lore.kernel.org/all/c7b956a9-d3e8-4e18-b780-5d08f5cd2ca1@kernel.org/
>>
>> Update example to the subnode form. Doing so, it picks up the supporting
>> properties needed on the video-codec node, address-cells, size-cells and
>> dma-ranges to declare 1:1 DMA translation into the parent. Given a soc
>> with address-cells and size-cells as 2, update the video-codec "reg"
>> accordingly.
>>
>> This patch depends-on:
>> https://github.com/devicetree-org/dt-schema/pull/207
>>
>> Tested-by: Daniel J Blueman <daniel@quora.org>
> 
> I already asked at v2.

Sure, will drop the tag and dependency PR will be added to changelog.

> 
> Best regards,
> Krzysztof

