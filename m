Received: from omta038.useast.a.cloudfilter.net (omta038.useast.a.cloudfilter.net [44.202.169.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C06A01EB3D
	for <iommu@lists.linux.dev>; Mon, 12 Feb 2024 20:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707770487; cv=none; b=NevaubYbOC2TIc0IzdLCVwTEgf0LXbEFqS24C3ci8qGkXzVkEX8xkLclWnHSol1Rkl82XTPPbTG+6ifKH69oXg1SgH3xpha5q25Xbq/5N9jyIfkDXiveoPKg7YDmo+rmWi4mTGwDesFcdmRYTE0/sbY0WcmTAucHig7w+Cljq1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707770487; c=relaxed/simple;
	bh=hdhLudHYo5bMj33n3Yyh9anyqdYEL/SsIr/1AeSObis=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ceGdXuw1WlB1Bnx7X5d9hCnnR4XZF6LxXs4ejErPNaCRim3DFPQkrI4X10Qw4PERgjCgSUG78DT3B+vA62pWesHBMX5Q0Z/S28A5tAXFaTux2rYZLqNePs82Vs3oPHie2U1NtgI9CTAfjjx5i/r/0CqfN8wsF9gcfGde+Cielog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=XCpJ7ZjC; arc=none smtp.client-ip=44.202.169.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="XCpJ7ZjC"
Received: from eig-obgw-5007a.ext.cloudfilter.net ([10.0.29.141])
	by cmsmtp with ESMTPS
	id Zd6GrcYXL9gG6Zd79rPWYu; Mon, 12 Feb 2024 20:41:19 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id Zd78rnaYdnWOMZd78rum41; Mon, 12 Feb 2024 20:41:18 +0000
X-Authority-Analysis: v=2.4 cv=G7i/EMk5 c=1 sm=1 tr=0 ts=65ca826e
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=VhncohosazJxI00KdYJ/5A==:17
 a=IkcTkHD0fZMA:10 a=k7vzHIieQBIA:10 a=wYkD_t78qR0A:10 a=NEAV23lmAAAA:8
 a=VwQbUJbxAAAA:8 a=7YfXLusrAAAA:8 a=ZyVk2ItIS7mYbqNWDTwA:9 a=QEXdDO2ut3YA:10
 a=9cHFzqQdt-sA:10 a=PUnBvhIW4WwA:10 a=AjGcO6oz07-iQ99wixmX:22
 a=SLz71HocmBbuEhFRYD3r:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=bw54feNBMSUAWt9H1kUwQT6TtWMrX6VS0KfO9CyJw9E=; b=XCpJ7ZjCAG/KP/VTwD4kYXi1K6
	/TbC0ueZTpwPte6x1WspBWfomnu9CbJKxBlg8AEJUb6bYruRsKh3OO2vXtRvNlWkDxzDo2VFlYy3f
	qSYbkP4Dq87K/EzMIfjT8nCoZF+MVL6JAojreH7zGZIG0ouO7a0Dcvr/liR1UWwMaOCAoExudUqpA
	THXkXJWEjbVSnKGcXxVcmR6wQkBei74Dpwno4G8U4P1oRPOAZygKG7GlOwYpoL35YVeM6gy8CnNFF
	HFNjBkxUkew9YfwsXFMbDVMdrqTG8mBK/rG56ejxDeAgvDakcbig5I9eWSpbucLebhmNuNIMOlBP+
	cTZ2GOzg==;
Received: from [201.172.172.225] (port=34544 helo=[192.168.15.10])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <gustavo@embeddedor.com>)
	id 1rZd77-000F5z-0a;
	Mon, 12 Feb 2024 14:41:17 -0600
Message-ID: <0f3213d3-9010-45d5-8852-f0ab3ffc8f8b@embeddedor.com>
Date: Mon, 12 Feb 2024 14:41:11 -0600
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu/mtk_iommu: Use devm_kcalloc() instead of
 devm_kzalloc()
Content-Language: en-US
To: Erick Archer <erick.archer@gmx.com>, Yong Wu <yong.wu@mediatek.com>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Kees Cook <keescook@chromium.org>
Cc: iommu@lists.linux.dev, linux-mediatek@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-hardening@vger.kernel.org
References: <20240211182250.12656-1-erick.archer@gmx.com>
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20240211182250.12656-1-erick.archer@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - lists.linux.dev
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 201.172.172.225
X-Source-L: No
X-Exim-ID: 1rZd77-000F5z-0a
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.15.10]) [201.172.172.225]:34544
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 5
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfMm9nNrSEFE7dB3BNJPlB9O78Gv2c5pHsfyHofHhMNcJpntpr7VtG1QCVHeupN8aN93TFN+ZECpjfKy+HUopkBImrvuKa1e5lnIYJGzhPP9XAUdkvSRZ
 6bKEAME5BsC4spkR3NwuzvMEGOUHb6L6WKYIEQXF0+4cwPyU0c622pOdBzfFazeqVOeu+ZlqeJXU3PlE2LPgdkCrukSgRxJkq4o=



On 2/11/24 12:22, Erick Archer wrote:
> This is an effort to get rid of all multiplications from allocation
> functions in order to prevent integer overflows [1].
> 
> Here the multiplication is obviously safe because MTK_PROTECT_PA_ALIGN
> is defined as a literal value of 256 or 128.
> 
> For the "mtk_iommu.c" file: 256
> For the "mtk_iommu_v1.c" file: 128
> 
> However, using devm_kcalloc() is more appropriate [2] and improves
> readability. This patch has no effect on runtime behavior.
> 
> Link: https://github.com/KSPP/linux/issues/162 [1]
> Link: https://www.kernel.org/doc/html/next/process/deprecated.html#open-coded-arithmetic-in-allocator-arguments [2]
> Signed-off-by: Erick Archer <erick.archer@gmx.com>

LGTM:

Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks!
-- 
Gustavo

> ---
>   drivers/iommu/mtk_iommu.c    | 2 +-
>   drivers/iommu/mtk_iommu_v1.c | 4 ++--
>   2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
> index 7abe9e85a570..9aae6eb604b1 100644
> --- a/drivers/iommu/mtk_iommu.c
> +++ b/drivers/iommu/mtk_iommu.c
> @@ -1264,7 +1264,7 @@ static int mtk_iommu_probe(struct platform_device *pdev)
>   	data->plat_data = of_device_get_match_data(dev);
> 
>   	/* Protect memory. HW will access here while translation fault.*/
> -	protect = devm_kzalloc(dev, MTK_PROTECT_PA_ALIGN * 2, GFP_KERNEL);
> +	protect = devm_kcalloc(dev, 2, MTK_PROTECT_PA_ALIGN, GFP_KERNEL);
>   	if (!protect)
>   		return -ENOMEM;
>   	data->protect_base = ALIGN(virt_to_phys(protect), MTK_PROTECT_PA_ALIGN);
> diff --git a/drivers/iommu/mtk_iommu_v1.c b/drivers/iommu/mtk_iommu_v1.c
> index 25b41222abae..45cd845d153f 100644
> --- a/drivers/iommu/mtk_iommu_v1.c
> +++ b/drivers/iommu/mtk_iommu_v1.c
> @@ -621,8 +621,8 @@ static int mtk_iommu_v1_probe(struct platform_device *pdev)
>   	data->dev = dev;
> 
>   	/* Protect memory. HW will access here while translation fault.*/
> -	protect = devm_kzalloc(dev, MTK_PROTECT_PA_ALIGN * 2,
> -			GFP_KERNEL | GFP_DMA);
> +	protect = devm_kcalloc(dev, 2, MTK_PROTECT_PA_ALIGN,
> +			       GFP_KERNEL | GFP_DMA);
>   	if (!protect)
>   		return -ENOMEM;
>   	data->protect_base = ALIGN(virt_to_phys(protect), MTK_PROTECT_PA_ALIGN);
> --
> 2.25.1
> 
> 
