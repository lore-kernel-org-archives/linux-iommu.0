Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AD5F2F3C18
	for <iommu@lists.linux.dev>; Wed, 25 Mar 2026 17:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774459727; cv=none; b=OfmzlZbMUQ/Bv4RLsXIviTswVo7kFSM9o0QzXKU1G+NKTyYsHOgZeuPViaqE9zGvBaGUK2L95vcBNzW1DCFdY+l5GLWfPRdKkRPhQ464g2a6g4SQT3rEJX7trmJ3sYzyss8xmXKlFdjMAEue9WKtdBNZ4zY1M5Y7v43KUDPyfHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774459727; c=relaxed/simple;
	bh=b4rDbPFuXYX2aCAL4uTNJULvKcuDhcMTfQ5o3cTNV2Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=iY+YblhIXRnOPAdku6/lsxP7sYgWaJ46uUIC1GGRZqeMsNAmYYkrL9e4H/Wban4H6A8J1IwXPnATC4h2uxqvhcA08It23mUN3hGSsA37pW/Ed5eW0ZE6o52HEY4rqcrF3crBa+BWb6IXrua1H8ucdAkbYfrj+6D1Yth9F/XA8UE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=Ffc4erb4; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Ffc4erb4"
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20260325172843euoutp0102687612165fc7bd31de07b1e7433238~gJbeBmyrO1911819118euoutp01H
	for <iommu@lists.linux.dev>; Wed, 25 Mar 2026 17:28:43 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20260325172843euoutp0102687612165fc7bd31de07b1e7433238~gJbeBmyrO1911819118euoutp01H
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1774459723;
	bh=0Gw/S8Zsh+bbwTFI9RM43qyHVS+L9kmOw0jj3MtD/So=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=Ffc4erb4r35TVPRrV7w3UyNldJye36dS5VUD6vgYs1ZUst3YzsJQB1D47gBXNjrAW
	 DVTI9gNXfcks3+E7Yh3oOoNLJ2mez+mrsgLXwB9NrB5i4UGn0PRrXZIg47JXWFgR8u
	 8QVhRm0sXdWhZWFy2a7NOVkrDhf2/n6zD4X44Abk=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20260325172842eucas1p207cf816bb965b5db99340ca5b2de580b~gJbdv4AHW2101821018eucas1p2B;
	Wed, 25 Mar 2026 17:28:42 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20260325172842eusmtip255e290294144e9c703636f74ebb83781~gJbdeoLmn1468314683eusmtip2b;
	Wed, 25 Mar 2026 17:28:42 +0000 (GMT)
Message-ID: <6d0eabf8-06c6-4b87-ac73-e6e4136c0691@samsung.com>
Date: Wed, 25 Mar 2026 18:28:41 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH] dma-debug: ensure mappings are created and released
 with matching attributes
To: Leon Romanovsky <leon@kernel.org>, Robin Murphy <robin.murphy@arm.com>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20260323-dma-attrs-debug-v1-1-6275228ca300@nvidia.com>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20260325172842eucas1p207cf816bb965b5db99340ca5b2de580b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20260323202058eucas1p1946c1763123f2ceb493ebef25165f453
X-EPHeader: CA
X-CMS-RootMailID: 20260323202058eucas1p1946c1763123f2ceb493ebef25165f453
References: <CGME20260323202058eucas1p1946c1763123f2ceb493ebef25165f453@eucas1p1.samsung.com>
	<20260323-dma-attrs-debug-v1-1-6275228ca300@nvidia.com>

On 23.03.2026 21:20, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
>
>
> The DMA API expects that callers use the same attributes when mapping
> and unmapping. Add tracking to verify this and catch mismatches.
>
>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>

Applied to dma-mapping-for-next, thanks!

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

