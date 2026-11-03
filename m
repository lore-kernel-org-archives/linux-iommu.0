Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=210.118.77.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793712391;
	b=EqykdPx5aP894snUfGFLPvne4rPPFZynjWga4CQBkMDMl6hTiIfO+mADaERd2lqkBbE4
	 av+xqgf8812kmqqEyO94n6gxk8/kOSZ7Omo9X1j4rdu07JqJ71wJZwBVjM5TcyDdH90sV
	 lqrGeH2hyrA1YDEgmOYCLREjxkh6eKJkk3AiC0Fx251FXANxtd/WZj+rdIev/y4KToBSO
	 R8AmCLD+pyunRj0R6miqoHJPemQM94JfaLjA0v2MfCFoqn39B5ShWAk+H5s5hGQ4Uw2tO
	 6tZY71LDn9quZ3gCGeaPegey70G7CTEqYj9dj1QCvGk9UeyZ3UhdmSGBR7FMWuhYBWg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793712391;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 Content-Language:From:In-Reply-To:Content-Transfer-Encoding:
	 X-CMS-MailID:X-Msg-Generator:Content-Type:X-RootMTR:X-EPHeader:
	 X-CMS-RootMailID:References;
	bh=+L1d02VlmBdeNiw2o6RjcDTm9z+gcwXX6G1uhnpjRu8=;
	b=usz78k2yR+a1xhS8DNkEJRqRFZ4320L0rwoWmI51g7YnootYtwDsbxn8U5JZIYfKqPvo
	 MaYbYGYvfZ98Lk+a/yGIVGWdaT4K+QMmAoagI3kbabnY8z5cPggltvvAyRQ/s8iHvOXzb
	 zOCPbm8zpRfGHUGd9SxqiOwFdE4ZARtsH0L+zLwipQt9H1PoNR1tBDqJ/MEyBlpDVBD0m
	 8J+2+JThB5IAsiMlDdMb0eH69Cy42UHVHxUqlewSeQQ6YSkfRM/qkR1iaYpRZbQuxNPek
	 KeJR+I8PaiaOsLqzOIPGu6PyC9CoXGo83j9PsslB1jZOaZhTFyjZ37EYUrSwUpVrj9A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=samsung.com;
	spf=pass smtp.mailfrom=samsung.com;
	dkim=pass header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=bpZG47an;
	arc=none smtp.remote-ip=210.118.77.11
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 538A2606A336
	for <iommu@lists.linux.dev>; Tue,  3 Nov 2026 13:26:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 538A2606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=bpZG47an
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20261103132623euoutp018d04b3d65d53b0a63315a836e772a4e4~ki_iynrp62298622986euoutp01E
	for <iommu@lists.linux.dev>; Tue,  3 Nov 2026 13:26:23 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20261103132623euoutp018d04b3d65d53b0a63315a836e772a4e4~ki_iynrp62298622986euoutp01E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1793712383;
	bh=+L1d02VlmBdeNiw2o6RjcDTm9z+gcwXX6G1uhnpjRu8=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=bpZG47anfZ6fp6OekXuJv8fYx+7zgxL0VqgDkBEL0P1MUEpj1IPjPyxLHiH0dehXH
	 EGSwcaQVUxHY+kqpl2oceGlpZM1jJzTOZyMrCYMQ2jy1Vm661f8s6SlOAn4H/1Sb7N
	 sqOk2kAVJYiWsn0Nnd0nQZoCilj4kzFifXyxv/zY=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20261103132622eucas1p2521781a5d80c5ac0985d722f349da735~ki_iiHNH80557005570eucas1p2T;
	Tue,  3 Nov 2026 13:26:22 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20261103132621eusmtip298676f7a0880c9649d211afd4e513a5d~ki_hlHa5c0573605736eusmtip2Y;
	Tue,  3 Nov 2026 13:26:21 +0000 (GMT)
Message-ID: <1feccffe-b74f-4c14-9416-a69919513061@samsung.com>
Date: Tue, 3 Nov 2026 14:26:21 +0100
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
Subject: Re: [RFC 01/11] dma-contiguous: pass the NUMA node to
 dma_alloc_contiguous()
To: Jakub Kicinski <kuba@kernel.org>, robin.murphy@arm.com
Cc: tglx@kernel.org, dave.hansen@linux.intel.com, x86@kernel.org,
	joro@8bytes.org, will@kernel.org, leon@kernel.org, mbloch@nvidia.com,
	iommu@lists.linux.dev, netdev@vger.kernel.org
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20261027022528.633359-2-kuba@kernel.org>
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20261103132622eucas1p2521781a5d80c5ac0985d722f349da735
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20261027022612eucas1p16aa56c7c3e5cf76d4bb2b50daa77e78a
X-EPHeader: CA
X-CMS-RootMailID: 20261027022612eucas1p16aa56c7c3e5cf76d4bb2b50daa77e78a
References: <20261027022528.633359-1-kuba@kernel.org>
	<CGME20261027022612eucas1p16aa56c7c3e5cf76d4bb2b50daa77e78a@eucas1p1.samsung.com>
	<20261027022528.633359-2-kuba@kernel.org>

On 27.10.2026 03:25, Jakub Kicinski wrote:
> dma_alloc_contiguous() picks the per-numa CMA area based on the node of
> the device. Let the callers pass the node in, so that the DMA allocators
> can be extended to place memory on a node other than the device's.
>
> All callers pass dev_to_node() for now, no functional change.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Acked-by: Marek Szyprowski <m.szyprowski@samsung.com>

I assume that the fallback discussed in 
https://lore.kernel.org/all/87se1o51wu.fsf@all.your.base.are.belong.to.us/ 
will be handled in separate patch.


> ---
>  include/linux/dma-map-ops.h |  5 +++--
>  drivers/iommu/dma-iommu.c   |  2 +-
>  kernel/dma/contiguous.c     | 12 +++++-------
>  kernel/dma/direct.c         |  2 +-
>  kernel/dma/ops_helpers.c    |  5 +++--
>  5 files changed, 13 insertions(+), 13 deletions(-)
>
> ...

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

