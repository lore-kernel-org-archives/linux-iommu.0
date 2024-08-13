Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7C98194A6B
	for <iommu@lists.linux.dev>; Tue, 13 Aug 2024 11:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723549816; cv=none; b=nXhRIsMn1xkFy0+NYf3CPAxLp4P3fGYypXT2n9IpagF8PG/2Lqzk/wJQx4fF7T384yhP10TWeApMQi1VoTj2P4TbnWtK1OILz8PiryoDVndyokHNL1Z6vOnLrRkYNnsyG2z8hlBD6e9gixbIvGxWlaFz1NTewgqjf+ppZ76+r6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723549816; c=relaxed/simple;
	bh=jqt54muLOVo9ftAomttUciUspyyZLMAhKp2YqEsQZKg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uKZNaBYwpKu1Du0o9cnMswpGOhyBpGc06Ne3KiOzRdZj02jH+9/tOH+qfOmNK/f6N1LMjbNgvA1wDKxlxKJzJH4lyVhTyakZ3gyzzODv68KeTOZiDqAjR9Hn4CtNmTm+AKqh1QdEK0qoSorrrInrEsL6N+G6hPjTSawtzi1BNNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id B1611227A87; Tue, 13 Aug 2024 13:50:02 +0200 (CEST)
Date: Tue, 13 Aug 2024 13:50:02 +0200
From: Christoph Hellwig <hch@lst.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Leon Romanovsky <leon@kernel.org>, Christoph Hellwig <hch@lst.de>,
	Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Easwar Hariharan <eahariha@linux.microsoft.com>,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	Jason Gunthorpe <jgg@nvidia.com>, leonro@nvidia.com
Subject: Re: [PATCH v4 0/2] DMA IOMMU static calls
Message-ID: <20240813115002.GA2825@lst.de>
References: <cover.1721818168.git.leon@kernel.org> <20240805122050.GA480973@unreal> <2024081330-dismiss-unsealed-0f21@gregkh>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024081330-dismiss-unsealed-0f21@gregkh>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Aug 13, 2024 at 11:58:51AM +0200, Greg Kroah-Hartman wrote:
> I thought we were trying to get away from adding iommu stuff to struct
> device, but oh well :(

Strictly speaking this is DMA-API stuff, despite being related to
dma-iommu.  And yes, I'd like to eventually move this out of
struct device into a separate dma_device, but that's pretty big
lift and for now this uses one of many spare bits without growing the
structure.

