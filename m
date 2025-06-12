Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CEBA1DDC37
	for <iommu@lists.linux.dev>; Thu, 12 Jun 2025 06:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749710496; cv=none; b=E4JQFS63cG3oXQeddS+Q5HVLDgv9NuqzRL2kPUgAc+5pyPZGI+dKi5isLFLTagi49Ghlxpx0URjtDIL0IQW/cHP/Zu2ow9buX6rYG3mreKNJF1fX/OuC11VBfC5tCICsaXkptoFR+zutNmOcB1ulgtQjfn1GfnM6IweEjo8MFp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749710496; c=relaxed/simple;
	bh=A7TqxuB8t9bmTFkapNPal+O9p2AhATY2thZsPhLxr6Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:In-Reply-To:
	 Content-Type:References; b=QVmvwQLDAjhVJxfzGDWQElbvk7/0d8wPgddqyEE8rhcOpXcbDiveOaEz3LsOMtwj62mYG93F0yWRmOAWg6+0v6LbvADNjtbaSALA3jpKrlL+eW6Dh40bVG9piKiSafBB/CWPBdggqtoibURElieKwHUgmSWa1GOCY1zqN7PZmfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=KJGJ7Z2K; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="KJGJ7Z2K"
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20250612064131euoutp0211d0dbcc827497de50eae0033b7ca2ac~IOGvfRMU50072900729euoutp023
	for <iommu@lists.linux.dev>; Thu, 12 Jun 2025 06:41:31 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20250612064131euoutp0211d0dbcc827497de50eae0033b7ca2ac~IOGvfRMU50072900729euoutp023
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1749710491;
	bh=7nYk7226mhpYPqAZ23fAfF9iNBbc+f6mM4CczYyFCIQ=;
	h=Date:Subject:To:From:In-Reply-To:References:From;
	b=KJGJ7Z2KRe6nwAJupdsYYMq7TGP1oGW628D9+BaS2tIb66lABtfShBULkRLe0EIqL
	 4UHYM5OfqJzMMG7QTvaRxrC89YEEn4G7ClylxB6iRwEjdRnt1xCwfOW1hH0LMqtRxw
	 lUuKPj9EisVcUmdK/B1QCR0iyvRRsSmBFu5bLjhU=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20250612064130eucas1p1f607c3f7d9b1751ee1bc48ccc5a0eea7~IOGvJlcn80968109681eucas1p15;
	Thu, 12 Jun 2025 06:41:30 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250612064130eusmtip1b9141f05b400d99bbb5c3913c5bc51a4~IOGuc7ewg2952629526eusmtip1M;
	Thu, 12 Jun 2025 06:41:30 +0000 (GMT)
Message-ID: <1da11218-64d4-49bc-a484-77390a5cd9bc@samsung.com>
Date: Thu, 12 Jun 2025 08:41:29 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dma-contiguous: hornor the cma address limit setup by
 user
To: Feng Tang <feng.tang@linux.alibaba.com>, Robin Murphy
	<robin.murphy@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Andrew
	Morton <akpm@linux-foundation.org>, Christoph Hellwig <hch@lst.de>,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20250612021417.44929-1-feng.tang@linux.alibaba.com>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20250612064130eucas1p1f607c3f7d9b1751ee1bc48ccc5a0eea7
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20250612021422eucas1p16c777f6fa46aa130d9b83ba80c2c11c3
X-EPHeader: CA
X-CMS-RootMailID: 20250612021422eucas1p16c777f6fa46aa130d9b83ba80c2c11c3
References: <CGME20250612021422eucas1p16c777f6fa46aa130d9b83ba80c2c11c3@eucas1p1.samsung.com>
	<20250612021417.44929-1-feng.tang@linux.alibaba.com>

On 12.06.2025 04:14, Feng Tang wrote:
> When porting a cma related usage from x86_64 server to arm64 server,
> the "cma=4G@4G" setup failed on arm64. The reason is arm64 and some
> other architectures have specific physical address limit for reserved
> cma area, like 4GB due to the device's need for 32 bit dma. Actually
> lots of platforms of those architectures don't have this device dma
> limit, but still have to obey it, and are not able to reserve a huge
> cma pool.
>
> This situation could be improved by honoring the user input cma
> physical address than the arch limit. As when users specify it, they
> already knows what the default is which probably can't suit them.
>
> Suggested-by: Robin Murphy <robin.murphy@arm.com>
> Signed-off-by: Feng Tang <feng.tang@linux.alibaba.com>

Thanks, applied to dma-mapping-fixes branch.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

