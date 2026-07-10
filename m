Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9712D3A3816
	for <iommu@lists.linux.dev>; Fri, 10 Jul 2026 06:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783665510; cv=none; b=NZAV4lT7OfIGmRBV1z5Xh3s4XvDkR2HvYBdXhnXtydxtSLpslkeMUVe65pQG7DCjmkOG7SYkgvbH7jsRguzcrTr/2YLjHJff9esfc4ocisA37FyHjZNgnlsbjjvpoLoSgxPCuDy5YbsKfM40gegce2sGfxbIYATQsxKmZWu5wqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783665510; c=relaxed/simple;
	bh=VKRIt/7yRmxAz+S9gKURZ4WyeFPoIUvlkDUS5dWUi6k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Rm490cqNo7GmZd2YvgFL/0TIlIJLDWg4eCleJMUFMH3TH2UZpPHQtatea21Ai5nllfgHR3OgoMR+UyMDAwIELxI9b9oPGPgqGwvUpYoGQh0gBxzjMBcv+ICsr8oVG+R3QxVy5DkFh3NxB7cwUyds96fO1fQ8qvcYd1Uz1/kIcB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=An11jyea; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=NTSNBBsv; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="An11jyea";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="NTSNBBsv"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66A3nUCN3848885
	for <iommu@lists.linux.dev>; Fri, 10 Jul 2026 06:38:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	0K5Opuo8W6vFKvh+gdX8BbeA6S2QAhhORoWXkYpGKec=; b=An11jyea+IvpFq77
	RvyfijqFOM1GQc75OTNGUf2BHZXCyUWplzVX5aEvM6EHLptMMrsfNu1mvMo+rTY7
	C1BFzMsCv8ds8Ff5vzjn7zHge+GVICsoYya1/rxoJQz0M3SCX00lLk+zlaaHif0+
	PjouPLZY81+I0wilKDTy00akcR2TdgU8sBZkqcAFlyPxeAtcAxtzRhjNC5yWIvSA
	VvysduvlLdkC5Vm13vnzGgSmW4Cv+TRQeObmcimleXRkQP7/w7KbvjIYUHwX1BgV
	oG3Y0be2lbXtqMawfhrZQXVIiGKD+OsIfyrNL9jWIA9LD795SI2BU1jmXSUkzheW
	uKiLKg==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4faeesu4j9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Fri, 10 Jul 2026 06:38:27 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2cae455cf6dso8455505ad.2
        for <iommu@lists.linux.dev>; Thu, 09 Jul 2026 23:38:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783665506; x=1784270306; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0K5Opuo8W6vFKvh+gdX8BbeA6S2QAhhORoWXkYpGKec=;
        b=NTSNBBsvIDzuytFrYWytTVAemRoKhi+2NtifoamNFZwam/Jvuc4eR97YWy9tWxnFqs
         PtkMezaMnCPQIn2YgWcW193GU0i8YxaqW5h8zOKG8ZkV49QwCoglaiseIJJrVXA1n7PI
         fLbrFJMpEO1wlxPzxuoPS2htU0b+73485ZrQP6A5kcB54d3xvhI5WtyLBlvXaN+urGCr
         eWIYWAFQ6e5qD7UBeEzzmpjHBSDN2n4IKbri/wWHT8NIIkJlODnrrGnawM7LpG0U0Hcy
         XKJsHfSFiZvoTrxy8OYDZkH8s5HbBBbLDbmvUk6YanM7HG+k0xNPMRjHT07McACHpey/
         ysUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783665506; x=1784270306;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0K5Opuo8W6vFKvh+gdX8BbeA6S2QAhhORoWXkYpGKec=;
        b=SLkMuaXKuJUz43h4hE49XQyrGONBWxw0ibKifx7DowhYlha4ttXw5n6Nd9adq16MLS
         X56H1DhdUHJUH592EKiG7sKDXItSgy4XyoqYAT61XeBdkmwQHuHz6SyJ2d0bc382lkHb
         KalUBq7kd+qazIyPDveCCJEy92msZLEJTF74WC3b5uVccXu8rmaXodO9wU2mMLg4BQns
         xxailfdBXSPukoCSo2lfFjo7gqDaHHfI3Gwzu1cyNz7VedehprNm0m0JThm+YCXx/Yce
         qvqVSjuRTP/+oas4oi0ziSUWjHR6yy1SKmmZyyzwXrwu58Zt9IsVODZY5EBcgWRuFHHc
         hZVQ==
X-Forwarded-Encrypted: i=1; AHgh+Ro10LcFqj9as7+Zx9O5K46ovHcrNKwwP2Yhr7s9qdBhKSzjYFAGxG8qX3psE4CJAoEg6Wax3Q==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxd6dE1u48vkA2C1CBgYbCf3JTZ4ScU/c4Ha1TG7PLqJl8z+eQM
	0Qvl932IwHSqHDVq4r0hIx/jEe3FpxxymTrr3aZr4d0/m1gk6FyhVWdSG3RPpl4bAUToyPIYL5B
	SxpOXq5NsD8qCDvEgiibPBFH4eqcIia38Tr1pOqR1y5T4Fs//B2roM8Krtw==
X-Gm-Gg: AfdE7cl4jC8M9Apmxme4QYW3L9PThNFTXZbsW7s8xBD+kaLTvYweEiAJjCXgHdSGL85
	9YlDqeaIe8t1ouztiarDsE61ZyiDzGYNQLNEc8pzpxALbYOjIyL9FPp/nRmuLkRXPP5+dNFx1kB
	WSBz6zT8XQX/4RktiRAzHewgpUDRkXFxtAgXPgE0HuOtXvdiTPRo894ZJFOGqRQQQs044vBG0Gx
	V4ThlrQOtw7IdOjvAt1DNofUxI4rZqxFSFZGWz0XUJItQvkO7wgyVlw00U+uz8MfNPuwr7WiAow
	4jqqCdrnrmFaH5GQGtmsLVJfw+ysvHAo6NGW9zUuSNKZzeFhXklh8PHEfIzq4Ni2U4C8lBbFUlq
	gLf1Al96Gj2Q7xhHyEKpz1wSr/SHtqHb3K45B7fhHcTTlkT1lNzbChDAS09k+7GXwp/EEUim1t7
	NpZBEa9RdpbqCPrgAKZ8em88TltJqT
X-Received: by 2002:a17:903:32c9:b0:2ca:e9dc:7357 with SMTP id d9443c01a7336-2ccea2d8029mr109938195ad.9.1783665506286;
        Thu, 09 Jul 2026 23:38:26 -0700 (PDT)
X-Received: by 2002:a17:903:32c9:b0:2ca:e9dc:7357 with SMTP id d9443c01a7336-2ccea2d8029mr109937745ad.9.1783665505631;
        Thu, 09 Jul 2026 23:38:25 -0700 (PDT)
Received: from [10.193.24.221] (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9bfb7aesm54996575ad.29.2026.07.09.23.38.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jul 2026 23:38:25 -0700 (PDT)
Message-ID: <0d1398f3-c2d5-4717-adf6-bdbc6055606b@oss.qualcomm.com>
Date: Fri, 10 Jul 2026 12:08:17 +0530
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] x86/pci-dma: add "any" keyword to swiotlb= kernel
 parameter
To: Robin Murphy <robin.murphy@arm.com>, m.szyprowski@samsung.com
Cc: corbet@lwn.net, skhan@linuxfoundation.org, akpm@linux-foundation.org,
        bp@alien8.de, rdunlap@infradead.org, peterz@infradead.org,
        feng.tang@linux.alibaba.com, dapeng1.mi@linux.intel.com,
        elver@google.com, enelsonmoore@gmail.com, kuba@kernel.org,
        lirongqing@baidu.com, ebiggers@kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
        aneesh.kumar@kernel.org, alexey.kardashevskiy@amd.com,
        thomas.lendacky@amd.com, jeff.hugo@oss.qualcomm.com,
        thanson@qti.qualcomm.com
References: <20260708114244.246176-1-aakarsh.jain@oss.qualcomm.com>
 <7c21e121-9bce-469e-a983-adbdf3781842@arm.com>
Content-Language: en-US
From: Aakarsh Jain <aakarsh.jain@oss.qualcomm.com>
In-Reply-To: <7c21e121-9bce-469e-a983-adbdf3781842@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: EMB7YoBS4p9MDQ0LnRssVtKJhRAPxuaz
X-Authority-Analysis: v=2.4 cv=bbpbluPB c=1 sm=1 tr=0 ts=6a509363 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=VwQbUJbxAAAA:8 a=QyXUC8HyAAAA:8 a=zd2uoN0lAAAA:8 a=EUspDBNiAAAA:8
 a=LWuNMJU_oDth5YTcOp8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDA2MiBTYWx0ZWRfX5C0Fm0f7TZ+f
 bAthcmnzOAJ+y5NbShC8XwByYqcgoCZ0Skr67yYgj9Vhh1rjnU15wcYrzGDv7RmC8sk7hJALBpN
 R+OC8rjUEfICNN4xLYOpxRrc1BKCe2Y=
X-Proofpoint-ORIG-GUID: EMB7YoBS4p9MDQ0LnRssVtKJhRAPxuaz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDA2MiBTYWx0ZWRfXyS2urI+2gfay
 X+F5Ym3SS1HYcabrZG7Sf1cbOu2u6Z0W5HHdtaVjXMXNqj8Ecx/C0RagSswtqTHcjQxQ04+2KQV
 7eZjTJjopHilV+rT2tMjUd0Dsepgjv4WfRlaN1fGWv9yh1wrdLWLQg2mimzEGItJJwWDjj5uuoa
 HKBY6rx1q2p8A1+yK1D32eOojGH0gCcOjuwBqrCQ48Mqx2wv9cwY7VnD2Tp8Ytd+fXJU7xkHFeu
 9RPJ92u+wgL6sFc/9voWclpmCjF63gni//GNhv3DqRWqEVv/ijsmWYm8SMPwyj0dM0xTnWdW2MR
 HjP8mGWKNjSekNnEqDiYlviZJfvwh41Q3ZMIeA77fMfHQq2SEC0Fv3qWr1sgIFfhGbs7JD9vE+C
 7ok3iqZZ0tHlwMpa0LgRdiMRMvc7F6sISqsQYZChI+ANUKjIoT1hbGKj5KoXJy0dGjYMWVZpTBA
 asTCKJthYdDoW0G+yVw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_01,2026-07-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 malwarescore=0 bulkscore=0 suspectscore=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607100062

Thanks Robin, Marek for the review.

On 7/9/2026 5:58 PM, Robin Murphy wrote:
> On 08/07/2026 12:42 pm, Aakarsh Jain wrote:
>> CoCo guests (AMD SEV-SNP, Intel TDX) require large swiotlb pools for
>> streaming DMA workloads such as high-speed NIC and AI accelerator
>> inference. The existing swiotlb pool allocator restricts placement to
>> low memory (below 4GB by default), capping usable pool size at ~1GB even
>> when a larger pool is requested via swiotlb=<nslabs>.
>>
>> The SWIOTLB_ANY flag already exists to lift this restriction, and
>> swiotlb_init_remap() already handles it correctly via the flags
>> parameter (see CONFIG_SWIOTLB_DYNAMIC path: io_tlb_default_mem.phys_limit
>> is set to virt_to_phys(high_memory-1) when SWIOTLB_ANY is set).
>>
>> However, there is no way to set SWIOTLB_ANY from the command line. The
>> only existing mechanism was via arch-specific code (e.g. powerpc SVM sets
>> SWIOTLB_ANY in pci_iommu_init). x86 CoCo guests have no such path.
>>
>> After Aneesh  series ("dma-mapping: Track shared DMA state through
>> direct, pool and swiotlb paths", https://patchwork.kernel.org/project/ 
>> linux-arm-kernel/cover/20260701054926.825925-1-aneesh.kumar@kernel.org/)
>> removes SWIOTLB_FORCE, x86 pci_swiotlb_detect() leaves 
>> x86_swiotlb_flags = 0 for
>> CoCo guests. The pool falls back to low memory and caps at ~1GB:
> 
> This is entirely irrelevant; SWIOTLB_FORCE has no impact on allocation 
> behaviour anyway. x86 wasn't passing SWIOTLB_ANY before and it still 
> isn't, although there doesn't seem to be any particular reason why the 
> well-reviewed patch for that hasn't been picked up:
> 
> https://lore.kernel.org/lkml/20260625012616.2992535-1-jun.miao@intel.com/
> 
You are right my commit message incorrectly tied SWIOTLB_FORCE removal 
to pool placement. SWIOTLB_FORCE only controls whether bounce buffering 
is forced at runtime, it has no bearing on where the pool is allocated. 
Placement is governed solely by SWIOTLB_ANY. I'll drop that paragraph 
entirely.
I see both you and Marek are pointing to this patch, which fixes the 
issue architecturally. I'm happy to help get that landed instead of 
adding a user facing knob. My only hesitation is the 32-bit concern below:
auto-enabling SWIOTLB_ANY for *all* CoCo guests carries the same 
breakage risk for limited-mask devices, which was flagged here:
https://lore.kernel.org/lkml/0a08cea7-62a2-4b33-8d8b-dd14b3c74235@amd.com/

>>    Without "any": pool at 0x35a9c000 (~900MB, below 4GB boundary)
>>    With    "any": pool at 0x1df9c00000 (~120GB, anywhere in RAM)
>>    [Tested on AMD SEV-SNP guest, swiotlb=4194304]
>>
>> Add "any" as a new keyword to the swiotlb= kernel parameter. This is an
>> explicit, opt-in mechanism that sets SWIOTLB_ANY for the default pool at
>> boot time, without touching any arch-specific code.
>>
>> Devices with 32-bit DMA masks are not affected, they still use the normal
>> low-memory bounce buffer path. The "any" option is only meaningful for
>> workloads where all active DMA devices have 64-bit masks.
> 
> That doesn't make any sense - if a user passes this option then any 
> devices with DMA addressing limitations definitely *are* going to be 
> affected, and quite likely broken altogether. If anything, the 
> documentation should be even more explicit that this should only be used 
> if you do know for sure that no devices have DMA addressing limitations.
> 
You are correct here too. My statement that "32-bit devices are not 
affected" is wrong. There is a single default pool, once it moves above 
4GB via "any", a device with a <64-bit DMA mask has no reachable bounce 
buffer and will break.
The opt-in nature only means the admin accepted that risk, it does not 
make the risk go away. If this option survives at all, the documentation 
must state the opposite of what I wrote: use it ONLY when you are 
certain no device in the system has DMA addressing limitations.

> As a general SWIOTLB-behaviour-debugging option for orthogonality with 
> force/noforce I'm not opposed to the idea, but it is definitely not 
> something that real CoCo use-cases should rely on - if the general 
> consensus if that CoCo environments want a different setup by default 
> then the arch/CoCo code should be taking care of that.
> 

So my takeaway, this patch, if kept, is at best a debugging knob for 
orthogonality with force/noforce, and not something real CoCo 
deployments should rely on. I'm fine positioning it that way, or 
dropping it.
Which brings me to the actual motivation behind posting this patch.
what should be recommended approach for large streaming DMA workloads in 
CoCo guests(high-speed NIC / AI accelerator inference)?
Is the intended direction to move such drivers to the coherent DMA path 
rather than growing or relocating the SWIOTLB pool?

Thanks,
Aakarsh


> Thanks,
> Robin.
> 
>> Signed-off-by: Aakarsh Jain <aakarsh.jain@oss.qualcomm.com>
>> ---
>>   Documentation/admin-guide/kernel-parameters.txt | 5 ++++-
>>   kernel/dma/swiotlb.c                            | 5 +++++
>>   2 files changed, 9 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/ 
>> Documentation/admin-guide/kernel-parameters.txt
>> index b5493a7f8f22..8a1fccbd9b25 100644
>> --- a/Documentation/admin-guide/kernel-parameters.txt
>> +++ b/Documentation/admin-guide/kernel-parameters.txt
>> @@ -7477,7 +7477,7 @@ Kernel parameters
>>               Execution Facility on pSeries.
>>       swiotlb=    [ARM,PPC,MIPS,X86,S390,EARLY]
>> -            Format: { <int> [,<int>] | force | noforce }
>> +            Format: { <int> [,<int>] | force | noforce | any}
>>               <int> -- Number of I/O TLB slabs
>>               <int> -- Second integer after comma. Number of swiotlb
>>                    areas with their own lock. Will be rounded up
>> @@ -7485,6 +7485,9 @@ Kernel parameters
>>               force -- force using of bounce buffers even if they
>>                        wouldn't be automatically used by the kernel
>>               noforce -- Never use bounce buffers (for debugging)
>> +            any --  Allow the swiotlb pool to be placed anywhere in
>> +                system RAM, lifting the default low-memory (4GB)
>> +                restriction.
>>       switches=    [HW,M68k,EARLY]
>> diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
>> index 1abd3e6146f4..34773ae7c770 100644
>> --- a/kernel/dma/swiotlb.c
>> +++ b/kernel/dma/swiotlb.c
>> @@ -80,6 +80,7 @@ struct io_tlb_slot {
>>   static bool swiotlb_force_bounce;
>>   static bool swiotlb_force_disable;
>> +static unsigned int swiotlb_param_flags __initdata;
>>   #ifdef CONFIG_SWIOTLB_DYNAMIC
>> @@ -198,6 +199,8 @@ setup_io_tlb_npages(char *str)
>>           swiotlb_force_bounce = true;
>>       else if (!strcmp(str, "noforce"))
>>           swiotlb_force_disable = true;
>> +    else if (!strcmp(str, "any"))
>> +        swiotlb_param_flags |= SWIOTLB_ANY;
>>       return 0;
>>   }
>> @@ -445,6 +448,8 @@ int swiotlb_init_late(size_t size, gfp_t gfp_mask,
>>       io_tlb_default_mem.force_bounce = swiotlb_force_bounce;
>> +    flags |= swiotlb_param_flags;
>> +
>>   #ifdef CONFIG_SWIOTLB_DYNAMIC
>>       if (!remap)
>>           io_tlb_default_mem.can_grow = true;
> 

