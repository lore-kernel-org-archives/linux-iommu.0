Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB8731519BA
	for <iommu@lists.linux.dev>; Wed,  5 Feb 2025 16:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738772300; cv=none; b=XHp0V/0lN32x9JVPnzIzzzULxZFwYGVhG9YtZuCFKmoIRbO2lM37oLXz5Zyysh8F/J89TYRRH1mW6+myTNMslskefab7i4Iz7ARQfs2M3TH8Km/+wES/qhtbCztruR4QqTF2SIP6qChDttVO7u6reE4rxNqQGk7EYYICLwKxkVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738772300; c=relaxed/simple;
	bh=RvpzDGf5Iwop1VDAqYYlfM34uq83/esOXK9tr/k0MiQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XlMW8q54s/cddo1OWjqrwOmPvTy/jyqbJ5jZa7yeZ+kSqILnU80eqPIIwgwu3s3kqf13UzIvsy/6UkkP0RLl0d9NN5scv4IqsQ5yIfdSaN/ChkyMWshRCUlVNs2YgRmlWuAM1w6FNYrFZcbl5PTPjewZRpKkvuNu7EHiH00amnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nu5E7bEw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nu5E7bEw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E00BC4CED1;
	Wed,  5 Feb 2025 16:18:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738772300;
	bh=RvpzDGf5Iwop1VDAqYYlfM34uq83/esOXK9tr/k0MiQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nu5E7bEw+j30/3syrjFPv3u7g4Z3H9YUJM33CyaFwUwO3pfydwQVseUJ7jBAA0he8
	 WwdcvFtS4OEpA6cZLAQWPLdzlWmi0sMlyIBODmG+G17/JncqrBQv5Q5mfPOeGcugAh
	 5TE812f/AzwGM7nxuoJslC9ZgiieWvDBb4GmjpTRMB0+bFTBgkIcd3B1SZhthO89iM
	 yZudHcABciAIoBC+o4GPUGtL9phAJJ54tvCzSiIjLO3kFhZLqWdePOtweTzyXN5abw
	 SvNTEOp9yEjyANQbkyakKEdIwfXCq6Pc8R6yJxte1qRMl/+QQEqwZG/H4FqwQSEEIq
	 I2dP0ampwpSMQ==
Date: Wed, 5 Feb 2025 09:18:16 -0700
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Jianxiong Gao <jxgao@google.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>,
	Robin Murphy <robin.murphy@arm.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Erdem Aktas <erdemaktas@google.com>,
	Vishal Annapurve <vannapurve@google.com>,
	Ryan Afranji <afranji@google.com>, linux-nvme@lists.infradead.org,
	iommu@lists.linux.dev
Subject: Re: [RFC PATCH 0/3] Add an option for devices to skip SWIOTLB
 pre-copy on read.
Message-ID: <Z6OPSFuxtEluOb8o@kbusch-mbp>
References: <20250204233630.3407878-1-jxgao@google.com>
 <Z6MZLWRv1hC8uLo1@smile.fi.intel.com>
 <20250205154321.GB13814@lst.de>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250205154321.GB13814@lst.de>

On Wed, Feb 05, 2025 at 04:43:21PM +0100, Christoph Hellwig wrote:
> On Wed, Feb 05, 2025 at 09:54:21AM +0200, Andy Shevchenko wrote:
> > On Tue, Feb 04, 2025 at 11:36:27PM +0000, Jianxiong Gao wrote:
> > > Removes an extra memory copy that occurs during IO read
> > > operations through the SWIOTLB. During high throughput
> > > read workloads, this extra copy is causing a lot of stress
> > > on the SWIOTLB.
> > > 
> > > With high performance devices, for example NVMe devices,
> > > the device will be overwriting the entire buffer.
> > 
> > Is this really guaranteed? I can imagine surprise power cut or
> > hotplug event, for example, just in the middle of the transfer.
> 
> Many command can return less data than originally mapped.  Get Log Page
> is an example that comes to mind that is heavily used that way.

It's also easy enough for a user to "mistakenly" request more memory
than the device will transfer. The safest thing is to clear any contents
that may get copied back to the user.
