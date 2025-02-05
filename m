Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 004501494DF
	for <iommu@lists.linux.dev>; Wed,  5 Feb 2025 15:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738770207; cv=none; b=Kk0koWQtk/Vpks9w88MxHshx3e0dL5kexivIBaCfGObao3pPIxa9QXxQcDwEHn2hiE2P85xwR+z76AWswEHxAWhE0VTQoseWXq3nx5OLLCGj2lCUkoVwfFLDX6klYpjRd+rfO0NdiSYoJR6aRo8M3fqaSrWR/JknNXbP2Z6tNPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738770207; c=relaxed/simple;
	bh=0Qve9Fu9dMEQ9bG1ILIvvS9vURx5fQVE2V5aiYBTDKQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nFSk+IRMUvA8DMeXdOjwbNfVjmBZu8qVrdcBaG1SEZW59shiJdCArao5sfzrwe4vtGP8N0POSNoGhhcdpVVt18UTcXM+xuAOMlbwRdzZFl+phbaPXF/xsomi3KkOEI0LGnEYgNBDpuVB2P9JPtg+hL95wSUMyBno3F/NqD5vnqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 49C6E68BFE; Wed,  5 Feb 2025 16:43:21 +0100 (CET)
Date: Wed, 5 Feb 2025 16:43:21 +0100
From: Christoph Hellwig <hch@lst.de>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Jianxiong Gao <jxgao@google.com>, Keith Busch <kbusch@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Robin Murphy <robin.murphy@arm.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Erdem Aktas <erdemaktas@google.com>,
	Vishal Annapurve <vannapurve@google.com>,
	Ryan Afranji <afranji@google.com>, linux-nvme@lists.infradead.org,
	iommu@lists.linux.dev
Subject: Re: [RFC PATCH 0/3] Add an option for devices to skip SWIOTLB
 pre-copy on read.
Message-ID: <20250205154321.GB13814@lst.de>
References: <20250204233630.3407878-1-jxgao@google.com> <Z6MZLWRv1hC8uLo1@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z6MZLWRv1hC8uLo1@smile.fi.intel.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Feb 05, 2025 at 09:54:21AM +0200, Andy Shevchenko wrote:
> On Tue, Feb 04, 2025 at 11:36:27PM +0000, Jianxiong Gao wrote:
> > Removes an extra memory copy that occurs during IO read
> > operations through the SWIOTLB. During high throughput
> > read workloads, this extra copy is causing a lot of stress
> > on the SWIOTLB.
> > 
> > With high performance devices, for example NVMe devices,
> > the device will be overwriting the entire buffer.
> 
> Is this really guaranteed? I can imagine surprise power cut or
> hotplug event, for example, just in the middle of the transfer.

Many command can return less data than originally mapped.  Get Log Page
is an example that comes to mind that is heavily used that way.

