Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A3B620127A
	for <iommu@lists.linux.dev>; Wed, 13 Nov 2024 18:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731520994; cv=none; b=lZ2sHeD4fr3bQggND5mhV/OXnEprba9RyAODJ4yxFtd97T3/WvgN4E3SIcW5EZU5mjnhaMV142XIDibOps7QBDwREwDVjhnMEvb8ZiFZwsEWXTp/TcjCmWNjaQSt+F568e+8L2uGxyP6NEuShvgAlpLhV92w1HokQCQeLkNrDc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731520994; c=relaxed/simple;
	bh=0dYtlNaE02KMPwPbNkOEG7D0Ej3fMxzfA77E8dWng18=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Sxc1gbBY/pWuMf9Se8bEYUm+kR5b3LYmlVIQeH/iFX/ZnfkUAqYDtdGX8dPksqp/G9VsevNY887VKXYzt/cs70woViQaCmt1loVgLn00cTkkUwwYNhuFheBvfIij20AwOWLp62a2X+7Y5Y9t0EN6VHt7f3OWc+3UkOLs9wzLuIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=aLL26I2b; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="aLL26I2b"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4ADH1ZEi025412;
	Wed, 13 Nov 2024 18:03:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	bYtOOA3mW6Ph2dWGJf/8a1jSF1QmnYitbVPB+AORG4w=; b=aLL26I2bikDogtDH
	fT2fQU1ZA8fAFhtHvZPGG6AeVPFCzKj9hL5xUnzqo0Bj0gqJHGYaHOUdHKmASg+4
	DjHSV6tbbp7v8dyqqMvVtRqFtztapVjIBjC9PoHLB7B4HHhkF7zNX9x7U24Gdf0+
	DvO6YZXxZ0DnFHx8FVOmp+78fmurjaOR4QDfPGhvahPmQnJo03MCQy2VBUOsuNQi
	Sj2QYrZB6vMelIH8iq5X8jZet++FEYrDczdM6RLL0CyXPImAfJfQhM5vgupdjhq7
	r7WJDUsCDp26+j3qm7ZcYJ3/zWcfMnMlIXyTEa+yfmf5PGc9dj466iE5hF2bB4aZ
	ps7G7A==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42vgqqtqwr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 Nov 2024 18:03:00 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4ADI2wk7004079
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 Nov 2024 18:02:58 GMT
Received: from [10.71.109.85] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 13 Nov
 2024 10:02:58 -0800
Message-ID: <6a8ba993-9413-40ad-8c91-0cf268798585@quicinc.com>
Date: Wed, 13 Nov 2024 10:02:49 -0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dma-mapping: Save base/size instead of pointer to shared
 DMA pool
To: Geert Uytterhoeven <geert+renesas@glider.be>,
        Rob Herring
	<robh@kernel.org>, Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski
	<m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>
CC: <iommu@lists.linux.dev>, <linux-renesas-soc@lists.infradead.org>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <f8cef6845a6141f0277e31a71fe153612daae776.1731436631.git.geert+renesas@glider.be>
Content-Language: en-US
From: Oreoluwa Babatunde <quic_obabatun@quicinc.com>
In-Reply-To: <f8cef6845a6141f0277e31a71fe153612daae776.1731436631.git.geert+renesas@glider.be>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: eu28F4D7NQKeyjXetHBQsxyFMsnBtuw5
X-Proofpoint-GUID: eu28F4D7NQKeyjXetHBQsxyFMsnBtuw5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 clxscore=1011
 impostorscore=0 lowpriorityscore=0 suspectscore=0 spamscore=0
 priorityscore=1501 phishscore=0 malwarescore=0 mlxlogscore=999
 adultscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411130149


On 11/12/2024 10:39 AM, Geert Uytterhoeven wrote:
> On RZ/Five, which is non-coherent, and uses CONFIG_DMA_GLOBAL_POOL=y:
>
>     Oops - store (or AMO) access fault [#1]
>     CPU: 0 UID: 0 PID: 1 Comm: swapper Not tainted 6.12.0-rc1-00015-g8a6e02d0c00e #201
>     Hardware name: Renesas SMARC EVK based on r9a07g043f01 (DT)
>     epc : __memset+0x60/0x100
>      ra : __dma_alloc_from_coherent+0x150/0x17a
>     epc : ffffffff8062d2bc ra : ffffffff80053a94 sp : ffffffc60000ba20
>      gp : ffffffff812e9938 tp : ffffffd601920000 t0 : ffffffc6000d0000
>      t1 : 0000000000000000 t2 : ffffffffe9600000 s0 : ffffffc60000baa0
>      s1 : ffffffc6000d0000 a0 : ffffffc6000d0000 a1 : 0000000000000000
>      a2 : 0000000000001000 a3 : ffffffc6000d1000 a4 : 0000000000000000
>      a5 : 0000000000000000 a6 : ffffffd601adacc0 a7 : ffffffd601a841a8
>      s2 : ffffffd6018573c0 s3 : 0000000000001000 s4 : ffffffd6019541e0
>      s5 : 0000000200000022 s6 : ffffffd6018f8410 s7 : ffffffd6018573e8
>      s8 : 0000000000000001 s9 : 0000000000000001 s10: 0000000000000010
>      s11: 0000000000000000 t3 : 0000000000000000 t4 : ffffffffdefe62d1
>      t5 : 000000001cd6a3a9 t6 : ffffffd601b2aad6
>     status: 0000000200000120 badaddr: ffffffc6000d0000 cause: 0000000000000007
>     [<ffffffff8062d2bc>] __memset+0x60/0x100
>     [<ffffffff80053e1a>] dma_alloc_from_global_coherent+0x1c/0x28
>     [<ffffffff80053056>] dma_direct_alloc+0x98/0x112
>     [<ffffffff8005238c>] dma_alloc_attrs+0x78/0x86
>     [<ffffffff8035fdb4>] rz_dmac_probe+0x3f6/0x50a
>     [<ffffffff803a0694>] platform_probe+0x4c/0x8a
>
> If CONFIG_DMA_GLOBAL_POOL=y, the reserved_mem structure passed to
> rmem_dma_setup() is saved for later use, by saving the passed pointer.
> However, when dma_init_reserved_memory() is called later, the pointer
> has become stale, causing a crash.
>
> E.g. in the RZ/Five case, the referenced memory now contains the
> reserved_mem structure for the "mmode_resv0@30000" node (with base
> 0x30000 and size 0x10000), instead of the correct "pma_resv0@58000000"
> node (with base 0x58000000 and size 0x8000000).
>
> Fix this by saving the needed reserved_mem structure's contents instead.
>
> Fixes: 8a6e02d0c00e7b62 ("of: reserved_mem: Restructure how the reserved memory regions are processed")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Oreoluwa Babatunde <quic_obabatun@quicinc.com>
> ---
>  kernel/dma/coherent.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
>
> diff --git a/kernel/dma/coherent.c b/kernel/dma/coherent.c
> index ff5683a57f77126d..3b2bdca9f1d4b027 100644
> --- a/kernel/dma/coherent.c
> +++ b/kernel/dma/coherent.c
> @@ -330,7 +330,8 @@ int dma_init_global_coherent(phys_addr_t phys_addr, size_t size)
>  #include <linux/of_reserved_mem.h>
>  
>  #ifdef CONFIG_DMA_GLOBAL_POOL
> -static struct reserved_mem *dma_reserved_default_memory __initdata;
> +static phys_addr_t dma_reserved_default_memory_base __initdata;
> +static phys_addr_t dma_reserved_default_memory_size __initdata;
>  #endif
>  
>  static int rmem_dma_device_init(struct reserved_mem *rmem, struct device *dev)
> @@ -376,9 +377,10 @@ static int __init rmem_dma_setup(struct reserved_mem *rmem)
>  
>  #ifdef CONFIG_DMA_GLOBAL_POOL
>  	if (of_get_flat_dt_prop(node, "linux,dma-default", NULL)) {
> -		WARN(dma_reserved_default_memory,
> +		WARN(dma_reserved_default_memory_size,
>  		     "Reserved memory: region for default DMA coherent area is redefined\n");
> -		dma_reserved_default_memory = rmem;
> +		dma_reserved_default_memory_base = rmem->base;
> +		dma_reserved_default_memory_size = rmem->size;
>  	}
>  #endif
>  
> @@ -391,10 +393,10 @@ static int __init rmem_dma_setup(struct reserved_mem *rmem)
>  #ifdef CONFIG_DMA_GLOBAL_POOL
>  static int __init dma_init_reserved_memory(void)
>  {
> -	if (!dma_reserved_default_memory)
> +	if (!dma_reserved_default_memory_size)
>  		return -ENOMEM;
> -	return dma_init_global_coherent(dma_reserved_default_memory->base,
> -					dma_reserved_default_memory->size);
> +	return dma_init_global_coherent(dma_reserved_default_memory_base,
> +					dma_reserved_default_memory_size);
>  }
>  core_initcall(dma_init_reserved_memory);
>  #endif /* CONFIG_DMA_GLOBAL_POOL */
Hi Geert,

Thanks for providing a fix!

I also looked around more to see if there are more places that
could store a stale reference to rmem but I didn't see any others,
so I think we are good!

I have given my "reviewed-by" tag as well.

Thank you!
Oreoluwa
