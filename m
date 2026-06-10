Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 059E13382FC
	for <iommu@lists.linux.dev>; Wed, 10 Jun 2026 14:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781101681; cv=none; b=XI08U6lnUv18812ix/HpVD36wJW8jCEb4y4MoMLiRetNiHr+4sZNYbUeSd59xisdzbh7DUtjKtOKU2yOj/HEJOFe6J1SXEYLUL62Ys0JeWugjrLMaXWXAPPPOvfB5kiO1pnx7Mg+9v+lQ+87PXQWcWi/AKyB8bDjiBJ+uPdf/L4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781101681; c=relaxed/simple;
	bh=ZDMr1KkMuid1/5JtT6zI9SV1IV3OBy8MAYDcq/h+gVc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=opI4fIziMxqiz8wH+RFKnvmdhQjmSvCpBdOrmXByvAnUuNN4YBLqVgDvvDvs8NQvHbkVOh3mwSrohOulSl7b6cLQR9wEqKghApnI22NeSRB0RJ9Kuhj+cQDdvRjhTkSXqfbSoTSUa7N8kYxV8F38XUscO9/FlJkJsmEtxBEvPRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hUuafbk6; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=P5wXeaGT; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hUuafbk6";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="P5wXeaGT"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65ACCpsE1598846
	for <iommu@lists.linux.dev>; Wed, 10 Jun 2026 14:27:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ZDMr1KkMuid1/5JtT6zI9SV1IV3OBy8MAYDcq/h+gVc=; b=hUuafbk6XbDXfklH
	nDxKc46oRgpXMyGRmH4nTXsxLZWIQXLz7nnY8hvoz7Ab/CVbBAY++3hawv19zWM4
	eqWns/hzxNX79laWU1kXFSZ9XVVHzed/rCck4nOko6cFkyaACpcnBuW2ERcgEVy2
	iCOWg3HhoKqehPRk5k/RIwgK4d1X8P8zDNyCCRZK9a1YGQPCD4EgldRZ6TjR0kxb
	QfFxbNS5TRZ7Wh696BUFrHDTTONhcgJ5nNtYCjvkw5BT5DOtNZDPXVkbd1OuzM3G
	ywi8Hvnr2uYFeEOGQAAnM0Fe4Jq2IN4OjSS4O3yLNmxT6opxfwTHQPrV0tV7Irh2
	JsKeOA==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eq2sehu62-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Wed, 10 Jun 2026 14:27:57 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-36bb6c41341so7583956a91.3
        for <iommu@lists.linux.dev>; Wed, 10 Jun 2026 07:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781101677; x=1781706477; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZDMr1KkMuid1/5JtT6zI9SV1IV3OBy8MAYDcq/h+gVc=;
        b=P5wXeaGT+Pjz+nG8mE5lFjIGmOgv1uKM5qvTAJtmn+xkEnSohCNM+AuRpe56Yc1gse
         HfblsONQtt9tj1DayKn+i3rZRkP5X8njsjfkqWzlRmNVmMwstNSlbYTixNJ65o/PQfai
         3LZu5Irp+g97xrsypF0HlEGiTnWb03Kw81joK0upPRMh2MTZFRpNuVOX+E/c43FzpNYi
         jV2E2JPnTkeV5MzjHmsJfS/9EQiVOhCOAUfXVaePxTgfdSLeiXsuZtKzx/0TXS3bLF3g
         VLHWhIe2BTaFnqD/1xEGefBVUtnyyE3Feqcw7E6t6O/pzGcwVQPGaUmc69hKz0cE3DPI
         ST4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781101677; x=1781706477;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZDMr1KkMuid1/5JtT6zI9SV1IV3OBy8MAYDcq/h+gVc=;
        b=ZPBlOHF8CLm2eiRunmpzAct85na72eBJscewuPJ5hRUrYt0eIQtPEe3eS3IGLzCzik
         LxW0s/+Lq9RXzvp0bRpWNa1jBCs+fM4BGauQT9IbYXuW86176Be+Qt7fWd5+uMSV2wyi
         AD0kyFxVtfbV5Jc2/aOAlZWMD5+l/FejQxyXyslm+n97qpcakDsd6GnYAWR93PUuvM0+
         0B8Rlal05e/BE0ajKT4gqRF5t55WBiHXmYHpULy4gVZc7d+r/uZ0y78yN8ZYAlKxHPqx
         TrNKe77OieD4DzarrieF7uh2/tdT5LU3HOa9sFo8veUoNhDBEZXPCe16pnweawBVupV1
         uJfQ==
X-Gm-Message-State: AOJu0YzNOzZmHVCMIGtbW3hQB5iSL31TV7tJ2l2JAjdR9RgSaw89tcGG
	kaiRQm/TnaDZXBsKI3f5DDfs0mqrwvP+oYkhLoXpU9vvtDggHPHc8n2RAPXSt7D9xB/ExQKMEbr
	ljLnBZeMJ7iscH6EJeUXJMcQGx0T95vLAsGxIKWCH9oO72NxHNEGrjm/g3YukmqhnYw==
X-Gm-Gg: Acq92OElY8qw33p3V3Pq3NjOeZBzwv1+fN/v0d3XXZqjTIXV4fL++hLP248hYgzyknt
	L4QnxhDtUaDW8uvyY1lnl/W1UgzOeGamqgwacbiBxw7EfypPTZLp0HgKhxD1qTSqpV5rHmp0Ddn
	BohH5R+Es/w1EBjALJb+HgqoPaHMhPGaZdju8K9Be2OvvzabrskAwIN9g+tLVIJjzLssb0SG6J8
	FezzdZcErsg2E+g4OwLhahBAAyTCLcnxwjRgEAGWdhllxYUvgH1rwVNKJq5VwcfJVBl53HPsfrE
	5lOHNPAlGuy/AE2Iu3PJYRbZ+BHRcYUrLg1ExFqBNmEZAPl2cQ3yAwhci/lOnw7n558KtGrqWe6
	QFtvaBMJdP6Vp4hcic8AQ5kx3O1Xd1D5ledzNXg3zpyyOo5GpoYsU9qyjzWPcujQO
X-Received: by 2002:a17:90b:5106:b0:36b:afa0:c53d with SMTP id 98e67ed59e1d1-370ee82fd0dmr27039656a91.2.1781101676379;
        Wed, 10 Jun 2026 07:27:56 -0700 (PDT)
X-Received: by 2002:a17:90b:5106:b0:36b:afa0:c53d with SMTP id 98e67ed59e1d1-370ee82fd0dmr27039612a91.2.1781101675823;
        Wed, 10 Jun 2026 07:27:55 -0700 (PDT)
Received: from [10.206.105.200] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-37645a2c6a9sm1984838a91.1.2026.06.10.07.27.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jun 2026 07:27:55 -0700 (PDT)
Message-ID: <bb59f07e-ca7e-f012-6a4b-0a148350b69c@oss.qualcomm.com>
Date: Wed, 10 Jun 2026 19:57:50 +0530
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] dma-iommu: Introduce API to reserve IOVA regions for
 dynamically created devices
To: Robin Murphy <robin.murphy@arm.com>, joro@8bytes.org, will@kernel.org,
        m.szyprowski@samsung.com
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        vikash.garodia@oss.qualcomm.com, dikshita.agarwal@oss.qualcomm.com
References: <20260119054936.3350128-1-busanna.reddy@oss.qualcomm.com>
 <cfd23f75-8952-4463-abd5-815b995031b0@arm.com>
Content-Language: en-US
From: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
In-Reply-To: <cfd23f75-8952-4463-abd5-815b995031b0@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: fc-kDE1XTVBLsm-ZnL2KUnGdxaJGAWhU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEwMDEzOCBTYWx0ZWRfXzodxkso154Z4
 9yozVX2zCvFd/L1sHzJDuoJ5TC/S4k+dWG38OxgRAA3msLnP0IKpsF87dowbZvrjq6ft2FHUx95
 PJX7IYKoRQ4cE/FcA01KZN3UI372DT3K7S9T7ZrPBTWF1kNOD8sE7I4VE41yffk3gjOFDD3xg+m
 UbYfnEaaEmfcMBzd4h8iTMVsWHuPmcW/G1c0JmC9LCxjbPLpyXAnQ+nsaevVkg/BDZnl2fjVwqR
 RT22qx7y8I6LHgr8cixlmnd8iR27nfMNJzr8itFLQZvGBP2ruGM0DQEJiAw+HnS9IJnC2VbzDF/
 4znarOwIK0KKxueEwv6RtFhyi2oU720i017d8+juPMaQAMbS6piQ7jW1G6Pmz++8T0+kQeacHf1
 uvcwSFvyoN/PWEOgHtFEXM496qv+5Ixf4ccMxRdxDVE4wjfch+PMl2vwwJjRIew+9cbfyj7+/A/
 iB1CFgYiQVJSeWYCD2w==
X-Proofpoint-ORIG-GUID: fc-kDE1XTVBLsm-ZnL2KUnGdxaJGAWhU
X-Authority-Analysis: v=2.4 cv=Md1cfZ/f c=1 sm=1 tr=0 ts=6a29746d cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=e5mUnYsNAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=ALB7cA6TA5vMt6cBXkgA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=mQ_c8vxmzFEMiUWkPHU9:22
 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-10_03,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 priorityscore=1501 adultscore=0 bulkscore=0
 impostorscore=0 spamscore=0 malwarescore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606100138


On 1/19/2026 7:43 PM, Robin Murphy wrote:
> On 19/01/2026 5:49 am, Vishnu Reddy wrote:
>> Drivers can create child devices dynamically. These child devices often
>> inherit parent device tree node, including its reserved iommu-address
>> ranges.
>
> Which frankly sounds entirely wrong. If there are distinct devices with
> distinct hardware properties, then they should be properly described as such,
> and handled by a proper bus driver. And if different devices have different
> DMA restrictions, that should be described by "dma-ranges", not by abusing
> reserved regions.
>

Hi Robin,

The VPU is a single hardware unit, but internally it consists of
multiple functional blocks. Each block has its own distinct Stream ID
(SID) and operates with a different IOVA range requirement:

  +--------------------------------------------------+
  |                  VPU Hardware                    |
  |                                                  |
  |  +------------+   SID-0   IOVA: 600MB - 3500MB   |
  |  |  Block 0   |                                  |
  |  +------------+                                  |
  |                                                  |
  |  +------------+   SID-1   IOVA: 0MB  - 3500MB    |
  |  |  Block 1   |                                  |
  |  +------------+                                  |
  |                                                  |
  |  +------------+   SID-2   IOVA: 16MB - 600MB     |
  |  |  Block 2   |                                  |
  |  +------------+                                  |
  +--------------------------------------------------+

Each Stream ID maps to a distinct IOMMU context bank, and each context
bank enforces a different IOVA range.

The upper boundary can be enforced via dma_set_mask_and_coherent. However,
enforcing the lower boundary (e.g., blocking 0 to 600MB for Block 0,
and 0 to 16MB for Block 2) requires explicit IOVA reservation,
which is what dma_iova_set_resv_region() provides in this patch.

These are synthetic child devices created at runtime and do not have their
own of_node. Inheriting the parent of_node might not be the correct way.

A crash was observed on one of the platforms due to the absence of
reserved regions. This API would help avoid such crashes by allowing
drivers to explicitly reserve the restricted IOVA range.
https://gitlab.freedesktop.org/drm/msm/-/work_items/100

Thanks,
Vishnu Reddy.

> Thanks,
> Robin.
>
>> While device tree can declare the multiple iommu-address ranges,
>> they still apply uniformly to any child inheriting the parent OF node.
>>
>> This creates a limitation when child requires a different iommu-address
>> range than its parent, as device tree cannot express the reservation per
>> child.
>>
>> Example layout and use case:
>> ----------------------------
>> A multimedia subsystem with multiple child devices and distinct ranges:
>>
>>      +-----------------------------------------------------------+
>>      | Device A reserved region (256 MB)                         |
>>      | 0x00000000 - 0x10000000                                   |
>>      +-----------------------------------------------------------+
>>      | Device B reserved region (512 MB)                         |
>>      | 0x00000000 - 0x20000000                                   |
>>      +-----------------------------------------------------------+
>>      | Device C reserved region (600 MB)                         |
>>      | 0x00000000 - 0x25800000                                   |
>>      +-----------------------------------------------------------+
>>      | Other reserved regions                                    |
>>      +-----------------------------------------------------------+
>>
>> If we add Device C's reserved range (0x0 to 0x025800000) into iommu
>> address range into device tree and assign that OF node to Device B
>> and C, it wastes memory:
>> - Device A wastes ~344 MB
>> - Device B wastes ~88 MB
>>
>> To avoid this, drivers can use the introduced API to set their device
>> specific IOVA region at runtime, ensuring the DMA mapping without
>> unnecessary address space reservation.
>>
>> Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
>> Link:
>> https://lore.kernel.org/all/20251220023555.3017456-1-busanna.reddy@oss.qualcomm.com/
>> ---
>>   drivers/iommu/dma-iommu.c   | 44 +++++++++++++++++++++++++++++++++++++
>>   include/linux/dma-mapping.h |  7 ++++++
>>   2 files changed, 51 insertions(+)
>>
>> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
>> index aeaf8fad985c3..baee119e1c277 100644
>> --- a/drivers/iommu/dma-iommu.c
>> +++ b/drivers/iommu/dma-iommu.c
>> @@ -1743,6 +1743,50 @@ size_t iommu_dma_max_mapping_size(struct device *dev)
>>       return SIZE_MAX;
>>   }
>>   +/**
>> + * dma_iova_set_resv_region - Set a reserved region in the IOVA space
>> + * @dev: Device to set the reserved region for
>> + * @start: Start of the reserved region
>> + * @length: Length of the reserved region
>> + *
>> + * This function enables drivers to set device specific reservations at
>> + * runtime, which is particularly useful for dynamically created child
>> + * devices that requires distinct IOVA ranges than parent.
>> + *
>> + * Returns:
>> + *  0        - Success
>> + *  -ENODEV  - No valid IOMMU DMA domain for the device
>> + *  -EINVAL  - Invalid domain or cookie type for this operation
>> + *  -ENOMEM  - Failed to reserve the requested range
>> + */
>> +int dma_iova_set_resv_region(struct device *dev, unsigned long start,
>> +                 unsigned long length)
>> +{
>> +    struct iommu_dma_cookie *cookie;
>> +    struct iommu_domain *domain;
>> +    struct iova_domain *iovad;
>> +    unsigned long lo, hi;
>> +
>> +    domain = iommu_get_dma_domain(dev);
>> +    if (!domain || domain->type != IOMMU_DOMAIN_DMA)
>> +        return -ENODEV;
>> +
>> +    cookie = domain->iova_cookie;
>> +    if (!cookie || domain->cookie_type != IOMMU_COOKIE_DMA_IOVA)
>> +        return -EINVAL;
>> +
>> +    iovad = &cookie->iovad;
>> +
>> +    lo = iova_pfn(iovad, start);
>> +    hi = iova_pfn(iovad, start + length - 1);
>> +
>> +    if (!reserve_iova(iovad, lo, hi))
>> +        return -ENOMEM;
>> +
>> +    return 0;
>> +}
>> +EXPORT_SYMBOL_GPL(dma_iova_set_resv_region);
>> +
>>   /**
>>    * dma_iova_try_alloc - Try to allocate an IOVA space
>>    * @dev: Device to allocate the IOVA space for
>> diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
>> index 29973baa05816..75b65160a37f3 100644
>> --- a/include/linux/dma-mapping.h
>> +++ b/include/linux/dma-mapping.h
>> @@ -347,6 +347,8 @@ static inline bool dma_use_iova(struct dma_iova_state
>> *state)
>>       return state->__size != 0;
>>   }
>>   +int dma_iova_set_resv_region(struct device *dev, unsigned long start,
>> +                 unsigned long length);
>>   bool dma_iova_try_alloc(struct device *dev, struct dma_iova_state *state,
>>           phys_addr_t phys, size_t size);
>>   void dma_iova_free(struct device *dev, struct dma_iova_state *state);
>> @@ -366,6 +368,11 @@ static inline bool dma_use_iova(struct dma_iova_state
>> *state)
>>   {
>>       return false;
>>   }
>> +static inline int dma_iova_set_resv_region(struct device *dev, unsigned long
>> start,
>> +                       unsigned long length)
>> +{
>> +    return -ENODEV;
>> +}
>>   static inline bool dma_iova_try_alloc(struct device *dev,
>>           struct dma_iova_state *state, phys_addr_t phys, size_t size)
>>   {
>
