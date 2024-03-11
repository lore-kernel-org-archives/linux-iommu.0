Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E6E83D541
	for <iommu@lists.linux.dev>; Mon, 11 Mar 2024 13:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710164183; cv=none; b=Qmg7jpMKBdueqYyrXl79o5ObkynGyl/ncssJEMYFWriWICV7acro6l/AR24iq9S6rDY6ZK/JUCYJoYfsdCqZR9hHyktfEBoR1f/fpwgFrfhf47BFgTT4hMTB54AQMAZG0hYUq0s97zkSWGsaj3/FdG/lrrAJIjhopT14ZVvFonw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710164183; c=relaxed/simple;
	bh=wQ5Yp4pXWaoBbmBNYOPfp7lvuKVchthqXLs7iIX5CUw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PRvtfiS92RgB1LyIeAwFSjW9ZbYDhy1xpr0w9KHlSWAIPb8xQhGKAbPaynwAZWbsR9tF45J6xMLIlwUcRe9OFjrO3GYdYRdZDuw6lZEAGDCdHfyd15MYcmauZeYyAjHY6iNWt4Jar8pwgnbioFqZvzLHV6G3E+dPN5mQhf8ON6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 48E0A68B05; Mon, 11 Mar 2024 14:36:17 +0100 (CET)
Date: Mon, 11 Mar 2024 14:36:17 +0100
From: Christoph Hellwig <hch@lst.de>
To: Will Deacon <will@kernel.org>
Cc: linux-kernel@vger.kernel.org, kernel-team@android.com,
	iommu@lists.linux.dev, Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Petr Tesarik <petr.tesarik1@huawei-partners.com>,
	Dexuan Cui <decui@microsoft.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Michael Kelley <mhklinux@outlook.com>
Subject: Re: [PATCH v6 0/6] Fix double allocation in swiotlb_alloc()
Message-ID: <20240311133617.GA1349@lst.de>
References: <20240308152829.25754-1-will@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240308152829.25754-1-will@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)


Thanks, I've applied this to the dma-mapping tree and plan to send it
onto Linus after a bit of soaking time.
