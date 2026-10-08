Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 087B449B451
	for <iommu@lists.linux.dev>; Thu,  8 Oct 2026 12:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791463053; cv=none; b=FWsW6tl2Mi6MB1AS2Qzcsj1X5J1KiRBIhrS1JSxmZZSeLvCt5oDugDoGFmx4rR8wDGRDg9lSsJ2cQ73JJsyMCeW7hdUmIuYpwixr7V0cYaCv9QtEKWaWqeT3fbUpjxp1bJNA37duwl1ORML2TO0RTQbx8g0pt/Xd0R1DARHbljs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791463053; c=relaxed/simple;
	bh=3YGRH66MEocHE8PHY3+X1AvHhNaJZ3N0ayOOhgWPQec=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sp24l18m4nWOQadHwRh2M3nTAQ8dpq24rsDD1M/6zm5mKmo/0+LP+nPX+EZVGQscOVSuGfLoS3visB+GvaECOzh+/NeguBiBO4fJExYYDG5isj7hZ+srRiQcEuXt1tSpWgTG8KjJC3chDqBFGJwek1zLPfK4a8x3+LdT6FebHJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 0909668BEB; Thu,  8 Oct 2026 14:37:25 +0200 (CEST)
Date: Thu, 8 Oct 2026 14:37:24 +0200
From: Christoph Hellwig <hch@lst.de>
To: John Garry <john.garry@linux.dev>
Cc: Christoph Hellwig <hch@lst.de>, kbusch@kernel.org, ahuang12@lenovo.com,
	sagi@grimberg.me, linux-nvme@lists.infradead.org,
	sunjw10@lenovo.com, iommu@lists.linux.dev
Subject: Re: [PATCH] Revert "nvme-pci: clamp max_hw_sectors based on DMA
 optimized limitation"
Message-ID: <20261008123724.GA22096@lst.de>
References: <20261006120248.147654-1-hch@lst.de> <8cf8a8ea-c9c9-434b-aec6-e361280a88a4@linux.dev>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8cf8a8ea-c9c9-434b-aec6-e361280a88a4@linux.dev>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Oct 08, 2026 at 08:36:54AM +0100, John Garry wrote:
> On 10/6/26 13:02, Christoph Hellwig wrote:
>> This turns down to cause up to 15% performance regressions on standard
>> large transfer workloads.  Revert it and hope the IOVA allocator can
>> eventually be fixed to remove the need for the original workaround.
>>
>> This reverts commit 3710e2b056cb92ad816e4d79fa54a6a5b6ad8cbd.
>>
>
> What was the block size and conditions for the original issue? The commit 
> just mentions that mdts=10 and we get a 4096KB max HW sectors.

Good question.  The original submitter and reporter are on Cc.

