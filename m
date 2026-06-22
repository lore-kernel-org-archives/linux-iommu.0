Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E37783BBFC9
	for <iommu@lists.linux.dev>; Mon, 22 Jun 2026 14:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782139518; cv=none; b=QV6iHKYBmGySRsRqj6t0DrKr10BMbf1FI8FXx2lPDLgdN3t8Br44R2cMwSEwffjUpo+LSTw0wbHytKBvoWcjG2dUsGb73gb9YFeW23TUq9z2cKACH7w8AsaVEjdMzUruPIRI2GlO9anSHdY6GVTCJ2n8Akun47HnWf9McomP15w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782139518; c=relaxed/simple;
	bh=LA7aUgosHwpJNqhhdQ6Hlje+F/G2SdsLcNndAVB2eBE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z28khg4I7fW40vdltje1CDSogdhiIlP3eunDMv5m8o/P+qB17I+7IdK7n9/vL0ybiyc3O2k0LrSROyvUe+EF/pZP/RgqtdcjevQ2ftgujci1Nw/xGeHpoYy6eOR8FtjiR9QjdVRaR0lWVCEGaT5xqc4sZXtg3PS/KOEFjPFnf5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZgzVryjJ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Y6aIHXgV; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZgzVryjJ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Y6aIHXgV"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65MDFbQ0773283
	for <iommu@lists.linux.dev>; Mon, 22 Jun 2026 14:45:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	gV4xDRUurhfQjcVnQzsMOKQF1/Zp8ED3KFqFWdXznZ0=; b=ZgzVryjJ0FApmJcK
	P0vLglnB8o12f2Lf9AIhmXnRpEPnj24uPSb2WE2ObJ/obUZ/8PMQw7foD2M1hvuf
	eBU2t55Emfc0aFujQJfvM+1P8yayZmqbUxfQ6LPC27RfxXa4Jvp7RUDkjXQlCGrI
	Wq5/6ED48lVMIsXuJ1D1sVoB0hGFr4ng16YpusFhFZNEMOkNd2P+ziVdQ8+juOpD
	kJsFx33JDdplrgOK3j0TCl3Ae9Uow3xyhFycOYldfN/wZerRPlqxFaE9c7CkXmKe
	8WPWC1wF2u/iZu6oZroxMYq2vgT3ZH7p90n1U0XETkN0zjNRUqte7CN9eq/YxOWh
	kP1AMg==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ey2yj8ybc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Mon, 22 Jun 2026 14:45:16 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-8421f5d76aaso3087489b3a.2
        for <iommu@lists.linux.dev>; Mon, 22 Jun 2026 07:45:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782139515; x=1782744315; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gV4xDRUurhfQjcVnQzsMOKQF1/Zp8ED3KFqFWdXznZ0=;
        b=Y6aIHXgVnn3QrqjnkaLweePC/V4+LdySOlSv4PDBFTZ3zN13GqP44nTXsPpsxh9Dz8
         twwZvhsn9CqHqfgWNdm6ZWgcLoeWwaWz/QKGgMg/NXdNns+uMr9Qr1FftKyEzukulsu3
         AjFmaLW5OG+vJRIfsy9/QOBHSXHyNhxAcLVHzBHyl9eU1DnTEHnWTCo9g+y+v2aKCYvB
         5ge6mhxSkBvZb+rtZ7HBzrVQGEHMNLwwD7uooc2bFCl63Ko2NxM15HY8LRaPu5NtVC4a
         /0Lo37760AO0Lp/aVZ++GZUGDewqYAu4rDQ8VGvakSpnZcjqvWIMVV4gO2P7i4kIPV2a
         hjtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782139515; x=1782744315;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gV4xDRUurhfQjcVnQzsMOKQF1/Zp8ED3KFqFWdXznZ0=;
        b=i8uD9f3p7rsURzyVe4iSf7LtxCpEGZnLNHF9Wh5RP8lkqVamGy/aTwp8Ns46MbNkhY
         ZLET0c9z1D905pw9XTGWDglfgSTX0l6JMu2y9cz5aTFJVhPHudTtizocDuSjn/S8a7YO
         JLQ01tCCHzLK+xD1iG6p/+sujisgXquE1bil17oyHSoqRjuti2ImptKSkNZGa25QNLxj
         QBVJr9oZy3bdJQA4zuYieAHAf6mstUl8PfUHcBSdJxF1MsS2Vn+pAnrmV/ZlvaGJnZL8
         MfPNE3Hjz5geT4YPJwR/1ERbQX8+J/QyuWYcPLB+CHw83/fTr5v8zqoUHp/tQ9zC/cuW
         Dnug==
X-Gm-Message-State: AOJu0Yy/sA7ZGjhZAM74yMplkHCy3pS+ikl+asU0bdNbgP+E1MaVnQQ9
	76kLeyieYU8zfr5xv38ekVNXwwOqvs2w3c2fiNFYIuVxDAPQ/QhXmt0lhXayntEoXcHi6dcnJyI
	FU/ksz7un7yeSmeatqjMBKRIU9+8P2EpXdBI/xzqKLBIvoUbtjrNXu0eI8g==
X-Gm-Gg: AfdE7clHSzRhWfxO+BQZKECu6e2neFBn6DQteM12nIMewnhat+BQgDWYBmd7LkwVj4w
	ceRWR70ccXq4awJ4c/I0ds/WobRJv4ktDPP0TGBB1EYq6XTofYRrejePJM4Nak1+EYN0i6eJ73D
	a9WKTHZt9mdpBvqS+4ZcmF9x2GGgRLGIvm7+k6vycn3pKgRV/FMCWQPryYJ235R/8AGei9wNrx9
	7mQmClUraIlCGMBFgkT0RZmhPciGdxq5McU4I78rcM7RQ2fiXmPXkuFGbcp8hCxqfa+vIZ4lICi
	wEYn6WR+D55/1+5dRPIFaH9BSLT/98H6a+SmdsPhiFuKk0oSypQr1uUvPqTD/5s4/5mMVx5KDxU
	63Aq+WVC7N6oNnH2i+sSKwq5J23/FlF104reWAQ==
X-Received: by 2002:a05:6a00:4fc4:b0:81e:ef16:b288 with SMTP id d2e1a72fcca58-84550872119mr16323727b3a.22.1782139515133;
        Mon, 22 Jun 2026 07:45:15 -0700 (PDT)
X-Received: by 2002:a05:6a00:4fc4:b0:81e:ef16:b288 with SMTP id d2e1a72fcca58-84550872119mr16323684b3a.22.1782139514575;
        Mon, 22 Jun 2026 07:45:14 -0700 (PDT)
Received: from [10.219.56.41] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84564ecd784sm8132407b3a.54.2026.06.22.07.45.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jun 2026 07:45:14 -0700 (PDT)
Message-ID: <75e435db-a24a-4852-8ca2-23f46e161fcd@oss.qualcomm.com>
Date: Mon, 22 Jun 2026 20:15:10 +0530
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] swiotlb: introduce Kconfig option for compile-time
 default pool size
To: Michael Kelley <mhklinux@outlook.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>
Cc: "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jagadeesh Pagadala <jpagadal@qti.qualcomm.com>
References: <20260617-swiotlb-v1-1-abfee3faf4ea@oss.qualcomm.com>
 <SN6PR02MB415703094466F2E2B9025868D4E32@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Language: en-US
From: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
In-Reply-To: <SN6PR02MB415703094466F2E2B9025868D4E32@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: VMY3EbtcrnVjsiKiF4GLdggJiwYeW0Cj
X-Proofpoint-GUID: VMY3EbtcrnVjsiKiF4GLdggJiwYeW0Cj
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIyMDE0NiBTYWx0ZWRfXxtjvtX7fRYRQ
 8gO6oGG6//BBv4Jef4DcoyUVim5oGcBqwLHBJVZJUUFH49Durq4efngDogDq84YcTo20W68owqV
 EkYw4xBCuEJ5u2Rdd5iQVwjF8CL+OtE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIyMDE0NiBTYWx0ZWRfX4C5KRzCeBn8W
 QhYVtTVQqMh+xT179KcFS7gncZf4FT6ajBxK32QeVln9pONNVDIKyk1t6mvSYbNJquhmkOmeRHK
 UNiL++dpRQKOoKMDj9W0TZpBviuc1fbFNRu8/u/An0Feul6ze0EJkKunDHvWC69ekyFtgelL5PU
 9EmD54I5IVVgnOOG4cV8xxUT8YS6qvYtmlnm8KYdcndMFF9eoSAXxsgkilkBQ1tRE+wcgqi05qG
 LiStF+4Y0uPETZ/SLpzMSo95QUg/8KU4wIYG1XEMek308Q8LyRW/69JMC7KtPmkC6E5oQE4tkAO
 qYf97eNXvVyOWiQ/bZ6OWRnD5Dh10uP1M0BWWXc188GUj9QJMvgrWqa7kT/7KBAG0UFb3Uusxbq
 0er4vcZ+xh4BS9Dr09142wq4eIJNGIAabRh1d7rYyDGdcV8SrbBZocmS0rPybO5HMypviz9Xyt6
 SnazVw6n9NiVBoyjR4w==
X-Authority-Analysis: v=2.4 cv=YLSvDxGx c=1 sm=1 tr=0 ts=6a394a7c cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=9ljbhfWoGXrtH4PsthoA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-22_02,2026-06-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 bulkscore=0 clxscore=1015 phishscore=0
 adultscore=0 spamscore=0 suspectscore=0 lowpriorityscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606220146



On 6/18/2026 9:34 PM, Michael Kelley wrote:
> From: bibek.patro@oss.qualcomm.com <bibek.patro@oss.qualcomm.com> Sent: Tuesday, June 16, 2026 2:36 PM
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
> 
> This message sequence is surprising to me -- there should not be any
> roundup if the default size is 2 MiB and there are 8 CPUs. I ran the patch
> with 8 CPUs and set CONFIG_SWIOTLB_DEFAULT_SIZE_MB=2, and
> no roundup was reported. I'm curious as to what configuration produced
> the "roundup" message.
> 

I see inside swiotlb.c, we have a print for rounding off based on the
number of slabs, inside the check for "round_up_default_nslabs()"
pr_info("SWIOTLB bounce buffer size roundup to %luMB",

Probability of getting the print based on the number of slabs.
<I am assuming your configuration is having nslabs in power of 2>


> Also, there's some text in Documentation/core-api/swiotlb.rst that
> describes the default size of the swiotlb, and how it can be overridden
> with the swiotlb= kernel boot option. This patch should include an update
> to that text to mention the new CONFIG option.
> 

Ack, thanks for this suggestion. I will incorporate in next revision.
It would be a good information for someone trying a similar approach for
setting the default option to custom value.

Thanks & regards,
Bibek

> Michael
> 
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
>>   	bool
>>   	select NEED_DMA_MAP_STATE
>>
>> +config SWIOTLB_DEFAULT_SIZE_MB
>> +	int "Default SWIOTLB bounce buffer size in MB"
>> +	depends on SWIOTLB
>> +	range 1 64
>> +	default 64
>> +	help
>> +	  Sets the default size of the software IO TLB (SWIOTLB) bounce buffer
>> +	  pool allocated at boot time. The default is 64 MB.
>> +
>> +	  On memory-constrained embedded or mobile platforms (e.g., those with
>> +	  a hardware IOMMU such as ARM SMMU covering most DMA-capable devices),
>> +	  a smaller value such as 4 or 8 MB may be sufficient. The SWIOTLB is
>> +	  then only needed for devices that bypass the IOMMU or have restricted
>> +	  DMA address ranges.
>> +
>> +	  The minimum allowed value is 1 MB. This compile-time default can be
>> +	  overridden at runtime using the "swiotlb=<nslabs>" kernel command line
>> +	  parameter. Refer to Documentation/admin-guide/kernel-parameters.txt
>> +	  for details.
>> +
>> +	  If unsure, leave at the default value of 64.
>> +
>>   config SWIOTLB_DYNAMIC
>>   	bool "Dynamic allocation of DMA bounce buffers"
>>   	default n
>>
>> ---
>> base-commit: 4fa3f5fabb30bf00d7475d5a33459ea83d639bf9
>> change-id: 20260617-swiotlb-c215ce0b23f7
>>
>> Best regards,
>> --
>> Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
>>
> 

