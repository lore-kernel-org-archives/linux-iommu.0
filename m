Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39C911A4E9D
	for <iommu@lists.linux.dev>; Tue, 15 Oct 2024 07:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728978863; cv=none; b=c9y/PO9ICh3wkYZtjjQr1S06E3sMg4qQEGriXl2Otve7gwt6Z6Wp7tJK79QBqdzQNYFA4D1asSQenfc6pohQl1E7LYCwluU841fqLjZs2I1MMERoUEpRpNj/8UQxFWMzrvP59obFQhV7HmKgrSXTKCPqOt/xudWEcCdcGC6sMGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728978863; c=relaxed/simple;
	bh=81PWpKBiCuQR9qayZ+gc7K8ZHTHGC6P8ZEbv2PsYCz0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AULjFVLZJ0/Y7VVcpGOS9AMW3ei2+OGB9j1tHPKRoYVI1ce2XxykXOqQX0CrlAy8eRsu+mWUJsdtJImadLUsDwOw2qh6FOXNNJCjUtBbwUV6gTCnkFvYYPsXhA3PPMxTDI15pJBDJXKcjio/1fsm2UxFpEwYMwQk5luRd9bh5uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id D4B5E227AA8; Tue, 15 Oct 2024 09:54:18 +0200 (CEST)
Date: Tue, 15 Oct 2024 09:54:18 +0200
From: Christoph Hellwig <hch@lst.de>
To: Ming Lei <ming.lei@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, Robin Murphy <robin.murphy@arm.com>,
	Hannes Reinecke <hare@suse.de>,
	Hamza Mahfooz <someguy@effective-light.com>,
	Dan Williams <dan.j.williams@intel.com>,
	linux-block@vger.kernel.org, io-uring@vger.kernel.org,
	linux-raid@vger.kernel.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [Report] annoyed dma debug warning "cacheline tracking EEXIST,
 overlapping mappings aren't supported"
Message-ID: <20241015075418.GA25487@lst.de>
References: <ZwxzdWmYcBK27mUs@fedora> <426b5600-7489-43a7-8007-ac4d9dbc9aca@suse.de> <20241014074151.GA22419@lst.de> <ZwzPDU5Lgt6MbpYt@fedora> <7411ae1d-5e36-46da-99cf-c485ebdb31bc@arm.com> <20241015045413.GA18058@lst.de> <Zw4camcCvclL4Q_6@fedora>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zw4camcCvclL4Q_6@fedora>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Oct 15, 2024 at 03:40:26PM +0800, Ming Lei wrote:
> > Yes, active_cacheline_insert only complains for FROM_DEVICE or
> > BIDIRECTIONAL mappings.  I can't see how raid 1 would trigger that
> > given that it only reads from one leg at a time.
> > 
> > Ming, can you look a bit more into what is happening here?
> 
> All should be READ IO which is FROM_DEVICE, please see my reply:

Yes, reads translate to DMA_FROM_DEVICE.

> https://lore.kernel.org/linux-block/Zw3MZrK_l7DuFfFd@fedora/
> 
> And the raid1 warning is actually from raid1_sync_request().

In that case the warnings are perfectly valid because the I/O patterns
will create data corruption on non-coherent architectures.  For direct
I/O from userspace the kernel can't prevent it, but for raid1 we should
be able to do something better.  As raid1_sync_request is a convoluted
and undocumented mess I don't have a straigh shot answer to what it is
doing (wrong) and how to fix it unfortunately.

> 
> 
> Thanks,
> Ming
---end quoted text---
