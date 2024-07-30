Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 948CC29A2
	for <iommu@lists.linux.dev>; Tue, 30 Jul 2024 15:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722353204; cv=none; b=AU8Tqof13L2IA+t1k+t/4iwaXH7fYPiF6PE/gls/i8GJ47edpY8EgFKw4BF1qZDVFoSt1wWIzFaz6FvaqudfzupEqG3szDNUoqR6t3qg5xWmL05gE7hzgzNvWA3PoyYu47HHHOa3BwBO+BEymbJqQbcVwabOsPQJVM813G9y40A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722353204; c=relaxed/simple;
	bh=njn0HB7ukJMtCr5Qf+JldoMEZ7R4rnMRzDsm+BdPcXI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=doblIO07OLfRQ88n6p8l7z7Lk7AXxMDnFicDpEGtgQkEz11U2sqfd5AmNBam5orUVr2ceEuEr6mgFxSFdAigvoU4NOWxcrGHsbgN/iT1D+CF7uLif1v21QXefW9ixGP9Vi2qz4+SKzd4Rq3Tsr40ySKZt9SgcfN6XAisxXCmNkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 63C2868AA6; Tue, 30 Jul 2024 17:26:39 +0200 (CEST)
Date: Tue, 30 Jul 2024 17:26:39 +0200
From: Christoph Hellwig <hch@lst.de>
To: Leon Romanovsky <leon@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Mostafa Saleh <smostafa@google.com>,
	Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Easwar Hariharan <eahariha@linux.microsoft.com>,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH v2 2/2] dma: add IOMMU static calls with clear default
 ops
Message-ID: <20240730152639.GA29914@lst.de>
References: <cover.1721219730.git.leon@kernel.org> <dd34bf3ecef252b4910d70aa21ff5273b5e8b19b.1721219730.git.leon@kernel.org> <ZqeN6MP4o2JNLcUz@google.com> <20240729171518.GB31388@lst.de> <20240730081637.GB4209@unreal>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240730081637.GB4209@unreal>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Jul 30, 2024 at 11:16:37AM +0300, Leon Romanovsky wrote:
> This is good remark, should I add this to the commit message and send v5?

I can just add it.  I'm fine with the current series except for a little
cosmetic coding style fixup I can take care of, but I'd really like to
see an Ack from Greg for the new bit in struct device, and a review
from Robin.

