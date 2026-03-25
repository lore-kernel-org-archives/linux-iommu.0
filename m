Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08A64382375
	for <iommu@lists.linux.dev>; Wed, 25 Mar 2026 20:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774472107; cv=none; b=AegdG1uy/UdCwgLgNKcNqVIyJMZJUxjmjcHAc0E+k6JSUOevLUDscq79TCViz1SDXkDkYJl1mWkgsBMLB0NGoxq/O+BpUF8xKlAAvACT9bw/Z3JPDnAf4IQgabbIXNlBAifmNr8fOv/n95V5xnT0dbmuGDE+b7ytxpkq/CjQM8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774472107; c=relaxed/simple;
	bh=Vt4x57x45IB9sJ3VjRo3liraQJpjOmqmqWr9ZH75GgY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=sO6cPeR25AKbAloOTiVwK7arPk54ekball7Cn4+yEn8AFzfSwaInyr6QegKhjdIovXgdjs7nF/SL1IvyTnfKueu7zhRdiD4Ay4rAtSVoG8yPtSuSEX/GvKw6qb4ZkG8ewXU7dcIrItMa7mhmch2eE3PO3nD8y7LJV5pwEXG1SIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=J9c1qXZh; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="J9c1qXZh"
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20260325205501euoutp02cca4686c79a5fd5385cfc220d1687582~gMPmU3ULH0270902709euoutp02C
	for <iommu@lists.linux.dev>; Wed, 25 Mar 2026 20:55:01 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20260325205501euoutp02cca4686c79a5fd5385cfc220d1687582~gMPmU3ULH0270902709euoutp02C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1774472101;
	bh=PY2CL0CMycDsOsBXWG0nc+K5vBh80XqbBbSm6JOePbM=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=J9c1qXZh+Pgb89AkBtB7+mVXKuUXd5c/bYze643HysW+VOsSvBQlTGLJxl0CKuWkq
	 nx+6zCsenJxe2CuhgPrVmg1xOa/0ADNIjsUuVoDujhCCezDxmSppM6n+demXPoPFpO
	 S29wWLfYnMEgxRMZcW70jmSKw04szolz/OTkXuFc=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20260325205501eucas1p2b1240f9af8cbd5412a68f49d3fec241f~gMPl7Rgdf0676006760eucas1p2Q;
	Wed, 25 Mar 2026 20:55:01 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20260325205500eusmtip1efe25faf3bb698b44e6f97bb3629c2a3~gMPlrZyHP2488724887eusmtip1H;
	Wed, 25 Mar 2026 20:55:00 +0000 (GMT)
Message-ID: <f09c9c3e-ae11-440d-b36e-b88fd4645648@samsung.com>
Date: Wed, 25 Mar 2026 21:54:59 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH] dma-debug: ensure mappings are created and released
 with matching attributes
To: Leon Romanovsky <leon@kernel.org>
Cc: Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20260325175622.GS814676@unreal>
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20260325205501eucas1p2b1240f9af8cbd5412a68f49d3fec241f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20260323202058eucas1p1946c1763123f2ceb493ebef25165f453
X-EPHeader: CA
X-CMS-RootMailID: 20260323202058eucas1p1946c1763123f2ceb493ebef25165f453
References: <CGME20260323202058eucas1p1946c1763123f2ceb493ebef25165f453@eucas1p1.samsung.com>
	<20260323-dma-attrs-debug-v1-1-6275228ca300@nvidia.com>
	<6d0eabf8-06c6-4b87-ac73-e6e4136c0691@samsung.com>
	<20260325175622.GS814676@unreal>

On 25.03.2026 18:56, Leon Romanovsky wrote:
> On Wed, Mar 25, 2026 at 06:28:41PM +0100, Marek Szyprowski wrote:
>> On 23.03.2026 21:20, Leon Romanovsky wrote:
>>> From: Leon Romanovsky <leonro@nvidia.com>
>>>
>>>
>>> The DMA API expects that callers use the same attributes when mapping
>>> and unmapping. Add tracking to verify this and catch mismatches.
>>>
>>>
>>> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
>> Applied to dma-mapping-for-next, thanks!
> Thanks a lot.

It looks I've hurries a bit too much. This patch is not yet ready for -next:

1. attrs are not passed to debug_dma_unmap_{phys, sg}

2. attrs are not propagated to 'struct dma_debug_entry ref' in 
debug_dma_free_{coherent, pages}

3. DMA_ATTR_NO_WARN and DMA_ATTR_ALLOC_SINGLE_PAGES should be probably 
ignored, as are they don't make any sense to check in free calls


The above issues result in dozens of false-positive warnings, even in 
drivers doing simple dma_alloc_wc(...) and then dma_free_wc(...).

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

