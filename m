Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CE328121A
	for <iommu@lists.linux.dev>; Tue, 30 Jan 2024 14:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706625283; cv=none; b=c13O1thlJyCf6BzKNh0f60w3/sb/JcO3eXWBtiTyVAcxvjln9tulnAVmE9MXgjAJGV8S04AseRPyX5C+8CF9d5TjTC37LgKRHbaNLEGg1ToSPQXjZSVuh5UXTIYRc1oJOpv+qtj/XJjGvt8RnWPm6gm9vUqcldY6h8lsHtFD8SE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706625283; c=relaxed/simple;
	bh=qKasyX1rHGUCXJ32d52gf77E7ACV42WbmmJTZqKxtu4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vfl9CcHpuyr4KezvgkddTVUI4o1qT9iMoncUP3ymrKU0Bh7OYloF/8K2imu3ndx4YDhXmWrBxKPChU2Fqzt8E0UFhuIbQfrIMFkLOuoKorBcfxZkZ/QSh3LVGAJ6XuHLaFPNY2Gkvdn/XG9G1u6LKXQUivtmmId7lHCgLg37zIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 266AE68B05; Tue, 30 Jan 2024 15:34:38 +0100 (CET)
Date: Tue, 30 Jan 2024 15:34:37 +0100
From: Christoph Hellwig <hch@lst.de>
To: Will Deacon <will@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org,
	kernel-team@android.com, iommu@lists.linux.dev,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Petr Tesarik <petr.tesarik1@huawei-partners.com>,
	Dexuan Cui <decui@microsoft.com>
Subject: Re: [PATCH 2/2] swiotlb: Enforce page alignment in swiotlb_alloc()
Message-ID: <20240130143437.GA31991@lst.de>
References: <20240126151956.10014-1-will@kernel.org> <20240126151956.10014-3-will@kernel.org> <20240129060853.GB19258@lst.de> <20240129194939.GE12631@willie-the-truck>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240129194939.GE12631@willie-the-truck>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Jan 29, 2024 at 07:49:40PM +0000, Will Deacon wrote:
> > >  	return pfn_to_page(PFN_DOWN(tlb_addr));
> > 
> > So PFN_DOWN aligns the address and thus per se converting the unaligned
> > address isn't a problem.
> 
> Hmm, I'm not sure I follow why it isn't a problem. If the first 2KiB slot
> of the 4KiB page has already been allocated to somebody else, isn't it a
> big problem to align down like that? Maybe I should word the warning
> message a bit better -- how about:

But the problem is that it's used, not that we can't create a page
from a non-aligned address.

> 
>   "Cannot allocate pages from non page-aligned swiotlb addr 0x%pa.\n"

That sounds better.

