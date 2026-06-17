Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE51A307AC7
	for <iommu@lists.linux.dev>; Wed, 17 Jun 2026 16:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781712829; cv=none; b=TRSneYL5j/gzLOIpaOgZB1O2nys6oILZ07c8jEpzJK8KXdt21kG0gJXWmWajcwFLxthKOpW/muQ5QJAAY2pYzGjv83gvoP7U/8vemLgwT6zQgvvTTspNDvP+fuvVmdvaszq8cG17lYtfWlawpEcnPWPDlvOvMvT5bEXBx/v73j8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781712829; c=relaxed/simple;
	bh=VndfbIpPwbVRR9kgReMPg2FppcVxf5dvVDw8DC4+jFM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GEpXCe8gvi/2R48xKRpgGLmGjlmkKQaUjybkqjiAA3nDMXYbXOohHeo+QVzDEDjzBWKJjFc2vR7KC/jdtK31Wua7OkG8r7i3hsds+udslvc9w2qA6J4I8dM9uquTeC4vKFGzcv39CKguGXZRgWjEqxQPVBgRd4YOF5eb9K9qbUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=M3KjLKXQ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=R5lCGFYD; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="M3KjLKXQ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="R5lCGFYD"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65HG4VXO3297580
	for <iommu@lists.linux.dev>; Wed, 17 Jun 2026 16:13:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	1Fymbf6PKyafYj/na3W/ZlVJ43rZNNl0dvGx9jrs41Q=; b=M3KjLKXQfAKWyeLS
	e+WIlVluUjt3z+srXdLF3bCAQaPN7673hxzzWXRy45BYM84y2DxW+RXkfEHikfXO
	xBSt4PvGTu93+Vp7IwY24ZJHWyhUHAyHk7N+mnZfcrUeClnSdY1Evjh4lo2rn+ob
	T4UiJN16oCY3IQceshFICJJ6Y+06+gVKbfUIc04eg1ZSbC+KXac3Uj8mter308u6
	ooN6VDRq/t3xV74wyq8H267G2lEI6Cm/z0EHCrsGSCCTJFrC9SM3d6ai4WwDPdhM
	xcZzaBDjBPSUcj+IoDqf5X6yeMboTegr6cqL3BXp4rkVHmeywuegOlTf3uke8B2y
	d5WKBQ==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eux2jr9qc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Wed, 17 Jun 2026 16:13:39 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-8423efbfb61so4282231b3a.0
        for <iommu@lists.linux.dev>; Wed, 17 Jun 2026 09:13:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781712818; x=1782317618; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1Fymbf6PKyafYj/na3W/ZlVJ43rZNNl0dvGx9jrs41Q=;
        b=R5lCGFYDsY8sUgdRcCv8ebjxWWs0PgQXt6WWrQb04xZFUC5vpZgeBNZrfa1EJ3YjLI
         s95xpbz7rHBnTQNhPeGoSxJTWi88JY3c04R65bseAN9FyYR6TIYyuTekhQ1H91Tfycmt
         o7BSUjJY6EzVYiCDrkWduSiO+mgQJxDqMMMcZFCtWzqM7XGgLmSf4uNAl42xUkep5pNC
         Med73cPVbKdgbibLZVvxxdrreMlwPg8190KMKVD5ZHJiUBP4iVfubosRAljO9hJRRPtv
         E7APZ14hNeOF34DMNwy1+J4BosgBe8YAwup/o3nqRN4DVIBJGkFE9e7bQhssra21KOTQ
         9fLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781712818; x=1782317618;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1Fymbf6PKyafYj/na3W/ZlVJ43rZNNl0dvGx9jrs41Q=;
        b=h+FRvt6NM7B9Py1+eyfmhORqp6tDHxjZIsJZGCDzeUNX8UZzGqEmsQvZQ8bAWUBMMs
         97chgWipsfi5cC03J4qhxryySPcK1wSAHLhWhXbdYoTKYvInyyYWVuvOBDkThxDEcgM5
         ZvamQFuB1q0QLPNMrCaR4u7GxjGUOElOL/QJjiYh1Yy0hBFohJ3O2J5YkqmzWOlpCmB9
         nNBh81F9DYIJW7zKTIkch2Q8/IXb96gh5itQXywNlY3PGdS8wnlzb5rwqvDUS0y5Uys/
         cHezXjZ7rmb+TEMK/WTGck+vik4ttjCYJ8fqsSdQ42Nlz7u/FiVUroyviWmSgmTtUZ6Q
         1Smw==
X-Forwarded-Encrypted: i=1; AFNElJ/XZrAlG92jSyyWMa4wYOC1UdYbPOJPaOwZtIzuN31yqChdxfoaUVWg5mVKzcBXPxnkV4d5bA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy2bRyR7djQb87NmjKp5HqyRH5jrmM87GHJjQFplafQPSWG6+9v
	F5VFSLqkRvRWlCbT4rlSAtJ5JvMYLEFP1R3KAQxItdqcv/6/008yu7XlKl7bCPRqNPdr3cA/Z2N
	j4Oga9efd89AQ9uvEBLc4c0pTiqWtdLUIHLPqpW9yLkR6CVAXdlu25I2QKQ==
X-Gm-Gg: Acq92OGWWn5caYfQuEgLKSjsCx7BbECv89uFkyGTM88syEqXwuyfAiGgUkJMOm6oycf
	sSGjsnexXI54hOreUae4pwi2VcXeBolfOvfi1iwwfhO58f+erOuCR1movITUWdV1+6fk3fOlQ2b
	WX40yYn1gKtNk8Vr1Z6c1szwRIeK38vm+sMQwN5E6Kenxf+5lQoZQ4UDIxmz64fd1WbzoWoIoMw
	wxZdfWMnijKtMyei30bEBxEZujAmzRQ4bIuK4S7q5SUpHmmxLzxcY/x8k5Zr8GA0+nwBoDwtjbu
	KtvSIf9oSV7Bqg9nh6KZ4YO+ipq5IEvdZb7WRCW7xTurKmMP67cBW0nVQv6gjGRsUDiTGpLidnQ
	9qxCrwVzbMX4fTopAX8sjXXTwH+OiafLwbJRH//E=
X-Received: by 2002:a05:6a00:2a0e:b0:842:5a8d:3036 with SMTP id d2e1a72fcca58-845245808femr5259207b3a.35.1781712818183;
        Wed, 17 Jun 2026 09:13:38 -0700 (PDT)
X-Received: by 2002:a05:6a00:2a0e:b0:842:5a8d:3036 with SMTP id d2e1a72fcca58-845245808femr5259167b3a.35.1781712817730;
        Wed, 17 Jun 2026 09:13:37 -0700 (PDT)
Received: from [10.219.57.228] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8434ad0118asm15320349b3a.27.2026.06.17.09.13.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jun 2026 09:13:37 -0700 (PDT)
Message-ID: <6cbf7d5b-cf7c-4b31-b60e-06e508c633ca@oss.qualcomm.com>
Date: Wed, 17 Jun 2026 21:43:21 +0530
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] swiotlb: introduce Kconfig option for compile-time
 default pool size
To: Mostafa Saleh <smostafa@google.com>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Jagadeesh Pagadala <jpagadal@qti.qualcomm.com>
References: <20260617-swiotlb-v1-1-abfee3faf4ea@oss.qualcomm.com>
 <CAFgf54r0oXgaFMQeBOV+jm70XoMUKFAOkRhNLM2FrFa_JhmwKA@mail.gmail.com>
Content-Language: en-US
From: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
In-Reply-To: <CAFgf54r0oXgaFMQeBOV+jm70XoMUKFAOkRhNLM2FrFa_JhmwKA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE3MDE1NiBTYWx0ZWRfXwxZwP7rZrZBc
 XE1jAJQQGIPiZF3aPIeSp7cz+SKigkKxnBqXaKCIJiDhqD0CDUtVkIWBCTmcR9IkhoB+4Ca8FGz
 d7CDLMnMCK1eTyZB9nLUBdQdt0uMrTsWaO6xMo8Xx6bUYKqnGunh2DgwYjAfQz7xwtKXceGlv4s
 WwyF1rP6LZRyopjOAkdsHfoDxRExLPRll5dKeN02LWH9hLhsSTTfagXecy0B09aWyDR6f8ltvSA
 zVZ+Ji2g7J+kSph54r1anjobgMLuL5pcr9ZrmBExT5lMUFm9CFfego9dsz+Lgy9RxMeSZYvx/lp
 YSR3UAoFEsEVAWuPyk50lzSCvupWUcgM9H1fl9E2emG3qQ9NrrWESQvkb9Vcf1VPqCXdm1EVSNi
 Dpc9J12lGVVf0B3S46JvEXyGSoQ1IcOBXjNf2aj6HpFJsbF4O80BewN1BDIAUZjZcrdJVKaFDn3
 HrCCTKBRgJiPx9qfFjQ==
X-Authority-Analysis: v=2.4 cv=Fsg1OWrq c=1 sm=1 tr=0 ts=6a32c7b3 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=9ljbhfWoGXrtH4PsthoA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-ORIG-GUID: AciPlNyPP9nIfvgdAzoT2kdbQEhY-AGr
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE3MDE1NiBTYWx0ZWRfX0i+AGPVcg1Vl
 xSY1qruyAn6Sw281bZNI5nhNcS55pjxl/lm/toBbB87pj4W0Jp9dr5w/rvqCfPnFLco0cAd+th8
 StrbR1YI2VKmEOkT9aqFlEVvSggcsbo=
X-Proofpoint-GUID: AciPlNyPP9nIfvgdAzoT2kdbQEhY-AGr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-17_02,2026-06-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 suspectscore=0 spamscore=0 phishscore=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 priorityscore=1501
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606170156



On 6/17/2026 2:17 PM, Mostafa Saleh wrote:
> On Tue, Jun 16, 2026 at 10:36 PM <bibek.patro@oss.qualcomm.com> wrote:
>>
>> From: Jagadeesh Pagadala <jpagadal@qti.qualcomm.com>
>>
>> The SWIOTLB bounce buffer pool size is hardcoded at 64 MB via
>> IO_TLB_DEFAULT_SIZE with no compile-time knob to adjust it. On
>> memory-constrained embedded or mobile platforms equipped with a
>> hardware IOMMU (e.g., ARM SMMU) covering most DMA-capable devices,
>> reserving 64 MB at boot is unnecessarily wasteful — the SWIOTLB is
>> only exercised for devices that bypass the IOMMU or have restricted
>> DMA address ranges.
>>
>> Introduce CONFIG_SWIOTLB_DEFAULT_SIZE_MB, an integer Kconfig option
>> (range 1–64 MB, default 64) that allows platforms to set a smaller
>> compile-time default. IO_TLB_DEFAULT_SIZE is updated to derive from
>> this value when CONFIG_SWIOTLB is enabled, preserving the existing
>> 64 MB default when the option is not configured.
>>
>> The runtime "swiotlb=<nslabs>" kernel parameter override remains
>> fully supported and takes precedence over the compile-time default.
>>
> 
> Just curious, why is not "swiotlb=" enough in your case?
> 

We are looking for an approach where we can set a default value of
IO_TLB_DEFAULT_SIZE to maintain and sustain it for a
specific platform or a kernel configuration.

So introducing a Kconfig tunable seemed to be a maintainable approach
compared to "swiotlb=" runtime variable.
(since defconfig is the right mechanism for platform specific 
compile-time defaults)

Further in case of any bootloader constraints - to make default runtime 
parameter, it might require firmware changes on production devices as 
well. (since in embedded/mobile platforms the kernel command line is 
typically managed by the bootloader)

Thanks & regards,
Bibek

> Thanks,
> Mostafa
> 
>> Signed-off-by: Jagadeesh Pagadala <jpagadal@qti.qualcomm.com>
>> Signed-off-by: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
>> ---
>> The SWIOTLB bounce buffer pool size is hardcoded at 64 MB. On
>> memory-constrained platforms with a hardware IOMMU (e.g., ARM SMMU),
>> this reservation is wasteful as SWIOTLB is only needed for devices
>> that bypass the IOMMU or have restricted DMA address ranges.
>>
>> Introduce CONFIG_SWIOTLB_DEFAULT_SIZE_MB (range 1–64 MB, default 64)
>> to allow a smaller compile-time default. The runtime "swiotlb="
>> parameter override remains supported and takes precedence.
>>
>> Before (default 64 MB):
>>    [    0.000000] software IO TLB: area num 8.
>>    [    0.000000] software IO TLB: mapped [mem 0x00000000fbfff000-0x00000000fffff000] (64MB)
>>
>> After (CONFIG_SWIOTLB_DEFAULT_SIZE_MB=2):
>>    [    0.000000] software IO TLB: area num 8.
>>    [    0.000000] software IO TLB: SWIOTLB bounce buffer size roundup to 2MB
>>    [    0.000000] software IO TLB: mapped [mem 0x00000000ffdff000-0x00000000fffff000] (2MB)
>> ---
>>   include/linux/swiotlb.h |  8 ++++++--
>>   kernel/dma/Kconfig      | 22 ++++++++++++++++++++++
>>   2 files changed, 28 insertions(+), 2 deletions(-)
>>
>> diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
>> index 3dae0f592063..1665a9ce8f94 100644
>> --- a/include/linux/swiotlb.h
>> +++ b/include/linux/swiotlb.h
>> @@ -32,8 +32,12 @@ struct scatterlist;
>>   #define IO_TLB_SHIFT 11
>>   #define IO_TLB_SIZE (1 << IO_TLB_SHIFT)
>>
>> -/* default to 64MB */
>> -#define IO_TLB_DEFAULT_SIZE (64UL<<20)
>> +/* compile-time default; overridable via CONFIG_SWIOTLB_DEFAULT_SIZE_MB */
>> +#ifdef CONFIG_SWIOTLB
>> +#define IO_TLB_DEFAULT_SIZE ((unsigned long)CONFIG_SWIOTLB_DEFAULT_SIZE_MB << 20)
>> +#else
>> +#define IO_TLB_DEFAULT_SIZE (64UL << 20)
>> +#endif
>>
>>   unsigned long swiotlb_size_or_default(void);
>>   void __init swiotlb_init_remap(bool addressing_limit, unsigned int flags,
>> diff --git a/kernel/dma/Kconfig b/kernel/dma/Kconfig
>> index 0a4ba21a57a7..3830a63ae032 100644
>> --- a/kernel/dma/Kconfig
>> +++ b/kernel/dma/Kconfig
>> @@ -86,6 +86,28 @@ config SWIOTLB
>>          bool
>>          select NEED_DMA_MAP_STATE
>>
>> +config SWIOTLB_DEFAULT_SIZE_MB
>> +       int "Default SWIOTLB bounce buffer size in MB"
>> +       depends on SWIOTLB
>> +       range 1 64
>> +       default 64
>> +       help
>> +         Sets the default size of the software IO TLB (SWIOTLB) bounce buffer
>> +         pool allocated at boot time. The default is 64 MB.
>> +
>> +         On memory-constrained embedded or mobile platforms (e.g., those with
>> +         a hardware IOMMU such as ARM SMMU covering most DMA-capable devices),
>> +         a smaller value such as 4 or 8 MB may be sufficient. The SWIOTLB is
>> +         then only needed for devices that bypass the IOMMU or have restricted
>> +         DMA address ranges.
>> +
>> +         The minimum allowed value is 1 MB. This compile-time default can be
>> +         overridden at runtime using the "swiotlb=<nslabs>" kernel command line
>> +         parameter. Refer to Documentation/admin-guide/kernel-parameters.txt
>> +         for details.
>> +
>> +         If unsure, leave at the default value of 64.
>> +
>>   config SWIOTLB_DYNAMIC
>>          bool "Dynamic allocation of DMA bounce buffers"
>>          default n
>>
>> ---
>> base-commit: 4fa3f5fabb30bf00d7475d5a33459ea83d639bf9
>> change-id: 20260617-swiotlb-c215ce0b23f7
>>
>> Best regards,
>> --
>> Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
>>
>>

