Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34F6C2367BA
	for <iommu@lists.linux.dev>; Thu, 26 Jun 2025 07:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750922465; cv=none; b=TGP64pK8KQUbVMn1PC/JRZxhyf40ABLkmg95lgZmVWB0pYjZsfl6HwCV+9JjwcXVJwz2+vmZGFFOYHsC+8acHt1hxKnHlBKjbQ9McbPeWtRb6Mh6VqFusImeFG/x3tbURiBQOIXYAnDQD592XX/wKGCX7CyY4cBmy4LPq9xO97s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750922465; c=relaxed/simple;
	bh=8BEqZFGNNPYAx8EANxy+tw8P/Y+o0527pa2JR+l2NpA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=BeILjc14sY0ar1RbVjStVylm2qW5WWhv25Ecg+zkEP5wtU5KDdHJlpf+PcSmJtqxEQMIt4pu7XlH2TsTuimo2R+nv06hL1Km+hKOAJbwkrP0RVXpQC9lm8TiKwX7IaJ/dACQ6RBg0FjNPzr3QpMLf9rESAWVRCINAZzya8i4F48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=UmJM2otD; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="UmJM2otD"
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20250626072102euoutp018dbf64c4acbcc5cd2c8f71fe2d3c1f33~MhrPu82Nu2706527065euoutp01J
	for <iommu@lists.linux.dev>; Thu, 26 Jun 2025 07:21:02 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20250626072102euoutp018dbf64c4acbcc5cd2c8f71fe2d3c1f33~MhrPu82Nu2706527065euoutp01J
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1750922462;
	bh=LPimFjjxe7jfdwBjYJXhsorVGtUpD3BI2ZbS3ELJhYk=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=UmJM2otDrqRpBzvO2qj99Ds4/cZ0bS9VDuqkdaaSi1UUfpRMRFQlRdRF0rircsutJ
	 p5YlojDXfZA2+rw9jdxegvh60GGV1UhpS0IrZN1g2GhQWjlqt9GAcAhXmQPLU2x4vq
	 fpJ1B/WFbK3MxgwHzhZ8F3/ROYC1+69fnBMm5Ft4=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20250626072102eucas1p1be8a47bb942ca25436f9985c45a01c95~MhrPYoBcn1644116441eucas1p14;
	Thu, 26 Jun 2025 07:21:02 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250626072101eusmtip17c426e105c6e0e527e20a4ad58cc97a1~MhrOgUKZ22676026760eusmtip1X;
	Thu, 26 Jun 2025 07:21:01 +0000 (GMT)
Message-ID: <3acea31c-054c-43a8-a6f7-ab4b5b6a7dca@samsung.com>
Date: Thu, 26 Jun 2025 09:21:00 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/8] docs: dma-api: replace consistent with coherent
To: Petr Tesarik <ptesarik@suse.com>, Robin Murphy <robin.murphy@arm.com>,
	Christoph Hellwig <hch@lst.de>
Cc: Jonathan Corbet <corbet@lwn.net>, Andrew Morton
	<akpm@linux-foundation.org>, Leon Romanovsky <leon@kernel.org>, Keith Busch
	<kbusch@kernel.org>, Caleb Sander Mateos <csander@purestorage.com>, Sagi
	Grimberg <sagi@grimberg.me>, Jens Axboe <axboe@kernel.dk>, John Garry
	<john.g.garry@oracle.com>, "open list:DOCUMENTATION"
	<linux-doc@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, "open
 list:MEMORY MANAGEMENT" <linux-mm@kvack.org>, iommu@lists.linux.dev
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20250626065123.646bd954@mordecai.tesarici.cz>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20250626072102eucas1p1be8a47bb942ca25436f9985c45a01c95
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20250626045133eucas1p1d5070046a3303f6b2fe7f9ec75d08f02
X-EPHeader: CA
X-CMS-RootMailID: 20250626045133eucas1p1d5070046a3303f6b2fe7f9ec75d08f02
References: <20250624133923.1140421-1-ptesarik@suse.com>
	<20250624133923.1140421-3-ptesarik@suse.com>
	<CGME20250626045133eucas1p1d5070046a3303f6b2fe7f9ec75d08f02@eucas1p1.samsung.com>
	<20250626065123.646bd954@mordecai.tesarici.cz>

On 26.06.2025 06:51, Petr Tesarik wrote:
> On Tue, 24 Jun 2025 15:39:17 +0200
> Petr Tesarik <ptesarik@suse.com> wrote:
>
>> For consistency, always use the term "coherent" when talking about memory
>> that is not subject to CPU caching effects. The term "consistent" is a
>> relic of a long-removed pci_alloc_consistent() function.
> I realize that I'm not an authoritative source for this, but I forgot
> to add more trusted maintainers to the recipient list.
>
> Now, all you DMA experts, do you agree that the word "consistent"
> should be finally eradicated from DMA API documentation?

Well, this was always puzzling for me, why there are those 2 names used 
(especially in case of dma_alloc_coherent() vs. 
dma_alloc_nonconsistent()). I'm for unifying them to "coherent" as this 
is the term use more often.


> > ...

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

