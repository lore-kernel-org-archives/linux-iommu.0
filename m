Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0DC9221555
	for <iommu@lists.linux.dev>; Mon,  4 Aug 2025 19:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754336281; cv=none; b=uB2O3XW2aOQSbYpF8yRY7voqdWBHYtBN5FoINO1064Sz3k8xJ/Ep5XBfbDSiFlRj5jCv2ZbceXN+t8djzFxOB8MChRppxhK5V2NqT5ONE4COnDDnRhAZEg+YLe8uetjKvR0oyZpT51t9kts4ikHVtcLsBz3RTRz3o+1cTwUZ2qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754336281; c=relaxed/simple;
	bh=gMNa7ghysRE0GnTzj2DIg8E+Jw4M+z2ED1KRbbrmldw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DURiC8ooY9qPqgX6sYuC5GhVBAhge6cXzFyYkGjcJ3HOkjg6Ncg3XPIsV0EK65iUZFbV9vdt58xcv6vqet1ZEvIO9F3lHl4NFnA9sj/DGNIP3/f13oGvnTIcpdUHBLDvJIgO52CL1x384/NSLYxp212bRe7JrqOouLNQX+s1IW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=h9bdvuKm; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="h9bdvuKm"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 574FQXKs007793
	for <iommu@lists.linux.dev>; Mon, 4 Aug 2025 19:37:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ZhETA39faQ5nTi2zmiEubPl3YqYzVEJnQSXgNm1akj4=; b=h9bdvuKmNN1pHB6D
	6/S6iaiA3kebkj+3OBMN1l8fKLNXd3v/6xNZ4J8JQu/KYQTicGIfqudUZmYhOdaR
	+UatLFVjmTXQDIavXf3Xt5NADVn5DO1iznFm9UHtMzndaggB/nShF2sLsGNBMPd0
	n6Sd/SQWbRS+qBVUkKpauOZGL12+Xr5knN+wmTwcFgzWtpuwlk0UShiItN1ODtyu
	DNZ5pjuHmv35gr8ijhjFOW1FRfmaDdxSg7KHUnyTFHtiCVtMpkztMFrNmO3i1Mi9
	2nw2GdUQyIfLj8y/Gcm8FS+L77n34tIoMhD38lXira66iLtmXP4Xp3QZLyWgj/NF
	OWbifQ==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 489buqp2vt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Mon, 04 Aug 2025 19:37:58 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-74d15d90cdbso3353990b3a.0
        for <iommu@lists.linux.dev>; Mon, 04 Aug 2025 12:37:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754336278; x=1754941078;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZhETA39faQ5nTi2zmiEubPl3YqYzVEJnQSXgNm1akj4=;
        b=gz7xRGCBKRXy+3TttYuVC6/IUcyxGK255jdk1k3tXuI0KMqoNkA/0n79QzsRhX9u/V
         dOxRXiyMjk5/8x5QU9ujRFEtMpMnHgqYbjEyHcwQ1oNDetxdOx6kY3/DtLtAjtI9evVT
         XErYYQ4lD15HEOcY+VVzvSIpLyTLTwDQt4NG+VAtgRxV3mBTBuJl1gdEi6ZwbFBtyFOC
         wRX4Sm9FWNMuwJitEvEJ8jQ/pEVcOjIuC8wOuCdTbpvg+p+QkFZkzFnze13KvaL+7nQH
         rMb6pKPCH2i2vHtU8zxalWkf9CEHElqPx5L2+OfrQiSMlotWw14P8TfCX6yetTEzWK7A
         Gbfg==
X-Forwarded-Encrypted: i=1; AJvYcCV03u5MluFMKFGbfUaMEC7r4frFgrbmHYwQXRQp9XCXR699T4CMM/h9p57ns9xFhj+4nxCn0Q==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw6sCMas0xPyH7XBjPy1jRDqXgYT+ZeURizVqxYXUgh8poFefGs
	2h4CQzM2UD5sj6yuziEgv5Zm/7BEWxddPjRnGAD3YCj2a3bSRhODGP8nzR27TzLgz7OiYx1EZ8h
	3oWIi6fNN2V08XVenJkLD2bF03iDeHJTbWGlc0EumLQRo+7pp/J2FFvkqeQ==
X-Gm-Gg: ASbGncvpo9N0R9cXAiGlM5+xuf/qXQX857rit23lu8N0kBK3Cg6JRvmb/hdANf5CNpt
	jmT4AOYVxYOr+gq7gAi9/ddtpSf8YSUN8aCbdFp/CcQThmBBwHao3mVJyCP/ehUaBEhsuGDBDAq
	xx5bu3Lq70UiwUyv5SLPRzV+pNVGLY9mevUsX5lc9x/EaFwK6vMDFwkonZt4V+GNmDwKNkkTpbg
	E0igsgjg7xnlmyZNiGxEfLwQ6CeUelbNxhCtyudlxfS3mlcLv6zF3DLWZWH9Oluzr2gr3dKM/aQ
	s9HALdCDreTgsmvp9oXl0Co9ccJOCOv9j97AbZN4kjx580BQ82Lz4PrTdilv6H/Cisjg00Pcrlm
	a/bi5m8y11MdR03va2Oj046dCcg5s
X-Received: by 2002:a05:6a21:32a8:b0:240:af8:1784 with SMTP id adf61e73a8af0-2400af81b60mr6755144637.1.1754336277812;
        Mon, 04 Aug 2025 12:37:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGjZtGErtEqr0mN/bYFEtV8ckk8GVvca6gvVir73rQPTbuaRSj7qE7ZcUwxOg9STp9FAz1DkA==
X-Received: by 2002:a05:6a21:32a8:b0:240:af8:1784 with SMTP id adf61e73a8af0-2400af81b60mr6755113637.1.1754336277347;
        Mon, 04 Aug 2025 12:37:57 -0700 (PDT)
Received: from [10.71.110.42] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4252b83822sm4242439a12.66.2025.08.04.12.37.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Aug 2025 12:37:56 -0700 (PDT)
Message-ID: <4becbced-8e88-4588-9de6-06f98eae0736@oss.qualcomm.com>
Date: Mon, 4 Aug 2025 12:37:39 -0700
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] of: reserved_mem: Restructure call site for
 dma_contiguous_early_fixup()
To: Rob Herring <robh@kernel.org>
Cc: m.szyprowski@samsung.com, robin.murphy@arm.com, saravanak@google.com,
        quic_obabatun@quicinc.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
        william.zhang@broadcom.com, kernel@oss.qualcomm.com, will@kernel.org,
        djakov@kernel.org
References: <20250730002956.1812694-1-oreoluwa.babatunde@oss.qualcomm.com>
 <20250730224132.GA1822233-robh@kernel.org>
Content-Language: en-US
From: Oreoluwa Babatunde <oreoluwa.babatunde@oss.qualcomm.com>
In-Reply-To: <20250730224132.GA1822233-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 5tvZhupyxb1TQGO9vVivhg8arZDQX5sJ
X-Authority-Analysis: v=2.4 cv=VZT3PEp9 c=1 sm=1 tr=0 ts=68910c16 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=Q-fNiiVtAAAA:8
 a=U-hEzrufn-yrS9YAMqUA:9 a=QEXdDO2ut3YA:10 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA0MDExNSBTYWx0ZWRfX+londWKr1put
 I0RyuR1MtY7doVXNxKtjNxbzZzkF19UgiEYSoR6ubXOlJEKQiSwojxraEhq/YnYgmAAeZsyaZHH
 qPWn7PuTr1vJKTZjMljXPB4Rkam+sns3BphBSKHW6RlDJ37ADqqTqy8UI3Zyl9mEaXl93DvbY7N
 vBLPfkxT2vrS6xNG3S13guwPL5BKNSQKy3HHdjM+PiGKrTUNHSW3eOjIwWPPGKtfJLkqRWUO+W3
 dadQzZhRewhUNUgYUkFp6kUwoVXGsyBlGZLCLk5G6Sc55OgxyJGuv4TNAc1aS/jwDAfK2ymusKm
 NCLE4qdM1jrADnVF0ed6VFg4fyOGHD8QGRVw0hXtQNZ1KUUUWZVnMPjMREf4iZ6/So/Yd2aOIdc
 NodrYUD2Toma/FZYb6c+JxgJWsEVC4amulfb8IPwF5OiyHYWYkJm5seUi3b/Iu3x1IUQju3i
X-Proofpoint-ORIG-GUID: 5tvZhupyxb1TQGO9vVivhg8arZDQX5sJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-04_08,2025-08-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 mlxlogscore=624 malwarescore=0 bulkscore=0 phishscore=0
 spamscore=0 mlxscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 lowpriorityscore=0 impostorscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2508040115



On 7/30/2025 3:41 PM, Rob Herring wrote:
> On Tue, Jul 29, 2025 at 05:29:56PM -0700, Oreoluwa Babatunde wrote:
>> Restructure the call site for dma_contiguous_early_fixup() to
>> where the reserved_mem nodes are being parsed from the DT so that
>> dma_mmu_remap[] is populated before dma_contiguous_remap() is called.
>>
>> Fixes: 8a6e02d0c00e ("of: reserved_mem: Restructure how the reserved memory regions are processed")
>> Signed-off-by: Oreoluwa Babatunde <oreoluwa.babatunde@oss.qualcomm.com>
>> Tested-by: William Zhang <william.zhang@broadcom.com>
>> ---
>> v3: Wrap the call to dma_contiguous_early_fixup() with a check for
>>     CONFIG_DMA_CMA to fix compile error seen on x86. The __weak function
>>     definition introduced in v2 was not sufficient to prevent the issue,
>>     so remove that as well.
>>     Also add Tested-by tag from William Zhang.
>>
>> v2: Add a check for the "reusable" property to narrow things down to
>>     only cma regions.
>>     Also add __weak function definition for dma_contiguous_early_fixup()
>>     to avoid compile errors on architectures that do not define the
>>     function.
>>
>>  drivers/of/of_reserved_mem.c | 20 ++++++++++++++++----
>>  kernel/dma/contiguous.c      |  2 --
>>  2 files changed, 16 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/of/of_reserved_mem.c b/drivers/of/of_reserved_mem.c
>> index 77016c0cc296..cfffecb91c3a 100644
>> --- a/drivers/of/of_reserved_mem.c
>> +++ b/drivers/of/of_reserved_mem.c
>> @@ -25,6 +25,7 @@
>>  #include <linux/memblock.h>
>>  #include <linux/kmemleak.h>
>>  #include <linux/cma.h>
>> +#include <linux/dma-map-ops.h>
>>  
>>  #include "of_private.h"
>>  
>> @@ -175,13 +176,19 @@ static int __init __reserved_mem_reserve_reg(unsigned long node,
>>  		base = dt_mem_next_cell(dt_root_addr_cells, &prop);
>>  		size = dt_mem_next_cell(dt_root_size_cells, &prop);
>>  
>> -		if (size &&
>> -		    early_init_dt_reserve_memory(base, size, nomap) == 0)
>> +		if (size && early_init_dt_reserve_memory(base, size, nomap) == 0) {
>> +			/* Architecture specific contiguous memory fixup. */
>> +#ifdef CONFIG_DMA_CMA
>> +			if (of_flat_dt_is_compatible(node, "shared-dma-pool") &&
>> +			    of_get_flat_dt_prop(node, "reusable", NULL))
>> +				dma_contiguous_early_fixup(base, size);
>> +#endif
> 
> Add a static inline for dma_contiguous_early_fixup() instead of having 
> an #ifdef.

ACK.

Thanks!
