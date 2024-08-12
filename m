Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9636C14F9F4
	for <iommu@lists.linux.dev>; Mon, 12 Aug 2024 08:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723451550; cv=none; b=q8dwosszGHzBxnQ1Vel3QhcAGagA7dbLwnMkBCsELGze3fMgpwj4W8BCsVlGoeMDl2zuXEzzvDWJHrkj6hxz2v5lgNrsXM1NmXoVdOKCkj/+qfHGbmyMvWHI4Afavnbxf+ciYLD10qmWdYHw1R6yZ/WkuYDfp5cJB0uwSy6BKFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723451550; c=relaxed/simple;
	bh=csoUntmjyLn+Ay/nbm8OFYK8V+dAVxhYyVn0sr4uOGE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X/3hvazI58yaMmEWnSJTy+PlpsPQadXNzo6u2+U+atSI7NVeOAsl5TrHwwMbTUdmVqv4pkSSD7dINh1DWnRYgqm+3SMNp+IyIqlJHNtg7nWFu1uxG2gpnlwmsiiZDXRYTJmxEc1+i7koSwaVrEO4J3v9p/jOM0HzUmY9LcXqQG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id F2CF868BEB; Mon, 12 Aug 2024 10:32:18 +0200 (CEST)
Date: Mon, 12 Aug 2024 10:32:18 +0200
From: Christoph Hellwig <hch@lst.de>
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev,
	Reiji Watanabe <reijiw@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dma-mapping: use bit masking to check VM_DMA_COHERENT
Message-ID: <20240812083218.GA3493@lst.de>
References: <20240810005911.684644-1-yosryahmed@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240810005911.684644-1-yosryahmed@google.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

Thanks Yosry, this looks good to me.  I don't see a real urgency here,
so I plan to add it to the dma-mapping tree for 6.12.

