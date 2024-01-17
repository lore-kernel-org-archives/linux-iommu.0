Received: from gentwo.org (gentwo.org [62.72.0.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E44728699
	for <iommu@lists.linux.dev>; Wed, 17 Jan 2024 22:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.72.0.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705530216; cv=none; b=n790X1ns78zFpIqbzy3pkq1OC7CKVzAf3jQWaOx3Aq/T2AWPPiqW+/KfZuAS7qLhx5jMXnmAhrEJwqtwPrHaJC7+Csz7D46KzaNw3yPwdi+QGtXx0xRv2lO06NFPRSiT3tBgskq1JiYsO+/fq7uGLPhL/BQaPdxuL0O3m257F4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705530216; c=relaxed/simple;
	bh=GzgtWrsrVSTETm0Nq6miwtI3r6kYiPkoq9PTnzBbi7A=;
	h=Received:Received:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type; b=Z6/dNY5kRDD5kDLxgH3Ad/WAobhS+fwSoitB1EwEGj4nawavohSRjtseDs+DqQERDsbSPn87D264PYOKBE+9w3RqkLnRAGtNljO6GMaLfE8I3qNo1zJG+ioBqt+T/TG7oHXOyFMwlqmciT/OE/0IRZJ9lujG+s+aXuK6rrOOQXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=fail smtp.mailfrom=linux.com; arc=none smtp.client-ip=62.72.0.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.com
Received: by gentwo.org (Postfix, from userid 1003)
	id 614C940A8B; Wed, 17 Jan 2024 14:23:33 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
	by gentwo.org (Postfix) with ESMTP id 5A16540A85;
	Wed, 17 Jan 2024 14:23:33 -0800 (PST)
Date: Wed, 17 Jan 2024 14:23:33 -0800 (PST)
From: "Christoph Lameter (Ampere)" <cl@linux.com>
To: Baruch Siach <baruch@tkos.co.il>
cc: Christoph Hellwig <hch@lst.de>, 
    Marek Szyprowski <m.szyprowski@samsung.com>, 
    Rob Herring <robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>, 
    Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
    Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev, 
    devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
    linux-kernel@vger.kernel.org, 
    =?ISO-8859-2?Q?Petr_Tesa=F8=EDk?= <petr@tesarici.cz>, 
    Ramon Fried <ramon@neureality.ai>
Subject: Re: [PATCH RFC 1/4] of: get dma area lower limit
In-Reply-To: <be71fbb0963584b8c401423d9dd2fba2511bd5b4.1703683642.git.baruch@tkos.co.il>
Message-ID: <30d81f73-e27e-6cc4-5458-686e3ddd2e5c@linux.com>
References: <cover.1703683642.git.baruch@tkos.co.il> <be71fbb0963584b8c401423d9dd2fba2511bd5b4.1703683642.git.baruch@tkos.co.il>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Wed, 27 Dec 2023, Baruch Siach wrote:

> of_dma_get_max_cpu_address() returns the highest CPU address that
> devices can use for DMA. The implicit assumption is that all CPU
> addresses below that limit are suitable for DMA. However the
> 'dma-ranges' property this code uses also encodes a lower limit for DMA
> that is potentially non zero.

All of memory can be used for DMA by default (==ZONE_NORMAL). ZONE_DMA 
defines a special range for devices that are unable to perform DMA to all 
of memory. Usually due to the lack of address bit support.

So I guess that the platform in question here has as a general limit as to 
what address spaces I/O devices can do DMA to?
