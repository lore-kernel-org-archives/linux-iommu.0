Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AB99514766
	for <iommu@lists.linux.dev>; Tue, 13 Oct 2026 15:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791904493; cv=none; b=qc2iVFxWg9b+ie7iuRg9tYHbSZfrkYdknC6QffyTC0aD8AYFtcfV5aSSu/gW6nyo54dFWnyfezW2riUXIO0sSzButAtBrf8kN+8I/0Mtz+/pYDW2U9o3A7diEp6/eof25eTvjqvvxSxeNx+pPen0bESvOo2wUlh0lOJJnYx3x0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791904493; c=relaxed/simple;
	bh=i+Kgazn/A26d/jnqiULLIMIDKPiJkQnG+4y4AEyQ0QM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=uF+YmoN7OlX9YBHgN7KMFBFq/rS1RChF6eaGz2nCXNas32VShq0gHPfvbdpyScJ4q4kv3jTzVb5a8VHmshUcqq6kt7DomRLGYfTupDLfK+oC2JXrSt/i0OxgtG/iTC6u3yj9OxVNLn1XIpai6yP2QhRDUWbrOoLIvLU7LTJwuYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=J+XhwAOA; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="J+XhwAOA"
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20261013151449euoutp01a9de0e275e7728c98eb73c9e6e5735bc~eH6OpHymN1757917579euoutp01C
	for <iommu@lists.linux.dev>; Tue, 13 Oct 2026 15:14:49 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20261013151449euoutp01a9de0e275e7728c98eb73c9e6e5735bc~eH6OpHymN1757917579euoutp01C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1791904489;
	bh=TucBtbT8WUZnaL4AAJ/KHE6ifLcnYplyyYn4+mym8U0=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=J+XhwAOA1Ibu2V+msB3Z0/x6R4HuqR9MG22HyLGM7owRGWCRXUhVdxR5ueM45Dkxe
	 +h5MPmkK3ly/kBNnW0tobrHknGR3YSCnvms3hmIrsV0lAKjHyIWxY2i0a1hKd+fUbw
	 x3DbyRVnt0NbAqmkuY5NdDJTr9fRu6XScs7BXLJg=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20261013151449eucas1p25f9863bc10f769dc04db0e1cc7d22a8b~eH6OfGkV41073110731eucas1p2Y;
	Tue, 13 Oct 2026 15:14:49 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20261013151448eusmtip2e76adc8617f398a4f3b94dab5e502846~eH6N6x-bM1039010390eusmtip2y;
	Tue, 13 Oct 2026 15:14:48 +0000 (GMT)
Message-ID: <2f3f6025-1bea-4957-ae2f-219666c426aa@samsung.com>
Date: Tue, 13 Oct 2026 17:14:48 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH] dma-debug: Skip cacheline tracking for MMIO mappings
To: Robin Murphy <robin.murphy@arm.com>, Leon Romanovsky <leon@kernel.org>,
	=?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>,
	Arnd Bergmann <arnd@arndb.de>, Vinod Koul <vkoul@kernel.org>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <e7b6e74a-4ec9-4146-a6b0-9183a9fb7933@arm.com>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20261013151449eucas1p25f9863bc10f769dc04db0e1cc7d22a8b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20261013124404eucas1p18634616550d426fa68a0e919b73be3bb
X-EPHeader: CA
X-CMS-RootMailID: 20261013124404eucas1p18634616550d426fa68a0e919b73be3bb
References: <20261013-dma-debug-fixes-v1-1-1ad1f471cc61@nvidia.com>
	<CGME20261013124404eucas1p18634616550d426fa68a0e919b73be3bb@eucas1p1.samsung.com>
	<e7b6e74a-4ec9-4146-a6b0-9183a9fb7933@arm.com>

On 13.10.2026 14:43, Robin Murphy wrote:
> On 13/10/2026 12:44 pm, Leon Romanovsky wrote:
>> From: Leon Romanovsky <leonro@nvidia.com>
>>
>> Mapping one MMIO dma-buf for many RDMA importers overflows dma-debug's
>> cacheline overlap counter and triggers a warning. DMA_ATTR_MMIO mappings
>> must never be CPU-cacheable, so CPU cacheline overlap tracking does not
>> apply to them.
>>
>> Skip MMIO entries in both cacheline insertion and removal. Keep them in
>> the DMA entry hash so mapping and unmapping checks still run.
>
> Seems fair;
>
> Reviewed-by: Robin Murphy <robin.murphy@arm.com>
>
> [...]
>>
>> Fixes: 0e74b34dfc33 ("dma-debug: add support for resource mappings")
>
> Although it would be a challenge to backport _that_ far, so more realistically I'd probably say:
>
> Fixes: 3aa31a8bb11e ("dma-buf: provide phys_vec to scatter-gather mapping routine")
>
> since regular dma_map_resource() users are still never going to hit this making their one-off mapping of a UART FIFO or whatever.


Applied to dma-mapping-for-next with updated Fixes: tag, thanks!


Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

