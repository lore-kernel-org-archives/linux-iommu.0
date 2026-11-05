Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=210.118.77.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793864794;
	b=JVVBO02do1a370/FYFk59WXep9koeLsXLoB3dPpBIuNuKDCznpYJhfufA0anjf17plAP
	 or9jiYhe8N6muv2X7ymKXX8nJmzl2v7TGg6BE9yAeA084kf0Srju8XMc3DJ1sLJVKFn6u
	 ZVzqpfnnyM/2h/qngAEXgS8yOZBpVBWUuOfmaag56qJmC42yOa0FGe7qbEnjYsNoIxADo
	 YkXIYLXJRir5pmXD0UdWfU7QHZm8a85u/9TJzAPfXVNTX9KNUE/zAKRmaq6r1u9s4+g/K
	 u+Ycnl6LTns33v+ruVkq4Qt+UGniOS2APsj8n09oihs8pWTJOB+Ku5+BCtmvBmtqq4Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793864794;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 Content-Language:From:In-Reply-To:Content-Transfer-Encoding:
	 X-CMS-MailID:X-Msg-Generator:Content-Type:X-RootMTR:X-EPHeader:
	 X-CMS-RootMailID:References;
	bh=lU5J71U4XgIWMOiPvXfTbGDkT+Od3ly2nNQHaTLpzYM=;
	b=3jb3MxGZ3PfzQ5Cfi9xdhw1Qo9HZWMulRZEllhR8Nlkyil1QBaHy0nFOVsCkziksxOAh
	 s/lncpSw5o38d+IOwfX0nI//jER7L+8ixwVB79A/ACBaU2CR99U6mm2YbyAFoiw22kv/G
	 BeNyvoKZ5nqkFGS+aoDfmkXcOlN5bswgUYyMZ/PTRDeKFWa76x7OHD2FRwxFxxyMP4rDb
	 nPL2vCxiZZuizyCgP3eMInH4KSxsyYVoouykOtHEtbYMtgcnSEqwSaXdl95tmhKc739c0
	 sCSHLsAme3707z0LcT4uAUkVCuQPhsx8xU7y1Ufjmklb6thrlCXSBukhtnv145Nmjyw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=samsung.com;
	spf=pass smtp.mailfrom=samsung.com;
	dkim=pass header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=muxVFj3n;
	arc=none smtp.remote-ip=210.118.77.11
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B36E7606A32C
	for <iommu@lists.linux.dev>; Thu,  5 Nov 2026 07:46:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B36E7606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=muxVFj3n
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20261105074625euoutp01b5adf660546c5f38164b494f5635b00f~lFoSStzg01661616616euoutp01O
	for <iommu@lists.linux.dev>; Thu,  5 Nov 2026 07:46:25 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20261105074625euoutp01b5adf660546c5f38164b494f5635b00f~lFoSStzg01661616616euoutp01O
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1793864785;
	bh=lU5J71U4XgIWMOiPvXfTbGDkT+Od3ly2nNQHaTLpzYM=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=muxVFj3nm9m7uVIu1wQnTfdKrp53jFMylxFBgvaxk3xmACoIUeLYYcJ5tapxX0I4v
	 9y1Svt/3wA15g+uMZvfQuMEUaAikosga+rMj1CggEqYXZiSsTSGhOjVZavLsLoBKlN
	 7QxQ/2Y5JMj1T6+tIF3pj+K58ujAwCfiGcbePuPs=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20261105074624eucas1p289667b7bbae43845369198bd5ee4635c~lFoSCAsYq2212322123eucas1p2C;
	Thu,  5 Nov 2026 07:46:24 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20261105074624eusmtip22b7a36fed5a922a5603e7a85df7483f9~lFoRSxEzR0109901099eusmtip2s;
	Thu,  5 Nov 2026 07:46:24 +0000 (GMT)
Message-ID: <d394bfeb-a578-436b-b8e5-2f704c4f7e4d@samsung.com>
Date: Thu, 5 Nov 2026 08:46:23 +0100
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
Subject: Re: [PATCH] dma: Remove redundant 0x prefixes
To: Thorsten Blum <blum@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Michael Kelley <mhklinux@outlook.com>, Will Deacon <will@kernel.org>, Petr
	Tesarik <petr.tesarik1@huawei-partners.com>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20261104155414.126812-3-blum@kernel.org>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20261105074624eucas1p289667b7bbae43845369198bd5ee4635c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20261104155542eucas1p21319566787c295bf97d096bc5f85474a
X-EPHeader: CA
X-CMS-RootMailID: 20261104155542eucas1p21319566787c295bf97d096bc5f85474a
References: <CGME20261104155542eucas1p21319566787c295bf97d096bc5f85474a@eucas1p2.samsung.com>
	<20261104155414.126812-3-blum@kernel.org>

On 04.11.2026 16:54, Thorsten Blum wrote:
> The %pa format specifier already includes the 0x prefix. Remove the
> redundant prefixes to avoid printing 0x0x.
>
> Fixes: 9d4f645a1fd4 ("dma-debug: store a phys_addr_t in struct dma_debug_entry")
> Fixes: 823353b7cf0e ("swiotlb: Enforce page alignment in swiotlb_alloc()")
> Signed-off-by: Thorsten Blum <blum@kernel.org>

Applied to dma-mapping-for-next. Thanks!


> ---
>  kernel/dma/debug.c   | 4 ++--
>  kernel/dma/swiotlb.c | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
>
Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

