Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBFDF371067
	for <iommu@lists.linux.dev>; Fri, 19 Jun 2026 10:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781866481; cv=none; b=HQwybPKN90iEjwRJVGFmG9rhmAdZhocnTz7uq0ZmDJMB39rYyyGYFTLj8oDzI3cEeTmU0VuSQVuaqfiK/kAwi2KQ5wOiYXemMxAK4Jh7QekhKt9RDIOEFsAh3Wu6YNyKbLrDyFNY6a3wsYAPZSZDkeG574rE+hpUVc7CvheBEWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781866481; c=relaxed/simple;
	bh=cijrwQ9O5Wsy7Ns7ARoiPJFl63dkmQm9dPwVhuUPxvE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c4yo1w7EeS2KK34+cl6bwVriiD4bg27zsRXt+Op5o+xu83Ml2wjQF1SYwQ8MJUw8WlXHBd8ofU/K9+cqmYN7sVV80gRopHp+08lQSkvw5fhwxX+BW9Ftt1/ZpcpyYVPWmNSBO6rHTrxCwvxBsr4mTHgWU88ObEYNk7a9jyRudLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=OhNHN0bi; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=BnHBp9h6; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="OhNHN0bi";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="BnHBp9h6"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65JAitk6506808
	for <iommu@lists.linux.dev>; Fri, 19 Jun 2026 10:54:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	uJASCICmhbYbPbzCDWKXXIRnLLMfhiemH7GJWmQ/H1Q=; b=OhNHN0biDYyFQwgk
	nXOC7uj4+hu8ejH3kmNt1s+lrUg4ZL23JpqdrV/OMVC+JLAuBLfE+xPm8V78s9iQ
	IF1mOiz1CV6CNDvSWeOueLa/qfC3FSSmq3Sk5+jbseiurHfL7elTbL+aX8zcQja/
	rDCmev4XPuahHfjOj/pDvSk4eXqC9a4WyYRwiD0MBk1RRNXmUXy5eWUudBDff8vp
	IaBJVLBpM2FBEPicbmK6K9qtCNsOlaQRO/HBzQ4qcICcRHme43QtTpf2XhAIqjaO
	FUCW16qOUCJnr4sifm6l+WTi8bbLHcVZil3qZQUudtHxiiVFW4A0sVMWm60wTmuW
	P9ZVgA==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4evm22bmyh-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Fri, 19 Jun 2026 10:54:38 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2c0d0516ad7so20207885ad.0
        for <iommu@lists.linux.dev>; Fri, 19 Jun 2026 03:54:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781866478; x=1782471278; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uJASCICmhbYbPbzCDWKXXIRnLLMfhiemH7GJWmQ/H1Q=;
        b=BnHBp9h6jSfqsmIqTS5ehCiR5HSBDSefHsxsjXpj7saAtBsQrzRaXotzr3nd5p+iN3
         Pub/xCFYpwCgZa6WwZxLGf53MbIxgWgj7GdOket91wy2YAu5eCWY+kOGcNVDiUAJJfLc
         U7XKh7BIzbVXt0BvY9OZrjd8tb9wSihmlUsRttVfitZgMJoyxw47nq2etaOcMKuNkhDn
         nfVCz3ojW3ZtS8GnnjC3jTj6Mfdqg0sXgnaHKFl33FIRr32p/TnTkDR0QfJ3C5VxtXkt
         +2JVBUQsJApSNDTIBXNAazhgexEVTZEfAcUxDPnaNQaiDQg39NRsbp8mVUehB3x7vZLT
         jQLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781866478; x=1782471278;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uJASCICmhbYbPbzCDWKXXIRnLLMfhiemH7GJWmQ/H1Q=;
        b=Xa+S0l/DehynaxGxSIQxG0/wEfRt/yYve9WYBj+Q7pShQqgB/UF5sXIuXMrsLBiBjA
         WCTKss16bseGFum9aFvTiycsUpEK0OwSDlTbVU5MzWYbqF0PBVDbHCbcHV1YODUVnmiI
         nhyYDV1eNkhzHWPzd6HGl3vtntyyS6vct77aZKCHaMJG6G+SezZSu78DITfsEULhNhZ1
         ZPsjqLcJQWzaYbDbJjt6n004RjwsfIK9ONJijrJ/AVo8UyMkQA2NosGEZR8DuzTPnNPj
         XLiyASmfRMzYgnqi9xkaehRqB5kBdvtp1Wax6uMigNv6h8mcRJVwRe6rq4IWoouCLhRm
         JIEw==
X-Forwarded-Encrypted: i=1; AFNElJ+jk56G043Meggx15rQK5pkXPmip5jErycQEqY2EM4/JvvrGNBh2nWy9kImznt0lOvYVATsJQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwjHUnt/CdCAtq6MZiSEWVISf4G4vTpIFnsDIKXTZV3J/MwWj0Q
	M/lnJYBsJ4gnsKu/6RkeiATjY+3nROy3clSG262OA07Ka0GUzhtRNOrp9emd7B9yZowfwRWagwx
	iuVCbUcGgATDzB9VBgFnJX5xjawuUV9XvCGofYHG/6T9lVhTIy7Q2W0HpuA==
X-Gm-Gg: AfdE7cl48EyfHDyauLQddpAScc3N1LyaKmvPrmZqA3TP3DglUxo2tRazDAt0xI+RL5P
	+eaxnPB0RgrjrvRkBMtUYlir2KEBIqoratNUzuFyBL296vxkoM/TnjXSIRENjeUeZN7x5qqMPhY
	o03huHCES4hWf/T3BGB/jczr0R0rXPPUWCqogyNJaZocKP/DcyMZoUokpwb2LJ74n6+6QCRwP0A
	nXbPmd0Y8XQehR2x8/oc5D66Ux7DIHAnzPDS4sWFNxa2VCVME41ORRanaKc/0ibMAWbKCoSRTOd
	Mv4fAFY27zrFqRr+qdNc7zQ+6PrXhROfbwx3ADf2ohcdYNAqME4U5SaniW7nfOII14wGSbiflgy
	UZ3l1wxBO/EkYnAUQJkgVu/8QqalXWpWWPMbwYg==
X-Received: by 2002:a17:903:32c7:b0:2c0:bcb3:86f with SMTP id d9443c01a7336-2c718f1f000mr33930795ad.6.1781866477623;
        Fri, 19 Jun 2026 03:54:37 -0700 (PDT)
X-Received: by 2002:a17:903:32c7:b0:2c0:bcb3:86f with SMTP id d9443c01a7336-2c718f1f000mr33930485ad.6.1781866477173;
        Fri, 19 Jun 2026 03:54:37 -0700 (PDT)
Received: from [10.219.56.41] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c73663cc3bsm4044435ad.76.2026.06.19.03.54.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Jun 2026 03:54:36 -0700 (PDT)
Message-ID: <aaf4daee-4886-4214-a761-80545d2565ee@oss.qualcomm.com>
Date: Fri, 19 Jun 2026 16:24:31 +0530
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
Content-Language: en-US
From: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
In-Reply-To: <299d54c5-fb93-47ee-9495-fbf48a3204fd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=YN+vDxGx c=1 sm=1 tr=0 ts=6a351fee cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=5sB-xfgw_plGXbDTPmIA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-GUID: fp4H787ntxT_o5Q2-mlYedP_mHwGBuuL
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE5MDEwMSBTYWx0ZWRfXwONLZ3bnQRKp
 TwOCx3S31kemY7DDks+Pu4aj0AoWVaddJ4Ab9a/Q7c3MlT8/V8z6trzpn3RxrxytYD4aaHTbjoj
 ntDNRVzOurY+g9dXTCLn7kvpkiuxbCU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE5MDEwMSBTYWx0ZWRfX92bwmkYPPrZt
 +ggcubGQyd/Mied0Hu01aJhOgFmkPjYXCtFUX1pxQtsoIVNON+xJJfARpTM3THCsn17+3st1pbj
 sbCZcXNThJKZb/JlJSW2UUDbYn5mWzmUyrwaRSVFIZfVnToTHtPdZYD3fF+TFtRu9tpjNlLoa0w
 sA5hWSuZg3wjVE/BBQCp6GO6jclAR/WZRT7akr+hxxAyf/Q71CYaWHNkRVtxZA/ZsWRJ9Imjfqq
 x+VusDdOS4QOz6MKiRlPJLTylF1YfO6799WkPZqdDmC1kMqOFUHnOSb3Ua97rXqJuuvFzZVNaoK
 ybQawmmVtNXIYrpEidIZKPiEkxpAuYyvPLgU+WDHXcepUij92WmfudmkWh4BTda9SpwQDXA1de0
 kt9xJxvLkBP1zVUrjK4coHbiKsNDhA/aDpFbUONiiWUAmDbYgzQLq2nw/lieHoI9OvfPFA7ahOX
 UPgPeN0fqdjfoaVt8RQ==
X-Proofpoint-ORIG-GUID: fp4H787ntxT_o5Q2-mlYedP_mHwGBuuL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-19_02,2026-06-18_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 adultscore=0 clxscore=1015 impostorscore=0
 phishscore=0 lowpriorityscore=0 malwarescore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606190101



On 6/18/2026 2:58 PM, Konrad Dybcio wrote:
> On 6/17/26 4:26 PM, Bibek Kumar Patro wrote:
>>
>>
>> On 6/16/2026 5:51 AM, Dmitry Baryshkov wrote:
>>> On Mon, Jun 15, 2026 at 06:36:51PM +0530, Bibek Kumar Patro wrote:
>>>>
>>>>
>>>> On 6/8/2026 7:25 PM, Dmitry Baryshkov wrote:
>>>>> On Tue, May 26, 2026 at 08:12:03PM +0530, Bibek Kumar Patro wrote:
>>>>>> On some SoCs the SMMU registers require an active interconnect
>>>>>> bandwidth vote to be accessible. While other clients typically
>>>>>> satisfy this requirement implicitly, certain corner cases (e.g.
>>>>>> during sleep/wakeup transitions) can leave the SMMU without a
>>>>>> vote, causing intermittent register access failures.
>>>>>>
>>>>>> Add support for an optional interconnect path to the arm-smmu
>>>>>> driver and vote for bandwidth while the SMMU is active. The path
>>>>>> is acquired from DT if present and ignored otherwise.
>>>>>>
>>>>>> The bandwidth vote is enabled before accessing SMMU registers
>>>>>> during probe and runtime resume, and released during runtime
>>>>>> suspend and on error paths.
>>>>>>
>>>>>> Generally, from an architectural perspective, GEM_NOC and DDR are
>>>>>> expected to have an active vote whenever the adreno_smmu block is
>>>>>> powered on. In most common use cases, this requirement is implicitly
>>>>>> satisfied because other GPU-related clients (for example, the GMU
>>>>>> device) already hold a GEM_NOC vote when adreno_smmu is enabled.
>>>>>>
>>>>>> However, there are certain corner cases, such as during sleep/wakeup
>>>>>> transitions, where the GEM_NOC vote can be removed before adreno_smmu
>>>>>> is powered down. If adreno_smmu is then accessed while the interconnect
>>>>>> vote is missing, it can lead to the observed failures. Because of the
>>>>>> precise ordering involved, this scenario is difficult to reproduce
>>>>>> consistently.
>>>>>> (also GDSC is involved in adreno usecases can have an independent vote)
>>>>>>
>>>>>> Signed-off-by: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
>>>>>> ---
>>>>>>     drivers/iommu/arm/arm-smmu/arm-smmu.c | 57 +++++++++++++++++++++++++++++++++--
>>>>>>     drivers/iommu/arm/arm-smmu/arm-smmu.h |  2 ++
>>>>>>     2 files changed, 57 insertions(+), 2 deletions(-)
>>>>>>
>>>>>> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/arm-smmu/arm-smmu.c
>>>>>> index 0bd21d206eb3e75c3b9fb1364cdc92e82c5aa499..07c7e44ec6a5bd1488f00f87d859a20495e46601 100644
>>>>>> --- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
>>>>>> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
>>>>>> @@ -53,6 +53,11 @@
>>>>>>     #define MSI_IOVA_BASE            0x8000000
>>>>>>     #define MSI_IOVA_LENGTH            0x100000
>>>>>> +/* Interconnect bandwidth vote values for the SMMU register access path */
>>>>>> +#define ARM_SMMU_ICC_AVG_BW        0
>>>>>> +#define ARM_SMMU_ICC_PEAK_BW_HIGH    1000
>>>>>
>>>>> totally random numbers, which might be different for non-Qualcomm platform.
>>>>>
>>>>
>>>> Ideally, any non-zero value would be enough to keep the path active.
>>>
>>> This is true for Qualcomm devices. However, you are adding this to a
>>> generic code.
>>>
>>>> Here 1 Would be enough to keep the path active, but might be too small to
>>>> reliably keep the bus active.
>>>> Other is UINT_MAX, which will reliably keep the bus active but might cause a
>>>> power penalty.
>>>>
>>>> #define ARM_SMMU_ICC_PEAK_BW_HIGH    UINT_MAX
>>>>
>>>> seems to be suitable here to reliably keep the bus active by BCM
>>>> for both Qualcomm and non-Qualcomm platforms (with some power penalty).
>>>>
>>>> LMK, if you feel otherwise.
>>>
>>> Shift it to the qcom instance or provide platform-specific values? (My
>>> preference would be towards the first solution).
>>>
>>
>>
>> To support platform-specific values, we may need to introduce a LUT-based approach in the driver. (Bandwidth voting values cannot be placed in device-tree property IIRC ?)
>>
>> Currently, all Qualcomm platforms use 0x1000 for SMMU ICC voting. I
> 
> (you used decimal 1000)
> 

It's my bad, i meant 1000 only
(I'll check on the icc_bw calculation to get clarity on the values)

>> can evaluate if this could be moved to a Qualcomm-specific
>> implementation.
> 
> Add a vendor hook to arm_smmu_runtime_suspend/resume and handle it within
> the QC driver
> 

Just curious, wouldn't this apply for all the arm-smmu users in addition 
to Qualcomm devices as i mentioned here [1].
Vendor hook would make it Qualcomm specific.

[1]: 
https://lore.kernel.org/all/984ff9c7-3eef-463c-a330-bf7acd063667@oss.qualcomm.com/

Thanks & regards,
Bibek

> Konrad

