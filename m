Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=210.118.77.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794823035;
	b=e/qwc6MvHNo1fA5CtjfTfUW1MBPKPgn9w8KxdWrD8XMNQkBRcVs8DqRT31HFyl/rlsrY
	 J6NP2ffpJVbOgUNENfn1QfWa1LLF0hWq7xIwbDcotYZjWT4wxu0utJ2OramT6pvVtttML
	 zRkJ4VmxB7vMtDrpcTiWvTWCklpT8EnQHG6DbVSlWnvompDBV7/uO05TJ1MraNsYtGLXb
	 euO73+es3zGB4mk5FlBhQTQMJUkBJV+BTZBtJLssGQ9Gz3Hu2s2LP+Ib0GGFVh0r0mfhA
	 H8EwCrPMMlLfxymeaxAWnWSFrSllwsnEqX/ko6VUtPucNz+AkXnOOXG1ZQiTnAZdQbQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794823035;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 Content-Language:From:In-Reply-To:Content-Transfer-Encoding:
	 X-CMS-MailID:X-Msg-Generator:Content-Type:X-RootMTR:X-EPHeader:
	 X-CMS-RootMailID:References;
	bh=gADPMhQ5JfaTMl41/g28OHbc9nkUDs7yH12IBxCuguI=;
	b=2gMS7dz8YOX2DyKprlu97X0pusBnCrgDm21NAfXh3PqKMjoOJH0o1pxnaFQGhRkgLw92
	 YtBh+kjeUr+K1sgKutI1gL8VWA8YjGuBauhTSWMfi906vXlXB+Vw2i89ylb6Al3/nJOL2
	 iAIZ3Krs6fGKXbHQsfFStyBEddsI0E9Qb4nFnbBK9iSwgXqbwYNFc4V/EKgVLd3MmfQZj
	 vAikSBh0+rEdGxC3LPmiWVCMoeDgOCITBpo8MHM9UAdEoDHTY5yEBgHeyEINvYZ1QgKYH
	 4FAk+IdobcqNHB+iEz1+w2KGjzxelaNZTl18r2ElLX6qEH3Ti+GtogzfHeBL1qzFgeg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=samsung.com;
	spf=pass smtp.mailfrom=samsung.com;
	dkim=pass header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=EtaJyRwt;
	arc=none smtp.remote-ip=210.118.77.11
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2CEF606A323
	for <iommu@lists.linux.dev>; Mon, 16 Nov 2026 09:57:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C2CEF606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=EtaJyRwt
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20261116095707euoutp0186920ea5e1961843fd7bcdfdf8dab686~ofgi70yZa0274802748euoutp01W
	for <iommu@lists.linux.dev>; Mon, 16 Nov 2026 09:57:07 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20261116095707euoutp0186920ea5e1961843fd7bcdfdf8dab686~ofgi70yZa0274802748euoutp01W
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1794823027;
	bh=gADPMhQ5JfaTMl41/g28OHbc9nkUDs7yH12IBxCuguI=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=EtaJyRwt1cHVcpo3NLfoLE+sfMLPr/ZzLiCnae2eQ67sn0qdgO8JjXGLmH1rJiz++
	 bBZzW6iCGlJivFePmHX1XbU2h7zQPfEUjg4ZtiXzNbJyE9aRCiPNrCBVHmjKwdHPyI
	 V+Umilwr3I5YDd2KQcgZar7zUhGbODdF9sryxmTY=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20261116095707eucas1p1495e3747e3b0f65092c48f8cf2ca97f8~ofgixM5At0211102111eucas1p14;
	Mon, 16 Nov 2026 09:57:07 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20261116095706eusmtip2b44cf9248b53db37577d1944e33a6a02~ofgiRd4_z0273602736eusmtip2-;
	Mon, 16 Nov 2026 09:57:06 +0000 (GMT)
Message-ID: <17fd14e7-41e3-4658-a62c-1206fd2b5e0d@samsung.com>
Date: Mon, 16 Nov 2026 10:57:06 +0100
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
Subject: Re: [PATCH 00/11] dma-mapping: add dma_alloc_attrs_node() and
 dma_alloc_coherent_node()
To: Jakub Kicinski <kuba@kernel.org>, robin.murphy@arm.com
Cc: netdev@vger.kernel.org, iommu@lists.linux.dev, joro@8bytes.org,
	will@kernel.org
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20261112081616.13b81fab@kernel.org>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20261116095707eucas1p1495e3747e3b0f65092c48f8cf2ca97f8
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20261112161622eucas1p131619576b0d4e6d201197007f3d7c951
X-EPHeader: CA
X-CMS-RootMailID: 20261112161622eucas1p131619576b0d4e6d201197007f3d7c951
References: <20261106184433.761422-1-kuba@kernel.org>
	<CGME20261112161622eucas1p131619576b0d4e6d201197007f3d7c951@eucas1p1.samsung.com>
	<20261112081616.13b81fab@kernel.org>

On 12.11.2026 17:16, Jakub Kicinski wrote:
> On Fri,  6 Nov 2026 10:44:22 -0800 Jakub Kicinski wrote:
>> Stable tag on top of v7.4-rc1, so that we can also pull this into
>> the networking tree:
>>
>>   git://git.kernel.org/pub/scm/linux/kernel/git/kuba/linux.git tags/dma_alloc_coherent_node
> Marek, Robin, would you be willing to pull?
> Or should I respin the tag to include the latest Ack/Review tags from
> the list?
If possible, respin the tag with latest acks/reviews, then I will pull it to
my dma-mapping-for-next branch.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

