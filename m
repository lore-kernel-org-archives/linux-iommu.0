Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C666D3E5A11
	for <iommu@lists.linux.dev>; Fri, 26 Jun 2026 11:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782473151; cv=none; b=rR/vJNrYz2szB2roziCsvTDcVAuCZLizcMndm2oHEdjGnbBECaottnnTiasa7fH3pDZDkWeInBSpOxjQMIvhKYUgLIe06rtXV17dOWZE3NeZOoc5WbIAtO1IW9VfTruKwWIOErAiCTd9DQX7KtaOH5i1nASS6BIcycQD8cDD06M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782473151; c=relaxed/simple;
	bh=ht/Pf4XLV9dCsPC42qhVTYRywrk/rJ1Q+lPS/ZazSqA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RYJuVq3c2zdiRhCT3cmHrMIgw0XrNtMh0GC0QFKGccNs1JRbOSJCNvUnFZLTG+rD2JHRU+xlVavEN1g5O7Lvp5GSU6DKhsXWrnHmIB819HNipvFZFnvCT6oPOnxUSKbxLdRe9ZSYcJaRzA/Wo8c3i7Ts4nUc62VTmtd5n8gwHDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nxse7MpI; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=iMTOFVa3; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nxse7MpI";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="iMTOFVa3"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65QAccPT1052663
	for <iommu@lists.linux.dev>; Fri, 26 Jun 2026 11:25:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	xp6BH1YDO1p6QN/66C7G3LI3oo+YrxYKt7PFYlnJB1I=; b=nxse7MpIWKwRS9Kq
	PzD23s235gtdv3TG4eC6YWz3k2Ihyta9XyWxIpJx0isDek4tTXfSirVc8FPCDjcB
	jX6CLqpCq3/OD/riyHZxJTUhQRDQ4sP5bC1lFI8zSjM3jhhxXBMFgq1rh4gdITVK
	j9KncVe/esV8QZcP679zaL3TW5K8JtvDPLTdY77yHkkhmWaKEbEnCeSJMoD6xpV4
	Xoon2A/LR+Vl1J4usG6/b7oyWWkAXb5rRTaCrzaI96OMu5cv6ureohlVfE88jZUa
	tBw2AERzFTOTifvxtrmbSZCoiGqnXtqcsdAIIZGasRE8Xx9zFzJg+Ips8o+76E8B
	jdZcaw==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f1ngggnpb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Fri, 26 Jun 2026 11:25:48 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-30c0d568830so3926723eec.1
        for <iommu@lists.linux.dev>; Fri, 26 Jun 2026 04:25:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782473148; x=1783077948; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xp6BH1YDO1p6QN/66C7G3LI3oo+YrxYKt7PFYlnJB1I=;
        b=iMTOFVa3FqSAVKoGoWJh5jyqIuhYj9kdc0jh+idrVxWHNlE3db4hZRhnOW0ejLlIYt
         5Tk3b1+UzLnnFwd7MGyiI9H8sjqxQl1/dCB241HZ3E7NbNOerN3H7aZcEWx0jHmXohV8
         RjnNYhaLhCG/rX736hIBJWMa5lebM90Cz4rlUHNreNWESJ05ffsT1KF224pOCG0fcJO7
         K094AXVvrsDOEVfJsiht92r5Gw15ZiIvTraW77hEbasYRb74DxaZl+cgWMiFlr2C5LfZ
         LPZrd63iihPbM8JlfRzykuMj5sV4gLW/gAfOKpydLOAvMHwQWEtwc2/vU2BN4dK/Mwrd
         tP4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782473148; x=1783077948;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xp6BH1YDO1p6QN/66C7G3LI3oo+YrxYKt7PFYlnJB1I=;
        b=LceN9C4+TRw0CW3srUTIvGV8Forz2IqJ+2vKWgOkXRAzme0HLY6EoXo1z2wC5maVn+
         RjwRiwXPZwmjsDd/6AktuOw+5R9BJAbS3g+3OyrSzwFTskspwvbbPnp6WzVgr2FrmoQU
         qTx7YIdUyhGvTC4aQT6hB9cjmn7YNDwrYnw2GtzvAnyUZwnp/bckh5MFq05DMzQoReOV
         WD5iwED3UTOQew9Kpf5Jax3UTG1TMf1BosuK8xWqk9HVv72ppOGS3qIKT+qQ8UoQdwEa
         u0BcDiFjwRCmKLqdRqbtG6dL2YT4JfYXvwdluDG2kKc406cgadU/eptmretetBOi5KDi
         GTMg==
X-Forwarded-Encrypted: i=1; AHgh+RqSSt+CiMTOycXuaedjaHtNkJAasVJ91Aw47ZD8fAIsv9FVP0HhhR6ylwziOhHt4KEB9Fvwrw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzKmxCb3SKrQukvVKlBHoPBgpzxeDQNQNDStwWUM/1OEfpOzoiE
	Wac+dVAix1DBAKZECN0ZACu7vhXIQN0cYqYDIBF/W56q/iLjPHomzuGULDc2SmtXAaiYteG8Wac
	K6aS3uIcXFrgIumfFrz5S+t6G+EMHQKpgd5MUwtbKR5kGoiS0UqrY/zytcA==
X-Gm-Gg: AfdE7cmx16vQtH1orvOBDLTIMb+qKahed9fI2Ail2ZrQAamU7SdVKQ6KdLqf52BxS+Z
	3aILq0cG0f73GKYOn8fhmv6Q37Wk+hhsM9zh+mJO7LKjvJQ3+4Ib99+eduVg1soHfWFzMxGgLpv
	TVvTAeGaBQCZnVbZ/4I+OBgQtJqijbkUZvO6sdeFumwLRoDvTGae4O6uAHWztUD09rJL/Xcsdb/
	R0UHYnueCCN4faTB/LY9UGbRrH8iDjKBz5Zqn3+SLcZoeroGBuNCaR8sqmSfzPCVl+MvWXNmDh6
	HhhdlOFrKSeCvl4RfuleZgAvu0c/FJO4wdIoi9jMY4vFPmlM4ItdmVkQ2yJ47kNoh7tU4jkj1Yu
	MDXNPGHUqHzQPq8UXNvvHgZkB27Jf0rTPEv8hgA==
X-Received: by 2002:a05:7300:fd07:b0:30b:d31f:1577 with SMTP id 5a478bee46e88-30c84e596bemr7352333eec.34.1782473147730;
        Fri, 26 Jun 2026 04:25:47 -0700 (PDT)
X-Received: by 2002:a05:7300:fd07:b0:30b:d31f:1577 with SMTP id 5a478bee46e88-30c84e596bemr7352290eec.34.1782473147186;
        Fri, 26 Jun 2026 04:25:47 -0700 (PDT)
Received: from [10.219.56.41] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-139d8f6d2e4sm17343537c88.7.2026.06.26.04.25.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Jun 2026 04:25:46 -0700 (PDT)
Message-ID: <abfc0099-be71-4e4c-abe4-e8341a06f15a@oss.qualcomm.com>
Date: Fri, 26 Jun 2026 16:55:22 +0530
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/6] iommu/arm-smmu: Add interconnect bandwidth voting
 support
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
 <20260526-smmu_interconnect_addition-v2-2-2a6d8ca30d63@oss.qualcomm.com>
 <7xfxlxfqjcqdzl6gckaoyy2ioefglc7bgi66yv5khrbl6fi2zc@ivtiukdaj4jv>
 <d25f24ca-5bb3-4276-ac8f-8340e8fb4ce8@oss.qualcomm.com>
 <sdm7sqiokmsgczeat2mxch42ois5rwabav6c5fm7abct2xoepf@j3kraqrjvpoc>
 <ea345832-711d-4e32-af0f-bc74d8646aef@oss.qualcomm.com>
 <299d54c5-fb93-47ee-9495-fbf48a3204fd@oss.qualcomm.com>
 <aaf4daee-4886-4214-a761-80545d2565ee@oss.qualcomm.com>
 <4f0878a0-2ab1-490d-b251-c6d68c4ee241@oss.qualcomm.com>
Content-Language: en-US
From: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
In-Reply-To: <4f0878a0-2ab1-490d-b251-c6d68c4ee241@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI2MDA5MiBTYWx0ZWRfX25vI7AFFmnOf
 Oe9to57w4BGRdGiU1qSn6Qz/bUBoeyC63338FvI5chvjM3jYNnt+SdRp+82/vGtxJtqsgzi94Qc
 TyYGJL/lfcpaPNgWG1+IVM+MKRpj/Kk84gB1HE5FrnShQNkZYNLK6kSl+eIAZKW0N8PivLdcmKM
 jQV1tDx4rFZqkY/hptCnvde/a8C7R8hGEXcZ1jgs0nACp9EbplGTK+lPje9+oGeHP/MtU2/bczX
 9H9AiVeWSYysxflw6sLCJWxLMdT6UraXXxo8p3yTlioYnRWyI2+DfZjghawi2BwGr0W7F02VAr6
 r2LzO1uf9QVVyEN2Q1w6ibvPCL3Csleu++4JDvO9fxmagNY7IUghMikcv49yhrvWOk84G5hnGuV
 VqlFQFrzzcV9+uijM+Rfz+I+rsIs8paWBrLBBv/JK9RofFcXUgw7fXJqhFmE6OLKTAKbR5hjQRx
 pH1Gbk868PCj8nn/QJw==
X-Authority-Analysis: v=2.4 cv=KNlqylFo c=1 sm=1 tr=0 ts=6a3e61bc cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=j3I-O8hsx3pVybSV4xQA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI2MDA5MiBTYWx0ZWRfX2JiSqxQNzlIM
 /DZHCjh397Gbyn2LrlQ4vJNgNMom8yrwFCdyPll02qp9HjsS/LzQIwd6617NKICCeKC8BeS2Dko
 0Tkojt5bfyh0aTkmm/Wml6uicRHMwOU=
X-Proofpoint-ORIG-GUID: 0ZYktjSimpdBi4fWu33ZgcdrT92qSBbh
X-Proofpoint-GUID: 0ZYktjSimpdBi4fWu33ZgcdrT92qSBbh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-26_03,2026-06-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 malwarescore=0 spamscore=0 adultscore=0
 suspectscore=0 lowpriorityscore=0 priorityscore=1501 phishscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606260092



On 6/25/2026 2:17 PM, Konrad Dybcio wrote:
> On 6/19/26 12:54 PM, Bibek Kumar Patro wrote:
>>
>>
>> On 6/18/2026 2:58 PM, Konrad Dybcio wrote:
>>> On 6/17/26 4:26 PM, Bibek Kumar Patro wrote:
>>>>
>>>>
>>>> On 6/16/2026 5:51 AM, Dmitry Baryshkov wrote:
>>>>> On Mon, Jun 15, 2026 at 06:36:51PM +0530, Bibek Kumar Patro wrote:
>>>>>>
>>>>>>
>>>>>> On 6/8/2026 7:25 PM, Dmitry Baryshkov wrote:
>>>>>>> On Tue, May 26, 2026 at 08:12:03PM +0530, Bibek Kumar Patro wrote:
>>>>>>>> On some SoCs the SMMU registers require an active interconnect
>>>>>>>> bandwidth vote to be accessible. While other clients typically
>>>>>>>> satisfy this requirement implicitly, certain corner cases (e.g.
>>>>>>>> during sleep/wakeup transitions) can leave the SMMU without a
>>>>>>>> vote, causing intermittent register access failures.
>>>>>>>>
>>>>>>>> Add support for an optional interconnect path to the arm-smmu
>>>>>>>> driver and vote for bandwidth while the SMMU is active. The path
>>>>>>>> is acquired from DT if present and ignored otherwise.
>>>>>>>>
>>>>>>>> The bandwidth vote is enabled before accessing SMMU registers
>>>>>>>> during probe and runtime resume, and released during runtime
>>>>>>>> suspend and on error paths.
>>>>>>>>
>>>>>>>> Generally, from an architectural perspective, GEM_NOC and DDR are
>>>>>>>> expected to have an active vote whenever the adreno_smmu block is
>>>>>>>> powered on. In most common use cases, this requirement is implicitly
>>>>>>>> satisfied because other GPU-related clients (for example, the GMU
>>>>>>>> device) already hold a GEM_NOC vote when adreno_smmu is enabled.
>>>>>>>>
>>>>>>>> However, there are certain corner cases, such as during sleep/wakeup
>>>>>>>> transitions, where the GEM_NOC vote can be removed before adreno_smmu
>>>>>>>> is powered down. If adreno_smmu is then accessed while the interconnect
>>>>>>>> vote is missing, it can lead to the observed failures. Because of the
>>>>>>>> precise ordering involved, this scenario is difficult to reproduce
>>>>>>>> consistently.
>>>>>>>> (also GDSC is involved in adreno usecases can have an independent vote)
>>>>>>>>
>>>>>>>> Signed-off-by: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
>>>>>>>> ---
>>>>>>>>      drivers/iommu/arm/arm-smmu/arm-smmu.c | 57 +++++++++++++++++++++++++++++++++--
>>>>>>>>      drivers/iommu/arm/arm-smmu/arm-smmu.h |  2 ++
>>>>>>>>      2 files changed, 57 insertions(+), 2 deletions(-)
>>>>>>>>
>>>>>>>> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/arm-smmu/arm-smmu.c
>>>>>>>> index 0bd21d206eb3e75c3b9fb1364cdc92e82c5aa499..07c7e44ec6a5bd1488f00f87d859a20495e46601 100644
>>>>>>>> --- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
>>>>>>>> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
>>>>>>>> @@ -53,6 +53,11 @@
>>>>>>>>      #define MSI_IOVA_BASE            0x8000000
>>>>>>>>      #define MSI_IOVA_LENGTH            0x100000
>>>>>>>> +/* Interconnect bandwidth vote values for the SMMU register access path */
>>>>>>>> +#define ARM_SMMU_ICC_AVG_BW        0
>>>>>>>> +#define ARM_SMMU_ICC_PEAK_BW_HIGH    1000
>>>>>>>
>>>>>>> totally random numbers, which might be different for non-Qualcomm platform.
>>>>>>>
>>>>>>
>>>>>> Ideally, any non-zero value would be enough to keep the path active.
>>>>>
>>>>> This is true for Qualcomm devices. However, you are adding this to a
>>>>> generic code.
>>>>>
>>>>>> Here 1 Would be enough to keep the path active, but might be too small to
>>>>>> reliably keep the bus active.
>>>>>> Other is UINT_MAX, which will reliably keep the bus active but might cause a
>>>>>> power penalty.
>>>>>>
>>>>>> #define ARM_SMMU_ICC_PEAK_BW_HIGH    UINT_MAX
>>>>>>
>>>>>> seems to be suitable here to reliably keep the bus active by BCM
>>>>>> for both Qualcomm and non-Qualcomm platforms (with some power penalty).
>>>>>>
>>>>>> LMK, if you feel otherwise.
>>>>>
>>>>> Shift it to the qcom instance or provide platform-specific values? (My
>>>>> preference would be towards the first solution).
>>>>>
>>>>
>>>>
>>>> To support platform-specific values, we may need to introduce a LUT-based approach in the driver. (Bandwidth voting values cannot be placed in device-tree property IIRC ?)
>>>>
>>>> Currently, all Qualcomm platforms use 0x1000 for SMMU ICC voting. I
>>>
>>> (you used decimal 1000)
>>>
>>
>> It's my bad, i meant 1000 only
>> (I'll check on the icc_bw calculation to get clarity on the values)
>>
>>>> can evaluate if this could be moved to a Qualcomm-specific
>>>> implementation.
>>>
>>> Add a vendor hook to arm_smmu_runtime_suspend/resume and handle it within
>>> the QC driver
>>>
>>
>> Just curious, wouldn't this apply for all the arm-smmu users in addition to Qualcomm devices as i mentioned here [1].
>> Vendor hook would make it Qualcomm specific.
> 
> You're proposing to use a Qualcomm-specific bandwidth value so that
> fits
> 

Got it, It seems valid. Will be sharing the new implementation post
testing in next revision.

Thanks & regards,
Bibek

> Konrad
> 
>>
>> [1]: https://lore.kernel.org/all/984ff9c7-3eef-463c-a330-bf7acd063667@oss.qualcomm.com/
>>
>> Thanks & regards,
>> Bibek
>>
>>> Konrad
>>

