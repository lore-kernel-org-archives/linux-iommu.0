Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07B9C384242
	for <iommu@lists.linux.dev>; Thu, 25 Jun 2026 08:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782377234; cv=none; b=MCGFXUQoVoG5hw5Np9asWlMkVi78dDmgK4TppbKtBLgRpsfWGWw/yMo9fgV076HZxL1stSWQroU+c47tw2/HJ0IxNJcFWEnqEfcNzfaCx3gPJUCHpxbnatFU3IhKJzJIgLoFcp6BmbDUR0ls784SepEn1IBCWIRllUtsZ//NC6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782377234; c=relaxed/simple;
	bh=YfRm1dMc4bpEJ3h6zXF9W+esguXRxP5DncHgBWv5vVM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nua5oK8bz5auJmc6bjFNJFukJ65mBKnd5yf0aWsYoIQb9VgzQEoz8VnwhuZxpjVXCTfjFE4C46id7N6ooKCvuShnyA7tj33QfvFWU0/Xtbji6HSWDN8XZcl2dQwtkL4d7r8kURmUHEzLbJjq+pwZuxS4DuzUP1TJP5Dq6yCPtDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BfX/MfuP; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=N8UevzZl; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BfX/MfuP";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="N8UevzZl"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65P75Mnu1009168
	for <iommu@lists.linux.dev>; Thu, 25 Jun 2026 08:47:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	MIZ+Uqqvmj3NIegJ7KZAdRkOcTSWSNArKesrmTVP7Cg=; b=BfX/MfuPWOPJJyxT
	YOTO6nsCRHX+zeMD6KtqzRyVyGCRUJ4TQKzNQrLPCmnLBHUuht8vCtHHpc4L0rpU
	vf1QKuwZWrxLyzixIewYgd2CP5b3mtrE3qreJKbhQBi07drl0je6K/U4TjL58bNv
	j5lrRbL7sAZIDKO+NGENnCBeMS23PkAjP724b1jyX4imrgP0JaWK/+hmJwO/0NUu
	YyCBgFCWp+BVEdOaWC/6ff+JZIoslZ/GB9xTv3exeirjLWB6ak+/IIz2gpZt64ad
	KPjiBmwcIRkO2lDOkaBCSE4Q7NGEUrilla5eOvUhRIRZ1+6NrdWrx6P11VMnxjRK
	Fs+m7w==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f0ymv0cr9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Thu, 25 Jun 2026 08:47:12 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-5176891d0a9so2908651cf.0
        for <iommu@lists.linux.dev>; Thu, 25 Jun 2026 01:47:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782377231; x=1782982031; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MIZ+Uqqvmj3NIegJ7KZAdRkOcTSWSNArKesrmTVP7Cg=;
        b=N8UevzZlk61595aWqUGDW0TZiJZH0cTq0GnVmVp8nIJeQReQhic8bqKZEIfgRzaPIF
         J0uAAYG5TykKb8doDc0veDMyhnWEmIE1YQ8KeJlGzQ2m0GWclCqkbl3Q/3SinGyqKDPl
         E/1RVTSrbfUqOEwVoVCxife42UFt1ieWfSXXrODdiLUXdMHtWkyOEpA7d/n5J5Mj6iuR
         oFdkKThLEbvRai6PUFnL1VkDj2kND+HaCmBiyfCjCAgVy5vdAP6UPtV/zpzWtqlFu+2n
         ApEc91rAVGJ6q97AliqVYQpLawK0eRQ7rsHkKeZDx1ZsWD5WHOENxURWlTVWIpbI+uRh
         sx9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782377231; x=1782982031;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MIZ+Uqqvmj3NIegJ7KZAdRkOcTSWSNArKesrmTVP7Cg=;
        b=IbWK9grH2sOPZfJd6iHUJraCN+2wkak4BTjGnQ5XtU/1Q5bA7BhiMnLNY4scb7rJvi
         t4UHuBbl7DcL1sMbIe6WSN8914Yto+Z+W56BHvGJwfgvyeE5074wtEAS47N3ssQpFreG
         rkxzaPxSnZYMzpRVbGBymI/DbqSKcRkEyAVNC09PebAZXa4alNxm7WJTKmBmm19dxLIP
         mxvYb6eZmzm/es6aTJnFZXExn+hWjYV1y+rU4+jWcKeuhEv5H+CInEvwimyGCzjcQ7Hj
         FyBvKVZyVhUCicIDbVFr5FISp1nramhvVKrHGjsMXWV6D3WkVaRt1aRwJ6EpkSp//eG9
         lYyA==
X-Forwarded-Encrypted: i=1; AFNElJ/uSS094gSflqDVz4fr8aSEJapPhbbm6//p5W8JqOKM8CIaYlRD4cxt2dADobQ7FAh+9LVfvw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwGJGOMm9FmaMeBhjaTYxRXvn/fTn8CFym96TStrePgb9DnAVMt
	L8dEGvhX1qfGr2H/9WpD1x+uoVhdJbB2QKZmvOyOXOcw836C2WUFCvezIJO8Dx6O6hjsm5qOPza
	bBwI0afkBsp54lXhcnmAFGnVIItMFbKxe6jf0c1zaZgxIgCJz910vdpnjaQ==
X-Gm-Gg: AfdE7cn7kB8jHNfH1K7G6a6j8/TqUis+SK1pQ8B7Qq4ynjvKUUzUD8Cy84k7QT0TPd+
	7rQgMHikslgYT5WxSezb7aXm9fYFHkmSIRgIqgDLIRh1O1lxjXPjrXO8W+tB6gZmvDniolxehSB
	SB9xv9wA3Hxqz/fP1YcLZqpeXgYMZGtpGB2wZqeLPDdLIg5DKDRJuKLb87iCyiDy8JG5LxXO5RF
	Y65Sv59NqPQ1WQRbqKBUyuNTA1hBuJip1PMhqcED9pBVsp6hVeDhScD+f1nIgJSpwSx4qyZQIK6
	lb7PmTHeXwKSY2u7dFE6S3p55A36lBSX2Z6/WhzKB6VgF6txI+nSdBbyO1d2VOzppqSGGCN6nDQ
	NsvQWfdwUFPVuyFZTkX6cDFrimvd7Z9HRlqw=
X-Received: by 2002:a05:622a:1451:b0:517:6d82:9d7b with SMTP id d75a77b69052e-51a7279ef50mr12133421cf.4.1782377230965;
        Thu, 25 Jun 2026 01:47:10 -0700 (PDT)
X-Received: by 2002:a05:622a:1451:b0:517:6d82:9d7b with SMTP id d75a77b69052e-51a7279ef50mr12133051cf.4.1782377230257;
        Thu, 25 Jun 2026 01:47:10 -0700 (PDT)
Received: from [192.168.120.170] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c11fbe05f9csm132345966b.31.2026.06.25.01.47.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jun 2026 01:47:09 -0700 (PDT)
Message-ID: <4f0878a0-2ab1-490d-b251-c6d68c4ee241@oss.qualcomm.com>
Date: Thu, 25 Jun 2026 10:47:07 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/6] iommu/arm-smmu: Add interconnect bandwidth voting
 support
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
 <20260526-smmu_interconnect_addition-v2-2-2a6d8ca30d63@oss.qualcomm.com>
 <7xfxlxfqjcqdzl6gckaoyy2ioefglc7bgi66yv5khrbl6fi2zc@ivtiukdaj4jv>
 <d25f24ca-5bb3-4276-ac8f-8340e8fb4ce8@oss.qualcomm.com>
 <sdm7sqiokmsgczeat2mxch42ois5rwabav6c5fm7abct2xoepf@j3kraqrjvpoc>
 <ea345832-711d-4e32-af0f-bc74d8646aef@oss.qualcomm.com>
 <299d54c5-fb93-47ee-9495-fbf48a3204fd@oss.qualcomm.com>
 <aaf4daee-4886-4214-a761-80545d2565ee@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <aaf4daee-4886-4214-a761-80545d2565ee@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=DqBmPm/+ c=1 sm=1 tr=0 ts=6a3ceb10 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=TtB6gFZ535HFW_zVIisA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI1MDA3NCBTYWx0ZWRfX6VrD4/EMPufN
 sAKOW3TvLbooaEsw5Y1Sx5BRvXX/XvN1Nxarfm0g34+xakGfMBWO97JzFwsJftqYjfMFOxfeP8n
 Zi3J74XjqRQRqA9HT8KatrxW6o2C2is=
X-Proofpoint-ORIG-GUID: ra59-8yEmGAKQz0Zdfvp6kxZ3pgoPPpD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI1MDA3NCBTYWx0ZWRfXwtuovFqMe6MY
 JaZfLc1ZNgTZmyN4H6ziLDCABXMo+VzaIwsgwq+//OIKXmhtEK30lbylA0brZxCMzBmcgZudSQM
 aLmMapaOBmS8rPWlncuQk7ummdo1nKwhkP027DrqXwAHf/LpP5P7sMkZVMMuuFm4EJNCbOmxihW
 bXNmUAhLGZEzjWVJSkL/HQsSn9FQEI5HMfWQSYI5ugB3mdJOgMX+xTIv4H0CfudfwbHT5S/UZs2
 6u1Rw18r8Zd1PUnlptlmPD9f5W0c2dNjHopcTxlR3UHKLteV54kAnHtUNgoQ4kCFSBBC4TLgl8m
 y2sXBg/Pw9oaC7s6SlERBRl020/3LK8fYqLzpb+MKaUk8bhqVH2Ncg321ZoqhnU3kDd8u/CuDDm
 zoPgFIYR3ioO9W3vSjeNqQFpcF2K5VDIlRm2AhhSE9HJsKttkIoGvcW0DySVE+4CPMWePABbd64
 BW/mu6qJ9rVYsp6y2TQ==
X-Proofpoint-GUID: ra59-8yEmGAKQz0Zdfvp6kxZ3pgoPPpD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-25_01,2026-06-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 priorityscore=1501 malwarescore=0
 suspectscore=0 bulkscore=0 adultscore=0 spamscore=0 impostorscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606250074

On 6/19/26 12:54 PM, Bibek Kumar Patro wrote:
> 
> 
> On 6/18/2026 2:58 PM, Konrad Dybcio wrote:
>> On 6/17/26 4:26 PM, Bibek Kumar Patro wrote:
>>>
>>>
>>> On 6/16/2026 5:51 AM, Dmitry Baryshkov wrote:
>>>> On Mon, Jun 15, 2026 at 06:36:51PM +0530, Bibek Kumar Patro wrote:
>>>>>
>>>>>
>>>>> On 6/8/2026 7:25 PM, Dmitry Baryshkov wrote:
>>>>>> On Tue, May 26, 2026 at 08:12:03PM +0530, Bibek Kumar Patro wrote:
>>>>>>> On some SoCs the SMMU registers require an active interconnect
>>>>>>> bandwidth vote to be accessible. While other clients typically
>>>>>>> satisfy this requirement implicitly, certain corner cases (e.g.
>>>>>>> during sleep/wakeup transitions) can leave the SMMU without a
>>>>>>> vote, causing intermittent register access failures.
>>>>>>>
>>>>>>> Add support for an optional interconnect path to the arm-smmu
>>>>>>> driver and vote for bandwidth while the SMMU is active. The path
>>>>>>> is acquired from DT if present and ignored otherwise.
>>>>>>>
>>>>>>> The bandwidth vote is enabled before accessing SMMU registers
>>>>>>> during probe and runtime resume, and released during runtime
>>>>>>> suspend and on error paths.
>>>>>>>
>>>>>>> Generally, from an architectural perspective, GEM_NOC and DDR are
>>>>>>> expected to have an active vote whenever the adreno_smmu block is
>>>>>>> powered on. In most common use cases, this requirement is implicitly
>>>>>>> satisfied because other GPU-related clients (for example, the GMU
>>>>>>> device) already hold a GEM_NOC vote when adreno_smmu is enabled.
>>>>>>>
>>>>>>> However, there are certain corner cases, such as during sleep/wakeup
>>>>>>> transitions, where the GEM_NOC vote can be removed before adreno_smmu
>>>>>>> is powered down. If adreno_smmu is then accessed while the interconnect
>>>>>>> vote is missing, it can lead to the observed failures. Because of the
>>>>>>> precise ordering involved, this scenario is difficult to reproduce
>>>>>>> consistently.
>>>>>>> (also GDSC is involved in adreno usecases can have an independent vote)
>>>>>>>
>>>>>>> Signed-off-by: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
>>>>>>> ---
>>>>>>>     drivers/iommu/arm/arm-smmu/arm-smmu.c | 57 +++++++++++++++++++++++++++++++++--
>>>>>>>     drivers/iommu/arm/arm-smmu/arm-smmu.h |  2 ++
>>>>>>>     2 files changed, 57 insertions(+), 2 deletions(-)
>>>>>>>
>>>>>>> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/arm-smmu/arm-smmu.c
>>>>>>> index 0bd21d206eb3e75c3b9fb1364cdc92e82c5aa499..07c7e44ec6a5bd1488f00f87d859a20495e46601 100644
>>>>>>> --- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
>>>>>>> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
>>>>>>> @@ -53,6 +53,11 @@
>>>>>>>     #define MSI_IOVA_BASE            0x8000000
>>>>>>>     #define MSI_IOVA_LENGTH            0x100000
>>>>>>> +/* Interconnect bandwidth vote values for the SMMU register access path */
>>>>>>> +#define ARM_SMMU_ICC_AVG_BW        0
>>>>>>> +#define ARM_SMMU_ICC_PEAK_BW_HIGH    1000
>>>>>>
>>>>>> totally random numbers, which might be different for non-Qualcomm platform.
>>>>>>
>>>>>
>>>>> Ideally, any non-zero value would be enough to keep the path active.
>>>>
>>>> This is true for Qualcomm devices. However, you are adding this to a
>>>> generic code.
>>>>
>>>>> Here 1 Would be enough to keep the path active, but might be too small to
>>>>> reliably keep the bus active.
>>>>> Other is UINT_MAX, which will reliably keep the bus active but might cause a
>>>>> power penalty.
>>>>>
>>>>> #define ARM_SMMU_ICC_PEAK_BW_HIGH    UINT_MAX
>>>>>
>>>>> seems to be suitable here to reliably keep the bus active by BCM
>>>>> for both Qualcomm and non-Qualcomm platforms (with some power penalty).
>>>>>
>>>>> LMK, if you feel otherwise.
>>>>
>>>> Shift it to the qcom instance or provide platform-specific values? (My
>>>> preference would be towards the first solution).
>>>>
>>>
>>>
>>> To support platform-specific values, we may need to introduce a LUT-based approach in the driver. (Bandwidth voting values cannot be placed in device-tree property IIRC ?)
>>>
>>> Currently, all Qualcomm platforms use 0x1000 for SMMU ICC voting. I
>>
>> (you used decimal 1000)
>>
> 
> It's my bad, i meant 1000 only
> (I'll check on the icc_bw calculation to get clarity on the values)
> 
>>> can evaluate if this could be moved to a Qualcomm-specific
>>> implementation.
>>
>> Add a vendor hook to arm_smmu_runtime_suspend/resume and handle it within
>> the QC driver
>>
> 
> Just curious, wouldn't this apply for all the arm-smmu users in addition to Qualcomm devices as i mentioned here [1].
> Vendor hook would make it Qualcomm specific.

You're proposing to use a Qualcomm-specific bandwidth value so that
fits

Konrad

> 
> [1]: https://lore.kernel.org/all/984ff9c7-3eef-463c-a330-bf7acd063667@oss.qualcomm.com/
> 
> Thanks & regards,
> Bibek
> 
>> Konrad
> 
