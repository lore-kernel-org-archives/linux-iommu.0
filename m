Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 326553D1712
	for <iommu@lists.linux.dev>; Tue, 19 May 2026 07:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779175086; cv=none; b=YOnKQVjUsP8/WK5G2L6Nv8Ra9D+t7qLmjGj3qDRkkI7DOCmfkBqqsyjxB7ls637VpRVkf68FW5/4fNEo7ssZv+dHJXWxnPPGq/XhH+AblWFVp8XTATq/vOLyacVkPYdKJ7q5GhICW1b+VCfj0qeB5RWiXLent4kA84SfmfXUKXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779175086; c=relaxed/simple;
	bh=0TI6SgOh6KRaYKaxl12x2+sBlNzKAWnVwxARy6keBAA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gbCdUa6Q2zmR84P8WB1ox7SyyWyz72bag9hGbKYrR7D7tt8cG+h6eyzFxA1Wq4rSslBf3pc0EVrl3Hj5YqbjpFTrpauzWG7bBI/KmGbRpv2UESOPyMiigiCkUM/n2ggEAwQOP7TA9XfKTqulT3taqN15rJjzEY0N1YClBe7jNsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id BCFD468D09; Tue, 19 May 2026 09:17:59 +0200 (CEST)
Date: Tue, 19 May 2026 09:17:58 +0200
From: Christoph Hellwig <hch@lst.de>
To: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Cc: Leon Romanovsky <leon@kernel.org>, m.szyprowski@samsung.com, hch@lst.de,
	robin.murphy@arm.com, djbw@kernel.org, akpm@linux-foundation.org,
	catalin.marinas@arm.com, harry@kernel.org, ming.lei@redhat.com,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH] dma-debug: skip cacheline overlap tracking on
 cache-coherent architectures
Message-ID: <20260519071758.GB10037@lst.de>
References: <20260518113251.64844-1-mikhail.v.gavrilov@gmail.com> <20260518121047.GR33515@unreal> <CABXGCsMxZ7VieyzWEmpGdxohdbTJ_qf_1ZOw0eF5g9i0YeOc3w@mail.gmail.com> <20260518125330.GT33515@unreal> <CABXGCsMA+uZtoup+QtGsPQcyF6TZimxYFOR2sDQksNkLpJq+2g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABXGCsMA+uZtoup+QtGsPQcyF6TZimxYFOR2sDQksNkLpJq+2g@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, May 18, 2026 at 06:29:11PM +0500, Mikhail Gavrilov wrote:
> DIO from userspace is unfixable from the kernel side per that
> message; raid1 acknowledged as needing a fix Christoph didn't have.
> Two years on, those cases (plus dm-thin and io_uring polled tests
> from Ming Lei's report) still don't have an annotation path. This
> patch covers what annotation can't reach without preventing future
> annotation work.

It is not.  We could require direct I/O to/from devices that are
attached without DMA coherence to require cache line alignment.

Now that Keith pushed down the checking into the driver that's even
fairly easily doable.

