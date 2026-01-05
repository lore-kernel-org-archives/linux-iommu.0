Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 580D456B81
	for <iommu@lists.linux.dev>; Mon,  5 Jan 2026 06:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767592971; cv=none; b=KqUx3VcYESEE9Ngu6y6xRy5pm0YetOZdFRAFnQ8XuLr3F9H/xJ3Qh+uEQ64O2zV2jikAFQZ4+amyHCcNbPpeqZ/06jH85ay3mGNMPDv+MiZUCL1DJqjUaWXojlYjqTd8As2uqmXhR6OCs+nkjZqrKFBfcct+QbPBVivauvCSvRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767592971; c=relaxed/simple;
	bh=/fCfzj8pJxxOFTAhEr458P2AWjbIiUWxcUQI+PiZ+Jo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A4xZPPuseNqe6FOfrUkVEty9mmcWxBTtQWpLkq4JltIM+F++FMhZfjKkftIjej8+dfvIvWASuv+10AoAYMmvMUyOsF8N5VAbxo6zJ9laCZhFtSHoZKA3S3sF3e9AjQqg+oWE4ELqi683vyY3r6kWRFwSAGwiXi2/c2BJKQFvoP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dEz5NH5T; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=azAsOie2; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dEz5NH5T";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="azAsOie2"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6053F1s43541817
	for <iommu@lists.linux.dev>; Mon, 5 Jan 2026 06:02:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	UFHfP3+ljG6X7U8dn/8CT3QCG9bZ5b12GFoxoMcv514=; b=dEz5NH5TMJ3fmF4b
	MkBivgmuswocIHyZE5EFXAzmzWsAGndlbCaxuWvn17HGgcldLmzzxoK0AlbydA6B
	GPffIkvhYg/w8ksc7qk2f/C64Yxxb2+n786Y29hUXqrnq40dMMkXBmxuJYZ9fhXb
	RRs0mL8UF2TAcB+9lh9nglI7aPsuGKJSumpD2AaXoI0C0m4n1/VxNrV8nGvVfH5i
	6I4QEr8DNjI1jBSUaShqFjJSC+oK/IGWwUxo+GLPjlYcZ6ZSaDHhr03eiYzANFKl
	CSTPUJJjwLqeOoMFd/8NEoaqAZXGF8YZu2/WfzUE4FejWmD0L79iq5pJV52XjNMJ
	LCNOug==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bg57sgc86-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Mon, 05 Jan 2026 06:02:48 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-7aa9f595688so21810757b3a.2
        for <iommu@lists.linux.dev>; Sun, 04 Jan 2026 22:02:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767592968; x=1768197768; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UFHfP3+ljG6X7U8dn/8CT3QCG9bZ5b12GFoxoMcv514=;
        b=azAsOie2Qt6RaZ95yUvx/b5lOKjFxTMNjXZey2ODmqeC7eCYYnB14PM3qt6K/YOwPm
         X1JU+6ghBoCruKQ/8rhvrVUAz2sKd53dZkWCHRl6JY6lauSLqad4G7mM/jlwFNweirQl
         EZbBqxVMoCE5CiNtjGYmKhxUuaSHiM7ph0CPbAJaJQenplNVU4/xC9h0zKvUOkDV7Ss9
         sHpU4oH05/XVjpogCAfPbgjI+RI83u0CjDbwUSsavqN5F/jAPuxXG/Q79malfkB2izqA
         GFfuoxtCAT3s+x+evSRguqMfOu7ewh0iUnlRhzk1RDeEL5EhoIgdeHvO6Rng/id5gG8V
         ebFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767592968; x=1768197768;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UFHfP3+ljG6X7U8dn/8CT3QCG9bZ5b12GFoxoMcv514=;
        b=X+vgu72ymWGBOhy4OkcJkyMKwokXJbnkLxaCeVIXSDv2fprJDIcxOHIOQ47dL4mPLO
         HYxunv4QRlVxIE55OlF2ZXfPs2ghXSs2Xrf9hxtni/UePFfuIHjTa/xZSXLPluOKUhqw
         GHCStG6VK/V/6YPAjTDeVfUimVXXNhe2z36uzVDHrCQXsg6HG52qy2E33f5sYCD84xE/
         lKzJxRHX0f6JWqtZwebsV11HL+fxjU5LUq50N41N+KZ13F9REuDg2jBc43ZCJKOPPSo6
         K+++m5ON/2JqjjnguFhrRj5TEh9IUskEhqpk+U7sWERR3cqju7ipix8/4E/q6iCl20em
         dm2Q==
X-Gm-Message-State: AOJu0Ywomp/cJ8Va4jXcpMeGIhfxdDSdkUIBJ/eTDCacMbZR9jXm62E+
	t2/p4Zglx547bA3PsqYjE4TU0un+mkaC5f6YREZ45JrkOqrRHksw840m+3xzbC0kiOuOb607DsQ
	N6gjNKbGFkbMiln+GNcDEdg88ry8zRYxfdwawvl6Cj7ypGjRvpWUS02Veag==
X-Gm-Gg: AY/fxX4tGLMS9cMQs1IqNkBZI9DwvRbUtx5CXFPGjqsw9TDES6cI0w4G5tJJPqLmMQS
	fKyLn/G60zUBJTG5YZHi4u8yE7HYd6z2RhhYkaAmqPQzOUzLnWVIW9ELVB+JBR0b6DGbTEoWqKL
	FGOjEPPJ5eRYfwBsnjEjTAg73jdVfwAcjTmyv3wNkwBL+8MrOTDWmvRiT6vRBtsgu6PmziZX64+
	hj/nWS7IWxygWNzK/OO4JC2lDikwY2eXxprxz30wAb79cL3cj7rSEGtV1b2sWTOMAE/3RbkPm3c
	POzQy7CafsXWeTlRNvkWYzDr5akk8i+u/Ln/ayHOb9jm12rYfoEIB0XGckvSLYGSUA7ONolS3TR
	zl3WBUPQMSC8OJS1D8HBPtOEXXnDVVo8NHcvaOXSIvw==
X-Received: by 2002:a05:6a00:7613:b0:7ff:acc3:2f40 with SMTP id d2e1a72fcca58-7ffacc33e69mr34282205b3a.26.1767592967783;
        Sun, 04 Jan 2026 22:02:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGAM1gi4s6Rb8/IudQp/6kzZlB2f/iYhGxLaNvhfSm/dDSwvfh+ZSwmGB1TjDrmhfM4OyTylw==
X-Received: by 2002:a05:6a00:7613:b0:7ff:acc3:2f40 with SMTP id d2e1a72fcca58-7ffacc33e69mr34282183b3a.26.1767592967242;
        Sun, 04 Jan 2026 22:02:47 -0800 (PST)
Received: from [10.206.105.120] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7ff7e792b65sm47699729b3a.58.2026.01.04.22.02.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 04 Jan 2026 22:02:46 -0800 (PST)
Message-ID: <d28ba659-b085-a323-8630-c86dedfdfdea@oss.qualcomm.com>
Date: Mon, 5 Jan 2026 11:32:42 +0530
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [RFC PATCH] dma-iommu: Introduce API to reserve IOVA regions for
 dynamically created devices
To: robin.murphy@arm.com, joro@8bytes.org, will@kernel.org,
        m.szyprowski@samsung.com
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        vikash.garodia@oss.qualcomm.com, dikshita.agarwal@oss.qualcomm.com
References: <20251220023555.3017456-1-busanna.reddy@oss.qualcomm.com>
Content-Language: en-US
From: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
In-Reply-To: <20251220023555.3017456-1-busanna.reddy@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=UJ/Q3Sfy c=1 sm=1 tr=0 ts=695b5408 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=a8cTlLbHd2QiVrkBEt8A:9
 a=QEXdDO2ut3YA:10 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA1MDA1MyBTYWx0ZWRfXwMyfRGoIoXwg
 VRRxZYBUChfdypS8rAbkpfuK7/vNOfJiljJylyB1DNxUOYIfj+2RzmZmrUzxybNIfMKEo95FGzt
 WiOrqs5PjGt2ntv4f/m+odXA8mRwvP24h/fGNhj17N22Em5gKW6Qac1xGOlaqBh7tgZKVT1Ijyd
 t6QpDR9Y6U/Ybz41i8Sr5BuNPTObu1vwB9GmKvPh7nnUOt6YZShzRGYy2+m9vVS6cXwTWF0E9rd
 LQz6ZjI80Iga9kbLev3oPNO/PPksbSNFgpKn+x3DI1bHU+1ruunZ9/9p0mntQyGbb1Bd0IJ/21/
 0+cSlq3LuiAFhVA9VwCIENn58XrOzwIK8WF45kopfGxSYcIyslsif5YHcMWsKDBN76+h4zuX/4h
 no1vWP+qfh9CG41TBMrA+T1y5zNtz1/TnvLCaDVIvn2Ig+DunU7xxDd7RaOnVneViztxNcIqV/h
 OfOu9UJToKfYLWdPxtQ==
X-Proofpoint-ORIG-GUID: woXJFf2kacyWeKz9bzSACAFTc6527BSV
X-Proofpoint-GUID: woXJFf2kacyWeKz9bzSACAFTc6527BSV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-05_01,2025-12-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 spamscore=0 bulkscore=0 phishscore=0
 lowpriorityscore=0 clxscore=1015 priorityscore=1501 impostorscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2512120000
 definitions=main-2601050053


On 12/20/2025 8:05 AM, Vishnu Reddy wrote:
> Drivers can create child devices dynamically. These child devices often
> inherit parent device tree node, including its reserved iommu-address
> ranges. While device tree can declare the multiple iommu-address ranges,
> they still apply uniformly to any child inheriting the parent OF node.
>
> This creates a limitation when child requires a different iommu-address
> range than its parent, as device tree cannot express the reservation per
> child.
>
> Example layout and use case:
> ----------------------------
> A multimedia subsystem with multiple child devices and distinct ranges:
>
>      +-----------------------------------------------------------+
>      | Device A reserved region (256 MB)                         |
>      | 0x00000000 - 0x10000000                                   |
>      +-----------------------------------------------------------+
>      | Device B reserved region (512 MB)                         |
>      | 0x00000000 - 0x20000000                                   |
>      +-----------------------------------------------------------+
>      | Device C reserved region (600 MB)                         |
>      | 0x00000000 - 0x25800000                                   |
>      +-----------------------------------------------------------+
>      | Other reserved regions                                    |
>      +-----------------------------------------------------------+
>
> If we add Device C's reserved range (0x0 to 0x025800000) into iommu
> address range into device tree and assign that OF node to Device B
> and C, it wastes memory:
> - Device A wastes ~344 MB
> - Device B wastes ~88 MB
>
> To avoid this, drivers can use the introduced API to set their device
> specific IOVA region at runtime, ensuring the DMA mapping without
> unnecessary address space reservation.
>
> Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
> ---
>   drivers/iommu/dma-iommu.c   | 44 +++++++++++++++++++++++++++++++++++++
>   include/linux/dma-mapping.h |  7 ++++++
>   2 files changed, 51 insertions(+)
>
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index c92088855450a..02c54cddf9417 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -1743,6 +1743,50 @@ size_t iommu_dma_max_mapping_size(struct device *dev)
>   	return SIZE_MAX;
>   }
>   
> +/**
> + * dma_iova_set_resv_region - Set a reserved region in the IOVA space
> + * @dev: Device to set the reserved region for
> + * @start: Start of the reserved region
> + * @length: Length of the reserved region
> + *
> + * This function enables drivers to set device specific reservations at
> + * runtime, which is particularly useful for dynamically created child
> + * devices that requires distinct IOVA ranges than parent.
> + *
> + * Returns:
> + *  0        - Success
> + *  -ENODEV  - No valid IOMMU DMA domain for the device
> + *  -EINVAL  - Invalid domain or cookie type for this operation
> + *  -ENOMEM  - Failed to reserve the requested range
> + */
> +int dma_iova_set_resv_region(struct device *dev, unsigned long start,
> +			     unsigned long length)
> +{
> +	struct iommu_dma_cookie *cookie;
> +	struct iommu_domain *domain;
> +	struct iova_domain *iovad;
> +	unsigned long lo, hi;
> +
> +	domain = iommu_get_dma_domain(dev);
> +	if (!domain || domain->type != IOMMU_DOMAIN_DMA)
> +		return -ENODEV;
> +
> +	cookie = domain->iova_cookie;
> +	if (!cookie || domain->cookie_type != IOMMU_COOKIE_DMA_IOVA)
> +		return -EINVAL;
> +
> +	iovad = &cookie->iovad;
> +
> +	lo = iova_pfn(iovad, start);
> +	hi = iova_pfn(iovad, start + length - 1);
> +
> +	if (!reserve_iova(iovad, lo, hi))
> +		return -ENOMEM;
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(dma_iova_set_resv_region);
> +
>   /**
>    * dma_iova_try_alloc - Try to allocate an IOVA space
>    * @dev: Device to allocate the IOVA space for
> diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
> index aa36a0d1d9df6..c89147cf92231 100644
> --- a/include/linux/dma-mapping.h
> +++ b/include/linux/dma-mapping.h
> @@ -339,6 +339,8 @@ static inline bool dma_use_iova(struct dma_iova_state *state)
>   	return state->__size != 0;
>   }
>   
> +int dma_iova_set_resv_region(struct device *dev, unsigned long start,
> +			     unsigned long length);
>   bool dma_iova_try_alloc(struct device *dev, struct dma_iova_state *state,
>   		phys_addr_t phys, size_t size);
>   void dma_iova_free(struct device *dev, struct dma_iova_state *state);
> @@ -358,6 +360,11 @@ static inline bool dma_use_iova(struct dma_iova_state *state)
>   {
>   	return false;
>   }
> +static inline int dma_iova_set_resv_region(struct device *dev, unsigned long start,
> +					   unsigned long length)
> +{
> +	return -ENODEV;
> +}
>   static inline bool dma_iova_try_alloc(struct device *dev,
>   		struct dma_iova_state *state, phys_addr_t phys, size_t size)
>   {

Reminder to review this patch.

Thanks
Vishnu Reddy
