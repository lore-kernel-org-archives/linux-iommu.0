Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 699683FB075
	for <iommu@lists.linux.dev>; Wed, 17 Jun 2026 14:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781706438; cv=none; b=gW7HHM2tyahHjMenk3gEnlEVE37yOEIbEugGGSLdeeWi8mhjO8n89UVQR2V2x9L29ncpMDICo+8KbW4/SbgLe5LqxqFGKUssaSdkkBz/TkpaI3n6vKogUIclDZnJRWAoGyQ0kcjJgzBMxadTSa7JcYAfK9jxFb5gtSXrz9b79Ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781706438; c=relaxed/simple;
	bh=EFS4n9bsWshz3xpJubMewbsLXsLLgJQrJAAdzYyeyBQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZSqfmMh8jElhz59w4Q4BsqidfWUuc9stTLFtuP4u92d8DPALYsaVlTbLRlBxlylps/2NPrG0uhQRDNTOWZ7AvRfvdEFmQ7qOkm/FNfX7jxHhGHriQN9N3zRe8TgZS7v9dyT5VEXHprse0HGwiRSQJyhfYv2X9kOaftGG1Tk/K1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pYZpfHLf; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=MJdDXIpk; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pYZpfHLf";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="MJdDXIpk"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65HEEU3x2379646
	for <iommu@lists.linux.dev>; Wed, 17 Jun 2026 14:27:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	An9cH8kmtTF2q7rWAOFIO0E7HomTnjc+hT38gPN++VE=; b=pYZpfHLf8lAVSEK5
	oidekzpgaXG+tKHMKtwM4AywhOMkdMed2gpUy819AdhqlKGdmiwOOGDWNkm+WCaH
	BiI8Qsrnz+jMNq/0XNVobb307i89lGEBr7EaJhwLT8E614PEYN/jmyFheXY+BwWR
	MhpWfczEBmrZhZOxlB0Ylj2jMD2N6LuItHe7PPxr5odRCxfi5ihi7d/V1LVI+QP3
	Wgyt6abp7B2FzbjQnzYP8CdTCpD4g8JwjeG9IWWRRMhdBanLCUJx8YX+vhIv99rS
	2djDPxN5P7bfZEltrHtk1W6dQj3cgTTmsZOT3GpmGQ0P0QiBj5jKoKpBQbGf4Qu7
	5JDAxg==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4euef23hy8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Wed, 17 Jun 2026 14:27:16 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-37cc07f3e36so630574a91.2
        for <iommu@lists.linux.dev>; Wed, 17 Jun 2026 07:27:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781706436; x=1782311236; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=An9cH8kmtTF2q7rWAOFIO0E7HomTnjc+hT38gPN++VE=;
        b=MJdDXIpkstb/fFgqoMbSQETjp19JzCVsTak2TSenWhTcEe8txR56vweBrLIkqnTgoM
         xSgZWk5rvrJgSCYMsW+frSxxv4nFiZ1CqxgyIjnakhrtM154BlgDxhRCKKZcEjLB3yY8
         vfgokzcMs6eT6hng3fJy/jGiiOiQv2/a5ODG99Cm2jSKbjmsa6BV2EUZ3H7ybI+4dcpv
         tV9PNhvr1BSoFP04Cg+I8vj7fOuShuAgTK/tfvGAJ0rnV8XX/K7pjTAKZAm3Ig4/bcwE
         H8/aAYffJqSp41Jo/TySrIyqhWdwMv7dmHYaH50k/I2Ijz1sRvgACWmMOOvrSzBE++vn
         AfcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781706436; x=1782311236;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=An9cH8kmtTF2q7rWAOFIO0E7HomTnjc+hT38gPN++VE=;
        b=nAg4pMs2TT2A4RPxPnOlOaHkXWz82z+BW11kyyyeu+aokBvWKA1xpEm0C2yXlJKI1B
         sX+Pex4iYFz+PYG75f1KX+j8MLGlJBL40u8sXsHHn6ta5gpq1w0lODktwAiPLSqQfFzd
         ARYPr1vKG+B55PhD0ZaeeX6ST0ENQc4RPTuGuVirG+S3Hbsut7cQvuHeq6qdO957YLPo
         6vsAesexSShyaZbVw01TIsC9VwM2bKfdTpDAJzdhZSTgQYo/2UUsd3CFtu5Oj7rSmL9e
         gi3np35Nh95ww3tkdkgxCCrfpYFP1Y5gB510q+/sVOwtBAgrRru97gKhpvWPoVCJqdm9
         FAXg==
X-Forwarded-Encrypted: i=1; AFNElJ8whoAv8XkIomjIploWUN/xgnJL+tOLi56v3quLAt6IzH75fhNKR14benPJjtkzd0sGDJij2Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YzclAJ5u/GX6CGLi1VcsZ2EzxWmQla+MBI8SAxx5n51W6iA8FEW
	tzwhM1D17faeDYc5QmXrhGIxwpMx9CHqWPenAoS///yZDnwozs1BgrlE09F4mlbzbEEPEX5xIHt
	QR5oIt8wtSl2TWFeDSGfPzyXJIeuq04wEFkzuoNoFk34VReW9yJpeelUM7Q==
X-Gm-Gg: AfdE7cleQILJ55atNVxWwZwZp21YF9eXh3jJ+o4vFuWiASea8QpfnIk1dF97EUQJHnC
	hBJeTRJrvxR/l/Sg6KZoFfFGVpj+A5RIM70Zks9uoZF0bNGN6JXpDZy1gW2PwVSFyb5952/HC5u
	qDlRNEt2Q6gTEVUb5QQycx68vgIrB2n8qAYKPqwEq/cO86aXvYk+UkqtSgMPiFS+McJvdtQnKqt
	Gj3SqVwcmUawrg5hwwkbTRiyJgb///cGcjxIysYDSXob2AUDRIBNyzVgXtCqmRvO1oBjXeZdcof
	rrucP+RzbRD68QiQiPEP2p6BLYJm3Ww5g38vB3hTdW8ngLfYnJqzyb8QsxA/crv080sSCcY0mBA
	k0+mnwgKSXnYKmSj8v83o6OG3Gz9a/gD3CYhDr7I=
X-Received: by 2002:a17:90b:2c8c:b0:36b:a4c6:da96 with SMTP id 98e67ed59e1d1-37c94cfcb5amr3893321a91.25.1781706435949;
        Wed, 17 Jun 2026 07:27:15 -0700 (PDT)
X-Received: by 2002:a17:90b:2c8c:b0:36b:a4c6:da96 with SMTP id 98e67ed59e1d1-37c94cfcb5amr3893275a91.25.1781706435350;
        Wed, 17 Jun 2026 07:27:15 -0700 (PDT)
Received: from [10.219.57.228] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c8665186aefsm14340442a12.15.2026.06.17.07.27.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jun 2026 07:27:14 -0700 (PDT)
Message-ID: <ea345832-711d-4e32-af0f-bc74d8646aef@oss.qualcomm.com>
Date: Wed, 17 Jun 2026 19:56:55 +0530
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/6] iommu/arm-smmu: Add interconnect bandwidth voting
 support
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
 <20260526-smmu_interconnect_addition-v2-2-2a6d8ca30d63@oss.qualcomm.com>
 <7xfxlxfqjcqdzl6gckaoyy2ioefglc7bgi66yv5khrbl6fi2zc@ivtiukdaj4jv>
 <d25f24ca-5bb3-4276-ac8f-8340e8fb4ce8@oss.qualcomm.com>
 <sdm7sqiokmsgczeat2mxch42ois5rwabav6c5fm7abct2xoepf@j3kraqrjvpoc>
Content-Language: en-US
From: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
In-Reply-To: <sdm7sqiokmsgczeat2mxch42ois5rwabav6c5fm7abct2xoepf@j3kraqrjvpoc>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE3MDEzOCBTYWx0ZWRfXyk3iM4GLB5NL
 +zNku4pLdYGe0KjlihTImJu8VWjQG/8wNvbT3+sfz6bCXOiBs8GO1N5qzlGzZPMGpuhGrtBnqTw
 GSg6e+IAJE2BZoicJgbPTrlR4HyFQ28=
X-Proofpoint-ORIG-GUID: TQOVgpP9DnSYenDIbbPzQG0tChzTtbWW
X-Proofpoint-GUID: TQOVgpP9DnSYenDIbbPzQG0tChzTtbWW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE3MDEzOCBTYWx0ZWRfX/PlSeMoxVQaC
 p9cWRUPPRXZAWaBjfovnLjP1afd9F/lQqOZxPbB+ncJkvLY0ENS45iPZL+InDvCl9mZCY+Y2KaF
 3d1n1JDuYjApZi6bpuvgBaIYKQGR5IyiIlhuGi+CFkmQbxdNTBhcIj+6fKLSiduYbPdd90GVQPZ
 TGZ0qNOCURRHMnBlO4+WpgOCiYoFLU15mEtlHQxKLf3bj7EFmSE0RR7oKJEMB+vqvw4H02aDUqF
 TPKg5MHBLafNyUvioUtAizzRE8N+47OLj/m0wDKKhCSvpeTmnLLLtws52hJHAdDuar8xwQ5Toyh
 fWglhLSbtGjikY6EoFrdMNJop+R88L9wzqkB9RY/MkV/1QYszACnxeAH64a3wpP4vPV6AjIOlPG
 1G0nBdUHEHnjSxSxJ+aPg1i4enDTMG0enJu4PWCwRIf4kdHJDQOLi37k3PR5XNACUhUIHCT4WGd
 p8fAwM4z2V1pGxi5zJg==
X-Authority-Analysis: v=2.4 cv=acpRWxot c=1 sm=1 tr=0 ts=6a32aec4 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=C6ffOseXIbhiAUGq2Q0A:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-17_02,2026-06-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 suspectscore=0 lowpriorityscore=0 adultscore=0
 clxscore=1015 bulkscore=0 malwarescore=0 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606170138



On 6/16/2026 5:51 AM, Dmitry Baryshkov wrote:
> On Mon, Jun 15, 2026 at 06:36:51PM +0530, Bibek Kumar Patro wrote:
>>
>>
>> On 6/8/2026 7:25 PM, Dmitry Baryshkov wrote:
>>> On Tue, May 26, 2026 at 08:12:03PM +0530, Bibek Kumar Patro wrote:
>>>> On some SoCs the SMMU registers require an active interconnect
>>>> bandwidth vote to be accessible. While other clients typically
>>>> satisfy this requirement implicitly, certain corner cases (e.g.
>>>> during sleep/wakeup transitions) can leave the SMMU without a
>>>> vote, causing intermittent register access failures.
>>>>
>>>> Add support for an optional interconnect path to the arm-smmu
>>>> driver and vote for bandwidth while the SMMU is active. The path
>>>> is acquired from DT if present and ignored otherwise.
>>>>
>>>> The bandwidth vote is enabled before accessing SMMU registers
>>>> during probe and runtime resume, and released during runtime
>>>> suspend and on error paths.
>>>>
>>>> Generally, from an architectural perspective, GEM_NOC and DDR are
>>>> expected to have an active vote whenever the adreno_smmu block is
>>>> powered on. In most common use cases, this requirement is implicitly
>>>> satisfied because other GPU-related clients (for example, the GMU
>>>> device) already hold a GEM_NOC vote when adreno_smmu is enabled.
>>>>
>>>> However, there are certain corner cases, such as during sleep/wakeup
>>>> transitions, where the GEM_NOC vote can be removed before adreno_smmu
>>>> is powered down. If adreno_smmu is then accessed while the interconnect
>>>> vote is missing, it can lead to the observed failures. Because of the
>>>> precise ordering involved, this scenario is difficult to reproduce
>>>> consistently.
>>>> (also GDSC is involved in adreno usecases can have an independent vote)
>>>>
>>>> Signed-off-by: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
>>>> ---
>>>>    drivers/iommu/arm/arm-smmu/arm-smmu.c | 57 +++++++++++++++++++++++++++++++++--
>>>>    drivers/iommu/arm/arm-smmu/arm-smmu.h |  2 ++
>>>>    2 files changed, 57 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/arm-smmu/arm-smmu.c
>>>> index 0bd21d206eb3e75c3b9fb1364cdc92e82c5aa499..07c7e44ec6a5bd1488f00f87d859a20495e46601 100644
>>>> --- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
>>>> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
>>>> @@ -53,6 +53,11 @@
>>>>    #define MSI_IOVA_BASE			0x8000000
>>>>    #define MSI_IOVA_LENGTH			0x100000
>>>> +/* Interconnect bandwidth vote values for the SMMU register access path */
>>>> +#define ARM_SMMU_ICC_AVG_BW		0
>>>> +#define ARM_SMMU_ICC_PEAK_BW_HIGH	1000
>>>
>>> totally random numbers, which might be different for non-Qualcomm platform.
>>>
>>
>> Ideally, any non-zero value would be enough to keep the path active.
> 
> This is true for Qualcomm devices. However, you are adding this to a
> generic code.
> 
>> Here 1 Would be enough to keep the path active, but might be too small to
>> reliably keep the bus active.
>> Other is UINT_MAX, which will reliably keep the bus active but might cause a
>> power penalty.
>>
>> #define ARM_SMMU_ICC_PEAK_BW_HIGH	UINT_MAX
>>
>> seems to be suitable here to reliably keep the bus active by BCM
>> for both Qualcomm and non-Qualcomm platforms (with some power penalty).
>>
>> LMK, if you feel otherwise.
> 
> Shift it to the qcom instance or provide platform-specific values? (My
> preference would be towards the first solution).
> 


To support platform-specific values, we may need to introduce a 
LUT-based approach in the driver. (Bandwidth voting values cannot be 
placed in device-tree property IIRC ?)

Currently, all Qualcomm platforms use 0x1000 for SMMU ICC voting. I
can evaluate if this could be moved to a Qualcomm-specific
implementation.

To clarify, this applies only to the bandwidth values.
Since the ICC path itself can remain part of struct arm_smmu_device, 
similar to clocks and IRQs, as it represents common infrastructure 
required for the SMMU device.

Thanks & regards,
Bibek


>>
>>
>>>> +#define ARM_SMMU_ICC_PEAK_BW_LOW	0
>>>> +
>>>>    static int force_stage;
>>>>    module_param(force_stage, int, S_IRUGO);
>>>>    MODULE_PARM_DESC(force_stage,
> 

