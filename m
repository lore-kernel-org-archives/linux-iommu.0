Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A75723D34B5
	for <iommu@lists.linux.dev>; Fri, 27 Mar 2026 09:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774604297; cv=none; b=S+kvBBWFfHF0T4rDBVOFgPJXoq3KCt4PtXYJlF7OFvqdfeAVf3qReNSB1aK7q0RiSDLg9o2P00u+YLy4gus0S3aDGgG3g3XU3QwXDi4R3xSa1BeY5pH0g8xrEyAnU8vQMZPns33vx+93TUkO0ZsiDllyXgfRtKfkujqQ7tqpwFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774604297; c=relaxed/simple;
	bh=VTGR2oZeOTUkXAjoxaQQHWqP5TfqoEgIsXg4YWroNFk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=Nwo0OkzXV3fBsluOZ/RttzPsuOTj/Yl+PXhS/i6MvAE2piPm+TFSmSC8wJeqTc7FDIVwkwgWrpOZog1dqge78h2tu0uen/oDb/jb9HE5l1e4cchqwbyDEuMQiqMbDEsKTY6jtf3XHOXnVxhdDIGNCCdjS2IwF/to+qHMBeLXopM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=tEJ9O1Jn; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="tEJ9O1Jn"
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20260327093813euoutp02e99b62d78ff224d0513adb4973f7eb06~gqTP0MOjZ1031710317euoutp02P
	for <iommu@lists.linux.dev>; Fri, 27 Mar 2026 09:38:13 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20260327093813euoutp02e99b62d78ff224d0513adb4973f7eb06~gqTP0MOjZ1031710317euoutp02P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1774604293;
	bh=0wrrBT9Vgx5xYr3ZtqLPUbt27G4B7MOzYfS2jPrN8kQ=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=tEJ9O1Jnk3kcIWa/GQWlYDVsdjOZbDe2dmIbrigJ2c8G34HJxvn4IGvWDvX6x+guU
	 7OpBFxvD7I7peNfcsUSBPn89cUk2ApU4PUTRxPyPG696UClnlWenGkehnLiZR0L6c7
	 OM7P/DSIpX29McX5cWpjCy5Zro3ZtRdqNda5cH0o=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20260327093813eucas1p2491c30df8c61bc550d31f05d90811332~gqTPXpzSE0810508105eucas1p2a;
	Fri, 27 Mar 2026 09:38:13 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20260327093811eusmtip192818a11797378662e842d7b047a01bf~gqTNROVR00077200772eusmtip1F;
	Fri, 27 Mar 2026 09:38:11 +0000 (GMT)
Message-ID: <f2047cd7-91a8-4f6a-b6b9-0e4f143f6854@samsung.com>
Date: Fri, 27 Mar 2026 10:38:10 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH v5 0/2] dma-buf: heaps: system: add an option to
 allocate explicitly shared/decrypted memory
To: Jiri Pirko <jiri@resnulli.us>, dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org, iommu@lists.linux.dev,
	linux-media@vger.kernel.org
Cc: sumit.semwal@linaro.org, benjamin.gaignard@collabora.com,
	Brian.Starkey@arm.com, jstultz@google.com, tjmercier@google.com,
	christian.koenig@amd.com, robin.murphy@arm.com, jgg@ziepe.ca,
	leon@kernel.org, sean.anderson@linux.dev, ptesarik@suse.com,
	catalin.marinas@arm.com, aneesh.kumar@kernel.org, suzuki.poulose@arm.com,
	steven.price@arm.com, thomas.lendacky@amd.com, john.allen@amd.com,
	ashish.kalra@amd.com, suravee.suthikulpanit@amd.com,
	linux-coco@lists.linux.dev
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20260325192352.437608-1-jiri@resnulli.us>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20260327093813eucas1p2491c30df8c61bc550d31f05d90811332
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20260325192400eucas1p2ae38ff4c2b3ab35a7047cfd680d9fda3
X-EPHeader: CA
X-CMS-RootMailID: 20260325192400eucas1p2ae38ff4c2b3ab35a7047cfd680d9fda3
References: <CGME20260325192400eucas1p2ae38ff4c2b3ab35a7047cfd680d9fda3@eucas1p2.samsung.com>
	<20260325192352.437608-1-jiri@resnulli.us>

On 25.03.2026 20:23, Jiri Pirko wrote:
> From: Jiri Pirko <jiri@nvidia.com>
>
> Confidential computing (CoCo) VMs/guests, such as AMD SEV and Intel TDX,
> run with private/encrypted memory which creates a challenge
> for devices that do not support DMA to it (no TDISP support).
>
> For kernel-only DMA operations, swiotlb bounce buffering provides a
> transparent solution by copying data through shared memory.
> However, the only way to get this memory into userspace is via the DMA
> API's dma_alloc_pages()/dma_mmap_pages() type interfaces which limits
> the use of the memory to a single DMA device, and is incompatible with
> pin_user_pages().
>
> These limitations are particularly problematic for the RDMA subsystem
> which makes heavy use of pin_user_pages() and expects flexible memory
> usage between many different DMA devices.
>
> This patch series enables userspace to explicitly request shared
> (decrypted) memory allocations from new dma-buf system_cc_shared heap.
> Userspace can mmap this memory and pass the dma-buf fd to other
> existing importers such as RDMA or DRM devices to access the
> memory. The DMA API is improved to allow the dma heap exporter to DMA
> map the shared memory to each importing device.
>
> Based on dma-mapping-for-next e7442a68cd1ee797b585f045d348781e9c0dde0d

I would like to merge this to dma-mapping-next, but I feel a bit 
uncomfortable with my lack of knowledge about CoCo and friends. Could 
those who know a bit more about it provide some Reviewed-by tags?

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

