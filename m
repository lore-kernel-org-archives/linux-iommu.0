Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85ED84A33F5
	for <iommu@lists.linux.dev>; Thu,  2 Jul 2026 13:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782999886; cv=none; b=Bx9ek0aRd/guPRFvU9LcA3c5YCYWYpAKhFnSeHeS4io64Fm9auYGx9YttlwbKuQuEezVOP0qj3gVQScYSyCuqPzJIAxlm6qAht3cwTbsUq4g2loRoqHl0JxjzKQD37Z0P9f4tTtALZNe4gmlz5JYCTf275kz9JqkTVu3LekQA4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782999886; c=relaxed/simple;
	bh=lR98lxEbhbbF1xIiWb1kkAkNRqCFwF+omC/zVnpBF7U=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=b0nHX8cDdVSRhtFqDFAIyMCcMwjS/868MZAvLCnwki5e6WK9PShJtMmAB5vcrEUH0SswmDVpZh9BmQAfypNyei+dFk38yEFQZx/8ZqTbtEOhk1JrOYil2cJqKb6TLNU4pVsZg6CidZT49A+2ZKe2iKpPltoMz+hu6+Vh7RAB1Cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Ok/jHZaU; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=AJBX6Z4f; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Ok/jHZaU";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="AJBX6Z4f"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 662D0k58519237
	for <iommu@lists.linux.dev>; Thu, 2 Jul 2026 13:44:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	dhQYWsgUDbnG/kOSy7DZkDM/sDPwiVS2gdi7188nGOY=; b=Ok/jHZaUrjTfbp6e
	cS/e8ZFWzwjRdrQcr+xSuwNtcZyg4eIK2iPqxogE2SiPV/PQQE9oLDgZaIb8GkAp
	Fv0I9WYal79fZ0qdTf6KVmw+p66nRnx1KzqaoTQhLi6unUFIKsZHoCSYH6jcJ1AV
	SkTjHccHoyUPXA+JgLOPqj7oI+A3X5cF47FL70ncA6cm9burdB6oiq7ATS708uLk
	XoekjmRh2CIN408ipWWpJceHwMo6qOCjFUZyeixeg5Iw/1rOvcjbpP20tiBNH6u5
	F5ZPHefhBu+zlEF7LLZR3p08SSqjygw2uF6xcEkkZlX9B6Qm9ZBR22aaYJEnzuEn
	9zqUyg==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f5qnp8dva-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Thu, 02 Jul 2026 13:44:42 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2ca0d4fb061so29980665ad.3
        for <iommu@lists.linux.dev>; Thu, 02 Jul 2026 06:44:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782999881; x=1783604681; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=dhQYWsgUDbnG/kOSy7DZkDM/sDPwiVS2gdi7188nGOY=;
        b=AJBX6Z4fmp999asI2iuDJGmLCcJv5q3ZQWN0cOv+wu6t1IaJ0e8TNkmJUlAaEBVZ7r
         IW7L415pAAVXn9LP28sguU7h2EbWaaq+9la+xHHGjZS5DSZlE8VjusxRmrfuoXkz8Tzo
         Jvog/ITiOChIyQsY/wwjX3QnP8nVGKbdTxN8NoIfk7SfiToQDTldAn5/S9XgouCzFBOi
         0knPwbPIQlSscOhewev6reGaWXieOLt7BILU86xOV7i7iEmzKXHcE0SRRmkpNPk9EKhJ
         E+KcuEpC2TS7+AVBLHUqou+AwJZe6vG3WKvOLjssiE2uO45UE1Mjj4NHpyL9E+yrs3+7
         hnhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782999881; x=1783604681;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dhQYWsgUDbnG/kOSy7DZkDM/sDPwiVS2gdi7188nGOY=;
        b=SNuBFJqYx/kMtruwYJ2Go2SpeMzmyvpidrXVrzzjLihVmMKfkJ4rfrqPQZUIR2kbOf
         Swe2NlSQQXIUwqI+Om+Qhdweum86G0iJF0NAH7V2CBGvhuURBt30j2nQvuE/cMqVRp/c
         vQJc1yOKfwNEcEqR943I3a7CMTnCNDnfYK9gLCSdmQUdqi5Tn+p9OI+/l7/YY5MSnznA
         As665RnS7yqVTpkzHK0TsfAD7Ftv9ssX9ny3IzBmMiCZkqf/ZEn/eokf2gpNPXOqNO9x
         sq6TLJVfSCcKFLvUanG1xRxrb/dqwGk1nYQmNu6/WqexlrqJLYFbTHs084HXsg1fgOQA
         BZeQ==
X-Gm-Message-State: AOJu0YyL0uC9oZF5CmE1yYuZ+VQgVULG0UYkLVMXjRTU3duFWgimdWBn
	woNz9sI046zAAwxizdyGYydVU/1GOQcwo7khMMsL2Q+rnAPCzmWxCUUyKiINvacSjfD5AMBGXMt
	W4NE+y6UQv/txkbKAnCpMVT52qKev5mzH3rImKwRUCzMQAy+LIbe3tFx/SQ==
X-Gm-Gg: AfdE7cnpuopbMTEBqW0gTxKJqqs6KOVQYYf6xDyh6wlGRf2repoK+ozGL3H+q3IRaQq
	hIXLns2e1E7fsDE4J1/k8JcYEhXI7ikzeyUQdKIr+7LTZGwnA+vSQWahhAe75S09iYhLpudDmkT
	h2m/RbmAef0ElTUThg3b9hnRpec58FCznhkMtBMDmr42E8/EP1wzTyYtFRn6Iw83TkKMna/nc56
	RSD3Uwk4vMHX9RcOAz1opLqXitc4jiTTG5E1DZAaMzao3S9brKH21zTFcVWJfsXe/gg0KOdEkX4
	IjFJme4HrI/nZn+4pTvarv5oaQe3yKSxPlgmoHKleN5TEOGODQLo7zAPZiIqS9/36MdnsrlKiLz
	1mf6B6A8IXkJ73DhDq8ZpdzmaaCsnIbNWyR2FFjE=
X-Received: by 2002:a17:902:dac3:b0:2c9:fb11:1bf4 with SMTP id d9443c01a7336-2ca7e6545e6mr63214125ad.7.1782999881374;
        Thu, 02 Jul 2026 06:44:41 -0700 (PDT)
X-Received: by 2002:a17:902:dac3:b0:2c9:fb11:1bf4 with SMTP id d9443c01a7336-2ca7e6545e6mr63213895ad.7.1782999880797;
        Thu, 02 Jul 2026 06:44:40 -0700 (PDT)
Received: from [10.219.56.198] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ca9a90b01csm14150485ad.26.2026.07.02.06.44.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Jul 2026 06:44:40 -0700 (PDT)
Message-ID: <70dd2528-e0b3-4bbf-af8c-7dcdd3bd4008@oss.qualcomm.com>
Date: Thu, 2 Jul 2026 19:14:37 +0530
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] swiotlb: introduce Kconfig option for compile-time
 default pool size
From: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
To: Michael Kelley <mhklinux@outlook.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>
Cc: "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jagadeesh Pagadala <jpagadal@qti.qualcomm.com>
References: <20260617-swiotlb-v1-1-abfee3faf4ea@oss.qualcomm.com>
 <SN6PR02MB415703094466F2E2B9025868D4E32@SN6PR02MB4157.namprd02.prod.outlook.com>
 <75e435db-a24a-4852-8ca2-23f46e161fcd@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <75e435db-a24a-4852-8ca2-23f46e161fcd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAyMDE0MyBTYWx0ZWRfXzIjnlUf9H7G+
 TUCBX/ENa9TZfvE2Mvtj+ite89bw0vwg9eTkNHrjTSfXtnM4bSiOhe4cgneiiRR+4qyAPiQkRV6
 SbybY7RAXIGmLrjqW0T7vScybfgy6Ls=
X-Authority-Analysis: v=2.4 cv=FoI1OWrq c=1 sm=1 tr=0 ts=6a466b4a cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=4LGNN7F37lkCH3xNYkkA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAyMDE0MyBTYWx0ZWRfXw3UOxewR469w
 wI0Gw/TzlGmf4ZXzDihnBs8UbZFq6Mkbs4825mxUkCm16+vMt49itxpv1FtwfS5CWYqcu1LZvPW
 xXP9ZJ0/1Twf0lpAquL1ETRRHo9/D6RnIR1gfzaosr9764f35HFxPhvjKzmNXcz3xOOlWmwR2F5
 tWoBM5dbYz7jorzOnA7OybB28ARWBdj3IRX4UDjAEQeqWG4AXsLbiKS7F/rpHkloJi1Lyi8xZMJ
 B4VA3TLnwZgeI+9Uh8DnvkHlvJRI4VC7NakObSsD9oZ+vARXs3Og24cReBX5ca/jVztx5tNfzhx
 qHJD5jjiOtxFzTi9fhbaQfxzox613LoQuxYWa2e1GW3D644nspjzVCh2OyRDJwGQk9cHxoA/3Af
 YoniTiUAGY4cEXeWmkIoAe39xlmmiPw3VNZXUiT22n4WM3F5x4ONF3oHNJkeIIlrhE0VxOVrY9w
 IIfofeos/DQNsb+hdEQ==
X-Proofpoint-ORIG-GUID: KrSyZX4_LKuPBQO1vRGiZIpvuKOFtOBG
X-Proofpoint-GUID: KrSyZX4_LKuPBQO1vRGiZIpvuKOFtOBG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-02_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 clxscore=1015 lowpriorityscore=0
 priorityscore=1501 phishscore=0 bulkscore=0 spamscore=0 suspectscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607020143



On 6/22/2026 8:15 PM, Bibek Kumar Patro wrote:
> 
> 
> On 6/18/2026 9:34 PM, Michael Kelley wrote:
>> From: bibek.patro@oss.qualcomm.com <bibek.patro@oss.qualcomm.com> 
>> Sent: Tuesday, June 16, 2026 2:36 PM
>>>
>>> From: Jagadeesh Pagadala <jpagadal@qti.qualcomm.com>
>>>
>>> The SWIOTLB bounce buffer pool size is hardcoded at 64 MB via
>>> IO_TLB_DEFAULT_SIZE with no compile-time knob to adjust it. On
>>> memory-constrained embedded or mobile platforms equipped with a
>>> hardware IOMMU (e.g., ARM SMMU) covering most DMA-capable devices,
>>> reserving 64 MB at boot is unnecessarily wasteful — the SWIOTLB is
>>> only exercised for devices that bypass the IOMMU or have restricted
>>> DMA address ranges.
>>>
>>> Introduce CONFIG_SWIOTLB_DEFAULT_SIZE_MB, an integer Kconfig option
>>> (range 1–64 MB, default 64) that allows platforms to set a smaller
>>> compile-time default. IO_TLB_DEFAULT_SIZE is updated to derive from
>>> this value when CONFIG_SWIOTLB is enabled, preserving the existing
>>> 64 MB default when the option is not configured.
>>>
>>> The runtime "swiotlb=<nslabs>" kernel parameter override remains
>>> fully supported and takes precedence over the compile-time default.
>>>
>>> Signed-off-by: Jagadeesh Pagadala <jpagadal@qti.qualcomm.com>
>>> Signed-off-by: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
>>> ---
>>> The SWIOTLB bounce buffer pool size is hardcoded at 64 MB. On
>>> memory-constrained platforms with a hardware IOMMU (e.g., ARM SMMU),
>>> this reservation is wasteful as SWIOTLB is only needed for devices
>>> that bypass the IOMMU or have restricted DMA address ranges.
>>>
>>> Introduce CONFIG_SWIOTLB_DEFAULT_SIZE_MB (range 1–64 MB, default 64)
>>> to allow a smaller compile-time default. The runtime "swiotlb="
>>> parameter override remains supported and takes precedence.
>>>
>>> Before (default 64 MB):
>>>    [    0.000000] software IO TLB: area num 8.
>>>    [    0.000000] software IO TLB: mapped [mem 
>>> 0x00000000fbfff000-0x00000000fffff000] (64MB)
>>>
>>> After (CONFIG_SWIOTLB_DEFAULT_SIZE_MB=2):
>>>    [    0.000000] software IO TLB: area num 8.
>>>    [    0.000000] software IO TLB: SWIOTLB bounce buffer size roundup 
>>> to 2MB
>>>    [    0.000000] software IO TLB: mapped [mem 
>>> 0x00000000ffdff000-0x00000000fffff000] (2MB)
>>
>> This message sequence is surprising to me -- there should not be any
>> roundup if the default size is 2 MiB and there are 8 CPUs. I ran the 
>> patch
>> with 8 CPUs and set CONFIG_SWIOTLB_DEFAULT_SIZE_MB=2, and
>> no roundup was reported. I'm curious as to what configuration produced
>> the "roundup" message.
>>

I might have misunderstood your query Michael, you're correct.

I rechecked my system configuration with 8 CPUs and
CONFIG_SWIOTLB_DEFAULT_SIZE_MB=2, and I did not get the "roundup"
message. I did a few experiments while developing the patch initially
with CONFIG_SWIOTLB_DEFAULT_SIZE_MB across a range of values.
CONFIG_SWIOTLB_DEFAULT_SIZE_MB=1 gives the roundup message:

   [    0.000000] software IO TLB: area num 8.
   [    0.000000] software IO TLB: SWIOTLB bounce buffer size roundup to 2MB
   [    0.000000] software IO TLB: mapped [mem 
0x00000000ffdff000-0x00000000fffff000] (2MB)

With CONFIG_SWIOTLB_DEFAULT_SIZE_MB=1:

   nslabs = CONFIG_SWIOTLB_DEFAULT_SIZE_MB << 9 = 1 << 9 = 512

With 8 CPUs, default_nareas = 8, so the minimum required nslabs is:

   IO_TLB_SEGSIZE * default_nareas = 128 * 8 = 1024

Since 512 < 1024, nslabs is rounded up to 1024 (2MB), which explains
the roundup message.
I have incorrectly labelled this log in cover letter by posting the logs 
for CONFIG_SWIOTLB_DEFAULT_SIZE_MB=1 instead of
CONFIG_SWIOTLB_DEFAULT_SIZE_MB=2
I will correct this info in the cover letter while sending the next
revision along with the documentation update as you suggested.

Thanks & regards,
Bibek

> 
> I see inside swiotlb.c, we have a print for rounding off based on the
> number of slabs, inside the check for "round_up_default_nslabs()"
> pr_info("SWIOTLB bounce buffer size roundup to %luMB",
> 
> Probability of getting the print based on the number of slabs.
> <I am assuming your configuration is having nslabs in power of 2>
> 
> 
>> Also, there's some text in Documentation/core-api/swiotlb.rst that
>> describes the default size of the swiotlb, and how it can be overridden
>> with the swiotlb= kernel boot option. This patch should include an update
>> to that text to mention the new CONFIG option.
>>
> 
> Ack, thanks for this suggestion. I will incorporate in next revision.
> It would be a good information for someone trying a similar approach for
> setting the default option to custom value.
> 
> Thanks & regards,
> Bibek
> 
>> Michael
>>
>>> ---
>>>   include/linux/swiotlb.h |  8 ++++++--
>>>   kernel/dma/Kconfig      | 22 ++++++++++++++++++++++
>>>   2 files changed, 28 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
>>> index 3dae0f592063..1665a9ce8f94 100644
>>> --- a/include/linux/swiotlb.h
>>> +++ b/include/linux/swiotlb.h
>>> @@ -32,8 +32,12 @@ struct scatterlist;
>>>   #define IO_TLB_SHIFT 11
>>>   #define IO_TLB_SIZE (1 << IO_TLB_SHIFT)
>>>
>>> -/* default to 64MB */
>>> -#define IO_TLB_DEFAULT_SIZE (64UL<<20)
>>> +/* compile-time default; overridable via 
>>> CONFIG_SWIOTLB_DEFAULT_SIZE_MB */
>>> +#ifdef CONFIG_SWIOTLB
>>> +#define IO_TLB_DEFAULT_SIZE ((unsigned 
>>> long)CONFIG_SWIOTLB_DEFAULT_SIZE_MB << 20)
>>> +#else
>>> +#define IO_TLB_DEFAULT_SIZE (64UL << 20)
>>> +#endif
>>>
>>>   unsigned long swiotlb_size_or_default(void);
>>>   void __init swiotlb_init_remap(bool addressing_limit, unsigned int 
>>> flags,
>>> diff --git a/kernel/dma/Kconfig b/kernel/dma/Kconfig
>>> index 0a4ba21a57a7..3830a63ae032 100644
>>> --- a/kernel/dma/Kconfig
>>> +++ b/kernel/dma/Kconfig
>>> @@ -86,6 +86,28 @@ config SWIOTLB
>>>       bool
>>>       select NEED_DMA_MAP_STATE
>>>
>>> +config SWIOTLB_DEFAULT_SIZE_MB
>>> +    int "Default SWIOTLB bounce buffer size in MB"
>>> +    depends on SWIOTLB
>>> +    range 1 64
>>> +    default 64
>>> +    help
>>> +      Sets the default size of the software IO TLB (SWIOTLB) bounce 
>>> buffer
>>> +      pool allocated at boot time. The default is 64 MB.
>>> +
>>> +      On memory-constrained embedded or mobile platforms (e.g., 
>>> those with
>>> +      a hardware IOMMU such as ARM SMMU covering most DMA-capable 
>>> devices),
>>> +      a smaller value such as 4 or 8 MB may be sufficient. The 
>>> SWIOTLB is
>>> +      then only needed for devices that bypass the IOMMU or have 
>>> restricted
>>> +      DMA address ranges.
>>> +
>>> +      The minimum allowed value is 1 MB. This compile-time default 
>>> can be
>>> +      overridden at runtime using the "swiotlb=<nslabs>" kernel 
>>> command line
>>> +      parameter. Refer to Documentation/admin-guide/kernel- 
>>> parameters.txt
>>> +      for details.
>>> +
>>> +      If unsure, leave at the default value of 64.
>>> +
>>>   config SWIOTLB_DYNAMIC
>>>       bool "Dynamic allocation of DMA bounce buffers"
>>>       default n
>>>
>>> ---
>>> base-commit: 4fa3f5fabb30bf00d7475d5a33459ea83d639bf9
>>> change-id: 20260617-swiotlb-c215ce0b23f7
>>>
>>> Best regards,
>>> -- 
>>> Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
>>>
>>
> 

