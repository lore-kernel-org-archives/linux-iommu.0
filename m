Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3B58148FED
	for <iommu@lists.linux.dev>; Thu, 12 Dec 2024 08:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733993344; cv=none; b=XhTOVlluI6I+LgihURV3vFv3VBMav6a7P/A56EbxtiLvNRhfjUFUFbCljmMMnNCh647U1noZ06Hu3/zE7goJD18ykvp+ySSa5dW9NIYhPMfy1Dft6wWslhzVBNO4rVZ+BAOnP20tMZz42YGwU4qnhu6654Oq4fcfsoDx366esg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733993344; c=relaxed/simple;
	bh=wNfdSZmyat0UwD7526wx2IW+8Fb/6Fxc7sKATjUY7Pc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WCgHGZzLfn9kQ5FjRaNcme12tXxQmjNyNQYKt9arCwsatxQ0TCCt3LizuhO0PSPoYgx+X4aKAe+aYKx6LBWey0H0ALf7v55nlVfFXFpaIqxMWK5CHiMmdM+nP5VF1Y30ufkvAFUNx/9K6Kr7lKZLvJGnSjX9SvnfAoMumF0oppg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 594C268D1E; Thu, 12 Dec 2024 09:48:57 +0100 (CET)
Date: Thu, 12 Dec 2024 09:48:56 +0100
From: Christoph Hellwig <hch@lst.de>
To: Leon Romanovsky <leon@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, Jason Gunthorpe <jgg@ziepe.ca>,
	Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Leon Romanovsky <leonro@nvidia.com>,
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
	kvm@vger.kernel.org, linux-mm@kvack.org,
	Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH v4 11/18] mm/hmm: let users to tag specific PFN with
 DMA mapped bit
Message-ID: <20241212084856.GE9376@lst.de>
References: <cover.1733398913.git.leon@kernel.org> <e4551571fc10d9c73ab9e38a75ea701c1b492686.1733398913.git.leon@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e4551571fc10d9c73ab9e38a75ea701c1b492686.1733398913.git.leon@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Dec 05, 2024 at 03:21:10PM +0200, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> Introduce new sticky flag (HMM_PFN_DMA_MAPPED), which isn't overwritten
> by HMM range fault. Such flag allows users to tag specific PFNs with information
> if this specific PFN was already DMA mapped.

Missing line wrap at 73 characters here.

>  
> @@ -253,14 +262,14 @@ static int hmm_vma_handle_pte(struct mm_walk *walk, unsigned long addr,
>  			cpu_flags = HMM_PFN_VALID;
>  			if (is_writable_device_private_entry(entry))
>  				cpu_flags |= HMM_PFN_WRITE;
> -			*hmm_pfn = swp_offset_pfn(entry) | cpu_flags;
> +			*hmm_pfn = (*hmm_pfn & HMM_PFN_INOUT_FLAGS) | swp_offset_pfn(entry) | cpu_flags;

Please avoid the overly long line here.

That being said I hate the structure here.  Can't we just have a local
variable for the actual new pfn value, and then a single goto label
at the end that takes the keeper flags from the argument and assigning
the new out value to *hmm_pfn instead of duplicating this in half a
dozen places?

