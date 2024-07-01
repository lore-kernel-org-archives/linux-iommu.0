Received: from bee.tesarici.cz (bee.tesarici.cz [37.205.15.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8844223A0
	for <iommu@lists.linux.dev>; Mon,  1 Jul 2024 05:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.205.15.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719812870; cv=none; b=uaQCzO2a1P/FHrQXxpj21g+T8OeidUpV2t6N7KBRyQk7j7XpVUpFqvgK25iVEy4zFWH3/5oweWPXn1TV6erKDLe8Wijb7oC8kFjew/EEnVE+8eKqczk7/joNmNNSEA32hjXy1NqAZDhFTs6jTz+uxO3ZraA7aS+Vs7zPxZP065Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719812870; c=relaxed/simple;
	bh=AmVllwoO/PrKVeEIjiMIXHaY1Hf9xdmMoer5gP5Wp/E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bgvDhvwlF7+HaAa2wYdsZYFoNg95nQzYE6Thb+7NeFdXwNEAx0HAlAnysq9J77NQaTZHlQFV2SLSOHCutLsLwX8dCGxdNI/Pj/6hL3v4t5V8xR4LOGQo0jWrI++Uu+lpqGdg8yVKaNb/yTnSjJ2nAaZgkaw28BHuY+Q7UEqHTJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tesarici.cz; spf=pass smtp.mailfrom=tesarici.cz; dkim=pass (2048-bit key) header.d=tesarici.cz header.i=@tesarici.cz header.b=w7telH3Y; arc=none smtp.client-ip=37.205.15.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tesarici.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tesarici.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tesarici.cz header.i=@tesarici.cz header.b="w7telH3Y"
Received: from meshulam.tesarici.cz (dynamic-2a00-1028-83b8-1e7a-4427-cc85-6706-c595.ipv6.o2.cz [IPv6:2a00:1028:83b8:1e7a:4427:cc85:6706:c595])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by bee.tesarici.cz (Postfix) with ESMTPSA id 8D62F1D0C85;
	Mon,  1 Jul 2024 07:47:38 +0200 (CEST)
Authentication-Results: mail.tesarici.cz; dmarc=fail (p=quarantine dis=none) header.from=tesarici.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tesarici.cz; s=mail;
	t=1719812858; bh=e8FYNZRZuI5kI/HMQrEY/5s1bjxIxOJVytBhx8+lpm8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=w7telH3Y2yZsreZaX7KSVk1w+95a7tKP427OnWftl4f6LLVJ9S2TqidF9RqdpPlbH
	 WVrhcczr8OMR+CX8QIJSYRgg8jTathu3ayX3TH6uigHYGfHOJLpMchcYYoPImGbfUC
	 Bi2pYXmhxJ5pQ1NyAAioYXA4/fA2DKMut3/ukI3VLX/pPIhN/2seJnL5mwrcy7HFa0
	 qa9xDy4Z3oEdz/Zl6tOtf16vZaLypjrBmxXNxr1b+rS20/NvHbvhqYKYHIO31Routj
	 xXg0ar05+IS+/5+xYd3DR1RCy9+1cxFDwBlXJ7Dc/3E+ypRkuKxSDpp+9TLnmx7V4e
	 9H6Una8P8iusg==
Date: Mon, 1 Jul 2024 07:47:37 +0200
From: Petr =?UTF-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
To: "hch@lst.de" <hch@lst.de>
Cc: Michael Kelley <mhklinux@outlook.com>, "robin.murphy@arm.com"
 <robin.murphy@arm.com>, "joro@8bytes.org" <joro@8bytes.org>,
 "will@kernel.org" <will@kernel.org>, "jgross@suse.com" <jgross@suse.com>,
 "sstabellini@kernel.org" <sstabellini@kernel.org>,
 "oleksandr_tyshchenko@epam.com" <oleksandr_tyshchenko@epam.com>,
 "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>
Subject: Re: [RFC 1/1] swiotlb: Reduce calls to swiotlb_find_pool()
Message-ID: <20240701072140.182aa267@meshulam.tesarici.cz>
In-Reply-To: <20240701043615.GB26372@lst.de>
References: <20240627060251.GA15590@lst.de>
	<20240627085216.556744c1@meshulam.tesarici.cz>
	<SN6PR02MB4157E61B49C8435E38AC968DD4D72@SN6PR02MB4157.namprd02.prod.outlook.com>
	<20240627152513.GA23497@lst.de>
	<SN6PR02MB4157D9B1A64FF78461D6A7EDD4D72@SN6PR02MB4157.namprd02.prod.outlook.com>
	<20240628060129.GA26206@lst.de>
	<20240628094708.3a454619@meshulam.tesarici.cz>
	<SN6PR02MB415781789CBD6597142BEC68D4D12@SN6PR02MB4157.namprd02.prod.outlook.com>
	<20240630055542.GA5379@lst.de>
	<SN6PR02MB415735CA2F5487AE3FD74FFED4D22@SN6PR02MB4157.namprd02.prod.outlook.com>
	<20240701043615.GB26372@lst.de>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 1 Jul 2024 06:36:15 +0200
"hch@lst.de" <hch@lst.de> wrote:

> On Sun, Jun 30, 2024 at 02:02:52PM +0000, Michael Kelley wrote:
> > 1) Rename is_swiotlb_buffer() to swiotlb_find_pool(), since it
> > now returns a pool.  A NULL return value indicates that the
> > paddr is not an swiotlb buffer.
> > 
> > 2) Similarly, rename is_xen_swiotlb_buffer() to
> > xen_swiotlb_find_pool()
> > 
> > 3) The existing swiotlb_find_pool() has the same function signature,
> > but it is used only where the paddr is known to be an swiotlb buffer
> > and hence always succeeds. Rename it to __swiotlb_find_pool() as
> > the "internal" version of swiotlb_find_pool().  
> 
> Sounds good.

Agreed. Most importantly, the "nice" name swiotlb_find_pool() is used
for external users. The difference between swiotlb_find_pool() and
__swiotlb_find_pool() is that the former can be used with any device,
and the latter (internal) only with devices that make some use of
swiotlb. The main reason to keep them separate is that the internal
function should not be inlined if CONFIG_SWIOTLB_DYNAMIC=y.

I hope somebody finds my explanation useful when they touch the code
again in a few years from now. ;-)

> > 4) Do you still want is_swiotlb_buffer() as a trivial wrapper around
> > the new swiotlb_find_pool(), for use solely in dma_direct_need_sync()
> > where only a Boolean is needed and not the pool?  
> 
> If there is really just a single caller left we can skip the wrapper,
> otherwise it might be handy.

AFAICS dma_direct_need_sync() is the only such place.

Petr T
