Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E934384039
	for <iommu@lists.linux.dev>; Wed, 10 Dec 2025 00:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765326546; cv=none; b=g//sytLNzkRkF45bddqUA0IsM1SzUCs+DFRooG4X+eeh+EvaNsGF1UJnu5k+32+GQp5R+FvscZTA3SEKJsp5AaZzebwOcRBopMa28g26O32BS0mfwWIHFCtJYTb8zLy6gFza0sX6TlGhKVe+HW1Mw3jFCK1TEbwANo9202iPQww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765326546; c=relaxed/simple;
	bh=DmbHOJzDGgP3zinDpUhdWFndWqr7KPrrGjBLOi/pilU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VqNdAIPJ6wJk47C4hP6D/fKVCYmo2idTnBVZrJGpb2eeNx5iPzKmBrDLGPQHYtISzq+npoyo4hBzt4LIbvEThodxjaOqKThS7u6mSGn/oZ+XuGBmhYkdUC9uPk3SGx0DHc9FzsByzg6j0ij7Qw28cuk48YzseC/VFxf9wqYFfnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LXacSh1x; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ORn1e6mV; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LXacSh1x";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ORn1e6mV"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BA0ODUn1218737
	for <iommu@lists.linux.dev>; Wed, 10 Dec 2025 00:29:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	1m/PxXI6rT8YrX7Kv/BU7N5+AWAw6oouRsa46G5QXRQ=; b=LXacSh1xfCz35EhV
	I1c4pPHiiUJIH1TEdyRmArMFjBlUjhhu6EdBjURBikLOfw+yDNQ0S0dEexojKEpW
	9wk2e0eckh7eE87DItezlVDiJdz9SIRrMH4Rk5aFycmCA8DCLYeft78cNeRBuVGU
	mh7ZltfH1StlOhQIAYdM/QfEw5g5mX1cpuBX0S0nZfBId6f0ipBP0IOynRp9iMsB
	8EJH64zxWznvk//YTQ4HfKSDdJ3QWegbwySsadtiOA/FEF83qvLkVO+9BKKEBDAi
	aZI3sg64ZPq0f5TYnAlSQfUjXfhqu7XRtW2jlY6xpQe4sP2vhbAA4NxBMqSz6Huo
	8MA2zw==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4axp5p1khh-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Wed, 10 Dec 2025 00:29:03 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-b969f3f5bb1so10137529a12.0
        for <iommu@lists.linux.dev>; Tue, 09 Dec 2025 16:29:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1765326542; x=1765931342; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1m/PxXI6rT8YrX7Kv/BU7N5+AWAw6oouRsa46G5QXRQ=;
        b=ORn1e6mVOvF7Pm/qVLKa4e0z9zkUcBwFEMi0pLIENmBhX5MxUNL4SFoyUA/zyvMqmu
         fAHEqf8++T6W7fZ7F7Kd24o1dwlGBlnwjv+0phVe8qmRW1BAG4aosnZaYZ+kpo4XND96
         YxBcyzEZka6MYD24sHf7rp36s/QXbdZRSd6zK79cSfphCq6SwQpc5OaxHRCOk0MhSU3X
         ny/9DidOTg42Dz9H0j7iridmCoPcz6z2ZyVqBuy4nFkhJJuZUrn9Kjnvc7rPrip0AkCd
         Az18AQq/GWzUCpNzqlVxU/Rennoq5uEz7KeoolGlQYqvddfucVzsHbb1wsNGnvRDMprp
         Hthw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765326542; x=1765931342;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1m/PxXI6rT8YrX7Kv/BU7N5+AWAw6oouRsa46G5QXRQ=;
        b=Ts7lbd2IRRdrvy0PUhL7SE2Tb46Knl0+wBmJp/C0rVE1z/YqPRq0eHPx7OXj+wFug1
         qF7xqG0f8TqKkuL/4DsijNIPXPUv+Cv9DWpTci1dG9LOGKq1h+uDZJRoiLbLzpUkrzum
         YD3uOLayWmhwub5ASuTS8vaH/6HKNm6UBHQUx2GwOE1nfWZppLHbz4tgVC8cojyIrmfm
         wqh84TuSaTd5svAjS/GBma/oGd7ZmXJ2ygjgmc27tJisOSpXUc3sKINQdbxKyEYAh8Mp
         0LfLkDevfHbxA5+ACP/Y9W2zhbwoYGZXGn137pExmMpDGxZUPqI71FEU+3+ezWWe6TxX
         /tbQ==
X-Forwarded-Encrypted: i=1; AJvYcCXv+DF37Er6zQP2SmX7U8LIHBJv30UPgW3pwBKdA77m3DRIP1KLLjK+SumDxn2g2hSAo+BEOw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwEd9rVSX8bhmc+iMGGJ0ONVdLqkwm7ufi3aBqyHoWUmZRNTkru
	NZoCf3/g722n1uSOpKKdmYvuIKkQN+FiQG2Ge0HTkK0dw5CtmgWf+Qe+3zpAl6b3fXJdclHe00T
	ejyzBjwa3e31cFRh8VWa/UA9tIqzrCjN35ablN7Edu+8rQDlxfwo9RJmAvQ==
X-Gm-Gg: ASbGncvDWVkRYH1JLWnZUGhBtWvELQNoZIk7RNRQ9bce6JMoF52c6xHiayi5z3FzG/B
	sNKxTUpzyuifvwNkN+NfdhCRohd9beCfgChpThT1/uyuQW2KBaDJIn+RQ5tCT57IVNbx5ai+6KK
	xmJ2MvW9Pl5eWI6u+o5IMVcFrMiobovsWpSPqL9hP+vm4M/Yq3Y4llcfp6KxfyAxtuF8Qt32mYy
	ONYF3cr8hWK7IigMQKvQbkrWNsoCTrtk2pW8AOiGBJb3O2J6uh0inkDcrmgrxipF3C0ZGQCrk5v
	EsC3fXaZ5wBb3ChHBF2g/hjg79s34tIp/X+IGEnZsrceE3+EOt7ZdrEfDmN98PVdem+MbeCzSSR
	5MtJLEhNsMBTzmTuYJ2ElA8kamGktK5apXeeJTlQYyEJVB6HOFxVQ2lmV2HTKluyBYNvBaQwPjA
	==
X-Received: by 2002:a05:7022:4299:b0:119:e569:f626 with SMTP id a92af1059eb24-11f29689922mr488023c88.31.1765326542352;
        Tue, 09 Dec 2025 16:29:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEy5keNfV7FkPtPxwGz50EOX7i55BO+dFaKFElM7BkmefsV2JDIwhim0Mttwnnmyd7Y2ySIGw==
X-Received: by 2002:a05:7022:4299:b0:119:e569:f626 with SMTP id a92af1059eb24-11f29689922mr487991c88.31.1765326541703;
        Tue, 09 Dec 2025 16:29:01 -0800 (PST)
Received: from [10.71.110.87] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11df7573508sm54609303c88.3.2025.12.09.16.29.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Dec 2025 16:29:01 -0800 (PST)
Message-ID: <8b8c2b0a-3629-4cde-afa4-18bc20e0f5df@oss.qualcomm.com>
Date: Tue, 9 Dec 2025 16:29:00 -0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] of: reserved_mem: Restructure call site for
 dma_contiguous_early_fixup()
To: Marek Szyprowski <m.szyprowski@samsung.com>, Ye Li <ye.li@oss.nxp.com>,
        robh@kernel.org, robin.murphy@arm.com
Cc: saravanak@google.com, quic_obabatun@quicinc.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux.dev, william.zhang@broadcom.com,
        kernel@oss.qualcomm.com, will@kernel.org, djakov@kernel.org,
        aisheng.dong@nxp.com, joy.zou@nxp.com, frank.li@nxp.com,
        jason.hui.liu@nxp.com
References: <CGME20250806172503eucas1p264d6731c73592fcc380b0dcc21cdeadf@eucas1p2.samsung.com>
 <20250806172421.2748302-1-oreoluwa.babatunde@oss.qualcomm.com>
 <416dbaed-a68f-4edb-a20c-94cb4c53c748@samsung.com>
 <cef8f9eb-88aa-4771-b25b-2cfd1ac2c387@oss.nxp.com>
 <3b0cc36d-0f7e-4d07-949f-fce670170247@samsung.com>
 <306596c4-cc91-4500-b705-50e619e9f38e@oss.qualcomm.com>
 <be70bdc4-bddd-4afe-8574-7e0889fd381c@samsung.com>
 <ae7e7a10-5aa4-4381-a878-101af19714b3@oss.qualcomm.com>
Content-Language: en-US
From: Oreoluwa Babatunde <oreoluwa.babatunde@oss.qualcomm.com>
In-Reply-To: <ae7e7a10-5aa4-4381-a878-101af19714b3@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: al_PbQA1H6dww-HXBEPPSVdj21RAcDRc
X-Authority-Analysis: v=2.4 cv=ZZYQ98VA c=1 sm=1 tr=0 ts=6938becf cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=Q-fNiiVtAAAA:8 a=efuEfnpHt8x5uVf3ZYYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=x9snwWr2DeNwDh03kgHS:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjEwMDAwMSBTYWx0ZWRfX9O4XSmtsu3gL
 C16Yc5qg4L84Zw2jyMuw4QqFv4Hj7Kg1dXZev4W5FsoRTGeu8vSm38VyK12YPJ369ViwFRlfh7r
 PrFmJ06r/VPfXQpFDxV8eq+6RRpmcxOO4fqavg+SHEHIEIoMaZ5nun2Nj1k2n5iSfXdsiQSXIZw
 GdyUZslnZQxpTg97sniX4VdVx4fNWHMH8qk4/aVqMzXtY4u0SY4DXbfkkZ8YGkAEDvD30/MzXLg
 nO8xsDsAcfzJPJo973LsIelMBs9Z/PYAH8O1PnreFtJmF3yI6HmDMyX9r7D5ENdQeyqtsCxRQtJ
 vgS4MP0plQ+sezP9sh3/lzQBfZ2e9nGeNI2BeEFgYzIxh9cJhop/dSw0YRJQcC0Qzh0wwhOwuIn
 AxYdPWE3TZ+fGQVy9lgJufvLRZhnzw==
X-Proofpoint-GUID: al_PbQA1H6dww-HXBEPPSVdj21RAcDRc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-09_05,2025-12-09_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 impostorscore=0 suspectscore=0 malwarescore=0
 bulkscore=0 lowpriorityscore=0 phishscore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512100001



On 12/1/2025 10:54 PM, Oreoluwa Babatunde wrote:
> 
> 
> On 11/30/2025 11:51 PM, Marek Szyprowski wrote:
>> On 01.12.2025 07:31, Oreoluwa Babatunde wrote:
>>> On 11/28/2025 4:43 AM, Marek Szyprowski wrote:
>>>> On 26.11.2025 02:37, Ye Li wrote:
>>>>> On 8/11/2025 7:07 PM, Marek Szyprowski wrote:
>>>>>> On 06.08.2025 19:24, Oreoluwa Babatunde wrote:
>>>>>>> Restructure the call site for dma_contiguous_early_fixup() to
>>>>>>> where the reserved_mem nodes are being parsed from the DT so that
>>>>>>> dma_mmu_remap[] is populated before dma_contiguous_remap() is called.
>>>>>>>
>>>>>>> Fixes: 8a6e02d0c00e ("of: reserved_mem: Restructure how the reserved
>>>>>>> memory regions are processed")
>>>>>>> Signed-off-by: Oreoluwa Babatunde <oreoluwa.babatunde@oss.qualcomm.com>
>>>>>>> Tested-by: William Zhang <william.zhang@broadcom.com>
>>>>>> Thanks, applied to dma-mapping-fixes branch.
>>>>>>
>>>>>> Best regards
>>>>> Hi Oreoluwa,
>>>>>
>>>>> We observed this patch causing kernel boot hang on iMX6 (armv7)
>>>>> platforms if using "cma=" kernel parameter. It only happens when the
>>>>> size assigned in
>>>>> "cma=" parameter is smaller than cma default size in dts.
>>>>>
>>>>> For example, we use "cma=96M" in command line and below reserved
>>>>> memory node (160M) in dts.
>>>>>
>>>>>          reserved-memory {
>>>>>                  #address-cells = <1>;
>>>>>                  #size-cells = <1>;
>>>>>                  ranges;
>>>>>
>>>>>                  linux,cma {
>>>>>                          compatible = "shared-dma-pool";
>>>>>                          reusable;
>>>>>                          size = <0xa000000>;
>>>>>                          linux,cma-default;
>>>>>                  };
>>>>>          };
>>>>>
>>>>> The root cause is this patch moving the dma_contiguous_early_fixup
>>>>> from rmem_cma_setup to __reserved_mem_alloc_size. rmem_cma_setup can
>>>>> skip the cma reserved memory if command line has cma parameter.
>>>>> However, the __reserved_mem_alloc_size won't do it. So this leads to
>>>>> have two cma regions added to dma_mmu_remap, one from dts, the other
>>>>> from command line. But the reserved memory of memblock that only
>>>>> records the cma from command line is inconsistent with dma_mmu_remap.
>>>>> The dma_contiguous_remap clears the MMU paging for the region of
>>>>> dma_mmu_remap firstly, then create a new mapping by iotable_init. For
>>>>> the cma from dts, this causes incorrect memory mapping cleared. Then
>>>>> any allocation from memblock in iotable_init hitting to the area will
>>>>> meet MMU mapping issue.
>>>>>
>>> Hi Ye Li,
>>>
>>> Thanks for pointing this out. From what I see in the code, if "cma="
>>> kernel parameter is being used to configure the default cma region, then we
>>> should skip adding the DT defined region to dma_mmu_remap array.
>>>
>>> I will work on a fix which does this and share here when it is done.
>>
>> I wonder how to avoid adding more such checks to 
>> drivers/of/of_reserved_mem.c and making this code even more tangled and 
>> spaghetti-like... I've briefly scanned that code and it is already quite 
>> hard to follow, especially after commits 8a6e02d0c00e ("of: 
>> reserved_mem: Restructure how the reserved memory regions are 
>> processed") and 2c223f7239f3 ("of: reserved_mem: Restructure call site 
>> for dma_contiguous_early_fixup()")... I wonder how many reserved memory 
>> regions are used on real machines? Maybe instead of complicating this 
>> code even more it is enough to make this configurable via Kconfig and 
>> restore pre-8a6e02d0c00e version?
> 
> Hi Marek,
> 
> There was a change which attempted a simpler approach of increasing the
> size of the static array:
> https://lore.kernel.org/all/1650488954-26662-1-git-send-email-quic_pdaly@quicinc.com/
> 
> The comment from Rob at the time was to revive another thread which attempted
> to dynamically allocate the reserved_mem array like we are doing now.
> Dynamic allocation gives more flexibility because we only use the exact
> amount of memory that is needed. This can save some memory if that ends
> up being smaller than what is specified in MAX_RESERVED_REGIONS.
> 
> I do agree that adding another check in of_reserved_mem.c might not be the best
> in terms of code complexity, so I'm exploring other options on how to keep things
> simpler.
> 
> Regards,
> Oreoluwa
> 

Hi all,

Apologies for the delay in pushing a fix for this.
I've uploaded a fix now:
https://lore.kernel.org/all/20251210002027.1171519-1-oreoluwa.babatunde@oss.qualcomm.com/

I ended up adding some checks in the reserved_mem code to skip initializing
the default cma region when the "cma=" kernel param is being used. This seems
to be the most straight forward way of fixing this issue.

Also, this way makes sense because it allows the reserved_mem code to skip the
default cma node and not add it in the reserved_mem array since it will not be
used as a cma region eventually.

Please help me review and give some feedback.

Thanks,
Oreoluwa



