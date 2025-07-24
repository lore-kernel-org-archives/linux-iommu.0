Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68A96238C0A
	for <iommu@lists.linux.dev>; Thu, 24 Jul 2025 07:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753343970; cv=none; b=OiJ9cz5V/g+8FfYmZ8nXf7skUCOlfw5WRi8qpWbzRYJKNYN5hpBXsqxDMYWFRodOdKFBx4kU5XmqG3bNcgzWAdj8KfuKdMlx5gE+sSYaclF08V1QINSZ01lgG1acJsIWSVwMz2V+gFc8fwfWFNm7llhIXqCPOevChYPYiXKTaco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753343970; c=relaxed/simple;
	bh=ljWAxX5kJwfu5zdNW//mA3LUzMWTGA4ERqpR/Py2W5Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qT822QJcWM56Ms5mTcoms6h87KBs105WcptifBufMQDR9YQfUK4/123BNRcC/iJcacLK3G65/3HPLZib2N9iqLm8J+iWLTN897vT6FVFI7htpX34WJ7Kq29e5EjdpEw0eksa4IyuRJ/yEwXX4RFsKuHFMmwpw69g8F1LGxUzf8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id B200368AFE; Thu, 24 Jul 2025 09:59:22 +0200 (CEST)
Date: Thu, 24 Jul 2025 09:59:22 +0200
From: Christoph Hellwig <hch@lst.de>
To: Leon Romanovsky <leon@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>,
	Alex Williamson <alex.williamson@redhat.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	dri-devel@lists.freedesktop.org, iommu@lists.linux.dev,
	Jens Axboe <axboe@kernel.dk>,
	=?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
	Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
	linaro-mm-sig@lists.linaro.org, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
	linux-mm@kvack.org, linux-pci@vger.kernel.org,
	Logan Gunthorpe <logang@deltatee.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Vivek Kasireddy <vivek.kasireddy@intel.com>,
	Will Deacon <will@kernel.org>
Subject: Re: [PATCH 02/10] PCI/P2PDMA: Introduce p2pdma_provider structure
 for cleaner abstraction
Message-ID: <20250724075922.GD30590@lst.de>
References: <cover.1753274085.git.leonro@nvidia.com> <c2307cb4c3f1af46da138f3410738754691fbb3d.1753274085.git.leonro@nvidia.com> <20250724075145.GB30590@lst.de> <20250724075533.GR402218@unreal>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250724075533.GR402218@unreal>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Jul 24, 2025 at 10:55:33AM +0300, Leon Romanovsky wrote:
> Please, see last patch in the series https://lore.kernel.org/all/aea452cc27ca9e5169f7279d7b524190c39e7260.1753274085.git.leonro@nvidia.com
> It gives me a way to call p2p code with stable pointer for whole BAR.
> 

That simply can't work.  So I guess you're trying to do the same stupid
things shut down before again?  I might as well not waste my time
reviewing this.

