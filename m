Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53F6D23F422
	for <iommu@lists.linux.dev>; Mon,  1 Dec 2025 06:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764570698; cv=none; b=rk7E2qG84W70MzONxFSBV1kBqRR2mG5jw9tt9J0ZEbZ6wWayDtzA8yT1MxaU/L24C8y44tPUI5Zp1HwCGEk5qp0xdYTBNHyhXFkXkxz4e0mWdeJdtT84jdK+nnH61DSDKHWYvJmJLbIAJMgndc4v1nXHKBrgt1NndUesIWARn8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764570698; c=relaxed/simple;
	bh=CKrfcpTP+RSWd/fvl3u3MIbrTp9/5nNjgOwlMIgeCSk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Mg4ICxlEfuYMvHkzBeG10hN2cgNqU/AswbMbyhNmaln2W58HGyO7sNRY5mSSXIm53p02N+WeE/HjIqQCyHxaR9rqGjed96e7WkcFaPNsDq9a3AY2J8/JNcIhVzUbhQiEzFgvkSLmxcOh6J+K5qfOPVK/eovzTMWRNWB7sUwR3l4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=keHPIo8S; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=P4Bm2C2o; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="keHPIo8S";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="P4Bm2C2o"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AULl5kh2876980
	for <iommu@lists.linux.dev>; Mon, 1 Dec 2025 06:31:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	STmhNXFTBwG+hnEDAKZ8sPKTo1Pq34YKzzGNKO+nYBw=; b=keHPIo8Smn1LOD+I
	9RmpnCfXaBrdhqNKDfVbY2H9omNp2NuDOt0fsX11rb0+J+LySaBsSOdC2jo2GvCZ
	61Vsnp28wN7wYIVihAg4GZTBkTF0N3S1yhNIvxkfIzJoVtV200pn/maaelL2CCeV
	HzVTt57iHKv8uDs5lKotwzgW7YWeSofGv99Nhh9WhU031GvV3QbEO3/FpLQaGzTK
	n73COUXETZL2b268Fu6tDSWD+RSOlWc1hB9BvmgVIDK5CFo38OzTpFKbRT1E75Oz
	JUXGybXJX7500aSjeWrKBhqd5BS1iE0/6mqSUPN2Ah8CO8LMRCTKbLJ0/KKBmmIw
	XV2dbA==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4aqrwsunr1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Mon, 01 Dec 2025 06:31:34 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-bb27b422cf2so5451931a12.1
        for <iommu@lists.linux.dev>; Sun, 30 Nov 2025 22:31:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1764570693; x=1765175493; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=STmhNXFTBwG+hnEDAKZ8sPKTo1Pq34YKzzGNKO+nYBw=;
        b=P4Bm2C2ohjaAATeZLjzGrrzc9XDU2KJSjZ70xdbiciud9HOu6NpC6ITk2d14JPbvef
         0cybrCJBwjkrVHf/pb7YE9zbdRhwt1K6OIrqdJ8ygbomCjSx6LX1LCpmkSXg3Tjcl4aj
         6gx/k06Lxqz0P2ZoS9AE7CGgp7E7OInA+hTdV8f5brJIzjukgXFW3R0j4ISWTMX9isCM
         EwFOA4Sv4FalqRdQr0DOkAGZUeqYC2fggsgUf2aXTUY0NM5f3MnxOE9YQCBTzQWE+9Tk
         8Kalwtii9UYzSwif0kz54mi7KPBRhHV84AachrIL34kwlhpWtxXLr/CRbZiqMHrc8erT
         11Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764570693; x=1765175493;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=STmhNXFTBwG+hnEDAKZ8sPKTo1Pq34YKzzGNKO+nYBw=;
        b=eiiEDEDy8pjCJZne/qeJ9w+UO9Mek93CB0tqWxLmoTfiwYYBbBaftMg+IDLXUizh8I
         xiRqZYbhYh4s2YO55pewSpWymfaB6A/X3l/WY4dykWZYXvwT/4RZNeGLvi0KTA4FIFiB
         /uKHl/gOiLOarBi0paYNM1XjDObKlpSIOI+QU3XawYAeun+Ceym0zwSpiKwJESZ26bf6
         FlpPNgm4CuoFDY4I94jQZL/+5QjkUvJ7F/yZDj/0UScfNxwFL07eIfXBBjdetMGvZzVe
         /diZQ7TdKe/rZMkkU7/5NyCv3QBwPTUWgUL0MRKBCd3SjArP/qdHvT8dVc6rdmMw2l5E
         +KUg==
X-Forwarded-Encrypted: i=1; AJvYcCVl91/dqWxz6MyxjnCYm05ilo3JGNYzbTjrEpKVxv0GYcOcnjpuvNhKOdndw/g94h/DPQfkFQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzUTCHnygumd/ovWxO8MOihnskug3DwFo/946YPTu4uSysa4q/9
	OSCfY0NKR9GKpSUGRSsOqGl1QauUnQZ17E3pHRrZJIPA+n4Y6PLfTrupBdFLy9wzhG7oYSXdVFn
	ujjvfW/VA6wytgGH6Cry85HkxaHsCFGwyQXXwisWnHujxxJlFqzZGOjszjg==
X-Gm-Gg: ASbGnctkT0U4nE8Rq0ifWCXrxFJbPEw/5FY5lrGYzX/Kvh5UvsFbRKYKWZRbJeN19kO
	VZBDj90lzJMRr71tSC6NuyUSG1HesLBefa2kgmcYweG1w1sHT6NYwQSrc2hlh0nXUbmTgaF4EQ5
	Q7C69xX8WgDD5EZZPTtWapI4SNHQ3C3N9kACDwJDNdldHrxGMfZLULR67xV5/QvFtTxb3uZ6GIP
	PwZz9IITjJDTiesi3r4uo0hR8EDV2mvjlaN84AHaopoRd0YVyxkEoUVoxnDn0xNjkra/99IPY2x
	OwuMdGv7HOFKFvi9+4Mta/pbroJmHMcQaUCx9O6s/Ixfn9Qg2Hkzr+zG66tNKZTyHjkT4WXwWjv
	BQm0nAWME2zP+P2wvPvThfY2yLpcOSkKiXMz6lacGlBr+MTY=
X-Received: by 2002:a05:693c:401a:b0:2a4:3593:969a with SMTP id 5a478bee46e88-2a719279e30mr21303241eec.23.1764570693134;
        Sun, 30 Nov 2025 22:31:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHq25E9R36CuT3AgjBKOaRQJujlghzIDuiLwY3y65LSvd45sTEgzm6NR9GN/sTVrOwajY87Rg==
X-Received: by 2002:a05:693c:401a:b0:2a4:3593:969a with SMTP id 5a478bee46e88-2a719279e30mr21303218eec.23.1764570692586;
        Sun, 30 Nov 2025 22:31:32 -0800 (PST)
Received: from [192.168.1.12] ([70.95.198.110])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2a965aafd17sm43254443eec.3.2025.11.30.22.31.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 30 Nov 2025 22:31:32 -0800 (PST)
Message-ID: <306596c4-cc91-4500-b705-50e619e9f38e@oss.qualcomm.com>
Date: Sun, 30 Nov 2025 22:31:16 -0800
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
Content-Language: en-US
From: Oreoluwa Babatunde <oreoluwa.babatunde@oss.qualcomm.com>
In-Reply-To: <3b0cc36d-0f7e-4d07-949f-fce670170247@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjAxMDA1MSBTYWx0ZWRfX8quH/qRmdaIz
 4a32Z+moA2QJszr3vlmEJ4z1AnrKzgcyLGZm7ZPmF8QpqpAfXE77JL94XoweUqZAjXluiskY1cO
 dClehQ4d6d5hNHn09PnsK1lcdcV0IjzzHLZrtjsRvcsNHLdBdRkzj7PH1y27nkeoEG72fJdMOPH
 hBIeCK+4wrixuKyXY8gcdBZzbMdGNCd91WgRhPOVbl3qceOwcCltL1wt+sAW/WS6hhIW0W0yhZM
 bUuZALjapILMfucYklUoXnnmRzJJnEp9TIxym8Gd/U9amizZEiyg/X6L5J9K02OJ3vfhKylmL0a
 Q1An9ZnpJl7MEjoCYYUi/8JIoh8zV2zYskDU0ODOVRUzCXaC49sLAEDaW/Xs3Z0wbym0gDnVvxQ
 M97HztHxSr8e5rtMu45fKvvjjCV+hA==
X-Proofpoint-ORIG-GUID: bpjWfauxL2Tr2BToIS2LKXUq0p5DK6kP
X-Authority-Analysis: v=2.4 cv=WONyn3sR c=1 sm=1 tr=0 ts=692d3646 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=46YzWcEg/N/3maUrm97V4A==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=Q-fNiiVtAAAA:8 a=EUspDBNiAAAA:8
 a=dCyIEBchpJQOD_9XQmUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-GUID: bpjWfauxL2Tr2BToIS2LKXUq0p5DK6kP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-28_08,2025-11-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 malwarescore=0 clxscore=1011
 lowpriorityscore=0 bulkscore=0 suspectscore=0 impostorscore=0 spamscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2512010051



On 11/28/2025 4:43 AM, Marek Szyprowski wrote:
> On 26.11.2025 02:37, Ye Li wrote:
>> On 8/11/2025 7:07 PM, Marek Szyprowski wrote:
>>> On 06.08.2025 19:24, Oreoluwa Babatunde wrote:
>>>> Restructure the call site for dma_contiguous_early_fixup() to
>>>> where the reserved_mem nodes are being parsed from the DT so that
>>>> dma_mmu_remap[] is populated before dma_contiguous_remap() is called.
>>>>
>>>> Fixes: 8a6e02d0c00e ("of: reserved_mem: Restructure how the reserved 
>>>> memory regions are processed")
>>>> Signed-off-by: Oreoluwa Babatunde <oreoluwa.babatunde@oss.qualcomm.com>
>>>> Tested-by: William Zhang <william.zhang@broadcom.com>
>>>
>>> Thanks, applied to dma-mapping-fixes branch.
>>>
>>> Best regards
>>
>> Hi Oreoluwa,
>>
>> We observed this patch causing kernel boot hang on iMX6 (armv7) 
>> platforms if using "cma=" kernel parameter. It only happens when the 
>> size assigned in
>> "cma=" parameter is smaller than cma default size in dts.
>>
>> For example, we use "cma=96M" in command line and below reserved 
>> memory node (160M) in dts.
>>
>>         reserved-memory {
>>                 #address-cells = <1>;
>>                 #size-cells = <1>;
>>                 ranges;
>>
>>                 linux,cma {
>>                         compatible = "shared-dma-pool";
>>                         reusable;
>>                         size = <0xa000000>;
>>                         linux,cma-default;
>>                 };
>>         };
>>
>> The root cause is this patch moving the dma_contiguous_early_fixup 
>> from rmem_cma_setup to __reserved_mem_alloc_size. rmem_cma_setup can 
>> skip the cma reserved memory if command line has cma parameter. 
>> However, the __reserved_mem_alloc_size won't do it. So this leads to 
>> have two cma regions added to dma_mmu_remap, one from dts, the other 
>> from command line. But the reserved memory of memblock that only 
>> records the cma from command line is inconsistent with dma_mmu_remap.
>> The dma_contiguous_remap clears the MMU paging for the region of 
>> dma_mmu_remap firstly, then create a new mapping by iotable_init. For 
>> the cma from dts, this causes incorrect memory mapping cleared. Then 
>> any allocation from memblock in iotable_init hitting to the area will 
>> meet MMU mapping issue.
>>
Hi Ye Li,

Thanks for pointing this out. From what I see in the code, if "cma="
kernel parameter is being used to configure the default cma region, then we
should skip adding the DT defined region to dma_mmu_remap array.

I will work on a fix which does this and share here when it is done.

>> From commit, I don't understand what issue does this patch fix. Can 
>> you look into the regression and provide a fix patch.

Please see below conversation for details on the original issue this patch fixes:
https://lore.kernel.org/all/5aa94f41-c689-443b-8665-c6913ff5ba8f@broadcom.com/

Thanks,
Oreoluwa



