Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61F00329368
	for <iommu@lists.linux.dev>; Fri, 28 Nov 2025 12:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764333816; cv=none; b=IrIv36oDjuaa3+K5nhU1xDw3N0CK9WkdljsDH9XoKwcdgk1o3o0tNmtu51JpMawfa6HkhFfdRPhZPh7DrEn+7HJQV3YZzWCwerjvduYk9c3NnQed+xM6S7AxKcXMaQsjzQ+M6OYwgAvyEgQusgYAjJupaR/ldbJgsrXLSvhT3fE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764333816; c=relaxed/simple;
	bh=G7QL9dFT71EWGLcsbPNOPq6FF43YQ6/rMkM8cKTBaH8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=hncnL6kV11uIszHb/0guR3w3azTiLCRi0fuuVtIgESnU9mrFvq+GP095dpQqTiknbtIsKHutYI7vPpmCcCl52S42pUv4rLqBVqwnVSC/pUpWALgxAroJz+Q0Z8nAvn3T1inE0W5E+rL3ySqwhFyy5IZe0EBdEHDbnVrXtD/JG7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=BftbEkhU; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="BftbEkhU"
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20251128124331euoutp01b1b73a32622b71fcf2d072c6598eea5b~8LEDrFYK42971929719euoutp01u
	for <iommu@lists.linux.dev>; Fri, 28 Nov 2025 12:43:31 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20251128124331euoutp01b1b73a32622b71fcf2d072c6598eea5b~8LEDrFYK42971929719euoutp01u
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1764333811;
	bh=b83AlmXsfZAj1dj+if7CjsYvhF1KdJ1x8hLV/CVmPug=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=BftbEkhUSeb5N4iFJNmdu8HZkdP/dbu8IpIFs3CQiGkPR0aGLZyWRJhi3b/sdE/F8
	 bgqZVgiBHerEyjw4TnKAR0RWXgiLT094+1Ks9esMvQVHM68NFXjtr73OKutDZc7bry
	 DGxlkWk7PWPbxUmmPtrQ8NBahecReoeHdDi+iyZc=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20251128124330eucas1p2e1a512efa1726e1e68b4c98f8d24aafa~8LEDL0mgB1512015120eucas1p2G;
	Fri, 28 Nov 2025 12:43:30 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20251128124329eusmtip2c89b212d02d7f69fbf67e99177e28990~8LEBgLH1G2432824328eusmtip2Q;
	Fri, 28 Nov 2025 12:43:28 +0000 (GMT)
Message-ID: <3b0cc36d-0f7e-4d07-949f-fce670170247@samsung.com>
Date: Fri, 28 Nov 2025 13:43:28 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH v4] of: reserved_mem: Restructure call site for
 dma_contiguous_early_fixup()
To: Ye Li <ye.li@oss.nxp.com>, Oreoluwa Babatunde
	<oreoluwa.babatunde@oss.qualcomm.com>, robh@kernel.org, robin.murphy@arm.com
Cc: saravanak@google.com, quic_obabatun@quicinc.com,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev, william.zhang@broadcom.com, kernel@oss.qualcomm.com,
	will@kernel.org, djakov@kernel.org, aisheng.dong@nxp.com, joy.zou@nxp.com,
	frank.li@nxp.com, jason.hui.liu@nxp.com
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <cef8f9eb-88aa-4771-b25b-2cfd1ac2c387@oss.nxp.com>
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20251128124330eucas1p2e1a512efa1726e1e68b4c98f8d24aafa
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20250806172503eucas1p264d6731c73592fcc380b0dcc21cdeadf
X-EPHeader: CA
X-CMS-RootMailID: 20250806172503eucas1p264d6731c73592fcc380b0dcc21cdeadf
References: <CGME20250806172503eucas1p264d6731c73592fcc380b0dcc21cdeadf@eucas1p2.samsung.com>
	<20250806172421.2748302-1-oreoluwa.babatunde@oss.qualcomm.com>
	<416dbaed-a68f-4edb-a20c-94cb4c53c748@samsung.com>
	<cef8f9eb-88aa-4771-b25b-2cfd1ac2c387@oss.nxp.com>

On 26.11.2025 02:37, Ye Li wrote:
> On 8/11/2025 7:07 PM, Marek Szyprowski wrote:
>> On 06.08.2025 19:24, Oreoluwa Babatunde wrote:
>>> Restructure the call site for dma_contiguous_early_fixup() to
>>> where the reserved_mem nodes are being parsed from the DT so that
>>> dma_mmu_remap[] is populated before dma_contiguous_remap() is called.
>>>
>>> Fixes: 8a6e02d0c00e ("of: reserved_mem: Restructure how the reserved 
>>> memory regions are processed")
>>> Signed-off-by: Oreoluwa Babatunde <oreoluwa.babatunde@oss.qualcomm.com>
>>> Tested-by: William Zhang <william.zhang@broadcom.com>
>>
>> Thanks, applied to dma-mapping-fixes branch.
>>
>> Best regards
>
> Hi Oreoluwa,
>
> We observed this patch causing kernel boot hang on iMX6 (armv7) 
> platforms if using "cma=" kernel parameter. It only happens when the 
> size assigned in
> "cma=" parameter is smaller than cma default size in dts.
>
> For example, we use "cma=96M" in command line and below reserved 
> memory node (160M) in dts.
>
>         reserved-memory {
>                 #address-cells = <1>;
>                 #size-cells = <1>;
>                 ranges;
>
>                 linux,cma {
>                         compatible = "shared-dma-pool";
>                         reusable;
>                         size = <0xa000000>;
>                         linux,cma-default;
>                 };
>         };
>
> The root cause is this patch moving the dma_contiguous_early_fixup 
> from rmem_cma_setup to __reserved_mem_alloc_size. rmem_cma_setup can 
> skip the cma reserved memory if command line has cma parameter. 
> However, the __reserved_mem_alloc_size won't do it. So this leads to 
> have two cma regions added to dma_mmu_remap, one from dts, the other 
> from command line. But the reserved memory of memblock that only 
> records the cma from command line is inconsistent with dma_mmu_remap.
> The dma_contiguous_remap clears the MMU paging for the region of 
> dma_mmu_remap firstly, then create a new mapping by iotable_init. For 
> the cma from dts, this causes incorrect memory mapping cleared. Then 
> any allocation from memblock in iotable_init hitting to the area will 
> meet MMU mapping issue.
>
> From commit, I don't understand what issue does this patch fix. Can 
> you look into the regression and provide a fix patch.


I confirm that there is an issue with CMA area initialized from "cma=" 
kernel parameter. The $subject patch in turn fixed the issue observed on 
ARM 32bit machines with cma regions initizalized from dt static qnode 
(area described by the 'reg' property) introduced earlied by the commit 
8a6e02d0c00e ("of: reserved_mem: Restructure how the reserved memory 
regions are processed").

I will check how to fix this case too.


Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

