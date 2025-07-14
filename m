Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71EA0246BB3
	for <iommu@lists.linux.dev>; Mon, 14 Jul 2025 12:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752495292; cv=none; b=KJHVXXdU3v26jUeY1CMG9O70uMp708n76h0sa3h/hNsaUDqSMSt1m6JLVlEcQeCM6l3wccQF0HvEIW69GRqQxaPyWYGjurpJt36MJVF8Ke8l9OH6QkVCCvR6BzkmLpwyECce48X2+VgVrl/a3WkYzhfwcRF69K96fvtjVOjp5Tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752495292; c=relaxed/simple;
	bh=LNvjq/HhF00mQ3s9sufU+eybecRGCk/V8PHR+axvGYY=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=fsc8MtqHDqB4YJee17MKjIq3zJaE8EpfErDrh8Nek2kmUPCsZMZ50JmxhpmjBxQ8osJAmoh9XZMh/6zX+euPL4uiQcOrfR4Vu2ldSGd5LrWA7UhqM3drCrtI/ft56DhHP9cxjS2bYCrCQwnMbHfaawy+ReKBDmhyhpAS7M+rpYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ThsZB4SN; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ThsZB4SN"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56E668Rl032496
	for <iommu@lists.linux.dev>; Mon, 14 Jul 2025 12:14:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	aoI5BFClgTcyFuK38F1KY+FhVdU3uKRCX2U3iUvC0Jg=; b=ThsZB4SNBrInD9Wa
	YmyWGrc2zGW9ciktJh7xytNgsEEs9g1akgkAuE6v+vHjbQTGM0sHGQy7V290e7dp
	15BBbMalNS92yhJdQzs84fRq0Vl0SXMXuNnL3RXxDfzWTxWjVBRKMiA10EpbkkFJ
	9XIKUKVVC8n8W7W+TsIILeQx7tt2ULLhBv9vgwxicXaoH8LCBpIJVOJ8u0NkdZ2A
	7sfng5mMUW0G4TS6rGT6gAwnB3+TuCrlNFkSlDdQrQcVmm85sVVmCJ+Bio4YJQC+
	on2aWSNC5m5HCOdSKchJoEPbUxIb8FHfNetrdbYkRLgOko61vPn3LAJ/e/wUJoOB
	ls6Btg==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47vvay1732-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Mon, 14 Jul 2025 12:14:50 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7df5870c8b1so45589685a.0
        for <iommu@lists.linux.dev>; Mon, 14 Jul 2025 05:14:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752495289; x=1753100089;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aoI5BFClgTcyFuK38F1KY+FhVdU3uKRCX2U3iUvC0Jg=;
        b=HGTdJD/qKpFaHPf2IWyWfdSXReA+GbhlOpNNNQlswkyZyujyv8Ets3+6dWaxVkUnC7
         iiP0eKoT7hjsZvDkoqW1zLwPNPlXfm2++om5kjAaQYEp0nozCM13CUu2URfDALLaYoRe
         TEpvPscxSagfo1mWZ+tVj0LedY+rEFgXj5V2tGI184GbJEFKsNL9BSQM28pEeSHKSLf5
         MOv3gMutkeS0Z+6+UI+AlI3xmhH0vBzCcJpZbu4fzdFPNOBvD2SSUMFnbSy0AtKp1L5o
         O+LCNCOQmzYWn0Hc6vydtCAlUXRqBiEjug84we4TeezuqVBojldnF8KF5nCO3n1718Z6
         mFnQ==
X-Forwarded-Encrypted: i=1; AJvYcCVWWiSz01mmIaXfyEjjYTXoTeZ3QSGRTYNZZE1wIHfreWQVsNc+WNR36M7MDvy6wY4c7BH7Pw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yyj2k65gHe9+Fser8Fo3VY3H3v0Sl4MWbbWThz4Xk7Eg7VFRHJc
	M2N4FUYjyaetOd2goQSQb9FyDu1ecL7jmz3siVv6mJUcrgylNCmwiVX9pj1zZvFzPwSfPFElsu9
	iDnDrJmSnBfclEF56qPisc+TTf1+fZnw8FszE4SHUSCycHGd8gBEurkWRJA==
X-Gm-Gg: ASbGnct4L+FYNx/dzXzHDF9xPMGpH3MUuEgBvUhNVaQUT/ffjkdVtPCJLRXbza2nT9y
	YUT42v3vSS9IFz6EMz3ZQ5eixaOsRUXNwgleVIdwMhLivNY/oPczj7xcDpbo3b5XdV15D6v4K+x
	FaI4YCY3AnUgRF2ISxWnN686cEi10sRKZ2lpFMV0nkOC3yjXlzUv9YcHMD9nsEH710jLArCjpoe
	tvvuOAVGesxf8hQJBBx2JVxssZ58WeY0Kg66hytt0OOnIaAz/LVnfHC12fAyXfM7jBsLc+UAKSK
	YjDXBUoj5/hlnFmOIW3FrdrpbxpVhHQcQvYPg9pEzL4r5Zo70BfMWHN13t8beKPGKI5FI9KMoVF
	GJPofvK4So+5LA29G4Lor
X-Received: by 2002:a05:620a:618f:b0:7e3:2d1d:bda5 with SMTP id af79cd13be357-7e32d1dc30fmr94698685a.9.1752495288898;
        Mon, 14 Jul 2025 05:14:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFG5vZyWrc5c1Pue3RENiHkc+kjzDktP9Y1RxdkTc6cDgp35ovMXQ//H2HFsJEBRaNnVMnwSg==
X-Received: by 2002:a05:620a:618f:b0:7e3:2d1d:bda5 with SMTP id af79cd13be357-7e32d1dc30fmr94696585a.9.1752495288322;
        Mon, 14 Jul 2025 05:14:48 -0700 (PDT)
Received: from [192.168.143.225] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae6e8298f85sm824827066b.144.2025.07.14.05.14.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Jul 2025 05:14:47 -0700 (PDT)
Message-ID: <45e6873e-adb7-453f-abd6-c7b6620c9b34@oss.qualcomm.com>
Date: Mon, 14 Jul 2025 14:14:44 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu/qcom: Fix pgsize_bitmap
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
To: Jason Gunthorpe <jgg@nvidia.com>, iommu@lists.linux.dev,
        Joerg Roedel <joro@8bytes.org>, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>
Cc: Joerg Roedel <joerg.roedel@amd.com>, Kevin Tian <kevin.tian@intel.com>,
        Linux Kernel Functional Testing <lkft@linaro.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Nicolin Chen <nicolinc@nvidia.com>, patches@lists.linux.dev,
        Alexey Minnekhanov <alexeymin@postmarketos.org>,
        Luca Weiss <luca@lucaweiss.eu>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        =?UTF-8?Q?Matti_Lehtim=C3=A4ki?= <matti.lehtimaki@gmail.com>
References: <0-v1-65a7964d2545+195-qcom_pgsize_jgg@nvidia.com>
 <6cc5bb7a-344c-45fa-a8cc-cea34493c759@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <6cc5bb7a-344c-45fa-a8cc-cea34493c759@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: eU-5WfB6EAwQ9jBKzpFnuZ8J_Z_y21nX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE0MDA3MSBTYWx0ZWRfX7aCM0FLWywGW
 tW799Pjw2IuYdxhtOJi6CxD53BFKmG5xxyKW64SyXc3x/0kHJliqmu/oKmJ1QshXU/f2E6Zq2ky
 ZptePImELywMruKywKhR2kDG7/7tr2Kl3OO4hdPSCcbO+kZeR/V1KeGK9lhYr5fsCVsokqJLNt9
 k+OGSXkVEDqFcjA+TxFYb9kDeCvCP0SKY+dr9co5Arp+yNapO9X1VyQd6yr2oRY+0CXAhKlnfU4
 LDCj9oSMyK3i9spi21ltgHlNBFIavBXuyOVRcds5fHtS82zCgDlhlZ9tceKjzPTCjbKyf8un4Ia
 QAi1UUXRUa66lDj6Gl+yYSglfp8sf1JjHR8s+xr5MLgmUtLLkzrOBiQGsBhMG6Q6sXAJ4DR8CtW
 +ZMoQXS5VWZXWqpigQVIcd+jbFA24ww+f/LCz1Z33G1S+3955Xhg+u0hPjG79gQgzlq/0X5a
X-Authority-Analysis: v=2.4 cv=GNIIEvNK c=1 sm=1 tr=0 ts=6874f4ba cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8
 a=KKAkSRfTAAAA:8 a=Ikd4Dj_1AAAA:8 a=EUspDBNiAAAA:8 a=LZJuRBUwro2lsZWipJkA:9
 a=NqO74GWdXPXpGKcKHaDJD/ajO6k=:19 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: eU-5WfB6EAwQ9jBKzpFnuZ8J_Z_y21nX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-14_01,2025-07-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=999 phishscore=0 adultscore=0 impostorscore=0 malwarescore=0
 mlxscore=0 clxscore=1015 lowpriorityscore=0 bulkscore=0 suspectscore=0
 priorityscore=1501 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507140071

On 7/11/25 3:26 PM, Konrad Dybcio wrote:
> On 7/11/25 3:16 PM, Jason Gunthorpe wrote:
>> qcom uses the ARM_32_LPAE_S1 format which uses the ARM long descriptor
>> page table. Eventually arm_32_lpae_alloc_pgtable_s1() will adjust
>> the pgsize_bitmap with:
>>
>> 	cfg->pgsize_bitmap &= (SZ_4K | SZ_2M | SZ_1G);
>>
>> So the current declaration is nonsensical. Fix it to be just SZ_4K which
>> is what it has actually been using so far. Most likely the qcom driver
>> copy and pasted the pgsize_bitmap from something using the ARM_V7S format.
>>
>> Fixes: db64591de4b2 ("iommu/qcom: Remove iommu_ops pgsize_bitmap")
>> Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
>> Closes: https://lore.kernel.org/all/CA+G9fYvif6kDDFar5ZK4Dff3XThSrhaZaJundjQYujaJW978yg@mail.gmail.com/
>> Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>
>> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
>> ---
> 
> The downstream driver from >10y ago for this era of hardware
> suggests (at least some?) users of this driver can issue a magic
> TZ call to switch to (IIUC) ARM_64_LPAE_S1, but there's no
> implementation upstream, so:
> 
> (adding a couple folks interested in the hardware museum to CC to
> bring this to their attention, nothing to act on though)
> 
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

I never actually added the people I thought about to CC - fixing
that..

Konrad
