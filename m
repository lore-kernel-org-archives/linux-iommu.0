Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65EF1224CC
	for <iommu@lists.linux.dev>; Fri, 28 Feb 2025 14:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740752982; cv=none; b=eATMpeyUDsIlx1Z7PMvU4weoLcdfRvucAgSyXjiCHUDyrTqkCaYupXUZpt85FjtECxLKM+ugJTah0+l0W2vs5RfOphklLAY6vWGcUBbZrX0GNcqfrZvnajRjStQiBMatpbFHOsqznsbsTpAqGYvA6Ui5fH+zHDvyg2zsBWaBBvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740752982; c=relaxed/simple;
	bh=wrkHfrMWdUhwqMsqXPfBrKrQMuZpa1RsPdz3Xjvtgk8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=WF8kVLbWqu46WXmdMvhbEt62pLF9uwHS0DuOiZ1EaM2h454sIowQz75ElIZeHJR0S+v2f+ESAVQFgty2i/L/IFBlkj6C5YzyVLSRVBMnXYGhMmrj62s/0E5xjQLIYPG5wt3sJ2v2spk5YNEtQ/Uw6EhH4PH5/rQuu42QP8dNHcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=It+B7sGI; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="It+B7sGI"
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20250228142931euoutp01e15b1102cca8a876d2df5829ecca603d~oZZqx8iSK3207432074euoutp01O
	for <iommu@lists.linux.dev>; Fri, 28 Feb 2025 14:29:31 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20250228142931euoutp01e15b1102cca8a876d2df5829ecca603d~oZZqx8iSK3207432074euoutp01O
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1740752971;
	bh=R9b6wNXLWS57OwUrSxSHHny8gYscUGRZCgoWnEP/DKE=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=It+B7sGIh3Z++sNXOqHZKPpAsnljTK3qXCtQ5uLbuHgRFrepAMN0YuejiVSkowIIj
	 QMuhoSepqlX8BLMskby2dfWMzjAr18ixQh5n+Ikc3b3KlvXv7KIXMkO1hmYpvzUTup
	 rfd/PAkKkPLU7nglc1i1sCtnhWKq/8/8WKf+WzXs=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20250228142930eucas1p18c32d0d89ed9c362f83d8b0c426366a0~oZZqqfhO-1259812598eucas1p1c;
	Fri, 28 Feb 2025 14:29:30 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges1new.samsung.com (EUCPMTA) with SMTP id FC.6D.20821.A48C1C76; Fri, 28
	Feb 2025 14:29:30 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20250228142930eucas1p118f56e14432e6d6d4da5f27175262064~oZZqXNh5m1245412454eucas1p1m;
	Fri, 28 Feb 2025 14:29:30 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20250228142930eusmtrp19f1d8b1bd1734200b6f9bb31dc7c55ce~oZZqWp5-n0218302183eusmtrp1b;
	Fri, 28 Feb 2025 14:29:30 +0000 (GMT)
X-AuditID: cbfec7f2-b09c370000005155-a0-67c1c84a3a97
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id FE.1C.19920.A48C1C76; Fri, 28
	Feb 2025 14:29:30 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250228142929eusmtip2b9887adb567d3b0e6d0bb374fd046551~oZZpcJE3O1500215002eusmtip2M;
	Fri, 28 Feb 2025 14:29:29 +0000 (GMT)
Message-ID: <963cee91-477d-453a-8b3d-194cfd5a211b@samsung.com>
Date: Fri, 28 Feb 2025 15:29:28 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dma-mapping: update MAINTAINERS
To: Christoph Hellwig <hch@lst.de>, torvalds@linux-foundation.org
Cc: robin.murphy@arm.com, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20250224162724.349679-1-hch@lst.de>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprMKsWRmVeSWpSXmKPExsWy7djPc7peJw6mG8z8ZGSxcvVRJotfXyws
	Lu+aw2Zx8MMTVotHfW/ZHVg91sxbw+hxYsZvFo8Xm2cyeuy+2cDm8XmTXABrFJdNSmpOZllq
	kb5dAlfGgXs3mAumsldMPnyBrYHxPmsXIyeHhICJxKEVx5i6GLk4hARWMErs2vOAGcL5wijR
	8qafHaRKSOAzo8TjHh6Yjpm9G9kgipYzSkzd+o8RwvnIKNF1cyEbSBWvgJ3Egc1tLCA2i4Cq
	RN/a7VBxQYmTM5+AxUUF5CXu35oBtkEYaGp30wewGhEBR4lT66+D2cwC/hL/1nawQ9jiEree
	zGcCsdkEDCW63naB1XAC2euv9LNC1MhLbH87B+wFCYEDHBL7dy6DetRFYveGhewQtrDEq+Nb
	oGwZidOTe1ggGtoZJRb8vs8E4UxglGh4fosRospa4s65X0DrOIBWaEqs36UPEXaU2H+riREk
	LCHAJ3HjrSDEEXwSk7ZNZ4YI80p0tAlBVKtJzDq+Dm7twQuXmCcwKs1CCpZZSN6cheSdWQh7
	FzCyrGIUTy0tzk1PLTbMSy3XK07MLS7NS9dLzs/dxAhMN6f/Hf+0g3Huq496hxiZOBgPMUpw
	MCuJ8M6KPZAuxJuSWFmVWpQfX1Sak1p8iFGag0VJnHfR/tZ0IYH0xJLU7NTUgtQimCwTB6dU
	A1NO+jmp/ce3CEXE601XtigP1H17UXti9y22qby9a8Ovelid2sex5EXKaa0OiTvuj77O8Fhr
	83nXTVObj+kfg1odDO9+vjq9WqTH6+jvw09XOx94smSl4qPrx32/z5lyeSPHyTSWlqu/9HdX
	W8y2n7jeVbtuWcalvYunbt+qtjjgRv3KtWUfmBclvro7SeOQaYP7jvoDH3zOSkjsqzh7deZF
	jSbTQ15lYl8efphS4zb5ovqna3fmb43kMTfs2bYtzCDUKWFB8CX96v+eBvoNZUflPi2fO41B
	4bPF8QN6rwLu2vlL2LHwHPn/64zpP1em2BTlcmP1hzO/XTi9rLHxrZN2lTvbjx/SBd9ObvrK
	UBdnqMRSnJFoqMVcVJwIAGXqAy6mAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrGIsWRmVeSWpSXmKPExsVy+t/xe7peJw6mGzTclrNYufook8WvLxYW
	l3fNYbM4+OEJq8WjvrfsDqwea+atYfQ4MeM3i8eLzTMZPXbfbGDz+LxJLoA1Ss+mKL+0JFUh
	I7+4xFYp2tDCSM/Q0kLPyMRSz9DYPNbKyFRJ384mJTUnsyy1SN8uQS/jwL0bzAVT2SsmH77A
	1sB4n7WLkZNDQsBEYmbvRrYuRi4OIYGljBKX9v2FSshInJzWAGULS/y51gVV9J5RYs7Vq2AJ
	XgE7iQOb21hAbBYBVYm+tdvZIOKCEidnPgGLiwrIS9y/NYMdxBYG2tbd9AGsRkTAUeLU+utg
	NrOAr8TjQ2+YIRa0MEr0P21kgkiIS9x6Mh/MZhMwlOh62wXWwAlkr7/SzwpRYybRtbWLEcKW
	l9j+dg7zBEahWUjumIVk1CwkLbOQtCxgZFnFKJJaWpybnltsqFecmFtcmpeul5yfu4kRGGHb
	jv3cvINx3quPeocYmTgYDzFKcDArifDOij2QLsSbklhZlVqUH19UmpNafIjRFBgYE5mlRJPz
	gTGeVxJvaGZgamhiZmlgamlmrCTO63b5fJqQQHpiSWp2ampBahFMHxMHp1QDk8zGM2xvZ68W
	mSA5i/es5dq5+s7T1Ga7FXZ3G0e92WcrMX379MrvHjNz95nM73H/sv70zY0Pa2bpnnNufnqK
	uWRLTcAL7n+2Ozlff/nyp+f95GCxnFkHebj652pfakye84gx8NybOV5F38o5b+Wf1KqZNKNq
	s+zO1W823mnN+lKlMT8w8MNa3Qssu9ZLH+CKNPyxdbburUV/GC+tcNvT2dz506G55k5ffZv1
	zUO/ryYFG37bHJApzBg4uZPLaxYLk+J6LQvWd9N3xlu5luc03O8rKZX35ZJfuUP0lbMQD7Mf
	k6/MF5ajNbkeC49dfv27cXsK38oEm8vSZ1hsmc02KjBdCEr7ZzdthSGb1txbtUosxRmJhlrM
	RcWJAAR9L/g5AwAA
X-CMS-MailID: 20250228142930eucas1p118f56e14432e6d6d4da5f27175262064
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20250224162737eucas1p20c108ccb973fb9815364f009cc061e7b
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20250224162737eucas1p20c108ccb973fb9815364f009cc061e7b
References: <CGME20250224162737eucas1p20c108ccb973fb9815364f009cc061e7b@eucas1p2.samsung.com>
	<20250224162724.349679-1-hch@lst.de>

On 24.02.2025 17:27, Christoph Hellwig wrote:
> Marek has graciously offered to maintain the dma-mapping tree.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   MAINTAINERS | 1 -
>   1 file changed, 1 deletion(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 4ff26fa94895..5434da7a4889 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -6879,7 +6879,6 @@ F:	kernel/dma/map_benchmark.c
>   F:	tools/testing/selftests/dma/
>   
>   DMA MAPPING HELPERS
> -M:	Christoph Hellwig <hch@lst.de>
>   M:	Marek Szyprowski <m.szyprowski@samsung.com>
>   R:	Robin Murphy <robin.murphy@arm.com>
>   L:	iommu@lists.linux.dev


Thank You Christoph for all the work done so far! I will do my best to 
keep dma-mapping subsystem uptodate. I will prepare a new dma-mapping 
git tree asap and start collecting patches.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

