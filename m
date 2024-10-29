Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDF7F202638
	for <iommu@lists.linux.dev>; Tue, 29 Oct 2024 07:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730187998; cv=none; b=iWVJNk5Z0nEAPYkz83bLnVDpFO01BlbglhCLiqxLavGixjNrHh8xrN0d0vQsjIf0vjrfc33HQvOyUuiUopmqbAbq0Z1rgdgfUKGQyHih4ZJvdOQgZ7LbirTvAICmK8Wv70dJdiuaXtZJwAoJcng6W5PYDQ3Qy2Ao7ItuCcefLhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730187998; c=relaxed/simple;
	bh=ey/h1UWH4PsNFprB/VIDBkwWQ4/GYp79V4On9mrOAm4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ViDFYhoB+h70pfLyYUQXuhsVBaZ02/gyF5TDQkmM4QiZY0DVIfnTF7AohLE76IVRr2QqWWClMLQNdRySc0k2WgucSjBu5bBIGxjA/TFNl6epNFP7sSJikPYvxakt/J8UkraL5OUHVkVt6uV43kh8vR4RlMSE+948O6HiTNFaRoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id E1051227A88; Tue, 29 Oct 2024 08:46:31 +0100 (CET)
Date: Tue, 29 Oct 2024 08:46:31 +0100
From: Christoph Hellwig <hch@lst.de>
To: Leon Romanovsky <leon@kernel.org>
Cc: Baolu Lu <baolu.lu@linux.intel.com>, Jens Axboe <axboe@kernel.dk>,
	Jason Gunthorpe <jgg@ziepe.ca>, Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Yishai Hadas <yishaih@nvidia.com>,
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	=?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
	linux-rdma@vger.kernel.org, iommu@lists.linux.dev,
	linux-nvme@lists.infradead.org, linux-pci@vger.kernel.org,
	kvm@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 05/18] dma: Provide an interface to allow allocate IOVA
Message-ID: <20241029074631.GD22316@lst.de>
References: <cover.1730037276.git.leon@kernel.org> <844f3dcf9c341b8178bfbc90909ef13d11dd2193.1730037276.git.leon@kernel.org> <25c32551-32e2-4a44-b0ae-30ad08e06799@linux.intel.com> <20241028063740.GD1615717@unreal>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241028063740.GD1615717@unreal>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Oct 28, 2024 at 08:37:40AM +0200, Leon Romanovsky wrote:
> In this specific case, the physical address is used to calculate
> IOVA offset, see "size_t iova_off = iova_offset(iovad, phys);" line,
> which is needed for NVMe PCI/block layer, as they can have first
> address to be unaligned and IOVA allocation will need an offset to
> properly calculate size.

And that is also very explicitly spelled out in the kerneldoc comments,
including the note that the physical address is optional if the
transfer is granule aligned (actually it says PAGE_SIZE which should
be fixed).

Any suggestions to further improve it are welcome of course.

