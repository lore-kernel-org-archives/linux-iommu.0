Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=210.118.77.12
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793712439;
	b=S2YVtMKN1tPFl8IlyS3gHn9h+nZ4+2J2ryB1UerMbGNPEjAwFmtxhAAjYSYzzmZIP9Vl
	 mHzlgKlZpqQKlVkHHCXnWakTCw7xaj11K7LJOM+93R44pdevDmLEHkyIf3j0uIObATtYP
	 YLv6Rp0Gs/kiX33KtJmgfe7qITpHwrjwhJ3E3x2m4226BPs30hEur+JJ1aAJne/aep9id
	 Ze9SG1iu6sPvMH64FC0ePAhz5THKIFTvncuvwE77BW5uXh8u+jq8j8i8kcmiHWzSjAD4H
	 LrvaC4ZLxua5Ov2h8HZMl3N7qiTplapWSZwx3fXs/kU4lqFzLgHikrZdH2hZEPKcHng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793712439;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 Content-Language:From:In-Reply-To:Content-Transfer-Encoding:
	 X-CMS-MailID:X-Msg-Generator:Content-Type:X-RootMTR:X-EPHeader:
	 X-CMS-RootMailID:References;
	bh=ABDqe6caApeNw6BhcqtL/ES/kBv7JWUT4r+E6SK+ZTw=;
	b=xsdSThxR+VT0XB3TCGR7WUUryQWqpVkRjqQoEIExDpAgEnjqJwRsVOqa2vHBpAAhmhuz
	 6ckRPsyRrEC77BGM19ExWJiBEwgW2alSX0572kgXcaJTGIuEKUekz/pdnPelnYs+pRFB0
	 V2xDR+pDVZOHalrwFALCYl9+Nlsy8KkaOSKCnb4Bkx8J36U/CuCaiRCvI/bvSm1A3UIJ7
	 tY6FWCqlZVilijmAo4geirv9kXNZ4Ho+BiGbX8TacEawcJ1w6O5zlxAhhIUAVjBWr1dRX
	 4M81IJvbQf04G1nXvznY8RZH53m5/9guLeCATIyyaLOz0oFHXmgUxgGOQQ0mFW58Wag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=samsung.com;
	spf=pass smtp.mailfrom=samsung.com;
	dkim=pass header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b="EBy9R/QE";
	arc=none smtp.remote-ip=210.118.77.12
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A946B60850A2
	for <iommu@lists.linux.dev>; Tue,  3 Nov 2026 13:27:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A946B60850A2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=EBy9R/QE
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20261103132717euoutp0284c50421ebce589527f12fd75327229c~ki-U9p1-D1699016990euoutp02Y
	for <iommu@lists.linux.dev>; Tue,  3 Nov 2026 13:27:17 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20261103132717euoutp0284c50421ebce589527f12fd75327229c~ki-U9p1-D1699016990euoutp02Y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1793712437;
	bh=ABDqe6caApeNw6BhcqtL/ES/kBv7JWUT4r+E6SK+ZTw=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=EBy9R/QETP3e4+7vlPkRFet3BCI/LK4YpPm00Wm/MJCoBqbHeJxJFHTEhB8ImMlnX
	 tT4Wztq8/jA5zZDrIk2jxWTOWB876D2IrULSKo/SM4rrkoH+IfoQnO7sHD/ep1q8Eo
	 WwX7gxcpXJh2xuwVoLY3NyWLUiCGy2sDUZk88C7Q=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20261103132716eucas1p1e3384deb453a2cb129efd879d757d88b~ki-Uf38D_2105421054eucas1p19;
	Tue,  3 Nov 2026 13:27:16 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20261103132715eusmtip13939e43bf3d107df8b1fcb9d1b36c191~ki-T8pIpM1299412994eusmtip1G;
	Tue,  3 Nov 2026 13:27:15 +0000 (GMT)
Message-ID: <d2c22ebc-99d9-4166-8fa3-5af4c88f4df1@samsung.com>
Date: Tue, 3 Nov 2026 14:27:15 +0100
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [RFC 03/11] iommu/dma: pass the NUMA node to iommu_dma_alloc()
To: Jakub Kicinski <kuba@kernel.org>, robin.murphy@arm.com
Cc: tglx@kernel.org, dave.hansen@linux.intel.com, x86@kernel.org,
	joro@8bytes.org, will@kernel.org, leon@kernel.org, mbloch@nvidia.com,
	iommu@lists.linux.dev, netdev@vger.kernel.org
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20261027022528.633359-4-kuba@kernel.org>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20261103132716eucas1p1e3384deb453a2cb129efd879d757d88b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20261027022613eucas1p17a0f748d1ef00ff8a1265b5b0345c5cc
X-EPHeader: CA
X-CMS-RootMailID: 20261027022613eucas1p17a0f748d1ef00ff8a1265b5b0345c5cc
References: <20261027022528.633359-1-kuba@kernel.org>
	<CGME20261027022613eucas1p17a0f748d1ef00ff8a1265b5b0345c5cc@eucas1p1.samsung.com>
	<20261027022528.633359-4-kuba@kernel.org>

On 27.10.2026 03:25, Jakub Kicinski wrote:
> iommu_dma_alloc() allocates the pages on the node of the device.
> Pass the node in explicitly, so that a node-aware coherent allocation
> API can be layered on top.
>
> Memory from the atomic pools is not node-aware.
> iommu_dma_alloc_noncontiguous() keeps using the device's node.
>
> Callers pass dev_to_node() for now, no functional change.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Acked-by: Marek Szyprowski <m.szyprowski@samsung.com>


> ---
>  include/linux/iommu-dma.h |  2 +-
>  drivers/iommu/dma-iommu.c | 28 ++++++++++++++++------------
>  kernel/dma/mapping.c      |  3 ++-
>  3 files changed, 19 insertions(+), 14 deletions(-)
>
> ...

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

