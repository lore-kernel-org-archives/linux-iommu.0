Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EEF32AE7F
	for <iommu@lists.linux.dev>; Tue, 26 Aug 2025 13:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756216663; cv=none; b=KAbeZRX+ZJMi8NCbAjIsjP81VA60qCzdWB0bpqzl6NfxFBCEWRET1LGnhwaJYGWc8g5LIrWRtvMV3AKObN8//x1ZWWylwqUPulPpX0efaXW5WjQDC9jEsKuuFCZGp1hZ3PcSVnztzl9Qvqvogn/WTJmN6qJDB7xkPkSOJANhD9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756216663; c=relaxed/simple;
	bh=1gAKaymMdJw9QRaQZwEz+4g6I7V87MF2spGYgqYSDNs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NHLiWpO6tMNvXUvY13zGnH/B42Gjp9lauYS7yo++R+D690gX/Xr0dKtFcd5Y/YmY0zequwpinLBptP6+Odvo184iAvBQXFFY5RNTe9d+UkvbQ11+CkLuFvk5gthNqMLH7FW3fvd3vDuAE7wAVVOf/5yCPk7F82AZyTKpOxXGxb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 4305667373; Tue, 26 Aug 2025 15:57:35 +0200 (CEST)
Date: Tue, 26 Aug 2025 15:57:34 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Christoph Hellwig <hch@infradead.org>,
	Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, axboe@kernel.dk,
	iommu@lists.linux.dev
Subject: Re: [PATCHv3 1/2] block: accumulate segment page gaps per bio
Message-ID: <20250826135734.GA4532@lst.de>
References: <20250821204420.2267923-1-kbusch@meta.com> <20250821204420.2267923-2-kbusch@meta.com> <aKxpSorluMXgOFEI@infradead.org> <aKxu83upEBhf5gT7@kbusch-mbp> <20250826130344.GA32739@lst.de> <aK27AhpcQOWADLO8@kbusch-mbp>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aK27AhpcQOWADLO8@kbusch-mbp>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Aug 26, 2025 at 07:47:46AM -0600, Keith Busch wrote:
> Currently, the virtual boundary is always compared to bv_offset, which
> is a page offset. If the virtual boundary is larger than a page, then we
> need something like "page_to_phys(bv.bv_page) + bv.bv_offset" every
> place we need to check against the virt boundary.

bv_offset is only guaranteed to be a page offset if your use
bio_for_each_segment(_all) or the low-level helpers implementing
it and not bio_for_each_bvec(_all) where it can be much larger
than PAGE_SIZE.
