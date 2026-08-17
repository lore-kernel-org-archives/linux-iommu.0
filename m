Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B50415477E
	for <iommu@lists.linux.dev>; Mon, 17 Aug 2026 08:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786955820; cv=none; b=g1SZtT9hu03w6dJF1XW0pAGaFEndMISHlWgi1E4W9UM7n3wi8Q3InWWsb2Zn9LZQVPM5qGbMVVVpbOKesc7rUmQwO/5BwbmfdzGfPdYGC1JT2MU5OJTE/TdVXwFKYNE21kOzY+cFuU+dOwCfuuk3wnsihpYVl8p0ke/5xeapGGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786955820; c=relaxed/simple;
	bh=oMwtd7pSLevkyP0Mk3qjXnOwoSgMx8FsyofrpyUaX08=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=X/T3JCdXd83UI1NzH7Z3HeXPbRbJw3dQlpldJSjg+4jfQlU/q/uhdlGQLb/R5V9SPj+FH+o0pexzCBTMpuLmqfZXUk8J2ljU2fEe68P5lDzXM5D0efll9Zdw7TgGWWKEkKdEc0XIIosaYbbbWE4gkMCde3Fhdfm336Fgexq9wE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 5F27868CFE; Mon, 17 Aug 2026 10:36:54 +0200 (CEST)
Date: Mon, 17 Aug 2026 10:36:54 +0200
From: Christoph Hellwig <hch@lst.de>
To: Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, John Garry <john.g.garry@oracle.com>,
	iommu@lists.linux.dev, linux-nvme@lists.infradead.org
Subject: dma_opt_mapping_size returns way too low sizes when using IOMMU
Message-ID: <20260817083654.GA23414@lst.de>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.17 (2007-11-01)

Hi all,

I got reports that NVMe devices were arbitrarily limited to 128kiB
transfers in recent kernel.  It turns out that this only happens when
using an IOMMU and is caused by iommu_dma_opt_mapping_size returning
iova_rcache_range(), which is defined as follows:

unsigned long iova_rcache_range(void)
{
	return PAGE_SIZE << (IOVA_RANGE_CACHE_MAX_SIZE - 1);
}

and thus indeed hardcodes a 128kiB return on 4k page size architectures.

Both the NVMe performance numbers and common sense suggest that this
is NOT the optimal DMA mapping granularity.  Can we pick a saner value
for iommu_dma_opt_mapping_size that does not restrict common I/O sizes?
